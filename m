Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316816;
	b=4/OFCSRQtTxLQZ5cWv5q2yKwb4pSvwDPBS0eQjE2e2CBnxPU9inRyRTyXBfwupkfe5ze
	 96/dK3QT+pHEtaR5V+F6wPaJos3jGyoJGNWkKwiRm+kSRXp8g7gwC+l6mA7pTQhwUEi3i
	 3ETfTTEg2218LI59FNT1wo/88SDcGuZ58koXq2JPHudPDiELgP/AeOwubGfmtN1hLhCGR
	 xKAF0OLpRYqEzMB+yUOVJ1krztTTqIQXssjhiw4eIfKCJ69Sw/8+j8vtgl8MnC7cMAMno
	 cNSS33j5AZNNtWoity8OeVAEWvOiJBCxV7QVLGTGHP1OwvOe/jxt0YY2zj659Cfy6hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316816;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vkQf0bsdN84NMZ6Q6aPSL5Z4srcg0iBviv4rLWVoxQM=;
	b=GEJWSNSnqfBUJVd7slfNVeWeOd4VfTkksBRT/+bi+S49bzmL0s34pio7yXJciDIy37W2
	 O3GU3QB+5mtBaxlvWn7LGM9FT7GkgDqv9kTHon+gMJHMheG7wrrQ3LvrVtIqbpms6Swhg
	 4zZB9XnFj1CeVQYPqrVTTvWyQrWrgo4RPgtUrGwu3cr+cC4wfStaxbhubuthR0O5O2r93
	 61BqHzWZVa8QsBGrAwk1UeEZzduaVXkuoXnydNWr9InOpb5XiIxqUqlN/Qxz1hzNbYp6B
	 Cfns7V84AX+0HnyGbo01Nd/ZXCEXdQ0d2JJsQM1VRTw8DQPJG/PuM6QJSBBdk2WRv3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BqDI+uJb;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Ay2g2CmS;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DAF606BFEB
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 13:20:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79DAF606BFEB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BqDI+uJb;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Ay2g2CmS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794316814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vkQf0bsdN84NMZ6Q6aPSL5Z4srcg0iBviv4rLWVoxQM=;
	b=BqDI+uJbskGFLklfpVtC9wFVU9N6uHFNtPO05iCJcB4Cb+KhEDChmDUX1L7BvM8kJfcb7M
	FEuD6y5KOFkvn7fQV0Ivg0CPDpEssRDnDC5Gvk2g10SpnOmcBrOBP8S9s+gCnweZJk0wtY
	NTRNKGd/niIGORNc947Ou6C+7M/ymjs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-h3SyMBaLOz2GUZDfheaQfw-1; Tue, 10 Nov 2026 08:20:13 -0500
X-MC-Unique: h3SyMBaLOz2GUZDfheaQfw-1
X-Mimecast-MFC-AGG-ID: h3SyMBaLOz2GUZDfheaQfw_1794316812
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c42888c50c4so184578366b.0
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 05:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794316812; x=1794921612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vkQf0bsdN84NMZ6Q6aPSL5Z4srcg0iBviv4rLWVoxQM=;
        b=Ay2g2CmSDGhfYv1HZpyR0gbQmRZPeb5Lugq7IS/RpaYt1hOKT0xm1F2blDKOUQwW12
         49bf89wmIvl9/lt5cbaFd07CQ9jl9XT7NOxNeXq+7hNcPTNXy9EREQdmRDqRRJCP076b
         mBwFl1BbuRUMxyhSzm7RPO78j1NNpGpidO/A6VBogP12ZgxRVelElW6rkN2KnuNNQiD8
         OeY6lDB+DzYvZBTYweiN7BjKb4nDrqBbdTWZ/5np6/yZZgVzfao0O4u1FdualM3RufnG
         ea/znoUgVwu9/JFdji3I/jsUZ9d7byqA8rs+iSQZGRIHqy/RDTQP5fH2aIjvWhPpe3+x
         kRig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794316812; x=1794921612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vkQf0bsdN84NMZ6Q6aPSL5Z4srcg0iBviv4rLWVoxQM=;
        b=zl3aQIUvCVdnABgZsc3uOvkJt1tzuSk2buPxYk82LZtsbQlnszI/MARA40WgJpmdH5
         KfJtCkwM806iXl+o0NZ3kv1dyndXsHMjrzuWPCBUWfkuGWQvsIXIJaHf2Ur6TdWyiVYM
         vAp9Wm+aAtKhCsndGGqmTz50DrM+S4bNrqWfUdhX7BA3oaa5NubPXIeF4l/tyfK/8kH5
         Sst5BN/i9bKleW/ldWPnpomgbOEMEM5fwBdymy/ORrkkHAenuu8VGIJRmL8Qjyi95mkU
         jVcDTj/22oGArgi0TKfrJvZeWluzGYOMrclxDuIODH3C3DhQr7HuGv7nfqhnN5q7JYpy
         q/HA==
