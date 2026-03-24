Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14295402457
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 15:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774365364; cv=none; b=oqz3ZOlj36HT7T/Z8Hf2T9boy5RNAHb//rba33QnqNmJuZo8hVRAQ1kCPPCsuiq1nxxA6DWbwx7u17sH1uQItY3+JNpuQ7wVVIlLtnvk4qA4UdSogf6FGCqeYszSf+N3pJD5AsZ8LfxmKhh+4sZcIekTb5JGwE4gT/FWYmnrfwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774365364; c=relaxed/simple;
	bh=0DAQT5hcnfFP7UoqaO6an4vhVS498McC5K6b/zfmBDc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uxAf9pkHW5aTswcSMwBpjOuy6gle6aBVuBPEGBPt8liS245yhjEGxWshkyHdhsq8lJLRS/zEdVpe1vZN8QZ1kNLgHYp17xncTNsCAAsfNZYRBELMwSGCACyek8x8UFIp8fjBRM4Q2Dt2Ef5KpeJjMtbqwe7LlJEzWOMqOlVQFCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aiLzUFxq; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cTiqyWVX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aiLzUFxq";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cTiqyWVX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774365362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=zZaZ+weNFt/DeQ+y853Qd9D2vVvyy8X2coFZA5Jbyn4=;
	b=aiLzUFxqsNzOqiPzOuCFGZYF1UY1Ap+iQO1TIkL2565e1VRlvo/2BvTTQDfWYZK1cH2hHG
	xPn6qqwyOuIxGNIHQz8tjsIlqtUQf5+/x166ipaddTWfLwiL5GTTCop1gQSF34pdeCRFVP
	Ph1wl3cXE86xlFq6Q6hYUctOScYePfQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-Zijp1AjKPxiZwEtw_II0cQ-1; Tue, 24 Mar 2026 11:15:59 -0400
X-MC-Unique: Zijp1AjKPxiZwEtw_II0cQ-1
X-Mimecast-MFC-AGG-ID: Zijp1AjKPxiZwEtw_II0cQ_1774365358
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-485c45885e6so59102065e9.0
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 08:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774365358; x=1774970158; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zZaZ+weNFt/DeQ+y853Qd9D2vVvyy8X2coFZA5Jbyn4=;
        b=cTiqyWVXW6ThVGdsO/WivvYGEgD6vRr7fw2tex9trBb2cD0cjZKTxMvfrGnfsgqqTK
         /VKFxciS1+PIN2pALJ/ziWHPHTRdfnZpBzArKkQ9NTNNCx2rQV/YSBWux1XMKJscM1Ic
         1YOh1lo3hiRKu107RYjOKZ+upuhu9sRLuh6K5EYCkVbxA+PSutogn/8UFnpN9vPm3g5z
         JpOI3uTeBvxy6aQg6DPyBrBJUSzkCTiIkoTFQvwknPUPJM8rUrwsh3n2vCEz0aXUkTvT
         LyHiWBdqED0nxjCgfZvE5wyAeRBxq0BhZ5YXK1bt60GQVk+dZDr9CcCSljExBUWlzNzM
         610g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774365358; x=1774970158;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zZaZ+weNFt/DeQ+y853Qd9D2vVvyy8X2coFZA5Jbyn4=;
        b=rUgv5eRjZwMbT3eXflE6PNZFOkoMUJ4GMl4fjCTwRCg/jPVAxMNxlagZhgMtYrv55V
         Y+JhNMYTCI90/nI2itMfAhTZSWHTD8u+N7mdHE0Bcv07B//n6/DKKTGJLADpxW4Bd1Dh
         zEkcSgZ1V85EUvtDuyxDB7Zk503+1Fdt2BNx2WQdCPEXmKLNipftCHgsCCKjAYKgZEDv
         2PF0kDEq7ScIpZBCy0OX/ERPm0VN/hoCN5px65fZy9ulfejcbHvvGeIuTl1ilG32Djl9
         34T2/R6ub1SyyfBOQ7iuzxjc9tnhgGcST9OcAzkObtnkEJ7QLJ1xY//NVV5zZAFacf3G
         JY1Q==
X-Forwarded-Encrypted: i=1; AJvYcCU6uaJsZHuGTbiRgQwI9Z3z+ZwsCuZgvRP4CwaFLp5uZ/ubGdCiRhqP55Juajj+bMLb1vA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyfM+Rsyth5sgj8j3XBcx6YfAhQUMiUvS15BkR6OR0VXtSqkSe
	lyZ3yIrKVdNU4V6nl80DLjUEG5HWY3wC7qT4fAOhhpcUCQ0VCrDzyeZOjciwMlpahP+5jG3SpFD
	2yzFKpVjIHP8bIWdeKXdlKv1U8fyNLSjbDh/6Iw1SeBuW4AqVEODU2A==
