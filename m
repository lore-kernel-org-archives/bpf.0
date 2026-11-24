Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795522905;
	b=YPLErUKnkoHdm/6kXqIdzyZ1OQXqdPRPELNHIxM2iQSW7sO48QMeYFOQdd3ldPGmWmbT
	 nBJmP3lNfmPKD3vasv1pjVL727XUtk8oUf8aJlrxNYQbEDkMhGjfUt5CsgZmRF7ZYAfvt
	 XQthsfIoMCQ1PWg0GdboigiBezfLo866/DZ2dPEVhhBz2OQS4L9lnBUGPwIzk+MXL5bxD
	 TIfACQ8WBNdQ2nEc4R5cKwRs5ldk84bcZ8csWuQiu+mTavYA9pFFgH9SzOayVASGEoggV
	 RRZS24jnq4bqjYz9U4nOdhD+bp895EqnIlHWMoUOanxFT7PVsN0sArb5xEOb+fIintA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795522905;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=sug3sIXb6TOC0bj3jtDZIi7xoEwjk6o8BtETfclb6qA=;
	b=2USAXctL4XMcfSngvrDKo4QV7Ql7UNq6T4VsG6jCpR+1noKxcIwPT0hHJ7R8ah1novXY
	 IJcT0CBEWGQkif8k44XNh+PSl28+pttrbIC/FKo9ZQIflFFhuXq+216OO3CKHhSmXkVwR
	 Lb0ikE6jEFXL+4q7k7WJ+9DjQXawMfBj2EKjrYvBWeCnKfoaX5MaIamNfSu0B4PVCVeTW
	 pdW5A5nf5D8JwmyWrjsEbUuE/OWvi6Y9uJpCTwBeDS9YkwXZkJXMG2VLIuv7JUXptG0vL
	 u8cpiqAKJnuLAPMyIJhnHWCBk44eSZtWUKK2Y1Uhvla8f2qgBq1412AWFTLFB/EmWEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bgyGTggW;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=cMy3OPpf;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AA7606A6AE
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 12:21:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06AA7606A6AE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bgyGTggW;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=cMy3OPpf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795522904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sug3sIXb6TOC0bj3jtDZIi7xoEwjk6o8BtETfclb6qA=;
	b=bgyGTggWD+oAFT8m6ORPS4OCJ653ll2PuLk/Ab3CD+7Y5F25DmWsRwApIop56P2hm7xyFQ
	CsQmAKPX0bc0jPeoE02H1O4BqawH7ltRdtttY/qGfqYuGmwU59T+1uN11B0+5ltDpnIUAc
	P+iiBBcaW4YcirqlGe6L55UlJIdhvQU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-AKTiAAXQPJWu4WRsF0uKBQ-1; Tue, 24 Nov 2026 12:21:42 +0000
X-MC-Unique: AKTiAAXQPJWu4WRsF0uKBQ-1
X-Mimecast-MFC-AGG-ID: AKTiAAXQPJWu4WRsF0uKBQ_1795522901
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a80bd45e1cso24488565e9.3
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 04:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795522901; x=1796127701; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sug3sIXb6TOC0bj3jtDZIi7xoEwjk6o8BtETfclb6qA=;
        b=cMy3OPpfxxjHZdDd3wlrrvL96O06eMwf0KtSx2SQ6GOc6h0hz+Rj8HuGiYz5c7aNWE
         CnucRHhia16tqHU6OU83k4SlEH/ZNGnjZ4rXQ1Bk1ejCMji0Jk8g1XEgvFE3xsUQEKoo
         E/MX8IftNers9NLnn5HVLvHWGBfFlf/WFmI+z+3q3RXwimNv9V0DGcdh3ANKaL6KK+9I
         WfQ/9e+LepzuoKnzCwOnFUdWUqfPhCki/LXL7gTB7PahNMdo43FV2NqRE9OR22eNHDs6
         12CNyJUVufnML+O5fZRrdC2O1CUfs5YL0xYlDxVf0qCdyO2w6eF/x36vMoINjkrkSEkN
         qqvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795522901; x=1796127701;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sug3sIXb6TOC0bj3jtDZIi7xoEwjk6o8BtETfclb6qA=;
        b=SEO9H1DZJIU8v/c4AKRty9nyJSnL1CdODgyYfj5JHZVuEryYQYnxxKE9/72KZIkz5M
         D4qM5UNxP528uQ6HLQ2L9qZXXo7i49AvSGz/Cz2uegnhuKBdys8tCibRRK7beINWT5PS
         JrAvnUvPDWh1AlOMFnAVdTZRlOIAeYa5PH8f3kE4KCJlnXh1ZrCsZLDT2i5bIDtklDui
         TINnhLtipeeVdDyROEVnS0XBaqUVw0S3dLELl5/7wIzzkmx3agLL2z/rwpcRPO6WNlx1
         k57af12TsAPp9/IAg6sjiaWJmLj7nFXvIjzCqXJxTveTnTuvvUWt/iXomF5DB4Czj8Qg
         Vm9A==
