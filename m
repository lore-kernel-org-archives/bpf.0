Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792600331;
	b=Nm0gfsU9QUohH7c+Mj/3serr7sAFlkmSBe4/fsbX4q1rKl1wvycInjWxAP8t/BI58Ya/
	 ghzvnNwM00RSqMUob71FAUS1v9xk8paSke61Xyja9BLe62MKrslPNhP83n1S6Y3TStwwl
	 RZBmxGkQbDLsYFqfrestQebAXeezeIcBB1mqFiy8eTC3vclbZ+x95tqOz03T6h8Z9vPRb
	 TV1TF4TjyZh0CAv+jYgQw9kUDlHC+Sdast51i/R/yFyCO4uNAZei03jZP2fLnEwZEqn3w
	 60C/T5CkaxvrvoFYnXwq9ghkQn5ehMNTUIW6cwRo4VULd1JZhuYjsJHQj8lgLHTRRxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792600331;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hWPhn/sEKxSR6yISxRC42gyehfNe6MmeCModEqQ++2s=;
	b=nTfGZ/d0Qd1FocsU0wtxCUvEiexUJ5srQBITyQs5xgTnu5JRKBFWFsz9wYMJIDnU637L
	 DIT3FxiKY+wCgSMnN5YEMBFvFS3myv6rs+Ra3QcY0AaVHfTVdANlbSSmYFAX+IuwvESNv
	 6K1H9z1xBX1Ppu7dNQt6NT8L1Bsu8imdzSxnVKrubuvOQBPmdUlLlK/Sw2UjZLhJawoIX
	 NluK2m/20NNiG0UZDANXV3Wba7rih+qRDvGTOS7rmE9sK40c/JMOgeCcAus2+M5f6j33Q
	 jH4GTcHAzr8MqOmtJb+D+FiKfXS+pVCroY2pNoFECqdkkY3gpwSsGOTqXn9XPjKcJyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jg2CsMWJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544DF606A31A
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 16:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jg2CsMWJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D217C1F000C1;
	Wed, 21 Oct 2026 16:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792600330;
	bh=hWPhn/sEKxSR6yISxRC42gyehfNe6MmeCModEqQ++2s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Jg2CsMWJbDsao1gTDOMaIgwdTes72NJtELslb5haF1OoCgac2MfLmQl8mbqy6w/2L
	 zFh3BBBaIOMQecdt5wdxTDZgFa+ZTvpVhSETsrTQg3Mr7Jcf1Kioj3luLPzyv8Voeh
	 19jc1tOk66Oxw6AvlBvAlg98pA1DsssRgEajR/VxrbPcCcoigRgLTTwP84p6l0HRn2
	 RBShWueVfQIXkQVF+q0b4BZpwhcppvW2nrLbrRdSsWW6cqfG4JGf8Cbzhl3pp2ta1+
	 dOeOZZIzVvJjkJcT97sXwpgioy9uEQidnXgQVnWMUI0izZpYHBj17H9YiePl3HAmEw
	 74acH6f5a3tnw==
Message-ID: <sashiko-outbox-180468@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf] net: return page_pool frags to the pool in
 bpf_xdp_shrink_data()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dudu Lu" <phx0fer@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261021155645.69120-1-phx0fer@gmail.com>
References: <20261021155645.69120-1-phx0fer@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 16:32:10 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] net: bpf_xdp_shrink_data() unrefs page_pool on non-recycled shared=
 frags
- [Low] bpf: multi-line comment style violation in bpf_xdp_shrink_data()
--

commit a0cb1ce1fd03b9aff34c23b2b43d38801d791b8d
Author: Dudu Lu <phx0fer@gmail.com>

net: return page_pool frags to the pool in bpf_xdp_shrink_data()

This commit updates bpf_xdp_shrink_data() in net/core/filter.c to check
whether a released fragment with MEM_TYPE_PAGE_SHARED is backed by a
page_pool and recycle it via napi_pp_put_page() before falling back to
__xdp_return(). This avoids freeing page_pool-backed fragments allocated
by skb_pp_cow_data() through page_frag_free() under generic xdp when the
rxq has no registered memory model.

> diff --git a/net/core/filter.c b/net/core/filter.c
> index b7ac145b68b1f..f17113ff29874 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c

