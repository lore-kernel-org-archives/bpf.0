Return-Path: <SRS0=hZ0g=SS=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A6BC10F14
	for <bpf@archiver.kernel.org>; Tue, 16 Apr 2019 12:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BC3F20693
	for <bpf@archiver.kernel.org>; Tue, 16 Apr 2019 12:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbfDPM6r (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 16 Apr 2019 08:58:47 -0400
Received: from mga05.intel.com ([192.55.52.43]:29568 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727240AbfDPM6q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Apr 2019 08:58:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Apr 2019 05:58:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,357,1549958400"; 
   d="scan'208";a="292005246"
Received: from mkarlsso-mobl.ger.corp.intel.com (HELO localhost.localdomain) ([10.249.47.235])
  by orsmga004.jf.intel.com with ESMTP; 16 Apr 2019 05:58:42 -0700
From:   Magnus Karlsson <magnus.karlsson@intel.com>
To:     magnus.karlsson@intel.com, bjorn.topel@intel.com, ast@kernel.org,
        daniel@iogearbox.net, netdev@vger.kernel.org
Cc:     bpf@vger.kernel.org, bruce.richardson@intel.com,
        ciara.loftus@intel.com, ilias.apalodimas@linaro.org,
        xiaolong.ye@intel.com, ferruh.yigit@intel.com,
        qi.z.zhang@intel.com, georgmueller@gmx.net
Subject: [PATCH bpf v3 5/5] libbpf: optimize barrier for XDP socket rings
Date:   Tue, 16 Apr 2019 14:58:12 +0200
Message-Id: <1555419492-16906-6-git-send-email-magnus.karlsson@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555419492-16906-1-git-send-email-magnus.karlsson@intel.com>
References: <1555419492-16906-1-git-send-email-magnus.karlsson@intel.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The full memory barrier in the XDP socket rings on the consumer side
between the load of the data and the store of the consumer ring is
there to protect the store from being executed before the load of the
data. If this was allowed to happen, the producer might overwrite the
data field with a new entry before the consumer got the chance to read
it.

On x86, stores are guaranteed not to be reordered with older loads, so
it does not need a full memory barrier here. A compile time barrier
would be enough. This patch introdcues a new primitive in
libbpf_util.h that implements a new barrier type (libbpf_smp_rwmb)
hindering stores to be reordered with older loads. It is then used in
the XDP socket ring access code in libbpf to improve performance.

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 tools/lib/bpf/libbpf_util.h | 5 +++++
 tools/lib/bpf/xsk.h         | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf_util.h b/tools/lib/bpf/libbpf_util.h
index 71fbb28..172b707e 100644
--- a/tools/lib/bpf/libbpf_util.h
+++ b/tools/lib/bpf/libbpf_util.h
@@ -32,20 +32,25 @@ do {				\
 # define libbpf_smp_wmb() asm volatile("" : : : "memory")
 # define libbpf_smp_mb() \
 	asm volatile("lock; addl $0,-4(%%rsp)" : : : "memory", "cc")
+/* Hinders stores to be observed before older loads. */
+# define libbpf_smp_rwmb() asm volatile("" : : : "memory")
 #elif defined(__aarch64__)
 # define libbpf_smp_rmb() asm volatile("dmb ishld" : : : "memory")
 # define libbpf_smp_wmb() asm volatile("dmb ishst" : : : "memory")
 # define libbpf_smp_mb() asm volatile("dmb ish" : : : "memory")
+# define libbpf_smp_rwmb() libbpf_smp_mb()
 #elif defined(__arm__)
 /* These are only valid for armv7 and above */
 # define libbpf_smp_rmb() asm volatile("dmb ish" : : : "memory")
 # define libbpf_smp_wmb() asm volatile("dmb ishst" : : : "memory")
 # define libbpf_smp_mb() asm volatile("dmb ish" : : : "memory")
+# define libbpf_smp_rwmb() libbpf_smp_mb()
 #else
 # warning Architecture missing native barrier functions in libbpf_util.h.
 # define libbpf_smp_rmb() __sync_synchronize()
 # define libbpf_smp_wmb() __sync_synchronize()
 # define libbpf_smp_mb() __sync_synchronize()
+# define libbpf_smp_rwmb() __sync_synchronize()
 #endif
 
 #ifdef __cplusplus
diff --git a/tools/lib/bpf/xsk.h b/tools/lib/bpf/xsk.h
index 2377c7a..82ea71a 100644
--- a/tools/lib/bpf/xsk.h
+++ b/tools/lib/bpf/xsk.h
@@ -152,7 +152,7 @@ static inline void xsk_ring_cons__release(struct xsk_ring_cons *cons, size_t nb)
 	/* Make sure data has been read before indicating we are done
 	 * with the entries by updating the consumer pointer.
 	 */
-	libbpf_smp_mb();
+	libbpf_smp_rwmb();
 
 	*cons->consumer += nb;
 }
-- 
2.7.4

