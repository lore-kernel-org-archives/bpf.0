Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E3629AAFD
	for <bpf@vger.kernel.org>; Fri,  8 May 2026 22:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778278640; cv=none; b=HZFbWDiHcJTgRbZ97wtd8ZIbeR5p6wKJZWaNyzCgXHzDjDV6a6Ncf/uN46LYtaTiiXCousnH5tktf1th+Nd8Kae1D9kLOms2bqyBZACaeDXtDEig8ysEXfAzsUjeHpRHe38vwVnBPXRHVGxR94PH8Kdraa2iYXOEcamaPeCNliM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778278640; c=relaxed/simple;
	bh=yTcFaT8w8BH0jFB+AtOoQxPB/N/3bKI5yx7vpyYPDVs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RtMQiTks9KuFOBZceRecnnCgDv0sVDFqZdtqto32+j23Wh427q+zghdPsMqNBUIUuq6D47E5OMgf3Q/+E6bQatCPoV6YBryzfTIXjZ01y389WJkXm29V6Vt7kTI0Z5h1waslZSidQnZO5sHRTkgirq9KdQErHY4BcxnlaGE/A/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DwJKCr0w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DwJKCr0w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EED64C2BCB0;
	Fri,  8 May 2026 22:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778278640;
	bh=yTcFaT8w8BH0jFB+AtOoQxPB/N/3bKI5yx7vpyYPDVs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=DwJKCr0wJBksya3vCx3SolOQNIlDF6HlT9TTX7prtJYeikNMbetBruged0sUofvlF
	 YQfVdPaXQNGdnEwpn6CGmWWP18/vCaGIuBIbDAS7ZNuez//OUyt0b1qdJIGu0NULxj
	 49X1xmc/rmt5n6ojfRh/cioXkHEPvhP8cWDvczarmS3lAf0G9IcG3PuaUVX1Pxkgzr
	 ZkHLzT76Z+qPvYjfre2VV/cmv3reDQufgLv2lgRx4ClAB61DXmZilVTegJ8C6GCFNy
	 0dsaDZjSuH8VH2OZC0XtjpxUP6Vh8p8GjPButIUhKErCiD2K2p9Scsq05t1AEV/3om
	 509aEqRNOMjJg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 bpf-next 8/8] selftest: bpf: Add test for
 BPF_SOCK_OPS_RCVLOWAT_CB.
Reply-To: sashiko@lists.linux.dev
To: "Kuniyuki Iwashima" <kuniyu@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260508073355.3916746-9-kuniyu@google.com>
References: <20260508073355.3916746-9-kuniyu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 22:17:19 +0000
Message-Id: <20260508221719.EED64C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Flaky test design due to race condition between send() and epoll=
_wait()/getsockopt().
- [Medium] Pipelined data causes a TOCTOU race that permanently breaks and =
disables the BPF autolowat program.
--

commit 7be0b88b0617982ff63886ecdcf680fd3a6f0db8
Author: Kuniyuki Iwashima <kuniyu@google.com>

selftest: bpf: Add test for BPF_SOCK_OPS_RCVLOWAT_CB.

This commit adds a selftest simulating a production scenario where a BPF
program dynamically adjusts a socket's SO_RCVLOWAT based on the parsing
of RPC descriptors. The test exchanges partial and full RPC frames over
a local connection and verifies that epoll wakes up the application at
the correct boundaries.

> diff --git a/tools/testing/selftests/bpf/prog_tests/tcp_autolowat.c b/too=
ls/testing/selftests/bpf/prog_tests/tcp_autolowat.c
> --- a/tools/testing/selftests/bpf/prog_tests/tcp_autolowat.c
> +++ b/tools/testing/selftests/bpf/prog_tests/tcp_autolowat.c

[ ... ]

