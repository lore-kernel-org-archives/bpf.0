Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE83285404;
	Wed, 25 Feb 2026 18:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772045959; cv=none; b=FoLa89BumPaCkAMwBxPUIynik7lUbEyYK/HrU3anD44KblTNMORYJKBD5IqStVxfSEZkNBb5RUvcayHcVjAfhnymKuEcasTXYCZ8Ds6RmY1QPDeR7KxkkeIJs2E+R8QrvS4VBD8U3a+HtWPsjm0/ycBwoRmc7WD1cOEKQRMsq5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772045959; c=relaxed/simple;
	bh=qr/8zkXTrBexFHqdNRMIfPEVZTEVjEz09gdNgjV+FeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aOH4RK20KBj18pEVq1ulifb2ZcFAmUcmAPpdWfXKfOqOOvnKWBBJ+b9WPoXx+TmnOtxjbiTYBPlEspRZzKhMq2MJnX1naygiNED012BDOryy1x3LF4Ch9KyNLCWZBk8lZ0g4UtmDE6lnfN0ibDAqweKgUZAUaZfALbW3PTOgONM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3uEev/N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3uEev/N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AFABC116D0;
	Wed, 25 Feb 2026 18:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772045959;
	bh=qr/8zkXTrBexFHqdNRMIfPEVZTEVjEz09gdNgjV+FeE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h3uEev/Nnr5GfiXpGkDAdsrSy81ecxVAh6LYEdE4MKMOXsRNjQLWgyJQERJAxxPnZ
	 AjPHKxedKhtw5ifCyjCsG3+7wsiH1Isw/bLHWaYJgswn+zprFqty7aY39lXLdJFm69
	 bbJNNSNBMuXelyeTQiQe7DFQwNo8qTaG0mkgZXLYamWAnreryiXmEhumrdC5AcQqoq
	 G3Uh3hjZQn2+Z6liMmyL/0Cox3t2X4yBZmf98j4aN2t+nCnflO0a+myQk0L1BYtCmO
	 7oU3Snx2SEnJu61ddeYmWbggNnb08Edszc1mM8fFQnpE1Wmlgxb5P/Vi/PbHEZ8+hl
	 me9PuGz3EkeFQ==
Date: Wed, 25 Feb 2026 18:59:13 +0000
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
Message-ID: <aZ9GgZxwP-S2gX5e@horms.kernel.org>
References: <20260223095222.3205363-1-larysa.zaremba@intel.com>
 <20260223095222.3205363-4-larysa.zaremba@intel.com>
 <aZ3jzpKs7VcVi-mL@horms.kernel.org>
 <aZ8vNEn7V4VVoOHr@soc-5CG4396X81.clients.intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZ8vNEn7V4VVoOHr@soc-5CG4396X81.clients.intel.com>

On Wed, Feb 25, 2026 at 06:19:48PM +0100, Larysa Zaremba wrote:
> On Tue, Feb 24, 2026 at 05:45:50PM +0000, Simon Horman wrote:
> > On Mon, Feb 23, 2026 at 10:52:10AM +0100, Larysa Zaremba wrote:
> > > Use page_pool buffers by the means of libeth in the Rx queues, this
> > > significantly reduces code complexity of the driver itself.
> > > 
> > > Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> > > Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> > > Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> > > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > 
> > ...
> > 
> > > @@ -3257,12 +3133,26 @@ static int ixgbevf_setup_all_tx_resources(struct ixgbevf_adapter *adapter)
> > >  int ixgbevf_setup_rx_resources(struct ixgbevf_adapter *adapter,
> > >  			       struct ixgbevf_ring *rx_ring)
> > >  {
> > > -	int size;
> > > +	struct libeth_fq fq = {
> > > +		.count		= rx_ring->count,
> > > +		.nid		= NUMA_NO_NODE,
> > > +		.type		= LIBETH_FQE_MTU,
> > > +		.xdp		= !!rx_ring->xdp_prog,
> > > +		.idx		= rx_ring->queue_index,
> > > +		.buf_len	= IXGBEVF_RX_PAGE_LEN(rx_ring->xdp_prog ?
> > > +						      LIBETH_XDP_HEADROOM :
> > > +						      LIBETH_SKB_HEADROOM),
> > > +	};
> > > +	int ret;
> > >  
> > > -	size = sizeof(struct ixgbevf_rx_buffer) * rx_ring->count;
> > > -	rx_ring->rx_buffer_info = vmalloc(size);
> > > -	if (!rx_ring->rx_buffer_info)
> > > -		goto err;
> > > +	ret = libeth_rx_fq_create(&fq, &rx_ring->q_vector->napi);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	rx_ring->pp = fq.pp;
> > > +	rx_ring->rx_fqes = fq.fqes;
> > > +	rx_ring->truesize = fq.truesize;
> > > +	rx_ring->rx_buf_len = fq.buf_len;
> > >  
> > >  	u64_stats_init(&rx_ring->syncp);
> > >  
> > > @@ -3270,25 +3160,29 @@ int ixgbevf_setup_rx_resources(struct ixgbevf_adapter *adapter,
> > >  	rx_ring->size = rx_ring->count * sizeof(union ixgbe_adv_rx_desc);
> > >  	rx_ring->size = ALIGN(rx_ring->size, 4096);
> > >  
> > > -	rx_ring->desc = dma_alloc_coherent(rx_ring->dev, rx_ring->size,
> > > +	rx_ring->desc = dma_alloc_coherent(fq.pp->p.dev, rx_ring->size,
> > >  					   &rx_ring->dma, GFP_KERNEL);
> > >  
> > >  	if (!rx_ring->desc)
> > 
> > Hi Larysa,
> > 
> > Prior to this patch, if this error condition was met,
> > then function would return -ENOMEM. But now it will return 0.
> > This does not seem intentional.
> > 
> > Flagged by Smatch.
> 
> No, it is not intentional, though the problem is fixed in a later patch.
> Will correct this one in v2.

Thanks, and sorry for not noticing that it is fixed later in the series.
