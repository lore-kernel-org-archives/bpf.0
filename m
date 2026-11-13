Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794587809;
	b=zqfbKxFBoyde0QQOMoROWK4IHOh/hqdcLQS4petycKET3zq5Anq8/ord/eYnmByxlyxI
	 PKLMxHNkRt6n3jc6XuR0ICpKvdQESBTnP27TOMT6YFS3ptxiQ/ztGdid//Kkxk7iaa6U8
	 fNkil+Zj2XQiW6J/36oE4YJ9xNEPk4l2++hOWNlhSmttqxGi2cg55akGopklkQk9fFELT
	 ISTvQLnt1PfotBuGUWJ3+UObdzWQGFPShgXzVUrKGzUEpGhunEoSQQ2nvJA4a4RRetbpd
	 KUx/qOIFLRZBePsc+LfaoQ3cln0p19BDH5g8liGxdjNkOqQp6LJEvsU5pu06IVM66GA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794587809;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UyJE0mbTTEEewCt1bY7p9pW9FJzBUBKBqTbg7Tka4X4=;
	b=knM0gpnDC2IWjgsGRDCKPcxATt3TIEZygMJwmqcJzVisJx6HSffD4F+QL1iASRd11LLJ
	 TkNOP8k1jfaCd8gPpYheTVhzQDQNdgCEeyFNR3RJMYOli3MEmb25W2QQ/FIBwvc2nbvRJ
	 elIdPDkIzjVlhJhwAHOmBjCuhpNLhPbyxqYeKad1Ie8mwFcqJjYU4r9GeQJ77mcdFpORE
	 7IPGfMYcPdx83wrCRcObO7FYvztjMdui0lnXj3jTMaJUwShWwQmxz06oBfGMfYTuAARLH
	 EWRuOuIoI9nkcggLJbJcfF/m+Gi4AlZxpAiTCx6j28sLlQW2YrwaYEX3fvT5LtpSikw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i3GGemaR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CBD606A323
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 16:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i3GGemaR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FAEF1F000C4;
	Fri, 13 Nov 2026 16:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794587809;
	bh=UyJE0mbTTEEewCt1bY7p9pW9FJzBUBKBqTbg7Tka4X4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i3GGemaRR+XeInhi3X/AdOcK/SjaoujEQ0VCaH1jBwz1Rtz9fZds3X1HcHgFL5qSP
	 3E2HHE2vnsdKdyOWmFuzLLs0RTwE9zGLgFpQ+qk5CtHdAx3tQfokw9iyyqgmRneRjc
	 a2RUerhCd9v+al9wOmBqHkZYeQ2Z3yhixfaWrIQC67HEZbfK4LsYsliw+ICCLXf3sS
	 irdrFI3JN3ZOowtOI7K1btiRFiqrP8oNlSTMLcbtB73b1QfjLgMOEOXivLaLoSf008
	 ZN0wKuU8t8srPs9FLQoWLafF8v8X5e/120swL/ze+U3IMI2ITBJP2XvTo9NIXqFrqg
	 UlijS6IZHjGEg==
Message-ID: <sashiko-outbox-213209@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v10 2/4] net: xdp: add xdp_buff_shrink_tail()
 helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lorenzo Bianconi" <lorenzo.bianconi@oss.qualcomm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261112-stmmac-rx-mb-v10-2-d3d04b65c6bc@oss.qualcomm.com>
References: <20261112-stmmac-rx-mb-v10-0-d3d04b65c6bc@oss.qualcomm.com>
 <20261112-stmmac-rx-mb-v10-2-d3d04b65c6bc@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 16:36:48 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] net: xdp: bounds check split in bpf_xdp_adjust_tail() allows
  pointer wrap
--

commit fe8a696967ad3281fe5305e0444a8948ebb0b12e
Author: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

net: xdp: add xdp_buff_shrink_tail() helper

This commit moves the XDP tail-shrinking helpers from net/core/filter.c to
net/core/xdp.c and exports xdp_buff_shrink_tail() for driver use.

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 9b8d5191c4ba2..5ea45dfce7a22 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -4438,96 +4438,21 @@ static int bpf_xdp_frags_increase_tail(struct xdp=
_buff *xdp, int offset)

[ ... ]

