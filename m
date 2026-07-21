Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6673C2F28EA
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 10:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784631048; cv=pass; b=JSiivvfQgiLgTeyLfP2KeWxwdz2QWRV+76eLHVXv+dBBl6otLnfB7igkMA8Rk+B91wsXMxfqtw5I0Fr3RTidYbrB+wonba5t6Y3bX8wE3D6OMofD/LV93GiQkbC3BVLINaXIv3HnEP+Pj0lNTGHozJcSK1N9xFT6sZcWc8rSXfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784631048; c=relaxed/simple;
	bh=FD2qBEEJEg52EBbJVV0x07ldAlJ8YKs9yAYCv7Q+0Qw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LwgOpfo62y1xlTziUMJXs8jRjLvDwRbMn06oUIJEDB2yQLg9CuCHyQnvC/rMOEgGfDb4TuELNkMt8X7aU2DUfvLaKwcYbn4Pveu3Vn7YcmpocHYNQXCiRYvMdEK02+ZWQEHIodUqRqm3pjEPiia0kPNn3xs4lh1/RyDffWLTmHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EEJWLDJM; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEJWLDJM"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c1712a04ddaso828758066b.2
        for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 03:50:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784631046; cv=none;
        d=google.com; s=arc-20260327;
        b=YXZhi/LEKYwxzJ6ZBVfV8FqTjGB9kto30bdgPQyO2YiL9LurMvSi7Zq2SZ5Q9nFwfM
         VVq1FmQUikGLtv2/7wdDAIbJLRqzcTL2uNgLL0LPUqFc9eZoV3ARpPnaRskqlsByWqJ1
         bq2J6xh4w7OOyjZC9/GHqaBaJA+GGRHqjqITrhLu7xNjy8kTPFmD+oH3nSn8k9kxlMGE
         GTzzZPNkC+05gLWJUqrHPmDWDlSA8CJz2ZLRBZqq2e2rbNq+m6rkKaygI9703YIG18ev
         JOqMmhq/r/nD/5vU8w8jgjQk3Vf0fiz0biO9qajwVRRMnU28ft1IGpWR1Q9ZiMHS6hqZ
         gaZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OZ7Ck3L1TbvHHA4nu6GF+3IsvaSmEU69FtmMgRFQdQw=;
        fh=bN2qRFck4K/yiFqb+nTk2tLkxN36lnX9bHgzFx9oKNA=;
        b=YijeZ2RHdzlLITjt0iJkVF+JXe+ANdNtcy9LuW5aJIGVAEXpnu2hkZ0yV2bsea/Y/S
         XsHue1AxKAPBafyJbqy9bJo3AFNZRcZ6P4M98Lm6WYUu+x/aPpHfXbQrpTa5HUP/iVXh
         hmKmo+DDJWgfaVfETxvuGUKojRHA1t9YEFsNlXrBnxv2qoiKNWLf/O3oyNjMj9mTp107
         MFijsQBCd6OBfXSRLbUn6CA+XBki5zafzZIPN3q2a6PjqRDIoaj/pwItbdCpRl4laTIb
         vK/ISGOZ5pWnPP0XB6JfVrE7Fjkyb1G9r261AdPp8w7EohMw6f41WImFjcyvCAQfWwUc
         t0iw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784631046; x=1785235846; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OZ7Ck3L1TbvHHA4nu6GF+3IsvaSmEU69FtmMgRFQdQw=;
        b=EEJWLDJMilYhydDqjQtRzIusiLM42qENWQO4BvfpzUsExvOHXFJBE8ryUt0fb1rzzF
         VnMEvl+Um+fcE3qcasEs2mc5ydS8ZJtQeWIjUcNMlSuiM22IaASLEr2ISE/q5Le8KTvP
         dKlqpxKrv1v0OkDWdNgE/WcW/g32Mc0ap0N81R1FH0SvQfobuTPF2WZzYQflCikdlBT8
         VSoaHIH/bXrI5Dp0IkwqPGvyB/HBKiGDyodRSTlnjijonxqWMVk0WLYwucQLsSe9pzLp
         7skNbws459ZVj9f92GW0z2lMtNg0dnUwpqB50+q1NvJZzsBERsRwMbCE6ZKvswBrMp57
         dzQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784631046; x=1785235846;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OZ7Ck3L1TbvHHA4nu6GF+3IsvaSmEU69FtmMgRFQdQw=;
        b=noU984A3muar3zb4RoTaOTGFRcAA3OWyShc6nkpwcIHwub9cd759+apQlcNNQF8u0i
         NLfTSNfXp5ekpG9NHWdZiuwFfa5PNg+ToKi4AEEAAPSpTQZ6lIilywG8OSqfn7p85VGj
         XORDFfAxPtb+9tUQj2xWsCFeKoTRLMFITWidGi2OvdFdxazMKtK47YDKK4ZgFJ40bg32
         ItZYRBn0IDhez+hICzeceP66EQns/f6c3SOrFPmwZUCHkwKINAtkwo/ZTu3PoIge8302
         vjIUn6x9fTIDu8UGxrqHyphZZPpozdlPovR2GL0kmp3jk+Bki6YUlAmMak+MGejSdOdf
         I5HQ==
