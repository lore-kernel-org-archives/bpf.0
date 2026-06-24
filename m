Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D6A2EEE9B
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 18:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782325461; cv=pass; b=cGWgetp5PcyLGprMjMB9xmBC1GFfDi8RJJL2gKDgi6FQPqIRQ6AGFZ42pLvqpDP81l781grfs+OWZt1nAL5Eksno25DuyapaIUDS9USXIPhNqQake/S9D5GtKnAl2KMpY0H1jZ/OkTpDhkd6TRtLaxSgs7S2dZNToF1mz+E9phA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782325461; c=relaxed/simple;
	bh=Hb4xLTgfJp/9y8lwsQ79+W67aztOiRgsiVtE17jRaQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DlxJnEkIMncbnx5MyN2TgjgRdqi3VHsOfS9nN8eGlHsHqAnkXzSwQn+RRNzJj7yXdb7ixocchPiJfT/l2CzBXb87/Lsz85+fcuZ7txcY2b3bACIKx6G3FX2t7hpMrO70Ii2usPmSHwt6PdP5aqKVJtYDu/fS5VbEKSm0hqEsBQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fJjORuS3; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJjORuS3"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7e86d46b02dso19166407b3.3
        for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 11:24:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782325459; cv=none;
        d=google.com; s=arc-20240605;
        b=ZNlv/iv/BLAXaxx6DT7XNlw2QCuvcKPsrXddSoWomcofYoAV/loTAsmFD9zBL9830F
         RDQfRu7KwvImeLH5shwoaGY60TX0CpQauLoC9C9nWKX0CWvuKOck2j9tPvZXjGbLK4vs
         ZwPbzd4/IOvJUYMOeN5zWJS9V4Xl2opW5qkYO9IWhUk+ng4ADyHgw6ExFoU1NlvKKTRT
         BHzvjVl1l9RHUIJivj/xz2UxovaK1uzCFEi7i0JOQcDxgSQNf4645Peh9RHrlFWRH/9r
         8sOULrGRw784CPuNQmnchJu0RV+ssoJRefIQG+vEL34FHe2bOor+PJ4ozpEDT4dzdzqL
         H7eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IY4/t9eKkaWP4XUnsXNVlFzjY/g3Uh9b/Y5kJrRDbTM=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=FDaNclM+R1tYwzUnuLSWqhqyl7syTtdZ0vnyBRdRyw9SUjoLAzqkMuDY9CK8s8udka
         ltbc6T6SKcazUtvagQusyLBNwhpkz2Igt9/E4/CebgYpndxdtQUUSvggUimGTn7+ear/
         tU39obZGbDe4XYSKhPVQbBnuVrsGemrBropG8mSQTmj96+FQ4aDsJzidkLONmHpirKSv
         gJI6yPk/sQ4E6Aa8uh21UHXVrOWCw9FxhY5KFJIYaW58zArFWIyiFt1qjVpwAKgPewtC
         4q6cvClzbWDCzHdvbdJQGkpDQTO2yFE5ht9yLlfny9D/T6ss87bOXNOTr6kTANNba3iq
         ClQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782325459; x=1782930259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IY4/t9eKkaWP4XUnsXNVlFzjY/g3Uh9b/Y5kJrRDbTM=;
        b=fJjORuS3cupim/+qNuWXVoEGlzTRs082eUsbnf0APunNO2PDEkiQp3Ey09qaKDL8Bl
         I3NjiCGy4icWmbTo9f03CkbYWY2eQivAaQk49DVtqnX3r3Jz6g1k9V6gyigjXzooVgLG
         jV40awW37Z2ZUCA1eLDqYZYyR8rg+Xy0pIIqUnnNvjhJ9bZ9C3Rd/cGgcHM20L8HhyKM
         ngrFkHZQZhRniTi2IMT2/S1nNhHJ/844vvW+LtA8KL8PWOFDRLQjA6ds73xy90x8jkqB
         O3EHnuCcjL6jG/LoJ6vDV+cRGGSOtEubWuEJyJPSvEkPVr2fw27ZNDBmzmP8/siEO/vO
         P/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782325459; x=1782930259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IY4/t9eKkaWP4XUnsXNVlFzjY/g3Uh9b/Y5kJrRDbTM=;
        b=MMvXU+5Mpd550Cg4u59jIWUuZ8UA0vqWtqhQxlIBfKRok39jpPCCEtB1cHWSjk4L//
         8brSEeuwEJbiPUa1z5jDytoaw1H2FgMHvMGOTrhGvyWJ3bQw4NI2pRVaKd9gJRWX2eum
         OoDBROluvyjqQpIuxH04H/DQtzxDoTHgGT46QQCDMvDlaH+6j1s78+7k+3/5t3nmu4Ao
         GH3LEMcAFfX1ovWFPCFcfjllqEPppg8ZFpUT+LUJURgZWF6vhNcJB+frXiB5Hjo4X1Xd
         kPSsTAeYhfW0f/RmNTTwlSRIuZMQuXZLYS4dXCtYvUSc1yPr7bFJ3lAU78a/GoxAx0I/
         /Fhg==
