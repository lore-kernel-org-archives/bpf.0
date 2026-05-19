Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F211C3E1695
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 08:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779179115; cv=none; b=qxx8Q5sVOWNcZD4D6Prry+wlcNDt+wR+2ZatX9sncCevd4wI+cj2sFN3lMcyAw0cuPMiNLafe+YVv90kXo9odQoNYZzdp+D3ORoANCUymQKe2etuPNXSV2pCLVjKcUxzwyX7l8Dd1jc8i47gc4xkVtDHDclfts01pUq0WD1DHlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779179115; c=relaxed/simple;
	bh=Kqm8NUKfLJgdpPSCBZ1DxlgWqh7XprgHaSnjBSNCJHc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UVutUZ5rQzmnR51WohcD1nEHIJ2OB4xyJqEpBuyEKVo7LT0TOMxtc2i0am90AS40OH2BOqszgeGEHR6GtnjQj2cV3f4D9d3baNYZReI1Z05czFrJKTkgjsfHdTC/9Z6Q3a2OZGroPU2r7nqpZx1gfkWsowbXNmYgrqAa5wQuug4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AM1xYcDp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AM1xYcDp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD96BC2BCC6;
	Tue, 19 May 2026 08:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779179114;
	bh=Kqm8NUKfLJgdpPSCBZ1DxlgWqh7XprgHaSnjBSNCJHc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=AM1xYcDpcPh3u4a/sE7QAXnmpjw4hs24yah/WYNkubuMMhW3yXlqBzABuI82bQiGC
	 eKzJbZxUuq0zjTDkkqI6yM0UTqhMmyTG3Xb6jSRxBt9BIW8zAZgd5syDawpB8Rm0wA
	 JyR8ojLpy+FARNUpjend7H+I1qvgwxF7zZ+uimL4iFnRkwkOqHE9kqMuX4qKY4a9xz
	 mhzpb689TwXFImjg1Hfa7eJGI0n1+JVCvr4rdjBGV8Z9xhivX/r9T11INVHtcbvrAP
	 hJ85VchmCqjV/awIshZe+nb+gtqCA/22Y4OPSaBY+eMbOJJvI6O0ZibzPZeK7nmd2X
	 MjUYg+Oh2p1Ig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 5/6] bpf: enable bpf timestamping rx in TCP
 layer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jason Xing" <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260518082344.96647-6-kerneljasonxing@gmail.com>
References: <20260518082344.96647-6-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 May 2026 08:25:14 +0000
Message-Id: <20260519082514.AD96BC2BCC6@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] BPF sock_ops hook is called without holding the socket lock, viola=
ting core locking rules and risking data corruption.
- [Medium] Missing BPF RX timestamping for zero-copy receive (tcp_zerocopy_=
receive).
- [Medium] MSG_PEEK causes event duplication, corrupting BPF statistics.
- [Medium] Data race due to lockless read of sk->sk_bpf_cb_flags.
--

commit bdfc9a5e79a8f2a8060029cde75cfb38b923754a
Author: Jason Xing <kerneljasonxing@gmail.com>

bpf: enable bpf timestamping rx in TCP layer

This commit introduces BPF RX timestamping for TCP by adding a BPF hook
to tcp_recvmsg(). It evaluates timestamping flags and conditionally
calls bpf_skops_rx_timestamping().

> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 21ece4c716121..64c69bb3578af 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -2949,8 +2949,18 @@ int tcp_recvmsg(struct sock *sk, struct msghdr *ms=
g, size_t len, int flags)
>  	release_sock(sk);
> =20
>  	if ((cmsg_flags | msg->msg_get_inq) && ret >=3D 0) {
> -		if (cmsg_flags & TCP_CMSG_TS)
> -			tcp_recv_timestamp(msg, sk, &tss);
> +		if (cmsg_flags & TCP_CMSG_TS) {
> +			u32 tsflags =3D READ_ONCE(sk->sk_tsflags);
> +
> +			if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&
> +			    SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_RX_TIMESTAMPING))

Since the socket lock was released above, is it safe to read
sk->sk_bpf_cb_flags here without READ_ONCE()? It appears
bpf_sock_ops_cb_flags_set() could modify this concurrently, potentially
causing a data race.

> +				bpf_skops_rx_timestamping(sk, &tss,
> +							  BPF_SOCK_OPS_TSTAMP_RCV_CB);

Does executing the BPF_PROG_TYPE_SOCK_OPS program here without holding the
socket lock risk data races? Since the program receives a full socket
context and can call helpers like bpf_setsockopt(), this might trigger
assertions in sock_owned_by_me(sk) or corrupt socket state.

If MSG_PEEK is passed in the flags, will this cause the BPF program to be
invoked multiple times for the same skb? The callback doesn't seem to
receive arguments indicating a peek, which might artificially inflate packet
counts and skew latency metrics.

> +			if (sock_flag(sk, SOCK_RCVTSTAMP) ||
> +			    tsflags & SOF_TIMESTAMPING_SOFTWARE ||
> +			    tsflags & SOF_TIMESTAMPING_RAW_HARDWARE)
> +				tcp_recv_timestamp(msg, sk, &tss);

Will packets processed via the zero-copy receive path miss these RX
timestamp events? High-performance applications using tcp_zerocopy_receive()
go through tcp_zc_finalize_rx_tstamp(), which directly calls
tcp_recv_timestamp() but seems to omit this new BPF callback.

> +		}
>  		if ((cmsg_flags & TCP_CMSG_INQ) | msg->msg_get_inq) {
>  			msg->msg_inq =3D tcp_inq_hint(sk);
>  			if (cmsg_flags & TCP_CMSG_INQ)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518082344.9664=
7-1-kerneljasonxing@gmail.com?part=3D5
