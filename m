Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB9A4A206B
	for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 14:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791642215; cv=none; b=GNaaRd3Yjl9Zfwa2a7xRPqA00HQstcbmBAQs+wQGr/4MrvMotWJPeRyk0aPOCSze6W4yC65rl+UiT6qauUjZZ+yyBqVoGVZaHQE6fps3eOwh6ynnwdbln8poC3ZfX4ioWDx8547jvbpwSRcU6sgsCan9lUnKT6+dbE3O02CSo5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791642215; c=relaxed/simple;
	bh=daqZc+QyaWQpFjyMP2c+tmz35bLN8UT1WQTyLRhtQEY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m6b8h0w5MgElA+qro7F7JzpFqHnIhp+rlR63MXS91EVCgORBByxkpGGGIpVdL2RlMdm8bviGqa5DKJDTidOyFXNMaS5CoxVm+XpSBhAuI7EPkZoljkHn8xxdjoO2kEll4K2R6d68OGM6CvDpPv1Qs3CRPsWPdn/hFL0ZJRBw3Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r8qnk08H; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r8qnk08H"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2df982e04c1so3096465ad.2
        for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 07:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791642214; x=1792247014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4KNUSu3bS7q4mwIXpQDiAcx7RZBKZD3bVskoMbRLE1w=;
        b=r8qnk08HZ25i18TOaiT5YkekjMn4CIw/SVBdOz6+LsL1gxhpgaE+S6hZUnMewyhVXz
         te2H5s71x09d+Dm3xKYqgRqWGzfJGLsisY34e20pvYpj/0cFeM1zUo9upG7I+yF6+lln
         a0K8l937dTbGdkLqybUyJkfrInlvNM1kYuHGNsi1CanoQDw10XERZCFlTK9NSNgbM2h2
         s5e+wCKVKg63RQI/0/HK0O1TQAb4cId8bMUvTNLie39QPUktVu5w4HlLhRU7g1l285Rj
         8VJc5koRdVQx2qTPTad9yEXgpahbMZki3vk0nD98AeZa2nVPoh0U3/5dG6QpmKm03rab
         WuxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791642214; x=1792247014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4KNUSu3bS7q4mwIXpQDiAcx7RZBKZD3bVskoMbRLE1w=;
        b=DExCEbpBVRPctx1wbaeP1xPpi5l1BkgF93ZBVzDiS0I/21prLtZaQtlPBo6XerqmEV
         DgkO7fWdyiPyy0UT0jHSxTFgxI7GFCXK0TXW3Dw0ZZPzgUtpPgmQ7YkKzxAkh6tJxf63
         a2Ihgmz7jJOEFEsBS0jC6JNBzhnReyYPW3IHUVyhxYJcI/gMYn99JRMxe7w9jxjVF3jD
         /LmRwPbSHyc9I6d22UG4wZoVxeZMcnjvHC8vpvtg72sRRKGPkQRj6X76XxxpXjLni9a0
         cCcm8aKhPy36i8jkeM1DPMDA8BSWFvtxpJPBvoTqzYqqLPEo6iQpOUytzMna73t9dzan
         /9Lg==
X-Forwarded-Encrypted: i=1; AKwUvByUhzVrheuUlqUnKCVHA8MbmM7jP38Pmt5TNIQmAEUkc3WXx1RKVO6XTD/+bHoB+UK/kWo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJBOiFf2uezvNP7R5IrBs0verI4i4bVlxrp0Kb4BQ7CYTDAnq1+
	U5vzbl0EUwmj90nRDk4GFuO1ho5xOxw8on9Tn3HxsX2DLg6tNhsFKUFF
X-Gm-Gg: AYBFou1wiY/6rAN1YVGNky9mvFWFcTRcJ+7jccoc3bLB3eNRFhXSBKWJIb3y7IBQFLc
	R8L338dCDBzKBxEuv/NtmFM+vtWqrXOQ+mR9X0/v2PldrUy+hMA2M5bmcKmqUmCwYYP3rB2XC69
	OT7NYCT1kNcqqiqyBzA0MPF2rFr7Q1jER470UVWVlK2TMvqjPmUqjYtLU6KjBqpUfgr1m0UoEq4
	pa1f4fZVHeRoud8lNWM3W+BX8gtbnQmXVuhCO4ULj6ZxYGD1+IYpMq5NSSbaIr0Pkx0jGC/79ec
	k3zDOQt9dcE/2b6dXqFYDj4Ewz+e0JnmttAt5NxrqNMhc67PXLvzlDlCZnuum/+WYEbqIqJph5d
	vSnL7grg3GLw5cRlnKA9Wnyb2UkeyKSj92Wgglgv6laV2Ie4x/KI1YdtsXU0e+DhylC+8xGMn7o
	VldiDthdG80y3K1NWcikkTX+mU32YzfgTDNTP+VZFZjSrMKfB7H9VE2aPoElG14qlEHoHg/Q==
