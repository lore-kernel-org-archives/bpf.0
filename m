Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793082421;
	b=h67OvGUa+zeR+xujktil04np8Il4l+Zn59F2VSz5iKKSo0bYv608BQe+/fZCx/cqGflM
	 Ihm7TFlZRG18m5Pw+fnsQop02c6kybmgG4IWD0glSS2BmWp4fEIiO4N74NofZcreRnqg1
	 CyLG8lZ086+7219XWv6hxAbL1iMRvXWtAMwlD7hXTsn1HF5j0Aa5XpOtnL5xs2NVuyr0J
	 OJ+hCpwcZ8GQKwX89Olwwm+LZcuaFuYGFOqkvOTR1Vi9VowXm6y/TATKXGMam5bTh8Jgh
	 Yq2QtRfgmNg4PKoFpdbEC29cKkrqYgUMGt3aTes4pr9hsXYBll5RIgikrMx0k7Mp6pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793082421;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=iEQvM9tYUcxwoTJM8knIdkprbqaFsbWcz3X2D6dSsa0=;
	b=qT1vAolGzdvW4YJwht5kxg8D9TD+x02d/Q6NnmrA6qNKtSC0COJi+xrQ7l3e4N6kVxgZ
	 MptU5plo3cHdfTEEJho/JegZZLW76MyfleqWTUPTrhvvDO4CjgEtAq+q+L8ecyg73cfD0
	 r+VR5lSB7rwaOY7DjvJGx4tRfdRHBeizeyoKVloQs3y0t6ukvXLP+pV+Dch6LKBCrea/K
	 n6e1QYBLHRgEeNpqeg7iB0wZ70tVkrSKav8Jpaal+ITJjgrEJfMx9mSBDUFX/Pz33EehH
	 z/puRTNDB99N4ZbvH+pDAG1mdnkm5ku36PD51uLGA0ACYG4du0/EUkdURzJ0yp/P/0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E25om5qx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56608606A31A
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 06:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E25om5qx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9B3F1F01825;
	Tue, 27 Oct 2026 06:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793082420;
	bh=iEQvM9tYUcxwoTJM8knIdkprbqaFsbWcz3X2D6dSsa0=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=E25om5qxYsxTAsHgIj7KrnjsVVM2zHAs+HipXfTRSyaXem69U9TV1vvvMPLLMAp8F
	 Um0dhOKctkj46PnyOhTHM2m6wSZZgoH/O9im5Wj3LnOiW/ZrrkZE8uq5+Jw0qzs7Ty
	 RrW06FgNBzb2O7dpD4kdtR40/rEVm2oA53y3XYl1T1N94vJsV4L3D1o16Nram5wzLr
	 wD+5PJi8XBgRD/Z3GRI2ldyV7uZYASmBD6cE3b4zWjO0NroxPFAx5qEiwezAomf0i5
	 fU89ps97gGg/Ff9hpbvdrB9BDRR6ihxfyQIy+fU4h6zD0uE9yrr6okyfT0w+ilmKlx
	 d8sCNCq513qbQ==
Message-ID: <sashiko-outbox-186158@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Exercise stack argument
 precision on state reuse
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xu Yunxiang" <xyx2021@mail.ustc.edu.cn>, bpf@vger.kernel.org
In-Reply-To: <20261027061303.1754535-3-xyx2021@mail.ustc.edu.cn>
References: <20261027061303.1754535-1-xyx2021@mail.ustc.edu.cn>
 <20261027061303.1754535-3-xyx2021@mail.ustc.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 06:27:00 +0000
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
- [Low] selftests/bpf: multi-line comments violate BPF comment style
- [Low] selftests/bpf: test_stack_arg_precision_reuse() skips supported RV64
--

commit 46da3caeb85de86ad2e22a94e1a61ab12b6a1cfc
Author: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>

selftests/bpf: Exercise stack argument precision on state reuse

This commit adds load-only BPF verifier selftests in
tools/testing/selftests/bpf/prog_tests/stack_arg_precision_reuse.c to
exercise stack argument precision tracking across state reuse and
conservative precision fallback. It constructs BPF instructions and BTF
directly so the tests can run even when the compiler cannot emit stack
arguments.

