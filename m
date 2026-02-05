Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5096F3EBF11
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 02:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770260251; cv=pass; b=tg/qFFsBWmH3TsLgPER226fw5Y22KwFDjVnpsv9CFP2UN5x1jRFr83svxRaSjh4SeOT1C7YjGOCCoZ4W6DHdyV2lfmld6lBwspdJOq1sUW272qd9pYdTudifAKL3bhQwKkWXuBMJ6414lRp+GkkhQ+tkr3eW8WF08ap+cTqGce4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770260251; c=relaxed/simple;
	bh=zReCzhoD7uhQak6MKiJdHU0d8mwNSsWi+X8HrUDLmS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=An5QtMBPmKa47rHB9oK6Yk2TlEtTve/nh4AvawrGaRGHj+bwxnWFR/EdakNIa1A/e+Ry9kmjngQWwn6eBky+hrqpT1JKyPb2ArmePy+5gmjZkD6RkomgzeeHknaxUAtJjdFllDryFL/X1UY7mZe1SAkIYRme1ZTDGbH2XSBCMEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LAFWAgM5; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LAFWAgM5"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b8710c9cddbso47589766b.2
        for <bpf@vger.kernel.org>; Wed, 04 Feb 2026 18:57:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770260249; cv=none;
        d=google.com; s=arc-20240605;
        b=bt0hWg4akipXvhyeBehhc/v2LtMAYXZq78U+PlI+hzJARMCWYUv6psiL5bhvhhEGHf
         qAhd4p2UsYU28wTFJYhVL/N67npGO8dnOoPgcmY9DSd4G4vF8mqfu7t3JmEmQ+epV4yE
         H+WiqNXq1w5iLzv2eXhCQ2hoauyjFmv5KpfzmAQHsl7W3SBzW7XyAdSjaFKpMVjeuD+W
         uIJhLK4j1tUOKVqYnNR43abK06UhjaoVoF5DLVIC0OhS9UpONvPrZh1izrDevtil4XAB
         ZCvEgPj5dETMMD81JLK8i13tZdJRW9UGGFXnTZF++bWaiz2fUdvt7QEoNSNx6pj/Dqtg
         UrLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NcUOQslXoqjpGowED28xCL+IJ+l2ktcHAgIek0ZG9RU=;
        fh=cKMUHX+7uaxJJpnCJTUj05r6u3b5LIa8H8LPnjF8mDI=;
        b=CyAinxKEMnJBsIiENH42IOVu7nwvsfwzJpBPUMYNIQOYZTf3Cb5a8lu6bpDpZe8N8B
         axapize/z8VKYpPtyOGKuA0FRNMIDR4ZbU9HXJ0s1IANtFN+ATn5VtBVZcRrgQxW42WA
         okqNX6Jl1quB/ODMSM2PVkEwp668GKtvS4qqwcXUF972Upka24TOQTbmr5xNC2neRAFK
         IZfIb/y/lIqSGYWpg8xkLXLT0rdp9/XCjr5beOlQpMIRBnUfb+UDIMBnZKb8pXNn3SqO
         xyp80Q4pzQNS4Pd7Evwx/D+r6fHMZMJfm8dr22b+l0W8UPP3UgmpMVA8GtYsTakaSwZy
         rDCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770260249; x=1770865049; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NcUOQslXoqjpGowED28xCL+IJ+l2ktcHAgIek0ZG9RU=;
        b=LAFWAgM5MjBTCmYPTXhShNuHzZqznbgG86N0TP9xlm4WK2DukOuYJG/PiTQRiO68jM
         0pUAHvB99yBld3wssSMWGSBVKBzHw2dHQ5TzODZDLAWdI3S5abVOz8vq6T9BwzkGgBni
         AdNDO780EWi1mosWLAWhA+OJmuYRNkyuZiPePu2F8wfzP/nVlJAR16hh7CYwWtTlRMbT
         pqQVHVqVrIVh4IQTIIlWj6mXUKfys0WecTzfU5B9Cc0NMHuMqAQ40aeyc5uGpsdOWLmo
         FgovXzvvJ2tUuaaJ0BE5gXQ15g8L5tOhX4hb1t0SdVa5KaxUmZaG3vY2+es/0wNegSiT
         ukkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770260249; x=1770865049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NcUOQslXoqjpGowED28xCL+IJ+l2ktcHAgIek0ZG9RU=;
        b=xAI4vhToocredEPPmnjqptMz89VzXhpj5NDWMBJO0FQrekNEMUdVWmSADRlf1kf2OZ
         gnKtrxlxoH6g8FWAmdlC9wrCVWoXNKNR8PPqeNuUUXr7HA4XuZqHt1hU53MD+FdLgXou
         cLUZndFsu72ZM9udOTgrJMYnIoc1crvBfCYB4nX/ntJ/Jl0FYi+mJ7T73ZWPHltB6WUv
         PSK8xqDFv0JY3j0aMoYdQjCkgBi2G+kvlzUxM2fiBJ4In1rZn0GADxZdkXaNm1bOjW8x
         ehsN0a7NyeyjvgvEGII8srdXldHRdirzuC106PyyGntdxYgJr+xSAHs/WAz555WkpJga
         1d5A==
