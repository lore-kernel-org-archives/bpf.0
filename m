Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316827;
	b=O/2eA6jH2rXQDVeeKWEsfqE/CrGtuNwDWew8Ywz3WBNB/O9nR08pjaDhFw6W3Vc9DIRI
	 AOifj3GIPE05+Ud/3rDi8J3//mkueF6Lr5tVENRy3pXEZJ15p8ji1i5v+2/pWqCxvpjCV
	 el1SHTScD5hBS33drvjbOuXTlcFpoUqvGZi+HBYVtkYjZLkYZ9rS+5gxZHeamIZwJ0IF5
	 c/a3KfyZpPO+uVE5gbIsPWNNp9eX6VsgxBsDGCIeegLTa6zlV1dJ7KbfH8qlCRy/TBCXu
	 jPTc0rAA+pJIOGgUkc/LRKuBoONFdoduVbhecPhskX00o3zzDlNnZN592d8wSAPtVUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316827;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Pz31vqC+wo+2o0gCwLIYMEAmmQRln4Z15UJNZwFA8/w=;
	b=XW3O4Ra64Fxd3QRqoNZsARe/EPdSs9X7bw3tQRXfE5qT30O/ZK7Rhi35QGTzJvwB9aOT
	 xjo1f49bG+NxpJ2xfhwLziVG+jEWMWcqqMauBOmwsgsyoK0F9pnvZ5W8HtDDPUkjVgsWs
	 97CNG+n0fciqeU80gkanrllw2jgc9/4B5Rd6ZJxMfViFbgDYTnTgqrm1tPDUaE/8YAeWA
	 SPmFFf7/dUenkdf4JVYt4eP3VFjpHzprUVSNgZtFscSWWFXtSoYFIYr2uHVSiGEFZ7bHJ
	 zxD54gEID2BbPVQqN8e+DCHTeJCziy+WyskjHP8U+WCX1jHDqbb5mKt0eJzVSUQLt1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=i5ImY9Y5;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=PnAUqEYB;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75DD606A9C3
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 13:20:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C75DD606A9C3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=i5ImY9Y5;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=PnAUqEYB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794316825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pz31vqC+wo+2o0gCwLIYMEAmmQRln4Z15UJNZwFA8/w=;
	b=i5ImY9Y5ARC41M4KP/jgVeeh6UgMhS4stEP5uNVbSNU8g6A2z3eft4adhQ1f17LhNZ+zdf
	IlviEzX/PKJX7Vi3Y9Uz8O4N6wDY0zrp4GkYe3ZhUcjTkempCxmaHQJkOGz8QqJbE9vSsH
	3M+Q4BNFLKfbuAQcPVyoiQW91fsmSwY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-eIjUzOBbPV-SoQk12GkLIg-1; Tue, 10 Nov 2026 08:20:21 -0500
X-MC-Unique: eIjUzOBbPV-SoQk12GkLIg-1
X-Mimecast-MFC-AGG-ID: eIjUzOBbPV-SoQk12GkLIg_1794316820
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c40aa03ded8so231465066b.2
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 05:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794316820; x=1794921620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pz31vqC+wo+2o0gCwLIYMEAmmQRln4Z15UJNZwFA8/w=;
        b=PnAUqEYBiOglTgIkrbuaGLSVg4NRaWwFIMAy53ceaXOnaLJK90AhoYBMsdbI2Bxt49
         vO6YEY1sV/bTY4lVz6GyYT063TxtSGuh8ndF+XaSO10GrUQsh4/j67S78FtxDn8FM5C0
         /0v5FN0rV/po+r3xwI8sSuRmWq0/a/GwjEjDue7TQaGR5q/ICZvfTh3KRrq3qmPQIPj6
         hfDGIwDPGghJJhCP5pTpUyuvEqxwYmMzUMYD+F0cWAqBuLbtV+gD9Yr8ixSARXsPTzKF
         MlAGBMGac6UxbKZObRg3wlAc9biwukBN9w9X5MMGyBWI7z/IFK2RGGbAX5FHfd7cyGtx
         JSHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794316820; x=1794921620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Pz31vqC+wo+2o0gCwLIYMEAmmQRln4Z15UJNZwFA8/w=;
        b=Rxyc/0prkvP65IyuEjyOU4WKLLpIMIzVAYlzkGYMaduRpN0XRx+UgysE5dy9NP2ppI
         d4PXg8dmcacqXI5UoU75TTX7lHbbCubv7c62sOqVY49+PInHvvfLnuBcGP1O4icU40Lc
         dACXctnESP+wfpDg3xkJDUWdLg8TwRLwi/k5XD7pwKLyZHuGw8NfIjUuLozGtCbpQu+K
         nBqE6BpT7ngAxlNZP2JUNG7rUpMRqIpTV7bzZq0TxBynx2yRRb+bApAu1C1TAL5J55FK
         ls+hgvfR28SE0Lq12bdBe+37L470ltb/YaZETCEeZQ0X7I7SaRSju4UsNJqLx0mDuf7t
         4G3w==
X-Forwarded-Encrypted: i=1; AL+hErHNxR91RYjN95239t8Nf2qV2z4Q4Mx5tkNYDqvBJxZiKY2B0iw+CHxxMRV0tmMydBQzJ4I=@vger.kernel.org
X-Gm-Message-State: APuU4Z+1WnTbEWunl+aAe/UGEaEaFIeaV2cSYBTr1yEChFcn26MPrMwH
	cBISk4Ub3M0WG+fviYW5XYFLehcrO3OYvhASxl1FDzzZVzk3CTeYuADYHw8p62lBBkmmsCiZ1M1
	9GKCabWa2opMFveZC/sD4Wu4YRv4XemFzcYtfUaZUkau3puBc2qT5Xd1opybfNg==
X-Gm-Gg: AYBFou1cws4TeQLnd0JN5Q41TKn64eV8WJ1Kewe0IIB0hj0vczQAIxZEFG+1eoJ/h6J
	YOJrgFryZjjyGkBMmhpj/OX5gvc9azsEsv5eQ7WZhKyABnBNNd6Q/ldR23hZodyoQBOYYQs8B94
	tqAep5FbrLEyZCy9SDdLBIbeRC5SVbkzFteiOtT/b7X4rB/zf2PYK1NVOnnFwBlek7Mdo+HkeU3
	Tf0wvtwdCeiMWft3K/nOSF162XpBUEIP1AUErPEypZPnhr0BY2Tf/kWj+XPNFstuUdzWDl7ylZi
	hnNwQJ11IekRkob2Y5LQhjeroEeVfwM3p8sBZdkjJXMBEGstJSPmYHjkOME6HAXGp01JyFsX8K0
	2i3MbLT1+sZ0jWi0kVTUv6nCTXWFYJWARhG4utgsV+LQ5ykywTNGQRTK2ktQOcSsodpIbKn6nqE
	7M4RYUz3z6ggXxcO86g80k0bOhNdIXKKToeK9f9ThBI1UnPVRm5fxCS9Ie5f94ciHFGKiaLzS4Q
	06j9lMoDxHkQB/5CzF9mZVcLa9PpujaOTXQ/Ac83dfnwp+cEVid
