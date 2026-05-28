Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022B63B6359
	for <bpf@vger.kernel.org>; Thu, 28 May 2026 14:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779978229; cv=pass; b=B6ZkxuRYOfA6cmT2Ze5/LMVMSGG0sHJZAs/JOqym+P0H8VXRGSMV+xIDB+ISmz+bHZfTQKczMvLR0YJh6pLunD7BpZ9rgh/BMwXOtTs5o1xV+HmJ+kKagVYF1sslPSkTG5GwWDf2KtY7Mihb4XnLUwMgqAF7yeyIHkL2acythXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779978229; c=relaxed/simple;
	bh=8mRoMx2Oc3B+Yugix5ihq/IYgz2XGH4JFKPNJ8/T5n8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LCnpV0uUBIkNmm/yTqiFIE5xyd5Sd4Gp22a9w8XGJhQzRne5aBeKZVqgLavzs5MRWy5gp8b4sbR5vZK1l0Btt/R1qLQEf7uZ/6s05fLXCm9KHJLgAkgy0oy7VXhqdMoEeOqKSZaaBNH8a7Zo9yYy5uS3HY1chdCe/SALf0GuYHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JOi3KCOu; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOi3KCOu"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-68ae265815aso1506650a12.1
        for <bpf@vger.kernel.org>; Thu, 28 May 2026 07:23:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779978226; cv=none;
        d=google.com; s=arc-20240605;
        b=HyqsW9C5j/7HGLzL9t2CituJAcM5PxmFGEhG8bUMIRspjhLlkOFccY7FOjs8eWl9UR
         d/FADap0ucreM7z23b4ZPw162GiW3ZW+gsKwpol0d/RgyN564iE/SzWUrumYwy147fWN
         N+3Qtyy2XTu/0fmgMon6PLzgRk64GoA7nYzZwqARGRrHGQWqeWACQAfTJ59JUwVpV2/s
         KFmJo5Rm+lvNd47ETrJObtHiBzFQZf5vVdecFKyrfUjLmBZyf5+YYC1r5OdFL/Hkkzrw
         +OQMh1sLBoQuZNOCeA1VevLG8nBIHIjdhP59njyK+EbayY5xvVtuv992tL7V2cbbbEUc
         qTSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=123Sb8xW7IFMcJuJcw7GfUYEiZQJLjxktTy++FJHDN8=;
        fh=ImV7wcOWCAIiSwmXuLCYiZW79zWvfoaz2vqrD/XVaNI=;
        b=T9c0mxxU4yQj1AXcQasulWXDJMWn111EVxnuiLiyu5X4MLL+cZJEGglrduI0g4UvsN
         VhcxnN+eBQLXwl3U3k0Qy0XiFb3wXOjfo/mcDYApy4TKoSk+mVDhw1/DgAhc0vfCBFIZ
         FpYLrl3hbv9fYFtq4Tlt5pc9vBFk5Mg0mwswRKBcoXb8vmsKw9wFWD8AatMqejh54iEZ
         eBLcvC26kIYMlB4c7deCwST7639zMVRfmq2zI87iLlO/8KG+/EA8+vb4eS00lO3VdyHk
         ITQbfY8Jnnlo05YiVnre6fUtn2unrYA5KFr8y0UMhmPYckrbYXWMaYswUDSukMhB+xpM
         Y79A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779978226; x=1780583026; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=123Sb8xW7IFMcJuJcw7GfUYEiZQJLjxktTy++FJHDN8=;
        b=JOi3KCOut0hZV+p9m8yCA6sGwuXia3v899aC8Rb35rG4SuZYPdn2AoNklZkIH+FzQ2
         MRDKVwf8l3Pxz5cf4ugPPqISmpGEBg124zCZQiY/6GxZgcSJH89qd/s4YwOuT8pMyXjE
         oBrZLsew/gdzIklYv62EAoXhx30ST0koXeSfqypsH5t3lg3eWWfq9c9efAJNZCrhG5We
         tlyXqkKTOMpWydBIyOxpQITcY1GiyL4gq7t/7656c0+UnWGJ+OlNxtBmid97DuhuyrAp
         qt+N/PoXuilRR03CUMOB1aZjDOPDOlAzLHddTuTr7VPv8BLfuzcUs7rSce00r5POSAy4
         48YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779978226; x=1780583026;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=123Sb8xW7IFMcJuJcw7GfUYEiZQJLjxktTy++FJHDN8=;
        b=Ou2YshTN85XI3tunJfi5vENhAAsQnjbJVotUQMVmUpC7qusYtfocPbLDnY4J2UR8v2
         WA+FZondoRlz27w9/A0POCyF+eHYKXjka3YtQrSpbvuAyW3LUc8Ert2m444Zk8sQr606
         Ud9PmJ8WgRCxw3ptpVDOw9xjXRX86FelFW5JUUwS58FbaXZ+l1opoOKaxhJaO49b4eil
         mPyJZRA6WOjoPFOzRNsNTlbv9hJzmlICTrCAgwMEiAKCzKYCt6zFAS8RzSqcGbY3fBsG
         FErpPKGPNH+R9QywAeMKITrJlxWGGr7mldn7ox7mfIK0D2vkUIlfe0uFvAsUcYrpySX+
         q/9w==
