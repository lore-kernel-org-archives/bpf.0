Return-Path: <SRS0=Cb5B=BC=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F5AC43459
	for <bpf@archiver.kernel.org>; Thu, 23 Jul 2020 11:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F7A422B47
	for <bpf@archiver.kernel.org>; Thu, 23 Jul 2020 11:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595504619;
	bh=KvOb2v4/DULASBMPzRRuXD1qDyTyXW+92QWKjzH1DvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qccF6G/ujHrJigaHaOXhYzMZMZJnIc7CobM5NUHjtHIbOiojO2VDqK3EzoYYQPwl2
	 c3M7kfpN20YltsZkcTUDj7nv5TYwUY9tsWkedunVl1P6z6ew++ZzoMmyfXc+oDypBA
	 28/nXD4YP5q4Nny7OniQujrEy0QzdJ17K5G/OgLQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbgGWLnj (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 23 Jul 2020 07:43:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:46506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728567AbgGWLni (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jul 2020 07:43:38 -0400
Received: from lore-desk.redhat.com (unknown [151.48.142.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 255A720B1F;
        Thu, 23 Jul 2020 11:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595504618;
        bh=KvOb2v4/DULASBMPzRRuXD1qDyTyXW+92QWKjzH1DvQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=otejXy1z31OO28r6MTLY2tV8PYAkCN8oMApHj5U6gviV9DdNTehGHIO2OM8PbkvpO
         vSvz5M1r4IJHLzbvO6DxVOcbrqAtooXkoJkehdB+7fIlRurCOcUxrBasL5XIDwISau
         ZSERQNZEN6X/1zthr3E+hKZEXpvyvFbtXPz/1om8=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     netdev@vger.kernel.org
Cc:     bpf@vger.kernel.org, davem@davemloft.net, ast@kernel.org,
        brouer@redhat.com, daniel@iogearbox.net,
        lorenzo.bianconi@redhat.com, echaudro@redhat.com,
        sameehj@amazon.com, kuba@kernel.org
Subject: [RFC net-next 12/22] net: sfc: initialize mb bit in xdp_buff to 0
Date:   Thu, 23 Jul 2020 13:42:24 +0200
Message-Id: <576a3b0205a554d06bbec3a47a47dfb0d6879816.1595503780.git.lorenzo@kernel.org>
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
 drivers/net/ethernet/sfc/rx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/sfc/rx.c b/drivers/net/ethernet/sfc/rx.c
index 59a43d586967..8fd6023995d4 100644
--- a/drivers/net/ethernet/sfc/rx.c
+++ b/drivers/net/ethernet/sfc/rx.c
@@ -301,6 +301,7 @@ static bool efx_do_xdp(struct efx_nic *efx, struct efx_channel *channel,
 	xdp.data_end = xdp.data + rx_buf->len;
 	xdp.rxq = &rx_queue->xdp_rxq_info;
 	xdp.frame_sz = efx->rx_page_buf_step;
+	xdp.mb = 0;
 
 	xdp_act = bpf_prog_run_xdp(xdp_prog, &xdp);
 	rcu_read_unlock();
-- 
2.26.2

