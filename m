Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99E61F1534
	for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 23:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773876853; cv=pass; b=r+Fnf8KVCliW5o8rGQLRu06CDMqaQ4nALeyrydCsxDCJxm+HoyDr6Zc/FE6HWAfwUJigSY8kU6jYdftbftvBvZJK1rLxUDTbtHsL0PAJCdsiwx5/0Ga6tqTxxWeOkqJX1eqQQOJzs6SBV1ntaJ8rx6uCuHRa8HgLgPc5khSN2ak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773876853; c=relaxed/simple;
	bh=0FyI810cAM7gpwueBgNw8WHX2d9kV08yFMEJff36wnM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J+Ec0C6VTqU8RPDsV1LuiNSmy0KH9xe8F5Y0fiGui+GPCICnLuuGMSCCYyr6wgkWjpDTOPm1AloI8Wm9A+MSS8r2UBpY/Lkex5qIlmjk9r2EYx37DyB7O3FKMiiqBMcSSpshZYRU1xcRCMs8oG7pp0iN9fRuq4VB7BCzh2iBKJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RJaJIDWb; arc=pass smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJaJIDWb"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-439bcec8613so214558f8f.3
        for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 16:34:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773876850; cv=none;
        d=google.com; s=arc-20240605;
        b=IxJU5PhYYXaZwaSXkyMS6q9+1A39g1i5sKqeHDTqHFU9aCpvmzMayBBs74wvza7svI
         VL4tiIL+YOuq1+fI1/NdutSURkpzeLWIMXMl9/REEcL22TF5wk/9SJ+vb5JV8LJNpGEX
         FFmzxXbWXUNZNoslMgjxVBgpKr02FWY/IZKMV7ivZC3FtI8SpDjjmG4GKBgyRFWw8XWJ
         MxOypLITFhny9yhu9ZLWIoFtIV5XkYVGRA1sn50NqNBkax3+KJxE96JHZANlgyMLwpCB
         1K48DvF674ioG+6nV/TMuVY0nApRzFNlqwKuuPT2Da4i2N8B+nbxQitLwIpPVUCXopIo
         TkYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=0xp1IE3BikoJUXHXS67UH0OszAsTUwaS+KfAtjFsxTc=;
        fh=jR1Kjz2ljfdIALWUCPBon5tMpz4rOpUIQbLfM+lGbgo=;
        b=O0T15HzcBzI2nJnI9gkKRZS+N6HzSjVmjVwNpPKtfujN5b+fiz7lvrdipBeaClwgbg
         FsOor+lVh0FAKU0gLRn55Ouug3E/61UTnm0DfxgGbTjRa0wgqVRFDSt55YTjsa86wUv3
         UewWbTd3GY14GEADdDhuByx3gMsQBTjiRdV8v6XYkYcH3Lwg1YWiuS8otQWssnoF2SMS
         7AS7ZMG2Bvsl6Q3QJjfLSnF1rVzxmqnzM3F6FAXxXDJX5hqdKnzVKutee6niKMdXOep2
         WccwYtzFwslBuLWKpZALNm1tQLzFhCTpZZM+z3OLAWdtvzGlMIjhBWK9HKBwI/dHeZU0
         SsVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773876850; x=1774481650; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0xp1IE3BikoJUXHXS67UH0OszAsTUwaS+KfAtjFsxTc=;
        b=RJaJIDWbQz+gwCr9POU6jPps+oQUZH1o63/n+aJ5hLjLBpQBH8vgltXGFcOBENIaCK
         FEowzHUj1ZavooO7ATMFiu38SuLBeJgDNLchpZD01IICAe1ZOGPrYa66J/4k+R4mVGYn
         2ThtAac/7tLGuix7lWSxIERsGxVQR9WuogD5DUg8enF3k58jFCXCkaRb9ZlH+cMbhYs0
         XJ9vsDbIXO0L6CVRZRT2j80z0NEuICs7+wgngUwp0YOGQRzbgbWmkYqv/B1qCwNmIgtB
         L7ZkU09tRGvW2h6PaQYkoSSpf7r22PvJ/2vnnJMpcPLTXB6hVjoRpKI3VOc+bHAiRJh4
         cVoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773876850; x=1774481650;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0xp1IE3BikoJUXHXS67UH0OszAsTUwaS+KfAtjFsxTc=;
        b=HZ5YwmIF9Ks8VMIUVn9HhmCY0lTlTOhl4fdT7ld5+82cad6aUUbbAEd/aPIIUspHhk
         lO2GzdWWb6ZqgFl2CHzKGCOZNf/ugQDTocPQWOelwvNG7ZkPG/ORPPrAhb94Cp3cBIi4
         Ahg/k4DlzNuX/pMWSKfHflu/9pgZjv8CsHCzwFq4S0e9YBzPSlWuaNNAbvNvyq6b76E+
         EtHpIXHV2+4rPeXMoq+VurCKa86D6fSkvc+C1P0WdK0IsfK5VHMwqxJaxZ8sd087BM+8
         oQeFL5nBiu2HvdRbBNNMJr7paF0QeFmpQqhuOquhnsjb4fLWr1dvHXpl29doulwU1Mer
         jl6A==
