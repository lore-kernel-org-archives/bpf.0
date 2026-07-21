Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B8147010E
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 17:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784656739; cv=none; b=i295yIMfMcerhsDYoaWHmM2m3OaENhQJyhl3w3XZC4R0cftRD2ZSZVfPacH/ptig4uRJFyVmiSz5iX6LDXQ9gLcYLSiLGkq5CqMRtTvHgjIOVQ1rTgerQxTRLAUO/WS3uX1JqpOcyVnV77mLTdMym21gyIcYwnVSzveEQ19w/Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784656739; c=relaxed/simple;
	bh=DiA7HdesN+zAEAiYP0dzWazQU1yHhkKz4TnRxizjK0o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iWhzUeTx3ANleYhnWJIhJF8wYEmvlKgQ8PFWnWxHhrVFG9sMatnhs1eCyUyAjpX72RzoZFrHQjrOzsOWScd+CpK3DJodiAvF3hYB6KnUQyPOQe3ICLx5oYYVLjy9uExyNkfgpdjpdXOEBnivOK+wFpBAe/7R0uXwF7EXPRGSm00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mBr/U55K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mBr/U55K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCF371F00A3A;
	Tue, 21 Jul 2026 17:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784656738;
	bh=6SIzxmyCbbX5NxasLYM/S4PLzNFZJQpmSqEtZ6giPmU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mBr/U55KcRmIYwMziqEXBjsZuRn+KelXV22jEfoI7vKoR56XgPKGkZRnPpAThnN4U
	 nT6AuJoHOASHyLZhEBNhi2RcTmH3Cx/YZ+ADbudOWkWgLy8nwhvvgux990oPsSDeUk
	 8AnVNst3Op1I+yZwsP22kCgxvYFJGBg1T1Macb0izZH1rEf//iuLlpsqS3U6cZGibA
	 2FG1qo8k7eKHR5VkDqEuqsHLrvxMI/594tRbbJ6eOMv1KCIOmD0O70o8QQVlM61ly5
	 8Bmevh894ED7krw30vNUOsMtp+tkgNw60owgmS00Vh76dGTRA1Nn6f9lgWxIl+5YoJ
	 knLR2w26OG30w==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next 3/3] selftests/bpf: build each test runner
 instance in its own sub-make
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mykola Lysenko" <nickolay.lysenko@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260721174909.8044-4-nickolay.lysenko@gmail.com>
References: <20260721174909.8044-1-nickolay.lysenko@gmail.com>
 <20260721174909.8044-4-nickolay.lysenko@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 17:58:57 +0000
Message-Id: <20260721175857.DCF371F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Parallel build race on shared helper objects (`testing_helpers.o=
`, `cgroup_helpers.o`) due to overlapping rules between the parent Makefile=
 and `Makefile.runner` sub-makes.
--

--- Patch [3]: [RFC PATCH bpf-next 3/3] selftests/bpf: build each test runn=
er instance in its own sub-make ---
commit e06c43ef78e32188e09532ae20788ac48fd20702
Author: Mykola Lysenko <nickolay.lysenko@gmail.com>
selftests/bpf: build each test runner instance in its own sub-make

This patch refactors the BPF selftests build system by moving the
double-expansion DEFINE_TEST_RUNNER logic into independent sub-makes via a
new Makefile.runner. Shared configurations and prebuilt toolchain elements
are kept in the top-level Makefile.

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index f5c0f81f61db7..a3ab525f7dfab 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile

[ ... ]

> +HELPER_OBJS :=3D $(addprefix $(OUTPUT)/,testing_helpers.o cgroup_helpers=
.o \
> +	       trace_helpers.o network_helpers.o json_writer.o		\
> +	       cap_helpers.o unpriv_helpers.o usdt_1.o usdt_2.o xsk.o)
> +
> +# $(BPFTOOL) is a prerequisite because its sub-make is what installs
> +# libbpf's internal headers (bpf/hashmap.h, bpf/libbpf_internal.h) into
> +# $(INCLUDE_DIR); without it, helpers including those headers race the
> +# install and can silently pick up the source-tree copies instead.
> +$(HELPER_OBJS): flow_dissector_load.h ip_check_defrag_frags.h		\
> +		$(VERIFY_SIG_HDR) prog_tests/tests.h $(BPFOBJ) $(BPFTOOL)

[ ... ]

> diff --git a/tools/testing/selftests/bpf/Makefile.runner b/tools/testing/=
selftests/bpf/Makefile.runner
> new file mode 100644
> index 0000000000000..4c58cc51f2514
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/Makefile.runner

[ ... ]

> +ifeq ($(RUNNER),test_progs)
> +EXTRA_SOURCES :=3D test_progs.c cgroup_helpers.c trace_helpers.c		\
> +		 network_helpers.c testing_helpers.c btf_helpers.c	\
> +		 cap_helpers.c unpriv_helpers.c sysctl_helpers.c	\
> +		 netlink_helpers.c jit_disasm_helpers.c io_helpers.c	\
> +		 test_loader.c xsk.c disasm.c disasm_helpers.c		\
> +		 json_writer.c bpftool_helpers.c usdt_1.c usdt_2.c

[ ... ]

> +EXTRA_OBJS :=3D $(patsubst %.c,$(RDIR)/%.o,$(filter %.c,$(EXTRA_SOURCES)=
))
> +LIB_OBJS   :=3D $(patsubst %.c,$(RDIR)/%.o,$(LIB_SOURCES))

[ ... ]

> +$(EXTRA_OBJS): $(RDIR)/%.o: %.c $(EXTRA_HDRS) $(TESTS_HDR) $(BPFOBJ) | $=
(RDIR)

[Severity: Medium]
Could this cause a parallel build race on the shared helper objects?

The top-level Makefile builds shared helpers like testing_helpers.o and
cgroup_helpers.o with a limited set of dependencies (shown above). However,
this EXTRA_OBJS rule inside the sub-makes encompasses those same helpers and
declares broader dependencies, such as $(LIBARENA_SKEL) for test_progs and
map_tests/tests.h for test_maps.

Because these broader dependencies are built in parallel by the top-level
make, they can end up with newer timestamps than the pre-built helpers. If
that happens, both the test_progs and test_maps sub-makes might evaluate
the helpers as out-of-date and concurrently recompile them.

Can this lead to intermittent "file truncated" or "file format not recogniz=
ed"
link errors when building with -j?

> +	$(call msg,EXT-OBJ,$(BINARY),$@)
> +	$(Q)$(CC) $(CFLAGS) -c $< -o $@

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721174909.8044=
-1-nickolay.lysenko@gmail.com?part=3D3
