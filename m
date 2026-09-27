Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C293CBE8B;
	Sun, 27 Sep 2026 17:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790531313; cv=none; b=YljZvPAkzJNYtGKbII/cfUhFfOdqb2oA1ZNaeRVusYuCUV6OR/fqZhxx5j6vUm3lI/4pr8n4sDa41mk9e2RT9Mbh71B6eqxGXRSLGPxjB8xp/kNdStlrpMDaWgUjGnVgPe7TmffwPLd7sATPChWS83tAius5Ly+ZOVMDKYAxGaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790531313; c=relaxed/simple;
	bh=77tu4iNrx8Sh3PiZPWpnqFZCgOQw/3Lq4YX1j1xZPf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SmfdKupBpRizPYeafIwE/R9RbHsdOhteotv0JrDo17oDNJd1EVfKSoI2zcKmo+wD22NlFeCDIiJu9OIQGFT7M44IiLn8ivE5nUKRm6xv72KZleF35efqsrE1Qv2M6RV93yHisvbMEYoYuCm9sxe/uAfn2a5i2VMAQulfxCXtlm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TdsNNYUE; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TdsNNYUE"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id E9E1AC5CD41;
	Sun, 27 Sep 2026 17:49:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 06961604FF;
	Sun, 27 Sep 2026 17:48:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8AD2B102F1E7E;
	Sun, 27 Sep 2026 19:48:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790531305; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=AfLFefFTZ9CCY0LnSyMHekNeX2TotPch4ikL4DSCq7U=;
	b=TdsNNYUEGR/IlBVUa5FG0wm302dtB1cFBSLS4xtjpv0xlLK2c5SQFG14+2O+6kp8Zkzf+5
	6auCNcbQvePq9bPfeHYNzImSnb4sxVuebq2UkFT59Y9cdJv7wxFy5XhQTM2ZKpD2AHOqVP
	LU9zy2Z3/fcjkHK4MZAcVp+lnl/jMxIizh07sIJ6HCO5D/vMmLxC/iDBk/bPd7nPdzGSOT
	G9xJBcGeVqr7fvZ1let+m6wXw6tAqNqgemQTI36cO0QmcGTwbGp17wf82fOTa3m4fxzI8j
	FLvQBl3dtHJ/iysB5ksUHdtxADjdQ9a81tSbFup5guiEaGsrlhGHoScMxTSs5A==
Message-ID: <9f7d6b86-3ccb-4ccf-8758-c4b8c6ad2ef1@bootlin.com>
Date: Sun, 27 Sep 2026 19:48:16 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net: stmmac: fix rx Scatter-Gather support
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <Jose.Abreu@synopsys.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
References: <20260923-stmmac-rx-sg-fix-v3-1-ed26fea7180d@oss.qualcomm.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260923-stmmac-rx-sg-fix-v3-1-ed26fea7180d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Lorenzo,

On 9/23/26 11:14, Lorenzo Bianconi wrote:
> When a received frame is larger than dma_buf_sz, the DMA scatters it
> across multiple RX descriptors (rx Scatter-Gather). The secondary RX
> buffer (sec_page) was only allocated and programmed when split-header
> (SPH) was active, so for regular frames buffer2 was neither allocated
> nor backed by a valid mapping. As soon as an incoming frame overflowed
> buffer1, the DMA wrote the overflow into the unmapped secondary-buffer
> address, triggering an SMMU translation fault on IOMMU-based platforms:
> 
> arm-smmu 15000000.iommu: Unhandled context fault: fsr=0x402, iova=0x00000000, fsynr=0x7f0011, cbfrsynra=0x1c90, cb=11
> arm-smmu 15000000.iommu: FSR    = 00000402 [Format=2 TF], SID=0x1c90
> arm-smmu 15000000.iommu: FSYNR0 = 007f0011 [S1CBNDX=127 WNR PLVL=1]
> 
> Enable scatter-gather for non-SPH frames on cores that can program an
> independent secondary RX buffer (GMAC4/XGMAC): allocate and mark buffer2
> as valid in stmmac_init_rx_buffers() and stmmac_rx_refill(), and account
> for it in the buffer length computation. Legacy cores have no set_sec_addr
> op, so they keep buffer2 disabled.
> 
> Since buffer2 is handed to the DMA at page offset 0, the page pool sync
> window is widened to cover both buffers in every mode: offset is set to 0
> and max_len to dma_buf_sz + stmmac_rx_offset().
> 
> The FCS can straddle the buffer1/buffer2 boundary and a descriptor
> boundary, so it is now stripped from the tail of the assembled frame with
> pskb_trim() instead of from a single buffer, avoiding an unsigned underflow
> for frames that overflow a buffer by 1..3 bytes. For single-buffer frames
> the XDP program must not see the FCS, so it is removed from the XDP buffer
> before the program runs.
> 
> Native XDP currently only supports single-buffer (linear) frames. An
> oversized frame accepted by the MAC (jumbo enabled) is received via
> buffer2; the XDP program only sees buffer1, so on a TX/REDIRECT verdict
> the frame is forwarded truncated. XDP multi-buffer support to handle
> this case is planned as a follow-up.
> 
> AF_XDP zero-copy RX is not covered by this change: a ZC queue still
> programs buffer2 at DMA address 0 (and XGMAC has no buffer2-valid bit),
> so an oversized frame overflowing buffer1 can still trigger the same
> SMMU translation fault. Handling is planned as a follow-up.
> 
> Fixes: 88ebe2cf7f3f ("net: stmmac: Rework stmmac_rx()")
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

Meh I replied to the previous iteration... I did test V3 actually, so
here's the blurb I said on V2 + tag :

I was able to test that on DWMAC4 (stm32mp157) sending oversized frames,
and they correctly spill over the next descriptor, no crashes no stall,
the only limitation being the RX fifo size now.

Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

