Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B7F2D0C62
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 16:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776530918; cv=none; b=GOiVZhaMFhDUI/dv2CFc3vwCAHsNw0IoQjZ3vXCy0rJcYQAaZZd+0+5YTHvR61AswNg/b/n3BCdgCX/t49JLSWkewnroCvsZoKV+y5mvmUMf9QBpQG6WVr5pIprBySh6kCQFcu/xJOYLA8nuX+RDnJykG9+xubm6cfbM+YGVGg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776530918; c=relaxed/simple;
	bh=ZqvLiKXL5PB/s44pKlWmp37LXYSmE6BPpCBw3Wq83Fw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dOwVaX4n175uMBI1esT62P2vRGATpN8aUQFV/uC5fGAWDOAFXjIobcQ/fRnNsSinoZmBRcnc+4OrI3wQenk63jabkHSWI7wp+CtdwfwLdfkjAwVYEW7VYiI5UgzLzrwH+DHFvbPhAJtJ2AXFuYsnokLU427P5a3Y/OA+Oi3AT6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jsw0dBkq; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jsw0dBkq"
Message-ID: <2425e72e-9044-4f6c-8959-91f2705e5c68@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776530915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4zthNB5VJBhsy3AM9sg+DY4Sn0l39quTeHMMOcdkoSw=;
	b=jsw0dBkqTzARyKVvd85cLZ+dkg4g/WdNKr8kJOgoC+lm10jIDNXnSVKMBOqAKDfr09KRHK
	ZKdb3U8+LYxsdvoZlUQM6wc1hVhsBXiQbjZj8WXTjkPpV3/Z+0m2qA658nI42NBi7FMwp8
	/n1XNm2eIjb9miAjz/tVcI04jdTa8c0=
Date: Sat, 18 Apr 2026 09:48:22 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 06/16] bpf: Limit the scope of BPF_REG_PARAMS
 usage
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 jose.marchesi@oracle.com, kernel-team@fb.com, martin.lau@kernel.org,
 eddyz87@gmail.com, clm@meta.com, ihor.solodrai@linux.dev
References: <20260417034729.2629367-1-yonghong.song@linux.dev>
 <0384d4ba23e7f159c6e80c79a64b4dcd2186fa97b53ae7b2eb721a9cd3156775@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <0384d4ba23e7f159c6e80c79a64b4dcd2186fa97b53ae7b2eb721a9cd3156775@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 4/16/26 9:30 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/kernel/bpf/const_fold.c b/kernel/bpf/const_fold.c
>> index db73c4740b1e..09db7fdb370f 100644
>> --- a/kernel/bpf/const_fold.c
>> +++ b/kernel/bpf/const_fold.c
> [ ... ]
>
>> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
>> index 1fb4c511db5a..993d7e543e9f 100644
>> --- a/kernel/bpf/liveness.c
>> +++ b/kernel/bpf/liveness.c
> [ ... ]
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index ff0c55d80311..f25a56cfabac 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -18487,13 +18487,22 @@ static int check_and_resolve_insns(struct bpf_verifier_env *env)
>>   		return err;
>>
>>   	for (i = 0; i < insn_cnt; i++, insn++) {
>> +		u8 class = BPF_CLASS(insn->code);
>> +		u8 mode = BPF_MODE(insn->code);
>> +
>>   		if (insn->dst_reg >= MAX_BPF_REG) {
>> -			verbose(env, "R%d is invalid\n", insn->dst_reg);
>> -			return -EINVAL;
>> +			if (insn->dst_reg != BPF_REG_PARAMS ||
>> +			    !((class == BPF_ST  || class == BPF_STX) && mode == BPF_MEM)) {
>> +				verbose(env, "R%d is invalid\n", insn->dst_reg);
>> +				return -EINVAL;
>> +			}
>>   		}
>>   		if (insn->src_reg >= MAX_BPF_REG) {
>> -			verbose(env, "R%d is invalid\n", insn->src_reg);
>> -			return -EINVAL;
>> +			if (insn->src_reg != BPF_REG_PARAMS || class != BPF_LDX ||
>> +			    mode != BPF_MEM) {
>> +				verbose(env, "R%d is invalid\n", insn->src_reg);
>> +				return -EINVAL;
>> +			}
>>   		}
>>   		if (insn[0].code == (BPF_LD | BPF_IMM | BPF_DW)) {
>>   			struct bpf_insn_aux_data *aux;
> Can these instructions with BPF_REG_PARAMS trigger out-of-bounds accesses
> in subsequent verification functions? The regs array in struct
> bpf_func_state is declared as regs[MAX_BPF_REG] with MAX_BPF_REG=11,
> giving valid indices 0-10.
>
> When instructions with src_reg=BPF_REG_PARAMS (11) reach check_load_mem():
>
> kernel/bpf/verifier.c:check_load_mem() {
>      ...
>      src_reg_type = regs[insn->src_reg].type;
>      ...
> }
>
> This performs regs[11] which is one past the end of the array.
>
> Similarly, when instructions with dst_reg=BPF_REG_PARAMS reach
> __check_reg_arg():
>
> kernel/bpf/verifier.c:__check_reg_arg() {
>      ...
>      reg = &regs[regno];
>      ...
> }
>
> The commit message states "array-based register tracking indexed by
> register number would cause out-of-bounds accesses. So do early return
> if needed." However, the patch adds early returns in const_fold.c and
> liveness.c but not in the main verification path functions like
> check_load_mem() or __check_reg_arg().
>
> The fix appears to arrive in subsequent commit 212295359353 ("bpf:
> Support stack arguments for bpf functions"). Between this commit and
> that fix, could user-provided BPF programs with BPF_REG_PARAMS
> instructions trigger out-of-bounds memory access in the kernel verifier?

You are right, this patch should be after "bpf: Support stack arguments
for bpf functions" to avoid such issues.

>
> This commit also lacks a Fixes: tag. The suggested tag would be:
>
> Fixes: 595885eced33 ("bpf: Introduce bpf register BPF_REG_PARAMS")
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24546989054

