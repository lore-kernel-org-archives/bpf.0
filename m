Return-Path: <SRS0=UYZo=VA=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96C8C5B57D
	for <bpf@archiver.kernel.org>; Wed,  3 Jul 2019 02:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8969206E0
	for <bpf@archiver.kernel.org>; Wed,  3 Jul 2019 02:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbfGCCfv (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 2 Jul 2019 22:35:51 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8688 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727144AbfGCCfv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Jul 2019 22:35:51 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 114BFA93318A16B54761;
        Wed,  3 Jul 2019 10:35:47 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Wed, 3 Jul 2019 10:35:40 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Jassi Brar <jaswinder.singh@linaro.org>,
        Alexei Starovoitov <ast@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Jakub Kicinski" <jakub.kicinski@netronome.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>
CC:     YueHaibing <yuehaibing@huawei.com>, <netdev@vger.kernel.org>,
        <xdp-newbies@vger.kernel.org>, <bpf@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH net-next] net: socionext: remove set but not used variable 'pkts'
Date:   Wed, 3 Jul 2019 02:42:13 +0000
Message-ID: <20190703024213.191191-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/net/ethernet/socionext/netsec.c: In function 'netsec_clean_tx_dring':
drivers/net/ethernet/socionext/netsec.c:637:15: warning:
 variable 'pkts' set but not used [-Wunused-but-set-variable]

It is not used since commit ba2b232108d3 ("net: netsec: add XDP support")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/socionext/netsec.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/socionext/netsec.c b/drivers/net/ethernet/socionext/netsec.c
index 5544a722543f..015d1ec5436a 100644
--- a/drivers/net/ethernet/socionext/netsec.c
+++ b/drivers/net/ethernet/socionext/netsec.c
@@ -634,7 +634,7 @@ static void netsec_set_rx_de(struct netsec_priv *priv,
 static bool netsec_clean_tx_dring(struct netsec_priv *priv)
 {
 	struct netsec_desc_ring *dring = &priv->desc_ring[NETSEC_RING_TX];
-	unsigned int pkts, bytes;
+	unsigned int bytes;
 	struct netsec_de *entry;
 	int tail = dring->tail;
 	int cnt = 0;
@@ -642,7 +642,6 @@ static bool netsec_clean_tx_dring(struct netsec_priv *priv)
 	if (dring->is_xdp)
 		spin_lock(&dring->lock);
 
-	pkts = 0;
 	bytes = 0;
 	entry = dring->vaddr + DESC_SZ * tail;



