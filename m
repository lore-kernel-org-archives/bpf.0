Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9874AC143
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 06:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791872278; cv=none; b=Lcky8tbl8fObba4x1UuS3fOxc6xPPg+1b+qKbUNPBSoYBDkmaT2ao8wvX5mUb37UI92gwPLeK73dcElfINxpnKCccwFF9VKSzxvNgDWAA26muQr9QWacpWvxkRnWT3wiY88jJ5bgjIYs9tyIW4qQ5eQTkholDIG0mYB+QVV1RK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791872278; c=relaxed/simple;
	bh=FVwBJ0XxtavJnHWXRkxE/FkYbjHVK32IY3330Ht+Vxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DQcsQ79OQm1TuWGaqIQZGRvQuaVsrpSqoiuEgTJ+WW6QEr1E8Kf2/C2/ZCC3TBjZRKr5BwM/ql++/AZDPYR9AiebcKR3gf3go/IksrVbW5bdhcPgJQX+3ZiJ91nZQSxh0BTxlLoqdyLVmYAV2UcvL1FZiFoKQUUdwCCfKQse/t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=na1/QD+3; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="na1/QD+3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=oicUmdbvkZlAAkWakT1cZEuj/Xikbl8f+gS9yOj4TKQ=;
	b=na1/QD+3OEal1K3e/46GtgK7J3eLycJdZW5cSZdlVGp874nXCIcheK94rB+3zp
	VDVMkZX1K68xr0pT18mrXnd9rYIIv6gAWg42uayIxvQ8Gk7ehuRxJOAYrnRXd7vV
	GE8W8AuAo2ahBFpFJoTz5ZJgF33TWzKniEFlI6o+hVm/4=
Message-ID: <79b7f28d-2013-4dcb-8f1a-aef7366c9aa5@163.com>
Date: Tue, 13 Oct 2026 14:17:43 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v7 3/4] bpf: Prevent task work context reuse
 while irq_work is busy
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20261012061915.231254-1-luyun_611@163.com>
 <20261012061915.231254-4-luyun_611@163.com>
 <sashiko-outbox-167741@kernel.org>
Content-Language: en-US
From: luyun <luyun_611@163.com>
In-Reply-To: <sashiko-outbox-167741@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgAXH68Hzc1qPonODw--.2174S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAF17try7WFWkGw4fJrWxCrg_yoWrCr1rpF
	Wrtr1Yyw4kJa4IvF12vw4xWFySgwsYya45Grn5Kryayr15Wrn2yryIkF1jqF45urs5JF12
	vr4qva93Cw1UuFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRYNtsUUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbC6wiDUmrNzQhY1wAA3f


在 2026/10/12 14:34, sashiko-bot@kernel.org 写道:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] bpf: UAF in task_work/timer callbacks due to async context re-init on deleted map elements
> --
Hi,
I reproduced this issue with KASAN on qemu/kvm.

After the map value is deleted, a stale value pointer can still re-publish
a context and schedule a task work through it (the schedule succeeds, no
error). Callbacks that have not entered RUNNING yet are cancelled by the
final allocator destructor and are safe. The gap is a callback that is
already RUNNING when the freeing grace period completes: the destructor
only publishes FREED without waiting, and the callback keeps using
ctx->map_val after the element has been kfree:

   BUG: KASAN: slab-use-after-free in bpf_repro_probe_tw
   Read of size 1 at addr ffff88800d999558 by task uaf_repro/89

   Call Trace:
     bpf_repro_probe_tw          <- debug-only probe, scratch build
     process_work_cb             <- BPF task work callback
     bpf_task_work_callback
     task_work_run

   Freed by task 11:
     kfree
     free_all
     __free_rcu
     srcu_invoke_callbacks       <- bpf_mem_cache freeing grace period

This is not introduced by this series: fetch_ctx(), schedule(),
cancel_and_free() and the callback are identical to the pre-series base,
and patch 3 only moves init_irq_work() around. I hit the same reinstall
path on the submitted tree with no modifications.

The fix has to stop retired elements from re-publishing async work and
keep elements alive while a callback still runs on them, so I'd rather fix

it in a separate series than grow this patch set.

---

Thanks.
Yun Lu

> commit 580f53f590a0a7077f231292b13de90213f646c5
> Author: Yun Lu <luyun@kylinos.cn>
>
> bpf: Prevent task work context reuse while irq_work is busy
>
> This commit fixes a race condition where a task work context could return to
> standby before its scheduling irq_work handler completes. It initializes the
> irq_work during context creation and checks for the BUSY state before reusing
> it to prevent overlapping invocations.
>
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index 028fc6796b597..350269b8646e4 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -4553,6 +4553,7 @@ static struct bpf_task_work_ctx *bpf_task_work_fetch_ctx(struct bpf_task_work *t
>>   	memset(ctx, 0, sizeof(*ctx));
>>   	refcount_set(&ctx->refcnt, 1); /* map's own ref */
>>   	ctx->state = BPF_TW_STANDBY;
>> +	init_irq_work(&ctx->irq_work, bpf_task_work_irq);
>>   
>>   	old_ctx = cmpxchg(&twk->ctx, NULL, ctx);
> [Severity: High]
> Can a newly allocated context be installed on a deleted map element here?
>
> If a concurrent map deletion calls bpf_task_work_cancel_and_free(), it
> synchronously clears the context:
>
> bpf_task_work_cancel_and_free(struct bpf_task_work *tw) {
>      ...
>      ctx = xchg(&twk->ctx, NULL);
>      ...
> }
>
> Since it doesn't leave a poison value, a concurrent BPF program running under
> RCU read lock that calls bpf_task_work_schedule() would see twk->ctx as NULL
> and successfully cmpxchg the newly allocated context into the deleted element.
>
> [ ... ]
>
>> @@ -4644,7 +4657,6 @@ static int bpf_task_work_schedule(struct task_struct *task, struct bpf_task_work
>>   	ctx->map = map;
>>   	ctx->map_val = (void *)tw - map->record->task_work_off;
>>   	init_task_work(&ctx->work, bpf_task_work_callback);
>> -	init_irq_work(&ctx->irq_work, bpf_task_work_irq);
>>   
>>   	irq_work_queue(&ctx->irq_work);
>>   	return 0;
> [Severity: High]
> Could this lead to a use-after-free if the element was concurrently deleted?
>
> If bpf_task_work_fetch_ctx() re-initializes a context on a deleted element as
> described above, ctx->map_val captures a pointer to the element's memory:
>
> bpf_task_work_schedule(...) {
>      ...
>      ctx->map_val = (void *)tw - map->record->task_work_off;
>      ...
>      irq_work_queue(&ctx->irq_work);
> }
>
> Since the deleted map element will be freed after the RCU grace period, but
> the newly initialized asynchronous irq_work remains armed, could the later
> execution of this callback access the freed element memory through
> ctx->map_val?
>

