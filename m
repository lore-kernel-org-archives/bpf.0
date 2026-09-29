Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581A33D1A9A
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 22:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790721423; cv=none; b=am8GUnKQNdam5LRVJE7HvSiCb3Isf7Sn/kiqeUSY5uGuw7OiureS5cy+Ni/YryXuQPFsPxwXzHHak02DY6FUhwEjFvGZoE3rIwglPHpDSfEyBP/jGgIIdbVB26V9vG8xwp1FIHUy34jwx+WXc8L0kfRal1JVcChMrNcr4Vz47zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790721423; c=relaxed/simple;
	bh=kvCZjGahBEapG0Q2WIHo9mZMXuzUKFhRXSrgJeLl67s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uzXmsF3kcWg/kfQ3pwIQRtCrSwYlMSezP3bJTzLWqySQit1g2P5Nqs4PclYutgJg1N7Gzk4qPl4IXenzgyQxf4/OwCjlruPR0Tn3RpCp7q1WJTqCrMztwOsTjdAHA0Lwptw4JN5/yoLXTPa5q5yKdx0Dg/kT8B99+h5MR8sGcTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJdS55zZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJdS55zZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C54751F00898;
	Tue, 29 Sep 2026 22:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790721422;
	bh=fKydjraTDIvGXBmkHgY0ExVyEiaSEcWB4sup2wqB2JI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BJdS55zZq8Ey7YmcIqYcBkJCYx4L6Hxf3UknsirMIAkqz4mnu+h0KjUohH4a7GgrD
	 SFxfMbICBNyWZlvd2SBetArdUBnnHik8/PDab+fobIR8f2sga7YEQFMZdk8INtJdZ/
	 5KjlmDXwCcVw/pYb4kNE2REFoLJc7jEFxfhlL1+zJh15ae6il5+aF98PeUa5Wfrkht
	 1ERM+1FqaD2CvHw/9k0uxrgmqbDX9vmQZ4L9tGNTUoklhMlFNBwjBdpqma6zAGJ/VA
	 oBqperASV2+fJQ1bMVvHwRO9VD/9Hnw7NmuF0p63a3+/3ETgOCBQAxhN3o0ruKA99T
	 NR/EjAdm5Lgeg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 5/5] net: drop GSO skbs instead of handing them
 to XDP
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260928223648.2739371-6-kuba@kernel.org>
References: <20260928223648.2739371-1-kuba@kernel.org>
 <20260928223648.2739371-6-kuba@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 22:37:01 +0000
Message-Id: <20260929223701.C54751F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] net: late GSO check in generic XDP causes DoS via skb_linearize()
- [Medium] veth: explicitly dropped GSO packets bypass kfree_skb tracepoints
--

commit 9f35b405d194efb7bc146b2c667a7b894d4c2f17
Author: Jakub Kicinski <kuba@kernel.org>
Subject: net: drop GSO skbs instead of handing them to XDP

This commit explicitly drops GSO packets on input to XDP since XDP lacks
helpers to fix up GSO state after modifications. It adds a check to generic
XDP and veth paths to intercept and drop these packets.

> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index 71227d0389aa5..5635037e3b605 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -756,6 +756,9 @@ static int veth_convert_skb_to_xdp_buff(struct veth_r=
q *rq,
>  	struct sk_buff *skb =3D *pskb;
>  	u32 frame_sz;
> =20
> +	if (unlikely(xdp_skb_feature_check(skb)))
> +		goto drop;
> +

[Severity: Medium]
When jumping to the drop label here, the code uses consume_skb():

veth_convert_skb_to_xdp_buff() {
	...
drop:
	consume_skb(skb);
	*pskb =3D NULL;

	return -ENOMEM;
}

Because *pskb is set to NULL, the caller's kfree_skb() on the error path
does nothing. Does this bypass network drop observability tools like
dropwatch, since consume_skb() makes it look like the packet was
successfully consumed instead of explicitly dropped?

>  	if (skb_shared(skb) || skb_head_is_locked(skb) ||
>  	    skb_is_nonlinear(skb) ||
>  	    skb_headroom(skb) < XDP_PACKET_HEADROOM) {

[ ... ]

> diff --git a/net/core/dev.c b/net/core/dev.c
> index 096d1dedebfd4..fbeb3df4c11f7 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
[ ... ]
> @@ -5516,6 +5517,9 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, s=
truct xdp_buff *xdp,
>  	u32 metalen, act;
>  	int off;
> =20
> +	if (unlikely(xdp_skb_feature_check(skb)))
> +		return XDP_DROP;
> +

[Severity: High]
Does this check happen too late for generic XDP?

In netif_receive_generic_xdp(), nonlinear and GSO packets are handled by
calling netif_skb_check_for_xdp() which triggers skb_linearize() before
this new check is reached:

netif_receive_generic_xdp() {
	...
	if (skb_cloned(skb) || skb_is_nonlinear(skb) ||
	    skb_headroom(skb) < XDP_PACKET_HEADROOM) {
		if (netif_skb_check_for_xdp(pskb, xdp_prog))
			goto do_drop;
	}
	...
	act =3D bpf_prog_run_generic_xdp(*pskb, xdp, xdp_prog);
	...
}

Because xdp_skb_feature_check() is added inside bpf_prog_run_generic_xdp(),
could this force the host to perform an expensive memory allocation and copy
to linearize large GSO packets, only to immediately drop them afterwards?=20

Could this be exploited as a Denial of Service vector by flooding large GSO
packets?

>  	/* The XDP program wants to see the packet starting at the MAC
>  	 * header.
>  	 */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928223648.2739=
371-1-kuba@kernel.org?part=3D5
