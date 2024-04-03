Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E2C1429B
	for <bpf@vger.kernel.org>; Wed,  3 Apr 2024 02:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712111708; cv=none; b=D2xrOxiNs700wsc3DEF7rJrlo4ADpYatKHgH8nIFvZDtA2FkvIELlrKAcdVWeCf9wFxb8oBLEFf4T820un0+POU9zkogPZA2WdQykC3ZY8MsLflWR1rGVQzLUtkCuoiTq0CyalQDAwgJjLBfiHrpP1n4PdXLcnEBBU+yQt6tpPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712111708; c=relaxed/simple;
	bh=pEfzIA2pIDI6iif8Maz/zzM8LZcdgFDTKcXo66cqeug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HaR0M1x9iS1/XZqtWyAjvsBRkJmRhZiD0HrfvbRceKlhsILntIqBVkFRpx0n/wh0FBf0uRyBvv4q13NTNE9MDgYfMgTKZUBtTl/29Lz9/3FTEF/QwV1QHP7bsQ8gQs6itlZjWZ4hiqmoOtGzxsU/JdvmO/JMP8160MM/4jnr5hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FcVlomxy; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FcVlomxy"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-34356f794a5so1646766f8f.1
        for <bpf@vger.kernel.org>; Tue, 02 Apr 2024 19:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712111704; x=1712716504; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GY/+7MRQ3fbQxjY6jKn9o7TAy8ibTll8+RQOy9JYKpE=;
        b=FcVlomxyTdOVVcrI5lGuyPbmoppWc02COh8g1rjy4SETy8Fjrwb1S4ajnU3esE2bhy
         fQh/qcczQR3pHaczgepsav7W8I03+BeP9iJk4pbzTwvEfx5QH4hqJ+Im/Sx4klhkYtNW
         vPmujwI5GxWivgJwhCxeU350JvQ2vgHRvTcodpJEjyNZ21r0+d1W4V4FmOLdC5sOWL14
         GibUP/UCfKZCZXCD5gskHWMzMyBSFXOaKrgTqfmdK2kCWngfyymzOYjGnDzd/Qwn/0Ai
         maXVkx3i17YRq2aXEMu2MaYA+aI+h+GWcyFK+Z4axNsZcRO2I3P5nQ9CT3XZht/erv/z
         DRCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712111704; x=1712716504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GY/+7MRQ3fbQxjY6jKn9o7TAy8ibTll8+RQOy9JYKpE=;
        b=lt6ZMlwTZPKVczVSlWmHDzL7sCx3dFLYz9Y/XI7gVQhjpi+/9SCXObW8/O230es0NB
         vvbXjJXjLCDDjBgPiVfpAa2zWuahqdX/rYqXeKTBUoSBIHDSZuTzu9LSV2zeEhLZMQG3
         wNDAirm0D9NSuWrJH+Ru2uj+ma0alkQCSgJfaQmS/dy/iZMylprJ0qH7St0JpzbtVXXo
         UbUndjATGH6J9vsraa9SBHAOnyVQG1UDqT1U7z2pUMbbsSam/SFT8myGT2YKL2CfbDfA
         nfocSHHcZA9NrqCYsHa84r5p1gVF3GojrMmlA39GVlKGwBicQg7JWxo1jisTPXrWwg9I
         ZTHg==
X-Gm-Message-State: AOJu0YymAPXka1EyKjwfub/JhKkxExqFrCdM2eZCf/0swUL1oFMwf8h7
	e7R8L80k3gFBCRYLrWi8LgZnphYkylw/mQyQ0TFijsg/Igo4eAnpnhCdubaVmEwKme9+wODgDx3
	ayNqoGEeiCSfpMVmGnrLZjzVmqUQ=
X-Google-Smtp-Source: AGHT+IGND2TQ2aX4W5a9lMGEt230r2QTPwkao59RffKxtmo33IbBGZ1RsVD5sVlCM9C7E5qI/REWejHso305hDFqpKs=
X-Received: by 2002:a5d:51c7:0:b0:341:e367:e7bf with SMTP id
 n7-20020a5d51c7000000b00341e367e7bfmr2931426wrv.69.1712111704286; Tue, 02 Apr
 2024 19:35:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401233800.42737-1-alexei.starovoitov@gmail.com> <ec622bce-eb17-e774-db03-7541a31661f4@iogearbox.net>
In-Reply-To: <ec622bce-eb17-e774-db03-7541a31661f4@iogearbox.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 2 Apr 2024 19:34:52 -0700
Message-ID: <CAADnVQKFfpY-QZBrOU2CG8v2du8Lgyb7MNVmOZVK_yTyOdNbBA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Optimize emit_mov_imm64().
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eddy Z <eddyz87@gmail.com>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 8:48=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.ne=
t> wrote:
>
> On 4/2/24 1:38 AM, Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > Turned out that bpf prog callback addresses, bpf prog addresses
> > used in bpf_trampoline, and in other cases the 64-bit address
> > can be represented as sign extended 32-bit value.
> > According to https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D82339
> > "Skylake has 0.64c throughput for mov r64, imm64, vs. 0.25 for mov r32,=
 imm32."
