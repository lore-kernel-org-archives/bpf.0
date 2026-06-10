Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF72228FFF6
	for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 13:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781097980; cv=none; b=Bz51WgZ5xp9Rj6d/i6NMtnMu12Icv4qW0YS/OTQInoJXI/4fnDZVGjUqaw/4Qri57Vef8Fl4gxxmvnbgWjypjR5FhjBw+du81flGD8QWW3uWnlDi83oTapZZjaDUd7lzlucv5HoOmJxFngmBuBUchbFhKTUBipvWJX4L0b99Cu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781097980; c=relaxed/simple;
	bh=6P+H/HQ+8mnb3tkMt2N8IGh0Zs45/Ss0T+8CYdzKf2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y8bNxqMIIc/rcPwybp6PrdGfZQX7+aLbySKp/WQkrwKkv+P7648manxoHIqkqRUnbOQNIOANO4HdUqxkHiil3QT4/hR/iGU7V39KWXc9uiljnTU8R+YkLc3+dZom4xz+DWsgGSrGIPapLJIu4AVXdMHooigV3AQFMfh+3pOo/jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gb63K6YFPzKHLx7
	for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 21:25:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 177D740539
	for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 21:26:11 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP1 (Coremail) with SMTP id cCh0CgA3Oj_xZSlqU_U3BQ--.31492S2;
	Wed, 10 Jun 2026 21:26:11 +0800 (CST)
Message-ID: <2a7af5be-17b9-4357-8955-5497aa6fce1a@huaweicloud.com>
Date: Wed, 10 Jun 2026 21:26:09 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/2] bpf: Fix setting retval to -EPERM for cgroup
 hooks not returning errno
Content-Language: en-US
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260610201724.733943-2-xukuohai@huaweicloud.com>
 <20260610124544.3EE211F00898@smtp.kernel.org>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <20260610124544.3EE211F00898@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgA3Oj_xZSlqU_U3BQ--.31492S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuryDGr43Jr4rWr43AF48tFb_yoW5Ar1UpF
	43AFZ8Gw4qgrZrG34kJ3y0vw4Fyrs5try5Xr1DXr1xZa9xXrW7JryIqryY9ayavr4Igr1S
	vFWYvFZakas0ya7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgmb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 6/10/2026 8:45 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] The patch breaks cgroup BPF boolean LSM hooks by ignoring a BPF program's denial (exit code 0). It leaves `run_ctx.retval` unmodified for boolean hooks, which fails to enforce denials, ignores overrides from previous programs in the cgroup array, and causes the trampoline to incorrectly fall back to the original kernel function.
> --
> 
> commit b6b16c6bf2bc0b50b22feebf85585b33ce70965a
> Author: Xu Kuohai <xukuohai@huawei.com>
> 
> bpf: Fix setting retval to -EPERM for cgroup hooks not returning errno
> 
> This commit modifies bpf_prog_run_array_cg() to avoid setting the hook return
> value to -EPERM when a cgroup BPF program exits with 0 for non-errno hooks
> (such as boolean or void LSM hooks).
> 
>> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
>> index 35d1f1428ef39..83ce66296ac19 100644
>> --- a/kernel/bpf/cgroup.c
>> +++ b/kernel/bpf/cgroup.c
> 
> [ ... ]
> 
>> @@ -83,7 +105,8 @@ bpf_prog_run_array_cg(const struct cgroup_bpf *cgrp,
>>   			*(ret_flags) |= (func_ret >> 1);
>>   			func_ret &= 1;
>>   		}
>> -		if (!func_ret && !IS_ERR_VALUE((long)run_ctx.retval))
>> +		if (!func_ret && cgroup_bpf_hook_returns_errno(atype) &&
>> +		    !IS_ERR_VALUE((long)run_ctx.retval))
>>   			run_ctx.retval = -EPERM;
> 
> [Severity: High]
> Could this change cause BPF program denials to be ignored for boolean hooks?
> 
> In cgroup BPF, a program returning 0 typically signifies a denial. By
> requiring cgroup_bpf_hook_returns_errno() to be true here, a func_ret of 0
> is ignored for boolean hooks, leaving run_ctx.retval unmodified.
> 
> If a prior program in the cgroup array called bpf_set_retval(1), and the
> current program returns 0 (denial), run_ctx.retval remains 1. Doesn't this
> break cgroup hierarchy semantics where a denial must override an allow?
> 
> Additionally, if run_ctx.retval remains 0, the fmod_ret trampoline interprets
> 0 as an instruction to call the original kernel function rather than skipping
> it. If the underlying kernel function returns 1, the operation ends up being
> allowed. Does this unintentionally bypass the BPF program's intent to deny
> the operation?
>

The key problem is that, boolean hooks do not have deny/allow semantics.

There are 3 boolean hooks, each has its own meaning of the return value:
1. inode_xattr_skipcap:  1 is "skip capability check", 0 is "not skip"
2. audit_rule_known:  1 is "rule is known", 0 is "rule not known"
3. xfrm_state_pol_flow_match: 1 is "match", 0 is "not match"

None of them has deny/allow semantics.

So for a boolean hook, we do not know whether 0 or 1 is the correct value
to translate the return value to when bpf prog exits with 0. I prefer to
not translate it at all, just leave the return value untouched.

>>   		item++;
>>   	}
> 

