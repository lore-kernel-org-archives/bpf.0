Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797903911A8
	for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 22:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781650027; cv=none; b=C8BwkiSE2sp4YFqt7yzu0dT5n4Dnhjvlk+4NW+POo8lAYsWGER6Ng9BsfBCfmxBPTsXHln4y2nUv82TS4FoT66ms+MZPjLqEimq/AuD0nih1y7PX89ERojhiBtiYrcTyVBVzpG5IJbySCCONbfpRpJ1015387ss0bP/5/JL9Bdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781650027; c=relaxed/simple;
	bh=klDq5dKngoZSE4+u5LGqrN7puLE3upsKbMPckpRO48M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FnU3pAMqp5De4QuBa9tEf0vf+4JHhZvOx6G7hi9gY89W9lSZSF9zR6hgixH7f74HMAiP2IitA/ogDk/tH8ZPDyqsZnoUTSwC3wGpxyL2i3sWlHV8x4YQVWy7u9QvDlygdtbQ53fntekEktRhAeCgxmFjKWD26yM7FQ13vddzZWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NgzFxk4L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NgzFxk4L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 061F31F000E9;
	Tue, 16 Jun 2026 22:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781650026;
	bh=5XFmGv5NrMbveje09flEhJgOLmf6i5u0UI4HuAij8CE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NgzFxk4LS6pR7VIYGAp5GXqZL+7KpSzesjRT5UpXqf14ZxJ3cRvTu/YXZUqICq23S
	 KHLm+6LcHn7qyMdNY7o8ToeJDqmeFOaUw026sTvC5XPYrmqShHHf8NF8o1VryR25jq
	 4oi1sL0gSVcKTQSeYnN7BA0JfrcEe6ubb1vmol1se3ezwRJU4ZV3UhC0xo8+RIpkvH
	 0h3DLy5ZOlacKlkkwajcsTfyYHaietdWWpppHMf/7/RSAXpGBQwjGMgp6NoAXIrUlh
	 PppSE+zPDNB2jxOCFcZgo8mDGqGaUf/wDhWpqfpwTS4Snz+aaar56Fd4L6k85S2KS7
	 eEfTWT4UFJvVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 2/4] bpf: Add BPF_FIB_LOOKUP_VLAN flag to
 bpf_fib_lookup() helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Avinash Duduskar" <avinash.duduskar@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260616223426.3568080-3-avinash.duduskar@gmail.com>
References: <20260616223426.3568080-3-avinash.duduskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 22:47:05 +0000
Message-Id: <20260616224706.061F31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Bypassing VLAN device MTU checks when BPF_FIB_LOOKUP_VLAN is used =
without tot_len creates a PMTU blackhole.
- [Low] Multi-line comments introduced by the patch violate the BPF subsyst=
em comment style guideline.
--

commit d2aaa28c3503734e5c44721d9455da2a142a44cf
Author: Avinash Duduskar <avinash.duduskar@gmail.com>

bpf: Add BPF_FIB_LOOKUP_VLAN flag to bpf_fib_lookup() helper

bpf_fib_lookup() returns the FIB-resolved egress ifindex straight
from the fib result. When the egress is a VLAN device, the returned
ifindex is the VLAN netdev's, which has no XDP xmit handler; XDP
programs that want to forward the frame (e.g. xdp-forward) must
instead target the underlying physical device and push the VLAN tag
themselves.

> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 11dd610fa5fae..f77aa9472bf1e 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h

[ ... ]

> @@ -7388,7 +7414,10 @@ struct bpf_fib_lookup {
> =20
>  	union {
>  		struct {
> -			/* output */
> +			/* output with BPF_FIB_LOOKUP_VLAN: set from the
> +			 * resolved egress VLAN device (see the flag); zeroed
> +			 * on other successful lookups.
> +			 */

[Severity: Low]
This isn't a bug, but does this violate the BPF subsystem multi-line comment
style? The guidelines prefer the opening /* to be on its own line:

/*
 * output with BPF_FIB_LOOKUP_VLAN: set from the
 * ...
 */

>  			__be16	h_vlan_proto;
>  			__be16	h_vlan_TCI;
>  		};

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 6fa172cb13480..b37a12321fba3 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c

[ ... ]

> @@ -6119,10 +6119,40 @@ static const struct bpf_func_proto bpf_skb_get_xf=
rm_state_proto =3D {
>  #endif
> =20
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

[Severity: Low]
This isn't a bug, but this multi-line comment also starts with text on the
same line as the opening /*.

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

[Severity: Low]
This isn't a bug, but this multi-line comment also starts with text on the
same line as the opening /*.

> +		if (!is_vlan_dev(real_dev) &&
> +		    net_eq(dev_net(real_dev), dev_net(dev))) {
> +			params->h_vlan_proto =3D vlan_dev_vlan_proto(dev);
> +			params->h_vlan_TCI =3D htons(vlan_dev_vlan_id(dev));
> +			params->ifindex =3D real_dev->ifindex;

[Severity: High]
Will this cause PMTU blackholes when bpf_skb_fib_lookup() is called without
tot_len?

When tot_len is not provided, the MTU check is deferred and done in
bpf_skb_fib_lookup() after bpf_fib_set_fwd_params() returns. Because
params->ifindex is swapped to the parent device here, the deferred MTU
check looks up the parent device:

net/core/filter.c:bpf_skb_fib_lookup() {
    ...
    dev =3D dev_get_by_index_rcu(net, params->ifindex);
    if (unlikely(!dev))
        return -ENODEV;
    if (!is_skb_forwardable(dev, skb))
        rc =3D BPF_FIB_LKUP_RET_FRAG_NEEDED;
    params->mtu_result =3D dev->mtu;
    ...
}

If the VLAN device has a smaller MTU than the parent, will this incorrectly
pass oversized packets against the parent's MTU, or return the parent's
larger MTU for ICMP Fragmentation Needed responses?

> +		}
> +	}
> +#endif

> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
> index 11dd610fa5fae..f77aa9472bf1e 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h

[ ... ]

> @@ -7388,7 +7414,10 @@ struct bpf_fib_lookup {
> =20
>  	union {
>  		struct {
> -			/* output */
> +			/* output with BPF_FIB_LOOKUP_VLAN: set from the
> +			 * resolved egress VLAN device (see the flag); zeroed
> +			 * on other successful lookups.
> +			 */

[Severity: Low]
This isn't a bug, but this copied UAPI multi-line comment also starts with
text on the same line as the opening /*.

>  			__be16	h_vlan_proto;
>  			__be16	h_vlan_TCI;
>  		};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616223426.3568=
080-1-avinash.duduskar@gmail.com?part=3D2
