Received: from mta0.migadu.com (out-248.mta0.migadu.com [91.218.175.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F71296BCF
	for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 03:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787803122; cv=none; b=jSyZvnt9KstRtaR1hWTYuxKOQQT09bcLQZhV5Kxn8OHzi9I4UCwib8y7TaFQbL3mab1xNU31S/6tk4AjoyqeEXnH/H2HfP3PvDF0ypxCu/2whXjBPaBUGZSo9JpQTXsZbJQzO6yT29qupxiBo6k2LNfhP1Xb8oy0nYJcoMptSOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787803122; c=relaxed/simple;
	bh=Sf5op7uIaxo4lWV3tyokSQj5UeVH3VaaZ9YuKEstFos=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lYErAwnco9okafamu3krM6DSt+OLHJZF/dpsdKnG6/vRg2+Ib0eGtkTZGgxlFsL/8sETHOQYEDDNxFSlo75xZEJ6e2lxdz85wR/RMGusg6UM0iUZ7Apum5jzLB0X9kgVW3O/DUeCJE78ZmrDesswre2PLA1j6RzPcJl4c3/9mow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Z9eD76M9; arc=none smtp.client-ip=91.218.175.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Z9eD76M9"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Sf5op7uIaxo4lWV3tyokSQj5UeVH3VaaZ9YuKEstFos=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787803118; v=1; x=1788407918;
 b=Z9eD76M9LGnt7gpa/zPi/2hCaDPSHzwUfntvFKEYyP9ksfxNa3NdlLoJxI/AEbVffQ/1BxeX
 UF7p8r/TO3nTXlI+LuRwBDgI+RW1qJva6U+0jOgMisMuXMcag0bpJSVzwI4pPk37H8ZSYzAgfnq
 AcMzamQ+G4TMm3yc44WI1B4U=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2600:381:1f2b:fe25:1c70:a7b8:f5b7:8b42] (2600:381:1f2b:fe25:1c70:a7b8:f5b7:8b42)
	by smtp.migadu.com with ESMTPS id 267b77ceceda8b46;
	Thu, 27 Aug 2026 03:58:38 +0000
X-Mizu-Trace-ID: 267b77ceceda8b46
X-Migadu-Flow: FLOW_OUT
Message-ID: <d479c649-9ced-4053-8aa0-ea8b74b09088@linux.dev>
Date: Wed, 26 Aug 2026 20:58:33 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 10/10] selftests/bpf: Test kfuncs returning
 arena pointers by value
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20260825205503.1327012-1-yonghong.song@linux.dev>
 <77c79917dc8a9d299cfa0725c5bf278a32d9563915878546fe394650eeade3d8@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <77c79917dc8a9d299cfa0725c5bf278a32d9563915878546fe394650eeade3d8@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/25/26 2:59 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/testing/selftests/bpf/prog_tests/aggregate_ret.c b/tools/testing/selftests/bpf/prog_tests/aggregate_ret.c