X-Received: by 2002:a17:906:4796:b0:c40:f9ea:7387 with SMTP id a640c23a62f3a-c5048f7d65fmr227824666b.6.1794316819503;
        Tue, 10 Nov 2026 05:20:19 -0800 (PST)
X-Received: by 2002:a17:906:4796:b0:c40:f9ea:7387 with SMTP id a640c23a62f3a-c5048f7d65fmr227820766b.6.1794316818204;
        Tue, 10 Nov 2026 05:20:18 -0800 (PST)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a5d54bbsm107791166b.48.2026.11.10.05.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 05:20:17 -0800 (PST)
From: Alex Markuze <amarkuze@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	io-uring@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next 07/12] io_uring/opaque: add IORING_OP_OPAQUE_OBJ_SEND
Date: Tue, 10 Nov 2026 13:20:01 +0000
Message-Id: <20261110132006.3280986-8-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261110132006.3280986-1-amarkuze@redhat.com>
References: <20261110132006.3280986-1-amarkuze@redhat.com>
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

Add an operation that queues an optional prefix, an object range and an
optional suffix to a TCP socket, reporting the queued byte count in one
CQE.

sqe->fd names the socket; addr, off and len select the object range;
addr3 optionally points to an io_uring_opaque_frame descriptor. Combined
framing is limited to 64 KiB. ioprio accepts SEND_LAST and msg_flags
accepts MSG_MORE and MSG_DONTWAIT. With a zero handle, offset and length,
the request sends only framing bytes as an object-free reply.

Preparation copies the frame descriptor when the kernel consumes this
SQE. Its storage must survive until that consumption, which a short or
failed submission may leave pending. Prefix and suffix bytes are copied
at first issue, before handle acquisition, and must remain valid until
then. The request owns the resulting copy, charged to the store and its
memory cgroup; framing can use the reply reserve.

The body uses MSG_SPLICE_PAGES over the immutable version's bio_vecs.
Indexed segment lookup finds the range's start. One cursor tracks prefix,
body and suffix so retries continue at the first unqueued byte. Without
MSG_DONTWAIT, the request waits for socket space until it finishes or an
error, signal or cancellation ends it. The result counts bytes queued to
TCP, not delivered to the peer.

Sends through one store to one socket enter a FIFO under the store's TX
lock after frame import during first issue. The ordering is by enqueue,
not SQE submission or the start of issue on concurrent rings. Only
the head sends and polls; followers resume through their own ring's task
work. The head leaves when its frame finishes or terminates. If it ends
after queuing only part of the frame, its followers complete -ECANCELED,
including admissions still acquiring object references. The failure
remains visible until both linked requests and admissions drain. A head
that queued nothing does not fail its followers. Cancellation of linked
followers proceeds in batches of 32 outside the queue lock between
batches. Writers outside this store do not participate in the FIFO.

The store indexes queues by socket address under tx_lock. Up to 64 empty
queues are retained for reuse. Their keys are compared, never
dereferenced; a reused address finds an empty, nonfailed queue.

An ordinary send pins the current version while leaving the handle
usable. SEND_LAST removes the handle at acquisition and transfers its
reference to the request. CONSUMED reports that transfer even if the
request later fails, is canceled or completes short. A failure before
acquisition consumes nothing. Competing LAST requests cannot both acquire
the same handle.

For plain TCP, the head acquires its references, sends each frame part,
advances the queue and drops nonfinal references under one socket lock.
Final version release follows release_sock(). The issue performs the
security hook, RPS recording and send-length tracing normally supplied
by sock_sendmsg(); the hook runs before lock_sock(), since it may take
that lock. A replaced TCP protocol uses sock_sendmsg() instead, and the
direct path rechecks the protocol between frame parts after TCP may have
dropped the socket lock.

With IO_URING_F_UNLOCKED, the ring lock is dropped before acquiring the
socket lock. Inline issue retains its ring lock. Nothing may wait for a
socket lock while holding the table mutex. Short and failed sends fail
their link chain.

