Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCE439B97C
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 16:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774368259; cv=pass; b=k6hDgk+AkBLnbAJVnWbX1DCm/gqzz7fjc+XfZRYJfygE+SGsZBvrBby/wk/G8HrjfJCoEDrYfyady0hecKtrKTvY0kawbN0P5h69GthbjReDSKd7Zd4/6U3hEStd5WhWMTH+0lTTGUNx2lUC3M+WzDT7ehBnHeklbLi0dtIByY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774368259; c=relaxed/simple;
	bh=Bap2I2Iwx1j90rJe9QRr9BlObCdTslZ+pvyg11P5Bkk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bTKnicdn/maOY9LfjN5XBoZWk2cayJ2xSUFZqnx9kcdeSubm1qdZI+TVmlJ1/skr8ZKakdv7IOb4vN3palo19rqvoQyoP5JZSXSL5UCnXCpazXxV7FsAWB1+cq5K3huIkDQsasbhTslWuVVlBVCFFv4P6Tw5ZXjZeRQA7u8xDeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qh6tn7NE; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qh6tn7NE"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-66a38c8255dso1367177a12.0
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 09:04:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774368256; cv=none;
        d=google.com; s=arc-20240605;
        b=Ee8wU48Dr6TCI816MZZY2+EqhFxBKZ2GdNa4kVCxxcKMe+pIPuwynMnDP48CD36zzO
         EJXmF6Rf57pTKn6DHtkVjCnlMC/1jGcJ9NpY6CS83kKNj7FwwMtswwCi/GHEfm3McIGR
         hDl6S98Lxm4UIfj1k2edYF6HwFbwJWgX6t+y1nTMsejiELtEvMHKNbOVHYhwvfeZ01+u
         OaKU8x2dMLfNCS5BeiSu806kvUbx55s737qTTnsXnOC2dzGRdxLweNQI9ulXxejrQbvc
         IQwTgnUBL3GmUG/BjrjrOazMK6jDZMs8qad15qZi05XikX6BUAym7lQacKwFB2EJWLrL
         o1ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9lAIj9nrwaKz6NfMKfdrELFElXaxUC4oA/DBJISnVu8=;
        fh=q4xa6HqL6AWMVfndyiQwlsMqoOVoPShY9MDbADRTQyI=;
        b=PmQ+mkq8ciK1gbBv4W+3xHOw7tz2pBK9yPzVwBXSrQhgyE9nTtNT7e12JIVrPm3iN9
         xnl7DSbNFBnxuqTlSEEEKVn5gpIUHhTGqUq72Mb0QRXXMybFH7J8IaVdYXkezk1Yg/PZ
         CQ7XMlp0BKTqRFKtKmprr+o7ViADBtWAFwzGeI9wV7MtCm+d9QIjZfos1V/DZLBz66Zo
         3iYyWKgUISRbeTVmtKijmbz0r/KapTCHQ0OC5owk6dtQOCJwQ9KW8jfaxO1GizIlDyIC
         9kr8JGrZOwsWblr8J4ckI458qwV3/SU5gwA4t+rgp3Fwe7xn5zluh5PsEkhRswYUoImW
         CZ8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774368256; x=1774973056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9lAIj9nrwaKz6NfMKfdrELFElXaxUC4oA/DBJISnVu8=;
        b=qh6tn7NEE62HHX3lMpBe7k2khmCW7U35AtqhMprApltPlBRt9IlTWtAF584ZGtnAf/
         Rdh/SWyughatgMoucsZtjvMqa3P0la0SKGbrWMU8Z0Bf2/FGFkPPP7oLX2k4OdesqcPa
         k9k2eid1bA6w6ZouXsQd8pHUDafnTZh1tsFgaKzsXg1ZrvZ/j7c20MG3gacpDE37rIJ4
         3SWsPTR7SvHbb8DoFVhh3pSq+IrFw4VrLGJS2tlJgubFQ5R3JQS9ozUfD6ep76AFTJLC
         CbGHW2Rogx5U00e38UbbQjFENm60+9lpMFL1qLJT/nDcVxNzfczk9zreYGRLKQnKThpX
         RBnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774368256; x=1774973056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9lAIj9nrwaKz6NfMKfdrELFElXaxUC4oA/DBJISnVu8=;
        b=EYUqvW7AN8UnBCeYc1NYiz1opMnu4m11C+BZZPObTUACd6w3yckdjrl8/qH3j1dRM5
         mbkgi/uzYLVa1M38JjPYbrx+EVAZNoU/frpNqSFXRhDbYspnH8HhoPIto1QEnDzoq2bd
         x5mchbpjVXF3twbSvM5HPGHkWpAtHKEz6CzY5w/D2UPMc5xNU/UGrT3AADx0EJfQbztL
         pdV6fAFf24HIhaAYSWOBnrwgmZhnHrckfX078wMuV6tv7p9AY9AScycQ8no0QEYZNSti
         Q9bHu0uaVOildBfp4X7xyP6Qe3Yq2lU/dx+0DD+m2tXUQ3nkHQVuNucTwbc4VTEV2Gal
         TpUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWcAN6yGeg7BQ6Y8LFLN10SCcb+rkhd96RZjQAn1ax6CmPH3/HeQi4tPl0B7JGszE8aAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxPmL3TwLNg5158Ep/OYA/07cH1K/fSZ6d3JS+kqZkuAXjEwuO
	l3osZTDTPTFJfSvvTJ5zs5P8dYUHZsXrIypfMPeUIdwjhhfi8JUzW7ZhT1cckiXz+xm+ESSxvxQ
	fAteJVUIN9cRujfpZuISPDAFK6MQMs2Y=
