Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793920648;
	b=44L4ZexeYPAIAr5GZraotf0E/EqulQcaxgPT+Woh9ezYCtXBogVL/gNs2ZkTdbfL51km
	 YsjTJqjPJHA2Zf22y2rhK0MbQ353JMkhGav7ReTdW6CO3NZF+wQMKP8x4YBmDdiYvfAxB
	 sW6U1wIuAto2EZcjcIyy6yHVGxj+Yi6hyElGKVfHqyAOLBfWBdSxZBjIBvZafiTf7aoqe
	 3TtDv01HnqVEiRuKl0sERBlBNNPGtphrIflTy2eynX8dErSYt+VP4D+JiuSUP0MrfDp0k
	 tgfAI+Tm7hGun5GjNrjG5nacnWCuuT9pPaaKNo8utWLgIWyxLE7GVg7NxqZlf6yhRqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793920648;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nS8K+tTrCD60z97KzHtCQ+Aw8s9IoPw3sQcXiQqJaTA=;
	b=g5Xy9vzWBO7FU4vZDoDdBAYCQQvgiZNf6LgCkm4BvqS9euKA+yntWVbrneJ5ABH4+uAl
	 QBbMPX0u6TlO/i49ni8STjO49vaMCduXB64k22/CZ4MFDRZkx1vHQaRsaEhFq613fwrFn
	 7Ft94QqrS8OeXE4gStndpg166wVXnnvCB+zs6iww02vp6q2HV5vcETpKkJmdxq6OL+vTt
	 vT0h6z2Lg0dybtr1UYyLotT1gIDlw2xTZd6PnWMc9ElbjPXfvcJwKPZ6uildBFR3TrLQs
	 RwdCLFg9Ze5TGmTyQzNbBhVdFxuw47WIELX3acghfj/OoVbLaoyt3Aoxza8e9AOQmZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EdbTYVX9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43688606A31B
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 23:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EdbTYVX9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBF3A1F008A3;
	Thu,  5 Nov 2026 23:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793920647;
	bh=nS8K+tTrCD60z97KzHtCQ+Aw8s9IoPw3sQcXiQqJaTA=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=EdbTYVX9hUWw6N88pvFkoWF5beWzR92P3x64rYUvWUXgMLVhVRCi5E1WHHws+l+c9
	 cuU6Q9Fu0FKqCBr2T23KnFrldlJbLX3mWKZ86q2f1fOfHO9DQCprzzknV2AV9PxR7V
	 6KrllwP2vw1Ucxocy41MngyCjf+s3z79Hw8mkPhImyrqb+4nwYw46/sToWmySfXYNb
	 5KTYsDaBrIOekatOnnSqHEmT4jYTQx0wV4XO/vB4sl+mqNDKUT6WH1mb/F9sDKyGWl
	 qomeJoIZPcf8o6znk2A9q2+EVDlJ7PY6qS1frkN66p/HhOJz5nAHdmqF9+JjCdInHm
	 xH2qZTshWzz7w==
Message-ID: <sashiko-outbox-200362@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 35/35] selftests/bpf: Test callx of one of a
 set of functions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261105204513.2230344-36-alexei.starovoitov@gmail.com>
References: <20261105204513.2230344-1-alexei.starovoitov@gmail.com>
 <20261105204513.2230344-36-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 23:17:27 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] selftests/bpf: missing __load_if_JITed() in callx_one_of_two_not=
_written()
--

commit ba1c0308dc6dec8af4c86b33d496967258a01c7c
Author: Alexei Starovoitov <ast@kernel.org>

selftests/bpf: Test callx of one of a set of functions

This commit adds verifier selftests covering indirect calls (callx) to a set
of functions loaded from read-only tables, callback verification, state lim=
its,
stack arguments, and BTF-declared argument liveness.

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c b/too=
ls/testing/selftests/bpf/progs/verifier_stack_arg.c
> index 9cd4fee561b23..dfb16434572dc 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
> @@ -530,6 +530,60 @@ __naked void null_check_of_stack_arg(void)
>  	: __clobber_all);
>  }
> =20
> +static __naked __noinline __used long adds_arg6_arg7(long a, long b, lon=
g c, long d, long e,
> +						     long f, long g)
> +{
> +	asm volatile (
> +	"r0 =3D *(u64 *)(r11 + 8);"
> +	"r1 =3D *(u64 *)(r11 + 16);"
> +	"r0 +=3D r1;"
> +	"exit;"
> +	::: __clobber_all);
> +}
> +
> +static __naked __noinline __used long subs_arg6_arg7(long a, long b, lon=
g c, long d, long e,
> +						     long f, long g)
> +{
> +	asm volatile (
> +	"r0 =3D *(u64 *)(r11 + 8);"
> +	"r1 =3D *(u64 *)(r11 + 16);"
> +	"r0 -=3D r1;"
> +	"exit;"
> +	::: __clobber_all);
> +}
> +
> +SEC("tc")
> +__description("stack_arg: callx of one of two functions, args are not wr=
itten")
> +__failure __msg("callee expects 7 args, stack arg1 is not initialized")
> +__naked void callx_one_of_two_not_written(void)
> +{
> +	asm volatile (
> +	".pushsection .rodata,\"a\",@progbits;"
> +	".balign 8;"
> +"two_funcs_%=3D:"
> +	".quad adds_arg6_arg7;"
> +	".quad subs_arg6_arg7;"
> +	".type two_funcs_%=3D, @object;"
> +	".size two_funcs_%=3D, .-two_funcs_%=3D;"
> +	".popsection;"
> +	"call %[bpf_get_prandom_u32];"
> +	"r0 &=3D 1;"
> +	"r0 <<=3D 3;"
> +	"r2 =3D two_funcs_%=3D ll;"
> +	"r2 +=3D r0;"
> +	"r6 =3D *(u64 *)(r2 + 0);"
> +	"r1 =3D 1;"
> +	"r2 =3D 2;"
> +	"r3 =3D 3;"
> +	"r4 =3D 4;"
> +	"r5 =3D 5;"
> +	"callx r6;"
> +	"exit;"
> +	:
> +	: __imm(bpf_get_prandom_u32)
> +	: __clobber_all);
> +}

[Severity: Medium]
Should callx_one_of_two_not_written() be marked with __load_if_JITed() (and
guarded by CAN_USE_CALLX)?

In tools/testing/selftests/bpf/prog_tests/verifier.c, test_verifier_stack_a=
rg()
runs the suite with RUN(verifier_stack_arg) rather than RUN_JITED():

    void test_verifier_stack_arg(void)            { RUN(verifier_stack_arg)=
; }

When BPF JIT is disabled, env->prog->jit_requested is false. Unlike direct-=
call
failure tests in verifier_stack_arg.c that reach check_outgoing_stack_args()
during do_check() before bpf_fixup_call_args() checks jit_requested, the
.rodata function pointer read and callx in callx_one_of_two_not_written() h=
it
check_func_ptr_read() -> require_callx_jit() (and check_func_callx() ->
require_callx_jit()) during do_check():

kernel/bpf/verifier.c:require_callx_jit() {
	if (!env->prog->jit_requested) {
		verbose(env, "JIT is required to use callx\n");
		return -EOPNOTSUPP;
	}
    ...
}

Wouldn't running verifier_stack_arg with JIT disabled fail because the veri=
fier
rejects the program with "JIT is required to use callx" before reaching
check_func_callx_set() -> check_outgoing_stack_args() to emit "callee expec=
ts
7 args, stack arg1 is not initialized"?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105204513.2230=
344-1-alexei.starovoitov@gmail.com?part=3D35
