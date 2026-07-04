Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5425384039
	for <bpf@vger.kernel.org>; Sat,  4 Jul 2026 09:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783157571; cv=none; b=f8O8iyhoF5cMsaK+nuvUFNL/xx+AK+xgkOr9zj1x6s+StlaGhRDxRqk02EKAXOjHNng7atKFA/qiNTE/Aa0Pk8xkVJDcUEQ2G37vbGhdETpKMrZo64/gupLHAGjenqBDZ1xijo2XbObgW50CytVPE4Enq0fVLEyHZmRKtl0smnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783157571; c=relaxed/simple;
	bh=eCgie/Cb4VGiruB7297IeW/HE0SSbIoNQFtLERIfYtk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HhO+0LOTiNDEoApI/7e9y/MdG7DkOwkAztlJNkX3T8Q9KFbe0S5KSGTcfXAmKMjMUsRbDmBs6we+uUSnMfHOT51kV3/2nrpVtfEb8LK3rBCxljP3PH4tCM30ZslvQ/FOYKtztuV6qmg8tILxTeaD0zdYMljnsXPvXXwXLvTQE58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bCFrmujq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bCFrmujq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ECDF1F000E9;
	Sat,  4 Jul 2026 09:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783157569;
	bh=mBW4XtrA+tSU/0Zvts8CMBJ05EXJl7zhph4s5Vv6f58=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bCFrmujqK5jYxJJhP5J6C8/qxt062uOTMxshrgVoakPCq03GavhL6/SG7brLBl7bR
	 +iImNVn8iG5Idu1HkrfMB4lJTbs6xJBrGhXP4P+8XlXVZlWoJFxhX4FaV0z3a27Xap
	 CrRdyPRElfBla2dvMln3yBCFpLox2xIjEfMrmGs/x9fi3sb//HNGEbhyjd65MK/XKE
	 hnltM8fL1TnfBsRhPAsEL6xILrO+jxoeytvPrPLiysAAi9VlolNiQgEvL3yCoHHA7B
	 lOhKOiwizcbLXjYgmm/KrhpNQ+wNM2H+QMwfhf2ciGJ+73BpvY5yKSN37qCgd1kegU
	 UxnieWlo9kMWQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v6 1/3] bpf: Add BPF_FIB_LOOKUP_VLAN flag to
 bpf_fib_lookup() helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Avinash Duduskar" <avinash.duduskar@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260704092159.1256823-2-avinash.duduskar@gmail.com>
References: <20260704092159.1256823-1-avinash.duduskar@gmail.com>
 <20260704092159.1256823-2-avinash.duduskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 04 Jul 2026 09:32:48 +0000
Message-Id: <20260704093249.8ECDF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The new `BPF_FIB_LKUP_RET_VLAN_FAILURE` return path clobbers input=
 parameters, rendering the documented 're-issue' behavior unsafe.
--

commit f83cb1c71b310219842f71a55cda54c3806b98ae
Author: Avinash Duduskar <avinash.duduskar@gmail.com>

bpf: Add BPF_FIB_LOOKUP_VLAN flag to bpf_fib_lookup() helper

This commit adds the BPF_FIB_LOOKUP_VLAN flag to bpf_fib_lookup(), allowing
XDP programs to resolve VLAN egress natively. If the egress cannot be reduc=
ed
to a physical device, the helper returns BPF_FIB_LKUP_RET_VLAN_FAILURE.

> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 89b36de5fdbb6..e00f0392e728f 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
[ ... ]
> @@ -3532,6 +3532,29 @@ union bpf_attr {
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

[Severity: High]
Does this documentation create a trap for users? The struct bpf_fib_lookup
uses unions for input and output fields, meaning several input parameters
are already clobbered by the time BPF_FIB_LKUP_RET_VLAN_FAILURE is returned.

If an XDP program follows this advice and re-issues the lookup without
BPF_FIB_LOOKUP_VLAN using the same params struct, will it execute with
garbage inputs (e.g., tbid=3D0, or an overwritten mark), potentially leading
to silent routing failures or policy bypass?

[ ... ]
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 2e96b4b847ce1..b5a45485a54bd 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
[ ... ]
> @@ -6201,10 +6201,29 @@ static const struct bpf_func_proto bpf_skb_get_xf=
rm_state_proto =3D {
>  #endif
> =20
>  #if IS_ENABLED(CONFIG_INET) || IS_ENABLED(CONFIG_IPV6)
> -static int bpf_fib_set_fwd_params(struct bpf_fib_lookup *params, u32 mtu)
> +static int bpf_fib_set_fwd_params(struct net_device *dev,
> +				  struct bpf_fib_lookup *params,
> +				  u32 flags, u32 mtu, u32 in_ifindex)
>  {
>  	params->h_vlan_TCI =3D 0;
>  	params->h_vlan_proto =3D 0;

[Severity: High]
Does this unconditionally clobber the aliased tbid input before the failure
path? In struct bpf_fib_lookup, h_vlan_proto and h_vlan_TCI share a union
with tbid.

When returning BPF_FIB_LKUP_RET_VLAN_FAILURE below, the original tbid is lo=
st,
guaranteeing the params struct is corrupted for a subsequent lookup.

> +
> +#if IS_ENABLED(CONFIG_VLAN_8021Q)
> +	if ((flags & BPF_FIB_LOOKUP_VLAN) && is_vlan_dev(dev)) {
> +		struct net_device *real_dev =3D vlan_dev_priv(dev)->real_dev;
> +
> +		if (!is_vlan_dev(real_dev) &&
> +		    net_eq(dev_net(real_dev), dev_net(dev))) {
> +			params->h_vlan_proto =3D vlan_dev_vlan_proto(dev);
> +			params->h_vlan_TCI =3D htons(vlan_dev_vlan_id(dev));
> +			params->ifindex =3D real_dev->ifindex;
> +		} else {
> +			params->ifindex =3D in_ifindex;
> +			return BPF_FIB_LKUP_RET_VLAN_FAILURE;
> +		}
> +	}
> +#endif
[ ... ]
> @@ -6347,7 +6367,7 @@ static int bpf_ipv4_fib_lookup(struct net *net, str=
uct bpf_fib_lookup *params,
>  	memcpy(params->smac, dev->dev_addr, ETH_ALEN);

[Severity: High]
Does this memcpy() overwrite the aliased mark input? In struct bpf_fib_look=
up,
smac shares a union with mark.

When bpf_fib_set_fwd_params() returns BPF_FIB_LKUP_RET_VLAN_FAILURE on the
failure path below, is the caller's original mark permanently overwritten by
the MAC address?

> =20
>  set_fwd_params:
> -	return bpf_fib_set_fwd_params(params, mtu);
> +	return bpf_fib_set_fwd_params(dev, params, flags, mtu, in_ifindex);
>  }
>  #endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260704092159.1256=
823-1-avinash.duduskar@gmail.com?part=3D1
