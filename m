Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B9763C8
	for <bpf@vger.kernel.org>; Wed,  3 Apr 2024 16:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712161833; cv=none; b=pcRietczsn4ORzfnaogvvxkFawx3/eSrTRFBAeha+0lkz+u8JALJv08Ag4HFnfvBoeQ3a86jUYLHjUn51a0qUGl86pgus3wB5c1gwWjxWMfT7DQpWHZ2EgiMYpZectZz2UmuX3zNzvx6sdAnqWT3Epp+1LpMR/aJejvKk9euhlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712161833; c=relaxed/simple;
	bh=/mGw95D8mmZbDDvt1A8fU8uVFPAUWjUpgWk/jKjgAPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GuqVKvsSdmgtGua6HWPTM6zBaVJU4DtY9T05dcQa5Wi8JGJxlKOBTXtNQF0mFFhxU7pfTfmATyKnTkcWuKYgKRK5ASk7UkMe6gKzq67a/mfzdzQP/Zvm4uSBNtLjUyvLwLYHOZJ6448A+4Wum/Dh0zYG5pRzx4FGUPnGVg0LwHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QzNR0u/c; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QzNR0u/c"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5e8470c1cb7so44210a12.2
        for <bpf@vger.kernel.org>; Wed, 03 Apr 2024 09:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712161831; x=1712766631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dJ9lmWN5498PANPQWqgWPqswbHG0Gi6uEOnOeNXw4w8=;
        b=QzNR0u/cpdmDQ/6MUcHXkmyvLKYBFO+iEnTRYDPYteKVLzaLPKCRyXbq2DHU4mTH8L
         KaF8MiGfYvqMIPwUJmx5wHTB6UYDghn3WAXw2VMlLorophUnmhBP8Qu/Yd4L3Pyi/i7d
         dTLBBBgguDPO8XfBXLN+r7kVbVhzvjFJYlU/oj0ubTi4qLDb4u2DkECvbnpW9y3I3Vlb
         IXjhHCIAxtS5DMWnZHUn5Flfll53QCoFggB0F6g6dOMS+oy+ETYeO5BFs0WH/Oz0fJtD
         MIigTf9TxVtuKakxcSgI7IG/gtnhLPBQ5ZEuXnQDVQ3H440HbTUsRrwCyPY565Av83iX
         kx6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712161831; x=1712766631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dJ9lmWN5498PANPQWqgWPqswbHG0Gi6uEOnOeNXw4w8=;
        b=BHnV65WPS90g5oeIruny/K1gCPhOhY6OaZlf8HaGLz8qSbBOyhwEey0+ckM05YVw4U
         4xrwVDBz+ReIccjr8hZzT4y0Y+Oe7d79WkyRMCAcDcdrmknDA+x4lhaMGlOsi1maoFB+
         mp5QzVXEhlxzx9FXuxwmHQnguKtxB/7EN9hpvTQf6rr52M5wcORYD8d8UX1hNXHQsDfa
         Vl2v7VeeVsqPijGHbW3mv0A3V6JRrM0uqfNstM/h5K0A1iYlbL9zn1LuNlAWFFtHghJA
         y3hxwMRzPI5OSyeC7PTjdiJCjXHoI1/nRuVOP9HwQHvrypqkyq7T/lq43bZa1hC4hhJZ
         kALg==
X-Forwarded-Encrypted: i=1; AJvYcCVfTG095jFmomDVJ+HctAqthem4AIPSElGSY16ngCOeLES1tQlAwMXvyL0mAnhykcnanqyqlPVarzwAHtAj0VzqUhtG
X-Gm-Message-State: AOJu0Yz4RtRIQQPU/h115ZYBAnzWC1pB9ddHNvfEP1ycF5t0kN0jyhWR
	JHFiOkit38gJ9TJQb39fedU+jy50C7Oq6SW9fUvm5FC9QBzRASnIWc/V9DVUu1AFcY/4Mf0Xcoh
	k6aeYRKVQkUo+nojQR7srlDbCNIU=
X-Google-Smtp-Source: AGHT+IE1adPl3Iy0Pc5Ubf9qxoR6LZZzTxtv6hiaK0u3sjmQqyXgPyVAHkKpyTX8PwMJGjn5OvQIo5075XgYHdVQH+8=
X-Received: by 2002:a17:90a:b10f:b0:29b:b3fa:b7a5 with SMTP id
 z15-20020a17090ab10f00b0029bb3fab7a5mr25951pjq.7.1712161830856; Wed, 03 Apr
 2024 09:30:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240320122153.3622252-1-tao.lyu@epfl.ch> <CAEf4Bza98OQ-axH-o1xE4KA72Ga9bLwdDuWJS_irESbbxp1saA@mail.gmail.com>
 <cae53ceb455c415fa2c4b10ec0a74df3@epfl.ch>
