Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52ED489FBE;
	Fri,  9 Oct 2026 09:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791536826; cv=none; b=QBqEnjwR+jgADwkoUBrZ2hkMZbUNwfFtg06xJMh2tGTC0wL+Lj9f3dnzIeyosdqgDaCt8dz7OMJybbmXI+3z6BTVKG4SoF/6B63rzb+ADnQok0y1yMbuMAfFutV5cQCRh8YSbAh+74b+YyniWGgf+wObVx6+tHjw/EU8+ZpNfAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791536826; c=relaxed/simple;
	bh=k1hq2ZrITAhrC0xGLKX26Gw3XmXodcKy3pPd6n1qcv0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mBicltRBxEaaM7kgCTKavNC6llOw63qrNDhOwt9Qpn8+OLI7RWMMO7vbzz3wBga3O8+bSTV5BWXrMm2tGMuiaISZBpBqVsUE+LljsHhjFCW23+D51tJJOp3ZVX0AKhZqhV+l73Sv4xx8xNsXgeOon2t3ALVqAjsZfo3udzqbyps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VwWT3BIp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VwWT3BIp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B39BB1F00898;
	Fri,  9 Oct 2026 09:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791536822;
	bh=i5SG3DjCiuIVoPKei06jHIrsTmo/IkuSfI2PQWR6iVs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VwWT3BIpUW54BgL7iE+VnSEHXF3CumKFIhs5k03o18ZAwwh6pTbPOhz+eV/OCDIHT
	 cXRQaeioeg6ilrrHukPh+AEvRv3i4uuUhfZ5j48Fn5WB0EoGdA9C0EsfdFlTqDYSzh
	 q7IIZrKmrDlAOvB/ws6vZ1prFmlQh6w2lfggPxZoNSIbrxOSSUm0rhr5AuOc2GK/ID
	 tOfxnqNT0NVuH1w/kELnnxRsQTyb3rI7TMLSC5MaksLzpBBL+c140QMe1vZrksrZSy
	 PGhG5ZakkWgqKnccJg+0TUD49NTHPQgHavfZDQYtcW4VGK3i4cbxSt/8t5mdQI4qBW
	 uFi0ekWUodGTQ==
Subject: Re: [PATCH net-next v4 4/6] netlink: specs: rt-route: describe
 lwtunnel IP options
From: netdev-bot+sashiko@kernel.org
To: hangbin.liu@linux.dev
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, donald.hunter@gmail.com,
 edumazet@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, liuhangbin@kylinos.cn
Date: Fri, 09 Oct 2026 09:07:01 +0000
Message-ID: <179153682125.434549.6402494415316907824@kernel.org>
In-Reply-To: <20261008-ynl_rt_encap-v4-4-4ed2ccf7f949@kylinos.cn>
References: <20261008-ynl_rt_encap-v4-4-4ed2ccf7f949@kylinos.cn>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Under this spec, YNL cannot send a request that sets Geneve
  tunnel options; the kernel rejects it.
- [Low] The new `lwtunnel-ip-opts` set declares `geneve` as one `binary`
  attribute without `multi-attr: true`.
- [Low] The commit message contradicts itself.

--

netlink: specs: rt-route: describe lwtunnel IP options

This commit changes the binary opts attribute in lwtunnel-ip and
lwtunnel-ip6 into a nest of a new lwtunnel-ip-opts set. It adds vxlan and
erspan option sets. Geneve options stay binary because the kernel uses a
different layout for requests and for dumps.

> Replace binary opts in lwtunnel-ip and lwtunnel-ip6 with a nested
> lwtunnel-ip-opts set. Add attribute sets for geneve, vxlan, and erspan
> IP options to match linux/lwtunnel.h.

[Severity: Low]
The first paragraph says attribute sets are added for geneve, vxlan and
erspan. The diff adds lwtunnel-ip-opts, lwtunnel-ip-opt-vxlan and
lwtunnel-ip-opt-erspan, but no lwtunnel-ip-opt-geneve set, and the
second paragraph says geneve is omitted.

Could the first paragraph say something like "Add attribute sets for
vxlan and erspan IP options; keep geneve as binary (see below)"?

