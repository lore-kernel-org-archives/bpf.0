Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795522904;
	b=m45S95Hdh36fmmUp2J1fPcB9v4IOyayOEH/2UtojcnfZfUS6hKbz/bsOIqlmKEAJcxDZ
	 GadQXcZRj57vNxgaASanrYf/j+Y+2E4nI82lmwTTsYxt+KMpyupylP2RLcgAp/pCn0sV6
	 USThFdjIHfWI8RXhDBV4GjcPcJTwUvxJQTTr5YYLLcX4WEuJX0qETjtsZruRPiO6Vq8VP
	 joaxkRETB6WAQZB4WGGoJ7Dywiv9pnsSJM75Ol1ioTAaoS4HR8kO2t5dMBDMZv9wcYLmW
	 WWp887+pMYUymVrR4g4XF+4UGNGBcp9hJqLmzlgVTKOcArfm+x6guhkq6Kjnp1aSlNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795522904;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=kRsJjjCDtc2CMBY4DZcEpFvNQQYyCSaW8arjfgYBJKM=;
	b=K+j1DBssuXd0rKP2DjEicAXwgfOHj9Jb1F8fQpcXWC9AAWsVhuxmrgoJ89OHk0IvTNyB
	 rgXtPpA/Eg1iLs0a1M94vpTcvXehL/7pkITBTEpixYO/TNwnOLwC9v3JwXRqRh7dGRxHH
	 YD6e99mbRid7xL/CfJhAG1oI57WnQ7jLAG3pe37sTS5wJwU5awl6No9XZYCt71tSfrKcW
	 cmAd3uHcHm9uOK3cGjnaRzFdph+2gQJeGAa7vh8n7OoXjn87aK++h8IfjPlk6FaYHXAE9
	 YuFoodmSobfjsLYOiY/8rvGiMjzrjXsfGRBsqG4lzyXdSnWUzjwk6EYNDHD3stq+JIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LAE3OTZJ;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=IGGOKaGg;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EE760A2611
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 12:21:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74EE760A2611
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LAE3OTZJ;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=IGGOKaGg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795522902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kRsJjjCDtc2CMBY4DZcEpFvNQQYyCSaW8arjfgYBJKM=;
	b=LAE3OTZJ94O9zADbvv78EnaJe8hSRtPzqrVWOuKLuospb0p7Ee/QaRtyC3ci4W1EFYT7fV
	PMYAM5/Rp17YDJXfHuvR5vpxH3Pa/RZXRlQBe6kQtGq44WIkdv+1ezPj59Z6CUjg+DHSfX
	UcT5mfeOGl5i5AZayIPJmCRAWg6zp6w=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-baZKbOfbMmWs8lDVjmhqQw-1; Tue, 24 Nov 2026 12:21:40 +0000
X-MC-Unique: baZKbOfbMmWs8lDVjmhqQw-1
X-Mimecast-MFC-AGG-ID: baZKbOfbMmWs8lDVjmhqQw_1795522899
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-499ca65ae87so1904977f8f.1
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 04:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795522899; x=1796127699; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kRsJjjCDtc2CMBY4DZcEpFvNQQYyCSaW8arjfgYBJKM=;
        b=IGGOKaGgnYTZC6uMNFphgEaAiBl+z7Ib/AzDlnlGJ/DneRYZzlK3fk9JXe+54ZSCdE
         KgaQ8QrsY3sctpasdziJODIS0SXAZqfY9wIHBPVwoB/40+5r8nJYemWV51OgiqsCCU/9
         epJDChCCnpOkqpuzXRQ5E+xKM4FwXGPWD0L1TCxO/12cUNR3qfHfogbIEO2h8nYin5fO
         5iazUkzKhxBkJvxNBtg5Je+Dt/9x8JGT75HmJUtNK5qdZFeEYcTIr/P6cf0pL6Me03sm
         gbHgYJyqtOOCLpEyPePrsmV6si1lQWN57cA20LZs9dwTIuqjUeT0TF26LEi4dXJmqT1V
         VaWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795522899; x=1796127699;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kRsJjjCDtc2CMBY4DZcEpFvNQQYyCSaW8arjfgYBJKM=;
        b=ZctVCvWEsodpxl4b1rfIJ1o8pM8uFPHYkjMpvgo1XbwE0qywqQQ6m74m9oAzY+s31X
         v6wRiFuHoT2+qxFHjIFT/JHjw/RS9tItf9E37KZu4Di8HH6TVv+xjYDCcIagFkeW7vM0
         z51W61VEStGMCiQ3v3iNe0k2u8/2nBm5RZ7abIrq21whQtuGA2zl2Ll9ospXdKY6+yc8
         WRSfakha06Yk87evZ2883jMZUWsrjmh8L4RgS6Bar6tMt2tNf3uD4xmypRw436r5CJxC
         0ssnnIWK0EbLB58iRYPQIXUwBkO+htK73q9IHCr+YwKKSHclmSjbhTlsSkZSd9v/bqq2
         qgjw==