X-Gm-Message-State: AOJu0YzqH6XHBrYlkDgg1h8EF0QiiuY+NE5UPsn2XOXMWQve+qRHKY6o
	3XtMpgN3uOyq4l280pp0Zpis2sSK3Q1Tw/bc/4WkF7YAOOQkDw5LZ1BKJbsgsxIJBmB5BpUzQbI
	T4xs+vYEnmomk9hAyHMOv0qwNE/Z88+g=
X-Gm-Gg: ATEYQzzIq7uD9EpSxWvkPN6gPUmNOMVTpTxghlNBkn3WT0OBz+xEuYSaqBbVJj7ihu5
	fJEgk3RuHS4KQQOnPNdf2e8vqLGRuJYlwVEufkOXBt+9WPRRpmY6Z4JAKbeI87arvEFiqoeqGdY
	NYh2RIaito9dQVBNQLmOWW8UnTiygJ9N+Vdw71487ABH1Pi1MPY+Ox8xVHYfNg9mTrM1RxIIGRN
	XnoS40sXpRTNVNKL3JLt0d5GK6D2k8tP3pYK5AVNGNrlMA1mFMuE7Zs0SEG49XnBSlL12uAbdE6
	/HER0YKS6OUl14QxPTc3IZf/OC4nbeYY1C6SdwaHGDXyO6gCPlmauQ9wGh9qDLf/qEqKUA==
X-Received: by 2002:a05:6000:40cd:b0:439:af0e:57a8 with SMTP id
 ffacd0b85a97d-43b527c54c0mr9226604f8f.33.1773876849694; Wed, 18 Mar 2026
 16:34:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318103526.2590079-1-memxor@gmail.com> <20260318103526.2590079-2-memxor@gmail.com>
 <e05e441f4b071a33c71f28d6668f2e580952c7da.camel@gmail.com>
 <CAP01T74km+A-CU9J4n2S+ZkhD+XmgpekU=2_7jF=TTU-T30+Fw@mail.gmail.com> <d6a552009f2f7cafbef5047a2ea8f6428845b755.camel@gmail.com>
In-Reply-To: <d6a552009f2f7cafbef5047a2ea8f6428845b755.camel@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 19 Mar 2026 00:33:33 +0100
X-Gm-Features: AaiRm51tuErFMkdmMY6Fp-s0de8uVd2IuJlm84INnBhOsnhUk1HmeY4uJpz2O5k
Message-ID: <CAP01T77WkOM-fRKg=wrs=geUx0RKh9KAtJ9RbS0wprUfcYS0qg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/3] bpf: Support variable offsets for syscall PTR_TO_CTX
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Tejun Heo <tj@kernel.org>, 
	Dan Schatzberg <dschatzberg@meta.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 18 Mar 2026 at 23:37, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Wed, 2026-03-18 at 22:57 +0100, Kumar Kartikeya Dwivedi wrote:
>
> [...]
>
> > > Let's simplify this as:
> > >
> > >                 if (var_off_ok)
> > >                         err = check_mem_region_access(env, regno, off, size, U16_MAX, false);
> > >                 else
> > >                         err = __check_ptr_off_reg(env, reg, regno, fixed_off_ok);
> > >                 if (err < 0)
> > >                         return err;
> > >                 off += reg->umax_value;
> >
> > Ack.
> >
> > >
> > > Tbh, the above looks a bit ad-hoc, one might argue that a better way in
> > > terms of abstraction would be to adjust bpf_verifier_ops->is_valid_access()
> > > to accept or reject varying offset access.
> >
> > I think for all current cases, the callback is supplied to make sure
> > the fixed offset is well formed.
> > There isn't really "valid or invalid" access otherwise, esp. for
> > syscall programs.
> > We can probably also drop this from syscall_prog_is_valid_access.
> > > if (off % size != 0)
> > Unaligned accesses should be fine.
>
> You mean exception handler would catch it?

