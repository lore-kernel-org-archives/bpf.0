Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793336072;
	b=xbMMVNfZHpvQFg/1f8wKEc7c3qtVO5gwRPlQNLTO+pMJMSxnDbeCNTNzz7Q99R8WfNlv
	 m4BVdTo0ZdgHcOxpd75qiea5ZvkW1wUq8V41pXShNgpbDpwZN5pLf5Wrc349Pn5lny/lk
	 tk8MdHUcFjyp7kpZTxOb/JvgDSGi8Im1DKUzfr0NsyH8NyFaB+m1JAdGiBzXy5TrmD71V
	 PqRCu9t9z7dr6mFS3H6lz8bJOYjKcMuFbwoEBK0lrqSwWgwfff1MSQaihS54SPDDc9K/u
	 WDIUCu+T4ngVoBVUVREML95MVT47t1CXY4asoHjS4pdX4uVCVEyzvEkSovEoEI9ih1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793336072;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jiFgyI4hoGryO1sZHkKjJ762BJ9DdasfPu4mieYLLpY=;
	b=RCuSjsBctDQ0hdajDIMKapjMl+h82ItefFRRsYqEAGHlN7+tp6kYEvaKTug/+Hn0cHOM
	 lQFS6OxpiD0hbxt2l95QiAdDbcp/wQwvxDk1jtpvGVrsAYle4/JgPXv1DWgaekIfVFrkK
	 FnaOkjZ+4J1PiFfM3TunZytrIY5WHrra3BCnWpe183gycGrcCy29YZwlNPVgUo1yqJRf/
	 KGhI2SB7t6TTFcLNsh4+PFrp1etFx33hRjUXBUSP3fmSmFXVyWXxztUOZ037n68Bdc2bd
	 PPdYwUahjR62/C6K3FYnf9tqoTb91lFZvm/kJmNB353B/4b17Qw1ruRpp5yvWwx4PAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oY2G7AHA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51445606A327
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 04:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oY2G7AHA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC4FE1F000C1;
	Fri, 30 Oct 2026 04:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793336071;
	bh=jiFgyI4hoGryO1sZHkKjJ762BJ9DdasfPu4mieYLLpY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oY2G7AHAO9fuXxLoCsohZVO6eYzR7O2jwtSk+oqfC+Ac1A3Q/oF/QO3wMuA4IAdoD
	 ld93JAbJ1GIxHmBv9hT85D++c1OsHymtG0S6AqrMczpMGatoPgF8nYD7+pAo2UiXt8
	 Qz9mN3oXFi9jNnOzCzrWxsjkXBGaO38OOsDuctGQ8OHGTcclTlfijcDizJeKFapFl0
	 2tXQwZ0fPClsfqsv3L0rTgOrPoKvdPhVFs9rojWmcwNAiNcWERdNPS0QtQV7Qwf5L6
	 f4NfuqPPKnzkV7xcgI9SGC1yaexui12+IvwgW6WeDB3O8n4vwv18bM6Y5JarfGFdof
	 3wiIcb4e65iQQ==
Message-ID: <sashiko-outbox-190474@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/13 RFC net-next] net: fib: split common nexthop logic
 to fib_core.c
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fernando Fernandez Mancera" <fmancera@suse.de>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260712013941.4570-10-fmancera@suse.de>
References: <20260712013941.4570-1-fmancera@suse.de>
 <20260712013941.4570-10-fmancera@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 04:54:31 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] IPv6 route dumps silently omit nexthop gateway, interface, and enc=
ap information when IPv4 is disabled.
- [High] IPv6 strict route netlink dumps bypass filter parsing and ignore u=
ser filters when CONFIG_IPV4 is disabled.
- [High] Missing fallback stub for `ip_valid_fib_dump_req` causes undefined=
 reference linker errors for IPv6 multicast routing and MPLS when compiled =
without IPv4.
--

--- Patch [9]: [PATCH 09/13 RFC net-next] net: fib: split common nexthop lo=
gic to fib_core.c ---
commit 8475b4cb1ca1bfc7fdd4717168ce4e1522e0104d
Author: Fernando Fernandez Mancera <fmancera@suse.de>
Subject: net: fib: split common nexthop logic to fib_core.c

This patch creates fib_core.c and moves common nexthop initialization and
release functions from fib_semantics.c to fib_core.c. This enables compiling
the INET subsystem without IPv4.

> diff --git a/include/net/ip_fib.h b/include/net/ip_fib.h
> index 0a35355fb0f33..0c56d8690e008 100644
> --- a/include/net/ip_fib.h
> +++ b/include/net/ip_fib.h
[ ... ]
> @@ -658,8 +683,26 @@ int ip_valid_fib_dump_req(struct net *net, const str=
uct nlmsghdr *nlh,
>  			  struct fib_dump_filter *filter,
>  			  struct netlink_callback *cb);
> =20

[Severity: High]
Does this missing fallback stub cause undefined reference linker errors for=
 IPv6
