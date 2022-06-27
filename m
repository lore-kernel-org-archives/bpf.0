Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F89C43334
	for <bpf@archiver.kernel.org>; Mon, 27 Jun 2022 19:09:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240351AbiF0TJM (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 27 Jun 2022 15:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237795AbiF0TJL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Jun 2022 15:09:11 -0400
X-Greylist: delayed 462 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 27 Jun 2022 12:09:10 PDT
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E9725C4;
        Mon, 27 Jun 2022 12:09:10 -0700 (PDT)
Received: from bree.oktetlabs.ru (bree.oktetlabs.ru [192.168.34.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by shelob.oktetlabs.ru (Postfix) with ESMTPS id 92342A5;
        Mon, 27 Jun 2022 22:01:25 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru 92342A5
Authentication-Results: shelob.oktetlabs.ru/92342A5; dkim=none;
        dkim-atps=neutral
From:   Ivan Malov <ivan.malov@oktetlabs.ru>
To:     Magnus Karlsson <magnus.karlsson@intel.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@intel.com>,
        netdev@vger.kernel.org
Cc:     Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Maxim Mikityanskiy <maximmi@mellanox.com>
Subject: [PATCH] xsk: clear page contiguity bit when unmapping pool
Date:   Mon, 27 Jun 2022 22:01:20 +0300
Message-Id: <20220627190120.176470-1-ivan.malov@oktetlabs.ru>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When a XSK pool gets mapped, xp_check_dma_contiguity() adds bit 0x1
to pages' DMA addresses that go in ascending order and at 4K stride.
The problem is that the bit does not get cleared before doing unmap.

As a result, a lot of warnings from iommu_dma_unmap_page() are seen
suggesting mapping lookup failures at drivers/iommu/dma-iommu.c:848.

Fixes: 2b43470add8c ("xsk: Introduce AF_XDP buffer allocation API")

Signed-off-by: Ivan Malov <ivan.malov@oktetlabs.ru>
---
 net/xdp/xsk_buff_pool.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 87bdd71c7bb6..f70112176b7c 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -332,6 +332,7 @@ static void __xp_dma_unmap(struct xsk_dma_map *dma_map, unsigned long attrs)
 	for (i = 0; i < dma_map->dma_pages_cnt; i++) {
 		dma = &dma_map->dma_pages[i];
 		if (*dma) {
+			*dma &= ~XSK_NEXT_PG_CONTIG_MASK;
 			dma_unmap_page_attrs(dma_map->dev, *dma, PAGE_SIZE,
 					     DMA_BIDIRECTIONAL, attrs);
 			*dma = 0;
-- 
2.30.2

