Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795258750;
	b=1qv7gKjttksEvHwiweQ1KL8anZ6Wa7ygTGZx26qOUyNLeShUUeJBFg7AJiEzaMNMKrYN
	 nx+04G6ER5VgSGOlKBJC0elnNWGzjWQ1LExNNAAwKe9bMCxu1eq3aDdwOcf8io78BKxRJ
	 PmrFy87W25ydvfWDxkGIAL1VKre2gqJEhd4hNFcAJKkxwxNlbpb45/8e8MNA+K+LWZN2L
	 SyUZS4dhGpMfO2PEG4y7hZ3EjmnwSwW/at7WhhZexQuRU4Sv45we0wVWFXKxjDrkKfZWY
	 +IModaM3LTj8Ce4xT5Kx2a9H+WP3Jd30CmyTRuQY6r1UrzmDFhYU5qw5uWnnchhh6LA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795258750;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Nm8oObJz8tSoGYtaEqjObc3D2GdwjES0wnO9CfqIokg=;
	b=psiG689oTZ06P8Y5iH6PJ8vbBa3Fbolr8a9pIZPsTYnGTjZbd34aOOWbdvUtk/bT7QCA
	 ikH80fILUXk9d1ixq1SAMDBesyeS1GlMupVo951pB2F7m8/24692bX3N2r0gk3laQ3GvL
	 JDSMgQJ6jSiUGrvGZwaiisFW1wT4mcyxusY0INLS4j34gq90YHAGfzGDxX6Y70zq5GZyC
	 1DfvJ7RJNqfvhgZ+KN3rUj4d+ZF5m6Kk4XYi2rYY3tz85HSqBq0Y1IwcHccvlw/JdHx/A
	 9Z47LBYSyrrUSzXWaSIJJfZTnl6T9CunPHz3qF1pUlCjZKD/nCAOcX/mruyBrYBrXBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mYYn9SXN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2704606A325
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 10:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mYYn9SXN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 877AD1F000CF;
	Sat, 21 Nov 2026 10:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795258749;
	bh=Nm8oObJz8tSoGYtaEqjObc3D2GdwjES0wnO9CfqIokg=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=mYYn9SXNAW6iKIvOJ+qtqws26Z/3VsqNsiJDofUet60OnJ5TggY3txgNpIk4tWKkz
	 hsBK10R9VjSD18BbJdaX4GZD5yFT4lwBOZ0uaU4h6ZtMmMBLTah/FnaDBpUJcHqbc5
	 98Ge1KSUe/Re/PsTzi0ueksMKR5egYvpONhOWqCDTz4Nf2bv5dNHCAOzxYoupkw9si
	 cF3mPPf6+MaNoD4NkD9j46OxuPuJ8OKl3cJCT+3/FH/x7V0FtpSPanxA/4uUtXqD19
	 kUHFzC8r5C3zmIiM51rspL9WQvIyLL+DW6EGlX3aB1LywJAZSJTEwhvDDoWq5jkdvO
	 Tppsx58HZ4PaQ==
Message-ID: <sashiko-outbox-226963@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 01/11] bpf, sockmap: Fix copied_seq updates with
 strparser
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>, bpf@vger.kernel.org
In-Reply-To: <20261121103222.88209-2-jiayuan.chen@linux.dev>
References: <20261121103222.88209-1-jiayuan.chen@linux.dev>
 <20261121103222.88209-2-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 10:59:07 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] bpf, sockmap: missing skb_orphan() on error in
  sk_psock_skb_ingress()
- [High] bpf, sockmap: multi-segment strparser message rewinds
  tp->copied_seq
--

commit 4f9dfdace1214b93f005e54687ec6d1b8e1449f2
Author: Jiayuan Chen <jiayuan.chen@linux.dev>

bpf, sockmap: Fix copied_seq updates with strparser

This commit updates tcp->copied_seq incrementally in
tcp_bpf_strp_read_sock() and tcp_bpf_recvmsg_parser(), moves
psock->ingress_bytes accounting to sk_psock_skb_ingress_self(), and
orphans strparser skbs when sk_psock_skb_ingress_enqueue() fails.

> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index 8a3b8536c0c21..16f84dcb5acd9 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
> @@ -574,9 +574,6 @@ static int sk_psock_skb_ingress_enqueue(struct sk_buf=
f *skb,
>  			return num_sge;
>  	}
> =20
> -#if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
> -	psock->ingress_bytes +=3D len;
> -#endif
>  	copied =3D len;
>  	msg->sg.start =3D 0;
>  	msg->sg.size =3D copied;
> @@ -642,8 +639,21 @@ static int sk_psock_skb_ingress_self(struct sk_psock=
 *psock, struct sk_buff *skb
>  	 */
>  	msg->sk =3D sk;
>  	err =3D sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg, tak=
e_ref);
> -	if (err < 0)
> +	if (err < 0) {
>  		kfree(msg);
> +		/*
> +		 * A strparser skb comes in without an owner and read_sock counts
> +		 * it as consumed once it is left to the backlog. Drop the owner
> +		 * again, or sk_psock_skb_ingress() takes the skb->sk =3D=3D sk path
> +		 * and recvmsg() counts it a second time.
> +		 */
> +		if (skb_bpf_strparser(skb))
> +			skb_orphan(skb);
> +	}
> +#if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
> +	else
> +		psock->ingress_bytes +=3D len;
> +#endif
>  	return err;
>  }

