Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795030236;
	b=1lsN/bzDK0Oz3HTAUrEgYnEni/f6rP/AEhi0gtUEfJ3tprOYtSVvNMoFD82gALW6qCnb
	 eeaRyH02fwqAN7knCLnSZUrJGIdiFILDxuAMRopeEpVByB6wbc9CKGqAQKxi9iXU/A2/j
	 EN4ll1z729MnKBSTOyp32+skMv5Gat87vcWOdkw27s2eKos8/YG7CfgNJwDI/T2azirgh
	 grKoGKagUd998rxzXeQyX7dN7z8l1ihrHN8t/Qz/jn5i2qN7bj1IxCG50UMrGrTOzW43b
	 fZgmOn8X+8q/LYFwU5lqwn4lbXplBLxPOB1U/+kJgBC5++nebJc4jbGAf1oIfCwZUFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795030236;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WvKy6IeaGu/sRxeOXmrFcbyXgji8lDifJ32I/v3bsZM=;
	b=n4Ef6HYDpeCYawvHTn1dL+dB+mfsgl9dhg11dg850UREjVc9PPkcQ/lxugrSySi/AgQW
	 m9XV3l32/6LubENptdyRBssb7dUKJ9uY1hBAbsKEKwsb518sBIeOnkgJC3Zmx3wRbf7e7
	 eyFzKN0o4Ao7pq2ia7+0pcN1ATRZ/PoDkaq47Oqi8xPRGw0KxMY/v93I7wjCLmlo/CiTN
	 sWaDqy4IEpeuKdZbSDuZkHZvUEeaiNaKM80+VPI/oYtBE+bMh5SHO6rLzBb3yb2yV7GfK
	 88fDlKFOL/Ki0ehJhxSpZ8jjWPKX9VQx3dtNBrhpJWMH19lGI1w7ZWnLkr4mpNHXZpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="LIi/Kn94";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE96607F22A
	for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 19:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LIi/Kn94
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B62B91F000C5;
	Wed, 18 Nov 2026 19:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795030235;
	bh=WvKy6IeaGu/sRxeOXmrFcbyXgji8lDifJ32I/v3bsZM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LIi/Kn94FL0rzc+IiXyWkCFkNN1fXodXVKi9GsYInyFUt8ZzVlRN/I88puNi3Qcd8
	 siyETYfgwCpUllzk+6zsaPs50QzSF+TmRYQo5H6UrBXB7AmXQzgyUUFYByQm1CZNMl
	 6Vp4ldswlmEFZuXSnuR8BwK3GXXv1WeMBqqG8snrxT+vudhwisggEvDBfq1mHU7Duz
	 3esecH9CTrC7hAwIyS2GOn6YOjTsoCjDiO6OzogicT0YLjEUYnJoWXclZfhrzhypDm
	 sXJJmCFIFe0GZ/CGLTZZhTmU1YPVwj4/yL2XgNJTN765rZPXVK1J6LqrvOCHYbfuUZ
	 B6MyudlBSMqzA==
Message-ID: <sashiko-outbox-221863@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2 2/3] bpf: don't redirect decrypted skbs from
 egress to ingress
Reply-To: sashiko-reviews@lists.linux.dev
To: "Todd Freed" <toddfreed@meta.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261117192411.247117-3-toddfreed@meta.com>
References: <20261117192411.247117-1-toddfreed@meta.com>
 <20261117192411.247117-3-toddfreed@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 19:30:35 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Low] bpf: multi-line comment style in bpf_xmit() in
  net/core/lwt_bpf.c
- [Low] bpf: inaccurate commit message claim about LWT xmit
  __sk_buff->tstamp access
--

commit f0449c06845a54209a334370bea65b715330a2a6
Author: Todd Freed <toddfreed@meta.com>

bpf: don't redirect decrypted skbs from egress to ingress

This commit drops decrypted skbs redirected from egress to ingress in
__bpf_redirect() and clears tc_at_ingress before running LWT xmit BPF
programs.

> Clear the bit before running an LWT xmit program, as __dev_queue_xmit()
> would right after. This also gives the program's other uses of the bit,
> in the redirect helpers and in its __sk_buff->tstamp access, the egress
> view, which matches where it runs.

[Severity: Low]
Is the commit message accurate about LWT xmit programs accessing
__sk_buff->tstamp?

lwt_xmit_verifier_ops uses lwt_is_valid_access(), which explicitly rejects
bpf_ctx_range(struct __sk_buff, tstamp), and lwt_xmit_func_proto() does not
expose bpf_skb_set_tstamp().

> diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
> index 72c86ff2a8472..4861fe2b4959a 100644
> --- a/net/core/lwt_bpf.c
> +++ b/net/core/lwt_bpf.c

[ ... ]

> @@ -327,6 +328,13 @@ static int bpf_xmit(struct sk_buff *skb)
>  		__be16 proto =3D skb->protocol;
>  		int ret;
> =20
> +		/* The packet is on egress, but a forwarded one can still have
> +		 * tc_at_ingress set by the tc ingress hook of the device it
> +		 * came in on, until __dev_queue_xmit() clears it. Clear it
> +		 * now, so that the redirect helpers see the direction of this
> +		 * hook.
> +		 */
> +		tcx_set_ingress(skb, false);

[Severity: Low]
This isn't a bug, but BPF coding style places the opening /* of a
multi-line comment on its own line, with the text starting on the next
line.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117192411.2471=
17-1-toddfreed@meta.com?part=3D2
