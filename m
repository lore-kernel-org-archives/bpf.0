Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBAD1FD4
	for <bpf@vger.kernel.org>; Sat, 11 Jul 2026 03:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783742328; cv=none; b=os7pfMHt6rh8uysEV2DGybop86XIE3Poze5rq/NPKfjDYbt9GGB5oropCLwUFmZcp4YMCXSV8fJTMRD/etPTfclQyN+dLn7N69RdCp6kCU4S2IiPyrcIXtIGizjs0cDYXtfHtlq5quo8X/e1STe6UiraiEpXC4uUutP98ZgR+bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783742328; c=relaxed/simple;
	bh=pMhnAS25HDzy5Wect84Rrm/FgoMeJ6hIk3UOaEdXP74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qIqLXnzhhnS5R73bK3tzL+OXycw5FM6DQwMsEPvLILjQp8pBXq4IyoXtbbVkAJAbCOfs/qcDyMgAYKc99U2NOy3/dxGbOcrpEaatECaoTMdcFHLSYzGQacyRJ/dUE69gkSGmDgiSIkQsCepT+uc3ZYvrd8IxK7A3eOk091Tqleo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dTPS7DNz; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dTPS7DNz"
Message-ID: <03358a0d-94bc-407a-8b01-b3dd27c8d46b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783742322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+L2fotWTKvTv2UGxxBazkI4pbJRrX7zYesThKI+fkAk=;
	b=dTPS7DNzF7kPq1CDh7ZHlthugucJ+UOyjQntpkJgfpe8uXfOSj+eyi5GH7FFCJVFywTKA8
	BNvSQNrObVy3yti9Re/3bWZ2jmHAU4VyQqHmdi7Dpp9xpU/bXh1Soquh51YSX6L++Skwu1
	5UWKbe5QXn5bnPvGiwyDoqxLXUg71n8=
Date: Fri, 10 Jul 2026 20:58:15 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 0/3] bpf: Fix trampoline handling of 128-bit
 values
Content-Language: en-GB
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, kernel-team@fb.com,
 Alan Maguire <alan.maguire@oracle.com>
References: <20260710225206.4013062-1-yonghong.song@linux.dev>
 <DJVC4VW0JKXX.1DBERHV6ZVCMX@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <DJVC4VW0JKXX.1DBERHV6ZVCMX@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 7/10/26 6:02 PM, Kumar Kartikeya Dwivedi wrote:
> On Sat Jul 11, 2026 at 12:52 AM CEST, Yonghong Song wrote:
>> The BPF trampoline preserves only 8 bytes of a target function's return
>> value (R0), and its register save area under-allocates space for 128-bit
>> arguments for x86_64. These two problems lead to memory corruption or
>> incorrect values observed by BPF programs and the real caller.
>>
>> This series fixes both issues and adds two selftests, otherwise, each of
>> them will fail if without the corresponding fix.
>>
> This is almost ready, but CI currently fails for tracing_struct tests. [0]
>
> My AI agent suggests the following root cause, which sounds like a pahole issue.
>
> "
> • The failure is caused by missing module BTF, not by the trampoline fix itself.
>
>    tracing_struct/int128_args fails with -ESRCH because pahole omits
>    bpf_testmod_test_int128_arg() from bpf_testmod.ko’s BTF. The failure occurs
>    before the BPF program attaches; see .kdev/logs/vm-cmd.log:3.
>
>    The problematic signature is tools/testing/selftests/bpf/test_kmods/bpf_testmod.c:184:
>
>    bpf_testmod_test_int128_arg(__int128 a, int b, long c)
>
>    On x86-64:
>
>    - a consumes rdi:rsi.
>    - b, the second source parameter, is therefore in rdx.
>    - pahole maps the second parameter positionally to rsi, sees b in rdx, and
>      marks the function as having unexpected register usage.
>    - Kernel BTF generation enables consistent_func, so the complete function is
>      omitted from BTF (scripts/Makefile.btf:17).
>
>    Verbose pahole confirmed:
>
>    bpf_testmod_test_int128_arg : skipping BTF encoding of function due to unexpected register usage for parameter
>
>    This also means the comment claiming that putting __int128 first prevents the pahole issue is incorrect.
>
>    A scratch probe with the exact kdev Clang and pahole showed:
>
>    int128_first : skipping BTF encoding ...
>    FUNC int128_last ...
>
>    The likely test correction is to use:
>
>    bpf_testmod_test_int128_arg(int b, long c, __int128 a)
>
>    and update tools/testing/selftests/bpf/progs/tracing_struct_int128.c:12 to
>    read b from ctx[0], c from ctx[1], and the return value from ctx[4]. With two
>    preceding scalar registers, the 128-bit argument starts at an even register
>    pair on arm64 too. This still exercises the four-slot allocation that the x86
>    patch fixes.
> "
>
>    [0]: https://github.com/kernel-patches/bpf/pull/12778

