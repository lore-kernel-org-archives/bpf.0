Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F10B442B34;
	Tue, 11 Aug 2026 13:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786453250; cv=none; b=YHNUtSGgtF29741L6wh69Sit6PxMmefgZR8XcEmj8VNKDhFmkE1P5lPYS37in354pHSyUGTz/ydXqJ0G21+hcffQNMFKNSLB9b41u2FhWMwiZLUj3aIoxsqMtaOt45RTWUKhjlhsHALzdl9el3MkGr17ZUltMU48MF9ump1UrsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786453250; c=relaxed/simple;
	bh=Apz5MdpqWGuqLZGhHoqZ47sKF/ZCk0rrcWIR4RuSpUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yo5eCDO4mIAt8LifYtyJm69ACm1jQhmFbdktcYbxKmZCWJ/pLm4NqtxJwj6IW7jgQAw9iXC7AsEfvdzRbCigpmsxpy3RBLdmsNSTRtN5SBHDMLo8trufvliZLAsvtbdKunSoMeN0fGxinQzJWZfCs8d2tj05FChn9SjlyBloXI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hKBYl5hMWzKHMN4;
	Tue, 11 Aug 2026 21:00:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id D57BE4056B;
	Tue, 11 Aug 2026 21:00:43 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgCXhdH6HHtqRkC2Bw--.50134S2;
	Tue, 11 Aug 2026 21:00:43 +0800 (CST)
Message-ID: <02288f8a-3a23-4d3a-97f9-5d830b420e0e@huaweicloud.com>
Date: Tue, 11 Aug 2026 21:00:42 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 2/2] bpf: Remove unnecessary dup/restore
 subprog_starts and prog clone
Content-Language: en-US
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Yonghong Song <yonghong.song@linux.dev>,
 Anton Protopopov <a.s.protopopov@gmail.com>
References: <cover.1785240296.git.xukuohai@huawei.com>
 <7e27df89f8d4e1c8790cd26b4bd30ffbd2926cf6.1785240296.git.xukuohai@huawei.com>
 <855d8ae50086be9d792c5efdaedd01895c7e2f13.camel@gmail.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <855d8ae50086be9d792c5efdaedd01895c7e2f13.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCXhdH6HHtqRkC2Bw--.50134S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AryUGFy5CF1xZF4UXrykuFg_yoW8GF15pF
	yqy34DCr4qva129a47Ja18Ca4fXa4rKryfGFWrK3ySvF1aqr1kGF13WwsFvFZ0vr4kCr1a
	vw10vr9F9ayxZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UAwI
	DUUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 8/11/2026 5:27 AM, Eduard Zingerman wrote:
> On Tue, 2026-07-28 at 20:25 +0000, Xu Kuohai wrote:
> 
> ...
> 
>> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
>> index 505d134cd264..ab5da3ff941a 100644
>> --- a/kernel/bpf/core.c
>> +++ b/kernel/bpf/core.c
>> @@ -1564,27 +1564,34 @@ void bpf_jit_prog_release_other(struct bpf_prog *fp, struct bpf_prog *fp_other)
>>    * Now this function is used only to blind the main prog and must be invoked only when
>>    * bpf_prog_need_blind() returns true.
>>    */
>> -struct bpf_prog *bpf_jit_blind_constants(struct bpf_verifier_env *env, struct bpf_prog *prog)
>> +int bpf_jit_blind_constants(struct bpf_verifier_env *env, struct bpf_prog **pprog,
>> +			    bool clone_needed, bool *cloned)
> 
> Imo, the code is harder to understand after this change.
> Maybe it would be simpler if clone_needed/cloned handling would moved
> to the caller. In the current form I'm not convinced the change is warranted.
> 
> ...

Yes, this is not an elegant cleanup. I think the cleanest way is to create
a general JIT layer, then iterate through all the instructions and do the
constant blinding and arch JIT for each one on the fly. This would eliminate
the prog clone completely. However, since we have more than 10 arch JITs, I
would like to explore whether it is actually feasible and drop the current
patch for now.

