Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.76.78.106
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792572619;
	b=3zD2GDiKU1Zcl4dC7m5BrxMP8WG4+ZIk18aIp056KBFOo6hTaSVVGXjSOW/OtCvwFE7v
	 BrGNoU8/EvIJ7VAOWx+Boi48WNhhKvWTmsQ/2tw+i6agOrEqaI1Y1f4oOiGyFIiVEiImY
	 d+9zjg5KREGsnpkFcemzHPGxjaW3rkDoDB/3k19rwz/uAH8oyPlC+S3VCvNagsS6jPX4n
	 hEjjVHB0Nke1RudZoj6uNry2EMt+m+iwpaBhLM4shuXS+a6k2TV736s+3cTFxv8Y9nHQt
	 uE+4aTNfN1lur/2XA/xQdYeslJc5bdacjNSu8+UViSWDWSzs26VKPdE6otq0oMlvoGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792572619;
	h=DMARC-Filter:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-CM-DELIVERINFO:X-Coremail-Antispam;
	bh=Bvbns/c9k2Ysb0qfksh+EEDxxSvu9RKvSHSavAnICg4=;
	b=WY/IjbVnNLiO2s/kqZLyyJ0KNO6dNGYzSmQ34ObgYapqmbJnkuzMJHa7Pjh3pI4z7v/A
	 D/GKKbc089XGzd+dGw1tGmmr1xRwKE7uvZjYywoNgCisa4+xH7fz9FIcxjrJk7stjIqJR
	 Olu8d784RYOTe9UKbTvXSJrUUo1/B+3TKB7nxM2c9eN5Tx3VkBUvp2FNEGdMTj1tZMikF
	 OU6PJYf1D+Tovev1UvHq1fClve6bkN59tlfjGuUj3v5vs9B0xcXf+OF/yqDqFUluOcjZH
	 reJ9tZvMdF66g89t1mwdJpBA5vl2Ld39k8ApLnjhZLC86SjqlKByDoa2jLGbmHMftlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=zju.edu.cn;
	spf=pass smtp.mailfrom=zju.edu.cn;
	arc=none smtp.remote-ip=13.76.78.106
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.78.106])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496BD606A321
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 08:50:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 496BD606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.162.163.215])
	by mtasvr (Coremail) with SMTP id _____wD3sj26fNhqUWqtAQ--.294S3;
	Wed, 21 Oct 2026 16:50:03 +0800 (CST)
Received: from [10.162.163.215] (unknown [10.162.163.215])
	by mail-app1 (Coremail) with UTF8SMTPSA id yy_KCgAHFYK5fNhqm8aBAA--.75S3;
	Wed, 21 Oct 2026 16:50:01 +0800 (CST)
Message-ID: <0c1e5725-475f-4c40-9f1c-3f4496e765e1@zju.edu.cn>
Date: Wed, 21 Oct 2026 16:50:01 +0800
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/8] bpf: Add UHMUL and SHMUL instructions
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com
References: <20261021-bpf-hmul-v2-1-88e260099f7d@outlook.com>
 <ade7e1bd9d4c7a3975fed8e1bea08fd66cf1b03c9c7df26f4f9fe07d36187dfa@mail.kernel.org>
Content-Language: en-US
From: Yazhou Tang <tangyazhou@zju.edu.cn>
In-Reply-To: <ade7e1bd9d4c7a3975fed8e1bea08fd66cf1b03c9c7df26f4f9fe07d36187dfa@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:yy_KCgAHFYK5fNhqm8aBAA--.75S3
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiAg8LCmrXxB0t6AAAst
X-CM-DELIVERINFO: =?B?D/Xq8gXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9KmYK0NRSKgOZzh3f8tQmcYWTeZJMivZ+GmmWIBIiropCbArUwDKhFFAgA48/vsCNPU2
	cTM/esb6ffkwVvLJ4LWN3k+NdtyNkM35N3A7iSEk8jLWEuvXCRi6ujgKFvapwA==
