Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC13B335BB4
	for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 16:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783961305; cv=none; b=S6wApd3fxdR7PFDpRm22SmzY178KLu+6JrQc7FXg483hCXsV4VpGRxprsbgAxCiboS0aSV6L2l8OJfMdqC0McqMcdvJsnXULTfPxVlK2KAvpbEQheyndgo7FlSqAauS+sCnKGDl4JD79g8jCkQp/P/Bc2C+5puG5d44Bn/hcM+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783961305; c=relaxed/simple;
	bh=/UPK0a+rZpBFIXG7EKrHaWX9wypqhhootmsahNQfd+Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eAzNCgAJCQycQp1vz21fMlAqjq8N0vsiybThWGjQOmFm0ykZk+Nrdc747zD91iSMneNvieIkPERAixYKEX+tq4O++xAu4tEkA8IWdN5Zx5L8t729BUcWquxUfyV84IoIjmEYsr2oL7lay9b8euzR3OCgJoGGogsiIzHrI4Rf8X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PtAEtrhZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PtAEtrhZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46FA71F000E9;
	Mon, 13 Jul 2026 16:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783961304;
	bh=Oz47+z/vrKCZ3DDFMgWCYaN7SkheChoBkU+Dods81o8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PtAEtrhZY4hi4uGvndfLg5kLarOdOeJ3nyQ5/i+h2hHl/rn5NOqM0VKuYjUM9yYGD
	 8KxrzRtCGQ9cLodCfsf+YoTbBQIa1y6/s8PLE5fWIHtF6RcNpIulIjcHtQaHTb/h2o
	 3Yhun6QTcRI/xrOhXrsUXVhzQlmdh0RMXWwc8anvaltbuQp4W+sVQH8Ff23IWU82dq
	 aioL62ojGbiEEmsRS64K7eh9XJaMwIp46z4IPffQVFyTOpIBc1315fUxtVVNj+K91h
	 kCdNPhM3/AS0SERL7EP8gW1Uto8dqfBBjHBQ19DiWXFy4paQp1Oh32wylEYL5KI41l
	 q0BGUGWVzMrVw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v9 5/9] bpftool: Generate skeleton for global
 percpu data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260713154024.30851-6-leon.hwang@linux.dev>
References: <20260713154024.30851-1-leon.hwang@linux.dev>
 <20260713154024.30851-6-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 16:48:23 +0000
Message-Id: <20260713164824.46FA71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] In light skeletons, `BPF_MAP_TYPE_ARENA` maps with initial values =
are permanently leaked because `__destroy()` skips them, failing to unmap t=
heir memory.
--

--- Patch [5]: [PATCH bpf-next v9 5/9] bpftool: Generate skeleton for globa=
l percpu data ---
commit b822b756947c191db53a46cfd85674008d72587c
Author: Leon Hwang <leon.hwang@linux.dev>

bpftool: Generate skeleton for global percpu data

Enhance bpftool to generate skeletons that properly handle global percpu
variables. The generated skeleton now includes a dedicated structure for
percpu data, allowing users to initialize and access percpu variables more
efficiently.

> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> index a01d06d22d1a3..b60db11081497 100644
> --- a/tools/bpf/bpftool/gen.c
> +++ b/tools/bpf/bpftool/gen.c

[ ... ]

> @@ -669,7 +693,8 @@ static void codegen_destroy(struct bpf_object *obj, c=
onst char *obj_name)
>  		if (!get_map_ident(map, ident, sizeof(ident)))
>  			continue;
>  		if (bpf_map__is_internal(map) &&
> -		    (bpf_map__map_flags(map) & BPF_F_MMAPABLE))
> +		    ((bpf_map__map_flags(map) & BPF_F_MMAPABLE) ||
> +		     bpf_map__type(map) =3D=3D BPF_MAP_TYPE_PERCPU_ARRAY))
>  			printf("\tskel_free_map_data(skel->%1$s, skel->maps.%1$s.initial_valu=
e, %2$zu);\n",
>  			       ident, bpf_map_mmap_sz(map));

[Severity: High]
This is a pre-existing issue, but does this manual internal map check cause
BPF_MAP_TYPE_ARENA maps to be permanently leaked in light skeletons?

ARENA maps with initial values appear to be skipped here because
bpf_map__is_internal() evaluates to false for them. This skips the generati=
on
of the skel_free_map_data() call.

Since ARENA maps can be very large, skipping them during skeleton destructi=
on
leaks both the userspace virtual memory (VMA) and the underlying kernel
bpf_map object, as the VMA holds a file reference to it. This can lead to
resource exhaustion if a daemon repeatedly reloads BPF policies.

Could this code be updated to use is_skel_data() instead of get_map_ident()
and bpf_map__is_internal() so that ARENA map memory is correctly unmapped a=
nd
freed?

>  		codegen("\

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713154024.3085=
1-1-leon.hwang@linux.dev?part=3D5
