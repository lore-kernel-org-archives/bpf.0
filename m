Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793114352;
	b=RY0XeJZKkcqRAwkDJUorOmRvdf02Z77/slzSWq84FaLtUhtfjrUsSbZWdNNzFQoBKNht
	 Um80PZ9KlwgF570UEQNg77Xf847ppzEd2H/U5OouT05gREV8h6fNx/A+tLkeXP2FC2KFd
	 sjs4CWpM001LSSjDoJ+JjLfS0ygG/W3P7i+1jq4DNvIISA++OEgXEks6B21LqxHirFstu
	 IbNODnztktfsLIlNuN62VIFfPTqXpRj7Rj2iXo6kMjiG+B5Po4AHoHB1rZP61ibyhtJvJ
	 Fy33XKsfsNDmfN8+FCJjE/9IWu3L5hFDO2rxR2RMyx41/SRyFAt5sTJvOa1zUJE7h4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793114352;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=qVOyjGft3yl8t21QQK6X5h58hFCy9arSFXCjxP8+GvE=;
	b=N1qdadRgKDo6gs5E8ijH47KxBZOJnYR6BmvmROKFHMCcGfDot2VTA4ai1RZBeksrASNp
	 swQFGWtrptpnEQXVs/5qqEZAMIlC1q7lqZbNUNR3ogrHXFQNSUbknM/p8UHo03vSiC2hr
	 o27KFOt9EksDRS3BYG2ZxfLtdrLT9t05GaSpcd8AtNxphOxTzMxMeBmRzwRaHVOWENh1I
	 m344HYvQdm0DoF58Z3cxm4fHkOClN85C8pf9XCNzbLCrlg3AHeuhQklgZRt+weHA255V4
	 4XNyzUnpg5cdvuyEkPwvl23yG6BbIOcItbdsHSZcqmvZcbQtdCfsqC+jFmZFCjVtI7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Lx9IsB10;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C1E606A31D;
	Tue, 27 Oct 2026 15:19:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1C1E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Lx9IsB10
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 56794C79AB4;
	Tue, 27 Oct 2026 15:20:09 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 90477603BD;
	Tue, 27 Oct 2026 15:19:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D8E5310328D57;
	Tue, 27 Oct 2026 16:18:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793114346; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=qVOyjGft3yl8t21QQK6X5h58hFCy9arSFXCjxP8+GvE=;
	b=Lx9IsB10zLwRififq18Vz4f1nNHDehrBnlXxwgOhAP+wxSg7U/q43gZuD1al62hhYFIKuQ
	y3lOVI+kCxXZk0VZhn45QsWfo1FeRxHHug5oXzJeBBz/pkMDW2wkzQFF4RNTSX1PRwVVOu
	fZfkA3d+qLoIvSI3d6ISPM5Nv0r16emp9QCCwyfnB1l3/tD+YVJR9MZjUFJGKrVFpE0vjY
	Pd7NeZBp4SF2WXTNrslrxtNGsc9xFcHEwxFEhqp5GbjG1Bwkv8Lsjx2gxDCxzBld3lvHNy
	xWb0PMGxdayeOXdOiQwtR+WicMTwJp5IEI04oxKrke+MRAV+Q2Y5TAvgWXja+w==
Message-ID: <8a1547bb-cc42-465b-8a8a-d4790cd0867f@bootlin.com>
Date: Tue, 27 Oct 2026 16:18:53 +0100
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] net: stmmac: descriptor management issue during PM
 sequence
To: Thomas Bourgoin <thomas.bourgoin@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
 Christophe Roullier <christophe.roullier@foss.st.com>,
 Ding Hui <dinghui1111@163.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20261027150556.51209-1-thomas.bourgoin@foss.st.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20261027150556.51209-1-thomas.bourgoin@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Thomas,

On 10/27/26 16:05, Thomas Bourgoin wrote:
> Hello,
> 
> During low power sequence on STM32MP21 we sometimes observe out of range access
> to the DDR by the GMAC ethernet. I managed to narrow down the issue to the
> resume sequence of the RX descriptors with the function
> stmmac_clear_descriptors().
> 
> On resume, stmmac_clear_descriptors() returns RX descriptors to the DMA
> without restoring their buffer addresses. On DWMAC4, the DMA will
> therefore consider a descriptor for the application as one for the DMA.
> This can lead to illegal access from the DMA anywhere.
> On STM32MP21 the DMA address bus is 40 bits, thus the extended status from the
> write-back descriptor is read as an high address by the DMA. DMA will then try
> to write in the DDR at 0x100000000 whereas on STM32MP215f-dk DDR is only 2Gb
> from 0x8000 0000 to 0xffff ffff and nothing is mapped at 0x100000000.
> All the other SoCs of the STM32MP1x or STM32MP2x are using a GMAC with a 32bits
> DMA address, so I do not have illegal attemps.
> 
> To fix this, I propose to reconstruct the RX descriptors that have been used by
> the DMA but not forwarded to the NAPI function stmmac_rx() before suspend.
> 
> I'm not used to this driver especially the xsk management and zero copy part.
> Since this driver is used by a lot of plateforms I'm open to all suggestions.
> 
> This V1 propose to reuse stmmac_init_rx_buffers() but maybe using
> stmmac_refill() would better fit the issue. From what I read, I could not call
> stmmac_refill() as rx_q->cur_rx is only updated in stmmac_rx(), so
> stmmac_rx_dirty() returns 0.

Thanks for the series :) However it looks like this is already being addressed by
Ding Hui's series (currently in V5) :

https://lore.kernel.org/r/20261025100636.613670-1-dinghui1111@163.com

Can you take a look and maybe provide some reviews/tested-by tags ?

Thanks,

Maxime

