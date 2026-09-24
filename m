Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D892E11D2
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 00:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790210029; cv=none; b=hdkT/pCG7UV/lA0XQ5C4N3tRFoN/yOoN4oR6D6q0Xkp3Ue/Q0M88NE2NQ6lyNNn3kgkxo4HoylG+9S2jFOjryI6ZqVo+nZOSqDF8IZNWEyKAdWM5Hx1p6ZydoD69eQ9u9sK5sIYo9wtmZNvXsI54Qyo6B8Tr9qgZ7OhmJVJ7eRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790210029; c=relaxed/simple;
	bh=x5BpPbe1e8H+K5yRzhQdMEG4NTs7an6GEhqz3ELaGuk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=tYpcB79+u9xShlzQcdzV5sSuchFFwAPuuqWXCrrNiPG9Mu7srZwpXknug7zu+8QE5OnfyhWxlQdV7b8i4YxAxfcmHoHH3SSiw79UvbOeeApUC1uFnYp6A4Tt5k3tj+OTOuKRGpMPjAvSMaJ2N1zHLg9/lWweEwV30ZGqVpIfDnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IHK4iBft; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IHK4iBft"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFCEF1F000FF;
	Thu, 24 Sep 2026 00:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790210028;
	bh=T4gmq7mTWmbUtOsnpRQrEvuxmcMTj9DE80Yl+vXED/k=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=IHK4iBftBeLCuupLcjj3wvQXh6s6wsKPvjz+Rj+EgmsOqtb6g5zRtmyJv9xv5Lj2m
	 okDSN4k8KolXN23Otyw4crrazJ5jETfje6HdlGAP846hjp6BGprvho19nsWdVnSngz
	 s4fUV4MTDY+26T3Jrl+s7X73IsHPKqMMOtLPJo3mT/4SUIyfk3wwdneZ72K3PLo7v+
	 BYy1fEWsf0vzGYm4cw0xthrOdw4sYP2m/FI3wcJpMOKOVKMRE72Oh1wUFSA61XlQ89
	 QVwo6bYbKyYyNXVdoGjZA1JNKmct8OF160bIeMSNmcBPI6O70bs4/CgYOAMg9u9Oeo
	 XKxpULnoMUZlQ==
Content-Type: multipart/mixed; boundary="===============1707737354958412526=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <27df6acd9bf26283a14a534d61af648dbaf53dce6540870b02a09588a0a73ff3@mail.kernel.org>
In-Reply-To: <20260922011323.1298619-17-alexei.starovoitov@gmail.com>
References: <20260922011323.1298619-17-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 16/17] selftests/bpf: Add tests for callx through pointers in read-only data
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,a.s.protopopov@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 24 Sep 2026 00:33:46 +0000 (UTC)

--===============1707737354958412526==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/Makefile.skel b/tools/testing/selftests/bpf/Makefile.skel
> index 580d1d82c186..3d92cdca62ed 100644
> --- a/tools/testing/selftests/bpf/Makefile.skel
> +++ b/tools/testing/selftests/bpf/Makefile.skel

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c b/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c
> new file mode 100644
> index 000000000000..419a90b1f894
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c
> @@ -0,0 +1,651 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Tests for callx through pointers to functions in read-only data */

[ ... ]

> +__noinline __used
> +int global_add3(int x)
> +{
> +	return x + 3;
> +}
> +
> +/* a pointer to a global function is not recognized, it's a number */
> +SEC("socket")
> +__failure __msg("R2 has type scalar, expected func")
> +__naked void callx_rodata_global_func(void)
> +{
> +	asm volatile (
> +		FUNC_TABLE2(tbl, add1, global_add3)
> +		"r2 = tbl_%= ll;"
> +		"r2 = *(u64 *)(r2 + 8);"
> +		"r1 = 10;"
> +		"callx r2;"
> +		"exit;"
> +		::: __clobber_all);
> +}

Does this test actually verify that the kernel skips global functions?

Looking at bpf_object__append_func_ptrs_code() in libbpf, it explicitly
skips global functions:

    if (subprog->sym_global)
        continue;

Since global_add3() is not referenced directly anywhere in the program,
libbpf never appends it. create_func_ptr_map() then finds no subprog for
that slot and writes 0 there:

    if (j == prog->subprog_cnt) {
        pr_debug("... no function for the pointer at offset %zu, it's NULL\n", ...);
        val = 0;
    }

So the kernel receives { offset(add1), 0 }. In resolve_func_ptrs(), the 0
is dropped by `if (!val || ...) continue;` before the
`bpf_subprog_is_global(env, subprog)` skip is ever reached. A kernel
without that skip would give the same "R2 has type scalar, expected func"
message.

To actually test global function handling, the program would need to also
reference global_add3() directly (e.g., with a `call global_add3`) so that
libbpf includes it and stores its offset in the table.

