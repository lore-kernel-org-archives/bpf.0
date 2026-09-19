Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA006282F0C
	for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 15:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789830520; cv=none; b=pAQ1Px5UenjtjwATGq7dau+VPtrxLWSEaOd+D4B3LGwk1B9e68M3NvmwzWRthBLEVrGMn8yQJQPcpQJixlTlzQgN5InveE9r616T+asvdaMGei7HwyUP/QUgd2q/MI5gD0TJkB7gEOuz7848lZ5HeE2mUTplW7fm2vcd8x11Rxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789830520; c=relaxed/simple;
	bh=Jq0RcJ8TMRb1o/GzSlKEly4Y6xM7dk+vvRMZFqU4lRY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fm8MViOXiVzFdeFqzvTxye4UXG6uKafRnXVl2OcWAvZEqVv0W7dGPnsWs7ucgbjo++cxAayfrEw7Pq76qVazEL77JOJ5eYWLwuEuNqW19Ik9j5UBzT9n2EDnh3RoE6Dk6FbkSmKh7pRtnjyVNDYp3AXIkEIaLdSmYRN7bRh3q5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ldWOe0nF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ldWOe0nF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B09A1F000FF;
	Sat, 19 Sep 2026 15:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789830518;
	bh=M5LYerJnXvM+WGzJHVVbSmWl+UHX2NRNgbnTVJmC810=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ldWOe0nFUSfNmDRZx+saq+XoQK4k9cG42dWSREnTP3hEJ6F55iafbuVlHa9Fgko9Q
	 YpZ6wUcENOgluBCDW1kbJ3MKjGECCC94Lvx8qsTHZuZmq+NX5Riyb7PMqSuX6Ptqyd
	 PxM0bP91KgE5mGu+qH5yQ3SntIwFcc+0h593H9o8O/cMWOZs5AjlbjuxQcdlDgtGSB
	 Ibj4dXMBwMaYhaUaihNNtDpaH4+4VEyi8rnrUx3NK9wPAI/rmouqeUf6UclusAkL7p
	 UTS926iifAkaIBODWvdCkSNjC+11xRgoUsUNpCRzoefbiij1aqSuNuZ8YOzqY4sSOU
	 biIdjwhgYbfOA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next] net: stmmac: rework stmmac_rx to support XDP
 rx multi-buff
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lorenzo Bianconi" <lorenzo.bianconi@oss.qualcomm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260918-stmmac-rx-mb-v1-1-0b4517d404af@oss.qualcomm.com>
References: <20260918-stmmac-rx-mb-v1-1-0b4517d404af@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 15:08:37 +0000
Message-Id: <20260919150838.4B09A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] stmmac: loop state leak on skb build failure causes panic and memo=
ry corruption
- [High] stmmac: uninitialized xdp_frags_truesize corrupts socket memory ac=
counting
- [High] stmmac: silently truncated frames bypass checksum errors and cause=
 data corruption
- [Medium] stmmac: unconditional rx state clear when NAPI budget is zero le=
aks memory
--

commit 342011b18b585ad2ea2189dab3bfe7efcf08625c
Author: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

net: stmmac: rework stmmac_rx to support XDP rx multi-buff
   =20
