Received: from mta0.migadu.com (out-142.mta0.migadu.com [91.218.175.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1E6189F43
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 01:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790644934; cv=none; b=s5YlEcmQsgkvJitL88UnVBcP6ooHXjyA6+/0/Cg9AJ3xo4wnFP1Sx1m5vl35f+ImyxHNfM6mAGoaiZ3goPlpNub7pjuzLbUiKuzEtahmelqoqs9e5tNOxlyPK4u5KZeO2jo7QH1D+h7+68/eUUSAhHAZWi199owoifGy4itM52w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790644934; c=relaxed/simple;
	bh=y6zwP3b2fxxBONzUl72JLW4nTSFbQsYTTWD04VWcprk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tTTpxrodoSpsa7ZKew5A3TYGr1qjshdADEE01pmS4Bh66JxIf7uf/hocXGBDZJ0tfioQAuYZg1WJBfkbOJ48OvDptrhedFOtYDt/cwOBddXFxbykbllYAk7E+DY18xdvL0F/OrnutE5EQnVT/QG9/YH3nQg0y9zF8LYP/ccCyUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=csQ2F424; arc=none smtp.client-ip=91.218.175.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="csQ2F424"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=y6zwP3b2fxxBONzUl72JLW4nTSFbQsYTTWD04VWcprk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790644929; v=1; x=1791249729;
 b=csQ2F424N0nEzbZgEWW2TqgN3RVvIITuTUrMqNtOvn9uLfe3ccp96NpXcsXQszLquOPo/Hb8
 a6UVHOL4++prHudRC/S2PjeUSPUTO5lg/9z4IhM8yR9yB2V5VT0ib2MwZOCI026eqDYbe+KuFwa
 EP1Gr5T5YAkJEzBpOEzVZPpQ=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 64465a751bbcb560;
	Tue, 29 Sep 2026 01:22:09 +0000
X-Mizu-Trace-ID: 64465a751bbcb560
X-Migadu-Flow: FLOW_OUT
Message-ID: <0499fb85-d323-4141-b76e-bc9812b1d142@linux.dev>
Date: Mon, 28 Sep 2026 18:22:02 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] tracing: fgraph: allocate shadow stacks inline
 with GFP_NOWAIT
To: sashiko-reviews@lists.linux.dev, Peter Zijlstra <peterz@infradead.org>,
 rostedt@goodmis.org, Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, kernel-team@meta.com
References: <20260929005411.4105448-1-vineet.gupta@linux.dev>
 <20260929005411.4105448-2-vineet.gupta@linux.dev>
 <20260929010327.024281F000FF@smtp.kernel.org>
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <20260929010327.024281F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/28/26 6:03 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] cleanup: mixing goto-based error handling and scope-based cleanup
> --
>
> commit a6de528fef00ef67da15965a7a8b3944fa92b053
> Author: Vineet Gupta <vineet.gupta@linux.dev>
> Subject: tracing: fgraph: allocate shadow stacks inline with GFP_NOWAIT
>
> This commit aims to resolve performance regressions with ftrace graph tracing
> when there are a large number of tasks. It replaces the pre-allocated batch
> approach with inline allocation using GFP_NOWAIT, avoiding repeated sweeps of
> the task list. Additionally, it transitions the RCU read-side section to use
> scoped_guard(rcu) instead of manual rcu_read_lock and rcu_read_unlock calls.
>
>> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
>> index 40d373d65f9b9..1c5ccc3f80d53 100644
>> --- a/kernel/trace/fgraph.c
>> +++ b/kernel/trace/fgraph.c
> [ ... ]
>> @@ -1057,26 +1056,37 @@ static int alloc_retstack_tasklist(unsigned long **ret_stack_list)
>>   		}
>>   	}
>>   
>> -	rcu_read_lock();
>> -	for_each_process_thread(g, t) {
>> -		if (start == end) {
>> -			ret = -EAGAIN;
>> -			goto unlock;
>> -		}
>> +	scoped_guard (rcu) {
> [Severity: Low]
> Does this mix goto-based error handling and scope-based cleanup within the same
> function?
>
> Looking at alloc_retstack_tasklist(), the function retains the legacy goto free
> path in the initial pre-allocation loop (just before this block), while
> introducing scoped_guard(rcu) here.
>
> The cleanup subsystem guidelines recommend that for a given routine, we should
> convert all resources that need a goto cleanup to scope-based cleanup, or
> convert none of them. Mixing these paradigms creates confusing ownership
> semantics and is highly prone to double-free or resource leak regressions upon
> future modifications.
>
> Could we either convert the ret_stack_list array cleanup to use scope-based
> helpers, or stick to the manual rcu_read_lock() and rcu_read_unlock() here to
> keep the error handling style consistent?

And a third option is to drop the fallback allocation completely and 
return -EAGAIN and come back. Granted I don't have much experience of 
typical handling of GFP_NOWAIT fails and retrying immediately: would 
that recover at all or does that take us back to where we started ? Peter

Thx,
-Vineet