X-Gm-Message-State: AOJu0YwBkC/SRhow3b+JkqKCJVOGYftxhBYP7eS/+PcAxEyjKWQKshZE
	bmj4IlzPRrU1g/jhS0F59uCIUG5S7bowyqWwU+Y+V3QoKB2/Oj9aWwneeROqDBI5uQuxX7+0jE+
	+v03zRX3JnEjcBNioGmw8If/5sEkQFJU=
X-Gm-Gg: AZuq6aLEwNW8O6Bh1/ymjuZK05L98a6d7hdToY2k9PhJJFtuuVbAj2AZ0k2WMMO1gCW
	+GcKgCEnA0OVdzez+RISRSIlaEqTeIwr+iG8xtoVdWkTCeuVXc99T14PoHsGCdP+QtB2TUZa20C
	9O1Tx6HP2XJ0BYsRiKPYLn3mgAgHsrlfHj4h+Hww/Hu7quTByiqOUSgEnz+TDFnmNLAYpktCoRH
	iafWeL7KMeUZFyuCtQDZSsBWe4zPhCYMx71lgE0z/WbHDOCWAmysSbdzHUz7vmG4ztsmqMP7vT1
	nzU2UKs=
X-Received: by 2002:a17:907:7b83:b0:b86:f495:5e4c with SMTP id
 a640c23a62f3a-b8e9f3781d8mr338561166b.55.1770260249352; Wed, 04 Feb 2026
 18:57:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205002508.808963-1-puranjay@kernel.org> <724c37abf5249d48701e337fca1571de1eee4b18.camel@gmail.com>
 <CANk7y0hoCGExyyiAGCUfV-5L6Vo_bRV5aBWvUBZBsfj1qFU4qQ@mail.gmail.com> <f1718e2e6e00785b1d654401a598641b3e9b890f.camel@gmail.com>