>> index e0b94ed10f941..07d9d6e1d6b88 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/aggregate_ret.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/aggregate_ret.c
>> @@ -1,11 +1,53 @@
>>   // SPDX-License-Identifier: GPL-2.0
>>   /* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
>>   #include <test_progs.h>
>> +#include <bpf/btf.h>
>>   #include "aggregate_ret_func.skel.h"
>>   #include "aggregate_ret_kfunc.skel.h"
>> +#include "aggregate_ret_kfunc_arena.skel.h"
>> +
>> +static bool testmod_has_arena_tagged_member(void)
>> +{
>> +	struct btf *vmlinux_btf, *module_btf = NULL;
>> +	const struct btf_type *t;
>> +	bool tagged = false;
>> +	__s32 id;
>> +
>> +	vmlinux_btf = btf__load_vmlinux_btf();
>> +	if (!vmlinux_btf)
>> +		return false;
>> +
>> +	module_btf = btf__load_module_btf("bpf_testmod", vmlinux_btf);
>> +	if (!module_btf)
>> +		goto out;
>> +
>> +	/* prog_test_ret_arena::a is 'void __arena_tag *': PTR -> TYPE_TAG -> void */
>> +	id = btf__find_by_name_kind(module_btf, "prog_test_ret_arena", BTF_KIND_STRUCT);
>> +	if (id <= 0)
>> +		goto out;
>> +
>> +	t = btf__type_by_id(module_btf, btf_members(btf__type_by_id(module_btf, id))[0].type);
>> +	if (!t || !btf_is_ptr(t))
>> +		goto out;
>> +
>> +	t = btf__type_by_id(module_btf, t->type);
>> +	tagged = t && btf_is_type_tag(t) &&
>> +		 !strcmp(btf__name_by_offset(module_btf, t->name_off), "arena");
>> +
>> +out:
>> +	btf__free(module_btf);
>> +	btf__free(vmlinux_btf);
>> +
>> +	return tagged;
>> +}
>>
>>   void test_aggregate_ret(void)
>>   {
>>   	RUN_TESTS(aggregate_ret_func);
>>   	RUN_TESTS(aggregate_ret_kfunc);
>> +
>> +	if (testmod_has_arena_tagged_member())
>> +		RUN_TESTS(aggregate_ret_kfunc_arena);
>> +	else
>> +		test__skip();
> A subsystem pattern flags this as potentially concerning:
> testmod_has_arena_tagged_member() collapses four distinct outcomes
> into the same 'false' return: environment broken (no vmlinux BTF),
> testmod absent or BTF missing, stale bpf_testmod.ko, or the actual
> capability probe (btf_type_tag attribute absent). When test__skip()
> is called without a reason string, the run shows 'aggregate_ret:OK
> (SKIP: 1/N)' with no indication of what was skipped or why.
>
> Since PAHOLE_HAS_BTF_TAG depends on CC_IS_CLANG (lib/Kconfig.debug)
> and GCC does not implement btf_type_tag, the skip branch is the normal
> outcome on a GCC-built kernel, which makes a permanently-skipped test
> easy to miss. The test appears to pass but the new coverage never runs.
>
> The BPF selftests/bpf/prog_tests/btf_tag.c establishes a precedent:
> it checks env.has_testmod, uses ASSERT_OK_PTR() so a BTF-load failure
> is a real FAIL, and prints a reason string before test__skip():
>
>      printf("%s:SKIP: btf_type_tag attribute not in %s", __func__, module_name)
>
> Should testmod_has_arena_tagged_member() distinguish a broken environment
> (ASSERT_OK_PTR on the vmlinux BTF) from a missing capability, and should
> the test__skip() carry a reason string?

It is already very clear for SKIP which is due to btf_type_tag attribute
is not available. The checking for e.g. vmlinux, load_module etc is
normal checking. It is to prevent potential environment issue but does not
mean the environment is broken.

>
>>   }
>> diff --git a/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc_arena.c b/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc_arena.c
>> new file mode 100644
>> index 0000000000000..f68deae6c900e
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc_arena.c
>> @@ -0,0 +1,47 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
>> +#include <vmlinux.h>
>> +#include <bpf/bpf_helpers.h>
>> +#include "bpf_misc.h"
>> +#include "../test_kmods/bpf_testmod_kfunc.h"
>> +
>> +void __kfunc_btf_root(void)
>> +{
>> +	asm volatile (""
>> +	:
>> +	: "r"(&bpf_kfunc_call_test_ret_arena),
>> +	  "r"(&bpf_kfunc_call_test_ret_arena_mixed));
>> +}
> A subsystem pattern flags this as potentially concerning: a new BPF
> prog file is added for two test cases, but progs/aggregate_ret_kfunc.c
> in the same directory already covers by-value kfunc returns
> (aggregate_ret_kfunc_precise, _fastcall_fail, _ptr_fail,
> _nested_ptr_fail, _too_deep_fail, _small_no_r2, _too_big_fail). The
> new file duplicates the header includes, the license string, the
> SEC("tc")/__arch_x86_64/__arch_arm64/__load_if_JITed() preamble and
> __kfunc_btf_root() itself, for two subtests.
>
> RUN_TESTS() operates on a whole skeleton (test_progs.h:546 ->
> test_loader__run_subtests(&tester, #skel, skel##__elf_bytes)), and
> these two subtests must be gated on whether the running bpf_testmod's
> BTF carries the 'arena' type tag - a per-toolchain condition that has
> no per-subtest expression in bpf_misc.h (__arch_*/__load_if_JITed
> cover architecture and JIT only). Putting them in
> aggregate_ret_kfunc.c would force the whole existing matrix behind
> the same gate.
>
> Is the separate file justified by the per-skeleton gating requirement,
> or could the new cases be added to aggregate_ret_kfunc.c?

Yes, I would like to be in aggregate_ret_kfunc_arena.c as
we want to test kfunc with arena's.

>
>> +
>> +SEC("tc")
>> +__arch_x86_64 __arch_arm64
>> +__load_if_JITed()
>> +__success __retval(0)
>> +__naked int aggregate_ret_kfunc_arena(void)
>> +{
>> +	asm volatile (
>> +	"call %[bpf_kfunc_call_test_ret_arena];"
>> +	"r0 = 0;"
>> +	"exit;"
>> +	:
>> +	: __imm(bpf_kfunc_call_test_ret_arena)
>> +	: __clobber_all);
>> +}
>> +
>> +SEC("tc")
>> +__arch_x86_64 __arch_arm64
>> +__load_if_JITed()
>> +__success __retval(0)
>> +__naked int aggregate_ret_kfunc_arena_mixed(void)
>> +{
>> +	asm volatile (
>> +	"r1 = 0;"
>> +	"call %[bpf_kfunc_call_test_ret_arena_mixed];"
>> +	"r0 = 0;"
>> +	"exit;"
>> +	:
>> +	: __imm(bpf_kfunc_call_test_ret_arena_mixed)
>> +	: __clobber_all);
>> +}
> The changelog claims this patch covers 'two arena pointers filling
> R0:R2', but neither new program ever reads R2. Both bodies are
> 'call <kfunc>; r0 = 0; exit;' with __success __retval(0), which only
> proves that check_kfunc_call() accepted the return type - i.e. that
> btf_struct_member_walk(..., BTF_MEMBER_SCALAR | BTF_MEMBER_ARENA_PTR, ...)
> returned true (kernel/bpf/verifier.c:14097). The number of return
> registers is decided separately by mark_kfunc_ret_regs() -> ret_regs_cnt(size)
> (kernel/bpf/verifier.c:11351, :413); if that path regressed to a
> single register for a 16-byte STRUCT return, both new tests would
> still pass, because R2 is never read.
>
> The file this patch sits beside already establishes the idiom for
> pinning this: aggregate_ret_kfunc_small_no_r2 asserts __failure
> __msg("R2 !read_ok") to prove R2 is *not* a return register for an
> 8-byte struct, and aggregate_ret_kfunc_precise reads 'r6 = r2' after
> the __int128 kfunc to prove R2 *is*.
>
> Should at least one of the arena tests read R2 back to verify the
> two-register return path?

Yes, this is a problem. I will try to come up with better tests.

>
>> +
>> +char _license[] SEC("license") = "GPL";
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32899532405

