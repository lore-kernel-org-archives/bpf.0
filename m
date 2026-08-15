Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623AF3947B0
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 23:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786837768; cv=none; b=cofnbLFUO8hso1n/zHvSaJDvPlNfLGRmXBybmYKM6TbqNaxaCe9LGpfjiHeLTvzMQL4wHk1vOdYlNetbZcXbRb3+VO0jGr/eR6QaQplr5vr9/eq4oyBVacpNqBkYW3vzSB2P/EoPypjW72p/bHejej74jIG504pyTVXgpgXcjFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786837768; c=relaxed/simple;
	bh=A7GN3PmMHHdVVVx6JBjOGpWpJWzE0as12TA6jBqNYNU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tn/Hp6jHc1rt4Ifici8vqLHg3M2fKb+IkTnXzKV/JVgsSn8RsUeWI0TfBuXIqsULmQCz4zPqBcKfNr56aqV/rBxKpggwPhlkPgDeC0QShwVTVPxe9eLTUmy9Wj097sumYEC/FlaR0P9AQAVRa5k0c982GwuNM69TXXzz3RnGCbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c4PUDUW2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c4PUDUW2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 335531F000E9;
	Sat, 15 Aug 2026 23:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786837767;
	bh=Cus7HlRiguIDz5VIY2XBq0+udeHwJODJx76OQNT+IZI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c4PUDUW2XqgZWHKyzFNsTeZINSmX4ts/dXPflQeNYbhXv3EBQ1PNOgBExI9CPubk4
	 k39ysa484Cs8O1pNZ+tfFlhq5UhTEAPES/zB9kmnP+XwMPqENkxGWV45kj4r/bWM4W
	 ecl903di67gC4QtjO+Pte450HY/IHTn9OyfQ8FcZ+ozGHIkxXyut6vtkdTVpa0U0Sk
	 1faWR5ZawTZFZ0pFpetuRy7fYc997YPtjGaiqLKelRqme/tp/sw8O9nBSu+Q9aaNV8
	 f+Ebrp5Q1kSwN1fTVcTx5X+TcdmwGZApZusNVH0ni3FjxpVsQuB76V9CRv7mWij8A7
	 ZXZtty0VYQ9vw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 6/6] gve: fix NULL dereference from premature XSK
 pool DMA unmap
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joshua Washington" <joshwash@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260814234845.773189-7-joshwash@google.com>
References: <20260814234845.773189-1-joshwash@google.com>
 <20260814234845.773189-7-joshwash@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 23:49:26 +0000
Message-Id: <20260815234927.335531F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Kernel panic via NULL pointer dereference on XSK pool disable erro=
r path.
--

--- Patch [6]: [PATCH net 6/6] gve: fix NULL dereference from premature XSK=
 pool DMA unmap ---
commit 70486a861c2e62f343665b0b44d80a866b2cbd87
Author: Joshua Washington <joshwash@google.com>

gve: fix NULL dereference from premature XSK pool DMA unmap

This commit defers the XSK pool DMA unmapping in gve_xsk_pool_disable()
until after the NAPI rings are disabled, aiming to prevent a race
condition that causes a NULL pointer dereference.

> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/eth=
ernet/google/gve/gve_main.c
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
[ ... ]
> @@ -1681,28 +1681,24 @@ static int gve_xsk_pool_disable(struct net_device=
 *dev,
>  	/* Stop and start RDA queues to repost buffers. */
>  	if (!gve_is_qpl(priv) && priv->xdp_prog) {
>  		err =3D gve_configure_rings_xdp(priv, priv->rx_cfg.num_queues);
>  		if (err)
> -			return err;
> +			goto unmap_and_return;

[Severity: High]
This is a pre-existing issue, but if gve_configure_rings_xdp() fails
(for example, due to a memory allocation failure), doesn't this goto bypass
the calls to napi_disable_locked() and gve_unreg_xsk_pool()?

[ ... ]
> -	return 0;
> +unmap_and_return:
> +	pool =3D xsk_get_pool_from_qid(dev, qid);
> +	if (pool)
> +		xsk_pool_dma_unmap(pool,
> +				   DMA_ATTR_SKIP_CPU_SYNC |
> +				   DMA_ATTR_WEAK_ORDERING);
> +
> +	return err;
>  }

[Severity: High]
If we reached this label via the gve_configure_rings_xdp() error path,
is it safe to call xsk_pool_dma_unmap() here?

Since the NAPI polling wasn't disabled and the active hardware ring's
xsk_pool pointer wasn't cleared, couldn't the still-active NAPI thread
dereference the unmapped pool->dev (which xsk_pool_dma_unmap() sets to
NULL) on the next packet, resulting in the exact same kernel panic this
patch is trying to prevent?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814234845.7731=
89-1-joshwash@google.com?part=3D6
