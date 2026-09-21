Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575783769EC;
	Mon, 21 Sep 2026 06:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789972699; cv=none; b=o6vuXrpX8CnHRomXy7FeRC2fyfiB7fXxovyyQJHgI2KgSMQC5Hs8Lxuqc18/wZ4eVFgrvKf9cRTPsUbv+DsOTVYcvuQcjcB1+Ve8Wp8IrgxJXe+e27sWfcDiUPvwCG7UklszrW0aQFRC/D2UewmY2Pg4UchRWacjg3LSkjg3Y+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789972699; c=relaxed/simple;
	bh=yFa/pWit/bgrQcnt62i2V3ruPnufvNyT2VBsdeAqpaU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OU3Rga/OlHQ2frxVZte+h0ERk/g71+BR9mG8eXiDFBoPI2xZJTl9aWY6c6vje0KT74Of5l6o95DJRzDHKrQ1DbbrgeeKf1jE6908W0P8Iz8QsjS8Lnma0LjHqLR6DxwDbYBv7krooJo4P90N5cb8kvbMym6iId21Vv3BQmlyjP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ss3RPqB+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ss3RPqB+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 879761F00898;
	Mon, 21 Sep 2026 06:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789972698;
	bh=CnRV4/8eXR4AZCnTAs6GV4SWtwt9joY3zU+v5LW5Pdg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Ss3RPqB+/CHaRZRC8v0zPqtRZcKB8ZaPVkn/wJszQ1aI03B8nTb1s4ihB3Pvxar7c
	 CwpjxPe8mf8g++ZFfryKjwMbWLh0wdmL6JxJwTR5vDYQyNjp136kkJ6nP0ynAuPARh
	 nHX5I7K0HAm46d8pu5jfWf6QZ3eUd07wESa96cJeu0eMv53nJ7umCt7MU7VyvbuSDN
	 n9Hwus6BMxjSTZpCZ0cjOpuOZc4nXa3e68eqvCqDYfQ9+XIFokA1/y7OkmBEURgD/g
	 mvfAGF671YuKhP2yGz/xZ1++0d14m5eHTruOxoLNgoVsbi/Y+hHyxW7wFwCjdtMKKf
	 rMfd6CQlrasoA==
Subject: Re: [PATCH net-next 5/6] netlink: specs: rt-route: describe lwt BPF
 program options
