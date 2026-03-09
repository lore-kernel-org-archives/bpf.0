Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F9427467F
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 18:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773082413; cv=pass; b=SBNcHyjkotkuAfJIwJ16Bx4Zl2P3se1DWdhec2BgnWB6zV/VHqcPL7mB5dcdZ/5SRIFBMZa9vf4VOPfLES4JvyVWhvYurv6ay4BZsBx7BkjZDhIuzUlSyjZ+tvscw9BtyWTyFg2BNRQqEHy8n2RDJ7OedVdbkFgOP0PFAhqTi6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773082413; c=relaxed/simple;
	bh=V6KxNuMLm6ZzWLbYWQAguNF+8tLcLMIeMaYNO5joh6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lTJ+IdGFQfZd86vFWmjRsmxZihkPPfiK/rzqCguzNmSn7vNeC2ZHCLCjrt7ValbZZKJ1wKXc0EQ7Q+qTrjF0KqisGh900JKPH0fRVhntYWOFMZIW9zCERFeQTkD8waVqbeLLoDXsETyRkdnsDAK6ZJMPsRqvLzSXQjGiqEwavos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jDjZeQIl; arc=pass smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jDjZeQIl"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-89a14be4733so87636686d6.2
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 11:53:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773082411; cv=none;
        d=google.com; s=arc-20240605;
        b=PcURPPxXRaJ97RH27yWnGZYQafAZU8ZaFxh2XlF4SYGxIUP1T/aNGjkMfGlmWUlDjz
         BPRIe46XfUJJKQqxkI88QAt9fE7c8yZW4E+GrTaFR3gV3/jSQJ3qRrfWfQR9TDdFyV/u
         5VsylKJivCDp6K3OUNDGN/vGK9dJv+NbdZYPlJ8uw9ccXJtFEVK36DCiZR8/Z7ja/Qih
         0ITVfdry2GHolSwbwyreCzxAeTFJHCypveHNC+sXMtfMyYTRcxb9KQhGtmXF1Y65JTNT
         KDJF1BiexEzJB+mLOuZH6B4Op3cQLfCMpvakOIiFOd7R/rhzzU85eoHNuBAKuMt/T9DQ
         Xf4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=73elTE7gXOHd2nqfwAGnB/hPm3mFOxh2FFR+H0T0CEA=;
        fh=wuoBM2iG6RygDo0LeZeO4sLItrBYgH+73WXlfO0/nAU=;
        b=jLBJ/MAIHBmUluYcE2xvybjGDjhocIe1wlG/M3EGuU7gFgjheba875g4XBscYcCcql
         eP0j1D5n67MGarJz9OokXoMJDRAdr4bS5RS4B75XCrpevl75zgCGRVk3AfG+NEzKR1gh
         fKyXIPpmOCvo24XLefhPY0FKL8q3rNEIrcygXdTpmFBpxf/s79ENE+4B2uSsy8l6OvPT
         iamhVzDzYRGzF9uqtPWK7h9/ghGr7/CjDjc1SegDLlNV8bg3o0MuLllwk55Q9rLsDI/5
         mx9wDuPyO54g8xVu/+EwESOAm+vwNoR00p7ViRQTQ11UraMx2G3TYT3V5JN66btzboyn
         /bEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773082411; x=1773687211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=73elTE7gXOHd2nqfwAGnB/hPm3mFOxh2FFR+H0T0CEA=;
        b=jDjZeQIlhnWU/zOFM1PjJkIzl2M8H0js8SJmv74c3AxXC/mvD6OQoQVr7NU5HeCpk6
         j9tgR38rO+JRFLtccb06Af+Gh+5DGi8knoy3s+2c7yWgoI/tK4GdHcdlcLqWhIuE+JDF
         m8c46zX/ptfHZg/fkuweNOPx4zZCMimfzll8K0xxqku+ZVcJ3NBvzq47D697qeDjFeut
         XUBbSzU8ZRagTAa9MibNq4iqQsWrv4RFnThT/n3MmYlWemQE+OklMvsg22gchGqB3Yth
         qQyfeC8K6brcdKOi5Pi2lW3qg9r9bONvTLetUAJ97aheU64wGbffLrnjKqcnwXtDZYGa
         qJgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773082411; x=1773687211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=73elTE7gXOHd2nqfwAGnB/hPm3mFOxh2FFR+H0T0CEA=;
        b=YnIttoQareCwCW/wBok9f6Yf0Zz79l2Fen6I5GwyIrW2sJj+X3Caneg1aXAVNF39Ht
         oxloWsbAUzMQRLGrV1N5uLv65IjeeauojB1vKTh7b5qhfuAKE+2iQCdZEg1cYo6n2quQ
         KSGgdNsCV/LpS7tRTnzW1T9um3KXcVO968IiPcoD9Flzz82qo9ZrAWVN7ylFfCXP363t
         U40wHPC6XctUXMKUC/EIkSy2quhXj8/DilrwoY5NZgrnc67MpHEfs8zEtEU3rbjKoN5d
         1upae0Va6qk4cxbMlcYWZTHgo6GWRGLN3j1Ctpm6b4ezNzeF3vr059Ww/CZZNDqXvP8P
         1vMQ==