Reserve the FIFO position in the first TX lock hold, before acquiring
references, including queue creation, but after frame import. Queue metadata
uses accounted nonblocking allocation; ENOMEM precedes handle acquisition
or LAST. A busy queue holds a socket reference independently of request
files. That reference is released outside the TX lock when its last
position drains. Idle queues pin no socket. Pending failures keep their
position through cleanup, preserving
the failure barrier without allowing socket-address reuse.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 include/uapi/linux/io_uring.h        |   4 +
 include/uapi/linux/io_uring/opaque.h |   3 +
 io_uring/opaque.c                    | 933 ++++++++++++++++++++++++++-
 io_uring/opdef.c                     |  21 +
 4 files changed, 958 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index 081f30605410..1759f4f805b1 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -321,6 +321,7 @@ enum io_uring_op {
 	IORING_OP_NOP128,
 	IORING_OP_URING_CMD128,
 	IORING_OP_OPAQUE_OBJ,
+	IORING_OP_OPAQUE_OBJ_SEND,
 
 	/* this goes last, obviously */
 	IORING_OP_LAST,
@@ -534,6 +535,8 @@ struct io_uring_cqe {
  *			if a large CQE is attempted posted when the ring has
  *			just a single small CQE worth of space left before
  *			wrapping.
+ * IORING_CQE_F_OPAQUE_CONSUMED OPAQUE_OBJ_SEND took ownership of the entire
+ *			object handle. Also valid on short or failed completions.
  * IORING_CQE_F_32	If set, this is a 32b/big-cqe posting. Use with rings
  *			setup in a mixed CQE mode, where both 16b and 32b
  *			CQEs may be posted to the CQ ring.
@@ -544,6 +547,7 @@ struct io_uring_cqe {
 #define IORING_CQE_F_NOTIF		(1U << 3)
 #define IORING_CQE_F_BUF_MORE		(1U << 4)
 #define IORING_CQE_F_SKIP		(1U << 5)
+#define IORING_CQE_F_OPAQUE_CONSUMED	(1U << 6)
 #define IORING_CQE_F_32			(1U << 15)
 
 #define IORING_CQE_BUFFER_SHIFT		16
diff --git a/include/uapi/linux/io_uring/opaque.h b/include/uapi/linux/io_uring/opaque.h
index 9a129b5da5af..2a862d76a40e 100644
--- a/include/uapi/linux/io_uring/opaque.h
+++ b/include/uapi/linux/io_uring/opaque.h
@@ -59,6 +59,9 @@ enum io_uring_opaque_op {
 	IORING_OPAQUE_AVAILABLE,
 };
 
+/* IORING_OP_OPAQUE_OBJ_SEND: sqe->ioprio contains these flags. */
+#define IORING_OPAQUE_SEND_LAST	(1U << 0)
+
 /* Optional SEND sqe->addr3 framing; size includes zero reserved extensions. */
 struct io_uring_opaque_frame {
 	__u32 size;
diff --git a/io_uring/opaque.c b/io_uring/opaque.c
index 81fbf2011446..b62c4be92fea 100644
--- a/io_uring/opaque.c
+++ b/io_uring/opaque.c
@@ -12,7 +12,9 @@
 #include <linux/sizes.h>
 #include <linux/slab.h>
 #include <linux/workqueue.h>
+#include <net/rps.h>
 #include <net/tcp.h>
+#include <trace/events/sock.h>
 #include <uapi/linux/io_uring/opaque.h>
 
 #include "io_uring.h"
@@ -32,8 +34,10 @@ void io_opaque_cache_free(struct io_ring_ctx *ctx)
 	io_alloc_cache_free(&ctx->opaque_cache, kfree);
 }
 
+static void io_opaque_resume(struct io_tw_req tw_req, io_tw_token_t tw);
 static void io_opaque_ready(struct io_tw_req tw_req, io_tw_token_t tw);
 static void io_opaque_stream_close(struct io_opaque_stream *stream);
+static void io_opaque_tx_put(struct io_opaque_req *op);
 
 static bool io_opaque_budget_ready(struct io_opaque_req *op, unsigned long now)
 {
@@ -253,6 +257,37 @@ void io_opaque_release_transient(struct io_opaque_store *store, u64 uncharge,
 		io_opaque_wake_budget(store);
 }
 
+/* Framing uses ordinary capacity first and the reply reserve only when that is full. */
+bool io_opaque_charge_frame(struct io_opaque_store *store, u64 bytes, bool *reserved)
+{
+	u64 limit = store->config.reply_reserve;
+	s64 used;
+
+	if (io_opaque_charge_transient(store, bytes, io_opaque_rx_limit(store))) {
+		*reserved = false;
+	} else {
+		used = atomic64_read(&store->reserve_framing);
+		for (;;) {
+			if (bytes > limit || used > limit - bytes)
+				return false;
+			if (atomic64_try_cmpxchg(&store->reserve_framing, &used, used + bytes))
+				break;
+		}
+		*reserved = true;
+	}
+	atomic64_add(bytes, &store->framing);
+	return true;
+}
+
+void io_opaque_uncharge_frame(struct io_opaque_store *store, u64 bytes, bool reserved)
+{
+	atomic64_sub(bytes, &store->framing);
+	if (reserved)
+		atomic64_sub(bytes, &store->reserve_framing);
+	else
+		io_opaque_release_transient(store, bytes, bytes);
+}
+
 static bool io_opaque_extent_reserve(struct io_opaque_store *store)
 {
 	int nr = atomic_read(&store->extents);
@@ -682,6 +717,21 @@ void io_opaque_stop(struct io_opaque_store *store)
 	io_opaque_wake_budget(store);
 }
 
+/* Free every queue; no request may be left on one. */
+static void io_opaque_txs_free(struct io_opaque_store *store)
+{
+	struct io_opaque_tx *tx, *next;
+
+	guard(spinlock)(&store->tx_lock);
+	rbtree_postorder_for_each_entry_safe(tx, next, &store->txs, node) {
+		WARN_ON_ONCE(!list_empty(&tx->requests) || tx->sk_held);
+		kfree(tx);
+	}
+	store->txs = RB_ROOT;
+	INIT_LIST_HEAD(&store->txs_idle);
+	store->nr_txs_idle = 0;
+}
+
 void io_opaque_free(struct io_opaque_store *store)
 {
 	if (!store)
@@ -689,6 +739,7 @@ void io_opaque_free(struct io_opaque_store *store)
 	io_opaque_stop(store);
 	WARN_ON_ONCE(atomic64_read(&store->bytes));
 	WARN_ON_ONCE(atomic_read(&store->extents));
+	io_opaque_txs_free(store);
 	io_unaccount_mem(store->user, store->mm,
 			 store->config.hard_limit >> PAGE_SHIFT);
 	obj_cgroup_put(store->objcg);
@@ -767,6 +818,20 @@ void io_opaque_queue_ready(struct io_opaque_req *op, int result)
 	io_req_task_work_add(op->req);
 }
 
+static void io_opaque_resume(struct io_tw_req tw_req, io_tw_token_t tw)
+{
+	struct io_kiocb *req = tw_req.req;
+	struct io_opaque_req *op = req->async_data;
+
+	io_tw_lock(req->ctx, tw);
+	list_del_init(&op->cancel);
+	op->phase = IO_OPAQUE_IDLE;
+	if (tw.cancel || READ_ONCE(op->canceled) || READ_ONCE(op->store->dead))
+		io_req_defer_failed(req, -ECANCELED);
+	else
+		io_req_task_submit(tw_req, tw);
+}
+
 static struct io_opaque_extent *io_opaque_extent_split(struct io_opaque_store *store,
 						       struct io_opaque_extent *extent,
 						       u64 at)
@@ -1179,10 +1244,12 @@ static void io_opaque_ready(struct io_tw_req tw_req, io_tw_token_t tw)
 	}
 	if (ret < 0)
 		req_set_fail(req);
+	if (ret < 0 && req->opcode == IORING_OP_OPAQUE_OBJ_SEND && op->progress)
+		ret = op->progress;
 	if (ret >= 0 && op->op == IORING_OPAQUE_RECV_OBJECT)
 		io_req_set_res32(req, ret, 0, op->handle, object_flags);
 	else
-		io_req_set_res(req, ret, 0);
+		io_req_set_res(req, ret, op->consumed ? IORING_CQE_F_OPAQUE_CONSUMED : 0);
 	io_req_task_complete(tw_req, tw);
 }
 
@@ -1562,8 +1629,19 @@ void io_opaque_cleanup(struct io_kiocb *req)
 		return;
 	store = op->store;
 	list_del_init(&op->cancel);
-	scoped_guard(spinlock, &store->wait_lock)
-		list_del_init(&op->wait);
+	/*
+	 * Taking wait_lock is how cleanup waits out a waker that is still in
+	 * its hold: budget_waits and copies are walked under it, using the
+	 * request's file and stream after its entry has been unlinked. A send
+	 * is on neither list. What reaches one from outside comes through its
+	 * TX queue, which io_opaque_tx_put() below waits for, or from
+	 * cancellation, which holds the ring lock as cleanup does. It has no
+	 * waker to wait out, and takes the lock only if its entry is linked.
+	 */
+	if (req->opcode != IORING_OP_OPAQUE_OBJ_SEND || !list_empty(&op->wait)) {
+		scoped_guard(spinlock, &store->wait_lock)
+			list_del_init(&op->wait);
+	}
 	/* Waiters have stopped accessing this request before cleanup. */
 	if (op->stream) {
 		mutex_lock(&op->stream->lock);
@@ -1591,9 +1669,858 @@ void io_opaque_cleanup(struct io_kiocb *req)
 				       store->objects[op->slot].generation);
 		mutex_unlock(&store->tables);
 	}
+	if (req->opcode == IORING_OP_OPAQUE_OBJ_SEND) {
+		io_opaque_tx_put(op);
+		kfree(op->framing);
+		if (op->frame_charge)
+			io_opaque_uncharge_frame(store, op->frame_charge, op->frame_reserved);
+	}
 	io_opaque_data_put(store, op->data);
 	io_opaque_stream_put(op->stream);
 	lockdep_assert_held(&req->ctx->uring_lock);
 	io_cache_free(&req->ctx->opaque_cache, op);
 	io_req_async_data_clear(req, 0);
 }
