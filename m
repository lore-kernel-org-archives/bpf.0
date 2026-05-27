Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BE33A8741
	for <bpf@vger.kernel.org>; Wed, 27 May 2026 17:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779904116; cv=pass; b=D8HIlkZkk5fi9udiuyzk8rk0MtLrtmzF0pi1ar8tmNXcL1HnyB+tdho9svbvNvJAPBum+KgT4LrQRP3XkCCQBYHzEC7WXWF9ONoScnDNbZHzi3Vu8UpwZd49wR0GGTcIPNJSLzV/NWc0GKwKYAeNCGQTj8lV0XsRsTsFEK5pizQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779904116; c=relaxed/simple;
	bh=vgTQAqNrVRQiy0aSed4BsChDCuleMCYERltv8w6VIb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VlvnhNlGWzTZen5eGzo1jSvzfAbR7vUIuzeXUALtv+7a43ck2dDgQMP6+mEgm4utJTlHX0aieueANOnZ9HmgBJGyKa4e5Dx6/vim9AL4+3m0KbRN33pSUNTjhZ+L4KxS4ozpYkBtUzI1xDOIicH2iexHy66fdJzUn12ULo+jqYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oS6Pqp3D; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oS6Pqp3D"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-68acf0a15b3so252172a12.1
        for <bpf@vger.kernel.org>; Wed, 27 May 2026 10:48:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779904109; cv=none;
        d=google.com; s=arc-20240605;
        b=aOUIWYFlPABF9ZeWhvVY4C8zm8cgQCkn+vCHEfmth40CpIYSon1CPQiWr/EnWECLrJ
         zmDOSFgTNNCDv9ax0keDT6yR4mCMbmVtq3K9SvdTD48zEjPFCDW7drihVzuM7khZ+AAO
         /dEsdl2+lzMz5P0du+jSHx6/1TDYmOFzg60/RofwbfnorUoLSrTPg7svDgpxpZYA1vfc
         PXJ+yCdAMLUbc+BrW5kXO/MInjo/QG+DmRDMvxfAhkfxAxiO41yFYF7ehKOha7IvnyUe
         iSIrkLLm/OlwjnOX8cUFT645H4Gylg+ESD2R1Dl8lAsX4R+YWwCJAJlvH4aOfmpsyMV+
         PDhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZvOXKtF2m9A/Zl+GBH0zm9CcZRDut4ck7TbMTJmtXzI=;
        fh=cJmAg0g2auUwBh0ntmIY07jSLZiD71Fi9c/Zxp3nDzM=;
        b=hh51Sf5CAdc1nXGL7KHAcwhD1gw8WuKvK9jpOeR4GSD2qMjGwhmxhHCBQRgrhx2s4x
         KBpwMO4mRd7XLa5GRP5vO0pFMnK+peqfayIIf5fT66tKhnq4rnQ0N9itr9K5X92Rqtx5
         6BdDfp4OHycZ6/1C6k6KEkq7r/x6cAAgOOV4dGfPqmRPhd3LFRK6Z/tI9pUNidgvHSIw
         kehzcFXFRY9u01MTu05nDQQYzj6kk71aOf8G9VD/P3fsmk56j4qQAHmCIR/dpB64ailI
         YFBqkD0jORqrEu50lzTTas9phhjjVID0R920VlwluPI4qxZAD3V4xRNANDHif8uLPJLB
         WeSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779904109; x=1780508909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZvOXKtF2m9A/Zl+GBH0zm9CcZRDut4ck7TbMTJmtXzI=;
        b=oS6Pqp3DX6amLWR6yGwmRbb0vkVJKLtxcWHutzk5fKniPD5liXmcQ5QPhGNsiyyTiT
         IXXIZIDZjN/z7uZlT8JHF2PiRe/sq88m7THy16yx1C/LqMmkSV/I+If80pZuKh/1PcJt
         QBe+vroCHmnSE9tStzH4AmXXdLTM9u1UbWybYztQ8hDHiLjtFwYgXGnmFJPfPn54EXwM
         SKgjDb5TKalBf0zYejVRMn98rwNiBXm6ZCSFEERnEJtCa3oEjU54ONm4D2vRx8l5aNjl
         eqcLmsQz/Nk9uiOSqjp1cmctVW2zVq+V1UPCTebqany9u/2QMxMdAfhrR1kKcjZJGi44
         Pk4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779904109; x=1780508909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZvOXKtF2m9A/Zl+GBH0zm9CcZRDut4ck7TbMTJmtXzI=;
        b=q7ewNqgkhm87Y0LYggUccW1qh/yjDkQj/ONVRSer44VxZQVuWMsf8B+/iERGsUgMdp
         yYueWxgQ4U7knf0Panc7lksE0wJ5KylJMwgO1ZDWJwkOw6KQjzolXDo/eJxSbNVikVF3
         eniUd5AEbRjwLMmlOtTvsgwaog4B6EPFFC7S0FQC3xDS5RRxcFjGCo8ghUWiH7ifPvEq
         Da8arYOQ+wiqO867I3aI5V6ShchPVKUYIyHuMdtl11ICRYOJia2ACZ1nh7V3Igyvwiri
         F4r9AaVXBlGj6eT8Mx0oFiaWvMUtSDtCIuWM3poExqDfflB9KeqIo9tUPpjDge7RgrdZ
         34xg==
