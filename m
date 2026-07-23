Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC3E33F374
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 07:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784791243; cv=none; b=Xpxw8jbWQgOjoyeXitMUvQFBEwRVscpUxuBv70ChaEx+juqaX60yL9OGsrw4ZkAu8pOBBKdVznpwUkQS+ynp631yOywqxN6BRKEKgusoH4en4PQR2rlsMe9POGkRLTWXOXDbgLCGa4CP8YWlr5k/+o7aR330Se59VsvgPPPUK4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784791243; c=relaxed/simple;
	bh=Xc7iHQ9vCifxxmtI+QCjs2SntCkSRDI+lGnwA5kjAxM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GbMxVnjmjsAAftdTETE4pBbhVsV8yfoJm6CuvsrWZrp9Yj5wi0UAMmux6wUjhN4oufaughnLwp4Yx+1oMoKRp/L1NQpHhWnsn3f9vVbP0/84lEGwW1yU7rzeS6TxCMzp9dhAqxPx8liFC8w1JQ1lef9PPtlTQWkQgCM6X7QmPoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nheWqPU4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nheWqPU4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 141BB1F000E9;
	Thu, 23 Jul 2026 07:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784791241;
	bh=DL4D+XFCFeSLQ5CIbZcq7uY9YrNB8nCEppDYn/iFwfA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nheWqPU4hDrIonjSBq4G7ZZRxTA7x/uUfO30ihzK2VEvIiVo5rPUUDmrw1jgpD3wv
	 997GZ0Zk0+zU+W2wuJOvIWEMTPGLeaDmCM3PLX89oFvZOwd7rjClsZi3WtD3rL6rPk
	 t/0noVuunzKCmWaBlWMcVvXl2uZElwjdclOjVv+4rfD8xPUNlZrzfVMvTzRUaEX72n
	 aH7vVe7XuUEt16XXtu0A4jaHU9PPBMHADOUaVO+09CJev4Bq/dJW8r1lWtX+Gaiuzm
	 imHetGS4q60JGRfB11luShDFcH0DgcTeyksjGIlmFB0HyIX3oyrcAc/oweGCJMnwil
	 7BfIkUCnLkePQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf] bpf, sockmap: fix page_counter underflow in
 strparser SK_PASS
Reply-To: sashiko-reviews@lists.linux.dev
To: "Junseo Lim" <zirajs7@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260723065244.186916-1-zirajs7@gmail.com>
References: <20260723065244.186916-1-zirajs7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 07:20:40 +0000
Message-Id: <20260723072041.141BB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Bypassing memory accounting in strparser SK_PASS path allows r=
emote memory exhaustion (DoS)
--

--- Patch [1]: [PATCH bpf] bpf, sockmap: fix page_counter underflow in strp=
arser SK_PASS ---
commit 5073ca36b1b9677d098ec43e3f231a7423b5d727
Author: Junseo Lim <zirajs7@gmail.com>

bpf, sockmap: fix page_counter underflow in strparser SK_PASS
   =20
This patch adds a charge_skb flag to skip memory accounting in the direct
strparser SK_PASS path. It attempts to fix a page_counter underflow by
preventing duplicate charges on the cloned SKB.

> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index 2521b643fa05d..17260681479a3 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c

[ ... ]

> @@ -618,12 +616,14 @@ static int sk_psock_skb_ingress(struct sk_psock *ps=
ock, struct sk_buff *skb,

[ ... ]

>  static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_b=
uff *skb,
> -				     u32 off, u32 len, bool take_ref)
> +				     u32 off, u32 len, bool take_ref,
> +				     bool charge_skb)
>  {
>  	struct sk_msg *msg =3D alloc_sk_msg(GFP_ATOMIC);
>  	struct sock *sk =3D psock->sk;
> @@ -631,7 +631,8 @@ static int sk_psock_skb_ingress_self(struct sk_psock =
*psock, struct sk_buff *skb
> =20
>  	if (unlikely(!msg))
>  		return -EAGAIN;
> -	skb_set_owner_r(skb, sk);
> +	if (charge_skb)
> +		skb_set_owner_r(skb, sk);

[Severity: Critical]
Does skipping skb_set_owner_r() here leave the cloned SKB without an
accounted truesize and without a destructor?

When charge_skb is false, the cloned SKB is queued without being charged.
At the same time, __tcp_read_sock() unlinks and frees the original SKB via
tcp_eat_recv_skb().

This invokes sock_rfree() and immediately subtracts skb->truesize from
sk->sk_rmem_alloc.

Because this queued clone lacks a destructor and was never charged, could
sk_rmem_alloc artificially drop to 0?

If so, tcp_select_window() might compute free_space as if the buffer is
entirely empty, continuously advertising a fully open TCP window and
potentially allowing a remote attacker to stream infinite data and exhaust
kernel memory.

[ ... ]

> @@ -1017,6 +1018,8 @@ static int sk_psock_verdict_apply(struct sk_psock *=
psock, struct sk_buff *skb,
>  		 * retrying later from workqueue.
>  		 */
>  		if (skb_queue_empty(&psock->ingress_skb)) {
> +			bool charge_skb =3D true;
> +
>  			len =3D skb->len;
>  			off =3D 0;
>  			if (skb_bpf_strparser(skb)) {
> @@ -1024,8 +1027,10 @@ static int sk_psock_verdict_apply(struct sk_psock =
*psock, struct sk_buff *skb,
> =20
>  				off =3D stm->offset;
>  				len =3D stm->full_len;
> +				charge_skb =3D false;
>  			}
> -			err =3D sk_psock_skb_ingress_self(psock, skb, off, len, false);
> +			err =3D sk_psock_skb_ingress_self(psock, skb, off, len,
> +							false, charge_skb);
>  		}
>  		if (err < 0) {
>  			spin_lock_bh(&psock->ingress_lock);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723065244.1869=
16-1-zirajs7@gmail.com?part=3D1
