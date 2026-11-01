Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793563050;
	b=YMRkjKgtdDn6Hl5BQumqVDMs2oMzZwS4Mixf3Fj+b+BMHAnSgBXxgSBplR+VvXi8PrBZ
	 C62k0R8r36yRomr2JkG84GPbIaxk82OuYLLgwCa+G5+H74bTRnDmLGRYBpuewWqjgT3Bu
	 oaVZsrIbyNCJSexfaxOLXEOXSWtXi0vMXLjJDfS09fAFSERIdURGDgi4RXhGydRkWq6/p
	 tVJEgfArAowa3m0OmJ63W4bNKYJDXl1tr2y3YQR2490uKqcH4UeHRoRMG7Z3pI0zH1Mn1
	 FBEMv/TuC9Nr+/pnqCiNuIak0vH0X3MOcWqygQXR5+zlO58xtJkFGQ34oVyZpHWNn9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793563050;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yJU0ZfUbFfL3NrMI1HZemQjeG1PrpLxJjKkcTMc8nn0=;
	b=dNZ4SqSCJkLreRjmqHUzxb67NFRBGXhP+YrDCxG0VhvE3Y51ivLnlojUgKQw9wpyHfL0
	 LMDfHRQaWEY6A9zZz20UoZSCOw/xgjFex1x1pVZtihY3viU3uyG6NCPApx61GOCbdO/zw
	 DpgFXHq357tFURI52GtNEpU/MXxhDf5N32SKpBFp6IYhUld8YQ04oEHDVXjY9oabB2Pna
	 dMR9gIaFpshaX3ukLFrsb2zJcx16uA+1P/mAfdMPCmRgc4k8SjX2BsetGezwgF+vlRgyY
	 uaSA+9LHEbpw35fLJUpEQQpBnErkeWjWeiPMN3tHw3HzTjg3NY+TWB0J0WHd0Vxz2YQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HgWXNkAE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30287606A324
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 19:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HgWXNkAE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 970BF1F000C1;
	Sun,  1 Nov 2026 19:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793563049;
	bh=yJU0ZfUbFfL3NrMI1HZemQjeG1PrpLxJjKkcTMc8nn0=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=HgWXNkAEsWaA5c13de1036bGPl35ZsNxb0PKeMl0S2nOHllvd+CKUlm7hZ4ubPdfc
	 JjKrsY/88Ea2W9OI0lgtWjzOVaoy68aDmMHpUAfANo+pml62OAHVBcXbhMr15vWACx
	 7fwVcy9OXdVgG1E8TkYcreoWRBi76v5G7iAJv7xlWTMhTrJ59Ki1HC4M7trOWFm3JS
	 MPffk87kRDkmimdADBnySPu5Fx4eC5j6pb6huoXCmqSjQUc5kI7CKD1RCJoXp6E+3P
	 8Oak51+PL3vNLZq745leyDucOeoty/y8DNjiEx9N71DRBNKcUD32C8On32ou2bsD6C
	 occEM1r6lRqKw==
Message-ID: <sashiko-outbox-192641@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 26/27] bpf: Use the inner transport header after a
 decap
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261101190535.1454146-27-alexei.starovoitov@gmail.com>
References: <20261101190535.1454146-1-alexei.starovoitov@gmail.com>
 <20261101190535.1454146-27-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 19:57:29 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: mishandled unset ~0U transport header in bpf_skb_clear_encap()
--

commit 907dfd6423a9766152f03a831bcc864117a68b99
Author: Chris Mason <mason@kernel.org>

bpf: Use the inner transport header after a decap

This commit adds bpf_skb_clear_encap() to update skb->transport_header from
skb->inner_transport_header when decapsulation in bpf_skb_net_shrink() clea=
rs
skb->encapsulation.

