Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A281E1A17
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 16:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782319757; cv=pass; b=spErG/k7FTrftupbt7kVlnuscEJz+t0OlNvdMdZHy7DWrhXVlSjnGTowaoN5ksx998pmfdJ36IznQOIs/lf8Ug3O4INoqqdkA3cQuJ2ZhQndJSDcATH5kRr8+mhclxuFXYOqQthd+iil6c7CGi8DzZddAweNJMbZp0SYRCRQuEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782319757; c=relaxed/simple;
	bh=EDnJSUveIwhgBIVZWUbAB3rg9JXHWQdsGT7dC/NtfiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YPXOBB6rtCq0W4X+iR0kiE7f4tQ0e8FBGW1y3lg3GYucwPm/Wi+/1rFK4qafbvth5f2CtlotUmBLiF23A7Z8/ukwBtweugXh9mmhS5eWrOgcdEcGnTV7La1r92G+TZmEEGWGyjnQdxxLrYUomwSM/w+q+0lxc4BUzAIniIpC/4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=inZOBpXS; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="inZOBpXS"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2c6bc87f4d5so5333355ad.1
        for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 09:49:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782319756; cv=none;
        d=google.com; s=arc-20240605;
        b=WpcM7hgyFzm217Z2kzciyzukRbn5UrI8w2mZ9RlHafbJ2VdCrGjxYHimAYn3Ay9Lle
         H+vssFQtHZsOmkT5a5v15F3EBOy0a7g/cNsFrvznu+GOfaYllLVdBypTpssreWDa0VYi
         CZmDHo9shGOmPxPksiY+2ov7MyThrqYWXAcD3k/HmXjfoUOqeU1GIJL+82KS0J1dE/EG
         OvmldgrTBVjvk3Z34xAPKfs165+PGQWNmL35wB0GGBxeCviipy/cUblqfPMUcPjaA4pg
         5ZisEalnL4V5lMN4WjkB1lVPGT4GALADkex697GNOuQ9mEfAe4O3SIMdz2/CGpX+CB0v
         Ajsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KrFR8w3YkfgIQ1ohAaiHSqBsF7yeysEVzQfn6K5QXtw=;
        fh=+QC29UjC2J+GJN3V1xCqyq3vUDVqtmteUbv12xBmqXM=;
        b=YJcb/WQJSVQD+XvIHnCR3axsCv0gkHk9p30Ux6RinVP+a9ro+CtyOD2QrAmGAvNbqi
         ST80zOj3BaKclggRhPVzbPKEaXoownG6vZ2SgBGLxojwQKzlrCPpQEYRmHHPdS5g8zSB
         DOxyDDT9J9AMqjV8TJw9ps5/19QE1LUSLD25osW6AJLN4CYVPjZps0lKS2A37Gn2v4cD
         F/DJ33SHY/DocEB7euBhRcN1EPibQITHsamea4XwoQJspdxvF/5mWez6wTlHVc0m+JD+
         34tKpS/El9DKClvuEMw0tyXpMm7Ia61Pi9Cmir9F46k510QZRJazu3oTUU0oZknx131I
         HMig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782319756; x=1782924556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KrFR8w3YkfgIQ1ohAaiHSqBsF7yeysEVzQfn6K5QXtw=;
        b=inZOBpXSQm54VZXYaHa5BP5Ogh4wspzxSHMfOxykZtYC8PMZWIMPjDUMD8Gq1emdvS
         7qB7InMUfJfgDnMToqKUnFNlEOTJFLO8iWPuNNXyjS85FyqdzBvK/rFUv4IKnwwWOdT9
         ovWhveAyFVLkPHnwcX0GbB6hhto0oAz18JVcZ2AgqWKE92Dbl+KQ5OGpl58jRHk5q0QF
         ubizhkXeU13rWl24svPqPge9JfETJnH4pzlUqkt+eV6uYBU27fQ9K3TrOvJd45L5LTaO
         aMlsXzKDq0OFHws7ajZDbFh69QUd38SVfuxDgLsdbjS8mDhRVLp+kj8cEpmHFWvOUdWk
         b+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782319756; x=1782924556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KrFR8w3YkfgIQ1ohAaiHSqBsF7yeysEVzQfn6K5QXtw=;
        b=pGUOtuFty+inCC11V55oT7Skpt4vCW7F3nAZ47ZPT3hWtdCxkJxdvUz572Zz0Flo92
         fv5eYI2F7fybiOckTkq6/9fWAOpX+ZZmL4fx7cf3aqjBq55v4y03ZshKrlagwEWHRRut
         jUSGDga8aJkMrZvLMgzDmf+Ve6xRTTZebZEg9Z6MTeDn5Ffh+cRpUzpWd507+G8qiR+U
         0hUiIQxIrLpnNmH+OUVl28h+ZG7IDDv43+VCuWF1nbCEcuivOTo190Ht/jnOtUga1LN/
         tdvL6b/8ulIivNeXDsF4g8fOHAS6c+URwaQ3ID0kqwV4ojGv9LlTuiWvc5UQuupdyw03
         DGCA==
