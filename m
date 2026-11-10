Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316827;
	b=ACXpW+GBHyRI11FSmRZ77o5H6m8mybA1uM4Uub8J+ZCkwjI77zDh59EfUWIqxbux0Ki6
	 O+8Znps/EzD+lxg83m2A6SzQDVVrdgqvY1XxEj1MdYRGkm54NjoF9ecS1tn9hKxZdDKsq
	 1zGn+5RVOJZlWY1TrReT4y6IXNzBL7XXuKbPP1Vej/u2IB1YptL58fUG/T5RguXNec/JX
	 SVBcJlArhb6bAu7OAmrB8QF0gY0TYHC2bzQiVpScp+1QjowWUpJql328TZdDf7Shb2Zrl
	 cyRi7LKuGDkQeYVKxDHYWUEo4x4qbSA6Um1lyZeN6UR1vikolMCqaGie9RC9mslRxGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316827;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=IMjpAbpOJnuW14XTRIrRCLYNjoSdqJNJdckzdUdSkFo=;
	b=E/BnXR0WOFv9zsONxyqSSo5ousC07DbaLQXZMdaLiBest+ndf7NX4+Erw3NQDfby40lj
	 I+g7ya3+WTTWO7u0n4pctC0FaZ4IuYsKu//Kc2tE4NUdMFHHWbfJHf3g27v0kmhGi+j24
	 8kxlHL8VoF+FCWDrHyy5s6sw+iFMIUZ1SVTqY6edV60Ss3KwhjKza0AFVQkcaHRj39oOq
	 6YgaUZwlDg6p+rdrxsZmT0it6PB+ccjzctKJY/K/zORKfOUfAvlfinLYk8cuWN2LcoxES
	 1gPHY1nAyQOhHt6uktDbecBuv+MHc4lpQcGBsHbNcfsozqWIdLv3LoamSb1Z6ib11OA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RcXEn5f9;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b="nN8P/pKj";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CA6606A9E6
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 13:20:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1CA6606A9E6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RcXEn5f9;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=nN8P/pKj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794316825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IMjpAbpOJnuW14XTRIrRCLYNjoSdqJNJdckzdUdSkFo=;
	b=RcXEn5f9x0KYmwBIoEfHD7FELErA26dCr1JtA2HfRTy15PPAD7QpDGtoaLuVjA0mpcEuZc
	nFYrZ/AMRDvxiZUHEcZAd3/OvGgrLzEJeTQa6eSLcSbjpyvrHoEJMU03CNCBeIrXN1OJBG
	Hja+deOOMtW3QIhmgm+sM1qf+bng8Sw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-xmiPl6YxPiCxoAD7T7zE_w-1; Tue, 10 Nov 2026 08:20:24 -0500
X-MC-Unique: xmiPl6YxPiCxoAD7T7zE_w-1
X-Mimecast-MFC-AGG-ID: xmiPl6YxPiCxoAD7T7zE_w_1794316823
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c42888c50c4so184597766b.0
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 05:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794316823; x=1794921623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IMjpAbpOJnuW14XTRIrRCLYNjoSdqJNJdckzdUdSkFo=;
        b=nN8P/pKjYfOdMOFTccorc+DPQr5TUiMFZke/HoDlETTSnwckBYK4/DDhWWUy4kfbaB
         tWrowqK19JbeJs7hH5Yt3nycFwDXb7iQNQFevvoqSHImAgx83kkmP8UCwo2G1sEdw6i3
         n4Wlp0J2+bzkwoHt80yZlfoSslcM61lsAVfKDqCYtWh5IaokpC3Fn9CtX2sHQkIUWdjs
         xRX8ctidOaFGgwvaRSVFPboLz0IweXAREp6YM2nSrsne1NZwRnVBueXzsuwNLPKJIZar
         ZSfDDCKievOFyClcl5pG9lAyrZOBFDErXvz2URm5c6mSAGXd9bRwaYkxpH3DMIEH73xr
         lJDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794316823; x=1794921623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IMjpAbpOJnuW14XTRIrRCLYNjoSdqJNJdckzdUdSkFo=;
        b=tMhnSmts91ETWcR8oJA9eR58vrbhWCBJw14xvf3B5C0oebfHGJg76ayVONMlMWN21J
         9RZuCUqYPR22zxJC3gd0bef6Q4v0y/rC5aXYAaBBdxinOGzL0Jz3w4lCBaFMXukcTm/H
         DZ1pR42ovri/kfbhCPO/Z7Dza5avDtHfWX4d69M2iH/TWoBgUdRJYGHscRD83v0yET4S
         CeOJYxVn577s6pNE7rn5DlPbhr5KRJsaBwwKx2yl5bHeWM/9x/8v5fszfA6Ao6x4PP/e
         VHnGEmPnBr3lO0HIu3ZpGKrF5C5QdA0uCUMLrW5XQqNwvEXXDOW24Z1pDz3nPfmZNNlG
         L5Og==
X-Forwarded-Encrypted: i=1; AL+hErGkJBwtq/EOlBJc4TtbGPgx7VDLdaV9ujm9fVtQSEfodgLmtB54OtgfmdNIaYvOIYoFytY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Kyo+g1I+5bfGPQc6i1SfWKJIEF5eSiz2+t2O0aNls7EiiHg4Z
	NY4CnQ74/vlqtd+D7nZ4QyKLghrsLX38OL04MNTcLOub8v8FufW0lT3khhQSHNnInl8qeVB+7rJ
	2nPJOtQw2yne79ODfbR6RcgtZ3iUqVVRuRmgIaD9vdHjQft7Ln7O8aw==
