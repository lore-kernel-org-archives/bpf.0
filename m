Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BCD4C8FEF
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 17:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780594214; cv=pass; b=ink0eipMDuyPS2tXVJjMyB7iKV2UdAyLf1zr7wMdEiMaTK4YIIo14xI1BrvtOeKgk+ixVwp81WGywb0vnhnJiru019TLzGU6V/jS1XDehGV7VlF3wAnm2z7BnoCLfulWaOXwbfsiRK4gYWYn5sZLwIhYXNhba/+pdaz/vA5Ux7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780594214; c=relaxed/simple;
	bh=m+4QLcA28bp5G0HKUjL3/lDC/CIvcXD0Vo0dOKDuzgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VrbXxtHBeAC1ZrI+JId+yJjstaXixQalF1o32C2QLi1c990y8zRIFnr9xgAseBfa0tYmjxY+wYatRoewyCyThAmbc9GClrl2Z4cjNZ5Ojc7eUn9JbtSf84TTTnFGNOMjqmGXgTsbBy/VBWHdSdE5A6jDCO+Y5wFq8L2TfJxgdTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r6HAiALK; arc=pass smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r6HAiALK"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4906869f0cbso12269675e9.1
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 10:30:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780594210; cv=none;
        d=google.com; s=arc-20240605;
        b=jJrMQQ1S5b0hWeUVX8fSDaNzJvP3fjCZG1In5Cf+Kf6PtaH8PKwwPbVM5ItDx2G9IB
         E4hI5PLY6AEXJ+2m3Ah3QVTrG4sC5aThanRhO5onfKGFxNjvVfYrcEYTixmnmImsnNHe
         HgJHzXgOQ3C4pXuyoieFs+TuYZRxRIEE/EjSS7RJQwKIN/Wyu+wJZVqxU8A+oK0mDjkI
         eUtzbWLbIp9AC5AHO1yGzrAnnnBrP2SR9HFxm6NJ01hfLygi6OweXLLQSy708j377cuw
         dOMAnbBHB2GUrAXmRRJs/dH4XQpDMy3hFkzcSNB2L88nIaTCU8eFnjd00lHEo9pmm61Y
         GULQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Iy+vz6DUwfjeEDVCsMRZnS+pvi9yyebM3FFxNTQM6/c=;
        fh=8E2a9nb4XWPtZedhoPzjq1EVgt9o/epcEFTaOlA80KU=;
        b=i55SW+Us0CKJqiDZ2lb6IPRUPk/gT/Q5ncqvRDbixdTkOZQnlNbRpGhfGFwbVNzi7A
         Z8ih5OfOr6IGDxUYZo8Jv1mTPWPI59l+PX0pJGi6otmz6S04ARySUWeXxjgJCfnSGxR/
         zYRDg/OjVscpO2nRtnsQofmu3DTjr6dASL9+TWx1OosaIGS/b52avNwh6FOjBRx8DAf7
         NJIm5w/UhdzRa8QSzDAMyW3ETyxdxMEL1hGfwkyUiogMVsqCcoRHmE1d+iAcWSksdx3j
         SAX50f/vNjrisBKvw8nyOyrzLKtCglhHQxvyP0mEh1E2TGiY/1KchZfbQ32ChiRHQonC
         koeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780594210; x=1781199010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iy+vz6DUwfjeEDVCsMRZnS+pvi9yyebM3FFxNTQM6/c=;
        b=r6HAiALKx+tOh8XLLh5b+XDuKYv/0ogE0HuYRXFcG44m7QXO7LfLi05KP5Njq/C8z2
         iqzRTVPmltIymxPh0gAGNiWAdE/jK0tWNgVGXuR2QQNRzSfknnacab5/p7LUHMZpzPi+
         ZDpkNRbO5US2MXGrQwX4soxFHbRVtusrHWQCS3VB2ygPxKSKfgTLjOXOg7wk22+pMeDx
         Cd0VT3bnSi/cXSF2pFGckTyj2BsSnJZKA1E7urbrSZERf6w1oWgz1naWVe6zEZEs80CY
         uQEy/fuFZU3P1+7J3FpIFvJdctQg4svIRj4VtOTmiZvU4y+11j2UhIHNNY08sFJCgEzp
         3R+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780594210; x=1781199010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Iy+vz6DUwfjeEDVCsMRZnS+pvi9yyebM3FFxNTQM6/c=;
        b=CEvaEyycr4VDztMzoO0GVZpYKweXfAUXbO3rGE+lLLOgzOqyep670ZiVup8xJ+m9/i
         yiW1N2uk/uEuXcCJwLCjwp99Q91gSEbyfkgnua59P4joh7GrUY037Pp9+mIfC3sqXVL8
         jvBoxTEtUHQeclCKjuEFxhQTb+3p01eaVSs6U12fPCN2A6+P/sgEaqxKfg5ItXHKzDkZ
         /7Z1kg7+LTtu6gp9n+AW0PUqVWalEUk6+FgFyBsvCgkUr6WseBx6qG5PW0TNC8GBffTL
         htgSnlujksF9rae8hJYrm7IhEVWVh9MNpM7y51NBUogBNilhZmvlnXQR2dIE7LuvFpA5
         oWLA==
X-Forwarded-Encrypted: i=1; AFNElJ94Uxo5VCRYSkssgLsOjv/9yChNwuYkVAZcbTcI+AAq57emXG5Wtjotm+pccHEGVZhmgcg=@vger.kernel.org
X-Gm-Message-State: AOJu0YztDC0vd4YO2MMWNT2BuILZRBii6cfMqg3vJggH3jLuuqc+hdEC
	DWSj8Y8CX2XIknZtU18gwvleDeUYeB3o3ey3o8EVdbBe91TVseejbIrDrO9U2dBfiawCFbDlrV9
	REJWoZDwsf/3VMgBVgi6dvwQOKTdeUrt+9cWv
