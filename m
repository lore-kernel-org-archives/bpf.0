Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BEE1FBCA7
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 01:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770254069; cv=none; b=MCx9lQE9IeELjHbTOFtUrIwchVJh1HRDZcLvF0S8zhqu0sH/TqSrBi1rMlCnzewAX9Kd4NF16Q6fP5y7dq3MFBHzEg5JLDtBpsAPQJNvzYDG7Co3vqvJKXUFAMFX+fUMnltotcRVkxfs+a9l+m6QJJya4kXSONea0ph3sdd9+r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770254069; c=relaxed/simple;
	bh=r9azueV7vYtm8fNolsKJwuao3OCta53IdBjShxmnVGE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TuW5pzN+HwH5Y3BJ/cbaVFG7Id3xODYhnpCOv3fqj8wyNilvuMsm7Ujgt9fEzoucZvUgBjJGsHRZwcNk8CfAPrUhvEKt7EudP1oGjuZrZzgdl1hKUUDRMKFuFjptjoWfWCv3LQrqJrbc+2ZfH2b9Jp5m2nuoYZShTrCdBsfFWHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OXEYSlWk; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXEYSlWk"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1248d27f293so1136758c88.0
        for <bpf@vger.kernel.org>; Wed, 04 Feb 2026 17:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770254069; x=1770858869; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Jegk1x0rhmEwBe8KICreye2t8/xrEK0hRK7vWpFxYvo=;
        b=OXEYSlWkJ/8rOBKKlJH2qMNaBTPP21l2YpHus52PacLMQfKPaJUsymEFdOhTgzcnAD
         mC2pIjbZwtIUCnGKsC0w425OTcsmsc82vt1KXDHY6ueWsG8LJ1z95o9HDNbJMmvXHH2L
         nQOOanKUL3eTXzqMbskDBn7XEd6Xi3iAPde3gMAimkYYGMmfMK3lEAaHqU5yETY5h4of
         ynuYJRJ9whZgjH1zlXLrBYXiN/3wbG3qKE2zB/EujXwXoT6aA13fcTLDBGZ4MiV/WEyU
         K0Z5+u9mbDePMrJFqq8o8CpwCrqWiO0Z5Nk313FfLcisy4SCd24b4Tr8LeLDxTC3akWU
         4WgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770254069; x=1770858869;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jegk1x0rhmEwBe8KICreye2t8/xrEK0hRK7vWpFxYvo=;
        b=QPurZY+9jrDzz8w37PA4sFeRqug/wG0AzBXvLvvnI4gNDiW487jN7wIEUYnS6Psjto
         ERJqq/Wh35ohBVPl5h7Gb7jM1ERP/Hh9lyKiFoUQLXdsSeBtF5CRye5krBPX7w1XtI4r
         GDDZyEA08788VxSHfLPdYJvzWZlWnPJDV6uffIjXqjDXCsLEiR5UXkSRixDI92jHyZ4M
         SDgsYqCTcgwGzQOYMYlFtADYc6DJN5ocrZEit/VLo+jscw/l+gjWCeMXS2MB6999bSDZ
         9uAW+yJ4Icjgf29b6sRXcF9odmaSnjLG+M022s66t5S+r00sHBe5JAWB9of6oFA/YNRE
         dszg==
X-Gm-Message-State: AOJu0YxeaU0+968cv/vSh1FrGqhfSbMSID36Bv8cEd3CEGcn8qQj3QzT
	qb1HhEuk0GUsG59LqOM36poAnQtXVR7Ic8ypy4VSHB4uuRVblnvmtCZyP8Daq0cJ
X-Gm-Gg: AZuq6aKz2sI4cAX7KA2xTPuJbHlVIYk8u6Wjk3EtinfGhxgAyXUzU9MqH+Oaom8/WUu
	MEGoyLGPmrdWdxnFKiQrsHAwFIxzUV2MJfeWY/0bgnHyTuN8D+AECBAm71IkapzbcdqdJKsXphZ
	FTZTgd3FbXrJSR1QEqGslDnj32sKLsQH/ezEY1LP2OSqlOiTo8Pn9fvDpyfBPs+47BHuBuv/Wim
	fTFnduI7rZvE/pP6yXcH4bX8Jgy6AbRbs/ZQXAI3F5CEXgQf3GXoBiZ6McDjRLIL6Ud6aur+QNr
	Vuqf0KMRHJ5bAEZRGTdAObBtR1KE7GtPXPAy9YlkrnPJZFgHTBVCGHZEruwV05fwyJp82jWB3rY
	7kbzq5RG4h6hT65MQdfgSEG+/5OYH3QYIT802Cbjr8DuCtwyAscxH86L3fJBf8p999NXp+Xb2hw
	0jd8wMJqz6lkGL46qpKlqbVvs4enHtlCnayS67ubfo+DFAi/gN+GM6r4ZP4BQVOQe+RQIc
X-Received: by 2002:a05:7022:41a7:b0:119:e56b:c74a with SMTP id a92af1059eb24-126f477c47fmr1914165c88.15.1770254068515;
        Wed, 04 Feb 2026 17:14:28 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:ac05:8e30:1e93:7ef5? ([2620:10d:c090:500::2:5ebc])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-126f503087esm3265771c88.12.2026.02.04.17.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 17:14:28 -0800 (PST)
