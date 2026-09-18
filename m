Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB4048E0ED
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 06:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789713420; cv=none; b=BQI0vTKJMDpPm6/9Hw3CNv2PlDHZvz0izcO+Azv23MkuGpUG8R672pMOwdFQYmG3AFe3vNmco4YXVoGbBhX2n2khPKhfUlkxVxf1XCAITVPdhDJcP3H0qkitZ2l9UsWgPGbkxksvx2CKmgn5AcZAGzxCz4ekQWEn6GiEvYxb1No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789713420; c=relaxed/simple;
	bh=J5rrKCKGyttVvZt/IOesPjl63oYeKLB6L+7jZzTcRfs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=duNACHbzDCKBlzwhlrj+6p0VD4ZEJ6Cg3czZymbvyaT3quXRubDNx8JeDP4/huft7nW+a/q0PgiSJa6ReA8XbcXhTm/LSO8znthhPCvm4es5ccuD2kEx4IYJyMn+GhW6XpFFn/nW0OgkS+vG1734QxZdlTrMUc00T/Ql5TZiJuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ba7hMBDO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ba7hMBDO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E4F1F000FF;
	Fri, 18 Sep 2026 06:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789713418;
	bh=5JkIKvo/XsoLxvtIHJAbK9Vu8wCqFgsxGHbZh9aAHQg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ba7hMBDO/mXJ0/uGWA6lnObTmxfpy3Ph05vPDgjm7sfTnJgtHPDIROinUClSzJVtA
	 f0ji1LyjohL0YQTLD5DhHnxYF0SEMxjGueTaU65RcRKwk+kO5YXkwRZevmYj5+GrGD
	 aLEd57TIVMWj+n6vPTxPCkfONueH7RWSE2Ov8e8km4setk8v/PYIBi75NRmND7+Dg0
	 Zca/ALthbAwChtIALzL3PNW2NzDnWgXU5J8xLhMnEUr/thV6fdR/JuLUhLjwINmxPe
	 SM7yXiaQTHsjedrY2r561hIffltq8bxhIsRX+S0zRxvB4BjO2o65L/AmhOGQYQ23t2
	 brKE4M6vkTpEQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 4/6] netlink: specs: rt-route: describe
 lwtunnel IP options
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hangbin Liu" <hangbin.liu@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260917-ynl_rt_encap-v1-4-fbbe6e680571@kylinos.cn>
References: <20260917-ynl_rt_encap-v1-0-fbbe6e680571@kylinos.cn>
 <20260917-ynl_rt_encap-v1-4-fbbe6e680571@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 06:36:58 +0000
Message-Id: <20260918063658.80E4F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] netlink: specs: missing byte-order property for lwtunnel-ip-opt-=
erspan index
- [Low] netlink: specs: missing max-len validation for lwtunnel-ip-opt-gene=
ve data
--

commit 15d568f88486d1cb50af0dbb912eabab2c37d852
Author: Hangbin Liu <liuhangbin@kylinos.cn>

netlink: specs: rt-route: describe lwtunnel IP options

This commit replaces binary options in lwtunnel-ip and lwtunnel-ip6 with
a nested lwtunnel-ip-opts set. It also adds attribute sets for geneve, vxla=
n,
and erspan IP options to align with the kernel's definitions in lwtunnel.h.

> diff --git a/Documentation/netlink/specs/rt-route.yaml b/Documentation/ne=
tlink/specs/rt-route.yaml
> index 0e236da140dc5..6030d7cb8d0d1 100644
> --- a/Documentation/netlink/specs/rt-route.yaml
> +++ b/Documentation/netlink/specs/rt-route.yaml
[ ... ]
> @@ -555,6 +557,59 @@ attribute-sets:
>        -
>          name: link
>          type: u32
> +  -
> +    name: lwtunnel-ip-opts
> +    name-prefix: lwtunnel-ip-opts-
> +    attributes:
> +      -
> +        name: geneve
> +        type: nest
> +        nested-attributes: lwtunnel-ip-opt-geneve
> +      -
> +        name: vxlan
> +        type: nest
> +        nested-attributes: lwtunnel-ip-opt-vxlan
> +      -
> +        name: erspan
> +        type: nest
> +        nested-attributes: lwtunnel-ip-opt-erspan
> +  -
> +    name: lwtunnel-ip-opt-geneve
> +    name-prefix: lwtunnel-ip-opt-geneve-
> +    attributes:
> +      -
> +        name: class
> +        type: u16
> +        byte-order: big-endian
> +      -
> +        name: type
> +        type: u8
> +      -
> +        name: data
> +        type: binary

[Severity: Low]
Does this binary attribute need a max-len validation check?

The kernel explicitly enforces a maximum length of 127 bytes for this
attribute in its Netlink policy:

net/ipv4/ip_tunnel_core.c:geneve_opt_policy[] {
    [LWTUNNEL_IP_OPT_GENEVE_DATA] =3D { .type =3D NLA_BINARY, .len =3D 127 =
},
}

Without a corresponding max-len constraint in the spec, auto-generated
tools will not catch oversized attributes locally before transmitting
them to the kernel.

> +  -
> +    name: lwtunnel-ip-opt-vxlan
> +    name-prefix: lwtunnel-ip-opt-vxlan-
> +    attributes:
> +      -
> +        name: gbp
> +        type: u32
> +  -
> +    name: lwtunnel-ip-opt-erspan
> +    name-prefix: lwtunnel-ip-opt-erspan-
> +    attributes:
> +      -
> +        name: ver
> +        type: u8
> +      -
> +        name: index
> +        type: u32

[Severity: Medium]
Will this result in an incorrect ERSPAN index on little-endian architecture=
s?

The kernel parses this attribute using nla_get_be32():

net/ipv4/ip_tunnel_core.c:ip_tun_parse_opts_erspan() {
    ...
    attr =3D tb[LWTUNNEL_IP_OPT_ERSPAN_INDEX];
    md->u.index =3D nla_get_be32(attr);
    ...
}

Since the spec defines index as a u32 without the byte-order: big-endian
property, auto-generated tools will send the value in host byte order.
When run on a little-endian system, the kernel would then read a
byte-swapped, incorrect value, which would break the tunnel configuration.

> +      -
> +        name: dir
> +        type: u8
> +      -
> +        name: hwid
> +        type: u8

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917-ynl_rt_enc=
ap-v1-0-fbbe6e680571@kylinos.cn?part=3D4
