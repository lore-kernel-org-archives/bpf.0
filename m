Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F71F370D52;
	Wed,  4 Mar 2026 12:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772626929; cv=none; b=bXBJojmksXOwq7Q8KswMOfsdkQWfK/FRWb1QOtBgynFv2s0mPySX4lNYsyZtpu5yGntrWK8EYkvALvtc4M8hZOdkkn0sbB0IRTpae+JFs0X43ryABZ4DjqwF8CPh2Q3rp0Lu8l4pYvgQZ1C0zsrxdoE78MY680MoyC3fq5boCLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772626929; c=relaxed/simple;
	bh=bNrf1uusVNba0v6WbtQO3V0M9aaJrKd456+6pAO8AJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lz2rKtNaWbKBOsqsBHRvLJrs9tj4xVTokfI2yHVO7Ia5e7j6O0EUiTlVGDRibVvIqTU5LdxeeUxXkBq9HUcBvvqYDg9L4FgaDgXZ8fYWeRwEe5BYcLfHkqAionjnpOt7lwcvIidzMBo4Gi3sDW6JDptyYDuA3GdJoOs6RseAGvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fQsGb2vVyzYQtrM;
	Wed,  4 Mar 2026 20:21:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id EC07C4056F;
	Wed,  4 Mar 2026 20:22:02 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP3 (Coremail) with SMTP id _Ch0CgAHVhTpI6hphl9kJQ--.9342S2;
	Wed, 04 Mar 2026 20:22:02 +0800 (CST)
Message-ID: <cdf7451e-a4af-44ba-9a65-db15ead46e75@huaweicloud.com>
Date: Wed, 4 Mar 2026 20:22:01 +0800
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
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Yonghong Song <yonghong.song@linux.dev>, Puranjay Mohan
 <puranjay@kernel.org>, Anton Protopopov <a.s.protopopov@gmail.com>
References: <20260302102726.1126019-1-xukuohai@huaweicloud.com>
 <20260302102726.1126019-2-xukuohai@huaweicloud.com>
 <fda9674c063db24cde39c2d97779e307943d4ba5.camel@gmail.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <fda9674c063db24cde39c2d97779e307943d4ba5.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgAHVhTpI6hphl9kJQ--.9342S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtFyrZry7Zw1kurWxWF45Wrg_yoWDtFc_uw
	sY9r1xuw4q93WxtFnxGr13Wr45Kr4vyFy0y34DWFZ3Jw4rGw45Xry0kF95ZF95GFyxKrZI
	yrnxWwn0qryfujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbx8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AK
	xVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UQ6p
	9UUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 3/4/2026 2:05 PM, Eduard Zingerman wrote:
> On Mon, 2026-03-02 at 18:27 +0800, Xu Kuohai wrote:
> 
> [...]
> 
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
> 
> I probably miss something important, but would it be possible to put a
> call to __bpf_prog_select_runtime() here and remove it from syscall.c:bpf_prog_load()?
> Thus avoiding the need for `jit_attempted` parameter.
>

Makes sense. In fact, at first I planned to move the whole thing to verifier,
but since this series is just fixing a JIT issue, I ultimately decided to only
move the JIT code to avoid unnecessary changes.

> [...]

