Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5611A481651
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 17:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781026212; cv=none; b=mZd4agNHUN2kytCTEXl1WSE8NDzJEARVHfUsl34Nk2QJiLKzdvHrKf3OK9ftjWfAYlPN6O3EiK/wqieQwG4+HGF61yogJMS4lk5AHU82Kz7hJ53GSEK9m4k4wO4F2osfPkYGHSLEkUFVN/oL/+3Aekd5RxtCDCtzVSTatxnAhwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781026212; c=relaxed/simple;
	bh=DlrIUdGYRFh/gTaQ1ghfsNnx/4BjXr6rhptJgMYxPdI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N1wZwZ6aXu9lZ5T35SOhwb0qyGhnsA8zfL+RoN7qqvQS4JXoIve3B2rEQB1+PrV+b+2bg2xP0oeOpje69C2RKVNwYWe0RmcFogTJaMaV6mpP3aVjizdhowW+Cw00UyJ1HjsIyRBQFB5Z+RuJfeyarkAkH1N3IzsGK4I+IT6pcWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jh4oHi9/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jh4oHi9/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD7D01F00893;
	Tue,  9 Jun 2026 17:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781026210;
	bh=2Zm2ZGEdbdxdMO2GdLLafTFAlBNL587Lz8gGXrWXrvM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jh4oHi9/vmDYb4ypNtIqOq8ecquLY27zdYgE+1pfeufjI5aiXYr/V0KR/yhQHSqh9
	 z4sBOc3kJAldHuTpj9DuVP5gw+EjOaRWR7frpydmZJauWBcTG6dZLFTNJWiFWccCg+
	 cim32at40ywYZ4WFgGuE1VJWpfzR/qWiY98NwdqJReHT0w3NBFYnM7UJYuGD57vb2b
	 dImeDBt5wA/k1zqpin/OajSlxndMpOZxsulCWA807zElWKAHo/BQIzBd71HHhUcAXi
	 Rht/oB9vNVKmQ4tAVgQSSBfds0TQQZWdQ06B0w0lqOtl/fBjS+D8rlfHyczGmeH44O
	 VC0JCZv1Y2hqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next] bpf: Add BPF_FIB_LOOKUP_VLAN flag to
 bpf_fib_lookup() helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Avinash Duduskar" <avinash.duduskar@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260609172052.81613-1-avinash.duduskar@gmail.com>
References: <20260609172052.81613-1-avinash.duduskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 17:30:10 +0000
Message-Id: <20260609173010.BD7D01F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Incorrect traversal of stacked VLANs leads to dropped intermediate=
 VLAN tags due to the use of `vlan_dev_real_dev()`.
--

commit 87422c811faeffeb7be03864e938458c390f9a15
Author: Avinash Duduskar <avinash.duduskar@gmail.com>

bpf: Add BPF_FIB_LOOKUP_VLAN flag to bpf_fib_lookup() helper

This commit introduces the BPF_FIB_LOOKUP_VLAN flag for the bpf_fib_lookup()
helper. When set, if the egress resolves to a VLAN device, the helper retur=
ns
the VLAN tag and the underlying device's ifindex to allow XDP programs to p=
ush
the tag and forward the frame directly.

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 9590877b0714f..782fa86df95a3 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
[ ... ]
> @@ -6119,10 +6119,28 @@ static const struct bpf_func_proto bpf_skb_get_xf=
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
> +	if ((flags & BPF_FIB_LOOKUP_VLAN) && is_vlan_dev(dev)) {
> +		struct net_device *real_dev =3D vlan_dev_real_dev(dev);

[Severity: High]
Does this correctly handle stacked VLANs (QinQ)? Both the commit message and
the inline comment below mention that stacked VLANs are not walked and only
the immediate parent is resolved.

However, looking at the implementation of vlan_dev_real_dev() in
net/8021q/vlan_core.c:

struct net_device *vlan_dev_real_dev(const struct net_device *dev)
{
        struct net_device *ret =3D vlan_dev_priv(dev)->real_dev;

        while (is_vlan_dev(ret))
                ret =3D vlan_dev_priv(ret)->real_dev;

        return ret;
}

It appears vlan_dev_real_dev() loops through all stacked VLANs to return the
ultimate non-VLAN underlying device. If the configuration is QinQ, wouldn't
this set params->ifindex to the base physical device while only returning t=
he
topmost VLAN tag in params->h_vlan_TCI?

This could cause an XDP program to push only a single tag and drop the
intermediate VLAN tags, bypassing the outer VLAN entirely.

Should this use vlan_dev_priv(dev)->real_dev instead to only get the
immediate parent as intended?

> +
> +		/* Only the immediate parent is resolved; stacked VLANs
> +		 * (QinQ) are not walked, and a NULL real_dev (which
> +		 * is_vlan_dev() rules out in practice) keeps the
> +		 * original ifindex.
> +		 */
> +		if (real_dev) {
> +			params->h_vlan_proto =3D vlan_dev_vlan_proto(dev);
> +			params->h_vlan_TCI =3D htons(vlan_dev_vlan_id(dev));
> +			params->ifindex =3D real_dev->ifindex;
> +		}
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609172052.8161=
3-1-avinash.duduskar@gmail.com?part=3D1
