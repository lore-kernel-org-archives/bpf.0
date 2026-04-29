Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9530B1F4C8E
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 22:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777503066; cv=none; b=oKjbyvbctcxf3DeypEBKfYdD3EosEwTcke+f9FYJ+1kHjPz43n2UGN2favtbhoJ0bapwjYUeftOVuL/UiNMh8eXMayjoqZsM7rQVH6ji+PtV6VWJW2k69A2a1emIgl1gTd3vFtahsPjjZmEEIJqOo/rC26ShWSjhaUvCfnXrk+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777503066; c=relaxed/simple;
	bh=IT+A5rkbn4Kvuu/efFQZMLBZ43KWVSjUxL9mXp4sxAM=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=p5QCc9s8+fciAwfbu4RfgmiGYowOBAut0zyVZCIV0Vmudn0QLkaE788B9Vyh0CAIajB+XoXOIiHkIZtFtetADyXp7bwq0CRArh1xuaBOMCqAPCrQwlj7MwjdZ/y1XffTQ4lFzQuJQpOSTPSwQVPDJwOnAz2oKPCW7kbvMFz76EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=GEu2gyB4; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="GEu2gyB4"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F40EFA5338;
	Thu, 30 Apr 2026 00:50:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1777503060; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=6XdQFv3lhWyVf6CiRYWh183KTdlcIFi6uEWthmdNDzI=;
	b=GEu2gyB44Fk3AKiEaoTYgxgRtn2LnrisWVbHHz1ub44QSrQ7V2ZtTa+rY3koeSiHF0Z/6y
	ch0ouyLsTOsMqx0kna+ORHPO7ppyTukz1ikZ61fPdQg/mQRjfJUYG9pI1iynzOA0hTDllr
	Os8DrmOxt9NsccNq9ZukArM5r4vpxqCKlHAn1YUQ9vKVZYLJyMIvFeJEhgQyPvUHMVXQV9
	jmTcG92SG7/rgCQ9+RZ9E49LklPF+/DEmCvD9PjdKKOvk1m0jdY7BSX8/O6yXKmxUnAIcY
	yz5FNxIFzsORr+m681agne4Rz92xzl3pTbM0WLVh7mXzY8K+S8TVqez/S9WalA==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 30 Apr 2026 00:50:59 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH net-next v8 5/7] net: bcmgenet: add XDP_REDIRECT and
 ndo_xdp_xmit support
In-Reply-To: <20260429211703.19EC9C2BCB4@smtp.kernel.org>
References: <20260428205846.2625550-6-nb@tipi-net.de>
 <20260429211703.19EC9C2BCB4@smtp.kernel.org>
