Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D5544E64A
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 08:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790757535; cv=none; b=t7+67QM7lkrNWsmjbv5vsVjrws87VZDtXjyF5ng0kKsAd9UC50t5O6/So7GefJBvjPG0iebRLYly48j1dJW64GtBCU9okiIluhizX3gxc5z1BBb1ejH4Hvj1VBKRcE2R5ffk3Ty3Byw1EY1FQLyhNYX5O0QgODXMjHr7O8S59+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790757535; c=relaxed/simple;
	bh=wDJkUnkyI2+Nhi4UT+W1qQZ5NePezBMCF26yxcklSdw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ODJlibpdueu3b9H3a7nD5Hh03ozzRCg9CmPewItz98A/jlQa+nh6fvOqIihpd6nO11xWK5+o6jm9Yy9kgmhHpl/FBu84padcb8NIg0m30bmek6/cEG5wuBRNJe6oOp3DIOq57knadZalAkHHp8vYZq1RsLZF08qI+j1PLTdbYHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WCT215Cq; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WCT215Cq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=tbSXmmCFRjNsY7vcNoOhHuRGcpqUyKFRDNHANg0hv+M=;
	b=WCT215CquKh0b/BdVn/FY3+uj2lwvF96zXx5zKiyqDSIkuo+G4O7Mhh4k9kROd
	7Btrv1HheHL2/dUvQNRbpzjbh40Xw7fNcwpEkhq9NIkGwzBqbu3qsT04L0M0z8vX
	cY0wB8TGvvJTcAeVSvT1Q6YLZVZ1sLHqnYvYw111y5g+Q=
Message-ID: <42361d59-bd08-49cd-9896-9594e7521ee8@163.com>
Date: Wed, 30 Sep 2026 16:37:57 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 3/3] selftests/bpf: Add task work scheduling
 race test
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bot+bpf-ci@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev
Cc: yatsenko@meta.com, bpf@vger.kernel.org, martin.lau@kernel.org,
 mason@kernel.org
References: <20260929072800.113129-4-luyun_611@163.com>
 <9ea45b3f464aec62edb4a2797fe3450bae63a2d6c24666af13731730f89f39e8@mail.kernel.org>
 <e443d46b-1062-484a-a20e-20c0d85afa48@gmail.com>
Content-Language: en-US
From: luyun <luyun_611@163.com>
In-Reply-To: <e443d46b-1062-484a-a20e-20c0d85afa48@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgDnb1VlyrxqbrW7CA--.34499S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGryxKrW8Gw4xXF13GFW5GFg_yoW7Jw4fpF
	93CF1DtF4kXFW2y3W2vFsrXFyfK3s7Kay3Kr1rJr9rArn0grn7Ar4IgF1Y9r47CrWvqryF
	vw4Ut393Wrs8ZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UuwZcUUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbCwweVZGq8ymezzwAA3y