X-Gm-Message-State: AOJu0Yyp30nsLSgH8A1+FEOeuUVNOzNQ+U4Yhrf9JMZ/hWZAztLn5CMj
	rWMOG7jhPbNv++m8KuWrgetj8Edxpnl1BZ3ZyKyt5Gx7YFmhY8G1S9VKpVxuD0S/tr2BT08Y7h5
	LFHfDuSO+JpWD/6jRbmoiuqusdhpgKDZlboNG
X-Gm-Gg: AR+sD13L7E7v+HOEoN9GISAi0fx+afc+KvxHulwndwDCUvJxDwpeisklZh1lRLt70bI
	pRdEOFhS2biD4WC0bjX6cwGH9bbxaTTpRMzyhxTRI2tFL+eL8FsSG/ahe+yH4VrtupDuTtiMmQs
	EgjJFhwAJ+y7ur9312lHFEpS823AKZYICCVB/DNPi3aZWoBjk4pFSE6DRlLexw4neOVX9Igs/ji
	e2ZonWNXXCyRIqzopqBP3NY9YL7Q+lp55zjL47XNzqJBYgTnlhpCPsnQ/P5S4zY8bHROXnnTzpm
	oQ==
X-Received: by 2002:a17:907:e158:b0:c19:5b6c:947 with SMTP id
 a640c23a62f3a-c195b6c0a2bmr334619866b.23.1784631045340; Tue, 21 Jul 2026
 03:50:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717141737.4090962-1-puranjay@kernel.org> <e2d160c9-903b-46f6-82e0-b3fc74aaebcb@huaweicloud.com>
