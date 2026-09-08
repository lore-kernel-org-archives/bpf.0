Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4543C1A
	for <bpf@vger.kernel.org>; Tue,  8 Sep 2026 00:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788826423; cv=pass; b=YvOFv2yX6TNL1syvyAl6gZxcI2A695HXXRdGK3G8yjnyTc7jUXm2nlXBo2Jt4aKcPdK0UbRO2WSyJsWueZ+yp9ReStivoLcWExIe2Y6DEUahqo6BAVaC+g1LzTu6lGBEprt4kVKlG102Z3oIU7bPU71tRZGE++C0XjDEwMgkwpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788826423; c=relaxed/simple;
	bh=6m3VZPDBkVQ6+/mM6PFFGJIJxnLmr5ec3XACDxovLWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jjgv6Lpc5+hWTDqPQodvoavwKpQbfdvc+B3TUdR3hUziZIt+r6+XKxDT8xcb28crLXcMs+S3WTxJumJvJB+RqUlgGp/Eqne4E5MknS7HBQL5GpiKd1Iw4+HeVaYbBhcmHVwtT4lsVvXz3iRyH3JyRToNcj93e5LXn4pDA3ehlqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SNq/NHlk; arc=pass smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SNq/NHlk"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cc1b838f9b6so4350172a12.3
        for <bpf@vger.kernel.org>; Mon, 07 Sep 2026 17:13:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788826421; cv=none;
        d=google.com; s=arc-20260327;
        b=IDe9qHYtxyXDKuklKbSfzb4xpelGb9aZTqYSfAQrQATkx92xkscW1gikwpoXqg/Dvg
         xyGVGqoTdF+A5fmPYWeP8z5iF4BZuoDlwYD0pkXQ0Nc88Dm5H2gF63bF0x/sw13c8LWt
         09Y9RphuCzzod+KRKXsoPthhfIPGLPPCUe7b3F0w2wXgzYYsaUGgJ4D3tONffn/NC4Rw
         S/XxgLvyylRdTRid0c4P1KEmy1ApIsscawopjnds8vRS9Hp2s8n1W0NdSP4u1of6xWUl
         VbRk5dN6nFLTcstMf5yOcUGI6pumthROuACr0lDrDJSwBUqWKgrm8BLnV+wujVuFlYMH
         +Dbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=enueFGnardzJb3tbskmtmDZ6fAqny4fFfaPoJB7LF7c=;
        fh=7zXHveqG8R6cbDf5/7BMjx8CU0OaZjz0i1lo04T3xGo=;
        b=PwTT6JnDGtDWaJr+K3sgycGKooOTiqR/uhc/keOZgHv7Wb7hzWjy99LCPu5R/7x/KV
         oAReRMespsStNsMH7/1nq7Wuukh/dXE/yFRGynw+q2dqoHTcNBCI+/FS8vi8Lp1IPcq7
         to0dbg1rx9xOWYlsxsdVN+ARCutbcSswuJUVFpzlZoN25vut8mOUTRYjWdDOiez+Q9vQ
         pzTwfYHeg5r/GjvDSm2HSpXn3tro1fHaUZx9OR4LFCe2tv+JUUV5KzEQP2zRM3Ab01S1
         O09QXxJ+bbIQI4cryhvEjBQ8WD3AHpAYB8rFW+IVaE8tixYepfoZp073lfWWQSdIwu18
         Ev6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788826421; x=1789431221; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=enueFGnardzJb3tbskmtmDZ6fAqny4fFfaPoJB7LF7c=;
        b=SNq/NHlkcQqF1RVNVMm5vRzbstpz41UUN52xW12tNLmGH53DPdK69XWcFl9PT8lBAd
         Dc7Z9R3p0w0JHap5lao/lvPa7uoJbfis/XsIPYneSFOnOeLlsYyumIDskr1fTotrtNMz
         WUilQaGxxBn1iDHHhXnjTDUDeYc0dLux1L+BJIdeyPqS6PIASCXPP9uGiTIPC+sV3ODZ
         K7I35vVzDZTu3CyQZJd75qmnZFBejGLZQG5ABLmic2s8wsJcA0N3irbCCN39Liuz0GyD
         JDCSqmlCkZcKAslSoBL4iCGr+RAkJo+TRteAO4mw5UnPKNDayaqS0hVR7RfzvqT0uPD/
         4Tjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788826421; x=1789431221;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=enueFGnardzJb3tbskmtmDZ6fAqny4fFfaPoJB7LF7c=;
        b=GE02O16InIBUieKGf+DyTgyjzm+AD0w1NWtDsKPA1eVmcpalRIrz2YjhzIdsaLzHJX
         fxfe0zBPznh68W+qTJH9q5DCY3rbtGG+sgiYRPoyhZfCZrJiAkDdbsw0aFHGwbwCKQ5e
         8PrCCSOzEvUgw+RIGgRCEtio5vjHp7B5ZIsbaD6KVzbzzQFFlXz5S13f1o7Aydt3gK4R
         CylvVRHi4xfrUFTass5GzSdPJmsUJjo2GqSiKa+mwnVZ51qhzbxbnhxC2MKIiHXoU9o5
         TUgiHpUEyw3OsoCI5QUUyfwR8dbp4eiUN5kEevgJZBlbJcVHaUILe5bk6FH7l2bkU2dZ
         A4Qg==
X-Forwarded-Encrypted: i=1; AKwUvBy2Uj7R/zqzsu844k1V4skcVGsGvpLNcdliNfBektreP+vL6ExuQ/mJr+DNkPXVqf56vyY=@vger.kernel.org
X-Gm-Message-State: AFuF++kIaxzJgvTIgoiEZZXFBwS/iZwANPj8wcpzV3r0eukw59O7Jj21
	Q1MFrwSvHUh/LpDEMzzjnGv5rcE0s6VQyZTbptic7QwVDZvkORj4nIRdmKxgk+tYW+WlZSaKqwl
	n5EkF3XAR1CoJ98n1qO/G3aLCozYxqgA=
