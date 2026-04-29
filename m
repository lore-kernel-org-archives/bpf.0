Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4616340298
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 22:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777502365; cv=none; b=Mkl171AQr8bJ+DQ9qG/tJoyatfzcQpZVfftqu75S3dJL8bRskp+zCLy/0+pOzVMggm8LYafhKaLBiPaGPMyB6hYzCotlUqEipLkUslOCh8lHqhfGVEoR7rNgBYpw63WZ3QqVZ+MiwfNxiwfqvXIRSmaQ5BgRb+Ns0+/2TqGkjgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777502365; c=relaxed/simple;
	bh=v+Lf5gMQS9L7eFCl2J/uJqjn0gXBj8rSRynjkxYNunw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=jvlNVF8ymEgvaE+OuVY0HBiaCt6NUPPbSR/Fxc8t+An5sYNHpyMDVdkCDroB3FfKmylXQtpuhYC1/65U8exwf+aVuM3IQVcEGPGybKc4fw7GqHJj+sro1daClG7YYsmqwoEIElWqIAsfxhFzriQLr5a2WI+DJSSNdjbTFpHfv7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=Pjy0L/l3; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="Pjy0L/l3"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CA840A5398;
	Thu, 30 Apr 2026 00:39:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1777502361; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=4TrQlw5eAMEZj5539nZeQ71X2cB2IQNqmh7vkQ18I/I=;
	b=Pjy0L/l3D08XwA+OxJYKivO0CIywk/4bNkZaL0kFzGR6f3hUDR/tIk+kLQ49EMXrw2THde
	GaK0f5N2Cp73fbNg9Bre6eJ7uCuC0MjDjlhziYpeSsZMPu7ldoSXg4Euujt50VtMHNF9xy
	hz5G/PKCQKSgKtlXEuODaVgmJaQ5Z5oH6vTpWLvoIMeaKOXAEkViZpbNX1cLKuIKqt2x+n
	3EW4vfomyXLOJstBH4A+LonHeGLGHFxl81XSK/qIb2c7uV4H5beH/3ByIS5PEYnyelxqBR
	ROKfZ3rr+2uJkNVRNiZmjiFIbo5y7jhytN+RPSdk+VkJ9OeWaxQDmeC9ESA8MA==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 30 Apr 2026 00:39:21 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH net-next v8 6/7] net: bcmgenet: add XDP statistics
 counters
In-Reply-To: <20260429211704.710D9C19425@smtp.kernel.org>
References: <20260428205846.2625550-7-nb@tipi-net.de>
 <20260429211704.710D9C19425@smtp.kernel.org>
Message-ID: <9846f1275ea211e3d03c6b6e5a6fdbce@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 29.4.2026 23:17, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential 
> issue(s) to consider:
> - [High] XDP_TX headroom check ignores metadata size, and TSB insertion 
> corrupts metadata state.
> - [Medium] Non-atomic updates to global XDP statistics from concurrent 
> NAPI contexts cause data races and cache-line bouncing.
> - [Medium] Missing counter increment when `xdp_convert_buff_to_frame()` 
> fails in the `XDP_TX` path.
> --
> 
> commit 9febde2d94a02157dc480d909cc304c59196d72f
> Author: Nicolai Buchwitz <nb@tipi-net.de>
> 
> net: bcmgenet: add XDP statistics counters
> 
> This commit exposes per-action XDP counters via ethtool -S. It uses
> the soft MIB infrastructure and increments the counters in
> bcmgenet_run_xdp().
> 
>> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c 
>> b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
>> index 9dd258567824..02ad2f410d6c 100644
>> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
>> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> 
> [ ... ]
> 
>> @@ -2428,6 +2435,7 @@ static unsigned int bcmgenet_run_xdp(struct 
>> bcmgenet_rx_ring *ring,
>> 
>>  	switch (act) {
>>  	case XDP_PASS:
>> +		priv->mib.xdp_pass++;
> 
> Is it safe to update global priv->mib statistics here?

The XDP counters follow the existing soft MIB convention in this
driver (plain u32, unsynchronized). A larger ring refactoring is
AFAIK planned that should address all MIB counters consistently.

> 
> Since bcmgenet_run_xdp() can execute concurrently in multiple 
> independent
> NAPI polling contexts (one per RX ring), non-atomic increments to 
> shared
> global variables can cause data races and lost increments.
> 
> Continually modifying a shared cacheline on the fast-path for every 
> packet
> could also force cacheline bouncing across CPUs and degrade XDP 
> performance.
> Should these statistics be maintained per-queue or using per-CPU 
> variables
> instead?
> 
>>  		return XDP_PASS;
>>  	case XDP_TX:
>>  		/* Prepend a zeroed TSB (Transmit Status Block).  The GENET
>>  		 * MAC has TBUF_64B_EN set globally, so hardware expects every
>>  		 * TX buffer to begin with a 64-byte struct status_64.  Back
>>  		 * up xdp->data into the RSB area (which is no longer needed
>>  		 * after the BPF program ran) and zero it.
>>  		 */
>>  		if (xdp->data - xdp->data_hard_start <
>>  		    sizeof(struct status_64) + sizeof(struct xdp_frame)) {
>>  			page_pool_put_full_page(ring->page_pool, rx_page,
>>  						true);
>> +			priv->mib.xdp_tx_err++;
>>  			return XDP_DROP;
>>  		}
>>  		xdp->data -= sizeof(struct status_64);
>>  		xdp->data_meta -= sizeof(struct status_64);
>>  		memset(xdp->data, 0, sizeof(struct status_64));
> 
> While not introduced by this patch, does this headroom check and TSB
> insertion handle metadata correctly?

Already addressed under patches 4 and 5: xdp_convert_buff_to_frame()
validates headroom against metasize. The memset writes into the former
RSB area, above the metadata; both data and data_meta shift equally so
the metadata position is preserved.

> 
> The headroom check doesn't account for metasize, which could cause
> xdp_convert_buff_to_frame() to fail its own bounds check later.
> 
> Additionally, if the XDP program added metadata, it would be located at
> [old_data - metasize, old_data]. The memset writes zeroes to
> [new_data, new_data + 64], which is [old_data - 64, old_data], 
> potentially
> overwriting the original metadata.
> 
> Since xdp->data_meta is shifted back by 64 bytes, could it now point to
> garbage memory and corrupt the metadata state?
> 
>> 
>>  		xdpf = xdp_convert_buff_to_frame(xdp);
>>  		if (unlikely(!xdpf)) {
>>  			page_pool_put_full_page(ring->page_pool, rx_page,
>>  						true);
>>  			return XDP_DROP;
>>  		}
> 
> Are we missing a counter increment on this failure path?

Fair point, but xdp_convert_buff_to_frame() failure is an extremely
rare path (insufficient headroom for xdp_frame). Can be addressed in
a follow-up.

> 
> The preceding headroom check failure explicitly increments xdp_tx_err 
> before
> dropping, but this path returns directly. Since it doesn't fall through 
> to
> the XDP_DROP switch case, the dropped packet appears to be unaccounted 
> for
> in the new statistics.

Thanks,
Nicolai
