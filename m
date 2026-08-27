Received: from mta0.migadu.com (out-159.mta0.migadu.com [91.218.175.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D443C1FB1
	for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 03:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787802410; cv=none; b=J+XrZzhdAqnjTHguw71QD7SVeSZA1RDNMNXP9qYQGwhS/Z81FGyAgAo8RThhRIhJ2Blf2NzZQWjHARtE5vP2NOwnROxeGvTvhpj9p22M5eF+MbaPPeK0aXoZZ62uI/6lwmjmNVYLQsbpxlAfOAZX7gj4kL9guQKMIM4y5tr7eCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787802410; c=relaxed/simple;
	bh=XUKsuDXELSNkbNPdKBemYDdM/dpZpkXAklyV2WSvdoQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o0PgyZ8wDIyybe8JCOYK3V3aXPTmkeAtcWP5pjj/2K3o4Z+vQ5pvQ3eGH9CK+FGmMfj69r8bm81OfMBJ5IDMXABevxA83rHbfgjC8TQGQ8oqazdtDTDH/ck7B+vOKjTgqZO4I/QtEKHJNEOoooUo72JcuLgXUxVH7kT03IGvuJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mlYcSYH3; arc=none smtp.client-ip=91.218.175.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mlYcSYH3"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=XUKsuDXELSNkbNPdKBemYDdM/dpZpkXAklyV2WSvdoQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787802405; v=1; x=1788407205;
 b=mlYcSYH3xKdySOKkO9mx3qACq+DvvC14wB7mcboMP8c+JhluKZrpMSgPdDcOGCwnnqCNV6rT
 qR9ebPzPUs8DJ9qN+pIMLX0HSu/CQCHczeBK7sUcuISVAG7II/T+hsad+RV1DxirDaqSqABsTjv
 rd6NARZklGAF1YshRQznmoPc=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2600:381:1f2b:fe25:1c70:a7b8:f5b7:8b42] (2600:381:1f2b:fe25:1c70:a7b8:f5b7:8b42)
	by smtp.migadu.com with ESMTPS id d8ea3bb7130c453e;
	Thu, 27 Aug 2026 03:46:45 +0000
X-Mizu-Trace-ID: d8ea3bb7130c453e
X-Migadu-Flow: FLOW_OUT
Message-ID: <5d63a77b-7fa0-4a74-8139-9826f3c3b27a@linux.dev>
Date: Wed, 26 Aug 2026 20:46:37 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 09/10] selftests/bpf: Test global functions
 returning arena pointers by value
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20260825205458.1325916-1-yonghong.song@linux.dev>
 <6211bca923f58d1bbb9404cec8a518c0c2b508799853fd4879403d1edc1641c6@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <6211bca923f58d1bbb9404cec8a518c0c2b508799853fd4879403d1edc1641c6@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/25/26 2:59 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/testing/selftests/bpf/progs/aggregate_ret_func.c b/tools/testing/selftests/bpf/progs/aggregate_ret_func.c
>> index 6f66fc822cede..237adb8e5ee1e 100644
>> --- a/tools/testing/selftests/bpf/progs/aggregate_ret_func.c
>> +++ b/tools/testing/selftests/bpf/progs/aggregate_ret_func.c
>> @@ -2,6 +2,7 @@
>>   /* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
>>   #include <linux/bpf.h>
>>   #include <bpf/bpf_helpers.h>
>> +#include <bpf_arena_common.h>
>>   #include "bpf_misc.h"
> [ ... ]
>
>> @@ -234,4 +235,121 @@ __naked int aggregate_ret_global_union_ptr_fail(void)
>>
>>   #endif
>>
>> +/*
>> + * gcc returns a by-value struct through a hidden pointer, and emits the
>> + * 'r0 = r1' returning it after the __naked body's exit, leaving the
>> + * subprogram falling through. Build these with clang only.
>> + */
>> +#if defined(__clang__)
> Should this use the same clang version check as the structurally identical
> block at line 178? That block checks '#if defined(__clang_major__) &&
> __clang_major__ >= 23' for __naked functions returning by-value structs:
>
> aggregate_ret_func.c:178
> #if defined(__clang_major__) && __clang_major__ >= 23
> ...
> __naked struct with_ptr global_ret_struct_ptr(void)
> {
> 	asm volatile (
> 	"r0 = 0;"
> 	"r2 = 0;"
> 	"exit;"
> 	);
> }
>
> SEC("tc")
> __load_if_JITed()
> __failure __msg("has unsupported return type")
> __naked int aggregate_ret_global_struct_ptr_fail(void)
> {
> 	asm volatile (
> 	"call %[global_ret_struct_ptr];"
> 	"r0 = 0;"
> 	"exit;"
> 	:
> 	: __imm(global_ret_struct_ptr)
> 	: __clobber_all);
> }
>
> The verifier_arena.c hunk added in this same commit also uses the '>= 23'
> guard:
>
> verifier_arena.c:737
> #if defined(__clang_major__) && __clang_major__ >= 23
>
> struct arena_page_pair {
> 	u32 __arena *first;
> 	u32 __arena *second;
> };
>
> __weak struct arena_page_pair split_arena_page(u32 __arena *page)
> {
> 	...
> }
>
> By-value struct returns in registers are an LLVM 23 BPF-ABI feature. With
> an older clang, the return is lowered through a hidden pointer (sret), which
> is the gcc behavior described in your new comment.
>
> With clang < 23, the four new '__success __retval(0)' tests would be
> compiled against a different signature than intended. The callers never
> initialize r1, so they would be checked against a prototype that no longer
> matches 'returns struct arena_pair' in the BTF.
>
> Can the two adjacent blocks be consistent about which toolchains can build
> the same construct?