X-Gm-Gg: AYBFou1PShemcfKS7RZMGA2qaIjvwY7209TSyITFeaRxg37+KDN09Mzbx0bQIaAYXT3
	sAh9X8mOgmFkS6NMv4QUH63mcs2kIJBSzt6vQ4FbtK1VDd8AiVSbhSLkTtSUVh2LJROD8I4SiLJ
	uSigNlryxhqu2q+G8ZhjISIavgKDSEMF5jVmxNnYx+QWAl5IJ83gcVNt4Fa8UMxzgjYjwBmtHB2
	uGrv5fxcM4hFGVdFO3EwPzSJEI58/gpyQRRihz5CRllc+VG71V8Gb19N7S5NV4DXJL2+mBkqV7i
	x+hiUuGE2hm4cmsXRbCXLEZs7/BGTz51dnXAOJIPVWHlON2x4bPHRr1x9Pxg776d/f8RmO+4u9d
	Mh23qXU6dYbEk5sfIPzw6beypiws/mRCzAatRngXOrbryANJX9eS5znB+rOKAV5UlEsvgOPlSXx
	ZjV6GtbpwH9nyePOfFZBed8Aa07RfkrObaydeqmX+jsLec1iKbu1dKfvMa0AhGs6yanq4PImovF
	FdFsAy8RWMGZU8werdgLmSfyKa76doIPK/0xv9geaxQZ+ItU+dB
X-Received: by 2002:a17:906:379b:b0:c4d:212a:192a with SMTP id a640c23a62f3a-c50496a58cemr148395866b.48.1794316822413;
        Tue, 10 Nov 2026 05:20:22 -0800 (PST)
X-Received: by 2002:a17:906:379b:b0:c4d:212a:192a with SMTP id a640c23a62f3a-c50496a58cemr148392266b.48.1794316821686;
        Tue, 10 Nov 2026 05:20:21 -0800 (PST)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a5d54bbsm107791166b.48.2026.11.10.05.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 05:20:21 -0800 (PST)
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
Subject: [RFC PATCH net-next 09/12] io_uring/opaque: add IORING_OP_OPAQUE_COLLECT
Date: Tue, 10 Nov 2026 13:20:03 +0000
Message-Id: <20261110132006.3280986-10-amarkuze@redhat.com>
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

Add a multishot request that attaches a connected TCP socket to a store
and collects its receive stream. sqe->fd names the socket and
opaque_store_id the store. ioprio accepts POLL_FIRST; IOSQE_ASYNC and
successful-CQE suppression are rejected.

Attachment requires ESTABLISHED or CLOSE_WAIT, the original TCP protocol,
no receive owner, repair mode, urgent data or sk_user_data. Authorize
receive access under the request's credentials before attachment and
before taking the socket lock. This authorization covers the collector's
lifetime; subsequent passes do not recheck receive policy. Attachment
posts the stream-token CQE before publishing the receive claim. If that
CQE cannot be posted, no claim or byte is taken. Stream offset zero is
the first unread byte at attachment.

Each issue captures at most 256 KiB through tcp_read_sock(). The actor
follows the earliest pending stream decision: DISCARD consumes without
retention, RECV_OBJECT builds private backing, and other bytes become
undecided. Eligible unshared receive pages are retained by reference;
other data is packed into owned copies. Undecided bytes normally stop
further collection so TCP flow control can apply. Decisions and waiting
inspection requests can make collection resume.

Byte or extent pressure produces a nonterminal -ENOBUFS CQE, at most
once per unread offset, and enrolls the collector on the store's budget
wait list. Allocation failure imposes a 50-ms retry deadline. Wakeups
grant no capacity: reentry checks both budgets and the deadline again.
An infeasible partial RECV_OBJECT returns its private prefix and fails
instead of holding capacity while waiting for the rest of itself.

Use native multishot socket polling between collection passes. The
receive-owner callback, decisions, closure and capacity returns set
a persistent private collector predicate before waking the socket
waitqueue with kernel-only POLL_RX_OWNER (bit 26). Native poll enrolls
before checking the predicate and consumes it only on collector entry.
Filter the private key before taking poll ownership: ordinary polls
and output async polls ignore it. Eligible payload-read async polls
recheck current receive ownership even after coalesced notifications,
so the real receive handler reports the owner conflict. Error-queue
receives retain their existing behavior. No UAPI poll event is added.

Retain a pass after both initial and multishot batch exhaustion. A
worker poll before first issue permits initial attachment unless
POLL_FIRST requested ordinary socket readiness. Set NO_LAZY because
one collector task-work enqueue can complete several range requests.
While budget-blocked, the collector still observes errors, urgent data
and EOF, consumes a payload-free FIN, and can execute a DISCARD at its
capture cursor without allocating.

EOF, socket error, urgent data, cancellation, stream close or inability
to post a pressure CQE ends the collector. Cancellation closes its stream
and releases retained undecided data, including cancellation after a
native poll-setup failure. A token is not a recovery promise after
that failure. EOF and socket errors leave retained data available for
pending decisions. The stream token remains until
STREAM_CLOSE or store teardown. The stream retains its socket file.

Capture takes stream->lock, then the socket lock, then wait_lock.
Attachment takes the socket lock before tables and sk_callback_lock;
no table holder waits for the socket lock.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 include/linux/poll.h          |   3 +
 include/uapi/linux/io_uring.h |   1 +
 io_uring/opaque.c             | 599 +++++++++++++++++++++++++++++++++-
 io_uring/opaque.h             |   6 +
 io_uring/opaque_internal.h    |   3 +
 io_uring/opdef.c              |  18 +
 io_uring/poll.c               |  58 +++-
 7 files changed, 680 insertions(+), 8 deletions(-)

diff --git a/include/linux/poll.h b/include/linux/poll.h
index 12bb18e8b978..b2a85a503fd9 100644
--- a/include/linux/poll.h
+++ b/include/linux/poll.h
@@ -12,6 +12,9 @@
 #include <uapi/linux/poll.h>
 #include <uapi/linux/eventpoll.h>
 
