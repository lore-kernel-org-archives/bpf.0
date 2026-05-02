Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC44F309EEB
	for <bpf@vger.kernel.org>; Sat,  2 May 2026 21:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777758909; cv=none; b=bKJAXTXjhlGj/7Syo684xfSO6w+QsJSrP6eiTaz6sRDsxQEiN7wk/uBR4ylsTfe11xSP0/JUkPfPoN6b0WAS72FdN+bumJOPFrFfbFqBzYGmY0sjV+pC/FGaGEXz5YAjPK//UnzyWtOaXn9blPhwtbX7+qsjqfDU8fSltP4jPwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777758909; c=relaxed/simple;
	bh=UJToFbk/smw7T+5219I0qKEaU/aJjyTwHoz37DS/4FU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SfGnXzA1nyTvv7skowS/atVdByV4UcLQwJwcrjSb3ksSkOd+6538wCqt5h7pUGlbuWZ0NECl3/xyMT9A52wJoHrXsR9ISqoVlvCV29Nqusbt6Pi5v2+8sWjc1MA+C4FELOWEM34H2t2RAi79tkhpIA83x51tZOpuDY+QteJ7PRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Fth92p0t; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Fth92p0t"
Message-ID: <7bfa2ead-3b2f-4ec3-be38-2146acc69eb2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777758902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lwiEKTGaoix92Mpj7lQCpAT9D/2ZAH85mNbwd/weSO8=;
	b=Fth92p0tBSkQ2ctZqheNGKYLqVx2l/OHQuKeXsiKtWnN1bFPa7kONQCvG/Th9maiRAy+rY
	sTuXycAtT9jffm2egvQfzI6uJ7tPZKyk50MrRLIk6dX/wodqeEl5xRVzsz9rXxlwgvyo7e
	tq+0vgXu48uFBz8qfyW6BQ66gLRv4Gw=
Date: Sat, 2 May 2026 23:54:59 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 01/18] bpf: Support stack arguments for bpf
 functions
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 "Jose E . Marchesi" <jose.marchesi@oracle.com>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20260424171433.2034470-1-yonghong.song@linux.dev>
 <20260424171438.2034741-1-yonghong.song@linux.dev>
 <DI8CQDATE33J.30U4FNOVZY97R@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <DI8CQDATE33J.30U4FNOVZY97R@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 5/2/26 6:03 PM, Alexei Starovoitov wrote:
> On Fri Apr 24, 2026 at 10:14 AM PDT, Yonghong Song wrote:
>> @@ -1669,6 +1669,8 @@ struct bpf_prog_aux {
>>   	u32 max_pkt_offset;
>>   	u32 max_tp_access;
>>   	u32 stack_depth;
>> +	u16 incoming_stack_arg_depth;
>> +	u16 stack_arg_depth; /* both incoming and max outgoing of stack arguments */
>>   	u32 id;
>>   	u32 func_cnt; /* used by non-func prog as the number of func progs */
>>   	u32 real_func_cnt; /* includes hidden progs, only used for JIT and freeing progs */
> ...
>
>> @@ -739,10 +759,13 @@ struct bpf_subprog_info {
>>   	bool keep_fastcall_stack: 1;
>>   	bool changes_pkt_data: 1;
>>   	bool might_sleep: 1;
>> -	u8 arg_cnt:3;
>> +	u8 arg_cnt:4;
>>   
>>   	enum priv_stack_mode priv_stack_mode;
>> -	struct bpf_subprog_arg_info args[MAX_BPF_FUNC_REG_ARGS];
>> +	struct bpf_subprog_arg_info args[MAX_BPF_FUNC_ARGS];
>> +	u16 incoming_stack_arg_depth;
>> +	u16 stack_arg_depth; /* incoming + max outgoing */
>> +	u16 max_out_stack_arg_depth;
>>   };
> I asked before but if there was an answer it got lost in all emails.
> So will ask again: why duplicate incoming_stack_arg_depth
> and stack_arg_depth in two places? One should be enough.

We can remove 'incoming_stack_arg_depth' in bpf_subprog_info since
in bpf_subprog_info we have 'arg_cnt' field.

I am not sure whether we can remove stack_arg_depth.
stack_arg_depth is to accumulate the incoming + max_outgoing since
the subprog may have multiple functions inside.
At this verification point, we accumulate such infomation at bpf_subprog_info.
At this point, we only have main program, so we cannot copy
subprog info stack_arg_depth to subprog. The subprog allocations
are in jit_subprogs(). Did I miss anything?

>
> And another question:
> max_out_stack_arg_depth is computed only to error like this in bpf_fixup_call_args().
>
> +               u16 outgoing = subprog->stack_arg_depth - subprog->incoming_stack_arg_depth;
> +
> +               if (subprog->max_out_stack_arg_depth > outgoing) {
> +                       verbose(env,
> +                               "func#%d writes stack arg slot at depth %u, but calls only require %u bytes\n",
> +                               i, subprog->max_out_stack_arg_depth, outgoing);
> +                       return -EINVAL;
>
> why bother? What will go wrong if it's not there?

This is related to jit. For example, we have the following x86 jit stack layout:

       high address
       +-------------------------+
       | incoming stack arg N    |  [rbp + 16 + (N-7)*8]  (from caller)
       | ...                     |
       | incoming stack arg 7    |  [rbp + 16]
       +-------------------------+
       | return address          |  [rbp + 8]
       | saved rbp               |  [rbp]
       +-------------------------+
       | BPF program stack       |  (round_up(stack_depth, 8) bytes)
       +-------------------------+
       | callee-saved regs       |  (r12, rbx, r13, r14, r15 as needed)
       +-------------------------+
       | outgoing arg M          |  [rsp + (M-7)*8]
       | ...                     |
       | outgoing arg 7          |  [rsp]
       +-------------------------+  rsp
       low address

Let us say M = 8, so we will do
     *(r11 - 8) = X1
          is translated to r9 = X1
     *(r11 - 16) = X2
          is to store X2 to slot 'outgoing arg 7'
     *(r11 - 24) = X3
          is to store X3 to slot 'outgoing arg 8'

Let us we have another *(r11 - 32) = X4 in the code, it
will to store the X4 in 'callee-saved regs' area and this
will corrupt the callee-saved regs.
That is why we should reject it in verifier.

