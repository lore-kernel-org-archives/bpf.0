Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BD84A3F34
	for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 14:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791642228; cv=none; b=Ylo336+S4IKWWvgEjjs6h2gF501VZyza5eIjpF5wnBtGVESbM4V4cmgx204paUMq+49Qhp2xBT3W15XHtfkz0b5OWQmb8MriiXBEVVukx4U1LWJc7W7Bh9B3aCuMjNAkyE8zpl9yH3Edz+FcG4vyO5f2K79mg9ViKxkT2pbhYPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791642228; c=relaxed/simple;
	bh=+Svg51xnJk0hwgA+Pvm9KcoMbCtihNvL/hL36fP1hLQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NVMManRqvgh99vz8JuS6XCq4M/bz6MDndJRUGMOKopTiL1fm2Bkuo1EgYyzdwRSLT0sfupmnYTsQM870JbzDxNzmV/jZ9cXHjQcgSM4vQmNIlv7JxwGj2FLeHyfEfC96J0D1bd+VewN5xdmezk5cek2ObgzPUrGOaPM0eylA+Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GxUg9onE; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GxUg9onE"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e7e742a2c7so3385475ad.0
        for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 07:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791642227; x=1792247027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2WXkOxHXnr8UIUrfCmHX0CjhpOg5N+1LYe2AkEvWJL8=;
        b=GxUg9onEKK41DK0JlH/QIVDusnJ2+cuQB5RTPuplNeoA3xuifNKXqfBNoF113+4cb2
         YLEkQiPpKr5TehJT4seNXK8k0eKgHXHcDiVkZWSULpI6OhlowRr5fmUkpqDTwiezKi25
         pbMwmbH1TEBSWinNYotBt4yTOWKMGng8m2yA5W/dBKjzKWF3OkEl/2c+7ANmz3aQdGGx
         rILeR75e43U9l3u/8KHddrl3gfTlicu05ZpWWnaCPGJ1CN1PFVsHvVLRFktrdJrHNynf
         eubCkSYuQ23nv0xJIqrb5P8jrTJ51Km0/lroUuJDUAtTpPnq0KV2D+oxuQCNbL5OsMII
         G7fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791642227; x=1792247027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2WXkOxHXnr8UIUrfCmHX0CjhpOg5N+1LYe2AkEvWJL8=;
        b=LmkGVJid7AlLa5A1pYEs8msU2HCrSTA4TbxlbHFCca4MXRoCqKxHX8h8JinWqUW4g+
         MH7es2rmReLc38DS3y4te1bDRsK7noidw866okPO2aWpO2ywzOJ+7HNXJaCTHT7uf018
         9yYicSjg7nvjwkG/iGq/aRc/MYxiGkG50T9mf8HNW9jl6H5kxE6Y0baqxwCOV53X0fd7
         NZO91BlYBA9JsaczrtQxOn1FGew+sp2AploENiA42V5whgOCHxNqukBCpOmS3khYckMy
         A9SBqvM7u2u+jyd2FgS9Z0J/hlN/Mh7qhvOYQClXUl8bGG/zFgDJCxiapEKG5PXVunHw
         SAAQ==
X-Forwarded-Encrypted: i=1; AKwUvBwVuNeNb6XZ9+cVkbbvZrVgRbbPEQcgwkhGHj7m4rM7k5iZ+Pre/xuhbiEeRSEhZ0Iq7vQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJJffpugVZp2J8aJ0PGchaBmmXAziRWPZXFESFesIwj2qCSF44k
	NiJSKTF3i7eU6Eu0vlf6+KBJfM3a2dOU6t0n335c0o8RoPaSFIdAGiMn