X-Forwarded-Encrypted: i=1; AFNElJ8RPRw/i9xpxbAkC63O+/dssVdBeDkmihVnaRFNB303SbatW5qdoJKvMF776EtdrhrfD1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhUgFrX6T8bzgju1dAf/5v4VRicwf4An8z628BeHftLOqp+RZ3
	/O/Hewkmh0Xvm2saMPQAJdWbHkmwvqgRtI3CCPscauMQBRShee/9iTbg+SZjQOuQPP3j7jVNlXQ
	yF7oGBYLEjkce5B3kZcbc6w7s5QzH9tU=
X-Gm-Gg: Acq92OF3xaCbw3zAxS8luVHroaufIgZD7woB/bRDASvHmiUkzhDhKGIHkRRyesfAlIP
	+MfnThuvvVQsyIrkqYVZZu6BUK+DlTJ0yuTcCJJO/HwKp1dMWqMXWVs01uOTF/UkHGmvYm2ZI8P
	Iqq9jbrt+POc7q8OWTCRTIzBh8fpVCTMxAthAAoOrUfgx339IYyL3U79BCfUt674P9UL73e/AvI
	XO9ccRgLdeiLGL/1gEz8gq1siiwy0BwY+H00H1ksRGqUi4neMl2EhVf8QxRvkrYPYipzm6wZzzr
	i0L0a2VLrg==
X-Received: by 2002:a17:907:267b:b0:bdc:6e26:a94 with SMTP id
 a640c23a62f3a-bdd1fe94160mr1052672666b.0.1779904108999; Wed, 27 May 2026
 10:48:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527052539.3388700-1-hataegu0826@gmail.com>
 <20260527052539.3388700-2-hataegu0826@gmail.com> <549d58c6-05f0-4176-98ec-c88e96ee4375@linux.dev>
