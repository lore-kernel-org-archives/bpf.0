Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB7623EAB0
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 01:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776820258; cv=none; b=pP3SkZzntoRgl8EzHOKIFhESiKNPfDVFVvnBaRSXKkTFB+tmpvYzqQaYB8QQalt8Aa5qVwgum1rMQbwdjofihvLDsmk4aibrfFeqt1avuMiEZ3Sp+0p6IsCE4NjIPgUP5dUenPslH/mbnEjjTC7vOXYQCIu4XWIQ/BRcwyD+uhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776820258; c=relaxed/simple;
	bh=eKym9XNmikZOQYILGptMEIqo8gEVfq5+vCILwrxAWKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mw9N0SUQyy5Ogq6aiDHz36FqSng5s4y4d35bFpI5QAV7V3h1CmUjd3vTESiHi58cPXgRcFtXgh1r3OAJFh+kcKFEF3EuZBcyOLsF/Mu5Ce/2fhS5QJ3+VDLXR4dCHJIB6vdXkUAgltlCGkzN+mo+pw50NXmQFNj7h8wy+hp7kqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FK1v9wOE; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FK1v9wOE"
Message-ID: <80715e2c-c1d0-4f76-af17-478ea0f8c8d5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776820253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0gRSG4Gn7W7NO5u70ow2EmuS07M643lr+DZBNBB1XUk=;
	b=FK1v9wOEwgnnWe7FcO8A8KXyOqTf7ZXig7lA89+a4Cc64b64rPhbstWVErjk4WaE4PXBIm
	uohVxcSsN8O5VXKI+LmPCptGKjxVUHt7XDHJcK9h9SXyvtDuv3O76SmgPihKNnYl3it3qo
	BXe3x7WcYfQVukPsgOAltiPNeg65SaI=
Date: Tue, 21 Apr 2026 18:10:47 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 8/9] bpf: Introduce bpf register BPF_REG_PARAMS
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 "Jose E . Marchesi" <jose.marchesi@oracle.com>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Puranjay Mohan <puranjay@kernel.org>
References: <20260421171927.3507554-1-yonghong.song@linux.dev>
 <20260421172007.3512280-1-yonghong.song@linux.dev>
 <DHZ6DPP9Q67P.17W3L0YIPN8Z4@gmail.com>
 <a98248e8-8b70-4125-b494-1a5ff12396fd@linux.dev>
 <DHZ9M7ACK4GR.15DYRN8T1LZZ4@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <DHZ9M7ACK4GR.15DYRN8T1LZZ4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 4/21/26 5:42 PM, Alexei Starovoitov wrote:
> On Tue Apr 21, 2026 at 5:09 PM PDT, Yonghong Song wrote:
>>
>> On 4/21/26 3:10 PM, Alexei Starovoitov wrote:
>>> On Tue Apr 21, 2026 at 10:20 AM PDT, Yonghong Song wrote:
>>>>    
>>>>    /* Kernel hidden auxiliary/helper register. */
>>>> -#define BPF_REG_AX		MAX_BPF_REG
>>>> -#define MAX_BPF_EXT_REG		(MAX_BPF_REG + 1)
>>>> +#define BPF_REG_PARAMS		MAX_BPF_REG
>>>> +#define BPF_REG_AX		(MAX_BPF_REG + 1)
>>>> +#define MAX_BPF_EXT_REG		(MAX_BPF_REG + 2)
>>> ...
>>>
>>>> --- a/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
>>>> +++ b/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
>>>> @@ -630,13 +630,13 @@ __xlated("...")
>>>>    __xlated("4: r0 = &(void __percpu *)(r0)")
>>>>    __xlated("...")
>>>>    /* may_goto expansion starts */
>>>> -__xlated("6: r11 = *(u64 *)(r10 -24)")
>>>> -__xlated("7: if r11 == 0x0 goto pc+6")
>>>> -__xlated("8: r11 -= 1")
>>>> -__xlated("9: if r11 != 0x0 goto pc+2")
>>>> -__xlated("10: r11 = -24")
>>>> +__xlated("6: r12 = *(u64 *)(r10 -24)")
>>>> +__xlated("7: if r12 == 0x0 goto pc+6")
>>>> +__xlated("8: r12 -= 1")
>>>> +__xlated("9: if r12 != 0x0 goto pc+2")
>>>> +__xlated("10: r12 = -24")
>>> maybe shift it to r15 right away, so we don't need to touch this code
>>> if/when true r12 is introduced?
>> We can do this. Do you think the following is okay:
>>
>> diff --git a/include/linux/filter.h b/include/linux/filter.h
>> index b77d0b06db6e..fe7b6b943ea4 100644
>> --- a/include/linux/filter.h
>> +++ b/include/linux/filter.h
>> @@ -59,9 +59,9 @@ struct ctl_table_header;
>>    
>>    /* Kernel hidden auxiliary/helper register. */
>>    #define BPF_REG_PARAMS         MAX_BPF_REG
>> -#define BPF_REG_AX             (MAX_BPF_REG + 1)
>> -#define MAX_BPF_EXT_REG                (MAX_BPF_REG + 2)
>> +#define MAX_BPF_EXT_REG                (MAX_BPF_REG + 1)
>>    #define MAX_BPF_JIT_REG                MAX_BPF_EXT_REG
>> +#define BPF_REG_AX             (MAX_BPF_REG + 4)
>>    
>>    /* unused opcode to mark special call to bpf_tail_call() helper */
>>    #define BPF_TAIL_CALL  0xf0
>> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
>> index ae10b9ca018d..3ad286ef3085 100644
>> --- a/kernel/bpf/core.c
>> +++ b/kernel/bpf/core.c
>> @@ -1299,8 +1299,8 @@ static int bpf_jit_blind_insn(const struct bpf_insn *from,
>>           u32 imm_rnd = get_random_u32();
>>           s16 off;
>>    
>> -       BUILD_BUG_ON(BPF_REG_PARAMS + 2 != MAX_BPF_JIT_REG);
>> -       BUILD_BUG_ON(BPF_REG_AX + 1 != MAX_BPF_JIT_REG);
>> +       BUILD_BUG_ON(BPF_REG_PARAMS + 1 != MAX_BPF_JIT_REG);
>> +       BUILD_BUG_ON(BPF_REG_AX != MAX_BPF_JIT_REG + 3);
> Ohh. We have:
> static unsigned int PROG_NAME(stack_size)(const void *ctx, const struct bpf_insn *insn) \
> { \
>          u64 stack[stack_size / sizeof(u64)]; \
>          u64 regs[MAX_BPF_EXT_REG] = {}; \
>
>
> Please double check that BPF_REG_AX is not used by the interpreter.
>
> but it's starting to feel that my suggestion was premature.
> Probably better to keep this patchset as-is.

Okay, let me keep the current one.