> diff --git a/net/core/filter.c b/net/core/filter.c
> index b5534dac9e6dc..21fcdc7cd950d 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -3769,6 +3769,25 @@ static int bpf_skb_net_grow(struct sk_buff *skb, u=
32 off, u32 len_diff,
>  	return 0;
>  }
> =20
> +/*
> + * Code that went by the inner transport header while skb->encapsulation=
 was set
> + * goes by the transport header from now on. So take the inner one over,=
 unless
> + * it is the smaller one, as it is if nobody has set it. Do not leave th=
e result
> + * in front of @off, where the bytes were removed.
> + */
> +static void bpf_skb_clear_encap(struct sk_buff *skb, u32 off)
> +{
> +	int thoff;
> +
> +	if (!skb->encapsulation)
> +		return;
> +
> +	thoff =3D max(skb->inner_transport_header, skb->transport_header) -
> +		skb_headroom(skb);
> +	skb_set_transport_header(skb, max_t(int, thoff, off));
> +	skb->encapsulation =3D 0;
> +}

[Severity: High]
Can max(skb->inner_transport_header, skb->transport_header) in
bpf_skb_clear_encap() in net/core/filter.c select the unset sentinel (~0U)
instead of a valid transport header offset?

In include/linux/skbuff.h, an unset transport header is represented by
(__u16)~0U (0xffff):

include/linux/skbuff.h:skb_transport_header_was_set() {
	return skb->transport_header !=3D (typeof(skb->transport_header))~0U;
}

Because 0xffff is the largest possible __u16 value rather than the smallest,
taking max(skb->inner_transport_header, skb->transport_header) will pick
0xffff whenever either field holds the unset sentinel:

1. If skb->transport_header is unset (0xffff) while
   skb->inner_transport_header holds a valid offset (for example, after
   gro_cells_receive() calls skb_unset_transport_header(), or after
   encapsulating via bpf_skb_net_grow() with BPF_F_ADJ_ROOM_ENCAP_L3_IPV4/I=
PV6
   without L4 flags), max() chooses 0xffff and overwrites
   skb->transport_header with 0xffff instead of copying
   skb->inner_transport_header.

2. If an skb starts with skb->transport_header unset (0xffff) and is
   encapsulated with BPF_F_ADJ_ROOM_ENCAP_L4_GRE or
   BPF_F_ADJ_ROOM_ENCAP_L4_UDP, bpf_skb_net_grow() copies 0xffff into
   skb->inner_transport_header while setting skb->transport_header to the
   outer L4 header:

net/core/filter.c:bpf_skb_net_grow() {
	if (encap) {
		...
		inner_trans =3D skb->transport_header;
	}
	...
	if (encap) {
		...
		skb->inner_transport_header =3D inner_trans;
		...
		if (flags & BPF_F_ADJ_ROOM_ENCAP_L4_GRE ||
		    flags & BPF_F_ADJ_ROOM_ENCAP_L4_UDP) {
			...
			skb_set_transport_header(skb, mac_len + nh_len);
		}
}

   When that packet is later decapsulated in bpf_skb_net_shrink(),
   bpf_skb_net_hdr_pop() clamps the outer skb->transport_header to off, whi=
le
   skb_inner_transport_offset(skb) is 0xffff - skb_headroom(skb) >=3D (int)=
off
   so skb->inner_transport_header stays 0xffff:

net/core/filter.c:bpf_skb_net_hdr_pop() {
		} else if (skb_transport_header_was_set(skb) &&
			   skb_transport_offset(skb) < (int)off) {
			/* It was in the removed bytes or before skb->data. */
			skb_set_transport_header(skb, off);
		}
		/* Do not leave the inner transport header in front of @off. */
		if (skb->encapsulation &&
		    skb_inner_transport_offset(skb) < (int)off)
			skb_set_inner_transport_header(skb, off);
}

   Then bpf_skb_clear_encap() evaluates max(0xffff, skb->transport_header) =
and
   sets skb->transport_header back to 0xffff.

For a GSO packet where bpf_skb_net_shrink() sets SKB_GSO_DODGY, resets
gso_segs =3D 0, and clears skb->encapsulation, leaving skb->transport_heade=
r at
0xffff causes qdisc_pkt_len_segs_init() to skip GSO segment calculation and
causes skb_gso_validate_mac_len() -> skb_gso_transport_seglen() ->
tcp_hdrlen() -> skb_transport_header() to trigger
DEBUG_NET_WARN_ON_ONCE(!skb_transport_header_was_set(skb)) and read from
skb->head + 0xffff.

Should bpf_skb_clear_encap() check whether the transport headers are set
(or ignore values equal to (__u16)~0U) before comparing them?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261101190535.1454=
146-1-alexei.starovoitov@gmail.com?part=3D26
