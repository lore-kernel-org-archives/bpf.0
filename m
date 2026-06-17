Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7410E39E178
	for <bpf@vger.kernel.org>; Wed, 17 Jun 2026 09:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781688389; cv=none; b=o3Rux+KEPxu06K1LUwxJCnKkg4smv/io6x883dMNX3Znx324ZI4rh4DdWF7eBenXXfsHEk5oL/fBJA/iGoCaats8lpTwKdzT2UiFVDb5aJcqZy1pbrvPRP9FcZ/jrOZfPo5/6b9foW/qTQGuEGRnWyr+abAbVNqKP8xPphYYyRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781688389; c=relaxed/simple;
	bh=s46IKH9C0KjfMj/YsGGN+zt62qBG1iCiNkueSfsY0H4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RgOpGy8DSP7G39jJ12Ft8IOeDZKEBFZrRXwPGwBH7c+QB+rt9Cp0XhxlbeCPFJIL+eVh1DLj5bcBcgriaVwrBmWzbtmsa7d4mroKLCOf6WWcM0bjdO1btm147yDI3am0q8M6x9FFV+7kK5NJ+XqOaeCGEd4ClcFdmdTDHJusvyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZUcA/QOt; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NwkSDYdE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZUcA/QOt";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NwkSDYdE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781688385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sMj5B6MTpxWxEzSSjWsEODq1pCHEKl35Ibvz3lZhyLw=;
	b=ZUcA/QOthgylBCtumC2GHKtXfkrp0Bq8RHnevrQqtuaEZOCRNDbH45DAmhlUGjjgZh/j3m
	x1/8MGs6YdBg0FKpurFrAAXgGbC3I8FQ1hLtrWgu2msUgI6nDmoEHVBVI27c07PhkG9A4u
	d+OEMKA+PtppcKxjWj8mLF5sBJjiU2w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-QIV425SRNfOdbv3q-suGOQ-1; Wed, 17 Jun 2026 05:26:24 -0400
X-MC-Unique: QIV425SRNfOdbv3q-suGOQ-1
X-Mimecast-MFC-AGG-ID: QIV425SRNfOdbv3q-suGOQ_1781688383
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490ab3f6e55so32448175e9.0
        for <bpf@vger.kernel.org>; Wed, 17 Jun 2026 02:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781688383; x=1782293183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sMj5B6MTpxWxEzSSjWsEODq1pCHEKl35Ibvz3lZhyLw=;
        b=NwkSDYdEMY4EiNCHkRbJE9gcnujqY+rlINR///nMmUNJxhswGCObI9BtbSZq77Z+wx
         H8t2xrT3YEpCbesR2zRrxNOrEkb10jeqqaziQNvITUG+AJVtq9f++I4eAxWmk+I8n0Uw
         NPYNRPsAigNSDm44vCXbJbggNtLRNrYcP3rFgnltSOpZFs0Yj6MgiTwMs7NC5hMc8jO6
         zyUecBfG+U9GQWzCRopS1K62Z3dMVgElvjgoBYpR6u2HZpVa7OmHPGtNVn8SfiRjmFQX
         kvfrP6poYKLLoOnMYfxrpFOi+F+Z9mx3M9taARhAgTWmO0eoMooMbEdDEzEJ9wJarPFd
         TqFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781688383; x=1782293183;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sMj5B6MTpxWxEzSSjWsEODq1pCHEKl35Ibvz3lZhyLw=;
        b=nsr17NGBJ6pOGsn7UdfMvI0Pn/PL0veYmg4DJ9yyG9QlAgKoUIHrUeXMPMlzvVHF0k
         vgbzFGaVVj7zaJmMjg2AG6lDmXz7SdLnoBu9JaWuO6750bzh7+1N1MDeLRnSoyQahFHj
         wvBwWAwrP87SMZLf+PoVJxBZFWuTwzdw+adqHFT7LfcVSDP5wwK1RR2kwOxPNjBItUPs
         2U71529Z0dz3gaeg9Xzsr1ut81F8t0qhGLlQ6FM1W69L4Qwqw1ZvYaejNRya5mzKt6Ud
         V/Giqn/rLwpWUirmBBzGa9hy4sxFkxQ79DRPBc/UY9pvcOOeaT8kKXlJvO28sP58bA5q
         /dog==
