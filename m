Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16EF37DE9D
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 07:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784099588; cv=none; b=mR4cW2vX7i6+R6QmktR3E1O3FNqbDfNze+BgM7iKEpkcmZJ+SgrUk6JLYqiQ7z01LjreNMs7CATAGeH9fDxwVY5/WOr/X8/dx6h7jP0Q0Efa3WWm9y9QNPU2KYNiu3RapmZZi40PYO17XWkn5JEmNlkxE7w5riskUsaC1FfqmtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784099588; c=relaxed/simple;
	bh=9GnXkmZA6D4ZCZ//ji0b24bA4CjarR7CUrGGMoV1OIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cWXzeWHiXKPtmNgGTGPMRQQiUOeGXsvOl9WWXHS9FlMONAyKIt90F2h/loosZLnG9M5IGjnGNrx3AHRZv0nW/j+cKYeNJXM2O2WHbyazCahMYO5jF7IJmZM4q+dh+YCzHr0VxGXq20CWOZ24M2YOfHDTj18d6F2lCeW9wdbOlPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4h0S6x0s2fzYQtt1
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 15:12:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id BB20D4058F
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 15:12:57 +0800 (CST)
Received: from [10.67.110.68] (unknown [10.67.110.68])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgCn1lf4MldqC9E0BQ--.23688S2;
	Wed, 15 Jul 2026 15:12:57 +0800 (CST)
Message-ID: <3a08e895-606f-4b54-9c4a-2a500424afaa@huaweicloud.com>
Date: Wed, 15 Jul 2026 15:12:56 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Add testcase for callback
 with tailcall
Content-Language: en-US
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260714024459.420075-1-pulehui@huaweicloud.com>
 <20260714024459.420075-3-pulehui@huaweicloud.com>
 <20260714025320.200C71F000E9@smtp.kernel.org>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <20260714025320.200C71F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCn1lf4MldqC9E0BQ--.23688S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFW8uF13CFWxAF18WFWktFb_yoW8ury8pF
	y5XwsFkayxWF17Ga47ZrWIkF4rtw4kXFyUtr48Kr90vrn29r97tFs7KrWjgF9xK395K34r
	ZasFqrn3Aw4kX3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgmb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/


On 2026/7/14 10:53, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Out-of-bounds map index used in bpf_tail_call_static in the test program.
> --
> 
> --- Patch [2]: [PATCH bpf-next v2 2/2] selftests/bpf: Add testcase for callback with tailcall ---
> commit 6b7ff517c87bc3ed869da7118100965c0668a781
> Author: Pu Lehui <pulehui@huawei.com>
> 
> selftests/bpf: Add testcase for callback with tailcall
> 
> This commit adds a new BPF selftest to verify that a callback involving a
> subprogram with a tail call is properly rejected by the verifier.
> 
>> diff --git a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_callback.c b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_callback.c
>> new file mode 100644
>> index 0000000000000..dfe9c49cfeb1d
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_callback.c
>> @@ -0,0 +1,62 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +#include <linux/bpf.h>
>> +#include <bpf/bpf_helpers.h>
>> +#include "bpf_misc.h"
>> +#include "bpf_test_utils.h"
>> +
>> +int classifier_0(struct __sk_buff *skb);
>> +
>> +struct {
>> +	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
>> +	__uint(max_entries, 1);
>> +	__uint(key_size, sizeof(__u32));
>> +	__array(values, void (void));
>> +} jmp_table SEC(".maps") = {
>> +	.values = {
>> +		[0] = (void *) &classifier_0,
>> +	},
>> +};
>> +
>> +static __noinline
>> +int subprog_tail0(struct __sk_buff *skb)
>> +{
>> +	int ret = 0;
>> +
>> +	bpf_tail_call_static(skb, &jmp_table, 1);

my bad, it should be `0`

> 
> [Severity: Low]
> Does this code use an out-of-bounds index for the tail call? The jmp_table
> map has max_entries set to 1 and populates index 0 with classifier_0, but
> this bpf_tail_call_static() invocation uses index 1.
> 
> Even though this test is designed to be rejected by the verifier, should
> this pass index 0 to correctly match the intended tail call target?
> 
>> +	barrier_var(ret);
>> +	return ret;
>> +}
> 
> [ ... ]
> 

