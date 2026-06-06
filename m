Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7B6327BFC;
	Sat,  6 Jun 2026 10:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780740173; cv=none; b=B+7xuAC+lnw6pvTppKsp40id9n/T4D1xv3aXMGqn9+zdazwM0WR1Hi4D1Brw8vSy3aBDFxkkoyoClxLqhk+Q35tHMmdla4E/uLrl+cIZel6uiZ6Vgn9VHcRHfGK6PvSewDUWtCfKTcWztfLVzBQKbCGE3q28FbCAB8vUnaYibu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780740173; c=relaxed/simple;
	bh=mnVJlo2ryhLpfOvFaLz8ysaSPtY55fwilz7NYfh6fRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SXQ7IqZzGRmsbM54vqYYaUuwEQEBcNSdiQ2cbKLNuf1R5PXWez/GfBM/XVxWb2gtjT6LrxW1xHg8SCt0RbRwZSglE3eiWSWAFrxl5YwmxSfuY7cp2QyyvEHb+sDhn8KIQ0EG1CPMc1IX5sg4MDQ9hY6o5HZqlXu6YNEQ/Xu/Ai0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gXYkY1WwYzKHMY0;
	Sat,  6 Jun 2026 18:02:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id B6E2440562;
	Sat,  6 Jun 2026 18:02:43 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP2 (Coremail) with SMTP id Syh0CgBHvIFA8CNqeKBGAw--.36613S2;
	Sat, 06 Jun 2026 18:02:41 +0800 (CST)
Message-ID: <84823ae5-a65f-4dec-9718-950be4fbb562@huaweicloud.com>
Date: Sat, 6 Jun 2026 18:02:40 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 2/3] bpf: Add validation for bpf_set_retval
 argument
Content-Language: en-US
To: bot+bpf-ci@kernel.org, xukuohai@huaweicloud.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com,
 yonghong.song@linux.dev, sdf@fomichev.me, zhuyifei@google.com,
 mattbobrowski@google.com, 2022090917019@std.uestc.edu.cn,
 martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev
References: <20260605140243.664590-3-xukuohai@huaweicloud.com>
 <8c3468a91bbfac22f819b0ac7f1307de0bb5bec062229b36387550e05807e485@mail.kernel.org>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <8c3468a91bbfac22f819b0ac7f1307de0bb5bec062229b36387550e05807e485@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgBHvIFA8CNqeKBGAw--.36613S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCrW7WFWxuw4rZF45ZryrWFg_yoW5Xr15pF
	4kGrWDJr1DZr1a93y7Krs7Zr40yw1qq3yfCFn8GwnFyanIvwn3tryUWF4agFyavF95Wr40
	kF4j9ws29FWqvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvE14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
	evJa73UjIFyTuYvjTRNJ5oDUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 6/5/2026 11:19 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 8ed484cb1a8a..a50280bb0d45 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -9790,6 +9792,29 @@ static int do_refine_retval_range(struct bpf_verifier_env *env,
>>   		reg_set_urange32(ret_reg, 0, nr_cpu_ids - 1);
>>   		reg_bounds_sync(ret_reg);
>>   		break;
>> +	case BPF_FUNC_get_retval:
>> +		/*
>> +		 * bpf_get_retval may see arbitrary value passed by bpf_prog_run_array_cg for
>> +		 * CGROUP_GETSOCKOPT type.
>> +		 */
>> +		if (prog_type == BPF_PROG_TYPE_CGROUP_SOCKOPT &&
>> +		    env->prog->expected_attach_type == BPF_CGROUP_GETSOCKOPT)
>> +			break;
>> +
>> +		if (prog_type == BPF_PROG_TYPE_LSM &&
>> +		    env->prog->expected_attach_type == BPF_LSM_CGROUP) {
>> +			if (!env->prog->aux->attach_func_proto->type)
>> +				break;
>> +			bpf_lsm_get_retval_range(env->prog, &range);
> 
> For a boolean LSM hook, bpf_lsm_get_retval_range() returns the range
> [0, 1], and this code refines the bpf_get_retval() return register to
> that range.
> 
> Can that static range be violated at runtime when multiple programs are
> attached to the same cgroup hook with BPF_F_ALLOW_MULTI?
> 
> In bpf_prog_run_array_cg(), if an earlier program returns 0 the retval
> is translated to an error:
> 
> 	if (!func_ret && !IS_ERR_VALUE((long)run_ctx.retval))
> 		run_ctx.retval = -EPERM;
> 
> A later program that calls bpf_get_retval() would then receive -EPERM
> (-1) at runtime, which is outside the [0, 1] range the verifier assumed
> here.
> 
> Does this static-versus-runtime mismatch let the verifier reason about
> bounds that the value can actually fall outside of?
> 
> This was raised on the v5 posting and does not appear to have a reply
> yet:
> 
>    https://lore.kernel.org/bpf/20260605144232.95A141F00893@smtp.kernel.org/
> 

Yes, returning -EPERM for a boolean hook breaks the verifier assumption.
I will create a follow-up patch to fix it, as the current patchset has
already been applied.

>> +		} else {
>> +			range.minval = -MAX_ERRNO;
>> +			range.maxval = 0;
>> +		}
>> +
>> +		reg_set_srange64(ret_reg, range.minval, range.maxval);
>> +		reg_set_srange32(ret_reg, range.minval, range.maxval);
>> +		reg_bounds_sync(ret_reg);
>> +		break;
>>   	}
>>
>>   	return reg_bounds_sanity_check(env, ret_reg, "retval");
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27021279696

