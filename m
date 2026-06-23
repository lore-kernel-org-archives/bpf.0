Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC97F3D5226
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 11:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782215895; cv=none; b=pztVbTYXcOTvSXgJx4AE8UfE8oYV5nee2YClyi3RrWpPiCxTQzJI71A0TNvIdlxx0Dua9meglhm9ToncVM23hbgT6WXappai14RwfiFoMsh71WfmY6hYR53GNnYQanTjqqdHSZv7u+op0nN/ByYzmlzs9SEFjvx1y1hlQ7zg0Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782215895; c=relaxed/simple;
	bh=ulixYUrLEOLsgmwRBAwj2pdvRxo8++O1KtAgstSzrgI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XdXocYZe6BC4y8FfmKWEEob5sI7uHd4X8V9MesqT1a/6GLngnTmxoF3feRuWZ+oVS8UiwmVt7w5SrmenbjToz/ONKOJfr7uJWvoovFRLk4mfQmSgWtT4M9ilblKhfgI1an6wDbEluYQEqbNJaoA5PtlByvanCkg5SglQiW5jics=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SFvPqLvp; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tJnYl6on; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SFvPqLvp";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tJnYl6on"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782215891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tuM2HWZfbdl/+3prcM1vbmw8CO7F/BsLiS5JqG/MJfw=;
	b=SFvPqLvpY0LeM35l9HmkdGZkecRFl3/2KqV1EpM7M6+SQdF7TpqgdgNALjk3yHwbxb588h
	WxMtdTZojb8UgJuihtYWj3locg1LJ3NGI7/S74/mhVpR9NzqL/zchPMvbQglogAUoDGaNJ
	ay0jT8IYJ1+OZjxrAJu5eMrMX1R4cxs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-8KW-ijQoNlmZKremjr48Uw-1; Tue, 23 Jun 2026 07:58:10 -0400
X-MC-Unique: 8KW-ijQoNlmZKremjr48Uw-1
X-Mimecast-MFC-AGG-ID: 8KW-ijQoNlmZKremjr48Uw_1782215889
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49245e10b73so21286805e9.3
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 04:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782215889; x=1782820689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tuM2HWZfbdl/+3prcM1vbmw8CO7F/BsLiS5JqG/MJfw=;
        b=tJnYl6on8ZypLfcdB9JFmp19XC4NuyoatYJHVEoDpea/rZScKEZiHPXr8wuFRF3Zhw
         Lojn34zRD/nX11/hmQ85jsBvenG/pIco1yABbi/IcwNEoZ02HPYZNjjwMSu+eeEPnPmc
         EKXmtrncONzC7yVapMV72zXwvN/XZagSeFob7YMIevoDVBb05F8INtzNHFnH1+Obwf0C
         r/YdDE3cx0IsQ9wa7Hrfl8cINX4hQ79Bahuu+R8jIb2NY8Sdq7hfs6PZL8eediVLCBZF
         T8T7rPvd2+1Em8X3UWuG9xgDCVbDzaKSpVAJ81vt0i51rz8RRHo1xZqWphI5Nc6MQNNM
         t/Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782215889; x=1782820689;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tuM2HWZfbdl/+3prcM1vbmw8CO7F/BsLiS5JqG/MJfw=;
        b=GEUPs4//6hrQCO/j0bTmm+ldgWfj90biCgc/R46dOQXU3qLFjwNYlOUVoYZeq/XIyk
         t9fw0EGK64kU6lKQHG6eBXlkGuAmF7SNPxrkeCg4fLUK1FueDuEGtGWID874leJusw+3
         M5p7hsp+bejUOHlkkBBFQuDY/bamyrTsOQSiCDVgH0PZCLa8496s4Rs6eE2nzljYSgrd
         UbEK1SZ003j8HeyJhnn7w9bzulzeYJOF2ngGHswIX4pYpfBWv7/z6tyoPRwSMk5MIZhA
         XRiE1EV/dxUwe+9onRhuvyaKJpk503f0R5ePYiygbi2AnKnM4FL/G00nEw0WmR7W02uT
         /nvQ==
X-Forwarded-Encrypted: i=1; AFNElJ+NUN21L3S8/RlEnmwFssIZmlupm0/4EZPJXM7nDuYE4nDbfGUVUqLNbntfT5zQfId4iBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwQnheRPRVH9R7+xRiM2Z9y/fM1vXuANg05ucR2HeCtP+BmoaX
	TJPvvH/oKByQgVtkqpucr/MOcgcIj3hcBMJqt272ErNT7KgW9v5pIzU4UFZLQzTmprY/O1xXjHJ
	7jNlaykqtsl6yJzZpgrf+Ek3knznmpzEluTB0DeZN+B5C+44tFETIzw==
