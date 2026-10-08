Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7051226158B
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 03:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791431008; cv=none; b=ZVm2yCXHxNVZ7xoeXv1z8T0vwALgng5k+LOUlk7DVEva5SAH+goshxfrXHbE8v9LBN4TqvtxZXvaZ3oHA9/ZHoR/q1a1OV/UdQCSTeDw7oWWKASFKqlT9ea0jyFAyQRCxJ7wapbV3ZhboXn+pBACCr2ipit7xq4MnpnhVB8Uzvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791431008; c=relaxed/simple;
	bh=erR1FkYFhnRwwKwAaj4W1bAfhpraJYWtNpLNZ83pyRY=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=A8ViSKn7sw+CzZ66BH/cQBbEW63MiroH1dUhXKKztafBNk10etixANxepkpwUWlapct/gQ2Ep0M6bUU6yLytUYcDrU3KNyK2xev0hoQR7Mk17noFV7UucA4zJduOz8CO7i3Z9kgZusCb7sw3B//DIMvoUu9YA7hZOxeMtz4czQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QtTRfH9P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QtTRfH9P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BF751F000FF;
	Thu,  8 Oct 2026 03:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791431007;
	bh=qEvl6j/z0Y9Vi2BiGXnpAie7UWb5cgyw87rXwqNad3I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QtTRfH9PYy0HFrMrLQmWQhf2wcwA9Ai4ysjmtlDXBAaPEYD+5xmA0mlVDcUYRWEMA
	 SjYzTkaAjGJZ9MCTBuXSq+wIICkp6LsHRGjesq52znC6UlzWsgL/rua+p5qoWosKDz
	 AUvNQiJBFjeWdri8dqlmUbmqm9zEyHJvE1hS/vRbs6xUmPzCIp7a0QSuq646T7PShb
	 ifJiwfOSQfTVavnNSS5Imvm5C7wHFIf5OKK8fV2owtcLIIhbISky3JoB2DwbExi7eu
	 z2r360oOiYqpKUeMSvkT9l1AL7fbSLoFOEixCJ7+qpX0CCT6EpOeSC7qOr5eiB8iXJ
	 OBYPS3xrSLHZA==
Message-ID: <sashiko-outbox-163575@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 bpf-next 09/10] bpf: tcp: Add kfunc to adjust
 sk->sk_rcvlowat.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kuniyuki Iwashima" <kuniyu@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261008031604.256498-10-kuniyu@google.com>
References: <20261008031604.256498-1-kuniyu@google.com>
 <20261008031604.256498-10-kuniyu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 03:43:26 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: tcp: OOB write and data race in bpf_tcp_ops_set_rcvlowat()
--

commit 7deb5622ddf6a03f72f031cf7e714bbd4cca6f9e
Author: Kuniyuki Iwashima <kuniyu@google.com>

bpf: tcp: Add kfunc to adjust sk->sk_rcvlowat.

This commit adds a new BPF kfunc, bpf_tcp_ops_set_rcvlowat, to dynamically
adjust sk->sk_rcvlowat from bpf_tcp_ops.{enqueue,dequeue}_rcvq(). It handles
negative values and calls __tcp_set_rcvlowat() to update the socket.

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

[Severity: High]
Could this allow a BPF program to pass a non-TCP or unlocked socket here?

Since the argument is a generic "struct sock *sk", a BPF program might use
bpf_map_lookup_elem() on a sockmap or bpf_sk_lookup_udp() to obtain a
trusted PTR_TO_SOCKET for a UDP socket or an unlocked TCP socket.

If an arbitrary socket is passed through to __tcp_set_rcvlowat(), it
unsafely casts the socket to a tcp_sock:

net/ipv4/tcp.c:__tcp_set_rcvlowat() {
    struct tcp_sock *tp =3D tcp_sk(sk);
    ...
    if (space > sk->sk_rcvbuf) {
        WRITE_ONCE(sk->sk_rcvbuf, space);

        if (tp->window_clamp && tp->window_clamp < val)
            WRITE_ONCE(tp->window_clamp, val);
    }
}

Since udp_sock is smaller than tcp_sock, writing to tp->window_clamp
could cause an out-of-bounds write. Additionally, modifying sk_rcvbuf and
window_clamp on an arbitrary looked-up socket could cause a data race
if the socket is not implicitly locked by the current context.

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
> +}
> +
>  __bpf_kfunc_end_defs();
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008031604.2564=
98-1-kuniyu@google.com?part=3D9
