Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.129.254.92
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792581904;
	b=V7eoQiWGz2pZpzmg/ZjLrWXtmNMlhUlThb6hzbtYgzEypp1N660A3HEZJ7yhlNJCSY5r
	 pphiZzIPq9ybDDiqUggP4J9vRiHxUsFvNUESo2OczXOeNTRwcyKwHXcOmzylat32ORCPi
	 izA3z0M5c2yFdAITyAXuQR0fJuA+4vaeWffu+cT4phuvKy0K+AgbPIUoVK0lcqz+OfExk
	 QomhjRSijuOFlhrs7FvpIT+Nbk7mBg7JGiSFB/4BSX8QhvhmBNRi33l/Tjjo2TLeEo9kZ
	 93T8EwD79AX7065IG5g010zqP5q5lii4y39wwjhdniQN5DdwDHO1L9jLnO5jPXcga7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792581904;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-HM-Tid:X-HM-MType:X-HM-Spam-Status;
	bh=EPDlZMTSTVQ5eCE68sbvYSTGTpxshvufAloZkiCKtC0=;
	b=3ZNJTS7U++rMcG4aiS918xAqt3GUsuPGfaZVX7QVx2JwvFJc8I67ng9hkcX5cQPJvbpq
	 wdZ435yj2d+Dy2NZYk/V7ZaLZjAcyTlA0IosE0k2mQ9L9euohp8S7cSXbVBmIZTtd+HHA
	 0PtgWUsjqxpMMQUMXvoZI+mgfQOol25KnJXgWmLJ+R7AgLwuqZsH8DKICqA9R6S/qg+gj
	 /psa2+s1xVqPwMAXsrMpHag8j98fWuKDmfmDxVLstNFCMAGZeVqhpzF1bUyfx3kUkQvYy
	 PRqQUpQydgiTDqqRPYUUv4b8k14S4ZI1/Op+Hv9bOEhv+hkc0TDRU12A+h20ZswpNmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=easystack.cn;
	spf=pass smtp.mailfrom=easystack.cn;
	arc=none smtp.remote-ip=103.129.254.92
Received: from mail-m25492.xmail.ntesmail.com (mail-m25492.xmail.ntesmail.com [103.129.254.92])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5F8606A330;
	Wed, 21 Oct 2026 11:25:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C5F8606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from localhost.localdomain (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTP id 204f151ab;
	Wed, 21 Oct 2026 19:24:53 +0800 (GMT+08:00)
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
Subject: [PATCH v3 4/7] mm/page_owner: add open-coded page_owner iterator
Date: Wed, 21 Oct 2026 19:24:34 +0800
Message-Id: <20261021112437.1799213-5-zhen.ni@easystack.cn>
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
X-HM-Tid: 0aa15e34fe6f0229kunme08c1fd526ace2
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCSkNMVk9KT0JPSk5NGB5CT1YVFA
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
Changes in v3:
- Gate the kfuncs with KF_PERFMON.
- Check the page_owner_inited static key in the iterator.
- Without scan->page, start at min_low_pfn - 1 and let next() pre-increment.
- bpf_page_owner_stack_snprint() rejects a NULL or zero-size buffer.

Changes in v2:
- bpf_page_owner_stack_snprint() now takes the scan cursor.
- Buffer args renamed to buf__uninit/buf__sz.

v2: https://lore.kernel.org/linux-mm/20261013122125.843451-4-zhen.ni@easystack.cn/
v1: https://lore.kernel.org/linux-mm/20261009112308.240769-4-zhen.ni@easystack.cn/
---
 kernel/bpf/helpers.c |  9 +++++++
 mm/page_owner.h      |  3 +++
 mm/page_owner_iter.c | 64 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 76 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 712dca5a2c5b..0ba836f77957 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4946,6 +4946,15 @@ BTF_ID_FLAGS(func, bpf_iter_dmabuf_new, KF_ITER_NEW | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_iter_dmabuf_next, KF_ITER_NEXT | KF_RET_NULL | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_iter_dmabuf_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
 #endif
+#ifdef CONFIG_PAGE_OWNER
+BTF_ID_FLAGS(func, bpf_iter_page_owner_new,
+	     KF_ITER_NEW | KF_SLEEPABLE | KF_PERFMON)
+BTF_ID_FLAGS(func, bpf_iter_page_owner_next,
+	     KF_ITER_NEXT | KF_RET_NULL | KF_SLEEPABLE | KF_PERFMON)
+BTF_ID_FLAGS(func, bpf_iter_page_owner_destroy,
+	     KF_ITER_DESTROY | KF_SLEEPABLE | KF_PERFMON)
+BTF_ID_FLAGS(func, bpf_page_owner_stack_snprint, KF_SLEEPABLE | KF_PERFMON)
+#endif
 BTF_ID_FLAGS(func, __bpf_trap)
 BTF_ID_FLAGS(func, bpf_strcmp, KF_PERFMON);
 BTF_ID_FLAGS(func, bpf_strcasecmp, KF_PERFMON);
diff --git a/mm/page_owner.h b/mm/page_owner.h
index 0aa7695bec82..4ab513f17fc9 100644
--- a/mm/page_owner.h
+++ b/mm/page_owner.h
@@ -6,6 +6,7 @@
 #ifndef __MM_PAGE_OWNER_H
 #define __MM_PAGE_OWNER_H
 
+#include <linux/jump_label.h>
 #include <linux/page_ext.h>
 #include <linux/sched.h>
 #include <linux/stackdepot.h>
@@ -13,6 +14,8 @@
 /*
  * mm/page_owner.c
  */
+DECLARE_STATIC_KEY_FALSE(page_owner_inited);
+
 struct page_owner {
 	unsigned short order;
 	short last_migrate_reason;
diff --git a/mm/page_owner_iter.c b/mm/page_owner_iter.c
index 529b2c4a589a..4b9741a2de53 100644
--- a/mm/page_owner_iter.c
+++ b/mm/page_owner_iter.c
@@ -4,6 +4,7 @@
 #include <linux/memblock.h>
 #include <linux/mm.h>
 #include <linux/seq_file.h>
+#include <linux/stackdepot.h>
 
 #include "page_owner.h"
 
@@ -116,3 +117,66 @@ int page_owner_iter_register(void)
 
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
+	kit->scan.pfn = min_low_pfn - 1;
+	return 0;
+}
+
+__bpf_kfunc struct page_owner_scan *
+bpf_iter_page_owner_next(struct bpf_iter_page_owner *it)
+{
+	struct bpf_iter_page_owner_kern *kit = (void *)it;
+
+	if (!static_branch_unlikely(&page_owner_inited))
+		return NULL;
+
+	cond_resched();
+
+	kit->scan.pfn++;
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
+	int len = 0;
+
+	if (!buf__uninit || !buf__sz)
+		return 0;
+
+	if (static_branch_unlikely(&page_owner_inited))
+		len = stack_depot_snprint(scan->po_snap.handle, buf__uninit,
+					  buf__sz, 0);
+
+	if (!len)
+		buf__uninit[0] = '\0';
+
+	return len;
+}
+
+__bpf_kfunc_end_defs();
-- 
2.20.1

