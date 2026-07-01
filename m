Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCF1480DED
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 11:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782907070; cv=pass; b=k814QNY9dPgsdd0LQC2mTA84wzNEg0+7e3sf0S1wlrUxbQspl7jCiR76WSwdIG3CelewL/BWTo6DWBxwxP1IzHC8x126iBzhs+7HWg8Ocryq3PROfQYEVQ0ag0Od3vHwNbuAgR9Je9js4h3reFsPZ643bO2e6xO1X6MUK39nfC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782907070; c=relaxed/simple;
	bh=k/m7mOwOe2VK+7j1exKhxSnw3ozmGI8iEWqvbTFE6eI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uMJWnxl61Sz+aTo9RBHWNA4cVkTJQNoukhMyQbeSzWnfqAOhPhkIJGqp/Kwe7rrd/Ab3+GahxFzKqQFB/7ENkVPIo8JPdambul0jNvvn/M4DYcpDxd7CPbxAPuAshlv86nHzPIEYOQlqkNifuRCpkQDuIPirFs+nNkp3HoiMGx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=beayJkSQ; arc=pass smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="beayJkSQ"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-4955cd5da3dso220896b6e.2
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2026 04:57:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782907065; cv=none;
        d=google.com; s=arc-20260327;
        b=MUMUs5WfYmx8iGuamhu0UarsbmIDjOi9YI7w97eVKjW10Ob2f/R9W1B21HAGyoK+yn
         RXQmpONDFPzx6CUJrNqoNOd7cmfnpDo0zDDHpcmCYk/0M+D7fzjklNpf0wwln4ogVZni
         4HiA4d4UdBcb707DZtlIJKX+HySD8O+ZHpTdIjBxrLVxsBLrudmQbmfyaDYaQKlWkfZW
         /cQsqL2AqXu1q1X2AO8z1BAOp39ghCwAvT+sRZWArNwwGt71nhhkywyiLOgU5NfCVd0u
         cqAaK5Fn9dYNLeUjxbKK5Vc8Cwf7j10Y+9hATxMPmPT+8igvfhvjNE/H7UoT8DbSblMX
         N+uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lqKxpCifHTwVLxyMY/FMijSWYZ0kJMALXZou2Lu6auM=;
        fh=TdfAiknAoHYJDv9dwgL26uTECxAWnaVfFFEM+0TUTpA=;
        b=GFt6Zk9fIhsHb+8qpOrKa8uBGpj7ogNXQSIeNkyTDPVTFNuaGDq4wgLhI66xpbhBma
         lP8W/q7erKlftc4rwxZ9CZT2tzO8wvosgxBgiDmegVShf0rX3jXtjo0COpjToRJXAEGI
         DWAWPBQUsRJuYTf1j6X58jfuha3z6uCBc24NORjFEvqllqCu43+3DXoJ+IslrV0A97Zi
         3ZAsrnA+f/Qe/JuXXeSBQJZVj9xbmclIIJ7WWnsWKoYd0M15YGr2oL0dt4TXevt9ri//
         ch+6pI+tyzA55gstuC0k/MAM7xgsjzvP2+PsMMjxL1aZG5Bqs5dV3cJU/dUK2EqyfK3u
         BrHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1782907065; x=1783511865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lqKxpCifHTwVLxyMY/FMijSWYZ0kJMALXZou2Lu6auM=;
        b=beayJkSQr05vWYthJphsua2qi+wI2deN3ee4s+RMMCcgG36dU/SEXscL3RrMizBEa3
         eOAxxSCX2hqgrkeKXxMxF7dAXzzyw67pfUz/T15fHCiNkUaPTnlR/pZynfzeNlGeDDKq
         buWXeDmcWf/HUMynqzaP/5i1vsu9w/Yj0BGAeuvAZ4gZ1WMo11SqajiqzMHOIlAJsTtw
         FOzLTQj7VUgrAQdAIS5uuRU2zq7AGqH3shd3tSFeo31+Uvd59dItC1E/EROQsNmp0rAT
         GrjUFCOZfpGFgvYMRBTNx+zSAIk5+nIHn0pTElTWQqb8uHmUnEi87FV+p3IjP54ID4OV
         HxhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782907065; x=1783511865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lqKxpCifHTwVLxyMY/FMijSWYZ0kJMALXZou2Lu6auM=;
        b=AFT7IypUDcwDvimi+cxEi5AC1wCbMeUwgszAb21e93ypGTgOkmOmcmpDRDoH418ezL
         4A74634BDThmPWhSJYotgknHtbCuNZQH/qKjjUBMJIBGZUwhyPtmxRGFdIHb5byZIjEx
         zObqTmniO2T2a7ha1iiit/jxEhrzqKEdzZy7W5RSncpv01kcfwWJwML0Gt7wy5dyRx6S
         R0vMQuh990Azw87FwCY4XUiz5xCL+LnczznFnw779c8PWXmqmOX2Fcdhm6K2DbNG8k1n
         WD1BTkiH+AJ6fS/IC966USnCIBQTu59I804RoTwrYLksDsBxj03yYOMYuC6qoAlcN6Xl
         sD4g==
