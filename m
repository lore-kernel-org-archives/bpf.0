Return-Path: <SRS0=uc+s=DH=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F875C4727C
	for <bpf@archiver.kernel.org>; Wed, 30 Sep 2020 15:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A24F2087D
	for <bpf@archiver.kernel.org>; Wed, 30 Sep 2020 15:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601480591;
	bh=xk9bFAyppCfcxz8mjaSlx2KdcKBpE7HdmJ6obgHpAUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GeUqFBwuHUR/6W0LL+ngEfImcrI9p0WTfHoqeHfD+HrrwTmIcr82nUsrEToLh0pAh
	 vCFSD9zhi4v5Fjpy99zyEs2vESbe4x/Bz/zDXHDVxReCc/T/Z/ZkitiqkqAxJZ/6et
	 A4nSdxd0T3wGpnSX7ZWZQxGh0RH/0NWWfxx/RnDo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729504AbgI3PnI (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 30 Sep 2020 11:43:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:53486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731136AbgI3PnH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Sep 2020 11:43:07 -0400
Received: from lore-desk.redhat.com (unknown [176.207.245.61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 212CD207C3;
        Wed, 30 Sep 2020 15:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601480587;
        bh=xk9bFAyppCfcxz8mjaSlx2KdcKBpE7HdmJ6obgHpAUA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wi0teLrI93hygU8BlKJxaKim2JeMkAkrYq6kgAIZiNFjzcEPvphlprfHPM1xVlrvQ
         XLu436DMyGagU2AYjupKuwjYel/1jExdhndKiKf73SBEnwydjCe4Cfj61SgpyP15kD
         jojAp2lsDwQDzgIrr0vOXzvn/xciOZRvQwzybSuw=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     netdev@vger.kernel.org
Cc:     bpf@vger.kernel.org, davem@davemloft.net, sameehj@amazon.com,
        kuba@kernel.org, john.fastabend@gmail.com, daniel@iogearbox.net,
        ast@kernel.org, shayagr@amazon.com, brouer@redhat.com,
        echaudro@redhat.com, lorenzo.bianconi@redhat.com,
        dsahern@kernel.org
Subject: [PATCH v3 net-next 11/12] net: mvneta: enable jumbo frames for XDP
Date:   Wed, 30 Sep 2020 17:42:02 +0200
Message-Id: <4b9ba38a87b570569cb05bd94f487168fdd83fa8.1601478613.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601478613.git.lorenzo@kernel.org>
References: <cover.1601478613.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index f709650974ea..e3352ed13ea8 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -3743,11 +3743,6 @@ static int mvneta_change_mtu(struct net_device *dev, int mtu)
 		mtu = ALIGN(MVNETA_RX_PKT_SIZE(mtu), 8);
 	}
 
-	if (pp->xdp_prog && mtu > MVNETA_MAX_RX_BUF_SIZE) {
-		netdev_info(dev, "Illegal MTU value %d for XDP mode\n", mtu);
-		return -EINVAL;
-	}
-
 	dev->mtu = mtu;
 
 	if (!netif_running(dev)) {
@@ -4445,11 +4440,6 @@ static int mvneta_xdp_setup(struct net_device *dev, struct bpf_prog *prog,
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