X-Forwarded-Encrypted: i=1; AFNElJ/uOtZU4U2HiYMGhYnWKcLmZTN5zXsMD/1EmHgSQY9nnNpBhInntDzjJhtNMMDsS5UIaSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwUoVoN9CG2gpyeZWKr6WqxOvVP0fc/aOqAhgaKSQiLBUH/AyI
	Wds3YgjNyHJCfHpIW3S+ovtKDI1FT84UHc1vi/jnFqiHXjIJLqq3wcn5/zi50bSYIBSNQiJ72ly
	jPutw9p13j3RbvFBoL+Z7eAbPXhZoSYBGMqGbcIMgRVtecwS/zKXMNA==
X-Gm-Gg: Acq92OGcb3N1wULZVyfVH6Ud6M4ExT8+VAIi4FZJ6l5+ZqKSM46YvzeBfzJJ3cDbLHo
	4yT2/i+NASUaeBJUOvXsTM7z6N1SqWfhTDoE0CQwu8JvmdqglvehyB7Aku93uoOq+T1+Rq+crI4
	Nl/r57c0eUxJH3nFF5EJtw2Q+Vd4V6b438INul5FFyEPZCl0LdBymEnKLeUnVg1uLAfO4fppzly
	1IijqhnncdQtUU9WEmlrlSSGyLXTdzBkmh6fNJDiDghl4MJiRet+4ekSCpqE/eEJCjxyfUp5DaV
	P/dthMF1coCuS15H2Y/bnTlpKe1wH7/4+vBltuQftBagd9hyK5luAtpJMpC7ScPsfe5H2pjI9mI
	9DvgH8/nlrbqQvU2ycxSMc+C8Xb0wNLbVhu0=
X-Received: by 2002:a05:600c:818f:b0:490:daca:5019 with SMTP id 5b1f17b1804b1-492333ba222mr52032355e9.6.1781688382918;
        Wed, 17 Jun 2026 02:26:22 -0700 (PDT)
X-Received: by 2002:a05:600c:818f:b0:490:daca:5019 with SMTP id 5b1f17b1804b1-492333ba222mr52031525e9.6.1781688382286;
        Wed, 17 Jun 2026 02:26:22 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49230a8ec56sm128331425e9.9.2026.06.17.02.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 02:26:21 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 04B888074BF; Wed, 17 Jun 2026 11:26:21 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Avinash Duduskar <avinash.duduskar@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa
 <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, John Fastabend
 <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, Shuah Khan
 <shuah@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, Mykyta
 Yatsenko <yatsenko@meta.com>, Leon Hwang <leon.hwang@linux.dev>, KP Singh
 <kpsingh@kernel.org>, Anton Protopopov <a.s.protopopov@gmail.com>, Amery
 Hung <ameryhung@gmail.com>, Eyal Birger <eyal.birger@gmail.com>, Rong Tao
 <rongtao@cestc.cn>, bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 2/4] bpf: Add BPF_FIB_LOOKUP_VLAN flag to
 bpf_fib_lookup() helper
In-Reply-To: <20260616223426.3568080-3-avinash.duduskar@gmail.com>
References: <20260616223426.3568080-1-avinash.duduskar@gmail.com>
 <20260616223426.3568080-3-avinash.duduskar@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 17 Jun 2026 11:26:20 +0200
