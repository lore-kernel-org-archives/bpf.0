Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9B138E5DF;
	Tue, 13 Oct 2026 08:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791879912; cv=none; b=tX56V6sTdcLvWuUW5hDoifyPXm308RlCf3l/hfmaXtVRRFQDbCkOwFBBIR8GLFETzvXEntu/8L6UbVL50MBTM94dE8nhzvTArAlXpnLIpTV4OEURfHNCYOQYUH7PbLdJwSf14vCOaPIkpV5jBVMGterbmXoSDa6mq7fHDlmT4ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791879912; c=relaxed/simple;
	bh=RbWbzjpqMkedbk8YK4D47wKdcaiIV95H7NKUfCthpPY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=PvPXoQY5VGV5dXr4WGojNzqcnhImtVwow21QrgRCPCFDdI80SehSInbjKgcYYuAkk8EPsbVHzmJQ4yn0l5iRajD80UJ/oy0s+Y5Ujr8OrlfNpCvKmQqbdMvvVCoiz/KovyG4H42PoPlOXKqDBxXjqO94udnY3zklrgRdZU8/dsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=F1DSAf6Q; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="F1DSAf6Q"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 02888A157F;
	Tue, 13 Oct 2026 10:24:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1791879903; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=un+RWDxQ0LzJC8cAfHiPgnBCvaRRs7NxkrufLYrfb0U=;
	b=F1DSAf6QlLFcxhiZ+os9THDj3f+sbAiNkAbcOvc7wgcb7nYRfw+b5BKQUQQfM3NFfoYab6
	sqz09NJu3BR+RYkULLhb8xHoBadK/hkQcL5LbLK7ibudtEBUAs/qRtzlf73RbndFGPl4hO
	bBdSgNVYPyd2NSgw44bR86LH8IZhN1DYOcgYbi9Chw4QkGJA1uK63hPHUMJHcApfzsyzr8
	iNEc9RcKdjtSr7OXx8DR8JQROrkQvGA74G054NltmY8InbjHHiO6v6IyzmOA+bUrPF0fzO
	Yf3h6dDDtF4EGjrztPxoxBNISOEvhaziefwpdtkOTOu/krw3ZtnoZKuhz4OSSg==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 13 Oct 2026 10:24:57 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer
 <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Stanislav
 Fomichev <sdf@fomichev.me>, Jose Abreu <Jose.Abreu@synopsys.com>, Ong Boon
 Leong <boon.leong.ong@intel.com>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v6 3/4] net: stmmac: drop multi-buffer frames in
 XDP mode
In-Reply-To: <as3pB16af0_QhNyB@lore-desk>
References: <20261012-stmmac-rx-mb-v6-0-2225050915c1@oss.qualcomm.com>
 <20261012-stmmac-rx-mb-v6-3-2225050915c1@oss.qualcomm.com>
 <b11af7d5d430dcddcc681484b50ae7e2@tipi-net.de> <as3pB16af0_QhNyB@lore-desk>
Message-ID: <3a483a6fbd86f50a02435932fe4a7ea3@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Lorenzo

On 13.10.2026 10:17, Lorenzo Bianconi wrote:
> On Oct 12, Nicolai Buchwitz wrote:

> [...]

>> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> > b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> > index 426bb68c9bbc..8c08d44fdbd3 100644
>> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> > @@ -5893,18 +5893,24 @@ static int stmmac_rx(struct stmmac_priv *priv,
>> > int limit, u32 queue)
>> >
>> >  		if (priv->extend_desc)
>> >  			stmmac_rx_extended_status(priv, &priv->xstats, rx_q->dma_erx +
>> > entry);
>> > -		if (unlikely(status == discard_frame)) {
>> > -			page_pool_put_page(rx_q->page_pool, buf->page, 0, true);
>> > -			buf->page = NULL;
>> > +
>> > +		if (unlikely(!error && status == discard_frame)) {
>> >  			error = 1;
>> >  			if (!priv->hwts_rx_en)
>> >  				rx_errors++;
>> >  		}
>> >
>> > -		if (unlikely(error && (status & rx_not_ls)))
>> > -			goto read_again;
>> > +		/* We do not support SG in XDP mode */
>> > +		if (unlikely(!error && (status & rx_not_ls) &&
>> > +			     stmmac_xdp_is_enabled(priv))) {
>> > +			rx_dropped++;
>> > +			error = 1;
>> > +		}
>> 
>> AFAIU GMAC4 and XGMAC always use the second buffer of a descriptor. If
>> so, at MTU 1500 a frame of up to 3072 bytes can fit in one descriptor,
>> and this check would not catch it?
>> 
>> The XDP program would then only see the first buffer. With XDP_TX the
>> frame is cut and sent too short. With XDP_PASS the second buffer is 
>> added
>> after the program already decided.
>> 
>> Patch 4 fixes this. But if this patch should work on its own, should 
>> it
>> also drop the frame when buf2_len is not zero? Or am I missing
>> something?
> 
> Hi Nicolai,
> 
> IIUC your comment we are missing the case where we have a single 
> descriptor
> (rx_not_ls is not set in status) but the packet is splitted over buf1 
> and buf2,
> right? Something like:
> 
> 	...
> 	buf2_len = stmmac_rx_buf2_len(priv, p, status, len);
> 	len += buf2_len;
> 
> 	if (unlikely(stmmac_xdp_is_enabled(priv) && buf2_len)) {
> 		rx_dropped++;
> 		dev_kfree_skb(skb);
> 		goto next;
> 	}
> 	...
> 
> Is my understanding correct?

Yes, exactly.

I think skb is always NULL there in XDP mode, so the dev_kfree_skb()
can go. Both pages stay in the slot and stmmac_rx_refill() reuses them,
so nothing leaks.

Maybe extend the "We do not support SG in XDP mode" comment to cover
this case too.

> [...]

Thanks,
Nicolai
