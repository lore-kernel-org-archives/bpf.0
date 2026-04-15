Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E713C37E2F9
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 08:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776243099; cv=none; b=XgmFLF4ZT17lrCyLa1XExV4AWFtBtyt8wByJzv2XUmLPzo4wC2ZbQtJYCSVhonO+aHOIJ07wvvqlIvsr4rM7EoAIsEFuUlxc4CtpZVC5uom86KlJQbvAJAN2N3k8rkRsyaxbud+tWZxjybEHIb3Bl6W5hKvr1odW3VmXYTHghL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776243099; c=relaxed/simple;
	bh=UG4sk3wjqX5cpYc1p7fKT+ASgFX6TD9VVrHngA27GUs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h93cgQcqfSKYCCs4tY2Z2Gy5NwCinPRiF8roVE1Jq4nmtfwaeB1GBI8e3J14EzzDpGzqiwFNJK0BfYwmv/IHT9les0PDBonzVj1/TckYnD9Ps3bYBvFFGBFrEgAb0zx+wzM2T0E/XDd2JyJNcRWE/asXPpykkTLVZC3T76qa8RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pHNMBeB2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pHNMBeB2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 703C8C19424;
	Wed, 15 Apr 2026 08:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776243098;
	bh=UG4sk3wjqX5cpYc1p7fKT+ASgFX6TD9VVrHngA27GUs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=pHNMBeB2gfbM+Rt6n36pho+uJwBRffSo73+F6toFB5bh7Q4+0Lrcj12dOOOvLixh3
	 nihid2DUx3UvR/bhRWoLuCmXIcta3Tm40sgwpBsq7J7HuI+ggtHYecOq5XYC02qpFc
	 pSgFO/83o3CGg/62xbpb/cbwQicAUiqKbAsHkV0u5JwSG/u9p3KDMsR0aQCTYEtTcG
	 eoHiPnhafNb7GeKoj/YNp5EaxgZB9TuEW3aAW2O2q78sH4PJqI5MC3Bhd15LZR/Uzk
	 W+neMKxppCfS81DLEI9ytO/1UTB82J1xIuB3xVTKeEh7dQQYxU9sPluEHV5mjvmAAY
	 5IME9NNBBuUtw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC net-next v4 01/14] xsk: introduce
 XDP_GENERIC_XMIT_BATCH setsockopt
Reply-To: sashiko@lists.linux.dev
To: "Jason Xing" <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260415082654.21026-2-kerneljasonxing@gmail.com>
References: <20260415082654.21026-2-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Apr 2026 08:51:37 +0000
Message-Id: <20260415085138.703C8C19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [High] Unsafe array allocation using kmalloc for a potentially large, use=
r-controlled size
--

commit 16fdf26210767cd884154d2717d7894d96a2ee54
Author: Jason Xing <kernelxing@tencent.com>
xsk: introduce XDP_GENERIC_XMIT_BATCH setsockopt

This commit introduces the XDP_GENERIC_XMIT_BATCH setsockopt to allow
batch processing in copy mode, attempting to improve throughput by=20
allocating and initializing multiple skbs at one time.

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 3b46bc635c432..1194268ae8676 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
[ ... ]
> @@ -1582,6 +1593,42 @@ static int xsk_setsockopt(struct socket *sock, int=
 level, int optname,
>  		WRITE_ONCE(xs->max_tx_budget, budget);
>  		return 0;
>  	}
> +	case XDP_GENERIC_XMIT_BATCH:
> +	{
> +		struct xsk_buff_pool *pool =3D xs->pool;
> +		struct xsk_batch *batch =3D &xs->batch;
> +		struct xdp_desc *descs;
> +		struct sk_buff **skbs;
> +		unsigned int size;
> +		int ret =3D 0;
> +
> +		if (optlen !=3D sizeof(size))
> +			return -EINVAL;
> +		if (copy_from_sockptr(&size, optval, sizeof(size)))
> +			return -EFAULT;
> +		if (size =3D=3D batch->generic_xmit_batch)
> +			return 0;
> +		if (!size || size > xs->max_tx_budget || !pool)
> +			return -EACCES;
> +
> +		mutex_lock(&xs->mutex);
> +		skbs =3D kmalloc(size * sizeof(struct sk_buff *), GFP_KERNEL);

Can the requested size here become large enough to trigger high-order
allocation failures under memory fragmentation?

Since size is bounded by xs->max_tx_budget, which follows the TX ring
entries, it looks like this could reach up to 65536 on some configurations.
A 512KB contiguous allocation via kmalloc might fail on long-running
systems and trigger page allocation warnings in the kernel log.

Also, since size is a user-provided value bounded only by the maximum
budget, could the open-coded multiplication overflow on 32-bit platforms?

Would it be safer to use kvmalloc_array() here to prevent both integer
overflows and the dependency on physically contiguous memory, similar to
how kvcalloc() is used for the descs array right below it?

> +		if (!skbs) {
> +			ret =3D -ENOMEM;
> +			goto out;
> +		}
> +		descs =3D kvcalloc(size, sizeof(struct xdp_desc), GFP_KERNEL);
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260415082654.2102=
6-1-kerneljasonxing@gmail.com?part=3D1
