Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794449623;
	b=B78SdDfyaUUtiVkYooiJIZts0F5n8Y6oD/+EjynriA0YPAWIjt94n7WrX4x9MWcrkvOs
	 SI+7DYRxylMDzMhh7zAaw+UyapK/GxygAsqzoWVDQiPjF69WsrrKqFAo9a3MTo2XAZu5u
	 /dWadruNQtDkmsdM4i2CwgiUO7E2fR7gsOVpzn3VwKd4nOs/8dcBjNbaVd/3n+mvFz9uw
	 Ej3LxIdqRviLRaT7oAL+o9UgAHgJ1TkhieXwjQ3Ku3aLJFnusb45pgirhBiwV7FMOEOkh
	 kCWBJth3YQhAhvDgVDX2q1TmJ/7rPecLfZ2/v6pJbslr/UoOiVYpdZUikOmByjI4ycg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794449623;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ASxibD7eZkzQFD1xdlQZW+ZvbrwHxv8p5UBEzGgjh6c=;
	b=UwTXVFHiWCyoFLppQUb2HQOMyDfcJqlBRonMxUA49YObskqTv242Vi2kgoMN5lzpJZjI
	 NMnMpbCbw/ScH7kQp1cirI9HvOQK3zpP5NIdYSbnuNy9gfmmL95wyrrHnKYlgp6TSvemy
	 /+eDfQm+6rR3MzWBuQtkQ8GYnm7cjgpTbK71WvO9gTQl7M/W7WSq82eV+XHraTX92IA0+
	 QPG3oe6isRzL9fIJuln5h45ZzR7qk5iRvUY+vmbVnP3QxPqINM9F6eYqSPha1aaOzxbEk
	 FhKL7e3sOGoFPshxjOlkCflzbd4ybW8RILsmGJBtLLEv9cxSCd0RgPkce4xneUlrfGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="aW3ZCB/I";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9040606A327;
	Thu, 12 Nov 2026 02:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aW3ZCB/I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BF0B1F00A05;
	Thu, 12 Nov 2026 02:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794449622;
	bh=ASxibD7eZkzQFD1xdlQZW+ZvbrwHxv8p5UBEzGgjh6c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aW3ZCB/I5FqCT1QTrrYSfnW73l065oZNdZXhjvby7kHi1ZSkeVXLP3eqLlENLiHaP
	 iQnDSIrUQGyoKlO8Q1pv1kn0/pXGMJ0rgxkR9C+PI58GyHZBSvltR5SSAq9Qj5wdGQ
	 IgstssvDXsHNClcHzQTRvOI1pRqhUXqk9Ax9x/rHdZKWnuQYE50XfnKo20q5FqEUsu
	 RczCKoIqSWrmUv3KT65booOJnRKsVUN0XxVKa883AIUYHHRiEhye6H1ZVgId2lvGAa
	 jUaSporZwXBFSDy7qmpiNiMmXb8ql0dG6NcRcowuF3jut3t6FBSiYVBMtbhR/MH0ip
	 HGNU6c8gjHwLw==
Date: Wed, 11 Nov 2026 18:13:41 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev
 <sdf@fomichev.me>, Jose Abreu <Jose.Abreu@synopsys.com>, Ong Boon Leong
 <boon.leong.ong@intel.com>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, Nicolai Buchwitz
 <nb@tipi-net.de>
Subject: Re: [PATCH net-next v9] net: stmmac: rework stmmac_rx to support
 XDP rx multi-buff
