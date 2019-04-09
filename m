Return-Path: <SRS0=Zphp=SL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D131EC282DA
	for <bpf@archiver.kernel.org>; Tue,  9 Apr 2019 06:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFF9220818
	for <bpf@archiver.kernel.org>; Tue,  9 Apr 2019 06:44:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfDIGos (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 9 Apr 2019 02:44:48 -0400
Received: from mga04.intel.com ([192.55.52.120]:18780 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726372AbfDIGos (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Apr 2019 02:44:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Apr 2019 23:44:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,328,1549958400"; 
   d="scan'208";a="289943844"
Received: from mkarlsso-mobl.ger.corp.intel.com (HELO VM.isw.intel.com) ([10.103.211.40])
  by orsmga004.jf.intel.com with ESMTP; 08 Apr 2019 23:44:43 -0700
From:   Magnus Karlsson <magnus.karlsson@intel.com>
To:     magnus.karlsson@intel.com, bjorn.topel@intel.com, ast@kernel.org,
        daniel@iogearbox.net, netdev@vger.kernel.org
Cc:     bpf@vger.kernel.org, bruce.richardson@intel.com,
        ciara.loftus@intel.com, ilias.apalodimas@linaro.org,
        xiaolong.ye@intel.com, ferruh.yigit@intel.com,
        qi.z.zhang@intel.com, georgmueller@gmx.net
Subject: [PATCH bpf 2/2] libbpf: remove dependency on barrier.h in xsk.h
Date:   Tue,  9 Apr 2019 08:44:13 +0200
Message-Id: <1554792253-27081-3-git-send-email-magnus.karlsson@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554792253-27081-1-git-send-email-magnus.karlsson@intel.com>
References: <1554792253-27081-1-git-send-email-magnus.karlsson@intel.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The use of smp_rmb() and smp_wmb() creates a Linux header dependency
on barrier.h that is uneccessary in most parts. This patch implements
the two small defines that are needed from barrier.h. As a bonus, the
new implementations are faster than the default ones as they default
to sfence and lfence for x86, while we only need a compiler barrier in
our case. Just as it is when the same ring access code is compiled in
the kernel.

Fixes: 1cad07884239 ("libbpf: add support for using AF_XDP sockets")
Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 tools/lib/bpf/xsk.h | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/xsk.h b/tools/lib/bpf/xsk.h
index 3638147..317b44f 100644
--- a/tools/lib/bpf/xsk.h
+++ b/tools/lib/bpf/xsk.h
@@ -39,6 +39,21 @@ DEFINE_XSK_RING(xsk_ring_cons);
 struct xsk_umem;
 struct xsk_socket;
 
+#if !defined bpf_smp_rmb && !defined bpf_smp_wmb
+# if defined(__i386__) || defined(__x86_64__)
+#  define bpf_smp_rmb() asm volatile("" : : : "memory")
+#  define bpf_smp_wmb() asm volatile("" : : : "memory")
+# elif defined(__aarch64__)
+#  define bpf_smp_rmb() asm volatile("dmb ishld" : : : "memory")
+#  define bpf_smp_wmb() asm volatile("dmb ishst" : : : "memory")
+# elif defined(__arm__)
+#  define bpf_smp_rmb() asm volatile("dmb ish" : : : "memory")
+#  define bpf_smp_wmb() asm volatile("dmb ishst" : : : "memory")
+# else
+#  error Architecture not supported by the XDP socket code in libbpf.
+# endif
+#endif
+
 static inline __u64 *xsk_ring_prod__fill_addr(struct xsk_ring_prod *fill,
 					      __u32 idx)
 {
@@ -119,7 +134,7 @@ static inline void xsk_ring_prod__submit(struct xsk_ring_prod *prod, size_t nb)
 	/* Make sure everything has been written to the ring before signalling
 	 * this to the kernel.
 	 */
-	smp_wmb();
+	bpf_smp_wmb();
 
 	*prod->producer += nb;
 }
@@ -133,7 +148,7 @@ static inline size_t xsk_ring_cons__peek(struct xsk_ring_cons *cons,
 		/* Make sure we do not speculatively read the data before
 		 * we have received the packet buffers from the ring.
 		 */
-		smp_rmb();
+		bpf_smp_rmb();
 
 		*idx = cons->cached_cons;
 		cons->cached_cons += entries;
-- 
2.7.4

