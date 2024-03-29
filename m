Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566041119F
	for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 23:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711755717; cv=none; b=pE5lPg18aQ2nUm30ts1Ff7vqinNYiWMndRX0yS83MxETbJUhVpRWl8R7SbFQAmFNn2IM7WZfz+qLXbKbeTvg74IpQZbvWtByD6odOkztjdmTgXcca8GVxycPUpNobfZ/7CgYZ4mFKOXbcC+cj8HO/FGaEGuD/nbiQPu8NQLKnes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711755717; c=relaxed/simple;
	bh=1guw3f8qi5pq+of8OBkCnW3RBU1rVhJIg5dqGVx3r+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oEuabksxJRX0W+5nBJiyj+Ylx7eW4UBsVQdfQg+CliKttY44PUp1DXMQWZU8Fy14TQj93KCPlMsWkAi8fupuq8VOFYpfph7JxlBpNv+kqxvYfUdxPInCPWnzfLLxciIta+/TE/+JopM375LGB4rxrmwLYwFpEvV5FybPEgJFqsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fplTwCLy; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fplTwCLy"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33edbc5932bso1673952f8f.3
        for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 16:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711755715; x=1712360515; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z9W4dG9j9fXq4wHZwF+TduxgkbKMeRBt8KYQXaonZUQ=;
        b=fplTwCLyfEZIevtukDtVzIuCCqLCpzDX8OwIob6pomEPPX8gt5pJ9x10er1gKxTCch
         rOJPpFov14s+FDBuyrDEgzuZQ2GEi33zCRyoT7KkPebpGpxA0G2ZvlmVea3+l/5vcBOo
         cQEW4W4/uOSziBG9BzJsDF+qnUBcmbwO2N9WwxBqUL4eZSXHmVKFCtC3VhLeX/ttsfSE
         odCUrajtLM7YjdnMQrV4bpCbpYB420yl/0uptYB0DlL0DDbVW1A4xKMkkk8WBgX/FNne
         ZlTnqTvcTJSTEUuYMsjCgZ513wFdA2q3KtV2c0no5gsutKKiogOpxiQ9gCF7Dh5wAbT7
         Cr3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711755715; x=1712360515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z9W4dG9j9fXq4wHZwF+TduxgkbKMeRBt8KYQXaonZUQ=;
        b=UinUAZ3dOcEb7SlVRj1r5xOG0Z+2WCdE3JsqIJCPwuRXjEd0AkDEFZWAIEMWVtd6nX
         RmOIh9gdKdNG3GZf0MsBWERPCWEYraXlK+WjFKFAerNOfFPuN0C/OCtpp2AxMx+fP0i1
         hA4fZl/z5TufTQPy6P4hr3EyiZwNT2IIurilEK1khW3PK+nExRqSiSfk42TUxWfF+2Ad
         KuVWwFTudidjTrYNgU3+i+S2eJnCcDTKpnw3o+OS3WlWoy3/fLNAy8/d8mVO9hgnaHPN
         LzK5nj3w4SRtAvgHZtkqqoIaNREm9uYanFlLbNpSDiHE7jse2XQ1hESYyqqIOhgEj3Ca
         b43g==
X-Forwarded-Encrypted: i=1; AJvYcCX4Qi2C0Mrxr5lw7TD7ndMtNoolYxHtjNLTrlquMDo8Alv6/kXz/ZV+zaOBdViklzVA6gfS7W5YtDNx1bgU53f4orSF
X-Gm-Message-State: AOJu0YyQoA0qpT6WiSo/YBTvvhrUbwD0u3+Rwj9PNnyTMond1X+uKEuA
	7esMfJ4jB70lh2wRFmPkwLjrIC5+vWImH8J6zT3+Jf3sYVaKJEqoY/5EEQsThCzZiJISWyzhRmB
	nzMIcgnATqAO2Bh1TyZkMrztElno=
X-Google-Smtp-Source: AGHT+IGeXrRNvEfWXYYCtNnjVFTSC6qAQM0YzSUfoA1XI+En3yn807snTTxgXQDY1qFDQ8Zo42i4xzLMi/dk3U559FM=
X-Received: by 2002:a5d:40c1:0:b0:343:354a:88f8 with SMTP id
 b1-20020a5d40c1000000b00343354a88f8mr2128013wrq.67.1711755714635; Fri, 29 Mar
 2024 16:41:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329184740.4084786-1-andrii@kernel.org> <20240329184740.4084786-3-andrii@kernel.org>
 <CAEf4BzZk-iHvSMW-9S44NdqVhQE55dhvSz952Fm_3yWhm6wBeA@mail.gmail.com>
In-Reply-To: <CAEf4BzZk-iHvSMW-9S44NdqVhQE55dhvSz952Fm_3yWhm6wBeA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 29 Mar 2024 16:41:42 -0700
Message-ID: <CAADnVQ+P4GiCym_u1FsmxGKfXEX40PAPpFSwMr6VUp9UhF5VaA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] bpf: inline bpf_get_smp_processor_id() helper
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 1:27=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Mar 29, 2024 at 11:47=E2=80=AFAM Andrii Nakryiko <andrii@kernel.o=
rg> wrote:
> >
> > If BPF JIT supports per-CPU LDX instructions, inline
> > bpf_get_smp_processor_id() to eliminate unnecessary function calls.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  kernel/bpf/verifier.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index edb650667f44..24caec8b200d 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -20072,6 +20072,23 @@ static int do_misc_fixups(struct bpf_verifier_=
env *env)
> >                         goto next_insn;
> >                 }
> >
> > +               /* Implement bpf_get_smp_processor_id() inline. */
> > +               if (insn->imm =3D=3D BPF_FUNC_get_smp_processor_id &&
> > +                   prog->jit_requested && bpf_jit_supports_percpu_insn=
s()) {
> > +                       insn_buf[0] =3D BPF_MOV32_IMM(BPF_REG_0, (u32)(=
long)&pcpu_hot.cpu_number);
>
> so CI reminds me that this part will have to be architecture-specific.
>
> We can keep BPF_FUNC_get_smp_processor_id inlining here in
> kernel/bpf/verifier.c, but have arch-specific #ifdef/#elif/#endif
> logic? Or we can have an arch_bpf_inline_helper() call or something,
> where different architectures can more cleanly implement arch-specific
> inlining logic? What would be the preferred way?

I'd gate it to CONFIG_X86_64 or have a weak function on arch side
that returns a patch as a set of bpf insns.
