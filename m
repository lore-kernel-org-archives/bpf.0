Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0993C3449;
	Fri, 17 Jul 2026 07:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784273874; cv=none; b=mK/rqj3jn1VC/fdzIfXXqUxA4voHC65hdKc9ZakiAJKyB/V9y3dT9Ds3bgBJu+qGNzairivsMz2XbznlgSY+4gXe+CewNw6MUKJ7L45gHmKNQFkSv4JdGvxKGo8TuTQdbmrNkYs5I2FKNUN4qdh232Xg0tyZLV0UylWxcTgB/2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784273874; c=relaxed/simple;
	bh=ZteC8Dp5P1iAB4z1TTbefJHYmN4UEEI1beqjYg43EAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LiD6p0cxIJMk4xGBLSBtzUBx0DnzhLsfqYxTKhrH07/5NdQas62AkNyHCbV7ksgeeYRvmnQa63RepNsrXBJ1Fr7PCoI5M+UJsk5YxElzD+ZbXsd9SamYHzmkJBAJqzhSvdos7jUKKQWeoW7GgnhnLRDLwSo74FccAeQD+tLZF+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4h1hZX6mStzYQthY;
	Fri, 17 Jul 2026 15:37:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 0D3154056B;
	Fri, 17 Jul 2026 15:37:45 +0800 (CST)
Received: from [10.67.110.68] (unknown [10.67.110.68])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgDH+lvH21lqe+wnBg--.58759S2;
	Fri, 17 Jul 2026 15:37:44 +0800 (CST)
Message-ID: <dd20e3ea-4b3a-45d1-99f4-79e99e51e7fb@huaweicloud.com>
Date: Fri, 17 Jul 2026 15:37:43 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v6 6/7] riscv, bpf: Mixing bpf2bpf and tailcalls
Content-Language: en-US
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>, bot+bpf-ci@kernel.org,
 bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 eddyz87@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, puranjay@kernel.org,
 pjw@kernel.org, palmer@dabbelt.com, alex@ghiti.fr, pulehui@huawei.com,
 martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev
References: <20260708064436.2971933-7-pulehui@huaweicloud.com>
 <a721df30ec2f824295000183c8e91f2c19d0bd56ae115b835b402be9eacc1c71@mail.kernel.org>
 <b4aadfde-9745-4c71-8dd4-ce433331f91b@huaweicloud.com>
 <CAJ+HfNi_icVbeB=jw-xnXrwzigZwP2OVRbzaF3VC87i6fDpdDw@mail.gmail.com>
 <fc972c33-1b66-4979-97e9-71627fb6179f@huaweicloud.com>
 <CAJ+HfNgPWwX3dfu=62TSMKeLD8m9S0rc2k9G8rVN7r2SuzQ6MQ@mail.gmail.com>
 <23cb9eac-1775-44b8-a9ec-10edde808a30@huaweicloud.com>
 <326eda4a-39e6-4f1e-8fe5-dc1cc9ae6739@iogearbox.net>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <326eda4a-39e6-4f1e-8fe5-dc1cc9ae6739@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDH+lvH21lqe+wnBg--.58759S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZFWrZw47tF15Cr1kZF4xJFb_yoW5AF47pF
	yrWa4UKFWDJF1Iyr17tr18Ja4SyrsxJryUXF15J3sxAr90kr1agr47GrWj9r95ur4rCF1j
	qw1Yqay7Xrn5A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7
	CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
	rVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kK
	e7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_
	WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07
	jIksgUUUUU=
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/



On 2026/7/10 17:43, Daniel Borkmann wrote:
> On 7/10/26 2:53 AM, Pu Lehui wrote:
>> On 2026/7/10 3:51, Björn Töpel wrote:
>>> On Thu, 9 Jul 2026 at 17:09, Pu Lehui <pulehui@huaweicloud.com> wrote:
>>>> On 2026/7/9 19:37, Björn Töpel wrote:
>>>>> Sorry for the delay here -- the bot had me thinking a bit.
>>>>>
>>>>> On Wed, 8 Jul 2026 at 10:54, Pu Lehui <pulehui@huaweicloud.com> wrote:
>>>>> ...
>>>>>
>>>>>>> This assumes a fixed number of instructions before the tailcall 
>>>>>>> entry
>>>>>>> point. When is_subprog is true, the rv_addi() instruction is not 
>>>>>>> emitted,
>>>>>>> which means the tailcall entry point moves forward by 4 bytes 
>>>>>>> relative to
>>>>>>> where RV_TAILCALL_OFFSET expects it to be.
>>>>>>>
>>>>>>> The tailcall entry is used in emit_bpf_tail_call() when 
>>>>>>> calculating the
>>>>>>> jump target for the tail call. If RV_TAILCALL_OFFSET doesn't 
>>>>>>> account for
>>>>>>> the conditional emission, could this cause the wrong entry point 
>>>>>>> to be
>>>>>>> used when tail calling into subprograms?
>>>>>>
>>>>>> This is not an issue, subprog can not be the tailcall callee.
>>>>>
>>>>> Say, that we have an entry function that does bpf_for_each_map_array()
>>>>> into a callback cb(). cb() is a subprogram, so no init of TCC. Now,
>>>>> cb() calls another subprogram that does a tailcall.
>>>>>
>>>>> The callback to cb() is coming from the kernel, so a6 could have been
>>>>> clobbered, no? We're entering a subprogram coming from the C ABI. Now,
>>>>> if the callback calls a subprog that's tail-call reachable, the TCC
>>>>> can be garbage?
>>>>
>>>> Sashiko reported the same issue yesterday. I verified that the verifier
>>>> rejects cases where a tail call is invoked within a callback;
>>>> specifically, while the callback's return value range is [0, 1], the
>>>> simulation of the exit path in `check_helper_call` (handling the tail
>>>> call helper) marks R0 as UNKNOWN, causing the verifier to reject 
>>>> it—so I
>>>> didn't investigate further. However, I just verified that the verifier
>>>> *does* accept the scenario where a callback calls a subprogram, and 
>>>> that
>>>> subprogram subsequently calls a tail call. I believe this scenario 
>>>> ought
>>>> to be rejected; perhaps some changes are needed in the verifier,
>>>> otherwise tail calls on other architectures (like x86) would also be
>>>> susceptible to infinite loop issues.
>>>
>>> Thanks for trying it out!
>>>
>>> Ok, so seems like we need a verifier fix pre-landing?

Hi Björn,

Just a quick note that the verifier fix we discussed has now landed in 
bpf-next [0]. Looking forward to your feedback on v6 whenever you get a 
chance. :)

[0] 
https://lore.kernel.org/bpf/178424941139.1475787.18080893330670192934.git-patchwork-notify@kernel.org/

>>
>> make sense to me, will try it.
> 
> Thanks, yes, please take a stab at crafting a verifier fix + BPF selftest
> and let us know if you are stuck somewhere.