+/* Wake-only receive-owner notification, not file readiness or a UAPI event. */
+#define POLL_RX_OWNER	((__force __poll_t)(1U << 26))
+
 /* ~832 bytes of stack space used max in sys_select/sys_poll before allocating
    additional memory. */
 #define MAX_STACK_ALLOC 832
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index 1759f4f805b1..6469ab391eec 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -322,6 +322,7 @@ enum io_uring_op {
 	IORING_OP_URING_CMD128,
 	IORING_OP_OPAQUE_OBJ,
 	IORING_OP_OPAQUE_OBJ_SEND,
+	IORING_OP_OPAQUE_COLLECT,
 
 	/* this goes last, obviously */
 	IORING_OP_LAST,
diff --git a/io_uring/opaque.c b/io_uring/opaque.c
index 0c58900073f7..4610e212a800 100644
--- a/io_uring/opaque.c
+++ b/io_uring/opaque.c
@@ -8,6 +8,7 @@
 #include <linux/overflow.h>
 #include <linux/rbtree.h>
 #include <linux/sched/mm.h>
+#include <linux/security.h>
 #include <linux/skbuff.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
@@ -49,6 +50,38 @@ static void io_opaque_vec_cleanup(struct io_opaque_req *op);
 static void io_opaque_stream_close(struct io_opaque_stream *stream);
 static void io_opaque_tx_put(struct io_opaque_req *op);
 
+/*
+ * Publish before waking; native poll enrolls before reading collect_ready.
+ * This is not TCP readiness: only COLLECT and receive-owner-affected apoll
+ * recheck their predicates. Ordinary poll and output apoll ignore the key.
+ */
+static void io_opaque_collect_wake(struct io_opaque_stream *stream)
+{
+	struct socket *sock = sock_from_file(stream->file);
+
+	atomic_set(&stream->collect_ready, 1);
+	wake_up_interruptible_poll(sk_sleep(sock->sk), POLL_RX_OWNER);
+}
+
+static void io_opaque_data_ready(struct sock *sk, void *data)
+{
+	struct io_opaque_stream *stream = data;
+
+	/* sk_callback_lock pins stream; do not take stream or socket locks here. */
+	atomic_set(&stream->collect_ready, 1);
+	wake_up_interruptible_poll(sk_sleep(sk), POLL_RX_OWNER);
+}
+
+__poll_t io_opaque_collect_poll(struct io_kiocb *req)
+{
+	struct io_opaque_req *op = req->async_data;
+
+	/* io-wq may poll before the first issue, including a trailing link. */
+	if (!op->stream)
+		return op->collect_flags & IORING_RECVSEND_POLL_FIRST ? 0 : EPOLLIN;
+	return atomic_read(&op->stream->collect_ready) ? EPOLLIN : 0;
+}
+
 static bool io_opaque_budget_ready(struct io_opaque_req *op, unsigned long now)
 {
 	struct io_opaque_store *store = op->store;
@@ -103,8 +136,6 @@ static bool io_opaque_wake_budget(struct io_opaque_store *store)
 	guard(spinlock)(&store->wait_lock);
 	stopped = READ_ONCE(store->dead);
 	list_for_each_entry_safe(op, next, &store->budget_waits, wait) {
-		struct socket *sock = sock_from_file(op->req->file);
-
 		if (!stopped && !READ_ONCE(op->stream->closed)) {
 			if (time_before(now, op->retry_at)) {
 				delay = min(delay, op->retry_at - now);
@@ -122,7 +153,7 @@ static bool io_opaque_wake_budget(struct io_opaque_store *store)
 		/* A wake is not a reservation; the collector rechecks on entry. */
 		woken++;
 		/* Native multishot polling also observes FIN, RST and urgent data. */
-		wake_up_interruptible_poll(sk_sleep(sock->sk), EPOLLIN);
+		io_opaque_collect_wake(op->stream);
 	}
 	if (!stopped && delay != MAX_JIFFY_OFFSET)
 		queue_delayed_work(system_dfl_wq, &store->retry_work, delay);
@@ -147,7 +178,6 @@ static void io_opaque_retry_work(struct work_struct *work)
 static void io_opaque_wake_stream(struct io_opaque_stream *stream)
 {
 	struct io_opaque_req *op = stream->collector;
-	struct socket *sock = sock_from_file(stream->file);
 
 	lockdep_assert_held(&stream->lock);
 	if (!op)
@@ -158,7 +188,7 @@ static void io_opaque_wake_stream(struct io_opaque_stream *stream)
 			return;
 		list_del_init(&op->wait);
 	}
-	wake_up_interruptible_poll(sk_sleep(sock->sk), EPOLLIN);
+	io_opaque_collect_wake(stream);
 }
 
 int io_opaque_memory_mode(struct io_opaque_store *store)
@@ -1158,6 +1188,269 @@ static void io_opaque_stream_process(struct io_opaque_stream *stream)
 	}
 }
 
+/* Only the earliest undecided range is consulted on the capture hot path. */
+static struct io_opaque_req *io_opaque_next_decision(struct io_opaque_stream *stream)
+{
+	struct rb_node *node = rb_first_cached(&stream->decisions);
+
+	return node ? rb_entry(node, struct io_opaque_req, decision) : NULL;
+}
+
+/* Undecided bytes are collected only when nothing is pending or a request needs later bytes. */
+static bool io_opaque_collect_demand(struct io_opaque_stream *stream)
+{
+	struct io_opaque_req *op = io_opaque_next_decision(stream);
+
+	lockdep_assert_held(&stream->lock);
+	return !stream->undecided || !list_empty(&stream->reads) ||
+	       (op && op->offset > stream->next);
+}
+
+static struct io_opaque_req *io_opaque_capture_keep(struct io_opaque_stream *stream)
+{
+	struct io_opaque_req *op = io_opaque_next_decision(stream);
+
+	if (op && op->op == IORING_OPAQUE_RECV_OBJECT && stream->next >= op->offset &&
+	    stream->next < op->offset + op->length)
+		return op;
+	return NULL;
+}
+
+static struct io_opaque_extent *io_opaque_capture_tail(struct io_opaque_stream *stream)
+{
+	struct io_opaque_req *op = io_opaque_capture_keep(stream);
+	struct list_head *list = op ? &op->data->extents : &stream->extents;
+
+	return list_last_entry_or_null(list, struct io_opaque_extent, list);
+}
+
+static int io_opaque_append(struct io_opaque_stream *stream, struct page *page,
+			    u32 offset, u32 length, bool take_ref, bool copied)
+{
+	struct io_opaque_req *op = io_opaque_capture_keep(stream);
+	struct list_head *list = &stream->extents;
+	struct io_opaque_extent *extent, *tail;
+	u64 start = stream->next;
+	bool new_backing = false;
+
+	if (op) {
+		list = &op->data->extents;
+		start -= op->offset;
+	}
+	tail = list_last_entry_or_null(list, struct io_opaque_extent, list);
+	offset += (page - compound_head(page)) * PAGE_SIZE;
+	page = compound_head(page);
+	if (tail && tail->backing->page == page) {
+		if (tail->start + tail->length == start &&
+		    tail->offset + tail->length == offset) {
+			tail->length += length;
+			extent = tail;
+			goto accounted;
+		}
+	}
+	stream->need_bytes = page_size(page);
+	if (atomic_read(&stream->store->extents) >= stream->store->config.max_extents - 2)
+		return -ENOBUFS;
+	if (tail && tail->backing->page == page) {
+		if (!io_opaque_extent_reserve(stream->store))
+			return -ENOBUFS;
+		extent = kmalloc_obj(*extent, GFP_KERNEL_ACCOUNT);
+		if (!extent) {
+			io_opaque_extent_unreserve(stream->store, 0);
+			return -ENOMEM;
+		}
+		*extent = (struct io_opaque_extent) {
+			.backing = tail->backing, .start = start,
+			.offset = offset, .length = length,
+		};
+		refcount_inc(&extent->backing->refs);
+	} else {
+		u64 left = op ? ALIGN(op->length - op->progress - length, PAGE_SIZE) : 0;
+
+		/* Leave room for dense copies of a private KEEP's remaining bytes. */
+		if (!copied && op && op->data->charge + stream->need_bytes + left >
+		    io_opaque_rx_limit(stream->store))
+			return -ENOBUFS;
+		extent = io_opaque_extent_new(stream->store, page, offset, length, start, copied);
+		if (IS_ERR(extent))
+			return PTR_ERR(extent);
+		if (take_ref)
+			get_page(page);
+		extent->backing->copied = copied;
+		new_backing = true;
+	}
+	list_add_tail(&extent->list, list);
+accounted:
+	if (op) {
+		op->progress += length;
+		op->data->length += length;
+		if (new_backing)
+			op->data->charge += extent->backing->charge;
+	} else {
+		stream->undecided += length;
+	}
+	if (copied) {
+		extent->backing->filled = offset + length;
+		atomic64_add(length, &stream->store->copied);
+	}
+	return length;
+}
+
+static int io_opaque_capture(struct io_opaque_stream *stream,
+			     const struct sk_buff *skb, u32 offset, u32 len,
+			     bool shared)
+{
+	u32 consumed = 0, head = skb_headlen(skb), start = head;
+	bool copy_frags;
+	struct sk_buff *child;
+	u64 retain_limit = io_opaque_rx_limit(stream->store);
+	u32 chunk;
+	int i, ret = -EFAULT;
+
+	shared |= skb_shared(skb);
+	copy_frags = shared || skb_cloned(skb) || skb_has_shared_frag(skb);
+	if (!skb_frags_readable(skb))
+		return -EIO;
+	if (offset < head) {
+		chunk = min(head - offset, len);
+		if (!shared && !skb_head_is_locked(skb)) {
+			void *data = skb->data + offset;
+			struct page *page = virt_to_page(data);
+
+			/* A compound allocation larger than the limit can never fit. */
+			if (page_size(compound_head(page)) > retain_limit)
+				goto copy;
+			ret = io_opaque_append(stream, page, offset_in_page(data),
+					       chunk, true, false);
+		} else {
+			goto copy;
+		}
+		if (ret == -ENOBUFS)
+			goto copy;
+		goto head_done;
+	}
+	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
+		const skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
+		u32 size = skb_frag_size(frag);
+
+		if (offset >= start + size) {
+			start += size;
+			continue;
+		}
+		chunk = min(start + size - offset, len);
+		if (copy_frags || page_size(compound_head(skb_frag_page(frag))) > retain_limit)
+			goto copy;
+		ret = io_opaque_append(stream, skb_frag_page(frag),
+				       skb_frag_off(frag) + offset - start, chunk, true, false);
+		if (ret == -ENOBUFS)
+			goto copy;
+		goto head_done;
+	}
+	skb_walk_frags(skb, child) {
+		if (offset >= start + child->len) {
+			start += child->len;
+			continue;
+		}
+		return io_opaque_capture(stream, child, offset - start,
+					 min(start + child->len - offset, len), copy_frags);
+	}
+	return -EFAULT;
+copy:
+	{
+		struct io_opaque_extent *tail = io_opaque_capture_tail(stream);
+		struct page *page;
+		u32 pos = 0;
+		bool allocated = true;
+		void *mapped;
+
+		if (tail && tail->backing->copied && tail->backing->filled < PAGE_SIZE &&
+		    tail->offset + tail->length == tail->backing->filled) {
+			page = tail->backing->page;
+			pos = tail->backing->filled;
+			allocated = false;
+		} else {
+			stream->need_bytes = PAGE_SIZE;
+			if (!io_opaque_charge(stream->store, PAGE_SIZE, true))
+				return -ENOBUFS;
+			page = alloc_page(GFP_KERNEL_ACCOUNT);
+			if (!page) {
+				io_opaque_uncharge(stream->store, PAGE_SIZE);
+				return -ENOMEM;
+			}
+		}
+		chunk = min_t(u32, chunk, PAGE_SIZE - pos);
+		mapped = kmap_local_page(page);
+		ret = skb_copy_bits(skb, offset, mapped + pos, chunk);
+		kunmap_local(mapped);
+		if (!ret)
+			ret = io_opaque_append(stream, page, pos, chunk, false, true);
+		if (ret < 0 && allocated) {
+			put_page(page);
+			io_opaque_uncharge(stream->store, PAGE_SIZE);
+		}
+	}
+head_done:
+	if (ret > 0)
+		consumed += ret;
+	return consumed ?: ret;
+}
+
+static int io_opaque_actor(read_descriptor_t *desc, struct sk_buff *skb,
+			   unsigned int offset, size_t length)
+{
+	struct io_opaque_stream *stream = desc->arg.data;
+	u32 consumed = 0;
+	int ret = 0;
+
+	/* The first capture error ends the pass; later bytes wait for the next one. */
+	if (desc->error)
+		return 0;
+	length = min(length, desc->count);
+	length = min_t(u64, length, U64_MAX - stream->next);
+	while (length) {
+		struct io_opaque_req *op = io_opaque_next_decision(stream);
+		u32 chunk = length;
+
+		if (op && stream->next >= op->offset) {
+			chunk = min_t(u64, chunk, op->offset + op->length - stream->next);
+			if (op->op == IORING_OPAQUE_DISCARD) {
+				op->progress += chunk;
+				ret = chunk;
+				goto consumed;
+			}
+		} else {
+			/*
+			 * Undecided bytes stay on the socket until someone asks for them.
+			 * A decision further in the stream asks for the gap before it,
+			 * including one that became the earliest during this pass.
+			 */
+			if (stream->hold_undecided && !op)
+				break;
+			if (op)
+				chunk = min_t(u64, chunk, op->offset - stream->next);
+		}
+		ret = io_opaque_capture(stream, skb, offset, chunk, false);
+		if (ret <= 0) {
+			desc->error = ret;
+			break;
+		}
+consumed:
+		stream->next += ret;
+		consumed += ret;
+		offset += ret;
+		length -= ret;
+		desc->count -= ret;
+		if (op && op->progress == op->length) {
+			rb_erase_cached(&op->decision, &stream->decisions);
+			RB_CLEAR_NODE(&op->decision);
+			io_opaque_queue_ready(op, op->length);
+		}
+	}
+	if (!length && stream->next == U64_MAX)
+		stream->error = -EOVERFLOW;
+	return consumed ?: ret;
+}
+
 static void io_opaque_stream_close(struct io_opaque_stream *stream)
 {
 	struct socket *sock = sock_from_file(stream->file);
@@ -1174,10 +1467,299 @@ static void io_opaque_stream_close(struct io_opaque_stream *stream)
 	io_opaque_extents_free(stream->store, &stream->extents);
 	stream->undecided = 0;
 	io_opaque_stream_process(stream);
-	wake_up_interruptible_poll(sk_sleep(sock->sk), EPOLLIN);
+	io_opaque_collect_wake(stream);
 	io_opaque_wake_budget(stream->store);
 }
 