X-Gm-Message-State: AOJu0Yyl+T9Hx8OK6vf2KTHx4v/HLtz8iGpjTuVmz5ihhOuX8vBSXX8+
	5dK6fdFOy3XOYmiKzFdEzTkHB05ZOghVQRPMKNPIuBVx02WeS30eV38ZEMxwlh6cMtynqBDPq0t
	sAPxkBoS2m8OBDHzf3TWYnB0JtYfUWh0=
X-Gm-Gg: ATEYQzyh+J4tmENpOhiL1JqfBPUZhorWCUyTnWC5P5vsLgbEPSk1mUUV28aBOwoLjqP
	WB7QfHKHO99DsrCqlWyD/HsTwUVueBGaJqy6FjuLbnOkMvE7XwDgHOmirinMD4ADnSxuGMKrBqF
	+jelLXXe7BHHC5yZAw4Ejpc87S+fI0FysIdhXtqD3LHnNbtFTu/1oOcFUMsvZFAszEF/cCcccjX
	crlNe3AgdRN0YPLYB6GxPFS3MI9RuEhahJnrA71akBVFCgDt+u2HGPXZ8tljxdK2q0s1McczciZ
	trCCT3U=
X-Received: by 2002:ad4:5d4c:0:b0:89a:994:973e with SMTP id
 6a1803df08f44-89a30adb186mr202414976d6.46.1773082410800; Mon, 09 Mar 2026
 11:53:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306190855.937198-1-qguanni@gmail.com> <20260306190855.937198-2-qguanni@gmail.com>
 <87cy1cn9qh.fsf@gmail.com>
In-Reply-To: <87cy1cn9qh.fsf@gmail.com>
From: Guanni Qu <qguanni@gmail.com>
Date: Mon, 9 Mar 2026 11:53:18 -0700
X-Gm-Features: AaiRm52cb2pSRI7zi23xteHmsmvcnfPB602GH3HMGkDwefiAg_NpM75VZ6l1U8o
Message-ID: <CAFzOa14nFdFTZHQ2Xmz-Mvcnk-0k=mxs0TqxgMQbKEg_qLJ+Qg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] bpf: Fix undefined behavior in interpreter
 sdiv/smod for INT_MIN
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, ast@kernel.org, 
	andrii@kernel.org, lkp@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

You're right, casting to u32 before negating avoids the UB entirely
without needing a special case for S32_MIN. Will send v3 with that
simplification. Thanks!