The condition "defined(__clang_major__) && __clang_major__ >= 23"
is needed since returning two registers is only supported at >= llvm23.

Another case is for __clang__ guard. For naked function, clang compilation
will maintain naked asm code. But for gcc, even for naked function, it
still check the return type during lowering and at that point, gcc will
change e.g. 16-byte return type to a sret, which is not what we want.

I will make sure this is explained in commit message.

>
>> +
>> +struct arena_pair {
>> +	void __arena *lo;
>> +	void __arena *hi;
>> +};
>> +
>> +struct arena_and_scalar {
>> +	void __arena *p;
>> +	__u64 x;
>> +};
>> +
>> +struct arena_array {
>> +	void __arena *p[2];
>> +};
>> +
>> +struct arena_single {
>> +	void __arena *p;
>> +};
>> +
>> +__naked struct arena_pair global_ret_arena_pair(void)
>> +{
>> +	asm volatile (
>> +	"r0 = 0;"
>> +	"r2 = 0;"
>> +	"exit;"
>> +	);
>> +}
>> +
>> +SEC("tc")
>> +__load_if_JITed()
>> +__success __retval(0)
>> +__naked int aggregate_ret_global_arena_pair(void)
>> +{
>> +	asm volatile (
>> +	"call %[global_ret_arena_pair];"
>> +	"r0 = 0;"
>> +	"exit;"
>> +	:
>> +	: __imm(global_ret_arena_pair)
>> +	: __clobber_all);
>> +}
>> +
>> +__naked struct arena_and_scalar global_ret_arena_and_scalar(void)
>> +{
>> +	asm volatile (
>> +	"r0 = 0;"
>> +	"r2 = 0;"
>> +	"exit;"
>> +	);
>> +}
>> +
>> +SEC("tc")
>> +__load_if_JITed()
>> +__success __retval(0)
>> +__naked int aggregate_ret_global_arena_and_scalar(void)
>> +{
>> +	asm volatile (
>> +	"call %[global_ret_arena_and_scalar];"
>> +	"r0 = 0;"
>> +	"exit;"
>> +	:
>> +	: __imm(global_ret_arena_and_scalar)
>> +	: __clobber_all);
>> +}
>> +
>> +__naked struct arena_array global_ret_arena_array(void)
>> +{
>> +	asm volatile (
>> +	"r0 = 0;"
>> +	"r2 = 0;"
>> +	"exit;"
>> +	);
>> +}
>> +
>> +SEC("tc")
>> +__load_if_JITed()
>> +__success __retval(0)
>> +__naked int aggregate_ret_global_arena_array(void)
>> +{
>> +	asm volatile (
>> +	"call %[global_ret_arena_array];"
>> +	"r0 = 0;"
>> +	"exit;"
>> +	:
>> +	: __imm(global_ret_arena_array)
>> +	: __clobber_all);
>> +}
>> +
>> +__naked struct arena_single global_ret_arena_single(void)
>> +{
>> +	asm volatile (
>> +	"r0 = 0;"
>> +	"exit;"
>> +	);
>> +}
>> +
>> +SEC("tc")
>> +__success __retval(0)
>> +__naked int aggregate_ret_global_arena_single(void)
>> +{
>> +	asm volatile (
>> +	"call %[global_ret_arena_single];"
>> +	"r0 = 0;"
>> +	"exit;"
>> +	:
>> +	: __imm(global_ret_arena_single)
>> +	: __clobber_all);
>> +}
>> +
>> +#endif
>> +
>>   char _license[] SEC("license") = "GPL";
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32899532405

