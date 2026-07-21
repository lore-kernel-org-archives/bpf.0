Received: from mail-wm2-f2.google.com (mail-wm2-f2.google.com [74.125.225.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F79F386C39
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 19:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784662228; cv=none; b=PHcX6h+FJ9aGaA2eovWcimApTU7IdaFVuuASoi8d1WDQjKgDAvLWuuHipP8b1R+TyippkprEAL4sAw3a2p1t7LkEa00igg4El1e3t7fqsel8no2ddJuDpNBGD8LluRlbHoMhLnSQ6Ja2VLkcX5OVaBRuJJoVZc7JqJPOylK9/Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784662228; c=relaxed/simple;
	bh=qtNC47ku99vDgcpvjMR2ku6SVXf+HJN7XOCZuGkep7U=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=o67Et1YKt6FzVfbBM4QOdxXtqq7KPSkuQKWyL5cvYnT5hbSG4+eTSk5S19BgajftL1XGGsncv2/xoT9cCpmb//tVo09mvhzxCWEGAU/y77+wBf0wRCy3/SH6jxA7MGvip5MBtIqtecmQgLTmcm/jsbttslXjQ0FrovGN+7Tp07s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XU86Iye8; arc=none smtp.client-ip=74.125.225.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XU86Iye8"
Received: by mail-wm2-f2.google.com with SMTP id 5b1f17b1804b1-49242309566so23345495e9.0
        for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 12:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784662225; x=1785267025; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FQPv+FfN22otxjRHQ2lP9vtjJl2RzMRuNs/wEDCdzNM=;
        b=XU86Iye8ThlqLYZc4CCRIX5OeA26KOy/KGbfjAsK5n01y4DLewPrlBX6mwnpk3MXjQ
         YtyEzmpEoaCi3/TYNzn54A+o0QYMMqapZyuFXfz46Wto9Q9pcCkt66aOkUpYJq6K7UAu
         Y7Sw0G+mAKTVRgLfxCSd4kic3We7D+Cd+dxgoRPhDwaHflcjSMbcMSYAbdHjl3YviL/Z
         MP1bqQBtBS+XS74LpSES2KhSH8uLHcSR7D/yDR0DMUA/y3os8YmJ7yBT1NzBn5FE9Cyu
         eXnlhy4SWntOr54phDEj4cW6PB7pFjuYWtKxNatG/eNc4kBd0ESpysx+eIPhAXPSoAWk
         tyEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784662225; x=1785267025;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FQPv+FfN22otxjRHQ2lP9vtjJl2RzMRuNs/wEDCdzNM=;
        b=btUnVQED2WL2Wj8RvjFZGLUf2Px7qmHDWN9UAfLLOw6+vzJ9Ov5Z9oDyHO218xZ9PX
         akYJM9Rg9uZhmWkuV/hpmyXMuhFbvu2gIVQe4V/Rhj0QTAbELJ5HKVJPzPM3MlKQhl3Z
         qF6uX5y/S9Ld5eJKSKxX4Mz6iw6yr+KuOUxw3GnmrrZBOU6PwCSIZefwiG4xeMzWp5EB
         v6B4UNA3QRezM011rk3Mqd436adhIDZWgCMIt2fzznszhhWejTHgas4j060VyxqQV1+y
         ZIECt+wEqqFZwSJrDtSNkGnDsjZSlp7ZrcFiIJsFj4qwUFrE0fF4skv9mXp7ZQGyZ5DG
         JsMA==
X-Gm-Message-State: AOJu0YxBWv1uT+DZGDC8ysa8MULDYEPSlBkmHeiw9GeeIzzwMTjOvsld
	gHJGR3DqudPhRZieLhkeU0p09echpbC/gIibGMS0spCAvauWqF/cosh5
X-Gm-Gg: AfdE7ckFO19XCFODE2jprZygL66zwDkRhN0/buiCt13BuQHDushBn0AHoZyzaB00N06
	1I9H+DHRkG5p4WiZLxphkLT2TZA/PpkZnp+/9aGVW9ZOWv2hqCy5IxTlW/g31Ys/zRcdxTM6dzS
	TEWWHzZZhUeANN+OhCGzun7hGnG0mpWx+tErSAqOuhvdI3UM1CQLq4A2Kh/0yGDYvAsWMiTPziM
	ZAc6R1uYwMVfhmzXFd6PA3aUZiCdK5MHG20C3oLJod/QUsBBPaHy8B/0iskk0BxDsG4LPzfmCkf
	ao/XPoFGFhNS069k7O1CEnyx1B+yigrf2nKhAmHui9abKHavRnOcIoghUF639nS3E2c4AdluuJC
	6lxH4trr01IqWGl8Ow96VAbcMAuoPAbxAXcF0ZdGkw+BOxL6bCYO/YlGHIClk/fnVeLgESHGNln
	plAqcm0T/zcrjZVfJZlcvhUDHqy/sHrwj7rh3nTosGGhDzJ7yhmHsRGPHrkTIWZ6UKJ5EJH4Me0
	cf+ecaNnzrDraknh6HiIluGUGsKL+4+38tM201C9vCZ
X-Received: by 2002:a05:600c:350f:b0:493:e365:ace9 with SMTP id 5b1f17b1804b1-4954a3db7e8mr223805455e9.11.1784662224989;
        Tue, 21 Jul 2026 12:30:24 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-495653bfabesm99387645e9.10.2026.07.21.12.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 12:30:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Jul 2026 21:30:24 +0200
Message-Id: <DK4HYJHDLBZP.92SX05PI2C5T@gmail.com>
Cc: <bpf@vger.kernel.org>, "Alexei Starovoitov" <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next] bpf, arm64: Fix stack-passed arguments for
 indirect trampolines
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Puranjay Mohan" <puranjay12@gmail.com>, "Xu Kuohai"
 <xukuohai@huaweicloud.com>
X-Mailer: aerc 0.21.0
References: <20260717141737.4090962-1-puranjay@kernel.org>
 <e2d160c9-903b-46f6-82e0-b3fc74aaebcb@huaweicloud.com>
 <CANk7y0isy3eUEv7Krxn08yGSiWu_kxaSxGj1XYO=1uuAC=hFOA@mail.gmail.com>
In-Reply-To: <CANk7y0isy3eUEv7Krxn08yGSiWu_kxaSxGj1XYO=1uuAC=hFOA@mail.gmail.com>

On Tue Jul 21, 2026 at 12:50 PM CEST, Puranjay Mohan wrote:
> On Sat, Jul 18, 2026 at 3:50=E2=80=AFAM Xu Kuohai <xukuohai@huaweicloud.c=
om> wrote:
>>
>> On 7/17/2026 10:17 PM, Puranjay Mohan wrote:
>> > save_args() reads stack-passed arguments relative to FP assuming the
>> > trampoline is entered through the fentry call from a traced function, =
in
>> > which case both the parent frame (FP/x9) and the traced function frame
>> > (FP/LR) are saved before FP is set, so the arguments start at FP + 32.
>> >
>> > An indirect trampoline for a struct_ops callback is entered through a
>> > function pointer (blr), so only the FP/LR frame is pushed and the
>> > arguments start at FP + 16, not FP + 32. Every stack-passed argument o=
f
>> > a struct_ops callback with more than eight argument slots is read two
>> > slots off.
>> >
>> > This has gone unnoticed because no in-tree struct_ops member passes
>> > arguments on the stack. Pass is_struct_ops into save_args() and pick t=
he
>> > offset accordingly, mirroring the x86 fix.
>> >
>>
>> Which x86 fix? Add a reference to it?
>>
>> > Fixes: 9014cf56f13d ("bpf, arm64: Support up to 12 function arguments"=
)
>> > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
>> > ---
>> >   arch/arm64/net/bpf_jit_comp.c | 16 ++++++++++++----
>> >   1 file changed, 12 insertions(+), 4 deletions(-)
>> >
>> > diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_co=
mp.c
>> > index c6756b964c843..4fe235f7ce894 100644
>> > --- a/arch/arm64/net/bpf_jit_comp.c
>> > +++ b/arch/arm64/net/bpf_jit_comp.c
>> > @@ -2506,7 +2506,7 @@ static void clear_garbage(struct jit_ctx *ctx, i=
nt reg, int effective_bytes)
>> >   static void save_args(struct jit_ctx *ctx, int bargs_off, int oargs_=
off,
>> >                     const struct btf_func_model *m,
>> >                     const struct arg_aux *a,
>> > -                   bool for_call_origin)
>> > +                   bool for_call_origin, bool is_struct_ops)
>> >   {
>> >       int i;
>> >       int reg;
>> > @@ -2526,7 +2526,15 @@ static void save_args(struct jit_ctx *ctx, int =
bargs_off, int oargs_off,
>> >               bargs_off +=3D 8;
>> >       }
>> >
>> > -     soff =3D 32; /* on stack arguments start from FP + 32 */
>> > +     /*
>> > +      * On-stack arguments start above the frame(s) pushed by the
>> > +      * trampoline prologue. A traced function is entered through the
>> > +      * fentry call, so both the parent (FP/x9) and the traced functi=
on
>> > +      * (FP/LR) frames are saved and the arguments start at FP + 32. =
A
>> > +      * struct_ops callback is called indirectly, so only the FP/LR f=
rame
>> > +      * is saved and the arguments start at FP + 16.
>> > +      */
>> > +     soff =3D is_struct_ops ? 16 : 32;
>> >       doff =3D (for_call_origin ? oargs_off : bargs_off);
>> >
>> >       /* save on stack arguments */
>> > @@ -2722,7 +2730,7 @@ static int prepare_trampoline(struct jit_ctx *ct=
x, struct bpf_tramp_image *im,
>> >       store_func_meta(ctx, func_meta, func_meta_off);
>> >
>> >       /* save args for bpf */
>> > -     save_args(ctx, bargs_off, oargs_off, m, a, false);
>> > +     save_args(ctx, bargs_off, oargs_off, m, a, false, is_struct_ops)=
;
>> >
>> >       /* save callee saved registers */
>> >       emit(A64_STR64I(A64_R(19), A64_SP, regs_off), ctx);
>> > @@ -2771,7 +2779,7 @@ static int prepare_trampoline(struct jit_ctx *ct=
x, struct bpf_tramp_image *im,
>> >
>> >       if (flags & BPF_TRAMP_F_CALL_ORIG) {
>> >               /* save args for original func */
>> > -             save_args(ctx, bargs_off, oargs_off, m, a, true);
>> > +             save_args(ctx, bargs_off, oargs_off, m, a, true, is_stru=
ct_ops);
>> >               /* call original func */
>> >               emit(A64_LDR64I(A64_R(10), A64_SP, retaddr_off), ctx);
>> >               emit(A64_ADR(A64_LR, AARCH64_INSN_SIZE * 2), ctx);
>> >
>>
>> LGTM. Since this issue is not covered by the existing selftests, I think
>> we need to add a new one.
>
> Kumar is working on a similar fix for x86 and will add a selftest with
> it. I will wait and repost this patch again when Kumar's patchset
> lands.
> Thanks for your review.

Yes, please resend when that lands, along with changes to enable tests on a=
rm64
and the remaining JIT-side changes needed to translate arena args.

pw-bot: cr
