Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794026262;
	b=5geJpwJAbdKnF1BnE26lLX7u8lAKG7Yj6AkHRJChkCOMAf7WqYRiCxzXpBqGJW2kGniw
	 fmH4RFVnpePoHs45RBtrVMxaBjAoH0DVU7isAObZ6SUwnMWk201EpK1oYhjR+BUIlCTSo
	 3GjbDmmXxask7UwpvY6Ub/DnYLTwH1EEhb+TYrNMebg8zox4Zb8OH64IhFYNHlE81+ihj
	 xrNst1rntzIalPyiP6n3pkJcYEuMGKAr2C9EsOqr9loGIT24UxgwqipEycAE8DqYMYDQ/
	 P0szbe/zu60NxRGMXlgW62M34W2h6McsVAarIjV7eIPZ6T/mSnP3cDNEf/y7K3cko5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794026262;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wN1vZ0WFmizSAqLkB3tXU08Bh1WOVVKaGtxid5DP8UQ=;
	b=X2U3w+3p9jTt/E9M7/l+HUmrHSTo9XOg4UTGc1fbUNM14f85B59W+LsCH/82UV9Kor56
	 dSRKD9P8ScEIsbeeIdo/AMzj9Pp+9wlYk54tIgy284w6pfKlxbZq3cWBNH1q3tn3BSByH
	 kQ0XJgENXlRy8zFVPjZVmm2xN4xT6S5pErkFSjfgQ3mlROhn/R+kx9PAd0mx8N9mDTMZT
	 A++p5ffgJwQjj+am06AmCpz2qzivXMhYgGyaceu0YBRiiwymajr3157k/E6IiKLk/0aSb
	 JLPlNiST5YK0QRm/zfoVh5pfnTA/3tJIbQl1vmW8vOhzNzUoItbv+ez84insboFSnFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Awbi2lgF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA066606A326
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 04:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Awbi2lgF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64D881F0089F;
	Sat,  7 Nov 2026 04:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794026261;
	bh=wN1vZ0WFmizSAqLkB3tXU08Bh1WOVVKaGtxid5DP8UQ=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Awbi2lgFLYiPsfDCzkWznVXeBt42qcf3bjtK5EUDn4TWyDJRqPBnQ5nOxWh7SkMNf
	 iCs0yF6xtceVBPp5vIE1840W72RLQVrT0KhehaOkMc3w40x/ItT2LW5A0ADqKlA7Oj
	 VI7xI33zDyK0OK7xBpDg4lL+btfPkkcNKj0TAcfwCT5opFBjWE7MkIkL6q7KWzD5fS
	 XCDiP8biP1D1ATgHBre5J3WPuaT3ozzh8folMISEcJ94W1qJLj1ZUMff8Gjx51M/eq
	 a8bSEB9jW4ZfY6gkv6Lk8izlZNG2mOmLoRXQjQYnzB+ZrqRaxL7j3pxGgjOlj8QHpj
	 MHl4pLnZrD3PQ==
Message-ID: <sashiko-outbox-202589@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 46/46] selftests/bpf: Test progs without
 bpf_for(), zero, can_loop and such
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261107033758.1547725-47-alexei.starovoitov@gmail.com>
References: <20261107033758.1547725-1-alexei.starovoitov@gmail.com>
 <20261107033758.1547725-47-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 04:37:40 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] selftests/bpf: missing BTF kfunc skip check in
  test_plain_c_test_wakeup_source()
- [Low] selftests/bpf: missing __skip_without_arena in plain_c
  arena_htab and arena_list
--

commit 803ffb91b4f8392f64289683ec7ad50605335c6c
Author: Alexei Starovoitov <ast@kernel.org>

selftests/bpf: Test progs without bpf_for(), zero, can_loop and such

This commit adds plain-C versions of existing BPF selftest programs
without verifier-oriented loop macros and workarounds, along with test
runners in prog_tests/plain_c.c.

