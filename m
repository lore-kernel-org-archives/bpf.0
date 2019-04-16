Return-Path: <SRS0=hZ0g=SS=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E398CC10F13
	for <bpf@archiver.kernel.org>; Tue, 16 Apr 2019 12:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFEFD2086A
	for <bpf@archiver.kernel.org>; Tue, 16 Apr 2019 12:58:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729286AbfDPM6n (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 16 Apr 2019 08:58:43 -0400
Received: from mga05.intel.com ([192.55.52.43]:29568 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729295AbfDPM6m (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Apr 2019 08:58:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Apr 2019 05:58:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,357,1549958400"; 
   d="scan'208";a="292005225"
Received: from mkarlsso-mobl.ger.corp.intel.com (HELO localhost.localdomain) ([10.249.47.235])
  by orsmga004.jf.intel.com with ESMTP; 16 Apr 2019 05:58:38 -0700
From:   Magnus Karlsson <magnus.karlsson@intel.com>
To:     magnus.karlsson@intel.com, bjorn.topel@intel.com, ast@kernel.org,
        daniel@iogearbox.net, netdev@vger.kernel.org
Cc:     bpf@vger.kernel.org, bruce.richardson@intel.com,
        ciara.loftus@intel.com, ilias.apalodimas@linaro.org,
        xiaolong.ye@intel.com, ferruh.yigit@intel.com,
        qi.z.zhang@intel.com, georgmueller@gmx.net
Subject: [PATCH bpf v3 4/5] libbpf: remove dependency on barrier.h in xsk.h
Date:   Tue, 16 Apr 2019 14:58:11 +0200
Message-Id: <1555419492-16906-5-git-send-email-magnus.karlsson@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555419492-16906-1-git-send-email-magnus.karlsson@intel.com>
References: <1555419492-16906-1-git-send-email-magnus.karlsson@intel.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The use of smp_rmb() and smp_wmb() creates a Linux header dependency
on barrier.h that is unnecessary in most parts. This patch implements
the two small defines that are needed from barrier.h. As a bonus, the
new implementations are faster than the default ones as they default
to sfence and lfence for x86, while we only need a compiler barrier in
our case. Just as it is when the same ring access code is compiled in
the kernel.

Fixes: 1cad07884239 ("libbpf: add support for using AF_XDP sockets")
Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 tools/lib/bpf/libbpf_util.h | 25 +++++++++++++++++++++++++
 tools/lib/bpf/xsk.h         |  7 ++++---
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf_util.h b/tools/lib/bpf/libbpf_util.h
index 81ecda0..71fbb28 100644
--- a/tools/lib/bpf/libbpf_util.h
+++ b/tools/lib/bpf/libbpf_util.h
@@ -23,6 +23,31 @@ do {				\
 #define pr_info(fmt, ...)	__pr(LIBBPF_INFO, fmt, ##__VA_ARGS__)
 #define pr_debug(fmt, ...)	__pr(LIBBPF_DEBUG, fmt, ##__VA_ARGS__)
 
+/* Use these barrier functions instead of smp_[rw]mb() when they are
+ * used in a libbpf header file. That way they can be built into the
+ * application that uses libbpf.
+ */
+#if defined(__i386__) || defined(__x86_64__)
+# define libbpf_smp_rmb() asm volatile("" : : : "memory")
+# define libbpf_smp_wmb() asm volatile("" : : : "memory")
+# define libbpf_smp_mb() \
+	asm volatile("lock; addl $0,-4(%%rsp)" : : : "memory", "cc")
+#elif defined(__aarch64__)
+# define libbpf_smp_rmb() asm volatile("dmb ishld" : : : "memory")
+# define libbpf_smp_wmb() asm volatile("dmb ishst" : : : "memory")
+# define libbpf_smp_mb() asm volatile("dmb ish" : : : "memory")
+#elif defined(__arm__)
+/* These are only valid for armv7 and above */
+# define libbpf_smp_rmb() asm volatile("dmb ish" : : : "memory")
+# define libbpf_smp_wmb() asm volatile("dmb ishst" : : : "memory")
+# define libbpf_smp_mb() asm volatile("dmb ish" : : : "memory")
+#else
+# warning Architecture missing native barrier functions in libbpf_util.h.
+# define libbpf_smp_rmb() __sync_synchronize()
+# define libbpf_smp_wmb() __sync_synchronize()
+# define libbpf_smp_mb() __sync_synchronize()
+#endif
+
 #ifdef __cplusplus
 } /* extern "C" */
 #endif
diff --git a/tools/lib/bpf/xsk.h b/tools/lib/bpf/xsk.h
index f264f24..2377c7a 100644
--- a/tools/lib/bpf/xsk.h
+++ b/tools/lib/bpf/xsk.h
@@ -16,6 +16,7 @@
 #include <linux/if_xdp.h>
 
 #include "libbpf.h"
+#include "libbpf_util.h"
 
 #ifdef __cplusplus
 extern "C" {
@@ -123,7 +124,7 @@ static inline void xsk_ring_prod__submit(struct xsk_ring_prod *prod, size_t nb)
 	/* Make sure everything has been written to the ring before indicating
 	 * this to the kernel by writing the producer pointer.
 	 */
-	smp_wmb();
+	libbpf_smp_wmb();
 
 	*prod->producer += nb;
 }
@@ -137,7 +138,7 @@ static inline size_t xsk_ring_cons__peek(struct xsk_ring_cons *cons,
 		/* Make sure we do not speculatively read the data before
 		 * we have received the packet buffers from the ring.
 		 */
-		smp_rmb();
+		libbpf_smp_rmb();
 
 		*idx = cons->cached_cons;
 		cons->cached_cons += entries;
@@ -151,7 +152,7 @@ static inline void xsk_ring_cons__release(struct xsk_ring_cons *cons, size_t nb)
 	/* Make sure data has been read before indicating we are done
 	 * with the entries by updating the consumer pointer.
 	 */
-	smp_mb();
+	libbpf_smp_mb();
 
 	*cons->consumer += nb;
 }
-- 
2.7.4

