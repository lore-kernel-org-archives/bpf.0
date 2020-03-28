Return-Path: <SRS0=dppq=5N=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00527C43331
	for <bpf@archiver.kernel.org>; Sat, 28 Mar 2020 03:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC268206F1
	for <bpf@archiver.kernel.org>; Sat, 28 Mar 2020 03:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgC1DGj (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 27 Mar 2020 23:06:39 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:51310 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726291AbgC1DGj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Mar 2020 23:06:39 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9190A9271D5AFA8BEF8B;
        Sat, 28 Mar 2020 11:06:35 +0800 (CST)
Received: from localhost (10.173.223.234) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Sat, 28 Mar 2020
 11:06:28 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <netanel@amazon.com>, <akiyano@amazon.com>, <gtzalik@amazon.com>,
        <saeedb@amazon.com>, <zorik@amazon.com>, <davem@davemloft.net>,
        <sameehj@amazon.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bpf@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] net: ena: Make some functions static
Date:   Sat, 28 Mar 2020 11:06:20 +0800
Message-ID: <20200328030620.22328-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.223.234]
X-CFilter-Loop: Reflected
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix sparse warnings:

drivers/net/ethernet/amazon/ena/ena_netdev.c:460:6: warning: symbol 'ena_xdp_exchange_program_rx_in_range' was not declared. Should it be static?
drivers/net/ethernet/amazon/ena/ena_netdev.c:481:6: warning: symbol 'ena_xdp_exchange_program' was not declared. Should it be static?
drivers/net/ethernet/amazon/ena/ena_netdev.c:1555:5: warning: symbol 'ena_xdp_handle_buff' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 5703282aba8f..2cc765df8da3 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -457,10 +457,9 @@ static void ena_xdp_unregister_rxq_info(struct ena_ring *rx_ring)
 	xdp_rxq_info_unreg(&rx_ring->xdp_rxq);
 }
 
-void ena_xdp_exchange_program_rx_in_range(struct ena_adapter *adapter,
-					  struct bpf_prog *prog,
-					  int first,
-					  int count)
+static void ena_xdp_exchange_program_rx_in_range(struct ena_adapter *adapter,
+						 struct bpf_prog *prog,
+						 int first, int count)
 {
 	struct ena_ring *rx_ring;
 	int i = 0;
@@ -478,8 +477,8 @@ void ena_xdp_exchange_program_rx_in_range(struct ena_adapter *adapter,
 	}
 }
 
-void ena_xdp_exchange_program(struct ena_adapter *adapter,
-			      struct bpf_prog *prog)
+static void ena_xdp_exchange_program(struct ena_adapter *adapter,
+				     struct bpf_prog *prog)
 {
 	struct bpf_prog *old_bpf_prog = xchg(&adapter->xdp_bpf_prog, prog);
 
@@ -1552,7 +1551,7 @@ static void ena_set_rx_hash(struct ena_ring *rx_ring,
 	}
 }
 
-int ena_xdp_handle_buff(struct ena_ring *rx_ring, struct xdp_buff *xdp)
+static int ena_xdp_handle_buff(struct ena_ring *rx_ring, struct xdp_buff *xdp)
 {
 	struct ena_rx_buffer *rx_info;
 	int ret;
-- 
2.17.1


