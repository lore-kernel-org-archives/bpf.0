Received: from mta1.migadu.com (out-222.mta1.migadu.com [95.215.58.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB32D196C7C
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 18:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786644282; cv=none; b=gBMVMRd5wp8tJh/XtbLqY49hx41o1dDW4En1i0UtCu2Asf/pz2LqYMBPLd1EPmBXr9GS7xz7huEkPSi7Fo9Zt2N9kuL3h8UC3KcPfwQT4C74A5A3acI8MwbYOE5pmij7s9C9Y4wmIiLmt6QlYSTNg5F0kDx2vu9gRer9bANQJwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786644282; c=relaxed/simple;
	bh=kpsvm4w1Af6hTtJKNzC5VU5wcjf8HWwIn/vJc9GR5Y8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XTenNbXVOWViJ3kpOcgiNGyw84xeNDCyRtmJ3SXcH8VZ+3hi1xhahB1mt40nfAENSlJkw9l+zcFX6vN7XitakikHBI2tYhtZtXSNBZUrUWHq2YgJ6kkok3cqGPnSZKGOQBR1xLN5X9P+IF53aKmkpWUEfIvcNkA18Rf+TJ5LTFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hH2tAbGA; arc=none smtp.client-ip=95.215.58.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hH2tAbGA"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=kpsvm4w1Af6hTtJKNzC5VU5wcjf8HWwIn/vJc9GR5Y8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786644278; v=1; x=1787249078;
 b=hH2tAbGA86QACAs3/OpgBTOZalC7hI1LiEWy0GZXo6hEaONCdOdHndNBo+/ZfwI2tm7p3Rwz
 w/hJ7uLk0DxxHsDzOUYiwfgJp1rFs7yxUn2B489PrfxT3VFKrb1B5S8gWSMRyp+9fqWFigAYJbl
 GcRFuV0oBRvtHZO1AuRjZ3yU=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2600:381:1f2d:e3e3:185d:58c3:4c79:68c] (2600:381:1f2d:e3e3:185d:58c3:4c79:68c)
	by smtp.migadu.com with ESMTPS id c5aafa6ca1c84c0a;
	Thu, 13 Aug 2026 18:04:38 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <16510321-fec5-4aaf-b719-653f07d19670@linux.dev>
Date: Thu, 13 Aug 2026 11:04:35 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 04/13] bpf: Track R2 of register-pair returns
 in precision backtracking
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
References: <20260811000911.2378679-1-yonghong.song@linux.dev>
 <20260811000932.2381351-1-yonghong.song@linux.dev>
 <6e48cbadf7fb90cce2da403266e4a962928b7c88.camel@gmail.com>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <6e48cbadf7fb90cce2da403266e4a962928b7c88.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/12/26 2:16 PM, Eduard Zingerman wrote:
> On Mon, 2026-08-10 at 17:09 -0700, Yonghong Song wrote:
>
> ...
>
>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>> index 79680f3b4c74..911d57ce2488 100644
>> --- a/include/linux/bpf_verifier.h
>> +++ b/include/linux/bpf_verifier.h
>> @@ -1447,6 +1447,8 @@ int bpf_jmp_offset(struct bpf_insn *insn);
>>   struct bpf_iarray *bpf_insn_successors(struct bpf_verifier_env *env, u32 idx);
>>   void bpf_fmt_stack_mask(char *buf, ssize_t buf_sz, u64 stack_mask);
>>   bool bpf_subprog_is_global(const struct bpf_verifier_env *env, int subprog);
>> +int bpf_get_kfunc_ret_size(const struct bpf_prog *prog, u32 func_id,
>> +			   u16 btf_fd_idx, u8 *ret_size);
>>   
>>   int bpf_find_subprog(struct bpf_verifier_env *env, int off);
>>   bool bpf_is_throw_kfunc(struct bpf_insn *insn);
>> diff --git a/kernel/bpf/backtrack.c b/kernel/bpf/backtrack.c
>> index 40bd04421a99..fc8ecad6f01b 100644
>> --- a/kernel/bpf/backtrack.c
>> +++ b/kernel/bpf/backtrack.c
>> @@ -425,6 +425,15 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
>>   				 */
>>   				verifier_bug_if(idx + 1 != subseq_idx, env,
>>   						"extra insn from subprog");
>> +				/*
>> +				 * a global subprog returning more than 8 bytes
>> +				 * sets R2 as well. R2 is part of the args mask
>> +				 * checked just below, so it has to be cleared
>> +				 * here rather than next to R0.
>> +				 */
>> +				if (bt_is_reg_set(bt, BPF_REG_2) &&
>> +				    bpf_ret_reg_pair(env, subprog))
>> +					bt_clear_reg(bt, BPF_REG_2);
> Nit: Tbh, I don't see a need in the bpf_ret_reg_pair() check.
>       I'd call bt_clear_reg(r2) unconditionally.
>       Don't find verifier_bug() justification all that compelling.

