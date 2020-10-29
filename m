Return-Path: <SRS0=L8C4=EE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D003C2D0A3
	for <bpf@archiver.kernel.org>; Thu, 29 Oct 2020 19:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2598820782
	for <bpf@archiver.kernel.org>; Thu, 29 Oct 2020 19:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603999794;
	bh=2T02Rnj9JSqlSyqTOWwETG3CNvYOciUI7owaOFmtoLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZQo6Uwu0XI3Qi1ILTj0g7pmYQIYsJ3fe08ewejOufFy/TABXc0WYF8KU7iWQcsuzj
	 7em026cokoqfT5AHb1oxDkUL+HVakUgCtI/xRiDoanTouiDivRLVha6NB7X85vUGEe
	 qxJIscAWGjWFKd40/lhyIX5Y5F0bNobjkX2fZK7o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbgJ2T3s (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 29 Oct 2020 15:29:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:51524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbgJ2T3c (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Oct 2020 15:29:32 -0400
Received: from lore-desk.redhat.com (unknown [151.66.29.159])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65BEF20825;
        Thu, 29 Oct 2020 19:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603999749;
        bh=2T02Rnj9JSqlSyqTOWwETG3CNvYOciUI7owaOFmtoLQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xmhi6WHj4k3m0XpBlFZ1/JVH4bgqrParXscypy7jAXFuzXnXx3wmISnGebf3JW7Wu
         aFfvo/lve3xXj89aF7wMUCNy17evybwjsHtnza8V+nOEB9C5q1cZwIe8/5AHzfEUpw
         o+ibQGffCjmNuP/Z5bSIOMoLw+eqqWshzWK8jYx8=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     netdev@vger.kernel.org
Cc:     bpf@vger.kernel.org, lorenzo.bianconi@redhat.com,
        davem@davemloft.net, kuba@kernel.org, brouer@redhat.com,
        ilias.apalodimas@linaro.org
Subject: [PATCH v2 net-next 4/4] net: mlx5: add xdp tx return bulking support
Date:   Thu, 29 Oct 2020 20:28:47 +0100
Message-Id: <25c50a285cb59e113ed79574c6b360fdf6d0050f.1603998519.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603998519.git.lorenzo@kernel.org>
References: <cover.1603998519.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Convert mlx5 driver to xdp_return_frame_bulk APIs.

XDP_REDIRECT (upstream codepath): 8.5Mpps
XDP_REDIRECT (upstream codepath + bulking APIs): 10.1Mpps

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
index ae90d533a350..5fdfbf390d5c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
@@ -369,8 +369,10 @@ static void mlx5e_free_xdpsq_desc(struct mlx5e_xdpsq *sq,
 				  bool recycle)
 {
 	struct mlx5e_xdp_info_fifo *xdpi_fifo = &sq->db.xdpi_fifo;
+	struct xdp_frame_bulk bq;
 	u16 i;
 
+	bq.xa = NULL;
 	for (i = 0; i < wi->num_pkts; i++) {
 		struct mlx5e_xdp_info xdpi = mlx5e_xdpi_fifo_pop(xdpi_fifo);
 
@@ -379,7 +381,7 @@ static void mlx5e_free_xdpsq_desc(struct mlx5e_xdpsq *sq,
 			/* XDP_TX from the XSK RQ and XDP_REDIRECT */
 			dma_unmap_single(sq->pdev, xdpi.frame.dma_addr,
 					 xdpi.frame.xdpf->len, DMA_TO_DEVICE);
-			xdp_return_frame(xdpi.frame.xdpf);
+			xdp_return_frame_bulk(xdpi.frame.xdpf, &bq);
 			break;
 		case MLX5E_XDP_XMIT_MODE_PAGE:
 			/* XDP_TX from the regular RQ */
@@ -393,6 +395,7 @@ static void mlx5e_free_xdpsq_desc(struct mlx5e_xdpsq *sq,
 			WARN_ON_ONCE(true);
 		}
 	}
+	xdp_flush_frame_bulk(&bq);
 }
 
 bool mlx5e_poll_xdpsq_cq(struct mlx5e_cq *cq)
-- 
2.26.2

