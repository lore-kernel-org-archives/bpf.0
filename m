Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B433655C3
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 03:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782875477; cv=pass; b=o49JECfpjl41dRMFtm9fBN8Z9TmXrRP+Clk6qi64yKofhaOBDxej+nhFe4/JfR2keSDK/ORUDUDgLx7B8QDll+tQxsNzqOgRX3Vy6i4cCRUJ5LUC4w21+rjxLPS5niuXw8mqGMy1fjV2zHlcXzqw1FVS5D07fELG+0SWdx9poiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782875477; c=relaxed/simple;
	bh=0uOca1qt2gUEPBJfSHH0c1IQv17V7spgn+tiXL+gnJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uBjo7qiOOjuZ/AYxrw3wrKrrFqCiLHfBhwIOmudeNw/IUrC1uiay7tXAuo4FfIK5VCJPmZBdemMppMOmUa7r3GsezCw8kD+18aDhWijVGClhDNfs2kU+ywPCZTsC/fkGm1ap3JqAd/CI4lEwR/4T3OknEVoek4kKp6GOzqHmJVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=RhtWkNr9; arc=pass smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="RhtWkNr9"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7eb29ed2bbdso28430a34.2
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 20:11:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782875473; cv=none;
        d=google.com; s=arc-20260327;
        b=UUOCZULt6LCciCnP484APYJxBEqPybKIfEKeHjq10SlrJFMTlnfWkODWBjV2f6cTbf
         ZGsxXIAiPZsTC+dirsbhYZAwThoG1t0u2Dw7BrY/yMj5Gok29v+pjbsg2Pb3JKbQ6U9T
         baFGXN8ty0CJvThZfAlDqqAP19rKxqW2g799Wv+aA2c4ED7QQRaGGzGfKigruV0qzLbP
         skYNvJHciGtN723zQO0zoU6V3Tfj4Sfj5ZDdtqdZM6i836GNj5qAGxl8eSaE3ueK15KG
         lfxQqAjJcibReooyEHptHrEf9VTuPV2l01koyrpVDI1j4kttcehfIvxjqddg4qPlhGqJ
         lGyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AW+XVWe2JL0df9uuAdxaZgi837urm1REze6zO62j7wg=;
        fh=MtKEu9jM6dPY8LSjtuhFxyjq86sWhnK/m4xDbHI1DHw=;
        b=aTX4fUMO2f/39O4OOmwywgQwY81fy7FWBGgKj+O0a6Ol3oBiyB+IeO3EbCSjYZSQIJ
         wKBopNvOwoEyLUjXPVtZ0VWPPa74nHSBbcXHwOF/joZnyWmtJutrocgK+5iNuA58oYrk
         qYq3ixz+FpLeOsfv/GhilAmhVJVQjRtjmo7RuGsxrTlzfMR7CW+QRU2KUU8rVfuXjz9Z
         ojd3Di+xLZ4GymywqIjoBwoVLtUWedSutTpaNKgvu9rsQateVzmjCLVP/sUop1MsUUMB
         zTrhCTbUHp7ZL31sx1dE5OQPLE+d1fxloERnT81EZvgPZX37zTXJoH7OHM6YQHyfA/Fu
         6n6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1782875473; x=1783480273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AW+XVWe2JL0df9uuAdxaZgi837urm1REze6zO62j7wg=;
        b=RhtWkNr9HQpCqgGvJVbgjiv2wzGAcrVQ+TANpvNCyIUXljKu9PhtnvdatILuTv1M1K
         PrDLUPg+L7Up4A24TBlk8gNNNUFTfWfELGRA83Bu5YBwNAeVvzgeBTO+E+21KLaAY7Hu
         Q1xWOUMDe4mjI5IBlU/nYxcT/OBYKg6lN93XIQTcYJUK73YvCUufLIqMdE5sea5peJEN
         ReZrZMf8DKYjiafiuZ7tlictI6Diw29QfSbSlM+LnvsK/8+lMadzvNT44xJTAPxa4X69
         3DROgSsOLwDWlz7PcRyj4SWl38cPKL3A/fNJJyaX9833yI8RXvn+OTqR5VokoT24MyAH
         VFvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782875473; x=1783480273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AW+XVWe2JL0df9uuAdxaZgi837urm1REze6zO62j7wg=;
        b=U8dQAMe4afc9JKzvKlKvJboaIjCtpjviUax65xZoS/OKlOAgz8A4INiE6l8f7br4Xp
         AnnEMYcDafFIVx9XKGAFdFsDvdJkRthKneGXIeI79Ho0DJacU6KWthWQJ5FItdbjqjSh
         ZwLLY3mRiep7Zskj7F7nf2JACkmaVviiJdpsIrU/X5dPBKw7ieO+S5O7ztX5HsGlmg2K
         qGVDglMPjwWlk5MxaqtMaItpc/Tfgudv3k2ahFGJ+k4gPVO6HaKGHzUIxOkf7rlV9oLI
         69WEGGLOejbYogxUOG8metqmpsVd4fc/Bf/OElC6e+2BAtw1q2eykJI1UbOzZC9Hz9KR
         7Jbg==
