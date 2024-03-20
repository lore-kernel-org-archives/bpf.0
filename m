Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C721E516
	for <bpf@vger.kernel.org>; Wed, 20 Mar 2024 17:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710956828; cv=none; b=deb516klkMGn+2lfEwHhYnmApUeyE/eETsptrXVDUslDwATgGhjMYaOVd/7XY6ekctWeKTap5gHTlNoXVcsISjjcByVTSuRBMNje13aEs2PAD2N+vYmlztZ6UvW0wq6MMP7PtaWomo6nP+mfArMrOXY9wdgA2QPI7Gnv4W1kSY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710956828; c=relaxed/simple;
	bh=rPGCHnj0Zr+54Dbmtu2NMXPzL6qEdt0tSrHQY8pK5ok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eP539ZCuL1a4t1WEtEyi4UCsC7fRAbCyz2XisBnYwzCIHOeKtTtwDWtI0KFTYwvo61PcVcmG7qnazkWkdexzykPZAMrqNJN8hDe+fsDkKo5GPhlDzwfJ0MGlqcT8ONLP0y0pkyzT5qzlNWoE0Kk0Gj8HHQDaqtGTdlm/SJCMG0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lKsY/oYB; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKsY/oYB"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e6c8823519so193323b3a.0
        for <bpf@vger.kernel.org>; Wed, 20 Mar 2024 10:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710956826; x=1711561626; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tKEthRsoLF5oMNKAmmCM9PKXwQ5tjLTwUO2q6MMgfSU=;
        b=lKsY/oYBx8sbgeCrADxxXreCAR0GcFEI1M3EVsoJGKBfVBUKO/5lYllNC+yveS3fLM
         e1a1BtrUxbXRCQKn5sxvaVOdyNeKic2WrxzYwIF1fCcvIWy7MqX26qpWj257QFDDkCeC
         4avOq9PwXu68j6YIdV5gPWUTVFOozoLxMIBERj+qMPPN+Oz7XUTZnbPImlO6Zybmkaq+
         e4ZeIojXNz4EW9qezB0RuKN8xrxC/uCln0Lfv282NxGf7pX1vD3fYkXWjoRLtGRga44V
         0/l0I1yYaN3kUaeUOnMMDxg9od6S8UXDUNRX0AizlcSO4UojtPs1b+scPnAoHmxZkTm1
         WgMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710956826; x=1711561626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tKEthRsoLF5oMNKAmmCM9PKXwQ5tjLTwUO2q6MMgfSU=;
        b=bdCgrC54yKTUu/kaBVq0b6YPMatObczE1Minfes93l9JMFx+tQrUHYGi2DewC/nbdA
         9PWZn69dpcqPya9o0wCbPdmCz8bmT9CU11tN1YGLGgHYUg56bIdlgA42DEgdrr5Ol0Po
         OB44GmFWuTtW+7shdPonRYDducwni/0/o6kDkgZz2dIzNHuXroNUTESbgFHL3rN8TW1o
         2MsVtjH/Bt/DC+edf3aJvtoLCaaBLaR266ou77m/vM5LZqyhTOLEH92kre+wsDSQghDO
         PVrI3IbTyoYP8+w53wQ7En8lIWopPgLlbtJmfJt64Skfvip1baFEMPMmmlKl8L/Y+C7R
         aQZg==
X-Forwarded-Encrypted: i=1; AJvYcCVCw2FktaHYSfjGE5pieJTTowdtgemh2ZB2Qrwi/IUeJkN24qCXM42fwsjYYYvQnvF+GaKTk0S/AiIrILmG2+dLKV7a
X-Gm-Message-State: AOJu0YzzG4rA2m/rlE4pAsML8o02RlkBKBZGGQGG7HdfXI5kqkKl2DCV
	/wtgHhbHiP8w30ohKBKy4dn0oV2CdrCnUOgHdcEGFiOs8/nx9ArStToigQB9dyTJ3t1GDzL7FQ9
	F/Bz7RmVqELRKquMsvLHyNTyCL0g=