X-Gm-Gg: ATEYQzwVFAtL7aqaBHggZU5nSfKF99fnOyz/kyxwJCqxDtpWS1hLj4x6t0/KBnFNJSM
	2OUsRnq16yy3bv4jus0YJELRLcbdwCTzFUEH+7rMKeG7aPe9OusjWOZxWRxqZK+244Sd17vpsuW
	gXLTvuLr1M588OhwHjCzS02HhPF7kP9jU7kfOIEnSIVC0shWIaU3Xbx8DjUN4ohXGsAjqcfYJ2y
	z6avGkUDPahvLwImdnpuzDZmg7p3CTvdhb1DfPI3Iiks8rNsvgoeNaJNQu+cSizMHeMDzozbRPv
	6nLaDBR6zhV9Rc2EnPsA0Di8aeOjAUrAsNIpxm9Qd0wZFZf77sTMb2JDf86fn9XHilxvZyt1sf/
	rEDARl/TBgPGGTti1vqiCgkYzoA==
X-Received: by 2002:a17:907:a807:b0:b90:8016:cfe4 with SMTP id
 a640c23a62f3a-b982f0bd41bmr1118661566b.10.1774368255441; Tue, 24 Mar 2026
 09:04:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323164858.1939248-1-sashal@kernel.org> <20260323164858.1939248-2-sashal@kernel.org>
 <CAADnVQJjJwRtUQNZAhLoXF7DYprhU97xJReZg9izV7n3f7=uJQ@mail.gmail.com> <acK1M_CvbYCtq7im@laps>
In-Reply-To: <acK1M_CvbYCtq7im@laps>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 24 Mar 2026 09:04:03 -0700
X-Gm-Features: AaiRm50g5sRljE-pOlu1qkME3uHtiXscwZS9bY6E1gCFONCc9DBnMt7wYDgAtI4
Message-ID: <CAADnVQLr5Sx+vG6D4Jxm8r2vPxu7ygFz60LGwmqfkc=VB0-Miw@mail.gmail.com>
Subject: Re: [PATCH 1/2] kallsyms: show function parameter info in oops/WARN dumps
To: Sasha Levin <sashal@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Petr Mladek <pmladek@suse.com>, Alexei Starovoitov <ast@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	David Gow <davidgow@google.com>, Kees Cook <kees@kernel.org>, 
	Greg KH <gregkh@linuxfoundation.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Helge Deller <deller@gmx.de>, 
	Randy Dunlap <rdunlap@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Juergen Gross <jgross@suse.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Alexey Dobriyan <adobriyan@gmail.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Petr Pavlu <petr.pavlu@suse.com>, 
	X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-modules@vger.kernel.org, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 9:00=E2=80=AFAM Sasha Levin <sashal@kernel.org> wro=
te:
>
> On Tue, Mar 24, 2026 at 08:03:30AM -0700, Alexei Starovoitov wrote:
> >On Mon, Mar 23, 2026 at 9:49=E2=80=AFAM Sasha Levin <sashal@kernel.org> =
wrote:
> >>
> >> Embed DWARF-derived function parameter name and type information in th=
e
> >> kernel image so that oops and WARN dumps display the crashing function=
's
> >> register-passed arguments with their names, types, and values.
> >>
> >> A new build-time tool (scripts/gen_paraminfo.c) parses DW_TAG_subprogr=
am
> >> and DW_TAG_formal_parameter entries from DWARF .debug_info, extracting
> >> parameter names and human-readable type strings. The resulting tables =
are
> >> stored in .rodata using the same two-phase link approach as lineinfo.
> >>
> >> At runtime, kallsyms_show_paraminfo() performs a binary search on the
> >> paraminfo tables, maps parameters to x86-64 calling convention registe=
rs
> >> (RDI, RSI, RDX, RCX, R8, R9), and prints each parameter's name, type,
> >> and value from pt_regs. If a parameter value matches the page fault
> >> address (CR2), it is highlighted with "<-- fault address".
> >>
> >> Integration at show_regs() means this works for both oops and WARN()
> >> automatically, since both paths provide full pt_regs at the exception
> >> point.
> >>
> >> Example output:
> >>
> >>   Function parameters (ext4_readdir):
> >>     file     (struct file *)         =3D 0xffff888123456000
> >>     ctx      (struct dir_context *)  =3D 0x0000000000001234  <-- fault=
 address
> >>
> >> Gated behind CONFIG_KALLSYMS_PARAMINFO (depends on CONFIG_KALLSYMS_LIN=
EINFO).
> >> Adds approximately 1-2 MB to the kernel image for ~58K functions.
> >>
> >> Assisted-by: Claude:claude-opus-4-6
> >> Signed-off-by: Sasha Levin <sashal@kernel.org>
> >
> >Nack.
> >
> >You asked claude to reinvent pahole and BTF and it did it
> >completely missing years of fine tuning that pahole does.
>
> Let's keep this on the technical side please.
>
> >dwarf cannot be trusted as-is. pahole converts it carefully
> >by analyzing optimized out arguments and dropping signatures
>
> Fair point about pahole and optimized-out args. The problem is that BTF d=
epends
> on BPF_SYSCALL, and the environments I care about can't enable either.

This is trivially fixable without reinventing pahole.