In-Reply-To: <549d58c6-05f0-4176-98ec-c88e96ee4375@linux.dev>
From: =?UTF-8?B?7ZWY7YOc6rWs?= <hataegu0826@gmail.com>
Date: Thu, 28 May 2026 02:48:16 +0900
X-Gm-Features: AVHnY4JX-aWTG8lf4QZmtCODkRVj2i7bEVZFrhzUULrl0iHcu9dZPOjB6z_FK9k
Message-ID: <CAPa51znR2bY8mojn07L4QLWrZP6yNVunMQHdvqGN1U_N0vPm7Q@mail.gmail.com>
Subject: Re: [PATCH bpf 1/1] bpf: reject overlarge global subprog argument sizes
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yonghong, Thanks for checking. Yes, the generated instruction is
only a 4-byte load at r1 + 4. The large array bound is not expected to
appear in the instruction stream. It matters through the BTF-derived
argument size used by the verifier. For the global subprog argument:
int (*p)[0x3fffffff] btf_resolve_size() resolves the pointee size to
0xfffffffc. At the call site, R1 is PTR_TO_STACK pointing to the
4-byte local variable at fp-4. The current stack path in
check_mem_reg() computes: size =3D -(int)mem_size so 0xfffffffc becomes
-4 as a signed int, and the negation validates only 4 bytes. This lets
the caller pass the 4-byte stack slot. The callee is then verified
independently with R1 as PTR_TO_MEM and mem_size 0xfffffffc, so the
4-byte access at r1 + 4 is accepted as being inside the BTF-described
memory region. At runtime, however, the actual argument value is still
fp-4, so r1 + 4 addresses fp+0, outside the 4-byte object that the
caller provided. I rechecked this on current origin/master
eb3f4b7426cf with the raw-BTF reproducer. The verifier accepts the
program and logs: 4: (85) call pc+2 // r1=3Dfp0-4 ... 7:
R1=3Dmem_or_null(id=3D1,sz=3D0xfffffffc) R10=3Dfp0 9: (61) r0 =3D *(u32 *)(=
r1
+4) Func#1 ('subprog') is safe for any args that match its prototype
So I agree that the objdump only shows a small load. The issue is that
the oversized BTF pointee size wraps the caller-side stack argument
check and lets that small load be accepted past the caller object. I
can send a v2 with the commit message and selftest comments clarified
to make this distinction explicit. Thanks, Taegu

