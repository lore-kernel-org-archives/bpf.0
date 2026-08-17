Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8C631D730
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 05:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786943855; cv=none; b=KC9V8ngFT8LaD/aM8Smhl2rapFrhNWhwIlrqTaiF+0VJbMfzt8HZkMrjgDFpNy5BizwmfU26e56MlyEtz1iWqOvkhkBVM6QzK0cgyUShX47elZx1mC58O1uUqH8LIKEJ+Sp+faLlx1qjnzUwFveVppsvG54i/yBOU6wgwDoGO44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786943855; c=relaxed/simple;
	bh=dXjWSQxsZWiMNVS21zON4/hkMb9tTI245q3DW0vvca8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=skpiSZGypDsFymf18NZSqwxWzVoMTQus0LdKcUxTE4gXOQQkEP9uT3djQLaKcn+A/QtQ6bGtqScOkEr6m5qD3SraXUQ0oD+Xe/0YeHRmgDPJ+/IOoyVrXOgubTIpIHkWHi6sm8A5eKvP5VVfMIMGLfW7RiWK+a/H2SK57HlKOf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EHM/p2w8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EHM/p2w8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 273CE1F00A3A;
	Mon, 17 Aug 2026 05:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786943853;
	bh=7iGF/tDnIukGIvtnfosO09xYeJdXrFx8IZQC9TfSBp4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=EHM/p2w8FwoHNy8ziFKLNLTSyCjERafNrGYy4A3Q9j8u5MVWVo3bgd9VjdWMhEwv6
	 WsHLoDgNh5qxPqb49j94QS/0jaJp3ejZovO5kjeLc6JRnuvckCfxfawDU0ytlzghLb
	 T6TKCayzuPdekGkl9IauMk5s3szgVdZswxvz+bUB63JrjtpX0b/LX7JjjEqcd2LAKc
	 vH8moziLVksC79rzlRCX/JSQSgtbeDbXr5XAj1drLuU5lSjQEjXqPOUmmZ8bukQDvW
	 w9/Z7lWJVjD7Uf2LcxtJRUmyffbvHpJ1xrmz4uOZzK1iVLZZi+jqXBI/wx5UfIb2iy
	 bf2XY/3WlEZ1g==
Content-Type: multipart/mixed; boundary="===============1206700634837167726=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <007af3660f62710298086713b7a7ffd4412ab2020a0cb628a4e100d62e783e3c@mail.kernel.org>
In-Reply-To: <20260817042227.2296079-1-yonghong.song@linux.dev>
References: <20260817042227.2296079-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v6 09/10] selftests/bpf: Add inline-asm and subprog tests for R0:R2 returns
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 17 Aug 2026 05:17:33 +0000 (UTC)

--===============1206700634837167726==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/aggregate_ret_func.c b/tools/testing/selftests/bpf/progs/aggregate_ret_func.c
> new file mode 100644
> index 000000000000..e35baaa10fea
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/aggregate_ret_func.c

[ ... ]

> +SEC("tc")
> +__failure __msg("At subprogram exit the register R2 is not a scalar value")
> +__naked int aggregate_ret_global_ptr_fail(void)
> +{
> +	asm volatile (
> +	"call %[global_agg_bad_ptr];"
> +	"r0 = r2;"
> +	"exit;"
> +	:
> +	: __imm(global_agg_bad_ptr)
> +	: __clobber_all);
> +}

Does this test need __load_if_JITed()? Without it, the test runs on
kernels where the JIT is disabled. When env->prog->jit_requested is
false, bpf_compute_subprog_ret_regs() returns early without marking any
ret_reg_pair flag, so global_agg_bad_ptr is not treated as returning a
register pair.

Main verification happens first, and with nregs = 1 at the call site,
check_func_call() marks only R0 (the callee's R2 is never propagated to
the caller). The next instruction "r0 = r2" then reads the caller's
NOT_INIT R2 from clear_caller_saved_regs() and dies in
__check_reg_arg() with "R2 !read_ok", never reaching
do_check_subprogs() where the asserted message "At subprogram exit the
register R2 is not a scalar value" would appear.

The program still fails to load, but with a different message than the
test asserts. aggregate_ret_static_precise and
aggregate_ret_global_precise both carry __load_if_JITed() to ensure the
R0:R2 convention is active when they run. Would the same gate keep this
test meaningful?

> +/*
> + * R2 is a return register once the subprogram returns a pair, so a stack
> + * pointer left in it is rejected at the callee's exit exactly as one in R0
> + * is: the callee frame is gone by the time the caller could use it.
> + */
> +SEC("tc")
> +__failure __msg("cannot return stack pointer to the caller")
> +__naked int aggregate_ret_static_ptr_fail(void)
> +{
> +	asm volatile (
> +	"call %[static_agg_bad_ptr];"
> +	"r0 = 0;"
> +	"exit;"
> +	:
> +	: __imm(static_agg_bad_ptr)
> +	: __clobber_all);
> +}

Does this test also need __load_if_JITed()? When the JIT is off,
bpf_compute_subprog_ret_regs() bails out before setting ret_reg_pair
for any subprogram, so bpf_ret_reg_pair() returns false for
static_agg_bad_ptr and prepare_func_exit() computes nregs = 1.

The loop "for (i = 0; i < nregs; i++)" then only inspects R0. Since
static_agg_bad_ptr leaves R0 as a scalar and the stack pointer only in
R2, the loop finds nothing and the program verifies cleanly. The test
body "r0 = 0; exit;" never reads R2, so the caller's R2 is already
NOT_INIT from clear_caller_saved_regs() and stays that way.