X-Received: by 2002:a17:902:e811:b0:2dd:ad73:c988 with SMTP id d9443c01a7336-2e842bc7f91mr38765655ad.32.1791642213379;
        Sat, 10 Oct 2026 07:23:33 -0700 (PDT)
Received: from gmail.com ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e841a0401esm23676615ad.4.2026.10.10.07.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 07:23:33 -0700 (PDT)
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
Subject: [PATCH net-next v2 2/5] vsock/virtio: amortize RX socket locking for stream packets
Date: Sat, 10 Oct 2026 22:22:44 +0800
Message-Id: <20261010142247.99223-3-physicalmtea@gmail.com>
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

The virtio-vsock RX worker currently acquires and releases the socket lock
for every received packet. Keep the lock held while processing a bounded
run of packets that belongs to the same socket.

Only ordinary RW packets for an established STREAM socket whose transport
and protocol remain unchanged are eligible. Control packets, SEQPACKET
traffic, state or transport changes, malformed packets, and sockets whose
protocol has been replaced end the active batch and retain their existing
handling.

Serialize the initial eligibility check with sk_callback_lock because
sockmap removal restores the protocol without taking the socket lock.

Limit each batch to 64 packets or 64KB of payload, bounding the work under
one socket lock. Keep the lookup reference until the batch finishes.

Keep a batch only while another skb metadata charge fits in the receive
buffer. Share this predicate with virtio_transport_inc_rx_pkt(). When an
enqueued skb consumes the final metadata slot, finish the batch and release
the socket lock before processing another packet, restoring the reader's
scheduling opportunity from the per-packet path.

The virtqueue callback remains a queue_work() callback. Batching runs only
in the process-context RX worker.

Introduce virtio_transport_rx_batch_finish() to tear down the batch and
release the socket lock and lookup reference.

Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 include/linux/virtio_vsock.h            |  11 ++
 net/vmw_vsock/virtio_transport.c        |  29 ++++-
 net/vmw_vsock/virtio_transport_common.c | 147 +++++++++++++++++++++++-
 3 files changed, 183 insertions(+), 4 deletions(-)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index f91704731057..26dde6909c4e 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -282,6 +282,17 @@ void virtio_transport_destruct(struct vsock_sock *vsk);
 
 void virtio_transport_recv_pkt(struct virtio_transport *t,
 			       struct sk_buff *skb, struct net *net);
+
+struct virtio_transport_rx_batch {
+	struct sock *sk;
+	unsigned int pkts;
+	size_t bytes;
+};
+
+void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
+				     struct sk_buff *skb, struct net *net,
+				     struct virtio_transport_rx_batch *batch);
+void virtio_transport_rx_batch_finish(struct virtio_transport_rx_batch *batch);
 void virtio_transport_inc_tx_pkt(struct virtio_vsock_sock *vvs, struct sk_buff *skb);
 u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 wanted);
 void virtio_transport_put_credit(struct virtio_vsock_sock *vvs, u32 credit);
diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 4f9aa9c4c3aa..ef076732158d 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -629,8 +629,16 @@ virtio_transport_seqpacket_allow(struct vsock_sock *vsk, u32 remote_cid)
 	return seqpacket_allow;
 }
 
