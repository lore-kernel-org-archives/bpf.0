Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191682D738F
	for <bpf@vger.kernel.org>; Sat, 27 Jun 2026 15:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782572487; cv=none; b=F/kZmArnNPeZ0kUU/Bg/horiy7Mx5LO/E8IDc/n5ezcfCcr5N/gqciAtDASGeZf4K1rQ3I8O8JxAcrp2ONZIV+5MA9j0q50yKGWL62wXfWCh/4qiiRjKCMVLVluPCvorEa1DRRfb0h/qD34OCle9x21aUt875+Jbrl36bsAY8Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782572487; c=relaxed/simple;
	bh=tM5g4VsLCHIYyygMGNjTeOzFPiTMnSoMAVgzubhIoMg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BwvBILWOpix/ZSQ1fV2wX49q8X4VfccphAa/tF6Ju5teD7lLdewlpPsj/qiiY/2WyIfCQN85MHxj2IO1VgUNJofmkbybh+WdiTL+Fzbm2PGrA6SiEORAbG89fBlB2sDtlD662XN62dDwQXEfocICD3SUHPZ0T50ktpFK5XsFYII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQIkf0pa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQIkf0pa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D3D41F000E9;
	Sat, 27 Jun 2026 15:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782572484;
	bh=G4tyQTevj0xnCdcD/dJJAX4ABODO7I3PpU4DATbwvKo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UQIkf0paW1JivFma6Ih1AWYkgtEYjqwEDP7w3dQjMrhe7nYo6LZt5LPRGT/8B5XyM
	 IccIv+hrLhtztyb2tNPYvW0BGcMztfiN3H49K24JPoIglZOHQ/mXCuG7DN4MVCKd8h
	 wRVTW9+im904RWkJEgYOd+6mfXqF3XLaD8tyYI2oY6jNAhtU/RbXQgsGcZLdPOYKns
	 UOOQt1j9lrBWSo7oHt1jyJtVgfrTlU07WypEeUSlkh1IYSaJPdPlo8kGh9IGk4ZCIp
	 Mg4yPjJJdVQTzS9Pm5FpnIPmYQWAmpK1e4zEEFGUe3azhfIozxeYwQPw3/+RdeOc7H
	 s0qQsSlMd/xHQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next 02/12] libbpf: Introduce bpf SDT probe
 macros
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xu Kuohai" <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <8d42452bd09872847be4c1953e4e1362db898d9a.1782571533.git.xukuohai@huawei.com>
References: <cover.1782571533.git.xukuohai@huawei.com>
 <8d42452bd09872847be4c1953e4e1362db898d9a.1782571533.git.xukuohai@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 15:01:23 +0000
Message-Id: <20260627150124.4D3D41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Hardcoded named labels in inline assembly break compilation during=
 routine compiler optimizations.
- [High] Missing `static` keyword on dummy type-checking variables causes l=
inker errors.
- [High] Missing `"memory"` clobber in inline assembly allows the compiler =
to reorder memory operations past the probe site.
- [Medium] Macro local variable names (`__a0`, `__a1`, etc.) are insufficie=
ntly obfuscated, leading to variable shadowing and trace data corruption.
- [Low] BPF subsystem multi-line comment style violation.
--

commit 225a1b2d44558cc189a9e559d3f30514eab101a7
Author: Xu Kuohai <xukuohai@huawei.com>

libbpf: Introduce bpf SDT probe macros

Introduce macros to declare and define bpf SDT probes. The declaration is
used to generate BTF ID of FUNC_PROTO for each probe site, so the probe
sites can be validated by the kernel, and observer programs can be attached
to the FUNC_PROTO like normal tracing programs.

> diff --git a/tools/lib/bpf/bpf_sdt.h b/tools/lib/bpf/bpf_sdt.h
> new file mode 100644
> index 0000000000000..23f84460aa368
> --- /dev/null
> +++ b/tools/lib/bpf/bpf_sdt.h

[ ... ]

> +#define BPF_SDT_DECLARE1(name, t0)					\
> +	___sdt_decl_attr(name, 1)					\
> +	static void (*const __sdt_type_##name)(t0);			\
> +	___sdt_chk_attr t0 __sdt_chk_##name##_0

[Severity: High]
Could this missing static keyword cause linker errors?

If a developer places BPF_SDT_DECLARE<N> in a shared header included in
multiple translation units, modern compilers defaulting to -fno-common might
throw multiple strong definition errors for these dummy variables since they
lack the static keyword.

[ ... ]

> +/* probe macros, 0-5 arguments
> + *
> + * Each probe emits a NOP (goto +0) in the program stream plus a
> + * .bpf_sdt_notes entry.  The entry begins with the ___sdt_jt_<name>

[Severity: Low]
This isn't a bug, but the BPF subsystem multi-line comment style requires
the opening /* to be on its own line.

> + * label so that libbpf can locate each entry boundary at load time.
> + * One BPF_SDT_PROBE<N> invocation per probe name is required; invoking
> + * the same name twice produces a duplicate symbol.
> + */
> +#define BPF_SDT_PROBE(name)						\
> +({									\
> +	asm volatile(							\
> +		"0:\n"							\
> +		"goto +0\n"						\
> +		".pushsection .bpf_sdt_notes,\"\",@progbits\n"		\
> +		"___sdt_jt_" #name ":\n"				\

[Severity: High]
Does this inline assembly block need a "memory" clobber?

Without it, could the compiler reorder memory operations past the probe
site, causing attached observer programs to read stale or uncommitted state
when triggered?

[Severity: High]
Can the fixed label ___sdt_jt_ #name cause a build failure?

If the compiler unrolls a loop containing this macro or inlines an
__always_inline caller multiple times, it seems the assembler would
encounter multiple identical labels and fail with a redefinition error.

[ ... ]

> +#define BPF_SDT_PROBE2(name, a, b)					\
> +({									\
> +	_Static_assert(__builtin_types_compatible_p(typeof(a),		\
> +			typeof(__sdt_chk_##name##_0)),			\
> +			"BPF_SDT_PROBE2: arg0 type mismatch");		\
> +	_Static_assert(sizeof(typeof(a)) <=3D 8,				\
> +			"BPF_SDT_PROBE2: arg0 too large, use pointer");	\
> +	_Static_assert(__builtin_types_compatible_p(typeof(b),		\
> +			typeof(__sdt_chk_##name##_1)),			\
> +			"BPF_SDT_PROBE2: arg1 type mismatch");		\
> +	_Static_assert(sizeof(typeof(b)) <=3D 8,				\
> +			"BPF_SDT_PROBE2: arg1 too large, use pointer");	\
> +	typeof(a) __a0 =3D (a);						\
> +	typeof(b) __a1 =3D (b);						\

[Severity: Medium]
Can these local variable names silently shadow caller variables?

If a caller passes a variable named __a0 as the second argument (b), does
the declaration of __a1 capture the macro's newly declared __a0 instead of
the caller's variable, resulting in the probe recording the first argument
twice?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1782571533.gi=
t.xukuohai@huawei.com?part=3D2
