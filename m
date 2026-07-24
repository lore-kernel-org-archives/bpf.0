Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C441E3CD8BD
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 21:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784927472; cv=pass; b=HqzAxwJLnla8aah2ORC4dVz9uz6vnU7tc2ZSGnxgbNAq0DBLtzZP0e3igS7GxibntFBGa8dOh8LP+dYDBPwsYsf/TahWSRKnMCI7VrlIol0lvdO8i/tX9bA6588o8hU2SJoZ/10D5FmganqOaj6+8TN43+j2RtVNIcC1DPUWy2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784927472; c=relaxed/simple;
	bh=401H7/3zainmi+ZS8WgSGXF+YfZu57AK9VZDf3Al6M0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qTr1x3iqu0oeN+9VtVzjVvPGDbfNex1/Y2W++4rgWSr950c0mh2XoRRsgSscE45mZ5/rcOMOLh7ZcxYFyTOaIAcD8AhfQ2yrjEw9GBI0pRvaL0qYTNGtZ+tOb24UtaVD1dB2xEvbmyqGZhfSaYJQqSxTCLEB24rqJrqe4zNT/IE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cVh6MdlR; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVh6MdlR"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-81ed2a06b9eso8086007b3.3
        for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 14:11:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784927469; cv=none;
        d=google.com; s=arc-20260327;
        b=Diu9xJiPFj8arCNBgYd34fNKI3pFpUgfJMXg3RE4pBxRjwFNvVLIl/D8dQfdIr+U0O
         oUNPwXxxXK21I84KZhEzj+38soj8Vgr7MWM74GeDd3cf9kkyybOXYHxq/K/Z+DAfxlAq
         20tJ5GInxW5sFo53dkoVP44AI5YMZXB9WBqyhy4QTr64zgzBe1zNjShceKSrhl1U8VGC
         lf6af/x1ck3ahbA3ZF4tYjwDHpQoerWXbMD9hSRk/JqfgWE+3gb6LfVLa07Y/egVjp2I
         icSJsnRhatvo0vulgofz+nHjzSkRpzO9txOATaqekEr+YHx60yyZLvGJh4opUyPcEe6C
         ktHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hWOgufAJLgySWXsH9Y29OSjWhJiYTY778NK68l79LHw=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=FT5kbZU4ibgoKJnjHUSRuLfJCT1QLOt+CLeqa4Ax/T2fX29Yj6UEukZkWxgUE1jXTr
         Nsq8XqFpEaIZVljCAWUX0VY+8hKsRs4pru3UwrsmF+XoEm5N0O4NX2dvjut7lWg0QmeO
         LJm6LBu5+ml7hL0ayL/1voEqcg/yBv+fwHsirsb0LhhlL+YUACCbcNiznUZcaOHTfSZs
         m4mOFe9O8h23lfVt4UUkatfg8yaUssC7S82IoZZHKZtqttroTZFhaJRzrOm12ZolYqOt
         W+r9hxe0KOpwfY0DeYsEgPkC59/ITE7Ng7cLE5DkRrrs+/bsnIBdt+/zCcidUHtRUciI
         jmKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784927469; x=1785532269; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hWOgufAJLgySWXsH9Y29OSjWhJiYTY778NK68l79LHw=;
        b=cVh6MdlRcyqI1QPDVvBdjMlbjNZoauUTlyUa/sNpyxaldXAoVttIoMmL/LxXsJQQhs
         tf0C6LFErE9wwleCrhAqXQPHb+jCpTb+2hfNm98wRXjcB3kNQ5v/JHyfkaWzmylCacch
         GxXMThpFvB5y1kGHkG/D3HP2JvaPmPeCWoXX6rh/NN5RK6TwDllzeq2vqc2/+biUtFQE
         msunv8nzVC9vzVMxXx7Br3pBc9RHg4nHfbTCp3nW5G5vLjCxnjaDPO9n7//tLG1H+EPg
         1xs3TwMksU1LcWu4GwRWWb09T/xDaVNLT5geuBARMCKA/Gre4U/MUuMG+N1wVx1/I+nj
         BaoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784927469; x=1785532269;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hWOgufAJLgySWXsH9Y29OSjWhJiYTY778NK68l79LHw=;
        b=EntI0U2NFh9DdXqsyw8Hey06ngdmTCvu5QE4kno5wQOaE5YzHv6TwiB0cggzobwFQe
         QN1rUYjiLPFSt2OsX7BJwVSnCyKQdPvi9/ZVvYf0FU2jrPvVJe0g+sfZWfmgVjqAwWbg
         dZoxbqhEGTRGuNo+O43X1rP8P7I/jqPr3Euu2SSMksCC6XJEGBwtArs7mQLUuaTpI24F
         2j7XAZd8LT8oV0okhspilOCtgTcptRdOrzZaeOAcn314VPeYJR47dMnhu5VFL0QvQsqo
         dV/+iRH/6Va9L5e8qx/xVYjVNRClL63hf7uVHYIF3QHcitI1QWFXrRboHfHIur0ZaPzz
         Ls8g==
