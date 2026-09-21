Received: from mta1.migadu.com (out-86.mta1.migadu.com [95.215.58.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3B43BD659
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 14:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790001012; cv=none; b=T0faPbkeN3lUd9cYeVKHMw6yyt4YZ1HSVYN03FfrYl9ddNZknfKmaM99hP4dyqJxcsAzFjE4b3DwumiYt3JAdHXNgMsBoYTF0yXLoM22ssoj/3lhodIyJ2YVOJdlRiRuzK/xfqmI88hfOjHefCjjN1AMljcHYmIx4DfPPopSGJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790001012; c=relaxed/simple;
	bh=4zwY2EWKUPkAoPOhdMH70w4a9K2kA0pkxqd3nWDAogU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lAVYl7NE1qwXxdrSCidjS5zD+ZxQfYUHEzZct9rsFclDYuiso+rGVJphRGk8Wp+K3majj6BG8TGebjInRp6F/L6tPzTtTAk2ebFU2oqNOuwhAPX7x+fEXfrhYyYWtm5oaLOfBNmpZ4xnaZ4IyrXSD7JnmzCuqXhTXGoOjO9Qlc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=r7rBVQwx; arc=none smtp.client-ip=95.215.58.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r7rBVQwx"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=4zwY2EWKUPkAoPOhdMH70w4a9K2kA0pkxqd3nWDAogU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790001007; v=1; x=1790605807;
 b=r7rBVQwxAnpKXBATct0IJ73jjBoY3CUJbYqgMYzdqv43AEb0tXE/GjSz9Pl+TEFpY/sFbsHs
 ttkvmEQHHW4NuQWnmEFZR/PWvruhPAstVuC33IWfKcEBU1eO4QDVeLrjHTySbshv8xaipIQfjVn
 4yIcnlCFrV4w1oIyZlSxQBqo=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c34fa60c15bd6572;
	Mon, 21 Sep 2026 14:30:07 +0000
X-Mizu-Trace-ID: c34fa60c15bd6572
X-Migadu-Flow: FLOW_OUT
Message-ID: <5b5847cf-5c4d-495a-8195-29ff382d8a51@linux.dev>
Date: Mon, 21 Sep 2026 07:30:01 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 20/20] selftests/bpf: Load an exception
 cleanup program from a light skeleton
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20260920054408.875401-1-yonghong.song@linux.dev>
 <a956e774692a94a2926fb953553f546ab0293fca13f6d021bc3d75e89752bcf9@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <a956e774692a94a2926fb953553f546ab0293fca13f6d021bc3d75e89752bcf9@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/19/26 11:31 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
>> index 7ea5ba1df29e..981cc2643049 100644
>> --- a/tools/testing/selftests/bpf/Makefile
>> +++ b/tools/testing/selftests/bpf/Makefile
>> @@ -523,7 +523,7 @@ LINKED_SKELS := test_static_linked.skel.h linked_funcs.skel.h		\
>>   LSKELS := fexit_sleep.c trace_printk.c trace_vprintk.c map_ptr_kern.c 	\
>>   	core_kern.c core_kern_overflow.c test_ringbuf.c			\
>>   	test_ringbuf_n.c test_ringbuf_map_key.c test_ringbuf_write.c    \
>> -	test_ringbuf_overwrite.c
>> +	test_ringbuf_overwrite.c exceptions_cleanup_light.c
> [ ... ]
>
>> diff --git a/tools/testing/selftests/bpf/progs/exceptions_cleanup_light.c b/tools/testing/selftests/bpf/progs/exceptions_cleanup_light.c
>> new file mode 100644
>> index 000000000000..de7ae478d67f
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/exceptions_cleanup_light.c
>> @@ -0,0 +1,39 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
>> +#include <vmlinux.h>
>> +#include <bpf/bpf_helpers.h>
>> +#include "bpf_misc.h"
>> +#include "exceptions_cleanup.h"
>> +
>> +static __used __noinline void __kfunc_btf_anchor(void)
>> +{
>> +	bpf_throw(0);
>> +	bpf_preempt_disable();
>> +	bpf_preempt_enable();
>> +	bpf_unwind_resume();
>> +}
> Are the kfunc declarations in scope here? The file includes only
> <vmlinux.h>, <bpf/bpf_helpers.h>, "bpf_misc.h", and
> "exceptions_cleanup.h".
>
> bpf_throw(), bpf_preempt_disable(), and bpf_preempt_enable() are
> normally declared with __ksym in tools/testing/selftests/bpf/
> bpf_experimental.h, which is not included. bpf_unwind_resume() has no
> declaration in any userspace header in the tree.

I prefer to use vmlinux.h.

>
> Without __ksym == __attribute__((section(".ksyms"))), these become
> implicit function declarations, and libbpf's bpf_object__collect_externs()
> will reject any extern not in a ".ksyms" DATASEC when it tries to
> relocate the calls in the inline asm below.
>
> The __kfunc_btf_anchor() function exists specifically to produce extern
> BTF FUNCs that libbpf can relocate for the 'call bpf_throw' and
> 'call bpf_unwind_resume' sites in the inline asm. If the declarations
> are implicit, either the compile fails or bpftool rejects the object when
> generating the light skeleton.
>
> Should this file include "bpf_experimental.h" and add a declaration for
> bpf_unwind_resume()? The identical pattern appears in
> progs/exceptions_cleanup.c, progs/exceptions_cleanup_shapes.c, and
> progs/exceptions_cleanup_ext_table.c from earlier commits in this series,
> so the fix may need to be series-wide.
>
>> +
>> +__u64 pads_ran = 0;
>> +
>> +SEC("syscall")
>> +__naked int entry_light(void)
>> +{
>> +	asm volatile (
>> +	"call bpf_preempt_disable;"
>> +	"r1 = %[cookie];"
>> +"1:"	"call bpf_throw;"		/* cleanup region */
>> +"2:"
>> +	"exit;"
>> +"3:"					/* landing pad */
>> +	"call bpf_preempt_enable;"
>> +	PAD_RAN("%[ran]")
>> +	"call bpf_unwind_resume;"
>> +	"exit;"
>> +	CLEANUP_REC("1b", "2b", "3b")
>> +	:
>> +	: [cookie]"i"(THROW_COOKIE), [ran]"i"(RAN_LIGHT),
>> +	  __imm_addr(pads_ran)
>> +	: __clobber_all);
>> +}
>> +
>> +char _license[] SEC("license") = "GPL";
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35492765538

