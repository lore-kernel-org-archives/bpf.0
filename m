Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794574198;
	b=09Epf+/e8sDzfpTjAeXNq1eI9EC88nef4r6SYNIJbnkBNtGvRyy+yqIwQnGI2k6AOwBI
	 9kIbtphlhke6nfVlSt3iopi8Plcroqm9Dfu6fNwvz0Zg9+sWSCZ4oLwtqlFxBmvX6r2Kq
	 M7cfrFw+Lg2WkUc9ZVtLSjGarGnUufUOWR/tU3x/tIEHWnMoa3Hd+s5mJIiNzVgRRuLjp
	 XJKPkCqY/UCz5+nzUb4fivp+MWINPgij8M4vt9BxNKSx5vpexeuU+1D28ngBCN9S1dInE
	 hPprutGn9jeqd6a1eXG5Y3hSr0xBPcGfYDlqFKDEQvuSWI1jo+z6BIbgO2s930N3/PQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794574198;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=kRsJjjCDtc2CMBY4DZcEpFvNQQYyCSaW8arjfgYBJKM=;
	b=GA0tWh7Me4taZdEdej2UfiQiKO4v9I2zh5Tiet6hIm7xx6atiWoBCVIhr0tMvcbYHONN
	 8scwCq411HYkEw0PhfbMHdG7o47G+EHSUduDpnbaZECYPnq2lCa5GMAa2rbeQqNtlTyCp
	 L105FDW+NLDjqWoSUuOWjy7IhjmFBxxKNOeJ4SyX7vt5pYIP0B2kjdsXp7fp5dd/NxrNt
	 3C5LlRvJbi/TOlJgHP/xKSfEl09aJCCXuuBEU0nSiJfHqnttgwLWp0DNqC3u0JbpZilQJ
	 gDNDGbHFDyhAYOgeJ3cv4ROQ/w3teEskAr5/KzsyfG+DL3Pz5QdAVZtyb4YWx01vN/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HlPIyGsl;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=apjf9lft;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D2460A3811
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 12:49:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57D2460A3811
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HlPIyGsl;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=apjf9lft
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794574196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kRsJjjCDtc2CMBY4DZcEpFvNQQYyCSaW8arjfgYBJKM=;
	b=HlPIyGslCW6bUqqF7CbuC66awmsdMHoiNinxge/sQLCVe/VJPTEm04LrvNJ1LAdTnfGI3W
	+Uvwy5Zb+gcXH2ERQi53Pt2NT3m+zzcWwelZ39heMG7KdYwMdqXEx7NmlVQnSQK/jlBE8W
	SrvHF5Co+Yb5Ck00Byb8gJiiBe5gudE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-l-JvlFfeOi-xn7GKo5OUMg-1; Fri, 13 Nov 2026 07:49:55 -0500
X-MC-Unique: l-JvlFfeOi-xn7GKo5OUMg-1
X-Mimecast-MFC-AGG-ID: l-JvlFfeOi-xn7GKo5OUMg_1794574194
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4b64722b5e6so8295295e9.2
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 04:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794574194; x=1795178994; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kRsJjjCDtc2CMBY4DZcEpFvNQQYyCSaW8arjfgYBJKM=;
        b=apjf9lftw/kE6a4icDfCjPJV+XzSfXXVFmugu7Z63ERAvY4nSAMM7vUv/VbHq4sv/1
         aSDAd5mwq8wKUU2nqzwO/Riv8Kmv9duHb79Hk42e5FR/kJUenCbyeXmB5Lu4/e/AU6Jd
         KZHqldA2MOcR8ZJd24gY0AhgVwyZwW2ke2yQ4dov4IUwE2nEZbUXXGCEfgQofXyFf7eT
         aGQRKwecpywQYlUIVb17EXPpVLrvJHxuiu9mD1yyS70qiucYXo/oL7iTEo3kW4kNKT8z
         zNfzg2MnNTnmhFZi0n06ZpO3uZx+DtDMWkgl+ZVcxVsca7O2Sa6TWMDeLa5xU2hfMMjy
         ENsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794574194; x=1795178994;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kRsJjjCDtc2CMBY4DZcEpFvNQQYyCSaW8arjfgYBJKM=;
        b=wTZ6237L3wBC94kM3znJLJBP7rh2Kg6n2/BCYuy14xPEtADfjbdSpdPVwJldVQpC+J
         W0GdfxLWLf8r6nOzp2VQNrHrEN0P1kNGtBzL7T5XP2G+4S/eOS2miQhiCdY6VjB4qG2H
         nOpfwJ3o6BfBThh00AmdkJflzDK32K+r9fCWE0sI6djmmi5NV0HjYIiJ+gDcPf+bn8T8
         qYz9BQnD07I99zAtVymUbGytZ7LksmQAH59Ro4rMvEJYsCit9q6VSJy6laAmy0TBK+QN
         Pin28ZhKNoVowg07lNslMc7eqtRKobA8cvqHSMDvmf5mCHZQUskUtMYWucCpVSPLca0H
         S78A==
