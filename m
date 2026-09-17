Received: from mta0.migadu.com (out-83.mta0.migadu.com [91.218.175.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB10337F725
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 01:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789610274; cv=none; b=Nv0LEiV+kHPObk5W6d6+AL6hHPggofGdS6Uh7+SemrnCOKLyZwI54+gSoPFo1tlhyrS965pzBxDmOsBq4lv4Hssi3iqU//Oamwdqcjo3bIhMbPOQsKy+3vZUxZIDq8k3CvZKA64V6Vif2M86P+kDezFHJ7eRGZS70Kl9MgF6tjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789610274; c=relaxed/simple;
	bh=yh/U8ST03EbCS0Q3T0iZvrAN/bAyuPwW4OCDVzGf/+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KITggWKM9/FZgE/7qTlnoHl9IiQ7epdkOKjYE1yDqLhAl2Xk4JuROzwMRT7GpmI6I2rQdyBFsyGHg6gNiyL/bewGoQ+wyl3mIshYlTAbKVRq6iMaqOx1rjpz2Vd3q0ktR9vArD8AMcmo86RwgLnNm/8mQcD8/AT93lV31oIoXf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c5qC/F8s; arc=none smtp.client-ip=91.218.175.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c5qC/F8s"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=yh/U8ST03EbCS0Q3T0iZvrAN/bAyuPwW4OCDVzGf/+I=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789610270; v=1; x=1790215070;
 b=c5qC/F8s5SMowxZVcAylC+Fe+FLoqFu5nrKnfsQtubgHsYGbUxXycXdESVbKo2DrjgGp0hKo
 MHRJpqXsf76BAvCPZruUHUUieaf3g8miz8DPzITRPkSmWmuWakZOIEwelQn+NeNugRWMfycnxyn
 2Uf/Iry1ZqGa7q0rIVlBqeRE=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 7db3ab29c6b34130;
	Thu, 17 Sep 2026 01:57:50 +0000
X-Mizu-Trace-ID: 7db3ab29c6b34130
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v7 1/4] bpf: Add a sleepable page allocator for map memory
Date: Thu, 17 Sep 2026 09:55:06 +0800
Message-ID: <20260917015618.7488-2-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917015618.7488-1-jiayuan.chen@linux.dev>
References: <20260917015618.7488-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_map_alloc_pages() can use a non-blocking allocator that never
reclaims. Add bpf_map_alloc_page_sleepable() which always uses the
blocking allocator, so the allocation can reclaim. It uses
__GFP_RETRY_MAYFAIL so it never invokes the OOM killer: the page is
charged to the map's memcg, which need not be the caller's, so an OOM
there could kill unrelated tasks in the map's cgroup while a foreign
caller could never be its victim. The caller is responsible for a
context where blocking is safe; see the function comment.

Like the other bpf map allocators it places the page on the map's
numa_node and does not follow the faulting task's NUMA mempolicy; arena
memory is shared, so the map's node is the right placement policy. The
next patch uses it from the arena page fault handler.

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
 kernel/bpf/syscall.c | 28 ++++++++++++++++++++++++----
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index e80963971f680..345fe4c2e6422 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2786,6 +2786,7 @@ struct bpf_prog *bpf_prog_get_curr_or_next(u32 *id);
 
 int bpf_map_alloc_pages(const struct bpf_map *map, int nid,
 			unsigned long nr_pages, struct page **page_array);
+struct page *bpf_map_alloc_page_sleepable(const struct bpf_map *map);
 #ifdef CONFIG_MEMCG
 void bpf_map_memcg_enter(const struct bpf_map *map, struct mem_cgroup **old_memcg,
 			 struct mem_cgroup **new_memcg);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index c7bc9ba9b331f..abd0f67c68d97 100644
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
@@ -636,6 +635,27 @@ int bpf_map_alloc_pages(const struct bpf_map *map, int nid,
 	return ret;
 }
 
+/*
+ * Allocate a page for map memory with the blocking allocator so it can
+ * reclaim. __GFP_RETRY_MAYFAIL keeps it from invoking the OOM killer: the
+ * page is charged to the map's memcg, which need not be the caller's, so
+ * an OOM there could kill unrelated tasks in the map's cgroup while a
+ * foreign caller could never be its victim.
+ *
+ * bpf_map_alloc_pages() serves arbitrary BPF program context and stays
+ * reentrancy-safe by falling back to the non-blocking allocator. This
+ * helper always blocks, so a sleepable context alone is not enough: the
+ * caller must guarantee it is not already inside the page allocator or
+ * reclaim, where blocking here would reenter mm and deadlock. The only
+ * user is arena_vm_fault(), a userspace page fault in task context.
+ */
+struct page *bpf_map_alloc_page_sleepable(const struct bpf_map *map)
+{
+	might_sleep();
+	return alloc_pages_node(map->numa_node,
+				BPF_PAGE_GFP | __GFP_RETRY_MAYFAIL, 0);
+}
+
 static int btf_field_cmp(const void *a, const void *b)
 {
 	const struct btf_field *f1 = a, *f2 = b;
-- 
2.43.0

