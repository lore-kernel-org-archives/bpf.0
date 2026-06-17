Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849C634FF79;
	Wed, 17 Jun 2026 07:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781679752; cv=none; b=czEv77ryxTZ6URTOEPQ0/bAbAMT3XRvCaQil4wcnUiB9hmP7UiotBwq4abk5eer1x7chn/0N30Ykj28VNdlwWVr8LWsNAc3biNKrr7E6eANwIcYKiX4MYOHrTpAalyUHrOdOWd7fzcbUzv6kWKOn4m4RLd/5cIgAhNTgNl2KkFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781679752; c=relaxed/simple;
	bh=QC/m4Ge72NarEgPPZnenQ8Z2ImAe81ATwGkWWw5fkVI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LNT23tYVWgv0lSig91ldhoinbxw546Z7OOOlVjyPFqJHz/PkblWut+3xShtOe8CuMfm6iCa/MX5eByHMYhmI4eLQ9ETxEGJRAXWqzooA57GlNwFD6xsyPgmYCzWm6IcG20RaQNK6VUq9n0eKtBCkf0v9cBxA3SJTsdzfJu2qbUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eq8F7qx0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eq8F7qx0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F03CB1F000E9;
	Wed, 17 Jun 2026 07:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781679751;
	bh=vP8VNXwJPI7kFbdNWCLWfd1RxXCQsIHlr7yJImNXR7Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Eq8F7qx0ErUZyeimSpoAey3+Aak+f6qnsF9u//0UVvYGt9DWzgwE4+ZSmeNs20ocp
	 kq7Zb7gdkpog4og1ERcRiwq/lHETSPI14E4fKVWeqJxfc6+OASvdEnK6dhanjYcQkZ
	 CJ8p8EN0tyKjefPr/c21+8W+9SceGgkIrqkSxrrq4mNJb0OXDlIk7rZWlM/n+Ezwq2
	 q1jG4rx3JYsWXxDSRkLaOWbK0Q0lJc2yiOXjRyKoLMkdQxVs1EbkPD4okC2DJPcZMK
	 8km8mIkk+RilbbFHALZkwG8VPXTxSLcqhuMrq/nOU2Vg3BeE/A0sxdLggj2C8/GBdM
	 CaB3BTCr21b6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tools/sched_ext: scx_flatcg: Fix inverted vtime delta
 accounting
Reply-To: sashiko-reviews@lists.linux.dev
To: luoliang@kylinos.cn
Cc: bpf@vger.kernel.org, sched-ext@lists.linux.dev
In-Reply-To: <20260617064805.3901965-1-luoliang@kylinos.cn>
References: <20260617064805.3901965-1-luoliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 07:02:30 +0000
Message-Id: <20260617070230.F03CB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Artificial clamping of `cvtime` at `S64_MAX` causes cgroup starvat=
ion.

Pre-existing issues:
- [High] RB-tree node comparison breaks when virtual time naturally wraps a=
round.
--

commit 4fba932e11addf1840854e2adfbd301dff527f34
Author: Liang Luo <luoliang@kylinos.cn>

tools/sched_ext: scx_flatcg: Fix inverted vtime delta accounting

This commit fixes inverted vtime delta accounting in try_pick_next_cgroup()
and fcg_dispatch(). It addresses an issue where early yields were penalized
and overruns resulted in massive positive cvtime_delta values due to unsign=
ed
underflow. The patch applies the refund using a signed domain to correctly
reduce virtual time without wrapping.

> diff --git a/tools/sched_ext/scx_flatcg.bpf.c b/tools/sched_ext/scx_flatc=
g.bpf.c
> index fec3595818269..a37f5b876da8f 100644
> --- a/tools/sched_ext/scx_flatcg.bpf.c
> +++ b/tools/sched_ext/scx_flatcg.bpf.c
> @@ -249,15 +249,26 @@ static void cgrp_refresh_hweight(struct cgroup *cgr=
p, struct fcg_cgrp_ctx *cgc)
> =20
>  static void cgrp_cap_budget(struct cgv_node *cgv_node, struct fcg_cgrp_c=
tx *cgc)
>  {
> -	u64 delta, cvtime, max_budget;
> +	s64 delta;
> +	u64 cvtime, max_budget;
> =20
>  	/*
>  	 * A node which is on the rbtree can't be pointed to from elsewhere yet
>  	 * and thus can't be updated and repositioned. Instead, we collect the
>  	 * vtime deltas separately and apply it asynchronously here.
>  	 */
> -	delta =3D __sync_fetch_and_sub(&cgc->cvtime_delta, cgc->cvtime_delta);
> -	cvtime =3D cgv_node->cvtime + delta;
> +	delta =3D (s64)__sync_fetch_and_sub(&cgc->cvtime_delta, cgc->cvtime_del=
ta);
> +	/*
> +	 * cvtime_delta may be negative (early-yield refund from fcg_dispatch()=
).
> +	 * Apply it in the signed domain and clamp the resulting cvtime at zero
> +	 * so that a refund larger than the accumulated cvtime doesn't roll the
> +	 * field negative.
> +	 */
> +	s64 vtime =3D (s64)cgv_node->cvtime + delta;
> +
> +	if (vtime < 0)
> +		vtime =3D 0;
> +	cvtime =3D (u64)vtime;

[Severity: High]
Does casting the absolute unsigned virtual time cgv_node->cvtime to s64
cause issues when cvtime crosses S64_MAX?

Because cvtime is scaled by inverse weight and advanced by the number of
active CPUs, a lowest-weight cgroup on a multi-core machine can exceed S64_=
MAX
in just 18-20 minutes of runtime. Once cvtime crosses S64_MAX, the (s64)
cast yields a negative number, causing the clamping logic to reset the
cgroup's cvtime to 0.

With its virtual time near 0 while all other cgroups are near S64_MAX, could
this cause the affected cgroup to be exclusively prioritized by the schedul=
er,
completely starving the system until its cvtime catches up again?

[ ... ]

While reviewing this patch, I noticed a pre-existing issue nearby:

tools/sched_ext/scx_flatcg.bpf.c:cgv_node_less() {
	struct cgv_node *cgc_a, *cgc_b;

	cgc_a =3D container_of(a, struct cgv_node, rb_node);
	cgc_b =3D container_of(b, struct cgv_node, rb_node);

	return cgc_a->cvtime < cgc_b->cvtime;
}

[Severity: High]
This is a pre-existing issue, but does using standard unsigned comparison
for cvtime break the RB-tree sorting when virtual time naturally wraps arou=
nd?

Because cvtime is scaled by inverse weight and advanced by all active CPUs
simultaneously, it can naturally wrap around U64_MAX in tens of minutes for
low-weight cgroups on large multi-core machines. When a cgroup's cvtime wra=
ps
back near 0, the unsigned comparison incorrectly considers it strictly smal=
ler
than all other non-wrapped cgroups.

Could this keep the wrapped cgroup at the front of the RB-tree and prioriti=
ze
it indefinitely, starving all other cgroups until its cvtime catches up to
U64_MAX again? Should this comparison use the wrap-safe time_before() macro?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617064805.3901=
965-1-luoliang@kylinos.cn?part=3D1
