Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36905284884;
	Sat,  7 Mar 2026 03:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772855773; cv=none; b=UxpKmLR7MkDyejdD2dx4VDCoLRfqJ1AiXrTE1om3SlAi8tOOaS11hf1MhXRCT6EGYqN8XbTkQEsIX/zJ3KwE+DDPEBnMnBs7alD+52WEKPZL7DTP3qyEna9U8ucFqlGBbE9z4ovHjlyC7AYQ/nWMVAbM5gcIbJwWluGiLXcJ5qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772855773; c=relaxed/simple;
	bh=5zluG4CHWV+26KvYDsJ3cK7L4+0Uljz9PfFmtGYdstA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=og5+wv9pvL7SNqaATKmhjGXkUu3zhxMdhr2grs4sTGLZZNUOPgfe7OCeIB9OEOefxGQCwHMgSr/9xiT6uC6VtTkHd15wXFe77SGrOwavMWjZuS8QNFYaNPV3gdHSgy4PT7O6BOGYw+zLvmUxWBIgHv21KiDqovw6OuZtdyjaxbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fSTvx6Y4yzKHMXT;
	Sat,  7 Mar 2026 11:55:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id ED4DB4058D;
	Sat,  7 Mar 2026 11:56:07 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP4 (Coremail) with SMTP id gCh0CgC3kEvWoatpOscDAA--.18155S2;
	Sat, 07 Mar 2026 11:56:07 +0800 (CST)
Message-ID: <e2be4bf9-5a39-4344-a138-a081666757dd@huaweicloud.com>
Date: Sat, 7 Mar 2026 11:56:06 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bpf-next v6 4/5] bpf, x86: Emit ENDBR for indirect jump targets
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>,
 Puranjay Mohan <puranjay@kernel.org>,
 Anton Protopopov <a.s.protopopov@gmail.com>,
 Shahab Vahedi <list+bpf@vahedi.org>, Russell King <linux@armlinux.org.uk>,
 Tiezhu Yang <yangtiezhu@loongson.cn>, Hengqi Chen <hengqi.chen@gmail.com>,
 Johan Almbladh <johan.almbladh@anyfinetworks.com>,
 Paul Burton <paulburton@kernel.org>, Hari Bathini <hbathini@linux.ibm.com>,
 Christophe Leroy <chleroy@kernel.org>, Naveen N Rao <naveen@kernel.org>,
 Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Pu Lehui <pulehui@huawei.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 "David S . Miller" <davem@davemloft.net>, Wang YanQing <udknight@gmail.com>
References: <20260306102329.2056216-1-xukuohai@huaweicloud.com>
 <20260306102329.2056216-5-xukuohai@huaweicloud.com>
 <c79adbee77ba5ce11d3df1ffa922c48937c8b536.camel@gmail.com>
 <e497dbd2-4f8e-45c2-b227-1bf0634dd924@huaweicloud.com>
 <CAADnVQ+EoVfSHwX_ni9krTEk7bvDZLfrzuCKEy46ZrASDBn-DA@mail.gmail.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <CAADnVQ+EoVfSHwX_ni9krTEk7bvDZLfrzuCKEy46ZrASDBn-DA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgC3kEvWoatpOscDAA--.18155S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXrWfZw1xCr4rAr17tF1DZFb_yoWrCw4fpF
	Z3JanIyF4DX3y5Jr42qF4jyry7KF4kKFy8Xr48t34ruwnIqrn7GF17Kw4Y9F9YgryxCr1f
	ZFyjyFnru34kZa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6x
	kF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE
	5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeV
	CFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x02
	62kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s
	026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_
	GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20x
	vEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07jxCztUUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 3/7/2026 11:31 AM, Alexei Starovoitov wrote:
> On Fri, Mar 6, 2026 at 7:15 PM Xu Kuohai <xukuohai@huaweicloud.com> wrote:
>>
>> On 3/7/2026 9:36 AM, Eduard Zingerman wrote:
>>> On Fri, 2026-03-06 at 18:23 +0800, Xu Kuohai wrote:
>>>> From: Xu Kuohai <xukuohai@huawei.com>
>>>>
>>>> On CPUs that support CET/IBT, the indirect jump selftest triggers
>>>> a kernel panic because the indirect jump targets lack ENDBR
>>>> instructions.
>>>>
>>>> To fix it, emit an ENDBR instruction to each indirect jump target. Since
>>>> the ENDBR instruction shifts the position of original jited instructions,
>>>> fix the instruction address calculation wherever the addresses are used.
>>>>
>>>> For reference, below is a sample panic log.
>>>>
>>>>    Missing ENDBR: bpf_prog_2e5f1c71c13ac3e0_big_jump_table+0x97/0xe1
>>>>    ------------[ cut here ]------------
>>>>    kernel BUG at arch/x86/kernel/cet.c:133!
>>>>    Oops: invalid opcode: 0000 [#1] SMP NOPTI
>>>>
>>>>    ...
>>>>
>>>>     ? 0xffffffffc00fb258
>>>>     ? bpf_prog_2e5f1c71c13ac3e0_big_jump_table+0x97/0xe1
>>>>     bpf_prog_test_run_syscall+0x110/0x2f0
>>>>     ? fdget+0xba/0xe0
>>>>     __sys_bpf+0xe4b/0x2590
>>>>     ? __kmalloc_node_track_caller_noprof+0x1c7/0x680
>>>>     ? bpf_prog_test_run_syscall+0x215/0x2f0
>>>>     __x64_sys_bpf+0x21/0x30
>>>>     do_syscall_64+0x85/0x620
>>>>     ? bpf_prog_test_run_syscall+0x1e2/0x2f0
>>>>
>>>> Fixes: 493d9e0d6083 ("bpf, x86: add support for indirect jumps")
>>>> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
>>>> ---
>>>>    arch/x86/net/bpf_jit_comp.c | 23 +++++++++++++++--------
>>>>    1 file changed, 15 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>>>> index 2c57ee446fc9..752331a64fc0 100644
>>>> --- a/arch/x86/net/bpf_jit_comp.c
>>>> +++ b/arch/x86/net/bpf_jit_comp.c
>>>> @@ -1658,8 +1658,8 @@ static int emit_spectre_bhb_barrier(u8 **pprog, u8 *ip,
>>>>       return 0;
>>>>    }
>>>>
>>>> -static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image,
>>>> -              int oldproglen, struct jit_context *ctx, bool jmp_padding)
>>>> +static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *addrs, u8 *image,
>>>> +              u8 *rw_image, int oldproglen, struct jit_context *ctx, bool jmp_padding)
>>>>    {
>>>>       bool tail_call_reachable = bpf_prog->aux->tail_call_reachable;
>>>>       struct bpf_insn *insn = bpf_prog->insnsi;
>>>> @@ -1743,6 +1743,11 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
>>>>                               dst_reg = X86_REG_R9;
>>>>               }
>>>>
>>>> +#ifdef CONFIG_X86_KERNEL_IBT
>>>> +            if (bpf_insn_is_indirect_target(env, bpf_prog, i - 1))
>>>> +                    EMIT_ENDBR();
>>>> +#endif
>>>> +
>>>>               switch (insn->code) {
>>>>                       /* ALU */
>>>>               case BPF_ALU | BPF_ADD | BPF_X:
>>>> @@ -2449,7 +2454,7 @@ st:                    if (is_imm8(insn->off))
>>>>
>>>>                       /* call */
>>>>               case BPF_JMP | BPF_CALL: {
>>>> -                    u8 *ip = image + addrs[i - 1];
>>>> +                    u8 *ip = image + addrs[i - 1] + (prog - temp);
>>>
>>> Sorry, meant to reply to v5 but got distracted.
>>> It seems tedious/error prone to have this addend at each location,
>>> would it be possible to move the 'ip' variable calculation outside
>>> of the switch? It appears that at each point there would be no
>>> EMIT invocations between 'ip' computation and usage.
>>>
>>
>> Besides the changes shown in this patch, there is another line in the
>> file computing address using 'image + addrs[i - 1] + (prog - temp)'.
>>
>> It is at the call to emit_return() in the 'BPF_JMP | BPF_EXIT' case.
>> But there are indeed EMIT*() invocations before the address copmutation,
>> so a pre-computed address before the switch statement is stale in
>> this case.
>>
>> To fix this, how about introducing a macro for the address computation,
>> as the following diff (based on this patch) shows:
>>
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
>> @@ -1606,6 +1606,8 @@ static void emit_priv_frame_ptr(u8 **pprog, void __percpu *priv_frame_ptr)
>>
>>    #define INSN_SZ_DIFF (((addrs[i] - addrs[i - 1]) - (prog - temp)))
>>
>> +#define CURR_IP      (image + addrs[i - 1] + (prog - temp))
>> +
> 
> No. Don't obfuscate it with macro.
> I don't like INSN_SZ_DIFF either.
> 
> 
OK, will use Eduward's approach as is.