X-Gm-Gg: AfdE7clXBdOd5Xmj7d6+1O5yjhDB8cXLOwRnIfKciCTnSWhdgfF2q4l2lhjZzJG2dYJ
	9spjBZXKYR0yJK0mSBjBKBZgEXmdtuqxj4o6d5dagOcvxPBfVRTVU1OXxNUkqWwjreG+sLjD6yB
	mwqmkT0hdE7FJrO8ttMUlK/vrLiXoKDllulFM4wBnSgnvmpr/q0wELQT7HfCkJQ3jFmKL4KH2iS
	yppl66jNYV1k3U2G/Bz3dxsVVIC7CydT4rD/n8a7lDa5obx2LD1d49fZ3Da+w8yUefyyAo6rVaT
	yU+Jxv15A+E2YwRODIzdDF6sHbcYJWoLWOe0K9xn6MJGbYhBr9GN2FkKLHamqWq/cRagG+XtNLl
	/P/EUFT54l+ScfqK9YZTqOLS6fW2YdHNCpiq40A==
X-Received: by 2002:a05:600c:4e4a:b0:490:e281:287d with SMTP id 5b1f17b1804b1-4925b34a6c6mr35671035e9.1.1782215889335;
        Tue, 23 Jun 2026 04:58:09 -0700 (PDT)
X-Received: by 2002:a05:600c:4e4a:b0:490:e281:287d with SMTP id 5b1f17b1804b1-4925b34a6c6mr35669755e9.1.1782215888259;
        Tue, 23 Jun 2026 04:58:08 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492494496d8sm289617055e9.9.2026.06.23.04.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 04:58:06 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 5BBDF808C7E; Tue, 23 Jun 2026 13:58:05 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Avinash Duduskar <avinash.duduskar@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org
Cc: eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, john.fastabend@gmail.com, sdf@fomichev.me,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, hawk@kernel.org,
 yatsenko@meta.com, leon.hwang@linux.dev, kpsingh@kernel.org,
 a.s.protopopov@gmail.com, ameryhung@gmail.com, rongtao@cestc.cn,
 eyal.birger@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 dsahern@kernel.org
Subject: Re: [PATCH bpf-next v4 1/3] bpf: Add BPF_FIB_LOOKUP_VLAN flag to
 bpf_fib_lookup() helper
In-Reply-To: <20260623025147.1001664-2-avinash.duduskar@gmail.com>
References: <20260623025147.1001664-1-avinash.duduskar@gmail.com>
 <20260623025147.1001664-2-avinash.duduskar@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 23 Jun 2026 13:58:05 +0200
Message-ID: <877bnpeaeq.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Avinash Duduskar <avinash.duduskar@gmail.com> writes:

> bpf_fib_lookup() returns the FIB-resolved egress ifindex straight
> from the fib result. When the egress is a VLAN device, the returned
> ifindex is the VLAN netdev's, which has no XDP xmit handler; XDP
> programs that want to forward the frame (e.g. xdp-forward) must
> instead target the underlying physical device and push the VLAN tag
> themselves. Today the program has no way to learn either the
> underlying ifindex or the VLAN tag without maintaining its own
> VLAN-to-ifindex map in userspace and refreshing it on netlink
> events.
>
> Add BPF_FIB_LOOKUP_VLAN. When the caller sets this flag and the fib
> result is a VLAN device whose immediate parent is a real (non-VLAN)
> device in the same network namespace, populate the existing output
> fields params->h_vlan_proto and params->h_vlan_TCI from the VLAN
> device and replace params->ifindex with the parent's ifindex.
> params->h_vlan_TCI carries the VID only, with PCP and DEI bits zero; a
> consumer wanting to set egress priority writes PCP itself.
> params->smac is the VLAN device's own address, which can differ from
> the parent's.
>
> Only the immediate parent is resolved, via vlan_dev_priv(dev)->real_dev
> and not vlan_dev_real_dev(), which walks to the bottom of a stack. When
> the immediate parent is not a real device in the same namespace, the
> lookup returns BPF_FIB_LKUP_RET_VLAN_FAILURE and leaves params->ifindex
> at the input. This covers a stacked VLAN (QinQ), where the immediate
> parent is itself a VLAN device and one h_vlan_proto/h_vlan_TCI pair
> cannot describe two tags, and a parent in another network namespace (a
> VLAN device can be moved while its parent stays), whose ifindex would
> be meaningless in the caller's namespace. A program that wants the VLAN
> device's own ifindex re-issues the lookup without BPF_FIB_LOOKUP_VLAN,
> so the unreducible case stays distinct from a physical egress. That
> distinction matters for XDP: a program cannot xmit on a VLAN device, so
> a success carrying the VLAN ifindex would make it redirect to a device
> with no ndo_xdp_xmit and drop the frame at xdp_do_flush(). The swap and
> the vlan fields are written only on the reduce path; other output
> fields keep their existing behaviour, so a frag-needed result still
> reports the route mtu in params->mtu_result.
>
> On the skb path without tot_len the deferred mtu check is done against
> the resolved egress device. To keep that the VLAN device rather than
> the parent after the swap, bpf_ipv4_fib_lookup()/bpf_ipv6_fib_lookup()
> hand the FIB-result device back to the caller; the XDP path always
> runs the route-mtu check and passes NULL. When the flag is not set,
> behaviour is unchanged: h_vlan_proto and h_vlan_TCI are zeroed and
> ifindex is left at the FIB result.
>
> The new block is compiled only under CONFIG_VLAN_8021Q since
> vlan_dev_priv() is not defined otherwise; without that config
> is_vlan_dev() is constant false and the flag is accepted but never
> acts. That is safe because no VLAN device can exist there, so every
> egress is already physical.
>
> This lets an XDP redirect target the physical device and learn the
> tag to push in a single lookup, which xdp-forward's optional VLAN
> mode (xdp-project/xdp-tools#504) wants from the kernel side.
>
> The helper's input semantics are unchanged; the reverse direction
> (supplying a tag as lookup input) is added in the following patch.
>
> Suggested-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> Signed-off-by: Avinash Duduskar <avinash.duduskar@gmail.com>
> ---
>  include/uapi/linux/bpf.h       | 28 +++++++++++++-
>  net/core/filter.c              | 69 ++++++++++++++++++++++++----------
>  tools/include/uapi/linux/bpf.h | 28 +++++++++++++-
>  3 files changed, 104 insertions(+), 21 deletions(-)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 89b36de5fdbb..8d0058d88eb2 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -3532,6 +3532,26 @@ union bpf_attr {
>   *			Use the mark present in *params*->mark for the fib lookup.
>   *			This option should not be used with BPF_FIB_LOOKUP_DIRECT,
>   *			as it only has meaning for full lookups.
> + *		**BPF_FIB_LOOKUP_VLAN**
> + *			If the fib lookup resolves to a VLAN device whose
> + *			parent is a real (non-VLAN) device, set
> + *			*params*->h_vlan_proto and *params*->h_vlan_TCI from
> + *			the VLAN device and replace *params*->ifindex with the
> + *			parent's ifindex. *params*->h_vlan_TCI carries the VID
> + *			only, with PCP and DEI bits zero; a consumer wanting to
> + *			set egress priority writes PCP itself. *params*->smac is
> + *			the VLAN device's own address, which can differ from the
> + *			parent's. Only the immediate parent is resolved; if it
> + *			is itself a VLAN device (QinQ) or in another namespace,
> + *			the egress cannot be reduced to a physical device plus
> + *			one tag and the lookup returns
> + *			**BPF_FIB_LKUP_RET_VLAN_FAILURE** with *params*->ifindex
> + *			left at the input. Re-issue without
> + *			**BPF_FIB_LOOKUP_VLAN** to obtain the VLAN device's own
> + *			ifindex. The swap and the vlan fields
> + *			are written only on success; other output fields keep
> + *			the helper's existing behaviour, so a frag-needed result
> + *			still reports the route mtu in *params*->mtu_result.
>   *
>   *		*ctx* is either **struct xdp_md** for XDP programs or
>   *		**struct sk_buff** tc cls_act programs.
> @@ -7327,6 +7347,7 @@ enum {
>  	BPF_FIB_LOOKUP_TBID    =3D (1U << 3),
>  	BPF_FIB_LOOKUP_SRC     =3D (1U << 4),
>  	BPF_FIB_LOOKUP_MARK    =3D (1U << 5),
> +	BPF_FIB_LOOKUP_VLAN    =3D (1U << 6),
>  };
>=20=20
>  enum {
> @@ -7340,6 +7361,7 @@ enum {
>  	BPF_FIB_LKUP_RET_NO_NEIGH,     /* no neighbor entry for nh */
>  	BPF_FIB_LKUP_RET_FRAG_NEEDED,  /* fragmentation required to fwd */
>  	BPF_FIB_LKUP_RET_NO_SRC_ADDR,  /* failed to derive IP src addr */
> +	BPF_FIB_LKUP_RET_VLAN_FAILURE, /* VLAN egress, parent unresolvable */
>  };
>=20=20
>  struct bpf_fib_lookup {
> @@ -7393,7 +7415,11 @@ struct bpf_fib_lookup {
>=20=20
>  	union {
>  		struct {
> -			/* output */
> +			/*
> +			 * output with BPF_FIB_LOOKUP_VLAN: set from the
> +			 * resolved egress VLAN device (see the flag); zeroed
> +			 * on other successful lookups.
> +			 */
>  			__be16	h_vlan_proto;
>  			__be16	h_vlan_TCI;
>  		};
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 2e96b4b847ce..8345295d84de 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -6201,10 +6201,28 @@ static const struct bpf_func_proto bpf_skb_get_xf=
rm_state_proto =3D {
>  #endif
>=20=20
>  #if IS_ENABLED(CONFIG_INET) || IS_ENABLED(CONFIG_IPV6)
> -static int bpf_fib_set_fwd_params(struct bpf_fib_lookup *params, u32 mtu)
> +static int bpf_fib_set_fwd_params(struct net_device *dev,
> +				  struct bpf_fib_lookup *params,
> +				  u32 flags, u32 mtu)
>  {
>  	params->h_vlan_TCI =3D 0;
>  	params->h_vlan_proto =3D 0;
> +
> +#if IS_ENABLED(CONFIG_VLAN_8021Q)
> +	if ((flags & BPF_FIB_LOOKUP_VLAN) && is_vlan_dev(dev)) {

If you move the ifdef into the if statement, the if statement can have
an else-branch that assigns params->ifindex, so you don't need the
restore dance (see below).

> +		struct net_device *real_dev =3D vlan_dev_priv(dev)->real_dev;
> +
> +		if (!is_vlan_dev(real_dev) &&
> +		    net_eq(dev_net(real_dev), dev_net(dev))) {
> +			params->h_vlan_proto =3D vlan_dev_vlan_proto(dev);
> +			params->h_vlan_TCI =3D htons(vlan_dev_vlan_id(dev));
> +			params->ifindex =3D real_dev->ifindex;
> +		} else {
> +			return BPF_FIB_LKUP_RET_VLAN_FAILURE;
> +		}
> +	}
> +#endif
> +
>  	if (mtu)
>  		params->mtu_result =3D mtu; /* union with tot_len */
>=20=20
> @@ -6214,8 +6232,10 @@ static int bpf_fib_set_fwd_params(struct bpf_fib_l=
ookup *params, u32 mtu)
>=20=20
>  #if IS_ENABLED(CONFIG_INET)
>  static int bpf_ipv4_fib_lookup(struct net *net, struct bpf_fib_lookup *p=
arams,
> -			       u32 flags, bool check_mtu)
> +			       u32 flags, bool check_mtu,
> +			       struct net_device **fwd_dev)
>  {
> +	u32 in_ifindex =3D params->ifindex;
>  	struct neighbour *neigh =3D NULL;
>  	struct fib_nh_common *nhc;
>  	struct in_device *in_dev;
> @@ -6347,16 +6367,23 @@ static int bpf_ipv4_fib_lookup(struct net *net, s=
truct bpf_fib_lookup *params,
>  	memcpy(params->smac, dev->dev_addr, ETH_ALEN);
>=20=20
>  set_fwd_params:
> -	return bpf_fib_set_fwd_params(params, mtu);
> +	if (fwd_dev)
> +		*fwd_dev =3D dev;
> +	err =3D bpf_fib_set_fwd_params(dev, params, flags, mtu);
> +	if (err =3D=3D BPF_FIB_LKUP_RET_VLAN_FAILURE)
> +		params->ifindex =3D in_ifindex;
> +	return err;

I think it's better to just move the assignment of params->ifindex
entirely into bpf_fib_set_fwd_params(), instead of this restore dance.
That way this can be simplified to:

	err =3D bpf_fib_set_fwd_params(dev, params, flags, mtu);
	if (!err && fwd_dev)
		*fwd_dev =3D dev;
       	return err;

>  }
>  #endif
>=20=20
>  #if IS_ENABLED(CONFIG_IPV6)
>  static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *p=
arams,
> -			       u32 flags, bool check_mtu)
> +			       u32 flags, bool check_mtu,
> +			       struct net_device **fwd_dev)
>  {
>  	struct in6_addr *src =3D (struct in6_addr *) params->ipv6_src;
>  	struct in6_addr *dst =3D (struct in6_addr *) params->ipv6_dst;
> +	u32 in_ifindex =3D params->ifindex;
>  	struct fib6_result res =3D {};
>  	struct neighbour *neigh;
>  	struct net_device *dev;
> @@ -6486,13 +6513,19 @@ static int bpf_ipv6_fib_lookup(struct net *net, s=
truct bpf_fib_lookup *params,
>  	memcpy(params->smac, dev->dev_addr, ETH_ALEN);
>=20=20
>  set_fwd_params:
> -	return bpf_fib_set_fwd_params(params, mtu);
> +	if (fwd_dev)
> +		*fwd_dev =3D dev;
> +	err =3D bpf_fib_set_fwd_params(dev, params, flags, mtu);
> +	if (err =3D=3D BPF_FIB_LKUP_RET_VLAN_FAILURE)
> +		params->ifindex =3D in_ifindex;
> +	return err;

Same as above.

-Toke