Build the xdp_buff by accumulating all the descriptors that make up a
frame, so the XDP program runs on the full (possibly fragmented) packet
instead of just the first buffer. When the frame is not consumed by the
program, assemble the skb from the head buffer and the collected
fragments via napi_build_skb()/xdp_update_skb_frags_info().

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_main.c
> index bf9e7e4cb1c31..1de8d9626c640 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -5735,6 +5737,82 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, =
int limit, u32 queue)
>  	return failure ? limit : (int)count;
>  }
> =20
[ ... ]
> +static void stmmac_build_xdp_frags(struct stmmac_priv *priv,
> +				   struct stmmac_rx_queue *rx_q,
> +				   unsigned int len, struct page *page,
> +				   unsigned int offset,
> +				   enum dma_data_direction dma_dir,
> +				   struct xdp_buff *xdp)
> +{
> +	struct skb_shared_info *sinfo =3D xdp_get_shared_info_from_buff(xdp);
> +	dma_addr_t dma_addr =3D page_pool_get_dma_addr(page) + offset;
> +
> +	dma_sync_single_for_cpu(priv->device, dma_addr, len, dma_dir);
> +
> +	if (!xdp_buff_has_frags(xdp)) {
> +		xdp_buff_set_frags_flag(xdp);
> +		sinfo->xdp_frags_size =3D 0;
> +		sinfo->nr_frags =3D 0;
> +	}

[Severity: High]
Does this code fail to initialize sinfo->xdp_frags_truesize, leaving it with
uninitialized memory?

If the XDP program redirects the packet, generic XDP handlers like
xdp_build_skb_from_buff() use tsize =3D sinfo->xdp_frags_truesize ? : ...

Could this random non-zero garbage be added to skb->truesize, causing massi=
ve
socket memory accounting (sk_rmem_alloc) corruption and subsequent drops?

> +
> +	if (sinfo->nr_frags < MAX_SKB_FRAGS) {
> +		skb_frag_t *frag =3D &sinfo->frags[sinfo->nr_frags++];
> +
> +		skb_frag_fill_page_desc(frag, page, offset, len);
> +		sinfo->xdp_frags_size +=3D len;
> +
> +		if (page_is_pfmemalloc(page))
> +			xdp_buff_set_frag_pfmemalloc(xdp);
> +	} else {
> +		page_pool_put_full_page(rx_q->page_pool, page, true);
> +	}

[Severity: High]
If a packet exceeds MAX_SKB_FRAGS, does returning the excess pages to the p=
ool
here silently truncate the payload without marking the frame as errored?

Because the hardware perfectly validated the original full frame's checksum,
could the truncated frame be passed up to the network stack where stmmac_rx=
()
will set skb->ip_summed =3D CHECKSUM_UNNECESSARY?=20

While the IPv4/v6 stack might drop it due to length mismatch, could bridged
Layer-2 traffic or XDP redirection forward the truncated payload with a val=
id
checksum, leading to silent data corruption at the destination?

> +}
> +
>  /**
>   * stmmac_rx - manage the receive process
>   * @priv: driver private structure
[ ... ]
> @@ -5831,6 +5911,10 @@ static int stmmac_rx(struct stmmac_priv *priv, int=
 limit, u32 queue)
>  		if (unlikely(error && (status & rx_not_ls)))
>  			goto read_again;
>  		if (unlikely(error)) {
> +			if (!first_desc) {
> +				stmmac_xdp_put_buff(rx_q, &ctx.xdp, -1);
> +				first_desc =3D true;
> +			}
>  			dev_kfree_skb(skb);

[Severity: High]
Is it possible for dev_kfree_skb(skb) to cause a kernel panic here by
dereferencing an error pointer?

If stmmac_build_skb() fails later in this loop, it jumps to read_again and
skb will contain an ERR_PTR(-ENOMEM). If the next frame has an RX error,
this path will be taken with that error pointer.

>  			skb =3D NULL;
>  			count++;
[ ... ]
> @@ -5914,51 +6014,13 @@ static int stmmac_rx(struct stmmac_priv *priv, in=
t limit, u32 queue)
>  			}
>  		}
> =20
> -		if (!skb) {
> -			unsigned int head_pad_len;
> -
[ ... ]
> -drain_data:
> -		if (likely(status & rx_not_ls))
> +		skb =3D stmmac_build_skb(&ctx.xdp);
> +		if (IS_ERR(skb)) {
> +			stmmac_xdp_put_buff(rx_q, &ctx.xdp, -1);
> +			rx_dropped++;
> +			count++;
>  			goto read_again;

[Severity: High]
Does this jump skip the loop header where skb =3D NULL and len =3D 0 reset =
the
state?

As noted above, this leaves skb as an ERR_PTR for the next iteration.
Additionally, since len is not reset, could stmmac_rx_buf2_len() later
underflow, producing a massive unsigned length for DMA syncs and leading to
memory corruption?

> -		if (!skb)
> -			continue;
> +		}
> =20
>  		/* Got entire packet into SKB. Finish it. */
> =20
[ ... ]
> @@ -5991,9 +6053,9 @@ static int stmmac_rx(struct stmmac_priv *priv, int =
limit, u32 queue)
>  		count++;
>  	}
> =20
> -	if (status & rx_not_ls || skb) {
> -		rx_q->state_saved =3D true;
> -		rx_q->state.skb =3D skb;
> +	rx_q->state_saved =3D !first_desc;
> +	if (!first_desc) {
> +		rx_q->state.xdp =3D ctx.xdp;
>  		rx_q->state.error =3D error;
>  		rx_q->state.len =3D len;
>  	}

[Severity: Medium]
Will this unconditionally drop previously saved state if limit =3D=3D 0?

If stmmac_rx() is invoked with limit =3D=3D 0 (e.g., via netpoll), the loop
while (count < limit) is bypassed entirely, and first_desc remains true.

Does setting rx_q->state_saved =3D !first_desc unconditionally overwrite the
saved state to false, discarding any partially accumulated xdp_buff from a
previous poll without freeing the associated fragments and causing a memory
leak?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918-stmmac-rx-=
mb-v1-1-0b4517d404af@oss.qualcomm.com?part=3D1