X-Forwarded-Encrypted: i=1; AL+hErHXGIJRCrxKUMgnExUOxu3FBo5naRnffiBBm4j7k83OUYOTMxLSbnpeDFcYznxFGyn5Qao=@vger.kernel.org
X-Gm-Message-State: APuU4Z8HUWl3FeTvDRjQSRcNHyJYvHM5+nuoXAcBlkh6KSh16YfATbhI
	1Brhk75y852L4kabok8ltNk1H+LaQOEzb1AK3luqjTMnj/2XAYD2bxXpijFJGdq0ge2msN5p3wr
	QJc1JZXXgq1Hbox+s1qZRALI6QJTffJwBKytGtSPnag7DGihGM6xX9A==
X-Gm-Gg: AZFdTZcGsaP9l69vdpCg6Lt7ksjQ0bnu91uAGBqzXQEDmg4pUbPwzK5Pt27DDbZG8i+
	o+gCMyYGC5X2ZDFk5pt1TUlrm2QvL+2PiGadCRv4pHQX5OAt0jFAwBGkFQoASwOGBWaqpZ5Ovsz
	H7jqH9YfiWHZOVLWgdglZO4Pk8GciFRmoUFTkLOCIbNMg79YJu7f9y2A3fxGVciKmgzfOvlNIx6
	IUmr6ADb5o66c+q7xTOnJ8QUofoiO4c1jHnRtMcngPltllS7QCujKzXQ7HMY4x4w+W8OxETiEv3
	tETzklQ/FrefX7sovB+aC+5bQjYJJIShaX/bQim+6qwTGEllrsyQrR6Exc5CTkzDqlBXLjAyrnH
	XAQXqhzKdUsUnotoDHOGtlAmvOQT0tKhBDDIpHFgAwJK5rRBS9RICwbkF0jsy+sleQ/cVR2Te2g
	OqIGAz9+Yi5wE=
X-Received: by 2002:a05:6000:2383:b0:492:aff5:da4d with SMTP id ffacd0b85a97d-4aa545e244fmr41056254f8f.7.1795522899300;
        Tue, 24 Nov 2026 04:21:39 -0800 (PST)
X-Received: by 2002:a05:6000:2383:b0:492:aff5:da4d with SMTP id ffacd0b85a97d-4aa545e244fmr41056186f8f.7.1795522898891;
        Tue, 24 Nov 2026 04:21:38 -0800 (PST)
