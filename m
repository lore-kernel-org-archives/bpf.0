Return-Path: <SRS0=Cb5B=BC=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 655FDC433F8
	for <bpf@archiver.kernel.org>; Thu, 23 Jul 2020 11:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 420D020B1F
	for <bpf@archiver.kernel.org>; Thu, 23 Jul 2020 11:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595504647;
	bh=X0Z1R2jFkhJUSkoinGq+f0fTEPc2NQ4LnVDbVcmKlN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=My3+BfsJPZbbz9HIqn2idko+v34E2jNgz0xfTC1irCe7z+M7iSHh1I0+MDTCoSvwi
	 yfIhRE2BHuyBau60M9xzThjQzk+0Idm/mqsi03u+F2ygM7s0ZFtyS3pitjcQP+sODr
	 02xFOBPkrPiljJ+SkAC96Rb7o57AG17dGx17nKlg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728822AbgGWLoG (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 23 Jul 2020 07:44:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:46934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726109AbgGWLoF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jul 2020 07:44:05 -0400
Received: from lore-desk.redhat.com (unknown [151.48.142.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32B602086A;
        Thu, 23 Jul 2020 11:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595504645;
        bh=X0Z1R2jFkhJUSkoinGq+f0fTEPc2NQ4LnVDbVcmKlN4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c0Vt+N4yB66ODn9Un9v4b2zZ3kUB57Si4SEqTOYQH3W/mARNidw8XjTln8iLE6Cyy
         AwwbcgpEW38kdubEmndGSCziBqHfqFCoI9Q10Njo+Nb9yXUpmUC7KSO4F95tNLEYbf
         I7DslHO117RWcTkwmGSMaDSEQwWIdZAgMIvXFuzA=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     netdev@vger.kernel.org
Cc:     bpf@vger.kernel.org, davem@davemloft.net, ast@kernel.org,
        brouer@redhat.com, daniel@iogearbox.net,
        lorenzo.bianconi@redhat.com, echaudro@redhat.com,
        sameehj@amazon.com, kuba@kernel.org
Subject: [RFC net-next 22/22] net: mlx4: initialize mb bit in xdp_buff to 0
Date:   Thu, 23 Jul 2020 13:42:34 +0200
Message-Id: <58f38cdce05d1126f4a9372f0e14de7718af0a14.1595503780.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1595503780.git.lorenzo@kernel.org>
References: <cover.1595503780.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Initialize multi-buffer bit (mb) to 0 in xdp_buff data structure.
This is a preliminary patch to enable xdp multi-buffer support.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx4/en_rx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_rx.c b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
index 8a10285b0e10..0d42e81a7ad8 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
@@ -684,6 +684,7 @@ int mlx4_en_process_rx_cq(struct net_device *dev, struct mlx4_en_cq *cq, int bud
 	xdp_prog = rcu_dereference(ring->xdp_prog);
 	xdp.rxq = &ring->xdp_rxq;
 	xdp.frame_sz = priv->frag_info[0].frag_stride;
+	xdp.mb = 0;
 	doorbell_pending = 0;
 
 	/* We assume a 1:1 mapping between CQEs and Rx descriptors, so Rx
-- 
2.26.2

