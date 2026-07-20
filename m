Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D1440FDA0
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 12:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784550150; cv=none; b=K6LQJfVyCed0o7p2laHO1EvpCg3gAv8CNcyaREtK+/qZNv9xdYJeyV4I4TgcrEvpGRKOgvT9pheXBYFrscpS3UAwtPJi6Kc0Ut/ydoLLx7y5qnyeq7pjMqBBJM4CFXxAYqB5dUSk3fJEBEANW5H2RvtsUjI+nmEvDZssFM+e+ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784550150; c=relaxed/simple;
	bh=x8S3GcVNnxtB7K00XX6l1xPEe2l3GGT7pO2F0Xz7+JE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hSLzSzACBzrwOmpWI9hZzwDx65AOkvJdnpnfNehjPSLPCGkykyZ1J9A4kAGB7fYDeFlR3GOfudrCOobgoZPa2hVS2+N/IFehYI63zwWu1bnyYhpozR6/6tBdUQCPAIju1x+qbI9iuUKfN0J14ILKHsa/s/aSRH78uEvWxWtDLBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=USPQApPM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="USPQApPM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77DE11F00A3A;
	Mon, 20 Jul 2026 12:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784550148;
	bh=3//aF8I0zNDL3Ac4X6nVsZn0RLwK9SoGtITpgBlt4UM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=USPQApPM3Ymd03YRw2tzufAsu9TLnoT19VR0EXPbA9in5QlD5lyzS9lUzgE9XiXBM
	 w07FIxR11TTKfk2YXLpQfn3vvN3uQdrM2/DM01WlCJTMQv4fxjKKrKx0GU9eojnksp
	 FDyO64C+RBwfP6mdWCgbGTep+vDWvo4TlexF9D8pkkE8/gvfOw0W4zqslaETCsrRLh
	 IdejyC3JwGj6udHHiuqYHWjs+ya4R9IRhTVQkH1b3VJI/qi/a2o80uYYCS8i3XgQ3v
	 W9SUD1Nk2Tw4Zkjr7yHDOS6FxEQ0FHFf5JlYg9pXgGE/QFk8BgG6wejc/Bn1EjdPWk
	 PBeRdwTHc/ZYg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 20/21] selftests/exec: test binfmt_misc loader
 substitution
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260720-work-bpf-binfmt_misc-ptinterp-v1-20-ddb76c9a508e@kernel.org>
References: <20260720-work-bpf-binfmt_misc-ptinterp-v1-0-ddb76c9a508e@kernel.org>
 <20260720-work-bpf-binfmt_misc-ptinterp-v1-20-ddb76c9a508e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 12:22:28 +0000
Message-Id: <20260720122228.77DE11F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Missing NULL check for the map pointer returned by `bpf_object__=
find_map_by_name` before passing it to `bpf_map__attach_struct_ops`.
- [Medium] An unhandled `read()` error on `/proc/<pid>/auxv` leads to a mas=
sive out-of-bounds array read due to implicit type conversion on 32-bit arc=
hitectures.
--

--- Patch [20]: [PATCH 20/21] selftests/exec: test binfmt_misc loader subst=
itution ---
commit 7fb50e082768e7f213f616cf84985ff4feb60ccd
Author: Christian Brauner <brauner@kernel.org>
Subject: selftests/exec: test binfmt_misc loader substitution

This commit exercises the 'L' flag end to end by running a payload as the m=
ain
image with a copy of the system loader substituted for its PT_INTERP. It al=
so
introduces a bpf-side BPF_BINPRM_LOADER test path.

> diff --git a/tools/testing/selftests/exec/binfmt_misc_bpf.c b/tools/testi=
ng/selftests/exec/binfmt_misc_bpf.c
> index 483c46e134107..926db50d39d54 100644
> --- a/tools/testing/selftests/exec/binfmt_misc_bpf.c
> +++ b/tools/testing/selftests/exec/binfmt_misc_bpf.c

[ ... ]

