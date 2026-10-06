Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C927730E82B
	for <bpf@vger.kernel.org>; Tue,  6 Oct 2026 19:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791315721; cv=none; b=Fdke6ORgSyw0uaqeB7GA1Ko4imHoaNr2tuh48cQhTYx8/CIlHLKjzJTJxnV6I8JceExnXo7xKk9/7o8oCVots+WOjCjViTG+UEJXr4pEieLzhedwX7n/qwzqDwQLp/7Ms+i1/hAKPSUG1un/3ng1c5X4Bd2qFGmHRU0prFLXqcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791315721; c=relaxed/simple;
	bh=05yrAMEHowaucFnzcoxC60+l7sft3Iizpg7JeuR2phk=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=SILBoTgeEyGXDj1PYLzTdonhIRmY+KVW96q7Acjc4o1R8Uyc9NJu35bKWpXKxKWBq2bs3gqncSnyraTnRb8E1xAUOP60cBIPkTSsvjvammPau+t66wQfmwC8ZwnRpj02sxu7TNgIdxBpT2AJV9isoqxvKwGb0x1YTX5APICS7AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ou+EASIo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ou+EASIo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 672881F0089B;
	Tue,  6 Oct 2026 19:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791315720;
	bh=v9QQs0AL3hb96LJlZbKvyfMQJSm8MZQZIW33QYWyeAM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ou+EASIoviiKRWyez7sDzpvhYXtaXcV81HwEI8deKI8mXVTVzwY16H03W2nhJ6J/f
	 GX77DVGWqKNF9PCSIIc9grYwzSBYyBEnI+ktTgE+2Ak4+MlQtBVJTDuIBOYjcHdOHv
	 8n2lN7Ukdkmd6SqVPNjRCrOQ6MwSpWy74VnZttpObqOMBTP3a9WvgsriqXIcEb6GLv
	 kCDNHZGClrz3W/hijeWURdKbLNsGTykIKB8C8ZkLi2vBpYe6boQMLRl6IrmwVbz/E1
	 W+Qn0QyYohFG8yQN1y+yE3vAcXIDAJ909BgN2qrU4ZvW4j1IlD0giGpmr/Bpklc91C
	 sn9WoWgcquZ9g==
Message-ID: <sashiko-outbox-162405@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 bpf-next 09/10] bpf: tcp: Add kfunc to adjust
 sk->sk_rcvlowat.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kuniyuki Iwashima" <kuniyu@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261006192601.1875100-10-kuniyu@google.com>
References: <20261006192601.1875100-1-kuniyu@google.com>
 <20261006192601.1875100-10-kuniyu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 19:42:00 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: bpf_tcp_ops_set_rcvlowat() allows out-of-bounds writes and da=
ta races via arbitrary sockets
--

commit f1017b98cfed57e0845856c2710e8fad69bfcbe9
Author: Kuniyuki Iwashima <kuniyu@google.com>

bpf: tcp: Add kfunc to adjust sk->sk_rcvlowat.

This commit adds a new BPF kfunc bpf_tcp_ops_set_rcvlowat() to dynamically
adjust a socket's sk_rcvlowat to suppress unnecessary wakeups. The function
determines whether to trigger a wakeup based on the BPF struct_ops hook
context.

> diff --git a/net/ipv4/bpf_tcp_ops.c b/net/ipv4/bpf_tcp_ops.c
> index 8182037c42690..2ba73dd6c52cc 100644
> --- a/net/ipv4/bpf_tcp_ops.c
> +++ b/net/ipv4/bpf_tcp_ops.c

[ ... ]

> @@ -361,12 +361,31 @@ __bpf_kfunc int bpf_tcp_ops_set_flags(struct tcp_so=
ck *tp, u32 enable, u32 disab
>  	return 0;
>  }
> =20
> +__bpf_kfunc int bpf_tcp_ops_set_rcvlowat(struct sock *sk, int rcvlowat,
> +					 const struct bpf_prog_aux *aux)
> +{
> +	u32 moff =3D aux->attach_st_ops_member_off;
> +	bool wakeup =3D false;
> +
> +	if (moff =3D=3D offsetof(struct bpf_tcp_ops, dequeue_rcvq))
> +		wakeup =3D true;
> +
> +	if (rcvlowat < 0)
> +		rcvlowat =3D INT_MAX;
> +
> +	return __tcp_set_rcvlowat(sk, rcvlowat, wakeup);

[Severity: High]
Does this code allow out-of-bounds writes if a non-TCP socket is passed?

The BPF verifier allows passing any trusted socket to kfuncs expecting a
struct sock *, such as those obtained via bpf_sk_lookup_udp() or
bpf_sk_lookup_tcp(). This means the sk argument is not restricted to the
locked context socket passed to the enqueue_rcvq or dequeue_rcvq hooks.

If a UDP socket is passed in, __tcp_set_rcvlowat() unsafely casts it to
struct tcp_sock and modifies tp->window_clamp:

net/ipv4/tcp.c:__tcp_set_rcvlowat() {
    struct tcp_sock *tp =3D tcp_sk(sk);
    ...
    if (space > sk->sk_rcvbuf) {
        ...
        if (tp->window_clamp && tp->window_clamp < val)
            WRITE_ONCE(tp->window_clamp, val);
    }
}

Since struct udp_sock is smaller and lacks the window_clamp field, will this
write out of bounds? Should the signature take a struct tcp_sock *tp instea=
d,
similar to bpf_tcp_ops_set_flags()?

Additionally, if a valid TCP socket is passed via a lookup, its socket lock
is not held. __tcp_set_rcvlowat() modifies sk_rcvlowat, sk_rcvbuf, and
window_clamp using logic that relies on the socket lock being held. Is there
a risk of data races and state corruption if it is called on an unlocked
socket?

Finally, passing an MPTCP subflow could bypass the intended restriction
since MPTCP subflows typically need to use mptcp_set_rcvlowat().

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006192601.1875=
100-1-kuniyu@google.com?part=3D9