X-Gm-Message-State: AOJu0YytUHmtTEO7bnpuz4417qzasKglKdHSBtxbtj8jFMW5UcpzGZi1
	PJxadLIJccGdl6jMkCo3bWJUIBIaj7QTXkNZXWF/LchppivsXNKZSgvZ5vD61DVb86r2PvZYI8z
	/dSqYySA3jJn5NZFNnmvdLk8Wdy7bUrg=
X-Gm-Gg: Acq92OFTQZjO1ljP03tlrIdAkH0LgYnr6GKfigsL2ldotWv0bzGkxbZFI6B3MMtpGPR
	EXRnze1/Mgswk6GsMjlwQV+2kFEay82A6TIMiGcG9mh8b5yTANugrSjpqM904gLTsafM6P8lRqD
	pQFeAiKeBFy50kEN0fkjZFfQkRolqZCsdhvpJW2NAK2UaopLV247spg92l57AfRTTELfeZb7xov
	AT01u/jAyMCq1mBN4xgFMY9S8LggSFMW255DF5J9oOsSquwetgG6PoBnVc3M9dyG33aGstO0pgE
	d22/7nOI3oh8Qk2dZm/FjNP9s/i60WIWQGk32qkGdWc4
X-Received: by 2002:a05:6402:320f:b0:688:1697:ab72 with SMTP id
 4fb4d7f45d1cf-6889cc66198mr15216309a12.26.1779978226023; Thu, 28 May 2026
 07:23:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427234801.2104511-1-puranjay@kernel.org> <20260427234801.2104511-3-puranjay@kernel.org>
 <ahhGbFY_4Dai1NjR@willie-the-truck>
In-Reply-To: <ahhGbFY_4Dai1NjR@willie-the-truck>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Thu, 28 May 2026 15:23:32 +0100
X-Gm-Features: AVHnY4LMDXcfZ1LqI3sJaif56UHbwagykFTXGHoWIwt3IHTuM31YvK58EmfPoYk
Message-ID: <CANk7y0j6JecSuJVZg1phn2tSHrcHPDqqmoaDBy1LdnMo-1qsFg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/3] bpf, arm64: Add JIT support for stack arguments
To: Will Deacon <will@kernel.org>
Cc: bpf@vger.kernel.org, Yonghong Song <yonghong.song@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Xu Kuohai <xukuohai@huaweicloud.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hi Will,

Thanks for your review.
These patches have already landed in bpf-next tree as a part of this
series: https://lore.kernel.org/all/20260513044949.2382019-1-yonghong.song@linux.dev/

I will take all your feedback and send fixes for all the required changes.

> How does that work with kfuncs? I think the PCS means that they will
> expect to pick the stack arguments starting at [SP+0]. Or are you
> saying that SP == FP+16 on entry to the callee? It's hard to reconcile
> that with the ASCII art in build_prologue() because neither "current
> A64_FP" nor "BPF_FP" point below A64_SP and it's not clear which of them
> you're referring to when you refer to "FP" on its own.

At entry to kfunc the arguments are starting at [SP+0] like a normal C
callee function would expect.

The line "callee reads them from [FP+16], [FP+24]" is for a BPF callee
which always emits a frame record.
So the caller puts the arguments at SP+0, SP+8, .. and then the callee
creates the frame record in the prologue which means the first
argument is at FP+16, ....
This is just an implementation detail about how the JITed BPF callee
programs can read stack arguments from FP+16, ... easily.

>
> > BPF convention uses fixed offsets from BPF_REG_PARAMS (r11): off=-8 is
> > always arg 6, off=-16 arg 7, etc. The verifier invalidates all outgoing
> > stack arg slots after each call, so the compiler must re-store before
> > every call. This means x5-x7 don't need to be saved on stack.
> >
> > Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> > ---
> >  arch/arm64/net/bpf_jit_comp.c | 87 ++++++++++++++++++++++++++++++++++-
> >  1 file changed, 86 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> > index 085e650662e3..cd8279880795 100644
> > --- a/arch/arm64/net/bpf_jit_comp.c
> > +++ b/arch/arm64/net/bpf_jit_comp.c
> > @@ -86,6 +86,7 @@ struct jit_ctx {
> >       __le32 *image;
> >       __le32 *ro_image;
> >       u32 stack_size;
> > +     u16 stack_arg_size;
> >       u64 user_vm_start;
> >       u64 arena_vm_start;
> >       bool fp_used;
> > @@ -533,13 +534,19 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf)
> >        *                        |     |
> >        *                        +-----+ <= (BPF_FP - prog->aux->stack_depth)
> >        *                        |RSVD | padding
> > -      * current A64_SP =>      +-----+ <= (BPF_FP - ctx->stack_size)
> > +      *                        +-----+ <= (BPF_FP - ctx->stack_size)
> > +      *                        |     |
> > +      *                        | ... | outgoing stack args (9+, if any)
> > +      *                        |     |
> > +      * current A64_SP =>      +-----+
> >        *                        |     |
> >        *                        | ... | Function call stack
> >        *                        |     |
> >        *                        +-----+
> >        *                          low
> >        *
> > +      * Stack args 6-8 are passed in x5-x7, args 9+ at [SP].
> > +      * Incoming args 9+ are at [FP + 16], [FP + 24], ...
> >        */
>
> I assume the arguments being passed are all <= 64-bit scalar types? If
> we ever want to pass anything with > 64-bit alignment or to a varargs
> function, then the rules for allocation get a little hairy.