In-Reply-To: <cae53ceb455c415fa2c4b10ec0a74df3@epfl.ch>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 3 Apr 2024 09:30:18 -0700
Message-ID: <CAEf4Bza-PsJ69uhFFPB7HtyD-W4peZnF6qfX_069Rzzvvt8iZg@mail.gmail.com>
Subject: Re: [PATCH] Inaccurate rejection conditions
To: Tao Lyu <tao.lyu@epfl.ch>
Cc: "andrii@kernel.org" <andrii@kernel.org>, "yonghong.song@linux.dev" <yonghong.song@linux.dev>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>, 
	"mathias.payer@nebelwelt.net" <mathias.payer@nebelwelt.net>, 
	"meng.xu.cs@uwaterloo.ca" <meng.xu.cs@uwaterloo.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 12:05=E2=80=AFPM Tao Lyu <tao.lyu@epfl.ch> wrote:
>
> >>
> >> Signed-off-by: Tao Lyu <tao.lyu@epfl.ch>
> >> ---
> >>  kernel/bpf/verifier.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> Hi,
> >>
> >> I am sorry to bother you due to my confusion on constraints about stac=
k writes.
> >>
> >> 1. When an instruction stores 64-bit values onto the stack with fixed =
offset and BPF_CAP only,
> >>    the verifier marks the stack slot type as STACK_SPILL, no matter wh=
ether they are scalar or pointers.
> >>
> >> 2. Then, a store instruction with a **32-bit scalar value** on the sam=
e stack slot leads to a verification rejection.
> >>    As it says, this might corrupt the stack pointer by asserting if th=
e stack slot type is STACK_SPILL.
> >>    However, even if the stack slot type is STACK_SPILL, it might store=
 a 64-bit scalar and not a stack pointer.
> >>    IMHO, this "issue" might originate from the incomplete conditions i=
n the check_stack_write_fixed_off() function below.
> >>    It only checks if the stack slot is a spilled register but forgets =
to check if the spilled register type is a pointer.
> >>
> >>  4479 static int check_stack_write_fixed_off(struct bpf_verifier_env *=
env,
> >>  ...
> >>  4494     if (!env->allow_ptr_leaks &&
> >>  4495         is_spilled_reg(&state->stack[spi]) &&
> >>  4496         size !=3D BPF_REG_SIZE) {
> >>  4497         verbose(env, "attempt to corrupt spilled pointer on stac=
k\n");
> >>  4498         return -EACCES;
> >>  4499     }
> >>  ...
> >>  4600 }
> >>
> >> Below is an example bpf program, which stores a 64-bit and 32-bit imme=
diate value on the same stack slot.
> >> But the second one gets rejected due to the above.
> >>
> >> 0: R1=3Dctx() R10=3Dfp0
> >> ; asm volatile ( @ repro.bpf.c:679
> >> 0: (7a) *(u64 *)(r10 -8) =3D 1          ; R10=3Dfp0 fp-8_w=3D1
> >> 1: (62) *(u32 *)(r10 -8) =3D 1
> >> attempt to corrupt spilled pointer on stack
> >> processed 2 insns (limit 1000000) max_states_per_insn 0 total_states 0=
 peak_states 0 mark_read 0.
> >>
> >> If my understanding is correct, then we can apply the attached patch.
> >>
> >> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> >> index de7813947981..65f7eb315e9c 100644
> >> --- a/kernel/bpf/verifier.c
> >> +++ b/kernel/bpf/verifier.c
> >> @@ -4493,6 +4493,7 @@ static int check_stack_write_fixed_off(struct bp=
f_verifier_env *env,
> >>          */
> >>         if (!env->allow_ptr_leaks &&
> >>             is_spilled_reg(&state->stack[spi]) &&
> >> +           state->stack[spi].spilled_ptr.type !=3D SCALAR_VALUE &&
> >
> > I think it's possible to easily convert PTR_TO_MEM kind of register to
> > SCALAR_VALUE through arithmetic operations, and so allowing to spill
> > SCALAR_VALUE to stack is basically just as dangerous as spilling
> > PTR_TO_MEM directly.
> >
> > So it feels a bit dangerous to do this.
>
> Hi Andrii, thanks for the reply.
>
> I think you might misunderstand this issue.
> Let me rephrase it below:
>
> ** The verifier should allow partially overwriting an 8-byte stack slot
> that contains a spilled scalar instead of rejecting it,
> as the example shows below.**
>
> 0: R1=3Dctx() R10=3Dfp0
> ; asm volatile ( @ repro.bpf.c:679
> 0: (7a) *(u64 *)(r10 -8) =3D 1          ; R10=3Dfp0 fp-8_w=3D1
> 1: (62) *(u32 *)(r10 -8) =3D 1
> attempt to corrupt spilled pointer on stack
>
> In this case, it's about overwriting a spill of a 64-bit scalar
> with another scalar with a smaller size (e.g., 32-bit).
> Pointers are not related to this IIUC.
>

Ah, you are right, I misunderstood the use case. From my perspective
what you propose makes sense. Please prepare an official patch with a
proper commit message and send it again to bpf@vger.kernel.org.

> Thanks for your time again.
>
> >
> >>             size !=3D BPF_REG_SIZE) {
> >>                 verbose(env, "attempt to corrupt spilled pointer on st=
ack\n");
> >>                 return -EACCES;
> >> --
> >> 2.25.1
> >>