X-Google-Smtp-Source: AGHT+IHOlt6VSLbvsN3etaIwIsa0d3EeJZ2zdch4rxS1CEHdet9JvGyKJ0aBYV8RvVD9J44/1zHQayrwTLfI0kmIv4g=
X-Received: by 2002:a05:6a20:7483:b0:1a3:6644:deff with SMTP id
 p3-20020a056a20748300b001a36644deffmr8047253pzd.43.1710956826472; Wed, 20 Mar
 2024 10:47:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319212013.1046779-1-andrii@kernel.org> <20240320124742.5652f47b8f6dfea24cf84ce9@kernel.org>
 <Zfqfgn6lqwRCFQaD@krava>
In-Reply-To: <Zfqfgn6lqwRCFQaD@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 20 Mar 2024 10:46:54 -0700
Message-ID: <CAEf4BzZ_HGWwc2KWGUtu+_e5OYoHEpdzrk0vLDfv7vYvyihniQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: avoid get_kernel_nofault() to fetch kprobe
 entry IP
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org, 
	kernel-team@meta.com, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 1:34=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Wed, Mar 20, 2024 at 12:47:42PM +0900, Masami Hiramatsu wrote:
> > On Tue, 19 Mar 2024 14:20:13 -0700
> > Andrii Nakryiko <andrii@kernel.org> wrote:
> >
> > > get_kernel_nofault() (or, rather, underlying copy_from_kernel_nofault=
())
> > > is not free and it does pop up in performance profiles when
> > > kprobes are heavily utilized with CONFIG_X86_KERNEL_IBT=3Dy config.
> > >
> > > Let's avoid using it if we know that fentry_ip - 4 can't cross page
> > > boundary. We do that by masking lowest 12 bits and checking if they a=
re
> > > >=3D 4, in which case we can do direct memory read.
> > >
> > > Another benefit (and actually what caused a closer look at this part =
of
> > > code) is that now LBR record is (typically) not wasted on
> > > copy_from_kernel_nofault() call and code, which helps tools like
> > > retsnoop that grab LBR records from inside BPF code in kretprobes.
>
> I think this is nice improvement
>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
>

Masami, are you ok if we land this rather straightforward fix in
bpf-next tree for now, and then you or someone a bit more familiar
with ftrace/kprobe internals can generalize this in a more generic
way?

> >
> > Hmm, we may better to have this function in kprobe side and
> > store a flag which such architecture dependent offset is added.
> > That is more natural.
>
> I like the idea of new flag saying the address was adjusted for endbr
>

instead of a flag, can kprobe low-level infrastructure just provide
"effective fentry ip" without any flags, so that BPF side of things
don't have to care?

> kprobe adjust the address in arch_adjust_kprobe_addr, it could be
> easily added in there and then we'd adjust the address in get_entry_ip
> accordingly
>
> jirka
>
> >
> > Thanks!
> >
> > >
> > > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> > >  kernel/trace/bpf_trace.c | 12 +++++++++---
> > >  1 file changed, 9 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > > index 0a5c4efc73c3..f81adabda38c 100644
> > > --- a/kernel/trace/bpf_trace.c
> > > +++ b/kernel/trace/bpf_trace.c
> > > @@ -1053,9 +1053,15 @@ static unsigned long get_entry_ip(unsigned lon=
g fentry_ip)
> > >  {
> > >     u32 instr;
> > >
> > > -   /* Being extra safe in here in case entry ip is on the page-edge.=
 */
> > > -   if (get_kernel_nofault(instr, (u32 *) fentry_ip - 1))
> > > -           return fentry_ip;
> > > +   /* We want to be extra safe in case entry ip is on the page edge,
> > > +    * but otherwise we need to avoid get_kernel_nofault()'s overhead=
.
> > > +    */
> > > +   if ((fentry_ip & ~PAGE_MASK) < ENDBR_INSN_SIZE) {
> > > +           if (get_kernel_nofault(instr, (u32 *)(fentry_ip - ENDBR_I=
NSN_SIZE)))
> > > +                   return fentry_ip;
> > > +   } else {
> > > +           instr =3D *(u32 *)(fentry_ip - ENDBR_INSN_SIZE);
> > > +   }
> > >     if (is_endbr(instr))
> > >             fentry_ip -=3D ENDBR_INSN_SIZE;
> > >     return fentry_ip;
> > > --
> > > 2.43.0
> > >
> >
> >
> > --
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> >
