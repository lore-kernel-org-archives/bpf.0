Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A1C4A8FF1
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 10:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789639894; cv=none; b=T4D0CcO6GVV1j/LT1lLUoLAszVNLBw6cSEybq6CHH+ye66mw/RdwFCiDysPlsKmVLFxNbmvW7hCuIxCRxys9y50bgFiieTP/10W7rWzpoKjc2wJGOMSz8dpUF/IPRTV+DfT0Ida5WoaBHXU2Xh2rRhb4b824BCnGrILJs5JN45s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789639894; c=relaxed/simple;
	bh=Khdn0yNASJVEvDKFWl2nzuYWJwtntVVgAPJPaEFV7fo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tNncpb+hCuC4tSKBBU2u2lFo2b8iHiFBOB4Xnmz9tDQ7HZMwUxkRTY7kcUzQLr4r0facCmJ+GBrgUaK9uAa6yDyqkGQNF52FTJM+C7g1+rv4DvAR9y7mGnNgWeBe7zw8AWZx9tAcT0Ijjdz3PIN/lLvDLlo5ByBi6jJ3XmrmIwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B2/64C10; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2/64C10"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d37b5so4017795e9.2
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 03:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789639890; x=1790244690; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+j9x/TYoYdCBQA+hpYRUNFOKzVf0y/0bQ3U7CD1aFBI=;
        b=B2/64C10PvceXRv9EmHXZ4hpJBA4MVCJ2lVktRzIbQZzDkGzU99sBvsz/JcqIHPD1c
         PA7PjWUaqYUg+sWW/X/9EkHkbxl83WBg3yn2u/Sr5VdGyaCJxwdvX66dGBp0NikOs3HC
         NVDWVpuTJr/HCHJSZx7/f05woBDsoQOWoum6iMrJohQe60WN5oKSEpURO3TMHAieI1PA
         rxB6GII9ScFiJ5X3G40ytdrY87uW1deaH5SgnlXvQ01n80IsR1b5tzMKKXJ200nygakU
         rWXx8QfLtgEArd/dIjym+P4zzBhbBVwagCnNZFNXmt+zcrLluGm0B74yJ6Cm2X1DUVlo
         mUkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789639890; x=1790244690;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+j9x/TYoYdCBQA+hpYRUNFOKzVf0y/0bQ3U7CD1aFBI=;
        b=Msg02f/i8ScySMIkhzWyLAXsfsoE4BDRIfOkGXe6qrsM2GeoF9APhoJka2r65oVlUA
         sUBmGEl5s/QEiQGzW5fblt1qJIlxPf9FUuLfNCFkm/ZuO/wZmId1Syj3nwNvzXuO9sIu
         uSkH+YBsyOp2+fmQCYQX3eI8tWDMaaycJ5CQzTx81+czuqUqIzYc8BO4SRz6oqm8oBC7
         GdX73p4aF7qK3OfEJ+b+0OT4Jp4BYEDRxCnYmaMy+9yG3itdWxUrFLBUirV3S5lV7Y+e
         FmDUAmt83rosWUkCwiA6sXFemlheWp6xbkCWiG+wC4iGQxR0wF2N9xNf1pFw8c18K6w5
         zlqA==
X-Forwarded-Encrypted: i=1; AKwUvBxf4NT7yjBHQIzeWA0Yiiw508L1f0/ZMUKv0SrU5wSxNosWCsr1Pww6oHQ9WV9oiM7opJU=@vger.kernel.org
X-Gm-Message-State: AFuF++mHR80uCUdwgz2OFjvuXF7sqMMV8oYX/u2e1ekrAzwMAp/c8vba
	oRkx3uYlBaYX7BupVr+96Lpp5Zfua3Oj8soCFP8cgaYCIFOco1QDhm9q
