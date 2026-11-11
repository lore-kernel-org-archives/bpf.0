Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794403246;
	b=eHbqWlxLOawJCnrbWCnQ6pjDkUCbgTLX/Px0+xOv80LN0hVbMoQP7YrJZY4l/FU4g6qG
	 uEi4IyFabURRKJ3MDfI74DNrPjkYK6xR/mB5im/fK3XjPEcbIcA1/jT9M2i10ffbsw7b1
	 WIVgqmfrMpSYad5AHuvd832PrXW1hb4wX60DC9oRSKYnqNXIyzUHxUNY/50vIYeureq/Y
	 qacHytk6lr5CruNvB5JD2fE8grpk5JhQ7HLL+pP3BVCdJ0HWV4tJKQaoRvatoOYfssEAc
	 i5PK9kh1DSb0Yr3p1fLWlkzrdf9UWYdVFpyHxpe+JuVN1n5sZAvcDyWn26ujjJV0b3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794403246;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=x7cfP7Jl4pkqSZdOOrEp+EfSUlf9Uxq1lgZkIpGOHBQ=;
	b=1d/chpPNZusBOrmWHCsIsuxCMkb08uxIpYx+KY66oTD7HhB8uied5DJXM7608PXTIpPp
	 2Leohju9z5WFzU06V6/lcJVC0/6i+DviIEoM2WFutymcG6yBhb5ymP0GMyik+o1UhuxIR
	 +4Yv9s69w/yM3DiHQlJT5oh96iCgnu2KdAv1UK8xpKUjIfdWT7M8lcJ8TzCu3xo6x4cX5
	 rRG9Ipkqo6yWM/3vj3crp5B5fQBZoclV8f81jm7lSSp6ohb2uX6T4NH1vQwNxGV9Q9F/K
	 vu0sn3grimLC7GDVprAAWfUhhIu2u5V+4OqGy8szuOgwppR9sINLBqNBerDe7scVeYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="JMPpV/mV";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58E7606A338
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 13:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JMPpV/mV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 945F61F00A06;
	Wed, 11 Nov 2026 13:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794403246;
	bh=x7cfP7Jl4pkqSZdOOrEp+EfSUlf9Uxq1lgZkIpGOHBQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JMPpV/mVPxeq3ZiyYXHU6jk9VysDqGO+xCqCHKrkXo1iy+k1EbW8Is1p+pKEyXCeh
	 Y4HKgZOhEi6HKBu5gObnwu94ICLCtC+p5vJqzxRigPxQTOoTR2w8diia8QzHjgraWi
	 UhxrqjMCb7CGz7qBVB7nyRtcSBkYYnLldAf6pSsE4USGZ6bGXK05Ihp67/9tykwUar
	 oY12fpNn5ZongRvRvojilbd6+84OnUT3wd7emDCn1rE/CJPVvLUaHvLMAUxWNTMDF1
	 +17+2KWZbWj9sSx8z5ajenq9VP+yqgdLdUf2n5U5rk7kDvtXWzz1wVjxgZ7TkyHbKf
	 ngnhMQ3N3WisA==
Message-ID: <sashiko-outbox-209066@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH net-next 09/12] io_uring/opaque: add
 IORING_OP_OPAQUE_COLLECT
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alex Markuze" <amarkuze@redhat.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261110132006.3280986-10-amarkuze@redhat.com>
References: <20261110132006.3280986-1-amarkuze@redhat.com>
 <20261110132006.3280986-10-amarkuze@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 13:20:46 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [High] io_uring/opaque: infinite io-wq/task_work loop in
  io_opaque_recv()
- [Medium] io_uring/opaque: wrong need_bytes in io_opaque_append() on
  tail reuse
- [Medium] io_uring/opaque: stale hold_undecided in io_opaque_actor()
  after decision
- [Medium] io_uring/opaque: POLL_FIRST collector ignores sock_rx_owned()
  in poll
--

commit 8d32c303015f5762780ff1306cc30dacc6d593bb
Author: Alex Markuze <amarkuze@redhat.com>

io_uring/opaque: add IORING_OP_OPAQUE_COLLECT

This commit adds the IORING_OP_OPAQUE_COLLECT multishot operation to attach
a connected TCP socket to an opaque store and capture its receive stream
into decisions or undecided extents using native multishot socket polling.

> diff --git a/io_uring/opaque.c b/io_uring/opaque.c
> index 0c58900073f72..4610e212a8005 100644
> --- a/io_uring/opaque.c
> +++ b/io_uring/opaque.c
> @@ -49,6 +50,38 @@ static void io_opaque_vec_cleanup(struct io_opaque_req=
 *op);