>  BPF_CALL_2(bpf_xdp_adjust_tail, struct xdp_buff *, xdp, int, offset)
>  {
>  	void *data_hard_end =3D xdp_data_hard_end(xdp); /* use xdp->frame_sz */
>  	void *data_end =3D xdp->data_end + offset;
> =20
> -	if (unlikely(xdp_buff_has_frags(xdp))) { /* non-linear xdp buff */
> -		if (offset < 0)
> -			return bpf_xdp_frags_shrink_tail(xdp, -offset);
> +	if (offset < 0)
> +		return xdp_buff_shrink_tail(xdp, -offset);
> =20
> +	if (unlikely(xdp_buff_has_frags(xdp))) /* non-linear xdp buff */
>  		return bpf_xdp_frags_increase_tail(xdp, offset);
> -	}
> =20
>  	/* Notice that xdp_data_hard_end have reserved some tailroom */
>  	if (unlikely(data_end > data_hard_end))
>  		return -EINVAL;
> =20
> -	if (unlikely(data_end < xdp->data + ETH_HLEN))
> -		return -EINVAL;
> -
>  	/* Clear memory area on grow, can contain uninit kernel memory */
>  	if (offset > 0)
>  		memset(xdp->data_end, 0, offset);

[ ... ]

> diff --git a/net/core/xdp.c b/net/core/xdp.c
> index 470bf90d93ef2..7c98dbc2a770c 100644
> --- a/net/core/xdp.c
> +++ b/net/core/xdp.c
> @@ -672,6 +672,97 @@ struct sk_buff *__xdp_build_skb_from_buff(const stru=
ct xdp_buff *xdp)

[ ... ]

> +int xdp_buff_shrink_tail(struct xdp_buff *xdp, int offset)
> +{
> +	void *data_end =3D xdp->data_end - offset;
> +
> +	if (unlikely(offset < 0))
> +		return -EINVAL;
> +
> +	if (unlikely(xdp_buff_has_frags(xdp))) /* non-linear xdp buff */
> +		return xdp_frags_shrink_tail(xdp, offset);
> +
> +	if (unlikely(data_end < xdp->data + ETH_HLEN))
> +		return -EINVAL;
> +
> +	xdp->data_end =3D data_end;
> +
> +	return 0;
> +}

[Severity: High]
Can splitting the upper and lower bounds checks between bpf_xdp_adjust_tail=
()
and xdp_buff_shrink_tail() allow pointer wraparound on linear buffers?

Previously, bpf_xdp_adjust_tail() checked both data_end > data_hard_end and
data_end < xdp->data + ETH_HLEN on xdp->data_end + offset, which prevented
pointer arithmetic overflow or underflow from passing validation.

With the checks split:

1. In bpf_xdp_adjust_tail(), offset >=3D 0 now only checks
   data_end > data_hard_end. On 32-bit architectures, a large positive offs=
et
   (e.g. 0x40000000) wraps xdp->data_end + offset past 0 to an address below
   data_hard_end, bypassing the check and passing offset to
   memset(xdp->data_end, 0, offset) for an out-of-bounds kernel memory writ=
e.
   It also allows frames initially shorter than ETH_HLEN (such as L3 packets
   on tun devices in generic XDP) to remain shorter than ETH_HLEN when
   offset >=3D 0.

2. In xdp_buff_shrink_tail(), linear buffers only check
   data_end < xdp->data + ETH_HLEN on xdp->data_end - offset. When
   (uintptr_t)xdp->data_end < 0x80000000 (for example on s390x where
   PAGE_OFFSET is 0, or 32-bit kernels with VMSPLIT_1G / VMSPLIT_2G_OPT), a
   positive offset larger than xdp->data_end underflows data_end to a high
   address above xdp->data + ETH_HLEN, setting xdp->data_end past
   data_hard_end and exposing out-of-bounds memory to BPF packet accesses.

Checking offset against the integer buffer bounds (such as
offset > (int)(xdp->data_end - xdp->data) - ETH_HLEN in
xdp_buff_shrink_tail(), and keeping the ETH_HLEN and tailroom checks in
bpf_xdp_adjust_tail() overflow-safe) would avoid both wraparounds.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-stmmac-rx-=
mb-v10-0-d3d04b65c6bc@oss.qualcomm.com?part=3D2
