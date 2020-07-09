Return-Path: <SRS0=tFjc=AU=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA6D4C433E1
	for <bpf@archiver.kernel.org>; Thu,  9 Jul 2020 15:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C50CC207DD
	for <bpf@archiver.kernel.org>; Thu,  9 Jul 2020 15:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594310264;
	bh=HCgs3d7gFvxgioFwPARkJIuMDzU61lJ3fi1pS1aBRfg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RilPxmCv/hxFUjHr/BIDunptp9dbWtaL/503o+kbPVw+opjXauUJ2vX/Y93uAAoaX
	 vky5qSGz+BS9v6RNLlglaFJMyTv7X9+1H2N4ePixGeXJU3hSS+JMabdhQ6ttEaqnXy
	 JcCXw6mrbezL7R/Q13O3aIRrfH4T3bH4+lbGkytM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbgGIP5o (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 9 Jul 2020 11:57:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:50618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbgGIP5n (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Jul 2020 11:57:43 -0400
Received: from localhost.localdomain.com (unknown [151.48.133.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 364AF207DA;
        Thu,  9 Jul 2020 15:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594310263;
        bh=HCgs3d7gFvxgioFwPARkJIuMDzU61lJ3fi1pS1aBRfg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=12DUz1qQV+/HQnjyMPPWXPrQbmVhfkLTPUGyAxGTOTvKkjYXw0gKs2gIA+M3zppzn
         ci0FkZ3WnQeR+qw7Hb2bQwvl1mm8bev1KcZbLPBKyajLTGjhO80x1JC79t0HvdjTvb
         NCbyStY0nvJtK+wVXvi+pOa/mYAlzZSqH6vUhSco=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, bpf@vger.kernel.org, kuba@kernel.org,
        ilias.apalodimas@linaro.org, lorenzo.bianconi@redhat.com,
        brouer@redhat.com, echaudro@redhat.com, sameehj@amazon.com
Subject: [PATCH 3/6] net: mvneta: move mvneta_run_xdp after descriptors processing
Date:   Thu,  9 Jul 2020 17:57:20 +0200
Message-Id: <bd4a08120070f246daa09fa811c832cb77f7c75d.1594309075.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1594309075.git.lorenzo@kernel.org>
References: <cover.1594309075.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Move mvneta_run_xdp routine after all descriptor processing. This is a
preliminary patch to enable multi-buffers and JUMBO frames support for
XDP

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/marvell/mvneta.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 678f90ccf271..fbf88e524210 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -2231,12 +2231,11 @@ mvneta_run_xdp(struct mvneta_port *pp, struct mvneta_rx_queue *rxq,
 	return ret;
 }
 
-static int
+static void
 mvneta_swbm_rx_frame(struct mvneta_port *pp,
 		     struct mvneta_rx_desc *rx_desc,
 		     struct mvneta_rx_queue *rxq,
 		     struct xdp_buff *xdp,
-		     struct bpf_prog *xdp_prog,
 		     struct page *page,
 		     struct mvneta_stats *stats)
 {
@@ -2245,7 +2244,6 @@ mvneta_swbm_rx_frame(struct mvneta_port *pp,
 	struct net_device *dev = pp->dev;
 	enum dma_data_direction dma_dir;
 	struct skb_shared_info *sinfo;
-	int ret = 0;
 
 	if (MVNETA_SKB_SIZE(rx_desc->data_size) > PAGE_SIZE) {
 		len = MVNETA_MAX_RX_BUF_SIZE;
@@ -2271,13 +2269,8 @@ mvneta_swbm_rx_frame(struct mvneta_port *pp,
 	sinfo = xdp_get_shared_info_from_buff(xdp);
 	sinfo->nr_frags = 0;
 
-	if (xdp_prog)
-		ret = mvneta_run_xdp(pp, rxq, xdp_prog, xdp, stats);
-
 	rxq->left_size = rx_desc->data_size - len;
 	rx_desc->buf_phys_addr = 0;
-
-	return ret;
 }
 
 static void
@@ -2384,20 +2377,15 @@ static int mvneta_rx_swbm(struct napi_struct *napi,
 		rxq->refill_num++;
 
 		if (rx_status & MVNETA_RXD_FIRST_DESC) {
-			int err;
-
 			/* Check errors only for FIRST descriptor */
 			if (rx_status & MVNETA_RXD_ERR_SUMMARY) {
 				mvneta_rx_error(pp, rx_desc);
 				goto next;
 			}
 
-			err = mvneta_swbm_rx_frame(pp, rx_desc, rxq, &xdp_buf,
-						   xdp_prog, page, &ps);
-			if (err)
-				continue;
-
 			desc_status = rx_desc->status;
+			mvneta_swbm_rx_frame(pp, rx_desc, rxq, &xdp_buf, page,
+					     &ps);
 		} else {
 			if (unlikely(!xdp_buf.data_hard_start))
 				continue;
@@ -2416,6 +2404,10 @@ static int mvneta_rx_swbm(struct napi_struct *napi,
 			goto next;
 		}
 
+		if (xdp_prog &&
+		    mvneta_run_xdp(pp, rxq, xdp_prog, &xdp_buf, &ps))
+			goto next;
+
 		skb = mvneta_swbm_build_skb(pp, rxq, &xdp_buf, desc_status);
 		if (IS_ERR(skb)) {
 			struct mvneta_pcpu_stats *stats = this_cpu_ptr(pp->stats);
-- 
2.26.2

