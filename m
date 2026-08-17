Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248AC421259
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 16:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786983062; cv=none; b=WW7nRrq0pMudAy3eqFCTy+wM6bMvz6A72aLMTgu1CqtolrwCEMKjzzpLlKrZvyCKtTGbwtqhrWOQuPX3zX7qQHgIQwOLgAjvFk7BkU/tCyt/nbWe51JJpF4FYRY5K05MYsH4eTWNUjwyCR0Ip0xJ7wvqqPeSdXr0DUFVrUXVKH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786983062; c=relaxed/simple;
	bh=fsxIDgRUuPksdxJSz4PyibIQrqU0djLP2lkWAJnTTS0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N7U4+t7rUIMQ/imBlIRoYaSGLm9ajWGQOJxejOz43bhsGf09UrQlYvrWTBYI2hzNekIHqWwgjjjlyO9r+GW+PFcACW+pOgkbn1mILP30pDDACCJrGsjSzJrZFYEGy/PrJVjNyff/MB0ivbEZ1BGx0bEn1CMss4VefQZGZ6Lz2AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NxSn8fym; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NxSn8fym"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A7391F000E9;
	Mon, 17 Aug 2026 16:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786983060;
	bh=CbQYiNzA1IFHo4pNj/PkEXqAbEY8AZLXol+UC+anx4o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NxSn8fym/hvMK7rbKo93mzOjmuQBdNDm2Fq42ztDrfTlW2qY1rWaoBqJMuCqmgKaW
	 9P68JAGxGakP6D1CRcBXnZeL4wmNUbdp0Jl6J8FyeALSYF5gMRAeboaOy2P3XB93HZ
	 bs1SyVoXfArWxOvnwMi8faAe66WsXLyaqofpr9QkQ5e3VLgKqkBfLAgvHm+5cErKDD
	 UdY+AmMW4TyYLcISQSUT2/AhU4474RWZYGexEtbRvLGt7JAj8UzblJZ4FY4SwuifSm
	 xhHfnpzrGYo95Fz9Ipl1KVUcvD9fHB6DHkuO/3BgxxrlVlRPYeC8AnyP6/2vMsnXm3
	 WcjnJ6Ib0G+SQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v3 1/2] bpf, sockmap: settle sk_forward_alloc for
 strparser SK_PASS
Reply-To: sashiko-reviews@lists.linux.dev
To: "Junseo Lim" <zirajs7@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260817155009.232670-2-zirajs7@gmail.com>
References: <20260817155009.232670-1-zirajs7@gmail.com>
 <20260817155009.232670-2-zirajs7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 16:11:00 +0000
Message-Id: <20260817161100.7A7391F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] Multi-line comments added in the patch violate the BPF subsystem co=
mment style.

Pre-existing issues:
- [High] Missing socket lock in sk_psock_skb_ingress() for cross-socket red=
irects causes sk_forward_alloc corruption.
--

--- Patch [1]: [PATCH bpf v3 1/2] bpf, sockmap: settle sk_forward_alloc for=
 strparser SK_PASS ---
commit 74acfd67ff001cb4d8a5e9b0c6aaa8bfc595f145
Author: Junseo Lim <zirajs7@gmail.com>

bpf, sockmap: settle sk_forward_alloc for strparser SK_PASS

This commit addresses sk_forward_alloc deficits caused by strparser SK_PASS
queuing cloned skbs back to the same socket. It settles any deficit before
assigning receive ownership to unowned self-pass skbs.

> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index 2521b643fa05d..347cb168f7491 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
[ ... ]
>  static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *=
skb,
> -				u32 off, u32 len)
> +				u32 off, u32 len, bool settle_fwd_alloc)
>  {
>  	struct sock *sk =3D psock->sk;
>  	struct sk_msg *msg;
>  	int err;
> =20
>  	if (unlikely(skb->sk =3D=3D sk))
> -		return sk_psock_skb_ingress_self(psock, skb, off, len, true);
> +		return sk_psock_skb_ingress_self_backlog(psock, skb, off,
> +							 len, true,
> +							 settle_fwd_alloc);
>  	msg =3D sk_psock_create_ingress_msg(sk, skb);
>  	if (!msg)
>  		return -EAGAIN;

[Severity: High]
This is a pre-existing issue, but does this cross-socket redirect path modi=
fy
sk_forward_alloc without holding the socket lock?

When called asynchronously from the backlog workqueue:
sk_psock_backlog() -> sk_psock_handle_skb() -> sk_psock_skb_ingress()

If the skb is redirected to a different socket (where skb->sk does not match
the destination sk), it bypasses the self_backlog path which properly holds
lock_sock(sk). It then proceeds to call sk_psock_create_ingress_msg() and
skb_set_owner_r() without the target socket's lock. Since sk_forward_alloc
is updated via non-atomic operations, could concurrent updates to the target
socket corrupt sk_forward_alloc and cause page_counter underflows?

> @@ -618,34 +621,100 @@ static int sk_psock_skb_ingress(struct sk_psock *p=
sock, struct sk_buff *skb,
[ ... ]
> +/* Puts an skb on the ingress queue for psock->sk.
> + *
> + * If the skb already has receive ownership for this socket, leave socket
> + * memory accounting untouched. Otherwise, before assigning receive owne=
rship
> + * to an unowned strparser SK_PASS skb, settle any existing sk_forward_a=
lloc
> + * deficit from earlier clone charges.
>   */
>  static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_b=
uff *skb,

[Severity: Low]
This isn't a bug, but does this comment format follow the BPF subsystem
style?

The BPF subsystem uses the modern kernel multi-line comment style, which
requires the opening /* to be on its own line.

[ ... ]
> +	/* This is used in tcp_bpf_recvmsg_parser() to determine whether the
> +	 * data originates from the socket's own protocol stack. No need to
> +	 * refcount sk because msg's lifetime is bound to sk via the ingress_ms=
g.
> +	 */
> +	msg->sk =3D sk;

[Severity: Low]
This isn't a bug, but should this multi-line comment also have its opening
/* on a separate line to match the subsystem conventions?

[ ... ]
> +static int sk_psock_skb_ingress_self_backlog(struct sk_psock *psock,
[ ... ]
> +	/* This is used in tcp_bpf_recvmsg_parser() to determine whether the
> +	 * data originates from the socket's own protocol stack. No need to
> +	 * refcount sk because msg's lifetime is bound to sk via the ingress_ms=
g.
> +	 */
> +	msg->sk =3D sk;

[Severity: Low]
This isn't a bug, but is the opening /* on the same line missing the BPF
comment style requirement here as well?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817155009.2326=
70-1-zirajs7@gmail.com?part=3D1