[Severity: High]
Does sk_psock_skb_ingress() also need to orphan the skb when
sk_psock_skb_ingress_enqueue() fails?

net/core/skmsg.c:sk_psock_skb_ingress() {
	if (unlikely(skb->sk =3D=3D sk))
		return sk_psock_skb_ingress_self(psock, skb, off, len, true);
	msg =3D sk_psock_create_ingress_msg(sk, skb);
	if (!msg)
		return -EAGAIN;

	skb_set_owner_r(skb, sk);
	err =3D sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg, true);
	if (err < 0)
		kfree(msg);
	return err;
}

When sk_psock_backlog() processes a strparser skb (or an skb redirected to
ingress from another socket), skb->sk !=3D sk, so sk_psock_skb_ingress()
calls skb_set_owner_r(skb, sk) and then sk_psock_skb_ingress_enqueue().  If
sk_psock_skb_ingress_enqueue() fails with -EAGAIN (for instance, when an
skb with more than MAX_MSG_FRAGS fragments fails skb_linearize() under
memory pressure), the skb stays on psock->ingress_skb with skb->sk =3D=3D sk
while sk_psock_backlog() has already stripped BPF_F_STRPARSER via
skb_bpf_redirect_clear().

On the next backlog run, sk_psock_skb_ingress() sees skb->sk =3D=3D sk and
takes the sk_psock_skb_ingress_self() branch without holding the socket
lock.  That modifies psock->ingress_bytes concurrently with
tcp_bpf_strp_read_sock() and sets msg->sk =3D sk, so
tcp_bpf_recvmsg_parser() adds the bytes to tcp->copied_seq a second time
(or counts foreign redirected bytes against this socket's
tcp->copied_seq), pushing tcp->copied_seq past rcv_nxt and stalling the
socket.

> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index 788ce08eef4d7..e59103e77aa5f 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
[ ... ]
> @@ -756,6 +753,7 @@ int tcp_bpf_strp_read_sock(struct strparser *strp, re=
ad_descriptor_t *desc,
>  	struct sk_psock *psock;
>  	struct tcp_sock *tp;
>  	int copied =3D 0;
> +	u32 seq;
> =20
>  	tp =3D tcp_sk(sk);
>  	rcu_read_lock();
> @@ -765,6 +763,7 @@ int tcp_bpf_strp_read_sock(struct strparser *strp, re=
ad_descriptor_t *desc,
>  		goto out;
>  	}
> =20
> +	seq =3D psock->copied_seq;
>  	psock->ingress_bytes =3D 0;
>  	copied =3D tcp_read_sock_noack(sk, desc, recv_actor, true,
>  				     &psock->copied_seq);
> @@ -775,7 +774,8 @@ int tcp_bpf_strp_read_sock(struct strparser *strp, re=
ad_descriptor_t *desc,
>  	 * For SK_REDIRECT, we need to ack the frame immediately but for
>  	 * SK_PASS, we want to delay the ack until tcp_bpf_recvmsg_parser().
>  	 */
> -	tp->copied_seq =3D psock->copied_seq - psock->ingress_bytes;
> +	WRITE_ONCE(tp->copied_seq, tp->copied_seq + psock->copied_seq - seq -
> +				   psock->ingress_bytes);
>  	tcp_rcv_space_adjust(sk);
>  	__tcp_cleanup_rbuf(sk, copied - psock->ingress_bytes);
>  out:

[Severity: High]
What happens here when a strparser message spans multiple TCP segments
across separate tcp_bpf_strp_read_sock() calls?

When the first segment of length L1 arrives and is buffered in
strp->skb_head awaiting the rest of the message, strp->cb.rcv_msg does not
run yet, so psock->copied_seq - seq is L1 and psock->ingress_bytes is 0.
tcp_bpf_strp_read_sock() advances tp->copied_seq by L1 and calls
__tcp_cleanup_rbuf(sk, L1) before any verdict runs (and if the partial
message later times out or hits a parser error, tp->copied_seq remains
permanently over-advanced by L1).

When the second segment of length L2 arrives and completes the message
with SK_PASS, sk_psock_verdict_apply() passes stm->full_len (L1 + L2) to
sk_psock_skb_ingress_self(), setting psock->ingress_bytes to L1 + L2 while
psock->copied_seq - seq is only L2.  Subtracting psock->ingress_bytes then
adds L2 - (L1 + L2) =3D -L1, rewinding tp->copied_seq backwards, and makes
copied - psock->ingress_bytes negative, which suppresses immediate ACKs in
__tcp_cleanup_rbuf() for any SK_REDIRECT frame processed in the same call.

Holding back tp->copied_seq for unread SK_PASS messages in ingress_msg
also inflates strp_peek_len() (which queries tcp_inq(), i.e. tp->rcv_nxt -
tp->copied_seq), so strp_recv() can see stm->strp.full_len -
stm->accum_len <=3D strp_peek_len(strp) on an intermediate segment and skip
updating strp->need_bytes, causing strp_data_ready() not to wake the
parser once the earlier message is read.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121103222.8820=
9-1-jiayuan.chen@linux.dev?part=3D1
