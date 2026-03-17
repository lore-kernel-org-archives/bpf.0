Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D7935CB87;
	Tue, 17 Mar 2026 09:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773739264; cv=none; b=lu7XPxs49IMSm4r5t1kOYl9CQd5b3feEvcslmtbp86uu/iQgateg7RH4rGDbfUWWftHnnNoM8nrWj9C51YyMaU7fAlax5WiixoIk8y2Lt2WUWvFvKQJFR56sG40koUgfPgIX+9PrwjU2KleM/m3uRlzwIdHUNfH4Zet68UwJqtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773739264; c=relaxed/simple;
	bh=5oTyZ1K8Ny0oP/DwI3MzKd7vmK/CIuyGhJB3xMfiehk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=prXrkbPGeoNrbOwffZMRVIxRGR4JMF5yLDQuSAAyILC1Xhf8qXQmH5iDQ4LqryUnh1YdP1idXL4vXjLq19PzP83ySCnq1qMOmLVxRqLwCFZT1NuE5eI9vducbL2Esz8bSX8UpdOftWMaqwPneffxXMlDDJ47q7B+yTTamMC+agM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Egc45Cpk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Egc45Cpk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82598C2BC9E;
	Tue, 17 Mar 2026 09:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773739264;
	bh=5oTyZ1K8Ny0oP/DwI3MzKd7vmK/CIuyGhJB3xMfiehk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Egc45CpknDt3zjpmdcJWbYzexnCUT4CEFBDSibzKKlck7MmmSlEs5YyPbg5ryt2DA
	 g+XvQRzhFwdBZ+S9HbeaNKjfVtvNFLsB6YWwtFbmmlB0YGUrGxsJl2DqOYgO2CvAhq
	 vYsiqYlaDCLi6ir+gK8hnpdIU9BTfDYmA4hlGkKkCv3GaxF9M3mh19ok+UPQNATLj6
	 rEW4px6uTym0KLTdeDrT8SLxiJcYEZ/oRLypgDCBVYrS7/xt7XA4yWXf8I4mHClUIP
	 cvBmj0E/PhsOR3bRTfEQ6YkYVkvWMhQp9pp2AXB0r5ymthmv8RNFeitbvvBZcXH8Ja
	 hfQOZ8pxO/UnQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, magnus.karlsson@intel.com, stfomichev@gmail.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 larysa.zaremba@intel.com, aleksander.lobakin@intel.com, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH net 2/6] ice: do not round up result of dbuff
 calculation for xsk pool
In-Reply-To: <20260316174550.462177-3-maciej.fijalkowski@intel.com>
References: <20260316174550.462177-1-maciej.fijalkowski@intel.com>
 <20260316174550.462177-3-maciej.fijalkowski@intel.com>
Date: Tue, 17 Mar 2026 10:21:00 +0100
Message-ID: <874imerev7.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:

> When programming dbuff on rx queue context, avoid division round up as
> it causes to actually corrupt the tailroom for AF_XDP ZC. Below is an
> example based on 4k chunk size when xsk pool pointer is valid on given
> rx ring:
>
> chunk_size = 4096
> headroom = 256
> tailroom = 320
>
> ring->rx_buf_len = 4096 - 256 - 320 = 3520
>
> rx_ctx.dbuff = DIV_ROUND_UP(3520, 128) ->
> 3520 / 128 = 27.5 -> round up results in 28
>
> dbuff programming unit is 128. If we give 128 * 28 = 3584. So HW will
> corrupt 64 bytes from tailroom. Doing plain division will floor the
> result and would not exceed reserved space at the end.
>
> Also, restore ::rx_buf_len setting via xsk_pool_get_rx_frame_size() as
> of now it respects the tailroom.
>
> Fixes: 1bbc04de607b ("ice: xsk: add RX multi-buffer support")
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_base.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
> index 1667f686ff75..930688bd3476 100644
> --- a/drivers/net/ethernet/intel/ice/ice_base.c
> +++ b/drivers/net/ethernet/intel/ice/ice_base.c
> @@ -498,8 +498,11 @@ static int ice_setup_rx_ctx(struct ice_rx_ring *ring)
>  	/* Receive Packet Data Buffer Size.
>  	 * The Packet Data Buffer Size is defined in 128 byte units.
>  	 */
> -	rlan_ctx.dbuf = DIV_ROUND_UP(ring->rx_buf_len,
> -				     BIT_ULL(ICE_RLAN_CTX_DBUF_S));
> +	if (ring->xsk_pool)
> +		rlan_ctx.dbuf = ring->rx_buf_len / BIT_ULL(ICE_RLAN_CTX_DBUF_S);
> +	else
> +		rlan_ctx.dbuf = DIV_ROUND_UP(ring->rx_buf_len,
> +					     BIT_ULL(ICE_RLAN_CTX_DBUF_S));

nit: Maybe put the BIT_ULL() in a variable (steps/unit?) and use ?: 
