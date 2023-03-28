Return-Path: <bpf-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15F0C76196
	for <bpf@archiver.kernel.org>; Tue, 28 Mar 2023 09:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbjC1J3z (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 28 Mar 2023 05:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjC1J3Z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Mar 2023 05:29:25 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4946D6A57;
        Tue, 28 Mar 2023 02:28:57 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VesaxbH_1679995733;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VesaxbH_1679995733)
          by smtp.aliyun-inc.com;
          Tue, 28 Mar 2023 17:28:54 +0800
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
Subject: [PATCH 05/16] virtio_net: separate virtnet_ctrl_set_queues()
Date:   Tue, 28 Mar 2023 17:28:36 +0800
Message-Id: <20230328092847.91643-6-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20230328092847.91643-1-xuanzhuo@linux.alibaba.com>
References: <20230328092847.91643-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: e880b402863c
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Separating the code setting queues by cq to a function.

This is to facilitate separating cq-related functions into a separate
file.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio/virtnet.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/net/virtio/virtnet.c b/drivers/net/virtio/virtnet.c
index 3fcf70782d97..0196492f289b 100644
--- a/drivers/net/virtio/virtnet.c
+++ b/drivers/net/virtio/virtnet.c
@@ -2078,19 +2078,25 @@ static void virtnet_ack_link_announce(struct virtnet_info *vi)
 	rtnl_unlock();
 }
 
-static int _virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
+static int virtnet_ctrl_set_queues(struct virtnet_info *vi, u16 queue_pairs)
 {
 	struct scatterlist sg;
+
+	vi->ctrl->mq.virtqueue_pairs = cpu_to_virtio16(vi->vdev, queue_pairs);
+	sg_init_one(&sg, &vi->ctrl->mq, sizeof(vi->ctrl->mq));
+
+	return virtnet_send_command(vi, VIRTIO_NET_CTRL_MQ,
+				    VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET, &sg);
+}
+
+static int _virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
+{
 	struct net_device *dev = vi->dev;
 
 	if (!vi->has_cvq || !virtio_has_feature(vi->vdev, VIRTIO_NET_F_MQ))
 		return 0;
 
-	vi->ctrl->mq.virtqueue_pairs = cpu_to_virtio16(vi->vdev, queue_pairs);
-	sg_init_one(&sg, &vi->ctrl->mq, sizeof(vi->ctrl->mq));
-
-	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_MQ,
-				  VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET, &sg)) {
+	if (!virtnet_ctrl_set_queues(vi, queue_pairs)) {
 		dev_warn(&dev->dev, "Fail to set num of queue pairs to %d\n",
 			 queue_pairs);
 		return -EINVAL;
-- 
2.32.0.3.g01195cf9f

