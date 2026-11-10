Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794296192;
	b=TyVeGWESF6D+qN6nJ0NaA5ZnBgLBg5W6ibSmc7upRCmjxkI8sRQO3wQpLtgXEiO+fawC
	 8ZPEkM8PHTDL/fd5jXtLlkpMqOOuo8/DzxciBJo8vaDqYGYSMud6ZfV49GLbwR1ICWHbq
	 KLLofFUdfPZVCDnz4jiyxMxQrYKuO80lyfngook+KmyubcEbxfMWu3Cd7o5SiFE69sQUh
	 Ga6lJh/PObIDkXvC0yZF5r8YTKArYHlswUoIBcEdSl8JgAhKOYQN0xnJmuqUkAd6v5ct4
	 2njaw3kxKcfn44STAlDpGPGH0mk9OgnhvmNIJU5Ond216yC0HH4nQPxxY2wFz1rIeDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794296192;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=w28p4hLU+RTP4FheCaCDlrPaq5T0brMSRYM4zl5KN9Y=;
	b=xGZLuiVXJf2OYB3nMiF2K59UP/GVEhpAoSNA624qmy68IzsWyiJvpirPCGel9D06AKWy
	 upVLgnJ7pv0vkOqyDdoVJzRGVFVNRbpWFNawmVhwRlDIMEJQLX2MOlBbvMn/tyAGUnY/u
	 LsiFITWwgreu2KYpqisxbLEQ1rQZh7PjoFdleIuiw+UWgjROe1/39oREbvZcHQB593ZB/
	 1QQJYU0W9xPEP/N8j+M9A43iP/7T2XSOlEGFFJXahgS4HpHC28eXqidvBfHMUmUbh+Lgs
	 Zw/NdPc623Rs8Bc4skc1cHIBSYQGHkmk89dCLgdD8kLyEvDLKVxcUN6rQGCcILtsArw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=ovJWfBMv;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29338606A33F;
	Tue, 10 Nov 2026 07:36:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29338606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=ovJWfBMv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=ovJWfBMvfQFgoxfAaGrWLNK2qa4v4h9vKJuA5vHr+Sh/8NG+LT5PCdDLVfeQQhx9dOSv3mutY7Yhg
	 eQvqRrTLkmMfnOHfWsDBAXKYw1NG1Ye74Ag4HvPTuw5P8vVwpM577XRlScEpLi4m1p1O8Y3V/KAKhg
	 bKG3KhOGmGV7vV+k=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee56af2c97c786-c9cf7;
	Tue, 10 Nov 2026 15:36:29 +0800 (CST)
X-RM-TRANSID:2ee56af2c97c786-c9cf7
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from  (unknown[74.82.203.40])
	by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee36af2c970885-ab732;
	Tue, 10 Nov 2026 15:36:29 +0800 (CST)
X-RM-TRANSID:2ee36af2c970885-ab732
From: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3 1/2] virtio_net: Don't DMA map the kernel image for the AF_XDP TX header
Date: Wed, 11 Nov 2026 00:30:00 +0900
Message-ID: <20261110153003.23731-2-yanhaishuang@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110153003.23731-1-yanhaishuang@cmss.chinamobile.com>
References: <20261110153003.23731-1-yanhaishuang@cmss.chinamobile.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtnet_xsk_pool_enable() DMA maps the static xsk_hdr, which lives in
the kernel image. On arm64 the kernel image is mapped in the vmalloc
area, so when the device uses the DMA API the mapping is rejected:

  virtio_net virtio0: rejecting DMA map of vmalloc memory
  WARNING: drivers/virtio/virtio_ring.c:3882 ...

and binding an AF_XDP zero-copy socket fails with -ENOMEM.

Allocate the all-zero header per send queue when the pool is enabled
and free it when it is disabled.

This was found while testing AF_XDP in QEMU on arm64, not in
production. Tested in QEMU (TCG, arm64 virt, virtio-net-pci with
iommu_platform=on) with a KASAN kernel: binding an XDP_ZEROCOPY socket
fails without this patch and succeeds with it.

Fixes: 21a4e3ce6dc7 ("virtio_net: xsk: bind/unbind xsk for tx")
Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
---
 drivers/net/virtio_net.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index dd2c41ef6fbe..4f5d8812f75b 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -315,6 +315,8 @@ struct send_queue {
 
 	struct xsk_buff_pool *xsk_pool;
 
+	/* All-zero header shared by the AF_XDP packets sent on this queue */
+	struct virtio_net_common_hdr *xsk_hdr;
 	dma_addr_t xsk_hdr_dma_addr;
 };
 
@@ -500,8 +502,6 @@ struct virtio_net_common_hdr {
 	};
 };
 
-static struct virtio_net_common_hdr xsk_hdr;
-
 static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
 static void virtnet_sq_free_unused_buf_done(struct virtqueue *vq);
 static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
@@ -5971,11 +5971,21 @@ static int virtnet_xsk_pool_enable(struct net_device *dev,
 	if (!rq->xsk_buffs)
 		return -ENOMEM;
 
-	hdr_dma = virtqueue_map_single_attrs(sq->vq, &xsk_hdr, vi->hdr_len,
+	/*
+	 * Don't map a static header: the kernel image is not in the linear
+	 * map on all architectures (e.g. arm64), so it can't be DMA mapped.
+	 */
+	sq->xsk_hdr = kzalloc_obj(*sq->xsk_hdr);
+	if (!sq->xsk_hdr) {
+		err = -ENOMEM;
+		goto err_free_buffs;
+	}
+
+	hdr_dma = virtqueue_map_single_attrs(sq->vq, sq->xsk_hdr, vi->hdr_len,
 					     DMA_TO_DEVICE, 0);
 	if (virtqueue_map_mapping_error(sq->vq, hdr_dma)) {
 		err = -ENOMEM;
-		goto err_free_buffs;
+		goto err_free_hdr;
 	}
 
 	err = xsk_pool_dma_map(pool, dma_dev, 0);
@@ -6004,6 +6014,9 @@ static int virtnet_xsk_pool_enable(struct net_device *dev,
 err_xsk_map:
 	virtqueue_unmap_single_attrs(rq->vq, hdr_dma, vi->hdr_len,
 				     DMA_TO_DEVICE, 0);
+err_free_hdr:
+	kfree(sq->xsk_hdr);
+	sq->xsk_hdr = NULL;
 err_free_buffs:
 	kvfree(rq->xsk_buffs);
 	return err;
@@ -6032,6 +6045,8 @@ static int virtnet_xsk_pool_disable(struct net_device *dev, u16 qid)
 
 	virtqueue_unmap_single_attrs(sq->vq, sq->xsk_hdr_dma_addr,
 				     vi->hdr_len, DMA_TO_DEVICE, 0);
+	kfree(sq->xsk_hdr);
+	sq->xsk_hdr = NULL;
 	kvfree(rq->xsk_buffs);
 
 	return err;

base-commit: 1d5e2c57e9ffc134e14b3f837c8d7c53b508bd22
-- 
2.43.0



