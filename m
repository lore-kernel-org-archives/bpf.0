Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237CE36F90A;
	Mon, 21 Sep 2026 06:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789972698; cv=none; b=q+VVTAlxp8QocYb4RXTTvfB9Lh4Ibix4LBe5WcMys+cnVFqwdboj/fG+or4PptqetmMoGZc1F0i0KPC+F9BpofSOxj/42eP1cU/lh6MEjpSXAV7xZqqd6iWylwM8oL1ST4x2n90FlrG9e6K8pw6bilt1up7wlf+fntexoV6CLa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789972698; c=relaxed/simple;
	bh=9jMS24w8T9/Iwx+fDxdj04EaAMFKVFMuy5ao1Ssiw8Q=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L9i0cDSQtEDuytkGB+Ahr2ODOVJK+kDcNL2ayx+/XShHL5HQQNxvJgP9Dc0N8b6Ok1jJbbiBv9mdYf9Y7iiOsGMavHAO5iHDzSLT0TOrrdL6hgUNtky+P9y7bAMBqSEGn+qHrRg7koKSIXXtS3FqNQCasMsjm14FJ0ZOxxXV+Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lxFp/P6t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lxFp/P6t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08B4D1F00899;
	Mon, 21 Sep 2026 06:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789972695;
	bh=shxNcuWti3/+oQ17+LN5PpSuwNQZGgc8fK6UujU3mLk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lxFp/P6t9N9BfqQdrWbfbnd5mRBxAEqAHusHgfoHqq2/YLY9RYImSfech6/LcU5Q5
	 Y9ZbitewLJStUlEKoxQx1k7L5arFRI+XxGVDDB25uwzexIUKhiYj3ssyzRMyQ+iqd8
	 /Hv8SfATTCnrEzl4Ob1eTySVAE4ywaOZ8+Td0abPF0KFHj/tJXm6pZzAlk2sCrUpW4
	 B8bRBDGxU9Odl8lPKnYGy1ie6429PoRnV2cIGehQ31NekFOmlW4XXL2rtlFqVk95Ni
	 YqMYCLzD9HGbW4Xu4bsOsWxrgLKcIVQvZCJTBY81XZ+/9UjhUNU2ztIvGDPiElLfz3
	 LFcI922NZVIgA==
Subject: Re: [PATCH net-next 3/6] netlink: specs: rt-route: add lwtunnel encap
 sub-message support
From: netdev-bot+sashiko@kernel.org
To: hangbin.liu@linux.dev
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 donald.hunter@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, liuhangbin@kylinos.cn
Date: Mon, 21 Sep 2026 06:38:14 +0000
Message-ID: <178997269458.2160803.9466830531181053829@kernel.org>
In-Reply-To: <20260917-ynl_rt_encap-v1-3-fbbe6e680571@kylinos.cn>
References: <20260917-ynl_rt_encap-v1-3-fbbe6e680571@kylinos.cn>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Newly described lwtunnel encap attributes that the kernel
  puts/gets in network byte order are declared as host-order integers,…
- [Medium] Generated C parser can dereference a NULL selector string:
  with RTA_ENCAP modelled as a sub-message selected by the `encap-type`…
- [Low] The newly added selector enum (`encap-type`), the `encap-data`
  sub-message and all eleven tunnel-specific attribute sets are added…

--

netlink: specs: rt-route: add lwtunnel encap sub-message support

This adds an encap-type enum to the rt-route spec and turns RTA_ENCAP into
a sub-message keyed by that enum, with new attribute sets describing the
mpls, ip, ila, ip6, seg6, bpf, seg6-local, rpl, ioam6 and xfrm payloads.
It also extends tools/net/ynl/Makefile.deps so the generated rt-route code
picks up the relevant uapi headers.

> diff --git a/Documentation/netlink/specs/rt-route.yaml b/Documentation/netlink/specs/rt-route.yaml
> index 253037ea5176a..0e236da140dc5 100644
> --- a/Documentation/netlink/specs/rt-route.yaml
> +++ b/Documentation/netlink/specs/rt-route.yaml
> @@ -99,6 +99,58 @@ definitions:
>          name: ra-withdrawn
>          doc: A Router Advertisement withdrew the route with a zero
>            lifetime.
> +  -
> +    name: encap-type
> +    type: enum
> +    name-prefix: lwtunnel-encap-
> +    enum-name:
> +    entries:
> +      - none
> +      - mpls
> +      - ip
> +      - ila
> +      - ip6
> +      - seg6
> +      - bpf
> +      - seg6-local
> +      - rpl
> +      - ioam6
> +      - xfrm

[Severity: Low]
This isn't a bug, but the new encap-type definition, the encap-data
sub-message and all eleven new attribute sets (mpls-iptunnel, lwtunnel-ip,
ila-attrs, lwtunnel-ip6, seg6-iptunnel, lwt-bpf, seg6-local, rpl-iptunnel,
ioam6-iptunnel, lwt-xfrm) carry no doc properties, while the neighbouring
rt-route-notify and rt-route-flags definitions in the same file do document
their entries.

Could a doc be added for at least the selector enum and each attribute set,
including a note that some members are deliberately left as binary here and
converted in follow-up patches?

> +
> +sub-messages:
> +  -
> +    name: encap-data
> +    formats:
> +      -
> +        value: mpls
> +        attribute-set: mpls-iptunnel

[ ... ]

> +      -
> +        value: xfrm
> +        attribute-set: lwt-xfrm
>  
>  attribute-sets:
>    -
> @@ -174,9 +226,12 @@ attribute-sets:
>        -
>          name: encap-type
>          type: u16
> +        enum: encap-type
>        -
>          name: encap
> -        type: binary  # tunnel specific nest
> +        type: sub-message
> +        sub-message: encap-data
> +        selector: encap-type