X-Gm-Gg: ATEYQzx5d0iu3WSYQHELI+Ku5Cs2L7p568ku9+2oQCIeqqRKKGgCIOiBUP5fF9NATOI
	Jg8JmXeGw0EpsemABDkcVBc0CFVsW98f660o2ED6iZc5dvJ0xKSm/wRbl4trQ66XyPQsnzNBEIz
	sm44eSrKOd2XqHQH58/Nyr28imBIo0/XrtW1v22dFlWSJsgqSNjvSzO9m8Eu9RdVdh7V5vkvq1Y
	4ZNclD99BV2//o0AYo3qTj19tIIChvKL5EskvPRUI5ppT39pKk7FVayuY3rGR+cvkPIWOvT6sNS
	wMj6qXC75PyM8RHza+gwIzVC5bYxqsXdu1usTxSk4AxHSkbsNRCIMnv78enlnESFJJ6xJfJDnTp
	GDi6hukwpGfvlVK9/
X-Received: by 2002:a05:600c:5296:b0:486:ffa3:593 with SMTP id 5b1f17b1804b1-4871606730amr1910415e9.28.1774365358068;
        Tue, 24 Mar 2026 08:15:58 -0700 (PDT)
X-Received: by 2002:a05:600c:5296:b0:486:ffa3:593 with SMTP id 5b1f17b1804b1-4871606730amr1909895e9.28.1774365357596;
        Tue, 24 Mar 2026 08:15:57 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1525:da00:3ac2:1a22:72ff:4256])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487116d82f1sm55500765e9.11.2026.03.24.08.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 08:15:57 -0700 (PDT)
Date: Tue, 24 Mar 2026 11:15:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Omar Elghoul <oelghoul@linux.ibm.com>,
	Srikanth Aithal <sraithal@amd.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Vishwanath Seshagiri <vishs@meta.com>, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, bpf@vger.kernel.org
Subject: [PATCH net-next] virtio_net: sync RX buffer before reading the header
Message-ID: <f4caa9be9e5addae7851c012cab0a733be7f0974.1774365273.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent

receive_buf() reads the virtio header through buf before
page_pool_dma_sync_for_cpu() runs in receive_small() or
receive_mergeable(). The header buffer is thus unsynchronized at the
point where flags and, for mergeable buffers, num_buffers are consumed.

Omar Elghoul reported that on s390x Secure Execution this showed up as
greatly reduced virtio-net performance together with "bad gso" and
"bad csum" messages in dmesg. This is because with SE sync actually
copies data, so the header is uninitialized.

Move the sync into receive_buf() so the
header is synchronized before any access through buf.

Tool use: Cursor with GPT-5.4 drafted the initial code move from prompt:
"in drivers/net/virtio_net.c, move page_pool_dma_sync_for_cpu on receive
path to before memory is accessed through buf".
The result and the commit log were reviewed and edited manually.

Fixes: 168b61da6871 ("virtio_net: add page_pool support for buffer allocation")
Reported-by: Omar Elghoul <oelghoul@linux.ibm.com>
Tested-by: Srikanth Aithal <sraithal@amd.com>
Tested-by: Omar Elghoul <oelghoul@linux.ibm.com>
Link: https://lore.kernel.org/r/20260323150136.14452-1-oelghoul@linux.ibm.com
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/net/virtio_net.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 97035b49bae7..2f57245c682d 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1956,13 +1956,6 @@ static struct sk_buff *receive_small(struct net_device *dev,
 	 */
 	buf -= VIRTNET_RX_PAD + xdp_headroom;
 
-	if (rq->use_page_pool_dma) {
-		int offset = buf - page_address(page) +
-			     VIRTNET_RX_PAD + xdp_headroom;
-
-		page_pool_dma_sync_for_cpu(rq->page_pool, page, offset, len);
-	}
-
 	len -= vi->hdr_len;
 	u64_stats_add(&stats->bytes, len);
 
@@ -2398,9 +2391,6 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 
 	head_skb = NULL;
 
-	if (rq->use_page_pool_dma)
-		page_pool_dma_sync_for_cpu(rq->page_pool, page, offset, len);
-
 	u64_stats_add(&stats->bytes, len - vi->hdr_len);
 
 	if (check_mergeable_len(dev, ctx, len))
@@ -2563,6 +2553,16 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
 		return;
 	}
 
+	/* Sync the memory before touching anything through buf,
+	 * unless virtio core did it already.
+	 */
+	if (rq->use_page_pool_dma) {
+		struct page *page = virt_to_head_page(buf);
+		int offset = buf - page_address(page);
+
+		page_pool_dma_sync_for_cpu(rq->page_pool, page, offset, len);
+	}
+
 	/* About the flags below:
 	 * 1. Save the flags early, as the XDP program might overwrite them.
 	 * These flags ensure packets marked as VIRTIO_NET_HDR_F_DATA_VALID
-- 
MST

