Return-Path: <SRS0=GL4p=6L=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0610EC5519A
	for <bpf@archiver.kernel.org>; Mon, 27 Apr 2020 10:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E37AB2064C
	for <bpf@archiver.kernel.org>; Mon, 27 Apr 2020 10:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgD0KmO (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 27 Apr 2020 06:42:14 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3312 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726485AbgD0KmO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Apr 2020 06:42:14 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D55B66B938826C5264BE;
        Mon, 27 Apr 2020 18:42:11 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Mon, 27 Apr 2020 18:42:02 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Ioana Ciornei <ioana.ciornei@nxp.com>,
        Ioana Radulescu <ruxandra.radulescu@nxp.com>,
        Russell King <linux@armlinux.org.uk>,
        "Alexei Starovoitov" <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Jakub Kicinski" <kuba@kernel.org>
CC:     Wei Yongjun <weiyongjun1@huawei.com>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <linaro-mm-sig@lists.linaro.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH net-next] dpaa2-eth: fix error return code in setup_dpni()
Date:   Mon, 27 Apr 2020 10:43:22 +0000
Message-ID: <20200427104322.11214-1-weiyongjun1@huawei.com>
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

Fix to return negative error code -ENOMEM from the error handling
case instead of 0, as done elsewhere in this function.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
index 8ec435ba7d27..11accab81ea1 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
@@ -2702,8 +2702,10 @@ static int setup_dpni(struct fsl_mc_device *ls_dev)
 
 	priv->cls_rules = devm_kzalloc(dev, sizeof(struct dpaa2_eth_cls_rule) *
 				       dpaa2_eth_fs_count(priv), GFP_KERNEL);
-	if (!priv->cls_rules)
+	if (!priv->cls_rules) {
+		err = -ENOMEM;
 		goto close;
+	}
 
 	return 0;



