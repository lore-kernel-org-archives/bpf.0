Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FB637A856
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 04:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784780057; cv=none; b=MN+UyRRpCpD1J571BYwu5DAUKIWN/jH0JLVnxAvUjXBbBCupxQXVvA+/Ika1bCKCGjXpjapvINhW41msjV6DtAG84ekcjZRM0mDxx6Iy0Q26OyBQroo7PY7P+bB55Dvq2o0E4SjkEDg/AFuhAwjXOWzb1vnfFbQ1QTloY3rFC0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784780057; c=relaxed/simple;
	bh=eVC6RC/rVnpzhU4gBTiNoD+DWTCVNL8IGx6T/3XLK+I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=n9Cxbl1ONcvV39KUkJ42DIaR8gFUQJa0u0VMeccm/FeFeHBH15SLSA3/2alJe/LxAj/jEHlJf1Lj4O6VGnejHbZZ7OZfFEXCUpIvSEtNWiOUWy3VvulGl1By0bGCcEMVD/NgZY7+OPnV0pAS+EhjjsM2gw9lkx/Km5pvyhasnzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0286B1F000E9;
	Thu, 23 Jul 2026 04:13:53 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2] xsk: reject undersized tx_metadata at runtime
 validation
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?Q2VuIFpoYW5nIChNaWNyb3NvZnQp?= <blbllhy@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260722041326.75199-1-blbllhy@gmail.com>
References: <20260722041326.75199-1-blbllhy@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 04:13:52 +0000
Message-Id: <20260723041354.0286B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] The patch introduces a backward compatibility regression by uncond=
itionally dropping valid packets with `tx_metadata_len < 16`.
- [High] A Time-of-Check to Time-of-Use (TOCTOU) vulnerability bypasses the=
 newly introduced metadata length validation, leaving the out-of-bounds rea=
d unfixed.

Pre-existing issues:
- [High] UAPI / ABI Incompatibility between 32-bit and 64-bit architectures=
 for `struct xsk_tx_metadata`.
- [High] Calling `skb_checksum_help()` in `xsk_build_skb_zerocopy()` trigge=
rs a kernel warning and wedges the TX queue because the SKB has no linear d=
ata.
- [High] Unaligned memory access panic when reading `meta->flags` in unalig=
ned chunk mode.
--

--- Patch [1]: [PATCH net v2] xsk: reject undersized tx_metadata at runtime=
 validation ---
commit 16c1a55389347ae87a6cce0af1dfd6639cadc298
Author: Cen Zhang (Microsoft) <blbllhy@gmail.com>

xsk: reject undersized tx_metadata at runtime validation

This commit adds a runtime check in xsk_buff_valid_tx_metadata() to
validate that tx_metadata_len is sufficient for the enabled flags. It
aims to fix an out-of-bounds read when accessing metadata fields in
xsk_skb_metadata().

Link: https://lore.kernel.org/all/20260720155210.34229-1-blbllhy@gmail.com/

> diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
> index 46797645a0c24..5c54c7462c45e 100644
> --- a/include/net/xdp_sock_drv.h
> +++ b/include/net/xdp_sock_drv.h

[ ... ]

> @@ -260,9 +260,22 @@ xsk_buff_raw_get_ctx(const struct xsk_buff_pool *poo=
l, u64 addr)
>  	0)
> =20
>  static inline bool
> -xsk_buff_valid_tx_metadata(const struct xsk_tx_metadata *meta)
> +xsk_buff_valid_tx_metadata(const struct xsk_buff_pool *pool,
> +			   const struct xsk_tx_metadata *meta)
>  {
> -	return !(meta->flags & ~XDP_TXMD_FLAGS_VALID);
> +	/* covers flags, XDP_TXMD_FLAGS_CHECKSUM & XDP_TXMD_FLAGS_TIMESTAMP */
> +	if (unlikely(pool->tx_metadata_len < 16))
> +		return false;

[Severity: High]
Does this unconditional check break backward compatibility for applications
using a length of 8 and requesting no metadata flags? If an application
didn't request features requiring more space, won't returning false here
cause xsk_skb_metadata() to return -EINVAL, permanently wedging the socket's
TX queue because __xsk_generic_xmit() aborts without releasing the
descriptor?

> +
> +	if (unlikely(meta->flags & ~XDP_TXMD_FLAGS_VALID))
> +		return false;

[Severity: High]
This isn't a bug introduced by this patch, but when the UMEM operates in
unaligned chunk mode, won't reading meta->flags directly perform an unalign=
ed
64-bit memory access? Could this cause a strict alignment fault and panic t=
he
kernel on architectures like ARM32 or SPARC? Should this be using
get_unaligned() instead?

> +
> +	if (meta->flags & XDP_TXMD_FLAGS_LAUNCH_TIME)

[Severity: High]
Is this validation safe against a Time-of-Check to Time-of-Use race? Since
meta->flags is located in shared UMEM, couldn't a malicious userspace
application set flags to 0 during this check, then immediately change it to
XDP_TXMD_FLAGS_LAUNCH_TIME before xsk_skb_metadata() reads it again? This
seems to allow bypassing the length validation and triggering the exact
out-of-bounds read this patch aims to fix.

> +		if (unlikely(pool->tx_metadata_len <
> +			     offsetofend(struct xsk_tx_metadata, request.launch_time)))
> +			return false;

[Severity: High]
This isn't a bug introduced by this patch, but doesn't struct
xsk_tx_metadata have an ABI mismatch between 32-bit and 64-bit architectures
due to a lack of explicit padding?

include/uapi/linux/if_xdp.h:
struct xsk_tx_metadata {
    __u64 flags;
    union {
        struct {
            __u16 csum_start;
            __u16 csum_offset;
            __u64 launch_time;
        } request;
    };
};

On 64-bit, launch_time requires 8-byte alignment, causing 4 bytes of padding
and making the struct 24 bytes long. On 32-bit, launch_time requires 4-byte
alignment, making the struct 20 bytes long. Won't this cause a 32-bit
application on a 64-bit kernel to suffer data corruption, and unconditional=
ly
fail UMEM registration since the length isn't a multiple of 8?

> +
> +	return true;
>  }

[ ... ]

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index b970f30ea9b9d..75b2c97e41e48 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -809,7 +809,7 @@ static int xsk_skb_metadata(struct sk_buff *skb, void=
 *buffer,
>  		return -EINVAL;
> =20
>  	meta =3D buffer - pool->tx_metadata_len;
> -	if (unlikely(!xsk_buff_valid_tx_metadata(meta)))
> +	if (unlikely(!xsk_buff_valid_tx_metadata(pool, meta)))
>  		return -EINVAL;
> =20
>  	if (meta->flags & XDP_TXMD_FLAGS_CHECKSUM) {

[Severity: High]
This is a pre-existing issue, but when xsk_skb_metadata() is called from
xsk_build_skb_zerocopy(), doesn't it invoke skb_checksum_help() on an SKB
with no linear data (skb_headlen is 0)?

net/xdp/xsk.c:xsk_skb_metadata() {
    ...
    if (unlikely(pool->tx_sw_csum)) {
        int err;
        err =3D skb_checksum_help(skb);
        if (err)
            return err;
    }
}

Would this cause the check inside skb_checksum_help() for
offset >=3D skb_headlen(skb) to evaluate to true, triggering a warning and
returning -EINVAL, which then wedges the TX queue?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722041326.7519=
9-1-blbllhy@gmail.com?part=3D1
