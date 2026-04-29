Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844A935836B
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 15:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777478334; cv=none; b=iFBw7axkAKVYaSdiBlwqi/nSKE7DCb8OxTGTaLePM2/MdhfkvvGvZA1yqTaghZrcC+mwMYtVBc39KuHeZ293yDZ6J14YQE/iR0kPHUrbfslDDG2KIka/xZfBQuzP4LqSqzZR175R2Eb0xzzZjdTrqQdXdgpG815gZuCc8lv8sbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777478334; c=relaxed/simple;
	bh=XEqBbcz2WitoWZ1ZscyguSEKCfVUkHLgH02Rw9uunT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cl0jEFcWC3qdAPuNDL4tDJmhuwMKjKTImHnJx385J9K1pnCvB7hjMgORp5MMVEb9h3o6KOGso2PW5GYPuI7NN4OeXRRGfQ5vqMsdSnrNANNUQGwtLcoowSGwPwAowIkpqapT99WldrX29+y9HyLpPiGCqSYUTFCUAyYzMn27QtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [112.10.248.232])
	by mtasvr (Coremail) with SMTP id _____wDHGAyuKvJpqyriAA--.4301S3;
	Wed, 29 Apr 2026 23:58:39 +0800 (CST)
Received: from [192.168.0.108] (unknown [112.10.248.232])
	by mail-app3 (Coremail) with SMTP id zS_KCgC3YHOqKvJpiTTHAA--.7276S3;
	Wed, 29 Apr 2026 23:58:37 +0800 (CST)
Message-ID: <0fda2248-18a4-4b24-a400-96e177084151@zju.edu.cn>
Date: Wed, 29 Apr 2026 23:58:33 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v8 3/3] selftests/bpf: Add test for large offset
 bpf-to-bpf call
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260429105608.92741-4-tangyazhou@zju.edu.cn>
 <20260429124936.69BA6C19425@smtp.kernel.org>
Content-Language: en-US
From: Yazhou Tang <tangyazhou@zju.edu.cn>
In-Reply-To: <20260429124936.69BA6C19425@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:zS_KCgC3YHOqKvJpiTTHAA--.7276S3
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiAgQQCmnxDY5GcwAAsy
X-CM-DELIVERINFO: =?B?yD1euAXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9PBiw24NM1oavoRE5xsGAPQtrmzz65JsiqxlGLeAvUxJRfwVpbFy3HR5pjEVwrwKiMAV
	bq8BGy5xoI+fDA2oVgPXEFtDFbvtVQXJqhjaNJsme6LrgY8qc9QLKJt0I4sQIQ==
X-Coremail-Antispam: 1Uk129KBj93XoWxurykWF47Cr4fJF47XFWrJFc_yoW5GF4UpF
	y8Ka4kKF1kWFyIkw1Ikr4DWF1Sq3yxXFyjyr4xXr98AFn8Zrn7GrsIgrW5WFyxCrs2v3W2
	vrsF934ak3W8AFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI4
	8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
	wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjx
	v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20E
	Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267
	AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUUUUU==



On 4/29/26 20:49, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Missing compiler barrier in the inline assembly landing pad allows LLVM to hoist the 'call_happened' load, leading to an infinite recursion loop and kernel panic.
> --
> 
> commit 7a012e4a738e7d37b40994fe21bcf400bb1dd252
> Author: Yazhou Tang <tangyazhou518@outlook.com>
> 
> selftests/bpf: Add test for large offset bpf-to-bpf call
> 
> This commit adds a selftest to verify verifier and JIT behavior when handling
> bpf-to-bpf calls with relative jump offsets exceeding the s16 boundary. It uses
> an inline assembly block with a .rept directive to generate a large dummy
> subprogram, forcing the verifier to process a jump exceeding the s16 range.
> 
>> diff --git a/tools/testing/selftests/bpf/progs/verifier_call_large_imm.c b/tools/testing/selftests/bpf/progs/verifier_call_large_imm.c
>> new file mode 100644
>> index 000000000000..da52a1c16d05
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/verifier_call_large_imm.c
> 
> [ ... ]
> 
>> +SEC("syscall")
>> +__success __retval(3)
>> +int call_large_imm_test(void *ctx)
>> +{
>> +	/*
>> +	 * Landing pad to handle call error on kernel without the fix,
>> +	 * preventing kernel panic.
>> +	 */
>> +	asm volatile (
>> +	"r0 = 0;"
>> +	".rept 32768;"
>> +	"r0 += 0;"
>> +	".endr;"
>> +	::: "r0");
>> +
>> +	/*
>> +	 * The call_happened variable is 1 only when the call insn wrongly
>> +	 * go back to the landing pad above.
>> +	 */
>> +	if (call_happened == 1) {
> 
> Could this lack of a memory clobber in the inline assembly allow the compiler
> to hoist the load of call_happened to before the inline assembly block?
> 
> Because call_happened is a plain global variable and the asm volatile block
> does not include a "memory" clobber, LLVM is structurally permitted to optimize
> the code by hoisting the load.
> 
> If the load is hoisted and a truncated backwards jump lands inside the
> assembly block on an unpatched kernel, the if condition would evaluate a stale
> register value (0) instead of re-reading memory.
> 
> Will this bypass the termination check, re-execute the target_subprog call,
> and create an infinite recursion loop that overflows the kernel stack?

Yes. I should use __clobber_all in the inline asm.

I will send v9 asap.

> 
>> +		/* A volatile variable is used here to prevent optimization. */
>> +		volatile int flag = -1;
>> +		return flag;
>> +	}
>> +
>> +	call_happened = 1;
>> +
>> +	padding_subprog();
>> +
>> +	return target_subprog();
>> +}
> 

