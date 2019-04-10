Return-Path: <SRS0=J20p=SM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA13C10F14
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 07:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E4DD20850
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 07:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbfDJHJ2 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 10 Apr 2019 03:09:28 -0400
Received: from mga06.intel.com ([134.134.136.31]:54211 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725909AbfDJHJ1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Apr 2019 03:09:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Apr 2019 00:09:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,332,1549958400"; 
   d="scan'208";a="290256235"
Received: from mkarlsso-mobl.ger.corp.intel.com (HELO VM.isw.intel.com) ([10.103.211.40])
  by orsmga004.jf.intel.com with ESMTP; 10 Apr 2019 00:09:22 -0700
From:   Magnus Karlsson <magnus.karlsson@intel.com>
To:     magnus.karlsson@intel.com, bjorn.topel@intel.com, ast@kernel.org,
        daniel@iogearbox.net, netdev@vger.kernel.org
Cc:     bpf@vger.kernel.org, bruce.richardson@intel.com,
        ciara.loftus@intel.com, ilias.apalodimas@linaro.org,
        xiaolong.ye@intel.com, ferruh.yigit@intel.com,
        qi.z.zhang@intel.com, georgmueller@gmx.net
Subject: [PATCH bpf v2 1/2] libbpf: remove likely/unlikely in xsk.h
Date:   Wed, 10 Apr 2019 09:09:13 +0200
Message-Id: <1554880154-30791-2-git-send-email-magnus.karlsson@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554880154-30791-1-git-send-email-magnus.karlsson@intel.com>
References: <1554880154-30791-1-git-send-email-magnus.karlsson@intel.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch removes the use of likely and unlikely in xsk.h since they
create a dependency on Linux headers as reported by several
users. There have also been reports that the use of these decreases
performance as the compiler puts the code on two different cache lines
instead of on a single one. All in all, I think we are better off
without them.

Fixes: 1cad07884239 ("libbpf: add support for using AF_XDP sockets")
Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 tools/lib/bpf/xsk.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/xsk.h b/tools/lib/bpf/xsk.h
index a497f00..3638147 100644
--- a/tools/lib/bpf/xsk.h
+++ b/tools/lib/bpf/xsk.h
@@ -105,7 +105,7 @@ static inline __u32 xsk_cons_nb_avail(struct xsk_ring_cons *r, __u32 nb)
 static inline size_t xsk_ring_prod__reserve(struct xsk_ring_prod *prod,
 					    size_t nb, __u32 *idx)
 {
-	if (unlikely(xsk_prod_nb_free(prod, nb) < nb))
+	if (xsk_prod_nb_free(prod, nb) < nb)
 		return 0;
 
 	*idx = prod->cached_prod;
@@ -129,7 +129,7 @@ static inline size_t xsk_ring_cons__peek(struct xsk_ring_cons *cons,
 {
 	size_t entries = xsk_cons_nb_avail(cons, nb);
 
-	if (likely(entries > 0)) {
+	if (entries > 0) {
 		/* Make sure we do not speculatively read the data before
 		 * we have received the packet buffers from the ring.
 		 */
-- 
2.7.4

