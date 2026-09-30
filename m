Received: from mta1.migadu.com (out-19.mta1.migadu.com [95.215.58.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4964532B108
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 01:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790732576; cv=none; b=bbr4pr5FafrZyIzNqGPySQkBT1UmJHZnCqACcHfKCrKTf3DZ/KLDfyL06mbnnayPrY3H27rRV9uoQJpTPlfsvP39ZjEo6Ejx5oFVPKuribI+R1mo6S2EuDOLWz06qo6Ebile076woYnIWhLwrPrNz49jA6nsGjzsWaZXWvb6GIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790732576; c=relaxed/simple;
	bh=twkuGM2txU1PIRmt4tSHKY29rliboSJcKKiRTV4Ghq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kJ4ONAK9r32pIKoefskyqqPYw7XVX75zIWtp8uODDVDsyCrdWlDkhMgXEkgRJct9sdKF5YGpCsJW7C6rE2V8S/WQKpJyQ7UDWHuzpRnhg76nmS8OyYU59xKJCYyRA7f+vakhVbnGDWVk+S25FpMnsR2oEORgeMUgM1cnMlMJzZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GyQnEc5i; arc=none smtp.client-ip=95.215.58.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GyQnEc5i"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=twkuGM2txU1PIRmt4tSHKY29rliboSJcKKiRTV4Ghq0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790732572; v=1; x=1791337372;
 b=GyQnEc5igHlNdjII2Pg6m01k/N9BeVk4m5t8DgcCa4je4ccM+ovI2EKJ7Tw3e0P4gMNy0JS6
 TflRkhvNyrjQ06fIhBAFrNwoSB/6/ttR5j8lNgS+Qes2K5pEVuUSomMFdrn4E/WKRysG+DKQAN1
 bgrfB5dYQcjyA9kwPKg9a51A=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 49faa4691a67d2cc;
	Wed, 30 Sep 2026 01:42:52 +0000
X-Mizu-Trace-ID: 49faa4691a67d2cc
X-Migadu-Flow: FLOW_OUT
Message-ID: <e0a5e59a-23f9-4a5d-bb83-07e2f6948594@linux.dev>
Date: Tue, 29 Sep 2026 18:42:45 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v7 19/22] selftests/bpf: Add end-to-end and
 negative .bpf_cleanup exception tests
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20260929001741.3255990-1-yonghong.song@linux.dev>
 <6a088778cba5c689e9024c435e0e092047176fff11c56ce6cb04d732b6073c34@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <6a088778cba5c689e9024c435e0e092047176fff11c56ce6cb04d732b6073c34@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/28/26 5:52 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/testing/selftests/bpf/progs/exceptions_cleanup_fail.c b/tools/testing/selftests/bpf/progs/exceptions_cleanup_fail.c
>> new file mode 100644
>> index 000000000000..76cca8dc45a9
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/exceptions_cleanup_fail.c
>> @@ -0,0 +1,878 @@
> [ ... ]
>
>> +static __used __noinline void __kfunc_btf_anchor(void)
>> +{
>> +	bpf_throw(0);
>> +	bpf_unwind();
>> +	bpf_preempt_disable();
>> +	bpf_preempt_enable();
>> +	bpf_rcu_read_lock();
>> +	bpf_rcu_read_unlock();
>> +	bpf_unwind_resume(NULL);
>> +}
>> +
>> +/* An unwind raised in a callee, which is how a cleanup region gets one. */
>> +static __used __naked __noinline __u64 inner_unwind(void)
>> +{
>> +	asm volatile (
>> +	"r1 = 1;"
>> +	"call bpf_unwind;"
>> +	"r0 = 0;"
>> +	"exit;"
>> +	::: __clobber_all);
>> +}
> [ ... ]
>
>> +static __used __naked __noinline __u64 unwind_in_pad_frame(void)
>> +{
>> +	asm volatile (
>> +	"call bpf_preempt_disable;"
>> +"1:"	"call inner_unwind;"		/* cleanup region */
>> +"2:"
>> +	"call bpf_preempt_enable;"
>> +	"r0 = 0;"
>> +	"exit;"
>> +"3:"					/* landing pad that unwinds again */
>> +	"call bpf_preempt_enable;"
>> +	"r1 = 2;"
>> +	"call bpf_unwind;"
>> +	"call bpf_unwind_resume;"
>> +	"exit;"
>> +	CLEANUP_REC("1b", "2b", "3b")
>> +	::: __clobber_all);
>> +}
> [ ... ]
>
>> +static __used __naked __noinline __u64 cb_and_table_frame(void)
>> +{
>> +	asm volatile (
>> +	"call bpf_preempt_disable;"
>> +	"r1 = 9;"
>> +"1:"	"call bpf_unwind;"		/* cleanup region */
>> +"2:"
>> +	"r0 = 0;"
>> +	"exit;"
>> +"3:"					/* landing pad */
>> +	"call bpf_preempt_enable;"
>> +	"call bpf_unwind_resume;"
>> +	"exit;"
>> +	CLEANUP_REC("1b", "2b", "3b")
>> +	::: __clobber_all);
>> +}
> [ ... ]
>
>> +static __used __naked __noinline __u64 pad_calls_thrower_frame(void)
>> +{
>> +	asm volatile (
>> +	"call bpf_preempt_disable;"
>> +	"r1 = 11;"
>> +"1:"	"call bpf_unwind;"		/* cleanup region */
>> +"2:"
>> +	"r0 = 0;"
>> +	"exit;"
>> +"3:"					/* landing pad */
>> +	"call pad_callee_that_throws;"	/* ...which can throw: refused */
>> +	"call bpf_preempt_enable;"
>> +	"call bpf_unwind_resume;"
>> +	"exit;"
>> +	CLEANUP_REC("1b", "2b", "3b")
>> +	::: __clobber_all);
>> +}
> [ ... ]
>
>> +static __used __naked __noinline __u64 catch_pad_frame(void)
>> +{
>> +	asm volatile (
>> +	"call bpf_preempt_disable;"
>> +	"r1 = 12;"
>> +"1:"	"call bpf_unwind;"		/* cleanup region */
>> +"2:"
>> +	"r0 = 0;"
>> +	"exit;"
>> +"3:"					/* catch pad: no resume, it stops here */
>> +	"call bpf_preempt_enable;"
>> +	"r0 = 0;"
>> +	"exit;"
>> +	CLEANUP_REC("1b", "2b", "3b")
>> +	::: __clobber_all);
>> +}
> [ ... ]
>
>> +static __used __naked __noinline __u64 stray_resume_frame(void)
>> +{
>> +	asm volatile (
>> +	"call bpf_preempt_disable;"
>> +	"r1 = 13;"
>> +"1:"	"call bpf_unwind;"		/* cleanup region */
>> +"2:"
>> +	"r0 = 0;"
>> +	"exit;"
>> +"3:"					/* landing pad */
>> +	"call bpf_preempt_enable;"
>> +	"call bpf_unwind_resume;"
>> +	"exit;"
>> +	CLEANUP_REC("1b", "2b", "3b")
>> +	::: __clobber_all);
>> +}
> [ ... ]
>
>> +static __used __naked __noinline __u64 pad_calls_resumer_frame(void)
>> +{
>> +	asm volatile (
>> +	"call bpf_preempt_disable;"
>> +	"r1 = 14;"
>> +"1:"	"call bpf_unwind;"		/* cleanup region */
>> +"2:"
>> +	"r0 = 0;"
>> +	"exit;"
>> +"3:"					/* landing pad */
>> +	"call bpf_preempt_enable;"
>> +	"call resume_in_callee;"	/* ...which resumes: refused */
>> +	"call bpf_unwind_resume;"
>> +	"exit;"
>> +	CLEANUP_REC("1b", "2b", "3b")
>> +	::: __clobber_all);
>> +}
> [ ... ]
>
>> +static __used __naked __noinline void gotox_unwinder(void)
>> +{
>> +	asm volatile (
>> +	"r1 = 15;"
>> +	"call bpf_unwind;"
>> +	"exit;"
>> +	::: __clobber_all);
>> +}
> This isn't a bug, but bpf_unwind() is declared as __bpf_kfunc void
> bpf_unwind(void) in kernel/bpf/helpers.c and takes no arguments.
>
> Several of these inline asm frames load r1 with a numbered value right
> before calling bpf_unwind: r1=1 in inner_unwind, r1=2 in
> unwind_in_pad_frame, r1=9 in cb_and_table_frame, r1=11 in
> pad_calls_thrower_frame, r1=12 in catch_pad_frame, r1=13 in
> stray_resume_frame, r1=14 in pad_calls_resumer_frame, and r1=15 in
> gotox_unwinder.
>
> Other bpf_unwind call sites in the same file like pad_drops_caller_lock_frame,
> no_pad_keeps_own_lock_frame, and pad_drops_caller_ref_frame call bpf_unwind
> without setting r1 first. The verifier checks no arguments for a zero-argument
> kfunc, and neither bpf_exc_keep_exits nor the runtime walk uses r1.
>
> Are the "r1 = N;" loads before these calls left over from an earlier
> cookie-style signature? Could they be dropped so the asm matches the kfunc
> prototype?

Will fix. thanks!

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36502848904

