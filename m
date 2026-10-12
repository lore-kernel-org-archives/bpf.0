Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F18F39478D;
	Mon, 12 Oct 2026 21:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791839059; cv=none; b=HYaAPUxVv0pMIgGqxcJZX5Kzzl0b4LREPR2GMo4b30XwZzogx6qt6GwV6ZTXs870seR+e/c/8niS1197mmW9WDaOr42J5SCOtzhK8abL4GigGMFfh0/xW4we6Gj57EHmEqwRgEFCoGP8gsRTrU+aqHh+SAlgKxj/1trssWylZoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791839059; c=relaxed/simple;
	bh=BGk7NAr2tTPjGgJaR62RozGUhRW+14yYSRcXHRoh4U8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=lNotmWSpgLkW0AEPgdGTJ+Uqmre7ng9OQnXXI5b/tzpSY0OEX0Fbu9kJ5i5Lj/u+3FgocJa4mWQTnb39zzObwsOQNqDp6jYcerI1cBZ+lcVcEHbtp9u+xK4c2Me9tBgtl08Jb9NVl2AyEPTykegmr8L1i6YWCag+XRDiU9C23/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=k9r/oLnD; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="k9r/oLnD"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D0919A1310;
	Mon, 12 Oct 2026 23:04:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1791839054; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ATDlnVkVpmBsbQi4Z42Xo1+upTwPMCBzGpQyazaRSrc=;
	b=k9r/oLnDGvjr3FmAMuH3CPaV+y2P+c3qben785WrqLhJh6pNaTakZQNJ2ky9wt6Fs+bsOj
	3WSgg2NAc5OKhJX23eXNt1jiABziDNN2fCCMwcKeqME3fBwIqAJt440qMlGsOU+rpzeAH7
	72lLMvjBBi1UQli8/iGnDKkwSWxF9EaTsEf90YetDK4Z4v07vpGCsTx0cIggwISc/JSVRH
	IYn3lkSC16pe8NfQCQ5/N024S+AMypBUpNCWml7VEbP06nEbjB/JCOittk0yd1IxPN9CZb
	CeNkg8TM8nk2zYFMHSgeS3CamxRvBPKWzjCjMl6V2M/99r7QGb8ry4VxOKAINA==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 12 Oct 2026 23:04:11 +0200
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
In-Reply-To: <20261012-stmmac-rx-mb-v6-3-2225050915c1@oss.qualcomm.com>
References: <20261012-stmmac-rx-mb-v6-0-2225050915c1@oss.qualcomm.com>
 <20261012-stmmac-rx-mb-v6-3-2225050915c1@oss.qualcomm.com>
Message-ID: <b11af7d5d430dcddcc681484b50ae7e2@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Lorenzo

On 12.10.2026 18:44, Lorenzo Bianconi wrote:
> stmmac_rx() runs the XDP program once per descriptor buffer and uses
> skb == NULL as the only marker for the start of a frame. A frame larger
> than one buffer is split by the hardware across several descriptors;
> GMAC4 enables jumbo frames unconditionally (GMAC_CONFIG_JE in
> GMAC_CORE_INIT), so an on-link peer can deliver such a frame even when
> the interface MTU is left at 1500.
> 
> When an XDP verdict ends a non-last descriptor, skb is cleared and the
> next descriptor of the same hardware frame is parsed as a new frame.
> For XDP_CONSUMED this happens via read_again with len preserved, so
> stmmac_rx_buf1_len() then returns min(dma_buf_sz, plen - len) for the
> last descriptor, which can be as small as 0-3 bytes. buf1_len -=
> ETH_FCS_LEN underflows and xdp_prepare_buff() puts data_end far past
> data; on XDP_PASS this produces an skb whose length is close to 4G that
> reaches the network stack (skb->tail and skb->len are 32-bit and wrap
> below skb->end, so skb_over_panic() does not fire). A 4+ byte tail is
> instead offered to the XDP program and delivered as a standalone
> mid-payload Ethernet frame on XDP_PASS. XDP_TX/XDP_REDIRECT instead
> falls through to the next iteration, resetting the running length, so
> the tail is re-parsed as a full-size new frame.
> 
> XDP does not support scatter-gather frames until the multi-buffer
> rework, so drop the whole frame instead: mark it as errored as soon as
> a non-last descriptor is seen while an XDP program is attached, drain
> and release every descriptor - including the last - and account the
> frame once in rx_dropped. Removing the re-parse lets both XDP verdict
> branches simply complete the packet via next.
> 
> Note: the subsequent "net: stmmac: rework stmmac_rx to support XDP rx
> multi-buff" accumulates the whole frame into a single xdp_buff and
> supersedes this patch; the fix is kept so the net portion of the series
> stands on its own.
> 
> Fixes: 5fabb01207a2 ("net: stmmac: Add initial XDP support")
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 28 
> ++++++++++-------------
>  1 file changed, 12 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c 
> b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 426bb68c9bbc..8c08d44fdbd3 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -5893,18 +5893,24 @@ static int stmmac_rx(struct stmmac_priv *priv, 
> int limit, u32 queue)
> 
>  		if (priv->extend_desc)
>  			stmmac_rx_extended_status(priv, &priv->xstats, rx_q->dma_erx + 
> entry);
> -		if (unlikely(status == discard_frame)) {
> -			page_pool_put_page(rx_q->page_pool, buf->page, 0, true);
> -			buf->page = NULL;
> +
> +		if (unlikely(!error && status == discard_frame)) {
>  			error = 1;
>  			if (!priv->hwts_rx_en)
>  				rx_errors++;
>  		}
> 
> -		if (unlikely(error && (status & rx_not_ls)))
> -			goto read_again;
> +		/* We do not support SG in XDP mode */
> +		if (unlikely(!error && (status & rx_not_ls) &&
> +			     stmmac_xdp_is_enabled(priv))) {
> +			rx_dropped++;
> +			error = 1;
> +		}

AFAIU GMAC4 and XGMAC always use the second buffer of a descriptor. If
so, at MTU 1500 a frame of up to 3072 bytes can fit in one descriptor,
and this check would not catch it?

The XDP program would then only see the first buffer. With XDP_TX the
frame is cut and sent too short. With XDP_PASS the second buffer is 
added
after the program already decided.

Patch 4 fixes this. But if this patch should work on its own, should it
also drop the frame when buf2_len is not zero? Or am I missing
something?

> [...]

Thanks,
Nicolai
