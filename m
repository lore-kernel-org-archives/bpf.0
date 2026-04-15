Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5860C333729
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 09:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776244725; cv=none; b=CsqGil17ibUxKYsYBqF4oXl0c39I9yq3nUMg799pPDizh7Rd9LMtFvdFiG9KOEa0fmiesIdmIAlIFgdOTjdN5rHwNhsyPtmJZOwCMIwpSYT+PC9/fFVyDZHImYTamQ8Fv5tQ6PjVAfj0r9d4MkTr/vALjr/Nmwi3q/UcyNKlwv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776244725; c=relaxed/simple;
	bh=atF6zKerC9NOypgYy4GtrX3e1Q8OsS325oz/Ir9Bxjw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=H6Rx0KnqR0Q3el0FgBTpy6FV/mLL4riDhej/mhYmMDKRg8uCOepqBEMMTc24OBraqWJaiA6of7LaW9BXSRqm2PIrvYRNC3kjVBaLoO82SvlUX3Ia1rBNbI22qfHRHV998cHj39Or31PFV82kmSRzrvI6wXymPW3jEvHrPolPgUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gI7wIDly; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gI7wIDly"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4344C19424;
	Wed, 15 Apr 2026 09:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776244725;
	bh=atF6zKerC9NOypgYy4GtrX3e1Q8OsS325oz/Ir9Bxjw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=gI7wIDlyYXpyxNcifKRO7DWzl7aDV9/+aSvgIwmp4QUCnpH55QZbs71COYQsfmVXQ
	 fCvmEGzx1sz/ncovyCjQuAxGtrKf8sQ8K53KBkHUKRQIt5slk6sZoaoYTffdhDuckD
	 XpUmm0faktIS60KKcn2A3Bl9yqUHvZ8t9Y8D7zkQ5UN3G7406uWUbv48/anvT0CVRb
	 0CGDwH90ZsCUGz8KB6Z/rsO+uKZeE+XpjRFEb71LXmiraAnYwGfDJZZwe8rsToV6Qc
	 6W6DDxPj+v4hXyMTfobsU37dMljFDPTIq1n+G8rGOzAT27m404pFJsmrXCaQ/PmY00
	 wACDp+LOIfLew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC net-next v4 13/14] xsk: retire old xmit path in copy
 mode
Reply-To: sashiko@lists.linux.dev
To: "Jason Xing" <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260415082654.21026-14-kerneljasonxing@gmail.com>
References: <20260415082654.21026-14-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Apr 2026 09:18:44 +0000
Message-Id: <20260415091844.D4344C19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [Critical] Time-of-Check to Time-of-Use (TOCTOU) Use-After-Free (UAF) vul=
nerability on `batch->desc_cache`.
- [High] Leaked socket structure on error path in `xsk_create()`.
- [High] Unbounded `kmalloc` size for user-controlled batch size triggers `=
WARN_ON` and potential panic.
--

commit 5f2cebbff2efe715b882067f337741749751ac65
Author: Jason Xing <kernelxing@tencent.com>

xsk: retire old xmit path in copy mode

This commit adds a new helper xsk_init_batch() with a default value of 1,
and obsoletes __xsk_generic_xmit() by substituting it with
__xsk_generic_xmit_batch() in the generic transmit path.

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 16e47f6fc30ec..232e7bf96b342 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
[ ... ]
> @@ -1030,101 +1030,14 @@ static int __xsk_generic_xmit_batch(struct xdp_s=
ock *xs)
>  	return err;
>  }
> =20
[ ... ]
>  static int xsk_generic_xmit(struct sock *sk)
>  {
> +	struct xdp_sock *xs =3D xdp_sk(sk);
>  	int ret;
> =20
>  	/* Drop the RCU lock since the SKB path might sleep. */
>  	rcu_read_unlock();
> -	ret =3D __xsk_generic_xmit(sk);
> +	ret =3D __xsk_generic_xmit_batch(xs);

By switching to __xsk_generic_xmit_batch(), does this expose a
use-after-free race with xsk_setsockopt()?

In __xsk_generic_xmit_batch(), the local pointer descs is assigned
batch->desc_cache before acquiring xs->mutex.

Concurrently, a user can call setsockopt(..., XDP_GENERIC_XMIT_BATCH),
which acquires xs->mutex and updates the batch size via xsk_init_batch().
This safely frees the old desc_cache array using kvfree() in
xsk_batch_reset() because the setsockopt path does not check for
xs->state !=3D XSK_READY.

Once setsockopt drops the mutex, the blocked __xsk_generic_xmit_batch()
thread acquires the mutex and proceeds to use its stale descs pointer.
Can this lead to a use-after-free write into the freed descriptor array?

>  	/* Reaquire RCU lock before going into common code. */
>  	rcu_read_lock();
[ ... ]
> @@ -1620,6 +1533,34 @@ struct xdp_umem_reg_v1 {
>  	__u32 headroom;
>  };
> =20
> +static int xsk_init_batch(struct xsk_batch *batch, unsigned int size)
> +{
> +	struct xdp_desc *descs;
> +	struct sk_buff **skbs;
> +	void **data;
> +
> +	skbs =3D kmalloc(size * sizeof(struct sk_buff *), GFP_KERNEL);

Can this trigger a WARN_ON_ONCE in the page allocator if a user requests
a very large batch size?

The size parameter is controlled by userspace via the XDP_GENERIC_XMIT_BATCH
setsockopt and is bounded by the TX ring size (xs->max_tx_budget), which
can be quite large.

Since these pointer arrays can exceed KMALLOC_MAX_SIZE, should this be
allocated using kvmalloc_array() similar to how the descs array is
allocated below?

> +	if (!skbs)
> +		return -ENOMEM;
> +
> +	data =3D kmalloc_array(size, sizeof(void *), GFP_KERNEL);
> +	if (!data) {
> +		kfree(skbs);
> +		return -ENOMEM;
> +	}
> +
> +	descs =3D kvcalloc(size, sizeof(struct xdp_desc), GFP_KERNEL);
[ ... ]
> @@ -2065,6 +1984,11 @@ static int xsk_create(struct net *net, struct sock=
et *sock, int protocol,
>  	if (!sk)
>  		return -ENOBUFS;
> =20
> +	xs =3D xdp_sk(sk);
> +	ret =3D xsk_init_batch(&xs->batch, 1);
> +	if (ret)
> +		return ret;
> +

Does this leak the sk object if xsk_init_batch() fails?

If xsk_init_batch() returns an error here, the function returns early
without calling sk_free(sk).

Because sock_init_data() has not been executed yet to link the sk to the
sock structure, the VFS socket layer will not free the socket memory when
tearing down the failed creation. Should this path clean up the allocated
socket before returning?

>  	sock->ops =3D &xsk_proto_ops;
> =20
>  	sock_init_data(sock, sk);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260415082654.2102=
6-1-kerneljasonxing@gmail.com?part=3D13