[ ... ]

> @@ -4408,6 +4409,18 @@ static bool bpf_xdp_shrink_data(struct xdp_buff *x=
dp, skb_frag_t *frag,
>  	}
> =20
>  	if (release) {
> +		/* The frag may be page_pool-backed even when the rxq's
> +		 * xdp_rxq_info carries no mem model (generic XDP on a
> +		 * driver that never registers one, e.g. loopback).  In that
> +		 * case mem_type is MEM_TYPE_PAGE_SHARED and __xdp_return()
> +		 * would free the page through page_frag_free(), leaving the
> +		 * page_pool's accounting dangling -- "page_pool leak".  Route
> +		 * page_pool pages back through the pool instead.
> +		 */

[Severity: Low]
This isn't a bug, but in bpf subsystem files such as net/core/filter.c,
should multi-line comments in bpf_xdp_shrink_data() have the opening /* on
its own line with the comment text starting on the following line?

> +		if (IS_ENABLED(CONFIG_PAGE_POOL) &&
> +		    mem_type =3D=3D MEM_TYPE_PAGE_SHARED && napi_pp_put_page(netmem))
> +			return release;
> +
>  		__xdp_return(netmem, mem_type, false, zc_frag);

[Severity: High]
Can calling napi_pp_put_page(netmem) in bpf_xdp_shrink_data() when
mem_type =3D=3D MEM_TYPE_PAGE_SHARED corrupt reference counts if the xdp_bu=
ff
owns a page->_refcount reference rather than a pp_ref_count reference?

On a veth interface with native xdp enabled, veth_xdp_rcv_skb() calls
veth_convert_skb_to_xdp_buff() -> skb_pp_cow_data(). For any trailing
fragment with size <=3D PAGE_SIZE / 2 (such as a 4000-byte packet),
page_pool_dev_alloc() -> page_pool_alloc_netmem() calls
page_pool_alloc_frag_netmem(), which fragments the page with BIAS_MAX:

net/core/page_pool.c:page_pool_alloc_frag_netmem() {
    ...
		pool->frag_page =3D netmem;

frag_reset:
		pool->frag_users =3D 1;
		*offset =3D 0;
		pool->frag_offset =3D size;
		page_pool_fragment_netmem(netmem, BIAS_MAX);
		return netmem;
}

When bpf_prog_run_xdp() returns XDP_TX or XDP_REDIRECT, veth_xdp_rcv_skb()
transfers ownership from the skb to the xdp_buff and switches the memory
model to rq->xdp_mem (which has type MEM_TYPE_PAGE_SHARED):

drivers/net/veth.c:veth_xdp_rcv_skb() {
    ...
	case XDP_TX:
		veth_xdp_get(xdp);
		consume_skb(skb);
		xdp->rxq->mem =3D rq->xdp_mem;
		if (unlikely(veth_xdp_tx(rq, xdp, bq) < 0)) {
    ...
}

Here, veth_xdp_get(xdp) increments page->_refcount via __skb_frag_ref(),
and consume_skb(skb) releases the skb's pp_ref_count reference via
napi_pp_put_page() (decrementing pp_ref_count from BIAS_MAX to
BIAS_MAX - 1). Because rq->page_pool->frag_page (or another skb sharing
the fragmented page) still holds the remaining pp_ref_count references,
pp_ref_count does not reach 0 and netmem_is_pp(netmem) remains true.

When a downstream program in veth_xdp_rcv_one(), dev_map_bpf_prog_run(),
or cpu_map_bpf_prog_run_xdp() shrinks and releases that fragment via
bpf_xdp_adjust_tail() or bpf_xdp_pull_data(), bpf_xdp_shrink_data() sees
mem_type =3D=3D MEM_TYPE_PAGE_SHARED and netmem_is_pp(netmem) =3D=3D true. =
Calling
napi_pp_put_page(netmem) decrements pp_ref_count a second time instead of
calling __xdp_return() -> page_frag_free() to drop the page->_refcount
reference.

Wouldn't this leak page->_refcount and cause page_pool_unref_netmem() to
underflow pp_ref_count (or prematurely recycle the page while other skbs
still hold fragments of it) when rq->page_pool drains frag_page?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021155645.6912=
0-1-phx0fer@gmail.com?part=3D1
