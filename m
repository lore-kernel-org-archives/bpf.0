Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5883563E8
	for <bpf@vger.kernel.org>; Sat,  1 Aug 2026 03:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785554679; cv=none; b=UBnptq7CJAHU71SvwAGQXFswIaYVX5NOoO3VnLPyCdjzoji2DBk83ouclIU5GErb1u+6FVx/DZBkOQucxKgUe+4XMP3Csa6hKhZit2crgBc7MRJ2GUx89JODV403gO5+IPC2bwt6hOeYHw905DBosjaHJYNOjDc2rwfrp5bnZKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785554679; c=relaxed/simple;
	bh=quKA/arjkC+YsUd0mfAxxL+OS4HriQJ7jQh/UZPljKw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NFtwMihbfd3SYcDoqfZ4V5abzwNJsapwk68BQrk3jeRCwflRnroal20sCH9fA+0TlgLk6mo2xcqtm2+yMfV3LBIOIDYAzREiwmBxns0XdQ46bfK4z++WrD3yTll6VkodHwcVy/OcAtiqpc4/fNY2I7x7MtACGkLEK/YcrriensE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QjnDXn0j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QjnDXn0j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D40A21F00AC4;
	Sat,  1 Aug 2026 03:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785554678;
	bh=gdIHm+swwzs/kN8dsKuRo47r3LtDmfZuQDmxj9r/z0A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QjnDXn0jTocRDd1TV6+C8iV6I2nBcdkt20yrnEN9S+NfDe/UCy7eGmTyhekglG8fZ
	 BCAyEmpoAlSKRUxmUdlV3NSnP3qcZFGWP4BktKlzPBYWRmFa/GFYDUrrd2m6iUsKOK
	 7wUACuGO54KoAuPNh+LJdVV+F4fuNNn/9snBlvM7pXjk4PRld2pTdhki+/44qXMduP
	 GyxlybXtDRlu0sG8BU5BMGCuk3+45SkAv8YzJP9YozM02Ydo6fHxYgiPBM/ClNn3zQ
	 G6kTtxt0W4QeLZ2CdMmcknGtMYHJUZmLMyLZ/61Ohnd0uKHjGFrexWb9Knxmu4PTM9
	 A8sedMhg2M01g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2 1/2] net: fix skb length accounting after generic
 XDP frag adjustment
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sun Jian" <sun.jian.kdev@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260731032357.6114-2-sun.jian.kdev@gmail.com>
References: <20260731032357.6114-1-sun.jian.kdev@gmail.com>
 <20260731032357.6114-2-sun.jian.kdev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 03:24:37 +0000
Message-Id: <20260801032437.D40A21F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The exact same metadata desynchronization bug that causes OOB =
reads in generic XDP also exists in drivers/net/veth.c, including an additi=
onal kernel panic vulnerability via BUG_ON.
- [Critical] bpf_xdp_frags_shrink_tail() incorrectly frees system_page_pool=
 pages using page_frag_free() for Generic XDP.
- [High] Preexisting BUG_ON() panic in generic XDP when the head is pulled =
by more than the original linear length.
--

--- Patch [1]: [PATCH net v2 1/2] net: fix skb length accounting after gene=
ric XDP frag adjustment ---
commit 98b02c083e22c12a3a47fab8bce5b83fb6fad2b7
Author: Sun Jian <sun.jian.kdev@gmail.com>

net: fix skb length accounting after generic XDP frag adjustment

This commit fixes an out-of-bounds read caused by generic XDP fragment
adjustment. It subtracts the old data_len from skb->len before updating
it to the new fragment size, keeping the lengths synchronized.

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
> -	 * (e.g. bpf_xdp_adjust_tail), we need to update data_len here.
> +	 * (e.g. bpf_xdp_adjust_tail). Remove the old fragment contribution
> +	 * from skb->len before updating data_len, then add the new one back.
>  	 */
> -	if (xdp_buff_has_frags(xdp))
> +	skb->len -=3D skb->data_len;

[Severity: High]
This is a pre-existing issue, but does bpf_prog_run_generic_xdp() still
panic if the head is pulled by more than the original linear length?

If an XDP program shrinks a packet's fragments to 0, it can subsequently
grow the linear part and pull the head pointer (via bpf_xdp_adjust_head)
by an amount greater than the original linear length.

In bpf_prog_run_generic_xdp(), the head adjustment is processed before
the tail and data_len updates:

        if (off > 0)
                __skb_pull(skb, off);

Since __skb_pull() asserts that skb->len >=3D skb->data_len and skb->data_l=
en
still holds its original value, wouldn't skb->len -=3D off fall below
skb->data_len and trigger a kernel panic?

[Severity: Critical]
This is a pre-existing issue, but does veth_xdp_rcv_skb() in
drivers/net/veth.c have the exact same metadata desynchronization bug?

If a fragmented packet is processed by a tail-adjusting XDP program in
veth_xdp_rcv_skb(), skb->len is unmodified while skb->data_len changes:

        /* check if bpf_xdp_adjust_tail was used */
        off =3D xdp->data_end - orig_data_end;
        if (off !=3D 0)
                __skb_put(skb, off); /* positive on grow, negative on shrin=
k */

If the packet is shrunk enough to remove all fragments and reduce the linear
part, wouldn't calling __skb_put(skb, off) with a negative offset trigger a
BUG_ON since skb->data_len is still non-zero at this point?

[Severity: Critical]
This is a pre-existing issue, but does bpf_xdp_shrink_data() incorrectly
free system_page_pool pages using page_frag_free() for Generic XDP?

When generic XDP processes a non-linear SKB, fragments are allocated from
system_page_pool. However, xdp_buff is initialized using the driver's
rxqueue->xdp_rxq (often MEM_TYPE_PAGE_SHARED).

If an XDP program shrinks the packet tail, bpf_xdp_shrink_data() drops
fragments and extracts the driver's mem_type:

        enum xdp_mem_type mem_type =3D xdp->rxq->mem.type;
        ...
        if (release) {
                __xdp_return(netmem, mem_type, false, zc_frag);
        }

Because the memory type relies on the driver's default, wouldn't
__xdp_return() incorrectly use page_frag_free() instead of returning the
page to the page_pool?

        case MEM_TYPE_PAGE_SHARED:
                page_frag_free(__netmem_address(netmem));
                break;

Could this bypass the page_pool recycling logic and free a page_pool page
directly to the buddy allocator, triggering a bad_page() BUG?

> +	if (xdp_buff_has_frags(xdp)) {
>  		skb->data_len =3D skb_shinfo(skb)->xdp_frags_size;
> -	else
> +		skb->len +=3D skb->data_len;
> +	} else {
>  		skb->data_len =3D 0;
> +	}
> =20
>  	/* check if XDP changed eth hdr such SKB needs update */
>  	eth =3D (struct ethhdr *)xdp->data;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731032357.6114=
-1-sun.jian.kdev@gmail.com?part=3D1
