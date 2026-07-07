Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79768433BB8
	for <bpf@vger.kernel.org>; Tue,  7 Jul 2026 18:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783448829; cv=none; b=N+7GQqYvvAJPf4bXA8ItrBpQ/IfScSpHAiCiQSbUNHf5HJS/Zxc2aDHxaozgk8agH9SGM7l/nCvgs32Z8zNlhKmDsRa2mFAsSxwVFL6DjLHmgDgQO222lQZQt/h+NofpNepm8m+RkdGM2vOPXWr9WLGGzJk+3LcLcPSB7iLUgPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783448829; c=relaxed/simple;
	bh=xnZTaQg8Cz0Hyfjv8w5qApKuEhHoJN9iwti5MbLHDuo=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=Gh/spnjTjQUq+qaM279+JmXl5n3a8JJsBkGZUFabokN89zcBokVD4j5tL0IQPpURAuUuzMEEBNPDX26xlSq0+YXil5n1JLzEvHQOvRzJEYp2w//LUfqBAWROWcC7Fna+NQHp1nIPXhKwaqstfGoR3hw/W5ZjaL55MUdH42UyMdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=bz8K66g1; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="bz8K66g1"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8454160043aso4532953b3a.3
        for <bpf@vger.kernel.org>; Tue, 07 Jul 2026 11:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1783448827; x=1784053627; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=odWLDKN0Ghb2cuE/W6RFPQZAR/ZYd/zQJN0AJ1iKQK8=;
        b=bz8K66g1RyNb/3hkEWIEL3HJj7HTmyYOEo28Hrh2qGB/9lHXlYg0soSvi2N1vQsqYY
         4Ygh/8dnm97Xfyh5rT7izwm7G1Y73O5Xif3jZ63ExOguUEiThLAoUGn2olbj2f65ydTH
         svXSMiwaaHYS+cUJJOzMTumv8cmTGP41YJHtKSFYg95rqCwNvi7aJaswf8h2dBfAsa+c
         oD/BJdz0F9+WvdIqEGdpwVLSYvZnCrW+2Zo2qWO8+kFW4nBD1wA0Ln+pWPcGLOQBWX8Q
         /A70SScMEyjqj57DuyzEscCYzQlzupbV1NQy94KozMOfx0FvcjK2HsVf6lnvdZNRqNnO
         e85A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783448827; x=1784053627;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=odWLDKN0Ghb2cuE/W6RFPQZAR/ZYd/zQJN0AJ1iKQK8=;
        b=KE7po/qzd8Q5/JCkMXqCl9OLgQjutl9ZBeyW+pBmNUM1zIvpHWyXAKwXwIOkQy3QzI
         gtFIBFnKmvqgYxWSfhZcPJonEZ+9rKED66oaa7HCwqd88rq3J4g6xg/gQLPbnPmrDm8G
         gdl38KNNwPdLWI7z7co3zQZoAQYVMVESeAb5mJtu3NHXMuD0QORRAnEZYuxuU1bU3YW+
         mKh5SkIODk6XlXLP2y+mBJLZ2BaGTYrv4t71D9Sy8zmATb+5+zAUxujYiYXPe7gdypgp
         lxuf/7SGVSaeii/OwQehGsFFbCLHQWnSmO2toZnMSYq8INRGfJ0O+eRs9NHMJO6Nekyg
         YDmQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp/pk4IERP7UhW1eUCXMLEDX6GOIJDDcv86huWpne8vNzx322OCElDpEALlv+3sGBLFico=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOziT6ywO7+rzwS1ridSFPoXUzSE3BxW7m/xNXF0Zeks9MPSHz
	qG8j1dabTTtwtNUbKKZkRU/QMahk7qFQ4TrV+8sqK8Kd2VYUA1g0S1EsWd6qqg0b37Y=
X-Gm-Gg: AfdE7cneqeTysJJIUZXuutalk9NdaURisWswSoc8OjZydLA2aqJ4a2HT/fLf4SP40NR
	QcvMza6B/8nQXttEdJRP8wkU2jHWKqpxjkfTR329tBheXENQ9lP1Agflvs2mh4DhUpLmvDcz5y0
	hDAlUOvU0waYOSvNyBzHm+vNbeR2ly4rYfvJa51lvfpuj15py2j+IKDk0VZjRTmQIsbuf7bopn0
	yfXgVF2nr8twCkkJzLELKZcz6d85ATZbOR4SnnTAaYKUSScHebSoxNluyYV/u8/iPMl+IeRywZs
	z5wPKofY+3IefcVSyasWMx53Puyxta+SPy0CEygvMTlqL1v6bR0NF9D9MmaWIDafz6iZwoLdte+
	4ErotyIoXSVBMYzoahFiOkKHR9F64R6gwKKIkEJQje80llv/2b2BIwQSseufMGbeDb2bSNsf131
	dFJ5Mw9zs4GlZ0wl9wtCUqPgT69FkmYMCn0x3Hz5td4g==