在 2026/9/29 20:00, Mykyta Yatsenko 写道:
>
> On 9/29/26 9:12 AM, bot+bpf-ci@kernel.org wrote:
>>> selftests/bpf: Add task work scheduling race test
>>>
>>> Exercise task-work scheduling and callback execution on different CPUs
>>> while userspace reuses or deletes the associated map value.  Run 1500
>>> rounds rotating through context reuse, deletion after the callback has
>>> recorded its generation, and deletion racing with scheduling.
>>>
>>> Publish the scheduling result and its generation in one packed value, so
>>> userspace does not rely on ordering between separate map slots.  Record
>>> callbacks in separate per-generation slots so an earlier callback cannot
>>> satisfy a later round's completion check.
>>>
>>> Retry transient -EBUSY results while the context is unavailable for
>>> reuse.  In the deletion-race case, allow -ENOENT if the element is
>>> removed before a retry finds it.
>>>
>>> Choose two CPUs from the process affinity mask and skip if fewer than
>>> two are available.  Bound the thread-start wait, report thread creation
>>> and affinity failures, and stop the worker threads with an atomic
>>> handshake.
>>>
>>> Signed-off-by: Yun Lu <luyun@kylinos.cn>
>> This isn't a bug, but could the changelog say which of the preceding fixes
>> this test is meant to cover, and which interleaving each variant targets,
>> instead of listing implementation details like the bounded thread-start
>> wait and the atomic stop handshake?
>>
>>> diff --git a/tools/testing/selftests/bpf/prog_tests/test_task_work.c b/tools/testing/selftests/bpf/prog_tests/test_task_work.c
>>> --- a/tools/testing/selftests/bpf/prog_tests/test_task_work.c
>>> +++ b/tools/testing/selftests/bpf/prog_tests/test_task_work.c
>>> @@ -5,10 +5,14 @@
>>>   #include <stdio.h>
>>>   #include "task_work.skel.h"
>>>   #include "task_work_fail.skel.h"
>>> +#include "task_work_race.skel.h"
>>>   #include <linux/bpf.h>
>>>   #include <linux/perf_event.h>
>>>   #include <sys/syscall.h>
>>>   #include <time.h>
>>> +#include <pthread.h>
>>> +#include <sched.h>
>>> +#include <unistd.h>
>> [ ... ]
>>
>>> +static void *task_work_race_trigger(void *arg)
>>> +{
>>> +	struct task_work_race_ctx *ctx = arg;
>>> +	int err;
>>> +
>>> +	err = task_work_race_pin_cpu(ctx->trigger_cpu);
>>> +	if (err)
>>> +		__atomic_store_n(&ctx->setup_err, err, __ATOMIC_RELEASE);
>>> +	__atomic_store_n(&ctx->trigger_tid, syscall(__NR_gettid),
>>> +			 __ATOMIC_RELEASE);
>>> +	while (!__atomic_load_n(&ctx->stop, __ATOMIC_ACQUIRE))
>>> +		getppid();
>>> +	return NULL;
>>> +}
>>> +
>>> +static void *task_work_race_target(void *arg)
>>> +{
>>> +	struct task_work_race_ctx *ctx = arg;
>>> +	int err;
>>> +
>>> +	err = task_work_race_pin_cpu(ctx->target_cpu);
>>> +	if (err)
>>> +		__atomic_store_n(&ctx->setup_err, err, __ATOMIC_RELEASE);
>>> +	__atomic_store_n(&ctx->target_tid, syscall(__NR_gettid),
>>> +			 __ATOMIC_RELEASE);
>>> +	while (!__atomic_load_n(&ctx->stop, __ATOMIC_ACQUIRE))
>>> +		getppid();
>>> +	return NULL;
>>> +}
>> This isn't a bug, but could the trigger and target threads share one
>> function with a small per-thread argument (cpu and tid pointer)? And could
>> the repeated 2000000 / 100 poll bound become a named constant, like
>> TASK_WORK_RACE_ROUNDS?
>>
> I think this is worth addressing.
Hi， Mykyta

Thanks for your reviewing.
I carefully considered the 3 suggestions from the bot+bpf-ci,
and believe they are all necessary. I will incorporate them into
the v5 revision.

I will send out the v5 revision later (selftest changes only).

---

Thanks,

Yun Lu

>> [ ... ]
>>
>>> +		err = task_work_race_check_done(skel, seq);
>>> +		/*
>>> +		 * Variant 2 deletes the element right after READY, so losing
>>> +		 * the race against the scheduling kfunc is a valid outcome:
>>> +		 * the schedule itself fails with -EBUSY (ctx already FREED),
>>> +		 * and the retry on the next tracepoint invocation fails with
>>> +		 * -ENOENT because the element is gone.  Either way the round
>>> +		 * exercised the deletion paths; a later variant 0 round
>>> +		 * recreates the element.
>>> +		 */
>>> +		if (variant == 2 && (err == -EBUSY || err == -ENOENT))
>>> +			err = 0;
>> This isn't a bug, but can err actually be -EBUSY here, given that
>> race_sched_work() returns without publishing RESULT on -EBUSY? If not,
>> could the condition just check -ENOENT?
>>
>> [ ... ]
>>
>>> diff --git a/tools/testing/selftests/bpf/progs/task_work_race.c b/tools/testing/selftests/bpf/progs/task_work_race.c
>>> --- /dev/null
>>> +++ b/tools/testing/selftests/bpf/progs/task_work_race.c
>> [ ... ]
>>
>> ---
>> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
>> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>>
>> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36538172291

