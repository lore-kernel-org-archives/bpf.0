Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B81353A60
	for <bpf@vger.kernel.org>; Sat, 25 Jul 2026 16:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784998051; cv=none; b=GZGcGD0OGdyU5j7OwWyty4wInCDw34+mO6UJ0ESxHuk8Topl1/XhFmIXJd6G51w6oTZ5ysXL2SX9I3M7OMvKxcesTm3ff7YuZJLeq3+I2aTLjy0ZTZ/Db8xmcIXeCRDXERnaGGn9kko6QrZMsOD3S1n/nbUtcs8a7T2yyQxsqsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784998051; c=relaxed/simple;
	bh=yawoDYxXYUHkREbZrp1DC2pUtxnWJGFbbNbxsw0iZ/M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mXJbavJa/p+6PjzLs83MIC7xclO9HShswfIIPh3OJMkAfJvidLbzLZhwZPZ4PN+ikLXwt4/2Qmq1mz7tA0TyDajY/Vp7qeslKfNiN0ffbPWDsDz2EIhikqnNd88uugruN7ctNfRHteW7LaVQoA5AbUJX949mtAiEAhI/QpTaRpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Woeh6k6X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Woeh6k6X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB941F000E9;
	Sat, 25 Jul 2026 16:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784998049;
	bh=wVd4ZTP8olfExz9FphqkjKYBKdgnHwDEEEsqkKO8+wA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Woeh6k6XPHbE1+Wt1oGq9yWgsDV0E4O1U1iVgN1nH/gprcPqAkAQyrKPQMpbYTm2T
	 /+vwWMt7mAVFXN9aNHUP/n3Y0M3Tud2LzQPwget54ekHEEbFdCuNktSLYbylCl4Zf8
	 7XPJDbxy4sHdIGvrawxCJjPk1UCxWoomiNi2BPYxnhS3LxsTlStvc8kdx8+5UC1Eyl
	 CPc14vn31nzWYXOKMSXfpIWrxpqg4tLu5skJ91mIx9BIkE99U2CRTri1+53diVeB1B
	 t13gYZHagfYB8Qke2vSqtQ0iKHybvImY6PTjWN+Pl2Ijpe05/DH5j67FGbSqC0nDNL
	 5AWc06sRKlosg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] xsk: fix NULL pointer dereference in __xsk_rcv()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?Q2VuIFpoYW5nIChNaWNyb3NvZnQp?= <blbllhy@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260724164719.99563-1-blbllhy@gmail.com>
References: <20260724164719.99563-1-blbllhy@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 16:47:28 +0000
Message-Id: <20260725164729.6BB941F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Rolling back the RX ring via xskq_prod_cancel_n() leaks previously=
 allocated UMEM buffers on multi-buffer packet allocation failure.
--

--- Patch [1]: [PATCH net] xsk: fix NULL pointer dereference in __xsk_rcv()=
 ---
commit 53feb1519cd9a4933abf6d79d7b04cb89df34c4b
Author: Cen Zhang (Microsoft) <blbllhy@gmail.com>

xsk: fix NULL pointer dereference in __xsk_rcv()

This commit fixes a NULL pointer dereference in the multi-buffer receive pa=
th
of __xsk_rcv(). It introduces a check for when xsk_buff_alloc() fails and
uses xskq_prod_cancel_n() to roll back partially submitted RX ring descript=
ors
to ensure no incomplete multi-buffer packet is delivered to userspace.

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index b970f30ea9b9d..3aad3996bd803 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c

[ ... ]

> @@ -348,6 +349,11 @@ static int __xsk_rcv(struct xdp_sock *xs, struct xdp=
_buff *xdp, u32 len)
>  		u32 copied;
> =20
>  		xsk_xdp =3D xsk_buff_alloc(xs->pool);
> +		if (!xsk_xdp) {
> +			xskq_prod_cancel_n(xs->rx, nb_submitted);
> +			xs->rx_dropped++;
> +			return -ENOMEM;
> +		}

[Severity: High]
Does this error path leak the UMEM chunks from previous loop iterations?

If an earlier fragment was allocated and submitted to the RX ring via
__xsk_rcv_zc_safe() (which internally calls xp_release()), and a subsequent
allocation fails here, xskq_prod_cancel_n() rewinds the RX ring's local
producer pointer.

Because the previously reserved descriptors are cancelled without manually
retrieving and returning their UMEM chunks to the kernel's free list, will
those chunks be permanently lost, allowing a user to exhaust the shared
UMEM pools by intentionally feeding invalid descriptors?

>  		copy_to =3D xsk_xdp->data - meta_len;
> =20
>  		copied =3D xsk_copy_xdp(copy_to, &copy_from, to_len, &from_len, &frag,=
 rem);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724164719.9956=
3-1-blbllhy@gmail.com?part=3D1