X-Received: by 2002:a05:6a00:808c:b0:848:2f84:f42b with SMTP id d2e1a72fcca58-8482f850539mr2943374b3a.68.1783448826615;
        Tue, 07 Jul 2026 11:27:06 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6d7c2casm5816823b3a.43.2026.07.07.11.27.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2026 11:27:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 Jul 2026 14:27:04 -0400
Message-Id: <DJSJUFFYLAHG.3UW5YWKGEFOZ2@etsalapatis.com>
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Avinash Duduskar" <avinash.duduskar@gmail.com>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <andrii@kernel.org>
Cc: <eddyz87@gmail.com>, <memxor@gmail.com>, <martin.lau@linux.dev>,
 <song@kernel.org>, <yonghong.song@linux.dev>, <jolsa@kernel.org>,
 <emil@etsalapatis.com>, <john.fastabend@gmail.com>, <sdf@fomichev.me>,
 <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <horms@kernel.org>, <shuah@kernel.org>,
 <hawk@kernel.org>, <yatsenko@meta.com>, <leon.hwang@linux.dev>,
 <kpsingh@kernel.org>, <a.s.protopopov@gmail.com>, <ameryhung@gmail.com>,
 <rongtao@cestc.cn>, <eyal.birger@gmail.com>, <bpf@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <toke@redhat.com>, <dsahern@kernel.org>
Subject: Re: [PATCH bpf-next v6 2/3] bpf: Add BPF_FIB_LOOKUP_VLAN_INPUT flag
 to bpf_fib_lookup() helper
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260704092159.1256823-1-avinash.duduskar@gmail.com>
 <20260704092159.1256823-3-avinash.duduskar@gmail.com>
In-Reply-To: <20260704092159.1256823-3-avinash.duduskar@gmail.com>

