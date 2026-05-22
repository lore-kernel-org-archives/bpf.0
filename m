Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB521A9F85
	for <bpf@vger.kernel.org>; Fri, 22 May 2026 08:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779438929; cv=none; b=KwXkTAkVdktP4p4crQq8SV21fvtkDa1yzNle5tOXXJwYGhb0YO+KmStTbWfu4nhgmnVM6YeS9aeEQAQByC9/h8HsYVJT8m5iohimzjUqDt1kBgMLOhsf2ScrScsf1UOIw5H0DAz2TLbEfd0FpKUDk9amiu/59jaRKjRkzJ9Kp4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779438929; c=relaxed/simple;
	bh=Xk14sgAAXwQPFYlo6hyUxf9rBSKp8FS7iRuRy0NjjyI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fUjNlAcRta5q+2vc384cvyNDNrcm+3mEC3p0S2/xE8S9namw49TrXfZOTv8Lqrr/slcN3Wt5BgSMxeMoZ0hvearhugw/OehOQt6vJr3KDUjK/8sHjpHBqhikBY8jSaCZ6qO6PXAPeQpsJgcRev0jy6vb+iBo8Kkuvgdo53b5qXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ff8JLssU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ff8JLssU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D40D51F000E9;
	Fri, 22 May 2026 08:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779438928;
	bh=5Y1oPL8cM8uOxgVZ6ujYgnM6OF2aXdMI86UbdPWBFBw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ff8JLssUMzS+PjlG89RDg6C7BjPzlfK4BbanvEQzM0fpWAAftmViESe0+0BELzDuh
	 Vx18iagnN/cCBccZ2Rwh+q4EA5cey/3NEPZprRG//DVmRkPvnGCF7PTa8nOnEUb3Dc
	 YjDIqMjjh9pQLk5e6PN+bFTT6enqE6Rw/H2mZP+48k4wXf3WJ+42eOqRuBEMr5VZTQ
	 B2CN0pxc+DHQLhpKbai3f9yzinqlXQjUfsKy0pLThUug3JJnbCAKXGNqCFPkJm9dSI
	 cIHRmY9y9Qyv+X57gKlFBXFeEv5vACjSX4DMgQBWt3IPQ9i16lpiHnF21Pps2zcoh/
	 SkbhmA+SDmu4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 bpf-next 11/11] selftest: bpf: Add test for
 BPF_SOCK_OPS_RCVQ_CB.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kuniyuki Iwashima" <kuniyu@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260522074601.1658705-12-kuniyu@google.com>
References: <20260522074601.1658705-12-kuniyu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 08:35:27 +0000
Message-Id: <20260522083527.D40D51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] The BPF program sets SO_RCVLOWAT to the total combined size of all=
 unread frames when multiple RPC frames are received in a single skb, causi=
ng the application to hang when reading frames sequentially.
- [Medium] Test case 4 incorrectly assumes that calling recv() triggers the=
 BPF program to update SO_RCVLOWAT, which causes a failing assertion.
- [Medium] The selftest assumes synchronous packet delivery over the loopba=
ck interface, leading to a race condition where epoll_wait and getsockopt c=
hecks occur before the TCP stack and BPF program have processed the packet.
- [Low] Multi-line comments in BPF code do not have the opening '/*' on its=
 own line.
--

commit e3c63e65707f68d5d1680cea7733be1620b9d094
Author: Kuniyuki Iwashima <kuniyu@google.com>

selftest: bpf: Add test for BPF_SOCK_OPS_RCVQ_CB.

This commit adds a BPF selftest for BPF_SOCK_OPS_RCVQ_CB, simulating a
production scenario where an application uses a BPF program to dynamically
adjust SO_RCVLOWAT for RPC frame parsing.

