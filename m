Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7702D7DF1
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 01:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785720977; cv=none; b=prIREJm3aKkF9ZdtAMwzcGC2a7VPIS2iD6x3SJQ319gxhSTokDFk3qHqPQKX6vUKpN4xDNhaGX+Sjan3dj5dVbHRcHxeCgsaAzMYOi+Q3KvB2zWhtVzCMmvfAeTZeExOgLLNsXmdTODhhDiwIm6kIzOydnhp3gPJsJ/fMbQX3Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785720977; c=relaxed/simple;
	bh=5lbvfI4COxuRip3idsClqUYLSJ0ZHwzNqbcitdjt+6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aS0h4CHP/c377DLFEOhB5hNy3JeRf/9GAllwk//yaH3V6RyPep4WwRbdryRAfn8dUDahdtslTMyW81O/Z93yYKXGv7QZdww7oUU6hP0KQ2x7g38v4t9i8maaeEyculdQX+sO49ZPmMX9zO371MYflwXp3gJl9rhSR4GmpCZX630=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=q/Wr3KR0; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="q/Wr3KR0"
Message-ID: <adeafc32-65cd-43f7-9e7d-cfcd6ef86327@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785720973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+bVnoneUmkJ6FN4nzGSU21hUSXf/0JvHO9dGUjjDVEE=;
	b=q/Wr3KR0WpWQWkvvY5wJ08iiahRKzXEQLrC9fUheODMoImDfXSE0kio5d4sdSHgn84p/fc
	XuhnPmUdYhqsRnLvZjcWBBznrSClbXVzRZDmGwbrjWqwQ87Tcaz2auUMm1wfAH2miKhzTK
	CuC3uqDRYiCoemk8qrNULTpze2EbfwA=
Date: Mon, 3 Aug 2026 09:35:49 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: arena: fix mmap_lock deadlock on arena lock
 failure
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, Puranjay Mohan
 <puranjay@kernel.org>, linux-kernel@vger.kernel.org
References: <20260728060517.95183-1-jiayuan.chen@linux.dev>
 <DKEWY0MJHZ64.ALDUTQQ1RPLG@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <DKEWY0MJHZ64.ALDUTQQ1RPLG@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 8/3/26 9:21 AM, Kumar Kartikeya Dwivedi wrote:
> On Tue Jul 28, 2026 at 8:05 AM CEST, Jiayuan Chen wrote:
>> Reported by the Sashiko AI review.
>>
>> arena_vm_fault() returns VM_FAULT_RETRY when it can't take
>> arena->spinlock, but it never took mmap_lock. The fault path assumes a
>> VM_FAULT_RETRY handler already dropped mmap_lock and re-takes it on the
>> retry, so mmap_lock gets taken twice and can deadlock:
>>
>> 	do_user_addr_fault()
>> 	{
>> 		fault = handle_mm_fault(...);   // calls arena_vm_fault()
>> 		if (fault & VM_FAULT_RETRY)
>> 			goto retry;   // re-locks mmap_lock
>> 		mmap_read_unlock(mm);
>> 	}
>>
>> Return VM_FAULT_SIGBUS instead, for two reasons:
>>
>> 1. We could keep VM_FAULT_RETRY, but then we'd have to drop the fault
>>     lock first and cap the retry ourselves, the way __folio_lock_or_retry()
>>     does.
>>
>> 2. A failed raw_res_spin_lock_irqsave() already means a possible deadlock
>>     was detected, so retrying just hits the same lock again.
>>
>> So returning VM_FAULT_RETRY here is overkill.
>>
>> Fixes: b8467290edab ("bpf: arena: make arena kfuncs any context safe")
>> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
>>
>> ---
>> target to bpf-next since I think it is moderate.
>> ---
> This looks ok to me, but after staring at this function for longer, I think all
> kinds of non-recoverable errors should be using VM_FAULT_SIGBUS vs SIGSEGV.
>
> The only case with SIGSEGV should be the flag based request to disable
> allocation on lazy faults. That should include the scratch page case, since it
> represents a hole.
>
> SIGSEGV: BPF_F_SEGV_ON_FAULT, scratch page.
> SIGBUS: lock acquisition failure, range-tree failures, page allocation failure,
> kernel PTE install failure.
>
> All of these SIGBUS are almost improbable, but I think it would be cleaner to
> keep semantics clear.
>
> Could you follow up with this change? I applied this one for now.


Sure. I'm happy to do it.

>>   kernel/bpf/arena.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
>> index 34f023a537fe..555ee2531ef9 100644
>> --- a/kernel/bpf/arena.c
>> +++ b/kernel/bpf/arena.c
>> @@ -490,8 +490,12 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
>>   	kaddr = kbase + (u32)(vmf->address);
>>
>>   	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags))
>> -		/* Make a reasonable effort to address impossible case */
>> -		return VM_FAULT_RETRY;
>> +		/*
>> +		 * A failed lock means a possible deadlock was detected. Don't
>> +		 * return VM_FAULT_RETRY: this handler never took mmap_lock, but
>> +		 * the fault path would re-take it on retry and deadlock. Fail.
>> +		 */
>> +		return VM_FAULT_SIGBUS;
>>
>>   	page = vmalloc_to_page((void *)kaddr);
>>   	if (page) {
