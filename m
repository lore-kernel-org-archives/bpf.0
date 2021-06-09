Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A77C48BCF
	for <bpf@archiver.kernel.org>; Wed,  9 Jun 2021 14:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24ED561285
	for <bpf@archiver.kernel.org>; Wed,  9 Jun 2021 14:14:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234463AbhFIOQh (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 9 Jun 2021 10:16:37 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3928 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237645AbhFIOQg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Jun 2021 10:16:36 -0400
Received: from dggeml759-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G0TYc6tJDz6vyG;
        Wed,  9 Jun 2021 22:11:32 +0800 (CST)
Received: from localhost.localdomain (10.175.102.38) by
 dggeml759-chm.china.huawei.com (10.1.199.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 9 Jun 2021 22:14:36 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     <weiyongjun1@huawei.com>, Netanel Belgazal <netanel@amazon.com>,
        Arthur Kiyanovski <akiyano@amazon.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Shay Agroskin <shayagr@amazon.com>,
        Sameeh Jubran <sameehj@amazon.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>
CC:     <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH net-next] net: ena: make symbol 'ena_alloc_map_page' static
Date:   Wed, 9 Jun 2021 14:25:06 +0000
Message-ID: <20210609142506.1621773-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.102.38]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggeml759-chm.china.huawei.com (10.1.199.138)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The sparse tool complains as follows:

drivers/net/ethernet/amazon/ena/ena_netdev.c:978:13: warning:
 symbol 'ena_alloc_map_page' was not declared. Should it be static?

This symbol is not used outside of ena_netdev.c, so marks it static.

Fixes: 947c54c395cb ("net: ena: Use dev_alloc() in RX buffer allocation")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index cd6ea59c543c..3bb0e66b2c7e 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -975,7 +975,8 @@ static void ena_free_all_io_rx_resources(struct ena_adapter *adapter)
 		ena_free_rx_resources(adapter, i);
 }
 
-struct page *ena_alloc_map_page(struct ena_ring *rx_ring, dma_addr_t *dma)
+static struct page *ena_alloc_map_page(struct ena_ring *rx_ring,
+				       dma_addr_t *dma)
 {
 	struct page *page;
 

