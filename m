Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383423A5457
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 08:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776068041; cv=none; b=FjCoJ1LRebU6Y7SDS59entbOA9Di7L/WUBgJ5AHqAPfQ63UG+IEKeadfXU/8eaTwFJkV4I0ryKL34YRhhbgtTIYdbgeS2e6EkuFAunoRKqN1iL9IYCkGjjz3hkY3UQGoGNgPsWIJ6+MwQ5mBrn4pnkgf9uibmwpO+uldf1OGbGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776068041; c=relaxed/simple;
	bh=ntJPW3F9wCH+bnd+CBHM4WQZ6U/QVcZiqScx2Aax40s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rS9jtbtCJF5dvhiwlUbX2TF+3K4bz2IG/Mk6Ly5JEyuZsaQyRC10bzqjxal49gz4fP2oeo3KfP3hhXP+Qtqx6T/qm3dxr7Wk7jVkp/lN796kHAyhTgDLfxxI9nDl7sLcoEsa+DUK62/xhgzIFRHJglVGhs7IQqo3B1NvxJwA2hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [209.85.222.174])
	by gateway (Coremail) with SMTP id _____8DxLurEpdxpqBQAAA--.90S3;
	Mon, 13 Apr 2026 16:13:57 +0800 (CST)
Received: from mail-qk1-f174.google.com (unknown [209.85.222.174])
	by front1 (Coremail) with SMTP id qMiowJBxrsLCpdxpGPtrAA--.49244S2;
	Mon, 13 Apr 2026 16:13:56 +0800 (CST)
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8d4f78fc9f6so490033385a.3
        for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 01:13:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ87QL8IY1E9N4wnX8jzEsDQ3+V8G8gwtjjtq9rsPDEnneZfYtlFfCLsr3OpApx/8SWu9gg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnG1t2QAiNJFjUVEA2FEoSMFvMBh8HnzHlrv4PSGMFgJU5s0WD
	XUXX5s1nT9m2X8vcEssOTmn2Ty/1rMzHqanWnwHHbihSVyBuQhf8fDxAt4o9X64bLo7AHOUuO4K
	A0GLe8qWUDocEXkXPhmWGLLmfrU3ZCgNlrim6SU4YcA==
X-Received: by 2002:a53:d007:0:b0:651:c047:f094 with SMTP id
 956f58d0204a3-651c047f43amr3893314d50.31.1776067568854; Mon, 13 Apr 2026
 01:06:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413040506.26640-4-yangtiezhu@loongson.cn> <8822e0eb47985fc0bcb8bc6c9b0fcdfb55566144517d90a8e77f2690c44ee8df@mail.kernel.org>
In-Reply-To: <8822e0eb47985fc0bcb8bc6c9b0fcdfb55566144517d90a8e77f2690c44ee8df@mail.kernel.org>
From: WANG Rui <wangrui@loongson.cn>
Date: Mon, 13 Apr 2026 16:05:57 +0800
X-Gmail-Original-Message-ID: <CAHirt9gy=HETVpi6bOrUOw65N0wuVVSMG-0usMSAQKm7G4OQww@mail.gmail.com>
X-Gm-Features: AQROBzDo6XriASiqA6WQWtAVhetXPEwhLVNnHT93SmV1NrOhpV5lBoAQTMbGKwU
Message-ID: <CAHirt9gy=HETVpi6bOrUOw65N0wuVVSMG-0usMSAQKm7G4OQww@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] LoongArch: BPF: Support 8 and 16 bit
 read-modify-write instructions
To: bot+bpf-ci@kernel.org
Cc: yangtiezhu@loongson.cn, chenhuacai@kernel.org, hengqi.chen@gmail.com, 
	loongarch@lists.linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev, 
	clm@meta.com, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID:qMiowJBxrsLCpdxpGPtrAA--.49244S2
X-CM-SenderInfo: pzdqw2txl6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxWr18Zw18GrWUXr1fGFykJFc_yoWrXF4kpr
	y8Wrs5Cr4kJFyqv3s7Ja17JrWUKr4ay3W7Wr1UXrWYyayYvF98JF10kF17XFW5urZYyFWa
	vF4q9w12va1UtagCm3ZEXasCq-sJn29KB7ZKAUJUUUUk529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUtVW8ZwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	JVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r1q6r43MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jwtxhUUUUU=

