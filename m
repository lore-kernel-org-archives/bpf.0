Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC19C433FE
	for <bpf@archiver.kernel.org>; Mon, 14 Feb 2022 08:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241660AbiBNIO6 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 14 Feb 2022 03:14:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241661AbiBNIOv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Feb 2022 03:14:51 -0500
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FCFC6C;
        Mon, 14 Feb 2022 00:14:43 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0V4Oo2Cx_1644826472;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0V4Oo2Cx_1644826472)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 14 Feb 2022 16:14:33 +0800
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
Subject: [PATCH v5 15/22] virtio: queue_reset: add helper
Date:   Mon, 14 Feb 2022 16:14:09 +0800
Message-Id: <20220214081416.117695-16-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220214081416.117695-1-xuanzhuo@linux.alibaba.com>
References: <20220214081416.117695-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: 24fd8391539b
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add helper for virtio queue reset.

* virtio_reset_vq: reset a queue individually
* virtio_enable_resetq: enable a reset queue

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 include/linux/virtio_config.h | 38 +++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 8cde339d40b4..cd7f7f44ce38 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -233,6 +233,44 @@ int virtio_find_vqs_ctx(struct virtio_device *vdev, unsigned nvqs,
 				      desc);
 }
 
+/**
+ * virtio_reset_vq - reset a queue individually
+ * @vq: the virtqueue
+ *
+ * returns 0 on success or error status
+ *
+ * After successfully calling this, be sure to call
+ * virtqueue_detach_unused_buf() to recycle the buffer in the ring, and
+ * then call vring_release_virtqueue() to release the vq ring.
+ *
+ * Caller should guarantee that the vring is not accessed by any functions
+ * of virtqueue.
+ */
+static inline
+int virtio_reset_vq(struct virtqueue *vq)
+{
+	if (!vq->vdev->config->reset_vq)
+		return -ENOENT;
+
+	return vq->vdev->config->reset_vq(vq);
+}
+
+/**
+ * virtio_enable_resetq - enable a reset queue
+ * @vq: the virtqueue
+ *
+ * returns 0 on success or error status
+ *
+ */
+static inline
+int virtio_enable_resetq(struct virtqueue *vq)
+{
+	if (!vq->vdev->config->enable_reset_vq)
+		return -ENOENT;
+
+	return vq->vdev->config->enable_reset_vq(vq);
+}
+
 /**
  * virtio_device_ready - enable vq use in probe function
  * @vdev: the device
-- 
2.31.0

