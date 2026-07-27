Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490323E47B
	for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 19:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785181097; cv=none; b=TqlpMLYfRJPjlAkJyKI52hEE/FXaTAiG1mPGJGMjLFgDm6thPlchbczjryXwE5q/SmIKFQmzC7g/EuAHjSATPdpzqSlzZyw9vpa5hKK4YwwzgOqolf5HPoyZEwOBtMd+eLdIZ8aXSJRrtx7XjEGFQGAP8831rxiDPpa1pFTnDO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785181097; c=relaxed/simple;
	bh=PUTUq9ooNrbONPOxNvgqYTkR/wYMVFYuT4NPxYX0NKI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YptelEwL8ToWdnXCmjWtYus5MDiFjS1R7TccEiybbK6BTrrWiTwQXYyF0gGDy0tOClX7KeDUzMhejQhnmLCCKvQKau7sp3n9jeTHuZkM2W1agJflGZhewOSZznt4CHmBp7slV7+DOmukEfhYb4YhDA0S/4nlfv1KNpmxVvooXSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kPCw0MFC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kPCw0MFC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF6BB1F000E9;
	Mon, 27 Jul 2026 19:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785181095;
	bh=5JBzxVq+OHGPSXi7HxooEpN/6Q9Y9ugO3DRgL/UVMrI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kPCw0MFCj/nCxcJlkXzP7yvUb4fb+nTgb3z9eR1fD7dMs3fSe1X8ibW8/3itKlSmt
	 KmTSTR6HdPLsKiYw+dcHxtuqM/uLbDqODuH61Fb7Yz+IWCzhNGLVrYw921NUbz/ZfQ
	 VhYUlKr95Zbh5HC5yHt+3I9i1PGs1HRM/7VHXg9CjXPE4fwhSfLpPwXJV60yPv2i9k
	 1iNJIMFXVlBSUuG4rqMXFK1Ug9yR9GBjDIh0qtgK6jjknouQkz+KFXjGwAYPPFfkRL
	 8391s+h/pN61c/hbfwTu5BrNl6UexTC/zXFiFJ5E8b6lm+VmDhhOz9i8wrFiYHSqNb
	 xPHAiVGEeMagA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 net-next 1/1] tcp: allow congestion controls to
 override TSO autosizing
Reply-To: sashiko-reviews@lists.linux.dev
To: chia-yu.chang@nokia-bell-labs.com
Cc: bpf@vger.kernel.org
In-Reply-To: <20260726193802.397321-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260726193802.397321-1-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 19:38:15 +0000
Message-Id: <20260727193815.AF6BB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Moving `min_tso_segs` into an anonymous union breaks the registrat=
ion and map updates of BPF TCP congestion controls, rendering the BPF CA su=
bsystem unusable.
- [High] Aliasing function pointers with different signatures inside a unio=
n creates severe Control Flow Integrity (CFI) hazards and breaks BPF stub g=
eneration.
- [High] Returning 0 from `ca_ops->tso_segs()` causes a permanent stall in =
the TCP write queue.
--

--- Patch [1]: [PATCH v4 net-next 1/1] tcp: allow congestion controls to ov=
erride TSO autosizing ---
commit 986d64ed9a398f1ef7247d7b653292cb0b6d25f3
Author: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

tcp: allow congestion controls to override TSO autosizing

This patch introduces the TCP_CONG_EXACT_TSO_SEGS flag and adds an alternat=
ive
tso_segs() callback to tcp_congestion_ops. It allows congestion control
algorithms to provide an exact TSO segment count instead of just a minimum.
This is implemented by placing the new callback in a union with the existing
min_tso_segs() callback.

Link: None

> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 2c5b889530b55..82cd82a19ff91 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
[ ... ]
> @@ -1361,8 +1363,16 @@ struct tcp_congestion_ops {
>  	/* hook for packet ack accounting (optional) */
>  	void (*pkts_acked)(struct sock *sk, const struct ack_sample *sample);
> =20
> -	/* override sysctl_tcp_min_tso_segs (optional) */
> -	u32 (*min_tso_segs)(struct sock *sk);
> +	union {
> +		/* Used when TCP_CONG_EXACT_TSO_SEGS is not set,
> +		 * override sysctl_tcp_min_tso_segs (optional)
> +		 */
> +		u32 (*min_tso_segs)(struct sock *sk);
> +		/* Used when TCP_CONG_EXACT_TSO_SEGS is set,
> +		 * override tcp_tso_autosize (optional)
> +		 */
> +		u32 (*tso_segs)(struct sock *sk, u32 mss_now);
> +	};

[Severity: High]
Does this anonymous union prevent the BPF TCP congestion control subsystem =
from
initializing?

Looking at bpf_struct_ops_desc_init() in kernel/bpf/bpf_struct_ops.c, the B=
PF
framework iterates over the members of the struct. If it encounters an
anonymous member, it explicitly rejects it with an "anon member in struct is
not supported" warning and aborts the registration:

kernel/bpf/bpf_struct_ops.c:bpf_struct_ops_desc_init() {
    ...
    if (!*mname) {
        pr_warn("anon member in struct %s is not supported\n",
            st_ops->name);
        err =3D -EOPNOTSUPP;
        goto errout;
    }
    ...
}

[Severity: High]
Can aliasing function pointers with different signatures inside a union cre=
ate
Control Flow Integrity (CFI) hazards?

The union aliases min_tso_segs (1 argument) and tso_segs (2 arguments). If a
congestion control module misconfigures the TCP_CONG_EXACT_TSO_SEGS flag, t=
he
kernel might execute an indirect call using a signature that does not match=
 the
target function's compiled kCFI hash. Would this trigger a kernel panic?

Additionally, does this break BPF stub generation since the static stub
structure __bpf_ops_tcp_congestion_ops can only populate a single pointer f=
or
this memory offset?

> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index d7c1444b5e304..0de27a87c39e7 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
[ ... ]
> @@ -2278,11 +2278,20 @@ static u32 tcp_tso_segs(struct sock *sk, unsigned=
 int mss_now)
>  	const struct tcp_congestion_ops *ca_ops =3D inet_csk(sk)->icsk_ca_ops;
>  	u32 min_tso, tso_segs;
> =20
> -	min_tso =3D ca_ops->min_tso_segs ?
> -			ca_ops->min_tso_segs(sk) :
> -			READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_min_tso_segs);
> +	min_tso =3D READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_min_tso_segs);
> +
> +	if (ca_ops->flags & TCP_CONG_EXACT_TSO_SEGS) {
> +		if (WARN_ON_ONCE(!ca_ops->tso_segs))
> +			tso_segs =3D tcp_tso_autosize(sk, mss_now, min_tso);
> +		else
> +			tso_segs =3D ca_ops->tso_segs(sk, mss_now);
> +	} else {
> +		if (ca_ops->min_tso_segs)
> +			min_tso =3D ca_ops->min_tso_segs(sk);
> +
> +		tso_segs =3D tcp_tso_autosize(sk, mss_now, min_tso);
> +	}
> =20
> -	tso_segs =3D tcp_tso_autosize(sk, mss_now, min_tso);
>  	return min_t(u32, tso_segs, sk->sk_gso_max_segs);
>  }

[Severity: High]
Does this code allow ca_ops->tso_segs() to return 0 and stall the socket?

While tcp_tso_autosize() is guaranteed to return at least 1 (because
sysctl_tcp_min_tso_segs is strictly clamped to >=3D 1), the new callback ha=
s no
minimum bounds check.

If ca_ops->tso_segs() returns 0, tcp_tso_segs() returns 0. When processed in
tcp_write_xmit(), this forces max_segs =3D 0, bounding cwnd_quota to 0:

net/ipv4/tcp_output.c:tcp_write_xmit() {
    ...
    cwnd_quota =3D min(cwnd_quota, max_segs);
    ...
}

This causes tcp_mss_split_point() to receive max_segs =3D 0 and return a li=
mit of
0. Then tso_fragment() shrinks the original head SKB to 0 bytes:

net/ipv4/tcp_output.c:tcp_write_xmit() {
    ...
    if (skb->len > limit &&
        unlikely(tso_fragment(sk, skb, limit, mss_now, gfp)))
        break;
    ...
}

This 0-length SKB appears to permanently trigger the break condition, skipp=
ing
dequeue and stalling the write queue on all subsequent calls:

net/ipv4/tcp_output.c:tcp_write_xmit() {
    ...
    if (TCP_SKB_CB(skb)->end_seq =3D=3D TCP_SKB_CB(skb)->seq)
        break;
    ...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260726193802.3973=
21-1-chia-yu.chang@nokia-bell-labs.com?part=3D1