[Severity: Medium]
Can this crash the generated C parser when the peer kernel knows an encap
type that the spec does not?

The enum here lists values 0..10 (none..xfrm, i.e. today's
LWTUNNEL_ENCAP_MAX). TypeSubMessage._attr_get() in
tools/net/ynl/pyynl/ynl_gen_c.py only guards the zero case:

	if (!dst->encap_type)
		return ynl_submsg_failed(yarg, "encap", "encap-type");
	if (rt_route_encap_data_parse(&parg, rt_route_encap_type_str(dst->encap_type), attr))

and _put_enum_to_str_helper() generates the lookup as:

	if (value < 0 || value >= (int)YNL_ARRAY_SIZE(rt_route_encap_type_strmap))
		return NULL;

while the sub-message parser emitted by parse_rsp_submsg() starts with

	if (!strcmp(sel, "mpls"))

with no NULL check on sel. So a binary built from this tree dumping routes
from a kernel that added LWTUNNEL_ENCAP_* value 11 would call
strcmp(NULL, "mpls") while parsing an ordinary RTM_GETROUTE reply.

Before this change RTA_ENCAP was type binary, so unknown encap types parsed
harmlessly. Should the enum-to-string conversion introduced by "tools: ynl:
convert enum selector to string for sub-message parsing" fall back to
ynl_submsg_failed() when the lookup returns NULL, given this spec is its
first consumer?

>        -
>          name: expires
>          type: u32
> @@ -277,6 +332,229 @@ attribute-sets:

[ ... ]

> +  -
> +    name: lwtunnel-ip
> +    name-prefix: lwtunnel-ip-
> +    header: linux/lwtunnel.h
> +    attributes:
> +      -
> +        name: id
> +        type: u64
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
Do these declarations byte-swap the tunnel id and tunnel flags on
little-endian hosts?

dst and src above correctly carry byte-order: big-endian, but id and flags
do not, while the kernel encodes both in network order in
net/ipv4/ip_tunnel_core.c:

ip_tun_fill_encap_info()
	nla_put_be64(skb, LWTUNNEL_IP_ID, tun_info->key.tun_id, LWTUNNEL_IP_PAD)
	nla_put_be16(skb, LWTUNNEL_IP_FLAGS, ip_tunnel_flags_to_be16(...))

ip_tun_build_state()
	tun_info->key.tun_id = nla_get_be64(tb[LWTUNNEL_IP_ID]);

Without a byte-order property, NlAttr.get_format() in
tools/net/ynl/pyynl/lib/ynl.py returns format_.native:

	if byte_order:
	    return format_.big if byte_order == "big-endian" else format_.little
	return format_.native

and the same format is used by _add_attr() when packing requests, so both
dumps and route creation would see reversed bytes, including flag bits such
as TUNNEL_KEY landing in the wrong byte.

The same question applies to the ila-attrs locator, identifier and
locator-match below, which are __be64 on the wire (note the __force casts in
net/ipv6/ila/ila_lwt.c):

	p->locator.v64 = (__force __be64)nla_get_u64(tb[ILA_ATTR_LOCATOR]);
	nla_put_u64_64bit(skb, ILA_ATTR_LOCATOR, (__force u64)p->locator.v64, ILA_ATTR_PAD)

and to lwtunnel-ip6 id and flags, which use nla_put_be64()/nla_put_be16()
for LWTUNNEL_IP6_ID and LWTUNNEL_IP6_FLAGS in ip6_tun_fill_encap_info().

> +      -
> +        name: pad
> +        type: pad
> +      -
> +        name: opts
> +        type: binary  # lwtunnel ip nest options
> +  -
> +    name: ila-attrs
> +    name-prefix: ila-attr-
> +    header: linux/ila.h
> +    attributes:
> +      -
> +        name: locator
> +        type: u64
> +      -
> +        name: identifier
> +        type: u64
> +      -
> +        name: locator-match
> +        type: u64

[ ... ]

> +  -
> +    name: lwtunnel-ip6
> +    name-prefix: lwtunnel-ip6-
> +    header: linux/lwtunnel.h
> +    attributes:
> +      -
> +        name: id
> +        type: u64

[ ... ]

> +      -
> +        name: flags
> +        type: u16

[ ... ]

> +  -
> +    name: seg6-local
> +    name-prefix: seg6-local-
> +    header: linux/seg6_local.h
> +    attributes:

[ ... ]

> +      -
> +        name: nh4
> +        type: u32
> +        display-hint: ipv4

[Severity: High]
Should nh4 also carry byte-order: big-endian?

SEG6_LOCAL_NH4 is a raw struct in_addr in net/ipv6/seg6_local.c:

	[SEG6_LOCAL_NH4] = NLA_POLICY_EXACT_LEN(sizeof(struct in_addr)),
	...
	memcpy(&slwt->nh4, nla_data(attrs[SEG6_LOCAL_NH4]), sizeof(struct in_addr));

With u32 plus display-hint: ipv4 and no byte-order, ynl unpacks and packs it
natively, so does an END.DX4 route created through ynl end up with a
byte-reversed next hop (192.0.2.1 written as 1.2.0.192), and dumps rendering
it reversed?

The affected attributes above (lwtunnel-ip id/flags, lwtunnel-ip6 id/flags,
ila-attrs locator/identifier/locator-match, seg6-local nh4) appear unchanged
through the end of the series, so respinning this patch rather than fixing it
later would keep the spec contract correct from the start.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917-ynl_rt_encap-v1-0-fbbe6e680571%40kylinos.cn