Message-ID: <6f05e119f0c419047313a20707e7fba5@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 29.4.2026 23:17, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 6 potential 
> issue(s) to consider:
> - [Critical] Prepended TSB in ndo_xdp_xmit completely overwrites struct 
> xdp_frame.
> - [Critical] Headroom validation in XDP_TX ignores metadata size, 
> allowing out-of-bounds writes.
> - [High] DMA mapping address in XDP_TX is incorrect when XDP metadata 
> is present.
> - [High] Redirected XDP frames will be leaked indefinitely if the 
> target interface is idle.
> - [Medium] bcmgenet_xdp_setup() clears NETDEV_XDP_ACT_NDO_XMIT when 
> detaching an XDP program, hiding device capabilities.
> - [Medium] Runt XDP frames (less than 60 bytes) will not be padded by 
> the hardware and will be transmitted as undersized packets.
> --
> 
> commit 893d59a522f087d2ccf486f06a06bb9e815cf330
> Author: Nicolai Buchwitz <nb@tipi-net.de>
> 
> net: bcmgenet: add XDP_REDIRECT and ndo_xdp_xmit support
> 
> Add XDP_REDIRECT support and implement ndo_xdp_xmit for receiving
> redirected frames from other devices.
> 
>> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c 
>> b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
>> index 3c3b0c44ea8a..9dd258567824 100644
>> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
>> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> 
> [ ... ]
> 
>> @@ -2451,11 +2452,25 @@ static unsigned int bcmgenet_run_xdp(struct 
>> bcmgenet_rx_ring *ring,
>>  						true);
>>  			return XDP_DROP;
>>  		}
>> -		if (unlikely(!bcmgenet_xdp_xmit_frame(priv, xdpf, false))) {
>> +
>> +		tx_ring = &priv->xdp_tx_ring;
>> +		spin_lock(&tx_ring->lock);
>> +		if (unlikely(!bcmgenet_xdp_xmit_frame(priv, tx_ring,
>> +						      xdpf, false))) {
> 
> Does the DMA mapping calculation in bcmgenet_xdp_xmit_frame() for this 
> local
> XDP_TX path (dma_map == false) account for XDP metadata?

For local XDP_TX, the caller adjusts xdp->data backwards to include the
prepended TSB before xdp_convert_buff_to_frame(). xdpf->data then points
to the TSB start, and the mapping calculation correctly resolves to that
location.

> 
> If an XDP program populates metadata, the calculation sizeof(*xdpf) +
> xdpf->headroom in the else block of bcmgenet_xdp_xmit_frame() will 
> point
> to the start of the metadata rather than where the TSB was actually 
> prepended
> at xdpf->data. The hardware expects the TSB at the DMA address, so it 
> might
> misinterpret the metadata as the status block.
> 
>> +			spin_unlock(&tx_ring->lock);
>>  			xdp_return_frame_rx_napi(xdpf);
>>  			return XDP_DROP;
>>  		}
>> +		bcmgenet_xdp_ring_doorbell(priv, tx_ring);
>> +		spin_unlock(&tx_ring->lock);
>>  		return XDP_TX;
> 
> Does the headroom check earlier in this XDP_TX block adequately 
> validate
> xdp->data_meta?

xdp_convert_buff_to_frame() validates the remaining headroom against
sizeof(struct xdp_frame) and returns NULL on insufficient space, which
we handle by dropping the frame.

> 
> Before backing up the pointers:
> 	if (xdp->data - xdp->data_hard_start <
> 	    sizeof(struct status_64) + sizeof(struct xdp_frame)) {
> 
> This check validates the space before xdp->data, but the code then 
> subtracts
> 64 bytes from xdp->data_meta:
> 	xdp->data -= sizeof(struct status_64);
> 	xdp->data_meta -= sizeof(struct status_64);
> 
> If an XDP program populates metadata, xdp->data_meta will be lower than
> xdp->data. The subtraction might push xdp->data_meta below
> xdp->data_hard_start, causing out-of-bounds writes when
> xdp_convert_buff_to_frame() constructs the struct xdp_frame.
> 
> [ ... ]
> 
>> @@ -3996,10 +4017,16 @@ static int bcmgenet_xdp_setup(struct 
>> net_device *dev,
>>  		return -EOPNOTSUPP;
>>  	}
>> 
>> +	if (!prog)
>> +		xdp_features_clear_redirect_target(dev);
>> +
>>  	old_prog = xchg(&priv->xdp_prog, prog);
>>  	if (old_prog)
>>  		bpf_prog_put(old_prog);
>> 
>> +	if (prog)
>> +		xdp_features_set_redirect_target(dev, false);
>> +
>>  	return 0;
>>  }
> 
> Can this unintentionally clear NETDEV_XDP_ACT_NDO_XMIT when detaching 
> an XDP
> program?

xdp_features_clear_redirect_target() / 
xdp_features_set_redirect_target()
only manipulate the redirect-target advertisement, not
NETDEV_XDP_ACT_NDO_XMIT. The same pattern is used by ice, bnxt and
others.

> 
> The driver statically implements ndo_xdp_xmit and advertises it in
> dev->xdp_features during probe, indicating the interface can receive 
> XDP
> redirected frames from other interfaces regardless of its own XDP 
> program state.
> Calling xdp_features_clear_redirect_target(dev) when prog is NULL will
> clear the NETDEV_XDP_ACT_NDO_XMIT capability, hiding it from discovery.
> 
> [ ... ]
> 
>> @@ -4013,6 +4040,36 @@ static int bcmgenet_xdp(struct net_device *dev, 
>> struct netdev_bpf *xdp)
>>  	}
>>  }
>> 
>> +static int bcmgenet_xdp_xmit(struct net_device *dev, int num_frames,
>> +			     struct xdp_frame **frames, u32 flags)
>> +{
>> +	struct bcmgenet_priv *priv = netdev_priv(dev);
>> +	struct bcmgenet_tx_ring *ring = &priv->xdp_tx_ring;
>> +	int sent = 0;
>> +	int i;
>> +
>> +	if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK))
>> +		return -EINVAL;
>> +
>> +	if (unlikely(!netif_running(dev)))
>> +		return -ENETDOWN;
>> +
>> +	spin_lock(&ring->lock);
>> +
>> +	for (i = 0; i < num_frames; i++) {
>> +		if (!bcmgenet_xdp_xmit_frame(priv, ring, frames[i], true))
>> +			break;
> 
> Does bcmgenet_xdp_xmit_frame() overwrite the struct xdp_frame metadata 
> when
> handling these redirected frames?

No. The xdp_frame ends at data_hard_start + sizeof(xdp_frame). The TSB
is written at xdpf->data - 64, which falls inside the headroom (after
the xdp_frame). The check xdpf->headroom < sizeof(struct status_64)
ensures no overlap with the xdp_frame.

> 
> When dma_map == true for redirected frames, the driver prepends a 
> 64-byte
> hardware TSB by calling memset(xdpf->data - sizeof(struct status_64), 
> 0, 64).
> Since the struct xdp_frame is located right before xdpf->data (or any 
> prepended
> metadata), writing backwards into the headroom could completely zero 
> out the
> struct xdp_frame fields, leading to crashes when returning the frame.
> 
> Also, does this cause runt frames to be transmitted as undersized 
> packets?

Padding short frames is the responsibility of the XDP program / source
device, same as in other XDP drivers.

> 
> If the XDP frame is less than 60 bytes, enabling DMA_TX_APPEND_CRC 
> inside
> bcmgenet_xdp_xmit_frame() without first padding the frame might trigger 
> the
> GENET hardware quirk where it fails to pad packets to the minimum 
> Ethernet size,
> causing them to be dropped by receiving switches.
> 
> Is there a mechanism to ensure these redirected frames won't be leaked 
> if the
> target interface is idle?

Known limitation of piggybacked TX reclaim, shared by other drivers.
In practice, redirect targets see bidirectional traffic. Frames are
dropped (not leaked) when the ring fills

> 
> Without setting DMA_TX_REQ_INTR in len_stat during transmission in
> bcmgenet_xdp_xmit_frame(), TX completions for the XDP TX ring rely 
> entirely
> on being polled during the RX NAPI cycle. If the interface is receiving 
> no
> normal traffic, the NAPI poll might never run, causing the redirected 
> frames to
> sit in the TX ring indefinitely.
> 
>> +		sent++;
>> +	}

Thanks,
Nicolai