> diff --git a/tools/testing/selftests/bpf/prog_tests/stack_arg_precision_r=
euse.c b/tools/testing/selftests/bpf/prog_tests/stack_arg_precision_reuse.c
> new file mode 100644
> index 0000000000000..4497d959247d7
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/stack_arg_precision_reuse.c
> @@ -0,0 +1,300 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <test_progs.h>
> +#include <bpf/btf.h>
> +
> +#define BPF_REG_PARAMS 11
> +
> +/* Construct BTF and instructions directly so these tests also run with
> + * compilers which cannot emit stack arguments yet.
> + */
> +struct test_program {

[ ... ]

> +static bool build_reuse(struct test_program *p, int map_fd,
> +			const struct reuse_test *test)
> +{

[ ... ]

> +	/* M: paths 2 and 3 meet with their offsets still in r6. Path 2
> +	 * must acquire precision here when it reuses path 1's state at P.
> +	 */
> +	jump_to(p, path2, p->insn_cnt);

[ ... ]

> +	/* Different precise r2 values prevent reuse before the callee.
> +	 * They converge here while the offset is still in the caller's slot.
> +	 */
> +	if (test->callee_join) {

[ ... ]

> +static bool build_fallback(struct test_program *p, int map_fd, bool call=
ee)
> +{

[ ... ]

> +	/* Subtraction turns r1 into a scalar. Precision backtracking across
> +	 * the store through its old pointer value needs conservative fallback.
> +	 * The resulting offset is bounded, so this program is always safe.
> +	 */
> +	emit(p, BPF_MOV64_REG(BPF_REG_1, BPF_REG_7));

[Severity: Low]
This isn't a bug, but in
tools/testing/selftests/bpf/prog_tests/stack_arg_precision_reuse.c, the four
multi-line comments above struct test_program, inside build_reuse(), and
inside build_fallback() place text on the opening /* line. Could these use
the standard BPF multi-line comment style with /* on its own line?

[ ... ]

> +void test_stack_arg_precision_reuse(void)
> +{
> +	const struct reuse_test tests[] =3D {
> +		{ .name =3D "arg6", .slot =3D 0, .offset =3D 32 },
> +		{ .name =3D "arg7", .slot =3D 1, .offset =3D 32 },
> +		{ .name =3D "caller_frame", .slot =3D 0, .offset =3D 32, .callee_join =
=3D true },
> +		{ .name =3D "nested_caller_frame", .slot =3D 1, .offset =3D 32,
> +		  .callee_join =3D true, .nested =3D true },
> +		{ .name =3D "in_bounds", .slot =3D 1, .offset =3D 8 },
> +		{ .name =3D "discarded", .slot =3D 0, .offset =3D 32, .discard =3D tru=
e },
> +		{ .name =3D "register_control", .slot =3D -1, .offset =3D 32 },
> +	};
> +	struct test_program p;
> +	int map_fd, i;
> +
> +	/* Stack argument JIT support currently exists on x86-64 and arm64. */
> +#if !defined(__x86_64__) && !defined(__aarch64__)
> +	test__skip();
> +	return;
> +#endif

[Severity: Low]
In test_stack_arg_precision_reuse() in
tools/testing/selftests/bpf/prog_tests/stack_arg_precision_reuse.c, when
compiled and run on 64-bit RISC-V, this guard unconditionally calls
test__skip().

However, arch/riscv/net/bpf_jit_comp64.c implements
bpf_jit_supports_stack_args() returning true, and other stack argument
selftests such as tools/testing/selftests/bpf/progs/stack_arg.c enable stack
argument testing on 64-bit RISC-V.

Should this condition and its comment also include 64-bit RISC-V (for
example, defined(__riscv) && __riscv_xlen =3D=3D 64) so these verifier test=
s are
not skipped on RV64?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027061303.1754=
535-1-xyx2021@mail.ustc.edu.cn?part=3D2
