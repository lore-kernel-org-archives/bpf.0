Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C451481FCF
	for <bpf@vger.kernel.org>; Tue,  1 Sep 2026 17:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788285372; cv=pass; b=m5CRfiZcod4mKzmJfdpPBXrMYam5zxs7Ts4SYMsT1QBBrvjKxUfytzwj1oGcX4c97PHmf/dLgBBSOL9VXsqYaaft9tVhmv09OhVpLQfcJn1MTxu3Pt/iaYx255x47Wy4p+QGVR0r+I1wTopbDjXSLV+v69vYTOuqc6YB+OFpeow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788285372; c=relaxed/simple;
	bh=67sOcTV81JkApNbqX2hOH9VuBpJBwGJvqocSdcu1+PQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i2GrD9hpPVswYvxhR+fwfMfWAzPDm+MuC33KnUcuwBq9qrITIgtryi6d10KgttmD+ncT34K+MkhqD/3OhuejKL0B7f17QqvEoxonZIGGe0jeZB+LxY+l5YF74YeBdpDfx1t2tTu4nqTUIIYAZKbwIAp5XYIZDNqSwLZ22vstK7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JdMs/s5r; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JdMs/s5r"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-855de2d0d4dso2091227b3.0
        for <bpf@vger.kernel.org>; Tue, 01 Sep 2026 10:56:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788285370; cv=none;
        d=google.com; s=arc-20260327;
        b=qHNsZatqW0/Qc6SmwV4BQYBqGAEr2Vroid3WtOdTISqI2mSSrHrGykUJ2FAN/9cjhX
         og5+pnGDiX0OxdHCcovIi1oDx5FTAunBE1JTBmB7p9rEpByl4f5P4vJNCuh7J3VrjwVm
         GQmjAurE9nlqR4t6l2RL5wHWOfidaEattJUg1gLGlktae9XVhNFeckl2NKHMkMnDGax5
         ArklpUF/l4noHzIio1pU6gf7mwpdwVtbktM2iIDO0REDK+zy2Fq8YT3UbXfQ87BXAKT9
         B8KBaDomSn4A4pwfti2h11JT1BwLTdn2ZJm8118TgGqSzOZUWG/RA4kd5WRyUBUFMn5/
         1X3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=RK13kFiX7PMi7gWJ/iJTKlNdEr1DypWw7v5RoTmQuwU=;
        fh=rORxYEv5MRHYqTd4UzC7yFcfKOHEyqQiCdJSoJdB0Q8=;
        b=gIkemZ8zRuADOVQQTdu6npLQIsi6ZrsPSjkwUdXrSPXE6FBiTyhXix9uzzai1daSKa
         5kGGsHhwTKZTTGMpMuAnW1A/nKgKVsh0R1BIJVaIyJ4YmymnvhTOWKTQHDU21n47ZPJ7
         2ZhQblUNHt354yAqnsBdyZusST+OquA1puZCAKYv1xnIWrW+dAmnEaYilnHKeB/w8/6E
         cZJ3SwaCXuzZtZG+rF1KJ1lBhxm7crvMMwtRdECVxyVtZf1uxMBcup7ffd70By+AM3kt
         9R/fZ6xI7I4Gj59kG9Pca/yccbUAWVTuYAKeizkLpFJBVlIcdwRoAu6zWKTpQAAcFj2r
         Wihg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788285370; x=1788890170; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RK13kFiX7PMi7gWJ/iJTKlNdEr1DypWw7v5RoTmQuwU=;
        b=JdMs/s5rO5vrVn1wsI84kXvvZWj0zfi1tbpoO2gSKXZ/X8AzR2DMEniQ5ytsXqmOGB
         BpWkpQEnL21LP2nIXYqF1UMDdXL0yUaq32tveRdfRQxZThQon0UfdOkcdcd9vl+BAJRO
         7H84d67oukxoKSdeNIxozJRvjuY6uV8TJwPVPH3Z72BZIhaXNrLpm29W+WYKSWJ/K3Ap
         zbP5AWVsuVcK9QQGs11X85e8U0srH3g/hhsEpmkI96NT+tUYKWvdGPB2wQltzWZii0au
         EXxsZrp0stzNngd+tD/O0KGQKD8o98McCJGOeZwqOa703sNF/sHIqcRD5q1luDitgM2z
         NejQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788285370; x=1788890170;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RK13kFiX7PMi7gWJ/iJTKlNdEr1DypWw7v5RoTmQuwU=;
        b=VqK2Bs4ZoYylySV/tRxg1WtkuNICXYdrvtwzpnDQUBmy3clbbfjjY9OA2yYBwXXu1J
         QhhmfHqBxZkOUZW6uwrv9qClr0nl9rGmLxFUMOSLRQ3Nrsr2Ln8HQgNI6tJdrbIRJLkr
         toTrPWdHTic+TwC1RjQVlvEOPAu2XW0bIPta6CRfEcZH2t0Sem57zIDeKU6vyBdEz/4n
         lt+3Vdisvb+teJ9mFPILV9YDnGb8jhDZ8UTP9u1INTLGIkBwAzlRMVGbD/T7LW8cwBD5
         5NMrnzmbwCslOfLbVxh120ZqqTc1buxIX95Lddu2gprkhMYK0hUkTn3wgxnqMTMAaeX7
         FNug==
