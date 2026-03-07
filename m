Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035451531C1;
	Sat,  7 Mar 2026 03:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772853324; cv=none; b=sRHEv1j6IyEdf5/0KRD8H+HbN2JH07t+8g+8+QZYKVdrUK0yFChfYsLe8nCBDja4M5safBjPOU8rOMtZn8P1WcVzmgkug01b8T2Fomo+I5LwgclK0wKv0B+XGPWUapvu686uBdMwOphc4SGkaHjEvwkZsJ9LIrBE/OWRbfzrsXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772853324; c=relaxed/simple;
	bh=FlJUAEpv3HXGD2ZFzu/XUH9ePTQ8yaRwksLyhkca7cQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vE32ew4zfGLOcLjxVJyZATprJxUtVS33422kplWqoyLe0GOyp30viqO65utEApDsH5AnOpz5dRLxR8Uu7ZvxZj3zkSmaKnELJSfJIP5mqE3j/K7fOCu/X6nH8+l699FBNAvWSSiFynRQdxBNKNiO3hMaVLcINHTwdQBwO7XVOUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fST0s3pg9zKHMWX;
	Sat,  7 Mar 2026 11:15:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 80BD240590;
	Sat,  7 Mar 2026 11:15:19 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP2 (Coremail) with SMTP id Syh0CgAXQgdGmKtpgE8AAA--.2072S2;
	Sat, 07 Mar 2026 11:15:19 +0800 (CST)
Message-ID: <e497dbd2-4f8e-45c2-b227-1bf0634dd924@huaweicloud.com>
Date: Sat, 7 Mar 2026 11:15:18 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bpf-next v6 4/5] bpf, x86: Emit ENDBR for indirect jump targets
Content-Language: en-US
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Yonghong Song <yonghong.song@linux.dev>, Puranjay Mohan
 <puranjay@kernel.org>, Anton Protopopov <a.s.protopopov@gmail.com>,
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
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <c79adbee77ba5ce11d3df1ffa922c48937c8b536.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgAXQgdGmKtpgE8AAA--.2072S2
X-Coremail-Antispam: 1UD129KBjvJXoW3XF4rtr4fZF1kAFy8KF18uFg_yoWxKF1fpa
	9rJFZ2vFZ8WrWqyrn7XF42yF9FkF4qgryxWF45t3y5ZwsxWr95WF1aga4avFWFk34fGr4f
	Xa4qkrnrua4ku37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7
	CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAq
	x4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6x
	CaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8
	ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
	CY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07jzE__UUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 3/7/2026 9:36 AM, Eduard Zingerman wrote:
> On Fri, 2026-03-06 at 18:23 +0800, Xu Kuohai wrote:
>> From: Xu Kuohai <xukuohai@huawei.com>
>>
>> On CPUs that support CET/IBT, the indirect jump selftest triggers
>> a kernel panic because the indirect jump targets lack ENDBR
>> instructions.
>>
>> To fix it, emit an ENDBR instruction to each indirect jump target. Since
>> the ENDBR instruction shifts the position of original jited instructions,
>> fix the instruction address calculation wherever the addresses are used.
>>
>> For reference, below is a sample panic log.
>>
>>   Missing ENDBR: bpf_prog_2e5f1c71c13ac3e0_big_jump_table+0x97/0xe1
>>   ------------[ cut here ]------------
>>   kernel BUG at arch/x86/kernel/cet.c:133!
>>   Oops: invalid opcode: 0000 [#1] SMP NOPTI
>>
>>   ...
>>
>>    ? 0xffffffffc00fb258
>>    ? bpf_prog_2e5f1c71c13ac3e0_big_jump_table+0x97/0xe1
>>    bpf_prog_test_run_syscall+0x110/0x2f0
>>    ? fdget+0xba/0xe0
>>    __sys_bpf+0xe4b/0x2590
>>    ? __kmalloc_node_track_caller_noprof+0x1c7/0x680
>>    ? bpf_prog_test_run_syscall+0x215/0x2f0
>>    __x64_sys_bpf+0x21/0x30
>>    do_syscall_64+0x85/0x620
>>    ? bpf_prog_test_run_syscall+0x1e2/0x2f0
>>
>> Fixes: 493d9e0d6083 ("bpf, x86: add support for indirect jumps")
>> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
>> ---
>>   arch/x86/net/bpf_jit_comp.c | 23 +++++++++++++++--------
>>   1 file changed, 15 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> index 2c57ee446fc9..752331a64fc0 100644
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
>> @@ -1658,8 +1658,8 @@ static int emit_spectre_bhb_barrier(u8 **pprog, u8 *ip,
>>   	return 0;
>>   }
>>   
>> -static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image,
>> -		  int oldproglen, struct jit_context *ctx, bool jmp_padding)
>> +static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *addrs, u8 *image,
>> +		  u8 *rw_image, int oldproglen, struct jit_context *ctx, bool jmp_padding)
>>   {
>>   	bool tail_call_reachable = bpf_prog->aux->tail_call_reachable;
>>   	struct bpf_insn *insn = bpf_prog->insnsi;
>> @@ -1743,6 +1743,11 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
>>   				dst_reg = X86_REG_R9;
>>   		}
>>   
>> +#ifdef CONFIG_X86_KERNEL_IBT
>> +		if (bpf_insn_is_indirect_target(env, bpf_prog, i - 1))
>> +			EMIT_ENDBR();
>> +#endif
>> +
>>   		switch (insn->code) {
>>   			/* ALU */
>>   		case BPF_ALU | BPF_ADD | BPF_X:
>> @@ -2449,7 +2454,7 @@ st:			if (is_imm8(insn->off))
>>   
>>   			/* call */
>>   		case BPF_JMP | BPF_CALL: {
>> -			u8 *ip = image + addrs[i - 1];
>> +			u8 *ip = image + addrs[i - 1] + (prog - temp);
> 
> Sorry, meant to reply to v5 but got distracted.
> It seems tedious/error prone to have this addend at each location,
> would it be possible to move the 'ip' variable calculation outside
> of the switch? It appears that at each point there would be no
> EMIT invocations between 'ip' computation and usage.
>

Besides the changes shown in this patch, there is another line in the
file computing address using 'image + addrs[i - 1] + (prog - temp)'.

It is at the call to emit_return() in the 'BPF_JMP | BPF_EXIT' case.
But there are indeed EMIT*() invocations before the address copmutation,
so a pre-computed address before the switch statement is stale in
this case.

To fix this, how about introducing a macro for the address computation,
as the following diff (based on this patch) shows:

--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1606,6 +1606,8 @@ static void emit_priv_frame_ptr(u8 **pprog, void __percpu *priv_frame_ptr)

  #define INSN_SZ_DIFF (((addrs[i] - addrs[i - 1]) - (prog - temp)))

+#define CURR_IP      (image + addrs[i - 1] + (prog - temp))
+
  #define __LOAD_TCC_PTR(off)                    \
         EMIT3_off32(0x48, 0x8B, 0x85, off)
  /* mov rax, qword ptr [rbp - rounded_stack_depth - 16] */
@@ -2454,7 +2456,7 @@ st:                       if (is_imm8(insn->off))

                         /* call */
                 case BPF_JMP | BPF_CALL: {
-                       u8 *ip = image + addrs[i - 1] + (prog - temp);
+                       u8 *ip = CURR_IP;

                         func = (u8 *) __bpf_call_base + imm32;
                         if (src_reg == BPF_PSEUDO_CALL && tail_call_reachable) {
@@ -2480,7 +2482,7 @@ st:                       if (is_imm8(insn->off))
                                 emit_bpf_tail_call_direct(bpf_prog,
                                                           &bpf_prog->aux->poke_tab[imm32 - 1],
                                                           &prog,
-                                                         image + addrs[i - 1] + (prog - temp),
+                                                         CURR_IP,
                                                           callee_regs_used,
                                                           stack_depth,
                                                           ctx);
@@ -2489,7 +2491,7 @@ st:                       if (is_imm8(insn->off))
                                                             &prog,
                                                             callee_regs_used,
                                                             stack_depth,
-                                                           image + addrs[i - 1] + (prog - temp),
+                                                           CURR_IP,
                                                             ctx);
                         break;

@@ -2654,8 +2656,7 @@ st:                       if (is_imm8(insn->off))
                         break;

                 case BPF_JMP | BPF_JA | BPF_X:
-                       emit_indirect_jump(&prog, insn->dst_reg,
-                                          image + addrs[i - 1] + (prog - temp));
+                       emit_indirect_jump(&prog, insn->dst_reg, CURR_IP);
                         break;
                 case BPF_JMP | BPF_JA:
                 case BPF_JMP32 | BPF_JA:
@@ -2745,7 +2746,7 @@ st:                       if (is_imm8(insn->off))
                         ctx->cleanup_addr = proglen;
                         if (bpf_prog_was_classic(bpf_prog) &&
                             !ns_capable_noaudit(&init_user_ns, CAP_SYS_ADMIN)) {
-                               u8 *ip = image + addrs[i - 1] + (prog - temp);
+                               u8 *ip = CURR_IP;

                                 if (emit_spectre_bhb_barrier(&prog, ip, bpf_prog))
                                         return -EINVAL;
@@ -2761,7 +2762,7 @@ st:                       if (is_imm8(insn->off))
                         EMIT1(0xC9);         /* leave */
                         bpf_prog->aux->ksym.fp_end = prog - temp;

-                       emit_return(&prog, image + addrs[i - 1] + (prog - temp));
+                       emit_return(&prog, CURR_IP);
                         break;

Would it make sense?

>>   
>>   			func = (u8 *) __bpf_call_base + imm32;
>>   			if (src_reg == BPF_PSEUDO_CALL && tail_call_reachable) {
>> @@ -2474,7 +2479,8 @@ st:			if (is_imm8(insn->off))
>>   			if (imm32)
>>   				emit_bpf_tail_call_direct(bpf_prog,
>>   							  &bpf_prog->aux->poke_tab[imm32 - 1],
>> -							  &prog, image + addrs[i - 1],
>> +							  &prog,
>> +							  image + addrs[i - 1] + (prog - temp),
>>   							  callee_regs_used,
>>   							  stack_depth,
>>   							  ctx);
>> @@ -2483,7 +2489,7 @@ st:			if (is_imm8(insn->off))
>>   							    &prog,
>>   							    callee_regs_used,
>>   							    stack_depth,
>> -							    image + addrs[i - 1],
>> +							    image + addrs[i - 1] + (prog - temp),
>>   							    ctx);
>>   			break;
>>   
>> @@ -2648,7 +2654,8 @@ st:			if (is_imm8(insn->off))
>>   			break;
>>   
>>   		case BPF_JMP | BPF_JA | BPF_X:
>> -			emit_indirect_jump(&prog, insn->dst_reg, image + addrs[i - 1]);
>> +			emit_indirect_jump(&prog, insn->dst_reg,
>> +					   image + addrs[i - 1] + (prog - temp));
>>   			break;
>>   		case BPF_JMP | BPF_JA:
>>   		case BPF_JMP32 | BPF_JA:
>> @@ -2738,7 +2745,7 @@ st:			if (is_imm8(insn->off))
>>   			ctx->cleanup_addr = proglen;
>>   			if (bpf_prog_was_classic(bpf_prog) &&
>>   			    !ns_capable_noaudit(&init_user_ns, CAP_SYS_ADMIN)) {
>> -				u8 *ip = image + addrs[i - 1];
>> +				u8 *ip = image + addrs[i - 1] + (prog - temp);
>>   
>>   				if (emit_spectre_bhb_barrier(&prog, ip, bpf_prog))
>>   					return -EINVAL;
>> @@ -3800,7 +3807,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
>>   	for (pass = 0; pass < MAX_PASSES || image; pass++) {
>>   		if (!padding && pass >= PADDING_PASSES)
>>   			padding = true;
>> -		proglen = do_jit(prog, addrs, image, rw_image, oldproglen, &ctx, padding);
>> +		proglen = do_jit(env, prog, addrs, image, rw_image, oldproglen, &ctx, padding);
>>   		if (proglen <= 0) {
>>   out_image:
>>   			image = NULL;

