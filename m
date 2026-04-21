Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BFD34EEF4
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 18:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776794528; cv=none; b=Gvk3XNINZe2+oeU0gywzeoXrL4fkE1bZDydbkA0sxTj+/Kj6WFQmUFq6gAUtt5CSSOuS+L2lDU5bOhRUULFPprS6fIzM3BFQ9m6GP+iopiC7H/ScPRg7WIXtMgWhp4b6V8OcORzYeZfXgMmKWBetsxRGezTGYy2mFVJvFOANYnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776794528; c=relaxed/simple;
	bh=bTjn1BnbfeH9cL0MirmwgwRiK6MuCd6FazLPtOWHwsM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sbef21jvBPSfK9TeSxQ7ryBGTB/luKxuhRN91eYagQgwCC/5JEcJN6YRmt2wdXGOrcGpC4ujH81VICkWhKZdAYHwbHAJP+sb/wgPfxnxhgt9gcyKt7p+g8N/+XDUflK90XLFqajER8gMl1BGcoCqfLo4ykGtgkeUC/XEc4pReEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iaxci3Iu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iaxci3Iu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB811C2BCB0;
	Tue, 21 Apr 2026 18:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776794527;
	bh=bTjn1BnbfeH9cL0MirmwgwRiK6MuCd6FazLPtOWHwsM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=iaxci3Iu/QCh3/1/ID4EnxNqxIUer3hplUGbV078TMY0iwloXTDcNZ6yf00aVJAi3
	 E0pEc33WUpTEpLAY+RfoQovjzbfK4LUMCAG9uZHtbzc0YZlh6UaykFdmhZwKFD5Mpw
	 9IqDLy7R/HW8fDlizmjCmigGIkOdXe47pkNM9CEIc3opUEUVKTo6uC6WOMBpPwu9fX
	 lP4xKO6X2RKIFiwGyKGa5x8JJgPoEQjMtXi2Nd5XoLxQyPUyMvqdbBFsdo/H6lojyg
	 od0XimcGjkPgRnVpIJP9Qxr5u3Kh0D12wLUhMeMY4AsIKMvQ+JMzeVBK6VxLvQbQa9
	 eF91bCOFH+FFw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18] xsk: validate MTU against usable frame
 size on bind
Reply-To: sashiko@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260420132314.1023554-312-sashal@kernel.org>
References: <20260420132314.1023554-312-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Apr 2026 18:02:06 +0000
Message-Id: <20260421180207.BB811C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 4 potential issue(s):
- [Critical] The patch references undefined functions `__xsk_pool_get_rx_fr=
ame_size()` and `xsk_pool_get_tailroom()`, which will cause a build failure.
- [High] Secondary sockets binding to a shared UMEM drop the `XDP_USE_SG` f=
lag, causing spurious MTU validation failures.
- [High] The `XDP_UMEM_SG_FLAG` is set on the persistent UMEM object before=
 the new MTU validation and is not reverted on failure, leading to socket s=
tate corruption.
- [High] An integer underflow in the calculation of `frame_size` bypasses t=
he MTU validation, allowing out-of-bounds DMA writes.
--

commit f3a660b520a18a5f378e6506df30590629252c09
Author: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

    xsk: validate MTU against usable frame size on bind

AF_XDP bind currently accepts zero-copy pool configurations without
verifying that the device MTU fits into the usable frame space provided
by the UMEM chunk. 2k chunk size might not provide enough space for
standard 1500 MTU, so catch such settings at bind time.

Link: https://patch.msgid.link/20260402154958.562179-5-maciej.fijalkowski@i=
ntel.com

> diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> index aa9788f20d0db..5641de2ed60d1 100644
> --- a/net/xdp/xsk_buff_pool.c
> +++ b/net/xdp/xsk_buff_pool.c
> @@ -165,8 +167,12 @@ static void xp_disable_drv_zc(struct xsk_buff_pool *=
pool)
>  int xp_assign_dev(struct xsk_buff_pool *pool,
>  		  struct net_device *netdev, u16 queue_id, u16 flags)
>  {
> +	u32 needed =3D netdev->mtu + ETH_PAD_LEN;
> +	u32 segs =3D netdev->xdp_zc_max_segs;
> +	bool mbuf =3D flags & XDP_USE_SG;

Secondary sockets binding to a shared UMEM omit the XDP_USE_SG flag in
xp_assign_dev_shared(). Does this cause mbuf to evaluate to false and
force segs =3D 1, leading to spurious MTU validation failures for secondary
sockets on devices with jumbo frames?

>  	bool force_zc, force_copy;
>  	struct netdev_bpf bpf;
> +	u32 frame_size;
>  	int err =3D 0;
> =20
>  	ASSERT_RTNL();

[ ... ]

> @@ -186,7 +192,7 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
>  	if (err)
>  		return err;
> =20
> -	if (flags & XDP_USE_SG)
> +	if (mbuf)
>  		pool->umem->flags |=3D XDP_UMEM_SG_FLAG;

If the MTU validation fails later in this function, the XDP_UMEM_SG_FLAG
will remain set on the persistent UMEM object. Can this cause a subsequent
bind on the same UMEM without XDP_USE_SG to bypass SG device setup but
still be placed in multi-buffer mode, leading to driver inconsistency?

[ ... ]

> @@ -208,8 +214,24 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
>  		goto err_unreg_pool;
>  	}
> =20
> -	if (netdev->xdp_zc_max_segs =3D=3D 1 && (flags & XDP_USE_SG)) {
> -		err =3D -EOPNOTSUPP;
> +	if (mbuf) {
> +		if (segs =3D=3D 1) {
> +			err =3D -EOPNOTSUPP;
> +			goto err_unreg_pool;
> +		}
> +	} else {
> +		segs =3D 1;
> +	}
> +
> +	/* open-code xsk_pool_get_rx_frame_size() as pool->dev is not
> +	 * set yet at this point; we are before getting down to driver
> +	 */
> +	frame_size =3D __xsk_pool_get_rx_frame_size(pool) -
> +		     xsk_pool_get_tailroom(mbuf);

Are __xsk_pool_get_rx_frame_size() and xsk_pool_get_tailroom() defined
in the kernel tree? It looks like this might cause an implicit function
declaration error and break the build. The comment mentions open-coding
these functions, but they appear to be called directly.

Also, if the XDP UMEM is configured with a large headroom, the available
rx frame size could be smaller than the tailroom. Would this subtraction
underflow the u32 frame_size, leading to a huge positive value that bypasses
the MTU validation and allows out-of-bounds DMA writes?

> +	frame_size =3D ALIGN_DOWN(frame_size, 128);
> +
> +	if (needed > frame_size * segs) {
> +		err =3D -EINVAL;
>  		goto err_unreg_pool;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260420132314.1023=
554-312-sashal@kernel.org?part=3D1
