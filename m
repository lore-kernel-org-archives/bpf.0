Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DD33AA1B8
	for <bpf@vger.kernel.org>; Fri, 22 May 2026 13:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779456718; cv=none; b=qThzDAeMgKn7rTCwP05M3CBgQSXcpDqbQcCEAjZQ3t97D9xI0XGVnR8z4Uip1uqR3czCZYzME7rOVnZWsPuEiZ63XPTmNcqTQyMj6ux++dBScvM0hZQdhv545Puwt5U15B3ERJmkGuzt5QznIZoTKfZedSjaFy4Qdhi0pTKbzVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779456718; c=relaxed/simple;
	bh=yfZuQfY+ugIeA6EcssHc5dZEJ3vWOTTNLQpj6E6unSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E86zLxDp58m6PxkOhvLYFO2Fc5ISrxql75FUKgEYVTk64V6rd6jmkHunA391QVlrwEzoR2rI4vxXehnk8QH1dFVy/4Ih78xS8dSeZKXXkOnElmzuTkdz0q18tytl7j79aeJf8bhZO2xoEMWVP1RrTkNMdEDd9qcbhquupzm4ymE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j69kL6Za; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j69kL6Za"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F1941F00A3E
	for <bpf@vger.kernel.org>; Fri, 22 May 2026 13:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779456717;
	bh=9H6UaDdlaI6ydIRIrgR/3TJ20CPLVbRSRwkleSG21xA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=j69kL6ZaFhrr6MatRKHyUwv5ZE5dubwkqjtyde67+DPzeUTtHLvSTITgtzBP6ALvQ
	 PbmzNFh6nj8YZEOdGEcrqovIBQ3tSFwXo1SIt+SfwntSmH8a8yESnNudqtUetbIKsO
	 jSfA6twmupgBAlJLvhyOsLdhWrbwyEkcoizS19A/IQTQcdBBS+OfRCp3F2J5sxJENR
	 s10NrZDTSPuWcoZxEtJNuGCG2i2vH830rf8qJi1rWeujr38BOuPz36expP6WRCZxw1
	 RyGz/eTfjU0XvC04kQWECXnKQxmrYP4bKLu8bk9i8LRGbAYknFlNM8hjCquuJuV4w7
	 nrNrikbyjVgTw==
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490426d72f7so7798985e9.3
        for <bpf@vger.kernel.org>; Fri, 22 May 2026 06:31:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8KaLMhk3MJ3gSuCQcdTD4DvQmNTDs5/BUXcTSx8/FCsqO3FMMeXvJEPwTVi1p75u0b48U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4DKcIlUhf750NmWBqIGj1QGSygUOqwq2w7v38eQtxAjjAYBf+
	du+bCNWSl+dap3DsMK0ptc6BOYg5JnZDlX/NpJ9euxKEvpvkaqroYmZUSRTN8BL/AG2xy8GYNaS
	cxhl+eOBWu/3UZif0saK/dsQYAozrV8nN/pbhjawc
X-Received: by 2002:a05:600c:1392:b0:490:46bf:17ab with SMTP id
 5b1f17b1804b1-49046ce6026mr33690465e9.29.1779456715810; Fri, 22 May 2026
 06:31:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521152217.2345235-3-kpsingh@kernel.org> <20260521165240.D95EA1F000E9@smtp.kernel.org>
 <CACYkzJ47rASFZLZPz2VU9FE7J2-hGdw2f-5LQYmXoB9urVwRqQ@mail.gmail.com>
 <CAADnVQLJw=Dk=VjWmot4O1WLm2TxLH+-mX3G8AuPd9f_5rAJCA@mail.gmail.com> <CACYkzJ4LO2tAdarpKAO3Nz-XjCiJ3+tNkBp_kXEr-2YqOnCwMQ@mail.gmail.com>
In-Reply-To: <CACYkzJ4LO2tAdarpKAO3Nz-XjCiJ3+tNkBp_kXEr-2YqOnCwMQ@mail.gmail.com>
From: KP Singh <kpsingh@kernel.org>
Date: Fri, 22 May 2026 15:31:43 +0200
X-Gmail-Original-Message-ID: <CACYkzJ41oiLQSYPi+AguQz9eZVRjFxabsiWexwsZhAiTU4=t1A@mail.gmail.com>
X-Gm-Features: AVHnY4K05dpbqXfwZEVZeAJi17_AtmIXGRs3eUlScWI2Z3O0C30Qob5QMeMnyvw
Message-ID: <CACYkzJ41oiLQSYPi+AguQz9eZVRjFxabsiWexwsZhAiTU4=t1A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] bpf, libbpf: reject non-exclusive metadata maps in
 the signed loader
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: sashiko-reviews@lists.linux.dev, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 5:47=E2=80=AFAM KP Singh <kpsingh@kernel.org> wrote=
:
>
> On Thu, May 21, 2026 at 11:30=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, May 21, 2026 at 9:09=E2=80=AFPM KP Singh <kpsingh@kernel.org> w=
rote:

[...]

>
> https://raw.githubusercontent.com/sinkap/linux/bpf-md-ptr-32bit-test/test=
_bpf_32bit.sh
>
> commit 13fa71a6e16b6f024da481bb7a733c312974ed32 (HEAD)
> Author: KP Singh <kpsingh@kernel.org>
> Date:   Fri May 22 05:18:32 2026 +0200
>
>     bpf: use __bpf_md_ptr for excl_prog_sha in struct bpf_map
>
>  include/linux/bpf.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> commit 13fa71a6e16b6f024da481bb7a733c312974ed32 (HEAD)
> Author: KP Singh <kpsingh@kernel.org>
> Date:   Fri May 22 05:18:32 2026 +0200
>
>     bpf: use __bpf_md_ptr for excl_prog_sha in struct bpf_map
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 11bec73db199..ea9bd24f82c0 100644

[...]

> =3D=3D=3D Boot 32-bit QEMU =3D=3D=3D
> qemu-system-i386: terminating on signal 15 from pid 4116468 (/bin/bash)
>
> =3D=3D=3D QEMU serial output =3D=3D=3D
> [    0.000000] Linux version 7.1.0-rc3-g13fa71a6e16b
> (kpsingh@kpsingh-genoa) (gcc (Ubuntu 15.2.0-16ubuntu1) 15.2.0, GNU ld
> (GNU Binutils for Ubuntu) 2.46) #3 SMP PREEMPT_DYNAMIC Fri May 22
> 05:25:14 CEST 2026
> [    0.000000] x86/CPU: Model not found in latest microcode list
> [    0.000000] BIOS-provided physical RAM map:
> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff]  Sy=
s
>
> [...]
>
> =3D=3D=3D Running atomics signed lskel on 32-bit =3D=3D=3D
> REJECTED: load: Permission denied (errno 13)
> LOG: 0: R1=3Dctx() R10=3Dfp0

[...]

> R1=3Dmap_ptr(map=3D__loader.map,ks=3D4,vs=3D9976)
> 78: (79) r2 =3D *(u64 *)(r1 +32)
> cannot access ptr member excl_prog_sha with moff 0 in struct (anon)
 I think we can address this as a follow-up and I'm sending v3.

 We don't test it in the CI and I spent way too much time proving /
debugging despite help from our AI friends.

- KP

> with off 0 size 8
> processed 29 insns (limit 1000000) max_states_per_insn 0 total_states
> 2 peak_states 2 mark_read 0
