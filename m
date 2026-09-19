Received: from mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612E7346A04
	for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 21:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789852421; cv=none; b=BZ6IXVWEPgrDwwdWYXgttHqMQVXZSct8LHNk6vz5lhM2Cd/nR1w644XIzF4G7Sr6trIm6/kK6IifxGBUoR+1wlXh/GpIPifwZyGYJw6OzvU/IvB4m7f2GR/dbRoWh/lcfZKYFOsaco8KCtfED2o1OlTuNU8ndrRKArgYdC2FKKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789852421; c=relaxed/simple;
	bh=o5MxIvZgXeDjyb7WMK7RxJSKhnfefb1YFaRHDFACRNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=czPq/trBss+cwU4tT11YjbKX569pBwv3H/AiDqoOjkuJbvDwTIe+dfipqOv33FlIPwwMr2klmQzq7MqAXYj/J4nrc2y2tL/k0KCafqS0xUz14u8Vdh3oLAEKhiaoscYjct+4WvD5r8enWy76Yekn+A2anM01u1laKNPNhYyxV6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uZbSI/oY; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uZbSI/oY"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=o5MxIvZgXeDjyb7WMK7RxJSKhnfefb1YFaRHDFACRNI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789852415; v=1; x=1790457215;
 b=uZbSI/oYijN0uq/FlcxTenFMArJdrkXN+kqkn6qGZ5RP42xlY33wRC43zuZ88PiqkT2/K++t
 WKBwI7iu+yTrXwrqltILYuBkPPsQjJvc6nqxRXeiTJJusC0E2695hzfS27rHl69jPafD8qBxYPl
 2l06Qppuwt0CuX2dAEnf5AFQ=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 781ac5f64b3623bb;
	Sat, 19 Sep 2026 21:13:35 +0000
X-Mizu-Trace-ID: 781ac5f64b3623bb
X-Migadu-Flow: FLOW_OUT
Message-ID: <068024f3-cf0d-4df4-b3ef-6cec9fdafe96@linux.dev>
Date: Sat, 19 Sep 2026 14:13:28 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 19/20] selftests/bpf: Cover the exception
 cleanup shapes the chain does not reach
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20260918044337.3293731-1-yonghong.song@linux.dev>
 <27a9f5239c8c6a1c6039433b29d55451480f745f023c5f1ba943542502dfd780@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <27a9f5239c8c6a1c6039433b29d55451480f745f023c5f1ba943542502dfd780@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/17/26 10:44 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/testing/selftests/bpf/exceptions_cleanup.h b/tools/testing/selftests/bpf/exceptions_cleanup.h
