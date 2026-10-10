Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B984A8FC6
	for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 14:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791642222; cv=none; b=BzBtJjU7f7QG8wH5IancyZx4EPQlbrQfVHd9Alb13+U+vv0kFWKZb/PbEnSRgd8KYALXp74zh0yRaAvt3MnfZdarZwSYqI13K+endbjfX2YVedeb23vAClR+SZbiDlDg0UZWcZ3ysB3YLk7y0y3W55wijz/zjWQrqq70JPe9Z7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791642222; c=relaxed/simple;
	bh=SR265Jmv9EOllUtmFjO77CtNsAfQryl1UbcAKyqIvXY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JgaaHqTn1CrdwRZyiXYzBpcOpDEM8I6+4IVX2FnTxg8qt9HjJWmKC8Yjt3u2UnPYW6LAxoHPjl0tSKHOBQv2Xew5O8yLwMTiith7l0/EPNQOi6zB104mKRO8IpNssTkJo/Yx10AXk9PieBm0IAKv0rVAd+/7fjSAGwEVAlA3CBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b6FWYlZp; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6FWYlZp"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3ab2bf5e75bso267418a91.3
        for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 07:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791642220; x=1792247020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O1x0phht5NvvvSb25eom8J7EmXbou4YWYoQ1p3enTUo=;
        b=b6FWYlZpeOw2AkpFm30bLDPWOZnHarjo/92yhsI3gJXF7wRKadRQgySt86V3Ewucb+
         TzfQJ8H4eqPuDAAFBWgOpdwuPtx8cpIX4aYw9AzlkX4w7x2HBQeewGAVUUcOz1Dxpjyk
         A/puvD+rzH5zrHduqrrR74OqSjED8hEXwymazhe/ye3DbfNio3245+mvmJbk4arfEinp
         HQvM5RBbhYhTvnbkNvUtai4+OGmmolA53r9Xr1yNVq4oHtqm2yGRAR2WcBtP3G5bFmGr
         eouaNLWd5mwB7B9+2KwuS4WJKCCYkcVaaH4AsUe41KqPnbd+Yaknis9gGArr19EV2JFa
         YpbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791642220; x=1792247020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=O1x0phht5NvvvSb25eom8J7EmXbou4YWYoQ1p3enTUo=;
        b=L2f2/40JQsVMFUOFeya1fjN8kx44wCL6+k/uxMweZsx6jPew/MzNI6eR2RWp1E6Blp
         LAp5/S23Q0jpafTQBULO5dfNimsmtFOHxFnCDj2G1oqrdI0SL4dHWfYLiDuNKWnxbhw2
         1hfbtvdndvCv0jwCvoWV1j5PcqAsvpG7nZH7TA1+/gOetC2Kq1z44fqoi23LRuBGSX4S
         VQT9l3W4oeAN538o5eVtpn/lw1JsI5s8yrp0az6zMZvGe9I8hz825Dou8aGrcFcOGWVN
         F5O1/vBBFWYe4riqOSxRNfvagwGs6FKPEr2f/6DW3zwknnrAb75zwPhfwxLGYuEvykUt
         z7Ng==
X-Forwarded-Encrypted: i=1; AKwUvBxPoEtK/NAL2O674xFns2tUVZcRJ0xl5LHldRx8XlgqBVQY3wRMkUHoZBizxM5IpagNXxQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYIzOuODNNfOoB57EhK1IoKs2/mKZ1WihuEwvAhIQhc42mjtxYHI
	2aZ/jag0T2WXTMb+tWxsWCUnVomi4+IGnNQv0lk2LI3meD9RZkU+d3Cw
X-Gm-Gg: AYBFou1PW5qsiRgOxtCXBA+bgDtHDSRN3BA7Q2GN2xJz7JfOq+etVPZyRdRY+c36H20
	tCBxnyfOgSXydWf6JcT6vq6O7si9ETrpY1EMvKPAks/CRSiEm407Zgk9gJfIN/q95o8fRCdNqgR
	rKUv+bE9Xt4zvy3Oe7GIKmXNuYS+ht8GWEJTV9RuVlKhKra+s1yJr/Apk79ZNSD0zzNPHJy/Bkg
	7b/4CEzZt4V9Nrhv4uqpaGJfr5WDZ6zOQ/4SPyqKzN7v/KgJCsL22fOFwqK5nN3xkV753l0VabV
	AsUiuJYJb1DQFOf4kT2O/W8X57TABZWbIHheRJBhetJedbjyovge1Ce5CMeSAtrVf6QzQ+OrTIe
	7ULs4yshMkL3aySQ1yIJfbu6KRYSOKCC9292HvqcHAPSxfcQn3ddYqKwMabSXuHq3BAsmUIJc4l
	lnsXuaDkaSyUw1nK+bs1RbMsmiUJLQr/1PjwCc/OW8QSTYBF5kcTl2nS7yNOjJqKzv2QXJpVt7V
	fXEMRqL
