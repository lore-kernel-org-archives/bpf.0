Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E677C3750DA;
	Tue,  3 Mar 2026 02:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772504918; cv=none; b=qr38/nbOJDsxCvkrPDYQU4a7Buemk8jEnw/i/A1lvxD6HESJXzoYa42YrDcn41kH/NoGTly8eqRZ8mDswNI0HE6OyR2mSE1mVrtjeAZjngIuw/UmeiK3qlLLbZNzBphevhAokxbxPp6arS2kDW8cXAPWThiUqP3bvqyFG/8XC/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772504918; c=relaxed/simple;
	bh=HMoF9fJL5K58JJ1olw4rfmD8Lhzxr47kFv5DmeFlLRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FWIhTrmYixnIWJ+tR0DHVE6Lsbx+LSOwKbGAEgNWR+zVWDtdDosqPHaAe3LXD70NLRHxscAz/EE6Z0RCqBK0vpUhoOpUPID1O2PW1VItCpCopTToLcjBN5XCRc53NakPj2H+TIEpWCTuzMxMTryjlghHvTVFUAoyMfn6/sYoK6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fQ08s5pJjzKHMYP;
	Tue,  3 Mar 2026 10:28:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 842F34058F;
	Tue,  3 Mar 2026 10:28:33 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP4 (Coremail) with SMTP id gCh0CgAniPhQR6ZpdniDJQ--.4204S2;
	Tue, 03 Mar 2026 10:28:33 +0800 (CST)
Message-ID: <770fef28-efd7-4bcb-aa11-33ab22cc9841@huaweicloud.com>
Date: Tue, 3 Mar 2026 10:28:32 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 1/5] bpf: Move JIT for single-subprog programs
 to verifier
Content-Language: en-US
To: bot+bpf-ci@kernel.org, xukuohai@huaweicloud.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, yonghong.song@linux.dev,
 puranjay@kernel.org, a.s.protopopov@gmail.com, martin.lau@kernel.org,
 clm@meta.com, ihor.solodrai@linux.dev
References: <20260302102726.1126019-2-xukuohai@huaweicloud.com>
 <cae8a7cfe54f2f1f66bde10df2026eb2c1076998bef9e483b513abd3bb5722c3@mail.kernel.org>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <cae8a7cfe54f2f1f66bde10df2026eb2c1076998bef9e483b513abd3bb5722c3@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgAniPhQR6ZpdniDJQ--.4204S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCFyrCry3Jr15ZFyDtrWrXwb_yoW5AFykpa
	s7KFWDCr4UGr1DtwnFyFWDZaySqa1rG3y7G3Z8JFWI9rnYgrnYgFW0ga1jgF90yr1Ykwsa
	va1jvrWqqr15ZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
	evJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 3/2/2026 6:46 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index fc4ccd1de569..ab2bc0850770 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -26086,6 +26086,11 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
>>   		convert_pseudo_ld_imm64(env);
>>   	}
>>
>> +	/* constants blinding in the JIT may increase prog->len */
>> +	len = env->prog->len;
>> +	if (env->subprog_cnt == 1)
>> +		env->prog = bpf_prog_select_jit(env->prog, &ret);
>> +
>>   	adjust_btf_func(env);
>>
>>   err_release_maps:
> 
> [ ... ]
> 
>> @@ -26111,7 +26116,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
>>   err_unlock:
>>   	if (!is_priv)
>>   		mutex_unlock(&bpf_verifier_lock);
>> -	clear_insn_aux_data(env, 0, env->prog->len);
>> +	clear_insn_aux_data(env, 0, len);
>>   	vfree(env->insn_aux_data);
> 
> Can the len variable be stale when reaching clear_insn_aux_data()
> through an error path?
> 
> At the top of bpf_check(), len is first assigned as:
> 
>      len = (*prog)->len;
> 
> This original value is used to allocate insn_aux_data. Later,
> instruction rewriting passes like convert_ctx_accesses() and
> do_misc_fixups() can change env->prog->len and resize
> insn_aux_data to match via bpf_patch_insn_data().
> 
> The second assignment added by this patch:
> 
>      len = env->prog->len;
> 
> is only reached on the success path, after all instruction
> rewriting and after the maps/btfs allocation. If an error occurs
> between the rewriting passes and this reassignment, for example
> bpf_vlog_finalize() returning an error, copy_to_bpfptr_offset()
> failing, or kmalloc for used_maps/used_btfs failing, the code
> jumps to err_release_maps and eventually reaches
> clear_insn_aux_data(env, 0, len) with the original program length
> rather than the current post-rewriting length.
> 
> If rewriting increased env->prog->len (the common case for
> programs with context accesses), the iteration stops short of
> the actual insn_aux_data size, potentially leaking jt fields in
> the unvisited entries.
> 

Right, len is stale in the error path. I'll fix it in the next version.

> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22571297111
> 
> AI-authorship-score: low
> AI-authorship-explanation: Standard kernel refactoring by a known BPF contributor with non-native English patterns in the commit message.
> issues-found: 1
> issue-severity-score: low
> issue-severity-explanation: Stale len variable in bpf_check error paths can cause insn_aux_data jt field memory leaks when instruction rewriting changed prog->len before an error between rewriting and the len reassignment.