X-Gm-Message-State: AOJu0Yw8g3YuYXqYXOgKbZ5J91l9zw1uKejylEMsC7NURtDkT9cgcr7i
	UI3gJZ7iiwF+xRC08h1yBSksI2ijOXMzINSnejNHBlVju5fIg+P5xVCI1fzLeIy0AD2VR2pM4OD
	uTxI0YsAlnQXb31tUgrKfPO1IiDsRXlE=
X-Gm-Gg: AR+sD12+sB0y6In0jfMKrSQSpnT+xamwZmzcyvZaRcKaTYkShH0Omr3ZgbxXJezayPJ
	6OqrQSfqbTIavURzxQKzGdWQ+H+EvjkPjb/t7LLYw5Of11yVOZesZoNP5/kvOP+AjlbvAFd7ILx
	CTjK+SkmnhJburuHS0uWzvmKbxfesvjFFKzVxL3Ugd2AZiEyT3b0SWSz/XdCn7J/KMEuIPcQX7W
	7WCMadp2XGiGox9t/4kUqGKfT1PIbHd2kIjZihwNs+NKKAhjvwBk1fcBedqWQ==
X-Received: by 2002:a05:690c:9c09:b0:81e:2b86:d75a with SMTP id
 00721157ae682-81f69e69fdcmr336957b3.55.1784927469575; Fri, 24 Jul 2026
 14:11:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724190813.1458271-1-ameryhung@gmail.com> <20260724190813.1458271-15-ameryhung@gmail.com>
 <20260724194706.0F79D1F000E9@smtp.kernel.org>
In-Reply-To: <20260724194706.0F79D1F000E9@smtp.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 24 Jul 2026 14:10:58 -0700
X-Gm-Features: AUfX_myzcCIwPNHoteUh9JcCBK-hOI9tnWJaFUCV6LfHXBrDjbT2vBuwQy2nK-0
Message-ID: <CAMB2axO+hMUNyk5WeOc78K3Xchf-5jOGSMJjAFUMBWXhX7YAhg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 14/18] bpf: Check helper mem+size in
 ARG_PTR_TO_MEM case
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 12:47=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] Calling check_mem_size_reg() on the size register before validat=
ing its type allows an unprivileged user to trigger a kernel warning (WARN_=
ONCE) and potential panic, leading to a local Denial of Service.
> --
>
> --- Patch [14]: [PATCH bpf-next v2 14/18] bpf: Check helper mem+size in A=
RG_PTR_TO_MEM case ---
> commit 49ede5ce4d16f1df74560df7eef17176d13cb3e1
> Author: Amery Hung <ameryhung@gmail.com>
>
> bpf: Check helper mem+size in ARG_PTR_TO_MEM case
>
> This commit modifies the BPF verifier to check variable-size memory argum=
ents
> and their associated size registers simultaneously during the ARG_PTR_TO_=
MEM
> case, rather than waiting for the ARG_MEM_SIZE argument. It looks ahead t=
o
> regno + 1 to process the size register.
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 144c2d8aa4922..2326b12a15313 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
>
> [ ... ]
>
> > @@ -8515,14 +8512,15 @@ static int check_func_arg(struct bpf_verifier_e=
nv *env, u32 arg,
> >                               return err;
> >                       if (arg_type & MEM_ALIGNED)
> >                               err =3D check_ptr_alignment(env, reg, 0, =
fn->arg_size[arg], true);
> > +             } else {
> > +                     struct bpf_reg_state *size_reg =3D reg_state(env,=
 regno + 1);
> > +
> > +                     err =3D check_mem_size_reg(env, reg, size_reg, ar=
gno,
> > +                                              argno_from_reg(regno + 1=
),
> > +                                              arg_type & MEM_WRITE ? B=
PF_WRITE : BPF_READ,
> > +                                              fn->arg_type[arg + 1] & =
SCALAR_MAYBE_ZERO, meta);
>
> [Severity: High]
> Could this call to check_mem_size_reg() process a non-scalar register?
>
> By looking ahead and processing size_reg at regno + 1 here, it seems this=
 is
> happening before the size register's type is validated in the next loop
> iteration of check_func_arg().
>

This is a real issue.

I will drop patch 15, not moving helper check_mem_size_reg(). Then for
kfunc, defer check_mem_size_reg() in KF_ARG_MEM_SIZE and
KF_ARG_CONST_MEM_SIZE similar to helper.

> If a BPF program passes a pointer (like PTR_TO_MAP_VALUE with var_off=3D0=
)
> instead of a scalar for the size argument, it appears it would bypass the
> scalar bounds checks. When check_mem_size_reg() subsequently calls
> mark_chain_precision() on that non-scalar register, could this trigger a
> verifier_bug() and BPF_WARN_ONCE()?
>
> On systems with panic_on_warn enabled, this might lead to a local denial
> of service.
>
> >               }
> >               break;
>
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724190813.14=
58271-1-ameryhung@gmail.com?part=3D14
