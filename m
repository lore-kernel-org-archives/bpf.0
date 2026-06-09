Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FB940D581
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 20:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781037106; cv=none; b=NhvYUO6xE4v8tfXNs4DsXeXqgUlVvvrA/NQ76FpMHHP6pnvlpbkP9sn7i2xZoYYjGz6+B4bpyuTLrcCn8I8PDxAzEXTzG44baXmz3Cwt5OyewAGIg/eSu5d1uu1x9T8E3JhfISVxmYxD9aI0A90cYyUeJKs9g487c8FTB3xn9DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781037106; c=relaxed/simple;
	bh=wEJ0Xw3Z7ZkOCXo41qhtilXgzMhoZ8sxFUWuRJy79Js=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Koifb9Vllb4FprkJrg6vB/x5bNWD5JLa968y3rIyn3NLLirSFhQcH/Pb7LD85Ch94Ah03grfJEiYVHhxsrEKea8XSC/Lx8WWhSKNjWRQPiNE45RIpJbZzLJDryym45iFwiOVnTl9F6/mFIiziC9/X6g4QRmsTp/SyoOp+/Wf2R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8vBz7o9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8vBz7o9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB9E41F00893;
	Tue,  9 Jun 2026 20:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781037105;
	bh=40OMUhF+5oydf4akH1Bi9bgsyaiJ56GjXTsFFiBF29M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B8vBz7o9dRH/OobPyOcQ6UX4otkAw6SxeDJ5azcjpt9XSZ+yceS19LnHC6Xd/fhoC
	 lzw8zkkXyVJVAfMZdT9A0rl1HUI1HOUMtiZYN/YtSY83iOK6YU1HUA7dNZYIjv//g2
	 N2WDTcNX3TdJHGeSe893xvXTWPUNgKui7PxsadPG0wXu2IGBUcekm0vNKJnaeZ5C0Y
	 ktxOaaUNLUiR2jIUA7ZJAWN4V2a4e+Yx/xLqvpqRFWwQ0qB6Vya1MqTXhS3jeZL/HI
	 6LwxwpHRC6nszCYwZ+qUJYIu2aE4CEpTa3xQGtHNf8EVJLIdPihuwkZaJlTOmNG8VR
	 SVjQk4aKH72Ow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] bnxt: fix head underflow on XDP head-grow
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joe Damato" <joe@dama.to>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260608203129.920104-1-joe@dama.to>
References: <20260608203129.920104-1-joe@dama.to>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 20:31:44 +0000
Message-Id: <20260609203144.DB9E41F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Out-of-bounds read of NET_IP_ALIGN bytes when XDP consumes all hea=
droom.
- [High] Leaked XDP fragments or permanent rx_agg_ring exhaustion when rx_s=
kb_func fails.
- [High] Missing DMA Sync on Buffer Reuse corrupts device memory.
- [High] Missing XDP Metadata Handling for large packets.
- [High] Double dma_sync_single_for_cpu destroys XDP payload modifications =
on non-coherent architectures.
--

commit c05fa36ff7d12821126ed8ba4fc33d7ac7363af0
Author: Joe Damato <joe@dama.to>
Date:   Mon Jun 8 20:31:28 2026 +0000

    bnxt: fix head underflow on XDP head-grow
   =20
    The xdp.py test test_xdp_native_adjst_head_grow_data crashes when run on
    a bnxt machine (and also crashes in NIPA).
   =20
    It seems that the bug is an underflow in bnxt_rx_multi_page_skb, which
    builds the skb head:

[ ... ]

>     The other rx_skb_func implementations don't have this issue.

[Severity: High]
This is a pre-existing issue, but does bnxt_rx_page_skb() actually have a
similar underflow?

If an XDP program adjusts the head backwards by the full available headroom,
data_ptr is pushed to the beginning of the DMA-mapped fragment.

bnxt_rx_page_skb() then calls:

    memcpy(skb->data - NET_IP_ALIGN, data_ptr - NET_IP_ALIGN,
           payload + NET_IP_ALIGN);

Since data_ptr is at the very beginning of the memory fragment, wouldn't
subtracting NET_IP_ALIGN cause an out-of-bounds read of unmapped memory bef=
ore
the page?