+/*
+ * Keep a bounded run of packets for one socket under a single socket lock.
+ * Limit packet count and payload size to bound the work done while locked.
+ */
+#define VIRTIO_TRANSPORT_RX_BATCH_MAX_PKTS	64
+#define VIRTIO_TRANSPORT_RX_BATCH_MAX_BYTES	(64 * 1024)
+
 static void virtio_transport_rx_work(struct work_struct *work)
 {
+	struct virtio_transport_rx_batch batch = {};
 	struct virtio_vsock *vsock =
 		container_of(work, struct virtio_vsock, rx_work);
 	struct virtqueue *vq;
@@ -666,6 +674,7 @@ static void virtio_transport_rx_work(struct work_struct *work)
 			/* Drop short/long packets */
 			if (unlikely(len < sizeof(*hdr) ||
 				     len > virtio_vsock_skb_len(skb))) {
+				virtio_transport_rx_batch_finish(&batch);
 				kfree_skb(skb);
 				continue;
 			}
@@ -673,6 +682,7 @@ static void virtio_transport_rx_work(struct work_struct *work)
 			hdr = virtio_vsock_hdr(skb);
 			payload_len = le32_to_cpu(hdr->len);
 			if (unlikely(payload_len > len - sizeof(*hdr))) {
+				virtio_transport_rx_batch_finish(&batch);
 				kfree_skb(skb);
 				continue;
 			}
@@ -680,16 +690,33 @@ static void virtio_transport_rx_work(struct work_struct *work)
 			if (payload_len)
 				virtio_vsock_skb_put(skb, payload_len);
 
+			if (batch.sk &&
+			    payload_len > VIRTIO_TRANSPORT_RX_BATCH_MAX_BYTES -
+					  batch.bytes) {
+				virtio_transport_rx_batch_finish(&batch);
+			}
+
 			virtio_transport_deliver_tap_pkt(skb);
 
 			/* Force virtio-transport into global mode since it
 			 * does not yet support local-mode namespacing.
 			 */
-			virtio_transport_recv_pkt(&virtio_transport, skb, NULL);
+			virtio_transport_recv_pkt_batch(&virtio_transport, skb, NULL,
+							&batch);
+
+			if (batch.sk) {
+				batch.pkts++;
+				batch.bytes += payload_len;
+				if (batch.pkts >= VIRTIO_TRANSPORT_RX_BATCH_MAX_PKTS ||
+				    batch.bytes >= VIRTIO_TRANSPORT_RX_BATCH_MAX_BYTES) {
+					virtio_transport_rx_batch_finish(&batch);
+				}
+			}
 		}
 	} while (!virtqueue_enable_cb(vq));
 
 out:
+	virtio_transport_rx_batch_finish(&batch);
 	if (vsock->rx_buf_nr < vsock->rx_buf_max_nr / 2)
 		virtio_vsock_rx_fill(vsock);
 out_nofill:
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index e3e75e59896f..a73e37b3fa62 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -576,10 +576,16 @@ virtio_transport_collapse_rx_queue(struct virtio_vsock_sock *vvs,
 	skb_queue_splice(&new_queue, &vvs->rx_queue);
 }
 
+static bool
+virtio_transport_rx_skb_has_headroom(struct virtio_vsock_sock *vvs)
+{
+	return (u64)(skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0) <=
+		vvs->buf_alloc;
+}
+
 static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
 					u32 len)
 {
-	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
 
 	/* Allow at most buf_alloc * 2 total budget (payload + overhead),
 	 * similar to how SO_RCVBUF is doubled to reserve space for sk_buff
@@ -588,7 +594,7 @@ static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
 	 * queue growth.
 	 */
 	if ((u64)vvs->buf_used + len > vvs->buf_alloc ||
-	    skb_overhead > vvs->buf_alloc)
+	    !virtio_transport_rx_skb_has_headroom(vvs))
 		return false;
 
 	vvs->rx_bytes += len;
@@ -1834,10 +1840,28 @@ struct virtio_transport_rx_pkt_ctx {
 	struct net *net;
 	const struct sockaddr_vm *src;
 	const struct sockaddr_vm *dst;
+	bool *batchable;
 };
 
+static bool
+virtio_transport_recv_pkt_batchable(struct virtio_transport *t,
+				    struct sock *sk)
+{
+	struct vsock_sock *vsk = vsock_sk(sk);
+	struct virtio_vsock_sock *vvs = vsk->trans;
+
+	return sk->sk_state == TCP_ESTABLISHED &&
+	       sk->sk_type == SOCK_STREAM &&
+	       READ_ONCE(sk->sk_prot) == sk->sk_prot_creator &&
+	       !sock_flag(sk, SOCK_DONE) &&
+	       vsk->transport == &t->transport &&
+	       vvs && virtio_transport_rx_skb_has_headroom(vvs);
+}
+
 /*
- * The caller holds sk's socket lock and must free skb if this returns true.
+ * The caller holds sk's socket lock.  Set @batchable if the socket can remain
+ * locked for another ordinary STREAM/RW packet.  Return true if the caller
+ * must free @skb.
  */
 static bool
 virtio_transport_recv_pkt_locked(struct virtio_transport *t,
@@ -1850,6 +1874,9 @@ virtio_transport_recv_pkt_locked(struct virtio_transport *t,
 	struct net *net = ctx->net;
 	bool space_available;
 
+	if (ctx->batchable)
+		*ctx->batchable = false;
+
 	/* Check after acquiring the socket lock. Listener sockets accept packets
 	 * from any source and are not assigned to a transport.
 	 */
@@ -1891,6 +1918,9 @@ virtio_transport_recv_pkt_locked(struct virtio_transport *t,
 		break;
 	}
 
+	if (ctx->batchable)
+		*ctx->batchable = virtio_transport_recv_pkt_batchable(t, sk);
+
 	return false;
 }
 
@@ -1941,6 +1971,117 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 }
 EXPORT_SYMBOL_GPL(virtio_transport_recv_pkt);
 
