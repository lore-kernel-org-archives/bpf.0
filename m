Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D783B5314
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 13:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782308020; cv=none; b=uHSf6IBEkVRw+n/TP4lDrU+FiBWIzrR1BBvdyEtPjNkMc1R/BcL+SA6/fc/jtzv7eKlZCcVI9pLUcoXlJ6wJMommYGfQWzk/BpLDeWF12VlVcG9Pyylt6U+5py0T03DKusEBd0KxcQ+ALBxuu5OQVc/M2vM80Bueszxttj1BYxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782308020; c=relaxed/simple;
	bh=q9xfmbkBXm4euQGEcp9sfDc38iIf1leHyp2Z5UEA0u0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FJT/f/eFYJo/cEiut0a5/6kpoeHEiJbit9k+PwtsPLWOUpcIDp5JZVV1O0zO6J+UvjN5BYUAdEuPOazzkBT5OMmrzB3M7dHefJEta3bZbGwbHGgYXVVWjkbMMqluuSNxN0FHGNW3c7xX8hVVO1Xms1EESIk8n7bgtVrQjgr9yLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LkrxW0SP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LkrxW0SP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5CDE1F000E9;
	Wed, 24 Jun 2026 13:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782308019;
	bh=DYgXZpr8FyfyETqGXK/Ebt4rOjwRw6sW0hTN1YfLhOU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LkrxW0SP/UZhbL1Q2kp2PUvC6oIv6DUKEq+e8pnyZwaIRm7dDq4ZuftrakukGdgEV
	 ll0lWgcctAn1x9wHqNxYyTJwIYoYtHfuv2u6hlrJ6GgNOZj4CxERez/IoQrqewXqIO
	 tWMfsd3gJF04oHSNxVAKpfHID0T+TFd62kjb1+yst+A+C6Xy7Yofx0ePB8g/rFG17P
	 rdtxb2SKB0pxOglOwDRTcUSvPtNghhEJGls7QhLcOT5JJeUmR+NwhLMqNYSBeNXvRF
	 3VyyBmpQOVny33fgslb1nqtwo6Nyd9+JtTDZZ8z9944z5h4PDvqVNP6AktLpEXKfi6
	 Phb51ki/25liA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 2/7] xsk: drain continuation descs after overflow in
 xsk_build_skb()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maciej Fijalkowski" <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260623133240.1048434-3-maciej.fijalkowski@intel.com>
References: <20260623133240.1048434-1-maciej.fijalkowski@intel.com>
 <20260623133240.1048434-3-maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 13:33:38 +0000
Message-Id: <20260624133338.E5CDE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The post-loop logic in `__xsk_generic_xmit()` leaves the invalid=
 descriptor in the TX ring if the Completion Queue (CQ) is full, leading to=
 unbounded double-counting of the `invalid_descs` statistic.
--

commit c4ba06aa2b6f82804cdabd955a9ab94cfe185d39
Author: Jason Xing <kerneljasonxing@gmail.com>

xsk: drain continuation descs after overflow in xsk_build_skb()

This patch adds a drain_cont flag to xdp_sock to handle multi-buffer packets
that exceed the maximum allowed fragments. It ensures the remaining
descriptors of a dropped packet are drained instead of being misinterpreted
as the start of new packets.

Closes: https://lore.kernel.org/all/20260425041726.85FB3C2BCB2@smtp.kernel.=
org/

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c

[ ... ]

> @@ -1063,11 +1076,22 @@ static int __xsk_generic_xmit(struct sock *sk)
>  			goto out;
>  		}
> =20
> +		if (unlikely(xs->drain_cont)) {
> +			xsk_cq_submit_addr_single_locked(xs->pool, &desc);
> +
> +			xs->tx->invalid_descs++;
> +			xskq_cons_release(xs->tx);
> +			xs->drain_cont =3D xp_mb_desc(&desc);
> +			continue;
> +		}
> +
>  		skb =3D xsk_build_skb(xs, &desc);
>  		if (IS_ERR(skb)) {
>  			err =3D PTR_ERR(skb);
>  			if (err !=3D -EOVERFLOW)
>  				goto out;
> +			if (xp_mb_desc(&desc))
> +				xs->drain_cont =3D true;
>  			err =3D 0;
>  			continue;
>  		}

[Severity: Medium]
When an invalid descriptor belonging to a multi-buffer packet is encountere=
d,
xskq_cons_peek_desc() increments invalid_descs and terminates the while loo=
p.

After the loop exits, if xsk_cq_reserve_locked() fails because the completi=
on
queue is full, __xsk_generic_xmit() goes to out without calling
xskq_cons_release(). Does this leave the invalid descriptor in the TX ring?

On subsequent retries, xskq_cons_peek_desc() will evaluate the exact same
descriptor again, which increments invalid_descs repeatedly.

There were prior concerns raised about this code path, but some of those
appear to be incorrect:

It was suggested this causes a livelock, but returning -EAGAIN correctly
yields back to user-space without infinite busy-looping inside the kernel.

It was also suggested this exposes garbage addresses. However, returning the
invalid descriptor's address to the completion queue is an intentional
design choice to prevent user-space buffer leaks, as established in prior
commits.

Finally, there was a concern about corrupting drain_cont. Using
xp_mb_desc() on an invalid descriptor is intentional to maintain
multi-buffer framing. If a descriptor is invalid but has the continuation
flag set, subsequent valid descriptors belong to the same dropped packet
and must be drained.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623133240.1048=
434-1-maciej.fijalkowski@intel.com?part=3D2
