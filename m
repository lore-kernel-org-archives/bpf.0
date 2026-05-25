Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3EC3E4C95
	for <bpf@vger.kernel.org>; Mon, 25 May 2026 08:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779699444; cv=none; b=laDJ2sOpq/XeAvI+vqzabTvnVAa8v1H5hBH0BttKx2VSgTMQ1zEa5RMEsq+i8OPbq8WK9wG+DInBEcAhjVIpjAx/1OPndACMujjr0kjH5rtuEooYCE59AVUuiPAs3+Fzr+rgkh5b6HBufE/TJf447o16O/z4R26184BNvAfIi0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779699444; c=relaxed/simple;
	bh=f3qr2WAjwbp+8HoJQLYnFKf5OJ7xyLwrZfLvH+wZhg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O9D6xmYy70o+LoDUqHekuGzfXwsFGEtI6GoJD9v0tcxZhbkU7+g+5QVafPeywh26dXw19UhFZkZq6Y57kMcIl0+YvvmPTff817IdVRrApUhdYd16kD0vXJlq/InPkjFLCqPo4kssjnjRlfU6PJZFh+iqvOhEx9QKw8SHiqzcMoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gP8r53nqrzYQtkf
	for <bpf@vger.kernel.org>; Mon, 25 May 2026 16:56:21 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 2FCF240573
	for <bpf@vger.kernel.org>; Mon, 25 May 2026 16:57:14 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP3 (Coremail) with SMTP id _Ch0CgDnRS7oDhRqpvsNDg--.36805S2;
	Mon, 25 May 2026 16:57:14 +0800 (CST)
Message-ID: <e116eaee-b911-4ddd-a8e6-2054083af03d@huaweicloud.com>
Date: Mon, 25 May 2026 16:57:12 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf 1/2] bpf: Add return value check for BPF_LSM_CGROUP
Content-Language: en-US
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260523085806.417723-2-xukuohai@huaweicloud.com>
 <20260523094804.AE9DD1F000E9@smtp.kernel.org>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <20260523094804.AE9DD1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgDnRS7oDhRqpvsNDg--.36805S2
X-Coremail-Antispam: 1UD129KBjvJXoWxurykZF43Xry7Jr1xCw1Utrb_yoWrGF4Dpr
	Z3G390yr1DJFZFgwnrta1kZF1Fyr4UX3yrGr98Jr90van0qrWxJFyYgrWa934ayr48Cw1I
	qF4jva9Fva4UAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgqb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVj
	vjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 5/23/2026 5:48 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [High] The bounds validation for bpf_set_retval() can be bypassed by passing a pointer instead of a scalar, leading to the exact kernel panic the patch attempts to fix.
> 
> Pre-existing issues:
> - [High] Bounds enforcement is strictly restricted to BPF_PROG_TYPE_LSM, completely neglecting other vulnerable cgroup program types like BPF_PROG_TYPE_CGROUP_DEVICE.
> --
> 
> commit db7ea535b43831ef01a0cbacc405e0287e5dd010
> Author: Xu Kuohai <xukuohai@huawei.com>
> 
> bpf: Add return value check for BPF_LSM_CGROUP
> 
> This commit adds validation for the return value set by the bpf_set_retval()
> helper in BPF_LSM_CGROUP programs. It verifies that the provided argument
> falls within the valid return value range for the target hook to prevent
> kernel panics.
> 
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 7fb88e1cd7c4d..fe60a695de558 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -10462,6 +10462,9 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>>   	case BPF_FUNC_set_retval:
>>   		if (prog_type == BPF_PROG_TYPE_LSM &&
>>   		    env->prog->expected_attach_type == BPF_LSM_CGROUP) {
> 
> [Severity: High]
> This is a pre-existing issue, but does restricting this check to
> BPF_PROG_TYPE_LSM leave other cgroup program types vulnerable?
> 
> Programs like BPF_PROG_TYPE_CGROUP_DEVICE can also call bpf_set_retval()
> with arbitrary positive values. If such a program returns 1 (allow)
> after setting a positive return value like 1234, the value propagates
> through __cgroup_bpf_check_dev_permission() and bdev_permission(), causing
> bdev_file_open_by_dev() to return ERR_PTR(1234).
>
> Since 1234 is not a valid negative error code, IS_ERR() would return false,
> potentially leading to a kernel panic when the caller attempts to
> dereference 1234 as a file pointer.
>

Good catch! Confirmed with a PoC.

> Should we extend this validation to all cgroup program types?
> 

I think so, will do.

>> +			struct bpf_retval_range range;
>> +			struct bpf_reg_state *r1 = &regs[BPF_REG_1];
>> +
>>   			if (!env->prog->aux->attach_func_proto->type) {
>>   				/* Make sure programs that attach to void
>>   				 * hooks don't try to modify return value.
>> @@ -10469,6 +10472,13 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>>   				verbose(env, "BPF_LSM_CGROUP that attach to void LSM hooks can't modify return value!\n");
>>   				return -EINVAL;
>>   			}
>> +
>> +			bpf_lsm_get_retval_range(env->prog, &range);
>> +			range.return_32bit = true;
>> +			if (!retval_range_within(range, r1)) {
> 
> [Severity: High]
> Can this bounds check be bypassed if a pointer is passed instead of a scalar?
> 
> Because bpf_set_retval_proto uses ARG_ANYTHING, check_func_arg() allows
> pointer registers when env->allow_ptr_leaks is true (which is the case
> with CAP_BPF).
> 
> If a pointer like PTR_TO_STACK is passed without a variable offset,
> its s32_min_value and s32_max_value are both 0. Since 0 falls within the
> valid [-MAX_ERRNO, 0] range, retval_range_within() will allow it.
> 
> At runtime, the 64-bit pointer address would be truncated to a 32-bit integer,
> potentially yielding an arbitrary positive return value and causing the exact
> kernel panic this patch intends to fix.
> 
> Should the verifier explicitly ensure that R1 is a SCALAR_VALUE before
> validating its range?
>

Yes, will check if R1 is SCALAR in next version

>> +				verbose_invalid_scalar(env, r1, range, "At bpf_set_retval", "R1");
>> +				return -EINVAL;
>> +			}
>>   		}
>>   		break;
>>   	case BPF_FUNC_dynptr_data:
> 

