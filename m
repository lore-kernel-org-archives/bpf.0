Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7543E40F6
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 09:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789033884; cv=none; b=RNUtXSBnqORhTEEIMmI9UnINx1OVmEG77x+rRbH2Hbax9ev+zBuW7z1TkMaLC3XPE7fGI5qE7pqnsNWrmFVe1HZtpx7qD9WqN06dUsoPS7COX6LeSeHB0LVIff/88IkKfPVKcCsriHwjwvw8Ayf4tKO3AT5KMjeXWFy6CQ4Xhfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789033884; c=relaxed/simple;
	bh=raNsPdnEyo/dgxA1D/BggzbdqWuiqnSZBYuFzcITIWg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=un7+nOWuO9vkiqPo+CbLvJ7SvW0wke0O7wbNyakmWwCj/i3eHbhFD0k3lO4RRPPShx5mleLR9Qc7PvOGsLRtdcgaV4LyHI4SQX9GP/BxjuUpfFxTfQOIhBipEnrnFShoSCn143lQkBD7rOMdB37H/Zx8jCM69VegbGuB5pve6jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hVqS1exk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hVqS1exk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A461D1F000FF;
	Thu, 10 Sep 2026 09:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789033882;
	bh=lbYRkkYq2qJKdYZO1dHpXOPSuPrxRwadUVwGTfEkm4o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hVqS1exknRk8MegHfd9vwSbS1lAuhRjKNGSOVOJUp4/0Ec+lAvIMhSmQc/xRVpv6Q
	 DHXJ4Aq1bKsmr3GhrsS1/OKyEUWAolcdNhNMQitmL1uk5DaNuiaSbqsaN3a/BkSufO
	 rR49N1vRkKuLiYO0maEV4S1GbRxuS6xUBftvvVymvlgMn8TPD6dGJUvEWxRa2zx+fv
	 /9aoSIZ4QeaEcQEQSKTA4Fq6QhQLgkSd3ozBFQpfVfWLu5Sj6PIH3th7NoO3wdyoKf
	 OiyHyY07Njdy3kMDWKq0AkF7SS1L+m3rImqkS8wwyADdnodaBEZNxEqrdssRba7a7R
	 3UaU9wIJUuRZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5.15.y] bpf: Enforce expected_attach_type for tailcall
 compatibility
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlndWVsIEdhenF1ZXogKFNjaG5laWRlciBFbGVjdHJpYyk=?= <miguel.gazquez@bootlin.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260910-cve-2025-40123-5-15-v1-1-547774d4a00b@bootlin.com>
References: <20260910-cve-2025-40123-5-15-v1-1-547774d4a00b@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 09:51:22 +0000
Message-Id: <20260910095122.A461D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The new `expected_attach_type` enforcement for `PROG_ARRAY` maps c=
an be completely bypassed using `BPF_PROG_TYPE_EXT` (extension) programs, a=
llowing execution of restricted helpers in the wrong context.

Pre-existing issues:
- [Critical] A logic bug in `__bpf_prog_map_compatible` bypasses the `attac=
h_func_proto` compatibility check for `BPF_PROG_TYPE_EXT` programs, allowin=
g normal programs to tail call into them with incompatible register states.
--

commit e59631235c69f576df8b0685292dedba6977c75e
Author: Daniel Borkmann <daniel@iogearbox.net>
Subject: bpf: Enforce expected_attach_type for tailcall compatibility

This patch updates tailcall map compatibility checks to enforce that the
expected_attach_type of the map owner matches the expected_attach_type of
the program being inserted. This prevents programs with different contextual
restrictions from bypassing verifier constraints via tailcalls.

Link: https://lore.kernel.org/r/20250926171201.188490-1-daniel@iogearbox.net

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
[ ... ]
> @@ -1866,6 +1867,10 @@ static bool __bpf_prog_map_compatible(struct bpf_m=
ap *map,
>  		      map->owner->jited =3D=3D fp->jited;
>  		/* Note: xdp_has_frags check would go here when available */
>  		/* && map->owner->xdp_has_frags =3D=3D aux->xdp_has_frags; */
> +		if (ret &&
> +		    map->map_type =3D=3D BPF_MAP_TYPE_PROG_ARRAY &&
> +		    map->owner->expected_attach_type !=3D fp->expected_attach_type)
> +			ret =3D false;

[Severity: High]
Does this new check fully prevent expected_attach_type mismatches when
BPF_PROG_TYPE_EXT programs are involved?

In bpf_check(), the verifier clears env->prog->expected_attach_type to 0
for BPF_PROG_TYPE_EXT programs after verification. If an EXT program uses
a tail call, the PROG_ARRAY map owner is assigned an expected_attach_type
of 0.

If another EXT program with a different target but the same base type
attempts to tail-call into it, both will have their expected_attach_type
set to 0. Because 0 =3D=3D 0, the check here passes, which seems to allow t=
hem
to bypass the boundary intended by this fix.

[Severity: Critical]
This is a pre-existing issue, but I noticed the attach_func_proto mismatch
is also bypassed for EXT programs in this same function.

Earlier in __bpf_prog_map_compatible(), prog_type is determined using the
target's type:

	enum bpf_prog_type prog_type =3D fp->aux->dst_prog ?=20
				       fp->aux->dst_prog->type : fp->type;

Later, the mismatch check relies on this prog_type:

	switch (prog_type) {
	case BPF_PROG_TYPE_TRACING:
	case BPF_PROG_TYPE_LSM:
	case BPF_PROG_TYPE_EXT:
	case BPF_PROG_TYPE_STRUCT_OPS:
		ret =3D false;
		break;
	default:
		break;
	}

When an EXT program is inserted into a PROG_ARRAY (e.g., a standard XDP
map), prog_type evaluates to the target's type (BPF_PROG_TYPE_XDP). Because
it evaluates to XDP, it hits the default case in the switch statement
instead of the BPF_PROG_TYPE_EXT case.=20

Could this bypass the rejection for mismatched function prototypes and allow
a normal program to tail call into the EXT program with incompatible
register states?

>  		for_each_cgroup_storage_type(i) {
>  			if (!ret)
>  				break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910-cve-2025-4=
0123-5-15-v1-1-547774d4a00b@bootlin.com?part=3D1
