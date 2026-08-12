Received: from mta1.migadu.com (out-147.mta1.migadu.com [95.215.58.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA22744A71E
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 21:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786568959; cv=none; b=pDxXhOngmP4npWJherPHTRh2duijb37Ll4VAuBL1gpuizA/rSflET36clZawjqX6+hnUgDqnnqRL4lPZkZR6FDxaWMybUJ0ZfYLZ0To5tEAaX60K5hpqAPr2Fen9bf5Wc0Mc9mgdj8+7s8K7PeKEr+7LDP2aD+p513Y6GoT6fYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786568959; c=relaxed/simple;
	bh=gWcj8CMtkucfzgfsDemhY5zSOvHjShTELIlLofPrbqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oA+I3AWKSsKXvwFeaiviNBDBuPvTRl5wqPk3r80zp+Dmb4gpZoSNESuUJ8DU3lj2j/6F4oH3IGTY8tMQvGToqi76OPrUtHdrqOY2H2H79ZYdn1ujH1OA8gQxKqHi0NMmWs/rPGzQMhVvTg4XFTas69oAA521H7M7nmuqo4902og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IcUyTSic; arc=none smtp.client-ip=95.215.58.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IcUyTSic"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=gWcj8CMtkucfzgfsDemhY5zSOvHjShTELIlLofPrbqo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786568953; v=1; x=1787173753;
 b=IcUyTSicESfaH98tMlygSLhGwUuEwCt5Zhq2K54e3ty9ZhE3AEH1tE52D55lJIdQB+DeP08w
 oT5EkZMljjEluRuRnzOO9gy2tJrNVv87IFJgl1lLPP6YxN/RTnUIAa+vc6/M02XjQKIENWXsxeT
 Ldw6NYnH6E4geSl5NcpeMeNw=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2a03:83e0:1151:15:1c5e:37e8:36:dd37] (2620:10d:c090:500::7:cd95)
	by smtp.migadu.com with ESMTPS id 1cc9376bf5aaf019;
	Wed, 12 Aug 2026 21:09:03 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <7284d446-b51e-407a-ba9c-fd42c8a8a99e@linux.dev>
Date: Wed, 12 Aug 2026 14:08:54 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 11/13] selftests/bpf: Add inline-asm and
 subprog tests for R0:R2 returns
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20260811001008.2383983-1-yonghong.song@linux.dev>
 <47093952550af2c87bc5730d0d9cec8f1c6e622cfb0216a9b1256118d8413274@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <47093952550af2c87bc5730d0d9cec8f1c6e622cfb0216a9b1256118d8413274@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/10/26 6:24 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/testing/selftests/bpf/prog_tests/aggregate_ret.c b/tools/testing/selftests/bpf/prog_tests/aggregate_ret.c
