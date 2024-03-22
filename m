Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C48A54FBE
	for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 16:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711123310; cv=none; b=WQTLSAzNd0Q6kVa9zngpmw/fhff+pUBERHkwS3NgdUXSCORpOt0Ba2zIFaTwFbfFUEa2Myos/i3LgcFbencUuFcMlnsil/TKMOrJRIrnYJYns0Z7LaZaE++xbWpNoPw94EQWoJoisqGMm7Ivy5xQMrgzj1bj4H/BTaxd/9znQZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711123310; c=relaxed/simple;
	bh=CvBW7n4DEm5yI8jesEugSrxvis0LLo0wTg4DxJPsMy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ckuoe4cXas8k0Tcy8LvVBYWbIxpTr5oD1bgSqtsX3ID5DYHrcytbb1PslAt34bdXeMukLkJa2VEXkcQvcMJBQz9ZtB43JBeS8ndBzn5KG2hoAl7Pvl7zu3d16vCzdhQ8M0YWW7HpDqNA8tDlf6VnCOAPtt9KBn2d9DA9BpU84v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rU5ZxcLe; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rU5ZxcLe"
Message-ID: <3c6729b3-f28c-4fc4-9f2e-4297185e8fa6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711123306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RH/TOGwP6aokJI6FFANZvFev2q39eE6W8uZI3lgL4/Y=;
	b=rU5ZxcLeAKKAwVSH818m4k9x30lPEFYz77yfhkyvHeXFOXEkMZ+wBhxYL7oh/tzObN6cDG
	FWU8isM1HieiHInAmeDuCc8W9C23414Kjw1FF+uUCNWsvzakSnOucbLJan9p8KZEEAanZu
	13SzibCtrsrerTg4dCbTH/8inSOaLjc=
Date: Fri, 22 Mar 2024 09:01:41 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 4/5] selftests/bpf: Fix
 kprobe_multi_bench_attach test failure with LTO kernel
Content-Language: en-GB
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
References: <20240321200058.2218328-1-yonghong.song@linux.dev>
 <20240321200119.2220027-1-yonghong.song@linux.dev> <Zf17ovmfcfAfAIBa@krava>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <Zf17ovmfcfAfAIBa@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 3/22/24 5:37 AM, Jiri Olsa wrote:
> On Thu, Mar 21, 2024 at 01:01:19PM -0700, Yonghong Song wrote:
>> In my locally build clang LTO kernel (enabling CONFIG_LTO and
>> CONFIG_LTO_CLANG_THIN), kprobe_multi_bench_attach/kernel subtest
>> failed like:
>>    test_kprobe_multi_bench_attach:PASS:get_syms 0 nsec
>>    test_kprobe_multi_bench_attach:PASS:kprobe_multi_empty__open_and_load 0 nsec
>>    libbpf: prog 'test_kprobe_empty': failed to attach: No such process
>>    test_kprobe_multi_bench_attach:FAIL:bpf_program__attach_kprobe_multi_opts unexpected error: -3
>>    #117/1   kprobe_multi_bench_attach/kernel:FAIL
>>
>> There are multiple symbols in /sys/kernel/debug/tracing/available_filter_functions
>> are renamed in /proc/kallsyms due to cross file inlining. One example is for
>>    static function __access_remote_vm in mm/memory.c.
>> In a non-LTO kernel, we have the following call stack:
>>    ptrace_access_vm (global, kernel/ptrace.c)
>>      access_remote_vm (global, mm/memory.c)
>>        __access_remote_vm (static, mm/memory.c)
>>
>> With LTO kernel, it is possible that access_remote_vm() is inlined by
>> ptrace_access_vm(). So we end up with the following call stack:
>>    ptrace_access_vm (global, kernel/ptrace.c)
>>      __access_remote_vm (static, mm/memory.c)
>> The compiler renames __access_remote_vm to __access_remote_vm.llvm.<hash>
>> to prevent potential name collision.
>>
>> The kernel bpf_kprobe_multi_link_attach() and ftrace_lookup_symbols() try
>> to find addresses based on /proc/kallsyms, hence the current test failed
>> with LTO kenrel.
>>
>> This patch removed __access_remote_vm and other similar functions from
>> kprobe_multi_attach by checking if the symbol like __access_remote_vm
>> does not exist in kallsyms with LTO kernel. The test succeeded after this change:
>>    #117/1   kprobe_multi_bench_attach/kernel:OK
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   .../selftests/bpf/prog_tests/kprobe_multi_test.c     | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
>> index 05000810e28e..f6130f4f3d88 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
>> @@ -345,6 +345,9 @@ static int get_syms(char ***symsp, size_t *cntp, bool kernel)
>>   	FILE *f;
>>   	int err = 0;
>>   
>> +	if (!ASSERT_OK(load_kallsyms(), "load_kallsyms"))
>> +		return -EINVAL;
>> +
>>   	/*
>>   	 * The available_filter_functions contains many duplicates,
>>   	 * but other than that all symbols are usable in kprobe multi
>> @@ -393,6 +396,15 @@ static int get_syms(char ***symsp, size_t *cntp, bool kernel)
>>   		if (!strncmp(name, "__ftrace_invalid_address__",
>>   			     sizeof("__ftrace_invalid_address__") - 1))
>>   			continue;
>> +		/*
>> +		 * In certain cases, e.g., clang lto kernel, the 'name' here
>> +		 * may be different from the one in /proc/kallsyms due to
>> +		 * /proc/kallsyms name might be "<name>.llvm.<hash>" instead
>> +		 * of "<name>". Exclude these 'name's since they will cause
>> +		 * later kprobe_multi_attach failure.
>> +		 */
>> +		if (ksym_get_addr(name) == 0)
>> +			continue;
> curious how many symbols like that are there?

The number of entries in /sys/kernel/tracing/available_filter_functions: 50654
After existing filtering ('arch_cpu_idle') etc: 50513 (filtering 141)
After above ksym_get_addr(name) check: 49437 (further filtering 1076)

>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
>
> jirka
>
>>   
>>   		err = hashmap__add(map, name, 0);
>>   		if (err == -EEXIST) {
>> -- 
>> 2.43.0
>>
>>
