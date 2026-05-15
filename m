Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63B63321A2
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 16:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778864272; cv=none; b=DsGKFMM64/1N+qhhm4oxbNSTApvnmRbK7FEimJprXPTNc7jeLSbiuCp9jAAaRIUZ6QR9aKIxnjAgja8vmjLceBQLMyiBni9/FYpBZhjVsCWTF7zRNMm1OI8Vu1tG5gNwLc1PX3IQxNr5kY/trFxi/melaZZB/QD3gkg1PboLq8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778864272; c=relaxed/simple;
	bh=HfDLRigbh/n6E84Sx5NzrBMlJciHBWOgs6Fm8/bRYfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JsMG7CobNCuA+mV3MjFYuxpTQftd4ok88uJW62ZIgLe+BEY3txi5uAVRzvkIDqU98QZjHJney8vq/NaTcLbNnrlkLvUcP9XYflZVvv+glHEGChRNaOmRVB59ZIcGjBNNn7WXnkaJhQwMWgR/1QUCdYAel9pA3tRz2aDHQzY75AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dV5Jnq+b; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dV5Jnq+b"
Message-ID: <46b576ec-a2e2-4501-9be5-094ce840e9f0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778864258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Js5Qjb6/DNEMn0Vvez1+YQ4G9KxW/8EhfaWypbw/RX8=;
	b=dV5Jnq+bbABu9UYDYMUj8tBiQBUW0UtMsi2+Pg7qs0H9TrPcYgKhngBpDUNq+LSnguf0nn
	ufjpmIhVJiXQehjHQrNPnCpy3+aO1wTg/p29LpsaTQfl79O5LsoCTO6PMe8fFkRhVI+sR1
	NIEe5a+fyzDxWivNa9a4vbfp4ZvXyR0=
Date: Fri, 15 May 2026 09:57:33 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 18/25] selftests/bpf: Add tests for BPF
 function stack arguments
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260513045127.2397187-1-yonghong.song@linux.dev>
 <20260515061609.B8AB1C2BCB0@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260515061609.B8AB1C2BCB0@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 5/15/26 8:16 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The test `test_async_cb_many` uses a hardcoded `usleep(50)` to wait for an asynchronous BPF timer to execute, which is prone to race conditions and flakiness on loaded CI systems.
> --
>
> commit 12812727f17076398fed8cfc802771db232582f8
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> selftests/bpf: Add tests for BPF function stack arguments
>
> This commit adds selftests for stack argument passing in BPF-to-BPF subprog
> and kfunc calls with more than 5 arguments. It covers scalar, pointer, mixed,
> dynptr, memory buffer, iterator, const string, and timer pointers.
>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/stack_arg.c b/tools/testing/selftests/bpf/prog_tests/stack_arg.c
>> new file mode 100644
>> index 0000000000000..d61bac33f8092
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/stack_arg.c
> [ ... ]
>> +static void test_async_cb_many(void)
>> +{
> [ ... ]
>> +	run_subtest(skel->progs.test_async_cb_many_args, 0);
>> +
>> +	/* Wait for the timer callback to fire and verify the result.
>> +	 * 10+20+30+40+50+60+70+80 = 360
>> +	 */
>> +	usleep(50);
> Could this short sleep lead to flaky test failures on loaded CI systems?
>
> Timer callbacks are executed in softirq context, and under load, scheduling
> delays could easily exceed 50 microseconds. This might cause the test process
> to wake up and read timer_result before the callback has actually executed.
>
> Would a polling loop with a reasonable timeout be more reliable here?

The prog_tests/tiemr.c uses 'usleep(50);' which seems working fine.
So I used it too.

>
>> +	ASSERT_EQ(skel->bss->timer_result, 360, "timer_result");
>> +
>> +out:
>> +	stack_arg__destroy(skel);
>> +}

