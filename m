Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5481DC433F5
	for <bpf@archiver.kernel.org>; Mon, 14 Feb 2022 08:14:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235510AbiBNIOi (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 14 Feb 2022 03:14:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241614AbiBNIOh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Feb 2022 03:14:37 -0500
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0004F5F8F8;
        Mon, 14 Feb 2022 00:14:28 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0V4Oo2BN_1644826464;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0V4Oo2BN_1644826464)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 14 Feb 2022 16:14:24 +0800
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
Subject: [PATCH v5 07/22] virtio_ring: queue_reset: extract the release function of the vq ring
Date:   Mon, 14 Feb 2022 16:14:01 +0800
Message-Id: <20220214081416.117695-8-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220214081416.117695-1-xuanzhuo@linux.alibaba.com>
References: <20220214081416.117695-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: 24fd8391539b
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Extract a function __vring_del_virtqueue() from vring_del_virtqueue() to
handle releasing vq's ring.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 20659f7ca582..c5dd17c7dd4a 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2355,12 +2355,10 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
 }
 EXPORT_SYMBOL_GPL(vring_new_virtqueue);
 
-void vring_del_virtqueue(struct virtqueue *_vq)
+static void __vring_del_virtqueue(struct vring_virtqueue *vq)
 {
-	struct vring_virtqueue *vq = to_vvq(_vq);
-
 	spin_lock(&vq->vq.vdev->vqs_list_lock);
-	list_del(&_vq->list);
+	list_del(&vq->vq.list);
 	spin_unlock(&vq->vq.vdev->vqs_list_lock);
 
 	if (vq->we_own_ring) {
@@ -2393,6 +2391,13 @@ void vring_del_virtqueue(struct virtqueue *_vq)
 		kfree(vq->split.desc_state);
 		kfree(vq->split.desc_extra);
 	}
+}
+
+void vring_del_virtqueue(struct virtqueue *_vq)
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+
+	__vring_del_virtqueue(vq);
 	kfree(vq);
 }
 EXPORT_SYMBOL_GPL(vring_del_virtqueue);
-- 
2.31.0

