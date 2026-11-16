Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794810832;
	b=CyqZDp4USNyyKF4ALVDVBGfS28Xl506KpC5RUueFkbrY1b49+Sml1t2DW4yaIuBypl9n
	 GEJ14VrZn3fSR3X2XiIdj3pY+VzJ7Sr6lq1Pufoh3tDNWL6FkgRHhrWpVzKloF0+CY8en
	 H3bBCJ83SlfUv8iCcoALAr0ZOdjgL2xis0KOII+iWSVNVoE6TmF7vZVGz+r8RKkXfN8qE
	 gPg4Wve1zImUQ8Z9rvEfGhwtV9H2aUpsxeXoUBUR8TG5A+nx+tHKCCE6fUluz5I9Zd9lh
	 sj9EWtchk+l49dxI7fAu7+Q74oaSEZLUDU/1Q1gT9FPry9palwX8OBPJQo/3H1HNUdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794810832;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=kFwr2cb9FH7fyHR8BiuuC0sus43cLV1U281SkGqAP1A=;
	b=ld0I0XveZywN+c8bXjOBg1x0fGpqfGpxh4H9ilMQhAJT+4ijsxytKGSshqVra5n1kORG
	 2ZzHqB/IvYmmmZDl7HkfmctFfzIWY2NGQkvSo8FORrlKzW1k4S6ePsHXrO71Z+/D1DiKy
	 330iDC5+COUR2ZBkAooDvbZTBkkiJQaqkk/vgL+K77i/Xr2iibJeL5q6s/ewvvjHn8Kxk
	 GlvWFw+9lJfSvvjL27C5wpsGK7xWaiod+VpoOa7bTViLH+fGKc4UQaVVcbKJrzp2ApV0N
	 Sfzwsg4P80ZA+eh4j8hiJsZJhRg8JJQC7CjbS6mK0zErDfTE3M4377oPlVaE0kUg5ZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="HKy6N0/c";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1421606A31C
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 06:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HKy6N0/c
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A07F1F000C4;
	Mon, 16 Nov 2026 06:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794810831;
	bh=kFwr2cb9FH7fyHR8BiuuC0sus43cLV1U281SkGqAP1A=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=HKy6N0/cIzCWqNJxqKlNajCBln8zF6txXEd6RtHiDeY/ThcCE7qVrUTflRkoWiflF
	 wX6k9NKCXlP9u1XEq4nUWlqM9JzrtjuGfFD6UM5KoPvPFKwGvUURGR78HzGd3dM33R
	 ajN6YubbvRePHsjNhMDA59XOww1IJQxmgoiMLQeSDj3c4GYnt8ynyR1BSj8V2vzgm7
	 Pdfk/F58Go0jEl0KCyAhgQvWBLWAaZXMmirrFObiNovzcM5IEqvNHYGRZ5n4vDYxep
	 Nc/Iev8Dz+jo+jjtsgc0H6yimrFitZB6pjSpEOtWyDPa60QsFzrfCCiD8WaWtg6rWX
	 i7+RXmwgrLtpA==
Message-ID: <sashiko-outbox-216280@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 20/21] selftests/bpf: Test programs above the
 old limits
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261116055638.4171529-21-alexei.starovoitov@gmail.com>
References: <20261116055638.4171529-1-alexei.starovoitov@gmail.com>
 <20261116055638.4171529-21-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 06:33:51 +0000
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
- [Medium] selftests/bpf: missing __load_if_JITed() on far_pad tests in
  verifier_unwind.c
- [Medium] selftests/bpf: live_recursion() fails on JIT archs without
  private stack
--

commit a69081d640b7a0d78afbe78ef6d18103940c7493
Author: Alexei Starovoitov <ast@kernel.org>

selftests/bpf: Test programs above the old limits

This commit adds BPF verifier selftests covering large map, subprogram,
and kptr counts, calls in dead code, dead bpf_loop() callbacks, and far
unwind cleanup pads.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_no_limits.c b/too=
ls/testing/selftests/bpf/progs/verifier_no_limits.c
> new file mode 100644
> index 0000000000000..b464ad3794a57
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_no_limits.c
[ ... ]
> +void dead_recursion(void) SEC("?raw_tp") __success;
> +RECURSION(dead_recursion, 7)
> +
> +void live_recursion(void) SEC("?raw_tp") __failure __msg("in a tracing p=
rogram");
> +RECURSION(live_recursion, 6)

[Severity: Medium]
Does live_recursion() fail log matching on JIT architectures without
private stack support (such as s390x, riscv64, and loongarch64)?

For non-kprobe programs like raw_tp, check_recursion() only emits
"recursive ... in a tracing program" when bpf_enable_priv_stack() is not
NO_PRIV_STACK:

kernel/bpf/verifier.c:check_recursion() {
    ...
			if ((bpf_enable_priv_stack(env->prog) !=3D NO_PRIV_STACK ||
			     env->prog->type =3D=3D BPF_PROG_TYPE_KPROBE) &&
			    !env->prog->aux->priv_stack_requested) {
				verbose(env, "recursive %s() in a tracing program\n",
					bpf_subprog_name(env, s));
				return -EINVAL;
			}
    ...
}

When bpf_jit_supports_private_stack() is false, bpf_enable_priv_stack()
returns NO_PRIV_STACK and check_recursion() instead logs "JIT does not
support recursive calls", so __msg("in a tracing program") does not match.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_unwind.c b/tools/=
testing/selftests/bpf/progs/verifier_unwind.c
> index 5a21345c34d45..50ab11b909aed 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_unwind.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_unwind.c
> @@ -69,6 +69,36 @@ static unsigned long may_unwind(void)
>  	);
>  }
> =20
> +/* The patches of the divisions push the pad out of the 16-bit range */
> +#define FAR_PAD(name, sub)					\
> +__naked void name(void)						\
> +{								\
> +	asm volatile (						\
> +		"r6 =3D *(u32 *)(r1 + 0);"			\
> +		"r1 =3D r6;"					\
> +		"r1 -=3D " #sub ";"				\
> +		"call may_unwind;"				\
> +		unwind_goto(8202)				\
> +		"r7 =3D 1;"					\
> +		".rept 8200; r7 /=3D r6; .endr;"			\
> +		"exit;"						\
> +		"r0 +=3D 100;"					\
> +		"exit;"						\
> +		:						\
> +		: __imm_unwind_goto(8202)			\
> +		: __clobber_all);				\
> +}
> +
> +SEC("tc")
> +__arch_x86_64 __arch_arm64
> +__success __retval(7)
> +FAR_PAD(far_pad_returns, 64)
> +
> +SEC("tc")
> +__arch_x86_64 __arch_arm64
> +__success __retval(105)
> +FAR_PAD(far_pad_unwinds, 0)

[Severity: Medium]
Should far_pad_returns() and far_pad_unwinds() include __load_if_JITed()
like the other valid unwind subtests in verifier_unwind.c?

test_verifier_unwind() uses RUN(verifier_unwind) rather than RUN_JITED(),
while check_unwind_insns() sets prog->jit_required =3D 1.  When BPF JIT is
disabled, bpf_fixup_call_args() rejects both programs with -EINVAL and the
subtests fail instead of being skipped.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116055638.4171=
529-1-alexei.starovoitov@gmail.com?part=3D20
