Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF7E474244
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 17:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784826090; cv=none; b=Wg7CqYfjbzHmR9AvFPVfwfesX1ZMOMmnJs79J9EdL/dPM6WGQs1JXX8vx9YM9hMe2jOAFbGdoCjyv5bY6o8kZuO9/Y9cVqhJOZ/sf/X2Wcgx0qLeNUCS7aD8WMLxpljPNV+dGoGGLt/lE3W7WCcHAF4EZ4oFh1iXylZWq6ZlWcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784826090; c=relaxed/simple;
	bh=HUxuplQvK/yFcvQWZqQol+t5/bMTGfuoXEeF6ALLQZs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NSHJNKMJCBv4bbaCn3qHW77FAqF5uoIuCzf+dSJa0KNAFjgshvcrXzrJSZGBb8kLN+EwgJmgDriX2ywtqN+lsWx3/ATe3G9l6Ldfuix5172LWssUozyzFSVWteiK0ws+OyCbwi2+4r7o6sf47BT4Rqn2GxeMO8og1tNgk6FGyWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZcuRjs7U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZcuRjs7U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 535951F000E9;
	Thu, 23 Jul 2026 17:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784826089;
	bh=+8GVcbgnVDZB7DIoAA6RLcuE7mP1lUn7KzBy7XDR78I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZcuRjs7UNUWU97mBnUnp/qSz4SIj0X0SIllR7PEb4IT2UItU/3DRDxamrJf0dDukX
	 Fd87ioiHPssvvKCsK5fuKSJJgRhIhJTafnl4DUhpzfEVtY2c8KDe6R19gEzmDVwFyn
	 erC6E/xKUq0jqLrVWHnuNh5E595vJDTT0fuTJ/fdT+l+/SxSTPhxWe914FLfdPddww
	 ytryltZzeHXRYLmNTWFWeL8Gfseaw/+G0Kq5ewpQxGkthlCo3KrFU/YEU1mJVgbEt9
	 OpnIM7MhjyJBq7wXY5Dq+MQ55WwWFbdnEJRW/fgDQLxNVCSJc/OJk3eDux4BUToE+6
	 iSER8CBLsvc7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next] tcp: honor BPF_SOCK_OPS_RWND_INIT on the
 active connect path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejas Birajdar" <tejasbirajdar@meta.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260722170033.2763794-1-tejasbirajdar@meta.com>
References: <20260722170033.2763794-1-tejasbirajdar@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 17:01:28 +0000
Message-Id: <20260723170129.535951F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] tcp_connect_init() caches tcp_full_space(sk) before running the BP=
F program, silently ignoring dynamic SO_RCVBUF updates.
- [Medium] Integer overflow in the inflated full_space calculation results =
in a negative buffer space and an advertised initial window of 0.
--

--- Patch [1]: [PATCH net-next] tcp: honor BPF_SOCK_OPS_RWND_INIT on the ac=
tive connect path ---
commit 9f42a78b2d1359dfbe17f1c5f948f19004eabdeb
Author: Tejas Birajdar <tejasbirajdar@meta.com>

tcp: honor BPF_SOCK_OPS_RWND_INIT on the active connect path

BPF_SOCK_OPS_RWND_INIT lets a sockops BPF program pick the initial TCP
receive window. This patch updates tcp_connect_init() to mirror the
listener-side inflation so the requested window isn't clamped down to the
default tcp_full_space(sk).

> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index d7c1444b5e304..478e4951140fe 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -4101,6 +4101,7 @@ static void tcp_ca_dst_init(struct sock *sk, const =
struct dst_entry *dst)
>  static void tcp_connect_init(struct sock *sk)
>  {
>  	const struct dst_entry *dst =3D __sk_dst_get(sk);
> +	int full_space =3D tcp_full_space(sk);

[Severity: High]
Does caching tcp_full_space(sk) here before the BPF program runs break
dynamic SO_RCVBUF updates?

BPF programs attached to BPF_SOCK_OPS_RWND_INIT can legitimately update
SO_RCVBUF via bpf_setsockopt() to tune connection memory. By caching
full_space early, the scaling factor is calculated using the pre-BPF default
buffer size, ignoring any dynamic changes.

[ ... ]
> @@ -4133,14 +4134,16 @@ static void tcp_connect_init(struct sock *sk)
> =20
>  	/* limit the window selection if the user enforce a smaller rx buffer */
>  	if (sk->sk_userlocks & SOCK_RCVBUF_LOCK &&
> -	    (tp->window_clamp > tcp_full_space(sk) || tp->window_clamp =3D=3D 0=
))
> -		WRITE_ONCE(tp->window_clamp, tcp_full_space(sk));
> +	    (tp->window_clamp > full_space || tp->window_clamp =3D=3D 0))
> +		WRITE_ONCE(tp->window_clamp, full_space);
> =20
>  	rcv_wnd =3D tcp_rwnd_init_bpf(sk);
>  	if (rcv_wnd =3D=3D 0)
>  		rcv_wnd =3D dst_metric(dst, RTAX_INITRWND);
> +	else if (full_space < rcv_wnd * tp->advmss)
> +		full_space =3D rcv_wnd * tp->advmss;

[Severity: Medium]
Could this calculation overflow and result in an advertised initial window
of 0?

If a BPF program returns a very large initial window value, the 32-bit
unsigned multiplication rcv_wnd * tp->advmss can overflow. Because
full_space is a signed int, values with the 31st bit set become negative.

When this is subsequently passed to tcp_select_initial_window(), negative
space is clamped to 0, which would advertise a completely closed initial
receive window and stall the connection.

> =20
> -	tcp_select_initial_window(sk, tcp_full_space(sk),
> +	tcp_select_initial_window(sk, full_space,

[Severity: High]
Is it intentional to pass the cached full_space here instead of re-evaluati=
ng
tcp_full_space(sk)?

Since full_space was cached before the BPF program executed, this passes
the stale value down, permanently bypassing any SO_RCVBUF updates that the
BPF program might have performed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722170033.2763=
794-1-tejasbirajdar@meta.com?part=3D1