> > So use shorter encoding and faster instruction when possible.
> >
> > Special care is needed in jit_subprogs(), since bpf_pseudo_func()
> > instruction cannot change its size during the last step of JIT.
> >
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > ---
> >   arch/x86/net/bpf_jit_comp.c |  5 ++++-
> >   kernel/bpf/verifier.c       | 13 ++++++++++---
> >   2 files changed, 14 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > index 3b639d6f2f54..47abddac6dc3 100644
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -816,9 +816,10 @@ static void emit_mov_imm32(u8 **pprog, bool sign_p=
ropagate,
> >   static void emit_mov_imm64(u8 **pprog, u32 dst_reg,
> >                          const u32 imm32_hi, const u32 imm32_lo)
> >   {
> > +     u64 imm64 =3D ((u64)imm32_hi << 32) | (u32)imm32_lo;
> >       u8 *prog =3D *pprog;
> >
> > -     if (is_uimm32(((u64)imm32_hi << 32) | (u32)imm32_lo)) {
> > +     if (is_uimm32(imm64)) {
> >               /*
> >                * For emitting plain u32, where sign bit must not be
> >                * propagated LLVM tends to load imm64 over mov32
> > @@ -826,6 +827,8 @@ static void emit_mov_imm64(u8 **pprog, u32 dst_reg,
> >                * 'mov %eax, imm32' instead.
> >                */
> >               emit_mov_imm32(&prog, false, dst_reg, imm32_lo);
> > +     } else if (is_simm32(imm64)) {
> > +             emit_mov_imm32(&prog, true, dst_reg, imm32_lo);
> >       } else {
> >               /* movabsq rax, imm64 */
> >               EMIT2(add_1mod(0x48, dst_reg), add_1reg(0xB8, dst_reg));
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index edb650667f44..d4a338e7b5e7 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -19145,12 +19145,19 @@ static int jit_subprogs(struct bpf_verifier_e=
nv *env)
> >               env->insn_aux_data[i].call_imm =3D insn->imm;
> >               /* point imm to __bpf_call_base+1 from JITs point of view=
 */
> >               insn->imm =3D 1;
> > -             if (bpf_pseudo_func(insn))
> > +             if (bpf_pseudo_func(insn)) {
> > +#if defined(MODULES_VADDR)
> > +                     u64 addr =3D MODULES_VADDR;
> > +#else
> > +                     u64 addr =3D VMALLOC_START;
> > +#endif
>
> Is this beneficial for all archs? It seems this patch is mainly targettin=
g x86.
> Why not having a weak function like u64 bpf_jit_alloc_exec_start() which =
returns
> the MODULES_VADDR for x86, but leaves the rest as-is?
>
> For example, arm64 has MODULES_VADDR defined, but the allocator uses vmal=
loc
> range instead, see bpf_jit_alloc_exec() there, so this is a different poo=
l and
> it's also not clear if this is better or worse wrt its imm encoding.

This part makes no difference for all JITs except x86.
Back when commit 3990ed4c4266 ("bpf: Stop caching subprog index in the
bpf_pseudo_func insn")
added the comment below: "jit (e.g. x86_64) may emit fewer instructions"
pseudo_func-s were introduced for x86 and only x86 JIT has this behavior.
Since then other JITs added support for pseudo_func-s, but none
of them rely on this part of the verifier.
So the comment still applies to x86 only (afaics).
s390, riscv, arm64 went with: "if (bpf_pseudo_func)" process
ld_imm64 differently regardless of what is the value of
insn[0].imm, insn[1].imm.
I think it's a bit wrong.
I considered removing this if (bpf_pseudo_func(insn)) from verifier.c
and doing a similar hack in x86 jit, but decided against that.
The previous insn[1].imm =3D 1 was a hack targeted at x86.
It served its purpose for 3 years.
A hack, but imo cleaner than if (bpf_pseudo_func(insn)) in JITs.
Since I'm making emit_mov_imm64() smarter, there is a need to
make this part of the verifier.c a bit more accurate in terms of
value it represents.
MODULES_VADDR or VMALLOC_START doesn't make a difference.
It's a kernel text address. It could be an (long)&_text. fwiw.
I believe all JITs can potentially generalize
if (bpf_pseudo_func(insn)) check into if (kernel_addr(imm64)),
but that's a follow up for somebody.

weak helper bpf_jit_alloc_exec_start() is certainly an overkill.
pseudo_func callback doesn't have to be jit-ed bpf prog.
It's the address of the function.
If there is ever an arch where kernel and jit-ed code needs different
insns to represent an address then we will tackle such issue at that time.

Notice that we have similar #if defined(MODULES_VADDR)
logic in bpf_jit_alloc_exec_limit() that was added 6 years ago
and it's still fine. No need to over design this one either.

>
> >                       /* jit (e.g. x86_64) may emit fewer instructions
> >                        * if it learns a u32 imm is the same as a u64 im=
m.
> > -                      * Force a non zero here.
> > +                      * Set close enough to possible prog address.
> >                        */
> > -                     insn[1].imm =3D 1;
> > +                     insn[0].imm =3D (u32)addr;
> > +                     insn[1].imm =3D addr >> 32;
> > +             }