multicast routing and MPLS when compiled without IPv4?

ip6mr_rtm_dumproute() and mpls_valid_fib_dump_req() unconditionally call
ip_valid_fib_dump_req(). Could a static inline stub be added for the
!CONFIG_IPV4 case?

> +#if IS_ENABLED(CONFIG_IPV4)
>  int fib_nexthop_info(struct sk_buff *skb, const struct fib_nh_common *nh,
>  		     u8 rt_family, unsigned char *flags, bool skip_oif);
>  int fib_add_nexthop(struct sk_buff *skb, const struct fib_nh_common *nh,
>  		    int nh_weight, u8 rt_family, u32 nh_tclassid);
> +#else
> +static inline int fib_nexthop_info(struct sk_buff *skb,
> +				   const struct fib_nh_common *nh,
> +				   u8 rt_family, unsigned char *flags,
> +				   bool skip_oif)
> +{
> +	return 0;
> +}

[Severity: High]
Since the stub returns 0, will IPv6 route dumps silently omit the nexthop
gateway, interface, and encap information when IPv4 is disabled?

IPv6 relies on this function to serialize its nexthop info in rt6_fill_node=
():

rt6_fill_node()
    if (fib_nexthop_info(skb, &rt->fib6_nh->nh_common, AF_INET6, &nh_flags,=
 false) < 0)
        goto nla_put_failure;

Could this be moved to fib_core.c instead of stubbed out so the RTA attribu=
tes
aren't dropped?

> +
> +static inline int fib_add_nexthop(struct sk_buff *skb,
> +				  const struct fib_nh_common *nh,
> +				  int nh_weight, u8 rt_family,
> +				  u32 nh_tclassid)
> +{
> +	return 0;
> +}
> +#endif
>  #endif  /* _NET_FIB_H */
> diff --git a/net/core/fib_core.c b/net/core/fib_core.c
> new file mode 100644
> index 0000000000000..93894b5847e97
> --- /dev/null
> +++ b/net/core/fib_core.c
[ ... ]
> +void fib_nhc_update_mtu(struct fib_nh_common *nhc, u32 new, u32 orig)
> +{
> +	struct fnhe_hash_bucket *bucket;
> +	int i;
> +
> +	bucket =3D rcu_dereference_protected(nhc->nhc_exceptions, 1);
> +	if (!bucket)
> +		return;
> +
> +	for (i =3D 0; i < FNHE_HASH_SIZE; i++) {
> +		struct fib_nh_exception *fnhe;
> +
> +		for (fnhe =3D rcu_dereference_protected(bucket[i].chain, 1);
> +		     fnhe;
> +		     fnhe =3D rcu_dereference_protected(fnhe->fnhe_next, 1)) {

[Severity: High]
This isn't a bug introduced by this patch, but does traversing the
nhc_exceptions list here without holding rcu_read_lock() or fnhe_lock risk a
use-after-free?

This loop traverses the fnhe_next chain using rcu_dereference_protected(...=
, 1).
Concurrently, update_or_create_fnhe() running in softirq can unlink and fre=
e a
fnhe entry via kfree_rcu(). Because rtnl_lock does not disable preemption,
can a grace period elapse and cause the traversal to follow a freed pointer?

> +			if (fnhe->fnhe_mtu_locked) {
> +				if (new <=3D fnhe->fnhe_pmtu) {
> +					fnhe->fnhe_pmtu =3D new;
> +					fnhe->fnhe_mtu_locked =3D false;
> +				}
> +			} else if (new < fnhe->fnhe_pmtu ||
> +				   orig =3D=3D fnhe->fnhe_pmtu) {
> +				fnhe->fnhe_pmtu =3D new;
> +			}
> +		}
> +	}
> +}
[ ... ]
> diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
> index a130cdfaebfbe..8b5f855c8dcbf 100644
> --- a/net/ipv6/ip6_fib.c
> +++ b/net/ipv6/ip6_fib.c
> @@ -645,9 +645,11 @@ static int inet6_dump_fib(struct sk_buff *skb, struc=
t netlink_callback *cb)
> =20
>  	rcu_read_lock();
>  	if (cb->strict_check) {
> +#if IS_ENABLED(CONFIG_IPV4)
>  		err =3D ip_valid_fib_dump_req(net, nlh, &arg.filter, cb);
>  		if (err < 0)
>  			goto unlock;
> +#endif

[Severity: High]
When IPv4 is disabled, does this skip filter parsing and cause strict route
netlink dumps to unconditionally dump the entire routing table?

If the filter parsing is bypassed, arg.filter remains zero-initialized and
userspace filters like table ID or device constraints are ignored. Could th=
is
break the NLM_F_STRICT_CHK uAPI guarantee?

>  	} else if (nlmsg_len(nlh) >=3D sizeof(struct rtmsg)) {
>  		struct rtmsg *rtm =3D nlmsg_data(nlh);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260712013941.4570=
-1-fmancera@suse.de?part=3D9