> diff --git a/tools/testing/selftests/bpf/prog_tests/plain_c.c b/tools/tes=
ting/selftests/bpf/prog_tests/plain_c.c
> new file mode 100644
> index 0000000000000..b7305118a4541
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/plain_c.c
> @@ -0,0 +1,160 @@

[ ... ]

> +/* prog_tests/arena_list.c: add 1000 elems, delete them, compare the sum=
s */
> +static void arena_list_add_del(void)
> +{
> +	LIBBPF_OPTS(bpf_test_run_opts, opts);
> +	struct plain_c_arena_list *skel;
> +	int cnt =3D 1000, sum =3D cnt * (cnt - 1) / 2;
> +
> +	skel =3D plain_c_arena_list__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "open_and_load"))
> +		return;
> +	skel->bss->cnt =3D cnt;
> +	ASSERT_OK(bpf_prog_test_run_opts(bpf_program__fd(skel->progs.arena_list=
_add), &opts),
> +		  "add");
> +	if (skel->bss->skip) {
> +		test__skip();
> +		goto out;
> +	}

[ ... ]

> +void test_plain_c_arena_htab(void) { RUN(arena_htab); }
> +void test_plain_c_arena_htab_asm(void) { RUN(arena_htab_asm); }
> +
> +void test_plain_c_arena_list(void)
> +{
> +	RUN(arena_list);
> +	if (test__start_subtest("run"))
> +		arena_list_add_del();
> +}

[ ... ]

> +void test_plain_c_test_wakeup_source(void) { RUN(test_wakeup_source); }

[Severity: Medium]
Does test_plain_c_test_wakeup_source() fail when CONFIG_PM_SLEEP is not
enabled in the kernel (for example on s390x, where ARCH_SUSPEND_POSSIBLE
and ARCH_HIBERNATION_POSSIBLE are not supported)?

plain_c_test_wakeup_source.c declares bpf_wakeup_sources_read_lock(),
bpf_wakeup_sources_read_unlock(), and bpf_wakeup_sources_get_head() as
strong __ksym externs.  Unlike test_wakeup_source() in
prog_tests/wakeup_source.c, which checks vmlinux BTF for
bpf_wakeup_sources_get_head and calls test__skip() when absent,
test_plain_c_test_wakeup_source() unconditionally invokes
RUN(test_wakeup_source), causing bpf_object__load() to fail with
unresolved kfunc externs.

> diff --git a/tools/testing/selftests/bpf/progs/plain_c_arena_htab.c b/too=
ls/testing/selftests/bpf/progs/plain_c_arena_htab.c
> new file mode 100644
> index 0000000000000..10a50b5058ddb
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/plain_c_arena_htab.c
> @@ -0,0 +1,222 @@

[ ... ]

> +SEC("syscall")
> +__success __retval(0)
> +#if !defined(__clang__) && defined(BPF_ARENA_FORCE_ASM)
> +__skip("GCC calls htab_init(): a global function gets an arena pointer a=
s a scalar")
> +#endif
> +int arena_htab_llvm(void *ctx)
> +{
> +#if defined(__BPF_FEATURE_ADDR_SPACE_CAST) || defined(BPF_ARENA_FORCE_AS=
M)

[ ... ]

> +#else
> +	skip =3D true;
> +#endif
> +	return 0;
> +}

[Severity: Low]
Should arena_htab_llvm() (when BPF_ARENA_FORCE_ASM is not defined) and
arena_list_add() / arena_list_del() in plain_c_arena_list.c be annotated
with __skip_without_arena, similar to plain_c_arena_strsearch.c and
plain_c_verifier_arena_large.c?

Without __BPF_FEATURE_ADDR_SPACE_CAST (such as in test_progs-bpf_gcc or
test_progs-no_alu32), these programs compile to `skip =3D true; return 0;`,
and RUN(arena_htab) and RUN(arena_list) load the no-op stubs via
test_loader without checking skel->bss->skip, reporting OK instead of
SKIP.  Also, arena_list_add_del() in prog_tests/plain_c.c calls
test__skip() without printing a reason message.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107033758.1547=
725-1-alexei.starovoitov@gmail.com?part=3D46
