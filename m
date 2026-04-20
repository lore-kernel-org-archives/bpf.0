Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456822D7812
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 05:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776664370; cv=none; b=bPjjum9n8EJh+3q8jGkB7/bVYxZXER4n0kxwiUeeCFBthDoOeGdcoRa8P9VzzpQhJca6ORlyPDYGzRb3O1SuFFu4TvBKpKasrOK1Cbyq0b9tT5CakKW5H+XF5slxFq7wSd96/uE5srlUyXHOkI8G8XKRoxaMKzhHYt6OumLk9ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776664370; c=relaxed/simple;
	bh=P9Ea85k2ipmaCPdLoOcKf9QW0R2Vs93tj4N1mcnC5xY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pmr2Vp+07y2z0uYADv6sYfC5MZpz2skFT7XKyQoa84mTlwq4Ko54YDIejXi/V8XsXtKhCwBU3yH4cBpxEXpnnhxg6yfiepWVhbaXepH1Va9tCWjtPoQYs5sEKnHW7VsWSZxqKIdmBui4Ytae2mVKLH4oLjNp2oKXqz9g0pMUGjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rLJJbVJc; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rLJJbVJc"
Message-ID: <c1ea0f04-f902-4f6c-9249-3348f729f0cc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776664366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+yuCXDIUaeRW08M8i0mkAdfDh//QKZbNWx3y/KuUFsQ=;
	b=rLJJbVJcNdU5m/B0Xl5bpIH9526JGewXfXedwrky13TBEScWUhqfyvqePZtICRO/CNcvbF
	CNHvJ9GC1ii99HV9uoTYuspEum1rKEHYSCvz8mPqQ6JrAw5Rtz994ixThZNwiAvm2PG2Ko
	PXw8dG4sYszOjhEt2kkSMOX1CJ5HMRU=
Date: Sun, 19 Apr 2026 22:52:22 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 15/17] selftests/bpf: Add tests for BPF
 function stack arguments
Content-Language: en-GB
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260419163435.740110-1-yonghong.song@linux.dev>
 <20260419171509.541CBC2BCAF@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260419171509.541CBC2BCAF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 4/19/26 10:15 AM, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 3 potential issue(s):
> - [Medium] The `test_async_cb_many` test uses an extremely short `usleep(50)` to wait for a BPF timer callback to execute, leading to potential flakiness.
> - [Low] The block comment for `global_two_callees` incorrectly refers to the function as `bar`.
> - [Low] The `bpf_iter_testmod_seq_next` kfunc is incorrectly declared with an `int *` return type in `stack_arg_kfunc.c`.
> --
>
> commit 63c1c9ef99d02448833e84a39ecb212ccaaf5b80
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> selftests/bpf: Add tests for BPF function stack arguments
>      
> This commit adds selftests covering stack argument passing for both BPF-to-BPF
> subprog calls and kfunc calls with more than 5 arguments.
>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/stack_arg.c b/tools/testing/selftests/bpf/prog_tests/stack_arg.c
>> new file mode 100644
>> index 0000000000000..d61bac33f8092
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/stack_arg.c
> [ ... ]
>
>> +static void test_async_cb_many(void)
>> +{
>> +	struct stack_arg *skel;
>> +
>> +	skel = stack_arg__open();
>> +	if (!ASSERT_OK_PTR(skel, "open"))
>> +		return;
>> +
>> +	if (!skel->rodata->has_stack_arg) {
>> +		test__skip();
>> +		goto out;
>> +	}
>> +
>> +	if (!ASSERT_OK(stack_arg__load(skel), "load"))
>> +		goto out;
>> +
>> +	run_subtest(skel->progs.test_async_cb_many_args, 0);
>> +
>> +	/* Wait for the timer callback to fire and verify the result.
>> +	 * 10+20+30+40+50+60+70+80 = 360
>> +	 */
>> +	usleep(50);
>> +	ASSERT_EQ(skel->bss->timer_result, 360, "timer_result");
> Is 50 microseconds enough time to reliably wait for the timer callback to
> execute?
>
> In CI environments or heavily loaded virtualization systems, might the
> scheduling and softirq execution be delayed by more than a fraction of a
> millisecond? If the timer does not fire in exactly that short window, the
> test would incorrectly read a timer_result of 0 and fail.
>
> Would it be more robust to use a polling loop or a significantly larger
> timeout to avoid flaky tests?

I am using the same 'usleep(50)' in prog_tests/timer.c:

         timer__detach(timer_skel);

         usleep(50); /* 10 usecs should be enough, but give it extra */
         /* check that timer_cb1() was executed 10+10 times */
	...

So I think 50 us should be okay.

>
> [ ... ]
>
>> diff --git a/tools/testing/selftests/bpf/progs/stack_arg.c b/tools/testing/selftests/bpf/progs/stack_arg.c
>> new file mode 100644
>> index 0000000000000..8c198ee952ff4
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/stack_arg.c
> [ ... ]
>
>> +/* bar calls foo1 (3 stack args) and foo2 (5 stack args).
>> + * The outgoing stack arg area is sized for foo2 (the larger callee).
>> + * Stores for foo1 are a subset of the area used by foo2.
>> + * Result: foo1(1,2,3,4,5,6,7,8) + foo2(1,2,3,4,5,6,7,8,9,10) = 36 + 55 = 91
>> + *
>> + * Pass a-e through so the compiler can't constant-fold the stack args away.
>> + */
>> +__noinline int global_two_callees(int a, int b, int c, int d, int e)
> This isn't a bug, but the comment refers to a function named bar, while the
> function being described is actually named global_two_callees.

Thanks. Will fix.

>
> [ ... ]
>
>> diff --git a/tools/testing/selftests/bpf/progs/stack_arg_kfunc.c b/tools/testing/selftests/bpf/progs/stack_arg_kfunc.c
>> new file mode 100644
>> index 0000000000000..6cc404d578639
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/stack_arg_kfunc.c
> [ ... ]
>
>> +#if defined(__TARGET_ARCH_x86) && defined(__BPF_FEATURE_STACK_ARGUMENT)
>> +
>> +const volatile bool has_stack_arg = true;
>> +
>> +struct bpf_iter_testmod_seq {
>> +	u64 :64;
>> +	u64 :64;
>> +};
>> +
>> +extern int bpf_iter_testmod_seq_new(struct bpf_iter_testmod_seq *it, s64 value, int cnt) __ksym;
>> +extern int *bpf_iter_testmod_seq_next(struct bpf_iter_testmod_seq *it) __ksym;
> Does bpf_iter_testmod_seq_next() actually return an int pointer?

This one
	+extern int *bpf_iter_testmod_seq_next(struct bpf_iter_testmod_seq *it) __ksym;
is dead code. Will remove.

>
> Looking at the corresponding kfunc definition in bpf_testmod.c, the function
> appears to return an s64 pointer. Although this function isn't actively called
> in this test file (which prevents a BTF verifier failure here), could the
> mismatched return type declaration cause confusion or subtle issues in the
> future?
>