X-Gm-Gg: Acq92OH2zJzW39mGiAuq/cn9zhWMoeLwe9Z4IG/N8cXktVB9AXxlHeyQbqGDKxFZkAd
	ilIsfIBMDiUHwxN/U3JEea//PZCIlLB3bzrW5iWb7USaTSxkgMb5RQWLV2p5bTdm7q70JQLEq+w
	TNUnDb/JaIT9M1+Srw/KxvOv6F14fvJ66EQRtN+/wFl4DLDdhEiBHNoR/qoMdY2DC6KNsUfNzCW
	4/nuL971NG83+D47MXwuduBisbXzMlYkq6peMhAhTvkHaus+kLB8yjse9MfgDdBObUzQUEOAs+m
	GcUX61pek7LsiNDfW2Q+oNE/QTESNKcbHZLdD5E9jYp6iM0mQ1zhuw5E9ueCEAVc2PXHyZymVHs
	kzTwkWs23fHd/4vdrakHqjIJ6dbo1+o+O0A==
X-Received: by 2002:a05:600c:c48e:b0:490:625e:bb68 with SMTP id
 5b1f17b1804b1-490b5eb7369mr136430945e9.3.1780594210178; Thu, 04 Jun 2026
 10:30:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413-kasan-v1-2-1a5831230821@bootlin.com> <20260425050557.827F3C2BCB2@smtp.kernel.org>
 <DJ094TM6SLCC.2FU5ZV435P1UK@bootlin.com> <CAADnVQ+u=pCMcB1=K_WQ3Ae5ML92of+DA1Z-sKRhHq2KoUJbnw@mail.gmail.com>
 <DJ0FMRLUKG6Z.3QLENZVQRK0VL@bootlin.com>
In-Reply-To: <DJ0FMRLUKG6Z.3QLENZVQRK0VL@bootlin.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 4 Jun 2026 10:29:58 -0700
X-Gm-Features: AVVi8CeMl-Jp0vf2YN2r8DUHxEgd4USimJ3GXXd1JeYMdxnMuga2ac4trc1sZ7U
Message-ID: <CAADnVQKgm3CN8BvGL0SSDmoKgokdSbg_DeSzf84NkZHSCz-=Jg@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 2/8] bpf: mark instructions accessing program stack
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: sashiko@lists.linux.dev, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 10:14=E2=80=AFAM Alexis Lothor=C3=A9
<alexis.lothore@bootlin.com> wrote:
>
> On Thu Jun 4, 2026 at 6:24 PM CEST, Alexei Starovoitov wrote:
> > On Thu, Jun 4, 2026 at 5:23=E2=80=AFAM Alexis Lothor=C3=A9
> > <alexis.lothore@bootlin.com> wrote:
> >>
> >> On Sat Apr 25, 2026 at 7:05 AM CEST, sashiko-bot wrote:
> >>
> >> [...]
> >>
> >> >>  #define LR_FRAMENO_BITS     3
> >> >>  #define LR_SPI_BITS 6
> >> > [ ... ]
> >> >> @@ -6493,6 +6498,8 @@ static int check_mem_access(struct bpf_verifi=
er_env *env, int insn_idx, u32 regn
> >> >>              else
> >> >>                      err =3D check_stack_write(env, regno, off, siz=
e,
> >> >>                                              value_regno, insn_idx)=
;
> >> >> +
> >> >> +            mark_insn_accesses_stack(env, insn_idx);
> >> >
> >> > Global subprograms are verified independently of their call sites, a=
nd pointer
> >> > arguments are tracked as PTR_TO_MEM rather than PTR_TO_STACK. Inside=
 the
> >> > subprogram, check_mem_access() evaluates loads and stores under the
> >> > PTR_TO_MEM branch, which does not invoke mark_insn_accesses_stack().
> >> >
> >> > If a BPF caller dynamically passes a pointer to its stack as an argu=
ment to
> >> > the global subprogram, will the JIT-compiled global subprogram execu=
te with
> >> > KASAN checks enabled for those accesses?
> >> >
> >> > Does this erroneously monitor the BPF stack, bypassing the intended
> >> > suppression mechanism?
> >>
> >> After having thought about this one for quite some time, I see no
> >> simple way to correctly distinguish stack accesses hidden behing a
> >> PTR_TO_MEM passed to a global subprog, as those are verified separatel=
y.
> >>
> >> I can either:
> >> 1. skip PTR_TO_MEM memory instrumentation when we are in global
> >> subprograms, at the risk of missing instrumentation on passed memory
> >> accesses that _need_ to be instrumented
> >> 2. systematically instrument passed PTR_TO_MEM memory accesses in glob=
al
> >> subprog, at the risk of inserting unneeded instrumentation when the
> >> passed memory comes in fact from caller memory.
> >>
> >> I then propose to be conservative and apply 2:  the only downside I ca=
n
> >> think of is that a few alwasy-passing kasan checks will be inserted, b=
ut
> >> we are at least sure not to miss any instrumentation.
> >
> > Isn't it the other way around? Replacing LDX with asan_load() will
> > check stack access, but it doesn't have shadow memory behind it?
> > Or you mean to assume kasan_vmalloc and vmalloced_stack kconfig?
>
> Ah yes, my bad, I did not state it explicitely, but my point above
> indeed assumes that we are with CONFIG_KASAN_VMALLOC and
> CONFIG_VMAP_STACK

ok, then it's an ok path forward. Better than option 1,
since skipping all of PTR_TO_MEM in global subprogs would leave a big gap.