>  static void io_opaque_stream_close(struct io_opaque_stream *stream);
>  static void io_opaque_tx_put(struct io_opaque_req *op);
> =20
> +/*
> + * Publish before waking; native poll enrolls before reading collect_rea=
dy.
> + * This is not TCP readiness: only COLLECT and receive-owner-affected ap=
oll
> + * recheck their predicates. Ordinary poll and output apoll ignore the k=
ey.
> + */
> +static void io_opaque_collect_wake(struct io_opaque_stream *stream)
> +{
> +	struct socket *sock =3D sock_from_file(stream->file);
> +
> +	atomic_set(&stream->collect_ready, 1);
> +	wake_up_interruptible_poll(sk_sleep(sock->sk), POLL_RX_OWNER);
> +}
> +
> +static void io_opaque_data_ready(struct sock *sk, void *data)
> +{
> +	struct io_opaque_stream *stream =3D data;
> +
> +	/* sk_callback_lock pins stream; do not take stream or socket locks her=
e. */
> +	atomic_set(&stream->collect_ready, 1);
> +	wake_up_interruptible_poll(sk_sleep(sk), POLL_RX_OWNER);
> +}
> +
> +__poll_t io_opaque_collect_poll(struct io_kiocb *req)
> +{
> +	struct io_opaque_req *op =3D req->async_data;
> +
> +	/* io-wq may poll before the first issue, including a trailing link. */
> +	if (!op->stream)
> +		return op->collect_flags & IORING_RECVSEND_POLL_FIRST ? 0 : EPOLLIN;
> +	return atomic_read(&op->stream->collect_ready) ? EPOLLIN : 0;
> +}

[Severity: Medium]
When an unattached IORING_OP_OPAQUE_COLLECT request with
IORING_RECVSEND_POLL_FIRST is waiting in apoll, does
io_opaque_collect_poll() need to return EPOLLIN if sock_rx_owned(sock->sk)
is true?

In io_poll_mask(), req->opcode =3D=3D IORING_OP_OPAQUE_COLLECT calls
io_opaque_collect_poll() instead of io_poll_rx_owned().  If another
collector is already attached or attaches to the same socket and wakes
sk_sleep(sock->sk) with POLL_RX_OWNER, io_opaque_collect_poll() returns 0
for the unattached POLL_FIRST collector, so io_poll_check_events() goes
back to sleep when the receive queue is empty instead of issuing
io_opaque_recv() -> io_opaque_attach() and failing with -EBUSY.

[ ... ]

> @@ -1158,6 +1188,269 @@ static void io_opaque_stream_process(struct io_op=
aque_stream *stream)
>  	}
>  }
> =20
> +/* Only the earliest undecided range is consulted on the capture hot pat=
h. */
> +static struct io_opaque_req *io_opaque_next_decision(struct io_opaque_st=
ream *stream)
> +{
> +	struct rb_node *node =3D rb_first_cached(&stream->decisions);
> +
> +	return node ? rb_entry(node, struct io_opaque_req, decision) : NULL;
> +}
> +
> +/* Undecided bytes are collected only when nothing is pending or a reque=
st needs later bytes. */
> +static bool io_opaque_collect_demand(struct io_opaque_stream *stream)
> +{
> +	struct io_opaque_req *op =3D io_opaque_next_decision(stream);
> +
> +	lockdep_assert_held(&stream->lock);
> +	return !stream->undecided || !list_empty(&stream->reads) ||
> +	       (op && op->offset > stream->next);
> +}

[Severity: Medium]
Does setting stream->hold_undecided once per pass from
io_opaque_collect_demand() allow io_opaque_actor() to keep draining
trailing undecided bytes after a pending decision completes?

When a pass starts with a pending decision at op->offset > stream->next,
io_opaque_collect_demand() returns true and sets stream->hold_undecided =3D
false for the entire tcp_read_sock() call, even when stream->reads is empty.
Once io_opaque_actor() captures the gap and finishes that decision (leaving
op =3D=3D NULL and stream->undecided > 0), the "if (stream->hold_undecided =
&&
!op) break;" check in io_opaque_actor() does not stop, so capture continues
pulling up to 256 KiB of undecided bytes off the socket instead of applying
TCP flow control.