X-Forwarded-Encrypted: i=1; AL+hErG+lZKGGghXyv5hL6bGdyaFSsKnpfAcNLhN0IXDonpSl/CwhtZNn5T3mINCxuO05POCtCc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+MdA3iuzqCKhpSp9fUd8WKf5eZPREzK8R9A9o/e+mRj2ex0kWU
	oMMalfqyAMzt6IQUaX11g60oyNprOtjeQrkYMZ2kvnWGQWu/SSwjGFS2tSSbHFdriET/Z2hahS6
	Plga9RCvZS256xDTPeTTZuSR5W+4NOphJuYstlyunJkhWsTThQRKH6g==
X-Gm-Gg: AZFdTZfEfaYvkYONx3H34McXF9DuD+mAYd9VRWAN/Nuz46Q/AyXvZDhzrzi1ktU3sWx
	8I9PHJnheU+LXFhcMapVgq3c+YJGxpTTMqI1XUQ6bO7F8WiNH/sWMJiQFix/WIpRrRGFogRdQh6
	JDePkNv2st8sjJyh3Dn+iOXWNNR0wNxpPZOtaC4Gz5aqFBF08OgmJkxOwnhn1eE0s05ndTEj28S
	37cV5N8WJ2gNB0QUPTLFm0nRC2grGF/i9x/x+GWZsT6nE+1p9MCztDZeZae2S33zFalAYtQ1S4d
	E8HYxY2AlYnHfdHNZI83rQITxpzyVDWihU0MGQ2NhBflLRd9QMoRytZ22QQwelk7ATlCTMQXuYD
	KgdKgIgIaI283M7PK1vwsMSQCldaJ3EPrM23Wjpp3FTDodqdoe0uhzIrfM+T+nnkqcaBEOL8c8S
	927Efd9Dd8Vhk=
X-Received: by 2002:a05:600c:670b:b0:4a6:30c3:1114 with SMTP id 5b1f17b1804b1-4bb88922df3mr276003825e9.12.1795522900838;
        Tue, 24 Nov 2026 04:21:40 -0800 (PST)
X-Received: by 2002:a05:600c:670b:b0:4a6:30c3:1114 with SMTP id 5b1f17b1804b1-4bb88922df3mr276003365e9.12.1795522900467;
        Tue, 24 Nov 2026 04:21:40 -0800 (PST)
