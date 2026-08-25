Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27C6443ABA
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 21:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787695197; cv=none; b=OvzTzbqatGRgsIfzOo47zECDdx/HTqazHj1q4QpZ956alYak77ds+HuLEe/11ilrlpMTlJ6BZA+vmSqH//uQTJGceoo3WL3kW4Hus1o3kLAszAqQzR+LPmgoV7P3jZ93Ibyw0hH3a2S5+WU5iLya5aaz3VsT/WHOCuYVdPZNaOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787695197; c=relaxed/simple;
	bh=JeW1KmzT5GvL4mvBr0cSOsygiWIqA8+JJP13waF685o=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=INk+i0NY1lJs58YirrMn+cLaq1TfAg2an2UYUBg6zmU0uNATucl3SfxdlTZf0ZqNY1YHK9P7s5ApiCYCLPpEnqm/05S/35uK2pU0cw55/kG93R8TuZCa0vAUZMMu3c5jyUufkt/8n9DDoTMNvWysjLT1ki+67yxuIzIV7z1igQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ED1S+Exk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ED1S+Exk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 787DA1F00AC4;
	Tue, 25 Aug 2026 21:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787695195;
	bh=I5+WneyBS1TOswWhyd6zW6ofKQ4wFUAxAGHAUN3l1q8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ED1S+ExkfbiFdzBz1FwnEVG6JWabsPwcZtEQcZ0nQFo0jc13ZUpRg36kmP68QlV2h
	 QgDmhHheDzUCGJpz0elv8KB4iI1Nv5Z34YVGiH2s5XYTvNgfwqxZqoEWKGYFz4AKQc
	 qSFCsEYaN/j7Q4lXcqhwvfEg/Lx9NpNXP5QgKpMRL39eS30tWkvgWKlrnVXArCP5Cc
	 9VlpKyYfBIH3vfVkjpKDLnqq8jDHH3nj9rQSKraJE2iyoqqwP5cbinkKJQU4/820Rs
	 c8Aisxf2EF5eS7A73Vx6ptqfQhuGuPYxkRqyKawKbWzcQ8c1joXSuSnQeiAd2pLzzM
	 STSHGCXbquljQ==
Content-Type: multipart/mixed; boundary="===============3395426746865023957=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <77c79917dc8a9d299cfa0725c5bf278a32d9563915878546fe394650eeade3d8@mail.kernel.org>
In-Reply-To: <20260825205503.1327012-1-yonghong.song@linux.dev>
References: <20260825205503.1327012-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v2 10/10] selftests/bpf: Test kfuncs returning arena pointers by value
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 25 Aug 2026 21:59:55 +0000 (UTC)

--===============3395426746865023957==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/aggregate_ret.c b/tools/testing/selftests/bpf/prog_tests/aggregate_ret.c
> index e0b94ed10f941..07d9d6e1d6b88 100644
> --- a/tools/testing/selftests/bpf/prog_tests/aggregate_ret.c
> +++ b/tools/testing/selftests/bpf/prog_tests/aggregate_ret.c
> @@ -1,11 +1,53 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
>  #include <test_progs.h>
> +#include <bpf/btf.h>
>  #include "aggregate_ret_func.skel.h"
>  #include "aggregate_ret_kfunc.skel.h"
> +#include "aggregate_ret_kfunc_arena.skel.h"
> +
> +static bool testmod_has_arena_tagged_member(void)
> +{
> +	struct btf *vmlinux_btf, *module_btf = NULL;
> +	const struct btf_type *t;
> +	bool tagged = false;
> +	__s32 id;
> +
> +	vmlinux_btf = btf__load_vmlinux_btf();
> +	if (!vmlinux_btf)
> +		return false;
> +
> +	module_btf = btf__load_module_btf("bpf_testmod", vmlinux_btf);
> +	if (!module_btf)
> +		goto out;
> +
> +	/* prog_test_ret_arena::a is 'void __arena_tag *': PTR -> TYPE_TAG -> void */
> +	id = btf__find_by_name_kind(module_btf, "prog_test_ret_arena", BTF_KIND_STRUCT);
> +	if (id <= 0)
> +		goto out;
> +
> +	t = btf__type_by_id(module_btf, btf_members(btf__type_by_id(module_btf, id))[0].type);
> +	if (!t || !btf_is_ptr(t))
> +		goto out;
> +
> +	t = btf__type_by_id(module_btf, t->type);
> +	tagged = t && btf_is_type_tag(t) &&
> +		 !strcmp(btf__name_by_offset(module_btf, t->name_off), "arena");
> +
> +out:
> +	btf__free(module_btf);
> +	btf__free(vmlinux_btf);
> +
> +	return tagged;
> +}
>
>  void test_aggregate_ret(void)
>  {
>  	RUN_TESTS(aggregate_ret_func);
>  	RUN_TESTS(aggregate_ret_kfunc);
> +
> +	if (testmod_has_arena_tagged_member())
> +		RUN_TESTS(aggregate_ret_kfunc_arena);
> +	else
> +		test__skip();

A subsystem pattern flags this as potentially concerning:
testmod_has_arena_tagged_member() collapses four distinct outcomes
into the same 'false' return: environment broken (no vmlinux BTF),
testmod absent or BTF missing, stale bpf_testmod.ko, or the actual
capability probe (btf_type_tag attribute absent). When test__skip()
is called without a reason string, the run shows 'aggregate_ret:OK
(SKIP: 1/N)' with no indication of what was skipped or why.

Since PAHOLE_HAS_BTF_TAG depends on CC_IS_CLANG (lib/Kconfig.debug)
and GCC does not implement btf_type_tag, the skip branch is the normal
outcome on a GCC-built kernel, which makes a permanently-skipped test
easy to miss. The test appears to pass but the new coverage never runs.

The BPF selftests/bpf/prog_tests/btf_tag.c establishes a precedent:
it checks env.has_testmod, uses ASSERT_OK_PTR() so a BTF-load failure
is a real FAIL, and prints a reason string before test__skip():

    printf("%s:SKIP: btf_type_tag attribute not in %s", __func__, module_name)

Should testmod_has_arena_tagged_member() distinguish a broken environment
(ASSERT_OK_PTR on the vmlinux BTF) from a missing capability, and should
the test__skip() carry a reason string?

>  }