Okay, will remove the above 'if' condition.

>
>>   				/* r1-r5 are invalidated after subprog call,
>>   				 * so for global func call it shouldn't be set
>>   				 * anymore
>> @@ -508,6 +517,19 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
>>   				return -ENOTSUPP;
>>   			/* regular helper call sets R0 */
>>   			bt_clear_reg(bt, BPF_REG_0);
>> +			/* a kfunc returning more than 8 bytes also sets R2 */
>> +			if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL &&
>> +			    bt_is_reg_set(bt, BPF_REG_2)) {
>> +				u8 ret_size;
>> +				int err;
>> +
>> +				err = bpf_get_kfunc_ret_size(env->prog, insn->imm, insn->off,
>> +							     &ret_size);
>> +				if (verifier_bug_if(err, env, "no kfunc desc for insn %d", idx))
>> +					return -EFAULT;
>> +				if (ret_size > 8)
>> +					bt_clear_reg(bt, BPF_REG_2);
>> +			}
> And same here, too much code for bug detection that fired once or
> twice in my memory.

Will remove verifier_bug_if().

>
>>   			if (bt_reg_mask(bt) & BPF_REGMASK_ARGS) {
>>   				/* if backtracking was looking for registers R1-R5
>>   				 * they should have been found already.
>> @@ -522,7 +544,30 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
>>   					return -EFAULT;
>>   			}
>>   		} else if (opcode == BPF_EXIT) {
>> -			bool r0_precise;
>> +			bool from_subprog_call, r0_precise, r2_precise = false;
>> +
>> +			/*
>> +			 * BPF_EXIT in subprog or callback always returns
>> +			 * right after the call instruction, so by checking
>> +			 * whether the instruction at subseq_idx-1 is subprog
>> +			 * call or not we can distinguish actual exit from
>> +			 * *subprog* from exit from *callback*. In the former
>> +			 * case, we need to propagate the precision of the
>> +			 * return registers, if necessary. In the latter we
>> +			 * never do that.
>> +			 */
>> +			from_subprog_call = subseq_idx - 1 >= 0 &&
>> +					    bpf_pseudo_call(&env->prog->insnsi[subseq_idx - 1]);
>> +			if (from_subprog_call && bt_is_reg_set(bt, BPF_REG_2)) {
>> +				struct bpf_subprog_info *callee;
>> +
>> +				/* 'idx' is the exit insn, so it is in the callee */
>> +				callee = bpf_find_containing_subprog(env, idx);
>> +				if (verifier_bug_if(!callee, env,
>> +						    "no subprog contains exit insn %d", idx))
>> +					return -EFAULT;
>> +				r2_precise = bpf_ret_reg_pair(env, callee - env->subprog_info);
>> +			}
> And here, if the verifier_bug check is ignored r0/r2 can be handled together.

Yes, will remove verifier_bug_if().

>
>>   
>>   			/* Backtracking to a nested function call, 'idx' is a part of
>>   			 * the inner frame 'subseq_idx' is a part of the outer frame.
> ...

