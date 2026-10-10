Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715723EC837
	for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 14:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791642209; cv=none; b=ClTFJc0f43dtvQkQd7CRG76p9Zff2jf1Q28ppPZUwdUi6YZttluJBiH6d31B/mNpBd3eKzdcw1VFG0o0eIGQLp0h4vL8ToIfGK7M29cbOs+3Ya/D1vc0+L8JaNAPNBKbmesOf9qVpgfZ0GXWvGPCp8wW13ohwGh24K+dKVSj9d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791642209; c=relaxed/simple;
	bh=SrTKDRuW9NZ2EjBREXpMO3zaIjzegK2qKsQrkr1UKlc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FuXL6qyZGlw6vN7F8F5MWQ6DCWumxtniAP3A8eZU9f1Octmjre7SdaAwt2B5yXLKmigr35/asteJz01mv35fhMojeIPr3cXasu8hlekeQfOIVQQU50dX7DERT0l62QaKPyTXLCAbC3RGPHim4VP57nNv86Edxa1xVcVxaHE4Vcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b5C+9egI; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5C+9egI"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e541dc9cb9so1978235ad.3
        for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 07:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791642208; x=1792247008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ft+6QFIF5f2VFqvcShDWqZDBbOT/nzezeoFifhj5jXM=;
        b=b5C+9egIgcunOqpCR6Q4XG5kGW9rc+IiY/BRH4haQ4kUYCNk0JAbIjl3WH+Rxmi7t0
         PS3soKSkTnGTZX+Zu/Q3+CSfBqnZcgm2nk0deAhsiXw0PNzK8bKHlU0w43o8nkDefc6d
         lVi5eUw/o7xacHv3fiyac+poRIUALWSXKWBResqB9cSDQUsJIx+6s8+z6UtiazsHqkcx
         mXMqSMEBMXBPPa3T/Q1QDIgW4bhAoujl01Z12km+x33sq97ColtNmmWpy98jdkiwn1M6
         ZfuABBIFC7+meu5UhyPrPKvFhJLCoU51SfWCv9utWHq1RxxXPmrE1djjJeWYQProaE63
         LoWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791642208; x=1792247008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ft+6QFIF5f2VFqvcShDWqZDBbOT/nzezeoFifhj5jXM=;
        b=eOYmjCUPIRWGn4GeJUzcN4fv9rkBwXdJs7fSNUAQ4nF86kOjGiI1NHsZ3i8Kvikm6I
         XOO+FcFLGF5vRn3nn1fbth2LDbf5JCA9pMTZ51c8l+YEbNVTSDlSB7ABLMCxpBhZonjj
         isb9Z8MYnfyJAJVHu7jLeCydwVMmtlUAOJqQ1c1OKVQNv185Sutli/f5QMexGdMX0Y9a
         Ouk9rZremaO+fj1N7Rgzhy721RBlaeJ9x0W6p4JQwesBRQLpAQoCRjhMRcecr85wK+Qh
         fCMDrl5QYScMWfpBbHSj3Ii2kmUZ3IMElxAzNZNKhX90n89qn43psGKy6GDh1MWa/AoD
         jTsA==
X-Forwarded-Encrypted: i=1; AKwUvBz0BqheogdnI8H44YmDaSiUWlytWwoa5e/7FPEPQU/MKd8biEkYzVvhl+G0adbkf8Xy2LU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLNEQGTIaMT6PXjGuj62sIJz7nYIlxVI0SeGGnGzE53KdZUU9y0
	jwYocoO9urNMHWI+F9PunfDBb0NiIKo+T0GX4mj9cHG9ZlM5Qk5BcdVO
X-Gm-Gg: AYBFou0eXiGtlDtDFg2CXIVGqowMB4uBZxJidBzrraos9sdrs4dys1n5qUMkTvRCJ3Q
	5HoRv51k7zHZHAGOGxtleG/RJoOkauTpTNgnj4ENoQTABZtcJpwbvEOUpyfMZ6bfdveD1zwybL2
	PMMPaXNdBXAV9ayMQ6yq4YpseJnGU3m0es2sQ8M5GrpkgnvCR9Po+m+tJs/3bEmnEcyYMXSVCal
	g/858GXt4ZADctWGB/E1+PapVzP4W3ZPOOQM5dN49drnzdIBtaqRsw0GMGepDWnHJfxkn4RkdPI
	D/ClrVQs7823LpqQXB2kTBsISB4pkIxRgRnEx/l4qnCqRMPecYOlbBGe1+fcwg2A3jBJPYPdxHv
	bNVbLu9fZtzjeUvCZ+BAEd1YtElngucCXgHcJGFKZJW7q2rnYe9bM4vQXmTTXLFdEs1O8v07VXp
	jop7Dby2bKVyjWkyqJwUpz5V5sgYjOpnk6dB0FigXXkw7lS80TbZI20gRD2FwEJ7gcIBsAwA==
