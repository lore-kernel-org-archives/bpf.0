Return-Path: <SRS0=tLdU=5I=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A97C10F26
	for <bpf@archiver.kernel.org>; Mon, 23 Mar 2020 06:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FCAE20736
	for <bpf@archiver.kernel.org>; Mon, 23 Mar 2020 06:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbgCWGsU (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 23 Mar 2020 02:48:20 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:56286 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726142AbgCWGsT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Mar 2020 02:48:19 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7B578D4A8DDD5F88AC1A;
        Mon, 23 Mar 2020 14:48:11 +0800 (CST)
Received: from huawei.com (10.175.113.25) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Mon, 23 Mar 2020
 14:48:04 +0800
From:   Zheng Zengkai <zhengzengkai@huawei.com>
To:     <sgoutham@marvell.com>, <rrichter@marvell.com>,
        <davem@davemloft.net>, <ast@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        <zhengzengkai@huawei.com>
Subject: [PATCH net-next] net: thunderx: remove set but not used variable 'tail'
Date:   Mon, 23 Mar 2020 14:51:16 +0800
Message-ID: <20200323065116.45399-1-zhengzengkai@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Zheng zengkai <zhengzengkai@huawei.com>

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/net/ethernet/cavium/thunder/nicvf_queues.c: In function nicvf_sq_free_used_descs:
drivers/net/ethernet/cavium/thunder/nicvf_queues.c:1182:12: warning:
 variable tail set but not used [-Wunused-but-set-variable]

It's not used since commit 4863dea3fab01("net: Adding support for Cavium ThunderX network controller"),
so remove it.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zheng zengkai <zhengzengkai@huawei.com>
---
 drivers/net/ethernet/cavium/thunder/nicvf_queues.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_queues.c b/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
index 4ab57d33a87e..069e7413f1ef 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
@@ -1179,13 +1179,12 @@ void nicvf_sq_disable(struct nicvf *nic, int qidx)
 void nicvf_sq_free_used_descs(struct net_device *netdev, struct snd_queue *sq,
 			      int qidx)
 {
-	u64 head, tail;
+	u64 head;
 	struct sk_buff *skb;
 	struct nicvf *nic = netdev_priv(netdev);
 	struct sq_hdr_subdesc *hdr;
 
 	head = nicvf_queue_reg_read(nic, NIC_QSET_SQ_0_7_HEAD, qidx) >> 4;
-	tail = nicvf_queue_reg_read(nic, NIC_QSET_SQ_0_7_TAIL, qidx) >> 4;
 	while (sq->head != head) {
 		hdr = (struct sq_hdr_subdesc *)GET_SQ_DESC(sq, sq->head);
 		if (hdr->subdesc_type != SQ_DESC_TYPE_HEADER) {
-- 
2.18.1

