Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F12249CF3E
	for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 14:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791642236; cv=none; b=uItNkHdiCpWYkHj7Y4nMs8G03bFRzb/GrkJOKm146LhLXE5fT/HFSGd93U9SH3/JHHTBzgQEOICXipzdJyxmVLnf7j9IX5szzUiqFyC3M0cSAvo0tZBvzVDoNy+If/5QLudgsbwysE7g3Ov3hJos+1XsA94rr4M6ea0XVhpM4ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791642236; c=relaxed/simple;
	bh=L1eZIEVU/ofQte2gvNih6Bludiqn1MxT0tCVYZyJVP8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kZykuIUF6zeZ/75HTCOvC0zk8ognC0fFBAUxBi8hBHYv7wGkkST/m70TOjCrKdG3w3vthLYqcnG0HpkohB3SLrmcM2vJTs0nOZOlfmLTl1P+D+00cgHHcOylRR/sLY+psziWsG5yG8/lk5Z2ofrJvHxDvnFoCqieBqCLJxuyfHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SfgDWM3G; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SfgDWM3G"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e812e2b31bso2703025ad.3
        for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 07:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791642235; x=1792247035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ow0+9kC3h+sUBY7u1HdgedXX1Au0fVpDxstdKdYipeg=;
        b=SfgDWM3GC7fNatBSAVxB3HKeX1p4q50JUPDNDsu+BgaOEGlc0lM0fJTXi8Glw7HXsi
         00EkUjhOhOaDsF4ComoFsEDymSQYu8+x2Fv8liFLrH4QRJ42WI/fQyz3zth3zh32AsuH
         BaTjAIgGMmabCCSI6vlfJcoYHxzn3AxAlbI1P6paDgETNlnsouFYD//rFvRDFreq7Cod
         3rPnx/DtC3STqEqKe4HW0+maUMiPhEWIOsoU/tOSOEwiITcwulzI2kwxi2FXkgNEN7ci
         vWgx/q6SmmKf6MBzlNowbWBGaiOlpvyADqpz1StYNvM5C5a+y64wHxm0lXBluEXHcIxk
         2sLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791642235; x=1792247035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ow0+9kC3h+sUBY7u1HdgedXX1Au0fVpDxstdKdYipeg=;
        b=TXbTb8Os0bJTR1q44hsiM77Qf78FnvmexLvEhPrARjjcOnAGf2NWuJ79kB8OP8yiNJ
         +f15twWTue34ucujSFZMc89p3Rdt6L+i1+Gk3mrYTRRcvubpL3Fv0+YNIdE/3/HgKT9v
         Jdglt4le6Z7Tgr/vixRJEOtKPGhl+3Nwg7IGV8mC/qouy70jr5nsuQYdnI8Fnevk00gV
         WveMkDteV8MJSWio3lUxBsUfaBXV4msn5KiPM+LjGZlpIiaAbXzXHnCL/cU0xQfzW8FS
         QqaAXEHCWfPkWeOT2dyj3X4C3VB2pu/doZ5AUDsnHiQyJe2bBWU13/an/saSz0dxCHMN
         /4Nw==
X-Forwarded-Encrypted: i=1; AKwUvBzLVRFuI7OCRe2iEsZ6rvv0W5MNBeIsOmp7yQPTun2Q73TFu6c9nh9q8QfGYMdLXnk0eQM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKh7CoMSOYxLGMJ3aWPDTYfubL+AYDuZ53HwWWxdHBRuLTCkJaG
	dDvflJD/3XI4tHY8Kp7atGwJvAbjpL1Xn2KcQfGrWn1+kDK3Gdr8L5qx
X-Gm-Gg: AYBFou2JakZCIenrxYBHyNsqbJ3XO1vY2XKjkqT3s0W990Y77lZCCpjUx9mapsEPesV
	wa1ecbRIReOnR0rwFUj4GyC3s8AiN3U3odzpKRjzRrZtU58zSvDttXuU4jmezxptudUjSt+0w0B
	M6CxgSuVgQRuGYuf/0MpnsxDlRl2HsWjelQAAywBrf3QJ4VLAeqkFEnxByy1QlScRWzaVpPFbLX
	mqd8FRRtCyJ58DcqgPXshzWdPLWf/5UUm/6m+RNN409ebFOnC90yHh8VMp/3YXqrXbMljFV/C2p
	Tdq/PkcDylMbs9kjDxnfbN29L/xSWNiygU9uU54VIgvtcVU/lbMubacxi+u6jnsjsF9DcKiMAmj
	QZRjDjk+h93X3gMhXe/0xkFmkbJfShY4oHmfOl+UpM5QsnZqUlH/MbpupDb5//1VkFinUFmhjdT
	rEQRdQICUJSZZ4ZY4kuq4zUZT8c8jKFBGQoeqSZfBIE1X9aKdiKioMBwHG4HMk4Vs+6TNycg==
