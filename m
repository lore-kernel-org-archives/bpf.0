Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E38C4167E
	for <bpf@archiver.kernel.org>; Mon, 14 Feb 2022 08:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241690AbiBNIPI (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 14 Feb 2022 03:15:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241692AbiBNIPF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Feb 2022 03:15:05 -0500
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FA75F8FE;
        Mon, 14 Feb 2022 00:14:57 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0V4NGfTX_1644826478;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0V4NGfTX_1644826478)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 14 Feb 2022 16:14:39 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org
Subject: [PATCH v5 20/22] virtio_net: set the default max ring num
Date:   Mon, 14 Feb 2022 16:14:14 +0800
Message-Id: <20220214081416.117695-21-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220214081416.117695-1-xuanzhuo@linux.alibaba.com>
References: <20220214081416.117695-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: 24fd8391539b
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Sets the default maximum ring num based on virtio_set_max_ring_num().

The default maximum ring num is 1024.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index a4ffd7cdf623..77e61fe0b2ce 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -35,6 +35,8 @@ module_param(napi_tx, bool, 0644);
 #define GOOD_PACKET_LEN (ETH_HLEN + VLAN_HLEN + ETH_DATA_LEN)
 #define GOOD_COPY_LEN	128
 
+#define VIRTNET_DEFAULT_MAX_RING_NUM 1024
+
 #define VIRTNET_RX_PAD (NET_IP_ALIGN + NET_SKB_PAD)
 
 /* Amount of XDP headroom to prepend to packets for use by xdp_adjust_head */
@@ -3045,6 +3047,8 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
 			ctx[rxq2vq(i)] = true;
 	}
 
+	virtio_set_max_ring_num(vi->vdev, VIRTNET_DEFAULT_MAX_RING_NUM);
+
 	ret = virtio_find_vqs_ctx(vi->vdev, total_vqs, vqs, callbacks,
 				  names, ctx, NULL);
 	if (ret)
-- 
2.31.0