> +static int bpf_case_start(struct bpf_case *c, const char *objfile,
> +			  const char *handler, const char *entry)
>  {
> -	struct bpf_object *obj;
> -	struct bpf_map *map;
> -	struct bpf_link *link;
> -	int ret =3D -1;
> +	c->obj =3D NULL;
> +	c->link =3D NULL;
> +	c->entry =3D entry;
> =20
> -	obj =3D bpf_object__open_file(objfile, NULL);
> -	if (!obj || libbpf_get_error(obj)) {
> +	c->obj =3D bpf_object__open_file(objfile, NULL);
> +	if (!c->obj || libbpf_get_error(c->obj)) {
>  		fprintf(stderr, "open %s failed\n", objfile);
> +		c->obj =3D NULL;
>  		return -1;
>  	}
> -	if (bpf_object__load(obj)) {
> +	if (bpf_object__load(c->obj)) {
>  		fprintf(stderr, "load %s failed (check dmesg for the verifier log)\n",
>  			objfile);
> -		goto close;
> -	}
> -	map =3D bpf_object__find_map_by_name(obj, handler);
> -	if (!map) {
> -		fprintf(stderr, "no struct_ops map '%s' in %s\n", handler, objfile);
> -		goto close;
> +		goto fail;
>  	}
> -	link =3D bpf_map__attach_struct_ops(map);
> -	if (!link || libbpf_get_error(link)) {
> +	c->link =3D bpf_map__attach_struct_ops(
> +			bpf_object__find_map_by_name(c->obj, handler));
> +	if (!c->link || libbpf_get_error(c->link)) {

[Severity: Medium]
Is it possible for bpf_object__find_map_by_name() to return NULL here if th=
e=20
map isn't found?

If it does return NULL, passing it directly to bpf_map__attach_struct_ops()
will cause a segmentation fault because the attach API unconditionally=20
dereferences the map pointer to check its type. The original code included a
check for a NULL map before attempting to attach.

>  		fprintf(stderr, "attach struct_ops '%s' failed\n", handler);
> -		goto close;
> +		c->link =3D NULL;
> +		goto fail;
>  	}

[ ... ]

> diff --git a/tools/testing/selftests/exec/binfmt_misc_loader.c b/tools/te=
sting/selftests/exec/binfmt_misc_loader.c
> new file mode 100644
> index 0000000000000..97fa0247ab53e
> --- /dev/null
> +++ b/tools/testing/selftests/exec/binfmt_misc_loader.c

[ ... ]

> +static int ptrace_probe(const char *target)
> +{
> +	unsigned long auxv[2 * 64], base =3D 0, entry =3D 0, at_flags =3D 0;
> +	unsigned long start_code =3D 0, end_code =3D 0;
> +	int status, fd, execfd_seen =3D 0, failed =3D 0;
> +	char path[64], buf[PATH_MAX];
> +	ssize_t n;
> +	pid_t pid;
> +	int i;

[ ... ]

> +	snprintf(path, sizeof(path), "/proc/%d/auxv", pid);
> +	fd =3D open(path, O_RDONLY);
> +	if (fd < 0) {
> +		failed =3D 1;
> +		n =3D 0;
> +	} else {
> +		n =3D read(fd, auxv, sizeof(auxv));
> +		close(fd);
> +	}
> +	for (i =3D 0; i + 1 < (int)(n / sizeof(unsigned long)); i +=3D 2) {

[Severity: Medium]
What happens if the read() call fails and returns -1?

If n is set to -1, the loop condition implicitly converts it to an unsigned
size_t during the division: n / sizeof(unsigned long). On 32-bit platforms,
this division results in a massive positive integer (0x3FFFFFFF).=20

Because this is cast to an int, the loop will iterate far past the end of t=
he
auxv array, leading to an out-of-bounds memory read. Should this check if n
is greater than 0 before proceeding to the loop?

> +		switch (auxv[i]) {
> +		case AT_BASE:
> +			base =3D auxv[i + 1];
> +			break;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720-work-bpf-b=
infmt_misc-ptinterp-v1-0-ddb76c9a508e@kernel.org?part=3D20
