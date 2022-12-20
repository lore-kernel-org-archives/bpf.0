Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7436C4332F
	for <bpf@archiver.kernel.org>; Tue, 20 Dec 2022 14:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233849AbiLTOPD (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 20 Dec 2022 09:15:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233829AbiLTOPA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Dec 2022 09:15:00 -0500
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48D8E4F;
        Tue, 20 Dec 2022 06:14:58 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R341e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VXluX-k_1671545693;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0VXluX-k_1671545693)
          by smtp.aliyun-inc.com;
          Tue, 20 Dec 2022 22:14:53 +0800
From:   Heng Qi <hengqi@linux.alibaba.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH v2 3/9] virtio_net: update bytes calculation for xdp_frame
Date:   Tue, 20 Dec 2022 22:14:43 +0800
Message-Id: <20221220141449.115918-4-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20221220141449.115918-1-hengqi@linux.alibaba.com>
References: <20221220141449.115918-1-hengqi@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Update relative record value for xdp_frame as basis
for multi-buffer xdp transmission.

Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index c5c4e9db4ed3..08f209d7b0bf 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -658,7 +658,7 @@ static int virtnet_xdp_xmit(struct net_device *dev,
 		if (likely(is_xdp_frame(ptr))) {
 			struct xdp_frame *frame = ptr_to_xdp(ptr);
 
-			bytes += frame->len;
+			bytes += xdp_get_frame_len(frame);
 			xdp_return_frame(frame);
 		} else {
 			struct sk_buff *skb = ptr;
@@ -1604,7 +1604,7 @@ static void free_old_xmit_skbs(struct send_queue *sq, bool in_napi)
 		} else {
 			struct xdp_frame *frame = ptr_to_xdp(ptr);
 
-			bytes += frame->len;
+			bytes += xdp_get_frame_len(frame);
 			xdp_return_frame(frame);
 		}
 		packets++;
-- 
2.19.1.6.gb485710b

