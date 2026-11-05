Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793920746;
	b=l1z1w+/Xk2vdeOdVdf98slkp4ecQngxjIOOpowc0WVjw8Q3RAhIcF/3LvPIm0vv8f+Qp
	 OXKzWxLsamloCXjnNoRJRTCPzOs04vBOPEN0ELU+dI744nyx6aKtxMU/JKGhha0oiju4o
	 nI4RF96JsGXJqq5RoRq+mZImAjfIym7ODyLvBUOvbJerVI+I8g50JNc5mFvY88CZJINWl
	 Q4TMwntj/n6DbPzgSSASHsGiw2e03ueLQuAbRH0lPnf0E/jIXztpitxnbtzgR7lcvaHM5
	 19cEpCQfP/qkvJBbG8yY5C2pzKq5ZK8Nwe8ii/FlmLEe4TCLgY47l3oYeBR9htoZgbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793920746;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=z3DVw2XVbogDG3LNk5Eay8yxRp1GXvk81AZ8Tll3Tw4=;
	b=J+95URp8FtZHjiVbbeNRw/FopmlSUwZtr8NdyKvkULC1OiOiN4xyDnLEt3JdMpDlpPLC
	 Uq432V+RQKL3U41EiGRG60T4iXCylo+O3Mu1XhJupiuejWMVA8qgK6i6GimG1NyRLSfK2
	 i217KI8oa6TG3ly07wjYN76ZAbgFYrbXF97uRk5hJLOQYpqKZaLtxq5kG/d3ah9zfZmCU
	 o7neP/BV/6ESE044oXDA6EVFAHY6PBu/sN/4u6jLm8+rJCLRZ67jFdZeDPkW0fALi1NF6
	 PBJ/ZuXv2dhT44Ndsv6vOmKMdF4C/5pco43bkwSpuYGz3eOjaIfeT5wpCP+k6Y4MhWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="cgUAPSe/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B39C606A326
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 23:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cgUAPSe/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 231031F0089F;
	Thu,  5 Nov 2026 23:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793920746;
	bh=z3DVw2XVbogDG3LNk5Eay8yxRp1GXvk81AZ8Tll3Tw4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=cgUAPSe/lAhaNnpeFYfWNssJiLuQSwnPbZgM5kbdWB2CtHvZ10uh9eKfM5hHqcil0
	 YVHoewjzEJJsfKEoZ4H/DJ/bYVnHyw6gndo9VrcnlxzauFp7PkRyiVVxa88TQwXYpK
	 mWucSp8qIoIPKGcP/FO6TOjA3U7oL9GiV51uKnxWOEguvJSxAZMI/5FTq2YKQE6gRi
	 T/ewSV9xro5DMGysdpmvsALDmpK5Ofdf5w3YOueRgeCi5lkL+nW4OM6SnzG4yMPzos
	 ZsErWIoNnJVaETSFfwBDZxP4NdOP0HRerjTjj+8eTUN/8geyjxipn3/U/zIiGPNcuQ
	 vpy+zsP4RDzPg==
Message-ID: <sashiko-outbox-200365@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 34/35] selftests/bpf: Test progs that run
 out of budget
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261105204513.2230344-35-alexei.starovoitov@gmail.com>
References: <20261105204513.2230344-1-alexei.starovoitov@gmail.com>
 <20261105204513.2230344-35-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 23:19:04 +0000
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
- [Medium] selftests/bpf: use RUN_JITED() in serial_test_verifier_budget()
- [Medium] selftests/bpf: loop_in_main() and loop_in_main_rcu() never run o=
ut of budget
--

commit a539b7e8368514c3719738508a3c302fb0c6d907
Author: Alexei Starovoitov <ast@kernel.org>

selftests/bpf: Test progs that run out of budget

This commit adds BPF verifier selftests for programs that exhaust their loop
or recursion runtime budget, along with a test for packet pointer invalidat=
ion
after indirect calls in verifier_callx.c.

> diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/te=
sting/selftests/bpf/prog_tests/verifier.c
> index 1424dc3036c5d..5b3eacb36a6cc 100644
> --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
> +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c

[ ... ]