>> index 630d2e207119a..5896cf83d15ee 100644
>> --- a/tools/testing/selftests/bpf/exceptions_cleanup.h
>> +++ b/tools/testing/selftests/bpf/exceptions_cleanup.h
>> @@ -4,6 +4,7 @@
>>   #define __EXCEPTIONS_CLEANUP_H__
>>
>>   #define THROW_COOKIE		0x100
>> +#define INNER_COOKIE		0x200
>>
>>   /* progs/exceptions_cleanup.c: one bit per frame that reports it ran. */
>>   #define RAN_FOO3_PREEMPT	0x1
> [ ... ]
>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c b/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
>> index d1e45b765af26..ffc0b95191681 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
> [ ... ]
>
>> +static void test_shapes(void)
>> +{
>> +	struct exceptions_cleanup_shapes *skel;
>> +
>> +	skel = exceptions_cleanup_shapes__open_and_load();
>> +	if (!ASSERT_OK_PTR(skel, "shapes open_and_load"))
>> +		return;
> [ ... ]
>
>> +	/* A throwing subprog named by a BPF_PSEUDO_FUNC no helper is handed: the
>> +	 * callback check has to look at the bpf_loop(), not at the ld_imm64.
>> +	 */
>> +	if (test__start_subtest("addr_taken_no_throw"))
>> +		run_shape(skel, skel->progs.entry_addr_taken, 1, 2, 0);
>> +	if (test__start_subtest("addr_taken_throw"))
>> +		run_shape(skel, skel->progs.entry_addr_taken, 101, THROW_COOKIE,
>> +			  RAN_ADDR_TAKEN);
> Does this comment accurately describe what the addr_taken shape tests?
>
> Looking at addr_taken_callee() in progs/exceptions_cleanup_shapes.c, the
> function does hand cb_thrower to bpf_loop(). The ld_imm64 and the
> bpf_loop() call are on the same path, after bpf_throw(). Since bpf_throw()
> is not declared noreturn, LLVM keeps that tail, and what actually makes
> the program load is that the verifier never reaches the bpf_loop() at all
> (it is dead after the throw).
>
> So push_callback_call() -> bpf_cleanup_check_callback() never fires.
>
> The shape exercised is 'a BPF_PSEUDO_FUNC whose helper call the verifier
> never reaches', not 'a BPF_PSEUDO_FUNC no helper is handed'. Could the
> comment be rephrased to reflect what the verifier actually sees?

Okay, will change comments.

>
> [ ... ]
>
>> diff --git a/tools/testing/selftests/bpf/progs/exceptions_cleanup_shapes.c b/tools/testing/selftests/bpf/progs/exceptions_cleanup_shapes.c
>> new file mode 100644
>> index 0000000000000..f5eb2ff15c896
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/exceptions_cleanup_shapes.c
> [ ... ]
>
>> +/*
>> + * 2. A callee called from both a covered and an uncovered site: the pad is
>> + * recorded on the call site, not on the callee. The lock sits between the two
>> + * calls because the frame really would leak it if the uncovered call unwound.
>> + */
>> +static __used __noinline __u64 shared_callee(__u64 x)
>> +{
>> +	if (x > 100)
>> +		bpf_throw(THROW_COOKIE);
>> +	return x + 1;
>> +}
>> +
>> +static __used __naked __noinline __u64 shared_frame(void)
>> +{
>> +	asm volatile (
>> +	"r1 = %[input] ll;"
>> +	"r6 = *(u64 *)(r1 + 0);"
>> +	"r1 = 0;"
>> +	"call shared_callee;"
>> +	"call bpf_rcu_read_lock;"
>> +	"r1 = r6;"
>> +"1:"	"call shared_callee;"		/* cleanup region */
>> +"2:"
>> +	"r6 = r0;"
>> +	"call bpf_rcu_read_unlock;"
>> +	"r0 = r6;"
>> +	"exit;"
>> +"3:"					/* landing pad */
>> +	"r7 = r0;"
>> +	"call bpf_rcu_read_unlock;"
>> +	PAD_RAN("%[ran]")
>> +	"r1 = r7;"
>> +	"call bpf_unwind_resume;"
>> +	"exit;"
>> +	CLEANUP_REC("1b", "2b", "3b")
>> +	:
>> +	: [ran]"i"(RAN_SHARED), __imm_addr(input), __imm_addr(pads_ran)
>> +	: __clobber_all);
>> +}
> Does the uncovered call site verify that the pad wouldn't be wrongly
> dispatched if an exception occurred there?
>
> The uncovered site is reached with the constant 0 in r1, and shared_callee
> only throws when x > 100, so the verifier proves that call cannot throw
> and no unwind ever leaves the uncovered site - at verification time or at
> run time.
>
> The structural half of the property (only the second call's return address
> falls inside the record's native range) is exercised, but the behavioral
> half is not: a kernel that wrongly matched the uncovered site's return
> address against the record and ran the pad would go unnoticed, because
> that site never unwinds.

The above analysis exactly described the code so the above 'wrongly dispatched
if an exception occurred there' does not happen. I guess this tries to
capture incorrect kernel implementation.

>
> [ ... ]
>
>> +/*
>> + * 6. A tail call that is really taken: the target is a program in its own
>> + * right, so the walk ends there and this frame's pad does not run. The callee
>> + * can also throw on a path never taken, which keeps the pad out of the sweep.
>> + */
>> +struct {
>> +	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
>> +	__uint(max_entries, 1);
>> +	__uint(key_size, sizeof(__u32));
>> +	__uint(value_size, sizeof(__u32));
>> +} taken_table SEC(".maps");
>> +
>> +SEC("syscall")
>> +int tc_target(void *ctx)
>> +{
>> +	bpf_throw(THROW_COOKIE);
>> +	return 0;
>> +}
>> +
>> +static __used __noinline __u64 tc_taken_callee(void *ctx, __u64 x)
>> +{
>> +	/* Never true at run time; the verifier cannot know that, and its
>> +	 * unwind out of here is what keeps the caller's pad alive.
>> +	 */
>> +	if (x == 7)
>> +		bpf_throw(THROW_COOKIE);
>> +	bpf_tail_call_static(ctx, &taken_table, 0);
>> +	return 0;
>> +}
>> +
>> +SEC("syscall")
>> +__naked int entry_tail_taken(void)
>> +{
>> +	asm volatile (
>> +	"*(u64 *)(r10 - 8) = r1;"	/* the context, straight from entry */
>> +	"r1 = %[input] ll;"
>> +	"r2 = *(u64 *)(r1 + 0);"
>> +	"if r2 < 101 goto 8f;"
>> +	"r1 = *(u64 *)(r10 - 8);"
>> +"1:"	"call tc_taken_callee;"		/* cleanup region */
>> +"2:"
>> +	"exit;"				/* the cookie, delivered at tc_target */
>> +"8:"
>> +	"r0 = 0;"
>> +	"exit;"
>> +"3:"					/* landing pad: must not run */
>> +	PAD_RAN("%[ran]")
>> +	"call bpf_unwind_resume;"
>> +	"exit;"
>> +	CLEANUP_REC("1b", "2b", "3b")
>> +	:
>> +	: [ran]"i"(RAN_TC_TAKEN), __imm_addr(input), __imm_addr(pads_ran)
>> +	: __clobber_all);
>> +}
> Can the tail_call_taken subtest fail if the kernel wrongly continues the
> walk past the tail-call boundary?

This is a test which fixed some early regression tests. Yes, if kernel
implementation is wrong, tail_call_taken test may fail.

>
> entry_tail_taken narrows the argument before the covered call:
>
>    "r2 = *(u64 *)(r1 + 0);"       /* r2 = input */
>    "if r2 < 101 goto 8f;"         /* fallthrough => r2 in [101, U64_MAX] */
>
> tc_taken_callee is a static subprog, so check_func_call() copies the
> caller's r1-r5 verbatim into the callee frame. x therefore arrives with
> umin_value == 101, and is_branch_taken() resolves 'if (x == 7)' to
> never-taken, so the verifier never explores the bpf_throw(). Nothing then
> unwinds into entry_tail_taken during verification, the landing pad at
> label 3 is never marked seen, and opt_remove_dead_code() removes it.
>
> fixups.c then clears the annotation for any call site whose cleanup_pad
> falls inside the removed window:
>
>      if (env->cleanup_info_cnt) {
>              for (i = 0; i < env->insn_aux_data_len; i++) {
>                      u32 pad = aux_data[i].cleanup_pad;
>                      if (pad > off + cnt) aux_data[i].cleanup_pad = pad - cnt;
>                      else if (pad > off)  aux_data[i].cleanup_pad = 0;
>              }
>      }
>
> so no native range is emitted for the region at all. The program still
> loads (mark_subprog_might_throw() is a static analysis, so bpf_check_cfg()
> still sees the pad edge and check_cleanup_info() runs before the sweep),
> and pads_ran stays 0 unconditionally. A kernel that wrongly continued
> bpf_stack_walker() past the tail-call boundary into entry_tail_taken's
> frame would find no record to match and would still leave pads_ran == 0,
> so the subtest passes on a correct and on a broken kernel alike.
>
> The in-code comment is also wrong on both clauses: the verifier CAN know
> x != 7 here, and consequently the unwind out of tc_taken_callee is NOT
> what keeps the caller's pad alive - nothing does.

The comment is:

         /* Never true at run time; the verifier cannot know that, and its
          * unwind out of here is what keeps the caller's pad alive.
          */
         if (x == 7)
                 bpf_throw(THROW_COOKIE);

Yes, the 'x' will be a known value at run time. Comments need update.

>
> Contrast with shape 7 (entry_freplace, lines 862-878), the analogous 'walk
> ends in the callee's frame' shape, which deliberately passes the
> unnarrowed input value to fr_callee() with no 'if r1 < 101' guard, keeping
> fr_callee's identical 'if (x == 7) bpf_throw()' live. Dropping the
> 'if r2 < 101 goto 8f' guard from entry_tail_taken (or otherwise passing a
> value the verifier cannot exclude 7 from) would make the pad survive and
> give the subtest something to fail on.
>
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35308528711

