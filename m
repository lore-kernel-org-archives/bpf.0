Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5EE3F326C
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 09:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785921616; cv=none; b=qSdOK/5Xy3jNiG3hOv+y43rsU/3g0A3F8lty0NnrBWzfhspZ7Pnx85Lnjzf+a3dzS+wimReEVP7wvxHCMmVW14RVl/H/3CvXxg36StgGRa2kyOiy7a6xKKJ0YRfgN9xSssOTnFMdK9lVVe9RI6fwrekwMWLZ3fSiQyKGQgCM05s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785921616; c=relaxed/simple;
	bh=ijsnVrTrJAr9iIFufGidF9T2LTUTcg75qzLv7bwVVP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aL7IPL/6zKVj8T6imHkZa2sg1785gTJQkwso/e9/QtheWECQ38xCb5rv7hYnTBLqCQzi+brQyGdKWKQEEIAMPdhQu6XsKnr/0xqvtSkCdxGJjZ2HAyDDNFs/Y1pxYZPImOyUEIW6IOxdr3C4rmHep6WtnxY1wU7dulSuoDnKmGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ArIN6sN/; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ArIN6sN/"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785921611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nI2x4Jw4QeDH+z0w8stHMu3B2x9kMF1+3hiOMr55Tzo=;
	b=ArIN6sN/8ojY0V9jMtDPvYjzaY+pzmBJlFZRF64c4OxST+5INcT9DOa5Qsq/KaRA8YsDmT
	XbD3U1Dmh4eIWbRvatGb0WWwB21vi4Hi1tLDWsJ5vYLqn3lhxdYlcY6CHZOHe1qM7EcBBR
	0NE+eI64Ivk/Dsif8WrSBtomjYu0b6E=
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
Subject: [PATCH bpf-next v2 1/4] bpf: Add a sleepable page allocator for map memory
Date: Wed,  5 Aug 2026 17:15:54 +0800
Message-ID: <20260805091720.139924-2-jiayuan.chen@linux.dev>
In-Reply-To: <20260805091720.139924-1-jiayuan.chen@linux.dev>
References: <20260805091720.139924-1-jiayuan.chen@linux.dev>
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
sleepable. It allocates from the map's numa_node, like the other map
allocators. The next patch uses it from the arena page fault handler.

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
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

