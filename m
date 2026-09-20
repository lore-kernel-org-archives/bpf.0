Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A4E3E1694
	for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 20:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789935215; cv=none; b=NSLMu4QXPURrKXjWC4vQyB66H8351O/bRrdSwVhVYzhKOnRptnzlIc555qt6Rn89d9NMUwYlEJRPRDfgKe+XPIXX+HWa2l43O+7KZVbLU6KrxZNc0sRpue2BVJyCzmH2SD1wTENWpHhg7A822qfwIFGENpwVFNPt3ZsWytQM5GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789935215; c=relaxed/simple;
	bh=BfsAI3FWnNQgRJ2OWfKkiLz5SH+LSfTCcOy8Gs+1ncQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kb6gireIntr08K49h+2K9edg1dG5PfPIYS4OSS4eP6HLcJSkqf8hLtw348iGdnAgv3OqwXPpybn3ecVAckQKEvqkMLySky2jJyFpBqHq3aPa0OgFg24gaXf4SdODpt63A0rHac0PJ6hgoSj80ckNG0pPF5yOTRGJ0KSANDyMOu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DTuXZzXV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DTuXZzXV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A40C81F000FF;
	Sun, 20 Sep 2026 20:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789935213;
	bh=X9RzaSITVjJHWKEHgVn/+kiZf3m1aBf5q531baR/fos=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DTuXZzXVHmvbMV/U92SWn8Bhymai+nUWEeJY8Ikz8KFqSym4EVXw5gtntRKdVlCO0
	 2kel3yHUTWywkFD0TzLH0HrcV1YgDyia1YADoEv+E8+0HVHUT7Yb+amxqLNkh3xE+0
	 Yxgq7AiT45ub1ofrBG5s41ADoXfzeo0CrjqswJVpyyfb9c6Noo4Yr5baYowMm2kEoy
	 jX+m73128htlvQWIkjcEQU1VHi6YRb/HAqLZAEoDKj3ljIjU/aoo7sp95RZXip/uFy
	 5sIsR4A4HzsorYS8bmYvLQftCk3RtOaqQMRkErhiiASyX6lAcfjXGUJXbMKgB4ckYw
	 xEHtN+RAyq+xA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 6/7] bpf: tcp: Add kfunc to adjust
 sk->sk_rcvlowat.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kuniyuki Iwashima" <kuniyu@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260920195633.3033620-7-kuniyu@google.com>
References: <20260920195633.3033620-1-kuniyu@google.com>
 <20260920195633.3033620-7-kuniyu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 20:13:33 +0000
Message-Id: <20260920201333.A40C81F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: tcp: OOB access and type confusion in bpf_tcp_ops_set_rcvlowa=
t()
--

commit c903e36ae4ed7b68c1aea9023743a57be672cd2a
Author: Kuniyuki Iwashima <kuniyu@google.com>

bpf: tcp: Add kfunc to adjust sk->sk_rcvlowat.

This commit adds a new BPF kfunc bpf_tcp_ops_set_rcvlowat() to dynamically
adjust the receive low watermark for TCP sockets. It clamps negative values
to INT_MAX and configures the wakeup flag appropriately depending on the
calling hook (enqueue vs dequeue).

> diff --git a/net/ipv4/bpf_tcp_ops.c b/net/ipv4/bpf_tcp_ops.c
> index b0e14b54917eb..3768b1440eb77 100644
> --- a/net/ipv4/bpf_tcp_ops.c
> +++ b/net/ipv4/bpf_tcp_ops.c
> @@ -359,8 +359,62 @@ static struct bpf_struct_ops bpf_tcp_ops =3D {
>  	.owner =3D THIS_MODULE,
>  };
> =20
> +__bpf_kfunc_start_defs();
> +
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
Could this lead to an out-of-bounds slab memory access if a BPF program
passes a non-TCP socket?

Because the kfunc accepts a generic struct sock *sk parameter, the BPF
verifier allows passing any socket type. For example, a trusted UDP
socket could be obtained via bpf_sk_lookup_udp() and passed directly here.

However, __tcp_set_rcvlowat() blindly casts the socket to struct tcp_sock *:

net/ipv4/tcp.c:__tcp_set_rcvlowat() {
    struct tcp_sock *tp =3D tcp_sk(sk);
    ...
    if (tp->window_clamp && tp->window_clamp < val)
        WRITE_ONCE(tp->window_clamp, val);
}

This writes to tp->window_clamp, which resides well beyond the bounds of a
UDP socket structure.

Additionally, does this permit concurrent modification of the socket state
since the looked-up socket isn't guaranteed to be locked?

> +}
> +
> +__bpf_kfunc_end_defs();

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260920195633.3033=
620-1-kuniyu@google.com?part=3D6
