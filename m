Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FA623394D
	for <bpf@vger.kernel.org>; Sat,  6 Jun 2026 12:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780750734; cv=none; b=bXbo3zwzhMmTT/tuBER+3UJLQQlRqrrsyXOcYZYw2i6Uzi4nNsF46Z712l4lmXdgUAkiC0HajYVd9YgddrGafFomPn4ynNKU8SPV30ZuVTtTWiUX27urJxWC7sAzgpnckULQKXMWW3+gVGtqQYP8CHZaH934pVNL7JxtPK1abUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780750734; c=relaxed/simple;
	bh=EqvJPtnA5teucBLbeI/ds0FqKCPImsXwk643pzvAZ9U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hBS27GpV7qH2UkInWqePNrtNax6vPQT0e8R2xcj7BJtDusBJOMaU/8mgUxu0zD0n/Eg8CsCkONy0guM3gQFNr6wHvtszHjtiKcmsc35Ya/6f0K0+mfgBii+h93A+lrqCx4YdeOfVIg6wx3i7gAmYh8dflEx5LgU7t0jtomNADPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4V7WURR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4V7WURR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C59CF1F00893;
	Sat,  6 Jun 2026 12:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780750732;
	bh=d50hZeZuO3R+9269r2tPofiAbqv5vJJ56vBmJc5hhAM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N4V7WURR7DSp1rGxOeAChoeX2AnGKUATv6XU90cdcb15ikCoBIv+KNGfA2ZO9rmE2
	 qK63FxghM7gaEH1LaF3y3G7y9/x2bJXUrdNVLGOxQimgaIjL1dm1iAPgDxxiuF1gZi
	 uJYM7v07fRZxIaZ8Jt8VGijjTizwPRCGH0tm9PdolK/L/Fj7VqVyFlGgFG1eeVcU+b
	 U5CCIWBPL+DSbpxlJIYmoD3/3CipVhnmUWC0A6Sk3vRLa+sKLOBleT5nLBfZT4JBs1
	 BuzWmMHGTWvyGX0mr2rMH/rBGr8doDVK8J485L7RMNmBzRTHnaYdfJW02L3kCNezB3
	 cyfXT3QZMwkHA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv8 bpf-next 13/29] bpf: Add support for tracing multi
 link
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260606123955.345967-14-jolsa@kernel.org>
References: <20260606123955.345967-14-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 12:58:52 +0000
Message-Id: <20260606125852.C59CF1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch references several types, functions, and macros that are =
not defined in the provided patch nor in the baseline kernel tree, breaking=
 the build.
--

commit a5d1adef694d2441a8417978dc686d52f27e4a65
Author: Jiri Olsa <jolsa@kernel.org>

bpf: Add support for tracing multi link

This commit introduces support for attaching BPF programs to multiple
function BTF IDs using a new tracing multi link type. It updates the
bpf_attr::link_create structure and adds the necessary attach/detach
plumbing for architectures with ftrace direct call support.

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 5fcfc32c7cb44..953235ff02d74 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -5869,6 +5869,8 @@ static int link_create(union bpf_attr *attr, bpfptr=
_t uattr)
>  			ret =3D bpf_iter_link_attach(attr, uattr, prog);
>  		else if (prog->expected_attach_type =3D=3D BPF_LSM_CGROUP)
>  			ret =3D cgroup_bpf_link_attach(attr, prog);
> +		else if (is_tracing_multi(prog->expected_attach_type))

[Severity: Low]
Is the definition of is_tracing_multi missing from this patch? The code
might fail to compile due to an implicit declaration error here.

> +			ret =3D bpf_tracing_multi_attach(prog, attr);
>  		else
>  			ret =3D bpf_tracing_prog_attach(prog,

[ ... ]

> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index d853f97bd154f..9e3cb547651e5 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c

[ ... ]

> +#if defined(CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS) && \
> +    defined(CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS)
> +
> +static void bpf_tracing_multi_link_release(struct bpf_link *link)
> +{
> +	struct bpf_tracing_multi_link *tr_link =3D
> +		container_of(link, struct bpf_tracing_multi_link, link);

[Severity: Low]
Could struct bpf_tracing_multi_link be undefined in this context? Using
container_of with an incomplete type typically results in a build failure.

> +
> +	WARN_ON_ONCE(bpf_trampoline_multi_detach(link->prog, tr_link));
> +}

[ ... ]

> +int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr=
 *attr)
> +{
> +	struct bpf_tracing_multi_link *link =3D NULL;

[ ... ]

> +	err =3D check_dup_ids(ids, cnt);
> +	if (err)
> +		goto error;
> +
> +	link =3D kvzalloc_flex(*link, nodes, cnt);

[Severity: Low]
Does this also fail to build because struct bpf_tracing_multi_link is an
incomplete type? It looks like kvzalloc_flex might not be able to determine
the allocation size without the full struct definition.

> +	if (!link) {
> +		err =3D -ENOMEM;
> +		goto error;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260606123955.3459=
67-14-jolsa@kernel.org?part=3D1
