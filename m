Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.224.81.87
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792581901;
	b=lb+HwqQaqw99KfqP//TMqgon24ACegcj6/1O9AAkef8T3aV8GSsBilK/RkCwJ65DGygr
	 jLBrQDnAAp5RydCOfq0r8HPNPhkxhXJGdkB8Nknxm4Wf5GA1/WYyvvjVyoRHZR2VqD/uF
	 /D0j88p8hdRoCRRo3ULBX1TAHVEf8corDMwrtDBpZe8MCLfUMccjmAGWTnNp622JqBsNN
	 +hjfrzRZ4hCEaE9w79/noGxCDV5uBnnF6M5VruHXDQpFCgey0S4tNe9PZHCxXDPLYZVGn
	 7d4IkYwPc23tKcRbvgCJZN4HpTThvZtOUwU509ItUdqFAsJT5WVinmjIO5A/isycISQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792581901;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-HM-Tid:X-HM-MType:X-HM-Spam-Status;
	bh=a6dY8R/bQis1rIq1yZh1AAI0QczoTtw4exwtDutCO9s=;
	b=C8vBfUDFQ1MmnHloXjihbWp96Qu3FVMxW9hC4PEBYKgOs9VrO70oxtZy/LmldLZaaKgt
	 iH8WGfatLEgpdFAgQra9llCbas+z0VC6TpmwIAWR4SVC4eGGW2W/Tonz1DOR/gKxy4sSH
	 iIp4QjpGovh78MijzKEaD8PWfdW/iXZP7aSiXHSiK4P/3UR7FEXZscRDoRfCtvUtIgCLz
	 aPAdPvs4CcyDKn83qj5RGWwN8RVcagCbVod63LbaYoIe+jqSYUDkTvJSd7os+Cp/9CttZ
	 9YRtjvBk/IHVsYFNxTBMobMltbmu9xD47DAH3bPJTlZ6Uwh5oK4Sb8zm5ddCqkgPQtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=easystack.cn;
	spf=pass smtp.mailfrom=easystack.cn;
	arc=none smtp.remote-ip=156.224.81.87
Received: from mail-m8187.xmail.ntesmail.com (mail-m8187.xmail.ntesmail.com [156.224.81.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA4F606A31D;
	Wed, 21 Oct 2026 11:24:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFA4F606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from localhost.localdomain (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTP id 204f151a5;
	Wed, 21 Oct 2026 19:24:49 +0800 (GMT+08:00)
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
Subject: [PATCH v3 1/7] mm/page_owner: extract page_owner_next_eligible() from read loop
Date: Wed, 21 Oct 2026 19:24:31 +0800
Message-Id: <20261021112437.1799213-2-zhen.ni@easystack.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20261021112437.1799213-1-zhen.ni@easystack.cn>
References: <20261021112437.1799213-1-zhen.ni@easystack.cn>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa15e34eca80229kunme08c1fd526acd0
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDHU9CVkMdQk9CH09KTkJOGFYVFA
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
Changes in v3:
- Drop the page field in struct page_owner_scan.

Changes in v2:
- Route the zero-handle case through ext_put_continue.

v1: https://lore.kernel.org/linux-mm/20261009112308.240769-2-zhen.ni@easystack.cn/
v2: https://lore.kernel.org/linux-mm/20261013122125.843451-2-zhen.ni@easystack.cn/
---
 mm/page_owner.c | 101 ++++++++++++++++++++++++++++++------------------
 1 file changed, 64 insertions(+), 37 deletions(-)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index fbbda7ba914b..92a92cdf74ec 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -36,6 +36,15 @@ struct page_owner {
 	pid_t free_tgid;
 };
 
+/*
+ * Cursor and per-page result of page_owner_next_eligible().
+ */
+struct page_owner_scan {
+	/* resume point */
+	unsigned long pfn;
+	struct page_owner po_snap;
+};
+
 struct stack {
 	struct stack_record *stack_record;
 	struct stack *next;
@@ -725,37 +734,24 @@ void __dump_page_owner(const struct page *page)
 	page_ext_put(page_ext);
 }
 
-static ssize_t
-read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
+/*
+ * Advance @scan to the next page eligible for page_owner output.
+ * On a hit, fill scan->pfn/po_snap and return true; the caller
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
@@ -798,13 +794,45 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
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
+		struct page *page = pfn_to_page(scan.pfn);
+
 		if (state->nid_filter_enabled) {
 			int nid;
 			memdesc_flags_t page_flags = READ_ONCE(page->flags);
@@ -814,21 +842,20 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
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
+		return print_page_owner(buf, count, scan.pfn, page,
+				&scan.po_snap, scan.po_snap.handle, state);
+
+skip_continue:
+		scan.pfn++;
 		cond_resched();
 	}
 
-- 
2.20.1

