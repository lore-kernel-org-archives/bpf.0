Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E14C373C12;
	Mon, 21 Sep 2026 06:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789972698; cv=none; b=SziRA4/xSsUw9T9/CyPflVGHBTyX3sRCk/XKt5032z19Tz1HyFye2GcT//m1acEWk6sfcZyowomabDK9wec6CiSp2FeyoWdPw5it7TFpiDZhXGw4T2zJU1g9yPrSP3teS7lgjmssw7al11yOMGIAvRHEEvbBvV9B8UU/45TIeJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789972698; c=relaxed/simple;
	bh=CGiHqk5TsRnOuJM+UjP9p7U5IQXpp3ubd6D0Hzp4r0w=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KilGpnndmCVXGQPg/wL9DmQ3MbrpDTF5bLhYOYJGsyj6fWsKb7sEqPu2p0OTaXabmYN4c+C2Mnlk/EZN6D4CiqE7gQuaQgyycGG78m5y42KKSFwaOcvuFajlU84dSIjAU5E3dDC/vL69FZYuFfia98eZrlbSNzHWDraCzVcJiFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYHw90nE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYHw90nE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ADB81F00893;
	Mon, 21 Sep 2026 06:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789972696;
	bh=HrpZjqcUa/VSzBtStdfiVD5ts6S8NWwGG+kimhJT3uc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CYHw90nE4IQgTZo50gbrKEyLCKpRbK0mkvwMh9Gi/OJby15IUY4DfG0LFgbxD1/uc
	 i9zdNCKMC+LrAnTs4LT/kzY6cM5YCiUYZHQPonGipEu0eFgAf+y8uRs7wkUm4TISm5
	 RN/MVapfizQnE0ZOCUVE865wvn2vpHciQKsIDrl3shjwi0w9VOl0UIipeW1dsGJd9I
	 RNjb2Epmtlk2yFcfgtY8iCrugbeHoh0u4bktQbKoUfJ+3P91bKfg9ABjNfKkBOqsLB
	 y+drUBtqBrrtQa+pBWocm5e1my8AvdFxe1HnLeK5KHKRrO8BicD7sl3er6NmiZpdrq
	 1mVL5XdXogfkg==
Subject: Re: [PATCH net-next 4/6] netlink: specs: rt-route: describe lwtunnel
 IP options
From: netdev-bot+sashiko@kernel.org
To: hangbin.liu@linux.dev
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 donald.hunter@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, liuhangbin@kylinos.cn
Date: Mon, 21 Sep 2026 06:38:15 +0000
Message-ID: <178997269588.2160803.17770495644903940757@kernel.org>
In-Reply-To: <20260917-ynl_rt_encap-v1-4-fbbe6e680571@kylinos.cn>
References: <20260917-ynl_rt_encap-v1-4-fbbe6e680571@kylinos.cn>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 2 (1) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] New `lwtunnel-ip-opt-erspan.index` attribute in
  Documentation/netlink/specs/rt-route.yaml is declared as host-order…
- [Medium] The new `lwtunnel-ip-opts` / `lwtunnel-ip-opt-geneve` sets
  cannot represent multi-option Geneve tunnels.
