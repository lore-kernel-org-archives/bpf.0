Received: from mta1.migadu.com (out-68.mta1.migadu.com [95.215.58.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAF71DF74F
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 03:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790737974; cv=none; b=tOjMUXgPmMeaXrUqNeuEwT9/7SjSocBDzqZp+1+avH2t02XhHXzBlBgXiDo2yi4XY9RGKuRJnVt9hNQ+p1rx08V+B9dsqXnVqow+173mqcsSr0C2C4hYHbqsUTk2d1SI6/8rCselRoy8jzUdklssnBb81YIhu0JUUWzgxx+mevY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790737974; c=relaxed/simple;
	bh=7t34H5aLmeZT8mN4v+w389CayGnpoP0uKM6m8TXhdyg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WtW+PVEB3SIq+Dl97EfL1lYuKqFyndROzAD/VS2FwjTC3Syqnlq6f2IMdJhvyvU/wAbwE43q/7u8pO/SQ/mrwM1mUkXhNErxT1xyZH1COwA8Yj7ArRQw1VIw5JvLyIecrElZvTdcvKk6kYoz4dsuwVbCPzPKkgcfj5bcRBAfOtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=V9rNnld6; arc=none smtp.client-ip=95.215.58.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="V9rNnld6"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=7t34H5aLmeZT8mN4v+w389CayGnpoP0uKM6m8TXhdyg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790737970; v=1; x=1791342770;
 b=V9rNnld6BUPIJJPt/ytvghJ1gZbVemA00JzPDuJ3np8AlJ9yGtIFZM5oHXUjfexxP3p3ot7q
 SBr+Cl/VzSSyG1m89sxRJ2IC86b7PRZ8JSyLdsDmVcWDo8Fd6a9qpLecq//iRqZXN21zQ42yRKb
 CTu14D5CATZSyqND2vemCtz8=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b8056c45788d203e;
	Wed, 30 Sep 2026 03:12:50 +0000
X-Mizu-Trace-ID: b8056c45788d203e
X-Migadu-Flow: FLOW_OUT
Message-ID: <a5d36d8f-cf4d-46b1-9c72-4ca808ffce42@linux.dev>
Date: Tue, 29 Sep 2026 20:12:43 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v7 22/22] selftests/bpf: Load an exception
 cleanup program from a light skeleton
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20260929001757.3256926-1-yonghong.song@linux.dev>
 <914df2aac52c3769cc5e0a433e8b6e792fec9288034f80af7b23a75e6568cce2@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <914df2aac52c3769cc5e0a433e8b6e792fec9288034f80af7b23a75e6568cce2@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/28/26 5:52 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/testing/selftests/bpf/Makefile.skel b/tools/testing/selftests/bpf/Makefile.skel
>> index 2e22bb901bf3..41575e180efb 100644
>> --- a/tools/testing/selftests/bpf/Makefile.skel
>> +++ b/tools/testing/selftests/bpf/Makefile.skel
>> @@ -33,7 +33,7 @@ LINKED_SKELS := test_static_linked.skel.h linked_funcs.skel.h		\
>>   LSKELS := fexit_sleep.c trace_printk.c trace_vprintk.c map_ptr_kern.c 	\
>>   	core_kern.c core_kern_overflow.c test_ringbuf.c			\
>>   	test_ringbuf_n.c test_ringbuf_map_key.c test_ringbuf_write.c    \
>> -	test_ringbuf_overwrite.c callx_rodata.c
>> +	test_ringbuf_overwrite.c callx_rodata.c exceptions_cleanup_light.c
> [ ... ]
>
>> diff --git a/tools/testing/selftests/bpf/progs/exceptions_cleanup_light.c b/tools/testing/selftests/bpf/progs/exceptions_cleanup_light.c
>> new file mode 100644
>> index 000000000000..19d53569bbda
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
>> +	bpf_unwind();
>> +	bpf_preempt_disable();
>> +	bpf_preempt_enable();
>> +	bpf_unwind_resume(NULL);
>> +}
>> +
>> +__u64 pads_ran = 0;
>> +
>> +SEC("syscall")
>> +__naked int entry_light(void)
>> +{
>> +	asm volatile (
>> +	"call bpf_preempt_disable;"
>> +"1:"	"call bpf_unwind;"		/* cleanup region */
>> +"2:"
>> +	"exit;"
>> +"3:"					/* landing pad */
>> +	"call bpf_preempt_enable;"
>> +	PAD_RAN("%[ran]")
>> +	"call bpf_unwind_resume;"
>> +	"exit;"
>> +	CLEANUP_REC("1b", "2b", "3b")
>> +	:
>> +	: [ran]"i"(RAN_LIGHT),
>> +	  __imm_addr(pads_ran)
>> +	: __clobber_all);
>> +}
>> +
>> +char _license[] SEC("license") = "GPL";
> A subsystem pattern flags this as potentially concerning:
>
> This adds a new BPF program file to test loading a cleanup table through
> the light skeleton path. The commit message states this is the smallest
> program that can verify whether the table survives the trip through
> bpf_gen__prog_load().
>
> However, progs/exceptions_cleanup.c already covers the same behavior
> more broadly - pads run on unwind and set bits in pads_ran. Makefile.skel
> already has LSKELS_EXTRA for building programs as both light skeleton
> and libbpf skeleton. Could exceptions_cleanup.c be built as a light
> skeleton and have the existing test cases (no_unwind, unwind_from_foo3,
> unwind_from_foo2) run through the gen loader path?
>
> That approach would also exercise the light skeleton code paths this new
> program never reaches. The new program has only one record in the main
> function, so in bpf_prog_collect_cleanup_info() it takes the owner == prog
> branch. The owner->sub_insn_off rebasing for records inside appended
> subprograms, and the multi-frame bpf_unwind_rewrite() walk, would not run
> under the gen loader with this minimal test.
>
> Should this be a light-skeleton case of the existing exceptions_cleanup.c
> instead of a separate file?

Okay, will follow your suggestions.

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36502848904

