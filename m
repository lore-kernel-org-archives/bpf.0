Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121D229A32D
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 14:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776435801; cv=pass; b=sxX6UwJvlR5eVwXFAzq62zyJQZvj/+Q1aJ4R9NZ2BNAiZAEBAlucP3/E7gdojA8uwYtFLGwQYXaen2dEkrXoves9eQK9P7iS/VHBEAwTEWC8nD+fZjlf0oK6bjJRaLAaeEF/3E6IEXtgmM/0kzGSUnrovd2F72X5lfqNbSb68NQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776435801; c=relaxed/simple;
	bh=zMzuR/G1qb7Em1PcFkr9hzhqdP2KvoqZqFUlSzMypSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r1HgUrXvsObGvPJQX5SDpthCi8lntrzuX5dggUSGmshmHmRNsbx7N3XECySJB0ABSA9pG/t6t9uFuXY4LN2M4MirRO2dwj+P9MIDA1On4tBb4QCxIkpwg3qbCrPeWsbe8C0gWW5ZMq2z/GzAITvLKYcmAH+zJgDKKFyCXt139bw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qg/4rwDS; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qg/4rwDS"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b9d9971d059so112874766b.2
        for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 07:23:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776435798; cv=none;
        d=google.com; s=arc-20240605;
        b=WyFVxkIHIkqaV8xn4jOdE1SA1b3sHoVeaG1OUe2I2RGni61qjN6O6eKAi27h5uGZol
         dUfDuttquUMPGL0jfXpDQE3kVcQW1IuGrmSkoE5RxduBpCFqYmlTngcgg/tCL5UikGFV
         TLeIeFBXFHLbFYtNm2a4yE/N8Apucng0WAhRVSoNW+l+uA6xKRZM94oTLx/ZMOCevXFN
         hh8hKlu+shrPwYMdhMnl8F6OuTTTm9QWj8d0dYiT9EY2YaU4W3iIxcjniPmPfJwckyqH
         zuKaA8fks89luHQMBHiwnvU/56Jis1rwyXEEg8dYhpXrjEskMCNDFMnFvlNZRfAptVs5
         /F1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qw47YsrmYc75ExdNxla+LXpcLBRU9NbH3e0/WJ1o+vc=;
        fh=7pQPbM1mTaKjUbZ75iTISJbipA72wUVZwkXXTYMxzFw=;
        b=QYAMNFV/l7//eZbyI/u6O2e8VSqEhQyXUzJtZhKk9yGUTXNS8LUBlYnAPkFBQRIXSr
         VXd2DOtjurUQ66WCAyGJOi/7h+epu/x5AsEskTDNzBV5N3adqt8RrXxvpjMiTGYG3O9z
         uNcZUm1AmC9wKiwYM9V9mDOwUmQgKcjSOa0NDuCr3n3AjShP1dV9yOofKbxHbBey5fZ9
         luWODxHkfFOujT6rsK+JHqws6P1Shq9jccd4V8Pr0tjIq/PGGr0ieYSSqsq57RoSR1hB
         v6ueXUtGFySS6tYr2PC5jcypE9VoCAlix5IrkRgJdIu0ku214s32pXl/16vAb890D9om
         Ec8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776435798; x=1777040598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qw47YsrmYc75ExdNxla+LXpcLBRU9NbH3e0/WJ1o+vc=;
        b=Qg/4rwDSnMZCnEQXfOcKOVkYWzcZDpz+TZVh0k8/iENI/WE7kcC+16+wMQi14zeyu/
         R5+9zGcT9RcrAKUc7tiVQqa2/HF2/xssmVDztQ01CXkVwwBsmGsRNyqblSI80RfSwtl0
         GdK2zYH95gZ8+hVziod60DIP5ACYPmTQOnUKEWdTkppGyzmTyISqbspCJVEwIDp76z5U
         9LWMq4l7ZOY/daD7lNUoGeL8ka1sE4s4s8Wm2eeiZ7x+D2s4qouboa21dGBZQ0ex1GKt
         3ra8oKqonsx7MWM4MMZPplu0fNA4AK6kBGhZmmcLAPuzDiAgujvVLorQArOxTeRNOd1U
         Nd/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776435798; x=1777040598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qw47YsrmYc75ExdNxla+LXpcLBRU9NbH3e0/WJ1o+vc=;
        b=ZDcbrd2r0RP3j6v5AytCjq2/JxxWKoOA3tSbfjrydDtIyhjPXEkkA7N1maDiYlstBv
         SQhD5WZkSuqHhggOg+MBFgZqRL+57k5HvgqBvt+0nVmvX0s1YpykLAaKXBZaVPUB3ZfL
         3v9PqVeXMPhtFtpLAuAph7Sfsaloa+dvNgYrr2sEOIaMQ/XbXrLcDq56Gs7hyqlgNcp5
         MuhE1mcttRQ3qs1Pvim/AarRh9p1FXO7lngFVivVDEXpnTWhXyxc8e7ku9fgFBQ0gEM0
         m4J+yiwm92adnUHoMaC5znh29mTEU2HIRPKoEp1XWAncD35OMvlNS/AcEjXsd+hQgYaY
         8c+A==
