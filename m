Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.79.60.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792581902;
	b=wvvWAj649LEIokNazyn3xNz6W2orI21HKn5COvHlIdeinbQ473Sc0aT8qs3fyTv1BX5j
	 DDkyKhTxvMFqRH2QsmORaoLKWbUew2YSFBJip8YzIElufY+4UK1/47G8PT26MpxA8Mrmt
	 61QzhhLujaCoj7QzYVBmZVD43EXf//yUTT6YhR3SOrDTraoQyg+V6ul43D9wHxZ22E2Tk
	 TVo4wjhNVpWg9IKTvxt8nec7z5OqODf2puWOXY6u+KVchx4cYA0hvcQbXgAQJmh9Pi5N8
	 QIl/p7uIuAUVMb+vKf7vugAOs3298UPT18bO1v1D0MjufZ4I99cbTdPIHL+sVnglnAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792581902;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-HM-Tid:X-HM-MType:X-HM-Spam-Status;
	bh=XNod+BDD/BkSwCVYSyt2PbUacsNtMgi+MLEdpjX47ak=;
	b=pUK/FV5fszLimbBWg1Q36lcxXAPrpVlBd6D4bEdTYz8lcZfG8Yw2XX+Pj03iw8EZ7Yqh
	 nXlBJpTtXC51jN441CVhP33TQ/HC3Eu31PZ3Hgvqg/tq3/0zJbBxtmdlo6s8OQNP3t3/H
	 kMzlOQKt/9YIV4+AiJo6a60O+fHpgBKN+1mbphyBP/U+7GbCf+cgXLMQ48FCkgPA+TnDW
	 pZhRYgJP6/Oin4fKSkIBfLUxwZFlNQo/50gfblvZlpw6UImOIyEKJoDT50iKMHGjLZ/7j
	 LjdBqgqZkifSz/hKAen/87q2lgSbjKhhJESVCvPH+d11kC1nDmMlIQ84EW4BXl4LLNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=easystack.cn;
	spf=pass smtp.mailfrom=easystack.cn;
	arc=none smtp.remote-ip=210.79.60.16
Received: from mail-m6016.netease.com (mail-m6016.netease.com [210.79.60.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E920606A31B;
	Wed, 21 Oct 2026 11:25:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E920606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from localhost.localdomain (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTP id 204f151a7;
	Wed, 21 Oct 2026 19:24:50 +0800 (GMT+08:00)
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
Subject: [PATCH v3 2/7] mm/page_owner: protect page access with mem-hotplug read lock
Date: Wed, 21 Oct 2026 19:24:32 +0800
Message-Id: <20261021112437.1799213-3-zhen.ni@easystack.cn>
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
X-HM-Tid: 0aa15e34f2a30229kunme08c1fd526acd7
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDSx5PVhoeSE1LGB5LTEpMH1YVFA
	kWGhdVGRETFhoSFyQUDg9ZV1kYEgtZQVlJSkNVQk9VSkpDVUJLWVdZFhoPEhUdFFlBWU9LSFVKS0
	lPT09IVUpLS1VKQktLWQY+

The page_owner scan walks PFNs locklessly and dereferences the resolved
struct page in the scan itself and in print_page_owner(). With
CONFIG_MEMORY_HOTREMOVE, a concurrent remove_memory() can tear down the
section's vmemmap, so a dereference after a stale validity check may
fault.

Take a mem-hotplug read lock across each page's check-then-deref. In the
scan, gate every PFN with pfn_to_online_page() under the reader and drop
it before cond_resched(), so hotplug can still interleave between pages;
in print_page_owner(), re-resolve the page under a reader covering just
the print of one record.

The reader is cheap: get_online_mems()/put_online_mems() are just
per-CPU counter increments/decrements when no hotplug is active, so
they contend only with an actual add/remove. Taking the lock per-page
bounds the writer's wait to a single page's check-and-deref, keeping
hot-remove stalls brief while all accesses stay protected.

This makes the traversal crash-free. A recycled-but-present page can
still yield stale data -- the lockless scan is best-effort and
unchanged by this patch.

Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
---
Changes in v3:
- New patch. Add the mem-hotplug protect.
---
 mm/page_owner.c | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index 92a92cdf74ec..8e72a85c663c 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -762,13 +762,22 @@ static bool page_owner_next_eligible(struct page_owner_scan *scan)
 			continue;
 		}
 
-		page = pfn_to_page(pfn);
+		/*
+		 * Hold a mem-hotplug reader across the page derefs so the
+		 * vmemmap isn't torn down mid-scan; released before
+		 * cond_resched().
+		 */
+		get_online_mems();
+		page = pfn_to_online_page(pfn);
+		if (!page)
+			goto put_online_continue;
+
 		if (skip_buddy_pages(&pfn, page))
-			continue;
+			goto put_online_continue;
 
 		page_ext = page_ext_get(page);
 		if (unlikely(!page_ext))
-			continue;
+			goto put_online_continue;
 
 		/*
 		 * Some pages could be missed by concurrent allocation or free,
@@ -805,10 +814,13 @@ static bool page_owner_next_eligible(struct page_owner_scan *scan)
 			goto ext_put_continue;
 
 		page_ext_put(page_ext);
+		put_online_mems();
 		return true;
 
 ext_put_continue:
 		page_ext_put(page_ext);
+put_online_continue:
+		put_online_mems();
 		cond_resched();
 	}
 
@@ -831,7 +843,17 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 
 	/* Find an allocated page */
 	while (page_owner_next_eligible(&scan)) {
-		struct page *page = pfn_to_page(scan.pfn);
+		struct page *page;
+		ssize_t ret;
+
+		/*
+		 * The scan is lockless. Re-resolve the page under a mem-hotplug
+		 * read-side lock so that we never access a hot-removed section.
+		 */
+		get_online_mems();
+		page = pfn_to_online_page(scan.pfn);
+		if (!page)
+			goto skip_continue;
 
 		if (state->nid_filter_enabled) {
 			int nid;
@@ -851,10 +873,13 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 		/* Record the next PFN to read in the file offset */
 		*ppos = scan.pfn + 1;
 
-		return print_page_owner(buf, count, scan.pfn, page,
+		ret = print_page_owner(buf, count, scan.pfn, page,
 				&scan.po_snap, scan.po_snap.handle, state);
+		put_online_mems();
+		return ret;
 
 skip_continue:
+		put_online_mems();
 		scan.pfn++;
 		cond_resched();
 	}
-- 
2.20.1