Message-ID: <878q8dh60z.fsf@toke.dk>
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
> and not vlan_dev_real_dev(), which walks to the bottom of a stack. For a
> stacked VLAN (QinQ) the immediate parent is itself a VLAN device; since
> one h_vlan_proto/h_vlan_TCI pair cannot describe two tags, ifindex is
> left unchanged and the vlan fields remain zero in that case. The swap
> is also skipped when the parent lives in another network namespace (a
> VLAN device can be moved while its parent stays), since its ifindex
> would be meaningless or match an unrelated device in the caller's
> namespace. The swap and the vlan fields are written only on success;
> other output fields keep their existing behaviour, so a frag-needed
> result still reports the route mtu in params->mtu_result. When the
> flag is not set, behaviour is unchanged: h_vlan_proto and h_vlan_TCI
> are zeroed and ifindex is left at the FIB result.
>
> The new block is compiled only under CONFIG_VLAN_8021Q since
> vlan_dev_priv() is not defined otherwise; without that config
> is_vlan_dev() is constant false and the flag is accepted but never
> acts.
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
>  include/uapi/linux/bpf.h       | 31 ++++++++++++++++++++++++++-
>  net/core/filter.c              | 39 ++++++++++++++++++++++++++++++----
>  tools/include/uapi/linux/bpf.h | 31 ++++++++++++++++++++++++++-
>  3 files changed, 95 insertions(+), 6 deletions(-)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 11dd610fa5fa..f77aa9472bf1 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -3527,6 +3527,31 @@ union bpf_attr {
>   *			Use the mark present in *params*->mark for the fib lookup.
>   *			This option should not be used with BPF_FIB_LOOKUP_DIRECT,
>   *			as it only has meaning for full lookups.
> + *		**BPF_FIB_LOOKUP_VLAN**
> + *			If the fib lookup resolves to a VLAN device whose
> + *			parent is a real (non-VLAN) device, set
> + *			*params*->h_vlan_proto and *params*->h_vlan_TCI from
> + *			the VLAN device and replace *params*->ifindex with the
> + *			parent's ifindex. This lets XDP programs that target
> + *			the underlying physical device (VLAN devices have no
> + *			XDP xmit) discover both the real egress ifindex and
> + *			the VLAN tag to push in one call. *params*->h_vlan_TCI
> + *			carries the VID only, with PCP and DEI bits zero; a
> + *			consumer wanting to set egress priority writes PCP
> + *			itself. *params*->smac is the VLAN device's own
> + *			address, which can differ from the parent's. Only the
> + *			immediate parent is resolved: for a stacked VLAN (QinQ)
> + *			the parent is itself a VLAN device, and since one tag
> + *			pair cannot describe two tags, *params*->ifindex is
> + *			left unchanged and the vlan fields remain zero. The
> + *			same applies when the parent is in another network
> + *			namespace, where its ifindex would be meaningless.
> + *			The swap and the vlan fields are written only on
> + *			success; other output fields keep the helper's
> + *			existing behaviour, so a frag-needed result still
> + *			reports the route mtu in *params*->mtu_result, and on
> + *			the tc path without tot_len the mtu check runs after
> + *			the swap, against the parent device.

This comment is quite long, please trim. At the very least drop:

"This lets XDP programs that target the underlying physical device (VLAN
devices have no XDP xmit) discover both the real egress ifindex and the
VLAN tag to push in one call."

and shorten:

"Only the immediate parent is resolved: for a stacked VLAN
(QinQ) the parent is itself a VLAN device, and since one tag pair cannot
describe two tags, *params*->ifindex is left unchanged and the vlan
fields remain zero. The same applies when the parent is in another
network namespace, where its ifindex would be meaningless."

to:

"The lookup only resolves the immediate parent (QinQ is not supported),
and fails if the parent is in a different namespace."

>   *
>   *		*ctx* is either **struct xdp_md** for XDP programs or
>   *		**struct sk_buff** tc cls_act programs.
> @@ -7322,6 +7347,7 @@ enum {
>  	BPF_FIB_LOOKUP_TBID    =3D (1U << 3),
>  	BPF_FIB_LOOKUP_SRC     =3D (1U << 4),
>  	BPF_FIB_LOOKUP_MARK    =3D (1U << 5),
> +	BPF_FIB_LOOKUP_VLAN    =3D (1U << 6),
>  };
>=20=20
>  enum {
> @@ -7388,7 +7414,10 @@ struct bpf_fib_lookup {
>=20=20
>  	union {
>  		struct {
> -			/* output */
> +			/* output with BPF_FIB_LOOKUP_VLAN: set from the
> +			 * resolved egress VLAN device (see the flag); zeroed
> +			 * on other successful lookups.
> +			 */
>  			__be16	h_vlan_proto;
>  			__be16	h_vlan_TCI;
>  		};
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 6fa172cb1348..b37a12321fba 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -6119,10 +6119,40 @@ static const struct bpf_func_proto bpf_skb_get_xf=
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
> +	/* vlan_dev_priv() is only defined when 8021q is built in or as a
> +	 * module; under !CONFIG_VLAN_8021Q is_vlan_dev() is constant false
> +	 * so this would be dead, but it still has to compile.
> +	 */

Superfluous comment - please drop.

> +	if ((flags & BPF_FIB_LOOKUP_VLAN) && is_vlan_dev(dev)) {
> +		struct net_device *real_dev =3D vlan_dev_priv(dev)->real_dev;
> +
> +		/* Resolve the immediate parent only. For a stacked VLAN
> +		 * (QinQ) the parent is itself a VLAN device, and a single
> +		 * h_vlan_proto/h_vlan_TCI pair cannot describe both tags;
> +		 * leave ifindex and the vlan fields untouched in that case
> +		 * rather than report the lower device with only one tag.
> +		 * The same applies when the parent lives in another netns
> +		 * (a VLAN device can be moved while its parent stays):
> +		 * its ifindex would be meaningless, or match an unrelated
> +		 * device, in the caller's namespace.
> +		 */

And this one - it's redundant with the flag description (and commit message=
).

-Toke

