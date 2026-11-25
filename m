Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795579746;
	b=BzD2o94EtkKK1GQe34TMkcIqS+U5auRTyJQs6/SATJVH/hFiKfnVWUzdHbST6eBfzO6U
	 gIb0vbMD7JZAj5+ZUp6rquK2WwQgJjTuoGOdoF9R3z8lY0KXTxt9GTgsO4LWVNep0+G1M
	 IMVfoD2dmF8TbLXNDD7/tRZlHYyT5oLuHWmDZ95jlvbAfth4lmJ7gwH5PKEG6/cnpl4KC
	 iyIJPndSffXET0nl4gU8gQTt6S2O5GOvWmL+YDSAC8/9Ws/XHkbTJg2PEVLplbVsTtMy1
	 5ghNSxFsnCQkJcrLldjeh3LPvlpOnMguC4IGOWzpxJ8FJq+a9PsxZ0JH0zMvtxnABWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795579746;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZdSMfW5htbsisQkRt29uilLbzX1SFeWtFFXdedtBIyA=;
	b=Vm0qd88pW38tPm1fXLOT7EhwJeRneFo0h8Uh0eOUcn9+wL22rkIbByWwuAj/tgd7bpty
	 fLPumwbI2P6UgteAJTuhkjrkMBMRhtDrnMUSzbzf8Ch5DGKoUT/J7FayW4ovsvYANIBag
	 4i9KNuth6PzUFsMjdpTqE7Ob0irUf8NBQdyPIutPALyoAM54C/FDlixKqHLeLI1idWdkz
	 CMfFP+9Lu+TjvvK/uGsrBuSTT2+b31ILhoHJh84hI+0zAq4kivMSL4J2ALe1pfCIlvY5S
	 qE11UFAMHugng45LaPolGre26z/EvW4HgzwqMYTBqcjCNs98kJxKgWNr+boCCaKYsbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZKKJ4CBP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07210606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 04:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZKKJ4CBP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 224CA1F000C0;
	Wed, 25 Nov 2026 04:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795579745;
	bh=ZdSMfW5htbsisQkRt29uilLbzX1SFeWtFFXdedtBIyA=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=ZKKJ4CBPhnfzqwtYOXnR5DUKoZUctszivF8O/1bJ9fAwfCRsJeI3rdAKlRmD6Ll4d
	 MdTqfJT9UzKQ4YsHHk7lZ9ZtC8qdVmmxSXlV1Wha3Ege7wVH3SbA4ZUbYlow/mRbWq
	 Ys5WxhrLWOOvDfs41FoK/mZqhpM8Nb9hy3rkSVkpQA6Xg7INX7MxjZsCwcYJvFUEg6
	 gDLrFoAsIVRBCaixoNERgf5Pp3N4YtRQyVz9xPK73BuD0jIEKdA4KWqoVJjrY0AaRG
	 F5Jxa1sJ8hpITvUQDiMmwJldqtrnkVrKSP09nQR5hcWLRXqvULIjz2AK+1mh9hRSL5
	 NUGPH7EDt1fkw==
Message-ID: <sashiko-outbox-232555@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 44/47] bpf, sockmap: Keep the parser and
 sk_data_ready in sync
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261125032938.670542-45-alexei.starovoitov@gmail.com>
References: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
 <20261125032938.670542-45-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 04:09:04 +0000
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
- [High] bpf, sockmap: psock->copied_seq rewind on parser restart in
  sk_psock_init_strp()
--

commit 5ffc4095c0078d67e56f16b091670687eaa8b6e3
Author: Alexei Starovoitov <ast@kernel.org>

bpf, sockmap: Keep the parser and sk_data_ready in sync

This commit checks SK_PSOCK_RX_STRP_ENABLED before calling
strp_data_ready(), stops the stream parser when sk_data_ready is
restored on sockmap deletion, and restarts an already-initialized parser
instead of calling strp_init() again.

> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index 8a3b8536c0c21..1a0029f276e2f 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c

[ ... ]

> @@ -1157,7 +1159,7 @@ static void sk_psock_strp_data_ready(struct sock *s=
k)
> =20
>  int sk_psock_init_strp(struct sock *sk, struct sk_psock *psock)
>  {
> -	int ret;
> +	int ret =3D 0;
> =20
>  	static const struct strp_callbacks cb =3D {
>  		.rcv_msg	=3D sk_psock_strp_read,
> @@ -1165,7 +1167,11 @@ int sk_psock_init_strp(struct sock *sk, struct sk_=
psock *psock)
>  		.parse_msg	=3D sk_psock_strp_parse,
>  	};
> =20
> -	ret =3D strp_init(&psock->strp, sk, &cb);
> +	/* A stopped parser keeps its works and its skb until strp_done() */
> +	if (sk_psock_test_state(psock, SK_PSOCK_RX_STRP_ENABLED))
> +		psock->strp.stopped =3D 0;
> +	else
> +		ret =3D strp_init(&psock->strp, sk, &cb);
>  	if (!ret)
>  		sk_psock_set_state(psock, SK_PSOCK_RX_STRP_ENABLED);
> =20

[Severity: High]
Does restarting a stopped parser here rewind psock->copied_seq and cause
incoming TCP segments to be silently dropped?

Just below this hunk, sk_psock_init_strp() runs:

net/core/skmsg.c:sk_psock_init_strp() {
    ...
	if (sk_is_tcp(sk)) {
		psock->strp.cb.read_sock =3D tcp_bpf_strp_read_sock;
		psock->copied_seq =3D tcp_sk(sk)->copied_seq;
	}
    ...
}

When tcp_bpf_strp_read_sock() parses skbs and the verdict program returns
SK_PASS, the skbs are eaten from sk->sk_receive_queue and
psock->copied_seq advances, while tcp_sk(sk)->copied_seq stays behind by
psock->ingress_bytes until userspace reads from psock->ingress_msg.

If the parser is stopped and restarted while unread SK_PASS data sits in
psock->ingress_msg, resetting psock->copied_seq to tcp_sk(sk)->copied_seq
rewinds it below TCP_SKB_CB(skb)->seq of the next arriving segment in
sk->sk_receive_queue.  On the next read, tcp_recv_skb() computes
offset =3D seq - TCP_SKB_CB(skb)->seq, which underflows u32 to a value >=3D
skb->len and discards the unread skb via tcp_eat_recv_skb().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125032938.6705=
42-1-alexei.starovoitov@gmail.com?part=3D44
