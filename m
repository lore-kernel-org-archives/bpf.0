Return-Path: <bpf-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47707C77B73
	for <bpf@archiver.kernel.org>; Sun, 23 Apr 2023 10:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjDWK6D (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sun, 23 Apr 2023 06:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjDWK55 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 23 Apr 2023 06:57:57 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FF52D7E;
        Sun, 23 Apr 2023 03:57:48 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R931e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VgjhMEi_1682247464;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VgjhMEi_1682247464)
          by smtp.aliyun-inc.com;
          Sun, 23 Apr 2023 18:57:45 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     netdev@vger.kernel.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Subject: [PATCH net-next v3 06/15] virtio_net: separate the logic of freeing the rest mergeable buf
Date:   Sun, 23 Apr 2023 18:57:27 +0800
Message-Id: <20230423105736.56918-7-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20230423105736.56918-1-xuanzhuo@linux.alibaba.com>
References: <20230423105736.56918-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: 3bb17d92efad
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch introduce a new function that frees the rest mergeable buf.
The subsequent patch will reuse this function.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index b4eb083ebf55..5f37a1cef61e 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1067,6 +1067,28 @@ static struct sk_buff *receive_big(struct net_device *dev,
 	return NULL;
 }
 
+static void mergeable_buf_free(struct receive_queue *rq, int num_buf,
+			       struct net_device *dev,
+			       struct virtnet_rq_stats *stats)
+{
+	struct page *page;
+	void *buf;
+	int len;
+
+	while (num_buf-- > 1) {
+		buf = virtqueue_get_buf(rq->vq, &len);
+		if (unlikely(!buf)) {
+			pr_debug("%s: rx error: %d buffers missing\n",
+				 dev->name, num_buf);
+			dev->stats.rx_length_errors++;
+			break;
+		}
+		stats->bytes += len;
+		page = virt_to_head_page(buf);
+		put_page(page);
+	}
+}
+
 /* Why not use xdp_build_skb_from_frame() ?
  * XDP core assumes that xdp frags are PAGE_SIZE in length, while in
  * virtio-net there are 2 points that do not match its requirements:
@@ -1427,18 +1449,8 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 	stats->xdp_drops++;
 err_skb:
 	put_page(page);
-	while (num_buf-- > 1) {
-		buf = virtqueue_get_buf(rq->vq, &len);
-		if (unlikely(!buf)) {
-			pr_debug("%s: rx error: %d buffers missing\n",
-				 dev->name, num_buf);
-			dev->stats.rx_length_errors++;
-			break;
-		}
-		stats->bytes += len;
-		page = virt_to_head_page(buf);
-		put_page(page);
-	}
+	mergeable_buf_free(rq, num_buf, dev, stats);
+
 err_buf:
 	stats->drops++;
 	dev_kfree_skb(head_skb);
-- 
2.32.0.3.g01195cf9f

