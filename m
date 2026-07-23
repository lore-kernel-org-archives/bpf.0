Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB2D3D75B1
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 19:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784834382; cv=none; b=gZJoCK+5CH0AtZmCvcYC2PIWrQ45rzL7PAyChhpXzhvXvGhTEb1rPwaaYRjbCbHFjqumWGW5YvHfcR4NkKyT++FYSchtS3kr9bMuhF5LNZ0lB1zINZHLhPyFSRaKV2nsSARCPoPXUhmQP9ewOn93y/HHXtKWlsKlxAiG3gFv3+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784834382; c=relaxed/simple;
	bh=e8147N0L1fp07qTiTUApBB9Ru4iw7eRxHzWmAdIJbIs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=F2ahljnthScjQarCnGwAquF5nYZBbYcWlZzJib2bfWZ0EQKu8iBY37c9wOLycHz9lJrVuiscn6wAupHaZpcLajS04GVLQPn28Us/LROX7eD6zeQIwOIDPOW1sZM//kzLvj/PUvkcg/gX5AgSzLeBgOAnHM8isnl80dWPRbiJvVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dv01M06a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dv01M06a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31CC91F00A3A;
	Thu, 23 Jul 2026 19:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784834379;
	bh=oSsi1FNjK5e0vdAJ7L+SxxfRahtPIpsEtW8KugBOH/k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Dv01M06a5lt7L60ErYovkQONLg4k0QR0gN3sV2rEFk31ONSlvP9BRyKW8fy+IOIse
	 lk2lkNf/2UdNK2QYpvNN+Y20OStzsG6O0pdePjVqSFlfexxE0IQuBsjYev1MAoYNjn
	 svnwFJkp6TpKcAkOw8UVDBcuNGwHFlIL9C+0slfSJfcpWn1yYWA2K1BTJVd8tijIrB
	 18zEqfGm34mkDist/1NO4Wc05rZ+Uy97rEbzgx2IBkEgYm4vjDlZJUc1RLMn02VLsL
	 FPMKoWL+hmsrFM/UeaUeE8g2FGcVya6khwUTiPYhjoVAjv6hTUZNWrHde27Cexh2R/
	 /btbOEvjRFPvQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3] veth: convert frag_list skbs before running XDP
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Fleming" <matt@readmodwrite.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260722191925.2192070-1-matt@readmodwrite.com>
References: <20260722191925.2192070-1-matt@readmodwrite.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 19:19:38 +0000
Message-Id: <20260723191939.31CC91F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] `skb_pp_cow_data` fails to account for `skb_shared_info` overh=
ead in `truesize`, leading to memory corruption and `skb_over_panic`.
--

--- Patch [1]: [PATCH net v3] veth: convert frag_list skbs before running X=
DP ---
commit 2a77993dec578b7da44e393d4e9fecc7e0e8c05c
Author: Matt Fleming <mfleming@cloudflare.com>

veth: convert frag_list skbs before running XDP

This commit fixes an AF_XDP copy mode crash by routing nonlinear skbs throu=
gh
skb_pp_cow_data() before exposing them to XDP, preventing empty frags[] from
being exposed.

> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index 1c51421491753..00e34afd858e7 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -756,7 +756,7 @@ static int veth_convert_skb_to_xdp_buff(struct veth_r=
q *rq,
>  	u32 frame_sz;
> =20
>  	if (skb_shared(skb) || skb_head_is_locked(skb) ||
> -	    skb_shinfo(skb)->nr_frags ||
> +	    skb_is_nonlinear(skb) ||
>  	    skb_headroom(skb) < XDP_PACKET_HEADROOM) {
>  		if (skb_pp_cow_data(rq->page_pool, pskb, XDP_PACKET_HEADROOM))
>  			goto drop;

[Severity: Critical]
This isn't a bug introduced by this patch, but does changing this condition
route more traffic into a memory corruption issue inside skb_pp_cow_data()?

Looking at skb_pp_cow_data() in net/core/skbuff.c, it computes the allocati=
on
size without accounting for the skb_shared_info structural overhead:

        truesize =3D SKB_HEAD_ALIGN(size) + headroom;
        data =3D page_pool_dev_alloc_va(pool, &truesize);

When page_pool_dev_alloc_va() allocates from a page fragment (which happens
when the requested size is <=3D PAGE_SIZE / 2), it returns a buffer of exac=
tly
the requested size.=20

The subsequent call to napi_build_skb() unconditionally subtracts the
skb_shared_info overhead from this size, setting skb->end below the required
bounds. This causes the payload copy in skb_copy_bits() to overwrite the
shared info, and later skb_put() calls will crash with an skb_over_panic.

Since standard 1500-byte MTU packets satisfy this fragment threshold
(1792 <=3D 2048), will routing all nonlinear SKBs into this path allow remo=
te
input to reliably trigger a kernel panic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722191925.2192=
070-1-matt@readmodwrite.com?part=3D1