X-Gm-Gg: AYBFou26LYcHN6nS8WDqhz3xH1OKuo+4L+NPLBPmggBeqHroY2t9r2X+REwGM4s25JP
	rU7g0d5bUJf5laC7qejDbxALBkhAdzZbYuo/xM9oG32V6PXR6D8PzG4cZoASGcfNTsWSQ67h1zU
	x/0zm4KN45jPCJ+X5UyvxzXn6sdMQ9/WpHHMFVeOTuHDGEkE3bQ1o9fMPEf45EtrczoMUtCgV7T
	jIDbNgjUXVcaCPMWDYj1qtzHlAze65TVGGhxpJ4PdP7FqxDzzy1GIhWkgl6ogWXNjagIDNPhFKe
	gtVcTxHwkpgtY9lZNkvBlK2oC4pM/7e0z+4XSfKpOqIbh8isoUQJnKjkaOvfHnxvmTH6v3Tk2I/
	ObaCkAWdfuT866uPP49PVcDiIGHtjVU/aoGFdlk1mbqTMXmUH01AaTbHZzaiIudtUVlaN7Aikv1
	x8P+5u49pNPfp5qmL+5cRdKXH6ppsgq2zEEM/+FFixsfAGPTm38jrzLGkh7FvS0+n59vetUkKAb
	ZnNSQsLg5TfeLtPnnMzZfxGMJDeQYS8ErXHaQ==
X-Received: by 2002:a05:600c:524e:b0:49f:c2ef:cfb9 with SMTP id 5b1f17b1804b1-49fc2efcfbcmr892015e9.4.1789639889542;
        Thu, 17 Sep 2026 03:11:29 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd6f24c7sm23288715e9.1.2026.09.17.03.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 03:11:28 -0700 (PDT)
Date: Thu, 17 Sep 2026 11:11:27 +0100
From: David Laight <david.laight.linux@gmail.com>
To: vladimir.oltean@nxp.com
Cc: netdev@vger.kernel.org, Zefir Kurtisi <zefir.kurtisi@westermo.com>,
 Claudiu Manoil <claudiu.manoil@nxp.com>, Wei Fang <wei.fang@nxp.com>, Clark
 Wang <xiaoning.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Simon
 Horman <horms@kernel.org>, Richard Cochran <richardcochran@gmail.com>,
 Yangbo Lu <yangbo.lu@nxp.com>, Ioana Ciornei <ioana.ciornei@nxp.com>,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v3 net 4/7] net: enetc: pad short frames in software
Message-ID: <20260917111127.577d344b@pumpkin>
In-Reply-To: <20260915222735.1016937-5-vladimir.oltean@nxp.com>
References: <20260915222735.1016937-1-vladimir.oltean@nxp.com>
	<20260915222735.1016937-5-vladimir.oltean@nxp.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Sep 2026 01:27:31 +0300
vladimir.oltean@nxp.com wrote:

