Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4863CBE75
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 18:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780510486; cv=none; b=LKqylj/iBlKjby6lSi0SStf7lE0VrZG1SxuHecbB40uqLTKTbslrfSU7G3/RtJ4c7YEBnvg0XNbeVk8NtwZSJn4iA3Wy1yDL+wWfCN67V5tbu90ZO9V53tQZSXt5Wro9jyo+iuhbbWi0SAcUPbAWDlAQAyamnJjTZXccfBPKr08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780510486; c=relaxed/simple;
	bh=7wyhagYve3qVDJkqFip1pCbXZPyGAuUuewROLUXIQ04=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=b0DAqEnKgZ6DyDksN48YtnWxq8ZVcBiycxJTst1nKHcfbVpCdM8oetnVT9TV0Ai34bJFz6US9ZZ1XZAWf3msBkXXwd95/zATI5ImL1tx7TqrXkP5LqGl9qNkqIrEu1yjHPTuQs934P2Vex+sDfzzi4nnfbx8Oy9L2h8neZzpknY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JLBHr1Nv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JLBHr1Nv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C5F11F00898;
	Wed,  3 Jun 2026 18:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780510484;
	bh=7qxXSrhY/QBKkt7H79In4b0ZNX2q101wbGL2/c6EQFI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JLBHr1NvPiNZ63kJYqXrZzCSFQOaX3/bfRnohJRBrHsg3Z+PlfVtG07KaBiJuF3bt
	 3d/j9In7LmqFGvieOVaK6bxwftbLeLCaAbnptZ7YZUZH6dH+Ic/xuRstsFUz5kLwGY
	 EJytYQuxQdeiVQDRwnVmb4q/gT7EOL2u85LAUHTbYNGRnv7fnlwWnWqt1VYte1ts2Z
	 5LUle6VlOBCyifdF67ylwONR7eI8LB7P3LH7fPqZ5M9DUDkuCXYf0jOf5s7Dhf2t04
	 Fx1TIa888rwcTG/oOJbXUawmDoEJ/dP22z96cCLraVTruvOCaYTJbxGCYyqtNegP2T
	 n7pL5Ij0IGIeQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 1/2] tcp: rehash onto different local ECMP path on
 retransmit timeout
Reply-To: sashiko-reviews@lists.linux.dev
To: "Neil Spring" <ntspring@meta.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260602181428.2318919-2-ntspring@meta.com>
References: <20260602181428.2318919-2-ntspring@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 18:14:44 +0000
Message-Id: <20260603181444.9C5F11F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Missing mp_hash initialization in tcp_v6_send_response() causes TC=
P control packets (RST, TIME_WAIT ACKs) to use a different ECMP path than d=
ata packets.
- [High] Unconditional txhash randomization in BPF syncookies breaks symmet=
ric ECMP routing for IPv6.
- [Medium] IPv4-mapped IPv6 connections incorrectly apply IPv6-specific coo=
kie txhash logic, biasing queue distribution.

Pre-existing issues:
- [Critical] bpf_sk_assign_tcp_reqsk() partially initializes tcp_request_so=
ck, leading to uninitialized slab memory usage and wild pointer dereference=
s.
--

commit e48c642c65c933dd8659dee905bbd3b1d86dd5a3
Author: Neil Spring <ntspring@meta.com>

tcp: rehash onto different local ECMP path on retransmit timeout

This patch updates TCP to select a different local ECMP path upon
retransmit timeout, path MTU discovery, or spurious retransmissions by
propagating the socket's txhash into the IPv6 multipath hash logic. It
ensures the cached destination is invalidated so the next transmit triggers
a fresh route lookup using the new hash. Syncookies are also updated to
derive txhash from the cookie for IPv6 to maintain ECMP path consistency.