X-Forwarded-Encrypted: i=1; AL+hErGv93lCouUdQWCQPHCJeyAg6hscEeRE+GNAz0YJg5b1hY+PAPuz79Cu2ezwcjo6Owgz3Mo=@vger.kernel.org
X-Gm-Message-State: APuU4Z9ssyEFD8X4fspPmdGPIuNbEUBREkGm9luhL7RVpXFykXiDqyYW
	qdqd0bGkgDOaTl7j8dqoEKH7c1pHwAAq8EuS5+P+NGHTr8u2xEMS7Sc7Te5jWL+Jwft6iBjBoEI
	TIlCd/+mfFsGRPqmiPu6+T4P8ljMZmG0ywoI1CsgvO7Bki9l8G2qVuQ==
X-Gm-Gg: AYBFou18OIBZt0mSnvHenZxamm0aQuCQUIsXruXrldRrP4h3aTRIQR6FoihGXX78ILE
	KOGv+erIrTNVuV8HED24iEofj8VhWfTWfRb8rif91LpKyV7uEOxjCot9KngLdasMgem0SmVJMhl
	0Fsbf1S04ljLPFhGuafG5qHqhfeN0lueE1DD9RTufX6FnX7/d19b8LIyrlBcR6dmIc6JaWbg9yV
	zT20+kYPgMTE8m8+9V9HW+6QpawasTEFi9lDYUuPfUM6LDKoUJJO8kw+fYqKOZ0/Tx8qKaCRMx4
	LDh1aIOYeQqX/C3RZG71D79yQRu/ql1bBt2JRPY0yXEhu4Z2id9IGaIaGIxCF4xU3fChb2LTHuL
	kzotC6REwkhlYBDhhA27qwD+3HpAyQCoqGu3NjXL/eWudbLq1tI5/Qo2cH2Y+8gjaAnqwfirgFg
	KBwsPxdzP0UjeJJzxLRDeg63aOIq3M/QuwbJZXOHp23SNRY/iMP1OP7fhc2nHvC8P1OgZhBhYzf
	XN81q/vMk5FmxpuOHlZ9h1uo+inq2eQnf0BeBM6YRd4oFv8ANlB
X-Received: by 2002:a17:907:cbc5:b0:c4c:d6a3:f4bb with SMTP id a640c23a62f3a-c504951e429mr197752066b.10.1794316811555;
        Tue, 10 Nov 2026 05:20:11 -0800 (PST)
X-Received: by 2002:a17:907:cbc5:b0:c4c:d6a3:f4bb with SMTP id a640c23a62f3a-c504951e429mr197749666b.10.1794316811010;
        Tue, 10 Nov 2026 05:20:11 -0800 (PST)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a5d54bbsm107791166b.48.2026.11.10.05.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 05:20:10 -0800 (PST)
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
Subject: [RFC PATCH net-next 02/12] io_uring/opaque: add data structures and the UAPI header
Date: Tue, 10 Nov 2026 13:19:56 +0000
Message-Id: <20261110132006.3280986-3-amarkuze@redhat.com>
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