> +
> +static struct io_opaque_req *io_opaque_capture_keep(struct io_opaque_str=
eam *stream)
> +{
> +	struct io_opaque_req *op =3D io_opaque_next_decision(stream);
> +
> +	if (op && op->op =3D=3D IORING_OPAQUE_RECV_OBJECT && stream->next >=3D =
op->offset &&
> +	    stream->next < op->offset + op->length)
> +		return op;
> +	return NULL;
> +}
> +
> +static struct io_opaque_extent *io_opaque_capture_tail(struct io_opaque_=
stream *stream)
> +{
> +	struct io_opaque_req *op =3D io_opaque_capture_keep(stream);
> +	struct list_head *list =3D op ? &op->data->extents : &stream->extents;
> +
> +	return list_last_entry_or_null(list, struct io_opaque_extent, list);
> +}
> +
> +static int io_opaque_append(struct io_opaque_stream *stream, struct page=
 *page,
> +			    u32 offset, u32 length, bool take_ref, bool copied)
> +{
> +	struct io_opaque_req *op =3D io_opaque_capture_keep(stream);
> +	struct list_head *list =3D &stream->extents;
> +	struct io_opaque_extent *extent, *tail;
> +	u64 start =3D stream->next;
> +	bool new_backing =3D false;
> +
> +	if (op) {
> +		list =3D &op->data->extents;
> +		start -=3D op->offset;
> +	}
> +	tail =3D list_last_entry_or_null(list, struct io_opaque_extent, list);
> +	offset +=3D (page - compound_head(page)) * PAGE_SIZE;
> +	page =3D compound_head(page);
> +	if (tail && tail->backing->page =3D=3D page) {
> +		if (tail->start + tail->length =3D=3D start &&
> +		    tail->offset + tail->length =3D=3D offset) {
> +			tail->length +=3D length;
> +			extent =3D tail;
> +			goto accounted;
> +		}
> +	}
> +	stream->need_bytes =3D page_size(page);
> +	if (atomic_read(&stream->store->extents) >=3D stream->store->config.max=
_extents - 2)
> +		return -ENOBUFS;
> +	if (tail && tail->backing->page =3D=3D page) {
> +		if (!io_opaque_extent_reserve(stream->store))
> +			return -ENOBUFS;

[Severity: Medium]
Should stream->need_bytes be set to 0 when tail && tail->backing->page =3D=
=3D
page reuses an already-charged backing page and only needs a new extent
slot?

If a stream reuses tail->backing across a non-coalescing boundary (such as
after an intervening IORING_OPAQUE_DISCARD advances stream->next) and hits
the max_extents - 2 limit, io_opaque_append() sets stream->need_bytes =3D
page_size(page) even though no additional byte budget is needed.  If the
store's byte usage is within page_size(page) of io_opaque_rx_limit(store),
io_opaque_budget_ready() will see op->need_bytes > limit - used and keep
the collector stalled in IO_OPAQUE_BUDGET_POLL even after extent slots are
freed; on the zero-copy path in io_opaque_capture(), -ENOBUFS from extent
exhaustion here also falls through to copy: and charges a redundant page.

[ ... ]

> +int io_opaque_recv(struct io_kiocb *req, unsigned int issue_flags)
> +{
> +	struct io_opaque_req *op =3D req->async_data;
> +	struct io_opaque_stream *stream;
> +	struct socket *sock =3D sock_from_file(req->file);
> +	read_descriptor_t desc =3D { .count =3D IO_OPAQUE_RX_BATCH };
> +	struct mem_cgroup *old;
> +	bool blocked;
> +	int ret;
> +
> +	io_ring_submit_lock(req->ctx, issue_flags);
> +	if (!(req->flags & REQ_F_POLLED) &&
> +	    (op->collect_flags & IORING_RECVSEND_POLL_FIRST)) {
> +		ret =3D -EAGAIN;
> +		goto out;
> +	}
> +	if (!op->stream && (issue_flags & IO_URING_F_UNLOCKED)) {
> +		io_req_task_queue(req);
> +		ret =3D IOU_ISSUE_SKIP_COMPLETE;
> +		goto out;
> +	}

[Severity: High]
Can an unattached IORING_OP_OPAQUE_COLLECT request loop forever between
io-wq and task_work when REQ_F_FORCE_ASYNC is set on it after prep?

Although io_opaque_recv_prep() rejects REQ_F_FORCE_ASYNC, if
IORING_OP_OPAQUE_COLLECT is the head of a link chain and a later SQE in the
link sets IOSQE_IO_DRAIN, io_init_drain() sets REQ_F_FORCE_ASYNC on the
head after prep:

io_uring/io_uring.c:io_init_drain() {
	if (head) {
		head->flags |=3D REQ_F_IO_DRAIN | REQ_F_FORCE_ASYNC;
		ctx->int_flags |=3D IO_RING_F_DRAIN_NEXT;
	}
}

When that request runs on a pollable file without O_NONBLOCK or
FMODE_NOWAIT, io_wq_submit_work() calls io_opaque_recv() with
IO_URING_F_UNLOCKED, which calls io_req_task_queue(req) without clearing
REQ_F_FORCE_ASYNC, and io_req_task_submit() sees req->flags &
REQ_F_FORCE_ASYNC and queues the request right back to io-wq in an infinite
loop.  In addition, because socket validation happens later in
io_opaque_attach(), submitting IORING_OP_OPAQUE_COLLECT with
IORING_RECVSEND_POLL_FIRST on a non-pollable non-socket file returns
-EAGAIN here and fails in io-wq with -EBADFD instead of -EOPNOTSUPP.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110132006.3280=
986-1-amarkuze@redhat.com?part=3D9
