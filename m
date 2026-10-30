Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793336071;
	b=MWyNWFYTidyd7okyrTyaljMfReZHQsd83/B3ZrMjl1buHqEH3D55ZQpjMeKNtLg0XR1J
	 jn8RXVJcocyIWrqVZbBa12+jrG6HtVVq4RfWIFSBOM5ORc3fo0/rSWc3BJReR3dkVe2FL
	 d6KjVUiSkDqwfmbuRSEe/6f8DwJkXloQVNe1XpjSiDy0rsjI5WIllMLdbMohUZyGXUg/1
	 qMywWOrz0IZcYP15U12HTzW3X6pNOadCwnghzW3DWcXuYWEGAwr1we+9pOK2kjAFMGqZP
	 nEZ8+xhP7UHz4sz2lFDZ+Ci0HeviM+vXJz38QSk3Hk0FhnfIN2+OVw5p5LRXcc5Cyuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793336071;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+hPfw+J+BfepkAJuL0WfCFotcBUDhWGmGVsgJvUGQaY=;
	b=h4kCHTcnl4+epdvR90tsCwKSSBmFo96OaIan4iUQP2sosaYdBCAAql7URTK3jV5Uqtip
	 1D9aWNSiRnv/lfguyPzqgE2HvAraD5EIatU0y+VEBgj+pptvTTnwE1l+fWk101vdYSaat
	 zXxx+T3LYRv119jCA884PWcV2mLGskaszAwDeE/Ru4NEd3RvtfvwEs1U/G/+7ImHWWBou
	 0mb7KztYbDn83tKmG5lk4Z+eX/nr8kZWq+/D3/ubX8l6K9mz2TaGmMGaY0H7YWpKzpoZS
	 zsNo7O+1EjVZr7V32DmMKMFnfCdEsMK2bY30km2aCJWlX/1p/RfnxVtWKa3t5dc1AXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pp+mUCeJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5F6606A31A
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 04:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pp+mUCeJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F091F0093A;
	Fri, 30 Oct 2026 04:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793336069;
	bh=+hPfw+J+BfepkAJuL0WfCFotcBUDhWGmGVsgJvUGQaY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Pp+mUCeJtyKOmDAC+HLUEgli+IppG5d3IBb9bIIK5CsdvIGpzsskEohA4557yTEy6
	 0IobaJxAFRZUjz3pWTDX5jN3gPC9TPbKHgZNRlImX64myneEb99RF7vc/cemB4RvtV
	 ykfYrGblIIJwtq643khhgJCdVLttK2d2rGsXIh4eJaDCWJL7qdLFxx0eSrnO/dZUAW
	 bi3kAbTwnNYc6kw1webBkKmuamoqxisqo+HMGhmEceGE+GBPcfdJUpOV/rOIUd6dd8
	 YfjT9EnbOCDNiK9b5JzPt9dO/ESnikQGi5vZBEpr5ymdVguuPgtnaC7OUdhhXWOtTe
	 iPE9dMhp6oVhQ==
Message-ID: <sashiko-outbox-190468@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/13 RFC net-next] net: core: add IPv4 fallback stubs
 and guards for CONFIG_IPV4=n
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fernando Fernandez Mancera" <fmancera@suse.de>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260712013941.4570-3-fmancera@suse.de>
References: <20260712013941.4570-1-fmancera@suse.de>
 <20260712013941.4570-3-fmancera@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 04:54:28 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Critical] The `SIOCGIFCONF` ioctl handler returns `-EAFNOSUPPORT` instea=
d of an empty list, breaking UAPI.
- [High] RCU read lock leak in `neigh_xmit()` when CONFIG_IPV4 is disabled.
- [Low] Missing stubs for IPv4 functions called by IPv6 code leads to undef=
ined references.
- [Low] Missing stubs for IP output functions and unconditional `tcp_prot` =
reference lead to undefined reference linker errors.
- [Low] Undefined reference to `tcp_twsk_unique` in IPv6 hashtables when CO=
NFIG_IPV4 is disabled.
--

--- Patch [2]: [PATCH 02/13 RFC net-next] net: core: add IPv4 fallback stub=
s and guards for CONFIG_IPV4=3Dn ---
commit c3ba15b9e372b7ea2df4737d8f114c24f3baec0c
Author: Fernando Fernandez Mancera <fmancera@suse.de>

net: core: add IPv4 fallback stubs and guards for CONFIG_IPV4=3Dn

To enable compiling the core network stack without IPv4, generic
networking code must avoid referencing missing IPv4 symbols.

