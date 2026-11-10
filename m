Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316822;
	b=cxSUBR/AFtKccQwUqVwn3jwaToDTPK8J06xnCcFvh16B/88KEw9eZIvMt+A/6Byu0y+F
	 qv5eDOCckaB7Mz4ZknHeyRhiFSMjapS5Rk2g+HnswninN0hUpWxONf++ZcK/IzNZXYdBI
	 EDcXpEJ3fiLW+q9HOf6TEXPvzzjwzBMN+RWJEDrVyt2ynNsSkHSRQ+KEbwkmWgY6lzm7S
	 3MEgWVws/IDYJ4p+LC4F9bscyyzznKuYfbuOvfsDWLxhinGCIBPruE4kmV3yHYWkLV8GI
	 wZsnbz1M0+SbzNpwSTaWGUVu8Qcx6Vq6B1kevgcknzr6JUkVDm+k1NAVVZlo781lNaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316822;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ycl2dCdRSG2yNQWq4oKpeINj85pJ+uFg5E+mDg9A5Js=;
	b=P0Zw+tgQBj8H9Wmzatj5gXaCTJh9xkbZN8VucpL5lbirP3rbL4/GaVc9pJjnuhqvucvu
	 dznU1F1uAYxEKpGTJ90LwxEQ3o6E7p/Nleg7k8PiBoePhMLCj68ecFdUiYho/K2ymoHPw
	 v3y2u10n8rnM2gwYS04TbEPGg2DchuVLfrOF/hTl7csllyMbjK6mrzHPWOHd5Sy8NA2Df
	 SXVbCDIdFSrp8lo3UNc9ttHYGGjTrOyh96lfRGN4pbFAlHm8Tc3xPeXapyoDULCe+yj2m
	 WGEW6uNroropGpCuCmLzqjOEWXRukQRncqr0/mfllpkdcVj6HgpogcIuyrpug2jf/Wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BLRV0NqZ;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=IuEkdQBu;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F3D60A381F
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 13:20:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26F3D60A381F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BLRV0NqZ;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=IuEkdQBu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794316820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ycl2dCdRSG2yNQWq4oKpeINj85pJ+uFg5E+mDg9A5Js=;
	b=BLRV0NqZCO7aDEVRqHyQVuTtOJ7b689gNA68Y/038P1Gg2TMFzRMSUQhZ0EiVMdhqOa/Xd
	HUYWwRDXT/vHtqR0xaDebf5UQJU+0+7K+MVuBWV4XLIDxt/NxBQiceXSbBdGycRcZvlgmy
	561FIvntadIxVO0+3/hYhkK77nGGhr8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-B_u83C6EOmK9x3zY2BXzEQ-1; Tue, 10 Nov 2026 08:20:18 -0500
X-MC-Unique: B_u83C6EOmK9x3zY2BXzEQ-1
X-Mimecast-MFC-AGG-ID: B_u83C6EOmK9x3zY2BXzEQ_1794316817
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c3613c35145so227339566b.3
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 05:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794316817; x=1794921617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ycl2dCdRSG2yNQWq4oKpeINj85pJ+uFg5E+mDg9A5Js=;
        b=IuEkdQBuscKxm7cqqUX21Eblb8RDTlcLUVoVtmWoQJFc6w3uoWLxGqS1qn51STUq1I
         x7PYkEd7YisvXoI9ny8+3YwxGYgy3cELK1UjkfxDywOgEhUke4ZKY+mq5d5tKHeNDGrK
         CQqe1EgWu0vR6mXPAmCEgyPAHb11Ii2n0VhDYAOwU4A/+4AEhXxYRY+AMiQ9YBG3xDMs
         TXBB5gHp8Pu/lGdhG0bknnxdpEU3f57n6B2/yTcXoldLSOeg7yEqZ3qo6H19muEZPm8u
         raKeLkbLCgf1jahiuU6XNA+YReUfqObdCK/yJLDzgEQ14WRQCPuQGzVMG2we/lxH3Wnb
         oIjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794316817; x=1794921617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ycl2dCdRSG2yNQWq4oKpeINj85pJ+uFg5E+mDg9A5Js=;
        b=M5SMu04DZqiSX5ONc1PFNbJvCzle/ukGcAkhW2iVkpQ9Z0MpSC+S2s2nB0SobpY1NX
         HhjW/SaeJL1tGV48V88/sl7CxIoKFHho45CLrR9aBBseplp1hy9+dY0+8pDqyhUQL8Qm
         dL5Qdoe465nJcU1XfwHHybU2wQMcgaL9VM1XSugJOtxg/d8aDWGo4Ia26exIq1qgFaU1
         K7rbaqfoltaJDj6Qu9bmrVTStf8cXyUvywfit22maOfbyL4cCk6ei562Y/bqGoo70WWJ
         vXlseibiOloaie9ufOpjDrZAcRbzbz5hpTuN8gQreQ/1/jQxS4Z+Ew0Ge9oprAdg8//Z
         okXg==
X-Forwarded-Encrypted: i=1; AL+hErGfpUPIxGhiDK7bTB2+++WEyhvJb49K+I7OVgCl38TAjiBHsmcCkxA8irtXgso2LJdvhYM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+pn3LD//IbAxXCPPSjZf20LXhv1ivYDPDIZ6dCAkrEkG5UH7j7
	ITGuUgrRYMpq5rmhUUN1+9gLV7MBiKNxNy1w8wQ9ShphTPsKm2uT4Mn/j8iC/N73at0OFdIdyDR
	UdRCM7sfgx+P5lP9NfhoIPNTHXTPH2zrodR/SsVdx0vJZCU8q8EfkiYfdwET4/Q==
X-Gm-Gg: AYBFou0Q4x3aK6W1FFBkODSK/7BQe8VWr7ICjeD7QdlWp2Tpsg1tYnUAHV6dAIhauSX
	wrQMH/5GQjLY8LcQR45miuEI+gygGeymfZvtZGCXeBMgfKlBBxvdwnM1iAx0n0uy8prcG51VynS
	HxbqsJFMI7vjBsCberNzoWY7r+lntmE3WA5jnrt757LANAmvPXq1KAGgydXh1U1eR1G5X9OjCFJ
	PwFIELtkRPvLoVbUDXyPLx31/vyZJIswFjA9IRr5REy+yvgY6uTDyUB9GzZEfYpl6Iy1uaWSYP7
	dd4n/M28ZGHndJ5BGkwO3Xeuz92OxRSAslC2E6Oo1s4ZPiFxCSHYbndMHQqPwN4S128+vjwkgRI
	Njjc2nHCB8kmkD19RmBKvDBHhQBr1QSt4tzIRs0nyoT/7JNBIzxVo2vwg9Yzyg1eTuzoCoW2zDI
	zCkjjOun7xPApIJpzbKVIvUhZGsdvlyCm6VzJrp1yFMy4XLz5QDai7QJ6iE72H/wtF+A6RIybIO
	gRaANQK48y1xlQm4WYZVSe4dGt6CLCagjDNddkAz8sMvqsjprNs
X-Received: by 2002:a17:907:1b20:b0:c3f:d912:ff8e with SMTP id a640c23a62f3a-c504954982amr202619366b.16.1794316816144;
        Tue, 10 Nov 2026 05:20:16 -0800 (PST)
X-Received: by 2002:a17:907:1b20:b0:c3f:d912:ff8e with SMTP id a640c23a62f3a-c504954982amr202615166b.16.1794316815406;
        Tue, 10 Nov 2026 05:20:15 -0800 (PST)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a5d54bbsm107791166b.48.2026.11.10.05.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 05:20:15 -0800 (PST)
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
Subject: [RFC PATCH net-next 05/12] io_uring/opaque: add store registration and IORING_OP_OPAQUE_OBJ
Date: Tue, 10 Nov 2026 13:19:59 +0000
Message-Id: <20261110132006.3280986-6-amarkuze@redhat.com>
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

Add IORING_REGISTER_OPAQUE_STORE and the object controls, together with
their request and store lifetimes.

Registration requires DEFER_TASKRUN and either CQE32 or CQE_MIXED. The
configuration supplies limits for backing bytes, object size, objects,
streams and extents, with optional watermarks and a reply reserve.
Creation accounts the hard byte limit against the ring's user and mm,
as registered buffers do. The creating task's live memory cgroup owns
the backing charges; the store retains that reference for its lifetime.
Flags and reserved fields must be zero. An xarray assigns the ring-local
store ID, removed if copying the registration result to userspace fails.

IORING_OP_OPAQUE_OBJ takes the control in sqe->ioprio, the store ID in
sqe->opaque_store_id, a handle or stream token in sqe->addr, a byte
offset in sqe->off, a length in sqe->len and a user pointer in sqe->addr3.

- INSPECT copies up to 64 KiB of retained stream bytes without consuming
  them, waiting if no byte is available at the requested offset.
- AVAILABLE returns the contiguous retained length without copying,
  stopping at the next pending receive or discard decision.
- RECV_OBJECT reserves a slot and assembles a declared stream range.
  Its completed CQE returns the length, handle and forwarding-only flag.