X-Gm-Message-State: AOJu0YwI6JpL7W1MhMuYloc6347xrQWGHiiYjrrqSYV7x0IAYc+0fQ8t
	NV3+KaJpR6tSEsaqneci6tHMjjVwpF5o0/6qyfTaP8Q6yIgqp8iXi8HzzVWl2ppkwnmAULnP4qO
	EssWvsm0cL4dkk8Q0Op2fSGld+0C5qsY=
X-Gm-Gg: AeBDiesO/qxsNxkbEOBzupuff28WdqGcOldQ/6qGQ/Oictga+vEnvvqDS7xNXH3ag8a
	PyDca08W+rnFT9V9GlvHw+RSg/3BpxTwto2RQ4cVqkSZqaDoKx26FSRnH+e8l6moKS8tHTqfwm/
	jFi+SrQqmVZO4kp3fxHHefo+UR/HHC7hhL/LEvgsq9sBvKE16d3tehJfXkMBGvW032FpO0QzfMg
	piw+t8en1nwx7YwHdaDg3pMnFwhj8E2hHsRp12oUUSxxleRf2nguWV4EBWDdAd3TcKERyv+CeQj
	7rLE5FjFqcOggkoequqUi7dvGpYE/1HQRg==
X-Received: by 2002:a17:906:99c2:b0:b98:2d0d:fc00 with SMTP id
 a640c23a62f3a-ba41a250074mr149298166b.24.1776435797970; Fri, 17 Apr 2026
 07:23:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260417103004.3552500-1-puranjay@kernel.org> <20260417112507.A99D7C19425@smtp.kernel.org>
In-Reply-To: <20260417112507.A99D7C19425@smtp.kernel.org>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Fri, 17 Apr 2026 15:23:02 +0100
X-Gm-Features: AQROBzBjH3Xtlm9dXz-oWmWwzS1lummXpMH-qG1SajuQtitrfYpntJXfyIUKcXg
Message-ID: <CANk7y0hjx36UvPnsdo4cmNaSNZEjmoH+KBHixdr0CA-ncaiw8w@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf, arm32: Reject BPF_PSEUDO_CALL in the JIT
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 17, 2026 at 12:25=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Sashiko AI review found 2 potential issue(s):
> - [High] The patch leaves the memory leak unpatched for BPF programs util=
izing callbacks (BPF_PSEUDO_FUNC).
> - [Low] The patch introduces a C90 'declaration after statement' violatio=
n that will cause build failures on stable backports.
> --
>
> commit 5b49d0ae3429d9aefefa73b4cf12e6c41845458c
> Author: Puranjay Mohan <puranjay@kernel.org>
>
> bpf, arm32: Reject BPF_PSEUDO_CALL in the JIT
>
> The ARM32 BPF JIT does not support subprograms. This patch rejects
> BPF_PSEUDO_CALL early in the JIT to prevent leaking a JIT binary
> allocation during the second pass in bpf_jit_subprogs().
>
> Link: https://lore.kernel.org/bpf/b63e9174-7a3d-4e22-8294-16df07a4af89@pe=
ngutronix.de
>
> > diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
> > index deeb8f292454b..91fef10e88bc4 100644
> > --- a/arch/arm/net/bpf_jit_32.c
> > +++ b/arch/arm/net/bpf_jit_32.c
> > @@ -2047,6 +2047,8 @@ static int build_insn(const struct bpf_insn *insn=
, struct jit_ctx *ctx)
> >       /* function call */
> >       case BPF_JMP | BPF_CALL:
> >       {
> > +             if (insn->src_reg =3D=3D BPF_PSEUDO_CALL)
> > +                     goto notyet;
> >               const s8 *r0 =3D bpf2a32[BPF_REG_0];
> >               const s8 *r1 =3D bpf2a32[BPF_REG_1];
> >               const s8 *r2 =3D bpf2a32[BPF_REG_2];
>
> Will this cause a build failure on older stable branches?
>
> This patch is a bugfix tagged for stable backports, but placing code befo=
re
> declarations violates the -Wdeclaration-after-statement rule enforced in
> kernels before 6.5. Should the check be moved below the local variable
> declarations?
>
> Also, does this leave the memory leak unpatched for programs utilizing
> callbacks like BPF_PSEUDO_FUNC?
>
> When a program uses a callback, the verifier creates a subprogram. During=
 the
> first JIT pass, the ARM32 JIT ignores insn->src_reg and compiles the
> instruction successfully as a 64-bit immediate load.
>
> Because the first pass succeeds, bpf_jit_subprogs() executes its second p=
ass,
> allocates a new binary, overwrites prog->bpf_func, and aborts with -ENOTS=
UPP,
> leaking the first allocation exactly as it did before this patch.
>
> Is an equivalent rejection needed for BPF_PSEUDO_FUNC in the
> BPF_LD | BPF_IMM | BPF_DW handler?

Yes, both reviews are correct, I will fix them in the next version.

Thanks