X-Gm-Gg: AYBFou1r/0q4/EnjjhC+wUYe/avmrNtK4R4fgC6W1DnkJeslTCkkLFk4ZNKvj5wXtS1
	3slz79PAH1qR2TF2V4KD4g+VyTVEg2680tZmsXYvohaFec1FtmSFTHg1YPXOB7Tg28OIWvHxX1b
	4p7BA7+3rausDguMGodjMkem5/yAIiPIII6VxUVKc979xpit0DBNAwAaBQ/vi5IEVBmFtYSaCFO
	0GiA6vcRFTunjOjX53SGXiHIl2irLTsQVmCBHV/vMsttDqVYGpLXlz2vFkuWbXOCAdN0F92GyZi
	SqMPzqBk8dz6HETL2Ay0y8GLDJR6srsBa2iYhT/q6w2820agN7BCTKetYb2TIFaJLx29bYLWprZ
	KqPVWoy6gqE54MAJchaSORDd4s7XDySXtW/E2LkR6p8pF7B00HV43u7eUPwfnXj3Z818uDiJUrW
	3kYAqwE879tsMQ0osyIf46G1kxoP0HehowsnrNqcG/IQM2SA3Zk230XtMWRfA+UGrNOLVjl4E=
X-Received: by 2002:a17:902:ecc1:b0:2d7:1f17:41f8 with SMTP id d9443c01a7336-2e8404d4e08mr32922875ad.15.1791642226256;
        Sat, 10 Oct 2026 07:23:46 -0700 (PDT)
Received: from gmail.com ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e841a0401esm23676615ad.4.2026.10.10.07.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 07:23:45 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: stefanha@redhat.com,
	sgarzare@redhat.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org
Cc: mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Jia Jia <physicalmtea@gmail.com>
Subject: [PATCH net-next v2 4/5] vsock/virtio: coalesce RX write-space notifications in lock batches
Date: Sat, 10 Oct 2026 22:22:46 +0800
Message-Id: <20261010142247.99223-5-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261010142247.99223-1-physicalmtea@gmail.com>
References: <20261010142247.99223-1-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Each received packet updates peer credit and calls sk_write_space() when
send space is available. A writer cannot use the newly advertised credit
until the socket lock is released, so repeated callbacks within one lock
batch cannot let it make progress sooner.

For the callback installed by sock_init_data(), record one pending
write-space notification and deliver it through the saved default callback
before release_sock(). If the callback has been replaced by batch finish,
invoke the replacement as well. This keeps the native writer wakeup from
being lost across a sockmap callback change while still notifying sockmap.

Save the initial sock_def_write_space() callback when the AF_VSOCK socket
is created because it is not visible to virtio_transport_common when built
as a module. The fast path uses READ_ONCE() and adds no callback lock.

Set the batch socket before processing its first packet so a batch ending
on that packet cannot lose the notification.

