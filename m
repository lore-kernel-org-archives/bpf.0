Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792431518;
	b=0BZk2OWgroyUeS+ctYSS+NcAgi4Jq6H2vUh58jNgfHUTb5uwF8uMyPqHQlQtMaFwC1fv
	 ui/lt2jgK+X0kfEtZUEirOLYiNUIRofamjJPsKG97sUkf9W02q8hTiqg9kicis2MkUTvj
	 yq5Byf8+uz2wbqkICTTE5VNbpEzhfuFzERxZT9Vx/sIi1zMXYtfcJGLXQ1+SEjvV/5mct
	 /Ux2PofvnJG5jh2YcH3tgYcUoXlBsXYegAhn3CZ7sFGNv7kLSwpJfw1AfmLl98BCLypqT
	 5HSiUZQrEJ2JHFPG59cSzjE5F51bhOJHP4nxs+3GfmrD8tnH8gpyhl/uI73QaSgeTjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792431518;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=l/5je6k7rCChD+zg8W/wKE+SGiPLHXlmUObVm64cOV8=;
	b=pyxkaLFlRZt2lHb3Gd3HrcwnmAA0r+mlWl4vfXYXMw19knVX5tfXTyWRxjxNp0atnVlK
	 oaOs+DuFWkgcslVaYkQTNcGwFfCbhhea76pSA8m0YLqzoRxiPe+ZhDNmZPM3m+yhzgKFX
	 ktiQaGxjYeWDe6Vuo2sm1rqTj8phRE6MSHvcThbbHz8GDI47vp8D0G+UHPwc+GcAlc/ts
	 MOu+kCxTXdPkv1Lg3tmZYRADxHtdMpko3vNjGZGIHEeQceHGCQKtWkWEZmx+lT9K3VgKH
	 3ARvn3HUbdKDgBBiLI+NS20K0pLtZMTCpDI+CtTb6Zdrpjn4rf+S0NXgwi2oF3VvrUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ec+TTAVM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AED606A322;
	Mon, 19 Oct 2026 17:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ec+TTAVM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EB011F000C6;
	Mon, 19 Oct 2026 17:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792431518;
	bh=l/5je6k7rCChD+zg8W/wKE+SGiPLHXlmUObVm64cOV8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Ec+TTAVMpIXnFvD3nnTuDnPrPed7rwt5u8bfmSlR8IOnUSHLngT9RYARtt2t4nrbL
	 LQoXxFhwLOkwulgWgarnktUCn6GpT1Tzp1CpkEgMn35qU90OeBhOE2WVgoZb5hGt0d
	 C7Gq8DVAmV89ixvQSkgdjP3gE/QpCg+NUDTr4M8LvCZHtLYM4e2+bxgPWNZvKFeFiO
	 m8yOYkvZzAlqdeGPDiOnbFMigbsHAy/aSQnfcM/82KPVN7JyYrb6ZtGpQB35C7et0g
	 a7kdrttnaeX4+2Vet0T8g5Q4XFtq+FhHC2oL4PZfPZRDMTiRnK55T3uhLmHG3YYxy2
	 W4vaWUPvoV4ZQ==
Subject:
 Re: [PATCH net-next v8 3/5] net: stmmac: drop multi-buffer frames in XDP mode
From: netdev-bot+sashiko@kernel.org
To: lorenzo.bianconi@oss.qualcomm.com
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, Jose.Abreu@synopsys.com, boon.leong.ong@intel.com,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 bpf@vger.kernel.org
Date: Mon, 19 Oct 2026 17:38:36 +0000
Message-ID: <179243151663.3135.5003290847659035107@kernel.org>
In-Reply-To: <20261018-stmmac-rx-mb-v8-3-5f58c0b25849@oss.qualcomm.com>
References: <20261018-stmmac-rx-mb-v8-3-5f58c0b25849@oss.qualcomm.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message does not describe what the patch actually
  does, and it hides changes to the non-XDP RX path.

--

net: stmmac: drop multi-buffer frames in XDP mode

When an XDP program is attached, stmmac_rx() now drops any frame that
spans more than one descriptor, or that uses the second buffer of a
descriptor. This prevents the XDP program from running on partial
frames. Both XDP_CONSUMED and XDP_TX/XDP_REDIRECT now finish the packet
via next instead of re-parsing the following descriptor.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index efa88cd359dac..e929cc0f23125 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -5888,18 +5888,23 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
>  		if (priv->extend_desc)
>  			stmmac_rx_extended_status(priv, &priv->xstats, rx_q->dma_erx + entry);
>  
> -		if (unlikely(status & discard_frame)) {
> -			page_pool_put_page(rx_q->page_pool, buf->page, 0, true);
> -			buf->page = NULL;
> +		if (unlikely(!error && (status & discard_frame))) {
>  			error = 1;
>  			if (!priv->hwts_rx_en)
>  				rx_errors++;
>  		}

[Severity: Low]
The commit message says the patch will:

  "mark it as errored as soon as a non-last descriptor, or a descriptor
  using its second buffer, is seen while an XDP program is attached,
  drain and release every descriptor - including the last."

Is this description accurate? This hunk removes the only
page_pool_put_page() call on the error path in stmmac_rx(). After the
patch, none of the drop paths returns a page to the page_pool. That
covers the hardware discard_frame drop, the new XDP SG drop and the new
buf2 drop.

The dropped buffers stay in rx_q->buf_pool[], and stmmac_rx_refill()
reuses them in place because it only allocates when the slot is empty:

stmmac_rx_refill() {
    ...
		if (!buf->page) {
			buf->page = page_pool_alloc_pages(rx_q->page_pool, gfp);
    ...
}

The reuse itself looks safe. All three drop checks run before any
dma_sync_single_for_cpu() or net_prefetch() on the buffer.

The new !error guard also changes rx_errors from once per descriptor
carrying discard_frame to once per frame. Both changes apply whether or
not an XDP program is attached, but the subject says "in XDP mode".

On dwmac100/dwmac1000, the previous patch in this series makes non-last
descriptors report discard_frame | rx_not_ls. So an errored frame
spread over N descriptors used to add N-1 or N to rx_errors, and now
adds 1.

Separately, the new buf2 drop in the later hunk doesn't set error, even
though the message says the frame is marked as errored:

	if (unlikely(stmmac_xdp_is_enabled(priv) && buf2_len)) {
		rx_dropped++;
		goto next;
	}

It only behaves the same way because, in XDP mode, that descriptor is
always the last one.

This patch carries a Fixes: tag for net/stable. Could the commit message
describe the in-place buffer reuse and the rx_errors accounting change
for the non-XDP path? The later "net: stmmac: rework stmmac_rx to
support XDP rx multi-buff" patch keeps both the !error guard and the
in-place reuse, so it doesn't change the picture here.

> -		if (unlikely(error && (status & rx_not_ls)))
> -			goto read_again;
> +		/* We do not support SG in XDP mode */
> +		if (unlikely(!error && (status & rx_not_ls) &&
> +			     stmmac_xdp_is_enabled(priv))) {
> +			rx_dropped++;
> +			error = 1;
> +		}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261018-stmmac-rx-mb-v8-0-5f58c0b25849%40oss.qualcomm.com
