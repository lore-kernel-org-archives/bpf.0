Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD43635E926
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 03:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791430405; cv=none; b=V2oVSZMNPJ+WYYvb2cw1Ckt6ABwdaBfNk9yXtxNQHez+wgnQFuPwI3mkBiFtIbI2xMew2TdDj51O+c/R3YOvmNStkBrLSzIEjKx8ORBJ11Oo81rBEWME5rYjGClVe7IvTlPaxw/7kFan43s14eGNRFqAuM0GyR6Drh9EC0klC5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791430405; c=relaxed/simple;
	bh=o+CJ1EppJHuLk/E7VMqoDnR0RdNZZzf/92RsrDoj8ME=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=QGgUI39XqTgJF02kolwrheBxjSicFP+rff6DuZmUdXJKyzSmsRlfJw2UNV0DR5nsFfBJvLqI9/DFhMuFUE8wahu9CuwU01gVkMf+KA+BIbIjNCqnCGzXQXcnBkDVPjk9bBw5zPPLo3AuzzUXZ1yehb8HRZhiOe5Vf51vxP9HLBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IlT+dL9p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IlT+dL9p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 384541F000FF;
	Thu,  8 Oct 2026 03:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791430404;
	bh=MnAf5O4lXzbUh6QZpCPK7Umo50iKnHzpGfqultenLiU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IlT+dL9pnD4mrR2a+tswPM8dRk8KrtlCJbcrfIC2NIQK73mLjJn8gFeHBulVjTWhJ
	 Eyf7Vb8elsEwY+cogat4kBBGHPOuAJ7s0Hwv/nSfW/YMbj3dnTAwfEyTI6sqbTS1A+
	 JshsT3N4U9SlxMHgidgRl5e8T8K9mSQKfQZWA4cv3gL6mQ0k7QzKAUSmHJvnqgbDKd
	 JwLgYnpr72RT18cRamcIhwL1HnusHfJy9+Ke5gKDusF6Hl3Au/uPnijpY+AZGVS3bD
	 xYjNqnuDeuKeREunjWqiHhPGTRts3YMvvQEx3woke8zNOBvBhdBKo2PxEhr/ZTiM8c
	 oPGv5kJ9IDyjQ==
Message-ID: <sashiko-outbox-163559@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 bpf-next 04/10] bpf: tcp: Guard fast-path
 bpf_tcp_ops_call() under per-socket flag.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kuniyuki Iwashima" <kuniyu@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261008031604.256498-5-kuniyu@google.com>
References: <20261008031604.256498-1-kuniyu@google.com>
 <20261008031604.256498-5-kuniyu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 03:33:23 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] tcp: stale saw_unknown flag partially defeats bpf_tcp_ops optimizat=
ion
--

commit f118f1505af0dead6c4ecc71acf79379acbf604a
Author: Kuniyuki Iwashima <kuniyu@google.com>

    bpf: tcp: Guard fast-path bpf_tcp_ops_call() under per-socket flag.
   =20
    bpf_tcp_ops.{parse_hdr,hdr_opt_len} are called for every
    incoming / outgoing skb.
   =20
    bpf_tcp_ops.rtt is called once per RTT, which is every
    incoming skb in ping-pong workloads like tcp_rr.
   =20
    Even attaching NULL callbacks in the fast path hurts performance.
   =20
    Let's guard them (and write_hdr_opt) with the new per-socket flags.

> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 209db8effcc41..4478d3f3d4b02 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
[ ... ]
> @@ -217,7 +222,12 @@ static void bpf_tcp_ops_parse_hdr(struct sock *sk, s=
truct sk_buff *skb)
>  		return;
>  	}
> =20
> -	bpf_tcp_ops_call(parse_hdr, sk, skb);
> +	tp =3D tcp_sk(sk);
> +
> +	if ((tp->rx_opt.saw_unknown &&
> +	     BPF_TCP_OPS_TEST_FLAG(tp, PARSE_HDR_OPT_UNKNOWN)) ||
> +	    BPF_TCP_OPS_TEST_FLAG(tp, PARSE_HDR_OPT_ALL))
> +		__bpf_tcp_ops_call(parse_hdr, sk, skb);
>  }

[Severity: Low]
Does this optimization rely on tp->rx_opt.saw_unknown being correctly clear=
ed
for packets without unknown options?

Looking at tcp_fast_parse_options(), the fast parse path clears other option
state flags but fails to clear saw_unknown:

net/ipv4/tcp_input.c:tcp_fast_parse_options() {
	if (th->doff =3D=3D (sizeof(*th) / 4)) {
		tp->rx_opt.saw_tstamp =3D 0;
		tp->rx_opt.accecn =3D 0;
		return false;
	}
...
}

If a previous packet had an unknown option and set saw_unknown, could
subsequent packets that take the fast parse path retain the stale saw_unkno=
wn
value, causing the BPF program to be invoked spuriously and partially
defeating this optimization?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008031604.2564=
98-1-kuniyu@google.com?part=3D4