+/*
+ * Finish the RX batch.
+ * For a non-empty batch, the caller must hold the socket lock acquired with
+ * lock_sock(). This function releases the lock and the batch's lookup
+ * reference.
+ * An empty batch is a no-op.
+ */
+void virtio_transport_rx_batch_finish(struct virtio_transport_rx_batch *batch)
+{
+	struct sock *sk = batch->sk;
+
+	batch->sk = NULL;
+	batch->pkts = 0;
+	batch->bytes = 0;
+
+	if (!sk)
+		return;
+
+	release_sock(sk);
+	sock_put(sk);
+}
+EXPORT_SYMBOL_GPL(virtio_transport_rx_batch_finish);
+
+void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
+				     struct sk_buff *skb, struct net *net,
+				     struct virtio_transport_rx_batch *batch)
+{
+	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
+	struct virtio_transport_rx_pkt_ctx ctx;
+	struct sockaddr_vm src, dst;
+	bool batchable, start_batch;
+	struct sock *sk;
+	bool free_pkt;
+
+	/* Only STREAM/RW packets can share a socket lock. */
+	if (le16_to_cpu(hdr->type) != VIRTIO_VSOCK_TYPE_STREAM ||
+	    le16_to_cpu(hdr->op) != VIRTIO_VSOCK_OP_RW) {
+		virtio_transport_rx_batch_finish(batch);
+		virtio_transport_recv_pkt(t, skb, net);
+		return;
+	}
+
+	virtio_transport_recv_pkt_init_addrs(skb, &src, &dst);
+	virtio_transport_trace_recv_pkt(skb, &src, &dst);
+
+	sk = virtio_transport_recv_pkt_find_socket(skb, &src, &dst, net);
+	if (!sk) {
+		virtio_transport_rx_batch_finish(batch);
+		(void)virtio_transport_reset_no_sock(t, skb, net);
+		kfree_skb(skb);
+		return;
+	}
+
+	if (!skb_set_owner_sk_safe(skb, sk)) {
+		WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
+		virtio_transport_rx_batch_finish(batch);
+		kfree_skb(skb);
+		return;
+	}
+
+	if (batch->sk && batch->sk != sk) {
+		/* Never acquire a second socket lock. */
+		virtio_transport_rx_batch_finish(batch);
+	}
+
+	if (batch->sk == sk) {
+		/* Keep the batch reference; drop this packet's lookup reference. */
+		sock_put(sk);
+		ctx = (struct virtio_transport_rx_pkt_ctx) {
+			.net = net,
+			.src = &src,
+			.dst = &dst,
+			.batchable = &batchable,
+		};
+		free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, &ctx);
+		if (!batchable)
+			virtio_transport_rx_batch_finish(batch);
+		if (free_pkt)
+			kfree_skb(skb);
+		return;
+	}
+
+	lock_sock(sk);
+	/*
+	 * Sockmap removal restores the native protocol under sk_callback_lock.
+	 * Serialize this initial eligibility check with that update.
+	 */
+	read_lock_bh(&sk->sk_callback_lock);
+	start_batch = virtio_transport_recv_pkt_batchable(t, sk);
+	read_unlock_bh(&sk->sk_callback_lock);
+
+	ctx = (struct virtio_transport_rx_pkt_ctx) {
+		.net = net,
+		.src = &src,
+		.dst = &dst,
+		.batchable = start_batch ? &batchable : NULL,
+	};
+	free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, &ctx);
+	if (start_batch && batchable) {
+		/* Keep the lookup reference until the batch is released. */
+		batch->sk = sk;
+		return;
+	}
+
+	release_sock(sk);
+	sock_put(sk);
+	if (free_pkt)
+		kfree_skb(skb);
+}
+EXPORT_SYMBOL_GPL(virtio_transport_recv_pkt_batch);
+
 /* Remove skbs found in a queue that have a vsk that matches.
  *
  * Each skb is freed.
-- 
2.34.1