>> --- a/tools/testing/selftests/bpf/prog_tests/aggregate_ret.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/aggregate_ret.c
>> @@ -5,6 +5,9 @@
>>   #include "aggregate_ret_struct_c.skel.h"
>>   #include "aggregate_ret_union_c.skel.h"
>>   #include "aggregate_ret_kfunc_c.skel.h"
>> +#include "aggregate_ret_run.skel.h"
>> +#include "aggregate_ret_func.skel.h"
>> +#include "aggregate_ret_kfunc.skel.h"
> [ ... ]
>
>> @@ -139,10 +142,65 @@ static void test_kfunc_c(void)
>>   	aggregate_ret_kfunc_c__destroy(skel);
>>   }
>>
>> +static void test_run(void)
>> +{
>> +	struct aggregate_ret_run *skel;
>> +	bool kfunc_ok = true;
>> +	int err;
>> +
>> +	/*
>> +	 * Every program in this object shares __kfunc_btf_root(), so where the
>> +	 * testmod kfuncs are absent the object cannot load at all -- including
>> +	 * for the kfunc-free "asm" subtest.
>> +	 */
>> +	if (!has_ret_pair_kfuncs()) {
>> +		run_subtest("asm", NULL, false);
>> +		run_subtest("asm_kfunc", NULL, false);
>> +		run_subtest("struct", NULL, false);
>> +		run_subtest("union", NULL, false);
>> +		return;
>> +	}
>> +
>> +	skel = aggregate_ret_run__open();
>> +	if (!ASSERT_OK_PTR(skel, "skel_run_open"))
>> +		return;
>> +
>> +	err = aggregate_ret_run__load(skel);
>> +	if (err == -EOPNOTSUPP) {
>> +		kfunc_ok = false;
>> +		aggregate_ret_run__destroy(skel);
>> +
>> +		skel = aggregate_ret_run__open();
>> +		if (!ASSERT_OK_PTR(skel, "skel_run_reopen"))
>> +			return;
>> +
>> +		bpf_program__set_autoload(skel->progs.aggregate_ret_asm_kfunc_test, false);
>> +		bpf_program__set_autoload(skel->progs.aggregate_ret_struct_test, false);
>> +		bpf_program__set_autoload(skel->progs.aggregate_ret_union_test, false);
>> +
>> +		err = aggregate_ret_run__load(skel);
>> +	}
>> +	if (!ASSERT_OK(err, "skel_run_load"))
>> +		goto out;
> A subsystem pattern flags this as potentially concerning:
> has_ret_pair_kfuncs() checks only for x86_64 or arm64 architecture at
> compile time. On those architectures, if bpf_testmod.ko is not actually
> loaded at runtime, aggregate_ret_run__load() returns -ESRCH rather than
> -EOPNOTSUPP, causing the reopen branch to be skipped and the test to
> report a hard FAIL rather than skipping. The comment states "where the
> testmod kfuncs are absent the object cannot load at all" but the code
> only guards one form of "absent" (architecture) and not the other
> (module not loaded).
>
> test_progs tracks whether bpf_testmod.ko is loaded in env.has_testmod
> and sets it to false if load_bpf_testmod() fails. Every other
> testmod-dependent test in the tree checks both the architecture
> capability and env.has_testmod before attempting to use testmod kfuncs.
> Examples include bpf_cookie.c, iters.c, ksyms_module.c, btf_module.c,
> btf_tag.c, tp_btf_nullable.c, module_fentry_shadow.c, and
> core_reloc.c.
>
> Should test_run() fold env.has_testmod into its guard to match the
> established pattern, so that the test skips cleanly in all environments
> where bpf_testmod is unavailable?

Yes, we should add env.has_testmod.

>
>> +
>> +	run_subtest("asm", skel->progs.aggregate_ret_asm_test, true);
>> +	run_subtest("asm_kfunc", skel->progs.aggregate_ret_asm_kfunc_test, kfunc_ok);
>> +	run_subtest("struct", skel->progs.aggregate_ret_struct_test, kfunc_ok);
>> +	run_subtest("union", skel->progs.aggregate_ret_union_test, kfunc_ok);
>> +
>> +out:
>> +	aggregate_ret_run__destroy(skel);
>> +}
>> +
>>   void test_aggregate_ret(void)
>>   {
>>   	test_int128_c();
>>   	test_struct_c();
>>   	test_union_c();
>>   	test_kfunc_c();
>> +	test_run();
>> +
>> +	RUN_TESTS(aggregate_ret_func);
>> +	if (has_ret_pair_kfuncs())
>> +		RUN_TESTS(aggregate_ret_kfunc);
>>   }
> A subsystem pattern flags this as potentially concerning: the four
> test_run() subtests are registered as named skips when kfuncs are
> unavailable, with a comment stating "the list of subtests does not
> depend on the compiler or on the architecture." RUN_TESTS(aggregate_ret_kfunc)
> conditionally disappears, so the five aggregate_ret_kfunc_* subtests do
> not appear at all outside x86_64/arm64 - the subtest list does depend
> on the architecture. Anyone diffing test_progs output across
> architectures sees subtests vanish rather than skip. The two halves of
> the change implement opposite policies about whether an unavailable
> prerequisite should produce a visible skip.
>
> Should RUN_TESTS(aggregate_ret_kfunc) use run_subtest() to produce
> named skips, matching the approach a few lines earlier?