> diff --git a/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc_arena.c b/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc_arena.c
> new file mode 100644
> index 0000000000000..f68deae6c900e
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc_arena.c
> @@ -0,0 +1,47 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +#include "../test_kmods/bpf_testmod_kfunc.h"
> +
> +void __kfunc_btf_root(void)
> +{
> +	asm volatile (""
> +	:
> +	: "r"(&bpf_kfunc_call_test_ret_arena),
> +	  "r"(&bpf_kfunc_call_test_ret_arena_mixed));
> +}

A subsystem pattern flags this as potentially concerning: a new BPF
prog file is added for two test cases, but progs/aggregate_ret_kfunc.c
in the same directory already covers by-value kfunc returns
(aggregate_ret_kfunc_precise, _fastcall_fail, _ptr_fail,
_nested_ptr_fail, _too_deep_fail, _small_no_r2, _too_big_fail). The
new file duplicates the header includes, the license string, the
SEC("tc")/__arch_x86_64/__arch_arm64/__load_if_JITed() preamble and
__kfunc_btf_root() itself, for two subtests.

RUN_TESTS() operates on a whole skeleton (test_progs.h:546 ->
test_loader__run_subtests(&tester, #skel, skel##__elf_bytes)), and
these two subtests must be gated on whether the running bpf_testmod's
BTF carries the 'arena' type tag - a per-toolchain condition that has
no per-subtest expression in bpf_misc.h (__arch_*/__load_if_JITed
cover architecture and JIT only). Putting them in
aggregate_ret_kfunc.c would force the whole existing matrix behind
the same gate.

Is the separate file justified by the per-skeleton gating requirement,
or could the new cases be added to aggregate_ret_kfunc.c?

> +
> +SEC("tc")
> +__arch_x86_64 __arch_arm64
> +__load_if_JITed()
> +__success __retval(0)
> +__naked int aggregate_ret_kfunc_arena(void)
> +{
> +	asm volatile (
> +	"call %[bpf_kfunc_call_test_ret_arena];"
> +	"r0 = 0;"
> +	"exit;"
> +	:
> +	: __imm(bpf_kfunc_call_test_ret_arena)
> +	: __clobber_all);
> +}
> +
> +SEC("tc")
> +__arch_x86_64 __arch_arm64
> +__load_if_JITed()
> +__success __retval(0)
> +__naked int aggregate_ret_kfunc_arena_mixed(void)
> +{
> +	asm volatile (
> +	"r1 = 0;"
> +	"call %[bpf_kfunc_call_test_ret_arena_mixed];"
> +	"r0 = 0;"
> +	"exit;"
> +	:
> +	: __imm(bpf_kfunc_call_test_ret_arena_mixed)
> +	: __clobber_all);
> +}

The changelog claims this patch covers 'two arena pointers filling
R0:R2', but neither new program ever reads R2. Both bodies are
'call <kfunc>; r0 = 0; exit;' with __success __retval(0), which only
proves that check_kfunc_call() accepted the return type - i.e. that
btf_struct_member_walk(..., BTF_MEMBER_SCALAR | BTF_MEMBER_ARENA_PTR, ...)
returned true (kernel/bpf/verifier.c:14097). The number of return
registers is decided separately by mark_kfunc_ret_regs() -> ret_regs_cnt(size)
(kernel/bpf/verifier.c:11351, :413); if that path regressed to a
single register for a 16-byte STRUCT return, both new tests would
still pass, because R2 is never read.

The file this patch sits beside already establishes the idiom for
pinning this: aggregate_ret_kfunc_small_no_r2 asserts __failure
__msg("R2 !read_ok") to prove R2 is *not* a return register for an
8-byte struct, and aggregate_ret_kfunc_precise reads 'r6 = r2' after
the __int128 kfunc to prove R2 *is*.

Should at least one of the arena tests read R2 back to verify the
two-register return path?

> +
> +char _license[] SEC("license") = "GPL";

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32899532405
--===============3395426746865023957==--
