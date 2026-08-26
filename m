Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DF63C4557
	for <bpf@vger.kernel.org>; Wed, 26 Aug 2026 18:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787769265; cv=none; b=dEFac6JyrniOcLfwepHzHUzPd9TLZV44/SAsfEpo2dVp4GfSX6O2Y2wHeZL1WvAh25zpNzJM6F5h48hIt3+bDs3CPDMNBwZIGtLMlAzvxqmKnQTx7/qyaCEj6mlT7F7DLUSBxcIMrBjdJtBbh8Xoote3EB3l3eLMXZcfJfMen7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787769265; c=relaxed/simple;
	bh=8g0uwVMGpCqXOyGiPHzD7O6PC6BtS+IxSgrcEQl2B6A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZVS/929BImyGtFPB9Wnehfdb+EYh++hn7CyiU6Kgb7TVGQZfkQxmVlPKvHOq30i4RaO3n3I4o+qclNAyEKKidEDzXHGQvPX+rEHEKBuP89UBGfcemli9blHu553qjk6T8gJOQ/Oyp79YbmCxFM6tex6Q5P6v4fvtmFh5P1D0V2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AIzoK4zt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AIzoK4zt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E20FE1F00A3A;
	Wed, 26 Aug 2026 18:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787769248;
	bh=zEV04jD2BjngopJ1AcI0LUPZ9z0Y9zqncG9WB1ZqCE0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AIzoK4ztvpIHvb1M8ThiUUTOz0YC6WWh+gUv84rSATU8+dHOzgQ0iE44x4cQeMFvr
	 HC541ZASkffVrVIs8YgkwZisTJg9sBTrEHiK+6ex3S5du627eqi2lNHs1/F3DnB3VV
	 /xszZV5IDO8d3RF6AR9r1c97Ck5psk8cImLWgyg+nEklrmrIfvjKJLT60HRzMTEEcy
	 PApkAaRUUHzshZGyu14RASEVN01tumcZ8nykBYF7p7GErKRpMHbfhAqbSQU1RGxIZP
	 5140zNXjWYEg5VGwEFS34Par9EKz3DuQb0JHRHo/jHH03zQSbr9kjpJDlqoIAZxjoQ
	 5R0Ji+1+nSDXA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 3/5] libbpf: Convert
 bpf_program__set_autoload() to load-type enum
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrey Grodzovsky" <andrey.grodzovsky@crowdstrike.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260826181825.1826541-4-andrey.grodzovsky@crowdstrike.com>
References: <20260826181825.1826541-1-andrey.grodzovsky@crowdstrike.com>
 <20260826181825.1826541-4-andrey.grodzovsky@crowdstrike.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 18:34:07 +0000
Message-Id: <20260826183407.E20FE1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Modifying the signature of the public API `bpf_program__set_au=
toload` from `bool` to `enum bpf_prog_load_type` breaks ABI and C++ API com=
patibility.
- [Medium] Internal static function `bpf_program__set_dynamicload` incorrec=
tly uses the public `libbpf_err()` wrapper, causing public APIs to omit it =
on their return paths.
--

commit 21a83792a849333b99398b408870c76df6690254
Author: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>

libbpf: Convert bpf_program__set_autoload() to load-type enum

This commit converts bpf_program__set_autoload() from bool to enum
bpf_prog_load_type to unify the API. It also restores autoattach when
leaving the dynamic load type.

> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
[ ... ]
> @@ -376,7 +389,18 @@ LIBBPF_API void bpf_program__set_ifindex(struct bpf_=
program *prog,
>  LIBBPF_API const char *bpf_program__name(const struct bpf_program *prog);
>  LIBBPF_API const char *bpf_program__section_name(const struct bpf_progra=
m *prog);
>  LIBBPF_API bool bpf_program__autoload(const struct bpf_program *prog);
> -LIBBPF_API int bpf_program__set_autoload(struct bpf_program *prog, bool =
autoload);
> +/**
> + * @brief **bpf_program__set_autoload()** is retained for backwards
> + * compatibility; **bpf_program__set_load_type()** is the preferred API.
> + * The enum's numbering (DISABLED=3D0, AUTO=3D1, DYNAMIC=3D2) matches th=
e previous
> + * bool semantics (false=3D0, true=3D1), so existing bool callers keep c=
ompiling
> + * and behaving unchanged. Only BPF_PROG_LOAD_TYPE_AUTO and
> + * BPF_PROG_LOAD_TYPE_DISABLED are accepted, preserving the original
> + * autoload on/off meaning; use bpf_program__set_load_type() to set
> + * BPF_PROG_LOAD_TYPE_DYNAMIC.
> + */
> +LIBBPF_API int bpf_program__set_autoload(struct bpf_program *prog,
> +					 enum bpf_prog_load_type autoload);

[Severity: Critical]
Does this signature change introduce a regression for existing compiled
binaries and C++ consumers?

Existing binaries compiled with the old bool signature pass a 1-byte value
in a register. The new library expects a 32-bit enum, which might read
undefined garbage from the upper 24 bits of the lower 32-bit register half.

This garbage could cause the validation in bpf_program__set_autoload() to
falsely trigger and return -EINVAL:

tools/lib/bpf/libbpf.c:bpf_program__set_autoload() {
    if (autoload !=3D BPF_PROG_LOAD_TYPE_AUTO &&
        autoload !=3D BPF_PROG_LOAD_TYPE_DISABLED)
            return libbpf_err(-EINVAL);
    ...
}

Furthermore, C++ code calling bpf_program__set_autoload(prog, true) will
fail to compile because C++ does not allow implicit conversion from bool
to an unscoped enum type.

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
[ ... ]
> @@ -15295,15 +15289,28 @@ static int bpf_program__set_dynamicload(struct =
bpf_program *prog)
> =20
>  int bpf_program__set_load_type(struct bpf_program *prog, enum bpf_prog_l=
oad_type type)
>  {
> +	if (!prog)
> +		return libbpf_err(-EINVAL);
> +
>  	if (prog->obj->state >=3D OBJ_LOADED)
>  		return libbpf_err(-EINVAL);
> =20
>  	switch (type) {
>  	case BPF_PROG_LOAD_TYPE_DYNAMIC:
>  		return bpf_program__set_dynamicload(prog);

[Severity: Medium]
Does this propagate an already-wrapped error code rather than applying the
wrapper at the public boundary?

The libbpf error handling convention mandates that errno must be set exactly
at the public API boundary, and internal functions like
bpf_program__set_dynamicload() must return raw negative error codes.

Because bpf_program__set_dynamicload() incorrectly calls libbpf_err()
internally, public APIs like bpf_program__set_load_type() and
bpf_program__set_autoload() end up propagating this wrapped error code
directly without applying the wrapper on their own return paths.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826181825.1826=
541-1-andrey.grodzovsky@crowdstrike.com?part=3D3