X-Gm-Message-State: AOJu0YwomBgWWVo0TSZTGjhUZUfyEZr+dR0V0UN1ENyNPA470TQ1p7O0
	K9BM3IsIezTfznkjVVbFRQpIN28VTJzYtO6fywfo3RtRsLXzn2nybdSwg+irn8RApk/xoLL7wbV
	soQ+yquN+t1RnqErf9vXg7ZwT1v+R+lw=
X-Gm-Gg: AfdE7ckVQfu2hEmxQQg5UuW87ZD6667EqB26fCrEpuUJR5a6YksxxuDSWQkxK/uJGiq
	p2bgB8PVaY91HfKwFNbkX9CoAT/xmFR8Kt3FApHi6to1e3aYok+nUI5MrahAFgYYM+dxlZSIOI/
	C8m/ibyDYyLFCgh/P0a0+BzZ91+ObsxBnGL+nWom94VRLzsxFau+d3whyZ+hwTTyAMjuymlnmwE
	3hiT00Eg6jlfvbY3aiQOEdZ99jyc9bPoRPt1cXfMPS35mNUaA5pilzLESIZlv8UXjorDwwJ
X-Received: by 2002:a05:690e:4842:b0:661:37ed:63ad with SMTP id
 956f58d0204a3-6636e58827bmr2940730d50.43.1782325459014; Wed, 24 Jun 2026
 11:24:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623175006.3136053-1-ameryhung@gmail.com> <20260623175006.3136053-12-ameryhung@gmail.com>
 <20260623232250.6F1551F000E9@smtp.kernel.org>