The __failure tag would then cause the subtest to report failure,
because the program loads successfully instead of failing with the
asserted message.

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/compute_live_registers.c b/tools/testing/selftests/bpf/progs/compute_live_registers.c
> index d055fc7b3b95..0be9441ec273 100644
> --- a/tools/testing/selftests/bpf/progs/compute_live_registers.c
> +++ b/tools/testing/selftests/bpf/progs/compute_live_registers.c

[ ... ]

> +SEC("socket")
> +/* A program observing the pair needs the JIT; see bpf_compute_subprog_ret_regs(). */
> +__load_if_JITed()
> +__log_level(2)
> +__msg("0: .12345.... (85) call pc+2")
> +__msg("1: ..2....... (bf) r0 = r2")
> +/* R2 is not read at the exit of this program, which returns an int, ... */
> +__msg("2: 0......... (95) exit")
> +__msg("3: .......... (b7) r0 = 1")
> +__msg("4: 0......... (b7) r2 = 2")
> +/* ... but it is at the exit of aux2(), which returns a register pair. */
> +__msg("5: 0.2....... (95) exit")
> +__naked void subprog_ret_reg_pair(void)

The comment says R2 is not live at the program's exit because "this
program ... returns an int". The program is declared "__naked void
subprog_ret_reg_pair(void)" - it does not return an int.

Is the reason actually that bpf_compute_subprog_ret_regs() skips the
main program?

In kernel/bpf/verifier.c:437, the loop starts at subprog 1:

    /*
     * Skip the main program: its return value is the program's exit
     * code, read out of R0, so it never uses the register pair. ...
     */
    for (subprog = 1; subprog < env->subprog_cnt; subprog++) {

So R2 would not be live at the main program's exit even if subprog 0
were declared to return 16 bytes. The program's return type is not what
decides this.

[ ... ]

> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> index c4bc8e11c6e1..20a9b9f20e96 100644
> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c

[ ... ]

> +__bpf_kfunc struct prog_test_ret_pair bpf_kfunc_call_test_ret_fastcall(u64 a, u64 b)
> +{
> +	struct prog_test_ret_pair r = { .lo = a + b, .hi = a - b };
> +
> +	return r;
> +}
> +
> +__bpf_kfunc struct prog_test_ret_ptr bpf_kfunc_call_test_ret_ptr(u64 tag)
> +{
> +	struct prog_test_ret_ptr r = { .p = NULL, .tag = tag };
> +
> +	return r;
> +}
> +
> +__bpf_kfunc struct prog_test_ret_ii bpf_kfunc_call_test_ret_ii(int a, int b)
> +{
> +	struct prog_test_ret_ii r = { .a = a, .b = b };
> +
> +	return r;
> +}
>  #endif /* __x86_64__ || __aarch64__ */

Would riscv64 benefit from test coverage here? Commit 3bfe2cb81326
("bpf: Wire up JIT support for 16-byte kfunc returns") added
bpf_jit_supports_kfunc_ret_reg_pair() returning true for riscv64, so
bpf_add_kfunc_call() accepts 16-byte kfunc returns there.

But the test infrastructure excludes riscv64:

- bpf_kfunc_call_test_ret_pair(), _ret_fastcall(), _ret_ptr(), and
  _ret_ii() are not compiled into bpf_testmod on riscv64 (arch guard)
- every test in progs/aggregate_ret_kfunc.c is tagged "__arch_x86_64
  __arch_arm64", so test_loader.c skips them on riscv64

The riscv64 LP64D ABI returns a 16-byte two-word struct in a0:a1,
matching the x86-64 rax:rdx and arm64 x0:x1 cases. bpf_misc.h already
defines "__arch_riscv64", and test_loader.c maps ARCH_RISCV64.

Could the arch guard be extended to "defined(__riscv) && __riscv_xlen
== 64" and the tests tagged with "__arch_riscv64" to cover the newly
enabled JIT path?

> +/*
> + * Takes no argument on purpose: with no arguments there is nothing for the sret
> + * pointer to displace, so this needs no architecture guard even though it
> + * returns 24 bytes. See the comment on bpf_kfunc_call_test_i128() above.
> + */
> +__bpf_kfunc struct prog_test_ret_big bpf_kfunc_call_test_ret_big(void)
> +{
> +	struct prog_test_ret_big r = { .a = 1, .b = 2, .c = 3 };
> +
> +	return r;
> +}

The comment has two issues. First, it references "the comment on
bpf_kfunc_call_test_i128() above", but there is no comment on
bpf_kfunc_call_test_i128(). That function appears without explanation a
few lines above.

Second, "with no arguments there is nothing for the sret pointer to
displace" is not why this function is safe without an arch guard. On
SysV x86-64, AAPCS64, and riscv64 LP64D, a 24-byte struct return is
returned via memory through a hidden pointer passed in the first
argument register.

With no declared arguments, the hidden sret pointer would still be taken
from the first argument register (BPF R1), which for this kfunc is never
set up. But that is not what makes this safe: bpf_add_kfunc_call() calls
btf_distill_func_proto() which rejects any return larger than 16 bytes
with "The function %s return type %s is unsupported."

The function is unreachable from BPF on every architecture, which is
what aggregate_ret_kfunc_too_big_fail asserts. The test in
progs/aggregate_ret_kfunc.c states this correct reason; the comment here
states a different one.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31995069373
--===============1206700634837167726==--