X-Gm-Message-State: AFuF++lTTFPrAr/ecKUmbSOfnflmEWjLMC8lww7tIETtmqDmaFvogSp7
	swgMdEHcFJpdYZ4Gh8Qc8BdVCltIPAHqbn3gmc6mxOtI2nC5L/IR+WoW8iH435dgBuvGa45gkKI
	8DYe2JF1yMR5EnF2MiWjFRBXoBPrIgPk=
X-Gm-Gg: AYBFou1k1dp3D6x+sUj0rOo1d8HdSyi2QestB/P9CU0HjT3LVegqh/aqRp6hm2EMt0m
	zEanSXznA/6M+f95d6r6XZwe4tdQYYhsLGMIyLQiMSiVZgWta3HO4jPydODEXDjCz/+hs2H712P
	qZEyfjCWu2riLh0VZhju/YrQ91T9wxxD7mSFI5OVxCRs9v0xbkSEBUNlxQe2BbWVgxc2qMWXFVN
	762vjRPHDW0Q2t2JxdLU5vxwc9N1WQIk/HAGbXznCtA0p5mEey7Jr56s3rhlQCOFXdv+rc5sN/+
	jA7o8ne3QvBBT/TvF2MX64HSWdDeC6wvFixO7OHrspmOEYGjhYtrPZXPvb/rPeVVlU1CH5Ub2lY
	SPVMaHLaqwQZYqeqM+C0VGsGlffuXIiQOuvhk4LdUb4lJAnbludd2RdCSV0AvH2JjvRuLswsMuZ
	axGRtuEwVIHj9E
X-Received: by 2002:a05:690c:e294:b0:81e:b78d:688b with SMTP id
 00721157ae682-8694c44cfbcmr26753987b3.12.1788285370161; Tue, 01 Sep 2026
 10:56:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901170144.70453-1-sidchintamaneni@gmail.com>
 <20260901170144.70453-2-sidchintamaneni@gmail.com> <apcRnSj7dVW1Dlsr@mail.gmail.com>
In-Reply-To: <apcRnSj7dVW1Dlsr@mail.gmail.com>
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Date: Tue, 1 Sep 2026 10:55:59 -0700
X-Gm-Features: AcwNN1XUxT6E63XNwqnj8eULpwdcWDTD-Sc6Xg6BKN5m6SQ_j_7c65Ms_cHzrXU
Message-ID: <CAE5sdEgXd3AcJyRO6zdNEtFs-bwXRWzbA_qMR=Xdi9qA_NZvJQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Test terminal gotox instructions
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Puranjay Mohan <puranjay@kernel.org>, rlmenge@gmail.com, hargar@linux.microsoft.com, 
	apais@microsoft.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 1 Sept 2026 at 10:45, Anton Protopopov <a.s.protopopov@gmail.com> wrote:
>
> On 26/09/01 05:01PM, Siddharth Chintamaneni wrote:
> > Add tests that place gotox at the end of the main program and a
> > subprogram, with each jump-table target preceding the gotox instruction.
> > This tests gotox as a valid non-fallthrough terminal instruction.
> >
> > Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
> > ---
> >  .../selftests/bpf/progs/verifier_gotox.c      | 42 +++++++++++++++++++
> >  1 file changed, 42 insertions(+)
> >
> > diff --git a/tools/testing/selftests/bpf/progs/verifier_gotox.c b/tools/testing/selftests/bpf/progs/verifier_gotox.c
> > index 5b18c9a27717..cfb5b648891f 100644
> > --- a/tools/testing/selftests/bpf/progs/verifier_gotox.c
> > +++ b/tools/testing/selftests/bpf/progs/verifier_gotox.c
> > @@ -47,6 +47,48 @@ DEFINE_SIMPLE_JUMP_TABLE_PROG(reserved_field_src_reg,      BPF_REG_1, 0, 0, __fa
> >  DEFINE_SIMPLE_JUMP_TABLE_PROG(reserved_field_non_zero_off, BPF_REG_0, 1, 0, __failure __msg("BPF_JA|BPF_X uses reserved fields"))
> >  DEFINE_SIMPLE_JUMP_TABLE_PROG(reserved_field_non_zero_imm, BPF_REG_0, 0, 1, __failure __msg("BPF_JA|BPF_X uses reserved fields"))
> >
> > +#define DEFINE_TERMINAL_GOTOX_PROG(NAME, BASE)                       \
> > +     __naked void NAME(void)                                 \
> > +     {                                                       \
> > +     asm volatile ("                                         \
> > +     .pushsection .jumptables,\"\",@progbits;                \
> > +jt0_%=:                                                      \
> > +     .quad ret0_%= - " BASE ";                               \
> > +     .size jt0_%=, 8;                                        \
> > +     .global jt0_%=;                                         \
> > +     .popsection;                                            \
> > +                                                             \
> > +     r0 = jt0_%= ll;                                         \
> > +     r0 = *(u64 *)(r0 + 0);                                  \
> > +     goto end_%=;                                            \
> > +ret0_%=:                                                     \
> > +     r0 = 0;                                                 \
> > +     exit;                                                   \
> > +end_%=:                                                      \
> > +     .8byte %[gotox_r0];                                     \
> > +"    :                                                       \
> > +     : __imm_insn(gotox_r0, BPF_RAW_INSN(BPF_JMP | BPF_JA | BPF_X,   \
> > +                                         BPF_REG_0, 0, 0, 0))        \
> > +     : __clobber_all);                                       \
> > +     }
> > +
> > +SEC("socket")
> > +__success __retval(0)
> > +DEFINE_TERMINAL_GOTOX_PROG(jump_table_terminal_gotox, "socket")
> > +
> > +static __noinline __used
> > +DEFINE_TERMINAL_GOTOX_PROG(terminal_gotox_subprog, ".text")
> > +
> > +SEC("socket")
> > +__success __retval(0)
> > +__naked void jump_table_terminal_gotox_subprog(void)
> > +{
> > +     asm volatile ("                                         \
> > +     call terminal_gotox_subprog;                            \
>
> I wonder if robot will reply the same as for v2.
>
> The suggestion was to do
>
>     call terminal_gotox_subprog1
>     call terminal_gotox_subprog2
>
> such that subprog1 is not the last piece of loaded prog...
>

I missed this part! Can I reply the diff to this thread? or does it
require a new revision?

> > +     exit;                                                   \
> > +"    ::: __clobber_all);
> > +}
> > +
> >  /*
> >   * Gotox is forbidden when there is no jump table loaded
> >   * which points to the sub-function where the gotox is used
> > --
> > 2.43.0
> >
