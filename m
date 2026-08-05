Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D3D3A7F46
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 05:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785908474; cv=none; b=Jp9iI0jQxLsYh0EcUYJlTOGx+XmnQ3yQY28EDcT3m96xkfXG/TYs74niB3yDm6Kh2DIVEGIEHqm0YfpSHREVCkWVnUE/YFYdl1CZeIUrY2jBHc6a3HrLzGt96Yw6FgUlte5mryMvOv1UZI0sPc3btzbnMVy15XKNqRzlFsPwJ40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785908474; c=relaxed/simple;
	bh=S+JB0JgDQg/8OybaIkiMaB3zrrpgIdCZyKUYB3ODhi8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hvrp3LavghU447ktAVMU2mk91ViqoxlJMni9ECewqyp0hLjV5nsk5hyt7yYLS+R5/DNOTyYMxkGLmxJDEyqJKcXsZfMd/slCdn+gAnjfdRgQnd66/l00P9cl2d5ncLwAGi3+3lUl0aK9AQhf795V85m97k6BVJjXB345SSowArc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GjmHnlQ0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GjmHnlQ0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74DF91F000E9;
	Wed,  5 Aug 2026 05:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785908469;
	bh=qtJl8kX8pSCSdzeiWgYf6EEBoVs6QIKqUGeiS7EmMcY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GjmHnlQ0nP4kHJuGeaWe11obseF39cJaLvpA8c5w5D3ZYOASjtPV7/S2rEsHRZBEk
	 GhbKGYAjTkYz0DxtIXtM6sM8BhX10YExr0WxkeryGcrexkc43pkOnoknKcIm9E2psO
	 3+/Upk2NcIv+iCP2Oo+h/i+IWD0j7yFqZw22n7ylOImvuTKsW+pYnbPH4AhRGg5Qob
	 /cZ2yteFll0rOwNEQmh7NUfBKa4SbSly9w6XL1bJ1E6kRXGgaaBNnsx0wuRB3yMYfM
	 fLFU1xopfN3cuBNvK4w8118OAbeb3nMLUdAe4uElfMLsvfJeCREBU9+eQJDbKiDFgw
	 3hwnSlnexQEeQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 1/2] net: fix skb length accounting after generic
 XDP frag adjustment
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sun Jian" <sun.jian.kdev@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260804054040.613675-2-sun.jian.kdev@gmail.com>
References: <20260804054040.613675-1-sun.jian.kdev@gmail.com>
 <20260804054040.613675-2-sun.jian.kdev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 05:41:08 +0000
Message-Id: <20260805054109.74DF91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Preexisting bug: bpf_xdp_adjust_tail for generic XDP incorrectly f=
rees system_page_pool fragment pages using the driver's RX queue memory mod=
el.
- [High] The exact length accounting vulnerability fixed in `bpf_prog_run_g=
eneric_xdp` remains unpatched in the native XDP receive path for veth devic=
es (`veth_xdp_rcv_skb`).
--

--- Patch [1]: [PATCH net v3 1/2] net: fix skb length accounting after gene=
ric XDP frag adjustment ---
commit e03da2f78f026fb5c5139f386cdfe9ac7e62b48f
Author: Sun Jian <sun.jian.kdev@gmail.com>
Subject: net: fix skb length accounting after generic XDP frag adjustment

Generic XDP exposes non-linear skb fragments through an xdp_buff. If an
XDP program adjusts the fragment area, bpf_prog_run_generic_xdp() copies
xdp_frags_size back to skb->data_len but leaves skb->len containing the
old fragment contribution.

This patch subtracts the old data_len before replacing it and adds the new
data_len afterwards, keeping skb->len and skb->data_len synchronized.

Link: https://lore.kernel.org/bpf/al9T9Eto%2FhRIzP5W@boxer/

> diff --git a/net/core/dev.c b/net/core/dev.c
> index 5933c5dab09ee..5c37cf6c4aa10 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -5517,12 +5517,16 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb,=
 struct xdp_buff *xdp,
