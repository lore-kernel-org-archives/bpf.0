Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67CA3C3BF5
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 06:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779086048; cv=none; b=RusMN7LDP3byzebY1wSZxpia6SrX/6D7zzrAU4ST0Yd7tA7x8YP4/L1Jelb6o1jJIHnNq8491ey3z2dRaCzby7Xo43LiUCbZFb/CdOf+ygTBTHEm52hLhG45NnKa7E9Ei09qruUPM2sXc8wzEzNf1oAWu0WEm1v6yjmQdmYCRCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779086048; c=relaxed/simple;
	bh=Yg7Y8hue5KhBCHm3n+qVbiC+BHd4OyOXs6M6EvNrNso=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LmW3hJvEAT0DfwBsHDf4GXrbUyrNaZU5Nq5IdH4YJZHyRejqJy86Jm1poa+8cGT7w8fUIzOl9qnryDmrQGgsdxZ17sMVnYqwlmlP1bDef+8nkJeC6HrH/GesZZLnUjMGI2rpsVb4wnBKbDjRz8Ft3RVm8OrfHP1iKqJFnu8MeEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tl4VMoJR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tl4VMoJR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F995C2BCC6;
	Mon, 18 May 2026 06:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779086048;
	bh=Yg7Y8hue5KhBCHm3n+qVbiC+BHd4OyOXs6M6EvNrNso=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Tl4VMoJRjrMI8S3GsjNDnVA6I6tOhChTPLgMtLm0x4R/+OeK9tzAnjgUcVLB3ctfL
	 suDqPZQfTyTkabzEpxMI+iRh5MRIfxDNV+7O8Fbk6bexxO5nmNMkyhZ/KiqnHX4KeV
	 l9vcVoBsoZ84nNGi7XjqspuHg07oheLzeaDhXKlqZfn8sLXKUazd2p+JNriuurOJSa
	 Glxzg+377a+7udscPSGSP8BJX49Q+HpDx1AljI2pYSJ1FpZ3RZCh8ojIZmBjgqgUIu
	 OjM3VIjhzXilwTIxmQTNiuBfZ1IPkfghvEe35TS1FrgqJ6MEdS0fMYqY8MKMSq1XRO
	 2YJKn0UxLeAyg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 3/5] xsk: drain continuation descs after overflow
 in xsk_build_skb()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jason Xing" <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260517063311.28921-4-kerneljasonxing@gmail.com>
References: <20260517063311.28921-4-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 06:34:08 +0000
Message-Id: <20260518063408.5F995C2BCC6@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The commit message claims the function returns `-EOVERFLOW` afte=
r draining is complete, but the code merely uses `continue;`.
--

commit 5c0ce4e27ce234e8586a243e61aed44e90c34548
Author: Jason Xing <kerneljasonxing@gmail.com>

xsk: drain continuation descs after overflow in xsk_build_skb()

This patch adds a drain_cont flag to xdp_sock to properly drain leftover
continuation descriptors when a multi-buffer packet exceeds MAX_SKB_FRAGS.
The main TX loop handles these leftover descriptors individually by returni=
ng
them to the completion queue with standard backpressure mechanisms.

Closes: https://lore.kernel.org/all/20260425041726.85FB3C2BCB2@smtp.kernel.=
org/

> When the last fragment
> (without XDP_PKT_CONTD) is processed, the flag is cleared and the
> function returns -EOVERFLOW so the next call starts with a fresh
> budget for normal packets.

Is this description accurate?

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 0a6203c425766..298194b7335e1 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c

[ ... ]

> @@ -1062,6 +1064,23 @@ static int __xsk_generic_xmit(struct sock *sk)
>  			goto out;
>  		}
> =20
> +		if (unlikely(xs->drain_cont)) {
> +			unsigned long flags;
> +			u32 idx;
> +
> +			spin_lock_irqsave(&xs->pool->cq_prod_lock, flags);
> +			idx =3D xskq_get_prod(xs->pool->cq);
> +			xskq_prod_write_addr(xs->pool->cq, idx, desc.addr);
> +			xskq_prod_submit_n(xs->pool->cq, 1);
> +			spin_unlock_irqrestore(&xs->pool->cq_prod_lock, flags);
> +
> +			xs->tx->invalid_descs++;
> +			xskq_cons_release(xs->tx);
> +			if (!xp_mb_desc(&desc))
> +				xs->drain_cont =3D false;
> +			continue;

Looking at the implementation here, the code clears the flag and executes
a continue statement, which proceeds to the next descriptor using the
remaining budget instead of returning -EOVERFLOW.

Could the code and the commit message be out of sync?

> +		}
> +
>  		skb =3D xsk_build_skb(xs, &desc);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260517063311.2892=
1-1-kerneljasonxing@gmail.com?part=3D3