X-Received: by 2002:a17:902:dac2:b0:2e4:adb3:c776 with SMTP id d9443c01a7336-2e842bc0a1fmr42948105ad.24.1791642234303;
        Sat, 10 Oct 2026 07:23:54 -0700 (PDT)
Received: from gmail.com ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e841a0401esm23676615ad.4.2026.10.10.07.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 07:23:51 -0700 (PDT)
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
Subject: [PATCH net-next v2 5/5] vsock/virtio: defer RX readable notifications until batch unlock
Date: Sat, 10 Oct 2026 22:22:47 +0800
Message-Id: <20261010142247.99223-6-physicalmtea@gmail.com>
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

An RX batch can make a socket readable while the worker still owns its
socket lock. Waking a reader at that point can make it immediately wait
for the same lock.

For the callback installed by sock_init_data(), record when the existing
low-watermark condition is met and issue one notification after the batch
releases the lock. Save the initial sock_def_readable() callback when the
AF_VSOCK socket is created because virtio_transport_common can be built as
a module and cannot refer to that unexported symbol directly.

When sk_data_ready or sk_write_space no longer matches that initial
callback, pass queued skbs to the current callback one skb at a time. The
handoff stops if the callback is the default again or the queue does not
shrink. After 64 successful callbacks, queue another bounded handoff if
data remains. vsock_bpf_update_proto() schedules the same handoff so an
attach or detach outside the worker still drains skbs already queued.

Always deliver a coalesced write-space event to the saved default callback
before sampling the callback state. A current replacement is invoked by
the handoff as well, so a callback change cannot hide the native writer
wakeup or pending sockmap work.

Sampling at batch finish takes sk_callback_lock once. The per-packet fast
path still uses READ_ONCE() and does not take that lock. Control packets,
state transitions, transport changes and non-batched sockets keep their
existing behavior.

Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 include/linux/virtio_vsock.h            |   1 +
 include/net/af_vsock.h                  |   8 +-
 net/vmw_vsock/af_vsock.c                | 103 ++++++++++++++++++++++++
 net/vmw_vsock/virtio_transport_common.c |  73 ++++++++++++++---
 net/vmw_vsock/vsock_bpf.c               |   2 +
 5 files changed, 174 insertions(+), 13 deletions(-)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 3a58120d9078..21a3460b940f 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -291,6 +291,7 @@ struct virtio_transport_rx_batch {
 	struct sockaddr_vm src;
 	struct sockaddr_vm dst;
 	bool write_space_pending;
+	bool data_ready_pending;
 };
 
 void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index 9d8ae62209ed..86d6e6ba3d9d 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -63,8 +63,11 @@ struct vsock_sock {
 	u32 peer_shutdown;
 	bool sent_request;
 	bool ignore_connecting_rst;
-	/* Initial callback, used to identify replacements. */
+	/* Initial callbacks, used to identify replacements. */
+	void (*default_data_ready)(struct sock *sk);
 	void (*default_write_space)(struct sock *sk);
+	struct delayed_work rx_cb_work;
+	bool rx_cb_retried;
 
 	/* Protected by lock_sock(sk) */
 	u64 buffer_size;
@@ -80,6 +83,9 @@ s64 vsock_stream_has_data(struct vsock_sock *vsk);
 s64 vsock_stream_has_space(struct vsock_sock *vsk);
 struct sock *vsock_create_connected(struct sock *parent);
 void vsock_data_ready(struct sock *sk);
+bool vsock_rx_cb_is_native(struct sock *sk);
+void vsock_rx_callback_kick(struct sock *sk);
+void vsock_rx_callback_handoff(struct sock *sk);
 
 /**** TRANSPORT ****/
 
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index fe7f49da6c4b..df6faee0bd37 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -931,6 +931,107 @@ static int __vsock_bind(struct sock *sk, struct sockaddr_vm *addr)
 	return retval;
 }
 