This same pattern appears to exist in bnxt_copy_data().

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethe=
rnet/broadcom/bnxt/bnxt.c
> index 35e1f8f663c78..448609cc1617c 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -1174,7 +1174,9 @@ static struct sk_buff *bnxt_rx_multi_page_skb(struc=
t bnxt *bp,
[ ... ]
>  	err =3D bnxt_alloc_rx_data(bp, rxr, prod, GFP_ATOMIC);
>  	if (unlikely(err)) {
>  		bnxt_reuse_rx_data(rxr, cons, data);

[Severity: High]
This isn't a bug introduced by this patch, but is device memory corrupted h=
ere
when the buffer is reused?

When XDP is active, the buffer is prepared for the CPU using
dma_sync_single_for_cpu(..., DMA_BIDIRECTIONAL).

If the allocation fails here, bnxt_reuse_rx_data() places the buffer back i=
nto
the hardware RX ring without calling dma_sync_single_for_device().

Could the CPU cache retain dirty lines that get evicted asynchronously,
corrupting the new packet data when the device DMA writes to this memory?

This also occurs in bnxt_rx_xdp() on XDP_DROP.

>  		return NULL;
>  	}
>  	dma_addr -=3D bp->rx_dma_offset;
>  	dma_sync_single_for_cpu(&bp->pdev->dev, dma_addr, rxr->rx_page_size,
>  				bp->rx_dir);

[Severity: High]
This is a pre-existing issue, but would this redundant sync destroy XDP pay=
load
modifications on non-coherent architectures?

When XDP is active, bnxt_xdp_buff_init() already prepares the packet for the
CPU. The XDP program executes and may modify the packet payload in the CPU =
cache.

If dma_sync_single_for_cpu() is called again here unconditionally with
DMA_BIDIRECTIONAL, it might invalidate the CPU cache on non-coherent
architectures (like ARM64), causing the CPU to read stale packet data from =
RAM
and lose the XDP modifications.

This same pattern appears to exist in bnxt_rx_page_skb().

> -	skb =3D napi_build_skb(data_ptr - bp->rx_offset, rxr->rx_page_size);
> +	frag_off =3D dma_addr - page_pool_get_dma_addr(page);
> +	frag_start =3D page_address(page) + frag_off;
> +	skb =3D napi_build_skb(frag_start, rxr->rx_page_size);
>  	if (!skb) {
>  		page_pool_recycle_direct(rxr->page_pool, page);
>  		return NULL;
>  	}
>  	skb_mark_for_recycle(skb);
> -	skb_reserve(skb, bp->rx_offset);
> +	skb_reserve(skb, data_ptr - (u8 *)frag_start);
>  	__skb_put(skb, len);
> =20
>  	return skb;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing this I notic=
ed
that XDP metadata might be dropped for large packets in bnxt_rx_pkt():

    skb =3D bp->rx_skb_func(bp, rxr, cons, data, data_ptr, dma_addr,
                          payload | len);

The SKB builder function (like bnxt_rx_multi_page_skb) is called without pa=
ssing
the metadata length, and skb_metadata_set() is never called on this path.

Are XDP metadata silently dropped for all packets larger than rx_copybreak?


[Severity: High]
This is a pre-existing issue, but could an allocation failure here cause a =
leak?

In bnxt_rx_pkt():

    skb =3D bp->rx_skb_func(bp, rxr, cons, data, data_ptr, dma_addr,
                          payload | len);
    if (!skb)
        goto oom_next_rx;

If the SKB allocation fails (e.g., OOM), the code jumps directly to oom_nex=
t_rx,
bypassing the cleanup block for aggregated fragments (agg_bufs).

For XDP, these fragments are owned by the xdp_buff and must be freed using
bnxt_xdp_buff_frags_free(). For non-XDP, they must be skipped via
bnxt_reuse_rx_agg_bufs().

Does bypassing this cleanup lead to a permanent page pool memory leak (for =
XDP)
or permanent exhaustion of the hardware rx_agg_ring (for non-XDP)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608203129.9201=
04-1-joe@dama.to?part=3D1
