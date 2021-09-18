Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E6B5C433EF
	for <bpf@archiver.kernel.org>; Sat, 18 Sep 2021 06:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34C4E61039
	for <bpf@archiver.kernel.org>; Sat, 18 Sep 2021 06:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233889AbhIRGHm (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 18 Sep 2021 02:07:42 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:49713 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233286AbhIRGHl (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 18 Sep 2021 02:07:41 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0UolKcM4_1631945175;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0UolKcM4_1631945175)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 18 Sep 2021 14:06:15 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     netdev@vger.kernel.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Subject: [PATCH net-next] virtio_net: use netdev_warn_once to output warn when without enough queues
Date:   Sat, 18 Sep 2021 14:06:15 +0800
Message-Id: <20210918060615.8508-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This warning is output when virtnet does not have enough queues, but it
only needs to be printed once to inform the user of this situation. It
is not necessary to print it every time. If the user loads xdp
frequently, this log appears too much.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 271d38c1d9f8..34f20993ba6b 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2530,8 +2530,8 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 
 	/* XDP requires extra queues for XDP_TX */
 	if (curr_qp + xdp_qp > vi->max_queue_pairs) {
-		netdev_warn(dev, "XDP request %i queues but max is %i. XDP_TX and XDP_REDIRECT will operate in a slower locked tx mode.\n",
-			    curr_qp + xdp_qp, vi->max_queue_pairs);
+		netdev_warn_once(dev, "XDP request %i queues but max is %i. XDP_TX and XDP_REDIRECT will operate in a slower locked tx mode.\n",
+				 curr_qp + xdp_qp, vi->max_queue_pairs);
 		xdp_qp = 0;
 	}
 
-- 
2.31.0