Message-ID: <20261111181341.56706354@kernel.org>
In-Reply-To: <20261106-stmmac-rx-mb-v9-1-c099c923664b@oss.qualcomm.com>
References: <20261106-stmmac-rx-mb-v9-1-c099c923664b@oss.qualcomm.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 06 Nov 2026 11:54:19 +0100 Lorenzo Bianconi wrote:
> +static struct sk_buff *stmmac_build_skb(struct xdp_buff *xdp)
> +{
> +	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
> +	u32 metasize = xdp->data - xdp->data_meta;
> +	struct sk_buff *skb;
> +	u8 num_frags = 0;
> +
> +	if (unlikely(xdp_buff_has_frags(xdp)))
> +		num_frags = sinfo->nr_frags;
> +
> +	skb = napi_build_skb(xdp->data_hard_start, xdp->frame_sz);
> +	if (!skb)
> +		return NULL;
> +
> +	skb_mark_for_recycle(skb);
> +	skb_reserve(skb, xdp->data - xdp->data_hard_start);
> +	skb_put(skb, xdp->data_end - xdp->data);
> +	if (metasize)
> +		skb_metadata_set(skb, metasize);
> +
> +	if (unlikely(xdp_buff_has_frags(xdp)))
> +		xdp_update_skb_frags_info(skb, num_frags, sinfo->xdp_frags_size,
> +					  sinfo->xdp_frags_truesize,
> +					  xdp_buff_get_skb_flags(xdp));
> +	return skb;
> +}

This is almost identical to xdp_build_skb_from_buff(), why not use the
common code?

> +static void
> +stmmac_xdp_put_buff(struct stmmac_rx_queue *rx_q, struct xdp_buff *xdp,
> +		    bool allow_direct)
> +{
> +	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
> +	int i;
> +
> +	if (likely(!xdp_buff_has_frags(xdp)))
> +		goto out;
> +
> +	for (i = 0; i < sinfo->nr_frags; i++)
> +		page_pool_put_full_page(rx_q->page_pool,
> +					skb_frag_page(&sinfo->frags[i]),
> +					allow_direct);
> +out:
> +	page_pool_put_full_page(rx_q->page_pool, virt_to_head_page(xdp->data),
> +				allow_direct);
> +}
> +
> +static int stmmac_xdp_shrink_tail(struct stmmac_rx_queue *rx_q,
> +				  struct xdp_buff *xdp, int offset)
> +{
> +	struct skb_shared_info *sinfo;
> +	int i;
> +
> +	if (unlikely(offset < 0 ||
> +		     offset > (int)xdp_get_buff_len(xdp) - ETH_HLEN))
> +		return -EINVAL;
> +
> +	if (likely(!xdp_buff_has_frags(xdp))) {
> +		xdp->data_end -= offset;
> +		return 0;
> +	}
> +
> +	sinfo = xdp_get_shared_info_from_buff(xdp);
> +	for (i = sinfo->nr_frags - 1; i >= 0 && offset > 0; i--) {
> +		skb_frag_t *frag = &sinfo->frags[i];
> +		int delta = min_t(int, offset, skb_frag_size(frag));
> +
> +		if (delta == skb_frag_size(frag)) {
> +			/* The whole frag is consumed by the strip: return it
> +			 * to the page pool right away. Its ring slot still
> +			 * carries the page DMA address until stmmac_rx_refill()
> +			 * re-arms it at the end of the NAPI poll. This is
> +			 * safe because HW cannot touch the slot until then.
> +			 */
> +			page_pool_put_full_page(rx_q->page_pool,
> +						skb_frag_page(frag), true);
> +			sinfo->nr_frags--;
> +			sinfo->xdp_frags_truesize -= xdp->frame_sz;
> +		} else {
> +			skb_frag_size_sub(frag, delta);
> +		}
> +
> +		sinfo->xdp_frags_size -= delta;
> +		offset -= delta;
> +	}
> +
> +	if (unlikely(!sinfo->nr_frags)) {
> +		xdp_buff_clear_frags_flag(xdp);
> +		xdp_buff_clear_frag_pfmemalloc(xdp);
> +		xdp->data_end -= offset;
> +	}
> +
> +	return 0;
> +}

These two OTOH could easily become new common helpers, they seem to do
nothing stmmac specific?
