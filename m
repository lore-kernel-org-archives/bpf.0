Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC9C2F5A2D;
	Thu,  8 Oct 2026 07:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791445827; cv=none; b=u5H0fM7swqES2uXj8k9BLLhcoZ1QkyxHq5mO7AiaFJBnOTF6eYJ0Ywiga2u25oXhCXJJ7NA7yvLE1VcK4deQXt7maLbFJUVohzF1P6b13ww0sGI0w35zQ+sW2VfwbqXJcq5RLRCKNkL1kAHIg2l9Ut+gb+Aly6JmrhVlMNCqcbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791445827; c=relaxed/simple;
	bh=HQTuKbcr56OWHudZYA/YmaZ399YGEzYzUHLXmXCYRyk=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=FDiGY1hRPBEerf7mdTPlNrgt5qKwO61TXt/uOVnFYfvnCsiVpMTulQ2s5+vA/6IYA8WE8+BfeM4nCEHKLBBUJaBpw5EPDe8MRmJ/OIEJ21QjWT6Kw/0naclwaYxuJhxSe618FcxSYQ4E58rPX5x9IItO/I+2Yp+qaYlEaud2hhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=g3P/M1+m; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="g3P/M1+m"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id ECF85A05A6;
	Thu,  8 Oct 2026 09:50:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1791445821; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=IOlVfgfP6cReZbjYOfgC3BBrEq2xqxmMoSO9wrismZA=;
	b=g3P/M1+mF5kD6hBkOKBHZoxyAkWBu+lPEehfpH8Rfpa8IeuT01zbhtt2OIcMvlGT98DBTJ
	mzKrkXcSERT8siNk7rc7F/R0nFwU+bUw0mqwCpGPbF4nQlYQkhO21ikv+5CCgIkO+DchRz
	lYjBWRCRkysI/X54d24qzdZTcCBC6Q646g9JGx4cia9H5nqCzPT9Sw17PM3w4JvLrd+oqL
	fHqI27x30xOdrFnmUxzAs/QJnVrexuuFVGmTRnNzAnrrL+wbGn/GcPiBkXElSE0KCh9R0g
	IX1a8v3l7+Ss2INEO/rpI7uGMu+ll3P9r1gyx9p2q+LK0jzDf9X1msBmi0cREQ==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 08 Oct 2026 09:50:19 +0200
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
 <yoong.siang.song@intel.com>, Noor Azura Ahmad Tarmizi
 <noor.azura.ahmad.tarmizi@intel.com>, Mohd Faizal Abdul Rahim
 <faizal.abdul.rahim@intel.com>, Ong Boon Leong <boon.leong.ong@intel.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH net v2 1/2] net: stmmac: Disable NAPI before stopping Tx
 queues in stmmac_xdp_release()
In-Reply-To: <20261005-stmmac_xsk_crashes-v2-1-46c60cba6421@linutronix.de>
References: <20261005-stmmac_xsk_crashes-v2-0-46c60cba6421@linutronix.de>
 <20261005-stmmac_xsk_crashes-v2-1-46c60cba6421@linutronix.de>
Message-ID: <bd26a838deb15b560419d1e4a33d838b@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Kurt

On 5.10.2026 09:09, Kurt Kanzenbach wrote:
> Attaching an XDP program while Tx traffic is running results in kernel
> crashes in stmmac_xmit() -> dwmac4_set_addr().
> 
> Loading an XDP program tears down and reallocates all DMA resources via
> stmmac_xdp_release() and stmmac_xdp_open(). stmmac_xdp_release() stops
> the Tx queues before disabling NAPI:
> 
>  stmmac_xdp_release:
>    netif_tx_disable
>    stmmac_disable_all_queues
>    ...
>    free_dma_desc_resources
> 
> A Tx NAPI poll may still be in flight at that point. stmmac_tx_clean()
> takes the Tx queue lock, reaps completed descriptors and wakes the 
> queue
> again when it observes it stopped with enough descriptors available.
> Nothing stops the queue afterwards, so the Tx path resumes while
> free_dma_desc_resources() releases the descriptor rings underneath it.
> 
> On non-coherent platforms dma_free_coherent() tears down the vmalloc
> mapping of the descriptors, so the subsequent stmmac_xmit() faults on 
> an
> unmapped address instead of corrupting memory silently.
> 
> Disable NAPI first and stop the Tx queues afterwards, which is the 
> order
> already used by __stmmac_release().
> 
> The issue can be easily reproduced by:
> 
>  1. Run iperf
>  2. Run application which opens an AF_XDP/ZC socket
> 
> Assisted-by: Claude:claude-opus-5
> Fixes: 77711683a504 ("net: stmmac: ensure tx function is not running in 
> stmmac_xdp_release()")
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>

> [...]

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Tested-by: Nicolai Buchwitz <nb@tipi-net.de> # stm32mp215

Thanks,
Nicolai
