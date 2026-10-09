Received: from mta0.migadu.com (out-250.mta0.migadu.com [91.218.175.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0008441F5E6
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 09:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791538849; cv=none; b=NuzbH5GRNbeX3rwBaGnmboL9fNz+uBJTwNyQOCA7TJQKoc126HO5iZzQMdL83yxSg7RPpmOUhvtSGY3DauKpT/+HPIKqu8QINIB6wRdZGvy3Vq7Vatllzj1fi08pD6ntqkftAtnCxymlw5U0MgeqcRpBzRaYHSZRX2EOWtBIP5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791538849; c=relaxed/simple;
	bh=xVrnhRmotXNnJn/Ot+2DF2PbMo6NgLhFJQaiiZmxOfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bD+nFP3GcHgk16QOWOh4xl2WUQ6Hg4xBH/JJ/3VeeAH5p1W9wDnpeHAjAOG0ev5E4nqDtKuHem6umEZRfLEXrwhjZzDdopvZEEF9T+WTiN4Xg9/bBkLtkrssfxt8rxvqdO2mdrZMQoMYa96UnWzPZxoWM2LhJ9iECwDm17N2NAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TDyQVfFG; arc=none smtp.client-ip=91.218.175.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TDyQVfFG"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=xVrnhRmotXNnJn/Ot+2DF2PbMo6NgLhFJQaiiZmxOfo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791538840; v=1; x=1792143640;
 b=TDyQVfFGaIP1LjsAXdzexZspOMyXtLYh0qJmN+uOphvzPuZURGpoCnqCEzLXjADqOEhGyT4h
 bikxxFvWf5nUW3JGxI8aSNE1pQPcaR/7MyNgzddLvkC2mZMr2r4Z5rXxGDmDG1qV52kq1F4b3Tp
 jYMFtyUqgtiBgPBx6g1JYGas=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id fc0f941f014be6ba;
	Fri, 09 Oct 2026 09:40:36 +0000
X-Mizu-Trace-ID: fc0f941f014be6ba
X-Migadu-Flow: FLOW_OUT
Date: Fri, 9 Oct 2026 17:40:23 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: netdev-bot+sashiko@kernel.org
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	donald.hunter@gmail.com, edumazet@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, liuhangbin@kylinos.cn
Subject: Re: [PATCH net-next v4 2/6] tools: ynl: convert enum selector to
 string for sub-message parsing
Message-ID: <asi2h4Rd7f4FXo1s@fedora>
References: <20261008-ynl_rt_encap-v4-2-4ed2ccf7f949@kylinos.cn>
 <179153681840.434549.374414508868008982@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179153681840.434549.374414508868008982@kernel.org>

On Fri, Oct 09, 2026 at 09:06:58AM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential
> issue(s) to consider.
> 
> Critical: 0 � High: 0 � Medium: 2 � Low: 2
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] An unknown enum selector value now aborts the whole message or
>   dump.
> - [Medium] The new enum-to-string conversion ignores byte order.
> - [Low] When the enum lookup fails, the error message is misleading.
> - [Low] The generator now produces working response parsing for enum-
>   keyed sub-messages.
> 
> --
> 
> tools: ynl: convert enum selector to string for sub-message parsing
> 
> This patch changes the YNL C code generator for sub-messages keyed by a
> non-external enum selector. The integer selector value is converted to a
> string with the family's {enum}_str() helper before the sub-message parse
> function is called. A missing selector or a failed enum lookup is
> reported through ynl_submsg_failed().
> 
> > diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
> > index 15c79849c6096..4aca51396a9e2 100755
> > --- a/tools/net/ynl/pyynl/ynl_gen_c.py
> > +++ b/tools/net/ynl/pyynl/ynl_gen_c.py
> > @@ -951,13 +951,31 @@ class TypeSubMessage(TypeNest):
> 
> [ ... ]
> 
> > +        if self.selector.is_enum_val() and not self.selector.is_external():
> > +            enum = self.family.consts[self.selector.get_enum_name()]
> > +            pres_var = f"{var}->_present.{sel}"
> > +            parse_sel = f"{sel}_str"
> > +            local_vars = [f'const char *{parse_sel};']
> > +
> > +            get_lines = [
> > +                f'if (!{pres_var})',
> > +                f'return ynl_submsg_failed(yarg, "{self.name}", "{selector}");',
> > +                f'{parse_sel} = {enum.render_name}_str({sel_var});',
> 
> [Severity: Medium]
> Does this handle selectors declared with byte-order: big-endian?

This doesn't affect the current series. The encap-type selector is
type: u16 with no byte-order specified (native order), so the raw value
passed to _str() is already host-order. nftables is in GENS_UNSUP today,
so no in-tree generated family hits this yet. We address this as a follow-up.

> 
> TypeScalar._attr_get() loads the value in {sel_var} with a plain
> ynl_attr_get_u32() or ynl_attr_get_u16(), which is a native load. In
> TypeScalar.__init__(), byte-order only becomes a C comment through
> byte_order_comment. The struct member therefore holds the value in wire
> order.
> 
> On a little-endian host, a big-endian selector value of 1 arrives as
> 0x01000000. That fails the range check in the generated {enum}_str():
> 
>     if (value < 0 || value >= (int)YNL_ARRAY_SIZE(map))
>         return NULL;
> 
> So every sub-message would fail with "enum-lookup-failed".
> 
> This combination already exists in-tree. obj-attrs in
> Documentation/netlink/specs/nftables.yaml has:
> 
>     name: type
>     type: u32
>     enum: object-type
>     byte-order: big-endian
>     ...
>     name: data
>     type: sub-message
>     sub-message: obj-data
>     selector: type
> 
> nftables is listed in GENS_UNSUP in tools/net/ynl/generated/Makefile, so
> the default build does not generate it.
> 
> Before this patch, though, the generator passed the u32 as the
> const char *sel argument, which failed at compile time. Now it silently
> emits code that cannot decode these sub-messages.
> 
> Should the conversion normalize the byte order first, or should the
> generator reject such specs?
> 
> Because of obj-attrs, the note below the commit message saying rt-route
> encap is "the first enum-keyed sub-message in the YNL specs" also does
> not seem accurate.
> 
> > +                f'if (!{parse_sel})',
> > +                f'return ynl_submsg_failed(yarg, "{self.name}", "enum-lookup-failed");']
> 
> [Severity: Medium]
> Is it intended that an unknown enum value aborts the whole message or
> dump?

Yes, this is intended. The same with string lookup fails.

> 
> ynl_submsg_failed() always returns YNL_PARSE_CB_ERROR.
> ynl_dump_trampoline() passes that up, and __ynl_sock_read_msgs() stops
> processing.
> 
> The string selector path behaves differently. parse_rsp_submsg() emits a
> strcmp() chain that ends in return 0. An unknown string key, such as a
> new rt-link kind, is skipped and parsing continues.
> 
> The enum path is also inconsistent within itself. A value that is in the
> enum but has no formats entry falls through the strcmp() chain and
> returns 0. A value outside the enum is a hard error.
> 
> Take the rt-route spec from this series. If a future kernel adds a new
> LWTUNNEL_ENCAP_* type, wouldn't the generated client fail the entire
> route dump as soon as one route uses that encap? Leaving the encap
> undecoded would match the rest of YNL.
> 
> The commit message says:
> 
>     or a new encap_type is missing from the spec file in future kernel,
>     the code will report "Sub-message key not set", the same with string
>     lookup fails.
> 
> This doesn't match the string path, which skips unknown keys silently.

The string patch used to failed like

	if (!{sel_var})
		return ynl_submsg_failed(yarg, "{self.name}", "{selector}");

> 
> Could this skip the sub-message instead, leaving it unset and returning
> success, when the enum lookup misses?

Jakub has suggested to use the current way other than *continue* to skip.

Thanks
Hangbin

> 
> [Severity: Low]
> Is "enum-lookup-failed" the right value for the selector name argument?
> ynl_submsg_failed() always uses this format with YNL_ERROR_SUBMSG_KEY:
> 
>     "Parsing error: Sub-message key not set (msg %s, key %s)"
> 
> The user would see "Sub-message key not set (msg encap, key
> enum-lookup-failed)". In this case the key was present but held an
> unknown value.
> 
> The message also loses the real selector name (encap-type) and does not
> report the numeric value that failed. To the caller, this looks the same
> as a missing selector.
> 
> > +        else:
> > +            parse_sel = sel_var
> 
> [ ... ]
> 
> > @@ -979,6 +997,12 @@ class Selector:
> >      def is_external(self):
> >          return self._external
> >  
> > +    def is_enum_val(self):
> > +        return self.get_enum_name() is not None
> > +
> > +    def get_enum_name(self):
> > +        return self.attr and self.attr.attr.get("enum")
> > +
> 
> [Severity: Low]
> Response parsing now supports enum selectors. Should the policy side be
> addressed, or at least documented? TypeSubMessage._attr_typol() still
> says:
> 
>     # Reverse-parsing of the policy (ynl_err_walk() in ynl.c) does not
>     # support external selectors. No family uses sub-messages with external
>     # selector for requests so this is fine for now.
> 
> Only TypeString._attr_typol() emits .is_selector = 1.
> TypeScalar._attr_typol() emits only .type = YNL_PT_U<N>, so the u16
> encap-type selector never gets the flag.
> 
> As a result, ynl_err_walk_is_sel() never records the selector. For any
> extack offset inside RTA_ENCAP, ynl_err_walk_report_one() then reaches
> this code and the attribute path is cut off at .encap:
> 
>     if (!selector) {
>         if (*n < str_sz)
>             *n += snprintf(str, str_sz, "(!selector)");
>         return 1;
>     }
> 
> For NLMSGERR_ATTR_MISS_NEST inside the encap nest, ynl_ext_ack_check()
> leaves nest_pol at the outer route-attrs policy. The missing attribute
> would then be named from the wrong policy.
> 
> newroute and delroute requests carry encap. The kernel does return
> extack offsets inside RTA_ENCAP, for example NL_SET_ERR_MSG_ATTR on
> tb[IOAM6_IPTUNNEL_*] in net/ipv6/ioam6_iptunnel.c.
> 
> ynl_err_walk_sel_policy() also assumes a string selector
> (ynl_attr_get_str() plus strcmp()). It would need enum-to-string support
> before is_selector could be set for scalar selectors.
> 
> The note below the commit message says this will be a follow-up. Could
> the comment in _attr_typol() be updated to mention the enum/integer
> selector limitation too?
> 
> -- 
> Sashiko AI review � https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008-ynl_rt_encap-v4-0-4ed2ccf7f949%40kylinos.cn
