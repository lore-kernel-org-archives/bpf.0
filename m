Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07270285C80
	for <bpf@vger.kernel.org>; Sun,  8 Mar 2026 16:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772986124; cv=pass; b=mcGyUIH8yLylkl+aOcIdUAQuHP6xvg0SqFWYCLhz4VKenON8QPuvkxl81YJEDjgZJQLO0zyUH08Mhg1M0E6GeqGtk5+ifc6fIaENSNucXlYfHDOo2cyaETG/qFY9t3f15RDQVKgaYziOqZZiI4aqgU3I3o0XJpOtGH2quHojZCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772986124; c=relaxed/simple;
	bh=B7TMnDq4T146kgiM9Jgq77zoPwPCnu0No9sjdgOMIUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oYAngTxLZlMdeBnhm0pptEtArS6bsSiQA+xc1/iYQOfGows2VQOiGKaPOgThvRfFIK3iaH/4vlHJcqZAx5tfGBADFrPjrwHVnheXYsnt7T5sL9jLU1fxlYvraidgkZ/Ot59TP2UnMe5UYzkzOietMipkWYqs6593dL6kLoGNew0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VU6gZ6hO; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VU6gZ6hO"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-439cd6b09f8so2900424f8f.3
        for <bpf@vger.kernel.org>; Sun, 08 Mar 2026 09:08:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1772986120; cv=none;
        d=google.com; s=arc-20240605;
        b=F9tkVhP/Q+SKHEgYeu4IVT+BTRccR3CFlStIWD4IrOt6JuxzImx6ieYkwVnWntZVez
         c/aXnqCoFGc35gf7SNUIOftXTprUZdf/H0mwMjPgib2JM3oDFveE3XPlwWAQvzraIAcQ
         /kSGjRqxcdMNg3OhaOcnpP48ZQVshOdgtFgNUWS+SIerOwIxHVk1gHHxC0ZXC2EXQn8q
         tuxanqf7MgzBjVKAB38Pv4E5vHNwU1QssdHUjCHAZkps+xTCsd8k/MuICE8xvy5e5ibz
         yBKnbE5anXDjcfRwInI3ilGUYvshK5kVbihysHIRHzMFxkBDpX9FEsInCCoVIB6IkAAQ
         cmcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lnyn0D7v3NtpCCFN+OaTBBhd5BPF9RP5TzZudislDW8=;
        fh=HfW3JP7tsQcN9lIU+/FcrwiPL2GxFsUX39Zss0K3Z9Y=;
        b=TuaGsJTqU6OV+xiB8t+239kjty7o/5PUgppXZ4a13L3SyKtbez42ComgqUEWj0v2xQ
         Y3JKLvXQRRvdJgYiBFOEoaP1EcN0vwSe4St+Y25le0IW0FPP2IrjxHHZZATIMMDdylux
         LnlNRe09fEXQcgRaBA8k4i2nNAxDg8BeeEau1M+RBwkHiepYTr980Witg2eg8OZIYoZd
         9ft93NTAiAlon+CIlVb5FQL7sLPErFLFoTGhCITILDUYT4Qn2j+WWEzUIIKmGqQTVK0+
         ijH8U0Ottw+DxmL5j+gunb9JCZoWNEBtyUk/Ger+MCdtHDCsS36KdoFasee2C4JIMB1+
         OCOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772986120; x=1773590920; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lnyn0D7v3NtpCCFN+OaTBBhd5BPF9RP5TzZudislDW8=;
        b=VU6gZ6hO0+Vnj2nTL1Kj/fV5OOUWOqmUmPvtJ373MO+0fYxWk7q3cqtZP2e1cX4JMA
         cGM8axYLQXtQ3sgDjtyoIL8zajH/wuF2uc0NzZa8rztVZPBt110zClDbEXIGbZ2f3FOe
         JCJow0Wmp5peqyUF09pmPdyMqozDxjVcO2p9xJWnezUAKWEX+vzF24Y8H9CNy5+lrmZz
         QhckG6B7mf3mDohxPCY2WMI0IagDs4+Bgfd1JubdQEpLOv2R03FQoVmwdc5m5FCtX0x2
         evjdMqdWI/WuQspKuMD6TIc5IeFUn9ShLsWhQ/eepQsRg7fW90yzkL1fg37LYbnIGWFE
         VU2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772986120; x=1773590920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lnyn0D7v3NtpCCFN+OaTBBhd5BPF9RP5TzZudislDW8=;
        b=dNeoJlNkq6MSQz2ahichplUifz/7TyAtqiGkBPFAaWxZ/JKZrqMCCCxUOD3XIa9dVk
         xSE2DsyeuhfDNMTAqMVfIjZKFYUeI2zhI9CAJyu2HbX65zdC1/6MqrSBWqyrPkIHfpGo
         1uivO7VG/SZZ0F0Fb+vVWyCvEUz/QOhypYiobjP7sSSJGwJ5z8YEHPDatz1wk+ttBI6c
         VwdU+JURk9lMZCmwadzTavCz96/7iVpRwB4mpzL5Ayg3eeXgfWrRM10pMsnGttDXxzHA
         9yOBvs+2ypvkiE0LJa5WjNdhg0cmdPTbiWr1+NigaZ7qK9pfjzVK4/OzMj4kSDeDFJHo
         UDgw==