+int io_opaque_recv_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
+{
+	struct io_opaque_store *store = xa_load(&req->ctx->opaque_stores,
+						READ_ONCE(sqe->opaque_store_id));
+	struct io_opaque_req *op;
+	u16 flags = READ_ONCE(sqe->ioprio);
+
+	if (!store)
+		return -ENXIO;
+	if (READ_ONCE(sqe->addr) || READ_ONCE(sqe->off) || READ_ONCE(sqe->addr3) ||
+	    READ_ONCE(sqe->len) || READ_ONCE(sqe->msg_flags) ||
+	    READ_ONCE(sqe->buf_index) || READ_ONCE(sqe->__pad2[0]) ||
+	    (flags & ~IORING_RECVSEND_POLL_FIRST) ||
+	    (req->flags & (REQ_F_CQE_SKIP | REQ_F_FORCE_ASYNC)))
+		return -EINVAL;
+	op = io_opaque_req_alloc(req, store);
+	if (IS_ERR(op))
+		return PTR_ERR(op);
+	op->op = U16_MAX - 1;
+	op->collect_flags = flags;
+	/* One native poll task-work enqueue may produce several range CQEs. */
+	req->flags |= REQ_F_APOLL_MULTISHOT | REQ_F_POLL_NO_LAZY;
+	return 0;
+}
+
+/*
+ * Make @op the collector of its socket. The socket is taken before tables,
+ * which is the order a send admits in, with the socket owned. Nothing may wait
+ * for a socket lock while it holds tables.
+ */
+static int io_opaque_attach(struct io_opaque_req *op)
+{
+	struct io_opaque_store *store = op->store;
+	struct io_opaque_stream *stream;
+	struct socket *sock = sock_from_file(op->req->file);
+	struct msghdr msg = { .msg_flags = MSG_DONTWAIT };
+	struct io_uring_cqe cqe[2] = {};
+	u32 i;
+	int ret;
+
+	if (!sock || sock->type != SOCK_STREAM || sock->sk->sk_protocol != IPPROTO_TCP)
+		return -EOPNOTSUPP;
+	/* Authorize the collector's lifetime before taking the socket lock. */
+	ret = security_socket_recvmsg(sock, &msg, 0, MSG_DONTWAIT);
+	if (ret)
+		return ret;
+	stream = kzalloc_obj(*stream, GFP_KERNEL_ACCOUNT);
+	if (!stream)
+		return -ENOMEM;
+	refcount_set(&stream->refs, 1);
+	atomic_set(&stream->collect_ready, 0);
+	mutex_init(&stream->lock);
+	INIT_LIST_HEAD(&stream->extents);
+	INIT_LIST_HEAD(&stream->reads);
+	stream->decisions = RB_ROOT_CACHED;
+	stream->store = store;
+	stream->file = get_file(op->req->file);
+	stream->owner.actor = io_opaque_actor;
+	stream->owner.data = stream;
+	stream->owner.data_ready = io_opaque_data_ready;
+	stream->collector = op;
+	lock_sock(sock->sk);
+	mutex_lock(&store->tables);
+	if (sock->sk->sk_rx_owner || sock->sk->sk_prot != sock->sk->sk_prot_creator ||
+	    tcp_sk(sock->sk)->repair || tcp_sk(sock->sk)->urg_data) {
+		ret = -EBUSY;
+		goto unlock;
+	}
+	if (sock->sk->sk_state != TCP_ESTABLISHED && sock->sk->sk_state != TCP_CLOSE_WAIT) {
+		ret = -ENOTCONN;
+		goto unlock;
+	}
+	ret = -ENOSPC;
+	for (;;) {
+		struct io_opaque_stream_slot *slot;
+
+		i = io_opaque_find_slot(store->stream_used, store->config.max_streams,
+					&store->stream_cursor);
+		if (i >= store->config.max_streams)
+			break;
+		slot = &store->streams[i];
+		if (slot->generation == IO_OPAQUE_GENERATION_MAX) {
+			__set_bit(i, store->stream_used);
+			continue;
+		}
+		write_lock_bh(&sock->sk->sk_callback_lock);
+		if (sock->sk->sk_user_data) {
+			write_unlock_bh(&sock->sk->sk_callback_lock);
+			ret = -EBUSY;
+			break;
+		}
+		slot->generation++;
+		stream->token = io_opaque_handle(i, slot->generation) | IO_OPAQUE_TOKEN_TAG;
+		cqe[0].user_data = op->req->cqe.user_data;
+		cqe[0].flags = IORING_CQE_F_MORE | ctx_cqe32_flags(op->req->ctx);
+		memcpy(&cqe[1], &stream->token, sizeof(stream->token));
+		if (!io_req_post_cqe32(op->req, cqe)) {
+			write_unlock_bh(&sock->sk->sk_callback_lock);
+			ret = -ENOSPC;
+			break;
+		}
+		WRITE_ONCE(sock->sk->sk_rx_owner, &stream->owner);
+		write_unlock_bh(&sock->sk->sk_callback_lock);
+		slot->stream = stream;
+		__set_bit(i, store->stream_used);
+		store->nr_streams++;
+		refcount_inc(&stream->refs);
+		op->stream = stream;
+		ret = 0;
+		break;
+	}
+unlock:
+	mutex_unlock(&store->tables);
+	release_sock(sock->sk);
+	/* Ownership publication is not an ordinary TCP readiness event either. */
+	if (!ret)
+		wake_up_interruptible_poll(sk_sleep(sock->sk), POLL_RX_OWNER);
+	if (ret)
+		io_opaque_stream_put(stream);
+	return ret;
+}
+
+/* Report a budget stall once per unread offset, without ending collection. */
+static int io_opaque_budget_cqe(struct io_opaque_req *op)
+{
+	struct io_opaque_stream *stream = op->stream;
+	struct io_uring_cqe cqe[2] = {};
+	u64 extra[2] = { stream->token, stream->next };
+
+	if (op->budget_reported && op->offset == stream->next)
+		return 0;
+	cqe[0].res = -ENOBUFS;
+	cqe[0].flags = IORING_CQE_F_MORE | ctx_cqe32_flags(op->req->ctx);
+	memcpy(&cqe[1], extra, sizeof(extra));
+	if (!io_req_post_cqe32(op->req, cqe))
+		return -ENOSPC;
+	op->budget_reported = true;
+	op->offset = stream->next;
+	return 0;
+}
+
+static void io_opaque_budget_wait(struct io_opaque_req *op, int error)
+{
+	lockdep_assert_held(&op->stream->lock);
+	scoped_guard(spinlock, &op->store->wait_lock) {
+		op->need_bytes = error == -ENOMEM ? 0 : op->stream->need_bytes;
+		if (error == -ENOMEM && !time_before(jiffies, op->retry_at))
+			op->retry_at = jiffies + msecs_to_jiffies(IO_OPAQUE_ALLOC_RETRY_MS);
+		else if (error == -ENOBUFS)
+			op->retry_at = jiffies;
+		op->phase = IO_OPAQUE_BUDGET_POLL;
+		list_add_tail(&op->wait, &op->store->budget_waits);
+	}
+	/* Recheck after enrollment to close the release/enrollment race. */
+	io_opaque_wake_budget(op->store);
+}
+
+int io_opaque_recv(struct io_kiocb *req, unsigned int issue_flags)
+{
+	struct io_opaque_req *op = req->async_data;
+	struct io_opaque_stream *stream;
+	struct socket *sock = sock_from_file(req->file);
+	read_descriptor_t desc = { .count = IO_OPAQUE_RX_BATCH };
+	struct mem_cgroup *old;
+	bool blocked;
+	int ret;
+
+	io_ring_submit_lock(req->ctx, issue_flags);
+	if (!(req->flags & REQ_F_POLLED) &&
+	    (op->collect_flags & IORING_RECVSEND_POLL_FIRST)) {
+		ret = -EAGAIN;
+		goto out;
+	}
+	if (!op->stream && (issue_flags & IO_URING_F_UNLOCKED)) {
+		io_req_task_queue(req);
+		ret = IOU_ISSUE_SKIP_COMPLETE;
+		goto out;
+	}
+	if (!op->stream) {
+		ret = io_opaque_attach(op);
+		if (ret)
+			goto out;
+	}
+	stream = op->stream;
+	mutex_lock(&stream->lock);
+	/* A concurrent data wake after this exchange belongs to the next pass. */
+	atomic_xchg(&stream->collect_ready, 0);
+	if (stream->closed || READ_ONCE(op->store->dead)) {
+		ret = -ECANCELED;
+		goto unlock_stream;
+	}
+	scoped_guard(spinlock, &op->store->wait_lock) {
+		blocked = io_opaque_collect_blocked(op);
+		if (blocked) {
+			/* Capacity may have been taken since the wake removed us. */
+			if (list_empty(&op->wait))
+				list_add_tail(&op->wait, &op->store->budget_waits);
+		} else {
+			list_del_init(&op->wait);
+			op->phase = IO_OPAQUE_IDLE;
+		}
+	}
+	desc.arg.data = stream;
+	old = set_active_memcg(op->store->memcg);
+	if (!blocked) {
+		/* Retained prefixes precede bytes captured directly into a TAKE. */
+		io_opaque_stream_process(stream);
+		stream->hold_undecided = !io_opaque_collect_demand(stream);
+	}
+	lock_sock(sock->sk);
+	if (tcp_sk(sock->sk)->urg_data) {
+		ret = -EOPNOTSUPP;
+	} else if (blocked) {
+		ret = 0;
+		if (sock->sk->sk_shutdown & RCV_SHUTDOWN) {
+			/* Consume a FIN-only skb, never payload, while out of budget. */
+			desc.count = 0;
+			ret = tcp_read_sock(sock->sk, &desc, io_opaque_actor);
+		}
+	} else {
+		ret = tcp_read_sock(sock->sk, &desc, io_opaque_actor);
+	}
+	if (desc.error)
+		ret = desc.error;
+	if (sock->sk->sk_err)
+		stream->error = sock_error(sock->sk);
+	if ((sock->sk->sk_shutdown & RCV_SHUTDOWN) &&
+	    skb_queue_empty(&sock->sk->sk_receive_queue))
+		stream->eof = true;
+	release_sock(sock->sk);
+	set_active_memcg(old);
+	if (ret < 0 && ret != -ENOBUFS && ret != -ENOMEM)
+		stream->error = ret;
+	if (blocked && !stream->error && !stream->eof) {
+		/* Close release/reenrollment races without retrying TCP capture. */
+		io_opaque_wake_budget(op->store);
+		ret = IOU_RETRY;
+		goto unlock_stream;
+	}
+	if (blocked) {
+		guard(spinlock)(&op->store->wait_lock);
+
+		list_del_init(&op->wait);
+		op->phase = IO_OPAQUE_IDLE;
+	}
+	io_opaque_stream_process(stream);
+	if (ret == -ENOBUFS) {
+		struct io_opaque_req *keep = io_opaque_capture_keep(stream);
+
+		/* A private prefix must not pin quota indefinitely awaiting itself. */
+		if (keep && keep->progress) {
+			rb_erase_cached(&keep->decision, &stream->decisions);
+			RB_CLEAR_NODE(&keep->decision);
+			io_opaque_restore(keep);
+			io_opaque_queue_ready(keep, -ENOBUFS);
+		}
+	}
+	if (ret == -ENOBUFS && !stream->error && !stream->eof) {
+		int err = io_opaque_budget_cqe(op);
+
+		if (err) {
+			/* Retain the token and captured prefix for explicit recovery. */
+			stream->error = err;
+			io_opaque_stream_process(stream);
+		}
+	}
+	if (stream->error || stream->eof) {
+		ret = stream->error;
+	} else if (ret == -ENOBUFS || ret == -ENOMEM) {
+		io_opaque_budget_wait(op, ret);
+		ret = IOU_RETRY;
+	} else if (!desc.count) {
+		/* Also retain the next pass when the initial issue exhausts a batch. */
+		atomic_set(&stream->collect_ready, 1);
+		ret = issue_flags & IO_URING_F_MULTISHOT ? IOU_REQUEUE : IOU_RETRY;
+	} else {
+		ret = IOU_RETRY;
+	}
+unlock_stream:
+	mutex_unlock(&stream->lock);
+out:
+	if (ret >= 0 && ret != IOU_ISSUE_SKIP_COMPLETE) {
+		io_req_set_res(req, ret, 0);
+		ret = IOU_COMPLETE;
+	}
+	io_ring_submit_unlock(req->ctx, issue_flags);
+	return ret;
+}
+
 static int io_opaque_copy(struct io_opaque_data *data, u64 off, u32 length,
 			  void __user *dest)
 {
@@ -1679,6 +2261,11 @@ void io_opaque_cleanup(struct io_kiocb *req)
 		}
 		if (op->stream->collector == op) {
 			op->stream->collector = NULL;
+			/*
+			 * Native poll setup failure may cancel COLLECT too. As for
+			 * explicit cancellation, closing discards undecided capture;
+			 * a token is not a promise of recovery after this failure.
+			 */
 			close = !op->stream->eof && !op->stream->closed && !op->stream->error;
 		}
 		mutex_unlock(&op->stream->lock);
