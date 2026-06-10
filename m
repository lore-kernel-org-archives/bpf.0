Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51E023B63E
	for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 03:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781063128; cv=none; b=OPvtGm9u3dY4WAFPMlkKpeywOtiO2Vmin9xXuLlhlqz9EUzQOJpQlI1x7wPgcqyPtjujV0UGK5U5xThq3gOvG+GvI48xvEKQt8tC3n9QezF2lYRd9dF0vREFIXIQPhUa32P5LWq4SFolCSDaSHC5Risav9JQ8IzBIqXaEfxW5lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781063128; c=relaxed/simple;
	bh=gwJWGz77qe/1ByjH2crEmxFB0VTpP5Uh8us4EGeuVZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EDNOYKycblTBorNcBJhSJZYrlvomP1SAmyqh9BmqvxUUHLPyGFHWmpbjWJBktQSJJr5ptdtlxDB6E3rLI5fdiH3Oo6s0UnlEsbRC3aX6th2xtaNceuEJhVgQNdlDStS7Thxu9nCmFpdDJ6/+m19LaelJM+h0YdlaJti97i0HdQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=M8qYx/uU; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="M8qYx/uU"
Message-ID: <811b9cd4-829e-4a02-8265-ea0f64d7991f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781063122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5ukLTOUrZY9TshkkY0HnPkd3VQYy5ImvpCPeKTGUyn8=;
	b=M8qYx/uUxrM/7AaNOj8lkJJRx4Gw+6O0m3ls2e9R2ZXe1tMmfoOpzzdbv1KRoaJOKojXTS
	WU+a6/yOln06iVRWj6iPGSrL+dLVyZf9Xuwi7xnW2pY/R1fCQvsvy99OtcLa+uq4N0yF1O
	ZRIYyksfovSbR2kC/TkimCQDxDhLrkU=
Date: Tue, 9 Jun 2026 20:45:13 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/2] selftests/bpf: Keep int return type for
 tailcall subprogs
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 kernel-team@fb.com, martin.lau@kernel.org, eddyz87@gmail.com, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20260609233407.2711577-1-yonghong.song@linux.dev>
 <5ece679164a4c99cbba93f55c2f9609be6e315d4813737a15b083c9f7dffa17f@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <5ece679164a4c99cbba93f55c2f9609be6e315d4813737a15b083c9f7dffa17f@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 6/9/26 5:07 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf2.c b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf2.c
>> index ce97d141daee..c4fadee5aadc 100644
>> --- a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf2.c
>> +++ b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf2.c
> [ ... ]
>
>> diff --git a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy2.c b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy2.c
>> index ae94c9c70ab7..6fde0ab92148 100644
>> --- a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy2.c
>> +++ b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy2.c
>> @@ -25,8 +25,11 @@ int count1 = 0;
>>   static __noinline
>>   int subprog_tail0(struct __sk_buff *skb)
>>   {
>> +	int ret = 0;
>> +
>>   	bpf_tail_call_static(skb, &jmp_table, 0);
>> -	return 0;
>> +	barrier_var(ret);
>> +	return ret;
>>   }
>>
>>   __auxiliary
>>   SEC("tc")
>>   int classifier_0(struct __sk_buff *skb)
>>   {
>>   	count0++;
>>   	subprog_tail0(skb);
>>   	return 0;
>>   }
> The patch adds barrier_var() to subprog_tail0() to prevent the compiler
> from optimizing its return type from int to void. However, is the
> approach sufficient for classifier_0()?
>
> Looking at how the patch handles other callers like classifier_1():
>
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
> In classifier_1(), the return value is captured and passed to __sink().
> This creates a use at the callsite that forces the compiler to preserve
> the int return type.
>
> Without capturing and sinking the return value in classifier_0(), could
> LLVM still create a void-returning clone of subprog_tail0() for this
> specific callsite? While subprog_tail0() is also called from
> tailcall_bpf2bpf_hierarchy_2() where its return value is properly sunk,
> the compiler might still specialize the function differently for the two
> callsites.

We should be fine. In the same file, we have  SEC("tc")

__success
__retval(33)
SEC("tc")
int tailcall_bpf2bpf_hierarchy_2(struct __sk_buff *skb)
{
         int ret = 0, ret1, ret2;

         clobber_regs_stack();

         ret1 = subprog_tail0(skb);
         ret2 = subprog_tail1(skb);
         __sink(ret1);
         __sink(ret2);
         __sink(ret);
         return (count1 << 16) | count0;
}

This will guarantee subprog_tail0() will have a return value.


>
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27243286945