+
+void io_opaque_fail(struct io_kiocb *req)
+{
+	struct io_opaque_req *op = req->async_data;
+
+	if (op && req->opcode == IORING_OP_OPAQUE_OBJ_SEND) {
+		if (op->progress)
+			req->cqe.res = op->progress;
+		if (op->consumed)
+			req->cqe.flags |= IORING_CQE_F_OPAQUE_CONSUMED;
+	}
+}
+
+/* Copy and check the framing descriptor at prep; prefix and suffix are send data. */
+static int io_opaque_frame_prep(struct io_opaque_req *op)
+{
+	struct io_uring_opaque_frame frame = {};
+	u32 size, bytes;
+	int ret;
+
+	op->total_length = op->length;
+	if (op->addr) {
+		if (get_user(size, (u32 __user *)op->addr))
+			return -EFAULT;
+		if (size < offsetof(struct io_uring_opaque_frame, __resv) ||
+		    size > PAGE_SIZE)
+			return -EINVAL;
+		ret = copy_struct_from_user(&frame, sizeof(frame), op->addr, size);
+		if (ret)
+			return ret;
+		if (frame.size != size || frame.flags ||
+		    !mem_is_zero(frame.__resv, sizeof(frame.__resv)) ||
+		    (!frame.prefix_length && frame.prefix) ||
+		    (!frame.suffix_length && frame.suffix) ||
+		    check_add_overflow(frame.prefix_length, frame.suffix_length, &bytes) ||
+		    bytes > IORING_OPAQUE_FRAME_MAX ||
+		    check_add_overflow(op->length, bytes, &op->total_length) ||
+		    op->total_length > INT_MAX)
+			return -EINVAL;
+		op->prefix = frame.prefix;
+		op->suffix = frame.suffix;
+		op->prefix_length = frame.prefix_length;
+		op->suffix_length = frame.suffix_length;
+	}
+	if (!op->total_length ||
+	    (!op->length && (op->handle || op->offset ||
+			    (op->send_flags & IORING_OPAQUE_SEND_LAST))))
+		return -EINVAL;
+	return 0;
+}
+
+/*
+ * Snapshot framing before TX admission can consume a LAST handle. Only a send
+ * with a frame gets here: one without is resolved at prep.
+ */
+static int io_opaque_frame_import(struct io_opaque_req *op)
+{
+	u32 bytes = op->prefix_length + op->suffix_length, charge;
+	struct mem_cgroup *old;
+
+	if (bytes) {
+		charge = kmalloc_size_roundup(bytes);
+		if (!io_opaque_charge_frame(op->store, charge, &op->frame_reserved))
+			return -ENOBUFS;
+		op->frame_charge = charge;
+		old = set_active_memcg(op->store->memcg);
+		op->framing = kmalloc(charge, GFP_KERNEL_ACCOUNT);
+		set_active_memcg(old);
+		if (!op->framing)
+			return -ENOMEM;
+		if ((op->prefix_length &&
+		     copy_from_user(op->framing, u64_to_user_ptr(op->prefix),
+				    op->prefix_length)) ||
+		    (op->suffix_length &&
+		     copy_from_user(op->framing + op->prefix_length,
+				    u64_to_user_ptr(op->suffix), op->suffix_length)))
+			return -EFAULT;
+		atomic64_add(bytes, &op->store->framing_copied);
+	}
+	op->resolved = true;
+	return 0;
+}
+
+/*
+ * A send without a frame reads nothing from user memory at first issue: its
+ * total is its body, which prep already checked to be positive.
+ */
+static void io_opaque_send_resolve(struct io_opaque_req *op)
+{
+	if (op->addr)
+		return;
+	op->total_length = op->length;
+	op->resolved = true;
+}
+
+/*
+ * Find the segment of @data that holds byte @off, and return how far into it
+ * @off is. @seg is a segment of the object that starts @pos bytes in and not
+ * after the one wanted: the walk goes on from there, and leaves @seg and @pos
+ * at the start of the segment it found.
+ *
+ * A segment within IO_OPAQUE_SEEK_STRIDE steps is walked to. A farther one
+ * is reached by jumping to the last anchor that is at or before @off, if that
+ * is ahead of where the walk is, and walking on from it: under a stride more.
+ * No seek takes more than two strides and a binary search over the anchors,
+ * wherever it starts, however large the object is.
+ */
+static u32 io_opaque_vec_seek(const struct io_opaque_data *data, u64 off, u32 *seg, u64 *pos)
+{
+	const struct bio_vec *src = data->bvec;
+	u32 i = *seg, steps = 0;
+	u64 at = *pos;
+
+	while (steps < IO_OPAQUE_SEEK_STRIDE && i < data->nr && at + src[i].bv_len <= off) {
+		at += src[i++].bv_len;
+		steps++;
+	}
+	if (data->anchor && i < data->nr && at + src[i].bv_len <= off) {
+		u32 lo = 0, hi = DIV_ROUND_UP(data->nr, IO_OPAQUE_SEEK_STRIDE) - 1;
+
+		/* The last anchor that starts at or before @off; the first always does. */
+		while (lo < hi) {
+			u32 mid = lo + (hi - lo + 1) / 2;
+
+			if (data->anchor[mid] <= off)
+				lo = mid;
+			else
+				hi = mid - 1;
+		}
+		if (data->anchor[lo] > at) {
+			i = lo * IO_OPAQUE_SEEK_STRIDE;
+			at = data->anchor[lo];
+		}
+	}
+	while (i < data->nr && at + src[i].bv_len <= off)
+		at += src[i++].bv_len;
+	*seg = i;
+	*pos = at;
+	return off - at;
+}
+
+/* The handle must hold a version, and the range must lie within it. */
+static int io_opaque_send_range(const struct io_opaque_slot *slot, u64 off, u32 len)
+{
+	if (!slot || !slot->data)
+		return -ESTALE;
+	if (off > slot->data->length || len > slot->data->length - off)
+		return -ERANGE;
+	return 0;
+}
+
+/*
+ * Take a send's reference on the version @slot holds: the table reference when
+ * the send is LAST, which also removes the handle, else an extra one. Under
+ * tables, after io_opaque_send_range().
+ */
+static struct io_opaque_data *io_opaque_send_pin(struct io_opaque_store *store,
+						 struct io_opaque_slot *slot, bool last)
+{
+	if (last)
+		return io_opaque_detach(store, slot);
+	refcount_inc(&slot->data->refs);
+	return slot->data;
+}
+
+/* Drop the references a send took at admission; a no-op when it took none. */
+static void io_opaque_send_unpin(struct io_opaque_req *op)
+{
+	io_opaque_data_put(op->store, op->data);
+	op->data = NULL;
+}
+
+/*
+ * The part of io_opaque_send_unpin() that a socket lock can wait for: drop
+ * every reference of the send that is not the last on its version, which is a
+ * decrement and cannot free anything, and say whether any is left. What is
+ * left is for io_opaque_send_unpin() once the socket is released, since the
+ * last reference frees the version, every extent of it, and that is not for
+ * the lock to wait out. Nobody can take a reference on a version whose count
+ * is one, which is not in the table, so the last one is still the last then.
+ */
+static bool io_opaque_send_unpin_cheap(struct io_opaque_req *op)
+{
+	bool left = false;
+
+	if (op->data) {
+		if (refcount_dec_not_one(&op->data->refs))
+			op->data = NULL;
+		else
+			left = true;
+	}
+	return left;
+}
+
+/*
+ * Point the send's cursor at the range it selects: @len bytes in @nr segments
+ * from @bv, of which the range starts @skip bytes in and lasts for op->length.
+ */
+static void io_opaque_send_iter(struct io_opaque_req *op, const struct bio_vec *bv,
+				unsigned int nr, size_t len, size_t skip)
+{
+	iov_iter_bvec(&op->iter, ITER_SOURCE, bv, nr, len);
+	iov_iter_advance(&op->iter, skip);
+	iov_iter_truncate(&op->iter, op->length);
+}
+
+/* Resolve what a send names, take its references and set its cursor, under tables. */
+static int io_opaque_send_acquire(struct io_opaque_req *op)
+{
+	struct io_opaque_store *store = op->store;
+	bool last = op->send_flags & IORING_OPAQUE_SEND_LAST;
+	struct io_opaque_slot *slot = io_opaque_lookup(store, op->handle);
+	u64 pos = 0;
+	u32 seg = 0, skip;
+	int ret;
+
+	if (store->dead)
+		return -ESHUTDOWN;
+	if (!op->length)
+		return 0;
+	ret = io_opaque_send_range(slot, op->offset, op->length);
+	if (ret)
+		return ret;
+	op->data = io_opaque_send_pin(store, slot, last);
+	if (last)
+		op->consumed = true;
+	/* The cursor starts at the segment that holds the range. */
+	skip = io_opaque_vec_seek(op->data, op->offset, &seg, &pos);
+	io_opaque_send_iter(op, op->data->bvec + seg, op->data->nr - seg, op->data->length - pos,
+			    skip);
+	return 0;
+}
+
+int io_opaque_send_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
+{
+	struct io_opaque_store *store = io_opaque_get_store(req, READ_ONCE(sqe->opaque_store_id));
+	struct io_opaque_req *op;
+	u16 send_flags = READ_ONCE(sqe->ioprio);
+	u32 msg_flags = READ_ONCE(sqe->msg_flags);
+	u64 end;
+	int ret;
+
+	if (!store)
+		return -ENXIO;
+	if ((send_flags & ~IORING_OPAQUE_SEND_LAST) ||
+	    ((send_flags & IORING_OPAQUE_SEND_LAST) && (req->flags & REQ_F_CQE_SKIP)) ||
+	    READ_ONCE(sqe->buf_index) || READ_ONCE(sqe->__pad2[0]) ||
+	    (msg_flags & ~(MSG_MORE | MSG_DONTWAIT)))
+		return -EINVAL;
+	op = io_opaque_req_alloc(req, store);
+	if (IS_ERR(op))
+		return PTR_ERR(op);
+	op->op = U16_MAX;
+	INIT_LIST_HEAD(&op->send);
+	op->send_flags = send_flags;
+	op->handle = READ_ONCE(sqe->addr);
+	op->offset = READ_ONCE(sqe->off);
+	op->length = READ_ONCE(sqe->len);
+	op->addr = u64_to_user_ptr(READ_ONCE(sqe->addr3));
+	op->msg_flags = msg_flags;
+	if (op->msg_flags & MSG_DONTWAIT)
+		req->flags |= REQ_F_NOWAIT;
+	if ((!op->length && !op->addr) || op->length > INT_MAX ||
+	    check_add_overflow(op->offset, (u64)op->length, &end))
+		return -EINVAL;
+	ret = io_opaque_frame_prep(op);
+	if (ret)
+		return ret;
+	io_opaque_send_resolve(op);
+	return 0;
+}
+
+static struct io_opaque_req *io_opaque_tx_head(struct io_opaque_tx *tx)
+{
+	return list_first_entry_or_null(&tx->requests, struct io_opaque_req, send);
+}
+
+/* Set under tx_lock, so that a release cannot pass a queued request by. */
+static void io_opaque_tx_park(struct io_opaque_req *op)
+{
+	guard(spinlock)(&op->store->wait_lock);
+	op->phase = IO_OPAQUE_SEND_WAIT;
+}
+
+static struct io_opaque_tx *io_opaque_tx_find(struct io_opaque_store *store,
+					      struct sock *sk,
+					      struct rb_node ***linkp,
+					      struct rb_node **parentp)
+{
+	struct rb_node **link = &store->txs.rb_node, *parent = NULL;
+	struct io_opaque_tx *tx = NULL;
+
+	lockdep_assert_held(&store->tx_lock);
+	while (*link) {
+		parent = *link;
+		tx = rb_entry(parent, struct io_opaque_tx, node);
+		if ((unsigned long)sk < (unsigned long)tx->sk)
+			link = &parent->rb_left;
+		else if ((unsigned long)sk > (unsigned long)tx->sk)
+			link = &parent->rb_right;
+		else
+			break;
+	}
+	/* On a miss these are the insertion point. */
+	*linkp = link;
+	*parentp = parent;
+	return *link ? tx : NULL;
+}
+
+/* A queue nobody uses stays for the next frame on its socket, up to a cap. */
+static struct sock *io_opaque_tx_unused(struct io_opaque_store *store, struct io_opaque_tx *tx)
+{
+	struct sock *sk;
+
+	lockdep_assert_held(&store->tx_lock);
+	if (!list_empty(&tx->requests))
+		return NULL;
+	/* Transfer the busy identity reference; the caller drops it after tx_lock. */
+	WARN_ON_ONCE(!tx->sk_held);
+	sk = tx->sk;
+	tx->sk_held = false;
+	/* Reuse a failed queue only after its followers and admissions drain. */
+	tx->failed = false;
+	list_add_tail(&tx->idle, &store->txs_idle);
+	if (++store->nr_txs_idle <= IO_OPAQUE_TX_IDLE_MAX)
+		return sk;
+	tx = list_first_entry(&store->txs_idle, struct io_opaque_tx, idle);
+	list_del(&tx->idle);
+	store->nr_txs_idle--;
+	rb_erase(&tx->node, &store->txs);
+	kfree(tx);
+	return sk;
+}
+
+/* A queue that is about to hold a request is not idle. */
+static void io_opaque_tx_busy(struct io_opaque_store *store, struct io_opaque_tx *tx)
+{
+	lockdep_assert_held(&store->tx_lock);
+	if (list_empty(&tx->requests)) {
+		WARN_ON_ONCE(tx->sk_held);
+		sock_hold(tx->sk);
+		tx->sk_held = true;
+	}
+	if (!list_empty(&tx->idle)) {
+		list_del_init(&tx->idle);
+		store->nr_txs_idle--;
+	}
+}
+
+static struct io_opaque_tx *io_opaque_tx_alloc(struct io_opaque_store *store,
+					       gfp_t gfp)
+{
+	return kzalloc_obj(struct io_opaque_tx, gfp);
+}
+
+/* Resolve what a send names and take its references, under tables. */
+static int io_opaque_tx_acquire(struct io_opaque_req *op)
+{
+	int ret;
+
+	scoped_guard(mutex, &op->store->tables)
+		ret = io_opaque_send_acquire(op);
+	return ret;
+}
+
+/*
+ * The admission of a request that found frames ahead of it. It takes its
+ * references before it waits, so that a LAST send parked behind another has
+ * consumed its object. Its FIFO position is already reserved. Until this
+ * second tx_lock hold it stays IDLE: a release must not wake an admission
+ * that is still issuing. If it became head meanwhile, it continues here.
+ * A queue that fails in between cancels it. It holds tables alone, not the
+ * socket. Returns as io_opaque_tx_join() does.
+ */
+static int io_opaque_tx_settle(struct io_opaque_req *op, struct io_opaque_tx *tx)
+{
+	struct io_opaque_store *store = op->store;
+	int ret = io_opaque_tx_acquire(op);
+
+	spin_lock(&store->tx_lock);
+	if (ret || tx->failed) {
+		bool pinned = !ret;
+
+		/* Normal cleanup releases the pending position and wakes its successor. */
+		spin_unlock(&store->tx_lock);
+		if (!pinned)
+			return ret;
+		/* The head failed after the check: the pin goes, LAST stays consumed. */
+		io_opaque_send_unpin(op);
+		return -ECANCELED;
+	}
+	ret = io_opaque_tx_head(tx) == op;
+	if (!ret)
+		io_opaque_tx_park(op);
+	spin_unlock(&store->tx_lock);
+	return ret;
+}
+
+/*
+ * Queue @op behind the frames already issuing for @sk. Returns
+ * IO_OPAQUE_TX_WAIT when it waits for one (its phase is set before tx_lock is
+ * dropped, so a release cannot miss it), IO_OPAQUE_TX_HEAD when it is the head
+ * and holds its references, IO_OPAQUE_TX_SETTLE when it is the head and has
+ * not taken them yet, or a negative errno.
+ *
+ * Every new request links itself in the first tx_lock hold, before acquiring
+ * references. A request that finds its queue empty takes them later, from
+ * io_opaque_tx_settle_head(), with the socket owned. Nothing can join the
+ * queue ahead of it, and a head cannot fail the queue, so nothing that
+ * settling does is undone by the queue. A request that finds frames ahead
+ * takes its references now, and may find itself the head when it is done
+ * (io_opaque_tx_settle()). A queue that has failed refuses it.
+ *
+ * @op->req is not used; the caller enrolls a waiting request for cancellation.
+ */
+static int io_opaque_tx_join(struct io_opaque_req *op, struct sock *sk)
+{
+	struct io_opaque_store *store = op->store;
+	struct io_opaque_tx *tx;
+	struct rb_node **link, *parent;
+	int ret = 0;
+
+	spin_lock(&store->tx_lock);
+	tx = op->tx;
+	if (tx) {
+		/* A resumed or retried request keeps its place. */
+		ret = io_opaque_tx_head(tx) == op;
+		if (!ret)
+			io_opaque_tx_park(op);
+		spin_unlock(&store->tx_lock);
+		return ret;
+	}
+	tx = io_opaque_tx_find(store, sk, &link, &parent);
+	if (!tx) {
+		/* First issue is authoritative on a miss too: never drop tx_lock here. */
+		tx = io_opaque_tx_alloc(store, GFP_NOWAIT | __GFP_ACCOUNT);
+		if (!tx) {
+			spin_unlock(&store->tx_lock);
+			return -ENOMEM;
+		}
+		tx->sk = sk;
+		INIT_LIST_HEAD(&tx->requests);
+		INIT_LIST_HEAD(&tx->idle);
+		rb_link_node(&tx->node, parent, link);
+		rb_insert_color(&tx->node, &store->txs);
+	}
+	if (tx->failed) {
+		ret = -ECANCELED;
+	} else {
+		io_opaque_tx_busy(store, tx);
+		ret = list_empty(&tx->requests) ? IO_OPAQUE_TX_SETTLE : IO_OPAQUE_TX_WAIT;
+		op->tx = tx;
+		list_add_tail(&op->send, &tx->requests);
+	}
+	spin_unlock(&store->tx_lock);
+	if (ret)
+		return ret;
+	return io_opaque_tx_settle(op, tx);
+}
+
+/*
+ * Take the references of a head that io_opaque_tx_join() left to settle, with
+ * the socket owned where it can be. Nothing is taken and nothing removed when
+ * this fails, and the request is still the head: it leaves the queue through
+ * io_opaque_tx_put(), which hands the queue to whoever waits behind it and does
+ * not fail it, since nothing of this frame was sent.
+ */
+static int io_opaque_tx_settle_head(struct io_opaque_req *op)
+{
+	return io_opaque_tx_acquire(op);
+}
+
+/*
+ * Cancel and wake the frames queued behind @op, a head that queued part of its
+ * frame and ended short. @op has left @tx, which has failed already, and goes
+ * back in for the walk. At most IO_OPAQUE_WAKE_BATCH followers are looked at
+ * in a hold of tx_lock, and they are woken after it: how many there are is up
+ * to the process, and every socket and ring of the store takes tx_lock.
+ *
+ * The followers stay in the queue and leave it as they always did, each when
+ * its request is cleaned up, so the queue stays failed until the last has
+ * gone. @op is where the walk has got to. It moves behind each batch and
+ * leaves with the last, and nobody else moves it. It is not parked, and a
+ * release hands the queue only to a parked follower, so a canceled follower
+ * that is released as the first of the queue cannot promote one that is not
+ * canceled yet.
+ *
+ * A follower is touched in a hold of tx_lock, where it cannot be cleaned up,
+ * for its cleanup leaves the queue first. After the hold the walk touches only
+ * those it made queued: nobody else wakes them, and a request ends only once
+ * it is woken. A follower that was queued before is a cancellation's to wake.
+ * It is marked here, and left alone.
+ */
+static noinline_for_stack struct sock *io_opaque_tx_fail(struct io_opaque_store *store,
+							 struct io_opaque_tx *tx,
+							 struct io_opaque_req *op)
+{
+	struct io_opaque_req *woken[IO_OPAQUE_WAKE_BATCH];
+
+	lockdep_assert_held(&store->tx_lock);
+	op->tx = tx;
+	list_add(&op->send, &tx->requests);
+	while (op->send.next != &tx->requests) {
+		struct list_head *pos = op->send.next;
+		unsigned int seen, nr = 0, i;
+
+		for (seen = 0; seen < IO_OPAQUE_WAKE_BATCH && pos != &tx->requests; seen++) {
+			struct io_opaque_req *next = list_entry(pos, struct io_opaque_req, send);
+			bool queue;
+
+			scoped_guard(spinlock, &store->wait_lock) {
+				WRITE_ONCE(next->canceled, true);
+				queue = next->phase == IO_OPAQUE_SEND_WAIT;
+				if (queue)
+					next->phase = IO_OPAQUE_QUEUED;
+			}
+			if (queue)
+				woken[nr++] = next;
+			pos = pos->next;
+		}
+		/* Behind the ones looked at: what follows is what is left to do. */
+		list_move(&op->send, pos->prev);
+		spin_unlock(&store->tx_lock);
+		for (i = 0; i < nr; i++)
+			io_opaque_queue_ready(woken[i], -ECANCELED);
+		spin_lock(&store->tx_lock);
+	}
+	list_del_init(&op->send);
+	op->tx = NULL;
+	/* The followers may all have gone while the walk was out of the lock. */
+	return io_opaque_tx_unused(store, tx);
+}
+
+/*
+ * Remove @op from its queue. A head that queued part of its frame and ended
+ * short fails the queue: every follower is canceled and woken
+ * (io_opaque_tx_fail()), and nothing is returned. Publish failure even when
+ * only in-progress admissions remain. Otherwise the follower that
+ * becomes head is returned with its phase already queued, for the caller to
+ * wake. Only the failure wakeups reach an io_kiocb.
+ */
+static struct io_opaque_req *io_opaque_tx_release(struct io_opaque_req *op)
+{
+	struct io_opaque_store *store = op->store;
+	struct io_opaque_tx *tx = op->tx;
+	struct io_opaque_req *next = NULL;
+	struct sock *put = NULL;
+	bool head;
+
+	spin_lock(&store->tx_lock);
+	head = io_opaque_tx_head(tx) == op;
+	list_del_init(&op->send);
+	op->tx = NULL;
+	/* Only a send that queued part of its frame breaks the following frames. */
+	if (head && op->progress && op->progress != op->total_length) {
+		tx->failed = true;
+		put = io_opaque_tx_fail(store, tx, op);
+		goto unlock;
+	}
+	if (list_empty(&tx->requests)) {
+		put = io_opaque_tx_unused(store, tx);
+		goto unlock;
+	}
+	if (!head || tx->failed)
+		goto unlock;
+	scoped_guard(spinlock, &store->wait_lock) {
+		struct io_opaque_req *candidate = io_opaque_tx_head(tx);
+
+		if (candidate->phase == IO_OPAQUE_SEND_WAIT) {
+			candidate->phase = IO_OPAQUE_QUEUED;
+			next = candidate;
+		}
+	}
+unlock:
+	spin_unlock(&store->tx_lock);
+	if (put)
+		sock_put(put);
+	return next;
+}
+
+static void io_opaque_tx_put(struct io_opaque_req *op)
+{
+	struct io_opaque_req *next;
+
+	if (!op->tx)
+		return;
+	next = io_opaque_tx_release(op);
+	if (next) {
+		next->req->io_task_work.func = io_opaque_resume;
+		io_req_task_work_add(next->req);
+	}
+}
+
+/*
+ * Whether a send may call tcp_sendmsg_locked() on @sk where sock_sendmsg()
+ * would end up in tcp_sendmsg(): plain TCP, whose sendmsg no ULP (kTLS,
+ * espintcp) or socket map has replaced, which they do with a copy of tcp_prot
+ * that sk_prot_creator does not follow. A socket with no local port has not
+ * connected. TCP's proto has inet_send_prepare() leave it unbound, so this
+ * does not change what a send does, and only keeps such a socket on the
+ * ordinary path.
+ *
+ * kTLS and espintcp install their proto under the socket lock, and a socket
+ * map under the bottom-half lock alone, so the answer is a hint until the
+ * socket is owned and is no more than true then. A swap that comes while
+ * tcp_sendmsg_locked() is in progress is what it is for a stock tcp_sendmsg()
+ * in flight: that call goes on with the proto it began with, and the next one
+ * takes the new, here the next part of the frame, which asks again.
+ */
+static bool io_opaque_send_direct(const struct sock *sk)
+{
+	const struct proto *prot;
+	u16 port;
+
+	prot = READ_ONCE(sk->sk_prot);
+	/* Written when the socket binds or connects; a stale zero only spoils a hint. */
+	port = data_race(inet_sk(sk)->inet_num);
+	return prot->sendmsg == tcp_sendmsg && prot == sk->sk_prot_creator && port;
+}
+
+static u32 io_opaque_send_msg_flags(const struct io_opaque_req *op, unsigned int issue_flags)
+{
+	u32 flags = MSG_NOSIGNAL | op->msg_flags;
+
+	if (issue_flags & IO_URING_F_NONBLOCK)
+		flags |= MSG_DONTWAIT;
+	return flags;
+}
+
+/*
+ * The security hook, for an issue that sends on the socket directly. The
+ * first sock_sendmsg() of an issue asks it for the part of the frame it sends,
+ * and a refusal ends that call before any byte goes: a send that has taken its
+ * references, so that LAST is consumed and a frame behind it fails with it if
+ * part of this one was sent, or is told to try again if the hook says EAGAIN.
+ * Here it is asked once, for what is left of the frame. The caller keeps the
+ * verdict and applies it where the first sock_sendmsg() would have met it, so
+ * that the issue ends in the same way. The ordinary path asks for every part,
+ * which a policy that depends on the socket and not on the part cannot tell
+ * apart.
+ *
+ * It is asked with the socket not owned, because a hook may take the socket
+ * lock itself: AppArmor's finds the address with getname(), which does, and
+ * would wait for the owner of the socket for ever.
+ */
+static int io_opaque_send_security(struct socket *sock, const struct io_opaque_req *op,
+				   unsigned int issue_flags)
+{
+	struct msghdr msg = { .msg_flags = io_opaque_send_msg_flags(op, issue_flags) };
+
+	lockdep_assert_not_held(&sock->sk->sk_lock);
+	return security_socket_sendmsg(sock, &msg, op->total_length - op->progress);
+}
+
+/*
+ * One issue of an object send. A request that is not the head of its
+ * destination's queue parks. The head sends its frame, prefix, body and
+ * suffix, from where it stopped, and the frame leaves the queue once all of it
+ * is queued to TCP.
+ *
+ * On a plain TCP socket (io_opaque_send_direct()) the head asks the security
+ * hook, and then does all of the rest under one lock_sock(): it takes the
+ * references it has not taken yet, applies what the hook said, calls
+ * tcp_sendmsg_locked() for each part of the frame, hands the queue on, lets go
+ * of the references that are not the last and only then releases the socket,
+ * and after it puts the last ones. While the socket is
+ * unowned, ACKs and the transmit that autocorking left queued run under its
+ * spinlock, for as long as they take, and the sender's next lock_sock() waits
+ * for them; the less the sender does in that window, the less often it does.
+ * Any other socket takes its references first and goes through sock_sendmsg()
+ * for each part, with the ring lock dropped around it.
+ *
+ * Under IO_URING_F_UNLOCKED the ring lock is dropped before the socket is
+ * taken, and an issue that owned the socket returns without taking it again,
+ * as io-wq expects; an inline issue holds it throughout, as it holds it across
+ * sock_sendmsg().
+ */
+int io_opaque_send(struct io_kiocb *req, unsigned int issue_flags)
+{
+	struct io_opaque_req *op = req->async_data;
+	struct socket *sock = sock_from_file(req->file);
+	struct sock *sk = NULL;
+	struct msghdr msg;
+	struct kvec vec;
+	u32 body_end;
+	bool body = false, fresh, left, owned = false;
+	int ret, sec = 0;
+
+	io_ring_submit_lock(req->ctx, issue_flags);
+	/* A worker cancellation may have searched opaque_waits before us. */
+	if (io_wq_cancel_seen(req, issue_flags)) {
+		ret = -ECANCELED;
+		goto finish;
+	}
+	if (!sock || sock->type != SOCK_STREAM || sock->sk->sk_protocol != IPPROTO_TCP) {
+		ret = -EOPNOTSUPP;
+		goto finish;
+	}
+	if (READ_ONCE(op->store->dead)) {
+		ret = -ESHUTDOWN;
+		goto finish;
+	}
+	if (!op->resolved) {
+		ret = io_opaque_frame_import(op);
+		if (ret)
+			goto finish;
+	}
+	sk = sock->sk;
+	ret = io_opaque_tx_join(op, sk);
+	if (ret < 0)
+		goto out;
+	if (ret == IO_OPAQUE_TX_WAIT) {
+		/* The ring lock keeps the wakeup from running before the request is listed. */
+		io_opaque_enroll(op);
+		ret = IOU_ISSUE_SKIP_COMPLETE;
+		goto out;
+	}
+	fresh = ret == IO_OPAQUE_TX_SETTLE;
+
+	if (io_opaque_send_direct(sk)) {
+		/*
+		 * The hint says plain TCP; the socket decides once it is owned.
+		 * The security hook is asked now, with it not owned, and what it
+		 * says is applied below, after the references are taken.
+		 */
+		io_ring_submit_unlock(req->ctx, issue_flags);
+		sec = io_opaque_send_security(sock, op, issue_flags);
+		sock_rps_record_flow(sk);
+		lock_sock(sk);
+		owned = io_opaque_send_direct(sk);
+		if (!owned) {
+			release_sock(sk);
+			io_ring_submit_lock(req->ctx, issue_flags);
+		}
+	}
+	if (fresh) {
+		ret = io_opaque_tx_settle_head(op);
+		if (ret) {
+			/* Nothing was taken or sent: the frame behind this one goes now. */
+			io_opaque_tx_put(op);
+			goto leave;
+		}
+	}
+	if (owned && sec) {
+		/* As the first sock_sendmsg() would have ended with it. */
+		ret = sec;
+		goto sent;
+	}
+
+again:
+	memset(&msg, 0, sizeof(msg));
+	msg.msg_flags = io_opaque_send_msg_flags(op, issue_flags);
+	body_end = op->prefix_length + op->length;
+	body = op->length && op->progress >= op->prefix_length &&
+	       op->progress < body_end;
+	if (!op->length) {
+		vec.iov_base = op->framing + op->progress;
+		vec.iov_len = op->total_length - op->progress;
+	} else if (op->progress < op->prefix_length) {
+		vec.iov_base = op->framing + op->progress;
+		vec.iov_len = op->prefix_length - op->progress;
+		msg.msg_flags |= MSG_MORE;
+	} else if (body) {
+		msg.msg_iter = op->iter;
+		msg.msg_flags |= MSG_SPLICE_PAGES;
+		if (op->suffix_length)
+			msg.msg_flags |= MSG_MORE;
+	} else {
+		vec.iov_base = op->framing + op->prefix_length + op->progress - body_end;
+		vec.iov_len = op->total_length - op->progress;
+	}
+	if (!body)
+		iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, &vec, 1, vec.iov_len);
+	if (owned) {
+		ret = tcp_sendmsg_locked(sk, &msg, iov_iter_count(&msg.msg_iter));
+		if (trace_sock_send_length_enabled())
+			trace_sock_send_length(sk, ret, 0);
+	} else {
+		/* io-wq may block in TCP; other requests must retain access to the ring. */
+		io_ring_submit_unlock(req->ctx, issue_flags);
+		ret = sock_sendmsg(sock, &msg);
+		io_ring_submit_lock(req->ctx, issue_flags);
+	}
+sent:
+	if (ret > 0) {
+		if (body)
+			op->iter = msg.msg_iter;
+		op->progress += ret;
+		if (op->progress < op->total_length && !iov_iter_count(&msg.msg_iter)) {
+			/*
+			 * TCP lets go of the socket while it waits for room, and a
+			 * protocol may have taken it over by then: ask again.
+			 */
+			if (owned && !io_opaque_send_direct(sk)) {
+				release_sock(sk);
+				io_ring_submit_lock(req->ctx, issue_flags);
+				owned = false;
+			}
+			goto again;
+		}
+		if (op->progress < op->total_length && !(req->flags & REQ_F_NOWAIT)) {
+			ret = -EAGAIN;
+			goto leave;
+		}
+	} else if (ret == -EAGAIN && (issue_flags & IO_URING_F_NONBLOCK) &&
+		   !(req->flags & REQ_F_NOWAIT)) {
+		goto leave;
+	}
+finish:
+	if (ret == -ERESTARTSYS)
+		ret = -EINTR;
+	if (ret < 0 || (op->progress && op->progress < op->total_length))
+		req_set_fail(req);
+	if (op->progress)
+		ret = op->progress;
+	/* The frame is queued or abandoned: the next send goes now, not at cleanup. */
+	io_opaque_tx_put(op);
+	/* The references go with the socket, the last of a version after it. */
+	left = owned && io_opaque_send_unpin_cheap(op);
+	io_req_set_res(req, ret, op->consumed ? IORING_CQE_F_OPAQUE_CONSUMED : 0);
+	if (owned) {
+		/*
+		 * Nothing is left for the ring lock, which an io-wq issue dropped
+		 * for the socket and an inline one still holds: taking it only to
+		 * give it up would be a round trip for the caller.
+		 */
+		release_sock(sk);
+		if (left)
+			io_opaque_send_unpin(op);
+		return IOU_COMPLETE;
+	}
+	ret = IOU_COMPLETE;
+	goto out;
+leave:
+	/* The request keeps whatever it still holds, and the ring lock is as the caller left it. */
+	if (owned) {
+		release_sock(sk);
+		return ret;
+	}
+out:
+	io_ring_submit_unlock(req->ctx, issue_flags);
+	return ret;
+}
diff --git a/io_uring/opdef.c b/io_uring/opdef.c
index 256c7c533118..a80a56b19581 100644
--- a/io_uring/opdef.c
+++ b/io_uring/opdef.c
@@ -601,6 +601,20 @@ const struct io_issue_def io_issue_defs[] = {
 		.issue			= io_opaque_issue,
 #else
 		.prep			= io_eopnotsupp_prep,
+#endif
+	},
+	[IORING_OP_OPAQUE_OBJ_SEND] = {
+		.audit_skip		= 1,
+		.ioprio			= 1,
+		.needs_file		= 1,
+		.unbound_nonreg_file	= 1,
+		.pollout			= 1,
+#ifdef CONFIG_IO_URING_OPAQUE_OBJ
+		.async_size		= sizeof(struct io_opaque_req),
+		.prep			= io_opaque_send_prep,
+		.issue			= io_opaque_send,
+#else
+		.prep			= io_eopnotsupp_prep,
 #endif
 	},
 };
@@ -865,6 +879,13 @@ const struct io_cold_def io_cold_defs[] = {
 		.name			= "OPAQUE_OBJ",
 		.cleanup		= io_opaque_cleanup,
 	},
+	[IORING_OP_OPAQUE_OBJ_SEND] = {
+		.name			= "OPAQUE_OBJ_SEND",
+		.cleanup		= io_opaque_cleanup,
+#ifdef CONFIG_IO_URING_OPAQUE_OBJ
+		.fail			= io_opaque_fail,
+#endif
+	},
 };
 
 const char *io_uring_get_opcode(u8 opcode)
-- 
2.34.1

