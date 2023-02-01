Return-Path: <bpf-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6FEC636D3
	for <bpf@archiver.kernel.org>; Wed,  1 Feb 2023 10:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbjBAKZW (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 1 Feb 2023 05:25:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbjBAKZU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 05:25:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4623B3E5;
        Wed,  1 Feb 2023 02:25:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E40BBB8214A;
        Wed,  1 Feb 2023 10:25:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1866AC433EF;
        Wed,  1 Feb 2023 10:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675247114;
        bh=EUEjHYCFZLBlSjnOAZ24J2T1iHJ/3Lz1NQeBwSmXZYY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SVuI+zUN+v/ek6atT1jY434aD2dCGtiIjY+g9Le3DZhK1eUvqLDLkHkbt1VZN2fdd
         7zUL77gnq7DUrn6Nk4og1Ex6zCaJ3cgr1y8YvDOmmb6bbBWsHaVSkkH5yOHK6BUOO2
         699hJV5Yr0qfhIMqe/FcESgRfY/UVXXFzf7+IhB/wARSkHHKlTlHflqJVi6rCEWkEp
         z/ZZKsy7EPKAVwyxsbP3agqy4Sl/VeJDEHedv0NSY6BbleiusKe+I0g0UJuvPM/L40
         ngaTjdBEqs1CyE3Bo4vekiEQotEhNw+Hh60Q+SU5xA+u8YWSAb7Cydsl7FXPLgOc34
         XsS5KqerglTcw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, edumazet@google.com, hawk@kernel.org,
        toke@redhat.com, memxor@gmail.com, alardam@gmail.com,
        saeedm@nvidia.com, anthony.l.nguyen@intel.com, gospo@broadcom.com,
        vladimir.oltean@nxp.com, nbd@nbd.name, john@phrozen.org,
        leon@kernel.org, simon.horman@corigine.com, aelior@marvell.com,
        christophe.jaillet@wanadoo.fr, ecree.xilinx@gmail.com,
        mst@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com,
        maciej.fijalkowski@intel.com, intel-wired-lan@lists.osuosl.org,
        lorenzo.bianconi@redhat.com, martin.lau@linux.dev, sdf@google.com,
        gerhard@engleder-embedded.com
Subject: [PATCH v5 bpf-next 3/8] xsk: add usage of XDP features flags
Date:   Wed,  1 Feb 2023 11:24:19 +0100
Message-Id: <45a98ec67b4556a6a22dfd85df3eb8276beeeb74.1675245258.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1675245257.git.lorenzo@kernel.org>
References: <cover.1675245257.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Marek Majtyka <alardam@gmail.com>

Change necessary condition check for XSK from ndo functions to
xdp features flags.

Signed-off-by: Marek Majtyka <alardam@gmail.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 net/xdp/xsk_buff_pool.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index ed6c71826d31..b2df1e0f8153 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -140,6 +140,10 @@ static void xp_disable_drv_zc(struct xsk_buff_pool *pool)
 	}
 }
 
+#define NETDEV_XDP_ACT_ZC	(NETDEV_XDP_ACT_BASIC |		\
+				 NETDEV_XDP_ACT_REDIRECT |	\
+				 NETDEV_XDP_ACT_XSK_ZEROCOPY)
+
 int xp_assign_dev(struct xsk_buff_pool *pool,
 		  struct net_device *netdev, u16 queue_id, u16 flags)
 {
@@ -178,8 +182,7 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
 		/* For copy-mode, we are done. */
 		return 0;
 
-	if (!netdev->netdev_ops->ndo_bpf ||
-	    !netdev->netdev_ops->ndo_xsk_wakeup) {
+	if ((netdev->xdp_features & NETDEV_XDP_ACT_ZC) != NETDEV_XDP_ACT_ZC) {
 		err = -EOPNOTSUPP;
 		goto err_unreg_pool;
 	}
-- 
2.39.1

