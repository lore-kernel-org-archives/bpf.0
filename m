Return-Path: <SRS0=hZ0g=SS=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79828C10F13
	for <bpf@archiver.kernel.org>; Tue, 16 Apr 2019 12:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2451420693
	for <bpf@archiver.kernel.org>; Tue, 16 Apr 2019 12:58:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbfDPM6e (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 16 Apr 2019 08:58:34 -0400
Received: from mga05.intel.com ([192.55.52.43]:29568 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727691AbfDPM6e (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Apr 2019 08:58:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Apr 2019 05:58:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,357,1549958400"; 
   d="scan'208";a="292005184"
Received: from mkarlsso-mobl.ger.corp.intel.com (HELO localhost.localdomain) ([10.249.47.235])
  by orsmga004.jf.intel.com with ESMTP; 16 Apr 2019 05:58:30 -0700
From:   Magnus Karlsson <magnus.karlsson@intel.com>
To:     magnus.karlsson@intel.com, bjorn.topel@intel.com, ast@kernel.org,
        daniel@iogearbox.net, netdev@vger.kernel.org
Cc:     bpf@vger.kernel.org, bruce.richardson@intel.com,
        ciara.loftus@intel.com, ilias.apalodimas@linaro.org,
        xiaolong.ye@intel.com, ferruh.yigit@intel.com,
        qi.z.zhang@intel.com, georgmueller@gmx.net
Subject: [PATCH bpf v3 2/5] libbpf: fix XDP socket ring buffer memory ordering
Date:   Tue, 16 Apr 2019 14:58:09 +0200
Message-Id: <1555419492-16906-3-git-send-email-magnus.karlsson@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555419492-16906-1-git-send-email-magnus.karlsson@intel.com>
References: <1555419492-16906-1-git-send-email-magnus.karlsson@intel.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The ring buffer code of	XDP sockets is missing a memory	barrier	on the
consumer side between the load of the data and the write that signals
that it is ok for the producer to put new data into the buffer. On
architectures that does not guarantee that stores are not reordered
with older loads, the producer might put data into the ring before the
consumer had the chance to read it. As IA does guarantee this
ordering, it would only need a compiler barrier here, but there are no
primitives in barrier.h for this specific case (hinder writes to be ordered
before older reads) so I had to add a smp_mb() here which will
translate into a run-time synch operation on IA.

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 tools/lib/bpf/xsk.h | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/xsk.h b/tools/lib/bpf/xsk.h
index a497f00..1b35c40 100644
--- a/tools/lib/bpf/xsk.h
+++ b/tools/lib/bpf/xsk.h
@@ -36,6 +36,10 @@ struct name { \
 DEFINE_XSK_RING(xsk_ring_prod);
 DEFINE_XSK_RING(xsk_ring_cons);
 
+/* For a detailed explanation on the memory barriers associated with the
+ * ring, please take a look at net/xdp/xsk_queue.h.
+ */
+
 struct xsk_umem;
 struct xsk_socket;
 
@@ -116,8 +120,8 @@ static inline size_t xsk_ring_prod__reserve(struct xsk_ring_prod *prod,
 
 static inline void xsk_ring_prod__submit(struct xsk_ring_prod *prod, size_t nb)
 {
-	/* Make sure everything has been written to the ring before signalling
-	 * this to the kernel.
+	/* Make sure everything has been written to the ring before indicating
+	 * this to the kernel by writing the producer pointer.
 	 */
 	smp_wmb();
 
@@ -144,6 +148,11 @@ static inline size_t xsk_ring_cons__peek(struct xsk_ring_cons *cons,
 
 static inline void xsk_ring_cons__release(struct xsk_ring_cons *cons, size_t nb)
 {
+	/* Make sure data has been read before indicating we are done
+	 * with the entries by updating the consumer pointer.
+	 */
+	smp_mb();
+
 	*cons->consumer += nb;
 }
 
-- 
2.7.4

