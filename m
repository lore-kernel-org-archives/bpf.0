Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BA23546E1
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 14:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789137223; cv=none; b=uIzlopVsrFc6B0bJndkrPC1s8jivw/ZhRh8qfYFiTuBf4G0oG/qIbmj1s2Q2wfP27hEG+S2tThdmSuQt48cqSHorVLIwksaruAGLH2FmAnOixvo8Z3UdMb2vPeaS1MUew6SiLlPbAR/eScf/QanVYY8e01reIMgBLOQHaol/e5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789137223; c=relaxed/simple;
	bh=3E3Yn9jElfq5dtm0UVLgzmmXK2JizeYyH0LtE8kymCw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZbVq/D/nnJ9paFenz+cwAjisTZc+bY4VmS+BhaR3L2XkzMZme6kPXdHKNCVSiouZNScaaXKk+K1r+NyjOmiRIFwcXNYU3IrwH648l6oJAj+mCrYu61cvvcQZXbSSZTPUavbc2t46HS791y1gdVySml2B4EZDyUt6nCx4qfLlrfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OTWbXXwe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OTWbXXwe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7905E1F000FF;
	Fri, 11 Sep 2026 14:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789137221;
	bh=fMq3nf+lZT6QIsnWcS+gCDPZCCHR7t11Kybm0Llcwlc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OTWbXXwej3GuVjcxTQ/axB9P9U/SnYDsQbTa/McgfN/DuAIoaARu1HA5aBgFdC1p/
	 8eDuXwwoxVE6xLax9Lq8252VC6S6yJ4Wr5yTKTn6Ya8D/Ek7t97VAh70Hq/sRHZmsY
	 ETekJjH9mBmoLiIZgONcjT7ywhCWmwJHGNGj39o7Is13Ei55M919w3AeNXIs6yyPhf
	 wsOQaTINdipbAke6Q0JPoHGzBSzVOCHPQWiVPV/29LLbiE7AP/XKQofDa0tEjRBZCV
	 tjzRazOQZ9EIkqpCRi0YXiM30rWn9mRCl0vZnoIpZ7BJquXptgH0uy7f6ohooWjpF4
	 Od71xz1ZzT6bg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next] selftests/bpf: Tolerate libarena skeleton
 failures under BPF_STRICT_BUILD=0
Reply-To: sashiko-reviews@lists.linux.dev
To: "HyeongJun An" <sammiee5311@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260911141621.1944900-1-sammiee5311@gmail.com>
References: <20260911141621.1944900-1-sammiee5311@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 14:33:40 +0000
Message-Id: <20260911143341.7905E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The permissive fallback for libarena sub-makes does not remove the=
 target file on failure, leaving a corrupted or empty skeleton header that =
permanently breaks incremental builds.
- [Medium] The `bench` executable fails to link and is completely skipped w=
hen the libarena benchmark skeleton generation fails, contradicting the com=
mit message's claim that 'bench all link'.
--

commit 03a9a4a189e91e03941dfb620bf2f4bda1071094
Author: HyeongJun An <sammiee5311@gmail.com>

selftests/bpf: Tolerate libarena skeleton failures under BPF_STRICT_BUILD=
=3D0

This patch modifies the libarena skeleton build rules to respect
BPF_STRICT_BUILD=3D0, allowing the build to continue if the libarena
skeletons fail to generate. It adds permissive fallback logic to the
three libarena sub-makes.

> The build then prints SKIP-SKEL and continues, and test_progs,
> test_progs-no_alu32, test_progs-cpuv4 and bench all link.

[Severity: Medium]
Is this claim about bench linking successfully accurate when the benchmark
skeleton fails?

Looking at the bench target in the Makefile, it has a hardcoded
dependency on $(OUTPUT)/bench_libarena.o. The link command unconditionally
passes all objects to the compiler:

$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.a %.o,$^) $(LDLIBS) -o $@ ...

If the libarena benchmark skeleton fails under permissive mode,
bench_libarena.o will be missing. Because the link command doesn't
filter out skipped benchmark objects, won't this cause the entire bench
executable to fail to link and trigger SKIP-LINK instead?

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index 7ea5ba1df29e3..a9951774e5c85 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -835,17 +835,20 @@ LIBARENA_SKEL :=3D libarena/libarena.skel.h
>  LIBARENA_BENCH_SKEL :=3D libarena/libarena_bench.skel.h
> =20
>  $(LIBARENA_SKEL): $(INCLUDE_DIR)/vmlinux.h $(BPFOBJ) $(LIBARENA_BPF_DEPS)
> -	+$(MAKE) -C libarena libarena.skel.h $(LIBARENA_MAKE_ARGS)
> +	+$(MAKE) -C libarena libarena.skel.h $(LIBARENA_MAKE_ARGS) $(if $(PERMI=
SSIVE),|| \
> +		printf '  %-12s %s\n' 'SKIP-SKEL' '$(notdir $@)' 1>&2)

[Severity: High]
Does this missing cleanup leave behind a corrupted skeleton header?

In other permissive fallback rules, ($(RM) $@; printf ...) is used to
ensure the target file is removed on failure. Because shell redirection
in the sub-make might truncate the skeleton header before bpftool runs,
could an error leave a 0-byte or incomplete file behind?

If the file isn't explicitly removed here, won't subsequent incremental
builds attempt to use the corrupted skeleton header instead of rebuilding
it?

[ ... ]

>  $(LIBARENA_BENCH_SKEL): $(INCLUDE_DIR)/vmlinux.h $(BPFOBJ) $(LIBARENA_BE=
NCH_BPF_DEPS) | $(LIBARENA_SKEL)
> -	+$(MAKE) -C libarena benchmarks $(LIBARENA_MAKE_ARGS)
> +	+$(MAKE) -C libarena benchmarks $(LIBARENA_MAKE_ARGS) $(if $(PERMISSIVE=
),|| \
> +		printf '  %-12s %s\n' 'SKIP-SKEL' '$(notdir $@)' 1>&2)

[Severity: High]
Similarly, should this fallback also remove the target file with $(RM) $@ to
prevent breaking future incremental builds with a corrupted
libarena_bench.skel.h?

[ ... ]

>  ifneq ($(CLANG_HAS_ARENA_ASAN),)
>  LIBARENA_ASAN_SKEL :=3D libarena/libarena_asan.skel.h
>  CFLAGS +=3D -DHAS_BPF_ARENA_ASAN
> =20
>  $(LIBARENA_ASAN_SKEL): $(INCLUDE_DIR)/vmlinux.h $(BPFOBJ) $(LIBARENA_BPF=
_DEPS)
> -	+$(MAKE) -C libarena libarena_asan.skel.h $(LIBARENA_MAKE_ARGS)
> +	+$(MAKE) -C libarena libarena_asan.skel.h $(LIBARENA_MAKE_ARGS) $(if $(=
PERMISSIVE),|| \
> +		printf '  %-12s %s\n' 'SKIP-SKEL' '$(notdir $@)' 1>&2)

[Severity: High]
Does this fallback need the same target cleanup for libarena_asan.skel.h?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911141621.1944=
900-1-sammiee5311@gmail.com?part=3D1