Received: from [192.168.0.19] (217.red-88-4-146.dynamicip.rima-tde.net. [88.4.146.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b110ba3sm22753198f8f.35.2026.11.24.04.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 04:21:38 -0800 (PST)
From: Sergio Lopez <slp@redhat.com>
Date: Tue, 24 Nov 2026 13:20:22 +0100
Subject: [PATCH RFC v4 4/8] vsock/virtio: negotiate datagram support on the
 guest
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
Message-Id: <20261124-vsock-dgram-support-v4-4-3607484e85e8@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4746; i=slp@redhat.com;
 h=from:subject:message-id; bh=iq6ep5+lpyNre87c+82+rRsIkGG2RBevg46oczOnz0k=;
 b=owEBbQKS/ZANAwAKAfRpJ40vDAI1AcsmYgBrBYFF7IkOixcD6aeU8YwF6+Ac+NjB8ZTAX9VUt
 vhkX1UCGMOJAjMEAAEKAB0WIQS+1fz3US2GgJFC6KL0aSeNLwwCNQUCawWBRQAKCRD0aSeNLwwC
 NQa7EACBjEJGAIQIYFtCJEK+zt/cuIT5TjQ0MPJoTh1Ut5YPjvEyOVH4wsLUDlJOSnOTMNi+1YC
 6JSXPs6dnaGdvBXQsAQiv28mRH9A7hX70dkt8B2Ni7fF2kFTvhpe1DM1S0JC+NSiGfGKv21EBAg
 cWYYLfw0I6bVFdD0DklYSAiDdbku6E1nUOCX4deyoGGqEERiquYKXorpSscKU3Pd+wzR4849Pxg
 GB0oJlSKQqC/eORSnlWttDW6D5ENxOkLKus5H6Avboc0UhbmMFHWtM/n5uJ/zBQT3LC+S6ew4zr
 e+hlUn+H/nR5blYN4QVotAr1n/EwwS7cSLVknfA7YxmCU6cNJA7sK2ms53f30hC5WmdrrwLiQrE
 vzRshVc0FHL5uOhh5GKsP8QWeuwQrTdQoEhU5S9L5GvhlBQCjUEA9+b2JLzW+uSsYyToaNDrTIS
 wyXQoML8Es651DUqrprc+4B7uMrUK5DDLUSBjidEo+ASDGfLpd2mU1CtBuyAZQx1kki8HrosAAD
 y8xF2UIX7cU4mZpDS/0P1tTWIuRsguaorUBhWGRKUCuSds+z3wLOk7vdf7CedmPDo2sbB7xYBUV
 IXSViTFKl6Wsz3KHWnDk7I5kRj+Lembhk1vZw0RG2hNYsY/TqTZVePZNKOrlX50a8FpumTjzj8I
 W57PdNgz/yXJ4kw==
X-Developer-Key: i=slp@redhat.com; a=openpgp;
 fpr=BED5FCF7512D86809142E8A2F469278D2F0C0235

Advertise VIRTIO_VSOCK_F_DGRAM and record whether the device
negotiated it. Gate datagram socket initialization and destination
checks on the negotiated feature and the transport's supported network
namespace mode.

Perform device capability checks at socket creation without requiring
a remote address, which is not yet known for an unconnected datagram
socket. The common virtio implementation provides the datagram data
path.

Discard received datagrams when the device has not negotiated support,
including when a socket was initialized through another transport.
Reject packets addressed to a different CID using the full 64-bit wire
value before bound-socket lookup narrows it or matches a wildcard.

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 net/vmw_vsock/virtio_transport.c | 50 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 47 insertions(+), 3 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 4f9aa9c4c3aa..fd10f20d7611 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -57,6 +57,7 @@ struct virtio_vsock {
 
 	u32 guest_cid;
 	bool seqpacket_allow;
+	bool dgram_allow;
 
 	/* These fields are used only in tx path in function
 	 * 'virtio_transport_send_pkt_work()', so to save
@@ -547,6 +548,18 @@ bool virtio_transport_stream_allow(struct vsock_sock *vsk, u32 cid, u32 port)
 
 static bool virtio_transport_seqpacket_allow(struct vsock_sock *vsk,
 					     u32 remote_cid);
+static bool virtio_transport_dgram_allow_check(struct vsock_sock *vsk,
+					       u32 cid, u32 port);
+
+static int virtio_transport_socket_init(struct vsock_sock *vsk,
+					struct vsock_sock *psk)
+{
+	if (sk_vsock(vsk)->sk_type == SOCK_DGRAM &&
+	    !virtio_transport_dgram_allow_check(vsk, 0, 0))
+		return -ESOCKTNOSUPPORT;
+
+	return virtio_transport_do_socket_init(vsk, psk);
+}
 
 static bool virtio_transport_has_remote_cid(struct vsock_sock *vsk, u32 cid)
 {
@@ -561,7 +574,7 @@ static struct virtio_transport virtio_transport = {
 		.get_local_cid            = virtio_transport_get_local_cid,
 		.has_remote_cid           = virtio_transport_has_remote_cid,
 
-		.init                     = virtio_transport_do_socket_init,
+		.init                     = virtio_transport_socket_init,
 		.destruct                 = virtio_transport_destruct,
 		.release                  = virtio_transport_release,
 		.connect                  = virtio_transport_connect,
@@ -571,7 +584,7 @@ static struct virtio_transport virtio_transport = {
 		.dgram_bind               = virtio_transport_dgram_bind,
 		.dgram_dequeue            = virtio_transport_dgram_dequeue,
 		.dgram_enqueue            = virtio_transport_dgram_enqueue,
-		.dgram_allow              = virtio_transport_dgram_allow,
+		.dgram_allow              = virtio_transport_dgram_allow_check,
 
 		.stream_dequeue           = virtio_transport_stream_dequeue,
 		.stream_enqueue           = virtio_transport_stream_enqueue,
@@ -629,6 +642,25 @@ virtio_transport_seqpacket_allow(struct vsock_sock *vsk, u32 remote_cid)
 	return seqpacket_allow;
 }
 
+static bool
+virtio_transport_dgram_allow_check(struct vsock_sock *vsk, u32 cid, u32 port)
+{
+	struct virtio_vsock *vsock;
+	bool dgram_allow;
+
+	if (!vsock_net_mode_global(vsk))
+		return false;
+
+	dgram_allow = false;
+	rcu_read_lock();
+	vsock = rcu_dereference(the_virtio_vsock);
+	if (vsock)
+		dgram_allow = vsock->dgram_allow;
+	rcu_read_unlock();
+
+	return dgram_allow;
+}
+
 static void virtio_transport_rx_work(struct work_struct *work)
 {
 	struct virtio_vsock *vsock =
@@ -677,6 +709,14 @@ static void virtio_transport_rx_work(struct work_struct *work)
 				continue;
 			}
 
+			/* Check the full wire CID before socket lookup truncates it. */
+			if (le16_to_cpu(hdr->type) == VIRTIO_VSOCK_TYPE_DGRAM &&
+			    (!vsock->dgram_allow ||
+			     le64_to_cpu(hdr->dst_cid) != vsock->guest_cid)) {
+				kfree_skb(skb);
+				continue;
+			}
+
 			if (payload_len)
 				virtio_vsock_skb_put(skb, payload_len);
 
@@ -835,6 +875,9 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
 	if (virtio_has_feature(vdev, VIRTIO_VSOCK_F_SEQPACKET))
 		vsock->seqpacket_allow = true;
 
+	if (virtio_has_feature(vdev, VIRTIO_VSOCK_F_DGRAM))
+		vsock->dgram_allow = true;
+
 	vdev->priv = vsock;
 
 	ret = virtio_vsock_vqs_init(vsock);
@@ -932,7 +975,8 @@ static struct virtio_device_id id_table[] = {
 };
 
 static unsigned int features[] = {
-	VIRTIO_VSOCK_F_SEQPACKET
+	VIRTIO_VSOCK_F_SEQPACKET,
+	VIRTIO_VSOCK_F_DGRAM,
 };
 
 static struct virtio_driver virtio_vsock_driver = {

-- 
2.56.0

