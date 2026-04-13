Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3257122257E
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 15:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776093793; cv=none; b=KTtJL4V4eIfpZ8sdyoIWCVrKWcLv4WJTCBo0OmiLjLaPihmWvaQhhCi2vUbzmgrlaxjihQfSfb+f+QVi57qyXk0TO6r5YF5aIsOHK7r0409ubVU47W6gg4qGgyrfbOFdjZDsKSfwK/4PvOwsaGX8y0D3C9EKnxoRMK/EuX5xbAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776093793; c=relaxed/simple;
	bh=by5dBs7UIZmHjeqxYGHb9+/kkCmPiz54MjuYh5y/C4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q7LitwkblqI5z5Vi556q5W2H5CRXCT0FGICIXTbvo4n6hKn9SSwAsIajJV7qIMRBz/mVh+kDY9fBJRXJqrgGSBFOra+ZhM6pEIeHgCke1j9o5F0vztYd3yvGKXQQoDNbMzIrdfRSaWhK8rtmw4hz78Y8+cSKtyL0XYNU3WRrPms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qcz8sYeY; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qcz8sYeY"
Message-ID: <e9489c37-9538-499a-a823-5900a9ea34c3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776093788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=brfZ8maWTO1TXPddmEJaRsjHvSE3Zefq48Xbyl4I/8c=;
	b=qcz8sYeYsBe/Z2Q+24X/ShNL51QoTUl+5aogx6mUhd9MslXPRZ9wXKmZseBQHX7tibxb5n
	9go6TaCAXUfAFJoUiW6Xcv/vHfo0ceWjqpfSZSH0AgVhiSo9/w3HssVdNof2vqc3Aqi1Rf
	kHPJJ/yDIiE/eg4fUJ5CdmQvIfmjgRY=
Date: Mon, 13 Apr 2026 08:22:42 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 09/18] bpf: Support stack arguments for bpf
 functions
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 jose.marchesi@oracle.com, kernel-team@fb.com, martin.lau@kernel.org,
 eddyz87@gmail.com, clm@meta.com, ihor.solodrai@linux.dev
References: <20260412045955.257613-1-yonghong.song@linux.dev>
 <bcd1b7033de7f597d73b3991f8fc4d8b502fce451fc288d909ae72a717578a0d@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <bcd1b7033de7f597d73b3991f8fc4d8b502fce451fc288d909ae72a717578a0d@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 4/11/26 10:43 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 01df990f841a..e664d924e8d4 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
> [ ... ]
>
>> @@ -22383,11 +22682,11 @@ static int check_and_resolve_insns(struct bpf_verifier_env *env)
>>   		return err;
>>
>>   	for (i = 0; i < insn_cnt; i++, insn++) {
>> -		if (insn->dst_reg >= MAX_BPF_REG) {
>> +		if (insn->dst_reg >= MAX_BPF_REG && insn->dst_reg != BPF_REG_STACK_ARG_BASE) {
>>   			verbose(env, "R%d is invalid\n", insn->dst_reg);
>>   			return -EINVAL;
>>   		}
>> -		if (insn->src_reg >= MAX_BPF_REG) {
>> +		if (insn->src_reg >= MAX_BPF_REG && insn->src_reg != BPF_REG_STACK_ARG_BASE) {
>>   			verbose(env, "R%d is invalid\n", insn->src_reg);
>>   			return -EINVAL;
>>   		}
> This allows r12 (BPF_REG_STACK_ARG_BASE) through the register
> validation for all instruction classes, but only BPF_LDX, BPF_STX,
> and BPF_ST have explicit early-return handling for r12. What happens
> if a BPF program uses r12 as src_reg or dst_reg in an ALU or JMP
> instruction?
>
> As far as I can tell, the path would be:
>
>    check_alu_op() or check_cond_jmp_op()
>      check_reg_arg(env, 12, ...)
>        __check_reg_arg(env, regs, 12, ...)
>          reg = &regs[12];
>
> The regs array is struct bpf_reg_state regs[MAX_BPF_REG] with
> MAX_BPF_REG = 11 (indices 0-10), so regs[12] is an out-of-bounds
> access into whatever follows the regs array in bpf_func_state.

Good point. We should allow BPF_REG_STACK_ARG_BASE only for BPF_LDX, BPF_STX
and BPF_ST.

>
> Would it make sense to restrict the r12 exemption here to only the
> instruction classes that actually handle it (BPF_LDX, BPF_STX,
> BPF_ST), rather than allowing it globally?
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24299298635

