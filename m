Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242D62C3252
	for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 20:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777322445; cv=none; b=YIZ0FWDtHuouUzGqRe/OoMLk6yZpAiMS/+/kW3wLo0cforrPgcOs9IxnkGmoPZE3IrXveqIqpwOFOFJpEnXGOQEpEQH92arsJnz0Olyd9KGcLJ+ZM4ht4jfUd0mDfkaZMyO0iBUgSfsiMQ5lLn+jqjhM05M3q5TPep80d1pPQrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777322445; c=relaxed/simple;
	bh=M+F11CcaNUw+LY83ugiGV9O1WGvvx5sJI291rPh/YHA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=EC9l9hFYZVoviW8PEo78D7XWpI1V9tFs/o9xzqIPFou5XlGH9WORN9p6BjgLyCtmtoWRqRdzVwImOK6NRzfrn/R0tzo62fNGezk5bB3MU2bteKpy0QcLFlrY+RUMmsGtZ9iuB1rR6AVJb1sWAOc6ybhQqD9+xldTnEMawyfUNPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xXhrBa17; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xXhrBa17"
Message-ID: <35ab7841-5e6a-483d-a539-3c267741a880@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777322441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sGgihnYBgGrq8AHUHlxYr9yaVbKDf1iNlJaSjWeIeUY=;
	b=xXhrBa17+zFyun4xM4U8GNFhfBS5NT5VA6GezsecL3iNRAFV915Gq6YfYn31o8BWBAirPx
	zRlR4nD3kAd7escNcW+78WFy/qZruqUlK+CEk3CI/16++RdoEOj8yfEmvAHmb/hpGBhpxH
	+CsSV4ZZyr4y3mM/+xHbsEuN5h2I3KA=
Date: Mon, 27 Apr 2026 21:40:32 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 01/18] bpf: Support stack arguments for bpf
 functions
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 jose.marchesi@oracle.com, kernel-team@fb.com, martin.lau@kernel.org,
 eddyz87@gmail.com, clm@meta.com, ihor.solodrai@linux.dev
References: <20260424171438.2034741-1-yonghong.song@linux.dev>
 <98641213c682008a7c4634976ef37edfe8338fdeaf196f3e119356d8c4c9a63a@mail.kernel.org>
 <fa7819f9-0fbe-4bdb-a9a5-fa6ea7b6e628@linux.dev>
In-Reply-To: <fa7819f9-0fbe-4bdb-a9a5-fa6ea7b6e628@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 4/24/26 10:09 PM, Yonghong Song wrote:
>
>
> On 4/24/26 11:13 AM, bot+bpf-ci@kernel.org wrote:
>>> diff --git a/include/linux/bpf_verifier.h 
>>> b/include/linux/bpf_verifier.h
>>> index d5b4303315dd..2cc349d7fc17 100644
>>> --- a/include/linux/bpf_verifier.h
>>> +++ b/include/linux/bpf_verifier.h
>> [ ... ]
>>
>>> @@ -739,10 +759,13 @@ struct bpf_subprog_info {
>>>       bool keep_fastcall_stack: 1;
>>>       bool changes_pkt_data: 1;
>>>       bool might_sleep: 1;
>>> -    u8 arg_cnt:3;
>>> +    u8 arg_cnt:4;
>>>
>>>       enum priv_stack_mode priv_stack_mode;
>>> -    struct bpf_subprog_arg_info args[MAX_BPF_FUNC_REG_ARGS];
>>> +    struct bpf_subprog_arg_info args[MAX_BPF_FUNC_ARGS];
>>> +    u16 incoming_stack_arg_depth;
>>> +    u16 stack_arg_depth; /* incoming + max outgoing */
>>> +    u16 max_out_stack_arg_depth;
>>>   };
>> Alexei Starovoitov raised a concern in the v6 review about duplicated
>> fields. The incoming_stack_arg_depth, stack_arg_depth, and
>> max_out_stack_arg_depth fields are present in both bpf_subprog_info and
>> bpf_prog_aux structures. His comment was:
>>
>>    "but you already have them in prog_aux?! another copy in
>>    bpf_subprog_info?! Remove one of them. JIT only need one set."
>>
>> Looking at include/linux/bpf.h, these fields appear in bpf_prog_aux:
>>
>>    struct bpf_prog_aux {
>>        ...
>>        u16 incoming_stack_arg_depth;
>>        u16 stack_arg_depth;
>>        ...
>>    };
>>
>> Does the verifier actually need both copies? The concern was that having
>> duplicate state creates maintenance burden.
>
> Before jit_subprogs(), bpf_subprog_info stores the information for 
> each subprog.
> At this point, the subprog has not been allocated and only main prog 
> is available.
> Therefore, it is not possible to copy bpf_subprog_info to each subprog.
>
> So I think it might be necessary to have both fields in bpf_prog_aux and
> bpf_subprog_info.
>
> This version made some changes so max_out_stack_arg_depth is not needed
> any more. Will remove it in the next revision.

I did some futher checking and found that max_out_stack_arg_depth is still
needed. Otherwise, they could silently corrupting stack. For example,
for
     bar(int a) {
       ...
       foo(a1, a2, a3, a4, a5, a6);
       ...
     }

let us say before foo(), we have
     *(u64 *)(r11 - 8) = ...
     *(u64 *)(r11 - 16) = ...
     call foo() ...

In JIT, the outgoing stack will be 8 bytes (for *(u64 *)(r11 - 8) = ...).
But due to '*(u64 *)(r11 - 16) = ...', it may have an outgoing stack writing
with offset -16, which may cause an issue since other applicaiton, e.g.,
nmi/irq etc. So in such ases, we should reject in verifier.

>
>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>> index ff6ff1c27517..bcf81692a22b 100644
>>> --- a/kernel/bpf/verifier.c
>>> +++ b/kernel/bpf/verifier.c 

[...]