X-Forwarded-Encrypted: i=1; AJvYcCVu7lUQtfe7L/BdgPMqoK4bM8spTgxfV+quxstLC07QCvp5SUkHCpd9Hj2UaG+FNz1I0po=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyP3tjDC6EWJ9kmpIyfsKAyufoncz+t0XDqDWj4arlGv7f295J
	Natcp1SNOSpVD391Gxhk6655Z7VwvosYtoFvADxJXG13cyGYCWkNgZDt6shbCNs9oBGFXOYYL5P
	IQsMKscBvN3vfGjbPwN18LRK5erbLOhc=
X-Gm-Gg: ATEYQzwqljcpTYcXHzzIKh89yiPS4lWm2+M7zFWXYzdK3sKdKlbum6HTOgGq+GajF99
	T3R7StQpGjBqyndhOc1uJ3m0D/HEBa7XAYmRJnOTnxBBkyGPAZpdAbF3xZq7Ui44EKdMRihabPU
	qWQBHp1ymIhy/kwsFe6b5HPTmMGBndTIuPscCKaPk/TTc7W0O9Atw3tTHTOYqG1INVDKrVYIBZN
	zxfMJpqKdtuQHvcWWy1I0WVtq5e4Pmk7qbSCU6S5FeI02ZXi4YkrH3d2trajD0D7XWaSRPhZ/yA
	hiS127w/P9Fh934IBRLl4PZd5yMY55tc911RwBRI1/xVw3wz6gNeSzNhxO8HL7/mbdGZYyoOHhd
	zQU4u1YUEMlvH3qLGhkG9LmUSVw==
X-Received: by 2002:a05:6000:18a7:b0:435:e3bd:5838 with SMTP id
 ffacd0b85a97d-439da33af85mr14879681f8f.25.1772986120221; Sun, 08 Mar 2026
 09:08:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306120024.1032301-1-sun.jian.kdev@gmail.com>
 <aar9gzh7QVhezeII@Tunnel> <CAADnVQJtG9s1CV-qeF8NSgi_UFPgahOXtB3PWiivBooAYC69GA@mail.gmail.com>
 <CABFUUZGV7ZAVY=Y6Py3ytZUzZV0i9otPWADgP9HtVrDzf612ew@mail.gmail.com> <b45c98d4e59bb31c3101d6ae2ef5d7cee8b4f6c8.camel@gmail.com>
In-Reply-To: <b45c98d4e59bb31c3101d6ae2ef5d7cee8b4f6c8.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 8 Mar 2026 09:08:29 -0700
X-Gm-Features: AaiRm52oEOAJUIVk2zitK0o1MXIMBduWUQNq5yKL-R8bfBi2FoMfslNHbKeD1Mk
Message-ID: <CAADnVQKnBPkybFMOM89OQ+dvPZhpzTYaZa05gDTT-zG9gu8EKg@mail.gmail.com>
Subject: Re: [PATCH v2] selftests/bpf: avoid jump seq limit in verif_scale_pyperf600
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: sun jian <sun.jian.kdev@gmail.com>, Paul Chaignon <paul.chaignon@gmail.com>, 
	bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 8, 2026 at 12:12=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Sun, 2026-03-08 at 13:55 +0800, sun jian wrote:
> > On Sat, Mar 7, 2026 at 12:23=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Fri, Mar 6, 2026 at 8:15=E2=80=AFAM Paul Chaignon <paul.chaignon@g=
mail.com> wrote:
> > > Sun Jian,
> > > I asked to do a _minimal_ tweak to pyperf600.
> > > What you did is a drastic change. Pls don't hack tests
> > > just to make them pass. The tests have to be meaningful
> > > and test coverage shouldn't degrade.
> > >
> >
> > Hi Alexei, Paul,
> >
> > I spent some more time looking into this.
> >
> > Comparing unmodified pyperf600 bytecode between clang-18 and clang-20, =
I
> > see fewer instructions with clang-20 and nearly the same number of
> > branches:
> >
> > clang-18: 90134 lines of disassembly, 6090 gotos
> > clang-20: 78369 lines of disassembly, 6085 gotos
> >
> > So this does not look like a simple program-size increase. What seems t=
o
> > change is the branch layout in the unrolled loop body, which seems to
> > make the verifier DFS go deeper before pruning.
> >
> > One useful data point is that a single __on_event() copy does load
> > successfully (that was my v2), while with 2 or more copies it
> > consistently fails at exactly 8193 jumps. In other words, the verifier
> > hits the jump-sequence limit before reaching the second copy.
> >
> > I also tried a range of source-level mitigations, but so far I couldn't
> > find one that preserves the test intent and keeps pyperf600 comparable
> > to the other variants:
> >
> > - UNROLL_COUNT tuning: 99 does not compile; 100-120 compile but still
> > fail at 8193; 121-145 fail to compile; 146-150 compile but still fail
> > at 8193
> > - early break/goto on !frame_ptr: insufficient for pyperf600, and also
> > hurts pyperf600_nounroll by adding branch points to the 600-iteration l=
oop
> > - wrapping 5x __on_event() in a non-unrolled loop: verifier still unrol=
ls it
> > - making get_frame_data() __noinline: still fails
> > - moving the unwind loop into a __noinline subprog: still fails
> > - SUBPROGS / __on_event as __noinline: still fails; codegen changes,
> > but the verifier still hits 8193
> >
> > Paul also mentioned trying STACK_MAX_LEN/UNROLL_COUNT and only getting =
it
> > to work with STACK_MAX_LEN reduced to 180, which would make it too clos=
e
> > to pyperf180.
> >
> > The only source change I found that passes is reducing __on_event() to =
a
> > single copy, but that clearly weakens the test as pointed out.
> >
> > At this point, I don't have a source-level fix that preserves the test
> > intent.
>
> Hi Sun,
>
> I have an old investigation for the pyperf600 failure reason from March 2=
024.
> Attaching it to the email. The discussion happened off-list.
> The source-level "mitigation" I found back then still stands:
>
>   --- a/tools/testing/selftests/bpf/progs/pyperf.h
>   +++ b/tools/testing/selftests/bpf/progs/pyperf.h
>   @@ -97,8 +97,15 @@ static __always_inline bool get_frame_data(void *fra=
me_ptr, PidData *pidData,
>                               frame_ptr + pidData->offsets.PyFrameObject_=
code);
>
>           // read data from PyCodeObject
>   +#if __BPF_CPU_VERSION__ < 4
>           if (!frame->f_code)
>                   return false;
>   +#else
>   +        asm volatile goto("if %[f_code] =3D=3D 0 goto %l[has_f_code];"
>   +                             :: [f_code]"r"(frame->f_code) :: has_f_co=
de);
>   +        return false;
>   +has_f_code:
>   +#endif
>
> (One needs cpuv4 because of the jump instructions exceeding 16-bit
>  offset ranges are only possible with cpuv4).
>
> The decision back then was that the "mitigation" is too brittle to
> apply and we should leave the test as-is, hoping that verifier would
> get smarter some day and be able to load the program.

Back then the hope was that it will be fixed imminently,
but 2 years later it still fails. So please send your workaround.

I prefer to have 'test_progs' passing all tests without denylist.