>  	}
> =20
>  	/* XDP frag metadata (e.g. nr_frags) are updated in eBPF helpers

[Severity: High]
This is a pre-existing issue, but since this code path relates to fragment
shrinking via bpf_xdp_adjust_tail(), does it incorrectly free system_page_p=
ool
fragment pages using the driver's RX queue memory model?

In generic XDP, skb fragments are reallocated using system_page_pool:

net/core/dev.c:netif_skb_check_for_xdp() {
    ...
    err =3D skb_cow_data_for_xdp(this_cpu_read(system_page_pool.pool), pskb=
, prog);
    ...
}

However, bpf_prog_run_generic_xdp() initializes the xdp_buff with the device
driver's rxqueue:

net/core/dev.c:bpf_prog_run_generic_xdp() {
    ...
    xdp_init_buff(xdp, frame_sz, &rxqueue->xdp_rxq);
    ...
}

When an XDP program shrinks fragments, bpf_xdp_shrink_data() retrieves the
driver's mem_type and passes it to __xdp_return():

net/core/filter.c:bpf_xdp_shrink_data() {
    ...
    enum xdp_mem_type mem_type =3D xdp->rxq->mem.type;
    ...
    if (release) {
        __xdp_return(netmem, mem_type, false, zc_frag);
    ...
}

If mem_type is MEM_TYPE_PAGE_SHARED, __xdp_return() routes to page_frag_fre=
e(),
bypassing the required page_pool_put_full_netmem() hooks for system_page_po=
ol
pages. Can this leak DMA mappings and corrupt page structures when these
pages reach the buddy allocator?

> -	 * (e.g. bpf_xdp_adjust_tail), we need to update data_len here.
> +	 * (e.g. bpf_xdp_adjust_tail). Remove the old fragment contribution
> +	 * from skb->len before updating data_len, then add the new one back.
>  	 */
> -	if (xdp_buff_has_frags(xdp))
> +	skb->len -=3D skb->data_len;
> +	if (xdp_buff_has_frags(xdp)) {
>  		skb->data_len =3D skb_shinfo(skb)->xdp_frags_size;
> -	else
> +		skb->len +=3D skb->data_len;

[Severity: High]
This isn't a bug introduced by this patch, but does the exact length
accounting vulnerability fixed here remain unpatched in the native XDP
receive path for veth devices?

Looking at veth_xdp_rcv_skb() in drivers/net/veth.c:

drivers/net/veth.c:veth_xdp_rcv_skb() {
    ...
    off =3D xdp->data_end - orig_data_end;
    if (off !=3D 0)
        __skb_put(skb, off); /* positive on grow, negative on shrink */

    /* XDP frag metadata (e.g. nr_frags) are updated in eBPF helpers
     * (e.g. bpf_xdp_adjust_tail), we need to update data_len here.
     */
    if (xdp_buff_has_frags(xdp))
        skb->data_len =3D skb_shinfo(skb)->xdp_frags_size;
    else
        skb->data_len =3D 0;
    ...
}

If an XDP program shrinks an skb's fragment area, skb->data_len is updated
but skb->len is not adjusted, which would artificially inflate skb_headlen()
and potentially leak adjacent kernel memory to userspace.

Additionally, if the fragments are completely dropped, xdp->data_end shrink=
s,
resulting in a negative off passed to __skb_put(). Since skb->data_len is
still non-zero during the __skb_put() call, would SKB_LINEAR_ASSERT() trigg=
er
a BUG_ON and cause a kernel panic?

> +	} else {
>  		skb->data_len =3D 0;
> +	}
> =20
>  	/* check if XDP changed eth hdr such SKB needs update */
>  	eth =3D (struct ethhdr *)xdp->data;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804054040.6136=
75-1-sun.jian.kdev@gmail.com?part=3D1