> diff --git a/net/core/filter.c b/net/core/filter.c
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -12301,6 +12301,7 @@ __bpf_kfunc int bpf_sk_assign_tcp_reqsk(struct __=
sk_buff *s, struct sock *sk,
> =20
>  	treq->req_usec_ts =3D !!attrs->usec_ts_ok;
>  	treq->ts_off =3D tsoff;
> +	treq->txhash =3D net_tx_rndhash();
> =20

[Severity: Critical]
This is a pre-existing issue, but since inet_reqsk_alloc() allocates the
request socket via a slab cache without zeroing memory, do the other fields
of tcp_request_sock (such as used_tcp_ao and af_specific) remain
uninitialized garbage?

If so, when tcp_create_openreq_child() is called later and dereferences
treq->af_specific->md5_lookup, could this result in a kernel panic from
evaluating the uninitialized pointers?

[Severity: High]
Does initializing txhash to a random value here break symmetric ECMP
routing for IPv6 BPF syncookies?

Since standard IPv6 syncookies set txhash to the cookie to maintain path
symmetry with the SYN-ACK, would this random initialization cause data
packets to route over a completely different ECMP path than the SYN/SYN-ACK
exchange?

>  	skb_orphan(skb);

[ ... ]

> diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
> --- a/net/ipv4/syncookies.c
> +++ b/net/ipv4/syncookies.c
> @@ -280,9 +280,18 @@ static int cookie_tcp_reqsk_init(struct sock *sk, st=
ruct sk_buff *skb,
>  	treq->snt_synack =3D 0;
>  	treq->snt_tsval_first =3D 0;
>  	treq->tfo_listener =3D false;
> -	treq->txhash =3D net_tx_rndhash();
>  	treq->rcv_isn =3D ntohl(th->seq) - 1;
>  	treq->snt_isn =3D ntohl(th->ack_seq) - 1;
> +	if (sk->sk_family =3D=3D AF_INET6) {
> +		/* Use the cookie as txhash so the ECMP path matches
> +		 * the SYN-ACK, where txhash was also set to the
> +		 * cookie.  The original request socket (and its
> +		 * txhash) was freed after sending the SYN-ACK.
> +		 */
> +		treq->txhash =3D treq->snt_isn;
> +	} else {
> +		treq->txhash =3D net_tx_rndhash();
> +	}

[Severity: Medium]
Can dual-stack listeners (IPv4-mapped IPv6) be negatively affected by this
check?

Since sk->sk_family is AF_INET6 for these listeners even when accepting IPv4
connections, would IPv4 connections incorrectly execute
treq->txhash =3D treq->snt_isn?

As noted in the commit message, the IPv4 cookie contains mssind bits that
could bias queue distribution if used as a hash.

>  	treq->syn_tos =3D TCP_SKB_CB(skb)->ip_dsfield;

[ ... ]

> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -275,6 +277,15 @@ static int tcp_v6_connect(struct sock *sk, struct so=
ckaddr_unsized *uaddr,
> =20
>  	security_sk_classify_flow(sk, flowi6_to_flowi_common(fl6));
> =20
> +	/* Non-zero mp_hash bypasses rt6_multipath_hash() in
> +	 * fib6_select_path(), letting txhash control ECMP path
> +	 * selection so that sk_rethink_txhash() rehashes onto a
> +	 * different path.  Policies 1-3 derive a deterministic
> +	 * hash from the flow keys and must not be overridden.
> +	 */
> +	if (ip6_multipath_hash_policy(net) =3D=3D 0 && sk->sk_txhash)
> +		fl6->mp_hash =3D (sk->sk_txhash >> 1) ?: 1;
> +

[Severity: High]
Does the missing mp_hash initialization in tcp_v6_send_response() cause TCP
control packets (like RST and TIME_WAIT ACKs) to use a different ECMP path
than data packets?

If tcp_v6_send_response() doesn't set fl6.mp_hash, it seems
fib6_select_path() will fall back to rt6_multipath_hash(). If the data path
was rehashed to recover from a failure, wouldn't the RSTs stay on the
broken default path and be dropped?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602181428.2318=
919-1-ntspring@meta.com?part=3D1
