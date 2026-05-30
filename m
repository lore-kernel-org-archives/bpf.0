Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBE3384CDA;
	Sat, 30 May 2026 09:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780133809; cv=none; b=fICkHhuEPLSK+DSAUC2b/a0k6qBFgFXSiGkFtE2m2gXX99+CaY+mCdbKjACmlBxbJslbouEv0X5/Kb1UVfTE8vfi3wooUi9BHkV0/eiY5MSHqpU8n9+U7YETwD4lNMVVDCtdWT+eu1fQHj5RLHpSHQP16PsIveyR/Uda64BZ8Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780133809; c=relaxed/simple;
	bh=DvzHfBi8bSzdJXZCzXX+Arf4jqGvTMfWhGUiSFuvYdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q4KlXdhOTaBTp0Gem4qKIJbQRoVlYmYYMTrUH1T96DpyTe5PPu4X7qalD+WQ/urtNAxg5Wvq1DTLTe0p0a5BJ6fFjUcpf//fWsnv3GvDroeCwGOhHzXzyC8Vf580OA25rcc799pIMclO62s/G4HDqPKzv5GLRv8a3aAhVH6lRQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gSFTB18F1zYQtlp;
	Sat, 30 May 2026 17:35:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 648F44056F;
	Sat, 30 May 2026 17:36:43 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP2 (Coremail) with SMTP id Syh0CgAHbfunrxpqhJ6HEA--.7421S2;
	Sat, 30 May 2026 17:36:41 +0800 (CST)
Message-ID: <1c581fa6-c957-4581-98ee-19c8fd54a84d@huaweicloud.com>
Date: Sat, 30 May 2026 17:36:39 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v2 1/3] bpf: Add validation for bpf_set_retval
 argument
Content-Language: en-US
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com,
 yonghong.song@linux.dev, sdf@fomichev.me, zhuyifei@google.com,
 mattbobrowski@google.com, 2022090917019@std.uestc.edu.cn,
 martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev
References: <20260530055557.549474-2-xukuohai@huaweicloud.com>
 <0bd66ee75b8124e031cda23490dea118871cf1517c42f8e6d99ab8369d0e8411@mail.kernel.org>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <0bd66ee75b8124e031cda23490dea118871cf1517c42f8e6d99ab8369d0e8411@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgAHbfunrxpqhJ6HEA--.7421S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWr1DXFWfuw1UXrykCFWrGrg_yoW5AFy3pr
	4xGrWYyrs0qF43W3Z7t3WkAFyYya42v3y3CF9rJas0yan5Wrn7Ka48Wr4akr9IvFy8Cw4S
	yr1Uu3sF9rWUAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	s2-5UUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 5/30/2026 3:04 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 7fb88e1cd7c4..e82dedf871e8 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -10460,6 +10460,19 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>>   		}
>>   		break;
>>   	case BPF_FUNC_set_retval:
>> +	{
>> +		struct bpf_retval_range range = {
>> +			.minval = -MAX_ERRNO,
>> +			.maxval = 0,
>> +			.return_32bit = true
>> +		};
>> +		struct bpf_reg_state *r1 = &regs[BPF_REG_1];
>> +
>> +		if (r1->type != SCALAR_VALUE) {
>> +			verbose(env, "R1 is not a scalar\n");
>> +			return -EINVAL;
>> +		}
>> +
>>   		if (prog_type == BPF_PROG_TYPE_LSM &&
>>   		    env->prog->expected_attach_type == BPF_LSM_CGROUP) {
>>   			if (!env->prog->aux->attach_func_proto->type) {
>> @@ -10469,8 +10482,16 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>>   				verbose(env, "BPF_LSM_CGROUP that attach to void LSM hooks can't modify return value!\n");
>>   				return -EINVAL;
>>   			}
>> +			bpf_lsm_get_retval_range(env->prog, &range);
>>   		}
>> +
>> +		if (!retval_range_within(range, r1)) {
>> +			verbose_invalid_scalar(env, r1, range, "At bpf_set_retval", "R1");
>> +			return -EINVAL;
>> +		}
>> +
> 
> Because bpf_set_retval() takes ARG_ANYTHING, does this bounds check need
> a call to mark_chain_precision(env, BPF_REG_1) to prevent a state pruning
> regression?
> 
> Since ARG_ANYTHING doesn't automatically mark the register as precise in
> check_func_arg(), it looks like the verifier's state pruning logic in
> regsafe() might treat this register as equivalent to any other scalar
> value if it remains imprecise.
> 
> Could this allow a program with two branches to bypass this bounds check?
> If a safe branch (e.g., passing 0) is explored first and saved with an
> imprecise R1, the verifier might prune an unsafe branch (e.g., passing 1)
> because it matches the imprecise scalar state.
> 
> This would skip the bounds check on the unsafe branch and potentially
> allow the exact bypass issue this patch is trying to fix.
> 
> Reference: https://lore.kernel.org/bpf/20260530063315.7C5D41F00893@smtp.kernel.org/
>

Confirmed with the following PoC:

SEC("scgroup/sock_create")
__naked int sock_create_prog(void *ctx)
{
	asm volatile(
		"call %[bpf_get_prandom_u32];"
		"if r0 != 0 goto 1f;"
		"r0 = r0;"
		"r0 = r0;"
		"r0 = r0;"
		"r0 = r0;"
		"r0 = r0;"
		"goto 2f;"
	"1:"
		"call %[bpf_get_prandom_u32];"
	"2:"
		"r1 = r0;"
		"call %[bpf_set_retval];"
		"r0 = 1;"
		"exit;"
		: : __imm(bpf_get_prandom_u32), __imm(bpf_set_retval)
	);
}

Will fix it and add the PoC to the test in the next version.

>>   		break;
>> +	}
> 
> [ ... ]
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26677028117

