Return-Path: <bpf-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE6DC77B73
	for <bpf@archiver.kernel.org>; Sun, 23 Apr 2023 10:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjDWK6f (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sun, 23 Apr 2023 06:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjDWK6B (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 23 Apr 2023 06:58:01 -0400
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63EB91997;
        Sun, 23 Apr 2023 03:57:54 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0Vgjkwiz_1682247467;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Vgjkwiz_1682247467)
          by smtp.aliyun-inc.com;
          Sun, 23 Apr 2023 18:57:48 +0800
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
Subject: [PATCH net-next v3 09/15] virtio_net: merge: remove skip_xdp
Date:   Sun, 23 Apr 2023 18:57:30 +0800
Message-Id: <20230423105736.56918-10-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20230423105736.56918-1-xuanzhuo@linux.alibaba.com>
References: <20230423105736.56918-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: 3bb17d92efad
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Now, the logic of merge xdp process is simple, we can remove the
skip_xdp.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index da15f4e75a85..de5a579e8603 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1380,7 +1380,6 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 	struct page *page = virt_to_head_page(buf);
 	int offset = buf - page_address(page);
 	struct sk_buff *head_skb, *curr_skb;
-	struct bpf_prog *xdp_prog;
 	unsigned int truesize = mergeable_ctx_to_truesize(ctx);
 	unsigned int headroom = mergeable_ctx_to_headroom(ctx);
 	unsigned int tailroom = headroom ? sizeof(struct skb_shared_info) : 0;
@@ -1396,22 +1395,20 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 		goto err_skb;
 	}
 
-	if (likely(!vi->xdp_enabled)) {
-		xdp_prog = NULL;
-		goto skip_xdp;
-	}
+	if (unlikely(vi->xdp_enabled)) {
+		struct bpf_prog *xdp_prog;
 
-	rcu_read_lock();
-	xdp_prog = rcu_dereference(rq->xdp_prog);
-	if (xdp_prog) {
-		head_skb = receive_mergeable_xdp(dev, vi, rq, xdp_prog, buf, ctx,
-						 len, xdp_xmit, stats);
+		rcu_read_lock();
+		xdp_prog = rcu_dereference(rq->xdp_prog);
+		if (xdp_prog) {
+			head_skb = receive_mergeable_xdp(dev, vi, rq, xdp_prog, buf, ctx,
+							 len, xdp_xmit, stats);
+			rcu_read_unlock();
+			return head_skb;
+		}
 		rcu_read_unlock();
-		return head_skb;
 	}
-	rcu_read_unlock();
 
-skip_xdp:
 	head_skb = page_to_skb(vi, rq, page, offset, len, truesize, headroom);
 	curr_skb = head_skb;
 
-- 
2.32.0.3.g01195cf9f