Yes, right now only 64-bit scalars are supported.

>
> >       emit_kcfi(is_main_prog ? cfi_bpf_hash : cfi_bpf_subprog_hash, ctx);
> > @@ -613,6 +620,9 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf)
> >       if (ctx->stack_size && !ctx->priv_sp_used)
> >               emit(A64_SUB_I(1, A64_SP, A64_SP, ctx->stack_size), ctx);
> >
> > +     if (ctx->stack_arg_size)
> > +             emit(A64_SUB_I(1, A64_SP, A64_SP, ctx->stack_arg_size), ctx);
>
> How do you ensure that the stack pointer is always 16-byte aligned? We
> run with SP alignment checking enabled, so you need to take care of that.

Down below as you have already found, stack_arg_size is always aligned.

>
> > @@ -1191,6 +1207,41 @@ static int add_exception_handler(const struct bpf_insn *insn,
> >       return 0;
> >  }
> >
> > +static const u8 stack_arg_reg[] = { A64_R(5), A64_R(6), A64_R(7) };
> > +
> > +#define NR_STACK_ARG_REGS    ARRAY_SIZE(stack_arg_reg)
> > +
> > +static void emit_stack_arg_load(u8 dst, s16 bpf_off, struct jit_ctx *ctx)
> > +{
> > +     int idx = bpf_off / sizeof(u64) - 1;
> > +
> > +     if (idx < NR_STACK_ARG_REGS)
> > +             emit(A64_MOV(1, dst, stack_arg_reg[idx]), ctx);
> > +     else
> > +             emit(A64_LDR64I(dst, A64_FP, (idx - NR_STACK_ARG_REGS) * sizeof(u64) + 16), ctx);
> > +}
>
> Is it worth asserting that bpf_off >= 8 here or can we rely on that? I
> struggled to find any details about how bpf passes arguments on the
> stack (beyond what you describe in the commit message) and grepping for
> BPF_REG_PARAMS didn't help either.

This and other patches in this set has more information about this:
https://lore.kernel.org/all/20260513045015.2385013-1-yonghong.song@linux.dev/

>
> > +static void emit_stack_arg_store(u8 src_a64, s16 bpf_off, struct jit_ctx *ctx)
> > +{
> > +     int idx = -bpf_off / sizeof(u64) - 1;
> > +
> > +     if (idx < NR_STACK_ARG_REGS)
> > +             emit(A64_MOV(1, stack_arg_reg[idx], src_a64), ctx);
> > +     else
> > +             emit(A64_STR64I(src_a64, A64_SP, (idx - NR_STACK_ARG_REGS) * sizeof(u64)), ctx);
> > +}
> > +
> > +static void emit_stack_arg_store_imm(s32 imm, s16 bpf_off, const u8 tmp, struct jit_ctx *ctx)
> > +{
> > +     int idx = -bpf_off / sizeof(u64) - 1;
> > +
> > +     emit_a64_mov_i(1, tmp, imm, ctx);
> > +     if (idx < NR_STACK_ARG_REGS)
> > +             emit(A64_MOV(1, stack_arg_reg[idx], tmp), ctx);
>
> nit: You seem to have redundant MOVs here.

Ack, will fix this.

>
> > @@ -2065,6 +2137,14 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
> >       ctx.user_vm_start = bpf_arena_get_user_vm_start(prog->aux->arena);
> >       ctx.arena_vm_start = bpf_arena_get_kern_vm_start(prog->aux->arena);
> >
> > +     if (prog->aux->stack_arg_depth > prog->aux->incoming_stack_arg_depth) {
> > +             u16 outgoing = prog->aux->stack_arg_depth - prog->aux->incoming_stack_arg_depth;
> > +             int nr_on_stack = outgoing / sizeof(u64) - NR_STACK_ARG_REGS;
> > +
> > +             if (nr_on_stack > 0)
> > +                     ctx.stack_arg_size = round_up(nr_on_stack * sizeof(u64), 16);
> > +     }
>
> ah, that's presumably where you handle the SP alignment. I think a
> comment would really help folks here... In fact, how does this interact
> with the same sort of SP adjustment that already exists in build_prologue()?
> Can we avoid the pointless re-alignment?

Yeah, you are right, if ctx->stack_size + ctx-> stack_arg_size is
aligned then we don't need to separately align these two, I can move
this from here and consolidate it in the build_prologue() function and
also add a comment there.

> Will