> +/* the compiler might turn the switch into a table that has no symbol */
> +static __noinline int call_by_switch(unsigned int idx, int x)
> +{
> +	op_fn op;
> +
> +	switch (idx) {
> +	case 0:
> +		op = op8;

[ ... ]

> +	return op(x);
> +}
> +
> +SEC("socket")
> +__success __retval(50)
> +int callx_c_table_null_check(void *ctx)
> +{
> +	unsigned int i = op_idx;
> +	op_fn op;
> +
> +	if (i >= sizeof(ops) / sizeof(ops[0]))
> +		return -1;
> +	/* the address of a function is not known until the program is jitted */
> +	op = ops[i];
> +	if (!op)
> +		return -2;
> +	return op(3);
> +}

Does the NULL check reach the const_fold logic it claims to test?

The commit message says this test covers a "NULL check of an element that
bpf_prune_dead_branches() must not fold". The comment points at the
const_fold.c check in const_reg_xfer():

    /* so are the addresses of functions that the map points to */
    bpf_map_range_func_ptrs(env, map, off, size, &cnt) ||

However, the index comes from `int op_idx = 11;`, which is in writable
.data, so const_fold treats `i` as unknown. The element address is built
as `r2 = ops ll; r2 += rX`. That BPF_ADD|BPF_X goes to the
`default: *dst = unknown;` case of const_reg_xfer(). The following BPF_LDX
then leaves at `if (!ci_is_map_value(src)) { *dst = unknown; break; }`
before bpf_map_range_func_ptrs() is ever called.

So `op` is never treated as a constant, and bpf_prune_dead_branches()
never considers the `if (!op)` conditional, whether or not the
function-pointer exclusion exists.

To cover the claim, the test would need a constant index into the table,
so that const_fold reaches the func-ptr read, followed by a conditional
jump on the loaded value.

> +/* a structure of operations, where pointers to functions are mixed with data */
> +struct shape_ops {
> +	int id;
> +	op_fn area;
> +	long scale;
> +	op_fn perimeter;
> +};
> +
> +static const struct shape_ops square_ops = { 1, op1, 10, op2 };
> +static const struct shape_ops circle_ops = { 2, op3, 20, op1 };
> +
> +static __noinline int use_shape(const struct shape_ops *ops, int x)
> +{
> +	return ops->area(x) * ops->scale + ops->perimeter(ops->id);
> +}
> +
> +SEC("socket")
> +__success __retval(433)
> +int callx_c_ops_mixed_with_data(void *ctx)
> +{
> +	/*
> +	 * square: op1(2) * 10 + op2(1) = 7 * 10 + 6 = 76
> +	 * circle: op3(3) * 20 + op1(2) = 18 * 20 + 7 = 367
> +	 * minus 10 when op_idx is not what it is set to
> +	 */
> +	return use_shape(&square_ops, 2) + use_shape(&circle_ops, 3) - (op_idx == 11 ? 10 : 0);
> +}

[ ... ]

> +SEC("socket")
> +__success __retval(50)
> +int callx_c_switch_table(void *ctx)
> +{
> +	/* op11(3) = 3 * 13 + 11 */
> +	return call_by_switch(op_idx - 8, 3);
> +}

A subsystem pattern flags this as potentially concerning: callx_c_switch_table()
compiles to callx, but is annotated only `__success __retval(50)`, with no
`__load_if_JITed()`.

check_callx() in kernel/bpf/verifier.c rejects callx with -EOPNOTSUPP when
the program is not going to be JITed:

    /* there is no support for callx in the interpreter */
    if (!env->prog->jit_requested) {
        verbose(env, "JIT is required to use callx\n");
        return -EOPNOTSUPP;
    }

With the JIT off (a kernel without CONFIG_BPF_JIT_ALWAYS_ON and
net.core.bpf_jit_enable=0), run_subtest() in test_loader.c computes
current_runtime = NO_JITED. The default load_mask is JITED | NO_JITED, so
the load-mode skip does not apply. The load goes ahead, bpf_object__load()
returns -EOPNOTSUPP, and ASSERT_OK(err, "unexpected_load_failure") reports
a failure.

The other callx-based tests in the file (callx_c_table,
callx_c_table_null_check, callx_c_ops_mixed_with_data, callx_c_ops_selected
and the asm callx_rodata_* success tests) have the same pattern. The file
already has the mechanism: `#define __load_if_JITed()
__test_tag("load_mode=jited")` in bpf_misc.h, which about 30 other verifier
progs use.

This is unlikely to show up in BPF CI (tools/testing/selftests/bpf/config.x86_64
and config.aarch64 both set CONFIG_BPF_JIT_ALWAYS_ON=y), but the test
should skip when JIT support is unavailable.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35935998342
--===============1707737354958412526==--
