Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A641A262D;
	Fri,  3 Apr 2026 23:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775260598; cv=none; b=H6MkiSIzQ/O5YPTZ8a9IjlfsHBshjCjysOizoPr3QI7un8GapYFXcFthfJz4Vn2HRwlb5vtiKIzvcizatQe5gDSgMGEwCZkVgaW0HsKIiJrFHnIYE2fMnBjGnju43tBQ919Oi4eGcJ6knG31QdjMvNWGsMw5KnraYGF+ctsvQ9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775260598; c=relaxed/simple;
	bh=UTBAkQ9neJE5ofzAe8EoJOdScc3B7H+1wVjcdejfLXE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nnHlTmw9ffp8u30PndwqN7n6gvVpvUIYYh270gEQpXVSl/nr22IRlyULaD499zPoUSwA+rY6s1X4gx6NbeM2zpC9j5kwvq7VxRBRttHQPeIq+ZHIXQU/lCTjzcqgGWSH7XajD7xAe4XoXsvVmSY+KZ81qpDTDD66VHu/2n1iSy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=msMw8Xsx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="msMw8Xsx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 756A1C4CEF7;
	Fri,  3 Apr 2026 23:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775260597;
	bh=UTBAkQ9neJE5ofzAe8EoJOdScc3B7H+1wVjcdejfLXE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=msMw8XsxjRYu5Qo/LG2w1oxhFGH3qTNP+e6ZeC1dImikJ77b4ZXGx3XA9QhlqGJJ+
	 oit5I7F1Stpw2pTfs7XERpfiHyPfnX101tIhxe+WQMJU75tF4Oo4euZGlz4bS/Nu2P
	 wDaZyuHnmi01s5cYi/fd5Z9e1ydGm8UEEItUV1JEHSRzy2Wpa86h9uq3su8UFFhuBq
	 WyNz82GJf9XISqj2SlvCHfW9Qw6IBVr6XNoxUo9+kphoTQmklrWRLvo3oWL4lL2uH/
	 0rPWE3+VjvZqL86WHUWkAUsM7TkYkwk9Es17NkNORQbmddQztVgSDSPlniDDv+aY0D
	 bw+VdVawPdmRQ==
Date: Fri, 3 Apr 2026 16:56:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com,
 stfomichev@gmail.com, pabeni@redhat.com, horms@kernel.org,
 larysa.zaremba@intel.com, aleksander.lobakin@intel.com, bjorn@kernel.org
Subject: Re: [PATCH v6 net 3/8] xsk: fix XDP_UMEM_SG_FLAG issues
Message-ID: <20260403165636.1f4ee958@kernel.org>
In-Reply-To: <20260402154958.562179-4-maciej.fijalkowski@intel.com>
References: <20260402154958.562179-1-maciej.fijalkowski@intel.com>
	<20260402154958.562179-4-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  2 Apr 2026 17:49:53 +0200 Maciej Fijalkowski wrote:
> Currently xp_assign_dev_shared() is missing XDP_USE_SG being propagated
> to flags so set it in order to preserve mtu check that is supposed to be
> done only when no multi-buffer setup is in picture.
> 
> Also, this flag has the same value as XDP_UMEM_TX_SW_CSUM so we could
> get unexpected SG setups for software Tx checksums. Since csum flag is
> UAPI, modify value of XDP_UMEM_SG_FLAG.

should we maybe add:

BUILD_BUG_ON(XDP_UMEM_SG_FLAG & XDP_UMEM_FLAGS_VALID)

somewhere or use a hack like this ?

#define XDP_UMEM_SG_FLAG	(XDP_UMEM_FLAGS_VALID + 1)

> diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> index 23e8861e8b25..ebac60a3d8a1 100644
> --- a/include/net/xdp_sock.h
> +++ b/include/net/xdp_sock.h
> @@ -14,7 +14,7 @@
>  #include <linux/mm.h>
>  #include <net/sock.h>
>  
> -#define XDP_UMEM_SG_FLAG (1 << 1)
> +#define XDP_UMEM_SG_FLAG BIT(3)
>  
>  struct net_device;
>  struct xsk_queue;
> diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> index 37b7a68b89b3..729602a3cec0 100644
> --- a/net/xdp/xsk_buff_pool.c
> +++ b/net/xdp/xsk_buff_pool.c
> @@ -247,6 +247,10 @@ int xp_assign_dev_shared(struct xsk_buff_pool *pool, struct xdp_sock *umem_xs,
>  	struct xdp_umem *umem = umem_xs->umem;
>  
>  	flags = umem->zc ? XDP_ZEROCOPY : XDP_COPY;
> +
> +	if (umem->flags & XDP_UMEM_SG_FLAG)
> +		flags |= XDP_USE_SG;
> +
>  	if (umem_xs->pool->uses_need_wakeup)
>  		flags |= XDP_USE_NEED_WAKEUP;
>  

