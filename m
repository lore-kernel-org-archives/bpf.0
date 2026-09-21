Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED8035DA53;
	Mon, 21 Sep 2026 06:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789972696; cv=none; b=jxssQXfjXY+4lrovcF4DdGDDNP9e3c79C8yXECoXqNoqX/ugqH3VW8thoZWv2Lf1ndVLzcdZMDOg8dYM//aoWdNbub9ITzp/t2nC/IeNJsIzxpn4Hfulto6+ksYn3dRnklM0FqN5+ohbXTfWWcnU9efo83W9ic3qD+wqeEaB1GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789972696; c=relaxed/simple;
	bh=9LXOEnadHB6MKT55282v68I53VQBFCobQV0duWpxEcc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u6YoM8/sqP1ht4j2+1lmv8T4lUDybPNsVF+3TEmEu7uL3GWXhQewtNBYzH3b8tlzk42oH0mdiJ8HeYPsxOjRMQbAYYxftvf6nPMtgV2SPhiVZ4ql7UTJD5iverH5rxBcfK9337AKRZPHL+m9Rd98yk6RhMrKs9WFxr7bzF1o5S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lLyaN7Ab; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLyaN7Ab"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD7D61F00898;
	Mon, 21 Sep 2026 06:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789972694;
	bh=2b4B/9uHCohMAF8ErJtQg3a/2sJrQvg6JASp4KDq+tg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lLyaN7AbpjCB4nZwJ3fkx5K+ifVORRQibFDu8d9r7gFBASOhOoSw3RiVgWWb5BsBf
	 ho80aH9bnMIXMngLGYXeWunw+t9Lmp0UVK7v1E4BLAC9XG6VM4GIVNKzHhc8VqXQkz
	 RTPTn+/b7vHBefPOUwN64NTzyFu50XWCeGNLPSY4ffvF4xG/Bc1jmrC4MZxzRHDvPV
	 Zyu5BfIBfZye9h+LKsYWY/JjOGFz4D1zhMWN4PqykboqF8oh+TBtReocY/5LwVq3ot
	 k/vet9lvCR0uNXz4RuS0vC0UlAYBjWng+prS68Db6fURMC8E/bKOkGG+DYKRu64O6F
	 IKAJeU6RX4V3w==
Subject: Re: [PATCH net-next 2/6] tools: ynl: convert enum selector to string
 for sub-message parsing
From: netdev-bot+sashiko@kernel.org
To: hangbin.liu@linux.dev
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 donald.hunter@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, liuhangbin@kylinos.cn
Date: Mon, 21 Sep 2026 06:38:13 +0000
Message-ID: <178997269335.2160803.5260665648782805568@kernel.org>
In-Reply-To: <20260917-ynl_rt_encap-v1-2-fbbe6e680571@kylinos.cn>
References: <20260917-ynl_rt_encap-v1-2-fbbe6e680571@kylinos.cn>
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

- [Medium] TypeSubMessage._attr_get()
  (tools/net/ynl/pyynl/ynl_gen_c.py:955-964) now emits…
- [Low] On the numeric/enum selector path newly enabled by this patch,
  TypeSubMessage._attr_get() keeps the guard `if (!{sel_var})` / `return…
- [Low] Concern raised: the patch should carry a Fixes: tag pointing at
  b9e03e263610 ("tools: ynl-gen: submsg: support parsing and rendering…

--

tools: ynl: convert enum selector to string for sub-message parsing

For non-external sub-message selectors that carry an enum, the generator now
wraps the selector value in the family's {enum}_str() helper before handing it
to the generated sub-message parser, so that the parser's strcmp() gets a
string instead of an integer.

A couple of questions about the generated code below.

> diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
> index 2b3483db1b60c..45bd7bc834b49 100755
> --- a/tools/net/ynl/pyynl/ynl_gen_c.py
> +++ b/tools/net/ynl/pyynl/ynl_gen_c.py
> @@ -951,9 +951,17 @@ class TypeSubMessage(TypeNest):
>              sel_var = f"_sel_{sel}"
>          else:
>              sel_var = f"{var}->{sel}"
> +
> +        parse_sel = sel_var
> +        if not self.selector.is_external() and self.selector.attr and \
> +           "enum" in self.selector.attr.attr:
> +            enum_name = self.selector.attr.attr["enum"]
> +            str_fn = c_lower(self.family.ident_name + "-" + enum_name) + "_str"
> +            parse_sel = f"{str_fn}({sel_var})"
> +
>          get_lines = [f'if (!{sel_var})',
>                       f'return ynl_submsg_failed(yarg, "{self.name}", "{selector}");',

[Severity: Low]
On this newly enabled path sel_var is a scalar struct member such as
dst->encap_type, not a string pointer, so the retained guard emits:

	if (!dst->encap_type)
		return ynl_submsg_failed(yarg, "encap", "encap-type");

For a string selector that test meant "attribute absent". For an integer
selector, is it able to distinguish an absent attribute (calloc'ed struct)
from an attribute that is present with enum value 0?

The presence bit is already recorded by the generated parser, since
Type.attr_get() emits:

	dst->_present.<attr> = 1;

Would testing dst->_present.<sel> be more appropriate here?

I checked the in-tree specs and no sub-message format is currently keyed on
the enum entry whose value is 0 (rt-route encap-data formats start at mpls =
1, nftables obj-data formats start at counter = 1), so this looks latent
today. The Python decoder in tools/net/ynl/pyynl/lib/ynl.py
(_resolve_selector) performs no such zero-value rejection, so the two ynl
implementations would also disagree for such a spec.

> -                     f"if ({self.nested_render_name}_parse(&parg, {sel_var}, attr))",
> +                     f"if ({self.nested_render_name}_parse(&parg, {parse_sel}, attr))",

[Severity: Medium]
Can the return value of the {enum}_str() helper be NULL here?  The helper
emitted by _put_enum_to_str_helper() is:

	const char *rt_route_encap_type_str(enum rt_route_encap_type value)
	{
		if (value < 0 || value >= (int)YNL_ARRAY_SIZE(rt_route_encap_type_strmap))
			return NULL;
		return rt_route_encap_type_strmap[value];
	}

so it returns NULL for any value outside the spec's enum range, and returns a
NULL table slot for a sparse enum with holes.

The generated sub-message parser from parse_rsp_submsg() dereferences the
selector as its very first action:

	if (!strcmp(sel, "mpls"))

The only guard in front of it tests the integer sel_var, not the returned
pointer, so is there anything preventing strcmp(NULL, "mpls") here?

With the rt-route lwtunnel encap sub-message spec added later in this series
(encap-type u16 with enum encap-type, selecting encap-data), the generated
code becomes:

	rt_route_encap_data_parse(&parg, rt_route_encap_type_str(dst->encap_type), attr)

The value comes from the kernel, and __ynl_attr_validate() in
tools/net/ynl/lib/ynl.c only checks the payload length for YNL_PT_U16, so an
RTA_ENCAP_TYPE value the generated code does not know about (for example a
new LWTUNNEL_ENCAP_* added by a kernel newer than the headers the code was
generated against, as happened for RPL, IOAM6 and XFRM) would reach the
helper unchecked.  Would that crash the ynl-based user-space program?

For comparison, on the pre-existing string-selector path (rt-link and tc
kind), an unrecognized selector simply falls through every else if and the
generated parser returns 0.  Does this change turn that benign no-match into
a NULL dereference?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917-ynl_rt_encap-v1-0-fbbe6e680571%40kylinos.cn
