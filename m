Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD767C433EF
	for <bpf@archiver.kernel.org>; Tue, 28 Jun 2022 09:18:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344114AbiF1JSy (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 28 Jun 2022 05:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243314AbiF1JSx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Jun 2022 05:18:53 -0400
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE661CFC2;
        Tue, 28 Jun 2022 02:18:52 -0700 (PDT)
Received: from bree.oktetlabs.ru (bree.oktetlabs.ru [192.168.34.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by shelob.oktetlabs.ru (Postfix) with ESMTPS id 0DBA6AA;
        Tue, 28 Jun 2022 12:18:51 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru 0DBA6AA
Authentication-Results: shelob.oktetlabs.ru/0DBA6AA; dkim=none;
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
Subject: [PATCH net v3 1/1] xsk: clear page contiguity bit when unmapping pool
Date:   Tue, 28 Jun 2022 12:18:48 +0300
Message-Id: <20220628091848.534803-1-ivan.malov@oktetlabs.ru>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220627190120.176470-1-ivan.malov@oktetlabs.ru>
References: <20220627190120.176470-1-ivan.malov@oktetlabs.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When a XSK pool gets mapped, xp_check_dma_contiguity() adds bit 0x1
to pages' DMA addresses that go in ascending order and at 4K stride.
The problem is that the bit does not get cleared before doing unmap.
As a result, a lot of warnings from iommu_dma_unmap_page() are seen
in dmesg, which indicates that lookups by iommu_iova_to_phys() fail.

Fixes: 2b43470add8c ("xsk: Introduce AF_XDP buffer allocation API")
Signed-off-by: Ivan Malov <ivan.malov@oktetlabs.ru>
---
 v1 -> v2: minor adjustments to dispose of the "Fixes:" tag warning
 v2 -> v3: extra refinements to apply notes from Magnus Karlsson

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