X-Received: by 2002:a17:903:15c8:b0:2e8:f7a:c69d with SMTP id d9443c01a7336-2e8429a8013mr40631895ad.15.1791642207520;
        Sat, 10 Oct 2026 07:23:27 -0700 (PDT)
Received: from gmail.com ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e841a0401esm23676615ad.4.2026.10.10.07.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 07:23:26 -0700 (PDT)
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
Subject: [PATCH net-next v2 1/5] vsock/virtio: split socket lookup from locked RX processing
Date: Sat, 10 Oct 2026 22:22:43 +0800
Message-Id: <20261010142247.99223-2-physicalmtea@gmail.com>
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

Split virtio_transport_recv_pkt() so socket lookup is separate from the
receive state machine that runs under the socket lock.

Keep virtio_transport_recv_pkt() on its existing per-packet locking path.
Pass the source and destination addresses used for lookup to the locked
receive path so they are decoded only once.

Pass the network namespace and decoded address tuple through a packet
context to the locked receive path.

Preserve source validation and failure handling. Keep the lookup reference
separate from the skb owner reference so the locked receive path can manage
the two lifetimes independently.

Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 net/vmw_vsock/virtio_transport_common.c | 139 ++++++++++++++++--------
 1 file changed, 96 insertions(+), 43 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index f225f53..e3e75e5 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1774,81 +1774,97 @@ static bool virtio_transport_valid_type(u16 type)
 	       (type == VIRTIO_VSOCK_TYPE_SEQPACKET);
 }
 
