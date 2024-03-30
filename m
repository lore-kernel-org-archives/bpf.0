Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADF94C8C
	for <bpf@vger.kernel.org>; Sat, 30 Mar 2024 05:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711775819; cv=none; b=dgD3brhQOEhrlJsQP3VZ8vGogtMtQNQu8k8PhJRNW5kdpN7gOYUb0xjvESu9TRSU83wZTK5CEnZPZw8vd/ZGRi5FrTH7NBKqlUDloeu/B0EuwHoFduMMNFwkPOe1TLoVQ003OQ1TyRbiEQQvWtMmXce/holajqkGXCO5k/VhYpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711775819; c=relaxed/simple;
	bh=0PxP4nYjIjq1TGjXwgGD6yyI+WgjrU52NwFCDHsXSHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LWIx0aOq2g41iBOaDxG8R+yAytVEPOdta0zYdeMN9NT5ph/wzsLvOsyTyI45CaWfSfPMmi+MRaHBk184UqSN/8VbmRTiX0U9KkKOeSgwK+Dz5ikbRueXVtqSFBaJxZV/pY0hmvTaQjGTt81TM+fFe+NULjyegPIKugSxgXGIpus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZJt5u3A; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZJt5u3A"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2a21330d093so878851a91.2
        for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 22:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711775817; x=1712380617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dTchfKg9vmVu9g0P4uJQi9sv/K2cgUeX/5bHRV2Nmt8=;
        b=VZJt5u3AB42SElpW6WcspZu4K5RTZgFthnxH3wa3/liwJnWd97HDd/PkAV+MuMSKx5
         oMOvaFfDYv4i2FbuRU6X2HIrPZSnhhH1x/9erSBg4DROXcD77z2T2953BwAkyTqf+jQd
         UICA8A+U9ifW6AozzlJD5ehm7dgdSR0AsxaYJ8PES/UXCL2TYgFzAbyQgNG+wytexeA5
         /dWUEE7kk7qngLzxg6rsqlj3rKNpXKr1N3yJ//ukD4EYHNu883IAMspeQ7IefHKTdJ9n
         6DG9qsI717gMlm0jN674lrbB49zmt6nWp8vTUIz8pBSvZsv65M/YvjXdyBi0XPAjW3Fv
         iiEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711775817; x=1712380617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dTchfKg9vmVu9g0P4uJQi9sv/K2cgUeX/5bHRV2Nmt8=;
        b=G9T+t7KmByxk8UtFeJ9Kjtm+rhx1nWKYcRa9yAxOX27NRFZ6kz0dvL5P4CfK05g7lY
         QDCL26PK8ZLT4Sa1fOytckWQVan/ad0U9jB6/hfhlNbZRv9N5G4Vs9xD1XyGTdQwd1Om
         XumCsrVDjOTT9EeEFZgblU9shYeXYvpSddgr6XGC84YeXVhY+ZCUhBuGtxqo4nzZZQN2
         VQSnbKkiQMDGujoPLG5Khuq2LJQw8Hb9qPceDGmBqk9ngeEl2wRk6+CH5HSOrSrQ6uqu
         CWZXXEQ+Bxhohir8ntmECF017/iD0nAcfQEiCXKVDnBvt8HKqySYmvDpfxiTRRxzsDgB
         PR6g==
X-Forwarded-Encrypted: i=1; AJvYcCVjXvE1yqpvFqF8wYtczQq3WxW/knka05rJ3WP/2p+Vx1PT/I9xm66E0BM+9cxs9WVBhlXeWzPY0Yx4mjLPrt22pG0q
X-Gm-Message-State: AOJu0Yz+FbPXHk5nHTz/AOxosLLTRL7/zXhoFAEDu6QgSXuTSA4KWlz2
	2lb3axkJk6IXz3NjPiU/NdNRbwonhIQucxXIJikOZxg8xJLf3J2xq4hT6rl8q2thtc72z5Mbh0n
	WXb+8ZkZmZaATGIGOocnAHWI1mbI=
X-Google-Smtp-Source: AGHT+IEha5+Q7xpsvKmTiyb2m9Ddwj9GWc2kDRACKnV6l3IkYvZLkRYkWMQSSDGAgtp3hmxv81uxHUX2dEgKyKv2dgM=
X-Received: by 2002:a17:90a:a40a:b0:2a2:8c1:db76 with SMTP id
 y10-20020a17090aa40a00b002a208c1db76mr4093265pjp.29.1711775817512; Fri, 29
 Mar 2024 22:16:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329184740.4084786-1-andrii@kernel.org> <20240329184740.4084786-3-andrii@kernel.org>
 <CAEf4BzZk-iHvSMW-9S44NdqVhQE55dhvSz952Fm_3yWhm6wBeA@mail.gmail.com> <CAADnVQ+P4GiCym_u1FsmxGKfXEX40PAPpFSwMr6VUp9UhF5VaA@mail.gmail.com>
In-Reply-To: <CAADnVQ+P4GiCym_u1FsmxGKfXEX40PAPpFSwMr6VUp9UhF5VaA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 29 Mar 2024 22:16:45 -0700
Message-ID: <CAEf4BzaHu0sosJkH1E-Eidq6qgRBM0N-asChzSZ5PWKC9DZSHQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] bpf: inline bpf_get_smp_processor_id() helper
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 4:41=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Mar 29, 2024 at 1:27=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Fri, Mar 29, 2024 at 11:47=E2=80=AFAM Andrii Nakryiko <andrii@kernel=
.org> wrote:
> > >
> > > If BPF JIT supports per-CPU LDX instructions, inline
> > > bpf_get_smp_processor_id() to eliminate unnecessary function calls.
> > >
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> > >  kernel/bpf/verifier.c | 17 +++++++++++++++++
> > >  1 file changed, 17 insertions(+)
> > >
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index edb650667f44..24caec8b200d 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -20072,6 +20072,23 @@ static int do_misc_fixups(struct bpf_verifie=
r_env *env)
> > >                         goto next_insn;
> > >                 }
> > >
> > > +               /* Implement bpf_get_smp_processor_id() inline. */
> > > +               if (insn->imm =3D=3D BPF_FUNC_get_smp_processor_id &&
> > > +                   prog->jit_requested && bpf_jit_supports_percpu_in=
sns()) {
> > > +                       insn_buf[0] =3D BPF_MOV32_IMM(BPF_REG_0, (u32=
)(long)&pcpu_hot.cpu_number);
> >
> > so CI reminds me that this part will have to be architecture-specific.
> >
> > We can keep BPF_FUNC_get_smp_processor_id inlining here in
> > kernel/bpf/verifier.c, but have arch-specific #ifdef/#elif/#endif
> > logic? Or we can have an arch_bpf_inline_helper() call or something,
> > where different architectures can more cleanly implement arch-specific
> > inlining logic? What would be the preferred way?
>
> I'd gate it to CONFIG_X86_64 or have a weak function on arch side
> that returns a patch as a set of bpf insns.

Ok, I'll gate by CONFIG_X86_64 for now, it's simpler. Once we have
more arch-specific inlining we can design a better interface.
