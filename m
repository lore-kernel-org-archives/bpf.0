Return-Path: <SRS0=zf1N=CM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D568C433E2
	for <bpf@archiver.kernel.org>; Thu,  3 Sep 2020 20:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C28EE206B8
	for <bpf@archiver.kernel.org>; Thu,  3 Sep 2020 20:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599166791;
	bh=peyukAcC2BN2wjt+dwbi/n6wfqFM65fensqMyu1gMcY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dUzR4r22k2P2PwzI4DMd5aoKsSfvOa2G4TfjFBCeWg58TNsDH1cTS5Wk3CBnNMDBv
	 L7YxxT6V8UQGoL+A4ZChr9eTXGQSOiKygyaS7NK40JL17xTG4YV/kcW22SgUgil89H
	 5AGkDMyq9YBWAwVN1wxIp3Mbexj48d2zDtTM56DA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729383AbgICU7p (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 3 Sep 2020 16:59:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:56394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729348AbgICU7n (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Sep 2020 16:59:43 -0400
Received: from lore-desk.redhat.com (unknown [151.66.86.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C803920709;
        Thu,  3 Sep 2020 20:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599166783;
        bh=peyukAcC2BN2wjt+dwbi/n6wfqFM65fensqMyu1gMcY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iwIfBf3jO5GjJwnuQ157HAatSlArsIYVGNxRBCmNYE+V9cK14vEquDJl8dQPKPdKB
         gHyGEjGbPuh+UCta4VhB2wjCyhat9i6BasFCPt2+XK/m36DE9edaLn20teBnQFIjWa
         02RQ+LGsmYoo++AEYCP3WV5MDPOZ87PoaG5QF2ng=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     netdev@vger.kernel.org
Cc:     bpf@vger.kernel.org, davem@davemloft.net,
        lorenzo.bianconi@redhat.com, brouer@redhat.com,
        echaudro@redhat.com, sameehj@amazon.com, kuba@kernel.org,
        john.fastabend@gmail.com, daniel@iogearbox.net, ast@kernel.org,
        shayagr@amazon.com
Subject: [PATCH v2 net-next 9/9] net: mvneta: enable jumbo frames for XDP
Date:   Thu,  3 Sep 2020 22:58:53 +0200
Message-Id: <a7649b57187881de001e6d353ad04557b3e9f671.1599165032.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1599165031.git.lorenzo@kernel.org>
References: <cover.1599165031.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Enable the capability to receive jumbo frames even if the interface is
running in XDP mode

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/marvell/mvneta.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 65fbed957e4f..85853fefcfd1 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -3737,11 +3737,6 @@ static int mvneta_change_mtu(struct net_device *dev, int mtu)
 		mtu = ALIGN(MVNETA_RX_PKT_SIZE(mtu), 8);
 	}
 
-	if (pp->xdp_prog && mtu > MVNETA_MAX_RX_BUF_SIZE) {
-		netdev_info(dev, "Illegal MTU value %d for XDP mode\n", mtu);
-		return -EINVAL;
-	}
-
 	dev->mtu = mtu;
 
 	if (!netif_running(dev)) {
@@ -4439,11 +4434,6 @@ static int mvneta_xdp_setup(struct net_device *dev, struct bpf_prog *prog,
 	struct mvneta_port *pp = netdev_priv(dev);
 	struct bpf_prog *old_prog;
 
-	if (prog && dev->mtu > MVNETA_MAX_RX_BUF_SIZE) {
-		NL_SET_ERR_MSG_MOD(extack, "Jumbo frames not supported on XDP");
-		return -EOPNOTSUPP;
-	}
-
 	if (pp->bm_priv) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "Hardware Buffer Management not supported on XDP");
-- 
2.26.2