- [Low] The four newly added attribute sets (`lwtunnel-ip-opts` at rt-
  route.yaml:561, `lwtunnel-ip-opt-geneve` at 577, `lwtunnel-ip-opt-…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but in the very
  `lwtunnel-ip` / `lwtunnel-ip6` sets the patch edits, `id` is declared…

--

netlink: specs: rt-route: describe lwtunnel IP options

This converts the opaque binary opts attribute in the lwtunnel-ip and
lwtunnel-ip6 attribute sets into a nest pointing at a new lwtunnel-ip-opts
set, and adds three new sets describing the geneve, vxlan and erspan IP
tunnel options.

> diff --git a/Documentation/netlink/specs/rt-route.yaml b/Documentation/netlink/specs/rt-route.yaml
> index 0e236da140dc5..6030d7cb8d0d1 100644
> --- a/Documentation/netlink/specs/rt-route.yaml
> +++ b/Documentation/netlink/specs/rt-route.yaml
> @@ -375,7 +375,8 @@ attribute-sets:
>          type: pad
>        -
>          name: opts
> -        type: binary  # lwtunnel ip nest options
> +        type: nest
> +        nested-attributes: lwtunnel-ip-opts

[Severity: Medium]
This isn't a bug introduced by this patch, but while the lwtunnel-ip and
lwtunnel-ip6 sets are being touched here, both declare id as plain u64 and
flags as plain u16 with no byte-order property:

  name: lwtunnel-ip
  ...
      -
        name: id
        type: u64
  ...
      -
        name: flags
        type: u16

The kernel encodes and decodes both as big-endian.  In
ip_tun_fill_encap_info():

	if (nla_put_be64(skb, LWTUNNEL_IP_ID, tun_info->key.tun_id,
			 LWTUNNEL_IP_PAD) ||
	...
	    nla_put_be16(skb, LWTUNNEL_IP_FLAGS,
			 ip_tunnel_flags_to_be16(tun_info->key.tun_flags)) ||

and ip_tun_build_state() reads them back with nla_get_be64() /
nla_get_be16().  ip6_tun_fill_encap_info() and ip6_tun_build_state() do the
same for LWTUNNEL_IP6_ID and LWTUNNEL_IP6_FLAGS.

Would generated codecs therefore byte-swap the tunnel id and flags on
little-endian hosts?  Since this patch adds byte-order: big-endian to a new
neighbouring attribute, would it make sense to annotate these two in the
same series so the edited sets are self-consistent?

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

[Severity: Low]
Should these four new sets carry header: linux/lwtunnel.h?

The LWTUNNEL_IP_OPTS_*, LWTUNNEL_IP_OPT_GENEVE_*, LWTUNNEL_IP_OPT_VXLAN_*
and LWTUNNEL_IP_OPT_ERSPAN_* enums all live in
include/uapi/linux/lwtunnel.h, and every sibling lwtunnel set in this same
file already declares it (lwtunnel-ip, lwtunnel-ip6, lwt-bpf, lwt-xfrm).

In ynl_gen_c.py the header property is what suppresses re-rendering of the
enum:

    for definition in parsed['definitions'] + parsed['attribute-sets']:
        if 'header' not in definition:
            continue

Without it, does C codegen re-define LWTUNNEL_IP_OPTS_GENEVE and friends
locally instead of including <linux/lwtunnel.h>, risking duplicate
definitions when both headers are used?

[Severity: Medium]
Can this set represent a tunnel carrying more than one Geneve option?

ip_tun_fill_encap_opts_geneve() opens a single LWTUNNEL_IP_OPTS_GENEVE nest
and then loops, emitting one CLASS/TYPE/DATA triplet per option inside that
one nest:

	while (tun_info->options_len > offset) {
		opt = ip_tunnel_info_opts(tun_info) + offset;
		if (nla_put_be16(skb, LWTUNNEL_IP_OPT_GENEVE_CLASS,
				 opt->opt_class) || ...

On the input side ip_tun_parse_opts() accumulates repeated Geneve nests,
rejecting only cross-type repeats:

		case LWTUNNEL_IP_OPTS_GENEVE:
			if (type && type != IP_TUNNEL_GENEVE_OPT_BIT)
				return -EINVAL;

Neither the outer geneve attribute nor the inner class/type/data attributes
are marked multi-attr: true.  nlspec.py defaults to single:

        self.is_multi = yaml.get('multi-attr', False)

and ynl.py then overwrites earlier values:

        if not is_multi:
            rsp[name] = decoded

So for a route created with something like

  ip route add ... encap ip id 1 geneve_opts 0102:80:00001111,0102:81:00002222 ...

would a decoder keep only the last triplet, and would an encoder be unable
to express more than one option at all?  The previous binary modelling of
opts preserved the whole payload, so is this conversion lossy as it stands?

Note that adding multi-attr only to the outer geneve attribute would not be
enough for reply decoding, since the repeated triplets live inside one nest.

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
Should data record the kernel's length constraints via checks: max-len?

geneve_opt_policy caps the attribute:

	[LWTUNNEL_IP_OPT_GENEVE_DATA]	= { .type = NLA_BINARY, .len = 127 },

and ip_tun_parse_opts_geneve() additionally requires 4-byte granularity:

	data_len = nla_len(attr);
	if (data_len % 4)
		return -EINVAL;

so 124 bytes is the largest payload the kernel accepts.  As written, can
spec-driven tooling build a request the kernel rejects with a bare -EINVAL?

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
Is index missing byte-order: big-endian here?

The kernel treats LWTUNNEL_IP_OPT_ERSPAN_INDEX as big-endian on both
paths.  ip_tun_fill_encap_opts_erspan() does:

	    nla_put_be32(skb, LWTUNNEL_IP_OPT_ERSPAN_INDEX, md->u.index))

and ip_tun_parse_opts_erspan() does:

			md->u.index = nla_get_be32(attr);

nlspec.py reads byte_order = yaml.get('byte-order'), which is None when the
property is absent, so generated codecs would use native order.  On
little-endian hosts, would an index of 1 decode as 0x01000000, and would a
request built from this spec program a swapped index that the kernel
accepts as-is?

The erspan_opt_policy entry is { .type = NLA_U32 }, which is a size-only
check and does not contradict the be32 accessors.  The class attribute added
in lwtunnel-ip-opt-geneve in this same patch does carry
byte-order: big-endian, so this looks like an oversight rather than an
intentional difference.

> +      -
> +        name: dir
> +        type: u8
> +      -
> +        name: hwid
> +        type: u8

Thanks for looking at these.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917-ynl_rt_encap-v1-0-fbbe6e680571%40kylinos.cn
