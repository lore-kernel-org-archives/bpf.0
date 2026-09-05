Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6B918DB2A;
	Sat,  5 Sep 2026 08:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788596172; cv=none; b=NElfBnU7Jc1+9DWUvlXhJMsy9O4Mneyb+jFun1VpQXNgmExnQ2VcfI4KrL2dcIkmx5jJShfFKDrcHrlLOd42SVfOI8lXHg8oOVokWQQ3kR4AWWqc4qFWHJ8Awnvm79clDJ6qNNbmtD8Rp6xxBxMaSziEwvzscpsoxu3gJCOycMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788596172; c=relaxed/simple;
	bh=xL5zQubzqvBIINUPQX6ilEZyzsVDhnv1yyS6uLaRN2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xlv6HEbyCUyWIdIy8Syqjzr3VLqA/z+uxSRGRPKd0k2xzZeXVA4aSUbe/CRUCOb96OymbPCOeYBxn/5Dclw9VZ6qByPbVzoa1V9EQ99p+F9GmDvfHhGQ4VsBj4Cm584nUL2XfdCHQqQUuIX9pEbrzO5b5s4Pim0T3X93eootkRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hcR2q1hJtzKHMZ7;
	Sat,  5 Sep 2026 16:14:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id D44784058D;
	Sat,  5 Sep 2026 16:15:55 +0800 (CST)
Received: from [10.67.110.68] (unknown [10.67.110.68])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgAXeZa6z5tqr35UAw--.62946S2;
	Sat, 05 Sep 2026 16:15:55 +0800 (CST)
Message-ID: <f8b70ac8-62bb-47c9-8193-632b23a78d67@huaweicloud.com>
Date: Sat, 5 Sep 2026 16:15:54 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 2/3] riscv, bpf: Add BPF stack arguments
 support for RV64 JIT
Content-Language: en-US
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 jiangfeng@kylinos.cn
Cc: bjorn@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 puranjay@kernel.org, pjw@kernel.org, palmer@dabbelt.com, alex@ghiti.fr,
 pulehui@huawei.com, martin.lau@kernel.org, mason@kernel.org
References: <20260905070409.4141522-3-pulehui@huaweicloud.com>
 <fc702295c9ff5bdad0622a0aebbeadb040a0fabc0b79c6e904c968a516de859b@mail.kernel.org>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <fc702295c9ff5bdad0622a0aebbeadb040a0fabc0b79c6e904c968a516de859b@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgAXeZa6z5tqr35UAw--.62946S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtw4rGryDuw1ruw47Ww1rWFg_yoW7GrW7pF
	WUGFs3CrWqqw48JFyDtF4UZr43KrsYgF12kF18Ka45JFnIvrW8G3W3Ka1akry5Cry8X3Wr
	AFWqvrnxC3ykJ37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
	6r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUIbyZUUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/



On 2026/9/5 16:00, bot+bpf-ci@kernel.org wrote:
>> diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
>> index 419b9d795f2a..039877f286fc 100644
>> --- a/arch/riscv/net/bpf_jit.h
>> +++ b/arch/riscv/net/bpf_jit.h
>> @@ -82,6 +82,7 @@ struct rv_jit_context {
>>   	unsigned long flags;
>>   	int stack_size;
>>   	int tcc_offset;
>> +	int stack_arg_sz;
>>   	u64 arena_vm_start;
>>   	u64 user_vm_start;
>>   };
>> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
>> index aac128b9f0a4..cda99c1f9ffe 100644
>> --- a/arch/riscv/net/bpf_jit_comp64.c
>> +++ b/arch/riscv/net/bpf_jit_comp64.c
>> @@ -498,6 +498,18 @@ static void emit_ldx(u8 rd, s16 off, u8 rs, u8 size, bool sign_ext,
>>   	ctx->ex_jmp_off = ctx->ninsns;
>>   }
>>
>> +static void emit_stack_arg_ldx(u8 rd, s16 off, struct rv_jit_context *ctx)
>> +{
>> +	int idx = off / 8 - 1;
>> +
>> +	if (idx < 3) {
>> +		emit_mv(rd, RV_REG_A5 + idx, ctx);
>> +		return;
>> +	}
>> +
>> +	emit_ldx_insn(rd, (idx - 3) * 8, RV_REG_FP, BPF_DW, false, ctx);
>> +}
>> +
> 
> This isn't a bug, but the literal 3 appears seven times across this file
> and bpf_jit_core.c (lines 505, 510, 535, 540, 563, 568, and bpf_jit_core.c
> line 78). The value really represents RV_MAX_REG_ARGS - MAX_BPF_FUNC_REG_ARGS
> (8 - 5). The file already defines RV_MAX_REG_ARGS symbolically and uses it in
> the kfunc fix-up loop (if (idx < RV_MAX_REG_ARGS) / (idx - RV_MAX_REG_ARGS)),
> but the stack argument helpers use the literal instead.
> 
> Would a named constant (e.g. NR_STACK_ARG_REGS = RV_MAX_REG_ARGS -
> MAX_BPF_FUNC_REG_ARGS) placed in bpf_jit.h be worth it here, so the same
> value in bpf_jit_core.c and the three emit helpers cannot drift apart? arm64
> uses NR_STACK_ARG_REGS with an explicit stack_arg_reg[] table.

