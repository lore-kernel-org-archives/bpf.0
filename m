Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1DF23F40D
	for <bpf@vger.kernel.org>; Sat, 20 Jun 2026 17:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781975392; cv=none; b=B3p4TcR8MDUGMnqDa1te3y4FEXcKKllR+3gI5x5ya3A0OO7h9Aopog0TAx+q6xPOQ9lz7DMP906FOszF/tNqm6ReeAE1OMP0PoSbITDZ/C5pJLnfko5am3Q1Rf40/YMA8dgsN54l7WJheQEPTLRS3WSWaqwnoRvvw1R3qR+2Wsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781975392; c=relaxed/simple;
	bh=BBn7OHkv/IKYlgkS15QnjR3kls1gQvDaYsilgJzJPtc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OxriLw/2vK9Gn9wyz4aocS/hCfmQ2ZfiJKWf+doXR3IQa3vNrOKkMNFGEyoceE+pjBsRlWp+/VxeAEUEkKr3MFq97NcTxnFW29fUxaCsiUJZ5Y0IH5twJsSobFqYLNpvQLPtcP9PxrjINAuRsbK2Wk+10ekrW4y2yYwzd+O/khU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMZ4boCY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMZ4boCY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 580641F00A3A;
	Sat, 20 Jun 2026 17:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781975391;
	bh=aarSy7IStmt/45OG6ekvdE/cMlh+Hi8THLTpnP7W8L0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kMZ4boCYkU4v7vWn7ERLimAuIXX5SAOWFltQ3lGFxyNQknIVOAQ8l0IBCYBZwb0/0
	 sH1UBWCgK9SMR7HFwX2Ea1WukpYNTSA4VXZUYbD101h0h1n1thuH/u7ADmvqZjx9GI
	 iJw0dmqFaKPteB+EtsegaP28u9PWrf+WzbPhtjP2O3B1xsJmCjF76PUH5N4jzroBhf
	 P8Xvf+4p8KA0R7prWjmpRtM9kEvWz1RPzDzSvyJn0PSpVAgRzOhHU2mbyxE1fcYVrg
	 dsFpPDfM8JTJwNnEk377eEHNsTGKuoI5HsGIDKniws+gWQrnHtCUhbDv3unA1bzth2
	 uYE1QzSrhvaOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 1/2] net: lwtunnel: Drop skb metadata before LWT
 encapsulation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jakub Sitnicki" <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260619-bpf-lwt-drop-skb-metadata-v3-1-71d6a33ab76b@cloudflare.com>
References: <20260619-bpf-lwt-drop-skb-metadata-v3-0-71d6a33ab76b@cloudflare.com>
 <20260619-bpf-lwt-drop-skb-metadata-v3-1-71d6a33ab76b@cloudflare.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 Jun 2026 17:09:50 +0000
Message-Id: <20260620170951.580641F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Calling `skb_metadata_clear(skb)` on a potentially cloned SKB modi=
fies the shared `skb_shinfo` structure without exclusive access, leading to=
 a data race and silent data corruption for other clones.
--

commit a6915ae09d5ba82236d77c5574df958bccb552d5
Author: Jakub Sitnicki <jakub@cloudflare.com>

net: lwtunnel: Drop skb metadata before LWT encapsulation

This commit clears skb metadata before lwt encapsulation across all dispatch
helpers. It prevents non-bpf lwt encapsulations from overwriting metadata in
the headroom and stops bpf lwt xmit from triggering warnings due to metadata
position during skb_data_move().

> diff --git a/net/core/lwtunnel.c b/net/core/lwtunnel.c
> index f9d76d85d04fd..b01a395d9a966 100644
> --- a/net/core/lwtunnel.c
> +++ b/net/core/lwtunnel.c
> @@ -350,6 +350,8 @@ int lwtunnel_output(struct net *net, struct sock *sk,=
 struct sk_buff *skb)
>  	rcu_read_lock();
>  	ops =3D rcu_dereference(lwtun_encaps[lwtstate->type]);
>  	if (likely(ops && ops->output)) {
> +		/* Encap pushes outer headers over the metadata; drop it. */
> +		skb_metadata_clear(skb);

[Severity: High]
Does calling skb_metadata_clear() here modify the shared skb_shinfo
structure without ensuring exclusive access?

Since skb_metadata_clear() modifies skb_shinfo(skb)->meta_len, if the
buffer is cloned (for instance, via tc mirred or multicast forwarding),
this might cause a data race and corrupt the metadata for other clones still
processing the packet.

Should we unshare the skb first to safely modify the shared info?

>  		dev_xmit_recursion_inc();
>  		ret =3D ops->output(net, sk, skb);
>  		dev_xmit_recursion_dec();

[ ... ]

> @@ -404,6 +406,8 @@ int lwtunnel_xmit(struct sk_buff *skb)
>  	rcu_read_lock();
>  	ops =3D rcu_dereference(lwtun_encaps[lwtstate->type]);
>  	if (likely(ops && ops->xmit)) {
> +		/* Encap pushes outer headers over the metadata; drop it. */
> +		skb_metadata_clear(skb);

[Severity: High]
Could this similarly corrupt shared metadata if the buffer is cloned?

>  		dev_xmit_recursion_inc();
>  		ret =3D ops->xmit(skb);
>  		dev_xmit_recursion_dec();

[ ... ]

> @@ -455,6 +459,8 @@ int lwtunnel_input(struct sk_buff *skb)
>  	rcu_read_lock();
>  	ops =3D rcu_dereference(lwtun_encaps[lwtstate->type]);
>  	if (likely(ops && ops->input)) {
> +		/* Encap pushes outer headers over the metadata; drop it. */
> +		skb_metadata_clear(skb);

[Severity: High]
Could this also lead to a data race by modifying skb_shinfo on a potentially
shared buffer before handing it to ops->input()?

>  		dev_xmit_recursion_inc();
>  		ret =3D ops->input(skb);
>  		dev_xmit_recursion_dec();

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619-bpf-lwt-dr=
op-skb-metadata-v3-0-71d6a33ab76b@cloudflare.com?part=3D1
