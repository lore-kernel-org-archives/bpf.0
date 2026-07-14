Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1642F2E736E;
	Tue, 14 Jul 2026 02:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783994523; cv=none; b=SfMtsy1VEGeBDcpWf9MRIM3Rtd9ITRDHQtujMrIlxw6HCNDeIo4nKYv0CB4pUu2XMJoxe2qQmHL+vI6XEMxoq0F1sliYkAstBj2VT+nH3XS6adSzpEtcyyHX4257Ds7a2/PojLIqYe6aTD2Z95LdS5wQSuaG58tq6IlvRZHIt54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783994523; c=relaxed/simple;
	bh=Y8VVOXI4u2UcVXHcTq+LOiwTobByBYfsMmNnohftf94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q8gw6NZsLa6VS2heIC10E9UwtqGmec2iciGT6pVE9YMEyjGqJ/Tt385ADyMs1FwO3A9yVGlIcLAWQDXKX4f/eFmHUz8s7a76aYEhM9RvSKZQG3uF40U7LhBRaPfVU0TYxuWf+N+00vx8awL6brQk3oFNMZwSsaA5oi+veIefUXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gzjGG6JcFzKHML7;
	Tue, 14 Jul 2026 10:01:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id CB37440590;
	Tue, 14 Jul 2026 10:01:56 +0800 (CST)
Received: from [10.67.110.68] (unknown [10.67.110.68])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgBXiVqTmFVq0_qgBA--.46930S2;
	Tue, 14 Jul 2026 10:01:56 +0800 (CST)
Message-ID: <3b418aba-d65b-46de-8924-b02bef5f95f7@huaweicloud.com>
Date: Tue, 14 Jul 2026 10:01:55 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add testcases for callback
 with tailcall
Content-Language: en-US
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Yonghong Song <yonghong.song@linux.dev>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, Song Liu <song@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>,
 Pu Lehui <pulehui@huawei.com>
References: <20260711104727.4023420-1-pulehui@huaweicloud.com>
 <20260711104727.4023420-3-pulehui@huaweicloud.com>
 <6befa724e4fdc197f4a603246b4f95b65748882f.camel@gmail.com>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <6befa724e4fdc197f4a603246b4f95b65748882f.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXiVqTmFVq0_qgBA--.46930S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CryrGw1xGw1UXFWrKF1UAwb_yoW8tr1UpF
	y8Z34YgryfZ3WfZF47Wr48WF98AFs5JFWYkr18JryFyrs7uFyfWFnFkFW8KFZa93yFv3s0
	vw10vr1xAws5JaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7
	CjxVAFwI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02
	F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4I
	kC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUF1v3UUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

Hi Eduard,

Thanks for reviewing.

On 2026/7/14 6:12, Eduard Zingerman wrote:
> On Sat, 2026-07-11 at 10:47 +0000, Pu Lehui wrote:
> 
> [...]
> 
>> diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
>> index a5a226d0104c..c66037162da5 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
> 
> [...]
> 
>>   void test_tailcalls(void)
>>   {
>>   	if (test__start_subtest("tailcall_1"))
>> @@ -1967,4 +1973,5 @@ void test_tailcalls(void)
>>   		test_tailcall_cgrp_storage_no_storage_leaf();
>>   	if (test__start_subtest("tailcall_cgrp_storage_no_storage_bridge"))
>>   		test_tailcall_cgrp_storage_no_storage_bridge();
>> +	test_tailcall_callback();
> 
> Please use test__start_subtest().

I use `RUN_TESTS(tailcall_callback)` above, so it will parse subtest 
base on `__description(desc)` or test func_proto. Also, it will make 
sense to test only by `test_progs -a tailcalls/tailcall_bpf2bpf_callback`


But if use `test__start_subtest`, it will show double test items:

#480/37  tailcalls/tailcall_cgrp_storage_no_storage_bridge:OK
#480/38  tailcalls/test_tailcall_bpf2bpf_callback:OK <--
#480/39  tailcalls/tailcall_bpf2bpf_callback:OK <--
#480     tailcalls:OK
Summary: 1/39 PASSED, 0 SKIPPED, 0 FAILED

> 
>>   }
>> diff --git a/tools/testing/selftests/bpf/progs/tailcall_callback.c b/tools/testing/selftests/bpf/progs/tailcall_callback.c
>> new file mode 100644
>> index 000000000000..504d8e7a6996
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/tailcall_callback.c
> 
> [...]
> 
>> +/* callback involving 1 subprog with tail call is rejected */
>> +SEC("tc")
>> +__failure __msg("cannot tail call within callback")
>> +int tailcall_bpf2bpf_callback_1(struct __sk_buff *skb)
>> +{
>> +	clobber_regs_stack();
>> +
>> +	bpf_loop(1, callback_loop_2, &skb, 0);
>> +	return 0;
>> +}
> 
> I think having all three is a bit redundant,
> let's settle on tailcall_bpf2bpf_callback_1?

make sense to me