Received: from [192.168.0.19] (217.red-88-4-146.dynamicip.rima-tde.net. [88.4.146.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b110ba3sm22753198f8f.35.2026.11.24.04.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 04:21:40 -0800 (PST)
From: Sergio Lopez <slp@redhat.com>
Date: Tue, 24 Nov 2026 13:20:23 +0100
Subject: [PATCH RFC v4 5/8] vhost/vsock: negotiate datagram support with
 guests
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-vsock-dgram-support-v4-5-3607484e85e8@redhat.com>
References: <20261124-vsock-dgram-support-v4-0-3607484e85e8@redhat.com>
In-Reply-To: <20261124-vsock-dgram-support-v4-0-3607484e85e8@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, bpf@vger.kernel.org, 
 linux-hyperv@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
 linux-doc@vger.kernel.org, Sashiko AI bot <sashiko-bot@kernel.org>, 
 Sergio Lopez <slp@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6390; i=slp@redhat.com;
 h=from:subject:message-id; bh=aPPGnkG3NRN8zsschNikrnYTRtwAoxBD04k3+bLVY5A=;
 b=owEBbQKS/ZANAwAKAfRpJ40vDAI1AcsmYgBrBYFGF4yM5q7avlFZKV6kU2d6VP1EECVsasY5S
 PmvpH1ob/qJAjMEAAEKAB0WIQS+1fz3US2GgJFC6KL0aSeNLwwCNQUCawWBRgAKCRD0aSeNLwwC
 NaLAEACrirJaOKWRU1EbZZ++DhiyHSznTCGcjrDOYWdLr60c9d5CUj4knGY7ONXawzgLD81/b6g
 0mKjlBlqBi55ipnSitwpkkEr1kGoxSnhnP8LdHEwOuAtxobUuqW88uUw0cqJzMpjqRwElfUAsEJ
 2KK4ko6Twsi2CoZ034N6h8S2Qct3i03TCjjpHy8exxDqMfMeQ9Q34Ua24S4aB/Yv3Gw+s1JFODW
 wvGVzPjSD3a9BltbymuORshWmmOWPMh82hQd+kwX0zw523OqsYePRvMv8jK+AVyTtqQzgk4e7DG
 CrNR8MZkxOTqtPfCWBeBYuT16g5DJvzKfpHvTn8rHPE2knPO7ICM+5KfW/zkxm5suF4zaTUoffa
 zs1qgbzFEoUZWBlcE5I+uo2v6gAXY081CkXnJTpsZ8PpJBCgfZ2FsiZQlGxGzepeO4e/NuKjfd7
 FcmdWiAjncq53kJe3Uq4r96SkkCMZkgr9PTxcraOSKQUx3w1IeLDTkYmlUJz7bRjeql4igG7jw6
 P0dViu2yKIMl5C0iCqk8rUingLToJMhY1AqpMzxkUVIznCpzAchEDglOtbLvMbWawzueQABWsxl
 MpPpvDP8dTPJ79vuyalKT2TNZczcwfgSOiZkp0CNfF7v0vuVLwN++vPypclEShPi9E9ogqJpU7T
 kXR84yhdnX71JCA==
X-Developer-Key: i=slp@redhat.com; a=openpgp;
 fpr=BED5FCF7512D86809142E8A2F469278D2F0C0235

Expose VIRTIO_VSOCK_F_DGRAM in the vhost feature bitmap and retain the
negotiated value for each guest.  Keep datagrams disabled until the
feature is negotiated.

Use a vhost-specific datagram destination check to look up the guest
in the socket's network namespace and require its negotiated datagram
feature. The common virtio implementation supplies the bind and
message operations; destination validation remains in connect() and
sendmsg(), where the remote CID is available.

Reject guest datagrams on ingress unless the receiving virtqueue
acknowledged the feature. Complete rejected descriptors normally so the
queue can continue processing subsequent traffic.

Validate the guest TX header before allocating the skb, and size the
skb from its declared payload length rather than the descriptor chain.
A guest can post a descriptor much larger than the packet it sends.
The old allocation could then create a nonlinear skb whose data_len
exceeds len; a socket filter trimming a datagram could make recvmsg()
read beyond the skb data.

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 drivers/vhost/vsock.c | 66 ++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 44 insertions(+), 22 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 0cb87971d749..767f28794c6b 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -32,7 +32,8 @@
 static const int vhost_vsock_bits[] = {
 	VHOST_FEATURES,
 	VIRTIO_F_ACCESS_PLATFORM,
-	VIRTIO_VSOCK_F_SEQPACKET
+	VIRTIO_VSOCK_F_SEQPACKET,
+	VIRTIO_VSOCK_F_DGRAM,
 };
 
 #define VHOST_VSOCK_FEATURES VHOST_FEATURES_U64(vhost_vsock_bits, 0)
@@ -62,6 +63,7 @@ struct vhost_vsock {
 	u32 guest_cid;
 	bool seqpacket_allow;
 	bool ever_started; /* set on first SET_RUNNING(1); never cleared */
+	bool dgram_allow;
 };
 
 static u32 vhost_transport_get_local_cid(void)
@@ -360,7 +362,7 @@ static struct sk_buff *
 vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
 		      unsigned int out, unsigned int in)
 {
-	struct virtio_vsock_hdr *hdr;
+	struct virtio_vsock_hdr hdr;
 	struct iov_iter iov_iter;
 	struct sk_buff *skb;
 	size_t payload_len;
@@ -378,34 +380,30 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
 	    len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE + VIRTIO_VSOCK_SKB_HEADROOM)
 		return NULL;
 
-	/* len contains both payload and hdr */
-	skb = virtio_vsock_alloc_skb(len, GFP_KERNEL);
-	if (!skb)
-		return NULL;
-
 	iov_iter_init(&iov_iter, ITER_SOURCE, vq->iov, out, len);
 
-	hdr = virtio_vsock_hdr(skb);
-	nbytes = copy_from_iter(hdr, sizeof(*hdr), &iov_iter);
-	if (nbytes != sizeof(*hdr)) {
+	nbytes = copy_from_iter(&hdr, sizeof(hdr), &iov_iter);
+	if (nbytes != sizeof(hdr)) {
 		vq_err(vq, "Expected %zu bytes for pkt->hdr, got %zu bytes\n",
-		       sizeof(*hdr), nbytes);
-		kfree_skb(skb);
+		       sizeof(hdr), nbytes);
 		return NULL;
 	}
 
-	payload_len = le32_to_cpu(hdr->len);
+	payload_len = le32_to_cpu(hdr.len);
+
+	/* The pkt is too big or the length in the header is invalid */
+	if (payload_len > len - sizeof(hdr))
+		return NULL;
+
+	skb = virtio_vsock_alloc_skb(sizeof(hdr) + payload_len, GFP_KERNEL);
+	if (!skb)
+		return NULL;
+	*virtio_vsock_hdr(skb) = hdr;
 
 	/* No payload */
 	if (!payload_len)
 		return skb;
 
-	/* The pkt is too big or the length in the header is invalid */
-	if (payload_len + sizeof(*hdr) > len) {
-		kfree_skb(skb);
-		return NULL;
-	}
-
 	virtio_vsock_skb_put(skb, payload_len);
 
 	if (skb_copy_datagram_from_iter(skb, 0, &iov_iter, payload_len)) {
@@ -436,6 +434,8 @@ static bool vhost_transport_msgzerocopy_allow(void)
 
 static bool vhost_transport_seqpacket_allow(struct vsock_sock *vsk,
 					    u32 remote_cid);
+static bool vhost_transport_dgram_allow(struct vsock_sock *vsk,
+					u32 cid, u32 port);
 
 static bool
 vhost_transport_stream_allow(struct vsock_sock *vsk, u32 cid, u32 port)
@@ -460,7 +460,7 @@ static struct virtio_transport vhost_transport = {
 		.dgram_enqueue            = virtio_transport_dgram_enqueue,
 		.dgram_dequeue            = virtio_transport_dgram_dequeue,
 		.dgram_bind               = virtio_transport_dgram_bind,
-		.dgram_allow              = virtio_transport_dgram_allow,
+		.dgram_allow              = vhost_transport_dgram_allow,
 
 		.stream_enqueue           = virtio_transport_stream_enqueue,
 		.stream_dequeue           = virtio_transport_stream_dequeue,
@@ -516,6 +516,24 @@ static bool vhost_transport_seqpacket_allow(struct vsock_sock *vsk,
 	return seqpacket_allow;
 }
 
+static bool vhost_transport_dgram_allow(struct vsock_sock *vsk,
+					u32 cid, u32 port)
+{
+	struct net *net = sock_net(sk_vsock(vsk));
+	struct vhost_vsock *vsock;
+	bool dgram_allow = false;
+
+	rcu_read_lock();
+	vsock = vhost_vsock_get(cid, net);
+
+	if (vsock)
+		dgram_allow = vsock->dgram_allow;
+
+	rcu_read_unlock();
+
+	return dgram_allow;
+}
+
 static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
 {
 	struct vhost_virtqueue *vq = container_of(work, struct vhost_virtqueue,
@@ -573,10 +591,12 @@ static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
 
 		hdr = virtio_vsock_hdr(skb);
 
-		/* Only accept correctly addressed packets */
+		/* Check addressing and datagram feature negotiation. */
 		if (le64_to_cpu(hdr->src_cid) == vsock->guest_cid &&
 		    le64_to_cpu(hdr->dst_cid) ==
-		    vhost_transport_get_local_cid())
+		    vhost_transport_get_local_cid() &&
+		    (le16_to_cpu(hdr->type) != VIRTIO_VSOCK_TYPE_DGRAM ||
+		     vhost_has_feature(vq, VIRTIO_VSOCK_F_DGRAM)))
 			virtio_transport_recv_pkt(&vhost_transport, skb,
 						  vsock->net);
 		else
@@ -737,6 +757,7 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
 	vsock->guest_cid = 0; /* no CID assigned yet */
 	vsock->seqpacket_allow = false;
 	vsock->ever_started = false;
+	vsock->dgram_allow = false;
 
 	atomic_set(&vsock->queued_replies, 0);
 
@@ -890,6 +911,7 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
 	}
 
 	vsock->seqpacket_allow = features & (1ULL << VIRTIO_VSOCK_F_SEQPACKET);
+	vsock->dgram_allow = features & (1ULL << VIRTIO_VSOCK_F_DGRAM);
 
 	for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++) {
 		vq = &vsock->vqs[i];

-- 
2.56.0