+#define VSOCK_RX_CB_HANDOFF_MAX 64
+
+static void vsock_rx_callback_queue(struct sock *sk, unsigned long delay)
+{
+	struct vsock_sock *vsk = vsock_sk(sk);
+
+	sock_hold(sk);
+	if (!schedule_delayed_work(&vsk->rx_cb_work, delay))
+		sock_put(sk);
+}
+
+void vsock_rx_callback_kick(struct sock *sk)
+{
+	vsock_rx_callback_queue(sk, 0);
+}
+
+/* Caller holds sk_callback_lock. */
+bool vsock_rx_cb_is_native(struct sock *sk)
+{
+	struct vsock_sock *vsk = vsock_sk(sk);
+
+	return READ_ONCE(sk->sk_prot) == sk->sk_prot_creator &&
+	       READ_ONCE(sk->sk_data_ready) == vsk->default_data_ready &&
+	       READ_ONCE(sk->sk_write_space) == vsk->default_write_space;
+}
+EXPORT_SYMBOL_GPL(vsock_rx_cb_is_native);
+
+/* Caller holds lock_sock(). */
+void vsock_rx_callback_handoff(struct sock *sk)
+{
+	struct vsock_sock *vsk = vsock_sk(sk);
+	void (*write_space)(struct sock *sk);
+	void (*data_ready)(struct sock *sk);
+	bool wrote = false;
+	s64 before, after;
+	int i;
+
+	if (sock_flag(sk, SOCK_DEAD) || !vsk->transport)
+		return;
+
+	read_lock_bh(&sk->sk_callback_lock);
+	data_ready = READ_ONCE(sk->sk_data_ready);
+	if (READ_ONCE(sk->sk_prot) != sk->sk_prot_creator &&
+	    data_ready == vsk->default_data_ready) {
+		read_unlock_bh(&sk->sk_callback_lock);
+		/*
+		 * start_verdict publishes sk_data_ready after the proto swap.
+		 * Retry once before treating this as a stable non-RX setup.
+		 */
+		if (!vsk->rx_cb_retried) {
+			vsk->rx_cb_retried = true;
+			vsock_rx_callback_queue(sk, 1);
+			return;
+		}
+		vsk->rx_cb_retried = false;
+		data_ready(sk);
+		return;
+	}
+	read_unlock_bh(&sk->sk_callback_lock);
+	vsk->rx_cb_retried = false;
+
+	for (i = 0; i < VSOCK_RX_CB_HANDOFF_MAX; i++) {
+		read_lock_bh(&sk->sk_callback_lock);
+		data_ready = READ_ONCE(sk->sk_data_ready);
+		write_space = READ_ONCE(sk->sk_write_space);
+		read_unlock_bh(&sk->sk_callback_lock);
+
+		if (!wrote && write_space != vsk->default_write_space) {
+			write_space(sk);
+			wrote = true;
+		}
+		if (data_ready == vsk->default_data_ready) {
+			data_ready(sk);
+			break;
+		}
+		before = vsock_stream_has_data(vsk);
+		if (before <= 0)
+			break;
+		data_ready(sk);
+		after = vsock_stream_has_data(vsk);
+		if (after >= before)
+			break;
+		if (i == VSOCK_RX_CB_HANDOFF_MAX - 1 && after > 0)
+			vsock_rx_callback_queue(sk, 0);
+	}
+}
+EXPORT_SYMBOL_GPL(vsock_rx_callback_handoff);
+
+static void vsock_rx_callback_work(struct work_struct *work)
+{
+	struct vsock_sock *vsk = container_of(work, struct vsock_sock,
+					      rx_cb_work.work);
+	struct sock *sk = sk_vsock(vsk);
+
+	lock_sock(sk);
+	if (!sock_flag(sk, SOCK_DEAD))
+		vsock_rx_callback_handoff(sk);
+	release_sock(sk);
+	sock_put(sk);
+}
+
 static void vsock_connect_timeout(struct work_struct *work);
 
 static struct sock *__vsock_create(struct net *net,
@@ -958,6 +1059,7 @@ static struct sock *__vsock_create(struct net *net,
 		sk->sk_type = type;
 
 	vsk = vsock_sk(sk);
+	vsk->default_data_ready = sk->sk_data_ready;
 	vsk->default_write_space = sk->sk_write_space;
 	vsock_addr_init(&vsk->local_addr, VMADDR_CID_ANY, VMADDR_PORT_ANY);
 	vsock_addr_init(&vsk->remote_addr, VMADDR_CID_ANY, VMADDR_PORT_ANY);
@@ -976,6 +1078,7 @@ static struct sock *__vsock_create(struct net *net,
 	WRITE_ONCE(vsk->peer_shutdown, 0);
 	INIT_DELAYED_WORK(&vsk->connect_work, vsock_connect_timeout);
 	INIT_DELAYED_WORK(&vsk->pending_work, vsock_pending_work);
+	INIT_DELAYED_WORK(&vsk->rx_cb_work, vsock_rx_callback_work);
 
 	psk = parent ? vsock_sk(parent) : NULL;
 	if (parent) {
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index f0398ae2200d..5499cd1d8a25 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1583,10 +1583,12 @@ out:
 
 static int
 virtio_transport_recv_connected(struct sock *sk,
-				struct sk_buff *skb)
+				struct sk_buff *skb,
+				bool *data_ready_pending)
 {
 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
 	struct vsock_sock *vsk = vsock_sk(sk);
+	void (*data_ready)(struct sock *sk);
 	int err = 0;
 
 	switch (le16_to_cpu(hdr->op)) {
@@ -1602,7 +1604,23 @@ virtio_transport_recv_connected(struct sock *sk,
 			vsock_remove_sock(vsk);
 			break;
 		}
-		vsock_data_ready(sk);
+		if (!data_ready_pending) {
+			vsock_data_ready(sk);
+		} else {
+			data_ready = READ_ONCE(sk->sk_data_ready);
+			if (data_ready == vsk->default_data_ready) {
+				if (!*data_ready_pending &&
+				    (vsock_stream_has_data(vsk) >= sk->sk_rcvlowat ||
+				     sock_flag(sk, SOCK_DONE)))
+					*data_ready_pending = true;
+			} else {
+				/* Use the callback seen for this packet. */
+				*data_ready_pending = false;
+				if (vsock_stream_has_data(vsk) >= sk->sk_rcvlowat ||
+				    sock_flag(sk, SOCK_DONE))
+					data_ready(sk);
+			}
+		}
 		return err;
 	case VIRTIO_VSOCK_OP_CREDIT_REQUEST:
 		virtio_transport_send_credit_update(vsk);
@@ -1836,6 +1854,7 @@ struct virtio_transport_rx_pkt_ctx {
 	const struct sockaddr_vm *dst;
 	bool *batchable;
 	struct virtio_transport_rx_batch *batch;
+	bool defer_data_ready;
 };
 
 static bool
@@ -1909,7 +1928,9 @@ virtio_transport_recv_pkt_locked(struct virtio_transport *t,
 		kfree_skb(skb);
 		break;
 	case TCP_ESTABLISHED:
-		virtio_transport_recv_connected(sk, skb);
+		virtio_transport_recv_connected(sk, skb,
+						ctx->defer_data_ready && ctx->batch ?
+						&ctx->batch->data_ready_pending : NULL);
 		break;
 	case TCP_CLOSING:
 		virtio_transport_recv_disconnecting(sk, skb);
@@ -1978,33 +1999,45 @@ EXPORT_SYMBOL_GPL(virtio_transport_recv_pkt);
  * Finish the RX batch.
  * For a non-empty batch, the caller must hold the socket lock acquired with
  * lock_sock(). This function releases the lock and the batch's lookup
- * reference.
- * An empty batch is a no-op.
+ * reference. An empty batch is a no-op.
  */
 void virtio_transport_rx_batch_finish(struct virtio_transport_rx_batch *batch)
 {
 	bool write_space_pending = batch->write_space_pending;
-	void (*write_space)(struct sock *sk);
+	bool data_ready_pending = batch->data_ready_pending;
 	struct sock *sk = batch->sk;
 	struct vsock_sock *vsk;
+	bool native;
 
 	batch->sk = NULL;
 	batch->pkts = 0;
 	batch->bytes = 0;
 	batch->net = NULL;
 	batch->write_space_pending = false;
+	batch->data_ready_pending = false;
 
 	if (!sk)
 		return;
 
-	if (write_space_pending) {
-		vsk = vsock_sk(sk);
+	vsk = vsock_sk(sk);
+	if (write_space_pending)
 		vsk->default_write_space(sk);
-		write_space = READ_ONCE(sk->sk_write_space);
-		if (write_space != vsk->default_write_space)
-			write_space(sk);
+
+	read_lock_bh(&sk->sk_callback_lock);
+	native = vsock_rx_cb_is_native(sk);
+	read_unlock_bh(&sk->sk_callback_lock);
+
+	if (native) {
+		release_sock(sk);
+		if (data_ready_pending)
+			vsk->default_data_ready(sk);
+		sock_put(sk);
+		return;
 	}
 
+	if (write_space_pending || data_ready_pending)
+		vsock_rx_callback_handoff(sk);
+
 	release_sock(sk);
 	sock_put(sk);
 }
@@ -2015,9 +2048,9 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
 				     struct virtio_transport_rx_batch *batch)
 {
 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
+	bool batchable, defer_data_ready, start_batch;
 	struct virtio_transport_rx_pkt_ctx ctx;
 	struct sockaddr_vm src, dst;
-	bool batchable, start_batch;
 	struct sock *sk;
 	bool free_pkt;
 
@@ -2038,6 +2071,17 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
 		    vsock_addr_equals_addr(&batch->dst, &dst) &&
 		    virtio_transport_recv_pkt_batchable(t, batch->sk)) {
 			sk = batch->sk;
+			defer_data_ready = READ_ONCE(sk->sk_data_ready) ==
+					   vsock_sk(sk)->default_data_ready;
+			if (unlikely(batch->data_ready_pending && !defer_data_ready)) {
+				/*
+				 * BPF map updates can replace callbacks while lock_sock()
+				 * remains held. Finish the old notification first.
+				 */
+				virtio_transport_rx_batch_finish(batch);
+				goto lookup;
+			}
+
 			if (!skb_set_owner_sk_safe(skb, sk)) {
 				WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
 				virtio_transport_rx_batch_finish(batch);
@@ -2051,6 +2095,7 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
 				.dst = &dst,
 				.batchable = &batchable,
 				.batch = batch,
+				.defer_data_ready = defer_data_ready,
 			};
 			free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, &ctx);
 
@@ -2064,6 +2109,7 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
 		virtio_transport_rx_batch_finish(batch);
 	}
 
+lookup:
 	sk = virtio_transport_recv_pkt_find_socket(skb, &src, &dst, net);
 	if (!sk) {
 		virtio_transport_rx_batch_finish(batch);
@@ -2089,6 +2135,8 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
 
 	if (start_batch)
 		batch->sk = sk;
+	defer_data_ready = start_batch &&
+		READ_ONCE(sk->sk_data_ready) == vsock_sk(sk)->default_data_ready;
 
 	ctx = (struct virtio_transport_rx_pkt_ctx) {
 		.net = net,
@@ -2096,6 +2144,7 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
 		.dst = &dst,
 		.batchable = start_batch ? &batchable : NULL,
 		.batch = start_batch ? batch : NULL,
+		.defer_data_ready = defer_data_ready,
 	};
 	free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, &ctx);
 	if (start_batch && batchable) {
diff --git a/net/vmw_vsock/vsock_bpf.c b/net/vmw_vsock/vsock_bpf.c
index 9049d2648646..7770a6c51dbe 100644
--- a/net/vmw_vsock/vsock_bpf.c
+++ b/net/vmw_vsock/vsock_bpf.c
@@ -154,6 +154,7 @@ int vsock_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore
 	if (restore) {
 		sk->sk_write_space = psock->saved_write_space;
 		sock_replace_proto(sk, psock->sk_proto);
+		vsock_rx_callback_kick(sk);
 		return 0;
 	}
 
@@ -166,6 +167,7 @@ int vsock_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore
 
 	vsock_bpf_check_needs_rebuild(psock->sk_proto);
 	sock_replace_proto(sk, &vsock_bpf_prot);
+	vsock_rx_callback_kick(sk);
 	return 0;
 }
 
-- 
2.34.1