> diff --git a/Documentation/netlink/specs/rt-route.yaml b/Documentation/netlink/specs/rt-route.yaml
> index dc842a786794a..ea6711292c9b6 100644
> --- a/Documentation/netlink/specs/rt-route.yaml
> +++ b/Documentation/netlink/specs/rt-route.yaml
> @@ -377,7 +377,8 @@ attribute-sets:
>          type: pad
>        -
>          name: opts
> -        type: binary  # lwtunnel ip nest options
> +        type: nest
> +        nested-attributes: lwtunnel-ip-opts
>    -
>      name: ila-attrs
>      name-prefix: ila-attr-

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
With geneve declared as binary, can YNL still send a route request that
carries Geneve options?

In tools/net/ynl/pyynl/lib/ynl.py, YnlFamily._add_attr() sets
NLA_F_NESTED only in the nest branch. The binary branch copies the payload
and leaves the flag out of the header:

    if attr["type"] == 'nest':
        nl_type |= Netlink.NLA_F_NESTED
    ...
    elif attr["type"] == 'binary':
        ...
            attr_payload = value

In the kernel, ip_opts_policy types GENEVE as nested:

net/ipv4/ip_tunnel_core.c:
    [LWTUNNEL_IP_OPTS_GENEVE]	= { .type = NLA_NESTED },

ip_tun_parse_opts() validates the payload in strict mode:

    err = nla_validate(nla_data(attr), nla_len(attr), LWTUNNEL_IP_OPTS_MAX,
                       ip_opts_policy, extack);

NL_VALIDATE_STRICT includes NL_VALIDATE_NESTED, so validate_nla() in
lib/nlattr.c rejects the attribute:

    if (validate & NL_VALIDATE_NESTED) {
        if ((pt->type == NLA_NESTED || pt->type == NLA_NESTED_ARRAY) &&
            !(nla->nla_type & NLA_F_NESTED)) {

ip_tun_parse_opts_geneve() then calls nla_parse_nested(), which does the
same check. So a newroute with encap type ip or ip6 and encap.opts.geneve
set to bytes fails with -EINVAL, even if the bytes hold a well-formed
CLASS/TYPE/DATA triplet.

Before this patch the whole opts attribute was binary. A caller could
pass the raw LWTUNNEL_IP_OPTS payload with NLA_F_NESTED already set on the
inner GENEVE header. The outer attribute is parsed with
nla_parse_nested_deprecated(), so the missing flag there was not checked.

Is this a regression for YNL users who configure Geneve options? Dumps
still decode, because ip_tun_fill_encap_opts_geneve() uses
nla_nest_start_noflag(). Later patches in the series do not change this,
and the final rt-route.yaml still has geneve as binary.

[Severity: Low]
Can this spec describe a request with more than one Geneve option?

On the request path, ip_tun_parse_opts() walks every attribute in the
opts nest. It passes each LWTUNNEL_IP_OPTS_GENEVE to
ip_tun_parse_opts_geneve(), which reads exactly one CLASS/TYPE/DATA
option:

    nla_for_each_attr(nla, nla_data(attr), nla_len(attr), rem) {
        switch (nla_type(nla)) {
        case LWTUNNEL_IP_OPTS_GENEVE:
            ...
            opts_len += opt_len;
            if (opts_len > IP_TUNNEL_OPTS_MAX)

So a request sends several Geneve options by repeating the GENEVE
attribute. The uAPI also defines a structured inner set for it, which
geneve_opt_policy enforces:

    [LWTUNNEL_IP_OPT_GENEVE_CLASS]	= { .type = NLA_U16 },
    [LWTUNNEL_IP_OPT_GENEVE_TYPE]	= { .type = NLA_U8 },
    [LWTUNNEL_IP_OPT_GENEVE_DATA]	= { .type = NLA_BINARY, .len = 127 },

The geneve entry here has no multi-attr. YnlFamily._add_attr() only turns
a list value into repeated attributes when attr.is_multi is set, so two
Geneve options on one route cannot be expressed.

Adding multi-attr alone would not make requests work, because of the
NLA_F_NESTED problem above. Nothing later in the series changes this.

> +      -
> +        name: vxlan
> +        type: nest
> +        nested-attributes: lwtunnel-ip-opt-vxlan

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008-ynl_rt_encap-v4-0-4ed2ccf7f949%40kylinos.cn