> diff --git a/tools/testing/selftests/bpf/prog_tests/tcp_autolowat.c b/too=
ls/testing/selftests/bpf/prog_tests/tcp_autolowat.c
> new file mode 100644
> index 0000000000000..5e971c42a32a4
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/tcp_autolowat.c
[ ... ]
> +struct rpc_test_case {
> +	char data[4096];
> +	struct rpc_descriptor desc[32];
> +	struct rpc_event event[32];
> +} rpc_test_cases[] =3D {
[ ... ]
> +	{
> +		.desc =3D {
> +			{.header_len =3D 100, .payload_len =3D 150},
> +			{.header_len =3D 200, .payload_len =3D 500},
> +		},
> +		.event =3D {
[ ... ]
> +			/* After reading the first RPC message, SO_RCVLOWAT should be RPC_DES=
C_SIZE. */
> +			{.type =3D RPC_EVENT_RECV,	.len =3D RPC_DESC_SIZE + 150 + 100},
> +			{.type =3D RPC_EVENT_EPOLL,	.nfds =3D 0},
> +			{.type =3D RPC_EVENT_RCVLOWAT,	.rcvlowat =3D RPC_DESC_SIZE},

[Severity: Medium]
Does calling recv() actually trigger the BPF program to update SO_RCVLOWAT?

Since the kernel only invokes BPF_SOCK_OPS_RCVQ_CB when a new skb is added
to the receive queue, and not when data is dequeued via recv(), the BPF
program doesn't seem to run here.

Could this cause the test to fail unconditionally because sk_rcvlowat
retains its previous value?

[ ... ]
> +static void tcp_autolowat_run_rpc_test(struct tcp_autolowat_test_cb *cb,
> +				       struct rpc_test_case *test_case)
> +{
[ ... ]
> +	while (1) {
> +		switch (event->type) {
[ ... ]
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

[Severity: Medium]
Could this lead to race conditions causing flaky tests?

The test calls send() to transmit data and immediately executes the next
event. Because network transmission over the loopback interface involves
asynchronous softirq processing, send() might return before the packet is
fully processed by the receiving socket.

If the next event is RPC_EVENT_EPOLL with a timeout of 0, could epoll_wait()
prematurely return 0? Similarly, for RPC_EVENT_RCVLOWAT, could getsockopt()
read a stale sk_rcvlowat value before the TCP stack and BPF program have
finished processing the packet?

[ ... ]
> diff --git a/tools/testing/selftests/bpf/progs/tcp_autolowat.c b/tools/te=
sting/selftests/bpf/progs/tcp_autolowat.c
> new file mode 100644
> index 0000000000000..41eacfdb34aa1
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/tcp_autolowat.c
[ ... ]
> +static int tcp_parse_descriptor(struct bpf_sock_ops *skops,
> +				struct tcp_autolowat_cb *cb,
> +				u32 seq, u32 end_seq)
> +{
[ ... ]
> +	if (before(cb->rpc_desc_seq + RPC_DESC_SIZE, end_seq))
> +		copy_len =3D RPC_DESC_SIZE - cb->rpc_desc_buff_len;
> +	else
> +		copy_len =3D end_seq - rpc_copied_seq;
> +
> +	/* Since LLVM commit 324e27e8bad83ca23a3cd276d7e2e729b1b0b8c7,
> +	 * clang omits the "copy_len =3D=3D 0" check below, which is necessary
> +	 * to satisfy the BPF verifier's range check for bpf_skb_load_bytes().
> +	 */

[Severity: Low]
This isn't a bug, but multi-line comments in the BPF subsystem are expected
to have the opening '/*' on its own line:

	/*
	 * Since LLVM commit ...
	 * ...
	 */

[ ... ]
> +static void tcp_set_autolowat(struct bpf_sock_ops_kern *skops_kern,
> +			      struct tcp_autolowat_cb *cb,
> +			      struct tcp_sock *tp)
> +{
> +	/* To handle wraparound. */
> +	u32 val =3D 0;
> +
> +	LOG("Setting rcvlowat: tp->copied_seq: %u, rpc_desc_seq: %u, rpc_end_se=
q: %u, rpc_desc_buff_len: %u",
> +	    TP_SEQ(copied_seq), CB_SEQ(rpc_desc_seq), CB_SEQ(rpc_end_seq), cb->=
rpc_desc_buff_len);
> +
> +	if (before(tp->copied_seq, cb->rpc_desc_seq))
> +		val =3D cb->rpc_desc_seq - tp->copied_seq;

[Severity: High]
Does this code incorrectly set SO_RCVLOWAT to the total combined size of all
unread frames when multiple RPC frames are received in a single skb?

If multiple complete frames arrive in the same skb, the parsing loop in
tcp_do_autolowat() parses all of them and advances cb->rpc_desc_seq to the
end of the last parsed frame. This sets:

val =3D cb->rpc_desc_seq - tp->copied_seq

which evaluates to the length of all unread frames combined.

If an application sequentially reads one frame at a time, tp->copied_seq
advances and the queue size decreases, but sk_rcvlowat is not updated
because BPF_SOCK_OPS_RCVQ_CB only fires on packet enqueue.

The remaining queue size will then be strictly less than sk_rcvlowat, causi=
ng
epoll_wait to block and trapping the remaining fully-received frames in the
receive queue.

Could this hang applications that rely on epoll to read one message at a
time?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522074601.1658=
705-1-kuniyu@google.com?part=3D11
