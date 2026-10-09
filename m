Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C821D381B01
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 08:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791534296; cv=none; b=cYkiTVGZU6dV34bsg0s5vxHTICAqvN8xChHDNvhhulcrexBUXhk/I55+LH2rFo4wdCFF3t2iBuG9NpfKs0VyHjkGaMNvvrqNDLYKJYoTkXF8xo5qYYOynE+KcL/w908ImIDRy2qn4Nke5wmUxxsEslKbob/G/UsOsL/SSFFlv8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791534296; c=relaxed/simple;
	bh=Vff8Hd52X1GUp4CY+Aq8GHpHQbd2SBaGwiL0Bg8yX/o=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=K6X2f69qW210Ly7PNM9uXFYg1+y5Q+vPU6ut/qsVNcjbutaNrbnxmZ2dy+EBCvO9W5sDXyMG66SZcBFAN/uq0Q9jqZHA9Sv4BVANyL1ZMav3THxcuaeiOE0F2vU0G1qCed/x2iwLZEPNGRkb1FlAx3qAzjsgFB3wZMSOi99pR7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gIGhRo5H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gIGhRo5H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 901431F000FF;
	Fri,  9 Oct 2026 08:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791534295;
	bh=LsuiKGApM5nnRHjGFtx/xIQLtlmpct3GLWU2eyK3NVw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gIGhRo5HITX/cUk+w1CIYQPz125odlQ96/TVCe0ggG8AP407dY6h4kEczplfDDQ5C
	 aZ+Xeyh+nIvpEDux57xOgOJKr9Makp8pTy/MxNqPtMYRlun17c6TYZP6xSKdlzw7SE
	 I3atfM8J22lr+E2n2AyVS23m4edz7k5H+9jTR765RLGtF1rztD7wGlFRGmT/62voSc
	 obPScnmJoJn26N/hbEuZsjON0DRX8p/Wxn7lY1qLb+5TRCYqblMiJ+1fVcQUHk6mxT
	 Ve+/dWbm++XqeEh1e8Vl2wQ8PT2S4mHcR45eraQgFXJTNhtnQmoR/XT04O9zQ3Jgx8
	 EvKU64J/TJBJw==
Message-ID: <sashiko-outbox-165078@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v4 4/6] netlink: specs: rt-route: describe
 lwtunnel IP options
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hangbin Liu" <hangbin.liu@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261008-ynl_rt_encap-v4-4-4ed2ccf7f949@kylinos.cn>
References: <20261008-ynl_rt_encap-v4-0-4ed2ccf7f949@kylinos.cn>
 <20261008-ynl_rt_encap-v4-4-4ed2ccf7f949@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 08:24:55 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] netlink: YNL geneve requests unconditionally rejected due to mis=
sing NLA_F_NESTED
--

commit bb8425fa89209355072145c90ad72e3379375b6e
Author: Hangbin Liu <liuhangbin@kylinos.cn>

netlink: specs: rt-route: describe lwtunnel IP options

Replace binary opts in lwtunnel-ip and lwtunnel-ip6 with a nested
lwtunnel-ip-opts set. Add attribute sets for geneve, vxlan, and erspan
IP options to match linux/lwtunnel.h.

> diff --git a/Documentation/netlink/specs/rt-route.yaml b/Documentation/ne=
tlink/specs/rt-route.yaml
> index dc842a786794a..ea6711292c9b6 100644
> --- a/Documentation/netlink/specs/rt-route.yaml
> +++ b/Documentation/netlink/specs/rt-route.yaml
[ ... ]
> @@ -562,6 +564,45 @@ attribute-sets:
>        -
>          name: link
>          type: u32
> +  -
> +    name: lwtunnel-ip-opts
> +    name-prefix: lwtunnel-ip-opts-
> +    attributes:
> +      -
> +        name: geneve
> +        type: binary

[Severity: Medium]
Even though the commit message mentions using binary for Geneve options as a
temporary workaround, will this unconditionally break the request path for =
YNL
clients?

Because geneve is defined here as type binary, a YNL client will format the
attribute without the NLA_F_NESTED flag. However, the kernel's
ip_opts_policy in net/ipv4/ip_tunnel_core.c strictly defines this attribute
as nested:

    [LWTUNNEL_IP_OPTS_GENEVE] =3D { .type =3D NLA_NESTED },

When ip_tun_parse_opts() calls nla_validate() with strict validation,
__nla_validate_parse() in lib/nlattr.c rejects the attribute if the
NLA_F_NESTED flag is missing:

    if ((pt->type =3D=3D NLA_NESTED || pt->type =3D=3D NLA_NESTED_ARRAY) &&
        !(nla->nla_type & NLA_F_NESTED)) {
            NL_SET_ERR_MSG_ATTR_POL(extack, nla, pt,
                                    "NLA_F_NESTED is missing");
            return -EINVAL;
    }

Additionally, without multi-attr: true, YNL cannot express multiple
consecutive Geneve options which the kernel expects.

> +      -
> +        name: vxlan
> +        type: nest
> +        nested-attributes: lwtunnel-ip-opt-vxlan
> +      -
> +        name: erspan
> +        type: nest
> +        nested-attributes: lwtunnel-ip-opt-erspan
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008-ynl_rt_enc=
ap-v4-0-4ed2ccf7f949@kylinos.cn?part=3D4
