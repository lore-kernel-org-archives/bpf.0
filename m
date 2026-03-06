Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68BB261B91;
	Fri,  6 Mar 2026 17:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772817496; cv=none; b=gLnvwD0YXuVfO+RvvDESIZ6/bvRFc4nZRFypXdunc7LgmUUpLk9etBaatm+OWsrKKD+nxoZHz1eW3N1dZZ16hN51OoBfPWtpMGS9RVxtUKEGQoOFxpCzFJjRVDCSs00Vqjc/ssRhOxxx6wdDFwB0TVh7oxG7Ix9p0WVOXaD7k50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772817496; c=relaxed/simple;
	bh=0M7QbmYyI0ceEzylMfV5fRYbSSi9sDXzTiYHtoplO/c=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=BXlHOu0H0LTOJ5J2N3LLEf9RX7y+QOGZluDRnsNvvymn1pQ38fBlCSDAhZoMk6ZeqPnTssaaBb4RX6TPp09zy/rSBmr6XWonA3AU7g7YktaPAVE5CfDxeA5AxLu/mZSET+5lg972EYGND7/nkeuK7gz5fOOqJoiEwf6TyIwheD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nPhm2M+d; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nPhm2M+d"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 37C8AC40437;
	Fri,  6 Mar 2026 17:18:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0981D5FF92;
	Fri,  6 Mar 2026 17:18:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2FEDC10369A8B;
	Fri,  6 Mar 2026 18:18:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772817489; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=FKv6jIYCxjPP+YKO7zW1o8pEb+7cdjqlbdtxG5+Tcj0=;
	b=nPhm2M+dSa+p25gnNKJqh89kRAcnlUNPmXF8ti0M2wlmP8uS8ZqmBweLnf/sm1sb0K6yt7
	tWe5MpMr8oCCYlNV9ArwPkWxAGqRaRDK9TnYnJycIP+4unZOIKClmKMKwIJwKqhBATTWnC
	aYsnbjXdHho122JCnKhGDqQ14ZvYCkkpdg2t2gCimiDRwfuh5x9cKfROEKLhG279JjHVgH
	KOZ+50hANPoGRNaFcNXpvqmZiOSn3DCWXZ2hAtxqv9sb/nJbVME5c0uUdbLbrCVMd4e0g4
	d6V1ysxtZ+O6PcgChKlTyQS1CbS5/4pUEijhQK9Klwmng3s1ytrIyPvQ33pZeQ==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 06 Mar 2026 18:18:03 +0100
Message-Id: <DGVVCKPUZVSQ.3U7SG8TTTA1CM@bootlin.com>
Subject: Re: [PATCH net-next 8/8] net: macb: add Tx zero-copy AF_XDP support
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, =?utf-8?q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, "Tawfik Bayouk" <tawfik.bayouk@mobileye.com>,
 "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>
To: "Maxime Chevallier" <maxime.chevallier@bootlin.com>,
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, "Nicolas Ferre"
 <nicolas.ferre@microchip.com>, "Claudiu Beznea" <claudiu.beznea@tuxon.dev>,
 "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Alexei
 Starovoitov" <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Jesper Dangaard Brouer" <hawk@kernel.org>, "John Fastabend"
 <john.fastabend@gmail.com>, "Stanislav Fomichev" <sdf@fomichev.me>,
 "Richard Cochran" <richardcochran@gmail.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260304-macb-xsk-v1-0-ba2ebe2bdaa3@bootlin.com>
 <20260304-macb-xsk-v1-8-ba2ebe2bdaa3@bootlin.com>
 <74089907-d7d3-4242-92a5-909812779932@bootlin.com>
In-Reply-To: <74089907-d7d3-4242-92a5-909812779932@bootlin.com>
X-Last-TLS-Session-Version: TLSv1.3

Hello!

On Fri Mar 6, 2026 at 1:48 PM CET, Maxime Chevallier wrote:
> On 04/03/2026 19:24, Th=C3=A9o Lebrun wrote:
>> Add a new buffer type (to `enum macb_tx_buff_type`). Near the end of
>> macb_tx_complete(), we go and read the XSK buffers using
>> xsk_tx_peek_release_desc_batch() and append those buffers to our Tx
>> ring.
>>=20
>> Additionally, in macb_tx_complete(), we signal to the XSK subsystem
>> number of bytes completed and conditionally mark the need_wakeup
>> flag.
>>=20
>> Lastly, we update XSK wakeup by writing the TCOMP bit in the per-queue
>> IMR register, to ensure NAPI scheduling will take place.
>>=20
>> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
>> ---
>
> [...]
>
>> +static void macb_xdp_xmit_zc(struct macb *bp, unsigned int queue_index,=
 int budget)
