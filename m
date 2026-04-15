Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276BA286D5C
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 09:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776244664; cv=none; b=VapnuZG3GyPdYWOwF0VS2660cu3VgLZAlC2fhg5KHZ53E3zhMHa3TwqaOHbR29jU7f3wpDTX/XcNRRciNbdqwHSprLwo8AYj4d14dRzgbt3zV3PDprXOy6gHZcCafKw/4rtjv3Ah1h3u0Sp3hQp+2Cj2TiMotqalFJiLF0WnIzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776244664; c=relaxed/simple;
	bh=UYB1yMTICNPKnGsnv0bQNS/IT0Vj3wz3hluein3K5/A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Lr3/t+vm6EBDY1s68BfSBlWIRIiubu5omkb+b69tXewDIWPz/V75cNYWxFPskoFTS6GwzEs4AIfcBbOgc3jlmiR4YrtD7mHR93nvTwMbd6df/NMn5CyA3g+mBwcUNYmWCM8uaS4EQhPcrdS/xNC7l9/qDvVuZW6d3FTRq3JDVas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J5R7KM+H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5R7KM+H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97FA1C19424;
	Wed, 15 Apr 2026 09:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776244663;
	bh=UYB1yMTICNPKnGsnv0bQNS/IT0Vj3wz3hluein3K5/A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=J5R7KM+HuoNuUiJOXF5j/T11YxNKuz0So9LNYX1/9Pl2OhgqNvLefEDUbK8qJU2O2
	 P6v7BbHhslNV7z0thUpOAe6GRYxYfQX0k+cF2WL6e7bh7pHPtXXzreoxHeArrcQjyW
	 iLfKhsEM4B+BqsAQW7llgbs0G+jmJruNVh0LDPk02Jh4lZbYGIJ/WaQ4vzItEhD2vg
	 zJGfybBizWzJG2GcqUB57QwyOkgscaBG+Pbs5yOBXz61aqWjeYw+tJ+ODoqyAc7L0C
	 bLcijI9Zmvop0o0EnSjyJuHkyd5hZqN7pMQXzHpmr+Mo9DEBddNs29YAaXI3hi3Kp4
	 hqWtjJjpva8Gg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC net-next v4 03/14] xsk: add xsk_alloc_batch_skb() to
 build skbs in batch
Reply-To: sashiko@lists.linux.dev
To: "Jason Xing" <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260415082654.21026-4-kerneljasonxing@gmail.com>
References: <20260415082654.21026-4-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Apr 2026 09:17:43 +0000
Message-Id: <20260415091743.97FA1C19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] Pre-allocated SKB and socket memory charge (`sk_wmem_alloc`) are p=
ermanently leaked when zerocopy metadata processing fails.
- [High] Double-free and Use-After-Free of `xs->skb` when fragment allocati=
on fails with `-EAGAIN` in copy mode.
--

commit 3ef2c03b6204759327ab337fe34617d9dd8e04ef
Author: Jason Xing <kernelxing@tencent.com>

xsk: add xsk_alloc_batch_skb() to build skbs in batch

This commit introduces xsk_alloc_batch_skb() to support allocating and
building skbs in batch. It reserves skbs, batches the sk_wmem_alloc charge,
and then copies data to complete initialization.

> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c

[ ... ]

> +	/* Phase 3: Build SKBs with packet data */
> +	for (j =3D 0; j < alloc_descs; j++) {
> +		if (!xs->skb) {
> +			skb =3D skbs[skb_count - 1 - k];
> +			k++;
> +		}
> +
> +		skb =3D xsk_build_skb(xs, skb, &descs[j]);
> +		if (IS_ERR(skb)) {
> +			*err =3D PTR_ERR(skb);
> +			break;
> +		}

Can this lead to a double-free and use-after-free of xs->skb if a fragment
allocation fails?

If xsk_build_skb() fails to allocate a page for a subsequent fragment in co=
py
mode, it frees the partially built skb and returns -EAGAIN. However, it
leaves xs->skb pointing to this freed memory.

When this loop breaks and returns -EAGAIN up the call chain, the caller
__xsk_generic_xmit_batch() checks xs->skb and calls xsk_drop_skb(xs->skb),
which would double-free the skb. Furthermore, any subsequent transmissions
could dereference the dangling pointer. Should xs->skb be explicitly cleared
when handling this error?

> +
> +		if (xp_mb_desc(&descs[j])) {
> +			xs->skb =3D skb;
> +			continue;
> +		}
> +
> +		xs->skb =3D NULL;
> +		__skb_queue_tail(&batch->send_queue, skb);
> +	}
> +
> +	/* Phase 4: Reclaim unused allocated SKBs */
> +	while (k < i)
> +		kfree_skb(skbs[skb_count - 1 - k++]);

Does this permanently leak the pre-allocated skb and its socket memory char=
ge
if xsk_build_skb() fails?

When xsk_build_skb() encounters an error like a zerocopy metadata processing
failure, it returns an ERR_PTR() without freeing the skb. Because k was
already incremented before the xsk_build_skb() call, the Phase 4 loop starts
reclaiming at the next skb.

The failed skb at index k - 1 is bypassed. Since it is never freed,
sock_wfree is skipped, leaking both the skb and the batched sk_wmem_alloc
charge.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260415082654.2102=
6-1-kerneljasonxing@gmail.com?part=3D3
