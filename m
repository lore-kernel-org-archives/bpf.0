Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B633737F8DF;
	Mon,  1 Jun 2026 13:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780319126; cv=none; b=rG+34iU6ObadnW2vk3HICYdXsWkPIXNY9219wjlUPh/Vkwz1Xu+ePLg0ufnr9kIyy26RuAIv2oldQmpaSrerdseOi6Efd4Cosb8zwhAyrZVflZnaxKPkrVFvftONvcUv3vFN4U7gb4jxcB/3k7/FcG7tUtNtQCNrYee5dGdP8wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780319126; c=relaxed/simple;
	bh=2/R613YUPTn1SaWMTKHDygqFsinVJKt/haPmengtawk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rbxY9OSyOxdrGklVLU7r80khTwME47PrqtL5201ANl6fQXWyPc2YHVkf7K82taMhOxzBzhxBsToK7oRCNjMUPyFfwdH8YAIRTbrocunrHgcARMLf8lH6fTIfKAbV6nUMvlFkAmcR+hxnmiWh3FBvyGpfQNqwtCqD33S/xOoghUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gTZ1h4xghzKHMlK;
	Mon,  1 Jun 2026 21:04:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 61BBD4056F;
	Mon,  1 Jun 2026 21:05:19 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP1 (Coremail) with SMTP id cCh0CgC3uj+Ogx1qGMb5AA--.59518S2;
	Mon, 01 Jun 2026 21:05:19 +0800 (CST)
Message-ID: <02e352e5-9680-4d83-8308-9988a0d0d8df@huaweicloud.com>
Date: Mon, 1 Jun 2026 21:05:18 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v3 2/3] selftests/bpf: Fix cgroup bpf tests broken by
 bpf_set_retval validation
Content-Language: en-US
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Yonghong Song <yonghong.song@linux.dev>, Stanislav Fomichev
 <sdf@fomichev.me>, YiFei Zhu <zhuyifei@google.com>,
 Matt Bobrowski <mattbobrowski@google.com>,
 Quan Sun <2022090917019@std.uestc.edu.cn>
References: <20260530101239.590395-1-xukuohai@huaweicloud.com>
 <20260530101239.590395-3-xukuohai@huaweicloud.com>
 <DIXH3R3D33MX.125DN9V9BR7QX@etsalapatis.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <DIXH3R3D33MX.125DN9V9BR7QX@etsalapatis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgC3uj+Ogx1qGMb5AA--.59518S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CFWUJFyfuF1UKw4fAw1UKFg_yoW8tFWfpa
	s7AFyqyws5Cr17Ja1xXrsFvFySqwsagrWYkr18Xw1UZw13J3s7Jr1xKF4YgF9IvrZa9wsx
	uaySgas3ZF48X3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUb
	mii3UUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 6/1/2026 1:45 PM, Emil Tsalapatis wrote:
> On Sat May 30, 2026 at 6:12 AM EDT, Xu Kuohai wrote:
>> From: Xu Kuohai <xukuohai@huawei.com>
>>
>> Add explicit return value checks for cgroup bpf progs rejected by the
>> bpf_set_retval validation.
>>
>> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> 
> Since these tests are breaking with patch 1 you should put this patch
> before them to avoid the breakage in the first place.
>

Makes sense, thanks.

>> ---
>>   .../selftests/bpf/progs/cgroup_getset_retval_hooks.c        | 6 +++++-
>>   tools/testing/selftests/bpf/progs/sk_bypass_prot_mem.c      | 2 ++
>>   2 files changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/bpf/progs/cgroup_getset_retval_hooks.c b/tools/testing/selftests/bpf/progs/cgroup_getset_retval_hooks.c
>> index 13dfb4bbfd28..c0bfa2d12dc7 100644
>> --- a/tools/testing/selftests/bpf/progs/cgroup_getset_retval_hooks.c
>> +++ b/tools/testing/selftests/bpf/progs/cgroup_getset_retval_hooks.c
>> @@ -2,12 +2,16 @@
>>   
>>   #include <linux/bpf.h>
>>   #include <bpf/bpf_helpers.h>
>> +#include <errno.h>
>> +#include "err.h"
>>   
>>   #define BPF_RETVAL_HOOK(name, section, ctx, expected_err) \
>>   	__attribute__((__section__("?" section))) \
>>   	int name(struct ctx *_ctx) \
>>   	{ \
>> -		bpf_set_retval(bpf_get_retval()); \
>> +		int val = bpf_get_retval(); \
>> +		set_if_not_errno_or_zero(val, -EFAULT); \
>> +		bpf_set_retval(val); \
>>   		return 1; \
>>   	}
>>   
>> diff --git a/tools/testing/selftests/bpf/progs/sk_bypass_prot_mem.c b/tools/testing/selftests/bpf/progs/sk_bypass_prot_mem.c
>> index 09a00d11ffcc..bae5283fca6b 100644
>> --- a/tools/testing/selftests/bpf/progs/sk_bypass_prot_mem.c
>> +++ b/tools/testing/selftests/bpf/progs/sk_bypass_prot_mem.c
>> @@ -5,6 +5,7 @@
>>   #include <bpf/bpf_helpers.h>
>>   #include <bpf/bpf_tracing.h>
>>   #include <errno.h>
>> +#include "err.h"
>>   
>>   extern int tcp_memory_per_cpu_fw_alloc __ksym;
>>   extern int udp_memory_per_cpu_fw_alloc __ksym;
>> @@ -97,6 +98,7 @@ int sock_create(struct bpf_sock *ctx)
>>   	return 1;
>>   
>>   err:
>> +	set_if_not_errno_or_zero(err, -EFAULT);
>>   	bpf_set_retval(err);
>>   	return 0;
>>   }

