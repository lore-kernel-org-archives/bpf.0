Received: from mta1.migadu.com (out-140.mta1.migadu.com [95.215.58.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD303149DF1
	for <bpf@vger.kernel.org>; Tue,  8 Sep 2026 04:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788841609; cv=none; b=dLDxbMfc4MkDFj/kh6YHelPUf5StEDui9fk9OZEMkd8P7RaDOGg4xphO3XPDJ8mj0ISyyXJkVONhQOcYuJe4AXb3+UIk0ZpBK1Ocvpf2BjBUHK2jIpzvjkMXqpYwOa/tcAoCvE0Pvhx0BqcxHWr/lrFOGcY/e0pfD/iPaW8VZuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788841609; c=relaxed/simple;
	bh=dqEE4SfDKYgiRz5WSBLE3flWNa2QhcOV6wIFz68Is60=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dZMOP2kvifRGthYntTt/AmDX5iR5V1M4QZdf6U+7haAJ6pVZSfFyrQ08BSb8jOOZvyuluMe4KOdx/I25sJfaJ6JV+ZB4mRNOxwFJFiN0fGVzRHfqaAmcadmdXpCswIY76o15at+14SWhTTd9+y+rEVx1VfR6TccdqqmfFwnsRGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Vu0vKb26; arc=none smtp.client-ip=95.215.58.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Vu0vKb26"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=dqEE4SfDKYgiRz5WSBLE3flWNa2QhcOV6wIFz68Is60=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788841605; v=1; x=1789446405;
 b=Vu0vKb26KHsFTT1il85d6LCjvLP4AnYvetB4HE/BGcczD6ObVSZY6BbwnknYbny7M9P+lHx4
 SbaoVtx/YOjIc35K9lRzLOr6soutIEpEB6EGHTW+m5+ZUS/AN90V/2Ao42mxI3MU+oUvQq4QUvU
 uAN2I8VnIGRdAkaTOngIlFFE=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 3f6d3b3f5b0ea20e;
	Tue, 08 Sep 2026 04:26:45 +0000
X-Mizu-Trace-ID: 3f6d3b3f5b0ea20e
X-Migadu-Flow: FLOW_OUT
Message-ID: <2a145c4d-f665-402c-9929-9b2a0fefdad2@linux.dev>
Date: Mon, 7 Sep 2026 21:26:43 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 06/12] bpf: Add a JIT helper for the outgoing
 stack of kfunc calls
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260904050957.3976119-1-yonghong.song@linux.dev>
 <20260904051028.3979694-1-yonghong.song@linux.dev>
 <20260904052505.DF05D1F00AC4@smtp.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260904052505.DF05D1F00AC4@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/3/26 10:25 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] An out-of-bounds write occurs in `btf_prepare_func_args` when processing a BPF subprogram with arguments that consume 11 slots followed by a final 16-byte struct argument.
> --
>
> commit d1c6556d5925344f81e73a6b534000285b7cee65
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> bpf: Support by-value struct arguments up to 16 bytes
>
> This commit adds support for global functions taking a struct or union by
> value up to 16 bytes. It handles structs passed in consecutive registers
> or split across registers and the stack, computing the necessary argument
> slots. The stack argument count is then recomputed based on the slots
> consumed to ensure proper JIT support checks.
>
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index 22828b489b778..dbd64cee1b27a 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
>> @@ -8103,6 +8103,14 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
>>   	for (i = 0, slots_used = 0; i < nargs; i++) {
>>   		u32 tags = 0;
>>   
>> +		if (slots_used >= MAX_BPF_FUNC_ARGS) {
>> +			if (!is_global)
>> +				return -EINVAL;
>> +			bpf_log(log, "Arguments of %s() need more than %d argument slots\n",
>> +				tname, MAX_BPF_FUNC_ARGS);
>> +			return -EINVAL;
>> +		}
>> +
>>   		err = btf_scan_decl_tags(env, btf, fn_t, i, is_global, &tags);
>>   		if (err)
>>   			return err;
> [ ... ]
>
>> @@ -8231,6 +8239,31 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
>>   			sub->args[slots_used++].arg_type = ARG_ANYTHING;
>>   			continue;
>>   		}
>> +		if (btf_type_is_struct(t)) {
>> +			u32 nslots;
>> +
>> +			if (!t->size || t->size > 2 * BPF_REG_SIZE) {
>> +				if (!is_global)
>> +					return -EINVAL;
>> +				bpf_log(log,
>> +					"Arg#%d type %s in %s() has size %u, only 1 to %d bytes "
>> +					"can be passed by value\n",
>> +					i, btf_type_str(t), tname, t->size, 2 * BPF_REG_SIZE);
>> +				return -EINVAL;
>> +			}
>> +			if (!btf_struct_is_composed_of(env, btf, t, BTF_MEMBER_SCALAR)) {
>> +				if (!is_global)
>> +					return -EINVAL;
>> +				bpf_log(log, "Arg#%d type %s in %s() is not composed of scalars\n",
>> +					i, btf_type_str(t), tname);
>> +				return -EINVAL;
>> +			}
>> +
>> +			nslots = (t->size + BPF_REG_SIZE - 1) / BPF_REG_SIZE;
>> +			while (nslots--)
>> +				sub->args[slots_used++].arg_type = ARG_ANYTHING;
> [Severity: High]
> Does this loop write beyond the end of the sub->args[] array?
>
> If a non-global BPF subprogram has arguments consuming exactly 11 slots,
> slots_used >= MAX_BPF_FUNC_ARGS evaluates to false (11 >= 12) at the start
> of the loop, allowing it to proceed.
>
> When a final 16-byte struct argument follows, nslots is set to 2. This
> while loop then writes to sub->args[11] and subsequently out-of-bounds to
> sub->args[12].
>
> Could this memory corruption overwrite the adjacent stack_arg_cnt and
> max_out_stack_arg_cnt fields in struct bpf_subprog_info?

The same issue similar to "bpf: Support by-value struct arguments up to 16 bytes"
and "bpf: Support __int128 as a by-value function argument". Will fix.

>
> On big-endian architectures, this might artificially inflate
> max_out_stack_arg_cnt to 9 (the value of ARG_ANYTHING), causing the
> verifier to subsequently reject valid BPF programs in
> check_outgoing_stack_args(). On little-endian architectures it would
> silently zero the field.
>
>> +			continue;
>> +		}
>>   		if (!is_global)
>>   			return -EINVAL;