On Mon, Mar 9, 2026 at 11:22=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> Jenny Guanni Qu <qguanni@gmail.com> writes:
>
> > The BPF interpreter's signed 32-bit division and modulo handlers use
> > the kernel abs() macro on s32 operands. The abs() macro documentation
> > (include/linux/math.h) explicitly states the result is undefined when
> > the input is the type minimum. When DST contains S32_MIN (0x80000000),
> > abs((s32)DST) triggers undefined behavior and returns S32_MIN unchanged
> > on arm64/x86. This value is then sign-extended to u64 as
> > 0xFFFFFFFF80000000, causing do_div() to compute the wrong result.
> >
> > The verifier's abstract interpretation (scalar32_min_max_sdiv) computes
> > the mathematically correct result for range tracking, creating a
> > verifier/interpreter mismatch that can be exploited for out-of-bounds
> > map value access.
> >
> > Introduce __safe_abs32() which handles S32_MIN correctly and replace
> > all 8 abs((s32)...) call sites in the interpreter's sdiv32/smod32
> > handlers.
> >
> > Fixes: ec0e2da95f72 ("bpf: Support new signed div/mod instructions.")
> > Signed-off-by: Jenny Guanni Qu <qguanni@gmail.com>
> > ---
> >  kernel/bpf/core.c | 23 ++++++++++++++---------
> >  1 file changed, 14 insertions(+), 9 deletions(-)
> >
> > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > index 3ece2da55625..663b9af6d19b 100644
> > --- a/kernel/bpf/core.c
> > +++ b/kernel/bpf/core.c
> > @@ -16,7 +16,6 @@
> >   * Andi Kleen - Fix a few bad bugs and races.
> >   * Kris Katterjohn - Added many additional checks in bpf_check_classic=
()
> >   */
> > -
> >  #include <uapi/linux/btf.h>
> >  #include <crypto/sha1.h>
> >  #include <linux/filter.h>
> > @@ -1736,6 +1735,12 @@ bool bpf_opcode_in_insntable(u8 code)
> >  }
> >
> >  #ifndef CONFIG_BPF_JIT_ALWAYS_ON
> > +/* Safe absolute value for s32 - abs() is undefined for S32_MIN */
> > +static inline u32 __safe_abs32(s32 x)
> > +{
> > +     return x >=3D 0 ? (u32)x : x =3D=3D S32_MIN ? (u32)S32_MIN : (u32=
)-x;
> can we write it as x >=3D 0 ? (u32)x : -(u32)x; ?
> By casting to u32 first, the negation operates in unsigned arithmetic
> where overflow does not happen =E2=80=94 it wraps.
> Please correct me if I'm wrong.
> > +}
> > +
> >  /**
> >   *   ___bpf_prog_run - run eBPF program on a given context
> >   *   @regs: is the array of MAX_BPF_EXT_REG eBPF pseudo-registers
> > @@ -1900,8 +1905,8 @@ static u64 ___bpf_prog_run(u64 *regs, const struc=
t bpf_insn *insn)
> >                       DST =3D do_div(AX, (u32) SRC);
> >                       break;
> >               case 1:
> > -                     AX =3D abs((s32)DST);
> > -                     AX =3D do_div(AX, abs((s32)SRC));
> > +                     AX =3D __safe_abs32((s32)DST);
> > +                     AX =3D do_div(AX, __safe_abs32((s32)SRC));
> >                       if ((s32)DST < 0)
> >                               DST =3D (u32)-AX;
> >                       else
> > @@ -1928,8 +1933,8 @@ static u64 ___bpf_prog_run(u64 *regs, const struc=
t bpf_insn *insn)
> >                       DST =3D do_div(AX, (u32) IMM);
> >                       break;
> >               case 1:
> > -                     AX =3D abs((s32)DST);
> > -                     AX =3D do_div(AX, abs((s32)IMM));
> > +                     AX =3D __safe_abs32((s32)DST);
> > +                     AX =3D do_div(AX, __safe_abs32((s32)IMM));
> >                       if ((s32)DST < 0)
> >                               DST =3D (u32)-AX;
> >                       else
> > @@ -1955,8 +1960,8 @@ static u64 ___bpf_prog_run(u64 *regs, const struc=
t bpf_insn *insn)
> >                       DST =3D (u32) AX;
> >                       break;
> >               case 1:
> > -                     AX =3D abs((s32)DST);
> > -                     do_div(AX, abs((s32)SRC));
> > +                     AX =3D __safe_abs32((s32)DST);
> > +                     do_div(AX, __safe_abs32((s32)SRC));
> >                       if (((s32)DST < 0) =3D=3D ((s32)SRC < 0))
> >                               DST =3D (u32)AX;
> >                       else
> > @@ -1982,8 +1987,8 @@ static u64 ___bpf_prog_run(u64 *regs, const struc=
t bpf_insn *insn)
> >                       DST =3D (u32) AX;
> >                       break;
> >               case 1:
> > -                     AX =3D abs((s32)DST);
> > -                     do_div(AX, abs((s32)IMM));
> > +                     AX =3D __safe_abs32((s32)DST);
> > +                     do_div(AX, __safe_abs32((s32)IMM));
> >                       if (((s32)DST < 0) =3D=3D ((s32)IMM < 0))
> >                               DST =3D (u32)AX;
> >                       else
> > --
> > 2.34.1
