Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999642673B0
	for <bpf@vger.kernel.org>; Mon, 25 May 2026 01:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779674211; cv=none; b=Ls611TNbZCen9caNcsrZRFm+9J1Fo6LqLnpnyKutRP0/thOKETnVkLUobsuBlPKXb/M7wV2J1B3bUEBn7pgHcU0Ko1q8/zVBA4ANVFv0bszZakEEGJRcT5217qVrTDYsAUbqG+JzWna38ua2bB0pLEXTQr2gR9up/ct36NQXmD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779674211; c=relaxed/simple;
	bh=9ztzUzY3lo2vl57ZNqxmxWqjmadfsn/shYzhV69Hf8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XET1q75qTyhEptY97AbCHNa/MyW+L3UlbQnCFn6KbZwQRRJPWsdPCArEfIaY37G5xJIb6JF/rI18qHgHACj3JUfrQ7ouXzeIoVAxmtf0V09zMhFWbWNnoc0iCESPyEsezZknhJBxSEij506hrePG/V3Q8fg5SOzkrJJ2/mnnOVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gNzVv6B2SzYQtvr
	for <bpf@vger.kernel.org>; Mon, 25 May 2026 09:55:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 0BCB540573
	for <bpf@vger.kernel.org>; Mon, 25 May 2026 09:56:44 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP4 (Coremail) with SMTP id gCh0CgCnblparBNqTQAkDg--.32696S2;
	Mon, 25 May 2026 09:56:44 +0800 (CST)
Message-ID: <c0d6beb8-2464-4a9c-9516-ab5ca370f7bd@huaweicloud.com>
Date: Mon, 25 May 2026 09:56:42 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Add return value tests for lsm
 cgroup
Content-Language: en-US
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260523085806.417723-3-xukuohai@huaweicloud.com>
 <20260523100829.584DB1F000E9@smtp.kernel.org>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <20260523100829.584DB1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCnblparBNqTQAkDg--.32696S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFW5CFyDAFWUZF43GF43GFg_yoW8Aw4xpa
	yxAasFya1vkFW2qw18tF4UZF4rXr4vvr4UZr1rtryjyr13Jr1xJrW7Krs8K3ZxWFZ8Cwna
	va12qryS9w1UJ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

On 5/23/2026 6:08 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] BPF test programs for the `socket_create` LSM hook incorrectly declare `struct task_struct *task` as their argument instead of `int family`.
> --
> 
> commit b7003df7335bb1051987324aa639e3088d3673b5
> Author: Xu Kuohai <xukuohai@huawei.com>
> 
> selftests/bpf: Add return value tests for lsm cgroup
> 
> This commit adds tests to check return values set by the bpf_set_retval()
> helper for lsm cgroup programs.
> 
>> diff --git a/tools/testing/selftests/bpf/progs/verifier_lsm.c b/tools/testing/selftests/bpf/progs/verifier_lsm.c
>> index 38e8e91768620..2072671ed6439 100644
>> --- a/tools/testing/selftests/bpf/progs/verifier_lsm.c
>> +++ b/tools/testing/selftests/bpf/progs/verifier_lsm.c
> 
> [ ... ]
> 
>> @@ -188,4 +188,49 @@ int BPF_PROG(null_check, struct file *file)
>>   	return 0;
>>   }
>>   
>> +SEC("lsm_cgroup/socket_create")
>> +__description("lsm_cgroup with -4095~0 retval test 1")
>> +__success
>> +int BPF_PROG(lsm_cgroup_set_retval_zero_valid, struct task_struct *task)
> 
> [Severity: Low]
> Is this argument type correct for the socket_create hook? The LSM hook for
> socket_create expects (int family, int type, int protocol, int kern), so
> the first argument should be int family.
> 
> Using struct task_struct *task incorrectly casts the first integer argument
> to a pointer. While it works here because the argument isn't dereferenced,
> could this cause issues if this code is used as a template and the argument
> is accessed in other tests?
>

Ah, the argument type is indeed wrong. I will fix it in the next version.

>> +{
>> +	bpf_set_retval(0);
>> +	return 0;
>> +}
> 
> [ ... ]
> 