ok

> 
>>   static void emit_st(u8 rd, s16 off, s32 imm, u8 size, struct rv_jit_context *ctx)
>>   {
>>   	emit_imm(RV_REG_T1, imm, ctx);
>> @@ -515,6 +527,19 @@ static void emit_st(u8 rd, s16 off, s32 imm, u8 size, struct rv_jit_context *ctx
>>   	ctx->ex_jmp_off = ctx->ninsns;
>>   }
>>
>> +static void emit_stack_arg_st(s16 off, s32 imm, struct rv_jit_context *ctx)
>> +{
>> +	int idx = -off / 8 - 1;
>> +
>> +	emit_imm(RV_REG_T1, imm, ctx);
>> +	if (idx < 3) {
>> +		emit_mv(RV_REG_A5 + idx, RV_REG_T1, ctx);
>> +		return;
>> +	}
>> +
>> +	emit_stx_insn(RV_REG_SP, (idx - 3) * 8, RV_REG_T1, BPF_DW, ctx);
>> +}
>> +
> 
> This isn't a bug, but for idx < 3 (the common case, covering BPF args 6-8),
> could this be emit_imm(RV_REG_A5 + idx, imm, ctx) directly, avoiding the
> RV_REG_T1 round trip and one instruction per store? The emit_imm then emit_mv
> sequence is carried over from emit_st() where materialising into a scratch
> register is unavoidable because the destination is memory. Here in the
> register case the immediate could be materialised straight into the
> destination. The two sibling helpers (emit_stack_arg_ldx, emit_stack_arg_stx)
> have no scratch use at all, and arm64's emit_stack_arg_store() writes the
> immediate path directly into the argument register.

very nice

> 
>> +static void emit_stx(u8 rd, s16 off, u8 rs, u8 size, struct rv_jit_context *ctx)
>> +{
>> +	if (is_12b_int(off)) {
>> @@ -531,6 +556,18 @@ static void emit_stx(u8 rd, s16 off, u8 rs, u8 size, struct rv_jit_context *ctx)
>>   	ctx->ex_jmp_off = ctx->ninsns;
>>   }
>>
>> +static void emit_stack_arg_stx(s16 off, u8 rs, struct rv_jit_context *ctx)
>> +{
>> +	int idx = -off / 8 - 1;
>> +
>> +	if (idx < 3) {
>> +		emit_mv(RV_REG_A5 + idx, rs, ctx);
>> +		return;
>> +	}
>> +
>> +	emit_stx_insn(RV_REG_SP, (idx - 3) * 8, rs, BPF_DW, ctx);
>> +}
>> +
> 
> [ ... ]
> 
>> diff --git a/arch/riscv/net/bpf_jit_core.c b/arch/riscv/net/bpf_jit_core.c
>> index cbfcd287ea16..ed48005568c8 100644
>> --- a/arch/riscv/net/bpf_jit_core.c
>> +++ b/arch/riscv/net/bpf_jit_core.c
>> @@ -48,6 +48,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
>>   	int pass = 0, prev_ninsns = 0, i;
>>   	struct rv_jit_data *jit_data;
>>   	struct rv_jit_context *ctx;
>> +	u16 stack_arg_cnt;
>>
>>   	if (!prog->jit_requested)
>>   		return prog;
>> @@ -71,6 +72,11 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
>>
>>   	ctx->arena_vm_start = bpf_arena_get_kern_vm_start(prog->aux->arena);
>>   	ctx->user_vm_start = bpf_arena_get_user_vm_start(prog->aux->arena);
>> +
>> +	stack_arg_cnt = bpf_out_stack_arg_cnt(env, prog);
>> +	/* First 3 stack args in regs, rest on stack */
>> +	ctx->stack_arg_sz = stack_arg_cnt > 3 ? round_up((stack_arg_cnt - 3) * 8, STACK_ALIGN) : 0;
>> +
>>   	ctx->prog = prog;
>>   	ctx->offset = kvzalloc_objs(int, prog->len);
>>   	if (!ctx->offset)
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33952202002