X-Forwarded-Encrypted: i=1; AL+hErGLKfFyBo8O0JTVJuKr5T2QxHU2spflv6bmutdtpMIpWtK9PloMGHnqrh5OsMt0GdCje2U=@vger.kernel.org
X-Gm-Message-State: APuU4Z9ItR7paIcyIbvRZwngafSGQ/MD3ST2tTxuSasAUWBnIkU6mAbh
	seFsePhP6Md5+DT00E7eCQdijJOZb96+dWKYrEXrEdVjsV6oLCgKwFKJ+dspEYCmMpVJe2nJldQ
	LBdI1EEAu8R/HgCKFYEHio48yVThhDwZgB9cDeDgvIK0lPaPwNZZTgQ==
X-Gm-Gg: AYBFou1WLsV0OBqG+w7NIwPyO8zvTniVlWt7niSZ8pzXiwzdG/zTCfr1AGc5L9hf7mL
	MGoUMWhHzu02FA85LPP/S2fLo1J3LUX35hspwB3Hkvo2GcEFosKRiPwtq95AOA7kmTRkdIVRwUP
	9szfnj7ajdhJRaERmKr4V/pvh4A1RIVsdYEc3PZkAw1ealhcSZvzldhNclieghEtB2ErvraZWun
	QzzM5szPt1d7tME1eeRiNKOwQzMkrVv+gmFm+9WSmHGgZNcJZb+LBI8jBeD62ta6VQXE3Nw5oWE
	ycMxqlT5K8etnrqAtQiAwGUsb4Oz9RH2XVhKbldR5afBV0BG0pQx+aC9rsMedScvUEQnqR0oTsx
	VmGSlMD0p0Ajdk1OJJs1TK7+GEr5mG9z4sYD85A9zJ5ZNxQb++iAn3QNQH5f6cHPSk/6VABMC9j
	vi2jWSuFC8tOU=
X-Received: by 2002:a05:600c:6219:b0:4b7:6aac:7406 with SMTP id 5b1f17b1804b1-4bb55a23b41mr43805085e9.3.1794574193927;
        Fri, 13 Nov 2026 04:49:53 -0800 (PST)
X-Received: by 2002:a05:600c:6219:b0:4b7:6aac:7406 with SMTP id 5b1f17b1804b1-4bb55a23b41mr43804695e9.3.1794574193541;
        Fri, 13 Nov 2026 04:49:53 -0800 (PST)
Received: from [192.168.0.19] (217.red-88-4-146.dynamicip.rima-tde.net. [88.4.146.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2adf53sm151135805e9.15.2026.11.13.04.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 04:49:52 -0800 (PST)
From: Sergio Lopez <slp@redhat.com>
Date: Fri, 13 Nov 2026 13:47:37 +0100
Subject: [PATCH RFC v2 4/8] vsock/virtio: negotiate datagram support on the
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
Message-Id: <20261113-vsock-dgram-support-v2-4-bacfc85b71ce@redhat.com>
References: <20261113-vsock-dgram-support-v2-0-bacfc85b71ce@redhat.com>
In-Reply-To: <20261113-vsock-dgram-support-v2-0-bacfc85b71ce@redhat.com>
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
 linux-doc@vger.kernel.org, Sergio Lopez <slp@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4746; i=slp@redhat.com;
 h=from:subject:message-id; bh=iq6ep5+lpyNre87c+82+rRsIkGG2RBevg46oczOnz0k=;
 b=owEBbQKS/ZANAwAKAfRpJ40vDAI1AcsmYgBq9wdeh/fbg8dtYF2DcAbRaFeKvm+icn7ibkHUI
 9UDc3bUTuCJAjMEAAEKAB0WIQS+1fz3US2GgJFC6KL0aSeNLwwCNQUCavcHXgAKCRD0aSeNLwwC
 NawhD/4yNgrww43ef4iLOcszJW/Vt9MQ3fWu2LbAo/inVbx5U5pXTx6wb0mGebUaDw/EjjYsNd1
 hl7B6IFWykqjaE2K+qsEkL86SvLKJtPqHf+dhdgkXqTfgHzgYJq6zgLAfB2O+KREcuH4GuRa5iw
 /7IWcNoRiicOapx87Te+iwT7K+oYtdjTKzTkCXUumOL1KVCPl1EExuywDO2A+fAcsxfYUNBLknR
 hS+ExF4RKc4Ygx+nv9cPLZb2zNpA4ofI/GRvAivuDOl7gUhsZ9UMoqMTSTFdVm+hm7hp7WMxu9j
 mhGRMQkUqXf4yvCV/zb59WFbNAk0Y9fKthrj4aqZKKNsdNdJ5VYdPt2/aqNvtFfQXNzzy98qE1I
 QNrePr/T7btb19CqzTiGKYLjYeYUMqLRMzk8jTv4IsAWznc4LDyFD1arq8gK2JXOds4FHC9aOVd
 xxcnITpeQhtXqE0BH6pVM/aLJieAX/JPFhx2HbIA709Pv2Gp17nTtEXAmVPpYs8JJBxig6U8Q78
 AceTOeKwXHhQm5BfKSnAhUQj2Vf/qJwgH1Pr8Xla3pKX3o5kq7LAnmqXcADRUeDWIPDyp+5lkMN
 Nb9NTW8KBk/pEgvtH1GQXnINsSlthdAqlC3Q6vL8ED9yQwmPDh7D1VXTpYHb9DXvlL03WS02LHj
 NWJUmzBel0efycg==
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

