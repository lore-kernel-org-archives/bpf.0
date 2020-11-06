Return-Path: <SRS0=kVCt=EM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7AD5C2D0A3
	for <bpf@archiver.kernel.org>; Fri,  6 Nov 2020 18:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 822D5221FA
	for <bpf@archiver.kernel.org>; Fri,  6 Nov 2020 18:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604686783;
	bh=2T02Rnj9JSqlSyqTOWwETG3CNvYOciUI7owaOFmtoLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n7Dtrw2I28H23a+kP7Za90FOMYwzOCRYIRuCfUJSjVYqlxKrArGWH8DpVk0Ypmr1G
	 Mg3UsF3K4TLzI9ennB68f3seRLXAEJz1a4r/+hDzWr14Pf1iWitBJnRw1apPOh+FQS
	 CgosSeJdGxf31jmsi14gWUKTqaj48w2xHOTOERsE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbgKFSTm (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 6 Nov 2020 13:19:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:41302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727791AbgKFSTl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Nov 2020 13:19:41 -0500
Received: from localhost.localdomain (unknown [151.66.8.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70EE821D81;
        Fri,  6 Nov 2020 18:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604686781;
        bh=2T02Rnj9JSqlSyqTOWwETG3CNvYOciUI7owaOFmtoLQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fn1Rn35R2/YBaN5gXuyPOrwyPYfb1S50e3mdv30EVeZrIv0CLancbyjg7hK/ZA+Fv
         xp0jIEBW6PUPLV1ChI8L6NmzbmRNjjbBaOOwmsZllVPbV4tJWPLcckDFDyUcsGb4Bp
         lvph9x3U0I/ij7RNMnOJNfMdzSQJiAOBhRtmX+fw=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     netdev@vger.kernel.org
Cc:     bpf@vger.kernel.org, lorenzo.bianconi@redhat.com,
        davem@davemloft.net, kuba@kernel.org, brouer@redhat.com,
        ilias.apalodimas@linaro.org
Subject: [PATCH v4 net-next 5/5] net: mlx5: add xdp tx return bulking support
Date:   Fri,  6 Nov 2020 19:19:11 +0100
Message-Id: <652d803bf1ffab08ff947da5e915add9fb737846.1604686496.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1604686496.git.lorenzo@kernel.org>
References: <cover.1604686496.git.lorenzo@kernel.org>
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

