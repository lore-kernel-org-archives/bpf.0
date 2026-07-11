Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80042F39C7
	for <bpf@vger.kernel.org>; Sat, 11 Jul 2026 07:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783755593; cv=none; b=jBia/52Jv1fn/qgBep+gaRWTSCL/GZ+A5+cqVTPP/W6/2+VpyrnWUEUQiSIqitUlNEQJuP0kXkIF+bIsphVOV7BgtNA2kRFurGqWqao0tDRTRk+441tzuyXxg7wOfLcF8Uz1aF9MDO1lBofSTPYnDV+sFLYKIV/AX6os5AMYCB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783755593; c=relaxed/simple;
	bh=2RUymcIbxvQDys706y4njEZ/V9NBQGo48VnBGQUoF3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mrqoSUNBhz71ISYn2d/TRiyCA1fQngNjI3YNBk+iGlkSXILxCNqOXnoymOde98WMWx8It6j3F6/IKiShfXtwebR9/z3PoXLIgSfSsuPTbdH7WieHX24ymkl67jXYZ9NGAcVT94zw/bkwRknaEZF+dvBR8LnyvzmAwEvAItz1r5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gy0vp1428zYQtFR
	for <bpf@vger.kernel.org>; Sat, 11 Jul 2026 15:39:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id EDFB240578
	for <bpf@vger.kernel.org>; Sat, 11 Jul 2026 15:39:43 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgBXPCg+81FquH5PAw--.6S2;
	Sat, 11 Jul 2026 15:39:43 +0800 (CST)
Message-ID: <f4010090-babc-4d25-ac80-e0abee9cfcbe@huaweicloud.com>
Date: Sat, 11 Jul 2026 15:39:42 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/2] bpf: Remove unnecessary dup/restore
 subprog_starts and prog clone
Content-Language: en-US
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <cover.1783775928.git.xukuohai@huaweicloud.com>
 <329e83120f0d88c2e5dc9d7bb2c0d38988959d32.1783775928.git.xukuohai@huaweicloud.com>
 <20260711054000.BC62D1F000E9@smtp.kernel.org>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <20260711054000.BC62D1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgBXPCg+81FquH5PAw--.6S2
X-Coremail-Antispam: 1UD129KBjvJXoWxurykWFWfJF4fJw4DGF45KFg_yoW5CF18pF
	95Jry8CF4qqa1xtw47XF48CFWkJr40qw12kr48Ww17Jw1UWF93WF1xKw4SvF9xZry0kw4I
	vr4qv3sxWw1xuFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgmb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 7/11/2026 1:40 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Critical] Use-After-Free of `env->prog` in `bpf_fixup_call_args()` due to cached pointer being freed by `bpf_jit_blind_constants()`.
> --
> 
> --- Patch [2]: [PATCH bpf-next 2/2] bpf: Remove unnecessary dup/restore subprog_starts and prog clone ---
> commit bd1c64739bd8085adba51ce9687069c667da314d
> Author: Xu Kuohai <xukuohai@huawei.com>
> 
> bpf: Remove unnecessary dup/restore subprog_starts and prog clone
> 
> This commit removes unnecessary cloning of BPF programs and saving of
> subprog states when JIT is required. It skips these steps because the
> kernel will reject the program on JIT failure rather than falling back
> to the interpreter.
> 
>> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
>> index 37f22eb418540..80c8beb45ea04 100644
>> --- a/kernel/bpf/fixups.c
>> +++ b/kernel/bpf/fixups.c
> 
> [ ... ]
> 
>> @@ -1273,35 +1275,33 @@ static int jit_subprogs(struct bpf_verifier_env *env)
>>   int bpf_jit_subprogs(struct bpf_verifier_env *env)
>>   {
>>   	int err, i;
>> -	bool blinded = false;
>>   	struct bpf_insn *insn;
>>   	struct bpf_prog *prog, *orig_prog;
>> -	u32 *orig_subprog_starts;
>> +	u32 *orig_subprog_starts = NULL;
>> +	bool cloned = false;
>>   
>>   	if (env->subprog_cnt <= 1)
>>   		return 0;
>>   
>>   	prog = orig_prog = env->prog;
>>   	if (bpf_prog_need_blind(prog)) {
>> -		orig_subprog_starts = bpf_dup_subprog_starts(env);
>> -		if (!orig_subprog_starts) {
>> -			err = -ENOMEM;
>> -			goto out_cleanup;
>> +		if (!prog->jit_required) {
>> +			orig_subprog_starts = bpf_dup_subprog_starts(env);
>> +			if (!orig_subprog_starts) {
>> +				err = -ENOMEM;
>> +				goto out_cleanup;
>> +			}
>>   		}
>> -		prog = bpf_jit_blind_constants(env, prog);
>> -		if (IS_ERR(prog)) {
>> -			err = -ENOMEM;
>> -			prog = orig_prog;
>> +		err = bpf_jit_blind_constants(env, &prog, !prog->jit_required, &cloned);
>> +		if (err)
>>   			goto out_restore;
> 
> [Severity: Critical]
> Can this lead to a use-after-free if bpf_jit_blind_constants() reallocates
> the program?
> 
> When prog->jit_required is true, we pass false for the clone_needed parameter.
> This means bpf_jit_blind_constants() modifies the original program directly.
> 
> If a patch requires expansion, bpf_patch_insn_data() triggers
> bpf_prog_realloc(), which allocates a new program structure and frees the
> original one.
> 
> If functions higher up in the call stack have cached the env->prog pointer
> before JIT processing, won't they be left with a dangling pointer? For
> example, in bpf_fixup_call_args():
> 
> kernel/bpf/fixups.c:bpf_fixup_call_args() {
>      struct bpf_prog *prog = env->prog;
>      struct bpf_insn *insn = prog->insnsi;
>      
>      ...
>      
>      if (prog->jit_required) {
>          verbose(env, "program requires BPF JIT compiler...\n");
>          ...
>      }
> }
> 
> If an error occurs and triggers this fallback path, does it end up
> dereferencing the freed prog pointer?

Yes, the local prog variable should be refreshed.

