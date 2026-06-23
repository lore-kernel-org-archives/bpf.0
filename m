Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D43390C85
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 22:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782254511; cv=pass; b=ijyu+p3B02w9djD8SgyXHJBXUcOZJIElWAqy27zoxTV/8So8SHLQ6VJutsAqo4bDlMcnFaeKS3P00PH3j0SOTAvQ0szxyXOL4+NdNH2OLFkpEwm4jmbCsfLc7ZjLZFVd0ipQHhMSXAP0+6xdmCAMqCNcS/s6aPgvJL0mlhz1sX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782254511; c=relaxed/simple;
	bh=soLQGPwr2c20lUfAI4ad57Az8Rz3HH/aJVeIfGJALkk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T8iuZwqvSytSw3RWQS5BPIbVBtgxXw2/HscSqFVhyGZP6p9FUCgD8d+FRNlfwr6tVLx5gVrVPyQgO4mq1on8TS3iOsm01TP7FosHRX4KxfqseAhTFkjVhbMdyF0SBo+US3/sXTgtEVCp+Rpmg3rJmVivtiOD3dDDwWTr6cDDTH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NS0wxFni; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NS0wxFni"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7fe8bc0a01bso4870127b3.1
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 15:41:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782254509; cv=none;
        d=google.com; s=arc-20240605;
        b=AR/+wtTCPf6lndyO3zLcCHhY5IjrE3qLjDSmJVqqBJstp7OoyJA4hMfe3i0P/bcpla
         OREuaLSSIYEh/ni+Tcdl/K/CPkTtm7o2aY/PS/dj/lYSpHFSWkG7fqyP3HUDHHHHD5tW
         5yV0ksZZRA+BdHfLwGhOV4QovfNGIulMOHgrjR7wiI8T2SEcRzDb9w9j5ilf0JVbn3wH
         Y3moR+TQyg79GHSzVAlAXQoRDBSRoUsIw33mZtIJtDKBdSRBe6P+jxUCRQTRsvh8e6JK
         3+j3bW7gRHvhV3X9TEPlXyqbcIoz5yq+6QvKcRHfVrm/GS6Ht96RspjO/xkQO025khb/
         sUqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jAGeEZmnsjWX0hms7jmjKIy+6+2pgzHwJvr4zj2qgIk=;
        fh=CF9paNkmUPRynj9CAyYxGK1ISE6SckLy4rjMEGufe80=;
        b=NUscHNx0KV60RN9p3JuWZOeKokayikovYwl737Wc62/bd3M2e/ytALy4gjD+KX2Nb1
         lRoL/xg21B0QOFJ28Z7WDEy4JYyhRy06qxRIqtIfkDJm0uCF9cRxCiJ5OjiJdL3JLAcq
         1iY8Z0R6EYgtpaKtVgQl56DxVF/7uO2MD6nEE84pW84LIqrt1Bw4lXsrTj4ZB85LzxsG
         B8VJ/UvqNkQWRpmLmxuQgRwGSnTaxI+oUylXagnBASfMXF181T8gy4Lh3YDxZ4LmhnaW
         RmQ8Of9l1utyQes53CrfDDY3WRqbrQVyJETW3Il+r7vh1IT9UKffG9jCouHt2+ChGEmy
         hBvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782254509; x=1782859309; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jAGeEZmnsjWX0hms7jmjKIy+6+2pgzHwJvr4zj2qgIk=;
        b=NS0wxFni95qZEfBmWb5YKN+Y2ltDuH7aYSI+YRArmEcDpxQKjnJxIdsfIMr71VlUgF
         4aA5Pc02CNmoMAQ3yqOK9FZFsY3H+ANiiGBhOySjFrpyZiWAKXY37pWxHICZxXwrSxkQ
         Z8x9qVA3bIXS3kYzMoAI2rKLZh2hmu2oty5SBPL0uihdFuxcE0apulufZ0N2OgMcf7Yw
         IvCGVf2W/BgVnxIOjc+CJQZgxC1GUegKwondn5WLL7/DgY36PjgAHdiQKVaMIhrJi857
         37pkaynWVn53R37aa6tfEAZOv4kXUhlkL9EDUGkfjlLfOTjy2nE9t+h2gUXya6jxylTj
         7h+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782254509; x=1782859309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jAGeEZmnsjWX0hms7jmjKIy+6+2pgzHwJvr4zj2qgIk=;
        b=ILVvl8CVcBV531Dukw6I17I+ZcftDZDZNm+ozURV5nLarcjPxwIIeuCMiBU1loZZqZ
         f/A/WLycZobdyNkp9RJtvTpM6BHb8n5I67fyLcsWojuZ4d4zo6wIuG9KewmBH+NbHEOg
         uOVbLoIAWxE0N4Vxz2MgyScpCQ05RHj3kzZpRgAwCL1u7ynbcYn6eojv3tX/LdHNjGQp
         sLQSb+Cmv9VsHhPJWvM2jfiLf9/2LSKUqDKReLpSSN0VRyJQXUvzDCOCGztmodTO7PoD
         ZpX8MWslYiBMZMayH8/LejT/XgQfieFF3zX5IC7keMfwsKMRaXEYITMK+rX7ntIr+FVm
         W2kg==
