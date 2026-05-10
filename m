Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BA33B47E5
	for <bpf@vger.kernel.org>; Sun, 10 May 2026 17:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778433091; cv=none; b=der2DnIEm7zjPBB+v53rEnwPVlVCo0PqgAohm0nRdNpHqt9pFbWwOEIxCecSY7edOVytVR+qy42wjAY5OFLl19IXHupxX/UP4RUugx/OYBQ3jz1KRwuiBeTZffQzpmvZF+1VDzJjl3h7b4q5JRvNkvFhGVdj3YPiMI9zcmyztYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778433091; c=relaxed/simple;
	bh=j11zjpxB7yrMMAB7th2v5gHoJ3Kl3BaOS8rn6O9DIW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=blqI9MSuzqfNErAwsq4hhg+MxSdiyoUytgmEMTjUoUmvA27H7m0gDpZ0flKk+boe7k1Jq/DB4jlUlZ4TJ1QCbzPz2JurDjoTK3JXdltbA9BrNW2yEI3zFo05jlcqqNWuuDkpTmm2X7AdQOkX6zhn9bn+tts37TcYk5ee9WEK6V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sCBL8BQm; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sCBL8BQm"
Message-ID: <08b05f0f-ef06-4c67-a79a-335ad2359409@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778433087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tzWyzEceKJqo66xhwjO04kxworHXWVClbZ9/PBWmBVU=;
	b=sCBL8BQmvpvI5Hb7G7l9RtShHm6q4aVZ1hqe9IgWOp5a9xFP0kqT6RMQU5vuNiAcgk2R/I
	u5Ugz1NEhEHJSDK2vw47bQLzTvkhirDumkQmXiZvPNfLo0ciEj+sJE2x+r+HBkme602Ray
	avTOqZe9h3xP1erYcmatILzLprCWoVE=
Date: Sun, 10 May 2026 10:11:22 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 12/23] bpf: Enable r11 based insns
Content-Language: en-GB
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260507213044.1130883-1-yonghong.song@linux.dev>
 <20260509025939.86223C2BCB0@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260509025939.86223C2BCB0@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 5/9/26 4:59 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Critical] The patch enables the use of `BPF_REG_PARAMS` (`r11`) in BPF instructions but fails to include the corresponding JIT compiler and interpreter support, allowing an attacker to achieve arbitrary kernel memory reads and writes.
> --
>
> commit ae81414063b0b3f7e1da69b7583407d2bc29cb7c
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> bpf: Enable r11 based insns
>
> This patch enables the use of BPF_REG_PARAMS (r11) for stack argument
> accesses in the BPF verifier. It updates check_and_resolve_insns() to
> accept ldx, st, and stx instructions that use r11 if they match the
> stack argument formats.
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 4827df9f817c2..e208807e79959 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -18004,11 +18004,12 @@ static int check_and_resolve_insns(struct bpf_verifier_env *env)
>>   		return err;
>>   
>>   	for (i = 0; i < insn_cnt; i++, insn++) {
>> -		if (insn->dst_reg >= MAX_BPF_REG) {
>> +		if (insn->dst_reg >= MAX_BPF_REG &&
>> +		    !is_stack_arg_st(insn) && !is_stack_arg_stx(insn)) {
> Does enabling r11 here without corresponding JIT and interpreter updates
> introduce a regression?

This is a new feature. So it won't cause regression from this patch
set perspective. But indeed, r11 based insns are enabled, but jit is
not enabled, but this is not a regression.

>
> If a program uses r11, but the JIT backends lack a mapping for it, could
> it map to an unexpected hardware register? For example, on x86-64, if
> reg2hex[11] defaults to 0, it maps to %rax (BPF_REG_0).

No. jit is not enabled yet for stack arguments. Also for the below
example.

>
> Since a BPF program can control the value of BPF_REG_0, an instruction
> like BPF_STX [r11 - 8], r1 might be compiled to mov %rdi, -8(%rax). Could
> this allow an arbitrary memory write bypassing the verifier sandbox?
>
> In non-JIT environments, could regs[11] in the interpreter be
> uninitialized, leading to uninitialized pointer dereferences?

The verifier should be able to prevent that. See previous comments
in "bpf: Reject stack arguments in non-JITed programs".

>
> It appears this regression is addressed later in the series by commit
> ee1dd512e669a ("bpf,x86: Implement JIT support for stack arguments")
> and commit 6ccf042549a39 ("bpf, arm64: Add JIT support for stack
> arguments"), but could applying this patch on its own break bisection?

I guess it should be okay. It won't break the kernel although
verificaiton will failure.

>
>>   			verbose(env, "R%d is invalid\n", insn->dst_reg);
>>   			return -EINVAL;
>>   		}
>> -		if (insn->src_reg >= MAX_BPF_REG) {
>> +		if (insn->src_reg >= MAX_BPF_REG && !is_stack_arg_ldx(insn)) {
>>   			verbose(env, "R%d is invalid\n", insn->src_reg);
>>   			return -EINVAL;
>>   		}

