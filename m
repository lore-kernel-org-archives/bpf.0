Received: from mail-m1973198.qiye.163.com (mail-m1973198.qiye.163.com [220.197.31.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DF013D53C;
	Tue, 13 Oct 2026 12:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791896246; cv=none; b=HCVcBussIkwz+T7P3gu7SrXHjKkcJ1DTZR4KjrvlllnEozgi+fb2bj4SX+SRqVY5WA4+VEPmqBYoT5Z6qNvrkDdtBJATb6k52jeArI9FiIl4aibulEVDKoxl0twPWcgztFUJW/iSmPdDSk8ipRHoSF9L2yA2H7Iv4Jl8U0Y9FQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791896246; c=relaxed/simple;
	bh=mCsPqGiqz9PyjMkewqXOYz3BEsU6ovphopKLLemF7Gw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=usw4tkVF03O74JkU/lKL38zZUrQE44OneE1IiTeONsuP1DWD/wmMGH08/ASuM2pZ2gfKae/ySFN7ChYkZ4NRrZzEdgZSwO05MYLhx1XGppQm1GV/XI4gYprh+pZO9xqsnu0qHYMiXCiM9/x33caOlUQJO3KReVkLv59s7uFQTjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn; spf=pass smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=220.197.31.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from localhost.localdomain (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTP id 200407eea;
	Tue, 13 Oct 2026 20:21:43 +0800 (GMT+08:00)
From: Zhen Ni <zhen.ni@easystack.cn>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	akpm@linux-foundation.org,
	vbabka@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	brendan.jackman@linux.dev,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	shuah@kernel.org
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhen Ni <zhen.ni@easystack.cn>
Subject: [PATCH v2 1/6] mm/page_owner: extract page_owner_next_eligible() from read loop
Date: Tue, 13 Oct 2026 20:21:20 +0800
Message-Id: <20261013122125.843451-2-zhen.ni@easystack.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20261013122125.843451-1-zhen.ni@easystack.cn>
References: <20261013122125.843451-1-zhen.ni@easystack.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1353625140229kunm0bc94a6a524c
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaHRhMVklNTUtNSx0YSh9DGFYVFA
	kWGhdVGRETFhoSFyQUDg9ZV1kYEgtZQVlJSkNVQk9VSkpDVUJLWVdZFhoPEhUdFFlBWU9LSFVKS0
	lPT09IVUpLS1VKQktLWQY+

Move the page scanning logic out of read_page_owner() into a dedicated
helper, in preparation for using it in the page_owner bpf_iter target.

The helper advances a struct page_owner_scan cursor to the next page
eligible for page_owner output and returns true on a hit. On a hit it
takes a snapshot of the page_owner record inside the page_ext RCU
window.

No change to the output is intended. handle is read from the snapshot,
taken before the non-zero check, so the validated and reported handle
are the same value.

Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
---
Changes in v2:
- Route the zero-handle case through ext_put_continue.

v1: https://lore.kernel.org/linux-mm/20261009112308.240769-2-zhen.ni@easystack.cn/
---
 mm/page_owner.c | 103 ++++++++++++++++++++++++++++++------------------
 1 file changed, 65 insertions(+), 38 deletions(-)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index fbbda7ba914b..56c75a669a6b 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -36,6 +36,16 @@ struct page_owner {
 	pid_t free_tgid;
 };
 
+/*
+ * Cursor and per-page result of page_owner_next_eligible().
+ */
+struct page_owner_scan {
+	/* resume point */
+	unsigned long pfn;
+	struct page *page;
+	struct page_owner po_snap;
+};
+
 struct stack {
 	struct stack_record *stack_record;
 	struct stack *next;
@@ -725,37 +735,24 @@ void __dump_page_owner(const struct page *page)
 	page_ext_put(page_ext);
 }
 
-static ssize_t
-read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
+/*
+ * Advance @scan to the next page eligible for page_owner output.
+ * On a hit, fill scan->pfn/page/po_snap and return true; the caller
+ * must advance scan->pfn past the hit before calling again to resume
+ * the scan.
+ */
+static bool page_owner_next_eligible(struct page_owner_scan *scan)
 {
-	unsigned long pfn;
-	struct page *page;
-	struct page_ext *page_ext;
-	struct page_owner *page_owner;
-	depot_stack_handle_t handle;
-	struct page_owner_filter_state *state = file->private_data;
+	unsigned long pfn = scan->pfn;
 
-	if (!static_branch_unlikely(&page_owner_inited))
-		return -EINVAL;
-
-	page = NULL;
-	if (*ppos == 0)
-		pfn = min_low_pfn;
-	else
-		pfn = *ppos;
 	/* Find a valid PFN or the start of a MAX_ORDER_NR_PAGES area */
 	while (!pfn_valid(pfn) && (pfn & (MAX_ORDER_NR_PAGES - 1)) != 0)
 		pfn++;
 
-	/* Find an allocated page */
 	for (; pfn < max_pfn; pfn++) {
-		/*
-		 * This temporary page_owner is required so
-		 * that we can avoid the context switches while holding
-		 * the rcu lock and copying the page owner information to
-		 * user through copy_to_user() or GFP_KERNEL allocations.
-		 */
-		struct page_owner page_owner_tmp;
+		struct page_owner *page_owner;
+		struct page_ext *page_ext;
+		struct page *page;
 
 		/*
 		 * If the new page is in a new MAX_ORDER_NR_PAGES area,
@@ -798,37 +795,67 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 			goto ext_put_continue;
 
 		/*
-		 * Access to page_ext->handle isn't synchronous so we should
-		 * be careful to access it.
+		 * Take a snapshot of the page_owner record inside the RCU
+		 * window, then validate it, so that print_page_owner()
+		 * reads the checked handle from the same snapshot.
 		 */
-		handle = READ_ONCE(page_owner->handle);
-		if (!handle)
+		scan->pfn = pfn;
+		scan->page = page;
+		scan->po_snap = *page_owner;
+
+		if (!scan->po_snap.handle)
 			goto ext_put_continue;
 
+		page_ext_put(page_ext);
+		return true;
+
+ext_put_continue:
+		page_ext_put(page_ext);
+		cond_resched();
+	}
+
+	return false;
+}
+
+static ssize_t
+read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
+{
+	struct page_owner_scan scan;
+	struct page_owner_filter_state *state = file->private_data;
+
+	if (!static_branch_unlikely(&page_owner_inited))
+		return -EINVAL;
+
+	if (*ppos == 0)
+		scan.pfn = min_low_pfn;
+	else
+		scan.pfn = *ppos;
+
+	/* Find an allocated page */
+	while (page_owner_next_eligible(&scan)) {
 		if (state->nid_filter_enabled) {
 			int nid;
-			memdesc_flags_t page_flags = READ_ONCE(page->flags);
+			memdesc_flags_t page_flags =
+				READ_ONCE(scan.page->flags);
 
 			/*
 			 * Bypass PF_POISONED_CHECK() in page_to_nid() to avoid
 			 * VM_BUG_ON when accessing poisoned pages.
 			 */
 			if (page_flags.f == PAGE_POISON_PATTERN)
-				goto ext_put_continue;
+				goto skip_continue;
 			nid = memdesc_nid(&page_flags);
 			if (!node_isset(nid, state->nid_filter))
-				goto ext_put_continue;
+				goto skip_continue;
 		}
 
 		/* Record the next PFN to read in the file offset */
-		*ppos = pfn + 1;
+		*ppos = scan.pfn + 1;
 
-		page_owner_tmp = *page_owner;
-		page_ext_put(page_ext);
-		return print_page_owner(buf, count, pfn, page,
-				&page_owner_tmp, handle, state);
-ext_put_continue:
-		page_ext_put(page_ext);
+		return print_page_owner(buf, count, scan.pfn, scan.page,
+				&scan.po_snap, scan.po_snap.handle, state);
+skip_continue:
+		scan.pfn++;
 		cond_resched();
 	}
 
-- 
2.20.1