X-Gm-Gg: AYBFou2jZJ1F/+tc2OBe6PTllM3hS5ps0BL7cyqOVwY9ZYW9T6ACthp5F1nf7CCWbKC
	lfPlkRdOCsM6Le6bsntS7v2qUs8dIhr1jbtk/n89IIsaB5HMkQ4qNsgXY5nXctZqZgniwZFfmuZ
	5VQ+TUGEm8K4bCdSKNT2aXAzELk6ZC5AFzIP0QBbhPAhRqyDs9vJCSZRSs/W5UURJ0+E6V605T5
	g+zjhftxHwNAqZaEWiIPgvKZkJuUDe58VPbvNjpbhuc3ixkvBtJWVAheEIVhAzLpc4+EF5yckB0
	rHSx4OJC3Ds7SCHg+ynrHfz4+dSLk/3k1M4Xvi88BcMdw2etqVoqGm3croX/nhUmHHzp1Fc53nI
	m8vIU63TsaqIIkwuI8RdTzu47eK2eMPBPs7sDTLI=
X-Received: by 2002:a05:6a21:6e88:b0:3bf:b182:94e with SMTP id
 adf61e73a8af0-3da39b5c379mr42313417637.5.1788826421141; Mon, 07 Sep 2026
 17:13:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907160538.922450-1-jolsa@kernel.org> <DL9CKPXX2OFG.2EK0RAZUT2PMV@gmail.com>
 <ap8d2AhD7Ax13rJ8@krava>
In-Reply-To: <ap8d2AhD7Ax13rJ8@krava>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 7 Sep 2026 17:13:29 -0700
X-Gm-Features: AcwNN1XZn2lwI3pCatYyIKcr8r8qDh4ad9HSJxdMKs3j4z12ZNPJjDLGV8mUnuE
Message-ID: <CAADnVQL-vs02PyTOQE9wYK+S988hG7cUMq+DAiD=X1K5+E=zmw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf, x86: Use global buffer for trampoline size generation
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Mike Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 7, 2026 at 1:26=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrote=
:
>
> On Mon, Sep 07, 2026 at 12:56:33PM -0700, Alexei Starovoitov wrote:
> > On Mon Sep 7, 2026 at 9:05 AM PDT, Jiri Olsa wrote:
> > > Currently arch_bpf_trampoline_size allocates and frees a temporary
> > > trampoline buffer on every invocation. The buffer is only used as a
> > > scratch space while __arch_prepare_bpf_trampoline() calculates the
> > > required size, and the generated trampoline is discarded.
> > >
> > > Allocating a writable scratch page during kernel initialization and
> > > reusing it for all size calculations. This improves tracing_multi
> > > attachment time.
> > >
> > > With current code:
> > >
> > >   # ./test_progs -t tracing_multi_bench_attach -v
> > >   ...
> > >   serial_test_tracing_multi_bench_attach: found 55227 functions
> > >   serial_test_tracing_multi_bench_attach: attached in   1.563s
> > >   serial_test_tracing_multi_bench_attach: detached in   0.256s
> > >
> > > With the fix:
> > >
> > >   # ./test_progs -t tracing_multi_bench_attach -v
> > >   ...
> > >   serial_test_tracing_multi_bench_attach: found 55235 functions
> > >   serial_test_tracing_multi_bench_attach: attached in   0.798s
> > >   serial_test_tracing_multi_bench_attach: detached in   0.258s
> > >
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > > was "bpf, x86: Add support for jit dry run",
> > > - doing this by having single scratch page instead as suggested by Al=
exei
> > >
> > >  arch/x86/net/bpf_jit_comp.c | 30 +++++++++++++++---------------
> > >  1 file changed, 15 insertions(+), 15 deletions(-)
> > >
> > > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.=
c
> > > index bba351944202..13ef0d53ca29 100644
> > > --- a/arch/x86/net/bpf_jit_comp.c
> > > +++ b/arch/x86/net/bpf_jit_comp.c
> > > @@ -9,6 +9,7 @@
> > >  #include <linux/filter.h>
> > >  #include <linux/if_vlan.h>
> > >  #include <linux/bitfield.h>
> > > +#include <linux/init.h>
> > >  #include <linux/bpf.h>
> > >  #include <linux/bpf_verifier.h>
> > >  #include <linux/memory.h>
> > > @@ -35,6 +36,15 @@ void __asan_store8(void *p);
> > >
> > >  static bool all_callee_regs_used[4] =3D {true, true, true, true};
> > >
> > > +static void *trampoline_size_image;
> > > +
> > > +static int __init init_trampoline_size_image(void)
> > > +{
> > > +   trampoline_size_image =3D execmem_alloc(EXECMEM_MODULE_DATA, PAGE=
_SIZE);
> >
> > I think I asked it earlier... why does it have to be execmem ?
> > Can it be normal page?
>
> ugh sorry I forgot.. the page/image needs to be in execmem range
> for emitting call/jmp otherwise the delta won't fit in 4 bytes
> and it fails on emit_patch is_simm32 check

ahh. I see. Please mention it in the comment and
also use bpf_jit_alloc_exec(PAGE_SIZE).

execmem_alloc(EXECMEM_MODULE_DATA...) was working by accident.
The VM ranges could have been different.

> >
> > If so then alloc it and free it every time. No need to keep one page in=
 reserve.
>
> hum, you mean drop the change then?

Since it needs to be execmem preallocating one page for this is fine.
