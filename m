Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179E02E7162
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 16:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776530469; cv=none; b=jOfze6pTN7Z1RBsn3TgDDsrgJL0fmmdH4bzSHW2qpZVqB90szfnhQkDoL69Y+UQmyQjEd7PNvNcIbLpNW/o57tnZ7ks2JEZLp0PsC1AuNooDxl2x/SNFKHVQRzNdAhIERL0wtQblo3CWO4diubZq+y2G73qKaWADStKN1DVWW7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776530469; c=relaxed/simple;
	bh=TWev8tfPm3KQ2i/DxsYM1AQlvR1pHhODOmJTJbfBiu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O4TH+fLU9KeSPJMUp0WDNfemcODwaiYuS9c8eHfoLtkIDpicArysR0zlV4Cde8RiiiukRFl8fqaD2NNuz5LcGMQnirIL2L+rogH5a1IcFWyX6pIuCGjdF59kdzzh4cUkdevuLqQX/09XJBva9/duFPS5b+MROV15Jd78Dlf18dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MGCfsrac; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MGCfsrac"
Message-ID: <b2cfd3ed-17eb-42b2-ab36-b98bf4c01007@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776530456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aUySpQRrL9ryTDHXCSnNECXOOnK5dzwLv2y69WWbCyk=;
	b=MGCfsracOpwDA/UxxBu35765ngTyC1ZYa89V8OpZGiotdxVR1+up9aF+ZRbIc4W2F/bSBF
	hmV1YLgrRdRp7AChSKAIgUpwTEwHl6s1c1fywzr/AOFDh0Cx1688vh2X+32Z6Q7o8OnLs8
	G6rt0KDHdmHHSlLDzQLgVW1wmLItR0c=
Date: Sat, 18 Apr 2026 09:40:51 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 03/16] bpf: Refactor to handle memory and size
 together
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260417034713.2627100-1-yonghong.song@linux.dev>
 <20260417044914.84018C19425@smtp.kernel.org>
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260417044914.84018C19425@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 4/16/26 9:49 PM, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 1 potential issue(s):
> - [High] Incomplete refactoring for stack arguments breaks verifier precision tracking, marking incorrect registers.
> --
>
> commit 7bebb6c179745d67fba0c807428d095b66738135
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> bpf: Refactor to handle memory and size together
>
> This commit refactors memory and size register handling in BPF helper
> verification, passing bpf_reg_state directly to prepare for stack arguments.
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 2bedaa193d54d..7a7024d94cf00 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
> [ ... ]
>> @@ -7020,15 +7020,17 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
>>   /* verify arguments to helpers or kfuncs consisting of a pointer and an access
>>    * size.
>>    *
>> - * @regno is the register containing the access size. regno-1 is the register
>> - * containing the pointer.
>> + * @mem_regno is the register containing the pointer, mem_regno+1 is the register
>> + * containing the access size.
>>    */
>>   static int check_mem_size_reg(struct bpf_verifier_env *env,
>> -			      struct bpf_reg_state *reg, u32 regno,
>> +			      struct bpf_reg_state *mem_reg,
>> +			      struct bpf_reg_state *size_reg, u32 mem_regno,
>>   			      enum bpf_access_type access_type,
>>   			      bool zero_size_allowed,
>>   			      struct bpf_call_arg_meta *meta)
>>   {
>> +	int size_regno = mem_regno + 1;
>>   	int err;
> Since this refactoring is intended to support stack arguments, does this
> hardcoded size_regno = mem_regno + 1 break verifier precision tracking?

We are fine here. In function get_kfunc_ptr_arg_type(), we have

         if (argno + 1 < nargs &&
             (is_kfunc_arg_mem_size(meta->btf, &args[argno + 1], &regs[regno + 1]) ||
              is_kfunc_arg_const_mem_size(meta->btf, &args[argno + 1], &regs[regno + 1])))
                 arg_mem_size = true;

This ensures mem_size is at most at R5.

>
> If the memory pointer is passed in R5, mem_regno is 5, making size_regno 6.
>
> This would cause mark_chain_precision() to incorrectly backtrack the
> callee-saved register BPF_REG_6 instead of the stack slot containing the size
> argument.
>
> Furthermore, if mem_regno is later modified to represent a 0-based argument
> index, size_regno will evaluate to the wrong register entirely.
>
> [ ... ]
>> -	err = check_helper_mem_access(env, regno - 1, reg->umax_value,
>> +	err = check_helper_mem_access(env, mem_reg, mem_regno, size_reg->umax_value,
>>   				      access_type, zero_size_allowed, meta);
>>   	if (!err)
>> -		err = mark_chain_precision(env, regno);
>> +		err = mark_chain_precision(env, size_regno);
> Does marking the wrong register leave the actual size argument imprecise,
> potentially corrupting verifier state pruning and allowing out-of-bounds
> memory accesses to bypass verification?
>