> @@ -0,0 +1,350 @@
> +static void tcp_autolowat_run_rpc_test(struct tcp_autolowat_test_cb *cb,
> +				       struct rpc_test_case *test_case)
> +{

[ ... ]

> +		switch (event->type) {
> +		case RPC_EVENT_END:
> +			return;
> +		case RPC_EVENT_AUTOLOWAT:
> +			err =3D setsockopt(cb->child, SOL_BPF, BPF_TCP_AUTOLOWAT,
> +					 &event->val, sizeof(event->val));
> +			if (!ASSERT_OK(err, "setsockopt"))
> +				return;
> +			break;
> +		case RPC_EVENT_SEND:
> +			err =3D send(cb->client, ptr, event->len, 0);
> +			if (!ASSERT_EQ(err, event->len, "send"))
> +				return;
> +
> +			ptr +=3D event->len;
> +			break;

[ ... ]

> +		case RPC_EVENT_EPOLL:
> +			err =3D epoll_wait(cb->epoll, &ev, 1, 0);
> +			if (!ASSERT_EQ(err, event->nfds, "epoll_wait"))
> +				return;
> +			break;
> +		case RPC_EVENT_RCVLOWAT:
> +			optval =3D 0;
> +			optlen =3D sizeof(optval);
> +
> +			err =3D getsockopt(cb->child, SOL_SOCKET, SO_RCVLOWAT, &optval, &optl=
en);
> +			if (!ASSERT_OK(err, "getsockopt") ||
> +			    !ASSERT_EQ(optval, event->rcvlowat, "rcvlowat"))
> +				return;
> +			break;
> +		}

Are the epoll and getsockopt checks vulnerable to flaky failures
under load?

Since TCP loopback delivery can be deferred to softirq context, could
epoll_wait with a 0-millisecond timeout return 0 if the packet hasn't
been queued yet?

Similarly, could getsockopt read a stale SO_RCVLOWAT value before the
BPF program gets a chance to update it?

Would using a polling loop or a positive epoll timeout prevent
intermittent test failures?

> diff --git a/tools/testing/selftests/bpf/progs/tcp_autolowat.c b/tools/te=
sting/selftests/bpf/progs/tcp_autolowat.c
> --- a/tools/testing/selftests/bpf/progs/tcp_autolowat.c
> +++ b/tools/testing/selftests/bpf/progs/tcp_autolowat.c

[ ... ]

> @@ -0,0 +1,316 @@
> +static int tcp_parse_descriptor(struct bpf_sock_ops *skops,
> +				struct tcp_autolowat_cb *cb,
> +				u32 seq, u32 end_seq)
> +{
> +	struct rpc_descriptor *rpc_desc;
> +	u32 rpc_copied_seq;
> +	u32 copy_len;
> +	u64 rpc_len;
> +	int err;
> +
> +	rpc_copied_seq =3D cb->rpc_desc_seq + cb->rpc_desc_buff_len;
> +
> +	if (before(cb->rpc_desc_seq + RPC_DESC_SIZE, end_seq))
> +		copy_len =3D RPC_DESC_SIZE - cb->rpc_desc_buff_len;
> +	else
> +		copy_len =3D end_seq - rpc_copied_seq;
> +
> +	/* Since LLVM commit 324e27e8bad83ca23a3cd276d7e2e729b1b0b8c7,
> +	 * clang omits the "copy_len =3D=3D 0" check below, which is necessary
> +	 * to satisfy the BPF verifier's range check for bpf_skb_load_bytes().
> +	 */
> +	barrier_var(copy_len);
> +
> +	if (copy_len =3D=3D 0)
> +		goto disable; /* FIN. */
> +	if (copy_len > RPC_DESC_SIZE)
> +		goto disable; /* always false, only for verifier. */
> +	if (cb->rpc_desc_buf + cb->rpc_desc_buff_len >=3D &cb->rpc_desc_buf[RPC=
_DESC_SIZE])
> +		goto disable; /* always false, only for verifier. */
> +
> +	err =3D bpf_skb_load_bytes(skops, rpc_copied_seq - seq,
> +				 cb->rpc_desc_buf + cb->rpc_desc_buff_len, copy_len);
> +	if (err)
> +		goto disable;

Is there a race condition if pipelined data is already in the receive
queue when BPF_TCP_AUTOLOWAT is enabled?

Looking at tcp_init_autolowat_cb(), cb->rpc_desc_seq is initialized to
tp->copied_seq. If there is already unread data in the queue, the next
packet arrival triggers BPF_SOCK_OPS_RCVLOWAT_CB.

Because seq (which comes from tcb->seq) corresponds to the new packet
and is greater than tp->copied_seq, will rpc_copied_seq - seq underflow?

If it underflows to a large positive value, won't bpf_skb_load_bytes()
fail with -EFAULT, causing the code to jump to the disable label and
permanently disable the autolowat functionality for this socket?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260508073355.3916=
746-1-kuniyu@google.com?part=3D8
