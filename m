Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E260738F223
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 12:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772801317; cv=none; b=Id5qzq+dm60as4x7Jk7JTWeUQcSKF1iUzc7a5bDLxJAX/45NR+AA6uqMjprK+G6wYihrdyu32ca0+hv4RfzjaDyM63elgVQ4y/emyGRYH7EKxK9RuyjKoYHS3+joWccAPEG/LFgEb+gQUnkJ8Ft13sIJ+x1V0vG+TT32sLkG6OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772801317; c=relaxed/simple;
	bh=qPicryEkwijXPwqofzoau04znhdrfvIHnu6/Pyv8VUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jRH4PRGT28FhzEuto1Ps75S9ZZXE5P+edZ/UMbUY8/46ey74JGLjXpIS+2wtijvildolhJ4IVbtcztDwwgu1tMyC464pKSrLoQ7K0CzC+C/K33HVUsvMRgpHdlO0bzl2/3ruIG5ph37Pz0+pmbX9ZLb87ur+RTthdwzhdBoEslM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KSLV+Asz; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KSLV+Asz"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id E285AC40432;
	Fri,  6 Mar 2026 12:48:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BEF445FF92;
	Fri,  6 Mar 2026 12:48:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1C126103699D2;
	Fri,  6 Mar 2026 13:48:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772801310; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=FkZSFQh+KvpketIOrBtEelxV6rwNiCRVKYCWCZUIhEw=;
	b=KSLV+Asz8WIYjHDBTLUnCDHxCh86N/EhI3LyQKwjdzdWns3qJQA4RavwYkb70hzWBNNCT4
	xKlaqWKEg0WCzgTZJU+/nb7YjDneVLt82ijLzRYw6FhNH02v1herHWe9vtJF4Ej4LkdCV6
	KnCWz6qxbFPOU/2NL661KQaOLbXrq8kDswrMXSgIaogUEhuOON/2mp4ITWIB5Ova+DcKq4
	YjJuJr4qZOPXlYPHq7eBRvw1PqCyT9RrmYvjFA0OSa346a9S6+dlf4VoePMBoMgRRIKQhx
	VtT66m1EHlvByauqhG/yS/af69G41C+sBtGmgh9/L4+AREexPyIfsVy+ljcRHw==
Message-ID: <74089907-d7d3-4242-92a5-909812779932@bootlin.com>
Date: Fri, 6 Mar 2026 13:48:23 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 8/8] net: macb: add Tx zero-copy AF_XDP support
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Richard Cochran <richardcochran@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 =?UTF-8?Q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>,
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20260304-macb-xsk-v1-0-ba2ebe2bdaa3@bootlin.com>
 <20260304-macb-xsk-v1-8-ba2ebe2bdaa3@bootlin.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260304-macb-xsk-v1-8-ba2ebe2bdaa3@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Théo,

On 04/03/2026 19:24, Théo Lebrun wrote:
> Add a new buffer type (to `enum macb_tx_buff_type`). Near the end of
> macb_tx_complete(), we go and read the XSK buffers using
> xsk_tx_peek_release_desc_batch() and append those buffers to our Tx
> ring.
> 
> Additionally, in macb_tx_complete(), we signal to the XSK subsystem
> number of bytes completed and conditionally mark the need_wakeup
> flag.
> 
> Lastly, we update XSK wakeup by writing the TCOMP bit in the per-queue
> IMR register, to ensure NAPI scheduling will take place.
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---

[...]

> +static void macb_xdp_xmit_zc(struct macb *bp, unsigned int queue_index, int budget)
> +{
> +	struct macb_queue *queue = &bp->queues[queue_index];
> +	struct xsk_buff_pool *xsk = queue->xsk_pool;
> +	dma_addr_t mapping;
> +	u32 slot_available;
> +	size_t bytes = 0;
> +	u32 batch;
> +
> +	guard(spinlock_irqsave)(&queue->tx_ptr_lock);
> +
> +	/* This is a hard error, log it. */
> +	slot_available = CIRC_SPACE(queue->tx_head, queue->tx_tail, bp->tx_ring_size);
> +	if (slot_available < 1) {
> +		netif_stop_subqueue(bp->dev, queue_index);
> +		netdev_dbg(bp->dev, "tx_head = %u, tx_tail = %u\n",
> +			   queue->tx_head, queue->tx_tail);
> +		return;
> +	}
> +
> +	batch = min_t(u32, slot_available, budget);
> +	batch = xsk_tx_peek_release_desc_batch(xsk, batch);
> +	if (!batch)
> +		return;
> +
> +	for (u32 i = 0; i < batch; i++) {
> +		struct xdp_desc *desc = &xsk->tx_descs[i];
> +
> +		mapping = xsk_buff_raw_get_dma(xsk, desc->addr);
> +		xsk_buff_raw_dma_sync_for_device(xsk, mapping, desc->len);
> +
> +		macb_xdp_submit_buff(bp, queue_index, (struct macb_tx_buff){
> +			.ptr = NULL,
> +			.mapping = mapping,
> +			.size = desc->len,
> +			.mapped_as_page = false,
> +			.type = MACB_TYPE_XSK,
> +		});
> +
> +		bytes += desc->len;
> +	}
> +
> +	/* Make newly initialized descriptor visible to hardware */
> +	wmb();
> +	spin_lock(&bp->lock);
> +	macb_writel(bp, NCR, macb_readl(bp, NCR) | MACB_BIT(TSTART));
> +	spin_unlock(&bp->lock);

this lock is also taken in interrupt context, this should probably use a
irqsave/restore variant. Now, there are a few other parts of this driver
that use a plain spin_lock() call and except for the paths that actually
run in interrupt context, they don't seem correct to me :(

Maxime