Define immutable versions, backing extents, stores and request state.
TX queues record FIFO positions ordered by enqueue under the store's TX
lock, including positions with reference acquisition still pending, and
carry a busy socket identity pin.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 include/linux/io_uring_types.h       |  10 +
 include/uapi/linux/io_uring/opaque.h | 126 +++++++++++++
 io_uring/opaque.h                    | 155 +++++++++++++++
 io_uring/opaque_internal.h           | 269 +++++++++++++++++++++++++++
 4 files changed, 560 insertions(+)
 create mode 100644 include/uapi/linux/io_uring/opaque.h
 create mode 100644 io_uring/opaque.h
 create mode 100644 io_uring/opaque_internal.h

diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_types.h
index 9140c21ca819..198c6bdb3e2c 100644
--- a/include/linux/io_uring_types.h
+++ b/include/linux/io_uring_types.h
@@ -412,6 +412,9 @@ struct io_ring_ctx {
 		struct io_alloc_cache	netmsg_cache;
 		struct io_alloc_cache	rw_cache;
 		struct io_alloc_cache	cmd_cache;
+#ifdef CONFIG_IO_URING_OPAQUE_OBJ
+		struct io_alloc_cache	opaque_cache;
+#endif
 
 		int (*loop_step)(struct iou_ctx *,
 				 struct iou_loop_params *);
@@ -421,6 +424,9 @@ struct io_ring_ctx {
 		 * ->uring_cmd() by io_uring_cmd_insert_cancelable()
 		 */
 		struct hlist_head	cancelable_uring_cmd;
+#ifdef CONFIG_IO_URING_OPAQUE_OBJ
+		struct list_head	opaque_waits;
+#endif
 		/*
 		 * For Hybrid IOPOLL, runtime in hybrid polling, without
 		 * scheduling time
@@ -491,6 +497,10 @@ struct io_ring_ctx {
 
 	/* Stores zcrx object pointers of type struct io_zcrx_ifq */
 	struct xarray			zcrx_ctxs;
+#ifdef CONFIG_IO_URING_OPAQUE_OBJ
+	struct xarray			opaque_stores;
+	bool				opaque_stores_dying;
+#endif
 
 	/* Used for accounting references on pages in registered buffers */
 	struct xarray		hpage_acct;
diff --git a/include/uapi/linux/io_uring/opaque.h b/include/uapi/linux/io_uring/opaque.h
new file mode 100644
index 000000000000..692daa7d7e32
--- /dev/null
+++ b/include/uapi/linux/io_uring/opaque.h
@@ -0,0 +1,126 @@
+/* SPDX-License-Identifier: (GPL-2.0 WITH Linux-syscall-note) OR MIT */
+#ifndef LINUX_IO_URING_OPAQUE_H
+#define LINUX_IO_URING_OPAQUE_H
+
+#include <linux/types.h>
+
+/* IORING_REGISTER_OPAQUE_STORE, nr_args == 1. size includes reserved bytes. */
+struct io_uring_opaque_register {
+	__u32 size;
+	__u32 flags;
+	__s32 fd;
+	__u32 store_id;
+	__u64 config;
+	__u32 config_size;
+	__u32 __resv0;
+	__u64 __resv[2];
+};
+
+/* config/config_size select a size-versioned configuration on creation. */
+struct io_uring_opaque_config {
+	__u64 hard_limit;
+	__u64 compact_headroom;
+	__u32 max_object_size;
+	__u32 max_objects;
+	__u32 max_streams;
+	__u32 max_extents;
+	__u32 flags;
+	__u32 __resv0;
+	__u64 __resv[2];
+	__u64 high_watermark;
+	__u64 low_watermark;
+	__u64 reply_reserve;
+	__u32 __resv2;
+	__u32 __resv1;
+};
+
+/* IORING_OP_OPAQUE_OBJ: sqe->ioprio selects the operation. */
+enum io_uring_opaque_op {
+	/* Nonconsuming available window; len is capacity, never WAITALL. */
+	IORING_OPAQUE_INSPECT,
+	/* Complete-only object-ready CQE for the declared future stream range. */
+	IORING_OPAQUE_RECV_OBJECT,
+	IORING_OPAQUE_DISCARD,
+	/* Copy from an already complete immutable object. */
+	IORING_OPAQUE_READ_OBJECT,
+	IORING_OPAQUE_FREE,
+	IORING_OPAQUE_STAT,
+	IORING_OPAQUE_OBJECT_STAT,
+	IORING_OPAQUE_STREAM_STAT,
+	IORING_OPAQUE_STREAM_CLOSE,
+	IORING_OPAQUE_COMPACT,
+	IORING_OPAQUE_SET_POLICY,
+	/* Copy userspace bytes into a new complete immutable object. */
+	IORING_OPAQUE_CREATE,
+	/* Nonconsuming contiguous byte count, without copying payload. */
+	IORING_OPAQUE_AVAILABLE,
+};
+
+/* Optional SEND sqe->addr3 framing; size includes zero reserved extensions. */
+struct io_uring_opaque_frame {
+	__u32 size;
+	__u32 flags;
+	__u64 prefix;
+	__u64 suffix;
+	__u32 prefix_length;
+	__u32 suffix_length;
+	__u64 __resv[2];
+};
+
+/* Combined copied prefix and suffix, independently of object body length. */
+#define IORING_OPAQUE_FRAME_MAX	(64U * 1024U)
+
+#define IORING_OPAQUE_OBJECT_F_COMPACTED	(1U << 0)
+#define IORING_OPAQUE_OBJECT_F_COMPACTING	(1U << 1)
+#define IORING_OPAQUE_OBJECT_F_FORWARD_ONLY (1U << 2)
+#define IORING_OPAQUE_STREAM_F_EOF		(1U << 0)
+
+enum io_uring_opaque_memory_mode {
+	IORING_OPAQUE_MEMORY_NORMAL,
+	IORING_OPAQUE_MEMORY_LOWMEM,
+};
+
+struct io_uring_opaque_stat {
+	__u32 size;
+	__u32 __resv;
+	__u64 backing_bytes;
+	__u64 hard_limit;
+	__u64 copied_bytes;
+	__u64 compacted_bytes;
+	__u64 compact_count;
+	__u32 objects;
+	__u32 streams;
+	__u32 extents;
+	__u32 memory_mode;
+	__u64 framing_bytes;
+	__u64 framing_copied_bytes;
+};
+
+struct io_uring_opaque_object_stat {
+	__u32 size;
+	__u32 flags;
+	__u64 length;
+	__u64 backing_bytes;
+	__u32 extents;
+	__u32 __resv;
+};
+
+struct io_uring_opaque_stream_stat {
+	__u32 size;
+	__u32 flags;
+	__u64 rx_next;
+	__u64 undecided_bytes;
+	__s32 error;
+	__u32 __resv;
+};
+
+struct io_uring_opaque_policy {
+	__u32 flags;
+	__u32 __resv0;
+	__u64 bytes_per_second;
+	__u64 burst_bytes;
+	__u64 max_temporary_bytes;
+	__u64 __resv[2];
+};
+
+#endif /* LINUX_IO_URING_OPAQUE_H */
diff --git a/io_uring/opaque.h b/io_uring/opaque.h
new file mode 100644
index 000000000000..a7210f4bee5e
--- /dev/null
+++ b/io_uring/opaque.h
@@ -0,0 +1,155 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef IO_URING_OPAQUE_H
+#define IO_URING_OPAQUE_H
+
+#include <linux/io_uring_types.h>
+#include <linux/rbtree.h>
+#include <linux/uio.h>
+#include <uapi/linux/io_uring/opaque.h>
+
+struct io_opaque_store;
+struct io_cancel_data;
+struct io_uring_opaque_config;
+
+#ifdef CONFIG_IO_URING_OPAQUE_OBJ
+struct io_opaque_stream;
+struct io_opaque_data;
+struct io_opaque_tx;
+struct io_opaque_vec;
+
+enum io_opaque_phase {
+	IO_OPAQUE_IDLE,
+	IO_OPAQUE_RANGE_WAIT,
+	IO_OPAQUE_BUDGET_POLL,
+	IO_OPAQUE_SEND_WAIT,
+	IO_OPAQUE_COPY_WORK,
+	IO_OPAQUE_QUEUED,
+};
+
+struct io_opaque_req {
+	struct io_kiocb *req;
+	struct io_opaque_store *store;
+	struct io_opaque_stream *stream;
+	struct io_opaque_data *data;
+	struct list_head wait;
+	struct list_head cancel;
+	u64 handle;
+	u64 offset;
+	u64 progress;
+	u64 need_bytes;
+	/* Unallocated CREATE charge; must coexist with the reserved slot. */
+	u64 create_reserved;
+	unsigned long retry_at;
+	void __user *addr;
+	u32 length;
+	int result;
+	u16 op;
+	u16 collect_flags;
+	enum io_opaque_phase phase;
+	bool canceled;
+	bool slot_reserved;
+	bool consumed;
+	bool resolved;
+	bool budget_reported;
+	union {
+		struct {
+			struct rb_node decision;
+			struct list_head read;
+			u32 slot;
+		};
+		struct {
+			struct iov_iter iter;
+			struct list_head send;
+			struct io_opaque_tx *tx;
+			void *framing;
+			u64 prefix;
+			u64 suffix;
+			u32 frame_charge;
+			u32 prefix_length;
+			u32 suffix_length;
+			u32 total_length;
+			u32 msg_flags;
+			u16 send_flags;
+			bool frame_reserved;
+		};
+		struct {
+			struct io_opaque_data *replacement;
+			u64 reserved;
+			u64 transient;
+		};
+		struct io_uring_opaque_policy policy;
+	};
+	/*
+	 * Block of a vectored send, kept when the request returns to the ring's
+	 * cache so that the next one has none to allocate. It is not part of the
+	 * union and is the last member: allocation clears everything before it.
+	 * Only a request with IORING_OPAQUE_SEND_VECTOR uses it, whatever it holds.
+	 */
+	struct io_opaque_vec *vec;
+};
+
+bool io_opaque_cache_init(struct io_ring_ctx *ctx);
+void io_opaque_cache_free(struct io_ring_ctx *ctx);
+struct io_opaque_store *io_opaque_alloc(struct io_ring_ctx *ctx,
+					const struct io_uring_opaque_config *config);
+void io_opaque_get(struct io_opaque_store *store);
+void io_opaque_user_put(struct io_opaque_store *store);
+void io_opaque_put(struct io_opaque_store *store);
+int io_register_opaque(struct io_ring_ctx *ctx, void __user *arg);
+void io_terminate_opaque(struct io_ring_ctx *ctx);
+void io_unregister_opaque(struct io_ring_ctx *ctx);
+void io_opaque_stop(struct io_opaque_store *store);
+void io_opaque_free(struct io_opaque_store *store);
+int io_opaque_recv_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe);
+int io_opaque_recv(struct io_kiocb *req, unsigned int issue_flags);
+int io_opaque_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe);
+int io_opaque_issue(struct io_kiocb *req, unsigned int issue_flags);
+int io_opaque_send_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe);
+int io_opaque_send(struct io_kiocb *req, unsigned int issue_flags);
+void io_opaque_cleanup(struct io_kiocb *req);
+void io_opaque_fail(struct io_kiocb *req);
+int io_opaque_cancel(struct io_ring_ctx *ctx, struct io_cancel_data *cd,
+		     unsigned int issue_flags);
+bool io_opaque_cancel_all(struct io_ring_ctx *ctx, struct io_uring_task *tctx,
+			  bool cancel_all);
+#else
+static inline bool io_opaque_cache_init(struct io_ring_ctx *ctx)
+{
+	return false;
+}
+
+static inline void io_opaque_cache_free(struct io_ring_ctx *ctx)
+{
+}
+
+static inline int io_register_opaque(struct io_ring_ctx *ctx, void __user *arg)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void io_terminate_opaque(struct io_ring_ctx *ctx)
+{
+}
+
+static inline void io_unregister_opaque(struct io_ring_ctx *ctx)
+{
+}
+
+static inline void io_opaque_cleanup(struct io_kiocb *req)
+{
+}
+
+static inline int io_opaque_cancel(struct io_ring_ctx *ctx,
+				   struct io_cancel_data *cd,
+				   unsigned int issue_flags)
+{
+	return -ENOENT;
+}
+
+static inline bool io_opaque_cancel_all(struct io_ring_ctx *ctx,
+					struct io_uring_task *tctx, bool cancel_all)
+{
+	return false;
+}
+#endif
+#endif
diff --git a/io_uring/opaque_internal.h b/io_uring/opaque_internal.h
new file mode 100644
index 000000000000..f6b372800c76
--- /dev/null
+++ b/io_uring/opaque_internal.h
@@ -0,0 +1,269 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef IO_URING_OPAQUE_INTERNAL_H
+#define IO_URING_OPAQUE_INTERNAL_H
+
+#include <linux/bitmap.h>
+#include <linux/bvec.h>
+#include <linux/net.h>
+#include <linux/sizes.h>
+#include <linux/workqueue.h>
+#include <uapi/linux/io_uring/opaque.h>
+
+#include "opaque.h"
+
+#define IO_OPAQUE_READ_MAX	SZ_64K
+#define IO_OPAQUE_RX_BATCH	SZ_256K
+#define IO_OPAQUE_MAX_ORDER	(PAGE_SHIFT < 16 ? 16 - PAGE_SHIFT : 0)
+#define IO_OPAQUE_ALLOC_RETRY_MS	50
+#define IO_OPAQUE_WAKE_BATCH	32
+#define IO_OPAQUE_INDEX_BITS	14
+#define IO_OPAQUE_INDEX_MASK	((1U << IO_OPAQUE_INDEX_BITS) - 1)
+/* Stream tokens carry the tag bit; object handles and generations never do. */
+#define IO_OPAQUE_TOKEN_TAG	BIT_ULL(63)
+#define IO_OPAQUE_GENERATION_MAX	(U64_MAX >> (IO_OPAQUE_INDEX_BITS + 1))
+/* Unused per-socket TX queues kept per store; the oldest is freed beyond this. */
+#define IO_OPAQUE_TX_IDLE_MAX	64
+/* Backing segments all ranges of one vectored send may span; more is EMSGSIZE. */
+#define IO_OPAQUE_SEND_VEC_SEGS	4096
+/*
+ * A version of more segments than this records where every this-many-th of
+ * them starts, so that a range is found with a walk of about this many steps
+ * and a binary search, however large the version is and wherever the walk
+ * began. A smaller one is walked, which is as short.
+ */
+#define IO_OPAQUE_SEEK_STRIDE	16
+/* Slots of the table of handles that a policy change walks while it holds tables. */
+#define IO_OPAQUE_POLICY_CHUNK	256
+
+/* What io_opaque_tx_join() returns besides an error. */
+/* Queued behind another frame and parked, with its references taken. */
+#define IO_OPAQUE_TX_WAIT	0
+/* The head of its queue, with its references taken. */
+#define IO_OPAQUE_TX_HEAD	1
+/* The head of its queue, still to take its references. */
+#define IO_OPAQUE_TX_SETTLE	2
+
+struct io_opaque_backing {
+	refcount_t refs;
+	struct page *page;
+	u64 charge;
+	u32 filled;
+	bool copied;
+	bool accounted;
+};
+
+struct io_opaque_extent {
+	struct list_head list;
+	struct io_opaque_backing *backing;
+	u64 start;
+	u32 offset;
+	u32 length;
+	bool embedded;
+};
+
+/* One allocation for the common capture; splits allocate only an extent. */
+struct io_opaque_chunk {
+	struct io_opaque_backing backing;
+	struct io_opaque_extent extent;
+};
+
+struct io_opaque_data {
+	refcount_t refs;
+	struct list_head extents;
+	struct bio_vec *bvec;
+	/*
+	 * Where segments 0, IO_OPAQUE_SEEK_STRIDE, twice that and so on start,
+	 * as bytes into the object, when it has more than that many segments;
+	 * else NULL. It is allocated with bvec and freed with it.
+	 */
+	u64 *anchor;
+	u64 length;
+	u64 charge;
+	u32 nr;
+	bool dense;
+	bool forward_only;
+};
+
+struct io_opaque_slot {
+	struct io_opaque_data *data;
+	u64 generation;
+	bool reserved;
+	bool compacting;
+	struct list_head candidate;
+	unsigned long born;
+	unsigned long retry;
+};
+
+struct io_opaque_stream_slot {
+	struct io_opaque_stream *stream;
+	u64 generation;
+};
+
+struct io_opaque_tx {
+	struct rb_node node;
+	struct sock *sk;
+	/* First-issue order, including pending admissions; only the head sends. */
+	struct list_head requests;
+	/* On store->txs_idle while no request is queued. */
+	struct list_head idle;
+	bool failed;
+	/* A busy queue owns its socket identity independently of request files. */
+	bool sk_held;
+};
+
+/*
+ * Where one range of a vectored send starts in the version it pins. Admission
+ * finds it under tables; the cursor is built from it once tables is dropped.
+ */
+struct io_opaque_vec_start {
+	/* The first segment of the range. */
+	u32 seg;
+	/* Bytes of that segment before the range. */
+	u32 skip;
+};
+
+/*
+ * What a vectored send needs besides the request: its entries, copied at prep,
+ * the version each pins, where each starts in it and the segments of the
+ * combined cursor. One block holds the header and the four arrays, so that
+ * growing it is one allocation.
+ */
+struct io_opaque_vec {
+	/* Entries, from the SQE. */
+	u32 nr;
+	/*
+	 * Entries of pin[] that admission has set. The version of each is kept
+	 * alive by the send, by a reference of the entry's own or, unless the
+	 * vector is LAST, by that of the entry before it when both name the
+	 * same handle.
+	 */
+	u32 pinned;
+	u32 cap_nr;
+	u32 cap_segs;
+	struct io_uring_opaque_send_entry *ent;
+	struct io_opaque_data **pin;
+	struct io_opaque_vec_start *start;
+	struct bio_vec *bv;
+};
+
+struct io_opaque_stream {
+	refcount_t refs;
+	/* Extents, range decisions and collector state. */
+	struct mutex lock;
+	struct io_opaque_store *store;
+	struct file *file;
+	struct sock_rx_owner owner;
+	struct list_head extents;
+	struct list_head reads;
+	struct rb_root_cached decisions;
+	struct io_opaque_req *collector;
+	u64 token;
+	u64 next;
+	u64 undecided;
+	u64 need_bytes;
+	int error;
+	bool eof;
+	bool closed;
+	/* Collection pass may not take undecided bytes off the socket. */
+	bool hold_undecided;
+};
+
+struct io_opaque_store {
+	refcount_t refs;
+	refcount_t users;
+	struct io_uring_opaque_config config;
+	/*
+	 * Handles and candidates; never held during copies or I/O, and for a time
+	 * that the request bounds: what admission does under it is a lookup per
+	 * entry, the segments its ranges span up to the limit, and for each range
+	 * a walk that the version's anchors keep to about two strides and a
+	 * binary search. Attach and the admission of a send take it with the
+	 * socket owned, so nothing may take a socket lock while holding it, or
+	 * wait for anything that holds one for long.
+	 */
+	struct mutex tables;
+	struct io_opaque_slot *objects;
+	struct io_opaque_stream_slot *streams;
+	unsigned long *object_used;
+	unsigned long *stream_used;
+	u32 object_cursor;
+	u32 stream_cursor;
+	u32 nr_objects;
+	u32 nr_streams;
+	struct rb_root txs;
+	struct list_head txs_idle;
+	u32 nr_txs_idle;
+	struct user_struct *user;
+	struct mm_struct *mm;
+	struct mem_cgroup *memcg;
+	struct obj_cgroup *objcg;
+	atomic64_t bytes;
+	atomic64_t copied;
+	atomic64_t compacted;
+	atomic64_t compactions;
+	atomic64_t framing;
+	atomic64_t framing_copied;
+	/* Framing held in the reply reserve, outside bytes. */
+	atomic64_t reserve_framing;
+	/*
+	 * Charged in bytes but not payload held: unpublished compaction copies
+	 * and framing in ordinary capacity. Watermarks subtract it. Changes
+	 * that move bytes and transient together are one seqcount write.
+	 */
+	atomic64_t transient;
+	/* Serializes transient_seq writers. */
+	spinlock_t transient_lock;
+	seqcount_spinlock_t transient_seq;
+	atomic_t extents;
+	atomic_t memory_mode;
+	/* Budget waiters and remote wakeup/cancellation arbitration. */
+	spinlock_t wait_lock;
+	/* TX queues: the tree, every queue's requests and failed flag. Never with tables. */
+	spinlock_t tx_lock;
+	struct list_head budget_waits;
+	struct list_head copies;
+	/* One dispatcher serializes manual and automatic copies. */
+	struct delayed_work compact_work;
+	struct delayed_work retry_work;
+	struct list_head candidates;
+	struct io_uring_opaque_policy policy;
+	/* Counts policy changes; a walk of the table that is overtaken by another stops. */
+	u32 policy_seq;
+	u64 tokens;
+	unsigned long token_time;
+	unsigned long auto_at;
+	int dead;
+};
+
+bool io_opaque_charge(struct io_opaque_store *store, u64 bytes, bool rx);
+void io_opaque_uncharge(struct io_opaque_store *store, u64 bytes);
+bool io_opaque_charge_transient(struct io_opaque_store *store, u64 bytes, u64 limit);
+void io_opaque_release_transient(struct io_opaque_store *store, u64 uncharge,
+				 u64 transient);
+bool io_opaque_charge_frame(struct io_opaque_store *store, u64 bytes, bool *reserved);
+void io_opaque_uncharge_frame(struct io_opaque_store *store, u64 bytes, bool reserved);
+int io_opaque_memory_mode(struct io_opaque_store *store);
+
+static inline u64 io_opaque_rx_limit(struct io_opaque_store *store)
+{
+	return store->config.hard_limit - store->config.compact_headroom -
+	       store->config.reply_reserve;
+}
+
+struct io_opaque_extent *io_opaque_extent_new(struct io_opaque_store *store,
+					      struct page *page, u32 offset,
+					      u32 length, u64 start,
+					      bool reserved);
+struct io_opaque_data *io_opaque_data_alloc(void);
+void io_opaque_data_put(struct io_opaque_store *store,
+			struct io_opaque_data *data);
+int io_opaque_vector(struct io_opaque_data *data);
+struct page *io_opaque_owned_page(unsigned int *order);
+struct page *io_opaque_dest_page(struct io_opaque_store *store, u64 pages_left,
+				 unsigned int *order);
+u64 io_opaque_handle(u32 index, u64 generation);
+struct io_opaque_slot *io_opaque_lookup(struct io_opaque_store *store,
+					u64 handle);
+void io_opaque_wait(struct io_opaque_req *op, enum io_opaque_phase phase);
+void io_opaque_queue_ready(struct io_opaque_req *op, int result);
+#endif
-- 
2.34.1

