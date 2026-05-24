Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863611B4138
	for <bpf@vger.kernel.org>; Sun, 24 May 2026 09:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779615501; cv=pass; b=VPl9HS+2oHJFcte/CSTJfKlEpIiG1keYEZw65TRlznYx/D7L9ptaL4eIeIzqJd4TRLIe3euQAaI+WTC/mrfPm3acXCAEwERwPebny6xxBtgfOx/wKr/mJR5Fn2GH+cxGYsRt/2zuV5WtQWNGv77zHSMhGbWUG8Huo5DgnCJOIHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779615501; c=relaxed/simple;
	bh=TmPcun4FqmDKsTHgJokOi7PfAIsbFqtxtyvbfYMC3TY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lRVwNtYmhxC2qPY9hQGeoJkzAaHtG6hI1T3CGepgsDfpyoH3mlPaH1/BdfdqAeMiawLha7XH4zJ/BFhZnPJJHO7PQCRvul8YK3DRT3qqOgEfrNV8+1VOmCnwhyAplR3dc5hKer/u7QvNyV5Oo+l8eOUMUUjxVVh+Pzn42XTfguc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GklOT1wA; arc=pass smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GklOT1wA"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4903fd19957so26987105e9.1
        for <bpf@vger.kernel.org>; Sun, 24 May 2026 02:38:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779615499; cv=none;
        d=google.com; s=arc-20240605;
        b=VmknXNv/Y8UBQejt/Bb0UUYDE8CoOmo0+nhZt46U2hdvX1cyrVDzmWjERLSzIU0jcU
         1HN2CDxGzYFOS4qVqb8h78o37sIFLTXyILBjLMYRBmhogan4q/48HFeIGn06oDK/geCq
         TL+73G/p2pu7DiO2Elm2+FxXUmFRkU/qraqICRoC9ItjOuHJnRuC8J2NJEWkHhPOdwCI
         h6fjNfAUrTV69WNNLNfyx26QALhfheD22YxSBXdsXEi6buennD/+crXBL3jOTBLBGS3H
         z2GHaB2YiW+nBg/YBoqjnxHXD0K2FdEd2zTjdQa3GZlEml+RhqaSzMDZiM0X15iWU4uR
         cy+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OJbsaeR/rgcSGFXakVpHnIFOTszW2zZ6It8h8bScqQg=;
        fh=U6/rBK8LShhmqvAfRojSxdfd3qw7bz4NRtMn9CQ7NnM=;
        b=iEKfmm2VMIcmF1j4XunQaD2DH6fXM/eEtUak4VK/8w5tJTwsXJiGj5NpUX5BDkR+Wl
         nhxBCD4zRZLmjim+/OTRKNAqdlayyg+OT9U+KffWCxOtxRfjV31N40FeCly3Tl+xMSP7
         uHuwZsAWMDKZUFni0kCP2KI1xkY2Bx3y066xcerDe+ONDmDejOf0xxUgCUyx0mX7Qw0d
         0MumCy9/wjE0TCtT2ozo0dMMWZlYsBTtDAXp2oRD29xuoD8dxBZUQIvSk2MuXgTuMNuo
         I7GDtZxipWa6S9hknwvdMEhTS/huuuntvhRCl49NN3OscHd1cPQmQgzBKvQdRZ0gxM9B
         GE1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779615499; x=1780220299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OJbsaeR/rgcSGFXakVpHnIFOTszW2zZ6It8h8bScqQg=;
        b=GklOT1wAp5oJgE6YtAB/Zw6n1p1IpJt1V2VEj+aL80a3tGEuqBN8187+xJNrsCQTJC
         EjnDCPAHZsijnDHW3+zfNoc2OWkbxkvis5OcIS+4f7qcgfUrn/Kyy63nUwnfkjl9Ear8
         6j7JVF9nQL2mEVjPXhSB8FBETOW2qjG2MkQMCG8zlBYCGqjba2F75lAPI9WsdaRo1Qfu
         6pqKpgUY1206eEBkv6X6usyhnI7e5fzGT1LJz3Wh6jhfuTexSxL5c3RlTGVAoKuTg02p
         VHYRZa7e9xaPJQJs0xwdzC08a3n4cio0j8HeZCFLzZd4fPG6OSV67dhVqfG3ueBlJ6cI
         fleg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779615499; x=1780220299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OJbsaeR/rgcSGFXakVpHnIFOTszW2zZ6It8h8bScqQg=;
        b=RtR8Pep4FYPTFQaKcWeF5y4x/6pmlF02cqgkz4PeZ3VeNOgJLZtgwwLsI0DutY2MtP
         3VmWX28F4tcXuvHErQGmH1WM2BiXs8ikeGzVrDtCugUuatB/HEzSuoAjGzQ3o8LznxGb
         9HfIbl6KW9OQ+v7wGGqdSz2EwE7WRUK01hgu3DLgbNAT6oKnCLAFg4ynUTRHFg8DJkxZ
         wQHIDQR3XgH3QKrlkk8i5DjDpQ5edSA76FMn0akOTjGfl5/uOGKVgOX852ojmj5/WOEG
         NLNNEajGIs2RyaxP9oahz909lQIi6xMJIVJsKCm9xe4D8HU/VbetUId8dw6+h8Us4j38
         iwyA==
