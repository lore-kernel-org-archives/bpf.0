Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63CE30F7EF;
	Wed, 21 Jan 2026 02:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768961045; cv=none; b=jkiJ5jdO3kaw62XMJUuhWxoGw8q7jzT3dNXqzKqROTbITfx5f+d1Y2DP4wYWHqymDIs+tAUm0tY5tkvW6TzDBTS9PNL4SdpgM9oU7nNYXTApfrUEgFTAIT670cLZftKEp69efksN0z/U7updCzHxXZkkk6ZUDSC7zuzqSURRjiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768961045; c=relaxed/simple;
	bh=n713X3MNMSqrvZT0f94Zhy1sZtKbysaEfru5CFyu8qM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UJYufycuDRfbESgGYSXGBwZLYsb6MY9KsekDbhQs05rS7nA6tBN/hAn6zwCWgFkBlHVSE10bH13gNsCbMSKdd0DUWu1ARLDrwyjKBI/oPE2dTq3zRBT6jpfNSuBIcL3wSy12znSbPEEZifesBXgEn/f+kDgbLR6eZOOkfAoMMwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W1YQoDGr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W1YQoDGr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2490AC16AAE;
	Wed, 21 Jan 2026 02:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768961043;
	bh=n713X3MNMSqrvZT0f94Zhy1sZtKbysaEfru5CFyu8qM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W1YQoDGr3YmhCdHDcTcTKeK5VrZf6mfSIcwc97uAnZ928qj53N30NkUWGCjQAzk3g
	 z3icYN1uUBSnoISPgKXyHeibDzjkkUFrxKKe69yAhro5NCkMjbFuAbTdJ0nIcfTvl6
	 C5H3fQgIekO5TcTOA37woRv+QiPiV8P5AN62+C86nfNKS7SH/ljOBsS9rK37JQzmyI
	 yy/DxmGfpNptHX8GZTypgvbH1R8HeZxy1Vnuh8skF2oJ1TqGMs5TIMj1JH2nABSZyh
	 KKAQkoj1c2a9pLNjzyjfp0fkOLtrHigMvnieywovbiJTWfIxi9nB3qknzZU5ImJjPA
	 GlJ1KXJaoSzQw==
Date: Tue, 20 Jan 2026 18:04:02 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com,
 sdf@fomichev.me, john.fastabend@gmail.com, martin.lau@kernel.org,
 jordan@jrife.io, maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
 dw@davidwei.uk, toke@redhat.com, yangzhenze@bytedance.com,
 wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v7 05/16] net: Proxy net_mp_{open,close}_rxq
 for leased queues
Message-ID: <20260120180402.2b9ab13a@kernel.org>
In-Reply-To: <20260115082603.219152-6-daniel@iogearbox.net>
References: <20260115082603.219152-1-daniel@iogearbox.net>
	<20260115082603.219152-6-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Jan 2026 09:25:52 +0100 Daniel Borkmann wrote:
>  	if (!netdev_need_ops_lock(dev))
>  		return -EOPNOTSUPP;
> -
>  	if (rxq_idx >= dev->real_num_rx_queues) {
>  		NL_SET_ERR_MSG(extack, "rx queue index out of range");
>  		return -ERANGE;
>  	}
> -	rxq_idx = array_index_nospec(rxq_idx, dev->real_num_rx_queues);
>  
> +	rxq_idx = array_index_nospec(rxq_idx, dev->real_num_rx_queues);

The white space changes here look haphazard.

> +	rxq = netif_get_rx_queue_lease_locked(&dev, &rxq_idx);

I really hate this function but I don't have any great suggestion on
how to make it better. I'd prefer if there was a clear separation
between the case where we call directly, vs where swapped the queue.
Instead of replacing pointers passed in by reference :| And that'd 
remove the conditional locking too.

> +	if (!rxq) {
> +		NL_SET_ERR_MSG(extack, "rx queue peered to a virtual netdev");

The fact the !rxq means the queue was leased is also fairly random
vs all the subsequent checks.

> +		return -EBUSY;
> +	}
> +	if (!dev->dev.parent) {
> +		NL_SET_ERR_MSG(extack, "rx queue is mapped to a virtual netdev");

mapped? Or belongs?

> +		ret = -EBUSY;
> +		goto out;
> +	}
>  	if (dev->cfg->hds_config != ETHTOOL_TCP_DATA_SPLIT_ENABLED) {
>  		NL_SET_ERR_MSG(extack, "tcp-data-split is disabled");
> -		return -EINVAL;
> +		ret = -EINVAL;
> +		goto out;
>  	}
>  	if (dev->cfg->hds_thresh) {
>  		NL_SET_ERR_MSG(extack, "hds-thresh is not zero");
> -		return -EINVAL;
> +		ret = -EINVAL;
> +		goto out;
>  	}
>  	if (dev_xdp_prog_count(dev)) {
>  		NL_SET_ERR_MSG(extack, "unable to custom memory provider to device with XDP program attached");
> -		return -EEXIST;
> +		ret = -EEXIST;
> +		goto out;
>  	}
> -
> -	rxq = __netif_get_rx_queue(dev, rxq_idx);
>  	if (rxq->mp_params.mp_ops) {
>  		NL_SET_ERR_MSG(extack, "designated queue already memory provider bound");
> -		return -EEXIST;
> +		ret = -EEXIST;
> +		goto out;
>  	}
>  #ifdef CONFIG_XDP_SOCKETS
>  	if (rxq->pool) {
>  		NL_SET_ERR_MSG(extack, "designated queue already in use by AF_XDP");
> -		return -EBUSY;
> +		ret = -EBUSY;
> +		goto out;

All these checks can be factored out to avoid making this function long
and having 5 gotos.

>  	}
>  #endif
> -

Please lease my whitespace be.

>  	rxq->mp_params = *p;
>  	ret = netdev_rx_queue_restart(dev, rxq_idx);
>  	if (ret) {
>  		rxq->mp_params.mp_ops = NULL;
>  		rxq->mp_params.mp_priv = NULL;
>  	}
