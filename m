Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE0BC388F7
	for <bpf@archiver.kernel.org>; Tue, 10 Nov 2020 15:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E9F3207BB
	for <bpf@archiver.kernel.org>; Tue, 10 Nov 2020 15:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="erluH06t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732494AbgKJPi0 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 10 Nov 2020 10:38:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:35832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730511AbgKJPiZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Nov 2020 10:38:25 -0500
Received: from lore-desk.redhat.com (unknown [151.66.8.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94E772076E;
        Tue, 10 Nov 2020 15:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605022705;
        bh=X/652KcX1ghKM3MixANJqmPxus5xOB2yI+S3x9cOI5M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=erluH06ti/00k0/ptayoXEN+fcs6AqTOtclphoOvVZEwPGwrCjmrqifTTX5qLNrKf
         AadxFLblNBi5v/Sc3tC/p8n9DDxyPlmfC2XiBIvO0Xfktr8tbpcSjp6kqtA7r9DHbf
         2SVeT7aQZNifIR527UqaF503VwYUs8GRHiB4lUQg=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     netdev@vger.kernel.org
Cc:     bpf@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        lorenzo.bianconi@redhat.com, brouer@redhat.com,
        ilias.apalodimas@linaro.org
Subject: [PATCH v5 net-nex 3/5] net: mvneta: add xdp tx return bulking support
Date:   Tue, 10 Nov 2020 16:37:58 +0100
Message-Id: <f148096f0dc8de7b1dd62d74698b816fa884eea4.1605020963.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605020963.git.lorenzo@kernel.org>
References: <cover.1605020963.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Convert mvneta driver to xdp_return_frame_bulk APIs.

XDP_REDIRECT (upstream codepath): 275Kpps
XDP_REDIRECT (upstream codepath + bulking APIs): 284Kpps

Co-developed-by: Jesper Dangaard Brouer <brouer@redhat.com>
Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/marvell/mvneta.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 54b0bf574c05..183530ed4d1d 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -1834,8 +1834,13 @@ static void mvneta_txq_bufs_free(struct mvneta_port *pp,
 				 struct netdev_queue *nq, bool napi)
 {
 	unsigned int bytes_compl = 0, pkts_compl = 0;
+	struct xdp_frame_bulk bq;
 	int i;
 
+	xdp_frame_bulk_init(&bq);
+
+	rcu_read_lock(); /* need for xdp_return_frame_bulk */
+
 	for (i = 0; i < num; i++) {
 		struct mvneta_tx_buf *buf = &txq->buf[txq->txq_get_index];
 		struct mvneta_tx_desc *tx_desc = txq->descs +
@@ -1857,9 +1862,12 @@ static void mvneta_txq_bufs_free(struct mvneta_port *pp,
 			if (napi && buf->type == MVNETA_TYPE_XDP_TX)
 				xdp_return_frame_rx_napi(buf->xdpf);
 			else
-				xdp_return_frame(buf->xdpf);
+				xdp_return_frame_bulk(buf->xdpf, &bq);
 		}
 	}
+	xdp_flush_frame_bulk(&bq);
+
+	rcu_read_unlock();
 
 	netdev_tx_completed_queue(nq, pkts_compl, bytes_compl);
 }
-- 
2.26.2

