Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF011D61BC
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 13:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780319077; cv=none; b=MYK7fkXF2Tq3dI9vZqJjiVGFHokqGQ0AX4bMlIgqg56d8V+eVj5+NxBv8tPj0R6aTKkCpdyiS//TEJBrpDcCIP01gylB5XGbFj6fP8iKvveGC1nb2mzi+sj7l+CEnGtFoOoUAcKNn7W3bOgeqgYQx1D+J21WoxPA8ZJ2KHlsvJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780319077; c=relaxed/simple;
	bh=WNdofKcKlfLkAe8zSEMRHgfRMf9TYKppR/HUZHqktFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MWMIhFYNwV5edxZR6eiOFZsFR9RSRde6a4KzQDVqgqomlsRhL5pKt3oKc+7ktRS85ehA5TPUDPnyrVOPsRTw6gy0PKiyL+X9g5uFUgepOMAg0WqHRYnC/r2uDwa+Z0UwHEiqYXO7x+t8R7M4qg7W6YOvXorb8wbqZ30I5196GDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gTZ182RdxzYQtqK
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 21:04:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 8E7184057D
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 21:04:31 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP4 (Coremail) with SMTP id gCh0CgDHG4Bcgx1qL4L7AA--.22035S2;
	Mon, 01 Jun 2026 21:04:29 +0800 (CST)
Message-ID: <d67ce3b4-ccd4-40e0-993d-9d134e86a058@huaweicloud.com>
Date: Mon, 1 Jun 2026 21:04:28 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v3 1/3] bpf: Add validation for bpf_set_retval
 argument
Content-Language: en-US
To: Emil Tsalapatis <emil@etsalapatis.com>, sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260530101239.590395-2-xukuohai@huaweicloud.com>
 <20260530105334.8E8BA1F00893@smtp.kernel.org>
 <DIXH1O3E96VX.EYFDM9QIT6AD@etsalapatis.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <DIXH1O3E96VX.EYFDM9QIT6AD@etsalapatis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgDHG4Bcgx1qL4L7AA--.22035S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAw13tr1DKF17WFW5tF48Xrb_yoWruw15pr
	Z7Ga4Dtr1DtrW2gw47tan7A3WFyw4vqrsxGF95Gry3Ca90qF9rtFyUGw45ur93AF1DCw40
	qr4Y93ZIvas8Aa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgvb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIev
	Ja73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 6/1/2026 1:42 PM, Emil Tsalapatis wrote:
> On Sat May 30, 2026 at 6:53 AM EDT, sashiko-bot wrote:
>> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>> - [High] The strict bounds check added to `bpf_set_retval()` unconditionally rejects programs that pass unconstrained variables, such as the output of `bpf_get_retval()`, breaking backward compatibility for existing user programs.
>> - [High] Restricting `bpf_set_retval()` to `[-MAX_ERRNO, 0]` breaks `BPF_CGROUP_GETSOCKOPT` programs that legitimately return positive values.
>> --
>>
>> commit 822adc8377df563ad6f9bfabc65c87c7f98aaf52
>> Author: Xu Kuohai <xukuohai@huawei.com>
>>
>> bpf: Add validation for bpf_set_retval argument
>>
>> This commit adds validation to the bpf_set_retval helper to prevent
>> cgroup BPF programs from returning unexpected positive values, which can
>> cause wild pointer dereferences or bypass error checks. For BPF_LSM_CGROUP,
>> it enforces LSM-specific ranges. For other cgroup types, it restricts the
>> argument to [-MAX_ERRNO, 0].
>>
>> Link: https://lore.kernel.org/all/567d3206-74a5-44e5-99c6-779c425f399e@std.uestc.edu.cn
>>
>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>> index 7fb88e1cd7c4d..4948bd4bf9e16 100644
>>> --- a/kernel/bpf/verifier.c
>>> +++ b/kernel/bpf/verifier.c
>>> @@ -10460,6 +10460,19 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>>>   		}
>>>   		break;
>>>   	case BPF_FUNC_set_retval:
>>> +	{
>>> +		struct bpf_retval_range range = {
>>> +			.minval = -MAX_ERRNO,
>>> +			.maxval = 0,
>>> +			.return_32bit = true
>>> +		};
>>
>> [Severity: High]
>> Does this blanket restriction to 0 break BPF_CGROUP_GETSOCKOPT programs?
>>
>> Commit c4dcfdd406aa2167 ("bpf: Move getsockopt retval to struct
>> bpf_cg_run_ctx") removed the restriction that getsockopt filters must
>> return <= 0, noting that valid getsockopt handlers often return positive
>> values for the option length.
>>
>> Could this maxval = 0 limit prevent BPF_CGROUP_GETSOCKOPT programs from
>> legitimately returning positive lengths via bpf_set_retval?
>>
> 
> AFAICT the getsockopt manpage corroborates the issue, should be possible to
> account for this.
>

Yeah, the return value of BPF_CGROUP_GETSOCKOPT is not checked or consumed by
the kernel. It is returned to user directly as the return value of getsockopt().
So I think there is no risk to leave it unrestricted.

>>> +		struct bpf_reg_state *r1 = &regs[BPF_REG_1];
>>> +
>>> +		if (r1->type != SCALAR_VALUE) {
>>> +			verbose(env, "R1 is not a scalar\n");
>>> +			return -EINVAL;
>>> +		}
>>> +
>>
>> [ ... ]
>>
>>> @@ -10469,8 +10482,20 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>>> +		err = mark_chain_precision(env, BPF_REG_1);
>>> +		if (err)
>>> +			return err;
>>> +
>>> +		if (!retval_range_within(range, r1)) {
>>> +			verbose_invalid_scalar(env, r1, range, "At bpf_set_retval", "R1");
>>> +			return -EINVAL;
>>> +		}
>>
>> [Severity: High]
>> Will this strict bounds check unconditionally reject programs that pass
>> unconstrained variables, such as the output of bpf_get_retval?
>>
>> The helper bpf_get_retval returns an int which is tracked by the verifier
>> as an unknown scalar. If this unconstrained scalar is passed directly to
>> bpf_set_retval, it is checked against the newly hardcoded [-MAX_ERRNO, 0]
>> range.
>>
>> Since the unknown bounds fall outside this narrow range, the verifier will
>> reject the program at load time.
>>
>> Could this break backward compatibility for existing user programs relying
>> on the bpf_set_retval(bpf_get_retval()) pattern?
> 
> "Backward compatibility" is definitely the wrong way to put this
> considering past behavior was buggy. The only alternative I can see is
> checking the return value dynamically in the helper itself and returning
> failure if the attempted value is illegal, and that is an even bigger
> change in behavior. Programs can add bounds checking to get_retval to
> handle this.

For cgroup bpf types other than BPF_CGROUP_GETSOCKOPT, the initial retval
is always set to 0. Since the retval can only be set by bpf_set_retval(),
and this patch restricts it to range [-MAX_ERRNO, 0], we can conclude that
bpf_get_retval() always returns value in the same range for these bpf types.

So I think it is OK to refine the return value of bpf_get_retval() to range
[-MAX_ERRNO, 0] for non-BPF_CGROUP_GETSOCKOPT types in the verifier.

