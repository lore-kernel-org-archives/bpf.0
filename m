Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D324F175A8B
	for <bpf@vger.kernel.org>; Sat, 18 Jul 2026 04:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784348230; cv=none; b=lzDwTZavszMyeXTFnojBXbLvWHoyBA0yhxoWz9idR7AQpQPSvC0W22gGbnhpIjClkU3RZe/nl4k1ncTDknmmCvLzXmD/Mm4M+Zu0DhNBhXCv6aaJTR9cLaAKIrBrxV9pTwyx/8o1SuQr7WAV1bHykm59HE8muipnJXJ/LzWusNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784348230; c=relaxed/simple;
	bh=il1btdJVa8YvFF9Ljj9N1aEghs+lcQCOztAMVigmP5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QgHpT+Lewgm7SnFGPs4oI8grYYC3h5N41LpvvmcmBm2WHcz2zAUikfJj/6K6yFxhzVBvUhYrXNiNNH7UWZQvrkaLAtDlj1ScKbTwUKf3o6lCfPPHJSYxByG90OTVA5gA8JayzEoFpm5qhsRY2+9EvLySJH/DjyteHJin4E0iffM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4h2D4B093yzKHMPh
	for <bpf@vger.kernel.org>; Sat, 18 Jul 2026 12:16:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 9EB454058F
	for <bpf@vger.kernel.org>; Sat, 18 Jul 2026 12:17:02 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgBHdlc9_lpqS5mQBg--.50012S2;
	Sat, 18 Jul 2026 12:17:02 +0800 (CST)
Message-ID: <7595427e-82aa-4618-8247-c85c8588abe4@huaweicloud.com>
Date: Sat, 18 Jul 2026 12:17:01 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpf, arm64: Optimize cast_user code generation
Content-Language: en-US
To: Puranjay Mohan <puranjay12@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
References: <20260717134817.2868291-1-puranjay@kernel.org>
 <CANk7y0iWkFe1=0hg6_h7YgMp+LK1HGGMheyPR6syPFDinRWafg@mail.gmail.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <CANk7y0iWkFe1=0hg6_h7YgMp+LK1HGGMheyPR6syPFDinRWafg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHdlc9_lpqS5mQBg--.50012S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuF45AFy5KrWfKrWkKryfJFb_yoW5Cw48pw
	sIgF4SkwsFqr1qyas7uwnrJr4rK397tF4Yvw13C3ySyryqqr1UGF1jkrWY93s8ZrWfZrZY
	kFWjkr13uayDJa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 7/17/2026 10:19 PM, Puranjay Mohan wrote:
> +cc Xu
> 
> On Fri, Jul 17, 2026 at 2:48 PM Puranjay Mohan <puranjay@kernel.org> wrote:
>>
>> cast_user converts an arena offset into a user address by combining the
>> low 32 bits of the pointer with the upper 32 bits of user_vm_start, while
>> keeping a NULL pointer NULL. The current sequence always emits six
>> instructions: it materializes user_vm_start >> 32 into a register, shifts
>> it into place, and ORs in the offset.
>>
>> The upper half of user_vm_start is a constant, so it can be written
>> directly onto the offset with MOVK. Move the 32-bit offset into dst
>> (which also zeroes the upper 32 bits), then MOVK the non-zero halfwords
>> of the upper address, branching over the MOVKs when the offset is zero so
>> NULL is preserved.
>>
>> This emits at most four instructions, and only one when the upper half of
>> user_vm_start is zero. The generated code is equivalent.
>>
>> Before:
>>    ; bpf_addr_space_cast(page1, 1, 0);
>>    7c:   mov     w10, w8
>>    80:   mov     w8, #1
>>    84:   lsl     x8, x8, #32
>>    88:   cbz     x10, 0xffff800087b80c20
>>    8c:   orr     x10, x8, x10
>>    90:   mov     x8, x10
>>
>> After:
>>    ; bpf_addr_space_cast(page1, 1, 0);
>>    7c:   mov     w8, w8
>>    80:   cbz     w8, 0xffff800087b80c28
>>    84:   movk    x8, #1, lsl #32
>>
>> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
>> ---
>>   arch/arm64/net/bpf_jit_comp.c | 25 +++++++++++++++++++------
>>   1 file changed, 19 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
>> index b0075ece4a6e7..c6756b964c843 100644
>> --- a/arch/arm64/net/bpf_jit_comp.c
>> +++ b/arch/arm64/net/bpf_jit_comp.c
>> @@ -1284,12 +1284,25 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
>>          case BPF_ALU | BPF_MOV | BPF_X:
>>          case BPF_ALU64 | BPF_MOV | BPF_X:
>>                  if (insn_is_cast_user(insn)) {
>> -                       emit(A64_MOV(0, tmp, src), ctx); // 32-bit mov clears the upper 32 bits
>> -                       emit_a64_mov_i(0, dst, ctx->user_vm_start >> 32, ctx);
>> -                       emit(A64_LSL(1, dst, dst, 32), ctx);
>> -                       emit(A64_CBZ(1, tmp, 2), ctx);
>> -                       emit(A64_ORR(1, tmp, dst, tmp), ctx);
>> -                       emit(A64_MOV(1, dst, tmp), ctx);
>> +                       u32 upper = ctx->user_vm_start >> 32;
>> +                       u16 upper_32 = upper & 0xffff;
>> +                       u16 upper_48 = upper >> 16;
>> +                       int nr_movk = !!upper_32 + !!upper_48;
>> +
>> +                       /*
>> +                        * Build the user address: the low 32 bits are the arena
>> +                        * offset, the upper 32 bits come from user_vm_start. A
>> +                        * zero offset must stay NULL, so branch over the MOVKs
>> +                        * when it is zero.
>> +                        */
>> +                       emit(A64_MOV(0, dst, src), ctx); /* 32-bit mov clears the upper 32 bits */
>> +                       if (nr_movk) {
>> +                               emit(A64_CBZ(0, dst, nr_movk + 1), ctx);
>> +                               if (upper_32)
>> +                                       emit(A64_MOVK(1, dst, upper_32, 32), ctx);
>> +                               if (upper_48)
>> +                                       emit(A64_MOVK(1, dst, upper_48, 48), ctx);
>> +                       }
>>                          break;
>>                  } else if (insn_is_mov_percpu_addr(insn)) {
>>                          if (dst != src)
>>

The upper_32/48 names sound like the upper 32/48 bits from the value, how
about change to upper_lo and upper_high?

Otherwise looks good to me.

>> base-commit: 1d91ea01185656ac3ee63c5f9f6f8bde3c746b3d
>> --
>> 2.53.0-Meta
>>