2026=EB=85=84 5=EC=9B=94 28=EC=9D=BC (=EB=AA=A9) =EC=98=A4=EC=A0=84 1:59, Y=
onghong Song <yonghong.song@linux.dev>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1=
:
>
>
>
> On 5/26/26 10:25 PM, Taegu Ha wrote:
> > Global subprogram argument checking derives generic pointer sizes from =
BTF
> > and passes the resolved size to check_mem_reg() as a u32. The access-si=
ze
> > validation path then uses a signed int, and stack pointers negate the v=
alue
> > before calling check_helper_mem_access().
> >
> > A BTF type such as int[0x3fffffff] resolves to 0xfffffffc bytes. On a s=
tack
> > pointer, (int)mem_size becomes -4 and the negation validates only four
> > bytes. A caller can therefore pass a four-byte stack slot while the cal=
lee
> > is verified with a nearly 4GiB memory argument, allowing accesses outsi=
de
> > the caller object.
> >
> > This was confirmed with a non-executing raw-BTF reproducer. On a
> > vulnerable kernel, the verifier accepted a program where the caller pas=
sed
> > a four-byte stack slot, while the callee argument was described by BTF =
as
> > int[0x3fffffff]. The verifier log showed:
> >
> >    R1=3Dmem_or_null(id=3D1,sz=3D0xfffffffc)
> >    r0 =3D *(u32 *)(r1 +4)
> >
> > The program was only loaded to prove verifier acceptance and was not
> > attached or executed.
> >
> > Reject sizes that cannot be represented by the signed verifier access-s=
ize
> > API before any conversion. Cast the non-stack case after the bound chec=
k to
> > make the conversion explicit, and add a verifier regression test for th=
e
> > oversized BTF argument.
> >
> > Fixes: 2cb27158adb3 ("bpf: poison dead stack slots")
> > Signed-off-by: Taegu Ha <hataegu0826@gmail.com>
> > ---
> >   kernel/bpf/verifier.c                           |  7 ++++++-
> >   .../bpf/progs/verifier_global_subprogs.c        | 17 ++++++++++++++++=
+
> >   2 files changed, 23 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 7fb88e1cd7c4..1007f204a1f5 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -7107,6 +7107,11 @@ static int check_mem_reg(struct bpf_verifier_env=
 *env, struct bpf_reg_state *reg
> >       struct bpf_reg_state saved_reg;
> >       int err;
> >
> > +     if (mem_size > S32_MAX) {
> > +             verbose(env, "R%d memory size %u is too large\n", regno, =
mem_size);
> > +             return -EACCES;
> > +     }
> > +
> >       if (bpf_register_is_null(reg))
> >               return 0;
> >
> > @@ -7119,7 +7124,7 @@ static int check_mem_reg(struct bpf_verifier_env =
*env, struct bpf_reg_state *reg
> >               mark_ptr_not_null_reg(reg);
> >       }
> >
> > -     int size =3D base_type(reg->type) =3D=3D PTR_TO_STACK ? -(int)mem=
_size : mem_size;
> > +     int size =3D base_type(reg->type) =3D=3D PTR_TO_STACK ? -(int)mem=
_size : (int)mem_size;
> >
> >       err =3D check_helper_mem_access(env, regno, size, BPF_READ, true,=
 NULL);
> >       err =3D err ?: check_helper_mem_access(env, regno, size, BPF_WRIT=
E, true, NULL);
> > diff --git a/tools/testing/selftests/bpf/progs/verifier_global_subprogs=
.c b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
> > index 1e08aff7532e..0ff8f85b4d46 100644
> > --- a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
> > +++ b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
> > @@ -151,6 +151,23 @@ int anon_user_mem_valid(void *ctx)
> >       return subprog_user_anon_mem(&t);
> >   }
> >
> > +__noinline __weak int subprog_user_anon_mem_huge(int (*p)[0x3fffffff])
> > +{
> > +     return p ? (*p)[1] : 0;
> > +}
> > +
> > +SEC("?tracepoint")
> > +__failure __log_level(2)
> > +__msg("R1 memory size 4294967292 is too large")
> > +int anon_user_mem_huge_size_invalid(void *ctx)
> > +{
> > +     int (*p)[0x3fffffff];
> > +     int tiny =3D 42;
> > +
> > +     p =3D (void *)&tiny;
> > +     return subprog_user_anon_mem_huge(p) + tiny;
> > +}
>
> Without verifier.c change, verification is successful.
>
> The objdump:
>
> 0000000000000160 <subprog_user_anon_mem_huge>:
> ; {
>        44:       b4 00 00 00 00 00 00 00 w0 =3D 0x0
> ;       return p ? (*p)[1] : 0;
>        45:       15 01 01 00 00 00 00 00 if r1 =3D=3D 0x0 goto +0x1 <L0>
>        46:       61 10 04 00 00 00 00 00 w0 =3D *(u32 *)(r1 + 0x4)
> <L0>:
>        47:       95 00 00 00 00 00 00 00 exit
>
> 0000000000000040 <anon_user_mem_huge_size_invalid>:
> ;       int tiny =3D 42;
>         8:       b4 01 00 00 2a 00 00 00 w1 =3D 0x2a
>         9:       63 1a fc ff 00 00 00 00 *(u32 *)(r10 - 0x4) =3D w1
>        10:       bf a1 00 00 00 00 00 00 r1 =3D r10
>        11:       07 01 00 00 fc ff ff ff r1 +=3D -0x4
> ;       return subprog_user_anon_mem_huge(p) + tiny;
>        12:       85 10 00 00 ff ff ff ff call -0x1
>                  0000000000000060:  R_BPF_64_32  subprog_user_anon_mem_hu=
ge
>        13:       61 a1 fc ff 00 00 00 00 w1 =3D *(u32 *)(r10 - 0x4)
>        14:       0c 01 00 00 00 00 00 00 w1 +=3D w0
>        15:       bc 10 00 00 00 00 00 00 w0 =3D w1
>        16:       95 00 00 00 00 00 00 00 exit
>
> The big 0x3fffffff does not really matter.
>
> > +
> >   __noinline __weak int subprog_nonnull_ptr_good(int *p1 __arg_nonnull,=
 int *p2 __arg_nonnull)
> >   {
> >       return (*p1) * (*p2); /* good, no need for NULL checks */
>
