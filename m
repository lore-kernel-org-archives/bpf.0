Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C3E39AD51
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 11:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784288551; cv=none; b=qraQDwiQYLpfnebV2LNDTLKilHKJ9EFegtFE+qYCr2gS5nmWk9uSQtCwpnQl3qS5tnYpNfgh42MllY7ls08jZ6dvg97XE1w6MKHSz6xFB8Q1A/tQCROmwtr/Mh1Maepl9hIC8m1ay79tsYMLO46jE59oZLcpI1O4+uX2wI5F/1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784288551; c=relaxed/simple;
	bh=edW/zkxQxHYY/xoESPYEqRNXd9pMHIOihUL5aFJKh68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TpL5CfEcSS47lpYwgKfrPc0HN6Bo9w4512EmPFubE9LBRrL//3ZIyvk+O2Al9Wu1OifTT6j4Hml8Py4aT2oa57QY4wd+te7qqsJz940l/YmUFxHdH+2vJZk25S6HLYbnpRQrfAuSrWgGiZi+3Hkp2rq1lTWwyJ5XNEdVZrDAk78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m3aDTVBA; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m3aDTVBA"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784288547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RrPtZPFmU7k8SyJGbrsegJWZtSKVS++WfilbkTIJ0YE=;
	b=m3aDTVBAkDOtk3sYl2jKd2hEMKKFGueSdrbnfQNZnEaBVKI/v0MY0jc1LvzBRU66gWlfXa
	qu+6MOXR+CvF5InDU9x1mTn37STRAoPrtufeS+y2cWsFl38+knbLQvaOpMHTsRyEsPXDpc
	ELKySs4QGBiraRzaKHwy2uXM/pURWnc=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	Woojin Ji <random6.xyz@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Saket Kumar Bhaskar <skb99@linux.ibm.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v2 1/4] bpf: Pass arena instead of scratch_page to the pte callbacks
Date: Fri, 17 Jul 2026 19:37:01 +0800
Message-ID: <20260717114117.350851-2-jiayuan.chen@linux.dev>
In-Reply-To: <20260717114117.350851-1-jiayuan.chen@linux.dev>
References: <20260717114117.350851-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace the scratch_page field in the pte-callback data with the arena
pointer; later patches use other arena fields from these callbacks. No
functional change.

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 kernel/bpf/arena.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 80b7b8a69446..8dbc24460890 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -143,14 +143,14 @@ static long compute_pgoff(struct bpf_arena *arena, long uaddr)
 }
 
 struct apply_range_data {
+	struct bpf_arena *arena;
 	struct page **pages;
-	struct page *scratch_page;
 	int i;
 };
 
 struct clear_range_data {
+	struct bpf_arena *arena;
 	struct llist_head *free_pages;
-	struct page *scratch_page;
 };
 
 static int apply_range_set_cb(pte_t *pte, unsigned long addr, void *data)
@@ -180,7 +180,7 @@ static int apply_range_set_cb(pte_t *pte, unsigned long addr, void *data)
 
 		if (pte_none(old))
 			continue;
-		if (WARN_ON_ONCE(pte_page(old) != d->scratch_page))
+		if (WARN_ON_ONCE(pte_page(old) != d->arena->scratch_page))
 			return -EBUSY;
 		ptep_get_and_clear(&init_mm, addr, pte);
 		flush_tlb_before_set(addr);
@@ -227,7 +227,7 @@ static int apply_range_clear_cb(pte_t *pte, unsigned long addr, void *data)
 	 * scratches its PTE. A later bpf_arena_free_pages() over that range walks
 	 * here. Without the skip, scratch_page would be freed.
 	 */
-	if (page == d->scratch_page)
+	if (page == d->arena->scratch_page)
 		return 0;
 
 	__llist_add(&page->pcp_llist, d->free_pages);
@@ -506,8 +506,7 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 	if (ret)
 		goto out_sigsegv_memcg;
 
-	struct apply_range_data data = { .pages = &page, .i = 0,
-					 .scratch_page = arena->scratch_page };
+	struct apply_range_data data = { .arena = arena, .pages = &page, .i = 0 };
 	/* Account into memcg of the process that created bpf_arena */
 	ret = bpf_map_alloc_pages(map, NUMA_NO_NODE, 1, &page);
 	if (ret) {
@@ -696,8 +695,8 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
 		bpf_map_memcg_exit(old_memcg, new_memcg);
 		return 0;
 	}
+	data.arena = arena;
 	data.pages = pages;
-	data.scratch_page = arena->scratch_page;
 
 	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags))
 		goto out_free_pages;
@@ -873,8 +872,8 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt,
 	range_tree_set(&arena->rt, pgoff, page_cnt);
 
 	init_llist_head(&free_pages);
+	cdata.arena = arena;
 	cdata.free_pages = &free_pages;
-	cdata.scratch_page = arena->scratch_page;
 	/* clear ptes and collect struct pages */
 	apply_to_existing_page_range(&init_mm, kaddr, page_cnt << PAGE_SHIFT,
 				     apply_range_clear_cb, &cdata);
@@ -981,8 +980,8 @@ static void arena_free_worker(struct work_struct *work)
 	bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
 
 	init_llist_head(&free_pages);
+	cdata.arena = arena;
 	cdata.free_pages = &free_pages;
-	cdata.scratch_page = arena->scratch_page;
 	arena_vm_start = bpf_arena_get_kern_vm_start(arena);
 	user_vm_start = bpf_arena_get_user_vm_start(arena);
 
-- 
2.43.0

