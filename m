Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008FF1DED4C;
	Fri, 13 Mar 2026 02:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773369148; cv=none; b=ZGepfqpL5fW0lWh81sygzktIcCQftyZFcU809QF8h8iQsUQScwcNChhI1OV3uMDmZepVvs3eobuhu3ap8LB1ilSBcO3TmLs5K8I7iQX4FEmIzHcXycfWJ7StxOz4jiBa8hXgZ8B2D4T3OjmHZ7Ak1Q396tWVS1k64HXIvMdy65I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773369148; c=relaxed/simple;
	bh=+vI6GSqtwKt0b9wsTQmOg3llRDsB0LamegMG9/0fPN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kuoSnQjL8+EKQfNzicVWv6ASiLKCX/ax9ILuq71UKHidEbXej7BZL/H27IYYw6apAy6+aZkgxSfSz2DEg25Yy/3fWQDBC0pkJjJGPvbZLVN9QTB0vgXVypmg7CuovVn7UHBJJWfmUk9a3vbAV0s1fnByvau8rK12eXuqXRDT+nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fX7lm2DMRzYQtvD;
	Fri, 13 Mar 2026 10:31:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 68FA24058F;
	Fri, 13 Mar 2026 10:32:22 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP4 (Coremail) with SMTP id gCh0CgCngEs0d7NpbWnZAg--.21976S2;
	Fri, 13 Mar 2026 10:32:21 +0800 (CST)
Message-ID: <6538d913-7341-47bb-8717-3ef8685caf5d@huaweicloud.com>
Date: Fri, 13 Mar 2026 10:32:20 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v9 1/5] bpf: Move constants blinding out of
 arch-specific JITs
Content-Language: en-US
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, yonghong.song@linux.dev,
 puranjay@kernel.org, a.s.protopopov@gmail.com, alexis.lothore@bootlin.com,
 list+bpf@vahedi.org, linux@armlinux.org.uk, yangtiezhu@loongson.cn,
 hengqi.chen@gmail.com, johan.almbladh@anyfinetworks.com,
 paulburton@kernel.org, hbathini@linux.ibm.com, chleroy@kernel.org,
 naveen@kernel.org, luke.r.nels@gmail.com, xi.wang@gmail.com,
 bjorn@kernel.org, pulehui@huawei.com, iii@linux.ibm.com, hca@linux.ibm.com,
 gor@linux.ibm.com, davem@davemloft.net, udknight@gmail.com,
 martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev
References: <20260312170255.3427799-2-xukuohai@huaweicloud.com>
 <23f4b038b245167ff440b79c0a445fcbc12e0a102884759623dd59b3d64d2ade@mail.kernel.org>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <23f4b038b245167ff440b79c0a445fcbc12e0a102884759623dd59b3d64d2ade@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCngEs0d7NpbWnZAg--.21976S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJFWUKrWDWFWfKw4DtFW3GFg_yoW5AF4rpa
	y0gFWkKF4qqF40qw17ZFWkAFW3tF4kJwnrGr45Wa43JF4jgrn3GF18KrsYvFWYkrykKr1I
	vr4j9r98uw1DJFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26rWY6Fy7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWrXVW8
	Jr1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUVZ2-UUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 3/13/2026 1:50 AM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 4fbacd2149cd..3ccefd13121b 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
> 
> [ ... ]
> 
>> @@ -22843,17 +22843,23 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
>>
>>   static int jit_subprogs(struct bpf_verifier_env *env)
>>   {
>> -	struct bpf_prog *prog = env->prog, **func, *tmp;
>> +	struct bpf_prog *orig_prog = env->prog, *prog, **func, *tmp;
>>   	int i, j, subprog_start, subprog_end = 0, len, subprog;
>>   	struct bpf_map *map_ptr;
>>   	struct bpf_insn *insn;
>>   	void *old_bpf_func;
>>   	int err, num_exentries;
>> -	int old_len, subprog_start_adjustment = 0;
>> +	bool blinded = false;
>>
>>   	if (env->subprog_cnt <= 1)
>>   		return 0;
>>
>> +	prog = bpf_jit_blind_constants(env, NULL);
>> +	if (IS_ERR(prog))
>> +		return -ENOMEM;
>> +	if (prog != orig_prog)
>> +		blinded = true;
> 
> When env is non-NULL, bpf_jit_blind_constants() uses
> bpf_patch_insn_data() to insert blinding instructions.
> bpf_patch_insn_data() calls adjust_insn_aux_data(), which expands
> and shifts entries in env->insn_aux_data to match the now-longer
> blinded program.
> 
>> +
>>   	for (i = 0, insn = prog->insnsi; i < prog->len; i++, insn++) {
> 
> [ ... ]
> 
>> @@ -23114,6 +23122,10 @@ static int jit_subprogs(struct bpf_verifier_env *env)
>>   	}
>>   	kfree(func);
>>   out_undo_insn:
>> +	if (blinded) {
>> +		bpf_jit_prog_release_other(orig_prog, prog);
>> +		env->prog = prog = orig_prog;
>> +	}
>>   	/* cleanup main prog to be interpreted */
>>   	prog->jit_requested = 0;
>>   	prog->blinding_requested = 0;
>> +	for (i = 0, insn = prog->insnsi; i < prog->len; i++, insn++) {
>>   		if (!bpf_pseudo_call(insn))
>>   			continue;
>>   		insn->off = 0;
>>   		insn->imm = env->insn_aux_data[i].call_imm;
>>   	}
> 
> After bpf_jit_prog_release_other() reverts to orig_prog, this loop
> iterates using the original program's indices and length. However,
> env->insn_aux_data was expanded and shifted by bpf_patch_insn_data()
> during blinding to match the blinded program's instruction count.
> 
> The call_imm values were saved at blinded indices (earlier in
> jit_subprogs, after the bpf_jit_blind_constants call), so reading
> them back at original indices gets the wrong aux data entries.
> 
> On !CONFIG_BPF_JIT_ALWAYS_ON configs, could this cause incorrect
> imm values to be restored into pseudo_call instructions, breaking
> interpreter fallback?
> 

Right, I overlooked that insn_aux_data is used here. In fact, when
blinded is true, we have rolled back to the clean, original program,
so there is no need to restore call_imm.

> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23013190773

