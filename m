Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B529412C524
	for <bpf@vger.kernel.org>; Thu, 21 Mar 2024 16:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711037793; cv=none; b=BSdz2L5L9rTtju1CY/YovZ++XqgNL0MNU1I/iOrTakN9yOlwmJdNQWe1bnaGFBpxFyhY31k/WKIxQibhko6u4gCS+r6PxPiE3iMMIVawO/Zmn0MMTdXrumnpdgu+ubnGdL1a9+oU6baqTrw7GJ3G5ItBM/ld7yEHjH7VefYTdAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711037793; c=relaxed/simple;
	bh=LPYtcYsWsUXdeUHJWH7lgZBVEtyCERLVzrMzizOIdHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dn00KSgg3mLKEBjBNXJN6Zzb68V3gHf820za+CtM3dFny2fXe75ihzN+fKuYzk2nT+CvuD2pVuM2Lb8OCDhkMpIk2HiOvv6mWZhRm2Toef9rx7Bfs+fobZRdlIGt9EvCoUiXpvdTeV5t+hSWqRotYytuliDxZruhAuP8EToey3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fWmEqLPy; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWmEqLPy"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-29c731ba369so841029a91.3
        for <bpf@vger.kernel.org>; Thu, 21 Mar 2024 09:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711037791; x=1711642591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PgUC8AAWMDx5mEEnE1Y/DnXlkiBVHp0xGogTiffPR/0=;
        b=fWmEqLPyRzZ7p7C9tFka7yFchGtNO+2VLj8HMvoS2SL8RZMSt0D54QBu+GaLx94gFp
         VNn0obE+TamJ5sBXyUDOLoAl385kgHfgiRRtlLa/wGJJ4nasR64aojzgDzHYy/+OEVnc
         R/umLWQphw0yB3vYxmdokOC+vb99ZHZJR8voBf6S3wa3ISlMAB7st7+LqOjpK0QQWANX
         82a1bwIW94rZ+JxLo2FvknCtNnv7ABXIIzERYv/UIcGmEcjh8Y3y/Ayk6qM2qGra+N+g
         VPCwGyCT4NuyO3tHyh4KSxH66w6Upzom5cChYgP/4T0KBNRZ192pVN+ZoEYKI1At4MP6
         G4MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711037791; x=1711642591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PgUC8AAWMDx5mEEnE1Y/DnXlkiBVHp0xGogTiffPR/0=;
        b=quTWf1HSbll//NyQ6uh3ol3X3bY2iYivOYkzBSjvrvTkHK4KU51dX+jJlF6gFwUBdE
         19tTh9xTh/4QveWo0qj87e6G001HR8VRUnIbcDtXRFxVrgIgiYV+13U2TqlkW+QeqStk
         1XUaW+/6jZGJPTx8hKN27j3jBMoYiVI8dE+hrlKFFOPtFH4S4yH1unbmbYbdiXwpd7++
         EjtcHxmHhIr5yaGgQhzMxE5yBCipGWwHMxHbJ7yJAsCAPzxl+V2nIbM1x/kgcesoFB7v
         qDkAf15ZOtYoP15coJafDnslURwENjgWP6Qb/ERzMAlg4wxGuq8hikjSUliXa/MuWuK7
         oK/w==
X-Forwarded-Encrypted: i=1; AJvYcCVH25w9BkxXXYtsvXRFqmkfJKbvEcodlLzwhn+qClqoA1BKnoEAQN2wwQcAexKJAsiz68r3blWXpVEt5+MYCzvye14n
X-Gm-Message-State: AOJu0YytR30j/U67Z4peHOVA3xW99Edw8V6LB72GU2UBb6rs8M2M7esx
	ewg9Ge9k8w3zqe+CyiZqHavdzOP7UoNgpy9FFRLTAPl68IVMMrJktAY7LfbvACr8i8eMfKEj6Q4
	1kEtYt4CdTAZDDMys/w61Q5qaDXRbfJ/s
X-Google-Smtp-Source: AGHT+IFCHURwSi263dKwoN02Cvtk8lFOYCNIrqCdazBvxFnp7ETW2a1DpSZA+unZBFUISgjxVjXkmRsMyBOhrE/PbFg=
X-Received: by 2002:a17:90a:4590:b0:29b:5c1:5e05 with SMTP id
 v16-20020a17090a459000b0029b05c15e05mr5226408pjg.2.1711037791037; Thu, 21 Mar
 2024 09:16:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319212013.1046779-1-andrii@kernel.org> <20240320124742.5652f47b8f6dfea24cf84ce9@kernel.org>
 <Zfqfgn6lqwRCFQaD@krava> <CAEf4BzZ_HGWwc2KWGUtu+_e5OYoHEpdzrk0vLDfv7vYvyihniQ@mail.gmail.com>
 <20240321084628.71442185b1fad5fdd47d0bab@kernel.org>
