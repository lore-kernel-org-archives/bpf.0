Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A44499F12;
	Fri,  9 Oct 2026 09:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791536825; cv=none; b=kXd29feHv88LNGt4pZ6XQNoPW3I3lG1PDBqflWt4bc9KliRR78tK6DhOrQWPgbD5AEBCE2P5XooO4pQyRJ4oqpjOQ2PgqlTJWykDul4zA8APhNGTcl4DPB32svWMVq3eC9zwDGvLOFwChrWbj8O486StTurqzw+N3vtpkYbIbxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791536825; c=relaxed/simple;
	bh=qVJTSCmnvwP0xl3HpgRFX86avfXk/dJkVX+ou6etAL0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XWPZUfRta3Qs3o0AdXWO5lKdbQVwkSTYKuj/8bYqopvYAaNbZqEZ43dbdxE30Ilbt3pjx+9rNDBFOCLjKCtFSSUB/L0e0vANT39TSHRrU48UZvG0CMsUBXkf2lOd6Z4KsYPCSXLo45V+0M/iEgygXjwkaXUyUnQJPunXiDz0MPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DjKZ5In2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DjKZ5In2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F7A21F00893;
	Fri,  9 Oct 2026 09:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791536821;
	bh=9fyQ498Nae3a4HPivKpgSD6ynmH4JbNHaYkzxCeBQcE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=DjKZ5In24zUcmS4YSwGsJeRrJEM2TemxXqQWAAMw5olC4URwBLCJP5EQKCjWggWlG
	 O+gBlSJquVEmH77kqKcLpvaWl1cI4JJuI6/Ysi9lmvw0INxtAHAU9dz33S6ADjW4kx
	 tcbEHGal3pwPyOiAU6HmvNojCEUhsES8CHNRD4Ufld19R7B+Q4HDHJ03wheovpR93G
	 N8DCXbyGxofD+u04qvMCevSM11W0pjo1YCdNFQHSRvhGfUOGSvnlOTaeVQDdtQhL8G
	 0XekC5mdiKGS5gFTGjwnyNdoH/mtGFsE0JmGWgz6yCiQ8PI700CUGDYfMW9MCDhNga
	 Fu4LqbCz8LMBA==
Subject: Re: [PATCH net-next v4 3/6] netlink: specs: rt-route: add lwtunnel
 encap sub-message support
From: netdev-bot+sashiko@kernel.org
To: hangbin.liu@linux.dev
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, donald.hunter@gmail.com,
 edumazet@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, liuhangbin@kylinos.cn
Date: Fri, 09 Oct 2026 09:06:59 +0000
Message-ID: <179153681978.434549.5170231095959857964@kernel.org>
In-Reply-To: <20261008-ynl_rt_encap-v4-3-4ed2ccf7f949@kylinos.cn>
References: <20261008-ynl_rt_encap-v4-3-4ed2ccf7f949@kylinos.cn>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] rt-route is the first C-generated family whose sub-message
  selector is an integer enum (`encap-type`, u16) rather than a string;…
- [Low] Generated C parsing of route messages fails hard when
  RTA_ENCAP_TYPE carries a value outside the spec's `encap-type` enum…

--

netlink: specs: rt-route: add lwtunnel encap sub-message support

This commit adds an encap-type enum for the LWTUNNEL_ENCAP_* values. It
turns the rt-route encap attribute into a sub-message keyed on encap-type
and adds attribute sets for each lwtunnel type. It also updates
Makefile.deps to pull in the matching uapi headers.

> diff --git a/Documentation/netlink/specs/rt-route.yaml b/Documentation/netlink/specs/rt-route.yaml
> index 253037ea5176a..dc842a786794a 100644
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
What happens in generated C clients when the kernel reports an encap type
that is not in this list?

For an enum selector, TypeSubMessage._attr_get() in ynl_gen_c.py (added
earlier in this series) generates:

    encap_type_str = rt_route_encap_type_str(dst->encap_type);
    if (!encap_type_str)
        return ynl_submsg_failed(yarg, "encap", "enum-lookup-failed");

The generated _str() helper returns NULL for any value past the end of its
string map. lwtunnel_fill_encap() emits RTA_ENCAP_TYPE and then RTA_ENCAP
for any type up to LWTUNNEL_ENCAP_MAX.

Suppose a future kernel adds a new LWTUNNEL_ENCAP_* value. Would a single
route using that type make a C client built from this spec fail the whole
getroute dump, or fail to parse the notification?

String selectors behave differently. parse_rsp_submsg() ends its strcmp()
chain with return 0, so an unknown format is skipped. The generated parsers
also ignore unknown attribute types.

The earlier commit message in the series says this case behaves "the same
with string lookup fails". Is that accurate? Unknown string selector values
are skipped, not reported as errors.

[ ... ]

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

[Severity: Low]
Can the C library's extack walker resolve error offsets inside RTA_ENCAP
when the selector is a u16?

rt-route looks like the first C-generated family whose sub-message selector
is an integer enum instead of a string. nftables also uses an enum
selector, but it is in GENS_UNSUP.

Selector.__init__ in ynl_gen_c.py sets attr.is_selector = True on
encap-type. However, only TypeString._attr_typol() turns that into the
policy flag:

    def _attr_typol(self):
        typol = '.type = YNL_PT_NUL_STR, '
        if self.is_selector:
            typol += '.is_selector = 1, '
        return typol

TypeScalar._attr_typol() only emits .type = YNL_PT_U16, so ynl_err_walk()
never records a selector for RTA_ENCAP.

Both newroute and delroute requests list encap-type and encap. If the
kernel returns NLMSGERR_ATTR_OFFS pointing at or inside RTA_ENCAP,
ynl_err_walk_report_one() stops here:

    if (policy->table[type].is_submsg) {
        if (!selector) {
            if (*n < str_sz)
                *n += snprintf(str, str_sz, "(!selector)");
            return 1;
        }

The user would see something like ".encap(!selector)" instead of
".encap(mpls).dst".

Setting .is_selector for scalars would not be enough by itself, because
ynl_err_walk_sel_policy() reads the selector as a string:

    sel = ynl_attr_get_str(selector);
    for (i = 0; i <= policy->max_attr; i++) {
        if (!strcmp(sel, policy->table[i].name))

That cannot match a 2-byte u16 payload.

The series patch "tools: ynl: convert enum selector to string for
sub-message parsing" updated the parse path but not this error-walk path.
Should the error walker also convert enum selectors to strings?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008-ynl_rt_encap-v4-0-4ed2ccf7f949%40kylinos.cn
