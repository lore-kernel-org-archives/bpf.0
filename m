Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794403246;
	b=y8y/nMTv7uaSEN3bNTfQySGN9HIorxB+YBNWO7Kvb9QXijG1wlOb8dC78AVVKAPpGCnM
	 0+Wy7WWGf6A7D/eKwOULwqMShcVhyJGyiFYIO8RMGERtvRI+ZrJ9Obkqk6nXZzIDCXOvR
	 I4DnLRiijmmAdaiAVEQOmPSzNyJqJNkivw6UP4w3SGrvTWX8T0cT3C69CwdiuWE9BFyss
	 yUpm15VdnOt2cpfDQqhmcoMsEDCqEjL7z0nI0h3mt4xHXYwmVo7JsY7DfW6YeQ5xiF3ab
	 G7EBiVBUsFhyz89p3tobX5kIsZxhiM90hjkIgHd7vCweJ21OU+F6i9GZpg94BLQt7kQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794403246;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2tlwZ+EpQu4Son+opdskvX7FxzHXuU4SwvBRitqIaVU=;
	b=X1AhK5tngfZzuHzIyhQLOgDn9TokE71iOZhRL7dIcjlDZrMYz8bgBUvT2EM4KbjWuTGq
	 J2358ToIXmajWKNNJJMxepBnceSRPsWuIxxSy6/L9Cv706a/QY4gtP5grZtbHAtHUmVpy
	 LhG1BA1ci2bfP2Ynxa9OmRZBZHPOKGQ8lTeKe/iJtLX7f5jiliYf/vQ1V9NKwR0mlK6BM
	 5YO63lEDrUTKwTXYNqHI0yKwdLPd96ZU52msc+8pMg6VOrrc2KI60C+tgwiSZDKupL5mU
	 TUe6G49hw4UfHiz5UeDAeG1NnXfWKEVoEWKVOKShvrsbLXrDO67OG4G26Pf6xkqz3zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MKz6Ck5B;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F805606A332
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 13:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MKz6Ck5B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8A101F00A06;
	Wed, 11 Nov 2026 13:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794403246;
	bh=2tlwZ+EpQu4Son+opdskvX7FxzHXuU4SwvBRitqIaVU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MKz6Ck5B2ehIj/y3USUO9bST7dOjfb9f0cBrGrt79GMzbmGZ6PazjNCcyK5Hmf2/k
	 kI6WkTP2sABsGOAjB0ZG6/ZMBdagiYe9Xhe/36B2Cc19nMtmH9c4JHktuDlWGcJhmh
	 pUdhx1pkoqrbmG0z5+i2Z3KRdKmo6hQiH5gAHQE7z47vRjXPIV2II1WxHx/AAw8f4A
	 VV5mnqzTBt7RY/mIS70eoM0aYbvHN59w8yIMTOLs9g1ssYZMaLTyqAIWbNl025yc1j
	 fraLRLeva9+nRA3KEXOFIBXzFL6VtkJXstMUnIZfIRpTutvrQd0GasOlx1l1/VFaqL
	 h7hAHQJPtpXxQ==
Message-ID: <sashiko-outbox-209064@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH net-next 07/12] io_uring/opaque: add
 IORING_OP_OPAQUE_OBJ_SEND
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alex Markuze" <amarkuze@redhat.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261110132006.3280986-8-amarkuze@redhat.com>
References: <20261110132006.3280986-1-amarkuze@redhat.com>
 <20261110132006.3280986-8-amarkuze@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 13:20:45 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] io_uring/opaque: missing IO_URING_F_NONBLOCK check in
  io_opaque_send()
--

commit 1e659b6cd96d02ac2bb983ff5c26c204fe0a5ef3
Author: Alex Markuze <amarkuze@redhat.com>

io_uring/opaque: add IORING_OP_OPAQUE_OBJ_SEND

This commit adds the IORING_OP_OPAQUE_OBJ_SEND operation to send an optional
prefix, an opaque object range, and an optional suffix to a TCP socket with
per-socket FIFO ordering across the store.

> diff --git a/io_uring/opaque.c b/io_uring/opaque.c
> index 81fbf2011446d..b62c4be92fead 100644
> --- a/io_uring/opaque.c
> +++ b/io_uring/opaque.c

[ ... ]

> @@ -1591,9 +1669,858 @@ void io_opaque_cleanup(struct io_kiocb *req)

[ ... ]

> +sent:
> +	if (ret > 0) {
> +		if (body)
> +			op->iter =3D msg.msg_iter;
> +		op->progress +=3D ret;
> +		if (op->progress < op->total_length && !iov_iter_count(&msg.msg_iter))=
 {
> +			/*
> +			 * TCP lets go of the socket while it waits for room, and a
> +			 * protocol may have taken it over by then: ask again.
> +			 */
> +			if (owned && !io_opaque_send_direct(sk)) {
> +				release_sock(sk);
> +				io_ring_submit_lock(req->ctx, issue_flags);
> +				owned =3D false;
> +			}
> +			goto again;
> +		}
> +		if (op->progress < op->total_length && !(req->flags & REQ_F_NOWAIT)) {
> +			ret =3D -EAGAIN;
> +			goto leave;
> +		}
> +	} else if (ret =3D=3D -EAGAIN && (issue_flags & IO_URING_F_NONBLOCK) &&
> +		   !(req->flags & REQ_F_NOWAIT)) {
> +		goto leave;
> +	}

[Severity: Medium]
Should the partial-send check in io_opaque_send() also test
(issue_flags & IO_URING_F_NONBLOCK), matching the ret =3D=3D -EAGAIN branch
right below it?

When io_opaque_send() runs in blocking mode from an io-wq worker
(!(issue_flags & IO_URING_F_NONBLOCK) and !(req->flags & REQ_F_NOWAIT)),
tcp_sendmsg_locked() or sock_sendmsg() can return a partial byte count if
sk_stream_wait_memory() is interrupted by a signal, cancellation, socket
error, or SO_SNDTIMEO after some bytes have already been queued.
Overwriting ret with -EAGAIN and jumping to leave skips the finish path's
io_opaque_tx_put() and io_opaque_send_unpin_cheap() before release_sock(),
and returns -EAGAIN to io_wq_submit_work() while needs_poll is false:

io_uring/io_uring.c:io_wq_submit_work() {
    ...
		if (!needs_poll) {
			if (!(req->flags & REQ_F_IOPOLL))
				break;
    ...
	if (ret)
		io_req_task_queue_fail(req, ret);
}

Because opaque stores require IORING_SETUP_DEFER_TASKRUN, the abandoned
head request stays at the head of tx->requests with tx->failed still false
and its object version pinned until the ring's submitter task runs
task_work cleanup.  Until then, queued followers are not canceled and new
sends to the same socket from other rings sharing the store can still pass
io_opaque_tx_join() and consume IORING_OPAQUE_SEND_LAST handles.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110132006.3280=
986-1-amarkuze@redhat.com?part=3D7
