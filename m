Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.131.191.57
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792581908;
	b=0LZ64JYRuFEAoxUw2GqSQ9ll26vrj3cUvaTogOSRcTc96574D78rTyFnjix0eRc1auKu
	 Y7BuyXHStF9WKmOEWSA4eAkUf7x07I+21ud3orIvBalcx9ly7f2YA8sARXzHR4HsoXNG4
	 p4usHJ+imyTztuPW/wjaRNGtA5VsLjfOJhWeV7fIrhw2fyXRSX9R5QGYAalf6I+8whBir
	 li5AgHDhWz1N3TCNKEzuQlwNvNBxo0rsinZh3iqYTJB0AQ/vh9EiPWoxusLh91xCiqASf
	 xarYYeCh8PBDnKIIouRbTvzxxeTksG9isxMNnVzXjfeb8zmmRkqn3gYEHw4jWmY94NA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792581908;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-HM-Tid:X-HM-MType:X-HM-Spam-Status;
	bh=mBXfKVl4/Kl4meR18VHWKqXqUs3LmwtSo20MC6ZTq7c=;
	b=vqlsa+ZXvgBIlmlQmfrxSdbpiVsBAVBfgM5DcL9FsS7AZrUyZ4D6mdTPtrwew27CMfx/
	 BxcIEqprI7uMJupOugI3yhbJF6zM7/BHSDGAEfzz0YPpQYG/NlG5NRGpCcOHExDwpeldq
	 kAI5GlctCMMLlmqOMNA/SHLwScfqsivy6/bkIFLsdskguith8xIvdh9ubx7+sR8ojYEWu
	 tCKoYIH/z2xwH6jcG3Kp9mI+NoZgxUzswqZ8VtoukAG3+7q3AwZmbwcsZgHLMyEX6F5+m
	 KtftLYdSx+Z2k/LHLghro9MfkF1XlgeobaZ/prbt5WUrxCEI3Qpl1x4YGb05RtGkSeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=easystack.cn;
	spf=pass smtp.mailfrom=easystack.cn;
	arc=none smtp.remote-ip=103.131.191.57
Received: from mail-m10313119157.xmail.ntesmail.com (mail-m10313119157.xmail.ntesmail.com [103.131.191.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B75606A331;
	Wed, 21 Oct 2026 11:25:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2B75606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from localhost.localdomain (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTP id 204f151ad;
	Wed, 21 Oct 2026 19:24:55 +0800 (GMT+08:00)
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
Subject: [PATCH v3 5/7] mm/page_owner: record the NUMA node in the scan cursor
Date: Wed, 21 Oct 2026 19:24:35 +0800
Message-Id: <20261021112437.1799213-6-zhen.ni@easystack.cn>
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
X-HM-Tid: 0aa15e35045c0229kunme08c1fd526ace7
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDGkkdVk4fTklKTR5KHUlOHlYVFA
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
Changes in v3:
- Add @scan->nid to the comment describing what is filled.

Changes in v2:
- Removes the v1 get_nid() kfunc. The node is now stored in scan->nid.

v2: https://lore.kernel.org/linux-mm/20261013122125.843451-5-zhen.ni@easystack.cn/
v1: https://lore.kernel.org/linux-mm/20261009112308.240769-5-zhen.ni@easystack.cn/
---
 mm/page_owner.c      | 29 +++++++++++++++++------------
 mm/page_owner.h      |  1 +
 mm/page_owner_iter.c |  4 +++-
 3 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index ece3b69a2579..8bc15bcdc24e 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -711,9 +711,22 @@ void __dump_page_owner(const struct page *page)
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
- * On a hit, fill scan->pfn/po_snap and return true; the caller
+ * On a hit, fill scan->pfn/po_snap/nid and return true; the caller
  * must advance scan->pfn past the hit before calling again to resume
  * the scan.
  */
@@ -790,6 +803,7 @@ bool page_owner_next_eligible(struct page_owner_scan *scan)
 		if (!scan->po_snap.handle)
 			goto ext_put_continue;
 
+		scan->nid = page_owner_get_nid(page);
 		page_ext_put(page_ext);
 		put_online_mems();
 		return true;
@@ -833,17 +847,8 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 			goto skip_continue;
 
 		if (state->nid_filter_enabled) {
-			int nid;
-			memdesc_flags_t page_flags = READ_ONCE(page->flags);
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
index 4ab513f17fc9..934bc9f84d6f 100644
--- a/mm/page_owner.h
+++ b/mm/page_owner.h
@@ -38,6 +38,7 @@ struct page_owner_scan {
 	/* resume point */
 	unsigned long pfn;
 	struct page_owner po_snap;
+	int nid;
 };
 
 bool page_owner_next_eligible(struct page_owner_scan *scan);
diff --git a/mm/page_owner_iter.c b/mm/page_owner_iter.c
index 4b9741a2de53..b7e0ce1dfa80 100644
--- a/mm/page_owner_iter.c
+++ b/mm/page_owner_iter.c
@@ -12,10 +12,11 @@ struct bpf_iter__page_owner {
 	__bpf_md_ptr(struct bpf_iter_meta *, meta);
 	__bpf_md_ptr(struct page_owner *, po);
 	u64 pfn;
+	int nid;
 };
 
 DEFINE_BPF_ITER_FUNC(page_owner, struct bpf_iter_meta *meta,
-		     struct page_owner *po, u64 pfn)
+		     struct page_owner *po, u64 pfn, int nid)
 
 static void *page_owner_seq_start(struct seq_file *seq, loff_t *posp)
 {
@@ -52,6 +53,7 @@ static int page_owner_prog_seq_show(struct bpf_prog *prog,
 		/* @po: hit-time snapshot, no RCU window needed. */
 		ctx.po = &scan->po_snap;
 		ctx.pfn = scan->pfn;
+		ctx.nid = scan->nid;
 	}
 
 	return bpf_iter_run_prog(prog, &ctx);
-- 
2.20.1

