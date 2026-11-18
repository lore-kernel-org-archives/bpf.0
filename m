Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795006049;
	b=MhYMT11h8NxCKSlOKYVTxx84ZkN1gprf3625Av1uSbpzbV9aDyREM0ZkJ7I9vHY++UNc
	 iqR5Nsuft5QBxl6OZcMs6Sf/qlYRbtAaqzh4AedDH9YzoXBJ1BTz8urRADX4yXp5ZvBDZ
	 8e2fUWcJt7Cmm8z5G7VMWwQYDjnFd3eHKrNurPDa4m16N4DDfZ+PWmR6WGv+WKHYUNFNy
	 YxogXNAOSHdzLxPfqKXwkk6ZnrClOSH2nST61x8lgEmhCq+K38CGWOBgBmUbHenNGkqjc
	 tUIvRB02QYPIEQztBjXzLT06Buo/ZA+Eklt2sXaxpqmOZ1vZn1zdNnztqsPt0LkdRpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795006049;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6KBwKotutrSEAZ3coDWA+O4Fwd0VhFbEzAdgAaRK53k=;
	b=T2+x58sIMVZUMvQFYpaY6T0kzR78ggwY/xPW82fQ6tSQNFy3Ejw6YPYuhzJduSicLStI
	 v/7ZG46/fyLxqlBCP0jD1HuGsBRTLXmQSRsn+XcSEw9FP1yxOj4D4MOXEXDsn4P8+3W2h
	 a1mJu3HRk1q8HUiWf5Vc0otx2UtoabpqefKFX9ryrtyCBmpomoTV/OAg22rTz54zD7V3l
	 B2MvV383Im6nMj77/Qllpz5Vm45NQTyPuCT8Q9ey5H74N0uoGi+mG0YCZn6aI1+SAgeJ9
	 SSOVhwbaTS9VASD0e1+N9wzz7oiDIypUV43Fj+GGheL8cL2jV5550kYfpusJxz2J+Zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VpbBi4Wh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1C3606A325
	for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 12:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VpbBi4Wh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 304C81F000C4;
	Wed, 18 Nov 2026 12:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795006049;
	bh=6KBwKotutrSEAZ3coDWA+O4Fwd0VhFbEzAdgAaRK53k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VpbBi4WhVllAMMJjOjzuYb4pCBwpck+8iGkIpFJaRfJWHNvc/3UeocTQw1N9CHosZ
	 LuQhYHrJgSOL0tEen2LaOCiBO2gCt4O3drl897a4uxpO+1WXwAUC9aaGGAE5vXW1jn
	 oDpRCQ9DbVLU/tyx7Wm1CRJLUh0+hunBYO4S4rSQDHtFgMqQ+SIKRllRZUsxvDqZCX
	 IDbl+/EZpZyPIwUomDVJxZTEaqioCNAWsjyeAwYneH3dsbbIrgEnSJZDFakgiUAdrZ
	 XqGu6uVWLgmJQmTeA4/nBJ/kSXuBQsojawujLTPZj125Ny5qQjGVeht9XdRP6vnZGW
	 RNtj5q1dxBB/g==
Message-ID: <sashiko-outbox-220941@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 2/2] tcp: accecn: initialize AccECN fields in
 syncookie path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thaison Phan" <thaisonphan@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261117124710.1338951-3-thaisonphan@google.com>
References: <20261117124710.1338951-1-thaisonphan@google.com>
 <20261117124710.1338951-3-thaisonphan@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 12:47:28 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] tcp: accecn: missing 3rd ACK option init in
  cookie_tcp_reqsk_init()
--

commit 5acfc9564ef55de35a9a6f13ac1b4466ed5e7a69
Author: Thaison Phan <thaisonphan@google.com>

tcp: accecn: initialize AccECN fields in syncookie path

This commit initializes saw_accecn_opt, accecn_fail_mode, syn_ect_rcv, and
syn_ect_snt on the request_sock constructed in the IPv4 and IPv6 syncookie
paths.

> diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
> index 4e0ff3b820627..1a837ed6efa00 100644
> --- a/net/ipv4/syncookies.c
> +++ b/net/ipv4/syncookies.c
> @@ -290,6 +290,9 @@ static int cookie_tcp_reqsk_init(struct sock *sk, str=
uct sk_buff *skb,
>  	 */
>  	treq->txhash =3D treq->snt_isn;
>  	treq->syn_tos =3D TCP_SKB_CB(skb)->ip_dsfield;
> +	treq->saw_accecn_opt =3D TCP_ACCECN_OPT_NOT_SEEN;
> +	treq->accecn_fail_mode =3D 0;
> +	treq->syn_ect_rcv =3D 0;
> =20
>  #if IS_ENABLED(CONFIG_MPTCP)
>  	treq->is_mptcp =3D sk_is_mptcp(sk);
> @@ -502,6 +505,7 @@ struct sock *cookie_v4_check(struct sock *sk, struct =
sk_buff *skb)
>  		ireq->rcv_wscale =3D rcv_wscale;
>  	ireq->ecn_ok &=3D cookie_ecn_ok(net, &rt->dst);
>  	treq->accecn_ok =3D ireq->ecn_ok && cookie_accecn_ok(th);
> +	treq->syn_ect_snt =3D READ_ONCE(inet_sk(sk)->tos) & INET_ECN_MASK;
> =20
>  	ret =3D tcp_get_cookie_sock(sk, skb, req, &rt->dst);
>  	/* ip_queue_xmit() depends on our flow being setup

[Severity: Medium]
Does the syncookie path leave tp->saw_accecn_opt stuck at
TCP_ACCECN_OPT_NOT_SEEN when the peer includes an AccECN option on the
third ACK?

In the normal SYN-RECV path, tcp_check_req() calls tcp_accecn_option_init()
on the third ACK to update treq->saw_accecn_opt and treq->accecn_fail_mode
before tcp_ecn_openreq_child() copies them to the child socket.  The
syncookie path bypasses tcp_check_req(), and when tcp_child_process() later
runs tcp_rcv_state_process() -> tcp_ack() on that third ACK, neither
FLAG_FORWARD_PROGRESS nor FLAG_TS_PROGRESS is set, so
__tcp_accecn_process() returns before calling tcp_accecn_process_option().

The established child socket then starts with tp->saw_accecn_opt set to
TCP_ACCECN_OPT_NOT_SEEN, which suppresses outgoing AccECN options in
tcp_established_options(), reports tcpi_accecn_opt_seen as 0 in TCP_INFO,
and skips zeroed-option detection (TCP_ACCECN_OPT_FAIL_RECV) on the third
ACK.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117124710.1338=
951-1-thaisonphan@google.com?part=3D2
