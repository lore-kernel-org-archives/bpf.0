Received: from mail-m3272.qiye.163.com (mail-m3272.qiye.163.com [220.197.32.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002CD4E50BB;
	Fri,  9 Oct 2026 13:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791553567; cv=none; b=bD867z1CDwlfpbc4agldAKL8Th7adNgYoyzRMeVJjtA4hzDVs2MxxRZF0tW1WfBXusanr/LSaBvn/BcI18p8rNDxPP1yiU3URWyuDYz7djy25mgAjftVFElsoeVR/oRGr8vKOBNF0E1EI87p3fI5zFWpiCT06RuVv753uGeA1S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791553567; c=relaxed/simple;
	bh=2MBQJPHhAwvTI0/6SuzIGdNe/4Na6UB7rkA3+fuVzZA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R/YK0apBQ4LecmpDldZqkn3qR68zr1d+lmFDLrmepAlns88ZJnvAM4akOlr6eyeszolUPXkXe+tkw48NXKdLVmCY7JUSMNDWQgZuRZuyN4cUKbBv7u7+XRykrbn02MdBoem2nkeWgFN1bHhOg5quXookFKlI3N8dptibqHtQp6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn; spf=pass smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=220.197.32.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from localhost.localdomain (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1fe2901a2;
	Fri, 9 Oct 2026 19:23:29 +0800 (GMT+08:00)
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
Subject: [PATCH 4/6] mm/page_owner: add bpf_page_owner_get_nid() kfunc
Date: Fri,  9 Oct 2026 19:23:06 +0800
Message-Id: <20261009112308.240769-5-zhen.ni@easystack.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20261009112308.240769-1-zhen.ni@easystack.cn>
References: <20261009112308.240769-1-zhen.ni@easystack.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1206765f80229kunmd33b3e054cb287
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCTxkdVk5KS09OSkpKTBpCGlYVFA
	kWGhdVGRETFhoSFyQUDg9ZV1kYEgtZQVlJSkNVQk9VSkpDVUJLWVdZFhoPEhUdFFlBWU9LSFVKS0
	lPT09IVUpLS1VKQktLWQY+

Extract the NUMA node lookup from read_page_owner() into a shared
page_owner_get_nid() helper, and expose it to BPF programs as
bpf_page_owner_get_nid().

The nid bitfield layout is build-time configuration, so BPF programs
cannot accurately derive it from page->flags.

Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
---
 kernel/bpf/helpers.c |  1 +
 mm/page_owner.c      | 26 +++++++++++++++-----------
 mm/page_owner.h      |  1 +
 mm/page_owner_iter.c |  5 +++++
 4 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 23a2d2d71f4d..3e8afd19a1f4 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4951,6 +4951,7 @@ BTF_ID_FLAGS(func, bpf_iter_page_owner_new, KF_ITER_NEW | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_iter_page_owner_next, KF_ITER_NEXT | KF_RET_NULL | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_iter_page_owner_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_page_owner_stack_snprint, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_page_owner_get_nid, KF_SLEEPABLE)
 #endif
 BTF_ID_FLAGS(func, __bpf_trap)
 BTF_ID_FLAGS(func, bpf_strcmp, KF_PERFMON);
diff --git a/mm/page_owner.c b/mm/page_owner.c
index eb420803a434..43a722678acc 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -711,6 +711,19 @@ void __dump_page_owner(const struct page *page)
 	page_ext_put(page_ext);
 }
 
+/*
+ * NUMA node of @page, bypassing PF_POISONED_CHECK() in page_to_nid() to
+ * avoid VM_BUG_ON on poisoned pages; -1 for poisoned pages.
+ */
+int page_owner_get_nid(struct page *page)
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
@@ -810,18 +823,9 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 	/* Find an allocated page */
 	while (page_owner_next_eligible(&scan)) {
 		if (state->nid_filter_enabled) {
-			int nid;
-			memdesc_flags_t page_flags =
-				READ_ONCE(scan.page->flags);
+			int nid = page_owner_get_nid(scan.page);
 
-			/*
-			 * Bypass PF_POISONED_CHECK() in page_to_nid() to avoid
-			 * VM_BUG_ON when accessing poisoned pages.
-			 */
-			if (page_flags.f == PAGE_POISON_PATTERN)
-				goto skip_continue;
-			nid = memdesc_nid(&page_flags);
-			if (!node_isset(nid, state->nid_filter))
+			if (nid < 0 || !node_isset(nid, state->nid_filter))
 				goto skip_continue;
 		}
 
diff --git a/mm/page_owner.h b/mm/page_owner.h
index fda83be69275..c57859d18dc3 100644
--- a/mm/page_owner.h
+++ b/mm/page_owner.h
@@ -39,6 +39,7 @@ struct page_owner_scan {
 };
 
 bool page_owner_next_eligible(struct page_owner_scan *scan);
+int page_owner_get_nid(struct page *page);
 
 /*
  * mm/page_owner_iter.c
diff --git a/mm/page_owner_iter.c b/mm/page_owner_iter.c
index 80693d417407..907517a29144 100644
--- a/mm/page_owner_iter.c
+++ b/mm/page_owner_iter.c
@@ -165,4 +165,9 @@ __bpf_kfunc int bpf_page_owner_stack_snprint(depot_stack_handle_t handle,
 	return stack_depot_snprint(handle, buf, buf_size, 0);
 }
 
+__bpf_kfunc int bpf_page_owner_get_nid(struct page_owner_scan *scan)
+{
+	return page_owner_get_nid(scan->page);
+}
+
 __bpf_kfunc_end_defs();
-- 
2.20.1