In-Reply-To: <20260623232250.6F1551F000E9@smtp.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 24 Jun 2026 11:24:06 -0700
X-Gm-Features: AVVi8CfGHzJvG4ND1DAHRQMFh9mCT59_erhCaC7fFPP3NcxAPyISMo77xTmsw4c
Message-ID: <CAMB2axM=ui2aZe8aDF6wr1ZZQe46AL4NAirF8wUWq2NMmLkhjA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 11/15] bpf: tcp: Support selected sock_ops
 callbacks as struct_ops
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 4:22=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [High] bpf_tcp_ops allows sleepable BPF programs which will trigger ker=
nel panics when executed within the RCU read-side critical sections of the =
dispatcher macros.
> - [Low] Multi-line comments in BPF subsystem files must have the opening =
`/*` on its own line.
> --
>
> commit c794084a252357df7f0bbf934f1e1707d2dd52fd
> Author: Martin KaFai Lau <martin.lau@kernel.org>
> Subject: bpf: tcp: Add bpf_tcp_ops and support attaching to cgroups
>
> This commit adds a TCP-specific struct_ops type, bpf_tcp_ops, and support=
s
> attaching it to cgroups. It wires up several existing sock_ops callbacks =
to
> allow each callback to have its own function signature.
>
> Link: https://drive.google.com/file/d/1wjKZth6T0llLJ_ONPAL_6Q_jbxbAjByp/v=
iew?usp=3Dsharing
>
> > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > index 6d376ea4d1c0..2102f9f2afd6 100644
> > --- a/include/net/tcp.h
> > +++ b/include/net/tcp.h
> [ ... ]
> > @@ -2953,12 +2953,120 @@ static inline void tcp_clear_sock_ops_cb_flags=
(struct sock *sk)
> >
> >  #endif
> >
> > +#if defined(CONFIG_BPF_JIT) && defined(CONFIG_CGROUP_BPF)
> > +
> > +struct bpf_tcp_ops {
> > +     /* Should return the initial SYN (active open) or SYN-ACK (passiv=
e open)
> > +      * retransmission timeout. Return the timeout in jiffies, or <=3D=
 0 for
> > +      * the kernel default.
> > +      *
> > +      * @req: request_sock on the passive (synack) path; NULL otherwis=
e.
> > +      */
>
> [Severity: Low]
> This isn't a bug, but could these multi-line comments be updated to place=
 the
> opening /* on its own line?
>
> [ ... ]
> > diff --git a/net/ipv4/bpf_tcp_ops.c b/net/ipv4/bpf_tcp_ops.c
> > new file mode 100644
> > index 000000000000..cf53c95a0dbc
> > --- /dev/null
> > +++ b/net/ipv4/bpf_tcp_ops.c
> [ ... ]
> > +BPF_CALL_0(bpf_tcp_ops_get_retval)
> > +{
> > +     struct bpf_tramp_run_ctx *ctx =3D
> > +             container_of(current->bpf_ctx, struct bpf_tramp_run_ctx, =
run_ctx);
> > +
> > +     /* bpf_get_retval() is only exposed to timeout_init/rwnd_init, wh=
ich
> > +      * always run via bpf_tcp_ops_call_int(). Its run_ctx carries the=
 int
> > +      * return value chained across the bpf_tcp_ops attached to the cg=
roup
> > +      * and is this program's saved_run_ctx.
> > +      */
>
> [Severity: Low]
> This isn't a bug, but would it be better to adjust this multi-line commen=
t so
> that the opening /* rests on its own line?
>
> [ ... ]
> > +static struct bpf_struct_ops bpf_tcp_ops =3D {
> > +     .verifier_ops =3D &bpf_tcp_ops_verifier,
> > +     .init_member =3D bpf_tcp_ops_init_member,
> > +     .init =3D bpf_tcp_ops_init,
> > +     .validate =3D bpf_tcp_ops_validate,
> > +     .name =3D "bpf_tcp_ops",
> > +     .cgroup_atype =3D CGROUP_TCP_SOCK_OPS,
> > +     .cfi_stubs =3D &__bpf_tcp_ops,
> > +     .owner =3D THIS_MODULE,
> > +};
>
> [Severity: High]
> Is it possible for sleepable BPF programs to be loaded for this struct_op=
s
> type?
>
> Without a .check_member callback to explicitly reject them, the verifier
> might allow sleepable programs to attach.
>
> If a sleepable program is attached, could it trigger a scheduling while
> atomic kernel panic?
>

This is a real issue. I will add check_member rejecting sleepable programs.

> Looking at include/net/tcp.h, the callbacks are invoked inside an RCU
> read-side critical section:
>
> bpf_tcp_ops_call()
>     rcu_read_lock_dont_migrate();
>     bpf_cgroup_struct_ops_foreach(...) {
>         if (tcp_ops->op)
>             tcp_ops->op(...);
>     }
>     rcu_read_unlock_migrate();
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623175006.31=
36053-1-ameryhung@gmail.com?part=3D11