diff --git a/io_uring/opaque.h b/io_uring/opaque.h
index a7210f4bee5e..4001a4484ff9 100644
--- a/io_uring/opaque.h
+++ b/io_uring/opaque.h
@@ -102,6 +102,7 @@ void io_opaque_stop(struct io_opaque_store *store);
 void io_opaque_free(struct io_opaque_store *store);
 int io_opaque_recv_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe);
 int io_opaque_recv(struct io_kiocb *req, unsigned int issue_flags);
+__poll_t io_opaque_collect_poll(struct io_kiocb *req);
 int io_opaque_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe);
 int io_opaque_issue(struct io_kiocb *req, unsigned int issue_flags);
 int io_opaque_send_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe);
@@ -113,6 +114,11 @@ int io_opaque_cancel(struct io_ring_ctx *ctx, struct io_cancel_data *cd,
 bool io_opaque_cancel_all(struct io_ring_ctx *ctx, struct io_uring_task *tctx,
 			  bool cancel_all);
 #else
+static inline __poll_t io_opaque_collect_poll(struct io_kiocb *req)
+{
+	return 0;
+}
+
 static inline bool io_opaque_cache_init(struct io_ring_ctx *ctx)
 {
 	return false;
diff --git a/io_uring/opaque_internal.h b/io_uring/opaque_internal.h
index f6b372800c76..2d5f69ee8925 100644
--- a/io_uring/opaque_internal.h
+++ b/io_uring/opaque_internal.h
@@ -2,6 +2,7 @@
 #ifndef IO_URING_OPAQUE_INTERNAL_H
 #define IO_URING_OPAQUE_INTERNAL_H
 
+#include <linux/atomic.h>
 #include <linux/bitmap.h>
 #include <linux/bvec.h>
 #include <linux/net.h>
@@ -148,6 +149,8 @@ struct io_opaque_vec {
 
 struct io_opaque_stream {
 	refcount_t refs;
+	/* Consumed only on entry to a collector pass, never by native poll. */
+	atomic_t collect_ready;
 	/* Extents, range decisions and collector state. */
 	struct mutex lock;
 	struct io_opaque_store *store;
diff --git a/io_uring/opdef.c b/io_uring/opdef.c
index a80a56b19581..628f908a66ad 100644
--- a/io_uring/opdef.c
+++ b/io_uring/opdef.c
@@ -592,6 +592,20 @@ const struct io_issue_def io_issue_defs[] = {
 		.prep			= io_uring_cmd_prep,
 		.issue			= io_uring_cmd,
 	},
+	[IORING_OP_OPAQUE_COLLECT] = {
+		.audit_skip		= 1,
+		.ioprio			= 1,
+		.needs_file		= 1,
+		.unbound_nonreg_file	= 1,
+		.pollin			= 1,
+#ifdef CONFIG_IO_URING_OPAQUE_OBJ
+		.async_size		= sizeof(struct io_opaque_req),
+		.prep			= io_opaque_recv_prep,
+		.issue			= io_opaque_recv,
+#else
+		.prep			= io_eopnotsupp_prep,
+#endif
+	},
 	[IORING_OP_OPAQUE_OBJ] = {
 		.audit_skip		= 1,
 		.ioprio			= 1,
@@ -875,6 +889,10 @@ const struct io_cold_def io_cold_defs[] = {
 		.sqe_copy		= io_uring_cmd_sqe_copy,
 		.cleanup		= io_uring_cmd_cleanup,
 	},
+	[IORING_OP_OPAQUE_COLLECT] = {
+		.name			= "OPAQUE_COLLECT",
+		.cleanup		= io_opaque_cleanup,
+	},
 	[IORING_OP_OPAQUE_OBJ] = {
 		.name			= "OPAQUE_OBJ",
 		.cleanup		= io_opaque_cleanup,
diff --git a/io_uring/poll.c b/io_uring/poll.c
index 4f04bda42f7f..25a202f3f3ae 100644
--- a/io_uring/poll.c
+++ b/io_uring/poll.c
@@ -9,6 +9,10 @@
 #include <linux/hashtable.h>
 #include <linux/io_uring.h>
 
+#ifdef CONFIG_SOCK_RX_OWNER
+#include <net/sock.h>
+#endif
+
 #include <trace/events/io_uring.h>
 
 #include <uapi/linux/io_uring.h>
@@ -21,6 +25,7 @@
 #include "kbuf.h"
 #include "poll.h"
 #include "cancel.h"
+#include "opaque.h"
 
 struct io_poll_update {
 	struct file			*file;
@@ -41,6 +46,47 @@ struct io_poll_table {
 	__poll_t result_mask;
 };
 
+static bool io_poll_rx_owned(struct io_kiocb *req)
+{
+#ifdef CONFIG_SOCK_RX_OWNER
+	struct socket *sock;
+
+	/* Error-queue receives do not encounter the payload-owner refusal. */
+	if (req->flags & REQ_F_CLEAR_POLLIN)
+		return false;
+	switch (req->opcode) {
+	case IORING_OP_READ:
+	case IORING_OP_READV:
+	case IORING_OP_READ_FIXED:
+	case IORING_OP_READV_FIXED:
+	case IORING_OP_READ_MULTISHOT:
+	case IORING_OP_RECV:
+	case IORING_OP_RECVMSG:
+	case IORING_OP_RECV_ZC:
+		break;
+	default:
+		return false;
+	}
+	sock = sock_from_file(req->file);
+	return sock && sock->sk && sock_rx_owned(sock->sk);
+#else
+	return false;
+#endif
+}
+
+static __poll_t io_poll_mask(struct io_kiocb *req, struct poll_table_struct *pt)
+{
+	/* Enroll before checking persistent readiness: a later change must wake us. */
+	__poll_t mask = vfs_poll(req->file, pt);
+
+	if (req->opcode == IORING_OP_OPAQUE_COLLECT)
+		mask |= io_opaque_collect_poll(req);
+	else if (io_poll_rx_owned(req))
+		/* A coalesced claim wake must still issue the real receive handler. */
+		mask |= EPOLLIN | EPOLLRDNORM;
+	return mask;
+}
+
 #define IO_POLL_CANCEL_FLAG	BIT(31)
 #define IO_POLL_RETRY_FLAG	BIT(30)
 #define IO_POLL_REF_MASK	GENMASK(29, 0)
@@ -283,7 +329,7 @@ static int io_poll_check_events(struct io_kiocb *req, io_tw_token_t tw)
 			__poll_t events = req->apoll_events;
 			struct poll_table_struct pt = { ._key = events };
 
-			req->cqe.res = vfs_poll(req->file, &pt) & events;
+			req->cqe.res = io_poll_mask(req, &pt) & events;
 			/*
 			 * We got woken with a mask, but someone else got to
 			 * it first. The above vfs_poll() doesn't add us back
@@ -417,6 +463,14 @@ static int io_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
 	if (unlikely(mask & POLLFREE))
 		return io_pollfree_wake(req, poll);
 
+	if (mask & POLL_RX_OWNER) {
+		if (req->opcode != IORING_OP_OPAQUE_COLLECT &&
+		    !io_poll_rx_owned(req))
+			return 0;
+		/* Recheck current ownership/readiness, never cache a private event. */
+		mask = 0;
+	}
+
 	/* for instances that support it check for an event match first */
 	if (mask && !(mask & (poll->events & ~IO_ASYNC_POLL_COMMON)))
 		return 0;
@@ -597,7 +651,7 @@ static int __io_arm_poll_handler(struct io_kiocb *req,
 	if (poll->events & EPOLLEXCLUSIVE)
 		req->flags |= REQ_F_POLL_NO_LAZY;
 
-	mask = vfs_poll(req->file, &ipt->pt) & poll->events;
+	mask = io_poll_mask(req, &ipt->pt) & poll->events;
 
 	if (unlikely(ipt->error || !ipt->nr_entries)) {
 		io_poll_remove_entries(req);
-- 
2.34.1