Message-ID: <f1718e2e6e00785b1d654401a598641b3e9b890f.camel@gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Remove unnecessary volatile and
 barrier_var()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko	 <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau	 <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
 kernel-team@meta.com
Date: Wed, 04 Feb 2026 17:14:26 -0800
In-Reply-To: <CANk7y0hoCGExyyiAGCUfV-5L6Vo_bRV5aBWvUBZBsfj1qFU4qQ@mail.gmail.com>
References: <20260205002508.808963-1-puranjay@kernel.org>
	 <724c37abf5249d48701e337fca1571de1eee4b18.camel@gmail.com>
	 <CANk7y0hoCGExyyiAGCUfV-5L6Vo_bRV5aBWvUBZBsfj1qFU4qQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-02-05 at 01:04 +0000, Puranjay Mohan wrote:
> On Thu, Feb 5, 2026 at 12:33=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > On Wed, 2026-02-04 at 16:24 -0800, Puranjay Mohan wrote:
> >=20
> > [...]
> >=20
> > > diff --git a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf3.c b/=
tools/testing/selftests/bpf/progs/tailcall_bpf2bpf3.c
> > > index 99c8d1d8a187..b50dc92b2126 100644
> > > --- a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf3.c
> > > +++ b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf3.c
> > > @@ -14,7 +14,7 @@ struct {
> > >  __noinline
> > >  int subprog_tail2(struct __sk_buff *skb)
> > >  {
> > > -     volatile char arr[64] =3D {};
> > > +     char arr[64] =3D {};
> > >=20
> > >       if (load_word(skb, 0) || load_half(skb, 0))
> > >               bpf_tail_call_static(skb, &jmp_table, 10);
> >=20
> > I think 'volatile' is used here to force specific function stack size.
> > W/o 'volatile' compiler will throw the variable away.
> > With 'volatile' one should check what's happening.
> > Could you please double check?
> >=20
> > [...]
>=20
> without volatile:
>=20
> Disassembly of section .text:
>=20
> 0000000000000000 <subprog_tail2>:
> ; {
>        0:       bf 16 00 00 00 00 00 00 r6 =3D r1
>        1:       b7 01 00 00 00 00 00 00 r1 =3D 0x0
> ;       char arr[64] =3D {};
>        2:       7b 1a f8 ff 00 00 00 00 *(u64 *)(r10 - 0x8) =3D r1
>        3:       7b 1a f0 ff 00 00 00 00 *(u64 *)(r10 - 0x10) =3D r1
>        4:       7b 1a e8 ff 00 00 00 00 *(u64 *)(r10 - 0x18) =3D r1
>        5:       7b 1a e0 ff 00 00 00 00 *(u64 *)(r10 - 0x20) =3D r1
>        6:       7b 1a d8 ff 00 00 00 00 *(u64 *)(r10 - 0x28) =3D r1
>        7:       7b 1a d0 ff 00 00 00 00 *(u64 *)(r10 - 0x30) =3D r1
>        8:       7b 1a c8 ff 00 00 00 00 *(u64 *)(r10 - 0x38) =3D r1
>        9:       7b 1a c0 ff 00 00 00 00 *(u64 *)(r10 - 0x40) =3D r1
>=20
> with volatile (bpf-next/master)
>=20
> 0000000000000000 <subprog_tail2>:
> ; {
>        0:       bf 16 00 00 00 00 00 00 r6 =3D r1
>        1:       b7 01 00 00 00 00 00 00 r1 =3D 0x0
> ;       volatile char arr[64] =3D {};
>        2:       7b 1a f8 ff 00 00 00 00 *(u64 *)(r10 - 0x8) =3D r1
>        3:       7b 1a f0 ff 00 00 00 00 *(u64 *)(r10 - 0x10) =3D r1
>        4:       7b 1a e8 ff 00 00 00 00 *(u64 *)(r10 - 0x18) =3D r1
>        5:       7b 1a e0 ff 00 00 00 00 *(u64 *)(r10 - 0x20) =3D r1
>        6:       7b 1a d8 ff 00 00 00 00 *(u64 *)(r10 - 0x28) =3D r1
>        7:       7b 1a d0 ff 00 00 00 00 *(u64 *)(r10 - 0x30) =3D r1
>        8:       7b 1a c8 ff 00 00 00 00 *(u64 *)(r10 - 0x38) =3D r1
>        9:       7b 1a c0 ff 00 00 00 00 *(u64 *)(r10 - 0x40) =3D r1
>=20
>=20
> I see that the commit c8ed66859397 ("selftests/bpf: fix lots of silly
> mistakes pointed out by compiler")
> added the __sink(arr[sizeof(arr) - 1]);
>=20
> and after that even without volatile, compiler will not remove it.

Interesting. __sink is defined as follows:

    #define __sink(expr) asm volatile("" : "+g"(expr))

'g' constraint [1]:

  > Any register, memory or immediate integer operand is allowed,
  > except for registers that are not general registers.

'+' modifier [2]:

  > Means that this operand is both read and written by the instruction.

So, it is not obvious for me, why compiler can't replace 'arr' with a
single char variable. It appears that passing an address of the array
would be a safer strategy.

[1] https://gcc.gnu.org/onlinedocs/gcc/Simple-Constraints.html
[2] https://gcc.gnu.org/onlinedocs/gcc/Modifiers.html