X-Gm-Message-State: AOJu0YyJsfyE/gWqC3fe6D6eZ47eHwW1FLDl86SBpLdnh+7Cew49mnJN
	F/c6axO8WXnFrgEFJWS159C7D6doqEcznITMnJYFWX+53oNkIwNituXfwjFVyuomzTAle2RLF++
	Dt4uf6pUaE8lVEaSw6jV89rjnd+G4XRMrqA==
X-Gm-Gg: AfdE7clSPJiZaxlNimec0awS8z8Qx2YsFb95OjEWI75ESvqeW1cQZXUyZtKSisAQAla
	NVOylgiD5qO7fITpGOKYgMBPGgp+DEGaxpb5s/311l0ETr271v4E2crqRdOGk6KjOVAj3xirtbT
	emFqbIfZggUAPnzIRYHe998qxjdoovMH+OxT+04J3khjVyorcGuIDAIyv8DiDtEm1Ik1JRLFvnB
	sVVZO1R/Y/UzjQgVH3JREM1Mw3yHMmAbGUh2DQrUQ3mbfHoKWT0Pl27oNWSl/bFLHRMS2CRNLsG
	eXazusaAQNlM/qR+F0d8KxiOnofn7b1PU+jeY8KkbpCZPXHwSq9QsUAsSWVOKYUZVsU=
X-Received: by 2002:a17:902:e844:b0:2c7:9b17:6676 with SMTP id
 d9443c01a7336-2c79b176ad5mr130616685ad.23.1782319755881; Wed, 24 Jun 2026
 09:49:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEf4BzaxKLJAEaZR7VBjT5N_jeWVJ=bRviP19viGaSGQ=44dRg@mail.gmail.com>
 <178229582410.80761.16669701451820050202@digiscrypt.com>
In-Reply-To: <178229582410.80761.16669701451820050202@digiscrypt.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 24 Jun 2026 09:49:02 -0700
X-Gm-Features: AVVi8Cc8OA4qwd1jkt8Mar9AyFjtizixK_C30Oy4SEA8H6uwV8511mgAyUre1Zo
Message-ID: <CAEf4BzZMfPBgN5j_qW7MsyyXp7Mt12j21+qvH53086CULqU6kA@mail.gmail.com>
Subject: Re: [PATCH v2] libbpf: bounds-check float size in btf_dump_float_data()
To: Naveed Khan <naveed@digiscrypt.com>
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 24, 2026 at 3:10=E2=80=AFAM Naveed Khan <naveed@digiscrypt.com>=
 wrote:
>
> libbpf: bounds-check float size in btf_dump_float_data()
>
> btf_dump_float_data() copies t->size bytes from the object being dumped
> into a fixed-size on-stack buffer whenever the source data is not
> naturally aligned:
>
>         union float_data fl;
>         int sz =3D t->size;
>         ...
>         if (!ptr_is_aligned(d->btf, type_id, data)) {
>                 memcpy(&fl, data, sz);
>                 flp =3D &fl;
>         }
>
> sz comes straight from the BTF type and is never bounded.
> btf_validate_type() does not validate the size of a BTF_KIND_FLOAT type,
> and btf_dump_type_data_check_overflow() only bounds the *source* read
> against data_end, not the destination buffer. The switch on sz that
> rejects unsupported sizes runs only *after* the memcpy, so a BTF blob
> describing a FLOAT larger than the destination smashes the stack before
> the size is ever validated.
>
> Validate sz before the copy, mirroring btf_dump_int_data(). Use a fixed
> 16-byte aligned buffer as the destination rather than union float_data,
> whose size is architecture-dependent (sizeof(long double) is 12 on some
> 32-bit ABIs), so that valid 16-byte long double floats are always
> accepted.
>
> Fixes: 920d16af9b42 ("libbpf: BTF dumper support for typed data")
> Signed-off-by: Naveed Khan <naveed@digiscrypt.com>
> ---

hm, did you see my previous reply? doesn't seem like your patch
addresses my concerns

> >From 27941d119a3e9815906e787728bac54de9737539 Mon Sep 17 00:00:00 2001
> From: Naveed Khan <naveed@digiscrypt.com>
> Date: Wed, 24 Jun 2026 15:23:56 +0530
> Subject: [PATCH] libbpf: bounds-check float size in btf_dump_float_data()
>
> btf_dump_float_data() copies t->size bytes from the object being dumped
> into a fixed-size on-stack buffer whenever the source data is not
> naturally aligned:
>
>         union float_data fl;
>         int sz =3D t->size;
>         ...
>         if (!ptr_is_aligned(d->btf, type_id, data)) {
>                 memcpy(&fl, data, sz);
>                 flp =3D &fl;
>         }
>
> sz comes straight from the BTF type and is never bounded.
> btf_validate_type() does not validate the size of a BTF_KIND_FLOAT type,
> and btf_dump_type_data_check_overflow() only bounds the *source* read
> against data_end, not the destination buffer. The switch on sz that
> rejects unsupported sizes runs only *after* the memcpy, so a BTF blob
> describing a FLOAT larger than the destination smashes the stack before
> the size is ever validated.
>
> Validate sz before the copy, mirroring btf_dump_int_data(). Use a fixed
> 16-byte aligned buffer as the destination rather than union float_data,
> whose size is architecture-dependent (sizeof(long double) is 12 on some
> 32-bit ABIs), so that valid 16-byte long double floats are always
> accepted.
>
> Fixes: 920d16af9b42 ("libbpf: BTF dumper support for typed data")
> Signed-off-by: Naveed Khan <naveed@digiscrypt.com>
> ---
>  tools/lib/bpf/btf_dump.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> index cc1ba65bb6..dc26f3a160 100644
> --- a/tools/lib/bpf/btf_dump.c
> +++ b/tools/lib/bpf/btf_dump.c
> @@ -1980,13 +1980,18 @@ static int btf_dump_float_data(struct btf_dump *d=
,
>                                const void *data)
>  {
>         const union float_data *flp =3D data;
> -       union float_data fl;
> +       char buf[16] __attribute__((aligned(16)));
>         int sz =3D t->size;
>
> -       /* handle unaligned data; copy to local union */
> +       if (sz < 0 || sz > sizeof(buf)) {
> +               pr_warn("unexpected size %d for id [%u]\n", sz, type_id);
> +               return -EINVAL;
> +       }
> +
> +       /* handle unaligned data; copy to local buffer */
>         if (!ptr_is_aligned(d->btf, type_id, data)) {
> -               memcpy(&fl, data, sz);
> -               flp =3D &fl;
> +               memcpy(buf, data, sz);
> +               flp =3D (void *)buf;
>         }
>
>         switch (sz) {
> --
> 2.52.0
>