In-Reply-To: <f1718e2e6e00785b1d654401a598641b3e9b890f.camel@gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Thu, 5 Feb 2026 02:57:16 +0000
X-Gm-Features: AZwV_QgdBMRF4AWv_r-ktn00_x0pjLcVI1WUSXy-R4kqxbIqUrwyuiGAqdVEjds
Message-ID: <CANk7y0h0WqRQOM7L=s0ndfa45dy3hqA2LqDWeORm50XS3spviQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Remove unnecessary volatile and barrier_var()
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 5, 2026 at 1:14=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Thu, 2026-02-05 at 01:04 +0000, Puranjay Mohan wrote:
> > On Thu, Feb 5, 2026 at 12:33=E2=80=AFAM Eduard Zingerman <eddyz87@gmail=
.com> wrote:
> > >
> > > On Wed, 2026-02-04 at 16:24 -0800, Puranjay Mohan wrote:
> > >
> > > [...]
> > >
> > > > diff --git a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf3.c =
b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf3.c
> > > > index 99c8d1d8a187..b50dc92b2126 100644
> > > > --- a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf3.c
> > > > +++ b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf3.c
> > > > @@ -14,7 +14,7 @@ struct {
> > > >  __noinline
> > > >  int subprog_tail2(struct __sk_buff *skb)
> > > >  {
> > > > -     volatile char arr[64] =3D {};
> > > > +     char arr[64] =3D {};
> > > >
> > > >       if (load_word(skb, 0) || load_half(skb, 0))
> > > >               bpf_tail_call_static(skb, &jmp_table, 10);
> > >
> > > I think 'volatile' is used here to force specific function stack size=
.
> > > W/o 'volatile' compiler will throw the variable away.
> > > With 'volatile' one should check what's happening.
> > > Could you please double check?
> > >
> > > [...]
> >
> > without volatile:
> >
> > Disassembly of section .text:
> >
> > 0000000000000000 <subprog_tail2>:
> > ; {
> >        0:       bf 16 00 00 00 00 00 00 r6 =3D r1
> >        1:       b7 01 00 00 00 00 00 00 r1 =3D 0x0
> > ;       char arr[64] =3D {};
> >        2:       7b 1a f8 ff 00 00 00 00 *(u64 *)(r10 - 0x8) =3D r1
> >        3:       7b 1a f0 ff 00 00 00 00 *(u64 *)(r10 - 0x10) =3D r1
> >        4:       7b 1a e8 ff 00 00 00 00 *(u64 *)(r10 - 0x18) =3D r1
> >        5:       7b 1a e0 ff 00 00 00 00 *(u64 *)(r10 - 0x20) =3D r1
> >        6:       7b 1a d8 ff 00 00 00 00 *(u64 *)(r10 - 0x28) =3D r1
> >        7:       7b 1a d0 ff 00 00 00 00 *(u64 *)(r10 - 0x30) =3D r1
> >        8:       7b 1a c8 ff 00 00 00 00 *(u64 *)(r10 - 0x38) =3D r1
> >        9:       7b 1a c0 ff 00 00 00 00 *(u64 *)(r10 - 0x40) =3D r1
> >
> > with volatile (bpf-next/master)
> >
> > 0000000000000000 <subprog_tail2>:
> > ; {
> >        0:       bf 16 00 00 00 00 00 00 r6 =3D r1
> >        1:       b7 01 00 00 00 00 00 00 r1 =3D 0x0
> > ;       volatile char arr[64] =3D {};
> >        2:       7b 1a f8 ff 00 00 00 00 *(u64 *)(r10 - 0x8) =3D r1
> >        3:       7b 1a f0 ff 00 00 00 00 *(u64 *)(r10 - 0x10) =3D r1
> >        4:       7b 1a e8 ff 00 00 00 00 *(u64 *)(r10 - 0x18) =3D r1
> >        5:       7b 1a e0 ff 00 00 00 00 *(u64 *)(r10 - 0x20) =3D r1
> >        6:       7b 1a d8 ff 00 00 00 00 *(u64 *)(r10 - 0x28) =3D r1
> >        7:       7b 1a d0 ff 00 00 00 00 *(u64 *)(r10 - 0x30) =3D r1
> >        8:       7b 1a c8 ff 00 00 00 00 *(u64 *)(r10 - 0x38) =3D r1
> >        9:       7b 1a c0 ff 00 00 00 00 *(u64 *)(r10 - 0x40) =3D r1
> >
> >
> > I see that the commit c8ed66859397 ("selftests/bpf: fix lots of silly
> > mistakes pointed out by compiler")
> > added the __sink(arr[sizeof(arr) - 1]);
> >
> > and after that even without volatile, compiler will not remove it.
>
> Interesting. __sink is defined as follows:
>
>     #define __sink(expr) asm volatile("" : "+g"(expr))
>
> 'g' constraint [1]:
>
>   > Any register, memory or immediate integer operand is allowed,
>   > except for registers that are not general registers.
>
> '+' modifier [2]:
>
>   > Means that this operand is both read and written by the instruction.
>
> So, it is not obvious for me, why compiler can't replace 'arr' with a
> single char variable. It appears that passing an address of the array
> would be a safer strategy.

Yeah you are right, I feel the best way is to keep the volatile. or do
something like:

#define __sink_ptr(p)  asm volatile("" : : "g"(p) : "memory")

__sink_ptr(&arr);

tested it on arm64 gcc with -O3 and it works.



> [1] https://gcc.gnu.org/onlinedocs/gcc/Simple-Constraints.html
> [2] https://gcc.gnu.org/onlinedocs/gcc/Modifiers.html