In-Reply-To: <e2d160c9-903b-46f6-82e0-b3fc74aaebcb@huaweicloud.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Tue, 21 Jul 2026 11:50:34 +0100
X-Gm-Features: AUfX_mzYk0qTjPuWHknqsjSw3Ulaj_B6iOq4Tvfw9ZEATF8v3YO4V0j0zprYZ0I
Message-ID: <CANk7y0isy3eUEv7Krxn08yGSiWu_kxaSxGj1XYO=1uuAC=hFOA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf, arm64: Fix stack-passed arguments for
 indirect trampolines
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 18, 2026 at 3:50=E2=80=AFAM Xu Kuohai <xukuohai@huaweicloud.com=
> wrote:
>
> On 7/17/2026 10:17 PM, Puranjay Mohan wrote:
> > save_args() reads stack-passed arguments relative to FP assuming the
> > trampoline is entered through the fentry call from a traced function, i=
n
> > which case both the parent frame (FP/x9) and the traced function frame
> > (FP/LR) are saved before FP is set, so the arguments start at FP + 32.
> >
> > An indirect trampoline for a struct_ops callback is entered through a
> > function pointer (blr), so only the FP/LR frame is pushed and the
> > arguments start at FP + 16, not FP + 32. Every stack-passed argument of
> > a struct_ops callback with more than eight argument slots is read two
> > slots off.
> >
> > This has gone unnoticed because no in-tree struct_ops member passes
> > arguments on the stack. Pass is_struct_ops into save_args() and pick th=
e
> > offset accordingly, mirroring the x86 fix.
> >
>
> Which x86 fix? Add a reference to it?
>
> > Fixes: 9014cf56f13d ("bpf, arm64: Support up to 12 function arguments")
> > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> > ---
> >   arch/arm64/net/bpf_jit_comp.c | 16 ++++++++++++----
> >   1 file changed, 12 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_com=
p.c
> > index c6756b964c843..4fe235f7ce894 100644
> > --- a/arch/arm64/net/bpf_jit_comp.c
> > +++ b/arch/arm64/net/bpf_jit_comp.c
> > @@ -2506,7 +2506,7 @@ static void clear_garbage(struct jit_ctx *ctx, in=
t reg, int effective_bytes)
> >   static void save_args(struct jit_ctx *ctx, int bargs_off, int oargs_o=
ff,
> >                     const struct btf_func_model *m,
> >                     const struct arg_aux *a,
> > -                   bool for_call_origin)
> > +                   bool for_call_origin, bool is_struct_ops)
> >   {
> >       int i;
> >       int reg;
> > @@ -2526,7 +2526,15 @@ static void save_args(struct jit_ctx *ctx, int b=
args_off, int oargs_off,
> >               bargs_off +=3D 8;
> >       }
> >
> > -     soff =3D 32; /* on stack arguments start from FP + 32 */
> > +     /*
> > +      * On-stack arguments start above the frame(s) pushed by the
> > +      * trampoline prologue. A traced function is entered through the
> > +      * fentry call, so both the parent (FP/x9) and the traced functio=
n
> > +      * (FP/LR) frames are saved and the arguments start at FP + 32. A
> > +      * struct_ops callback is called indirectly, so only the FP/LR fr=
ame
> > +      * is saved and the arguments start at FP + 16.
> > +      */
> > +     soff =3D is_struct_ops ? 16 : 32;
> >       doff =3D (for_call_origin ? oargs_off : bargs_off);
> >
> >       /* save on stack arguments */
> > @@ -2722,7 +2730,7 @@ static int prepare_trampoline(struct jit_ctx *ctx=
, struct bpf_tramp_image *im,
> >       store_func_meta(ctx, func_meta, func_meta_off);
> >
> >       /* save args for bpf */
> > -     save_args(ctx, bargs_off, oargs_off, m, a, false);
> > +     save_args(ctx, bargs_off, oargs_off, m, a, false, is_struct_ops);
> >
> >       /* save callee saved registers */
> >       emit(A64_STR64I(A64_R(19), A64_SP, regs_off), ctx);
> > @@ -2771,7 +2779,7 @@ static int prepare_trampoline(struct jit_ctx *ctx=
, struct bpf_tramp_image *im,
> >
> >       if (flags & BPF_TRAMP_F_CALL_ORIG) {
> >               /* save args for original func */
> > -             save_args(ctx, bargs_off, oargs_off, m, a, true);
> > +             save_args(ctx, bargs_off, oargs_off, m, a, true, is_struc=
t_ops);
> >               /* call original func */
> >               emit(A64_LDR64I(A64_R(10), A64_SP, retaddr_off), ctx);
> >               emit(A64_ADR(A64_LR, AARCH64_INSN_SIZE * 2), ctx);
> >
>
> LGTM. Since this issue is not covered by the existing selftests, I think
> we need to add a new one.

Kumar is working on a similar fix for x86 and will add a selftest with
it. I will wait and repost this patch again when Kumar's patchset
lands.
Thanks for your review.
