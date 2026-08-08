Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C34D411A0E
	for <bpf@vger.kernel.org>; Sat,  8 Aug 2026 14:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786198096; cv=none; b=W8fEoiTAeuNVWe9nHL6ekZ1R9+P4SD+pjcuPlacN5UnjIEQlpGHwm9mTrWDHH6/TiOvmJ+dsB63HCr7eZ36LpxkahXKU/ERaNSXucNmmXVZmLJyI4vWp05auXIzisfbFulAYAgE+jiVluznVMurTJ/jh3Ym1+KC7hihDsBTF9eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786198096; c=relaxed/simple;
	bh=UC2LJYe3PFIkZRH5Apil5ybbPebbqcoMfD4/wm2NiVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U4ZbblRo8OdwGN5Pjrt79WY/1QZmAOZcMjuq5PdZc8PviwJC8YfrhelQI4Gzyf58lMyE0AfKe4WBvsCe+odjEbjIdYANhSlc/wmqq9Z6NAXDlhzSOj0LcrrGCMdu0D9OZ5NTevC4zmoTWi/sduPL2xmFCN43wWeZGh2fZDmquq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SAaN0B4u; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SAaN0B4u"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786198092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1HXRAMSD0Fh+bzPqoIZc5+ftVcShNG2fimblgMCFSGU=;
	b=SAaN0B4usUVuB/keS0gXhalrvdCBrmkqnNN4+IjIARL6aCFWdLo/UnTRPrJF4SzKBz89t/
	NkM1MBU1eOiB2mjzCxSCoTUkeMJVMX9zhBGzNQralcJb0gpW6AOS+LKbcA4Rp6CcKGzCcz
	rLDNEqrtw+P/Vdlykz5Xffi6fbRLcdk=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH bpf-next v3 1/4] bpf: Add a sleepable page allocator for map memory
Date: Sat,  8 Aug 2026 22:05:53 +0800
Message-ID: <20260808140720.293604-2-jiayuan.chen@linux.dev>
In-Reply-To: <20260808140720.293604-1-jiayuan.chen@linux.dev>
References: <20260808140720.293604-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

bpf_map_alloc_pages() picks the allocator via can_alloc_pages(), a
conservative guess for BPF program context that is always false under
PREEMPT_RT. So even a caller that really is sleepable gets the
non-blocking allocator, which never reclaims and never engages the OOM
machinery.

Add bpf_map_alloc_page_sleepable() for callers that know they are
sleepable. Like the other bpf map allocators it places the page on the
map's numa_node and does not follow the faulting task's NUMA mempolicy;
arena memory is shared, so the map's node is the right placement policy.
The next patch uses it from the arena page fault handler.

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
---
To sashiko:
- The alloc_pages_nolock() fallback still zeroes: it forces __GFP_ZERO
  internally and only accepts __GFP_ACCOUNT.
- __GFP_ZERO is unchanged from the existing __bpf_alloc_page(), and no
  arena-capable arch has D-cache aliasing, so there is no dcache concern.
---
 include/linux/bpf.h  |  1 +
 kernel/bpf/syscall.c | 21 +++++++++++++++++----
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 73bacfc6444d..0dc51c37c25c 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2784,6 +2784,7 @@ struct bpf_prog *bpf_prog_get_curr_or_next(u32 *id);
 
 int bpf_map_alloc_pages(const struct bpf_map *map, int nid,
 			unsigned long nr_pages, struct page **page_array);
+struct page *bpf_map_alloc_page_sleepable(const struct bpf_map *map);
 #ifdef CONFIG_MEMCG
 void bpf_map_memcg_enter(const struct bpf_map *map, struct mem_cgroup **old_memcg,
 			 struct mem_cgroup **new_memcg);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 8d111da88655..67d8157c6623 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -602,15 +602,14 @@ static bool can_alloc_pages(void)
 		!IS_ENABLED(CONFIG_PREEMPT_RT);
 }
 
+#define BPF_PAGE_GFP (GFP_KERNEL | __GFP_ZERO | __GFP_ACCOUNT | __GFP_NOWARN)
+
 static struct page *__bpf_alloc_page(int nid)
 {
 	if (!can_alloc_pages())
 		return alloc_pages_nolock(__GFP_ACCOUNT, nid, 0);
 
-	return alloc_pages_node(nid,
-				GFP_KERNEL | __GFP_ZERO | __GFP_ACCOUNT
-				| __GFP_NOWARN,
-				0);
+	return alloc_pages_node(nid, BPF_PAGE_GFP, 0);
 }
 
 int bpf_map_alloc_pages(const struct bpf_map *map, int nid,
@@ -636,6 +635,20 @@ int bpf_map_alloc_pages(const struct bpf_map *map, int nid,
 	return ret;
 }
 
+/*
+ * For callers that know they run in a sleepable context, e.g. a user page
+ * fault handler. can_alloc_pages() is a conservative guess made for BPF
+ * program context - notably it is always false on PREEMPT_RT - so going
+ * through bpf_map_alloc_pages() there would needlessly pick the
+ * non-blocking allocator, which never reclaims and never engages the OOM
+ * machinery.
+ */
+struct page *bpf_map_alloc_page_sleepable(const struct bpf_map *map)
+{
+	might_sleep();
+	return alloc_pages_node(map->numa_node, BPF_PAGE_GFP, 0);
+}
+
 
 static int btf_field_cmp(const void *a, const void *b)
 {
-- 
2.43.0

