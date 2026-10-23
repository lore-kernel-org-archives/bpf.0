Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792765735;
	b=4I5TmiWlFWepTSkfg7MPoE582jnQK9jQUTMNfqHVGJ5rddRuDf4zbmmLGoV8Vv5FjXlR
	 tNe4/BrzeI3UMzu1KFm6Szqn8DgOlNkphZY+3CXI0D6/5dENB7CGgAskiyG9uHSNu+jSU
	 91XxNEn2snc4XCCbUELWLIWLFW42DI2N8S7LqkYfZlfw0Nqm8B9VTMlxpxJrbPVrTI2W/
	 +QzE2Puv33Z1HFyqRlfRQnD3LiLZMGUOVxIqMYg0elsG6dDJCiqxuoFIUvYNA44yOSakQ
	 cqHdmpOuXLRp8TVB5mkpBJn5qN5Q79goJskklWy7O9u0KwY8rBc8OrY6cuWQG8GXRFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792765735;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=aVAsSVIWZnlL5yU5VCNDs7vQ1BtE7lHGYcj8oYuZoA0=;
	b=2IbnIhELdMx8awcIynk5tiHi6d6VbqOKoxNyg+cib6k0ST9es4T3L4ZHDIn2veJSBMC8
	 BuGxFHtYO7FbHPNb/AEasw+1sBzDeZx+bB2HwxmFqH4HJCw9NRnD460YSAvE1MTtSKnN9
	 eFABKNj1L27lCoam5fbl2br2lPqeBQKvzaw88op+HpMGFvXTiM/9fruQucSEAa3kI2/mR
	 XZ39YrEIx53w60J2r8GCuoDx8MrbIkiajfj2vWSYkgp1qPP4g1zHSt5nC7ZqOM5cv7vfg
	 1VPMBIPi8e/ODkw4lv+RrSdfNHCFKJ9S+JBiacLesdn+o8egv3wLbCqrtpcbjua0aKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vs5Dg0Xd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A13606A31B
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 14:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vs5Dg0Xd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D59121F01825;
	Fri, 23 Oct 2026 14:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792765735;
	bh=aVAsSVIWZnlL5yU5VCNDs7vQ1BtE7lHGYcj8oYuZoA0=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Vs5Dg0XdPQvDe4bj1yAlDomy29csWcLk822j+Mj3yTWn0KC0zAEFNAZfFQknsXIUI
	 7fvEVi5eCZysQVVLoEtTnOylqCIE1kdkhwkREtMwTVBG0aqaavDtdZEsnsLrXuH7JG
	 sTVfGTwrcAPDKnyMxKAOmTuIXoHrTga4u7JKGn/PLChT0DHgeQ5fRl2F+0AgOX/x5l
	 ZL+EWdVpY1OSi3zrkwC0MG/DfQRMJrOKVCu18OI5sjtqjZvkEbTvVCEw5VPx5MECbN
	 k3qQrEiiLwOvlQmPJPjurYCjcQ4/FsIpobZHbNIWGsLfILoYquz6W+rsHB3xNm54Bl
	 X235DYSzs386w==
Message-ID: <sashiko-outbox-182871@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] libbpf: fix symbol resolution without .symtab
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eduard Zateev" <hackerowskiy@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261023141040.249597-1-hackerowskiy@gmail.com>
References: <20261023141040.249597-1-hackerowskiy@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 14:28:54 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] selftests/bpf: missing uprobe_multi_stripped.so in RUNNER_EXTRA_=
FILES
- [Low] selftests/bpf: unfiltered -static flag breaks uprobe_multi_stripped=
.so build
--

commit 4a70746dbfb8f05e040808945c59a7d7fbba3b95
Author: Eduard Zateev <hackerowskiy@gmail.com>

libbpf: fix symbol resolution without .symtab

This commit updates elf_resolve_syms_offsets() in libbpf to clear -ENOENT
when one of the symbol tables (.symtab or .dynsym) is absent so symbol
resolution succeeds against the remaining table. It also adds a regression
selftest using a stripped shared object uprobe_multi_stripped.so.

Link: https://github.com/libbpf/libbpf/issues/953

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index 1e4af62e8312e..4125133d4dab6 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -61,7 +61,8 @@ TEST_GEN_PROGS_EXTENDED =3D \
>  	xdp_synproxy \
>  	xskxceiver
> =20
> -TEST_GEN_FILES +=3D $(TEST_KMODS) liburandom_read.so urandom_read sign-f=
ile uprobe_multi
> +TEST_GEN_FILES +=3D $(TEST_KMODS) liburandom_read.so urandom_read sign-f=
ile uprobe_multi \
> +	uprobe_multi_stripped.so

[Severity: Medium]
Should $(OUTPUT)/uprobe_multi_stripped.so also be added to
RUNNER_EXTRA_FILES in tools/testing/selftests/bpf/Makefile?

Currently RUNNER_EXTRA_FILES lists the other runtime fixtures:

    RUNNER_EXTRA_FILES :=3D $(OUTPUT)/urandom_read			\
                          $(OUTPUT)/liburandom_read.so			\
                          $(OUTPUT)/xdp_synproxy			\
                          $(OUTPUT)/sign-file				\
                          $(OUTPUT)/uprobe_multi			\

Because test_progs depends on $(RUNNER_EXTRA_FILES) (or
$(OUTPUT)/runner-extras) rather than $(TEST_GEN_FILES), running make
test_progs on a clean tree will not build uprobe_multi_stripped.so.

In addition, when flavored test runners (test_progs-no_alu32,
test_progs-cpuv4, test_progs-bpf_gcc) start, main() -> cd_flavor_subdir()
in tools/testing/selftests/bpf/test_progs.c changes the working directory
into the flavor subdirectory, where only $(RUNNER_EXTRA_FILES) are copied.
When test_attach_api_syms_stripped() in
tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c then calls:

    link =3D bpf_program__attach_uprobe_multi(skel->progs.uprobe, -1,
                                            "./uprobe_multi_stripped.so", N=
ULL, &opts);

opening ./uprobe_multi_stripped.so fails with -ENOENT.

[ ... ]

> @@ -666,6 +667,10 @@ $(OUTPUT)/uprobe_multi: uprobe_multi.c uprobe_multi.=
ld
>  	$(Q)$(CC) $(CFLAGS) -Wl,-T,uprobe_multi.ld -O0 $(LDFLAGS) 	\
>  		$(filter-out %.ld,$^) $(LDLIBS) -o $@
> =20
> +$(OUTPUT)/uprobe_multi_stripped.so: uprobe_multi_stripped.c
> +	$(call msg,BINARY,,$@)
> +	$(Q)$(CC) $(CFLAGS) -fPIC -shared -Wl,-s $(LDFLAGS) $< -o $@

[Severity: Low]
Will this target fail to link when building the BPF selftests with -static
in CFLAGS or LDFLAGS, since -static and -shared conflict when selecting
startup objects?

In tools/testing/selftests/bpf/Makefile, the $(OUTPUT)/liburandom_read.so
rule filters out -static:

    $(OUTPUT)/liburandom_read.so: urandom_read_lib1.c urandom_read_lib2.c l=
iburandom_read.map
            $(call msg,LIB,,$@)
            $(Q)$(CLANG) $(CLANG_TARGET_ARCH) \
                         $(filter-out -static,$(COMMON_CFLAGS) $(LDFLAGS)) \

Would it make sense to use $(filter-out -static,$(CFLAGS) $(LDFLAGS)) for
$(OUTPUT)/uprobe_multi_stripped.so as well?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023141040.2495=
97-1-hackerowskiy@gmail.com?part=3D1
