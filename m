Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B634EDCD6
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 20:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789677703; cv=none; b=JcCwJq2hRP1ktaRHK5WA6FOiMDB8uzR8j00NYPXwSn0KfOcwZ6RkIkDENPcxa0l74K7yZcsw+tPdh1zY0oAOcxkMzxAwB/UizqSfqp0myJz7WPJK0Xj45cdkPcw8Lpl9gC1byGtmrzmt+iBpoQxztppqAju7Kn4Rxy24DNae48k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789677703; c=relaxed/simple;
	bh=tDvXgdjh8DLeSygJdKEPDGnXo6CURmoqj58WaXeuv24=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ojwQkTsOsgsRuMDKthud8KTnThrNRFS5Jlp/Ly5Vcu2OIN2TQmnYus+0NxHxUFKuOiqVseXv2xetI5kBUXead3u0t8b09xTnnpFE8mwesHHscMqLssUYv7Mv9Ja/mspqztQp1t6waxGkSftuv0aoSMe5SNahlL9pdXbGz1+xE2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=avX8W0UQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="avX8W0UQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF7EF1F000FF;
	Thu, 17 Sep 2026 20:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789677702;
	bh=FhTFhp1dKfrUV7EY46jRmd3mzlCAAYLIlVeYvErksHQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=avX8W0UQsMbP0yPuN2J8JT4eDhXxw1Kf0gzm9QdCB56PuFMDY47P7HfznmJaq9jou
	 teiGvBLVyoui4MNgDDubj4L7zlzEilluegCth/YJl8ONEiU+ntBzS8etabcFMoyQuI
	 Cme3D663YbrGqDagkY5T8nwbdjfE1MeR2V/a3oM+9GTgl32xOeDVXPlmAihKvyj0fz
	 zYsJMfluy3qf2ezHoOlpH+OsVaYK7doTOqDPMGOS+wnQjOjXVf68iYQaS2VktieE5K
	 jpQ4QVM5HgUDw54I5Rg7epYVbW4edBB9QcD5emq5f3Hda7ZgxkcWTjAxI59+/0KEMv
	 MCc5tYtx4pdBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 2/6] libbpf: BPF programs manual loading and
 attaching
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrey Grodzovsky" <andrey.grodzovsky@crowdstrike.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260917203040.3150212-3-andrey.grodzovsky@crowdstrike.com>
References: <20260917203040.3150212-1-andrey.grodzovsky@crowdstrike.com>
 <20260917203040.3150212-3-andrey.grodzovsky@crowdstrike.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 20:41:41 +0000
Message-Id: <20260917204141.BF7EF1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] bpf: raw error code logged instead of error string
--

commit 41645c9f0ca68e1802db1c78d41589ed30fa75e4
Author: Slava Imameev <slava.imameev@crowdstrike.com>

libbpf: BPF programs manual loading and attaching

This commit introduces a manual load strategy for BPF programs. It permits
programs to be loaded and attached independently after the initial bpf_obje=
ct
loading, which skips the auto-load pass to improve performance for utilities
with hundreds of programs.

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index bd510a4e4941c..acb8caffa442e 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> @@ -15247,3 +15310,49 @@ enum bpf_prog_load_strategy bpf_program__load_st=
rategy(const struct bpf_program
>  {
>  	return prog->load_strategy;
>  }
> +
> +/*
> + * This function must be called after bpf_object__prepare (or
> + * bpf_object__load, which calls bpf_object__prepare internally).
> + * Manually-loaded program data is initialized on object prepare.
> + * Post-prepare initialization is not supported.
> + */
> +int
> +bpf_program__load_manually(struct bpf_program *prog)
> +{
> +	int err;
> +	struct bpf_object *obj =3D prog->obj;
> +
> +	if (obj->state < OBJ_PREPARED)
> +		return libbpf_err(-EINVAL);
> +
> +	if (prog_is_subprog(obj, prog) || prog->load_strategy !=3D BPF_PROG_LOA=
D_STRATEGY_MANUAL)
> +		return libbpf_err(-EINVAL);
> +
> +	if (prog->fd >=3D 0)
> +		return libbpf_err(-EBUSY);
> +
> +	err =3D bpf_object_load_prog(obj, prog, prog->insns, prog->insns_cnt,
> +				   obj->license, obj->kern_version, &prog->fd);
> +	if (err) {
> +		pr_warn("prog '%s': failed to load manually: %d\n", prog->name, err);

[Severity: Low]
Does this code log the raw integer error code instead of a descriptive erro=
r=20
string? When bpf_program__load_manually is called and bpf_object_load_prog=
=20
returns an error, this will print the %d format specifier. Other libbpf=20
load functions typically use %s with errstr(err) to improve debuggability.

> +		return libbpf_err(err);
> +	}
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917203040.3150=
212-1-andrey.grodzovsky@crowdstrike.com?part=3D2
