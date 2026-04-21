Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AAD3AD52A
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 09:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776764426; cv=none; b=a2ysAcrFHkGTqv2Md2kxVRLcwmAEiAnveawg74A7S7qEHLTFHTsE+X48xK/zgtAvabPsi5b9ox6OcOxk7P4G/fF31XIybH7busk59TvkZA/tZimmlMFe4OzsrauAjSMlclo92XAfd/R48Zkw5ENeAq5naQlpPeS/QpJwZ8nUy+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776764426; c=relaxed/simple;
	bh=dwvLsC/RqPyj8Kjsn2TsP/WuVuhtmJSk4iFtqlsM8HM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Rs66K0CzNu++1jL3ZpD2Rw7Xcnt01vEFB4S84xcOqE6dNKJqLsgupJYEOCJw5gXgvywxUsXi+57eiNjCiYpP49vXg6+0Zr0vJiJL/xGt81P13UY4aSPeu8WldO+kkXQTKdO0/iFCcqLWf5dI2F7dtsmL+YBgnQKEp2sMF+Jl5aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nX8B8deE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nX8B8deE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6543DC2BCB0;
	Tue, 21 Apr 2026 09:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776764426;
	bh=dwvLsC/RqPyj8Kjsn2TsP/WuVuhtmJSk4iFtqlsM8HM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=nX8B8deEHSrIiZysQg+qj2t82P9uKNt3U7jLpl5RaWVEyMxIKM303rrYRPJQ0bF3U
	 jH/eO43UGIp6H08fWwzoKYozbGf5Qp4hf30XEDVjmeq4FDOxriRtD2wDnw2oeSfc5H
	 D4KshHhozTvXOXE21T56g+t1fF62r4DNaoCNn8ei56NjqeopQYjsbquP26UPSjBvid
	 WJW5klIotxhYOf7Sc6OZz0YFqD0uOiVf7haLJExyiH6vbr5fFIjHzfXQJFzbtu1eWY
	 IVWHcH31yumBq7kQMbsB7mw3/Sh/O8e5FJR4RVm2ukdp8kjL7QpXymZp0EgPztDckL
	 qpaqd2T7fjIUw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2 8/8] xsk: fix u64 descriptor address truncation
 on 32-bit architectures
Reply-To: sashiko@lists.linux.dev
To: "Jason Xing" <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260420082805.14844-9-kerneljasonxing@gmail.com>
References: <20260420082805.14844-9-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Apr 2026 09:40:25 +0000
Message-Id: <20260421094026.6543DC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [High] On 32-bit systems, xsk_drop_untrans_skb() will call kmem_cache_fre=
e() on an uninitialized destructor_arg pointer in early allocation failure =
paths, causing slab corruption.
--

commit cf643670755512ad76d19d6d0707e86a2a05c671
Author: Jason Xing <kerneljasonxing@gmail.com>

xsk: fix u64 descriptor address truncation on 32-bit architectures

This commit fixes a truncation issue of the 64-bit descriptor address
on 32-bit architectures by allocating an xsk_addrs struct to store the
full address instead of packing it into the destructor_arg pointer.
It also updates the related cleanup and initialization functions to
handle the newly allocated struct.

Link: https://lore.kernel.org/all/20260419045824.D9E5EC2BCAF@smtp.kernel.or=
g/

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 9c06a4e868725..0232559d5348f 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
[ ... ]
> @@ -799,6 +825,12 @@ static int xsk_skb_metadata(struct sk_buff *skb, voi=
d *buffer,
> =20
>  static void xsk_drop_untrans_skb(struct sk_buff *skb)
>  {
> +	if (!IS_ENABLED(CONFIG_64BIT) && !xsk_skb_destructor_is_addr(skb)) {
> +		struct xsk_addrs *xsk_addr;
> +
> +		xsk_addr =3D (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
> +		kmem_cache_free(xsk_tx_generic_cache, xsk_addr);
> +	}

Could this pass an uninitialized pointer to kmem_cache_free() and cause slab
corruption?

When a new socket buffer is allocated via sock_alloc_send_skb(), the
networking core's __alloc_skb() function only zeroes the skb_shared_info
struct up to the dataref field. The destructor_arg field resides after
dataref and contains uninitialized garbage from the slab.

If an error occurs before destructor_arg is explicitly initialized, such as
when xsk_skb_init_misc() returns -ENOMEM:

xsk_build_skb_zerocopy()
    ...
    skb =3D sock_alloc_send_skb(&xs->sk, hr, 1, &err);
    ...
    err =3D xsk_skb_init_misc(skb, xs, desc->addr);
    if (unlikely(err)) {
        xsk_drop_untrans_skb(skb);
        return ERR_PTR(err);
    }

In xsk_drop_untrans_skb() on 32-bit systems, xsk_skb_destructor_is_addr(skb)
evaluates to !skb_shinfo(skb)->destructor_arg. Because destructor_arg
contains non-zero garbage, the function returns false. The check in
xsk_drop_untrans_skb() (!xsk_skb_destructor_is_addr(skb)) then succeeds,
passing the garbage pointer to kmem_cache_free().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260420082805.1484=
4-1-kerneljasonxing@gmail.com?part=3D8
