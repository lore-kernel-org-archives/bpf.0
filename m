Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC3A34CDD;
	Tue, 24 Feb 2026 17:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771955156; cv=none; b=coPBCtkhAcaYLEdXR4ZjF0/6W0BoBPJKhwdlO/vIxWsdLWI8tcM/GCQeB6gkoas5wMPCkX+qrD/qrwUO6ZYPuSdJd7A/ATmEDm2ZwSGzNPBBhoyh3iGcxcX5DcxHIozxfOUd8gBWeCoxX43ZT3hqh96svFW/ARgCPFmn6TsFzEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771955156; c=relaxed/simple;
	bh=fsV5OtmQB3MCcvqHSs0f1XcawGCHuZ+36al1QPuGjBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lD8HrGdpioXgA2YF+2RxYWWqL+6Hhk8tale9P9MuYdR7uvxDsx7mLygxIk/az70xsoC2cCzYbRlG9oN46IVBNf5ex+z9PkOY4efB8PO8bDOdI2MZgjEg+R2NUVEPa7QPFYqgH9OsNtX2v8/KfRqeQ+0sCqK6s/ZQp5ZJMJr8dCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RtH4k/hE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RtH4k/hE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF172C116D0;
	Tue, 24 Feb 2026 17:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771955156;
	bh=fsV5OtmQB3MCcvqHSs0f1XcawGCHuZ+36al1QPuGjBs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RtH4k/hE7nEZnU15GOAtp9wp/KmTvWE7qaI5tjRV7a8nRnVZ+X1IjTYIkXdLTybEM
	 XV4BW+Dm44O4QMuZfJ5jpAygzMC0QkEJrHcunM/qTlct0GoYCpaxi+08OaQ7g569/i
	 h1ywD//a+WKtwOCIwdcd7rM61MKB4DJB+vyFBzf7CdFwCfEYn8vuMcwJd2Hni2VduB
	 UxOPjJI0rhih49yRI2cpTA8QIwWSSeqkuw76rlRBlZgwNAqotw8qJWPlyrbnvg4Ei1
	 VvCTeVlEe6cN1QXn6QjwSEre9OhQY5lWmbRfBnCaWikfWlND+4qAU5K0ie6cDA/jkT
	 p8dp1FlYQYL3A==
Date: Tue, 24 Feb 2026 17:45:50 +0000
From: Simon Horman <horms@kernel.org>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Natalia Wochtman <natalia.wochtman@intel.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH iwl-next 03/10] ixgbevf: use libeth in Rx processing
Message-ID: <aZ3jzpKs7VcVi-mL@horms.kernel.org>
References: <20260223095222.3205363-1-larysa.zaremba@intel.com>
 <20260223095222.3205363-4-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223095222.3205363-4-larysa.zaremba@intel.com>

On Mon, Feb 23, 2026 at 10:52:10AM +0100, Larysa Zaremba wrote:
> Use page_pool buffers by the means of libeth in the Rx queues, this
> significantly reduces code complexity of the driver itself.
> 
> Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>

...

> @@ -3257,12 +3133,26 @@ static int ixgbevf_setup_all_tx_resources(struct ixgbevf_adapter *adapter)
>  int ixgbevf_setup_rx_resources(struct ixgbevf_adapter *adapter,
>  			       struct ixgbevf_ring *rx_ring)
>  {
> -	int size;
> +	struct libeth_fq fq = {
> +		.count		= rx_ring->count,
> +		.nid		= NUMA_NO_NODE,
> +		.type		= LIBETH_FQE_MTU,
> +		.xdp		= !!rx_ring->xdp_prog,
> +		.idx		= rx_ring->queue_index,
> +		.buf_len	= IXGBEVF_RX_PAGE_LEN(rx_ring->xdp_prog ?
> +						      LIBETH_XDP_HEADROOM :
> +						      LIBETH_SKB_HEADROOM),
> +	};
> +	int ret;
>  
> -	size = sizeof(struct ixgbevf_rx_buffer) * rx_ring->count;
> -	rx_ring->rx_buffer_info = vmalloc(size);
> -	if (!rx_ring->rx_buffer_info)
> -		goto err;
> +	ret = libeth_rx_fq_create(&fq, &rx_ring->q_vector->napi);
> +	if (ret)
> +		return ret;
> +
> +	rx_ring->pp = fq.pp;
> +	rx_ring->rx_fqes = fq.fqes;
> +	rx_ring->truesize = fq.truesize;
> +	rx_ring->rx_buf_len = fq.buf_len;
>  
>  	u64_stats_init(&rx_ring->syncp);
>  
> @@ -3270,25 +3160,29 @@ int ixgbevf_setup_rx_resources(struct ixgbevf_adapter *adapter,
>  	rx_ring->size = rx_ring->count * sizeof(union ixgbe_adv_rx_desc);
>  	rx_ring->size = ALIGN(rx_ring->size, 4096);
>  
> -	rx_ring->desc = dma_alloc_coherent(rx_ring->dev, rx_ring->size,
> +	rx_ring->desc = dma_alloc_coherent(fq.pp->p.dev, rx_ring->size,
>  					   &rx_ring->dma, GFP_KERNEL);
>  
>  	if (!rx_ring->desc)

Hi Larysa,

Prior to this patch, if this error condition was met,
then function would return -ENOMEM. But now it will return 0.
This does not seem intentional.

Flagged by Smatch.

>  		goto err;
>  
>  	/* XDP RX-queue info */
> -	if (xdp_rxq_info_reg(&rx_ring->xdp_rxq, adapter->netdev,
> -			     rx_ring->queue_index, 0) < 0)
> +	ret = __xdp_rxq_info_reg(&rx_ring->xdp_rxq, adapter->netdev,
> +				 rx_ring->queue_index, 0, rx_ring->truesize);
> +	if (ret)
>  		goto err;
>  
> +	xdp_rxq_info_attach_page_pool(&rx_ring->xdp_rxq, fq.pp);
> +
>  	rx_ring->xdp_prog = adapter->xdp_prog;
>  
>  	return 0;
>  err:
> -	vfree(rx_ring->rx_buffer_info);
> -	rx_ring->rx_buffer_info = NULL;
> +	libeth_rx_fq_destroy(&fq);
> +	rx_ring->rx_fqes = NULL;
> +	rx_ring->pp = NULL;
>  	dev_err(rx_ring->dev, "Unable to allocate memory for the Rx descriptor ring\n");
> -	return -ENOMEM;
> +	return ret;
>  }
>  
>  /**

...