Packets outside the eligible STREAM/RW batch path retain per-packet
notification behavior. The 64-packet and 64K limits cap the packets whose
notifications can be coalesced.

Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 include/linux/virtio_vsock.h            |  1 +
 include/net/af_vsock.h                  |  2 ++
 net/vmw_vsock/af_vsock.c                |  1 +
 net/vmw_vsock/virtio_transport_common.c | 42 ++++++++++++++++++++++---
 4 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index d6528681e052..3a58120d9078 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -290,6 +290,7 @@ struct virtio_transport_rx_batch {
 	struct net *net;
 	struct sockaddr_vm src;
 	struct sockaddr_vm dst;
+	bool write_space_pending;
 };
 
 void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index 5549298c1ec6..9d8ae62209ed 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -63,6 +63,8 @@ struct vsock_sock {
 	u32 peer_shutdown;
 	bool sent_request;
 	bool ignore_connecting_rst;
+	/* Initial callback, used to identify replacements. */
+	void (*default_write_space)(struct sock *sk);
 
 	/* Protected by lock_sock(sk) */
 	u64 buffer_size;
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 44cee7451955..fe7f49da6c4b 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -958,6 +958,7 @@ static struct sock *__vsock_create(struct net *net,
 		sk->sk_type = type;
 
 	vsk = vsock_sk(sk);
+	vsk->default_write_space = sk->sk_write_space;
 	vsock_addr_init(&vsk->local_addr, VMADDR_CID_ANY, VMADDR_PORT_ANY);
 	vsock_addr_init(&vsk->remote_addr, VMADDR_CID_ANY, VMADDR_PORT_ANY);
 
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 73e5c7dfe8b4..f0398ae2200d 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1835,6 +1835,7 @@ struct virtio_transport_rx_pkt_ctx {
 	const struct sockaddr_vm *src;
 	const struct sockaddr_vm *dst;
 	bool *batchable;
+	struct virtio_transport_rx_batch *batch;
 };
 
 static bool
@@ -1863,6 +1864,7 @@ virtio_transport_recv_pkt_locked(struct virtio_transport *t,
 	const struct sockaddr_vm *src = ctx->src;
 	const struct sockaddr_vm *dst = ctx->dst;
 	struct vsock_sock *vsk = vsock_sk(sk);
+	void (*write_space)(struct sock *sk);
 	struct net *net = ctx->net;
 	bool space_available;
 
@@ -1885,8 +1887,17 @@ virtio_transport_recv_pkt_locked(struct virtio_transport *t,
 	if (vsk->local_addr.svm_cid != VMADDR_CID_ANY)
 		vsk->local_addr.svm_cid = dst->svm_cid;
 
-	if (space_available)
-		sk->sk_write_space(sk);
+	if (space_available) {
+		write_space = READ_ONCE(sk->sk_write_space);
+		if (ctx->batch &&
+		    write_space == vsk->default_write_space &&
+		    virtio_transport_recv_pkt_batchable(t, sk)) {
+			ctx->batch->write_space_pending = true;
+		} else {
+			/* Use the callback seen for this packet. */
+			write_space(sk);
+		}
+	}
 
 	switch (sk->sk_state) {
 	case TCP_LISTEN:
@@ -1972,16 +1983,28 @@ EXPORT_SYMBOL_GPL(virtio_transport_recv_pkt);
  */
 void virtio_transport_rx_batch_finish(struct virtio_transport_rx_batch *batch)
 {
+	bool write_space_pending = batch->write_space_pending;
+	void (*write_space)(struct sock *sk);
 	struct sock *sk = batch->sk;
+	struct vsock_sock *vsk;
 
 	batch->sk = NULL;
 	batch->pkts = 0;
 	batch->bytes = 0;
 	batch->net = NULL;
+	batch->write_space_pending = false;
 
 	if (!sk)
 		return;
 
+	if (write_space_pending) {
+		vsk = vsock_sk(sk);
+		vsk->default_write_space(sk);
+		write_space = READ_ONCE(sk->sk_write_space);
+		if (write_space != vsk->default_write_space)
+			write_space(sk);
+	}
+
 	release_sock(sk);
 	sock_put(sk);
 }
@@ -2027,6 +2050,7 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
 				.src = &src,
 				.dst = &dst,
 				.batchable = &batchable,
+				.batch = batch,
 			};
 			free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, &ctx);
 
@@ -2063,11 +2087,15 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
 	start_batch = virtio_transport_recv_pkt_batchable(t, sk);
 	read_unlock_bh(&sk->sk_callback_lock);
 
+	if (start_batch)
+		batch->sk = sk;
+
 	ctx = (struct virtio_transport_rx_pkt_ctx) {
 		.net = net,
 		.src = &src,
 		.dst = &dst,
 		.batchable = start_batch ? &batchable : NULL,
+		.batch = start_batch ? batch : NULL,
 	};
 	free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, &ctx);
 	if (start_batch && batchable) {
@@ -2075,12 +2103,16 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
 		batch->net = net;
 		batch->src = src;
 		batch->dst = dst;
-		batch->sk = sk;
 		return;
 	}
 
-	release_sock(sk);
-	sock_put(sk);
+	if (start_batch) {
+		virtio_transport_rx_batch_finish(batch);
+	} else {
+		release_sock(sk);
+		sock_put(sk);
+	}
+
 	if (free_pkt)
 		kfree_skb(skb);
 }
-- 
2.34.1