Right, we can do skip. In the future, when additional arch
gets support, those 'skip' can be changed to actual run.

>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
>> --- a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
> [ ... ]
>
>> diff --git a/tools/testing/selftests/bpf/progs/verifier_arena.c b/tools/testing/selftests/bpf/progs/verifier_arena.c
>> --- a/tools/testing/selftests/bpf/progs/verifier_arena.c
>> +++ b/tools/testing/selftests/bpf/progs/verifier_arena.c
>> @@ -704,4 +704,42 @@ int check_arena_arg_ret(void *ctx)
>>   	return 0;
>>   }
>>
>> +struct arena_ret_pair {
>> +	__u64 lo;
>> +	__u64 hi;
>> +};
>> +
>> +/*
>> + * A 16-byte value is returned in the R0:R2 register pair. A global subprogram
>> + * may return an arena pointer in R0, but R2 holds the upper half of a scalar
>> + * pair, so an arena pointer there is not a valid return value. The ld_imm64 of
>> + * the arena map is what links the arena to the program, without which the
>> + * addr_space_cast insn is not allowed.
>> + */
>> +__naked struct arena_ret_pair global_ret_arena_ptr_in_r2(void)
>> +{
>> +	asm volatile (
>> +		"r1 = %[arena] ll;"
>> +		"r2 = 8192;"
>> +		"r2 = addr_space_cast(r2, 0x0, 0x1);"
>> +		"r0 = 0;"
>> +		"exit;"
>> +		:
>> +		: __imm_addr(arena)
>> +		: __clobber_all);
>> +}
> Does this inline-asm instruction build on clang older than LLVM 18?
> The addr_space_cast mnemonic was introduced in LLVM 18 along with
> __BPF_FEATURE_ADDR_SPACE_CAST. Every other inline-asm use of
> addr_space_cast in tools/testing/selftests/bpf/progs/ is guarded:
>
> verifier_arena.c at lines 511-638 wraps six uses inside '#if
> defined(__BPF_FEATURE_ADDR_SPACE_CAST)'.
>
> arena_atomics.c guards its uses with '#if defined(ENABLE_ATOMICS_TESTS)
> && defined(__BPF_FEATURE_ADDR_SPACE_CAST)'.
>
> verifier_zext.c guards with '#ifdef __BPF_FEATURE_ADDR_SPACE_CAST'.
>
> compute_live_registers.c guards with '#ifdef
> __BPF_FEATURE_ADDR_SPACE_CAST'.
>
> verifier_ldsx.c guards with '__clang_major__ >= 18'.
>
> The new code here is the only unguarded occurrence in the tree. On
> older clang this asm string will not parse and verifier_arena.bpf.o
> will fail to build.

The CI is using llvm21, so we should be okay.

