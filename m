Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793940755;
	b=R+O1+FPLJ+Sg89HC3OwfY8fPgu9P4/P/2Z2WkgHGy8Ha93x6TzOyBkiM1A0qkaz9HIy7
	 O7LfwFwXafR4i7LcPQHSjvmr8R8SS/zs1pRAOOs2VJt+BNArIUfkyH0GaA6faz06/Zxug
	 Rk1b521y7s68DfjKdfAvMoNLN3zDHNAttcpWUMCTGpBttOSDjE6THJL7L6p66Satxv2sm
	 +7EWwLRsXPPUKyoh2k1XsePCYg+5uZbSColLK2paYGbjn9pe++SGe30Fcyt13EQAeYVp8
	 yh6vzIwZ5MWu3K6q40mOU4hrWJ1tZ9XRokAUOROPeIiu5mj3pj3LT2WWaR5DgMKDlmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793940755;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=O9KSW+XDIqU0dgbDclDOTYDdzORYToOpWQbljX51zic=;
	b=D3xBMEnGsKTEz3IusEs97eh9nFjWEC2+fT2TK2XDionTA15ZlvwTXnhihL303IkRgLw/
	 sQXKyY/KtEf1YY8s5UMvN97NUlJPwXC+VoBIlDK9UgqdKGuRyX4kgU7MF/fzLAaV9Q8Hr
	 jChxqbGzeYccVwH7/sZMApIOVxSNE0pwYd4If/ZiKGCHqaD9ymGcEqyuu+XCh1AfBjjCh
	 vgJffJGa8r0F3W1MGdfD6ehXKBoPG8m/O0aL2Ipdyp4BNKu7a33+1t7rVvOBmmZwIYh1Z
	 TsP7GWDZys0OYpbSlg5PWRlnNgPdm8NiOHZ2UYURcOdt393/gacNvk8ewlnKklT8qHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iHPkapf5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F51606A31B
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 04:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iHPkapf5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C78CB1F0089F;
	Fri,  6 Nov 2026 04:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793940754;
	bh=O9KSW+XDIqU0dgbDclDOTYDdzORYToOpWQbljX51zic=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=iHPkapf5iTN0PxDHN7m0NjuvpZQgfAi5Xr8lYVUjjPlQxe4+Vrz66q1n4imTKESxv
	 XFh/cHyOtnC9xA01hjcPhq9cyj4YV+eJ588DMIJZn9simwejJYU4FSX2Covqezp0Km
	 uFIE5ipe9Dh71fHIfmntMRd0ugZosoymbKlst6MPejN44Ho6X5eU5h05zg9fUVMrwr
	 5QZpcI5YqUteVsEwsHXFYp43eVDSUPAzBNpueg5DF5PA/n67xdOM5ELWf9likXVUo/
	 0RVCyPhfKxMis1pJOsZT0TE62dc/ZPT4nh0Wsvc074Qhf0qW7MfeeICk6jnGUvBB0H
	 CdyY2+HJc+yHQ==
Message-ID: <sashiko-outbox-200774@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 45/45] selftests/bpf: Test callx of one of a
 set of functions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261106035111.3315285-46-alexei.starovoitov@gmail.com>
References: <20261106035111.3315285-1-alexei.starovoitov@gmail.com>
 <20261106035111.3315285-46-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 04:52:34 +0000
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

commit 64c4b960a70c853d9b8785754e157dac9645cef4
Author: Alexei Starovoitov <ast@kernel.org>

selftests/bpf: Test callx of one of a set of functions

This commit adds BPF verifier selftests covering indirect function calls
(callx) where a register holds a pointer to one of a set of functions loaded
from a read-only table, as well as declared argument liveness at callx.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c b/too=
ls/testing/selftests/bpf/progs/verifier_stack_arg.c
> index e3f5e4d14b759..c642675dd92bc 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
> @@ -572,6 +572,60 @@ __naked void null_check_of_stack_arg(void)
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
As reported by Sashiko on v2 [1], should callx_one_of_two_not_written() be
marked with __load_if_JITed() (and guarded with #ifdef CAN_USE_CALLX)?

In tools/testing/selftests/bpf/prog_tests/verifier.c,
test_verifier_stack_arg() runs the suite via RUN(verifier_stack_arg) rather
than RUN_JITED(verifier_stack_arg):

    void test_verifier_stack_arg(void)            { RUN(verifier_stack_arg)=
; }

When the BPF JIT is disabled (for example, bpf_jit_enable=3D0 when
CONFIG_BPF_JIT_ALWAYS_ON is not set), subtests in verifier_stack_arg.c
without __load_if_JITed() are still loaded.

During verification of callx_one_of_two_not_written(), reading the function
pointer from .rodata and executing callx r6 both invoke
require_callx_jit(env) before reaching check_func_callx_set() and
check_outgoing_stack_args():

    do_check_all()
      -> check_map_mem_read()
        -> check_func_ptr_read()
          -> require_callx_jit()

and:

    do_check_all()
      -> check_func_callx()
        -> require_callx_jit()

In kernel/bpf/verifier.c:require_callx_jit():

    static int require_callx_jit(struct bpf_verifier_env *env)
    {
            if (!env->prog->jit_requested) {
                    verbose(env, "JIT is required to use callx\n");
                    return -EOPNOTSUPP;
            }

Without JIT enabled, wouldn't the verifier reject this program with "JIT is
required to use callx" instead of reaching the expected "callee expects 7
args, stack arg1 is not initialized" error?

[1] https://lore.kernel.org/r/20261105204513.2230344-36-alexei.starovoitov@=
gmail.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106035111.3315=
285-1-alexei.starovoitov@gmail.com?part=3D45
