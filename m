Received: from mta1.migadu.com (out-216.mta1.migadu.com [95.215.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE49451990
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 09:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789984028; cv=none; b=nTV72nmLdrDgmoB83G9GAPI/9JMifj+77i2FAaP7yshW/s6wK2POhCbOZQX3PbDccfUcetCgS+gobvENoctH5oqzLpC46hK8iEGxtVhiPTU5Lp1sLNYUVkIcpGkffObPWGWlKKLtYTOn6bQKd8VI24dpSGrPZTJebnf+317xshM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789984028; c=relaxed/simple;
	bh=wecnKx7LkqikUqo4Dhub5mbay8oFhGFKDyVeaaaa/eI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UrbSsZytx1l8vs39cfK17AQBYGLpwrHvRQqUt64m6obURJAQDceWgJMW6d4Nm2iclM/87npnqNDIxMJY+c6c2tVBp0aQwsRWynllQrME22K97EpILlwi9SisxLF2TRhEO8fhOzdWstRPTHCuP9VoRapDpcscFaYPt82EFVnoObE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rN34ZI90; arc=none smtp.client-ip=95.215.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rN34ZI90"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=wecnKx7LkqikUqo4Dhub5mbay8oFhGFKDyVeaaaa/eI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789984024; v=1; x=1790588824;
 b=rN34ZI905DK9iICF+c0JOplQeLL8kC+oEY4AyTZkst44seFX5tFrzRlfJRdT6aw/CZdtWLEj
 JZXSbLQE7XbPAFinreLa4b+amWUZHgCEQLTBVEJyZyi8u5F3Bg80z1mJ/MUsdoP5V+5ODGfuhXc
 5yUMy8s7ES/JCVzfNHuy/ZN8=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 04cc045a125c398a;
	Mon, 21 Sep 2026 09:47:04 +0000
X-Mizu-Trace-ID: 04cc045a125c398a
X-Migadu-Flow: FLOW_OUT
Date: Mon, 21 Sep 2026 17:46:46 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: netdev-bot+sashiko@kernel.org
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, donald.hunter@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	liuhangbin@kylinos.cn
Subject: Re: [PATCH net-next 5/6] netlink: specs: rt-route: describe lwt BPF
 program options
Message-ID: <arD89olLH_d2Y29A@fedora>
References: <20260917-ynl_rt_encap-v1-5-fbbe6e680571@kylinos.cn>
 <178997269710.2160803.17529308820161087653@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <178997269710.2160803.17529308820161087653@kernel.org>

On Mon, Sep 21, 2026 at 06:38:17AM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 1
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] Documentation/netlink/specs/rt-route.yaml re-points the
>   seg6-local `bpf` attribute (SEG6_LOCAL_BPF) at the newly added `lwt-…

Thanks, I will update the SEG6_LOCAL_BPF attrs in the seg6 update (patch 06).
in v3.

Hangbin

> - [Low] The new `lwt-bpf-prog` `name` attribute in
>   Documentation/netlink/specs/rt-route.yaml (lines 624-626) is declared…
> 
> --
> 
> netlink: specs: rt-route: describe lwt BPF program options
> 
> This changes the lwt-bpf in/out/xmit attributes and the seg6-local bpf
> attribute in Documentation/netlink/specs/rt-route.yaml from binary to a
> nest, and adds a new shared lwt-bpf-prog attribute set with fd and name
> members.
> 
> > diff --git a/Documentation/netlink/specs/rt-route.yaml b/Documentation/netlink/specs/rt-route.yaml
> > index 6030d7cb8d0d1..5e9537f7dfad4 100644
> > --- a/Documentation/netlink/specs/rt-route.yaml
> > +++ b/Documentation/netlink/specs/rt-route.yaml
> 
> [ ... ]
> 
> > @@ -503,7 +506,8 @@ attribute-sets:
> >          type: u32
> >        -
> >          name: bpf
> > -        type: binary
> > +        type: nest
> > +        nested-attributes: lwt-bpf-prog
> 
> [Severity: Medium]
> Should the seg6-local bpf attribute point at the lwt-bpf-prog set?  This
> attribute lives in the seg6-local set, which carries
> header: linux/seg6_local.h, but lwt-bpf-prog below uses
> name-prefix: lwt-bpf-prog-, so its members document and generate as
> LWT_BPF_PROG_FD / LWT_BPF_PROG_NAME.
> 
> Those identifiers come from linux/lwtunnel.h:
> 
>     enum {
>             LWT_BPF_PROG_UNSPEC,
>             LWT_BPF_PROG_FD,
>             LWT_BPF_PROG_NAME,
>             __LWT_BPF_PROG_MAX,
>     };
> 
> while the seg6-local nest is a separate uAPI namespace in
> linux/seg6_local.h:
> 
>     enum {
>             SEG6_LOCAL_BPF_PROG_UNSPEC,
>             SEG6_LOCAL_BPF_PROG,
>             SEG6_LOCAL_BPF_PROG_NAME,
>             __SEG6_LOCAL_BPF_PROG_MAX,
>     };
> 
> The values (1, 2) and payload types happen to coincide, so the wire format
> still decodes, but does this end up documenting SRv6 attributes with
> lwtunnel.h names?  There also seems to be no header: value that can be
> correct for a set shared between linux/lwtunnel.h and
> linux/seg6_local.h.
> 
> Would a separate seg6-local-bpf-prog set with
> header: linux/seg6_local.h be more accurate here?
> 
> Separately, the commit message says only:
> 
>     Replace binary BPF attributes with a nested lwt-bpf-prog to support
>     lwt bpf prog options.
> 
> Could it also mention that the seg6-local bpf attribute is being re-typed,
> since that is a different attribute space?
> 
> > @@ -610,6 +614,16 @@ attribute-sets:
> >        -
> >          name: hwid
> >          type: u8
> > +  -
> > +    name: lwt-bpf-prog
> > +    name-prefix: lwt-bpf-prog-
> > +    attributes:
> > +      -
> > +        name: fd
> > +        type: u32
> 
> [Severity: Medium]
> Is fd the right name for attribute 1 in both directions?  In requests
> parse_nla_bpf() in net/ipv6/seg6_local.c does treat it as a descriptor:
> 
>     fd = nla_get_u32(tb[SEG6_LOCAL_BPF_PROG]);
>     p = bpf_prog_get_type(fd, BPF_PROG_TYPE_LWT_SEG6LOCAL);
> 
> but on GET/dump put_nla_bpf() emits a program id, not a descriptor:
> 
>     if (nla_put_u32(skb, SEG6_LOCAL_BPF_PROG, slwt->bpf.prog->aux->id))
>             return -EMSGSIZE;
> 
> So a spec-driven decoder would print slwt->bpf.prog->aux->id under a field
> called fd, and feeding that value back into a request would resolve an
> unrelated descriptor or fail.  On the lwt-bpf side bpf_fill_lwt_prog() in
> net/core/lwt_bpf.c never emits attribute 1 at all and only puts
> LWT_BPF_PROG_NAME.
> 
> Would it be worth naming this member after the program reference/id, or at
> least documenting the id-versus-fd asymmetry?
> 
> Note this appears unchanged at the end of the series (30e3ec46f708 still
> has name: bpf with nested-attributes: lwt-bpf-prog and the fd member).
> 
> > +      -
> > +        name: name
> > +        type: string
> 
> [Severity: Low]
> Should this string carry a max-len?  Both kernel consumers of this nest
> bound it to MAX_PROG_NAME (256).
> 
> net/core/lwt_bpf.c:
> 
>     static const struct nla_policy bpf_prog_policy[LWT_BPF_PROG_MAX + 1] = {
>             [LWT_BPF_PROG_FD]   = { .type = NLA_U32, },
>             [LWT_BPF_PROG_NAME] = { .type = NLA_NUL_STRING,
>                                     .len = MAX_PROG_NAME },
>     };
> 
> net/ipv6/seg6_local.c:
> 
>     static const struct nla_policy bpf_prog_policy[SEG6_LOCAL_BPF_PROG_MAX + 1] = {
>             [SEG6_LOCAL_BPF_PROG]      = { .type = NLA_U32, },
>             [SEG6_LOCAL_BPF_PROG_NAME] = { .type = NLA_NUL_STRING,
>                                            .len = MAX_PROG_NAME },
>     };
> 
> As written the spec advertises an unbounded string, so tooling generated
> from it will build a request that the kernel rejects with -EINVAL.
> MAX_PROG_NAME is a private define in those two .c files, so the numeric
> bound would need to be spelled out in the spec, and max-len does not count
> the NUL terminator.
> 
> This is also still missing at the end of the series (30e3ec46f708).
> 
> >  
> >  operations:
> >    enum-model: directional
> 
> -- 
> Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917-ynl_rt_encap-v1-0-fbbe6e680571%40kylinos.cn