> The ENETC does not support BUF_LEN or FRM_LEN in TX buffer descriptors
> less than 16. This is written in the reference manual of all SoCs
> supported by the driver: LS1028A, i.MX943, i.MX95 etc.
> 
>   Frames must not have a FRM_LEN that is less than 16 bytes. Frames of
>   0-15 bytes are not supported.
>   (...)
>   The first descriptor in a chain must not have a BUFF_LEN that is less
>   than 16 bytes.
> 
> I don't think proper attention was paid to this during development, we
> found the text at the end of a bug investigation. Therefore, the driver
> does not enforce this.
> 
> But the frame length is out of the driver's control, and the network
> stack can actually send packets with skb->len smaller than that. The
> result is unpleasant, as will be explained below, so for simplicity
> sake, we just pad anything shorter than ETH_ZLEN.
> 
> Zefir Kurtisi found a case where transmitting L2 WNM keep-alive frames
> through ENETC would soft-lockup the host through an IRQ storm. He later
> distilled this into a small enetc-killer.c user space program which
> sends a packet with MAC DA, MAC SA and EtherType IPv4 (14 octets in
> length) through an AF_PACKET raw socket.
> 
> The IRQ storm is actually a curious effect of a chain of events.
> 
> The hardware behaviour, when an invalid BD is put in its TX ring, is
> that it would transmit the packet as normal, update counters, raise
> completion interrupt as normal, but it would just not advance the
> consumer index of the ring (TBaCIR) to signify that the BD has been
> consumed and is available for software to free. The ring will also get
> its TBaSR[BUSY] bit persistently set to 1 afterwards.
> 
> It deserves an explanation why the behaviour above would lead to an
> IRQ storm, since ENETC interrupts are message-based (MSI-X), and an
> unhandled interrupt would typically just be lost rather than retrigger
> itself as a wired interrupt would.
> 
> NAPI processing in ENETC has 3 steps:
> 
> I. the enetc_msix() hardirq handler disables RBaIER, TBaIER and sets
>    softirq processing to the 'pending' state.
> 
> II. the enetc_poll() softirq handler for the IRQ vector walks through
>     the TX rings affine to that vector, checks which ones have a TBCIR
>     updated since last time - enetc_bd_ready_count() - processes those
>     completed frames, and clears pending interrupts in these updated TX
>     rings by writing to TBaIDR. (I've excluded RX processing due to it
>     being irrelevant).
> 
> III. After the softirq handler does its round of checking all RX and TX
>      rings for updates, it re-enables all interrupts in RBaIER and
>      TBaIER that were previously disabled by the hardirq handler, and
>      exits.
> 
> Because the TX ring with the short frame is skipped at step II (TBCIR
> wasn't updated as part of HW malfunction), its pending IRQ is not
> cleared in TBaIDR by enetc_clean_tx_ring().
> 
> But because enetc_msix() disables TBaIER at step I and re-enables it at
> step III, another MSI will be fired upon re-enabling it. This is what
> completes the cycle and the driver goes back to step I.
> 
> So the driver misinterprets the mixed signals it's getting from the
> hardware, and ends up causing a software-amplified IRQ storm.
> 
> Fixes: d4fd0404c1c9 ("enetc: Introduce basic PF and VF ENETC ethernet drivers")
> Reported-by: Zefir Kurtisi <zefir.kurtisi@westermo.com>
> Closes: https://lore.kernel.org/netdev/b3d9136c-2803-4203-b1ea-1f9e62de80a1@gmail.com/
> Tested-by: Zefir Kurtisi <zefir.kurtisi@westermo.com>
> Reviewed-by: Wei Fang <wei.fang@nxp.com>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
> v1->v3: none
> ---
>  drivers/net/ethernet/freescale/enetc/enetc.c | 13 +++++++++++++
>  drivers/net/ethernet/freescale/enetc/enetc.h |  2 ++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> index 0216f7d08e19..bbad942041f5 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -1077,6 +1077,19 @@ netdev_tx_t enetc_xmit(struct sk_buff *skb, struct net_device *ndev)
>  	u8 udp, msgtype, twostep;
>  	u16 offset1, offset2;
>  
> +	/* Hardware does not support transmit buffer descriptors with a total
> +	 * length of less than 16 bytes, or a first buffer size of less than
> +	 * 16 bytes.
> +	 */
> +	if (unlikely(skb_headlen(skb) < ENETC_MIN_BUFF_SIZE &&
> +		     skb_linearize(skb))) {

Isn't it only necessary to pull a few bytes into the linear region?

> +		dev_kfree_skb_any(skb);
> +		return NETDEV_TX_OK;
> +	}
> +
> +	if (eth_skb_pad(skb))
> +		return NETDEV_TX_OK;

That could be inside the (skb_headlen(skb) < ENETC_MIN_BUFF_SIZE) test.

David

> +
>  	/* Mark tx timestamp type on enetc_cb->flag if requires */
>  	if ((skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) &&
>  	    (priv->active_offloads & ENETC_F_TX_TSTAMP_MASK))
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
> index d1e9d9130057..a4e76060e94b 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.h
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.h
> @@ -22,6 +22,8 @@
>  #define ENETC_MAX_MTU		(ENETC_MAC_MAXFRM_SIZE - \
>  				(ETH_FCS_LEN + ETH_HLEN + VLAN_HLEN))
>  
> +#define ENETC_MIN_BUFF_SIZE	16
> +
>  #define ENETC_CBD_DATA_MEM_ALIGN 64
>  
>  #define ENETC_MADDR_HASH_TBL_SZ	64