In-Reply-To: <20240321084628.71442185b1fad5fdd47d0bab@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 21 Mar 2024 09:16:19 -0700
Message-ID: <CAEf4BzYZMe8d=Vq-vTykNkHAGADUBEv_tOui3U3mVZ-94y8JFA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: avoid get_kernel_nofault() to fetch kprobe
 entry IP
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org, 
	kernel-team@meta.com, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 4:46=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.o=
rg> wrote:
>
> On Wed, 20 Mar 2024 10:46:54 -0700
> Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> > On Wed, Mar 20, 2024 at 1:34=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> =
wrote:
> > >
> > > On Wed, Mar 20, 2024 at 12:47:42PM +0900, Masami Hiramatsu wrote:
> > > > On Tue, 19 Mar 2024 14:20:13 -0700
> > > > Andrii Nakryiko <andrii@kernel.org> wrote:
> > > >
> > > > > get_kernel_nofault() (or, rather, underlying copy_from_kernel_nof=
ault())
> > > > > is not free and it does pop up in performance profiles when
> > > > > kprobes are heavily utilized with CONFIG_X86_KERNEL_IBT=3Dy confi=
g.
> > > > >
> > > > > Let's avoid using it if we know that fentry_ip - 4 can't cross pa=
ge
> > > > > boundary. We do that by masking lowest 12 bits and checking if th=
ey are
> > > > > >=3D 4, in which case we can do direct memory read.
> > > > >
> > > > > Another benefit (and actually what caused a closer look at this p=
art of
> > > > > code) is that now LBR record is (typically) not wasted on
> > > > > copy_from_kernel_nofault() call and code, which helps tools like
> > > > > retsnoop that grab LBR records from inside BPF code in kretprobes=
.
> > >
> > > I think this is nice improvement
> > >
> > > Acked-by: Jiri Olsa <jolsa@kernel.org>
> > >
> >
> > Masami, are you ok if we land this rather straightforward fix in
> > bpf-next tree for now, and then you or someone a bit more familiar
> > with ftrace/kprobe internals can generalize this in a more generic
> > way?
>
> I'm OK for this change for short term fix. As far as I can see, the
> kprobe-side change may involve more kprobe internal changes, so
>
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>

Great, thank you!

> >
> > > >
> > > > Hmm, we may better to have this function in kprobe side and
> > > > store a flag which such architecture dependent offset is added.
> > > > That is more natural.
> > >
> > > I like the idea of new flag saying the address was adjusted for endbr
> > >
> >
> > instead of a flag, can kprobe low-level infrastructure just provide
> > "effective fentry ip" without any flags, so that BPF side of things
> > don't have to care?
>
> It's possible. But it is a bit only for BPF and not fit to kprobe
> itself. I think we can add it in trace_kprobe instead of kprobe,
> which can be accessed from struct kprobe *kp.

sure, if it can be just "endbr64 offset" instead of a true/false flag,
it would help to avoid extra conditionals in the hot path (which waste
LBR records in some mode, which are important in some applications)

>
> Thank you,
>
> >
> > > kprobe adjust the address in arch_adjust_kprobe_addr, it could be
> > > easily added in there and then we'd adjust the address in get_entry_i=
p
> > > accordingly
> > >
> > > jirka
> > >
> > > >
> > > > Thanks!
> > > >
> > > > >
> > > > > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > > > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > > > ---
> > > > >  kernel/trace/bpf_trace.c | 12 +++++++++---
> > > > >  1 file changed, 9 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > > > > index 0a5c4efc73c3..f81adabda38c 100644
> > > > > --- a/kernel/trace/bpf_trace.c
> > > > > +++ b/kernel/trace/bpf_trace.c
> > > > > @@ -1053,9 +1053,15 @@ static unsigned long get_entry_ip(unsigned=
 long fentry_ip)
> > > > >  {
> > > > >     u32 instr;
> > > > >
> > > > > -   /* Being extra safe in here in case entry ip is on the page-e=
dge. */
> > > > > -   if (get_kernel_nofault(instr, (u32 *) fentry_ip - 1))
> > > > > -           return fentry_ip;
> > > > > +   /* We want to be extra safe in case entry ip is on the page e=
dge,
> > > > > +    * but otherwise we need to avoid get_kernel_nofault()'s over=
head.
> > > > > +    */
> > > > > +   if ((fentry_ip & ~PAGE_MASK) < ENDBR_INSN_SIZE) {
> > > > > +           if (get_kernel_nofault(instr, (u32 *)(fentry_ip - END=
BR_INSN_SIZE)))
> > > > > +                   return fentry_ip;
> > > > > +   } else {
> > > > > +           instr =3D *(u32 *)(fentry_ip - ENDBR_INSN_SIZE);
> > > > > +   }
> > > > >     if (is_endbr(instr))
> > > > >             fentry_ip -=3D ENDBR_INSN_SIZE;
> > > > >     return fentry_ip;
> > > > > --
> > > > > 2.43.0
> > > > >
> > > >
> > > >
> > > > --
> > > > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > >
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
