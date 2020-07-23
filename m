Return-Path: <SRS0=Cb5B=BC=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C17C4345F
	for <bpf@archiver.kernel.org>; Thu, 23 Jul 2020 11:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C352720825
	for <bpf@archiver.kernel.org>; Thu, 23 Jul 2020 11:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595504624;
	bh=PYfhGStmHGabhVRpKCSxyn+LSBDv3+M907BzmhZ2kAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ErtB3Hwmh71U2S6C1TQ1PlvistLa6RvX7C/9edFSyhQLtI3fVCCSJ6i7hbwpyu6i2
	 wl9rojmXFklu08hW0/MRLkzdsJIcxIljdkXv1yZUpQfSJFms/+IsHcr6O48vUEAsWe
	 kaMRfXOZWCKkHBhKtIyitiwtnEypRAPShnb+ehi8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbgGWLno (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 23 Jul 2020 07:43:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:46580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728567AbgGWLnn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jul 2020 07:43:43 -0400
Received: from lore-desk.redhat.com (unknown [151.48.142.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5203122B47;
        Thu, 23 Jul 2020 11:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595504623;
        bh=PYfhGStmHGabhVRpKCSxyn+LSBDv3+M907BzmhZ2kAM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hoBTuAhriSJuEtSzA+PRLE0rHXVKk8HQNhq1TprMJtRF1s6OVRHEzTJP/MfVQATq8
         p4i0TCy0bBav5OW4CIM8AOelPDWp4DMbA80ZnP898ppeozufht/M7+X3BWaq7mBjVw
         EG8OBmP8bW5nG+65zrDSJLt7AMAPI7FyiscAazv0=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     netdev@vger.kernel.org
Cc:     bpf@vger.kernel.org, davem@davemloft.net, ast@kernel.org,
        brouer@redhat.com, daniel@iogearbox.net,
        lorenzo.bianconi@redhat.com, echaudro@redhat.com,
        sameehj@amazon.com, kuba@kernel.org
Subject: [RFC net-next 14/22] net: amazon: ena: initialize mb bit in xdp_buff to 0
Date:   Thu, 23 Jul 2020 13:42:26 +0200
Message-Id: <4ed74f33688075319dfe859fe62d789611a7efe1.1595503780.git.lorenzo@kernel.org>
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
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 6478c1e0d137..12f7ee1d1f0a 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -1613,6 +1613,7 @@ static int ena_clean_rx_irq(struct ena_ring *rx_ring, struct napi_struct *napi,
 	res_budget = budget;
 	xdp.rxq = &rx_ring->xdp_rxq;
 	xdp.frame_sz = ENA_PAGE_SIZE;
+	xdp.mb = 0;
 
 	do {
 		xdp_verdict = XDP_PASS;
-- 
2.26.2

