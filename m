Return-Path: <SRS0=pSPe=EC=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD24C4363A
	for <bpf@archiver.kernel.org>; Tue, 27 Oct 2020 19:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8720B21D24
	for <bpf@archiver.kernel.org>; Tue, 27 Oct 2020 19:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603825468;
	bh=CEqASvpURooVyTo2fuJKqWW0pHRASjrmZUlThXYDT4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q4jOQenx3A7jBNisvoYLNXM/o+Kom8aniHyJojAEVN0s0Dh4LQNz/7mXcc16oSqA1
	 Vk/CPg8BuueklQGPH9KWPJfjgeZrgB4HT72e3Idr3T6YXDAi1gteeXN2aV+NZ93wRL
	 MSbGIS9ABBdt5f0eGoXTFSL2XdhSAh/Tvpj1Nd7g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1829315AbgJ0TE1 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 27 Oct 2020 15:04:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:41924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1829312AbgJ0TE0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Oct 2020 15:04:26 -0400
Received: from lore-desk.redhat.com (unknown [151.66.125.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D51A0206D4;
        Tue, 27 Oct 2020 19:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603825466;
        bh=CEqASvpURooVyTo2fuJKqWW0pHRASjrmZUlThXYDT4w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q4DW2tArOkAsyjerl+wTBg9RkhnSGoAE2t5pymuWCI//0u9DCw2YuHcUSXKvGK3Eo
         NkjG+UAn7UrAvf4inii5AUHb07XecTye1VQIJR6uTUtowk7fW9oyPgl0kwh6hTcQ/K
         1hSpQd58KOjQoby3389e5oHAa3RN3hy+vxPvwKxM=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     netdev@vger.kernel.org
Cc:     bpf@vger.kernel.org, lorenzo.bianconi@redhat.com,
        davem@davemloft.net, kuba@kernel.org, brouer@redhat.com,
        ilias.apalodimas@linaro.org
Subject: [PATCH net-next 3/4] net: mvpp2: add xdp tx return bulking support
Date:   Tue, 27 Oct 2020 20:04:09 +0100
Message-Id: <ea0343b52e83dd46a5082383aa59b9ea4d67a4e4.1603824486.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603824486.git.lorenzo@kernel.org>
References: <cover.1603824486.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Convert mvpp2 driver to xdp_return_frame_bulk APIs.

XDP_REDIRECT (upstream codepath): 1.79Mpps
XDP_REDIRECT (upstream codepath + bulking APIs): 1.93Mpps

Tested-by: Matteo Croce <mcroce@microsoft.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index f6616c8933ca..04f24d1d72ab 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -2440,8 +2440,10 @@ static void mvpp2_txq_bufs_free(struct mvpp2_port *port,
 				struct mvpp2_tx_queue *txq,
 				struct mvpp2_txq_pcpu *txq_pcpu, int num)
 {
+	struct xdp_frame_bulk bq;
 	int i;
 
+	bq.xa = NULL;
 	for (i = 0; i < num; i++) {
 		struct mvpp2_txq_pcpu_buf *tx_buf =
 			txq_pcpu->buffs + txq_pcpu->txq_get_index;
@@ -2454,10 +2456,11 @@ static void mvpp2_txq_bufs_free(struct mvpp2_port *port,
 			dev_kfree_skb_any(tx_buf->skb);
 		else if (tx_buf->type == MVPP2_TYPE_XDP_TX ||
 			 tx_buf->type == MVPP2_TYPE_XDP_NDO)
-			xdp_return_frame(tx_buf->xdpf);
+			xdp_return_frame_bulk(tx_buf->xdpf, &bq);
 
 		mvpp2_txq_inc_get(txq_pcpu);
 	}
+	xdp_flush_frame_bulk(&bq);
 }
 
 static inline struct mvpp2_rx_queue *mvpp2_get_rx_queue(struct mvpp2_port *port,
-- 
2.26.2

