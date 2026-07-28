Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90306332909
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 03:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785209172; cv=none; b=PYwHuMqOXST2Pn21ConNyfxwi/jlTpF4yKw3rnA9nyT29dETNU6b7mmWT+nmRYBqDUFuVHLwNhZpGppq/aKIeSNlMFlwTa4v70SzMUs5bpN7FZFtvye2CmAW1Xn8bhS2HO76/vTt7DwH/PR2aONxLuQhnnACdNP70k4PGKwYq7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785209172; c=relaxed/simple;
	bh=Pcy7hOdsGxUF11LYIa2U2OFjgwhaL6P/vxJL7+kWf70=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WtbDYa5XAXxSLRR4gmb5LaNQXZKm4ZuUe90OAZjUvUe0WpXHvXyXCx8m1Fr9O4E0I5t/q/kjvBIDuAUIc8Np7n6p8WsLphHBHcw1TOwTEE5Re/pygYNErkk1tWzsgEvTp7ZLfNU36/EQFMJ4ivPZgmiR16LrPhPTdwfYbRAnQ8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JgTUc1gB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JgTUc1gB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F6FD1F00A3A;
	Tue, 28 Jul 2026 03:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785209171;
	bh=axHCnDMfs3EHzLtbX1sOyLgs3nClI8tLUw5TVLqKyhw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JgTUc1gBrBipVRGsm0wPhhqZbb+lhAEAq4MhFU1mHpGEVCOvPmOvh8r/zkL+UPgvr
	 LpN+eKmdCdkeO8n1hUf5xgKRyeMQ3sC9TIi3B1rRpQkJ8/YJBVjLyn4jbbKc6OphQV
	 ZcHDon5MnNtns6+ll9R+bm49vDWaMXZPjXW61R5EoIKkRfrYvKaNfo08bD2bBpdmJl
	 erE+qp/QWM/xx9x4JiTgOkrsKm3Wlnhr+x1BK+4d42MH4C9QM+K6G5SSOYRugTGOTF
	 SORBiFir0/hULt7Rt9n9pEJRJUMlPCa6JpRqVU2/AQdUkxrFfTcejA9ob6O8541tYd
	 CJ6eq7FEmVunQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 1/2] net: fix skb length accounting after generic
 XDP frag adjustment
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sun Jian" <sun.jian.kdev@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260727032535.13469-2-sun.jian.kdev@gmail.com>
References: <20260727032535.13469-1-sun.jian.kdev@gmail.com>
 <20260727032535.13469-2-sun.jian.kdev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 03:26:10 +0000
Message-Id: <20260728032611.3F6FD1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] A generic XDP program can trigger a kernel panic via BUG_ON() in _=
_skb_pull() by dropping all fragments and then manipulating head and tail l=
engths.
--

--- Patch [1]: [PATCH net 1/2] net: fix skb length accounting after generic=
 XDP frag adjustment ---
commit 553adb7b7f41a20f63d7c32e81ef98469247c00c
Author: Sun Jian <sun.jian.kdev@gmail.com>

net: fix skb length accounting after generic XDP frag adjustment

This commit fixes skb length accounting after generic XDP fragment
adjustments by keeping skb->len and skb->data_len synchronized. It
subtracts the old data_len before replacing it and adds the new
data_len afterwards.

Link: https://lore.kernel.org/r/20260720141859.19FF41F000E9@smtp.kernel.org
Link: https://lore.kernel.org/bpf/al9T9Eto%2FhRIzP5W@boxer/

> diff --git a/net/core/dev.c b/net/core/dev.c
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
[ ... ]
> @@ -5497,12 +5517,14 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb,=
 struct xdp_buff *xdp,
> =20
>  	/* check if bpf_xdp_adjust_head was used */
>  	off =3D xdp->data - orig_data;
>  	if (off) {
>  		if (off > 0)
>  			__skb_pull(skb, off);

[Severity: High]
This is a pre-existing issue, but can this sequence trigger a kernel panic
via BUG_ON() in __skb_pull()?

If an XDP program drops all fragments via bpf_xdp_adjust_tail() with a
negative offset, grows the linear tailroom, and shrinks the linear head by
consuming the newly added space, it seems __skb_pull() is called while
skb->data_len still holds the original large fragment size.

Since the fragment adjustments to skb->data_len are synchronized further do=
wn
in this function, could skb->len drop below skb->data_len during this pull
and trigger the BUG() inside __skb_pull()?

>  		else if (off < 0)
>  			__skb_push(skb, -off);
> =20
>  		skb->mac_header +=3D off;
>  		skb_reset_network_header(skb);
>  	}
[ ... ]
>  	/* XDP frag metadata (e.g. nr_frags) are updated in eBPF helpers
> -	 * (e.g. bpf_xdp_adjust_tail), we need to update data_len here.
> +	 * (e.g. bpf_xdp_adjust_tail), update skb length fields here.
>  	 */
> +	skb->len -=3D skb->data_len;
>  	if (xdp_buff_has_frags(xdp))
>  		skb->data_len =3D skb_shinfo(skb)->xdp_frags_size;
>  	else
>  		skb->data_len =3D 0;
> +	skb->len +=3D skb->data_len;
> =20
>  	/* check if XDP changed eth hdr such SKB needs update */
>  	eth =3D (struct ethhdr *)xdp->data;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727032535.1346=
9-1-sun.jian.kdev@gmail.com?part=3D1
