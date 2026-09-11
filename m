Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B5C352022
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 15:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789139742; cv=none; b=Y4pHitOxwu5Le5rqurS1eBO9kDQTC5CwInKYeZEVX+kD7aOMA3PXEzGnNSfxyLi27GC135kacWLiywNk91uuiN6TOM1rcwQROxnMNF9u3zWVccg3gVKUi0SD/doEVKuYLVeP6KtAD62mdBENsV0xL4cVjMidJcFcRO8FovKe1/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789139742; c=relaxed/simple;
	bh=NRDP0MfR1Q68cCPKPCmZFquU1b+MMuT8gJHnevIbfDo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hicNzwr8XZlDT4qP6IIIXb1xHkWWrsaxFMwPDwZQTwtqI5zi2yUJwnrbbZxKUGmafT6sJqmR8QZYxzDOKC9svJJ8XVSCN9vgB5Too2W0XVjxI59/zW8n91reIxpSUwYX5u6iVkr8vIz7chFi/FWgdb19M0uwV02qzUO/KaSowXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SWZJQLCH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SWZJQLCH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B89271F00893;
	Fri, 11 Sep 2026 15:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789139739;
	bh=59hsyzU+rmq1Nt6YQA/XDUl3dLIgBQnV5WJH8EYxD5A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SWZJQLCHVXOwVgx9u/KkGr/sInXylrsK/fOdF8H31nwJ0wIjawxSphSL6Le97TGck
	 9WtxjBF3FuqqXmduAbYOGgvzq9s8RUsQ7cC2v6u8rnHKzOpF0R+72SUC7n2BiqrFsq
	 iUrQNb9eMU6bNWZWDqwQSAIcz7OM52/70FQVK2d0BIw7k8MTlwY99CWpYtUxNhJ0p4
	 YZAs5nhpih7tOggTvFNayp6BVJxwBoo7WvmiHVHAPbpzuK4jKnHDGiMeHgADjOfKX9
	 OXZTI8VHa/egh9nW2QvnHTo0Rs57lXHSnrxhC3ucmSHUN/DBo3wtABDZd5hYs8YUzk
	 u5Qck18jMbBqg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/13 net-next] net: fib: split common nexthop logic to
 fib_core.c
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fernando Fernandez Mancera" <fmancera@suse.de>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260910144914.8025-10-fmancera@suse.de>
References: <20260910144914.8025-1-fmancera@suse.de>
 <20260910144914.8025-10-fmancera@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 15:15:39 +0000
Message-Id: <20260911151539.B89271F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] Syntax error in `nh_netdev_event` when `CONFIG_IPV4` is enabled, ca=
using a build failure.
- [Low] Parameter name mismatch in the dummy inline function for `fib_nh_in=
it`.
--

commit 243925357332d15aa13a077472006e05019dde8d
Author: Fernando Fernandez Mancera <fmancera@suse.de>

net: fib: split common nexthop logic to fib_core.c

This commit creates fib_core.c and moves functions for common nexthop
initialization and release from fib_semantics.c to fib_core.c. This makes
shared FIB and nexthop logic accessible to IPv6 when the IPv4 routing
stack is omitted.

> diff --git a/include/net/ip_fib.h b/include/net/ip_fib.h
> index 0a35355fb0f33..4bbafb7b723f2 100644
> --- a/include/net/ip_fib.h
> +++ b/include/net/ip_fib.h
[ ... ]
> @@ -578,10 +584,23 @@ void fib_select_multipath(struct fib_result *res, i=
nt hash,
>  void fib_select_path(struct net *net, struct fib_result *res,
>  		     struct flowi4 *fl4, const struct sk_buff *skb);
> =20
> +#if IS_ENABLED(CONFIG_IPV4)
>  int fib_nh_init(struct net *net, struct fib_nh *fib_nh,
>  		struct fib_config *cfg, int nh_weight,
>  		struct netlink_ext_ack *extack);
>  void fib_nh_release(struct net *net, struct fib_nh *fib_nh);
> +#else
> +static inline int fib_nh_init(struct net *net, struct fib_nh *fib_nh,
> +			      struct fib_config *cfg, int gfp,
                                                              ^^^

[Severity: Low]
Does this code use the correct parameter name here? The actual definition of
fib_nh_init in the IPv4 block uses int nh_weight for the fourth parameter.
Using gfp in the stub obscures the API contract and might mislead developers
into passing a GFP flag instead of a routing weight.

> +			      struct netlink_ext_ack *extack)
> +{
> +	return -EAFNOSUPPORT;
> +}
[ ... ]
> diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
> index a7c2b8dced4e7..ea747fc2223c4 100644
> --- a/net/ipv4/nexthop.c
> +++ b/net/ipv4/nexthop.c
[ ... ]
> @@ -4004,8 +4005,12 @@ static int nh_netdev_event(struct notifier_block *=
this,
>  			nexthop_flush_dev(dev, event);
>  		break;
>  	case NETDEV_CHANGEMTU:
> +#if IS_ENABLED(CONFIG_IPV4)
> +		struct netdev_notifier_info_ext *info_ext;
> +
>  		info_ext =3D ptr;
>  		nexthop_sync_mtu(dev, info_ext->ext.mtu);
> +#endif

[Severity: Low]
Can this sequence cause a build failure when CONFIG_IPV4 is enabled? In C, a
case label cannot be immediately followed by a declaration. This causes a
compilation error because a label can only be part of a statement, and a
declaration is not a statement. Could we add a block or move the declaration
to avoid breaking the build?

>  		rt_cache_flush(dev_net(dev));
>  		break;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910144914.8025=
-1-fmancera@suse.de?part=3D9