Thanks, Kumar,

This indeed is a pahole issue. My local test is working because my local pahole
has the following patch set:
   pahole: Encode true signatures in kernel BTF
     https://lore.kernel.org/bpf/20260625020148.1883082-1-yonghong.song@linux.dev/

With this, e.g, running selftest like './test_progs -t tracing_struct' will succeed
for both clang21 and gcc15.

Without the above pahole patch set (pahole: Encode true signatures in kernel BTF),
the 'tracing_struct' test will fail with either llvm21 or gcc15:

libbpf: prog 'test_int128_arg_fexit': failed to find kernel BTF type ID of 'bpf_testmod_test_int128_arg': -ESRCH
libbpf: prog 'test_int128_arg_fexit': failed to prepare load attributes: -ESRCH
libbpf: prog 'test_int128_arg_fexit': failed to load: -ESRCH
libbpf: failed to load object 'tracing_struct_int128'
libbpf: failed to load BPF skeleton 'tracing_struct_int128': -ESRCH
test_int128_args:FAIL:tracing_struct_int128__open_and_load unexpected error: -3
#539/3   tracing_struct/int128_args:FAIL

So in order to unblock this patch set, the pahole patch set
   pahole: Encode true signatures in kernel BTF
should be merged soon (maybe after some minor adjustment).

I will contact Alan for this as I will take some time off in the next couple of weeks.

>
>> Changelogs:
>>    v2 -> v3:
>>      - v2: https://lore.kernel.org/bpf/20260710182204.1085329-1-yonghong.song@linux.dev/
>>      - Align __int128 argument at even position enforced by arm64.
>>    v1 -> v2:
>>      - v1: https://lore.kernel.org/bpf/20260710144404.2579671-1-yonghong.song@linux.dev/
>>      - Also handle __int128 arguments for x86_64.
>>
>> Yonghong Song (3):
>>    bpf: Reject >8 byte return values on return-reading trampoline paths
>>    bpf, x86: Fix trampoline stack size for 128-bit arguments
>>    selftests/bpf: Add tests for >8 byte return value and 128-bit
>>      arguments
>>
>>   arch/x86/net/bpf_jit_comp.c                   |  7 ++--
>>   kernel/bpf/bpf_struct_ops.c                   | 12 +++++++
>>   kernel/bpf/verifier.c                         | 25 +++++++++++++
>>   .../bpf/prog_tests/tracing_failure.c          | 12 +++++++
>>   .../selftests/bpf/prog_tests/tracing_struct.c | 36 +++++++++++++++++++
>>   .../selftests/bpf/progs/tracing_failure.c     |  6 ++++
>>   .../bpf/progs/tracing_struct_int128.c         | 18 ++++++++++
>>   .../selftests/bpf/test_kmods/bpf_testmod.c    | 32 +++++++++++++++++
>>   8 files changed, 143 insertions(+), 5 deletions(-)
>>   create mode 100644 tools/testing/selftests/bpf/progs/tracing_struct_int128.c

