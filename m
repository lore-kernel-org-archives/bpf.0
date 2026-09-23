Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2106D51AECB
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 22:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790200973; cv=none; b=K6ubBsuJedE7xnxBEpMlMvBFlBvWR7/uFYUgGmM4G6ZWe/oYedaNUVRA64rY+2HSxmV1hXPCCT6KqJEejKwLLK0k/PcqwfKSgBjs2LctHrSmifyZSoXXzggGAsn+bvdSxXXjwDByGI01v0qx824z7oTmHo/Uox9kgH+z6s3i3eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790200973; c=relaxed/simple;
	bh=WxgfC22R8UK1tcyd0rkYXB9hFJQNpeCZhaSZquYdlUg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bgQPZhxPncfO3kxilB5sKJ5utGF6bZ8xYjMWI7T1Ra5hbaqI8Lwh+AatufCsJZpnj6qjhdEf3niG62hhLsU2rf4ylX+NbWHot8UEj6c1XWrCET8dWkIS2ypjyFBlq2OZlXcuICfISRLvgsxl1hRrKSDu/OT8uOnNoaHQ+WHrmj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1aZF044; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1aZF044"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9490C1F000FF;
	Wed, 23 Sep 2026 22:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790200971;
	bh=QVKOANMCvkt7z2NFT6//YUQuIba30IxPh7E3uTP1A4M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X1aZF044dM6sEWqQuAt7j+Oqv5ssHw8r4cpa02iR8gYlbVomTT3R4v1jBRciGxpb8
	 rMYGAxtM/B83TvFqCAkbntK+V+93i/DtfSWboqf7YBTVnc8plDtlZ8FGxi42CJqo1w
	 TpF8rIHyDP4uQsMrcydC9X9F69i36JL7SngTx1HI8ucI308ZTmjnbbiLCNml0R2zCv
	 9ACE1CnPomtcq6fjg/RKxzURYDenYuVUQY8tUXrCa+DOaAcbcYoDTPOx9jutBlxEhQ
	 DdetXYC6Ag/68v50PT0qcfXpUoeERF2yGxkHvUZYoO9+71OMPz98fdcyvlywzKLCnN
	 2/P5Lm46FpQ4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 bpf-next 7/8] bpf: tcp: Add kfunc to adjust
 sk->sk_rcvlowat.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kuniyuki Iwashima" <kuniyu@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260923213719.224838-8-kuniyu@google.com>
References: <20260923213719.224838-1-kuniyu@google.com>
 <20260923213719.224838-8-kuniyu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 22:02:50 +0000
Message-Id: <20260923220251.9490C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: tcp: OOB write in __tcp_set_rcvlowat via unrelated socket
--

commit 68bce63bbe5802a4eee99c7c0f138096d7c16481
Author: Kuniyuki Iwashima <kuniyu@google.com>

bpf: tcp: Add kfunc to adjust sk->sk_rcvlowat.

This commit adds a new BPF kfunc bpf_tcp_ops_set_rcvlowat to allow
struct_ops programs to dynamically adjust sk->sk_rcvlowat. It clamps
negative values to INT_MAX and delegates the update to __tcp_set_rcvlowat().

> diff --git a/net/ipv4/bpf_tcp_ops.c b/net/ipv4/bpf_tcp_ops.c
> index b0cade34cce65..e93c8d13684ef 100644
> --- a/net/ipv4/bpf_tcp_ops.c
> +++ b/net/ipv4/bpf_tcp_ops.c
[ ... ]
> @@ -368,8 +368,62 @@ static struct bpf_struct_ops bpf_tcp_ops =3D {
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
Does this code allow an out-of-bounds write via an unrelated socket type?

If a privileged user loads a TCP struct_ops BPF program with an enqueue_rcvq
callback, the program can extract skb->sk. After a NULL check, the verifier
treats it as a trusted struct sock.

If the packet was sent over the loopback interface by a UDP socket, skb->sk
points to a struct udp_sock. When this socket pointer is passed to
bpf_tcp_ops_set_rcvlowat(), it is handed directly to __tcp_set_rcvlowat()
which unconditionally casts it to struct tcp_sock:

net/ipv4/tcp.c:__tcp_set_rcvlowat() {
    struct tcp_sock *tp =3D tcp_sk(sk);
    ...
        if (tp->window_clamp && tp->window_clamp < val)
            WRITE_ONCE(tp->window_clamp, val);
    ...
}

Because struct udp_sock is much smaller than struct tcp_sock, could this
cast and subsequent WRITE_ONCE() corrupt adjacent slab objects? Should there
be a check to ensure the socket protocol is TCP before calling
__tcp_set_rcvlowat()?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923213719.2248=
38-1-kuniyu@google.com?part=3D7