X-Forwarded-Encrypted: i=1; AFNElJ+CPGYLeT4r0mxcr6FbZ1awlynnylQEmteKP5cBuwJjV8QBL58bl5276ZAKcWocAY9loh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxI7k/a+F9SPIkTdybixsKjkaSYy6yfKc13TuIOPxU2qCMm+LX
	196wxRyBC7brgHhHs3qeFmVJUc4oRBIEsEviBay7lsegg+bQiKTNIWChsXal5E2sjkyWDs/O/gi
	PKuIearqZ48kupXe7NggkH2pV+5oiGKu8doQ+IwHSoA==
X-Gm-Gg: AfdE7cnQTYYsIc3tIHRGNrcqja0IrNosInaeomO9dNrdd78ieegYFyq7uQ7zsnhV20n
	nSxXjpC4oMUQFHRM0oGtAWd4J8mvea5JK9MNNmDDJd5OGCubJjXb+rCgLmtosXYX58kB1Z56+HL
	5Sh9eK2M77WhSW0DMprI4XIyMTvN78pJgBvZnBnRtSjIZzWgEloW3DkQ4Dq1u4vDKvd40KLDp9E
	2LVMyde75UzVkI6Js9G4pxs0Srouzl66c2Hn4hrgTAu7PtwQaUSb5kHbo39425sHZzK9lYAzEQ=
X-Received: by 2002:a05:6808:1389:b0:492:5bf0:d29f with SMTP id
 5614622812f47-4960f0d2101mr838181b6e.37.1782907065542; Wed, 01 Jul 2026
 04:57:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1782877663.git.cuiyunhui@bytedance.com> <7988df83f6341ea045ebd7294af2e8907dbd5ee7.1782877663.git.cuiyunhui@bytedance.com>
 <ea525a80-1e6f-4304-a371-3ec17d91ee96@app.fastmail.com>
In-Reply-To: <ea525a80-1e6f-4304-a371-3ec17d91ee96@app.fastmail.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Wed, 1 Jul 2026 19:57:33 +0800
X-Gm-Features: AVVi8Ce8Hvhgv036NZvyTtBZ5NMmFq-2bEMlGWh7WwSjecXpQvRJF8LZ_SFRCM4
Message-ID: <CAEEQ3wnDACZ08kk6ycpgXezgyS5zxi+P_vF_yBScK2sxU+UKaw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v5 1/3] riscv: io: avoid null-pointer
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
	Vivian Wang <wangruikang@iscas.ac.cn>, Atish Patra <atishp@rivosinc.com>, 
	Anup Patel <apatel@ventanamicro.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, qingfang.deng@siflower.com.cn, 
	Linux-Arch <linux-arch@vger.kernel.org>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

On Wed, Jul 1, 2026 at 2:25=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Jul 1, 2026, at 06:20, Yunhui Cui wrote:
> > @@ -56,6 +56,8 @@
> >  #define __io_pbw()   RISCV_FENCE(iow, o)
> >  #define __io_paw()   RISCV_FENCE(o, io)
> >
> > +#define PCI_IO_ADDR(addr)    ((void __iomem *)((unsigned long)PCI_IOBA=
SE
> > + (addr)))
>
> This does not seem to have any purpose, is this just left over
> from the previous version?
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
> As far as I can tell, just adding the #ifdef here should be sufficient.

Okay.

>
>       Arnd

Thanks,
Yunhui