On Sat Jul 4, 2026 at 5:21 AM EDT, Avinash Duduskar wrote:
> BPF_FIB_LOOKUP_VLAN resolves a VLAN egress. The reverse is also
> useful: an XDP program receiving a VLAN-tagged frame on a physical
> device wants the lookup to behave as if the packet had arrived on the
> corresponding VLAN subinterface, so iif-based policy routing and VRF
> table selection use the right ingress.
>
> Add BPF_FIB_LOOKUP_VLAN_INPUT. When set, params->h_vlan_proto and
> params->h_vlan_TCI are read as an input VLAN tag and the matching VLAN
> device of params->ifindex is resolved with __vlan_find_dev_deep_rcu().
> The device must be up and in the same network namespace as
> params->ifindex (a VLAN device can be moved to another netns while
> registered on its parent; receive would deliver into that other
> namespace, which a lookup here cannot represent). If params->ifindex
> is itself a VLAN device, its inner (QinQ) subinterface is matched.
> For a bond or team, a tag on a port matches no device and returns
> NOT_FWDED; pass the master's ifindex.
> The lookup then runs with the resolved device as the ingress;
> params->ifindex itself is not modified on the input side. When the
> resolved device is enslaved to a VRF, both the full lookup (via the
> l3mdev rule) and BPF_FIB_LOOKUP_DIRECT (via l3mdev_fib_table_rcu())
> select the VRF's table from the resolved ingress. That follows from
> feeding the resolved device to the flow as the ingress
> (fl4.flowi4_iif =3D dev->ifindex), which is what makes l3mdev resolve
> the VRF master from the subinterface rather than from
> params->ifindex.
>
> The two failure classes get different treatment on purpose. A
> h_vlan_proto other than 802.1Q/802.1ad is API misuse and returns
> -EINVAL, since it would otherwise reach the WARN in vlan_proto_idx()
> with a program-controlled value. An unmatched VID, a device that is
> down, or one in another namespace is a data outcome and returns
> BPF_FIB_LKUP_RET_NOT_FWDED, matching the DIRECT path when
> fib_get_table() finds no table and mirroring real ingress, where the
> receive path drops such frames. A VID of 0 (a priority tag) is looked
> up literally and normally fails the same way; receive instead
> processes such frames untagged, so callers should not set the flag for
> priority tags. Proceeding on the physical device for any of these
> would be fail-open for the policy-routing cases above.
>
> The h_vlan fields share a union with tbid, so the flag cannot be
> combined with BPF_FIB_LOOKUP_TBID. It describes ingress, so it also
> cannot be combined with BPF_FIB_LOOKUP_OUTPUT. Both combinations
> return -EINVAL; restricting now keeps a later relaxation backward
> compatible. Combining with BPF_FIB_LOOKUP_VLAN is allowed: the tag is
> consumed on the ingress side and the egress tag is written on
> success.
>
> Under !CONFIG_VLAN_8021Q the __vlan_find_dev_deep_rcu() stub returns
> NULL, so every lookup with the flag returns NOT_FWDED, which is
> correct since no VLAN device can exist.
>
> Suggested-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> Signed-off-by: Avinash Duduskar <avinash.duduskar@gmail.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  include/uapi/linux/bpf.h       | 21 ++++++++++-
>  net/core/filter.c              | 66 +++++++++++++++++++++++++++++++---
>  tools/include/uapi/linux/bpf.h | 21 ++++++++++-
>  3 files changed, 101 insertions(+), 7 deletions(-)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index e00f0392e728..d4218954c50f 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -3555,6 +3555,22 @@ union bpf_attr {
>   *			This flag is only valid for XDP programs; tc programs
>   *			receive -EINVAL since they can redirect to the VLAN
>   *			device directly.
> + *		**BPF_FIB_LOOKUP_VLAN_INPUT**
> + *			Treat *params*->h_vlan_proto and *params*->h_vlan_TCI
> + *			as an input VLAN tag and run the lookup as if ingress
> + *			had happened on the VLAN subinterface carrying that tag
> + *			on *params*->ifindex. The VID is the low 12 bits of
> + *			*params*->h_vlan_TCI; *params*->h_vlan_proto must be
> + *			ETH_P_8021Q or ETH_P_8021AD in network byte order, else
> + *			**-EINVAL**. If *params*->ifindex is itself a VLAN
> + *			device, its inner (QinQ) subinterface is matched; for a
> + *			bond or team, pass the master's ifindex. An unmatched
> + *			tag, a down device, or one in another namespace returns
> + *			**BPF_FIB_LKUP_RET_NOT_FWDED**, mirroring real ingress.
> + *			A VID of 0 is looked up literally, so do not set this
> + *			flag for priority-tagged frames. Cannot be combined with
> + *			**BPF_FIB_LOOKUP_TBID** or **BPF_FIB_LOOKUP_OUTPUT**
> + *			(returns **-EINVAL**).
>   *
>   *		*ctx* is either **struct xdp_md** for XDP programs or
>   *		**struct sk_buff** tc cls_act programs.
> @@ -7351,6 +7367,7 @@ enum {
>  	BPF_FIB_LOOKUP_SRC     =3D (1U << 4),
>  	BPF_FIB_LOOKUP_MARK    =3D (1U << 5),
>  	BPF_FIB_LOOKUP_VLAN    =3D (1U << 6),
> +	BPF_FIB_LOOKUP_VLAN_INPUT =3D (1U << 7),
>  };
> =20
>  enum {
> @@ -7421,7 +7438,9 @@ struct bpf_fib_lookup {
>  			/*
>  			 * output with BPF_FIB_LOOKUP_VLAN: set from the
>  			 * resolved egress VLAN device (see the flag); zeroed
> -			 * on other successful lookups.
> +			 * on other successful lookups. input with
> +			 * BPF_FIB_LOOKUP_VLAN_INPUT: the VLAN tag to scope
> +			 * the lookup by.
>  			 */
>  			__be16	h_vlan_proto;
>  			__be16	h_vlan_TCI;
> diff --git a/net/core/filter.c b/net/core/filter.c
> index b5a45485a54b..0ea362fa4287 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -6229,6 +6229,25 @@ static int bpf_fib_set_fwd_params(struct net_devic=
e *dev,
> =20
>  	return 0;
>  }
> +
> +static struct net_device *bpf_fib_vlan_input_dev(struct net_device *dev,
> +						 const struct bpf_fib_lookup *params)
> +{
> +	__be16 proto =3D params->h_vlan_proto;
> +	struct net_device *vlan_dev;
> +	u16 vid;
> +
> +	if (proto !=3D htons(ETH_P_8021Q) && proto !=3D htons(ETH_P_8021AD))
> +		return ERR_PTR(-EINVAL);
> +
> +	vid =3D ntohs(params->h_vlan_TCI) & VLAN_VID_MASK;
> +	vlan_dev =3D __vlan_find_dev_deep_rcu(dev, proto, vid);
> +	if (!vlan_dev || !(vlan_dev->flags & IFF_UP) ||
> +	    !net_eq(dev_net(vlan_dev), dev_net(dev)))
> +		return NULL;
> +
> +	return vlan_dev;
> +}
>  #endif
> =20
>  #if IS_ENABLED(CONFIG_INET)
> @@ -6249,6 +6268,14 @@ static int bpf_ipv4_fib_lookup(struct net *net, st=
ruct bpf_fib_lookup *params,
>  	if (unlikely(!dev))
>  		return -ENODEV;
> =20
> +	if (flags & BPF_FIB_LOOKUP_VLAN_INPUT) {
> +		dev =3D bpf_fib_vlan_input_dev(dev, params);
> +		if (IS_ERR(dev))
> +			return PTR_ERR(dev);
> +		if (!dev)
> +			return BPF_FIB_LKUP_RET_NOT_FWDED;
> +	}
> +
>  	/* verify forwarding is enabled on this interface */
>  	in_dev =3D __in_dev_get_rcu(dev);
>  	if (unlikely(!in_dev || !IN_DEV_FORWARD(in_dev)))
> @@ -6258,7 +6285,11 @@ static int bpf_ipv4_fib_lookup(struct net *net, st=
ruct bpf_fib_lookup *params,
>  		fl4.flowi4_iif =3D 1;
>  		fl4.flowi4_oif =3D params->ifindex;
>  	} else {
> -		fl4.flowi4_iif =3D params->ifindex;
> +		/*
> +		 * dev->ifindex, not params->ifindex: VLAN_INPUT may have
> +		 * resolved dev to a subinterface above.
> +		 */
> +		fl4.flowi4_iif =3D dev->ifindex;
>  		fl4.flowi4_oif =3D 0;
>  	}
>  	fl4.flowi4_dscp =3D inet_dsfield_to_dscp(params->tos);
> @@ -6395,6 +6426,14 @@ static int bpf_ipv6_fib_lookup(struct net *net, st=
ruct bpf_fib_lookup *params,
>  	if (unlikely(!dev))
>  		return -ENODEV;
> =20
> +	if (flags & BPF_FIB_LOOKUP_VLAN_INPUT) {
> +		dev =3D bpf_fib_vlan_input_dev(dev, params);
> +		if (IS_ERR(dev))
> +			return PTR_ERR(dev);
> +		if (!dev)
> +			return BPF_FIB_LKUP_RET_NOT_FWDED;
> +	}
> +
>  	idev =3D __in6_dev_get_safely(dev);
>  	if (unlikely(!idev || !READ_ONCE(idev->cnf.forwarding)))
>  		return BPF_FIB_LKUP_RET_FWD_DISABLED;
> @@ -6403,7 +6442,12 @@ static int bpf_ipv6_fib_lookup(struct net *net, st=
ruct bpf_fib_lookup *params,
>  		fl6.flowi6_iif =3D 1;
>  		oif =3D fl6.flowi6_oif =3D params->ifindex;
>  	} else {
> -		oif =3D fl6.flowi6_iif =3D params->ifindex;
> +		/*
> +		 * dev->ifindex, not params->ifindex: VLAN_INPUT may have
> +		 * resolved dev to a subinterface above.
> +		 */
> +		oif =3D dev->ifindex;
> +		fl6.flowi6_iif =3D oif;
>  		fl6.flowi6_oif =3D 0;
>  		strict =3D RT6_LOOKUP_F_HAS_SADDR;
>  	}
> @@ -6514,7 +6558,19 @@ static int bpf_ipv6_fib_lookup(struct net *net, st=
ruct bpf_fib_lookup *params,
>  #define BPF_FIB_LOOKUP_MASK (BPF_FIB_LOOKUP_DIRECT | BPF_FIB_LOOKUP_OUTP=
UT | \
>  			     BPF_FIB_LOOKUP_SKIP_NEIGH | BPF_FIB_LOOKUP_TBID | \
>  			     BPF_FIB_LOOKUP_SRC | BPF_FIB_LOOKUP_MARK | \
> -			     BPF_FIB_LOOKUP_VLAN)
> +			     BPF_FIB_LOOKUP_VLAN | BPF_FIB_LOOKUP_VLAN_INPUT)
> +
> +static bool bpf_fib_lookup_flags_ok(u32 flags)
> +{
> +	if (flags & ~BPF_FIB_LOOKUP_MASK)
> +		return false;
> +
> +	if ((flags & BPF_FIB_LOOKUP_VLAN_INPUT) &&
> +	    (flags & (BPF_FIB_LOOKUP_TBID | BPF_FIB_LOOKUP_OUTPUT)))
> +		return false;
> +
> +	return true;
> +}
> =20
>  BPF_CALL_4(bpf_xdp_fib_lookup, struct xdp_buff *, ctx,
>  	   struct bpf_fib_lookup *, params, int, plen, u32, flags)
> @@ -6522,7 +6578,7 @@ BPF_CALL_4(bpf_xdp_fib_lookup, struct xdp_buff *, c=
tx,
>  	if (plen < sizeof(*params))
>  		return -EINVAL;
> =20
> -	if (flags & ~BPF_FIB_LOOKUP_MASK)
> +	if (!bpf_fib_lookup_flags_ok(flags))
>  		return -EINVAL;
> =20
>  	switch (params->family) {
> @@ -6560,7 +6616,7 @@ BPF_CALL_4(bpf_skb_fib_lookup, struct sk_buff *, sk=
b,
>  	if (plen < sizeof(*params))
>  		return -EINVAL;
> =20
> -	if (flags & ~BPF_FIB_LOOKUP_MASK)
> +	if (!bpf_fib_lookup_flags_ok(flags))
>  		return -EINVAL;
> =20
>  	if (flags & BPF_FIB_LOOKUP_VLAN)
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
> index e00f0392e728..d4218954c50f 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -3555,6 +3555,22 @@ union bpf_attr {
>   *			This flag is only valid for XDP programs; tc programs
>   *			receive -EINVAL since they can redirect to the VLAN
>   *			device directly.
> + *		**BPF_FIB_LOOKUP_VLAN_INPUT**
> + *			Treat *params*->h_vlan_proto and *params*->h_vlan_TCI
> + *			as an input VLAN tag and run the lookup as if ingress
> + *			had happened on the VLAN subinterface carrying that tag
> + *			on *params*->ifindex. The VID is the low 12 bits of
> + *			*params*->h_vlan_TCI; *params*->h_vlan_proto must be
> + *			ETH_P_8021Q or ETH_P_8021AD in network byte order, else
> + *			**-EINVAL**. If *params*->ifindex is itself a VLAN
> + *			device, its inner (QinQ) subinterface is matched; for a
> + *			bond or team, pass the master's ifindex. An unmatched
> + *			tag, a down device, or one in another namespace returns
> + *			**BPF_FIB_LKUP_RET_NOT_FWDED**, mirroring real ingress.
> + *			A VID of 0 is looked up literally, so do not set this
> + *			flag for priority-tagged frames. Cannot be combined with
> + *			**BPF_FIB_LOOKUP_TBID** or **BPF_FIB_LOOKUP_OUTPUT**
> + *			(returns **-EINVAL**).
>   *
>   *		*ctx* is either **struct xdp_md** for XDP programs or
>   *		**struct sk_buff** tc cls_act programs.
> @@ -7351,6 +7367,7 @@ enum {
>  	BPF_FIB_LOOKUP_SRC     =3D (1U << 4),
>  	BPF_FIB_LOOKUP_MARK    =3D (1U << 5),
>  	BPF_FIB_LOOKUP_VLAN    =3D (1U << 6),
> +	BPF_FIB_LOOKUP_VLAN_INPUT =3D (1U << 7),
>  };
> =20
>  enum {
> @@ -7421,7 +7438,9 @@ struct bpf_fib_lookup {
>  			/*
>  			 * output with BPF_FIB_LOOKUP_VLAN: set from the
>  			 * resolved egress VLAN device (see the flag); zeroed
> -			 * on other successful lookups.
> +			 * on other successful lookups. input with
> +			 * BPF_FIB_LOOKUP_VLAN_INPUT: the VLAN tag to scope
> +			 * the lookup by.
>  			 */
>  			__be16	h_vlan_proto;
>  			__be16	h_vlan_TCI;