From: netdev-bot+sashiko@kernel.org
To: hangbin.liu@linux.dev
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 donald.hunter@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, liuhangbin@kylinos.cn
Date: Mon, 21 Sep 2026 06:38:17 +0000
Message-ID: <178997269710.2160803.17529308820161087653@kernel.org>
In-Reply-To: <20260917-ynl_rt_encap-v1-5-fbbe6e680571@kylinos.cn>
References: <20260917-ynl_rt_encap-v1-5-fbbe6e680571@kylinos.cn>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Documentation/netlink/specs/rt-route.yaml re-points the
  seg6-local `bpf` attribute (SEG6_LOCAL_BPF) at the newly added `lwt-…
- [Low] The new `lwt-bpf-prog` `name` attribute in
  Documentation/netlink/specs/rt-route.yaml (lines 624-626) is declared…

--

netlink: specs: rt-route: describe lwt BPF program options

This changes the lwt-bpf in/out/xmit attributes and the seg6-local bpf
attribute in Documentation/netlink/specs/rt-route.yaml from binary to a
nest, and adds a new shared lwt-bpf-prog attribute set with fd and name
members.

> diff --git a/Documentation/netlink/specs/rt-route.yaml b/Documentation/netlink/specs/rt-route.yaml
> index 6030d7cb8d0d1..5e9537f7dfad4 100644
> --- a/Documentation/netlink/specs/rt-route.yaml
> +++ b/Documentation/netlink/specs/rt-route.yaml

[ ... ]

> @@ -503,7 +506,8 @@ attribute-sets:
>          type: u32
>        -
>          name: bpf
> -        type: binary
> +        type: nest
> +        nested-attributes: lwt-bpf-prog

[Severity: Medium]
Should the seg6-local bpf attribute point at the lwt-bpf-prog set?  This
attribute lives in the seg6-local set, which carries
header: linux/seg6_local.h, but lwt-bpf-prog below uses
name-prefix: lwt-bpf-prog-, so its members document and generate as
LWT_BPF_PROG_FD / LWT_BPF_PROG_NAME.

Those identifiers come from linux/lwtunnel.h:

    enum {
            LWT_BPF_PROG_UNSPEC,
            LWT_BPF_PROG_FD,
            LWT_BPF_PROG_NAME,
            __LWT_BPF_PROG_MAX,
    };

while the seg6-local nest is a separate uAPI namespace in
linux/seg6_local.h:

    enum {
            SEG6_LOCAL_BPF_PROG_UNSPEC,
            SEG6_LOCAL_BPF_PROG,
            SEG6_LOCAL_BPF_PROG_NAME,
            __SEG6_LOCAL_BPF_PROG_MAX,
    };

The values (1, 2) and payload types happen to coincide, so the wire format
still decodes, but does this end up documenting SRv6 attributes with
lwtunnel.h names?  There also seems to be no header: value that can be
correct for a set shared between linux/lwtunnel.h and
linux/seg6_local.h.

Would a separate seg6-local-bpf-prog set with
header: linux/seg6_local.h be more accurate here?

Separately, the commit message says only:

    Replace binary BPF attributes with a nested lwt-bpf-prog to support
    lwt bpf prog options.

Could it also mention that the seg6-local bpf attribute is being re-typed,
since that is a different attribute space?

> @@ -610,6 +614,16 @@ attribute-sets:
>        -
>          name: hwid
>          type: u8
> +  -
> +    name: lwt-bpf-prog
> +    name-prefix: lwt-bpf-prog-
> +    attributes:
> +      -
> +        name: fd
> +        type: u32

[Severity: Medium]
Is fd the right name for attribute 1 in both directions?  In requests
parse_nla_bpf() in net/ipv6/seg6_local.c does treat it as a descriptor:

    fd = nla_get_u32(tb[SEG6_LOCAL_BPF_PROG]);
    p = bpf_prog_get_type(fd, BPF_PROG_TYPE_LWT_SEG6LOCAL);

but on GET/dump put_nla_bpf() emits a program id, not a descriptor:

    if (nla_put_u32(skb, SEG6_LOCAL_BPF_PROG, slwt->bpf.prog->aux->id))
            return -EMSGSIZE;

So a spec-driven decoder would print slwt->bpf.prog->aux->id under a field
called fd, and feeding that value back into a request would resolve an
unrelated descriptor or fail.  On the lwt-bpf side bpf_fill_lwt_prog() in
net/core/lwt_bpf.c never emits attribute 1 at all and only puts
LWT_BPF_PROG_NAME.

Would it be worth naming this member after the program reference/id, or at
least documenting the id-versus-fd asymmetry?

Note this appears unchanged at the end of the series (30e3ec46f708 still
has name: bpf with nested-attributes: lwt-bpf-prog and the fd member).

> +      -
> +        name: name
> +        type: string

[Severity: Low]
Should this string carry a max-len?  Both kernel consumers of this nest
bound it to MAX_PROG_NAME (256).

net/core/lwt_bpf.c:

    static const struct nla_policy bpf_prog_policy[LWT_BPF_PROG_MAX + 1] = {
            [LWT_BPF_PROG_FD]   = { .type = NLA_U32, },
            [LWT_BPF_PROG_NAME] = { .type = NLA_NUL_STRING,
                                    .len = MAX_PROG_NAME },
    };

net/ipv6/seg6_local.c:

    static const struct nla_policy bpf_prog_policy[SEG6_LOCAL_BPF_PROG_MAX + 1] = {
            [SEG6_LOCAL_BPF_PROG]      = { .type = NLA_U32, },
            [SEG6_LOCAL_BPF_PROG_NAME] = { .type = NLA_NUL_STRING,
                                           .len = MAX_PROG_NAME },
    };

As written the spec advertises an unbounded string, so tooling generated
from it will build a request that the kernel rejects with -EINVAL.
MAX_PROG_NAME is a private define in those two .c files, so the numeric
bound would need to be spelled out in the spec, and max-len does not count
the NUL terminator.

This is also still missing at the end of the series (30e3ec46f708).

>  
>  operations:
>    enum-model: directional

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917-ynl_rt_encap-v1-0-fbbe6e680571%40kylinos.cn