>
>> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
>> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
>> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> [ ... ]
>
>> diff --git a/tools/testing/selftests/bpf/progs/aggregate_ret_func.c b/tools/testing/selftests/bpf/progs/aggregate_ret_func.c
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/aggregate_ret_func.c
>> @@ -0,0 +1,420 @@
> [ ... ]
>
>> +#if __clang_major__ >= 23
>> +
>> +struct pair {
>> +	__u64 hi;
>> +	__u64 lo;
>> +};
>> +
>> +union upair {
>> +	__u64 halves[2];
>> +	struct {
>> +		__u64 lo;
>> +		__u64 hi;
>> +	} parts;
>> +};
>> +
>> +/* A by-value struct that smuggles a pointer, which must be rejected. */
>> +struct with_ptr {
>> +	void *p;
>> +	__u64 x;
>> +};
>> +
>> +/* A by-value union that smuggles a pointer, which must be rejected too. */
>> +union upair_with_ptr {
>> +	void *p;
>> +	__u64 halves[2];
>> +};
>> +
>> +/* Global subprogram returning a scalar-only 16-byte struct in R0:R2. */
>> +__naked struct pair global_ret_struct(void)
>> +{
>> +	asm volatile (
>> +	"r0 = 0x1234;"	/* struct's first half */
>> +	"r2 = 0x5678;"	/* struct's second half */
>> +	"exit;"
>> +	);
>> +}
>> +
>> +/* Global subprogram returning a scalar-only 16-byte union in R0:R2. */
>> +__naked union upair global_ret_union(void)
>> +{
>> +	asm volatile (
>> +	"r0 = 0x1234;"
>> +	"r2 = 0x5678;"
>> +	"exit;"
>> +	);
>> +}
> [ ... ]
>
>> +__naked struct with_ptr global_ret_struct_ptr(void)
>> +{
>> +	asm volatile (
>> +	"r0 = 0;"
>> +	"r2 = 0;"
>> +	"exit;"
>> +	);
>> +}
>> +
>> +SEC("tc")
>> +__failure __msg("Global function global_ret_struct_ptr() has unsupported return type")
>> +__naked int aggregate_ret_global_struct_ptr_fail(void)
>> +{
>> +	asm volatile (
>> +	"call %[global_ret_struct_ptr];"
>> +	"r0 = 0;"
>> +	"exit;"
>> +	:
>> +	: __imm(global_ret_struct_ptr)
>> +	: __clobber_all);
>> +}
>> +
>> +__naked union upair_with_ptr global_ret_union_ptr(void)
>> +{
>> +	asm volatile (
>> +	"r0 = 0;"
>> +	"r2 = 0;"
>> +	"exit;"
>> +	);
>> +}
>> +
>> +SEC("tc")
>> +__failure __msg("Global function global_ret_union_ptr() has unsupported return type")
>> +__naked int aggregate_ret_global_union_ptr_fail(void)
>> +{
>> +	asm volatile (
>> +	"call %[global_ret_union_ptr];"
>> +	"r0 = 0;"
>> +	"exit;"
>> +	:
>> +	: __imm(global_ret_union_ptr)
>> +	: __clobber_all);
>> +}
>> +
>> +#endif /* __clang_major__ >= 23 */
>> +
>> +static __naked u128 agg_callee(void)
>> +{
>> +	asm volatile (
>> +	"r0 = 1;"
>> +	"r2 = 2;"
>> +	"exit;"
>> +	);
>> +}
> [ ... ]
>
>> +struct ptr_pair {
>> +	void *p;
>> +	__u64 x;
>> +};
>> +
>> +static __naked __noinline struct ptr_pair static_ret_ptr_pair(void)
>> +{
>> +	asm volatile (
>> +	"r0 = 0;"
>> +	"r2 = r1;"
>> +	"exit;"
>> +	);
>> +}
>> +
>> +SEC("tc")
>> +__success __retval(0)
>> +__naked int aggregate_ret_static_ptr_pair(void)
>> +{
>> +	asm volatile (
>> +	"call %[static_ret_ptr_pair];"
>> +	"r1 = *(u32 *)(r2 + 0);"	/* deref the returned ctx pointer */
>> +	"r0 = 0;"
>> +	"exit;"
>> +	:
>> +	: __imm(static_ret_ptr_pair)
>> +	: __clobber_all);
>> +}
> The file treats the same construct - a __naked subprogram whose C
> prototype returns a 16-byte aggregate - two different ways, and exactly
> one of the two must be wrong.
>
> Inside the guard at lines 218-349 sit global_ret_struct (struct pair),
> global_ret_union (union upair), global_ret_struct_ptr (struct
> with_ptr) and global_ret_union_ptr (union upair_with_ptr), plus their
> four test programs. Outside the guard, after #endif, lines 392-418 add
> struct ptr_pair, static_ret_ptr_pair() returning struct ptr_pair, and
> aggregate_ret_static_ptr_pair() - an unguarded naked subprogram
> returning a 16-byte struct by value, in the same file.
>
> If the guard is unnecessary, then the four guarded tests are dead on
> every toolchain in use today. That costs test coverage:
> 'aggregate_ret_global_struct_ptr_fail' and
> 'aggregate_ret_global_union_ptr_fail' are the only coverage anywhere in
> the tree for the __btf_type_is_scalar_struct() rejection added by this
> series to btf_validate_return_type() in kernel/bpf/btf.c. That check is
> the security-relevant half of the new convention - it stops a global
> subprogram from laundering a pointer to its caller through half of an
> "opaque scalar pair". Under this interpretation that check ships with
> zero test coverage until clang 23 is widely deployed, and the two
> positive tests 'aggregate_ret_global_struct' /
> 'aggregate_ret_global_union' (the only ones proving a struct/union - as
> opposed to __int128 - actually reaches R0:R2) are dead too.
>
> If the guard is necessary, then static_ret_ptr_pair is broken on clang
> < 23. The commit message states "a by-value return larger than 16 bytes
> is lowered to an sret pointer argument and the BTF the verifier reads
> says the function returns void". If a pre-23 backend does the same for
> any by-value aggregate return, then on clang < 23 static_ret_ptr_pair's
> BTF says void (or gains a hidden sret argument),
> bpf_ret_reg_pair(env, subprog) is false, prepare_func_exit() copies
> only R0 back into the caller, and the caller's 'r1 = *(u32 *)(r2 + 0)'
> hits R2 == NOT_INIT - the naked entry never wrote it. That would be 'R2
> !read_ok' at verifier.c, so a test tagged '__success __retval(0)' fails
> to load. test_aggregate_ret() calls RUN_TESTS(aggregate_ret_func)
> unconditionally - no arch or compiler gate - so this would be a hard
> FAIL for essentially every current toolchain.
>
> Evidence points at the guard being the mistake: (1) the same commit
> adds '__naked struct arena_ret_pair global_ret_arena_ptr_in_r2(void)'
> to progs/verifier_arena.c unguarded; (2) the same commit adds '__naked
> u128 agg_ret_target_func(void)' in progs/aggregate_ret_target.c
> unguarded; (3) progs/aggregate_ret_run.c's own comment says taking the
> address rather than calling "avoids any dependence on the compiler
> lowering an __int128 or struct return value". A naked body has no
> return statement to lower, so the source-level prototype is what lands
> in BTF.
>
> Either way the asymmetry needs resolving. If the guard is superfluous,
> could it be dropped or replaced with the '#if defined(__clang_major__)
> && __clang_major__ >= 23' + '#else' fallback shape used by
> aggregate_ret_struct_c.c? If it is not superfluous, should
> static_ret_ptr_pair and aggregate_ret_static_ptr_pair move inside it,
> and should progs/verifier_arena.c receive the same treatment?
>
> The lore discussion with Eduard Zingerman on v1 suggested moving the
> liveness test (aggregate_ret_live) to compute_live_registers.c, where
> such tests are usually added. You agreed ('I can move the test to
> compute_live_registers.c') but the test remains in aggregate_ret_func.c
> in v4. Should aggregate_ret_live be moved to
> compute_live_registers.c to follow the established pattern?

Okay, will do.

>
> The same v1 review suggested keeping only the C version of the global
> union test (not assembly) to reduce duplication. The assembly version
> aggregate_ret_global_union still exists in aggregate_ret_func.c. Would
> dropping the assembly version match the intent?

Let me check if indeed there are some redundancy.

>
>> diff --git a/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc.c b/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc.c
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc.c
> [ ... ]
>
>> diff --git a/tools/testing/selftests/bpf/progs/aggregate_ret_run.c b/tools/testing/selftests/bpf/progs/aggregate_ret_run.c
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/aggregate_ret_run.c
> [ ... ]
>
>> diff --git a/tools/testing/selftests/bpf/progs/aggregate_ret_target.c b/tools/testing/selftests/bpf/progs/aggregate_ret_target.c
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/aggregate_ret_target.c
> [ ... ]
>
>> diff --git a/tools/testing/selftests/bpf/progs/freplace_ret_pair.c b/tools/testing/selftests/bpf/progs/freplace_ret_pair.c
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/freplace_ret_pair.c
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31446101762

