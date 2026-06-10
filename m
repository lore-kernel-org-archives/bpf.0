Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4932C11CA
	for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 03:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781062914; cv=none; b=XXn1qmA54jUSl5z+5hc6HALzV/dnVIktMzBypvMTVh5kZaQBC/fStV5AnS6fHiWoJ8tWoAn6wu+u/WUmPvGk9kVO9SHgwcEsePNwQ2EDa5IgQKQWYuu83LWz2oqBV52nmXd5Q7iGOG0JO2FhMIFNIfDBGXLO3lQYhArcJiX1vnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781062914; c=relaxed/simple;
	bh=tXbFrbokO5RZwDmSC5TllgPNjYOVFJgh0OQ/kUbi8xY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T4F9r2NFK7vlMT8eYDQEZjNVfNeyyRJapPd8dF2uS7ThaVwcafRvHcOs7UfT2OfMUo9iq9nvxuulEFZHJqKirJYSNIFPGAu4bv76WS384H40nIy6PN2qc0ZgTjCLjTxY4eqmTUjqDjifiae42sJxkr8/zCQkJq/bXeI5wBiecMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HaSvH6w7; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HaSvH6w7"
Message-ID: <862565aa-a5c3-47ec-ad9d-a6c64c61d150@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781062900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rsPmWvfwQSOjTS6cBu2jrJ8w2ejWLn3A0JR8MmqOkUc=;
	b=HaSvH6w7hldLcwyWH/baAYc+XHulhMAP3lSVQZzKosObpocWxCEeosljZGthdLOuBA5InH
	iyPpfWqhWOJ0Ck9GCypn0HudfPB2SjJL3+jVzroW1kMrKWjj9RPyV169ZVUZZ18jSFclNQ
	o0CvozPXZ0GQ5OJfBnI3TFzC9eJF14Q=
Date: Tue, 9 Jun 2026 20:41:36 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/2] selftests/bpf: Keep int return type for
 tailcall subprogs
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260609233407.2711577-1-yonghong.song@linux.dev>
 <20260609234251.C1A6F1F00893@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260609234251.C1A6F1F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 6/9/26 4:42 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Incomplete application of compiler optimization mitigation in `classifier_0`.
> --
>
> commit 230de7228ec64290b0e30a90f68ca96dd2ee6dd0
> Author: Yonghong Song <yonghong.song@linux.dev>
> selftests/bpf: Keep int return type for tailcall subprogs
>
> This commit updates tailcall subprograms to prevent LLVM 23 from optimizing
> their return types from 'int' to 'void', which would cause verifier failures.
> It uses barrier_var() and __sink() to ensure the compiler retains the int
> return type.
>
>> diff --git a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy2.c b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy2.c
>> index ae94c9c70ab7d..6fde0ab921486 100644
>> --- a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy2.c
>> +++ b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy2.c
> [ ... ]
>> @@ -41,16 +44,22 @@ int classifier_0(struct __sk_buff *skb)
>>   static __noinline
>>   int subprog_tail1(struct __sk_buff *skb)
>>   {
>> +	int ret = 0;
>> +
>>   	bpf_tail_call_static(skb, &jmp_table, 1);
>> -	return 0;
>> +	barrier_var(ret);
>> +	return ret;
>>   }
>>   
>>   __auxiliary
>>   SEC("tc")
>>   int classifier_1(struct __sk_buff *skb)
>>   {
>> +	int ret;
>> +
>>   	count1++;
>> -	subprog_tail1(skb);
>> +	ret = subprog_tail1(skb);
>> +	__sink(ret);
>>   	return 0;
>>   }
> [Severity: Medium]
> In classifier_1() here, the return value of subprog_tail1() is captured and
> sunk using __sink() to prevent optimization. Should classifier_0() also be
> updated symmetrically to capture and sink the return value of subprog_tail0()?
>
> Looking at classifier_0() in the same file:
>
> __auxiliary
> SEC("tc")
> int classifier_0(struct __sk_buff *skb)
> {
> 	count0++;
> 	subprog_tail0(skb);
> 	return 0;
> }
>
> While the return value of subprog_tail0() is currently sunk elsewhere in
> tailcall_bpf2bpf_hierarchy_2(), leaving this callsite unsunk could
> potentially leave the code fragile to LLVM optimizations that might create a
> void-returning clone of subprog_tail0() specifically for classifier_0().

We should be fine. In the same file, we have  SEC("tc")
  int tailcall_bpf2bpf_hierarchy_2(struct __sk_buff *skb)
  {
-	int ret = 0;
+	int ret = 0, ret1, ret2;
  
  	clobber_regs_stack();
  
-	subprog_tail0(skb);
-	subprog_tail1(skb);
-
+	ret1 = subprog_tail0(skb);
+	ret2 = subprog_tail1(skb);
+	__sink(ret1);
+	__sink(ret2);
  	__sink(ret);
  	return (count1 << 16) | count0;
  }

This will guarantee subprog_tail0() will have a return value.