> @@ -235,6 +236,8 @@ void test_verifier_bounds_mix_sign_unsign(void) { RUN=
(verifier_bounds_mix_sign_u
>  void test_verifier_bpf_get_stack(void)        { RUN(verifier_bpf_get_sta=
ck); }
>  void test_verifier_bpf_trap(void)             { RUN(verifier_bpf_trap); }
>  void test_verifier_bswap(void)                { RUN(verifier_bswap); }
> +/* Serial: many progs spin for 250 ms in an RCU read-side critical secti=
on, see timed_may_goto.c */
> +void serial_test_verifier_budget(void)        { RUN(verifier_budget); }

[Severity: Medium]
Should serial_test_verifier_budget() use RUN_JITED(verifier_budget) instead=
 of
RUN(verifier_budget) (matching test_verifier_callx() and
test_verifier_callx_rodata())?

When BPF JIT is disabled (for example with bpf_jit_enable=3D0),
is_jit_enabled() is false and prog->jit_requested is 0, while none of the
subtests in verifier_budget.c specify __load_if_JITed():

1. callback_arms_itself() has no architecture filter and passes a callback =
to
bpf_timer_set_callback(), which jit_subprogs() rejects with "callbacks are =
not
allowed in non-JITed programs".

2. Subtests with recursive subprograms (such as recursion(),
recursion_too_deep(), recursion_ends_in_the_middle(), and others) fail in
check_recursion() with -EOPNOTSUPP because bpf_prog_has_invocation_budget()
requires prog->jit_requested.

3. Subtests using unwind_goto or unwind_exit (such as loop_in_subprog_caugh=
t()
and loop_in_subprog_locked()) set prog->jit_required =3D 1 in
check_unwind_insns() and fail to load without JIT.

4. guard_all_regs_live() asserts per-cpu timed may_goto instructions
("r0 =3D &(void __percpu *)(r0)") via __xlated, which bpf_do_misc_fixups() =
only
emits when timed_may_goto is enabled.

5. In may_goto_stays_in_loop(), without timed may_goto in JIT,
bpf_do_misc_fixups() expands both may_goto_self and the verifier-added
may_goto at the loop head with separate stack counters via may_goto_expand(=
).
Each time may_goto_self counts down 8M iterations and jumps to the loop hea=
d,
the outer may_goto decrements once and may_goto_self re-initializes to 8M,
resulting in 2^46 iterations in the interpreter.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_budget.c b/tools/=
testing/selftests/bpf/progs/verifier_budget.c
> new file mode 100644
> index 0000000000000..1aa5b3eff712d
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_budget.c
> @@ -0,0 +1,1873 @@

[ ... ]

> +/* The verifier doesn't know what is in there */
> +unsigned long zero;
> +unsigned long one =3D 1;

[ ... ]

> +SEC("socket")
> +__description("budget: a loop in the main prog ends it")
> +__arch_x86_64
> +__arch_arm64
> +__success __retval(1)
> +__naked void loop_in_main(void)
> +{
> +	asm volatile (
> +		"r6 =3D %[zero] ll;"
> +	"1:"
> +		"r1 =3D *(u64 *)(r6 + 0);"
> +		"if r1 !=3D 0 goto 1b;"
> +		"r0 =3D 1;"
> +		"exit;"
> +		:
> +		: __imm_addr(zero)
> +		: __clobber_all
> +	);
> +}
> +
> +SEC("socket")
> +__description("budget: a loop in the main prog that holds something is l=
eft")
> +__arch_x86_64
> +__arch_arm64
> +__success __retval(1)
> +__naked void loop_in_main_rcu(void)
> +{
> +	asm volatile (
> +		"r6 =3D %[zero] ll;"
> +		"call %[bpf_rcu_read_lock];"
> +	"1:"
> +		"r1 =3D *(u64 *)(r6 + 0);"
> +		"if r1 !=3D 0 goto 1b;"
> +		"call %[bpf_rcu_read_unlock];"
> +		"r0 =3D 1;"
> +		"exit;"
> +		:
> +		: __imm_addr(zero),
> +		  __imm(bpf_rcu_read_lock),
> +		  __imm(bpf_rcu_read_unlock)
> +		: __clobber_all
> +	);
> +}

[Severity: Medium]
Should loop_in_main() and loop_in_main_rcu() load the address of one instead
of zero (and should loop_in_main() expect __retval(0))?

Because r6 is initialized from zero, "r1 =3D *(u64 *)(r6 + 0);" loads 0 on =
the
first trip and "if r1 !=3D 0 goto 1b;" falls through immediately without
spinning or running out of budget.

In loop_in_main(), falling through executes "r0 =3D 1; exit;" instead of ti=
ming
out on the verifier-added may_goto and jumping to the budget exit ("r0 =3D =
0;
exit;") when the main prog holds nothing. In loop_in_main_rcu(), the loop
exits via the normal branch condition on the first trip rather than timing =
out
via the verifier-added may_goto while holding the RCU read lock.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105204513.2230=
344-1-alexei.starovoitov@gmail.com?part=3D34
