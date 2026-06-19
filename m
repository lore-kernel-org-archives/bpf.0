Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C7754652
	for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 20:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781900087; cv=none; b=q5iONCfBmmp9UEqrbZbSvF0sFQKOP/wA3jW/3zDpyWdxBJOyQLz5JBptGNKwGKpC5biBB5xBm9NPYIjmeSZ6SItwo76r5+0R5DH5iw9JIME0/BdwEikMG3pmtsjnCV6/mPtLK9VO3V83tWFjfp4GawqlUp6oVGV3ecYnzkzy6xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781900087; c=relaxed/simple;
	bh=oP3+ufLY+I8xwo6/masF9bxzbdP4GAHCEYnWdLrmBgU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hJ/NZdWLxEcNDgOMKFKVt/hMvO4XTNhfMMxPkZRr5vTndWz1xKnqhw/KSbNg1DPWmW8ypmFbYXyv7OhH8gkSpyvjwizMHhrAtE+fUzbTNMQZDWB1BtE+ppIMMzbuwDqgUFztRiTNs1W85Q1kmqskiWMKGIbVrLoTGo1ZOaG17Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iz678+8y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iz678+8y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F4A81F000E9;
	Fri, 19 Jun 2026 20:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781900085;
	bh=6ngx8pQOpC/XSXzvcYqhflLIv/7TZc7VubQG8AtzoGE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iz678+8yKzAXVC78HokSMto1PX7kmUn5PGgxCClu4irTvGASbJgmkij9EqdVl70In
	 sQo1xeZwW2SohzKzz7Us7Gug4lLqbmHO9yDwP9ee5dp3G3tnL4Em4DQXqV2i34xvEo
	 6aOcCe0NKtBLx1+7pmUbkntB3SNvsODDBUEkMbug8P5qE3PyWz2XCar247YQOfYvcP
	 v50C/gdtDZ5GK3vJIOQPzE1GDjY1aUdtIkG6+8Q+bQegw/Le1/jUGd+dmK/iwoHl6b
	 AIoqMGgcdvTbhbyL+EGWT1whqHhybvNDYKAtU3a2YkheRNy0H8QCI8JJgnU68Gqo/Z
	 HLPk7Z3UcftCw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] bpf: preserve rx_queue_index across XDP redirects
Reply-To: sashiko-reviews@lists.linux.dev
To: Siddharth_Cibi <siddharthcibi@icloud.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260619195759.41254-2-siddharthcibi@icloud.com>
References: <20260619195759.41254-1-siddharthcibi@icloud.com>
 <20260619195759.41254-2-siddharthcibi@icloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 20:14:45 +0000
Message-Id: <20260619201445.6F4A81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Uninitialized `rx_queue_index` leak in the BPF `test_run` framewor=
k exposes kernel memory to BPF programs.

Pre-existing issues:
- [Critical] Incomplete metadata copy when manually duplicating `xdp_frame`=
 in the DPAA driver causes uninitialized flags usage.
- [Critical] Converting a zero-copy XDP buffer with metadata into an `xdp_f=
rame` causes an out-of-bounds write when an SKB is later built from it.
--

commit bc57980ef3c6d7e89349b8a948f430b656d7ecab
Author: Siddharth C <siddharthcibi@icloud.com>

bpf: preserve rx_queue_index across XDP redirects

Store rx_queue_index in struct xdp_frame during xdp_buff to xdp_frame
conversion and restore it when rebuilding xdp_rxq_info for cpumap and
devmap execution paths. This preserves ingress RX queue information for
XDP programs executed after redirect.

> diff --git a/include/net/xdp.h b/include/net/xdp.h
> index aa742f413c358..90318b2b76dcb 100644
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h
> @@ -301,6 +301,7 @@ struct xdp_frame {
>  	 */
>  	enum xdp_mem_type mem_type:32;
>  	struct net_device *dev_rx; /* used by cpumap */
> +	u32 rx_queue_index;

[Severity: High]
Does adding rx_queue_index here introduce a kernel memory leak in the BPF
test_run framework?

Looking at net/bpf/test_run.c, both xdp_test_run_init_page() and reset_ctx()
manually construct an xdp_frame using xdp_update_frame_from_buff().

Because xdp_update_frame_from_buff() does not copy rx_queue_index, and the
test_run code does not explicitly initialize it, frm->rx_queue_index appears
to retain uninitialized kernel memory from the page pool allocation.

If a test BPF program returns XDP_REDIRECT to a cpumap or devmap, will this
uninitialized rx_queue_index be exposed to the secondary BPF program via the
ctx->rx_queue_index context field, leaking 4 bytes of kernel memory per pac=
ket?

[Severity: Critical]
This is a pre-existing issue, but could manually duplicating the xdp_frame
cause uninitialized flags usage in the DPAA driver?

In drivers/net/ethernet/freescale/dpaa/dpaa_eth.c, dpaa_a050385_wa_xdpf()
manually duplicates an xdp_frame into a newly allocated buffer using
dev_alloc_pages(0).

It appears to leave several fields uninitialized, particularly flags. Since
the allocated page is not zeroed, new_xdpf->flags contains uninitialized
memory.

When xdp_return_frame() is later called on this frame, it checks for
XDP_FLAGS_HAS_FRAGS. If the uninitialized memory happens to have this flag
set, won't xdp_return_frame() read a bogus skb_shared_info from the end of
the page and attempt to free random memory addresses as fragments?

>  	u32 frame_sz;
>  	u32 flags; /* supported values defined in xdp_buff_flags */
>  };

[ ... ]

> diff --git a/net/core/xdp.c b/net/core/xdp.c
> index 9890a30584ba7..9691d8dfadf3c 100644
> --- a/net/core/xdp.c
> +++ b/net/core/xdp.c
> @@ -606,6 +606,7 @@ struct xdp_frame *xdp_convert_zc_to_xdp_frame(struct =
xdp_buff *xdp)
>  	xdpf->metasize =3D metasize;
>  	xdpf->frame_sz =3D PAGE_SIZE;
>  	xdpf->mem_type =3D MEM_TYPE_PAGE_ORDER0;
> +	xdpf->rx_queue_index =3D xdp->rxq->queue_index;

[Severity: Critical]
This isn't a bug introduced by this patch, but will setting headroom to 0
instead of metasize here cause an out-of-bounds write later?

Looking at xdp_convert_zc_to_xdp_frame(), it sets xdpf->headroom =3D 0 and
calculates the data offset using metasize.

Later, when __xdp_build_skb_from_frame() processes this frame, it calculate=
s:

hard_start =3D xdpf->data - (sizeof(*xdpf) + xdpf->headroom)

which evaluates to page_virt + metasize. It then calls
build_skb_around(skb, hard_start, PAGE_SIZE).

This places the skb_shared_info structure at hard_start + PAGE_SIZE (minus
alignment). Because hard_start is offset by metasize, wouldn't the end of t=
he
skb_shared_info overlap into the adjacent physical page by metasize bytes,
corrupting memory when the kernel zero-initializes this out-of-bounds area?

> =20
>  	xsk_buff_free(xdp);
>  	return xdpf;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619195759.4125=
4-1-siddharthcibi@icloud.com?part=3D1
