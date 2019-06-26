Return-Path: <SRS0=yGwg=UZ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96EFEC48BDB
	for <bpf@archiver.kernel.org>; Wed, 26 Jun 2019 14:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 767B32133F
	for <bpf@archiver.kernel.org>; Wed, 26 Jun 2019 14:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbfFZOgT (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 26 Jun 2019 10:36:19 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:59880 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727923AbfFZOgS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Jun 2019 10:36:18 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from tariqt@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 26 Jun 2019 17:36:16 +0300
Received: from dev-l-vrt-206-006.mtl.labs.mlnx (dev-l-vrt-206-006.mtl.labs.mlnx [10.134.206.6])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x5QEaGY5027430;
        Wed, 26 Jun 2019 17:36:16 +0300
From:   Tariq Toukan <tariqt@mellanox.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, bjorn.topel@intel.com,
        Magnus Karlsson <magnus.karlsson@intel.com>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Jonathan Lemon <bsd@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Maxim Mikityanskiy <maximmi@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>
Subject: [PATCH bpf-next V6 07/16] net/mlx5e: Replace deprecated PCI_DMA_TODEVICE
Date:   Wed, 26 Jun 2019 17:35:29 +0300
Message-Id: <1561559738-4213-8-git-send-email-tariqt@mellanox.com>
X-Mailer: git-send-email 1.8.4.3
In-Reply-To: <1561559738-4213-1-git-send-email-tariqt@mellanox.com>
References: <1561559738-4213-1-git-send-email-tariqt@mellanox.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Maxim Mikityanskiy <maximmi@mellanox.com>

The PCI API for DMA is deprecated, and PCI_DMA_TODEVICE is just defined
to DMA_TO_DEVICE for backward compatibility. Just use DMA_TO_DEVICE.

Signed-off-by: Maxim Mikityanskiy <maximmi@mellanox.com>
Signed-off-by: Tariq Toukan <tariqt@mellanox.com>
Acked-by: Saeed Mahameed <saeedm@mellanox.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
index eb8ef78e5626..5a900b70b203 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
@@ -64,7 +64,7 @@ int mlx5e_xdp_max_mtu(struct mlx5e_params *params)
 		return false;
 	xdpi.dma_addr = di->addr + (xdpi.xdpf->data - (void *)xdpi.xdpf);
 	dma_sync_single_for_device(sq->pdev, xdpi.dma_addr,
-				   xdpi.xdpf->len, PCI_DMA_TODEVICE);
+				   xdpi.xdpf->len, DMA_TO_DEVICE);
 	xdpi.di = *di;
 
 	return sq->xmit_xdp_frame(sq, &xdpi);
-- 
1.8.3.1

