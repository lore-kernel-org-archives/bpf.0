Received: from mail-m12742.qiye.163.com (mail-m12742.qiye.163.com [115.236.127.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE4A4F7CBA;
	Tue, 13 Oct 2026 12:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.236.127.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791895041; cv=none; b=MSoFsnmLOlMpnn3OV+wZ1PHMkILElgOo3u57qfvHOOrjmWkBcdZTP8yv/8iCGzqOJxt3jrcWfshpj70dVTs7PM5any5rqD5LoqGS/l/HyH0rCOwXhyuiZFWnEv8fQuml8V1amjV+Lwy+cgJJo5Uok5zYi+vgMX5K536dDsq9nsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791895041; c=relaxed/simple;
	bh=1u8uo7+K0UcbXg7esArrYt2nHDPJp8PXWoswvQid4m4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bbf3ax20qtDxyNpAnjGgHpnLvJH75ttvWrLpIcoKLre9815dzxd43Q9eH91Jp2wFlaoeuAGsROjoP1LoO7G1bNK4A5CHXZKxwsbDA1ZdfunyxtIK8POrj9wJB/zGAhNbjFyPOrH80SMUthifLs3MnD9VcWBIw2iow5gzvAQ3XYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn; spf=pass smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=115.236.127.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from localhost.localdomain (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTP id 200407eee;
	Tue, 13 Oct 2026 20:21:46 +0800 (GMT+08:00)
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
Subject: [PATCH v2 3/6] mm/page_owner: add open-coded page_owner iterator
Date: Tue, 13 Oct 2026 20:21:22 +0800
Message-Id: <20261013122125.843451-4-zhen.ni@easystack.cn>
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
X-HM-Tid: 0aa1353630d00229kunm0bc94a6a5256
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDSUtLVk1CT0ofH0xKTx1IGlYVFA
	kWGhdVGRETFhoSFyQUDg9ZV1kYEgtZQVlJSkNVQk9VSkpDVUJLWVdZFhoPEhUdFFlBWU9LSFVKS0
	lPT09IVUpLS1VKQktLWQY+

Add an open-coded bpf_iter over the pages eligible for page_owner
output, reusing page_owner_next_eligible().

A sleepable BPF program drives it with
bpf_iter_page_owner_new()/next()/destroy(); each next() returns the
page_owner_scan. po_snap is copied inside the page_ext RCU window, so
the program needs no RCU section when it reads it.

Also add bpf_page_owner_stack_snprint(), which renders the stack trace
of the current page into a caller-provided buffer.

Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
---
Changes in v2:
- bpf_page_owner_stack_snprint() now takes the scan cursor.
- Buffer args renamed to buf__uninit/buf__sz.

v1: https://lore.kernel.org/linux-mm/20261009112308.240769-4-zhen.ni@easystack.cn/
---
 kernel/bpf/helpers.c |  6 +++++
 mm/page_owner_iter.c | 53 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 712dca5a2c5b..23a2d2d71f4d 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4946,6 +4946,12 @@ BTF_ID_FLAGS(func, bpf_iter_dmabuf_new, KF_ITER_NEW | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_iter_dmabuf_next, KF_ITER_NEXT | KF_RET_NULL | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_iter_dmabuf_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
 #endif
+#ifdef CONFIG_PAGE_OWNER
+BTF_ID_FLAGS(func, bpf_iter_page_owner_new, KF_ITER_NEW | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_iter_page_owner_next, KF_ITER_NEXT | KF_RET_NULL | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_iter_page_owner_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_page_owner_stack_snprint, KF_SLEEPABLE)
+#endif
 BTF_ID_FLAGS(func, __bpf_trap)
 BTF_ID_FLAGS(func, bpf_strcmp, KF_PERFMON);
 BTF_ID_FLAGS(func, bpf_strcasecmp, KF_PERFMON);
diff --git a/mm/page_owner_iter.c b/mm/page_owner_iter.c
index 938cb42ab7d7..ac7e69ba0cef 100644
--- a/mm/page_owner_iter.c
+++ b/mm/page_owner_iter.c
@@ -4,6 +4,7 @@
 #include <linux/memblock.h>
 #include <linux/mm.h>
 #include <linux/seq_file.h>
+#include <linux/stackdepot.h>
 
 #include "page_owner.h"
 
@@ -122,3 +123,55 @@ int page_owner_iter_register(void)
 
 	return bpf_iter_reg_target(&page_owner_iter_reg_info);
 }
+
+/* opaque to BPF programs */
+struct bpf_iter_page_owner {
+	__u64 __opaque[16];
+} __attribute__((aligned(8)));
+
+struct bpf_iter_page_owner_kern {
+	struct page_owner_scan scan;
+} __attribute__((aligned(8)));
+
+__bpf_kfunc_start_defs();
+
+__bpf_kfunc int bpf_iter_page_owner_new(struct bpf_iter_page_owner *it)
+{
+	struct bpf_iter_page_owner_kern *kit = (void *)it;
+
+	BUILD_BUG_ON(sizeof(*kit) > sizeof(*it));
+	BUILD_BUG_ON(__alignof__(*kit) != __alignof__(*it));
+
+	kit->scan.pfn = min_low_pfn;
+	kit->scan.page = NULL;
+	return 0;
+}
+
+__bpf_kfunc struct page_owner_scan *
+bpf_iter_page_owner_next(struct bpf_iter_page_owner *it)
+{
+	struct bpf_iter_page_owner_kern *kit = (void *)it;
+
+	cond_resched();
+
+	if (kit->scan.page)
+		kit->scan.pfn++;
+
+	if (!page_owner_next_eligible(&kit->scan))
+		return NULL;
+
+	return &kit->scan;
+}
+
+__bpf_kfunc void bpf_iter_page_owner_destroy(struct bpf_iter_page_owner *it)
+{
+}
+
+__bpf_kfunc int bpf_page_owner_stack_snprint(struct page_owner_scan *scan,
+					     char *buf__uninit, u32 buf__sz)
+{
+	return stack_depot_snprint(scan->po_snap.handle, buf__uninit, buf__sz,
+				   0);
+}
+
+__bpf_kfunc_end_defs();
-- 
2.20.1