-/* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq->mutex
- * lock.
- */
-void virtio_transport_recv_pkt(struct virtio_transport *t,
-			       struct sk_buff *skb, struct net *net)
+static void
+virtio_transport_recv_pkt_init_addrs(struct sk_buff *skb,
+				     struct sockaddr_vm *src,
+				     struct sockaddr_vm *dst)
 {
 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
-	struct sockaddr_vm src, dst;
-	struct vsock_sock *vsk;
-	struct sock *sk;
-	bool space_available;
 
-	vsock_addr_init(&src, le64_to_cpu(hdr->src_cid),
+	vsock_addr_init(src, le64_to_cpu(hdr->src_cid),
 			le32_to_cpu(hdr->src_port));
-	vsock_addr_init(&dst, le64_to_cpu(hdr->dst_cid),
+	vsock_addr_init(dst, le64_to_cpu(hdr->dst_cid),
 			le32_to_cpu(hdr->dst_port));
+}
+
+static void
+virtio_transport_trace_recv_pkt(struct sk_buff *skb,
+				const struct sockaddr_vm *src,
+				const struct sockaddr_vm *dst)
+{
+	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
 
-	trace_virtio_transport_recv_pkt(src.svm_cid, src.svm_port,
-					dst.svm_cid, dst.svm_port,
+	trace_virtio_transport_recv_pkt(src->svm_cid, src->svm_port,
+					dst->svm_cid, dst->svm_port,
 					le32_to_cpu(hdr->len),
 					le16_to_cpu(hdr->type),
 					le16_to_cpu(hdr->op),
 					le32_to_cpu(hdr->flags),
 					le32_to_cpu(hdr->buf_alloc),
 					le32_to_cpu(hdr->fwd_cnt));
+}
 
-	if (!virtio_transport_valid_type(le16_to_cpu(hdr->type))) {
-		(void)virtio_transport_reset_no_sock(t, skb, net);
-		goto free_pkt;
-	}
+static struct sock *
+virtio_transport_recv_pkt_find_socket(struct sk_buff *skb,
+				      struct sockaddr_vm *src,
+				      struct sockaddr_vm *dst,
+				      struct net *net)
+{
+	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
+	struct sock *sk;
 
-	/* The socket must be in connected or bound table
-	 * otherwise send reset back
-	 */
-	sk = vsock_find_connected_socket_net(&src, &dst, net);
-	if (!sk) {
-		sk = vsock_find_bound_socket_net(&dst, net);
-		if (!sk) {
-			(void)virtio_transport_reset_no_sock(t, skb, net);
-			goto free_pkt;
-		}
-	}
+	if (!virtio_transport_valid_type(le16_to_cpu(hdr->type)))
+		return NULL;
+
+	sk = vsock_find_connected_socket_net(src, dst, net);
+	if (!sk)
+		sk = vsock_find_bound_socket_net(dst, net);
+	if (!sk)
+		return NULL;
 
 	if (virtio_transport_get_type(sk) != le16_to_cpu(hdr->type)) {
-		(void)virtio_transport_reset_no_sock(t, skb, net);
 		sock_put(sk);
-		goto free_pkt;
+		return NULL;
 	}
 
-	if (!skb_set_owner_sk_safe(skb, sk)) {
-		WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
-		goto free_pkt;
-	}
+	return sk;
+}
 
-	vsk = vsock_sk(sk);
+struct virtio_transport_rx_pkt_ctx {
+	struct net *net;
+	const struct sockaddr_vm *src;
+	const struct sockaddr_vm *dst;
+};
 
-	lock_sock(sk);
+/*
+ * The caller holds sk's socket lock and must free skb if this returns true.
+ */
+static bool
+virtio_transport_recv_pkt_locked(struct virtio_transport *t,
+				 struct sk_buff *skb, struct sock *sk,
+				 const struct virtio_transport_rx_pkt_ctx *ctx)
+{
+	const struct sockaddr_vm *src = ctx->src;
+	const struct sockaddr_vm *dst = ctx->dst;
+	struct vsock_sock *vsk = vsock_sk(sk);
+	struct net *net = ctx->net;
+	bool space_available;
 
-	/* Check if sk has been closed or assigned to another transport before
-	 * lock_sock (note: listener sockets are not assigned to any transport)
+	/* Check after acquiring the socket lock. Listener sockets accept packets
+	 * from any source and are not assigned to a transport.
 	 */
 	if (sock_flag(sk, SOCK_DONE) ||
 	    (sk->sk_state != TCP_LISTEN &&
-	     !vsock_check_source(vsk, &t->transport, &src))) {
+	     !vsock_check_source(vsk, &t->transport, src))) {
 		(void)virtio_transport_reset_no_sock(t, skb, net);
-		release_sock(sk);
-		sock_put(sk);
-		goto free_pkt;
+		return true;
 	}
 
 	space_available = virtio_transport_space_update(sk, skb);
 
 	/* Update CID in case it has changed after a transport reset event */
 	if (vsk->local_addr.svm_cid != VMADDR_CID_ANY)
-		vsk->local_addr.svm_cid = dst.svm_cid;
+		vsk->local_addr.svm_cid = dst->svm_cid;
 
 	if (space_available)
 		sk->sk_write_space(sk);
@@ -1875,12 +1891,49 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 		break;
 	}
 
+	return false;
+}
+
+/* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq->mutex
+ * lock.
+ */
+void virtio_transport_recv_pkt(struct virtio_transport *t,
+			       struct sk_buff *skb, struct net *net)
+{
+	struct virtio_transport_rx_pkt_ctx ctx;
+	struct sockaddr_vm src, dst;
+	struct sock *sk;
+	bool free_pkt;
+
+	virtio_transport_recv_pkt_init_addrs(skb, &src, &dst);
+	virtio_transport_trace_recv_pkt(skb, &src, &dst);
+
+	sk = virtio_transport_recv_pkt_find_socket(skb, &src, &dst, net);
+	if (!sk) {
+		(void)virtio_transport_reset_no_sock(t, skb, net);
+		goto free_pkt;
+	}
+
+	if (!skb_set_owner_sk_safe(skb, sk)) {
+		WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
+		goto free_pkt;
+	}
+
+	lock_sock(sk);
+	ctx = (struct virtio_transport_rx_pkt_ctx) {
+		.net = net,
+		.src = &src,
+		.dst = &dst,
+	};
+	free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, &ctx);
 	release_sock(sk);
 
 	/* Release refcnt obtained when we fetched this socket out of the
 	 * bound or connected list.
 	 */
 	sock_put(sk);
+	if (free_pkt)
+		kfree_skb(skb);
 	return;
 
 free_pkt:
-- 
2.34.1