On Mon, Apr 13, 2026 at 12:49=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.=
c
> > index fefda4050a20..c9a32f124f5e 100644
> > --- a/arch/loongarch/net/bpf_jit.c
> > +++ b/arch/loongarch/net/bpf_jit.c
>
> [ ... ]
>
> > @@ -388,11 +408,32 @@ static int emit_atomic_rmw(const struct bpf_insn =
*insn, struct jit_ctx *ctx)
> >       /* src =3D atomic_fetch_<op>(dst + off, src) */
> >       case BPF_ADD | BPF_FETCH:
> > +             switch (BPF_SIZE(insn->code)) {
> > +             case BPF_B:
> > +                     if (cpu_has_lam_bh) {
> > +                             emit_insn(ctx, amaddb, src, t1, t3);
> > +                             emit_zext_32(ctx, src, true);
>
> Is emit_zext_32() sufficient for zero-extending an 8-bit value here?
>
> emit_zext_32() uses lu32id to clear bits [63:32], but for a byte-width
> atomic fetch the returned value needs bits [63:8] zeroed. If amadd.b
> follows the LoongArch convention of sign-extending sub-word results
> (as amadd.w does for 32-bit values), then a byte value like 0x80 would
> produce 0x00000000ffffff80 after emit_zext_32() instead of the expected
> 0x0000000000000080.
>
> Elsewhere in this file, 16-bit zero-extension already uses bstrpickd:
>
>     emit_insn(ctx, bstrpickd, dst, dst, 15, 0);
>
> Should the BPF_B and BPF_H cases here use bstrpickd with the
> appropriate bit range (7,0 for bytes and 15,0 for halfwords) instead
> of emit_zext_32()?

I don't think truncating byte and sub-word results to only the low 8
or 16 bits is the right model here. The current behavior intentionally
keeps the low 32 bits of the computed value in the register, because
all uses explicitly extend from 32 bits to 64 bits when feeding
instructions that require 64-bit operands. The same reasoning should
apply to byte and sub-word types as well.

For example:

Def:
int8 a =3D amadd.b
int8 b =3D amadd.b

Use:
t1 =3D sext32 a
t2 =3D sext32 b
blt t1, t2   // a < b

Take a =3D -1 and b =3D 0. In the 64-bit registers:

If we keep the low 32 bits:
a: 0x0000_0000_ffff_ffff
b: 0x0000_0000_0000_0000

then:
t1: 0xffff_ffff_ffff_ffff
t2: 0x0000_0000_0000_0000

So a < b evaluates to true, as expected.

But if we only keep the low 8 bits:
a: 0x0000_0000_0000_00ff
b: 0x0000_0000_0000_0000

then:
t1: 0x0000_0000_0000_00ff
t2: 0x0000_0000_0000_0000

Now a < b becomes false, which is clearly not the intended result.

In other words, narrowing the result to 8 or 16 bits here would break
the existing 32-bit canonicalization rule for sub-word values.

More generally, the "always explicitly extend" pattern doesn't map
particularly well to the LoongArch ISA. In the long run, it would be
preferable if we could eliminate these explicit extensions altogether
rather than relying on them as part of the semantic model.

Thanks,
Rui


>
> > +             case BPF_H:
> > +                     if (cpu_has_lam_bh) {
> > +                             emit_insn(ctx, amaddh, src, t1, t3);
> > +                             emit_zext_32(ctx, src, true);
>
> Same concern for the halfword case -- emit_zext_32() would leave
> bits [31:16] with sign-extended values if amadd.h sign-extends.
>
> [ ... ]
>
> > @@ -421,11 +462,32 @@ static int emit_atomic_rmw(const struct bpf_insn =
*insn, struct jit_ctx *ctx)
> >       /* src =3D atomic_xchg(dst + off, src); */
> >       case BPF_XCHG:
> > +             switch (BPF_SIZE(insn->code)) {
> > +             case BPF_B:
> > +                     if (cpu_has_lam_bh) {
> > +                             emit_insn(ctx, amswapb, src, t1, t3);
> > +                             emit_zext_32(ctx, src, true);
>
> Same question applies to the exchange path -- amswap.b and amswap.h
> return the old value and would need proper sub-word zero-extension
> rather than the 32-bit emit_zext_32().
>
> > +             case BPF_H:
> > +                     if (cpu_has_lam_bh) {
> > +                             emit_insn(ctx, amswaph, src, t1, t3);
> > +                             emit_zext_32(ctx, src, true);
>
> Same here for amswap.h.
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/243253=
84786

