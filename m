Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3693B2FCD
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 06:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789713418; cv=none; b=qItzKG7CvpWv9uYtL5fEUnzFWIBRd1jgDDlpfwCx9gvTBNfMmcuaiZWFkqbuRvYLKFpfQ8DXabw6th8poJDcpvQ1ZFzMmZr8+ZauW54PcwHyUaE4a1/pjvnbm281fUm9jQFRBO1OSsX4MR2FaGwoKX44AlUg4LqxOKGj65sUGns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789713418; c=relaxed/simple;
	bh=h1Xa4OaBezOO6u9sbslzFUXlcGt4I6bPP9Bu6Sq+bhM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dscg0AgTlIC1cw+BxX+KbzdjybIAiHvdHUhBkCgPC5YeDrDU/3mOFt7YF6KrSgwgPvYTbyTczaSK8wzEhpq4lThttSK1Z1XBomD3Z1xRD6Nd5XXlidMtTGjJ+644HuTr8qnLq4ZnawkileEYSLDe45y/I19Dp9UrUDjU07rQFsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/AqktTm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/AqktTm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 953941F00898;
	Fri, 18 Sep 2026 06:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789713416;
	bh=1+6muLYkY6/OLaVOWfMwAO3r2j/ZwoVD2PufUVAec+c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D/AqktTmE9HxfkJmWbIaxsciTDnqgjXkWP4mBCP8NfRuHU9gZfdTp43IEvU3UlQwR
	 iwQ2Wmx539u5NkTNGd1mZd4hqg6tw8oh0KLP4r+xHT/u8Y6dMiK1KT/H7UnAkUD6BO
	 BCQbzJnfUI/EA1TrEdLzqx2NZY+YzqhWCSPS47XNB1xI0JBoq7NKZkgReSv8O6LtnA
	 beblAQc+31E8WTsYcxx0VQOzWLz/+kxSPXaUimKycYtZ7GOGfrTYwIYStCaKEzBWKv
	 +/otnWpvD+J9DvM8UW/6LSqQxvb2DPavlhWza0kgS4wpS+u1xe4FzofXHU5NeALDom
	 ezmJkAxmCqLNg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 3/6] netlink: specs: rt-route: add lwtunnel
 encap sub-message support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hangbin Liu" <hangbin.liu@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260917-ynl_rt_encap-v1-3-fbbe6e680571@kylinos.cn>
References: <20260917-ynl_rt_encap-v1-0-fbbe6e680571@kylinos.cn>
 <20260917-ynl_rt_encap-v1-3-fbbe6e680571@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 06:36:56 +0000
Message-Id: <20260918063656.953941F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] netlink: missing byte-order: big-endian in rt-route specs
--

commit 18041b529d7678ae7bbdd8ee61a7fb4213ae6804
Author: Hangbin Liu <liuhangbin@kylinos.cn>

netlink: specs: rt-route: add lwtunnel encap sub-message support

This commit adds lwtunnel encapsulation sub-message support to the rt-route
netlink specs, defining various tunnel attribute sets such as mpls, ip, ip6,
seg6, bpf, etc. It updates the yaml spec for rt-route and adds necessary
headers to the Makefile dependencies.

> diff --git a/Documentation/netlink/specs/rt-route.yaml b/Documentation/ne=
tlink/specs/rt-route.yaml
> index 253037ea5176a..0e236da140dc5 100644
> --- a/Documentation/netlink/specs/rt-route.yaml
> +++ b/Documentation/netlink/specs/rt-route.yaml
[ ... ]
> @@ -277,6 +332,229 @@ attribute-sets:
>        -
>          name: fastopen-no-cookie
>          type: u32
[ ... ]
> +  -
> +    name: lwtunnel-ip
> +    name-prefix: lwtunnel-ip-
> +    header: linux/lwtunnel.h
> +    attributes:
> +      -
> +        name: id
> +        type: u64

[Severity: High]
Does this field need a byte-order: big-endian annotation? The kernel
reads LWTUNNEL_IP_ID as be64 using nla_get_be64(). Without the annotation,
YNL tools will byte-swap this on little-endian architectures, potentially
causing silent data corruption.

> +      -
> +        name: dst
> +        type: u32
> +        byte-order: big-endian
> +        display-hint: ipv4
> +      -
> +        name: src
> +        type: u32
> +        byte-order: big-endian
> +        display-hint: ipv4
> +      -
> +        name: ttl
> +        type: u8
> +      -
> +        name: tos
> +        type: u8
> +      -
> +        name: flags
> +        type: u16

[Severity: High]
Does this field also need a byte-order: big-endian annotation? The kernel
reads LWTUNNEL_IP_FLAGS as be16 using nla_get_be16().

[ ... ]
> +  -
> +    name: lwtunnel-ip6
> +    name-prefix: lwtunnel-ip6-
> +    header: linux/lwtunnel.h
> +    attributes:
> +      -
> +        name: id
> +        type: u64

[Severity: High]
Could this also be missing a byte-order: big-endian annotation? The kernel
reads LWTUNNEL_IP6_ID as be64.

[ ... ]
> +      -
> +        name: hoplimit
> +        type: u8
> +      -
> +        name: tc
> +        type: u8
> +      -
> +        name: flags
> +        type: u16

[Severity: High]
Could this also be missing a byte-order: big-endian annotation? The kernel
reads LWTUNNEL_IP6_FLAGS as be16.

[ ... ]
> +  -
> +    name: seg6-local
> +    name-prefix: seg6-local-
> +    header: linux/seg6_local.h
> +    attributes:
[ ... ]
> +      -
> +        name: table
> +        type: u32
> +      -
> +        name: nh4
> +        type: u32
> +        display-hint: ipv4

[Severity: High]
Does this field need a byte-order: big-endian annotation? SEG6_LOCAL_NH4 is
a raw IPv4 address and handled as a struct in_addr in the kernel, but here
it is typed as a native u32. This might cause YNL tools to silently
byte-swap the address on little-endian architectures.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917-ynl_rt_enc=
ap-v1-0-fbbe6e680571@kylinos.cn?part=3D3