X-Coremail-Antispam: 1Uk129KBj93XoWxGF1fWr1DtrWDWw1UAF15ZFc_yoW5tF1kpF
	saqF1kGr4kWFZ8Zwn7u342g3WY9a1F9a1UWFyDGrWDZanxG3s5Kr4IgF1avFyUGr4vg3WU
	tFZ09w1kCrWrZrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
	wI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI4
	8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
	wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjx
	v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20E
	Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267
	AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UR7KsUUUUU=



On 10/21/26 2:15 PM, bot+bpf-ci@kernel.org wrote:
>> bpf: Add UHMUL and SHMUL instructions
> 
> TL;DR: Verifier still rejects UHMUL/SHMUL (off 1/2), so the new interpreter
> code is unreachable; once enabled, JITs and range tracking would silently use
> low-half multiply. Should the UAPI wait for the full series?
> 
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index f29b0aad440c..90c30e5d790b 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -34,6 +34,12 @@
>>   #define BPF_FROM_LE	BPF_TO_LE
>>   #define BPF_FROM_BE	BPF_TO_BE
>>
>> +/* BPF_MUL off values for high-half multiplication; BPF_ALU64 only. */
>> +enum bpf_mul_variant {
>> +	BPF_UHMUL = 1,
>> +	BPF_SHMUL = 2,
>> +};
>> +
>>   /* jmp encodings */
> 
> Can a program that uses these new encodings be loaded at all with only this
> patch applied?
> 
> check_alu_fields() in kernel/bpf/verifier.c is not touched, and it still
> rejects any BPF_MUL with a non-zero off:
> 
>      case BPF_MUL:
>      case BPF_DIV:
>      case BPF_MOD:
>          if (BPF_SRC(insn->code) == BPF_X) {
>              if (insn->imm != 0 || (insn->off != 0 && insn->off != 1) ||
>                  (insn->off == 1 && opcode != BPF_MOD && opcode != BPF_DIV)) {
>                  verbose(env, "BPF_ALU uses reserved fields\n");
>                  return -EINVAL;
>              }
>          } else if (insn->src_reg != BPF_REG_0 ||
>                 (insn->off != 0 && insn->off != 1) ||
>                 (insn->off == 1 && opcode != BPF_MOD && opcode != BPF_DIV)) {
> 
> Both off == 1 (UHMUL) and off == 2 (SHMUL) fail with "BPF_ALU uses reserved
> fields".
> 
> That means the UHMUL/SHMUL arms of ALU64_MUL_X and ALU64_MUL_K in
> ___bpf_prog_run() cannot run, and BPF_UHMUL/BPF_SHMUL describe encodings the
> kernel refuses.  bpf_insn_is_hmul() in include/linux/filter.h has no callers
> anywhere in the tree, and bpf_is_hmul_variant() is only called by it, so both
> are currently dead code.
> 
> The commit message mentions interpreter support, but does not say that the
> verifier change is left for later.
> 
> When the verifier is relaxed, the JITs and the range tracking will also need
> attention.  The JITs ignore insn->off for BPF_MUL today; for example
> arch/x86/net/bpf_jit_comp.c emits a plain imul for
> "case BPF_ALU64 | BPF_MUL | BPF_K/X".  adjust_scalar_min_max_vals() models
> BPF_MUL as a low-half multiply.  Without changes there, JITed programs would
> silently compute the low half and the verifier's bounds would not match the
> real result.
> 
> Should the UAPI constants and the divmul64v2 group wait until verifier, JIT
> and selftest support land in the same series, or should the unused
> bpf_insn_is_hmul() be dropped from this patch?


Thanks for the review. This review appears to have been triggered while
the v2 series was only partially available on the mailing list due to
SMTP delivery issues. I have now manually sent the remaining patches,
which should address these concerns.

However, I agree that it would be better to move the definition of
bpf_insn_is_hmul() from patch 1/8 to patch 2/8 where it is first used.
I'll make this change in the next revision.

(I've removed most recipients from this reply to avoid running into
the same SMTP delivery issues again.)

> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39552088777

