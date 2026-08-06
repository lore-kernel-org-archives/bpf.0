Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970023D667D;
	Thu,  6 Aug 2026 09:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786007989; cv=none; b=iX2W9LPc1w0lyNfaZYpq+PXA78UH8s3BwyfHyMoxxH96+1ZHcX9qDg1UVMt9dg+RxK7sMyFuPBoEXP0mQDflSES66ivn9pqob8R8j7a7/k3mu62Zi/fE7GVQ2mVkPpfm0II0Ur6oPKAC7uUyzGFVhlRWm+Sy6LRx+CPB3zk4aqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786007989; c=relaxed/simple;
	bh=ZOy8ye1izp4wIxal0miIC9qErBHaINStsTmwt4ncyR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sEL+Evkr+MQQSWAxtPUVhSnMXhY1h2ldIGld0qVlPr2/s/moY+ZVEkXj6UDgeIIoi3jOhDyG/S7Mr9qVDL216wAdVHQPB0UlLscOCvzoJDrVQl+V6fB6RnOMiuQS7IOlBgTzY9ibKXMXwlJoXezMvB99RzcqiHQmfjDtNNJRW5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hG1tF6QMPzYQtyt;
	Thu,  6 Aug 2026 17:18:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 67D4240593;
	Thu,  6 Aug 2026 17:19:40 +0800 (CST)
Received: from [10.67.110.68] (unknown [10.67.110.68])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgBHgs6qUXRqRqc+BQ--.50682S2;
	Thu, 06 Aug 2026 17:19:40 +0800 (CST)
Message-ID: <fbef490c-d57f-4a0c-b96d-75a846fe5c98@huaweicloud.com>
Date: Thu, 6 Aug 2026 17:19:38 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 0/9] Fixes for bpf_jit_free
Content-Language: en-US
To: Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Puranjay Mohan <puranjay@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>,
 Tiezhu Yang <yangtiezhu@loongson.cn>, Hengqi Chen <hengqi.chen@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Helge Deller <deller@gmx.de>, "David S. Miller" <davem@davemloft.net>,
 Shahab Vahedi <list+bpf@vahedi.org>, Hari Bathini <hbathini@linux.ibm.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Naveen N Rao <naveen@kernel.org>, Pu Lehui <pulehui@huawei.com>
References: <20260725154915.2488611-1-pulehui@huaweicloud.com>
 <dc180ce3-e222-4c67-b44b-f792930afd8f@iogearbox.net>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <dc180ce3-e222-4c67-b44b-f792930afd8f@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHgs6qUXRqRqc+BQ--.50682S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXFyrCr43Zr13ZFyUAF47Arb_yoW5uw1UpF
	Wvqr13Cryqgr97trsxJw48XFyYyw4rJ3W7WF13Way8Z3WYgryjgFy29w4F9FWjyrW8Gw4Y
	qF1Ygr98uFyDX3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
	evJa73UjIFyTuYvjTRM6wCDUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

Hi Daniel,

Sorry for late reply.

On 2026/8/3 21:05, Daniel Borkmann wrote:
> Hi Pu,
> 
> On 7/25/26 5:49 PM, Pu Lehui wrote:
>> From: Pu Lehui <pulehui@huawei.com>
>>
>> Fixes for bpf_jit_free identified by Sashiko, as previously noted in [0].
>>
>> Link: 
>> https://lore.kernel.org/bpf/28ba19a4-b487-49fd-bbba-04410acdb113@iogearbox.net/ [0]
> 
> Given you need to introduce a bpf_jit_free multiple times in the various
> JITs, could you rather look into moving this code into the core so core BPF
> code can handle this? Then it would also be easier to test in CI if we can
> consolidate the subprogram failure handling.


Before preparing the next, I'd like to clarify two points:

1. Only target non-pack archs (s390, parisc...),or touch binary-pack 
archs like x86/arm64 as well?

2. For handling jit priv data without callbacks, I have two options:
- Option A: Append jit priv data directly after jit_data in one 
allocation. Then a single kvfree(aux->jit_data) in core frees both.
```
// alloc
jit_data = kvzalloc(sizeof(*jit_data) + addrs_size, GFP_KERNEL);
jit_data->ctx.addrs = (void *)(jit_data + 1);

// free
kvfree(aux->jit_data)
```
- Option B: Add jit_priv_data to bpf_prog->aux and point to the jit priv 
data, and free both of them.
```
// alloc
jit_data = kvzalloc(sizeof(*jit_data), GFP_KERNEL);
jit_data->ctx.addrs = kvzalloc(addrs_size, GFP_KERNEL);
fp->aux->jit_priv_data = jit_data->ctx.addrs;

// free
kvfree(aux->jit_priv_data)
kvfree(aux->jit_data)
```

Which approach prefer, or do you have other recommendations?

Thanks,
Lehui

> 
> Thanks,
> Daniel
> 
>> v3:
>> - Add fix for private stack leak on arm64. (Sashiko)
>> - Some minor fixes.
>>
>> v2: 
>> https://lore.kernel.org/bpf/20260725102020.2287770-1-pulehui@huaweicloud.com
>> - Fix JITs not freeing leftover jit_data when jit_subprogs() aborts. 
>> (Sashiko)
>> - Drop fix for loongarch as it's applied.
>>
>> v1: 
>> https://lore.kernel.org/bpf/20260722112754.1615201-1-pulehui@huaweicloud.com
>>
>>
>> Pu Lehui (9):
>>    bpf: Extract the bpf_jit_binary_hdr helper
>>    s390/bpf: Fix memory leak in bpf_jit_free
>>    parisc: Fix memory leak in bpf_jit_free
>>    bpf, sparc64: Fix memory leak in bpf_jit_free
>>    ARC, bpf: Fix memory leak in bpf_jit_free
>>    bpf, arm64: Fix memory leak in bpf_jit_free
>>    bpf, arm64: Fix private stack leak when JIT failed
>>    riscv, bpf: Adjust bpf_func to account for CFI offset in bpf_jit_free
>>    bpf: Fix double-free RO header in bpf_jit_free
>>
>>   arch/arc/net/bpf_jit_core.c      | 19 +++++++++++++++++++
>>   arch/arm64/net/bpf_jit_comp.c    |  6 +++---
>>   arch/loongarch/net/bpf_jit.c     |  6 ++----
>>   arch/parisc/net/bpf_jit_core.c   | 19 +++++++++++++++++++
>>   arch/powerpc/net/bpf_jit_comp.c  |  5 +++--
>>   arch/riscv/net/bpf_jit_core.c    |  8 +++-----
>>   arch/s390/net/bpf_jit_comp.c     | 19 +++++++++++++++++++
>>   arch/sparc/net/bpf_jit_comp_64.c | 19 +++++++++++++++++++
>>   arch/x86/net/bpf_jit_comp.c      |  7 ++-----
>>   include/linux/filter.h           |  2 ++
>>   kernel/bpf/core.c                | 19 ++++++++++---------
>>   11 files changed, 101 insertions(+), 28 deletions(-)
>>

