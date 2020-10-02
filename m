Return-Path: <SRS0=svjS=DJ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DE9C4363D
	for <bpf@archiver.kernel.org>; Fri,  2 Oct 2020 14:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9546206FA
	for <bpf@archiver.kernel.org>; Fri,  2 Oct 2020 14:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601649798;
	bh=xk9bFAyppCfcxz8mjaSlx2KdcKBpE7HdmJ6obgHpAUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P6KF3i5DJrcP2aqLy6R+NeMrP+R45yiy8THTAOH4FS62pf6LEVkAu28FClN5jFN1u
	 D0dzBR7AWnxeWse9S8wzFi4afraUzq3ODUGj2boyEcXk6gpBVCWoimhvarWqaQlI7x
	 yuRdv7omIpHPsRN5+59Z+9n/r7T2K4NT826+CVhA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388240AbgJBOnQ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 2 Oct 2020 10:43:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:32896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388238AbgJBOnQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Oct 2020 10:43:16 -0400
Received: from lore-desk.redhat.com (unknown [176.207.245.61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A20620719;
        Fri,  2 Oct 2020 14:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601649795;
        bh=xk9bFAyppCfcxz8mjaSlx2KdcKBpE7HdmJ6obgHpAUA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lvQCA4gS8s2oaHbxKETf8NhsPmapw6Z4otKapTi7CTRX7Fadf429N8dkj+QWUADDH
         7ruVDrh8QlRHNVayvhc1sww3FNbiEHvyqF1gRXH/OVq3ZOEK7sxKVdO6dWLXYyGxvv
         tAHgyhnKTEI0iueMbuQi6yw8hmXf1sF+Y21F97hk=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     bpf@vger.kernel.org, netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, shayagr@amazon.com, sameehj@amazon.com,
        john.fastabend@gmail.com, dsahern@kernel.org, brouer@redhat.com,
        lorenzo.bianconi@redhat.com, echaudro@redhat.com
Subject: [PATCH v4 bpf-next 12/13] net: mvneta: enable jumbo frames for XDP
Date:   Fri,  2 Oct 2020 16:42:10 +0200
Message-Id: <48dbbc156eaaadfcc341f76991ff126cc5ed4b56.1601648734.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601648734.git.lorenzo@kernel.org>
References: <cover.1601648734.git.lorenzo@kernel.org>
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