X-Forwarded-Encrypted: i=1; AFNElJ/Q30SXRU2h+5qHKuYaGW2zSnihBD1Yx+BZawADal7tkFx5/QF3sjtVdz+yxHH6RnnfuDE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc2mTzES1y00Jbn/lBJK7MoK7PXHgaOiCcvbgG/hHrYNYq0UB1
	tTAhOfa2ss7K+5uFss4+XdR4mHC8V4Z2PBCTGV2gZx4PjoZRbPmAWR9QwLIv/23WzkY3g9+q7/O
	T04zSHMiKDn1v6Z0tORW2G5oBgXnwabGePk12DAS2bA==
X-Gm-Gg: AfdE7clS7hzQIjBLFa+En0UkUIUVf4g5WosN5bS/whgDNhb0vXHxFBY7g63+vbfvmqK
	2wN1IT51Tveko3FB5z1JHHEZYfu68Wesa0lWYy4ZaEtTFKub+qL6WrUhPIS1+KPglPI7UnB++c/
	/GXUy69eiVsQoFt/jA6uazRlcoRAC7E5c3oejEGBxXLL88AjJRwH/YynK5kOyZLUtE3NCyKpM5a
	dXzOE4rWpZBUwWyWKbUqwJytBdS5T73lMYWLJLmbIlEioh9gd6bQqxMUon80oM0IDEki9Y1WM8=
X-Received: by 2002:a05:6830:4901:b0:7dc:c4ae:a689 with SMTP id
 46e09a7af769-7e9ec586d01mr4829708a34.2.1782875473497; Tue, 30 Jun 2026
 20:11:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505062026.91724-1-cuiyunhui@bytedance.com>
 <20260505062026.91724-2-cuiyunhui@bytedance.com> <3720c3a4-cc0d-4ba8-97ae-35def0189e2e@app.fastmail.com>
In-Reply-To: <3720c3a4-cc0d-4ba8-97ae-35def0189e2e@app.fastmail.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Wed, 1 Jul 2026 11:11:02 +0800
X-Gm-Features: AVVi8CfCZ39PlUVHuhvVesQ30Ayu5byi3NLY-dGR5ZLniizemgTSehNq4vDg6QE
Message-ID: <CAEEQ3wn8AFVqWZAiXfQd4a1ZzH=2L8qRX4W3S=KcmQ5FORjn+Q@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v4 1/3] riscv: io: avoid null-pointer
 arithmetic in PIO helpers
To: Arnd Bergmann <arnd@arndb.de>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Dennis Zhou <dennis@kernel.org>, 
	Tejun Heo <tj@kernel.org>, "Christoph Lameter (Ampere)" <cl@gentwo.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, pulehui@huawei.com, 
	puranjay@kernel.org, Thomas Huth <thuth@redhat.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Ben Dooks <ben.dooks@codethink.co.uk>, 
	=?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Zong Li <zong.li@sifive.com>, 
	"Conor.Dooley" <conor.dooley@microchip.com>, Thomas Gleixner <tglx@kernel.org>, 
	Deepak Gupta <debug@rivosinc.com>, seanwascoding@gmail.com, 
	Andy Chiu <andybnac@gmail.com>, menglong8.dong@gmail.com, cyrilbur@tenstorrent.com, 
	wangruikang@iscas.ac.cn, Atish Patra <atishp@rivosinc.com>, 
	Anup Patel <apatel@ventanamicro.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, qingfang.deng@siflower.com.cn, 
	Linux-Arch <linux-arch@vger.kernel.org>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

