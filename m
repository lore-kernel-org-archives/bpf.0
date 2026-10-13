Received: from mail-m81199.xmail.ntesmail.com (mail-m81199.xmail.ntesmail.com [156.224.81.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5904EF154;
	Tue, 13 Oct 2026 12:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.224.81.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791894122; cv=none; b=Rch0I5bb83YiZbBL/rhrLpng+X78aWGZsSvGa8XNPhlwLIih8+qbKAgRcvH07ErkCx7jDkUIjj6wjicEVayATfOnMg1aUEkJR3CzXpIZ9zUROrpQQsYh2ZrCk1Mem01uL1Kc1c1hOuZN/06f8Psa41uF9PONWqpUNJbdj7s9h/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791894122; c=relaxed/simple;
	bh=Okpfzb3H0hUVmZcJAh+cXteE+qEoSMsq818Q6gYbKzY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B1D6yl7O+FTl3Xb1pHWSNLUa9hYocxNEFceya0gOpkt6dmyxQJ7sZHWG37cVTFbsg50WWAdT6WpST3vbQHf6lXsWwz34QBtx5hz4T1xRy2yfmP0qWhkNzXhl+QtKXU3dXmuXkZtTLutfBQuc12hsAFdoJl6M3GLHS+WAQlUkz5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn; spf=pass smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=156.224.81.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from localhost.localdomain (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTP id 200407ef0;
	Tue, 13 Oct 2026 20:21:47 +0800 (GMT+08:00)
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
Subject: [PATCH v2 4/6] mm/page_owner: record the NUMA node in the scan cursor
Date: Tue, 13 Oct 2026 20:21:23 +0800
Message-Id: <20261013122125.843451-5-zhen.ni@easystack.cn>
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
X-HM-Tid: 0aa1353636830229kunm0bc94a6a525d
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaGhhPVkgZGUweGhgfTBhOHVYVFA
	kWGhdVGRETFhoSFyQUDg9ZV1kYEgtZQVlJSkNVQk9VSkpDVUJLWVdZFhoPEhUdFFlBWU9LSFVKS0
	lPT09IVUpLS1VKQktLWQY+

Compute the page's NUMA node in page_owner_next_eligible() while the
page is still valid, and store it in scan->nid.

The debugfs nid filter reads scan->nid instead of recomputing it, and a
BPF program iterating the cursor reads the node straight from scan->nid.

Resolve nid at scan time to avoid dereferencing a possibly-unmapped page.
Keep it in the transient scan cursor rather than struct page_owner, so
nid does not add per-page memory overhead.

Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
---
Changes in v2:
- Removes the v1 get_nid() kfunc. The node is now stored in scan->nid.

v1: https://lore.kernel.org/linux-mm/20261009112308.240769-5-zhen.ni@easystack.cn/
---
 mm/page_owner.c      | 28 ++++++++++++++++------------
 mm/page_owner.h      |  1 +
 mm/page_owner_iter.c |  5 ++++-
 3 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index 617346a4ab22..113e4e7e0b3a 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -711,6 +711,19 @@ void __dump_page_owner(const struct page *page)
 	page_ext_put(page_ext);
 }
 
+/*
+ * NUMA node of @page, bypassing PF_POISONED_CHECK() in page_to_nid() to
+ * avoid VM_BUG_ON on poisoned pages; -1 for poisoned pages.
+ */
+static int page_owner_get_nid(struct page *page)
+{
+	memdesc_flags_t page_flags = READ_ONCE(page->flags);
+
+	if (page_flags.f == PAGE_POISON_PATTERN)
+		return -1;
+	return memdesc_nid(&page_flags);
+}
+
 /*
  * Advance @scan to the next page eligible for page_owner output.
  * On a hit, fill scan->pfn/page/po_snap and return true; the caller
@@ -782,6 +795,7 @@ bool page_owner_next_eligible(struct page_owner_scan *scan)
 		if (!scan->po_snap.handle)
 			goto ext_put_continue;
 
+		scan->nid = page_owner_get_nid(page);
 		page_ext_put(page_ext);
 		return true;
 
@@ -810,18 +824,8 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 	/* Find an allocated page */
 	while (page_owner_next_eligible(&scan)) {
 		if (state->nid_filter_enabled) {
-			int nid;
-			memdesc_flags_t page_flags =
-				READ_ONCE(scan.page->flags);
-
-			/*
-			 * Bypass PF_POISONED_CHECK() in page_to_nid() to avoid
-			 * VM_BUG_ON when accessing poisoned pages.
-			 */
-			if (page_flags.f == PAGE_POISON_PATTERN)
-				goto skip_continue;
-			nid = memdesc_nid(&page_flags);
-			if (!node_isset(nid, state->nid_filter))
+			if (scan.nid < 0 ||
+			    !node_isset(scan.nid, state->nid_filter))
 				goto skip_continue;
 		}
 
diff --git a/mm/page_owner.h b/mm/page_owner.h
index fda83be69275..e8e52d22abed 100644
--- a/mm/page_owner.h
+++ b/mm/page_owner.h
@@ -36,6 +36,7 @@ struct page_owner_scan {
 	unsigned long pfn;
 	struct page *page;
 	struct page_owner po_snap;
+	int nid;
 };
 
 bool page_owner_next_eligible(struct page_owner_scan *scan);
diff --git a/mm/page_owner_iter.c b/mm/page_owner_iter.c
index ac7e69ba0cef..a2b90c874852 100644
--- a/mm/page_owner_iter.c
+++ b/mm/page_owner_iter.c
@@ -13,10 +13,12 @@ struct bpf_iter__page_owner {
 	__bpf_md_ptr(struct page *, page);
 	__bpf_md_ptr(struct page_owner *, po);
 	u64 pfn;
+	int nid;
 };
 
 DEFINE_BPF_ITER_FUNC(page_owner, struct bpf_iter_meta *meta,
-		     struct page *page, struct page_owner *po, u64 pfn)
+		     struct page *page, struct page_owner *po, u64 pfn,
+		     int nid)
 
 static void *page_owner_seq_start(struct seq_file *seq, loff_t *posp)
 {
@@ -54,6 +56,7 @@ static int page_owner_prog_seq_show(struct bpf_prog *prog,
 		/* @po: hit-time snapshot, no RCU window needed. */
 		ctx.po = &scan->po_snap;
 		ctx.pfn = scan->pfn;
+		ctx.nid = scan->nid;
 	}
 
 	return bpf_iter_run_prog(prog, &ctx);
-- 
2.20.1

