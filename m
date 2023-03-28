Return-Path: <bpf-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E69C76195
	for <bpf@archiver.kernel.org>; Tue, 28 Mar 2023 09:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbjC1JaT (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 28 Mar 2023 05:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232580AbjC1J32 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Mar 2023 05:29:28 -0400
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5996A60;
        Tue, 28 Mar 2023 02:29:01 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VeseIC9_1679995737;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VeseIC9_1679995737)
          by smtp.aliyun-inc.com;
          Tue, 28 Mar 2023 17:28:58 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Subject: [PATCH 09/16] virtio_net: introduce virtnet_rq_update_stats()
Date:   Tue, 28 Mar 2023 17:28:40 +0800
Message-Id: <20230328092847.91643-10-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20230328092847.91643-1-xuanzhuo@linux.alibaba.com>
References: <20230328092847.91643-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: e880b402863c
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Separating the code of updating rq stats.

This is prepare for separating the code of ethtool.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio/virtnet.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/net/virtio/virtnet.c b/drivers/net/virtio/virtnet.c
index 84b90333dc77..36c747e43b3f 100644
--- a/drivers/net/virtio/virtnet.c
+++ b/drivers/net/virtio/virtnet.c
@@ -1550,6 +1550,21 @@ static void refill_work(struct work_struct *work)
 	}
 }
 
+static void virtnet_rq_update_stats(struct virtnet_rq *rq, struct virtnet_rq_stats *stats)
+{
+	int i;
+
+	u64_stats_update_begin(&rq->stats.syncp);
+	for (i = 0; i < VIRTNET_RQ_STATS_LEN; i++) {
+		size_t offset = virtnet_rq_stats_desc[i].offset;
+		u64 *item;
+
+		item = (u64 *)((u8 *)&rq->stats + offset);
+		*item += *(u64 *)((u8 *)stats + offset);
+	}
+	u64_stats_update_end(&rq->stats.syncp);
+}
+
 static int virtnet_receive(struct virtnet_rq *rq, int budget,
 			   unsigned int *xdp_xmit)
 {
@@ -1557,7 +1572,6 @@ static int virtnet_receive(struct virtnet_rq *rq, int budget,
 	struct virtnet_rq_stats stats = {};
 	unsigned int len;
 	void *buf;
-	int i;
 
 	if (!vi->big_packets || vi->mergeable_rx_bufs) {
 		void *ctx;
@@ -1584,15 +1598,7 @@ static int virtnet_receive(struct virtnet_rq *rq, int budget,
 		}
 	}
 
-	u64_stats_update_begin(&rq->stats.syncp);
-	for (i = 0; i < VIRTNET_RQ_STATS_LEN; i++) {
-		size_t offset = virtnet_rq_stats_desc[i].offset;
-		u64 *item;
-
-		item = (u64 *)((u8 *)&rq->stats + offset);
-		*item += *(u64 *)((u8 *)&stats + offset);
-	}
-	u64_stats_update_end(&rq->stats.syncp);
+	virtnet_rq_update_stats(rq, &stats);
 
 	return stats.packets;
 }
-- 
2.32.0.3.g01195cf9f

