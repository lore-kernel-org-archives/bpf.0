Received: from mail-ua2-f35.google.com (mail-ua2-f35.google.com [74.125.226.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4ECF3EDAD5
	for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 14:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790517815; cv=none; b=r7wTDO5Y0lt5k2DlCInfCDS5dfDtSu65awmD4y4XvQZRre1NSRFTWIDS3i8iPuYAz14MoJqb0gY9/++vmIB4jlgMu6hym5fazSIVgSTxf6qrYzwA3mXPt7/0MFhfcDYjC1JdM0AQ5UlwPKRy3iPaNplhuuQ21JIZX1mQBFNCH9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790517815; c=relaxed/simple;
	bh=yhyQ5E5gTwtMoqYqyOj85N/VFjOffiNcf89Kbn3imTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mmzeTAJiJk0fQocT4z6eThO+BDQYlq4WiGNZXOvnG5Zc9c7Jo//r6x8D61MkjUTesHaXqy9nscbRZWIXXxyUsy5TlP/AG3xE/MTJIwxdV8Q8+Dka8cvlJAiu4mSe8KsisDSHZs/fXvdFfVIVyxL9RyNCMRlttWhg8yFg9nlSI7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.226.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua2-f35.google.com with SMTP id a1e0cc1a2514c-9863292a2e9so708935241.1
        for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 07:03:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790517812; x=1791122612;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SEr1x1TudocYne3WCX5MTGLuJSrLgCYH24KPO9XObHo=;
        b=nFEDOfQyvT5YYcVY5IyX6tjIKkoeWrVGcPiUt2bdV7FW1yy3ojhqjuXrAyKqjKtazx
         VkoWu97ZcdL0uW90i4la+7/rfbvxQ+sBce5DVqzodXg6dTib7Le6MUItu5miGTo3KP6j
         nUs/gxxtdJh2CYkSKqd4UL+yuGcVJ4W+N0vp7duyPk8Ghq3J4vKqZp53+lazM+Kpb0/4
         PWcz0IfS/Z+hiOmqN1hzO6MgbYbpkfJf7uofNIIxCcWXFvDLbN2o7x0PsYIavJyMI9Nr
         U4/B5mkRwyHDHtJ7e0fpmwhaaq78gX267KZ/XnZJ/jiSQ1g9bsYJfDJJmYmhitt+2fEZ
         K9Xw==
X-Forwarded-Encrypted: i=1; AKwUvBydCcMhH8wgwfrNablGPBF4j6yu0sK/ygmTwniM/qoIMhKuDPnoKWnTrgp3USDhhelR53E=@vger.kernel.org
X-Gm-Message-State: AFq9FYKlYjeOKajIMrotJAtYwZg3B+/QP6ffziEy55DB86vhpM46yEp6
	xhBmJmeoe2C8yDZK+o2oC5H3yL6bRorarInWLUGq4LS5vjOnFL+CRcgBr7zHWFbM
X-Gm-Gg: AYBFou0PItIySJjH8+DchrMS6FiJWB+4Vxy8Ex+3RXhkIq4/8UBNa76OHJqDAS/maBD
	kXpbVGgum3KklRuBayN2+Pip8I50wsXI4IPhJP9lUO0ENjrEHYGe1+LacJmOO95yb7S1omnrSNC
	k7fBzqEi6ENp+av6wXBsYTBowfSLv3bBYTe7a0TBC4K/bn66N1iv1MwwrECcBVnuil73iZolmSD
	vNr4LgI6Xd6DmVniVrBPIRwODn5IEHRhmpP43uKCzAUgPrIVNHGzLd1eZCERjJ8Z538JoUzEVIo
	M/QE2uI29OmGJ73RmfRzlVsNjt+gCizimHNJu0mWpcugqzsdR8JK1zgUizGRgThqrWKO5Cm64Ce
	ANENRAsvAJ/lNm09h4PYsRmG2ma2EUceHishLU+M4TRM+20rfAEeCdnpwL6VSrfQfpzpLB7foL8
	pg1rV8x+mC+5fzGKDnEkwCt3AnWQF15HwC5toXAFp0GbJLfIc53/TgahvBdz6NnbmwT+9EY8MUm
	xni1UABqW93t0sv20OSt5LlVliVZc6rFPfacQ==
X-Received: by 2002:a05:6102:6889:b0:7b3:2a2b:ca0c with SMTP id ada2fe7eead31-7b32a2c2f2cmr1278480137.21.1790517812549;
        Sun, 27 Sep 2026 07:03:32 -0700 (PDT)
Received: from mail-ua2-f42.google.com (mail-ua2-f42.google.com. [74.125.226.234])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9889afc5b62sm2767715241.1.2026.09.27.07.03.27
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Sep 2026 07:03:28 -0700 (PDT)
Received: by mail-ua2-f42.google.com with SMTP id a1e0cc1a2514c-98729795320so272931241.3
        for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 07:03:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzeuvSyjhA+Hm/G1lSUBFkKn2Sfb1/6NfF7MTgzWzviLNEWBoI1EHPkGkKJErhPwjpi43Y=@vger.kernel.org
X-Received: by 2002:a05:6102:6a8a:b0:7b3:32fe:77bb with SMTP id
 ada2fe7eead31-7b332fec22fmr1341342137.27.1790517806812; Sun, 27 Sep 2026
 07:03:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260823163812.3024812-1-visitorckw@gmail.com> <f89b4e87-12fb-45ae-a2a1-12ebcc483326@polyxeno.com>
In-Reply-To: <f89b4e87-12fb-45ae-a2a1-12ebcc483326@polyxeno.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 27 Sep 2026 16:03:15 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX6rtJDZUqhLf+-U=9=yTkhJtYUU_Ru1GE=7o0qXu+d6Q@mail.gmail.com>
X-Gm-Features: AclHuK8wpR6y1eZRM9LOMXOTOPARQG0nffPxefCG8RnAkx6men2t0o6U3_-doY4
Message-ID: <CAMuHMdX6rtJDZUqhLf+-U=9=yTkhJtYUU_Ru1GE=7o0qXu+d6Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5] m68k, bpf: Add initial BPF JIT compiler support
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: ast@kernel.org, Greg Ungerer <gerg@polyxeno.com>, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, 
	song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, 
	emil@etsalapatis.com, ihor.solodrai@linux.dev, jserv@ccns.ncku.edu.tw, 
	marscheng@google.com, eleanor15x@gmail.com, linux-kernel@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, bpf@vger.kernel.org, 
	Daniel Palmer <daniel@thingy.jp>
Content-Type: text/plain; charset="UTF-8"

Hi Kuan-Wei,

On Fri, 28 Aug 2026 at 12:50, Greg Ungerer <gerg@polyxeno.com> wrote:
> On 24/8/26 02:38, Kuan-Wei Chiu wrote:
> > Add a BPF JIT compiler for the m68k architecture.
> >
> > The JIT generates m68k machine code targeting m68020+ processors and
> > coldfire parts with an mmu (ISA_B/ISA_C). It excludes plain 68000/68010
> > and non-mmu coldfire processors, as it relies on 32-bit branch
> > displacements (b<cc>.l) to handle large bpf programs.
> >
> > Tested with the test_bpf.ko:
> > test_bpf: Summary: 1061 PASSED, 0 FAILED, [1049/1049 JIT'ed]
> > test_bpf: test_tail_calls: Summary: 10 PASSED, 0 FAILED, [10/10 JIT'ed]
> >
> > Tested-by: Daniel Palmer <daniel@thingy.jp>
> > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Thanks for your (impressive) patch!

> From here it is really up to Geert now if and when he will pick this up.
> I am happy with this patch in its current form.

Who am I to block this feature? ;-)

> > --- a/arch/m68k/Kconfig
> > +++ b/arch/m68k/Kconfig
> > @@ -8,6 +8,7 @@ config M68K
> >       select ARCH_HAS_CPU_FINALIZE_INIT if MMU
> >       select ARCH_HAS_CURRENT_STACK_POINTER
> >       select ARCH_HAS_DMA_PREP_COHERENT if M68K_NONCOHERENT_DMA && !COLDFIRE
> > +     select HAVE_EBPF_JIT if MMU

Pleave move this to the other "select HAVE_*" lines below, to preserve
sort order.

> >       select ARCH_HAS_SYNC_DMA_FOR_DEVICE if M68K_NONCOHERENT_DMA
> >       select ARCH_HAVE_NMI_SAFE_CMPXCHG if RMW_INSNS
> >       select ARCH_MIGHT_HAVE_PC_PARPORT if ISA

I think you should also update
Documentation/features/core/eBPF-JIT/arch-support.txt.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
