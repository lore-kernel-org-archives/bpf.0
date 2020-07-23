Return-Path: <SRS0=Cb5B=BC=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09647C43458
	for <bpf@archiver.kernel.org>; Thu, 23 Jul 2020 11:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCD7D208E4
	for <bpf@archiver.kernel.org>; Thu, 23 Jul 2020 11:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595504616;
	bh=pWec+2KcieliOLBE2JVAA0CoHeIXFsSui4XmQldnPWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fizQTBOOuNF0AxpFyaK2tMn1FJVDicC+XMH0qnyk2XXYh0QFNnnHrQsqUK5trQkCe
	 YdDkH8YMHIiKAX7MfOO1sSyJzwa6oyWE4zuFB9Rjhy2Vc3RY697xSCFjmbmnQNIwIK
	 6OWaWafgHYIZY3PEHz2usY56X48CjCbtPkTHbfz8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728749AbgGWLng (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 23 Jul 2020 07:43:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:46462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728567AbgGWLng (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jul 2020 07:43:36 -0400
Received: from lore-desk.redhat.com (unknown [151.48.142.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1DEC22B43;
        Thu, 23 Jul 2020 11:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595504615;
        bh=pWec+2KcieliOLBE2JVAA0CoHeIXFsSui4XmQldnPWM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GSpelUmTvPAnuZQ9N+TCedE2Lpmbt//jzrJyCMeZ9pitPavp13nKv6SL9ui5w7Cxx
         uDz5tKTb2JK8bIuUPT13dl70Ucb695itLAdHK2brjNMoCfhrx0elvPDiX3zK+2RdgW
         XJr5nyMcEY6NKIJrTv5t7OlfvbUAQ0fQyCE5sfIs=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     netdev@vger.kernel.org
Cc:     bpf@vger.kernel.org, davem@davemloft.net, ast@kernel.org,
        brouer@redhat.com, daniel@iogearbox.net,
        lorenzo.bianconi@redhat.com, echaudro@redhat.com,
        sameehj@amazon.com, kuba@kernel.org
Subject: [RFC net-next 11/22] net: mvpp2: initialize mb bit in xdp_buff to 0
Date:   Thu, 23 Jul 2020 13:42:23 +0200
Message-Id: <f615dd1a440420cb3708610b8beefb02bf9828f7.1595503780.git.lorenzo@kernel.org>
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
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 6a3f356640a0..61b1688527ea 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -3475,6 +3475,7 @@ static int mvpp2_rx(struct mvpp2_port *port, struct napi_struct *napi,
 			xdp.data = data + MVPP2_MH_SIZE + MVPP2_SKB_HEADROOM;
 			xdp.data_end = xdp.data + rx_bytes;
 			xdp.frame_sz = PAGE_SIZE;
+			xdp.mb = 0;
 
 			if (bm_pool->pkt_size == MVPP2_BM_SHORT_PKT_SIZE)
 				xdp.rxq = &rxq->xdp_rxq_short;
-- 
2.26.2