X-Forwarded-Encrypted: i=1; AHgh+RqCxU+0yI0GWpRRF0OvQ5RZWQW9LQSqWz2Pj35Nxis8Xo1v1EAbJYQDy+R1XXSYlcyFHg0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+HiyXpUEEi8mz00OgeJ5ZpgDoA0/HLsWoH9443bB3T++MXqu/
	CxWj33KfTBE/AdhVTMLv3vw3VDmn1DSVgEAneREuUz+Yh0e3agfptxiPbT63YlcTFiR7g/yyRaB
	nK1jm1qkhiYjAMBqcrewGowlfC5ZB1ISfWbj0
X-Gm-Gg: AfdE7cm97dyTRwYDlYEQFIW9jDaU1kK+acQbX3+9a3InrOJKJbIDxYOyyO0CHQskF+z
	IBIdWxqtsP8MA1K52N4eO+OwM0iWLRtAMYNSwE9/CJyhtblUC5t1VQsUuZI07tyIWWpyFWYUh90
	RvTcsa6JZ0m36wKFACq3JWHUD7mRXC/gyNBcDNJrnCtaipSoHwAicGCUFWnCv65jj8UW10asHPI
	h3Hm3dXOdJAlb2iHn3QnWLp0UiyTpK97ZiRJltPelwUFBdbTHP+Ml3jXVysvUzgUH8Lfzd1zTqB
	pS8+srPJ/YoR
X-Received: by 2002:a05:690c:3705:b0:7c7:5111:5ee1 with SMTP id
 00721157ae682-807ef05acf7mr9868217b3.26.1782254509418; Tue, 23 Jun 2026
 15:41:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1782197377.git.chenyy23@mails.tsinghua.edu.cn>
 <703a2cbfeb17ae707fa4a003b795c5326cc0abb8.1782197377.git.chenyy23@mails.tsinghua.edu.cn>
 <20260623175111.60F761F000E9@smtp.kernel.org>
In-Reply-To: <20260623175111.60F761F000E9@smtp.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 23 Jun 2026 15:41:36 -0700
X-Gm-Features: AVVi8Cec7cFVv1FF8R5GRl1xYjWOl9PIIv4i0xy-Ury4tbYTOhCK-P6LigvfSzE
Message-ID: <CAMB2axMN6UWE8G_GEQ6S2RE0ajiti+uTa+6OZY=HCMZUp-mrKA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Reject MEM_ALLOC BTF accesses past
 object bounds
To: sashiko-reviews@lists.linux.dev
Cc: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 10:58=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] btf_struct_ids_match() hardcodes `is_alloc=3Dfalse`, bypassing t=
he MEM_ALLOC bounds protection and allowing out-of-bounds kfunc accesses.
> --
>
> commit ea4066197ea8dc72df56252849c8752b81c506d6
> Author: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
>
> bpf: Reject MEM_ALLOC BTF accesses past object bounds
>
> This patch modifies the BTF struct walk logic to reject memory accesses p=
ast
> the object bounds when dealing with MEM_ALLOC objects. It disables the
> trailing flexible array relaxation for these allocated objects, keeping
> verifier-approved BTF accesses strictly within the bytes provided by the
> allocation kfunc.
>
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index 15ae7c43f594b..3e68af9c1a5eb 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
>
> [ ... ]
>
> > @@ -7441,7 +7445,7 @@ bool btf_struct_ids_match(struct bpf_verifier_log=
 *log,
> >       type =3D btf_type_by_id(btf, id);
> >       if (!type)
> >               return false;
> > -     err =3D btf_struct_walk(log, btf, type, off, 1, &id, &flag, NULL)=
;
> > +     err =3D btf_struct_walk(log, btf, type, off, 1, &id, &flag, NULL,=
 false);
>
> [Severity: High]
> This isn't a bug introduced by this patch, but hardcoding false for the
> is_alloc parameter here completely bypasses the newly introduced strict
> bounds check for MEM_ALLOC types during struct matching.
>
> Can this allow a BPF program to obtain a pointer to unallocated slab memo=
ry
> and pass it to a kernel kfunc or store it in a map kptr?
>
> For example, in kernel/bpf/verifier.c:check_kfunc_args(), it calls
> btf_struct_ids_match() with reg->var_off.value without conveying that
> the register possesses the MEM_ALLOC flag:
>
> kernel/bpf/verifier.c:check_kfunc_args() {
>         ...
>         struct_same =3D btf_struct_ids_match(&env->log, reg_btf, reg_ref_=
id,
>                                            reg->var_off.value, meta->btf,
>                                            ref_id, strict_type_match);
>         ...
> }
>
> A similar path exists in map_kptr_match_type() when storing into
> unreferenced kptrs (where strict is false).
>
> Does btf_struct_ids_match() need a way to know if the register type is
> MEM_ALLOC so it can properly apply the bounds protection here as well?
>
> >       if (err !=3D WALK_STRUCT)
> >               return false;
> >
>

Sashiko has a valid point. While hardcoding is_alloc=3Dfalse in
btf_struct_ids_match() will likely not introduce triggerable bugs, it
is logically incorrect and fragile. I think it will need to come from
btf_struct_ids_match() callers.

> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1782197377.=
git.chenyy23@mails.tsinghua.edu.cn?part=3D1
>
