Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B877C314D1E;
	Tue, 17 Mar 2026 09:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773739849; cv=none; b=Nqc3J211zrojT2cY/fR0QYeurO6tUCFs8uo6TvDHcXALJl3X4kw5gZ1Yl8jO/2G/clrTrj4ojwbAJwyqMr7hSW7F98zHAM6LywXXRaannfLOKgHGv98YdxqfTE+cj42RISnf3kSY+meLBuz4NFJ/qSS6UZQnrhKds/mP+GSbO+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773739849; c=relaxed/simple;
	bh=Tw/rnTLYKS4Urzz+msvBuIWHlyg5TGSnKFRnFbTTRtk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O9FO2YufYxHOk0FSJz862kAY+pH0nCBGPewhbtONmC2T0lYEc/Cu91YO09ufpbNW8fIQ3mgqHkzW3DKTLqlKtdhbfkmOZV/xbl3eGBEK7h+QygevmGI0Ysk96RC6H81I1b6OOeG3hCNcNTLSI97acXARv/KGjUPUo7hSxgeiUXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0DB0rAa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0DB0rAa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0FF0C2BC9E;
	Tue, 17 Mar 2026 09:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773739849;
	bh=Tw/rnTLYKS4Urzz+msvBuIWHlyg5TGSnKFRnFbTTRtk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Y0DB0rAaK/nP2tGp/3BWOGWaGpnu1esqxrZ9Xmx2hDORUdO/zh7PYmlXU1Z8bac3a
	 6GFZT1pHRrKkQ3rJ2ywlWidJKJKtvmBV/XmuUjQ7+tm/KPNzZHl32OkDYEd2GUeQ0H
	 ej6os3egWujB1lD/9SG/g1tQdrumN92G+5SNjrb0wZ46ncnTLLNCDGyuTBmNKOF3/N
	 BQHJWey5FUj0g0oRmad6FnhcmSipwv8d+h2YpI3fBfUIucS+DwnSC+A8/FO96kwvm0
	 6dDHCSnEYilyjKaKtJiqtWH4m6NYlq9goHtA0I3Tf/DgMxJlC5Lx3x72e3PEc9u/G3
	 tqk9tS7I2QkSA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, magnus.karlsson@intel.com, stfomichev@gmail.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 larysa.zaremba@intel.com, aleksander.lobakin@intel.com, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH net 4/6] xsk: validate MTU against usable frame size on
 bind
In-Reply-To: <20260316174550.462177-5-maciej.fijalkowski@intel.com>
References: <20260316174550.462177-1-maciej.fijalkowski@intel.com>
 <20260316174550.462177-5-maciej.fijalkowski@intel.com>
Date: Tue, 17 Mar 2026 10:30:46 +0100
Message-ID: <87qzpipzuh.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:

> AF_XDP bind currently accepts zero-copy pool configurations without
> verifying that the device MTU fits into the usable frame space provided
> by the UMEM chunk.
>
> This becomes a problem since we started to respect tailroom which is
> subtracted from chunk_size (among with headroom). 2k chunk size might
> not provide enough space for standard 1500 MTU, so let us catch such
> settings at bind time.
>
> This prevents creating an already-invalid setup and complements the
> MTU change restriction for devices with an attached XSK pool.
>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  net/xdp/xsk_buff_pool.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> index 2cfc19e363e3..0a6d76df97dc 100644
> --- a/net/xdp/xsk_buff_pool.c
> +++ b/net/xdp/xsk_buff_pool.c
> @@ -157,6 +157,7 @@ static void xp_disable_drv_zc(struct xsk_buff_pool *pool)
>  int xp_assign_dev(struct xsk_buff_pool *pool,
>  		  struct net_device *netdev, u16 queue_id, u16 flags)
>  {
> +	bool mbuf = flags & XDP_USE_SG;
>  	bool force_zc, force_copy;
>  	struct netdev_bpf bpf;
>  	int err = 0;
> @@ -178,7 +179,7 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
>  	if (err)
>  		return err;
>  
> -	if (flags & XDP_USE_SG)
> +	if (mbuf)
>  		pool->umem->flags |= XDP_UMEM_SG_FLAG;
>  
>  	if (flags & XDP_USE_NEED_WAKEUP)
> @@ -200,11 +201,19 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
>  		goto err_unreg_pool;
>  	}
>  
> -	if (netdev->xdp_zc_max_segs == 1 && (flags & XDP_USE_SG)) {
> +	if (netdev->xdp_zc_max_segs == 1 && mbuf) {
>  		err = -EOPNOTSUPP;
>  		goto err_unreg_pool;
>  	}
>  
> +	if (!mbuf) {
> +		if (netdev->mtu + netdev->hard_header_len >
> +				xsk_pool_get_rx_frame_size(pool)) {
> +			err = -EOPNOTSUPP;

Hmm, EINVAL?
