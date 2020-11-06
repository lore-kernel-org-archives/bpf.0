Return-Path: <SRS0=kVCt=EM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450ABC388F2
	for <bpf@archiver.kernel.org>; Fri,  6 Nov 2020 18:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2CCB221FA
	for <bpf@archiver.kernel.org>; Fri,  6 Nov 2020 18:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604686780;
	bh=XG8zM2QinAMBZxdequKTMs22iF+bNdCsH09LFY9ExeE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jz+jiPXpLfJ2xZ+rWb5ieuoDv0IDttUoOnuOlT6Lj9duVHgCg+Pb4zxW7atrpnMwj
	 MRr/opIX5b7Hvpc99MXrbcWW3nYdDNALi+Xs1u0LfJrjjIk1Owa9AQ7CBf4tOQkcgh
	 yXWx/ah2mOGE9SuGdEs9L9eHXHUzcYO3cw9w2N2c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbgKFSTg (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 6 Nov 2020 13:19:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:41220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727791AbgKFSTg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Nov 2020 13:19:36 -0500
Received: from localhost.localdomain (unknown [151.66.8.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B1AD208FE;
        Fri,  6 Nov 2020 18:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604686776;
        bh=XG8zM2QinAMBZxdequKTMs22iF+bNdCsH09LFY9ExeE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iVgSqXweKcT6tvnN/KF+dxg/JYvspuLZvbn4VKYIbPAYCagQbL1k2/yob83UWjT2q
         5Goxe196h81CgMftKPFR5UBLMUzJtP/GRK+4WQMZWPbl505ow/nM3P2bc7N/yHBRko
         cLhtRkR+wC6j60IiNTS9XbkyJqr6dA2goq6wRvPo=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     netdev@vger.kernel.org
Cc:     bpf@vger.kernel.org, lorenzo.bianconi@redhat.com,
        davem@davemloft.net, kuba@kernel.org, brouer@redhat.com,
        ilias.apalodimas@linaro.org
Subject: [PATCH v4 net-next 3/5] net: mvneta: add xdp tx return bulking support
Date:   Fri,  6 Nov 2020 19:19:09 +0100
Message-Id: <c2242f62260b90d5961d6587cdcad067d891ad31.1604686496.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1604686496.git.lorenzo@kernel.org>
References: <cover.1604686496.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Convert mvneta driver to xdp_return_frame_bulk APIs.

XDP_REDIRECT (upstream codepath): 275Kpps
XDP_REDIRECT (upstream codepath + bulking APIs): 284Kpps

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/marvell/mvneta.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 54b0bf574c05..43ab8a73900e 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -1834,8 +1834,10 @@ static void mvneta_txq_bufs_free(struct mvneta_port *pp,
 				 struct netdev_queue *nq, bool napi)
 {
 	unsigned int bytes_compl = 0, pkts_compl = 0;
+	struct xdp_frame_bulk bq;
 	int i;
 
+	bq.xa = NULL;
 	for (i = 0; i < num; i++) {
 		struct mvneta_tx_buf *buf = &txq->buf[txq->txq_get_index];
 		struct mvneta_tx_desc *tx_desc = txq->descs +
@@ -1857,9 +1859,10 @@ static void mvneta_txq_bufs_free(struct mvneta_port *pp,
 			if (napi && buf->type == MVNETA_TYPE_XDP_TX)
 				xdp_return_frame_rx_napi(buf->xdpf);
 			else
-				xdp_return_frame(buf->xdpf);
+				xdp_return_frame_bulk(buf->xdpf, &bq);
 		}
 	}
+	xdp_flush_frame_bulk(&bq);
 
 	netdev_tx_completed_queue(nq, pkts_compl, bytes_compl);
 }
-- 
2.26.2