This patch provides static inline stubs in include/net/ip.h and
include/net/route.h that return a proper error code when IPv4 is
disabled. This behaves as IPv6 code does. In addition, it introduces
guards around IPv4 specific code in generic implementations to prevent
undefined reference errors while linking.

> diff --git a/include/net/ip.h b/include/net/ip.h
> index 7f2fe1a8401b1..aeac40d11c725 100644
> --- a/include/net/ip.h
> +++ b/include/net/ip.h
[ ... ]
> @@ -225,27 +235,58 @@ int ip_append_data(struct sock *sk, struct flowi4 *=
fl4,
[ ... ]
> +static inline void ip_flush_pending_frames(struct sock *sk)
> +{
> +}
> +#endif
> +
> +int ip_generic_getfrag(void *from, char *to, int offset, int len, int od=
d,
> +		       struct sk_buff *skb);
> +int ip_send_skb(struct net *net, struct sk_buff *skb);
> +int ip_push_pending_frames(struct sock *sk, struct flowi4 *fl4);
> +int ip_queue_xmit(struct sock *sk, struct sk_buff *skb, struct flowi *fl=
);

[Severity: Low]
Could these un-stubbed declarations cause undefined reference errors during
linking?=20

The declarations for ip_generic_getfrag(), ip_send_skb(),
ip_push_pending_frames(), and ip_queue_xmit() are placed outside the
CONFIG_IPV4 guard without providing static inline stubs. If net/ipv4/af_ine=
t.c
and net/ipv4/udp.c are compiled without CONFIG_IPV4, references to these
functions and tcp_prot will break the build.

Additionally, are there missing stubs for IPv4 functions called directly by=
 the
IPv6 subsystem? When building with CONFIG_IPV6=3Dy and CONFIG_IPV4=3Dn, IPv=
6 mapped
socket code directly calls IPv4 functions:

net/ipv6/datagram.c:ipv6_mapped_datagram_connect() calls __ip4_datagram_con=
nect()
net/ipv6/tcp_ipv6.c:tcp_v6_connect() calls tcp_v4_connect()
net/ipv6/inet6_hashtables.c:__inet6_check_established() calls tcp_twsk_uniq=
ue()

Without stubs for these functions, or proper guards in the IPv6 code, the l=
inker
will fail.

> diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
> index a320e264eaaf0..f7ca3701b6bd1 100644
> --- a/net/core/dev_ioctl.c
> +++ b/net/core/dev_ioctl.c
> @@ -39,6 +39,7 @@ static int dev_ifname(struct net *net, struct ifreq *if=
r)
>   */
>  int dev_ifconf(struct net *net, struct ifconf __user *uifc)
>  {
> +#if IS_ENABLED(CONFIG_IPV4)
>  	struct net_device *dev;
>  	void __user *pos;
>  	size_t size;
[ ... ]
> @@ -82,6 +83,9 @@ int dev_ifconf(struct net *net, struct ifconf __user *u=
ifc)
>  	rtnl_net_unlock(net);
> =20
>  	return put_user(total, &uifc->ifc_len);
> +#else
> +	return -EAFNOSUPPORT;
> +#endif
>  }

[Severity: Critical]
Will this break legacy userspace applications that enumerate interfaces?

By returning -EAFNOSUPPORT instead of an empty list, the behavior changes
for the SIOCGIFCONF ioctl when the kernel is compiled without IPv4.

Could this branch instead return 0 interfaces via put_user(0, &uifc->ifc_le=
n)
to maintain backwards compatibility for tools expecting the ioctl to succee=
d?

> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> index 1349c0eedb642..1a40a0ab041b8 100644
> --- a/net/core/neighbour.c
> +++ b/net/core/neighbour.c
> @@ -3208,9 +3208,13 @@ int neigh_xmit(int index, struct net_device *dev,
>  			goto out_kfree_skb;
>  		}
>  		if (index =3D=3D NEIGH_ARP_TABLE) {
> +#if IS_ENABLED(CONFIG_IPV4)
>  			u32 key =3D *((u32 *)addr);
> =20
>  			neigh =3D __ipv4_neigh_lookup_noref(dev, key);
> +#else
> +			goto out_kfree_skb;
> +#endif
>  		} else {
>  			neigh =3D __neigh_lookup_noref(tbl, addr, dev);
>  		}

[Severity: High]
Does this error path leak the RCU read lock?

The function neigh_xmit() acquires the rcu_read_lock() earlier, and this
goto out_kfree_skb jumps directly to the cleanup label, missing the
rcu_read_unlock() call.

Could this stall RCU grace periods if a packet is transmitted where
index =3D=3D NEIGH_ARP_TABLE when CONFIG_IPV4 is disabled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260712013941.4570=
-1-fmancera@suse.de?part=3D2
