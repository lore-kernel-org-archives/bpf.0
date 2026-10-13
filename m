Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760D83FD955;
	Tue, 13 Oct 2026 12:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791893178; cv=none; b=W0cOB5ZoB7AVdiPND+yuaMl8NdcU0ld4kY9RDUgxQhdb6H18qVYFQNVxCRLHdiqogo9SjGFXe8rCYvzrUjJ/kuNCMcnlqKnNm/VIkbVBLeq0hb4d6YjmBsVccby4TWKdx3MNbn1GzT1T29E2qMEsvW6o8n8otQ52TD7/RN2jBDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791893178; c=relaxed/simple;
	bh=A4+2RIjVH4PDDEkF7kuXITq+214r5Ljx7gquaEjiI04=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=CpgltS87kEfquN1kLpZu4f/Dvjcii0PXFrsEYY9twZUMoqm8v1JguWa78a5TkxL1sG5Y/J47GyqMc2Cuo1qGulRFX6qWO4TtUVPA2DdXgV4aQpCc813267HA8zFsDD+rdMA82umbcOOmEQCfP8mLUte9TPYs+0lkY/m1hEM9Ejg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=x4RpA1an; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="x4RpA1an"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5B73CA154D;
	Tue, 13 Oct 2026 14:06:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1791893169; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=eMLdNmdNwgUmvAo6yFCQwGyE2IXMBMPu/dG68ponrNc=;
	b=x4RpA1anJUuS6zo86bux7WVQtdYUwwEKX5gOg2e6Pmj7RB5A1O08u9aUZnNZavuNduP+Mz
	DbQ/tQKRZvQ8yb8BG5QDHf7vULvBdcN+Lrg0Mz6nLbkgJ3dYPqixPoUfGaoBkswyuC13ZZ
	8WW6NckeKULzD80LBeWQ0v2xm2ttFX5yYTiT446qZum2Xm8+VzCQY8LF4oReLmDXeNKnqG
	jIcHHAjUI7HAZBPltTfQ1avQsgmlS6Paxc2InQPR3mXFxLFEdg3+eV7eM8NLHGsRij8ncg
	Eh24DGwxRDd8daIFQ2hJQO4JQ3fT17UiTjJWK7/R6tyt8lXjF1MXaIMpZgD6xQ==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 13 Oct 2026 14:06:06 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Song Yoong Siang
 <yoong.siang.song@intel.com>, Mohd Faizal Abdul Rahim
 <faizal.abdul.rahim@intel.com>, Ong Boon Leong <boon.leong.ong@intel.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH net v3 2/2] net: stmmac: Stop Tx queue when (en|dis)abling
 XSK pools
In-Reply-To: <20261013-stmmac_xsk_crashes-v3-2-50fca7790af2@linutronix.de>
References: <20261013-stmmac_xsk_crashes-v3-0-50fca7790af2@linutronix.de>
 <20261013-stmmac_xsk_crashes-v3-2-50fca7790af2@linutronix.de>
Message-ID: <cccec8df7c85b987bc67affeedfe40e2@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Kurt

On 13.10.2026 10:57, Kurt Kanzenbach wrote:
> When enabling or disabling XSK pools in parallel to Tx traffic, kernel
> crashes occur. For VLAN tagged frames that happens in stmmac_xmit() ->
> dwmac4_set_vlan_tag() and for normal frames in stmmac_xmit() ->
> dwmac4_set_addr(). Both of these functions access the Tx DMA 
> descriptors.
> 
> The XDP pool (en|dis)ablement frees and reallocates the Tx DMA 
> resources:
> 
>  stmmac_disable_tx_queue:
>    __free_dma_tx_desc_resources
> 
>  stmmac_enable_tx_queue:
>    __alloc_dma_tx_desc_resources
>    __init_dma_tx_desc_rings
> 
> NAPI is disabled during that allocation window, but the Tx queue is not
> stopped. Therefore, add the stopping of the Tx queue during the 
> enabling
> and disabling of XSK pools.
> 
> The issue can be easily reproduced by:
> 
>  1. Run iperf
>  2. Run application which opens an AF_XDP/ZC socket
> 
> Also add a dedicated queue check for the XDP Tx paths.
> 
> Fixes: 132c32ee5bc0 ("net: stmmac: Add TX via XDP zero-copy socket")
> Suggested-by: Nicolai Buchwitz <nb@tipi-net.de> # XDP Tx checks
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>

> [...]

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Tested-by: Nicolai Buchwitz <nb@tipi-net.de> # stm32mp215

Thanks,
Nicolai