- DISCARD consumes a declared range without retaining an object.
- READ_OBJECT copies up to 64 KiB from a published object; FREE removes
  its handle without invalidating references already held by requests.
- STAT, OBJECT_STAT and STREAM_STAT return size-versioned statistics.
- STREAM_CLOSE ends a stream.

Pending receive and discard ranges are non-overlapping and ordered by
offset. A failed or canceled receive returns its private prefix while
the stream is open, allowing inspection, retry or discard. Cancellation,
linked timeouts and request cleanup release all acquired references.
Request state is cached per ring.

Handles carry a slot generation; stream tokens additionally carry a tag.
Stale or wrong-kind names fail with -ESTALE. Exhausted generations retire
their slots. A store stops when its user count reaches zero, closing its
streams and releasing table-owned objects. Its reference count retains
memory and accounting until outstanding requests finish.

The ring lock serializes issue, task work, cancellation and cleanup.
The table mutex protects handle tables; the stream mutex protects one
stream's extents and decisions; wait_lock protects request phases and
wait lists. The order is uring_lock, then tables or stream->lock, then
wait_lock. The table and stream mutexes never nest.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 include/uapi/linux/io_uring.h |    5 +
 io_uring/Makefile             |    2 +-
 io_uring/cancel.c             |    5 +
 io_uring/io_uring.c           |    9 +
 io_uring/opaque.c             | 1200 +++++++++++++++++++++++++++++++++
 io_uring/opaque_register.c    |   90 +++
 io_uring/opdef.c              |   16 +
 io_uring/register.c           |    7 +
 8 files changed, 1333 insertions(+), 1 deletion(-)
 create mode 100644 io_uring/opaque_register.c

diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index b456f45fa8de..081f30605410 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -91,6 +91,7 @@ struct io_uring_sqe {
 		__s32	splice_fd_in;
 		__u32	file_index;
 		__u32	zcrx_ifq_idx;
+		__u32	opaque_store_id;
 		__u32	optlen;
 		struct {
 			__u16	addr_len;
@@ -319,6 +320,7 @@ enum io_uring_op {
 	IORING_OP_PIPE,
 	IORING_OP_NOP128,
 	IORING_OP_URING_CMD128,
+	IORING_OP_OPAQUE_OBJ,
 
 	/* this goes last, obviously */
 	IORING_OP_LAST,
@@ -724,6 +726,9 @@ enum io_uring_register_op {
 	/* register bpf filtering programs */
 	IORING_REGISTER_BPF_FILTER		= 37,
 
+	/* register, import or export a kernel opaque object store */
+	IORING_REGISTER_OPAQUE_STORE	= 38,
+
 	/* this goes last */
 	IORING_REGISTER_LAST,
 
diff --git a/io_uring/Makefile b/io_uring/Makefile
index 191316972e04..912b1861c0a5 100644
--- a/io_uring/Makefile
+++ b/io_uring/Makefile
@@ -17,7 +17,7 @@ obj-$(CONFIG_IO_URING)		+= io_uring.o opdef.o kbuf.o rsrc.o notif.o \
 					query.o loop.o
 
 obj-$(CONFIG_IO_URING_ZCRX)	+= zcrx.o
-obj-$(CONFIG_IO_URING_OPAQUE_OBJ)	+= opaque.o opaque_compact.o
+obj-$(CONFIG_IO_URING_OPAQUE_OBJ)	+= opaque.o opaque_register.o opaque_compact.o
 obj-$(CONFIG_IO_WQ)		+= io-wq.o
 obj-$(CONFIG_FUTEX)		+= futex.o
 obj-$(CONFIG_EPOLL)		+= epoll.o
diff --git a/io_uring/cancel.c b/io_uring/cancel.c
index 6f7a6cf356c2..e35720f41721 100644
--- a/io_uring/cancel.c
+++ b/io_uring/cancel.c
@@ -19,6 +19,7 @@
 #include "waitid.h"
 #include "futex.h"
 #include "cancel.h"
+#include "opaque.h"
 #include "wait.h"
 
 struct io_cancel {
@@ -130,6 +131,9 @@ int io_try_cancel(struct io_uring_task *tctx, struct io_cancel_data *cd,
 		cd->running = true;
 
 	ret = io_poll_cancel(ctx, cd, issue_flags);
+	if (ret != -ENOENT)
+		return ret;
+	ret = io_opaque_cancel(ctx, cd, issue_flags);
 	if (ret != -ENOENT)
 		return ret;
 
@@ -582,6 +586,7 @@ __cold bool io_uring_try_cancel_requests(struct io_ring_ctx *ctx,
 	mutex_lock(&ctx->uring_lock);
 	ret |= io_cancel_defer_files(ctx, tctx, cancel_all);
 	ret |= io_poll_remove_all(ctx, tctx, cancel_all);
+	ret |= io_opaque_cancel_all(ctx, tctx, cancel_all);
 	ret |= io_waitid_remove_all(ctx, tctx, cancel_all);
 	ret |= io_futex_remove_all(ctx, tctx, cancel_all);
 	ret |= io_uring_try_cancel_uring_cmd(ctx, tctx);
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 8ffe0c9a4e29..fddf9e0ebc8b 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -88,6 +88,7 @@
 #include "msg_ring.h"
 #include "memmap.h"
 #include "zcrx.h"
+#include "opaque.h"
 #include "bpf-ops.h"
 
 #include "timeout.h"
@@ -220,6 +221,7 @@ static void io_free_alloc_caches(struct io_ring_ctx *ctx)
 	io_alloc_cache_free(&ctx->rw_cache, io_rw_cache_free);
 	io_alloc_cache_free(&ctx->cmd_cache, io_cmd_cache_free);
 	io_futex_cache_free(ctx);
+	io_opaque_cache_free(ctx);
 	io_rsrc_cache_free(ctx);
 }
 
@@ -267,6 +269,7 @@ static __cold struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
 			    sizeof(struct io_async_cmd),
 			    sizeof(struct io_async_cmd));
 	ret |= io_futex_cache_init(ctx);
+	ret |= io_opaque_cache_init(ctx);
 	ret |= io_rsrc_cache_init(ctx);
 	if (ret)
 		goto free_ref;
@@ -287,6 +290,10 @@ static __cold struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
 	ctx->submit_state.free_list.next = NULL;
 	INIT_HLIST_HEAD(&ctx->waitid_list);
 	xa_init_flags(&ctx->zcrx_ctxs, XA_FLAGS_ALLOC);
+#ifdef CONFIG_IO_URING_OPAQUE_OBJ
+	xa_init_flags(&ctx->opaque_stores, XA_FLAGS_ALLOC);
+	INIT_LIST_HEAD(&ctx->opaque_waits);
+#endif
 #ifdef CONFIG_FUTEX
 	INIT_HLIST_HEAD(&ctx->futex_list);
 #endif
@@ -2294,6 +2301,7 @@ static __cold void io_ring_ctx_free(struct io_ring_ctx *ctx)
 
 	mutex_lock(&ctx->uring_lock);
 	io_unregister_zcrx(ctx);
+	io_unregister_opaque(ctx);
 	io_cqring_overflow_kill(ctx);
 	io_eventfd_unregister(ctx);
 	io_free_alloc_caches(ctx);
@@ -2638,6 +2646,7 @@ static __cold void io_ring_ctx_wait_and_kill(struct io_ring_ctx *ctx)
 	xa_for_each(&ctx->personalities, index, creds)
 		io_unregister_personality(ctx, index);
 	io_terminate_zcrx(ctx);
+	io_terminate_opaque(ctx);
 	/* Drop these now, rather than async, to unpin the files */
 	io_sqe_buffers_unregister(ctx);
 	io_sqe_files_unregister(ctx);
diff --git a/io_uring/opaque.c b/io_uring/opaque.c
index 2fd9db898e67..81fbf2011446 100644
--- a/io_uring/opaque.c
+++ b/io_uring/opaque.c
@@ -21,6 +21,20 @@
 #include "rsrc.h"
 #include "tw.h"
 
+bool io_opaque_cache_init(struct io_ring_ctx *ctx)
+{
+	return io_alloc_cache_init(&ctx->opaque_cache, IO_ALLOC_CACHE_MAX,
+				   sizeof(struct io_opaque_req), sizeof(struct io_opaque_req));
+}
+
+void io_opaque_cache_free(struct io_ring_ctx *ctx)
+{
+	io_alloc_cache_free(&ctx->opaque_cache, kfree);
+}
+
+static void io_opaque_ready(struct io_tw_req tw_req, io_tw_token_t tw);
+static void io_opaque_stream_close(struct io_opaque_stream *stream);
+
 static bool io_opaque_budget_ready(struct io_opaque_req *op, unsigned long now)
 {
 	struct io_opaque_store *store = op->store;
@@ -33,6 +47,30 @@ static bool io_opaque_budget_ready(struct io_opaque_req *op, unsigned long now)
 	       atomic_read(&store->extents) < store->config.max_extents - 2;
 }
 
+/* A DISCARD at the capture cursor consumes TCP bytes without allocating. */
+static bool io_opaque_discard_ready(struct io_opaque_stream *stream)
+{
+	struct rb_node *node = rb_first_cached(&stream->decisions);
+	struct io_opaque_req *op;
+
+	lockdep_assert_held(&stream->lock);
+	if (!node)
+		return false;
+	op = rb_entry(node, struct io_opaque_req, decision);
+	return op->op == IORING_OPAQUE_DISCARD &&
+	       op->offset + op->progress == stream->next &&
+	       op->progress < op->length;
+}
+
+static bool io_opaque_collect_blocked(struct io_opaque_req *op)
+{
+	lockdep_assert_held(&op->stream->lock);
+	lockdep_assert_held(&op->store->wait_lock);
+	return op->phase == IO_OPAQUE_BUDGET_POLL &&
+	       !io_opaque_budget_ready(op, jiffies) &&
+	       !io_opaque_discard_ready(op->stream);
+}
+
 /*
  * Let in the waiters for budget that the budget lets go on, at most
  * IO_OPAQUE_WAKE_BATCH of them in a hold of wait_lock. Those left over are for
@@ -84,6 +122,31 @@ static void io_opaque_wake_budget_all(struct io_opaque_store *store)
 		;
 }
 
+static void io_opaque_retry_work(struct work_struct *work)
+{
+	struct io_opaque_store *store = container_of(to_delayed_work(work),
+						   struct io_opaque_store, retry_work);
+
+	io_opaque_wake_budget(store);
+}
+
+static void io_opaque_wake_stream(struct io_opaque_stream *stream)
+{
+	struct io_opaque_req *op = stream->collector;
+	struct socket *sock = sock_from_file(stream->file);
+
+	lockdep_assert_held(&stream->lock);
+	if (!op)
+		return;
+	scoped_guard(spinlock, &stream->store->wait_lock) {
+		if (!stream->closed && !READ_ONCE(stream->store->dead) &&
+		    io_opaque_collect_blocked(op))
+			return;
+		list_del_init(&op->wait);
+	}
+	wake_up_interruptible_poll(sk_sleep(sock->sk), EPOLLIN);
+}
+
 int io_opaque_memory_mode(struct io_opaque_store *store)
 {
 	unsigned int seq;
@@ -284,6 +347,17 @@ static u64 io_opaque_extent_release(struct io_opaque_store *store, struct io_opa
 	return charge;
 }
 
+static void io_opaque_extent_free(struct io_opaque_store *store,
+				  struct io_opaque_extent *extent)
+{
+	u64 charge = io_opaque_extent_release(store, extent);
+
+	if (charge)
+		io_opaque_uncharge(store, charge);
+	else
+		io_opaque_wake_budget(store);
+}
+
 /*
  * Free the extents of @list. What they held is returned to the store in one
  * step, and the waiters for budget are looked at in one go: each look takes
@@ -385,6 +459,32 @@ static u32 io_opaque_index(u64 handle)
 	return handle & IO_OPAQUE_INDEX_MASK;
 }
 
+/* Stream tokens carry IO_OPAQUE_TOKEN_TAG; strip it to get the generation. */
+static u64 io_opaque_token_generation(u64 token)
+{
+	return (token & ~IO_OPAQUE_TOKEN_TAG) >> IO_OPAQUE_INDEX_BITS;
+}
+
+static u32 io_opaque_find_slot(unsigned long *used, u32 count, u32 *cursor)
+{
+	u32 index = find_next_zero_bit(used, count, *cursor);
+
+	if (index == count && *cursor) {
+		index = find_first_zero_bit(used, *cursor);
+		if (index == *cursor)
+			return count;
+	}
+	if (index < count)
+		*cursor = (index + 1) % count;
+	return index;
+}
+
+static void io_opaque_release_slot(unsigned long *used, u32 index, u64 generation)
+{
+	if (generation != IO_OPAQUE_GENERATION_MAX)
+		__clear_bit(index, used);
+}
+
 struct io_opaque_slot *io_opaque_lookup(struct io_opaque_store *store,
 					u64 handle)
 {
@@ -397,3 +497,1103 @@ struct io_opaque_slot *io_opaque_lookup(struct io_opaque_store *store,
 		return NULL;
 	return &store->objects[index];
 }
+
+/* Drop handle visibility, transferring the table reference to the caller. */
+static struct io_opaque_data *io_opaque_detach(struct io_opaque_store *store,
+					       struct io_opaque_slot *slot)
+{
+	struct io_opaque_data *data;
+
+	lockdep_assert_held(&store->tables);
+	if (!slot || !slot->data)
+		return NULL;
+	data = slot->data;
+	slot->data = NULL;
+	store->nr_objects--;
+	io_opaque_release_slot(store->object_used, slot - store->objects, slot->generation);
+	slot->compacting = false;
+	list_del_init(&slot->candidate);
+	return data;
+}
+
+static int io_opaque_slot_reserve(struct io_opaque_req *op)
+{
+	struct io_opaque_store *store = op->store;
+	struct io_opaque_slot *slot;
+	u32 index;
+
+	guard(mutex)(&store->tables);
+	for (;;) {
+		index = io_opaque_find_slot(store->object_used, store->config.max_objects,
+					    &store->object_cursor);
+		if (index >= store->config.max_objects)
+			return -ENOSPC;
+		slot = &store->objects[index];
+		__set_bit(index, store->object_used);
+		if (slot->generation != IO_OPAQUE_GENERATION_MAX)
+			break;
+	}
+	slot->reserved = true;
+	slot->generation++;
+	if (op->data)
+		op->data->forward_only =
+			io_opaque_memory_mode(store) == IORING_OPAQUE_MEMORY_LOWMEM;
+	op->slot = index;
+	op->handle = io_opaque_handle(index, slot->generation);
+	op->slot_reserved = true;
+	return 0;
+}
+
+static void io_opaque_stream_put(struct io_opaque_stream *stream)
+{
+	if (stream && refcount_dec_and_test(&stream->refs)) {
+		io_opaque_extents_free(stream->store, &stream->extents);
+		fput(stream->file);
+		mutex_destroy(&stream->lock);
+		kfree(stream);
+	}
+}
+
+struct io_opaque_store *io_opaque_alloc(struct io_ring_ctx *ctx,
+					const struct io_uring_opaque_config *config)
+{
+	struct io_uring_opaque_config cfg = *config;
+	struct io_opaque_store *store;
+	int ret;
+	u32 i;
+
+	if (cfg.flags || cfg.__resv0 || cfg.__resv1 || cfg.__resv2 ||
+	    !mem_is_zero(cfg.__resv, sizeof(cfg.__resv)))
+		return ERR_PTR(-EINVAL);
+	if (!cfg.hard_limit || cfg.hard_limit > SZ_1T ||
+	    !IS_ALIGNED(cfg.hard_limit, PAGE_SIZE) ||
+	    !IS_ALIGNED(cfg.compact_headroom, PAGE_SIZE) ||
+	    cfg.compact_headroom >= cfg.hard_limit ||
+	    !cfg.max_object_size || cfg.max_object_size > INT_MAX ||
+	    !cfg.max_objects || cfg.max_objects > 16384 ||
+	    !cfg.max_streams || cfg.max_streams > 1024 ||
+	    cfg.max_extents < 4 || cfg.max_extents > 65536)
+		return ERR_PTR(-EINVAL);
+	if (!IS_ALIGNED(cfg.reply_reserve, PAGE_SIZE) ||
+	    cfg.reply_reserve >= cfg.hard_limit - cfg.compact_headroom ||
+	    (!cfg.high_watermark && cfg.low_watermark) ||
+	    (cfg.high_watermark &&
+	     (!cfg.reply_reserve ||
+	      !IS_ALIGNED(cfg.high_watermark, PAGE_SIZE) ||
+	      !IS_ALIGNED(cfg.low_watermark, PAGE_SIZE) ||
+	      cfg.low_watermark >= cfg.high_watermark ||
+	      cfg.high_watermark > cfg.hard_limit - cfg.compact_headroom - cfg.reply_reserve)))
+		return ERR_PTR(-EINVAL);
+	store = kzalloc_obj(*store, GFP_KERNEL_ACCOUNT);
+	if (!store)
+		return ERR_PTR(-ENOMEM);
+	refcount_set(&store->refs, 1);
+	refcount_set(&store->users, 1);
+	store->config = cfg;
+	store->objects = kvcalloc(cfg.max_objects, sizeof(*store->objects),
+				  GFP_KERNEL_ACCOUNT);
+	store->streams = kvcalloc(cfg.max_streams, sizeof(*store->streams),
+				  GFP_KERNEL_ACCOUNT);
+	store->object_used = bitmap_zalloc(cfg.max_objects, GFP_KERNEL_ACCOUNT);
+	store->stream_used = bitmap_zalloc(cfg.max_streams, GFP_KERNEL_ACCOUNT);
+	if (!store->objects || !store->streams || !store->object_used || !store->stream_used) {
+		ret = -ENOMEM;
+		goto free_store;
+	}
+	ret = io_account_mem(ctx->user, ctx->mm_account, cfg.hard_limit >> PAGE_SHIFT);
+	if (ret)
+		goto free_store;
+	store->user = ctx->user ? get_uid(ctx->user) : NULL;
+	store->mm = ctx->mm_account;
+	if (store->mm)
+		mmgrab(store->mm);
+	/* The registering task's memcg owns backing charges, including after import. */
+	store->memcg = get_mem_cgroup_from_current();
+#ifdef CONFIG_MEMCG
+	if (store->memcg && !mem_cgroup_is_root(store->memcg)) {
+		struct mem_cgroup *old = set_active_memcg(store->memcg);
+
+		store->objcg = get_obj_cgroup_from_current();
+		set_active_memcg(old);
+	}
+#endif
+	mutex_init(&store->tables);
+	spin_lock_init(&store->wait_lock);
+	spin_lock_init(&store->tx_lock);
+	spin_lock_init(&store->transient_lock);
+	seqcount_spinlock_init(&store->transient_seq, &store->transient_lock);
+	INIT_LIST_HEAD(&store->budget_waits);
+	INIT_LIST_HEAD(&store->copies);
+	INIT_LIST_HEAD(&store->candidates);
+	store->txs = RB_ROOT;
+	INIT_LIST_HEAD(&store->txs_idle);
+	for (i = 0; i < cfg.max_objects; i++)
+		INIT_LIST_HEAD(&store->objects[i].candidate);
+	INIT_DELAYED_WORK(&store->retry_work, io_opaque_retry_work);
+	return store;
+free_store:
+	bitmap_free(store->stream_used);
+	bitmap_free(store->object_used);
+	kvfree(store->streams);
+	kvfree(store->objects);
+	kfree(store);
+	return ERR_PTR(ret);
+}
+
+void io_opaque_stop(struct io_opaque_store *store)
+{
+	u32 i;
+
+	if (!store)
+		return;
+	/* Close enrollment before draining the compaction dispatcher. */
+	scoped_guard(mutex, &store->tables) {
+		guard(spinlock)(&store->wait_lock);
+
+		if (store->dead)
+			return;
+		WRITE_ONCE(store->dead, 1);
+	}
+	cancel_delayed_work_sync(&store->retry_work);
+	for (i = 0; i < store->config.max_streams; i++) {
+		struct io_opaque_stream *stream;
+
+		mutex_lock(&store->tables);
+		stream = store->streams[i].stream;
+		store->streams[i].stream = NULL;
+		if (stream) {
+			store->nr_streams--;
+			io_opaque_release_slot(store->stream_used, i, store->streams[i].generation);
+		}
+		mutex_unlock(&store->tables);
+		if (stream) {
+			io_opaque_stream_close(stream);
+			io_opaque_stream_put(stream);
+		}
+	}
+	for (i = 0; i < store->config.max_objects; i++) {
+		struct io_opaque_data *data;
+
+		mutex_lock(&store->tables);
+		data = io_opaque_detach(store, &store->objects[i]);
+		mutex_unlock(&store->tables);
+		io_opaque_data_put(store, data);
+	}
+	io_opaque_wake_budget(store);
+}
+
+void io_opaque_free(struct io_opaque_store *store)
+{
+	if (!store)
+		return;
+	io_opaque_stop(store);
+	WARN_ON_ONCE(atomic64_read(&store->bytes));
+	WARN_ON_ONCE(atomic_read(&store->extents));
+	io_unaccount_mem(store->user, store->mm,
+			 store->config.hard_limit >> PAGE_SHIFT);
+	obj_cgroup_put(store->objcg);
+	mem_cgroup_put(store->memcg);
+	if (store->mm)
+		mmdrop(store->mm);
+	free_uid(store->user);
+	bitmap_free(store->object_used);
+	bitmap_free(store->stream_used);
+	kvfree(store->objects);
+	kvfree(store->streams);
+	mutex_destroy(&store->tables);
+	kfree(store);
+}
+
+void io_opaque_get(struct io_opaque_store *store)
+{
+	refcount_inc(&store->refs);
+	refcount_inc(&store->users);
+}
+
+void io_opaque_user_put(struct io_opaque_store *store)
+{
+	if (refcount_dec_and_test(&store->users))
+		io_opaque_stop(store);
+}
+
+void io_opaque_put(struct io_opaque_store *store)
+{
+	if (refcount_dec_and_test(&store->refs))
+		io_opaque_free(store);
+}
+
+static struct io_opaque_req *io_opaque_req_alloc(struct io_kiocb *req,
+						 struct io_opaque_store *store)
+{
+	struct io_opaque_req *op;
+
+	if (READ_ONCE(store->dead))
+		return ERR_PTR(-ESHUTDOWN);
+	op = io_uring_alloc_async_data(&req->ctx->opaque_cache, req);
+	if (!op)
+		return ERR_PTR(-ENOMEM);
+	memset(op, 0, sizeof(*op));
+	op->op = U16_MAX;
+	op->req = req;
+	op->store = store;
+	op->retry_at = jiffies;
+	INIT_LIST_HEAD(&op->wait);
+	INIT_LIST_HEAD(&op->cancel);
+	req->flags |= REQ_F_NEED_CLEANUP;
+	return op;
+}
+
+/* The ring lock protects enrollment; wait_lock arbitrates remote wakeups. */
+static void io_opaque_enroll(struct io_opaque_req *op)
+{
+	lockdep_assert_held(&op->req->ctx->uring_lock);
+	if (list_empty(&op->cancel))
+		list_add_tail(&op->cancel, &op->req->ctx->opaque_waits);
+}
+
+void io_opaque_wait(struct io_opaque_req *op, enum io_opaque_phase phase)
+{
+	io_opaque_enroll(op);
+	guard(spinlock)(&op->store->wait_lock);
+	op->phase = phase;
+}
+
+void io_opaque_queue_ready(struct io_opaque_req *op, int result)
+{
+	guard(spinlock)(&op->store->wait_lock);
+	op->result = result;
+	op->phase = IO_OPAQUE_QUEUED;
+	op->req->io_task_work.func = io_opaque_ready;
+	io_req_task_work_add(op->req);
+}
+
+static struct io_opaque_extent *io_opaque_extent_split(struct io_opaque_store *store,
+						       struct io_opaque_extent *extent,
+						       u64 at)
+{
+	struct io_opaque_extent *right;
+	u32 left = at - extent->start;
+
+	if (!io_opaque_extent_reserve(store))
+		return ERR_PTR(-ENOBUFS);
+	right = kmalloc_obj(*right, GFP_KERNEL_ACCOUNT);
+	if (!right) {
+		io_opaque_extent_unreserve(store, 0);
+		return ERR_PTR(-ENOMEM);
+	}
+	*right = *extent;
+	right->embedded = false;
+	refcount_inc(&right->backing->refs);
+	right->start = at;
+	right->offset += left;
+	right->length -= left;
+	extent->length = left;
+	list_add(&right->list, &extent->list);
+	return right;
+}
+
+static int io_opaque_available(struct io_opaque_stream *stream, u64 off, u64 len)
+{
+	struct io_opaque_extent *extent;
+	u64 end = off + len;
+	u64 start = off;
+
+	list_for_each_entry(extent, &stream->extents, list) {
+		if (extent->start + extent->length <= off)
+			continue;
+		if (extent->start > off)
+			break;
+		off = min(end, extent->start + extent->length);
+		if (off == end)
+			break;
+	}
+	if (off != start)
+		return off - start;
+	return off < stream->next ? -ENODATA : 0;
+}
+
+/*
+ * AVAILABLE must not count bytes reserved by a pending decision, even if
+ * pressure has left that decision's prefix in the stream extents.
+ */
+static int io_opaque_unclassified(struct io_opaque_stream *stream, u64 off, u64 len)
+{
+	struct rb_node *node;
+
+	for (node = rb_first_cached(&stream->decisions); node; node = rb_next(node)) {
+		struct io_opaque_req *decision = rb_entry(node, struct io_opaque_req, decision);
+
+		if (decision->offset > off) {
+			len = min(len, decision->offset - off);
+			break;
+		}
+	}
+	return io_opaque_available(stream, off, len);
+}
+
+static int io_opaque_snapshot(struct io_opaque_req *op)
+{
+	struct io_opaque_extent *extent;
+	int ret = io_opaque_available(op->stream, op->offset, op->length);
+	u64 end;
+
+	if (ret <= 0)
+		return ret;
+	end = op->offset + ret;
+	list_for_each_entry(extent, &op->stream->extents, list) {
+		u64 first = max(op->offset, extent->start);
+		u64 last = min(end, extent->start + extent->length);
+		struct io_opaque_extent *copy;
+
+		if (first >= last)
+			continue;
+		if (!io_opaque_extent_reserve(op->store))
+			return -ENOBUFS;
+		copy = kmalloc_obj(*copy, GFP_KERNEL_ACCOUNT);
+		if (!copy) {
+			io_opaque_extent_unreserve(op->store, 0);
+			return -ENOMEM;
+		}
+		*copy = *extent;
+		copy->embedded = false;
+		refcount_inc(&copy->backing->refs);
+		copy->start = first - op->offset;
+		copy->offset += first - extent->start;
+		copy->length = last - first;
+		list_add_tail(&copy->list, &op->data->extents);
+	}
+	op->data->length = ret;
+	return ret;
+}
+
+static int io_opaque_take(struct io_opaque_req *op)
+{
+	struct io_opaque_stream *stream = op->stream;
+	u64 off = op->offset + op->progress;
+	u64 end = op->offset + op->length;
+
+	while (off < end && off < stream->next) {
+		struct io_opaque_extent *extent, *found = NULL;
+		u64 last;
+
+		list_for_each_entry(extent, &stream->extents, list) {
+			if (extent->start + extent->length <= off)
+				continue;
+			if (extent->start <= off)
+				found = extent;
+			break;
+		}
+		if (!found)
+			return -ENODATA;
+		extent = found;
+		if (extent->start < off) {
+			extent = io_opaque_extent_split(op->store, extent, off);
+			if (IS_ERR(extent))
+				return PTR_ERR(extent);
+		}
+		last = min(end, extent->start + extent->length);
+		if (last < extent->start + extent->length) {
+			struct io_opaque_extent *right;
+
+			right = io_opaque_extent_split(op->store, extent, last);
+			if (IS_ERR(right))
+				return PTR_ERR(right);
+		}
+		stream->undecided -= last - off;
+		if (op->op == IORING_OPAQUE_RECV_OBJECT) {
+			struct io_opaque_extent *tail;
+
+			tail = list_last_entry_or_null(&op->data->extents,
+						       struct io_opaque_extent, list);
+			if (!tail || tail->backing != extent->backing)
+				op->data->charge += extent->backing->charge;
+			extent->start -= op->offset;
+			list_move_tail(&extent->list, &op->data->extents);
+			op->data->length += last - off;
+		} else {
+			io_opaque_extent_free(op->store, extent);
+		}
+		op->progress += last - off;
+		off = last;
+	}
+	return off == end;
+}
+
+/* An unsuccessful KEEP returns its private prefix to the undecided stream. */
+static void io_opaque_restore(struct io_opaque_req *op)
+{
+	struct io_opaque_stream *stream = op->stream;
+	struct io_opaque_extent *extent, *next;
+	struct list_head *before = &stream->extents;
+
+	lockdep_assert_held(&stream->lock);
+	if (!op->data || !op->data->length || stream->closed)
+		return;
+	list_for_each_entry(extent, &stream->extents, list) {
+		if (extent->start > op->offset) {
+			before = &extent->list;
+			break;
+		}
+	}
+	list_for_each_entry_safe(extent, next, &op->data->extents, list) {
+		extent->start += op->offset;
+		list_move_tail(&extent->list, before);
+	}
+	stream->undecided += op->data->length;
+	op->data->length = 0;
+	op->data->charge = 0;
+	op->progress = 0;
+}
+
+static u64 io_opaque_dense_left(struct io_opaque_req *op)
+{
+	struct io_opaque_extent *tail;
+	u64 left = op->length - op->progress;
+
+	tail = list_last_entry_or_null(&op->data->extents, struct io_opaque_extent, list);
+	if (tail && tail->backing->copied &&
+	    tail->offset + tail->length == tail->backing->filled) {
+		u32 room = PAGE_SIZE - tail->backing->filled;
+
+		left -= min_t(u64, left, room);
+	}
+	return ALIGN(left, PAGE_SIZE);
+}
+
+static bool io_opaque_overlap(u64 a, u64 alen, u64 b, u64 blen)
+{
+	return a < b + blen && b < a + alen;
+}
+
+static int io_opaque_range_insert(struct io_opaque_req *op)
+{
+	struct io_opaque_stream *stream = op->stream;
+	struct rb_node **link = &stream->decisions.rb_root.rb_node, *parent = NULL;
+	struct io_opaque_req *other;
+	bool leftmost = true;
+
+	while (*link) {
+		parent = *link;
+		other = rb_entry(parent, struct io_opaque_req, decision);
+		if (io_opaque_overlap(op->offset, op->length, other->offset, other->length))
+			return -EBUSY;
+		if (op->offset < other->offset) {
+			link = &parent->rb_left;
+		} else {
+			link = &parent->rb_right;
+			leftmost = false;
+		}
+	}
+	list_for_each_entry(other, &stream->reads, read)
+		if (io_opaque_overlap(op->offset, op->length, other->offset, 1))
+			return -EBUSY;
+	rb_link_node(&op->decision, parent, link);
+	rb_insert_color_cached(&op->decision, &stream->decisions, leftmost);
+	return 0;
+}
+
+/* Validate a blocked TAKE without taking and restoring its retained prefix. */
+static int io_opaque_defer_take(struct io_opaque_req *op)
+{
+	struct io_opaque_stream *stream = op->stream;
+	struct io_opaque_extent *extent, *tail = NULL;
+	u64 off = op->offset, end = min(off + op->length, stream->next);
+	u64 charge = 0, left;
+
+	/* Allocation backoff can leave an already private prefix in place. */
+	if (op->progress)
+		return 0;
+	list_for_each_entry(extent, &stream->extents, list) {
+		if (extent->start + extent->length <= off)
+			continue;
+		if (extent->start > off)
+			break;
+		if (!tail || tail->backing != extent->backing)
+			charge += extent->backing->charge;
+		tail = extent;
+		off = min(end, extent->start + extent->length);
+		if (off == end)
+			break;
+	}
+	if (off < end)
+		return -ENODATA;
+	left = op->length - (off - op->offset);
+	if (tail && tail->backing->copied &&
+	    tail->offset + tail->length == tail->backing->filled)
+		left -= min_t(u64, left, PAGE_SIZE - tail->backing->filled);
+	return charge + ALIGN(left, PAGE_SIZE) > io_opaque_rx_limit(op->store) ?
+		-ENOBUFS : 0;
+}
+
+static void io_opaque_stream_process(struct io_opaque_stream *stream)
+{
+	struct io_opaque_req *op, *next;
+	struct rb_node *node, *after;
+	int ret;
+
+	list_for_each_entry_safe(op, next, &stream->reads, read) {
+		ret = stream->closed ? -ECANCELED :
+			op->op == IORING_OPAQUE_AVAILABLE ?
+			io_opaque_unclassified(stream, op->offset, op->length) :
+			io_opaque_snapshot(op);
+		if (!ret && !stream->eof && !stream->closed && !stream->error)
+			continue;
+		list_del_init(&op->read);
+		if (!ret && stream->error)
+			ret = stream->error;
+		io_opaque_queue_ready(op, ret);
+	}
+	for (node = rb_first_cached(&stream->decisions); node; node = after) {
+		op = rb_entry(node, struct io_opaque_req, decision);
+		after = rb_next(node);
+		if (op->op == IORING_OPAQUE_RECV_OBJECT &&
+		    op->offset + op->length > stream->next &&
+		    stream->collector &&
+		    stream->collector->phase == IO_OPAQUE_BUDGET_POLL &&
+		    !stream->closed && !stream->eof && !stream->error)
+			ret = io_opaque_defer_take(op);
+		else
+			ret = stream->closed ? -ECANCELED : io_opaque_take(op);
+		if (!ret && op->op == IORING_OPAQUE_RECV_OBJECT &&
+		    op->data->charge + io_opaque_dense_left(op) >
+		    io_opaque_rx_limit(op->store))
+			ret = -ENOBUFS;
+		if (!ret && !stream->eof && !stream->closed && !stream->error)
+			continue;
+		rb_erase_cached(node, &stream->decisions);
+		RB_CLEAR_NODE(node);
+		if (!ret)
+			ret = stream->error ?: -ENODATA;
+		if (ret < 0 && op->op == IORING_OPAQUE_RECV_OBJECT)
+			io_opaque_restore(op);
+		io_opaque_queue_ready(op, ret == 1 ? op->length : ret);
+	}
+}
+
+static void io_opaque_stream_close(struct io_opaque_stream *stream)
+{
+	struct socket *sock = sock_from_file(stream->file);
+
+	guard(mutex)(&stream->lock);
+	stream->closed = true;
+	stream->error = -ECANCELED;
+	lock_sock(sock->sk);
+	write_lock_bh(&sock->sk->sk_callback_lock);
+	if (sock->sk->sk_rx_owner == &stream->owner)
+		WRITE_ONCE(sock->sk->sk_rx_owner, NULL);
+	write_unlock_bh(&sock->sk->sk_callback_lock);
+	release_sock(sock->sk);
+	io_opaque_extents_free(stream->store, &stream->extents);
+	stream->undecided = 0;
+	io_opaque_stream_process(stream);
+	wake_up_interruptible_poll(sk_sleep(sock->sk), EPOLLIN);
+	io_opaque_wake_budget(stream->store);
+}
+
+static int io_opaque_copy(struct io_opaque_data *data, u64 off, u32 length,
+			  void __user *dest)
+{
+	struct io_opaque_extent *extent;
+	u64 end = off + length, done = off;
+
+	if (end > data->length)
+		return -ENODATA;
+
+	list_for_each_entry(extent, &data->extents, list) {
+		u64 first = max(off, extent->start);
+		u64 last = min(end, extent->start + extent->length);
+		u32 pos = extent->offset + first - extent->start;
+
+		if (first >= last)
+			continue;
+		if (first != done)
+			return -ENODATA;
+		while (first < last) {
+			u32 offset = offset_in_page(pos);
+			u32 chunk = min_t(u64, last - first, PAGE_SIZE - offset);
+			void *mapped = kmap_local_page(extent->backing->page +
+						      (pos >> PAGE_SHIFT));
+			unsigned long left;
+
+			left = copy_to_user(dest + first - off, mapped + offset, chunk);
+			kunmap_local(mapped);
+			if (left)
+				return -EFAULT;
+			pos += chunk;
+			first += chunk;
+		}
+		done = last;
+	}
+	return done == end ? length : -ENODATA;
+}
+
+static int io_opaque_publish(struct io_opaque_req *op, u64 *object_flags)
+{
+	struct io_opaque_store *store = op->store;
+	struct io_opaque_slot *slot = &store->objects[op->slot];
+
+	guard(mutex)(&store->tables);
+	if (store->dead || READ_ONCE(op->canceled))
+		return -ECANCELED;
+	if (!slot->reserved ||
+	    slot->generation != op->handle >> IO_OPAQUE_INDEX_BITS)
+		return -ESTALE;
+	slot->data = op->data;
+	if (op->data->forward_only)
+		*object_flags = IORING_OPAQUE_OBJECT_F_FORWARD_ONLY;
+	store->nr_objects++;
+	op->data = NULL;
+	slot->reserved = false;
+	op->slot_reserved = false;
+	slot->born = jiffies;
+	slot->retry = jiffies;
+	return op->length;
+}
+
+static void io_opaque_ready(struct io_tw_req tw_req, io_tw_token_t tw)
+{
+	struct io_kiocb *req = tw_req.req;
+	struct io_opaque_req *op = req->async_data;
+	struct io_opaque_store *store = op->store;
+	int ret = op->result;
+	u64 object_flags = 0;
+
+	io_tw_lock(req->ctx, tw);
+	list_del_init(&op->cancel);
+	op->phase = IO_OPAQUE_IDLE;
+	if (tw.cancel || READ_ONCE(op->canceled) || READ_ONCE(store->dead))
+		ret = -ECANCELED;
+	if (ret >= 0 && op->op == IORING_OPAQUE_INSPECT)
+		ret = io_opaque_copy(op->data, 0, op->data->length, op->addr);
+	if (ret >= 0 && op->op == IORING_OPAQUE_RECV_OBJECT) {
+		ret = op->data->length == op->length ?
+			io_opaque_vector(op->data) : -ENODATA;
+		if (!ret)
+			ret = io_opaque_publish(op, &object_flags);
+	}
+	if (ret < 0 && op->op == IORING_OPAQUE_RECV_OBJECT) {
+		mutex_lock(&op->stream->lock);
+		io_opaque_restore(op);
+		io_opaque_stream_process(op->stream);
+		mutex_unlock(&op->stream->lock);
+	}
+	if (ret < 0)
+		req_set_fail(req);
+	if (ret >= 0 && op->op == IORING_OPAQUE_RECV_OBJECT)
+		io_req_set_res32(req, ret, 0, op->handle, object_flags);
+	else
+		io_req_set_res(req, ret, 0);
+	io_req_task_complete(tw_req, tw);
+}
+
+static struct io_opaque_store *io_opaque_get_store(struct io_kiocb *req, u32 id)
+{
+	return xa_load(&req->ctx->opaque_stores, id);
+}
+
+static bool io_opaque_stream_op(u16 op)
+{
+	return op == IORING_OPAQUE_INSPECT || op == IORING_OPAQUE_AVAILABLE ||
+	       op == IORING_OPAQUE_RECV_OBJECT ||
+	       op == IORING_OPAQUE_DISCARD || op == IORING_OPAQUE_STREAM_STAT ||
+	       op == IORING_OPAQUE_STREAM_CLOSE;
+}
+
+int io_opaque_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
+{
+	struct io_opaque_store *store = io_opaque_get_store(req, READ_ONCE(sqe->opaque_store_id));
+	struct io_opaque_req *op;
+	u64 end;
+	u16 cmd = READ_ONCE(sqe->ioprio);
+
+	if (!store)
+		return -ENXIO;
+	if (READ_ONCE(sqe->fd) != -1 || READ_ONCE(sqe->rw_flags) ||
+	    READ_ONCE(sqe->buf_index) || READ_ONCE(sqe->__pad2[0]) ||
+	    cmd > IORING_OPAQUE_AVAILABLE ||
+	    cmd == IORING_OPAQUE_COMPACT || cmd == IORING_OPAQUE_SET_POLICY ||
+	    cmd == IORING_OPAQUE_CREATE ||
+	    (req->flags & (REQ_F_CQE_SKIP | REQ_F_FIXED_FILE)))
+		return -EINVAL;
+	op = io_opaque_req_alloc(req, store);
+	if (IS_ERR(op))
+		return PTR_ERR(op);
+	op->op = cmd;
+	if (cmd <= IORING_OPAQUE_DISCARD || cmd == IORING_OPAQUE_AVAILABLE) {
+		INIT_LIST_HEAD(&op->read);
+		RB_CLEAR_NODE(&op->decision);
+	}
+	op->handle = READ_ONCE(sqe->addr);
+	op->offset = READ_ONCE(sqe->off);
+	op->length = READ_ONCE(sqe->len);
+	op->addr = u64_to_user_ptr(READ_ONCE(sqe->addr3));
+	if (check_add_overflow(op->offset, (u64)op->length, &end))
+		return -EOVERFLOW;
+	if (cmd <= IORING_OPAQUE_READ_OBJECT || cmd == IORING_OPAQUE_AVAILABLE) {
+		if (!op->length || op->length > INT_MAX)
+			return -EINVAL;
+		if ((cmd == IORING_OPAQUE_INSPECT || cmd == IORING_OPAQUE_READ_OBJECT) &&
+		    (op->length > IO_OPAQUE_READ_MAX || !op->addr))
+			return -EINVAL;
+		if ((cmd == IORING_OPAQUE_RECV_OBJECT || cmd == IORING_OPAQUE_DISCARD ||
+		     cmd == IORING_OPAQUE_AVAILABLE) && op->addr)
+			return -EINVAL;
+		if (cmd == IORING_OPAQUE_RECV_OBJECT &&
+		    (op->length > store->config.max_object_size ||
+		     op->length > io_opaque_rx_limit(store)))
+			return -EMSGSIZE;
+	} else if (op->offset) {
+		return -EINVAL;
+	}
+	if (cmd == IORING_OPAQUE_FREE || cmd == IORING_OPAQUE_STREAM_CLOSE) {
+		if (op->length || op->addr)
+			return -EINVAL;
+	}
+	if (cmd == IORING_OPAQUE_STAT) {
+		if (op->handle || !op->addr)
+			return -EINVAL;
+	}
+	return 0;
+}
+
+/* Resolve resources when links permit execution, never while preparing SQEs. */
+static int io_opaque_resolve(struct io_opaque_req *op)
+{
+	struct io_opaque_store *store = op->store;
+	struct io_opaque_slot *slot;
+	u16 cmd = op->op;
+	int ret = 0;
+
+	if (op->resolved)
+		return 0;
+	mutex_lock(&store->tables);
+	if (io_opaque_stream_op(cmd)) {
+		u32 index = io_opaque_index(op->handle);
+
+		if (!(op->handle & IO_OPAQUE_TOKEN_TAG) || index >= store->config.max_streams ||
+		    store->streams[index].generation != io_opaque_token_generation(op->handle) ||
+		    !store->streams[index].stream) {
+			ret = -ESTALE;
+		} else {
+			op->stream = store->streams[index].stream;
+			refcount_inc(&op->stream->refs);
+			op->req->file = get_file(op->stream->file);
+		}
+	} else if (cmd == IORING_OPAQUE_READ_OBJECT || cmd == IORING_OPAQUE_OBJECT_STAT) {
+		slot = io_opaque_lookup(store, op->handle);
+		if (!slot || !slot->data) {
+			ret = -ESTALE;
+		} else {
+			op->data = slot->data;
+			refcount_inc(&op->data->refs);
+			if (cmd == IORING_OPAQUE_READ_OBJECT &&
+			    (op->offset > op->data->length ||
+			     op->length > op->data->length - op->offset))
+				ret = -ERANGE;
+		}
+	}
+	mutex_unlock(&store->tables);
+	if (ret)
+		return ret;
+	if (cmd == IORING_OPAQUE_INSPECT || cmd == IORING_OPAQUE_RECV_OBJECT) {
+		op->data = io_opaque_data_alloc();
+		if (!op->data)
+			return -ENOMEM;
+	}
+	if (cmd == IORING_OPAQUE_RECV_OBJECT) {
+		ret = io_opaque_slot_reserve(op);
+		if (ret)
+			return ret;
+	}
+	op->resolved = true;
+	return 0;
+}
+
+static int io_opaque_range_start(struct io_opaque_req *op)
+{
+	struct io_opaque_stream *stream = op->stream;
+	struct rb_node *node;
+	int ret = 0;
+
+	guard(mutex)(&stream->lock);
+	if (stream->closed)
+		return -ECANCELED;
+	if (op->op == IORING_OPAQUE_INSPECT || op->op == IORING_OPAQUE_AVAILABLE) {
+		for (node = rb_first_cached(&stream->decisions); node; node = rb_next(node)) {
+			struct io_opaque_req *other;
+
+			other = rb_entry(node, struct io_opaque_req, decision);
+
+			if (io_opaque_overlap(op->offset, 1, other->offset, other->length))
+				return -EBUSY;
+		}
+		list_add_tail(&op->read, &stream->reads);
+	} else {
+		ret = io_opaque_range_insert(op);
+		if (ret)
+			return ret;
+	}
+	io_opaque_wait(op, IO_OPAQUE_RANGE_WAIT);
+	io_opaque_stream_process(stream);
+	/* A decision, or an INSPECT still waiting for bytes, may let collection continue. */
+	if ((op->op != IORING_OPAQUE_INSPECT && op->op != IORING_OPAQUE_AVAILABLE) ||
+	    !list_empty(&op->read))
+		io_opaque_wake_stream(stream);
+	return IOU_ISSUE_SKIP_COMPLETE;
+}
+
+static int io_opaque_stat_copy(struct io_opaque_req *op, const void *stat, u32 size)
+{
+	if (!op->addr || op->length < sizeof(u32) || op->length > PAGE_SIZE)
+		return -EINVAL;
+	return copy_struct_to_user(op->addr, op->length, stat, size, NULL);
+}
+
+static int io_opaque_stat(struct io_opaque_req *op)
+{
+	struct io_opaque_store *store = op->store;
+	struct io_uring_opaque_stat stat = {
+		.size = sizeof(stat),
+		.backing_bytes = atomic64_read(&store->bytes),
+		.hard_limit = store->config.hard_limit,
+		.copied_bytes = atomic64_read(&store->copied),
+		.compacted_bytes = atomic64_read(&store->compacted),
+		.compact_count = atomic64_read(&store->compactions),
+		.extents = atomic_read(&store->extents),
+		.framing_bytes = atomic64_read(&store->framing),
+		.framing_copied_bytes = atomic64_read(&store->framing_copied),
+		.memory_mode = io_opaque_memory_mode(store),
+	};
+
+	/* Framing in the reply reserve is charged outside bytes. */
+	stat.backing_bytes += atomic64_read(&store->reserve_framing);
+	mutex_lock(&store->tables);
+	stat.objects = store->nr_objects;
+	stat.streams = store->nr_streams;
+	mutex_unlock(&store->tables);
+	return io_opaque_stat_copy(op, &stat, sizeof(stat));
+}
+
+int io_opaque_issue(struct io_kiocb *req, unsigned int issue_flags)
+{
+	struct io_opaque_req *op = req->async_data;
+	struct io_opaque_store *store = op->store;
+	int ret;
+
+	io_ring_submit_lock(req->ctx, issue_flags);
+	/* Pair with the cancellation search before any opaque wait enrollment. */
+	if (io_wq_cancel_seen(req, issue_flags)) {
+		ret = -ECANCELED;
+		goto out;
+	}
+	if (READ_ONCE(store->dead)) {
+		ret = -ESHUTDOWN;
+		goto out;
+	}
+	ret = io_opaque_resolve(op);
+	if (ret)
+		goto out;
+	switch (op->op) {
+	case IORING_OPAQUE_INSPECT:
+	case IORING_OPAQUE_AVAILABLE:
+	case IORING_OPAQUE_RECV_OBJECT:
+	case IORING_OPAQUE_DISCARD:
+		ret = io_opaque_range_start(op);
+		break;
+	case IORING_OPAQUE_READ_OBJECT:
+		ret = io_opaque_copy(op->data, op->offset, op->length, op->addr);
+		break;
+	case IORING_OPAQUE_FREE:
+		mutex_lock(&store->tables);
+		{
+			struct io_opaque_data *data = io_opaque_detach(store,
+						io_opaque_lookup(store, op->handle));
+
+			ret = data ? 0 : -ESTALE;
+			mutex_unlock(&store->tables);
+			io_opaque_data_put(store, data);
+		}
+		break;
+	case IORING_OPAQUE_STAT:
+		ret = io_opaque_stat(op);
+		break;
+	case IORING_OPAQUE_OBJECT_STAT:
+		{
+			struct io_uring_opaque_object_stat stat = {
+				.size = sizeof(stat),
+				.length = op->data->length,
+				.backing_bytes = op->data->charge,
+				.extents = op->data->nr,
+				.flags = op->data->dense ? IORING_OPAQUE_OBJECT_F_COMPACTED : 0,
+			};
+			struct io_opaque_slot *slot;
+
+			if (op->data->forward_only)
+				stat.flags |= IORING_OPAQUE_OBJECT_F_FORWARD_ONLY;
+			mutex_lock(&store->tables);
+			slot = io_opaque_lookup(store, op->handle);
+			if (slot && slot->compacting)
+				stat.flags |= IORING_OPAQUE_OBJECT_F_COMPACTING;
+			mutex_unlock(&store->tables);
+			ret = io_opaque_stat_copy(op, &stat, sizeof(stat));
+		}
+		break;
+	case IORING_OPAQUE_STREAM_STAT:
+		{
+			struct io_uring_opaque_stream_stat stat = { .size = sizeof(stat) };
+
+			mutex_lock(&op->stream->lock);
+			stat.rx_next = op->stream->next;
+			stat.undecided_bytes = op->stream->undecided;
+			stat.flags = op->stream->eof ? IORING_OPAQUE_STREAM_F_EOF : 0;
+			stat.error = op->stream->error;
+			mutex_unlock(&op->stream->lock);
+			ret = io_opaque_stat_copy(op, &stat, sizeof(stat));
+		}
+		break;
+	case IORING_OPAQUE_STREAM_CLOSE:
+		mutex_lock(&store->tables);
+		if (store->streams[io_opaque_index(op->handle)].stream == op->stream) {
+			store->streams[io_opaque_index(op->handle)].stream = NULL;
+			store->nr_streams--;
+			io_opaque_release_slot(store->stream_used, io_opaque_index(op->handle),
+					       io_opaque_token_generation(op->handle));
+			mutex_unlock(&store->tables);
+			io_opaque_stream_close(op->stream);
+			io_opaque_stream_put(op->stream);
+			ret = 0;
+		} else {
+			mutex_unlock(&store->tables);
+			ret = -ESTALE;
+		}
+		break;
+	default:
+		ret = -EINVAL;
+	}
+out:
+	if (ret != IOU_ISSUE_SKIP_COMPLETE) {
+		if (ret < 0)
+			req_set_fail(req);
+		io_req_set_res(req, ret, 0);
+		ret = IOU_COMPLETE;
+	}
+	io_ring_submit_unlock(req->ctx, issue_flags);
+	return ret;
+}
+
+static bool io_opaque_cancel_req(struct io_opaque_req *op)
+{
+	enum io_opaque_phase phase;
+	bool queue;
+
+	if (op->stream)
+		mutex_lock(&op->stream->lock);
+	spin_lock(&op->store->wait_lock);
+	phase = op->phase;
+	if (op->canceled || phase == IO_OPAQUE_IDLE) {
+		spin_unlock(&op->store->wait_lock);
+		if (op->stream)
+			mutex_unlock(&op->stream->lock);
+		return false;
+	}
+	WRITE_ONCE(op->canceled, true);
+	/* A queued copy is owned by the shared worker until it reports readiness. */
+	if (phase != IO_OPAQUE_COPY_WORK)
+		list_del_init(&op->wait);
+	/* Claim task work before a remote TX head can promote this waiter. */
+	queue = phase != IO_OPAQUE_QUEUED && phase != IO_OPAQUE_COPY_WORK;
+	if (queue)
+		op->phase = IO_OPAQUE_QUEUED;
+	spin_unlock(&op->store->wait_lock);
+	if (phase == IO_OPAQUE_RANGE_WAIT) {
+		list_del_init(&op->read);
+		if (!RB_EMPTY_NODE(&op->decision)) {
+			rb_erase_cached(&op->decision, &op->stream->decisions);
+			RB_CLEAR_NODE(&op->decision);
+		}
+	}
+	if (op->stream) {
+		if (op->op == IORING_OPAQUE_RECV_OBJECT)
+			io_opaque_restore(op);
+		mutex_unlock(&op->stream->lock);
+	}
+	if (queue)
+		io_opaque_queue_ready(op, -ECANCELED);
+	return true;
+}
+
+int io_opaque_cancel(struct io_ring_ctx *ctx, struct io_cancel_data *cd,
+		     unsigned int issue_flags)
+{
+	struct io_opaque_req *op;
+	int nr = 0;
+
+	io_ring_submit_lock(ctx, issue_flags);
+	list_for_each_entry(op, &ctx->opaque_waits, cancel) {
+		if (!io_cancel_req_match(op->req, cd) || !io_opaque_cancel_req(op))
+			continue;
+		nr++;
+		break;
+	}
+	io_ring_submit_unlock(ctx, issue_flags);
+	return nr ? 0 : -ENOENT;
+}
+
+bool io_opaque_cancel_all(struct io_ring_ctx *ctx, struct io_uring_task *tctx,
+			  bool cancel_all)
+{
+	struct io_opaque_req *op;
+	bool found = false;
+
+	lockdep_assert_held(&ctx->uring_lock);
+	list_for_each_entry(op, &ctx->opaque_waits, cancel)
+		if (io_match_task_safe(op->req, tctx, cancel_all))
+			found |= io_opaque_cancel_req(op);
+	return found;
+}
+
+void io_opaque_cleanup(struct io_kiocb *req)
+{
+	struct io_opaque_req *op = req->async_data;
+	struct io_opaque_store *store;
+	bool close = false;
+
+	if (!op)
+		return;
+	store = op->store;
+	list_del_init(&op->cancel);
+	scoped_guard(spinlock, &store->wait_lock)
+		list_del_init(&op->wait);
+	/* Waiters have stopped accessing this request before cleanup. */
+	if (op->stream) {
+		mutex_lock(&op->stream->lock);
+		if (op->op <= IORING_OPAQUE_DISCARD || op->op == IORING_OPAQUE_AVAILABLE) {
+			list_del_init(&op->read);
+			if (!RB_EMPTY_NODE(&op->decision)) {
+				rb_erase_cached(&op->decision, &op->stream->decisions);
+				RB_CLEAR_NODE(&op->decision);
+			}
+			if (op->op == IORING_OPAQUE_RECV_OBJECT)
+				io_opaque_restore(op);
+		}
+		if (op->stream->collector == op) {
+			op->stream->collector = NULL;
+			close = !op->stream->eof && !op->stream->closed && !op->stream->error;
+		}
+		mutex_unlock(&op->stream->lock);
+		if (close)
+			io_opaque_stream_close(op->stream);
+	}
+	if (op->slot_reserved) {
+		mutex_lock(&store->tables);
+		store->objects[op->slot].reserved = false;
+		io_opaque_release_slot(store->object_used, op->slot,
+				       store->objects[op->slot].generation);
+		mutex_unlock(&store->tables);
+	}
+	io_opaque_data_put(store, op->data);
+	io_opaque_stream_put(op->stream);
+	lockdep_assert_held(&req->ctx->uring_lock);
+	io_cache_free(&req->ctx->opaque_cache, op);
+	io_req_async_data_clear(req, 0);
+}
diff --git a/io_uring/opaque_register.c b/io_uring/opaque_register.c
new file mode 100644
index 000000000000..9e39d1ee5072
--- /dev/null
+++ b/io_uring/opaque_register.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Ring-local registration IDs for shared kernel-resident object stores. */
+#include <linux/anon_inodes.h>
+#include <linux/file.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+#include <uapi/linux/io_uring/opaque.h>
+
+#include "io_uring.h"
+#include "opaque.h"
+
+static void io_opaque_unregister_user(struct io_opaque_store *store)
+{
+	io_opaque_user_put(store);
+	io_opaque_put(store);
+}
+
+int io_register_opaque(struct io_ring_ctx *ctx, void __user *arg)
+{
+	struct io_uring_opaque_register reg;
+	struct io_uring_opaque_config config;
+	struct io_opaque_store *store;
+	u32 size, id;
+	int ret;
+
+	lockdep_assert_held(&ctx->uring_lock);
+	if (!(ctx->flags & IORING_SETUP_DEFER_TASKRUN) ||
+	    !(ctx->flags & (IORING_SETUP_CQE32 | IORING_SETUP_CQE_MIXED)))
+		return -EINVAL;
+	if (get_user(size, &((struct io_uring_opaque_register __user *)arg)->size))
+		return -EFAULT;
+	if (size < offsetof(struct io_uring_opaque_register, __resv) || size > PAGE_SIZE)
+		return -EINVAL;
+	ret = copy_struct_from_user(&reg, sizeof(reg), arg, size);
+	if (ret)
+		return ret;
+	if (reg.size != size || reg.__resv0 ||
+	    !mem_is_zero(reg.__resv, sizeof(reg.__resv)))
+		return -EINVAL;
+	reg.size = sizeof(reg);
+	if (reg.store_id || reg.flags)
+		return -EINVAL;
+	if (reg.fd != -1 || !reg.config ||
+	    reg.config_size < offsetof(struct io_uring_opaque_config, __resv0) ||
+	    reg.config_size > PAGE_SIZE)
+		return -EINVAL;
+	ret = copy_struct_from_user(&config, sizeof(config),
+				    u64_to_user_ptr(reg.config), reg.config_size);
+	if (ret)
+		return ret;
+	store = io_opaque_alloc(ctx, &config);
+	if (IS_ERR(store))
+		return PTR_ERR(store);
+	ret = xa_alloc(&ctx->opaque_stores, &id, store, xa_limit_31b, GFP_KERNEL);
+	if (ret)
+		goto put_store;
+	reg.store_id = id;
+	ret = copy_struct_to_user(arg, size, &reg, sizeof(reg), NULL);
+	if (!ret)
+		return 0;
+	xa_erase(&ctx->opaque_stores, id);
+put_store:
+	io_opaque_unregister_user(store);
+	return ret;
+}
+
+void io_terminate_opaque(struct io_ring_ctx *ctx)
+{
+	struct io_opaque_store *store;
+	unsigned long index;
+
+	lockdep_assert_held(&ctx->uring_lock);
+	if (ctx->opaque_stores_dying)
+		return;
+	ctx->opaque_stores_dying = true;
+	xa_for_each(&ctx->opaque_stores, index, store)
+		io_opaque_user_put(store);
+}
+
+void io_unregister_opaque(struct io_ring_ctx *ctx)
+{
+	struct io_opaque_store *store;
+	unsigned long index;
+
+	lockdep_assert_held(&ctx->uring_lock);
+	io_terminate_opaque(ctx);
+	xa_for_each(&ctx->opaque_stores, index, store)
+		io_opaque_put(store);
+	xa_destroy(&ctx->opaque_stores);
+}
diff --git a/io_uring/opdef.c b/io_uring/opdef.c
index cf3aa2242cd7..256c7c533118 100644
--- a/io_uring/opdef.c
+++ b/io_uring/opdef.c
@@ -38,6 +38,7 @@
 #include "futex.h"
 #include "truncate.h"
 #include "zcrx.h"
+#include "opaque.h"
 
 static int io_no_issue(struct io_kiocb *req, unsigned int issue_flags)
 {
@@ -591,6 +592,17 @@ const struct io_issue_def io_issue_defs[] = {
 		.prep			= io_uring_cmd_prep,
 		.issue			= io_uring_cmd,
 	},
+	[IORING_OP_OPAQUE_OBJ] = {
+		.audit_skip		= 1,
+		.ioprio			= 1,
+#ifdef CONFIG_IO_URING_OPAQUE_OBJ
+		.async_size		= sizeof(struct io_opaque_req),
+		.prep			= io_opaque_prep,
+		.issue			= io_opaque_issue,
+#else
+		.prep			= io_eopnotsupp_prep,
+#endif
+	},
 };
 
 const struct io_cold_def io_cold_defs[] = {
@@ -849,6 +861,10 @@ const struct io_cold_def io_cold_defs[] = {
 		.sqe_copy		= io_uring_cmd_sqe_copy,
 		.cleanup		= io_uring_cmd_cleanup,
 	},
+	[IORING_OP_OPAQUE_OBJ] = {
+		.name			= "OPAQUE_OBJ",
+		.cleanup		= io_opaque_cleanup,
+	},
 };
 
 const char *io_uring_get_opcode(u8 opcode)
diff --git a/io_uring/register.c b/io_uring/register.c
index 2ce36623e25a..1e450554ca38 100644
--- a/io_uring/register.c
+++ b/io_uring/register.c
@@ -32,6 +32,7 @@
 #include "msg_ring.h"
 #include "memmap.h"
 #include "zcrx.h"
+#include "opaque.h"
 #include "query.h"
 #include "bpf_filter.h"
 
@@ -1013,6 +1014,12 @@ static int __io_uring_register(struct io_ring_ctx *ctx, unsigned opcode,
 	case IORING_REGISTER_QUERY:
 		ret = io_query(arg, nr_args);
 		break;
+	case IORING_REGISTER_OPAQUE_STORE:
+		ret = -EINVAL;
+		if (!arg || nr_args != 1)
+			break;
+		ret = io_register_opaque(ctx, arg);
+		break;
 	case IORING_REGISTER_ZCRX_CTRL:
 		ret = io_zcrx_ctrl(ctx, arg, nr_args);
 		break;
-- 
2.34.1