>> +{
>> +	struct macb_queue *queue =3D &bp->queues[queue_index];
>> +	struct xsk_buff_pool *xsk =3D queue->xsk_pool;
>> +	dma_addr_t mapping;
>> +	u32 slot_available;
>> +	size_t bytes =3D 0;
>> +	u32 batch;
>> +
>> +	guard(spinlock_irqsave)(&queue->tx_ptr_lock);
>> +
>> +	/* This is a hard error, log it. */
>> +	slot_available =3D CIRC_SPACE(queue->tx_head, queue->tx_tail, bp->tx_r=
ing_size);
>> +	if (slot_available < 1) {
>> +		netif_stop_subqueue(bp->dev, queue_index);
>> +		netdev_dbg(bp->dev, "tx_head =3D %u, tx_tail =3D %u\n",
>> +			   queue->tx_head, queue->tx_tail);
>> +		return;
>> +	}
>> +
>> +	batch =3D min_t(u32, slot_available, budget);
>> +	batch =3D xsk_tx_peek_release_desc_batch(xsk, batch);
>> +	if (!batch)
>> +		return;
>> +
>> +	for (u32 i =3D 0; i < batch; i++) {
>> +		struct xdp_desc *desc =3D &xsk->tx_descs[i];
>> +
>> +		mapping =3D xsk_buff_raw_get_dma(xsk, desc->addr);
>> +		xsk_buff_raw_dma_sync_for_device(xsk, mapping, desc->len);
>> +
>> +		macb_xdp_submit_buff(bp, queue_index, (struct macb_tx_buff){
>> +			.ptr =3D NULL,
>> +			.mapping =3D mapping,
>> +			.size =3D desc->len,
>> +			.mapped_as_page =3D false,
>> +			.type =3D MACB_TYPE_XSK,
>> +		});
>> +
>> +		bytes +=3D desc->len;
>> +	}
>> +
>> +	/* Make newly initialized descriptor visible to hardware */
>> +	wmb();
>> +	spin_lock(&bp->lock);
>> +	macb_writel(bp, NCR, macb_readl(bp, NCR) | MACB_BIT(TSTART));
>> +	spin_unlock(&bp->lock);
>
> this lock is also taken in interrupt context, this should probably use a
> irqsave/restore variant. Now, there are a few other parts of this driver
> that use a plain spin_lock() call and except for the paths that actually
> run in interrupt context, they don't seem correct to me :(

I almost sent a reply agreeing with you, but actually here is the
exhaustive `spin_lock(&bp->lock)` list:

   #   Function                Context
   ------------------------------------------
   1   gem_wol_interrupt()     irq
   2   macb_interrupt()        irq
   3   macb_wol_interrupt()    irq
   4   macb_tx_error_task()    workqueue/user
   5   macb_tx_restart()       napi/softirq
   6   macb_xdp_xmit_zc()      napi/softirq
   7   macb_start_xmit()       user
   8   macb_xdp_submit_frame() user

And all contexts are safe because it always is this sequence in non-IRQ
contexts (#4-8):

   spin_lock_irqsave(&queue->tx_ptr_lock, flags);
   spin_lock(&bp->lock);
   spin_unlock(&bp->lock);
   spin_unlock_irqrestore(&queue->tx_ptr_lock, flags);

So bp->tx_ptr_lock always wraps bp->lock and does the local CPU IRQ
disabling.

(I also checked we don't risk ABBA deadlock, and we don't: all code
acquires bp->tx_ptr_lock THEN bp->lock.)

However, there is still a bug in the code you quoted: setting
BIT(TSTART) is done twice by macb_xdp_xmit_zc():
 - once in the helper function macb_xdp_submit_buff() and,
 - once in its own body (code you quoted)
This is fixed for V2!

Thanks Maxime,
Have a nice week-end,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