lol, that would be bad. It probably wouldn't if it happened.
But I don't think that unaligned accesses will cause faults.
They were there to ensure field accesses were aligned correctly for
other ctx types.
This check is repeated elsewhere, and probably aped in this callback as well.

>
> > If we moved it inside we'd have to repeat this ptr offset thing for
> > most of them except syscall.
> > Second, it does not have access to either env or reg to do the
> > check_mem_region_access.
>
> Yes, this will include some mechanical changes.
> Ok, let's stick with special case for now.
>
> > >
> > > >               err = check_ctx_access(env, insn_idx, off, size, t, &info);
> > > >               if (err)
> > > >                       verbose_linfo(env, insn_idx, "; ");
> > > > @@ -8442,22 +8453,16 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int
> > > > regno,
> > > >               return check_ptr_to_btf_access(env, regs, regno, 0,
> > > >                                              access_size, BPF_READ, -1);
> > > >       case PTR_TO_CTX:
> > > > -             /* in case the function doesn't know how to access the context,
> > > > -              * (because we are in a program of type SYSCALL for example), we
> > > > -              * can not statically check its size.
> > > > -              * Dynamically check it now.
> > > > -              */
> > > > -             if (!env->ops->convert_ctx_access) {
> > > > -                     int offset = access_size - 1;
> > > > -
> > > > -                     /* Allow zero-byte read from PTR_TO_CTX */
> > > > -                     if (access_size == 0)
> > > > -                             return zero_size_allowed ? 0 : -EACCES;
> > > > -
> > > > -                     return check_mem_access(env, env->insn_idx, regno, offset, BPF_B,
> > > > -                                             access_type, -1, false, false);
> > > > +             /* Only permit reading or writing syscall context using helper calls. */
> > > > +             if (resolve_prog_type(env->prog) == BPF_PROG_TYPE_SYSCALL) {
> > >
> > > Nit: this is a second place where this check is hard-coded.
> >
> > Any better ideas? This program type is sort of special wrt semantics of ctx.
> > Unlike all others, ctx here is user supplied, and rw, and carries no
> > kernel data.
>
> We usually hide such things behind a utility function,
> e.g. is_varying_context_offset_allowed(env).
>

Ok, I will wrap it.

> >
> > >
> > > > +                     int err = check_mem_region_access(env, regno, 0, access_size, U16_MAX,
> > > > +                                                       zero_size_allowed);
> > > > +                     if (err)
> > > > +                             return err;
> > > > +                     if (env->prog->aux->max_ctx_offset < reg->umax_value + access_size)
> > > > +                             env->prog->aux->max_ctx_offset = reg->umax_value + access_size;
> > > > +                     return 0;
> > >
> > > Why is this change necessary at all? Wouldn't old code handle all
> > > relevant cases, now that check_mem_access() is updated?
> >
> > I think we cannot pass the access_size through, check_mem_access is
> > meant to simulate an instruction access.
> > Earlier it was doing access on the final byte since pointer
> > modification was not permitted, so real register offset was always
> > zero.
> > All we needed to check was whether access_size - 1 fell within bounds,
> > more importantly just record the max_ctx_offset since there's no
> > bounds except U16_MAX.
> > Now, the register is modified, and we can access lengths wider than
> > those we get from bpf_size_to_bytes.
>
> Oh, I see. Would it be possible to extract a utility function such
> that it is used both from here and from check_mem_access?
>
> > >
> > > >               }
> > > > -
> > > >               fallthrough;
> > > >       default: /* scalar_value or invalid ptr */
> > > >               /* Allow zero-byte read from NULL, regardless of pointer type */
> > >
> > > [...]
> > >
> > > > diff --git a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
> > > > b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
> > > > index f02012a2fbaa..2250fc31574d 100644
> > > > --- a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
> > > > +++ b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
> > > > @@ -134,7 +134,6 @@ __noinline __weak int subprog_user_anon_mem(user_struct_t *t)
> > > >
> > > >  SEC("?tracepoint")
> > > >  __failure __log_level(2)
> > > > -__msg("invalid bpf_context access")
> > >
> > > Nit: should this test case be forked as tracepoint and non-tracepoint versions?
> >
> > In terms of coverage? I have those in the next patch already.
>
> Ack.
