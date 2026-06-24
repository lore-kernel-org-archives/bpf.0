Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817DF34E75E
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 19:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782328771; cv=none; b=tNl2ceZcRgG2AEX4GbKS65OpO+2oXxcRUr6Jb7hx6eAU41p4CpRbXhK/kAc/aKwphMrrVj9rWbVqb5RADAz6O9NqQZwKjE1gqYy10jtw7r6WTNiIG5v6wp6IC/GjFsm/j9mh8IQrgKWMOohtG/TM00Yx/2qGvbG4woiJAsGuN4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782328771; c=relaxed/simple;
	bh=cjs666VNWJUK9COjGZHBYjiwlVS7VrVGbeRMFtWUqcg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZitTOFOp8VR/kDQ8MhWFIlDXZ/2CIfblBhyYWHMpne/YIMOt9TAaWF0FxiF6VkqgbwvLxNLvVvfyKLpbJSpfKSe5C3RsEjM2lZ3CYApQIFQ/7Qo+Y6AjnWpIS7+Axj2w3Ld1BKLCTQqDcJgUauUKVa9+vbr6lbkD8h/qwUBp134=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dHprnp4l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHprnp4l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE72B1F000E9;
	Wed, 24 Jun 2026 19:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782328767;
	bh=BVInnT7mBaIdqnP3SeeYe80Pd19x9tYs9CSd870sN00=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dHprnp4lLD9eTbtkZOJN3MLuX1Em0izqqKjeW6RilyIc56wGSBWq97/l8psM4ssJn
	 eH7p42k/ZIZJbVIVTl0CCMd7v93nXaLQnjnGzNqZvAf3X/Upza9lDa1QF+HXCFjO0/
	 y79ycPi/Mr/t87+y8bYiynMxSuN1SpvL08BY85bKkS9tbmPZSIIshQSTfO3qXux47c
	 ZNwpJQEFcetF/0kQk+4BZwEmsZ4EqULso1zP0OrLlOanz1jkgLO5nSImOb1ddEFyh9
	 jpK3rPkh99Cnm0DAu5L1DnhjpqGIoLMjh0on8tOg9mcAVUP817NPDCoXFiugiHrMzC
	 XSj144MK1iKcw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v9 1/5] bpf: add bpf_icmp_send kfunc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mahe Tardy" <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260624185554.362555-2-mahe.tardy@gmail.com>
References: <20260624185554.362555-1-mahe.tardy@gmail.com>
 <20260624185554.362555-2-mahe.tardy@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 19:19:26 +0000
Message-Id: <20260624191927.BE72B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing `skb_valid_dst()` check for IPv6 allows type confusion wit=
h metadata dst entries, leading to an out-of-bounds read and kernel crash.
--

commit a59a53956c9b8f69a9dfa47bc54cc9fbcd9759ec
Author: Mahe Tardy <mahe.tardy@gmail.com>

bpf: add bpf_icmp_send kfunc

This commit introduces a new bpf_icmp_send kfunc to allow BPF programs to
generate ICMP error messages. It clones the original skb and invokes the
underlying IPv4 or IPv6 ICMP send routines.

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 2e96b4b847ce1..f3aa494ed1053 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c

[ ... ]

> +__bpf_kfunc int bpf_icmp_send(struct __sk_buff *skb_ctx, int type, int c=
ode)
> +{
> +	struct sk_buff *skb =3D (struct sk_buff *)skb_ctx;
> +	struct sk_buff *nskb;
> +	struct sock *sk;

[ ... ]

> +	switch (skb->protocol) {
> +#if IS_ENABLED(CONFIG_INET)
> +	case htons(ETH_P_IP): {
> +		if (type !=3D ICMP_DEST_UNREACH)
> +			return -EOPNOTSUPP;
> +		if (code < 0 || code > NR_ICMP_UNREACH ||
> +		    code =3D=3D ICMP_FRAG_NEEDED) /* needs a valid next-hop MTU */
> +			return -EINVAL;
> +
> +		/* icmp_send requires a rtable; test-run synthetic skbs lack one. */
> +		if (!skb_valid_dst(skb))
> +			return -ENETUNREACH;
> +
> +		nskb =3D skb_clone(skb, GFP_ATOMIC);

[ ... ]

> +#if IS_ENABLED(CONFIG_IPV6)
> +	case htons(ETH_P_IPV6):
> +		if (type !=3D ICMPV6_DEST_UNREACH)
> +			return -EOPNOTSUPP;
> +		if (code < 0 || code > ICMPV6_REJECT_ROUTE)
> +			return -EINVAL;
> +

[Severity: High]
Should there be a check for skb_valid_dst(skb) here before cloning and
sending the IPv6 ICMP message?

It looks like the IPv4 branch validates the dst to prevent routing table
lookups on synthetic or metadata-dst packets, but the IPv6 branch does not.

If an IPv6 packet with a metadata_dst (e.g., from LWT or a tunnel) is
passed to bpf_icmp_send(), could icmpv6_send() process the invalid dst and
cast it to a struct rt6_info in icmp6_dev()? Dereferencing rt6->rt6i_idev
might then read out of bounds from the metadata_dst struct and cause a
kernel crash.

> +		nskb =3D skb_clone(skb, GFP_ATOMIC);
> +		if (!nskb)
> +			return -ENOMEM;
> +
> +		memset(IP6CB(nskb), 0, sizeof(*IP6CB(nskb)));
> +		icmpv6_send(nskb, type, code, 0);
> +		consume_skb(nskb);
> +		break;
> +#endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624185554.3625=
55-1-mahe.tardy@gmail.com?part=3D1
