Return-Path: <SRS0=Cb5B=BC=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC0D6C433F4
	for <bpf@archiver.kernel.org>; Thu, 23 Jul 2020 11:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAB7520B1F
	for <bpf@archiver.kernel.org>; Thu, 23 Jul 2020 11:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595504644;
	bh=g2Y8uQfOslio3TmfWA9z7XYrN3U+Q1ktDyxOf5q72Js=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=t3vdsX/d4QGvpovX/jd32rXct9uqJ9srt0flzzuwXaVx08pliPeY8UG+rTewRwBP+
	 s1ySeKTDzS/psA2WBrkvuPtnWAC69QU//JUDQf8tNRIwxLGAtQ/x0swB7anQtjtkMx
	 MLHsD6lM8rZVFPMuSHaosgsC0zVAJgf9XX8lYgNg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbgGWLoE (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 23 Jul 2020 07:44:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:46894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726109AbgGWLoD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jul 2020 07:44:03 -0400
Received: from lore-desk.redhat.com (unknown [151.48.142.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6AFF22B43;
        Thu, 23 Jul 2020 11:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595504642;
        bh=g2Y8uQfOslio3TmfWA9z7XYrN3U+Q1ktDyxOf5q72Js=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r+L0I3aOpGnsYiA+nbE0EKy7XnhjQTswQpe3i8APfzvmqxwA+tMHxBYZK87UFqLnN
         Q/mRlkd6jBQn/Zkf/7Eft8DhUCSM+3GgkJ4SfMt+pzx4gE/G/3Wcaka9C/RWdn++o+
         Mc0udBAxzvGNY/0/RD0OykL4485/7Apr4sfGfw3k=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     netdev@vger.kernel.org
Cc:     bpf@vger.kernel.org, davem@davemloft.net, ast@kernel.org,
        brouer@redhat.com, daniel@iogearbox.net,
        lorenzo.bianconi@redhat.com, echaudro@redhat.com,
        sameehj@amazon.com, kuba@kernel.org
Subject: [RFC net-next 21/22] net: mlx5: initialize mb bit in xdp_buff to 0
Date:   Thu, 23 Jul 2020 13:42:33 +0200
Message-Id: <042ee812c11d32a437100cc00462dbad08f66e40.1595503780.git.lorenzo@kernel.org>
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
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 74860f3827b1..bfaa03134505 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1104,6 +1104,7 @@ static void mlx5e_fill_xdp_buff(struct mlx5e_rq *rq, void *va, u16 headroom,
 	xdp->data_end = xdp->data + len;
 	xdp->rxq = &rq->xdp_rxq;
 	xdp->frame_sz = rq->buff.frame0_sz;
+	xdp->mb = 0;
 }
 
 struct sk_buff *
-- 
2.26.2