X-Received: by 2002:a17:90b:48c1:b0:3aa:f4af:1e0b with SMTP id 98e67ed59e1d1-3ab3a32f599mr3976782a91.8.1791642219863;
        Sat, 10 Oct 2026 07:23:39 -0700 (PDT)
Received: from gmail.com ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e841a0401esm23676615ad.4.2026.10.10.07.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 07:23:38 -0700 (PDT)
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
Subject: [PATCH net-next v2 3/5] vsock/virtio: reuse same-flow socket lookup in RX batches
Date: Sat, 10 Oct 2026 22:22:45 +0800
Message-Id: <20261010142247.99223-4-physicalmtea@gmail.com>
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

An RX lock batch still looks up the socket for every packet and takes a
temporary lookup reference, even though the batch already holds a reference
to the locked socket.

Record the network namespace and packet address tuple when a batch starts.
Reuse the batch socket for later STREAM/RW packets with the same tuple, and
release the batch before looking up a different flow.

The cached path still traces every packet, takes an skb owner reference,
validates socket state, source and transport, updates credit, and runs the
receive state machine. Only the socket table lookup and its temporary
reference are skipped.

Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 include/linux/virtio_vsock.h            |  3 ++
 net/vmw_vsock/virtio_transport_common.c | 58 +++++++++++++++----------
 2 files changed, 38 insertions(+), 23 deletions(-)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 26dde6909c4e..d6528681e052 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -287,6 +287,9 @@ struct virtio_transport_rx_batch {
 	struct sock *sk;
 	unsigned int pkts;
 	size_t bytes;
+	struct net *net;
+	struct sockaddr_vm src;
+	struct sockaddr_vm dst;
 };
 
 void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index e67dfcaa279c..73e5c7dfe8b4 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1977,6 +1977,7 @@ void virtio_transport_rx_batch_finish(struct virtio_transport_rx_batch *batch)
 	batch->sk = NULL;
 	batch->pkts = 0;
 	batch->bytes = 0;
+	batch->net = NULL;
 
 	if (!sk)
 		return;
@@ -2008,6 +2009,37 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
 	virtio_transport_recv_pkt_init_addrs(skb, &src, &dst);
 	virtio_transport_trace_recv_pkt(skb, &src, &dst);
 
+	if (batch->sk) {
+		if (batch->net == net &&
+		    vsock_addr_equals_addr(&batch->src, &src) &&
+		    vsock_addr_equals_addr(&batch->dst, &dst) &&
+		    virtio_transport_recv_pkt_batchable(t, batch->sk)) {
+			sk = batch->sk;
+			if (!skb_set_owner_sk_safe(skb, sk)) {
+				WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
+				virtio_transport_rx_batch_finish(batch);
+				kfree_skb(skb);
+				return;
+			}
+
+			ctx = (struct virtio_transport_rx_pkt_ctx) {
+				.net = net,
+				.src = &src,
+				.dst = &dst,
+				.batchable = &batchable,
+			};
+			free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, &ctx);
+
+			if (!batchable)
+				virtio_transport_rx_batch_finish(batch);
+			if (free_pkt)
+				kfree_skb(skb);
+			return;
+		}
+
+		virtio_transport_rx_batch_finish(batch);
+	}
+
 	sk = virtio_transport_recv_pkt_find_socket(skb, &src, &dst, net);
 	if (!sk) {
 		virtio_transport_rx_batch_finish(batch);
@@ -2018,33 +2050,10 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
 
 	if (!skb_set_owner_sk_safe(skb, sk)) {
 		WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
-		virtio_transport_rx_batch_finish(batch);
 		kfree_skb(skb);
 		return;
 	}
 
-	if (batch->sk && batch->sk != sk) {
-		/* Never acquire a second socket lock. */
-		virtio_transport_rx_batch_finish(batch);
-	}
-
-	if (batch->sk == sk) {
-		/* Keep the batch reference; drop this packet's lookup reference. */
-		sock_put(sk);
-		ctx = (struct virtio_transport_rx_pkt_ctx) {
-			.net = net,
-			.src = &src,
-			.dst = &dst,
-			.batchable = &batchable,
-		};
-		free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, &ctx);
-		if (!batchable)
-			virtio_transport_rx_batch_finish(batch);
-		if (free_pkt)
-			kfree_skb(skb);
-		return;
-	}
-
 	lock_sock(sk);
 	/*
 	 * Sockmap removal restores the native protocol under sk_callback_lock.
@@ -2063,6 +2072,9 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
 	free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, &ctx);
 	if (start_batch && batchable) {
 		/* Keep the lookup reference until the batch is released. */
+		batch->net = net;
+		batch->src = src;
+		batch->dst = dst;
 		batch->sk = sk;
 		return;
 	}
-- 
2.34.1

