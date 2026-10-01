Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504C647DD7B
	for <bpf@vger.kernel.org>; Thu,  1 Oct 2026 14:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790863509; cv=none; b=cUGkk1//LboG0M4Z1GcK0Q6CGar1auhOzFgCfFbiukMAZsxDGvgeA386LMAn+4FZDvjwiqKMF+bh8kKONOtv5xQt+LH6HqdBbyJ1xt6UIaSIZwsriRKL2JEKI6N8+Kq4rR8kuM8BvuuXKs/256JWSVO/oj9iCgDnbr9zuozVIAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790863509; c=relaxed/simple;
	bh=5aGR/8tUpKqRkeSyUuG2N8y/7QkT31tZhP7nw3z0THU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jhwBTaKe0IxsX2mEKze4G0u/wx5sK/BXBB8c14prAn/vfg2pe0SoXGvpjkWiD31UnnDUZVbOncnJV9WQCOUFUwTKDdpjDakE0Qhdu1QAJmvN4Rp54PQskF1L4aXjV6OJbt0Nb/GgKs9AR+z9lOYCibP7HfMDtiqg6EFKs64bz+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AgdtMaeQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AgdtMaeQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5C4E1F00898;
	Thu,  1 Oct 2026 14:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790863508;
	bh=G6R7SfO3+UHfBlAzZxj5mft1zfDUyoCGC8t1d6lbpj4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AgdtMaeQLFQKvyaJlMil25NPPaJXyTSO5+sGCFKHNUrt/sMr4wipr2yK2Vbjij0V8
	 Co5//eLAB13IdAw1XuY+/urF1cpFmaxS3E0NHKcpmZlvX5pEPq3mu5ay0Hxoggv2jQ
	 etJctBBA9SjMUH7xQnBReveAtcsed4PCYQEUeZCPpL362QNmOTcWRhBxGyrC408fBU
	 Wxgua7+0ZaHZM2lxbiL4G3UqNa0YpfacL+qjOax07pWq2YiJzqlptM5Y5XfUREiAxe
	 bdMIVbKikIn3opEF/QHvJvdNtA/Bj0nwth2pfPxxS2ud7T5exKqiN2fvUZ2aQuKXmq
	 ewFZx9nQ5X04Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/16 net-next v3] ipv4: fib: split common nexthop logic
 to fib_core.c
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fernando Fernandez Mancera" <fmancera@suse.de>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260930135334.4739-10-fmancera@suse.de>
References: <20260930135334.4739-1-fmancera@suse.de>
 <20260930135334.4739-10-fmancera@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 14:05:07 +0000
Message-Id: <20261001140507.C5C4E1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] net: build failure due to missing IPv4 nexthop stubs
--

commit 37eb694c7118e7af349ed67aa655f6c7aa572300
Author: Fernando Fernandez Mancera <fmancera@suse.de>

ipv4: fib: split common nexthop logic to fib_core.c

To enable compiling INET subsystem without IPv4, shared FIB and nexthop
logic must be accessible to IPv6 when IPv4 routing stack is omitted.

This patch creates fib_core.c and move all the functions for common
nexthop initialization and release from fib_semantics.c to fib_core.c.
Note that fib_core.c is under net/core.

> diff --git a/include/net/ip_fib.h b/include/net/ip_fib.h
> index 0a35355fb0f33..6058e53fa3dec 100644
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
> +			      struct fib_config *cfg, int nh_weight,
> +			      struct netlink_ext_ack *extack)
> +{
> +	return -EAFNOSUPPORT;
> +}
> +
> +static inline void fib_nh_release(struct net *net, struct fib_nh *fib_nh)
> +{
> +}
> +#endif

[Severity: Low]
When CONFIG_IPV4 is disabled, fib_check_nh() and fib_info_update_nhc_saddr()
are missing fallbacks.

Because net/ipv4/nexthop.c is unconditionally built for CONFIG_INET, its
nh_create_ipv4() function still references these functions, causing a build
failure at link time:

net/ipv4/nexthop.c:nh_create_ipv4() {
    ...
	/* sets nh_dev if successful */
	err =3D fib_check_nh(net, fib_nh, tb_id, 0, extack);
	if (!err) {
		nh->nh_flags =3D fib_nh->fib_nh_flags;
		fib_info_update_nhc_saddr(net, &fib_nh->nh_common,
					  !fib_nh->fib_nh_scope ? 0 : fib_nh->fib_nh_scope - 1);
    ...
}

Should we add fallback stubs for these functions here in ip_fib.h, similar =
to
fib_nh_init() and fib_nh_release(), when CONFIG_IPV4 is disabled?

>  int fib_nh_common_init(struct net *net, struct fib_nh_common *nhc,
>  		       struct nlattr *fc_encap, u16 fc_encap_type,
>  		       void *cfg, gfp_t gfp_flags,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930135334.4739=
-1-fmancera@suse.de?part=3D9