X-Forwarded-Encrypted: i=1; AFNElJ8TLGNn3t4J24xCbAT79ZjeTlquyM13ZvtCKdmQY6Al5+onkCvSfEQMUGF4a88L/+2UkTU=@vger.kernel.org
X-Gm-Message-State: AOJu0YztS+QIRR80naXe/+eY0ttfLEfiyQyfbItvfhJ7IrS1Fl/zdNfD
	qWH6qUZAssGuvCm9FmP6HKtnH3cujOIKPLKT1KIkzdnxHwoqUMaaLkSVNISLflNIQP6d5amB55L
	DSPOEeI/suBZUu567si70OqluF6xPEM8y0Hepi2gSYw==
X-Gm-Gg: Acq92OHSGE/9DYtKXownM5QDrwL6ogCkus8V0Aavf8FhTfShxW6PnE+AuDeK6zQPaWA
	U1VgCS/RNSfp+HB6tjrfwRiAQIt9ZOEsKHfH7drJbuw2wH+F4Z4m6sQaC43IsvIEGEpjUe/BcrQ
	He1476gyEOhjicXPLYgLPgV5rmWsXuSA2ZqiBiw4xu1irjstimFB04ch2ya3woKTv4UYYk94CuN
	sCqhZgtjqDtCWdXrsqJcG08dwlFxbhm1sRDJD5rZpbrasjy4wBUkoTDOOkO6gbKcrwhPz+r8Pe3
	QcGK5e/TkQCWP2qvn7M5tWLSYpyrT7j4TFoD+F8KOat7l+o9GhTuYev7WFEWKgmw3bc5CA==
X-Received: by 2002:a05:600c:3547:b0:48a:7b55:12a6 with SMTP id
 5b1f17b1804b1-4904224b05emr178761545e9.0.1779615498516; Sun, 24 May 2026
 02:38:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260524082944.10625-1-chensong_2000@126.com> <20260524091000.8C1D11F00A3F@smtp.kernel.org>
In-Reply-To: <20260524091000.8C1D11F00A3F@smtp.kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 24 May 2026 11:38:06 +0200
X-Gm-Features: AVHnY4KpkC-a7cfuZ6fFvjGjqPEgUFQ45hdg634lu0Qrzxqw07o4-eoCNmvY8-0
Message-ID: <CAADnVQKKeZYD6yOrLF8AG2kLLG81+LAVU4HTR2XWA1jR5wUkhA@mail.gmail.com>
Subject: Re: [PATCH v3] kernel/bpf/btf.c: reject to register duplicated kfunc
To: sashiko-reviews@lists.linux.dev
Cc: Song Chen <chensong_2000@126.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 24, 2026 at 11:10=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] The duplicate kfunc check incorrectly searches raw BTF data for =
any function, rejecting kfunc registration if any unrelated static or globa=
l function shares the name.
> --
>
> commit 3dd29707347d5a7d6755ecd640562865f115a75b
> Author: Song Chen <chensong_2000@126.com>
> kernel/bpf/btf.c: reject to register duplicated kfunc
>
> This commit adds a check during kfunc registration to search for duplicat=
ed
> kfunc names in both vmlinux and loaded modules. It prints an error and
> returns -EINVAL if a duplicate name is found.
>
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index a62d785812076..5fc2b4ca23470 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
>
> [ ... ]
>
> > @@ -8684,6 +8684,47 @@ static int btf_check_iter_kfuncs(struct btf *btf=
, const char *func_name,
> >       return 0;
> >  }
> >
> > +static int btf_check_kfunc_name(struct btf *btf, const char *func_name=
, u32 kind)
> > +{
> > +#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
> > +     struct btf_module *btf_mod, *tmp;
> > +#endif
> > +     s32 id;
> > +     int ret =3D 0;
> > +
> > +     if (!btf_is_module(btf))
> > +             goto out;
> > +
> > +     id =3D btf_find_by_name_kind(bpf_get_btf_vmlinux(),
> > +                                     func_name, kind);
> > +     if (id >=3D 0) {
>
> [Severity: High]
> Does this logic incorrectly reject kfuncs that happen to share a name wit=
h
> unrelated internal functions?
>
> btf_find_by_name_kind() searches the entire raw BTF data for any function
> with the matching name and BTF_KIND_FUNC. It does not check if the found
> function is actually a registered kfunc.
>
> If a module attempts to register a legitimate kfunc, couldn't the registr=
ation
> be unconditionally rejected if its name matches an unrelated static or gl=
obal
> function in vmlinux or another loaded module?
>
> Would it be safer to verify if the matching function ID is actually regis=
tered
> as a kfunc, perhaps by consulting btf->kfunc_set_tab?

It sounds like a valid suggestion, but AI is missing
that kfuncs are global functions and vmlinux + all modules
is one global namespace, so btf_find_by_name_kind()
is not only enough, but it's a good check to do,
since modules shouldn't be able to register a kfunc
with the same name as the existing global function.
It's arguable for static functions.
Technically a kfunc in a module that matches static func
in vmlinux is ok-ish, but it's a sign of poor name choice.
So good to reject as well, so the code is fine as-is.
No need to respin.
