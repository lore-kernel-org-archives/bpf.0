Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB7A388E48
	for <bpf@vger.kernel.org>; Sun,  3 May 2026 20:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777838968; cv=none; b=ZYndRgeU5+o7dfmJqhaF4sg35WJpimdwyip/YbAf8L4Dmug6vEuXfGwJLoz7vJKGLx1+1+Q7exWBjcEBMtkcZgH02gUqehMtlZPpD/flGTsiChggOW32vh6xMpX43d1BWR4NPIIyVVXj39cimWKl/K4RPRfxMV6Wov8pe5ItUYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777838968; c=relaxed/simple;
	bh=xzDO3JufJyi+v51kZd3rEtZC19HP5/9N1G6wBmZJIo8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Pm94kTSHqBKTHTJmqTIZ+WxhXi1iTQw7JfDjktp79p4hOnSq4xWwZ0kpvfd0o/FfR/cvWp/IuxlmpHvmgc8MhtxC+8iaZ57Rtr4jj3T1fyqMnqLlvnYdte8y6VxXgCp1mnWUFLBiFvD6v02umvkaO1J/9/3aezUmKCc5xhOGs/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DurBzqMt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DurBzqMt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5988DC2BCB4;
	Sun,  3 May 2026 20:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777838968;
	bh=xzDO3JufJyi+v51kZd3rEtZC19HP5/9N1G6wBmZJIo8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=DurBzqMtEjEEEsAjAqu5yjNbfCzIhvmzHgyRBKbAGuDxNCBlDMB+ieIo8nwW21oFp
	 NalBkOSlyzWbsoY9lq7CXqgBQJGvfg90bjQ3wtqOyddkbsSu7OIU1wlC3ICDNX0Oab
	 0UIgTOMq8bMMFrkcmcpdn4WFle5zt2WiHZSkcILzPY6EfPc+sgRIWODA2wHGUVy3I0
	 f1LdvyiGL2Ngo0YAOI3ZO+Om5YpH9rDeNDSVQH0AkTRkeeG7H28qhm6Wl1v/mtcIec
	 f2P5y4wze4g5tq0pR3YbFk1H0JLCyolW+e1vmx1cltiWsJohznwks7mh1oXBGUABXB
	 ZXuayjrneGUVQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v5 8/8] xsk: fix u64 descriptor address truncation
 on 32-bit architectures
Reply-To: sashiko@lists.linux.dev
To: "Jason Xing" <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260502200722.53960-9-kerneljasonxing@gmail.com>
References: <20260502200722.53960-9-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 03 May 2026 20:09:27 +0000
Message-Id: <20260503200928.5988DC2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] In the copy-mode TX path (`xsk_build_skb`), if a multi-buffer frag=
ment exceeds the `MAX_SKB_FRAGS` limit, the buffer's address is leaked to u=
serspace because `0` is erroneously submitted to the completion queue.
--

commit 4a776aefc60aa4d3123e7e63fd8f927f3748d008
Author: Jason Xing <kerneljasonxing@gmail.com>

xsk: fix u64 descriptor address truncation on 32-bit architectures

This commit fixes a 32-bit truncation issue when storing 64-bit descriptor
addresses in the SKB destructor argument by allocating an xsk_addrs struct.
It consolidates the allocation logic into xsk_addrs_alloc() and uses it in
both zerocopy and copy modes.

Link: https://lore.kernel.org/all/20260419045824.D9E5EC2BCAF@smtp.kernel.or=
g/

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 079abd4bcb69..5e5786cd9af5 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c

[ ... ]

> @@ -929,19 +959,10 @@ static struct sk_buff *xsk_build_skb(struct xdp_soc=
k *xs,
>  			struct page *page;
>  			u8 *vaddr;
> =20
> -			if (xsk_skb_destructor_is_addr(skb)) {
> -				xsk_addr =3D kmem_cache_zalloc(xsk_tx_generic_cache,
> -							     GFP_KERNEL);
> -				if (!xsk_addr) {
> -					err =3D -ENOMEM;
> -					goto free_err;
> -				}
> -
> -				xsk_addr->num_descs =3D 1;
> -				xsk_addr->addrs[0] =3D xsk_skb_destructor_get_addr(skb);
> -				skb_shinfo(skb)->destructor_arg =3D (void *)xsk_addr;
> -			} else {
> -				xsk_addr =3D (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
> +			xsk_addr =3D xsk_addrs_alloc(skb);
> +			if (!xsk_addr) {
> +				err =3D -ENOMEM;
> +				goto free_err;
>  			}
> =20
>  			if (unlikely(nr_frags =3D=3D (MAX_SKB_FRAGS - 1) && xp_mb_desc(desc))=
) {

This isn't a regression introduced by this patch, but while looking at the
modified code, does this error handling path leak the buffer's address to
userspace?

If this overflow check evaluates to true, the code sets err =3D -EOVERFLOW =
and
jumps to the free_err label before assigning desc->addr to
xsk_addr->addrs[xsk_addr->num_descs].

In the free_err block, it handles -EOVERFLOW by calling
xsk_inc_num_desc(xs->skb) and xsk_drop_skb(xs->skb). This increments
num_descs to account for the dropped descriptor and eventually calls
xsk_destruct_skb() which calls xsk_cq_submit_addr_locked().

Since xsk_addr->addrs was never initialized with desc->addr for this
descriptor, does this mean it submits 0 (from kmem_cache_zalloc) to the
completion queue instead of the actual buffer address, causing userspace
to permanently lose track of the buffer?

By comparison, xsk_build_skb_zerocopy() assigns desc->addr to the array
before checking the fragment limit:

net/xdp/xsk.c:xsk_build_skb_zerocopy() {
    ...
		xsk_addr =3D xsk_addrs_alloc(skb);
		if (!xsk_addr)
			return ERR_PTR(-ENOMEM);

		/* in case of -EOVERFLOW that could happen below,
		 * xsk_consume_skb() will release this node as whole skb
		 * would be dropped, which implies freeing all list elements
		 */
		xsk_addr->addrs[xsk_addr->num_descs] =3D desc->addr;
	}

	len =3D desc->len;
    ...
}

Should xsk_build_skb() also record the descriptor address before checking
the -EOVERFLOW condition?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260502200722.5396=
0-1-kerneljasonxing@gmail.com?part=3D8