On Tue, May 5, 2026 at 2:34=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, May 5, 2026, at 08:20, Yunhui Cui wrote:
> > The RISC-V PIO helpers derive I/O addresses from PCI_IOBASE in ins*(),
> > outs*(), and ioport_map().
> >
> > Under configurations where I/O port support is not available, these
> > expressions can still be formed during compilation and trigger
> > -Wnull-pointer-arithmetic warnings from clang.
>
> If a driver attempts to use ISA port operations in a configuration
> without CONFIG_HAS_IOPORT, there is a NULL pointer warning because
> this is actually a NULL pointer access that will crash the
> kernel if the driver is ever loaded. You should not attempt
> to shut up the useful warning here but instead make sure every
> such code has a proper 'depends on HAS_IOPORT' dependency.

Thanks for the review.

I agree that NULL-pointer arithmetic warnings can point to real missing
HAS_IOPORT dependencies in drivers, and we should not hide those globally.

You are right about the generic ioport_map() change: the helper is already
guarded by CONFIG_HAS_IOPORT_MAP, so the extra CONFIG_HAS_IOPORT check is
redundant. I will drop that change.

For the RISC-V ins*/outs* helpers, they use PIO-specific fences
(__io_pbr()/__io_par() and __io_pbw()/__io_paw()), while the asm-generic
helpers would go through readsb()/writesb() and use normal MMIO string
ordering. So removing them would change ordering semantics.

I will keep the RISC-V helpers for now and only guard the port-I/O
variants with CONFIG_HAS_IOPORT.

>
> >
> > +#ifdef CONFIG_HAS_IOPORT
> >  __io_reads_ins(ins,  u8, b, __io_pbr(), __io_par(addr))
> >  __io_reads_ins(ins, u16, w, __io_pbr(), __io_par(addr))
> >  __io_reads_ins(ins, u32, l, __io_pbr(), __io_par(addr))
> > -#define insb(addr, buffer, count) __insb(PCI_IOBASE + (addr), buffer, =
count)
> > -#define insw(addr, buffer, count) __insw(PCI_IOBASE + (addr), buffer, =
count)
> > -#define insl(addr, buffer, count) __insl(PCI_IOBASE + (addr), buffer, =
count)
> > +#define insb(addr, buffer, count) __insb(PCI_IO_ADDR(addr), buffer, co=
unt)
> > +#define insw(addr, buffer, count) __insw(PCI_IO_ADDR(addr), buffer, co=
unt)
> > +#define insl(addr, buffer, count) __insl(PCI_IO_ADDR(addr), buffer, co=
unt)
> > +#endif
>
> Can you try to remove the custom accessors altogether and
> use the ones from asm-generic instead? These should already
> have the correct behavior all the time, in particular they
> already come with the correct #ifdef check that is apparently
> missing in the riscv version.
>
> > diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> > index ca5a1ce6f0f89..d799e5ccc9437 100644
> > --- a/include/asm-generic/io.h
> > +++ b/include/asm-generic/io.h
> > @@ -1205,8 +1205,12 @@ static inline void __iomem
> > *ioremap_np(phys_addr_t offset, size_t size)
> >  #define ioport_map ioport_map
> >  static inline void __iomem *ioport_map(unsigned long port, unsigned
> > int nr)
> >  {
> > +#ifdef CONFIG_HAS_IOPORT
> >       port &=3D IO_SPACE_LIMIT;
> >       return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
> > +#else
> > +     return NULL;
> > +#endif
> >  }
>
> The function definition here is guarded by the #ifdef CONFIG_HAS_IOPORT_M=
AP
> check, which should already prevent it from being visible when
> CONFIG_HAS_IOPORT is disabled.
>
>      Arnd

Thanks,
Yunhui
