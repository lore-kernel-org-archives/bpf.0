Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.218.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793309750;
	b=aSyMWFwRnwtLleIZFBx38xr15ELJDI/Pmb2Kxh/Mfx5Yf//6fHG7+G34NBdCVtLdS5Sd
	 LvRE6w1arAr9Imw44CJHhkfz5FB6XE5SKEjWnIMBKwWc818Is6JHyqtYCrAeIIQoSrYOI
	 LdLzPKNHw97C3dV4oba+CaR6ZYJVjmT3zOJTifRKVW/5koub382WTsDq3XYrymwFEyaJn
	 Awp7sAhzNPt/1hZ0gPFCP8Yck3X9IOJgeGJUDw5RObwmdEQ34o717n8o3GpbcRg1eSVYe
	 RDmNKoliqCtEqfeZ9r0d0Vnj7eUnsez6jc2bkTPnb2dgsj88ZSHLZIyXnRy5JjInIMg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793309750;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=AjT67sODfv8LIA3zVwUGB//ZCy/sHbwEFOtaC99aW5g=;
	b=5bwcmq0PiMm+BJeZLDJ/2UpSwIFhtXEAaN9nZ+qYJUMZNQkQI5OXc1Nf3gd/61X7nIlf
	 wA+xIiWU5tUHK7yCMm6sVwsACN88gmhrLQ+UNduKCYgzj4A2vFBo8RT8jIW08JBruiZYi
	 +AJ2oeQSzxjcB3KhUQdemKibTxqUZGN4bdGhTaAR/ZndJakV5VwQtxNQPLG+JJZRMCHAa
	 GE6xrgbLgqhvhBJI8LX7I0mK/xSRfjpKloXY6I4eZP2emswrrzs19pugRaGnD60CWozqI
	 oldirWmXmcQxEzhKG5Vp+TVBmeopbjL0p03nvz+4jzLBswL9GpEDEPO2u0dcMGVWzjQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Ny4Qf79m;
	arc=fail smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0881606A31A
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 21:35:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0881606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Ny4Qf79m
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c3f04e0e65fso488766b.2
        for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 14:35:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793309748; cv=none;
        d=google.com; s=arc-20260327;
        b=QaJI8qd6uDKHHg7cUZugdJJMftYCuCEajx9vrKk33DHAe3hWjT9iHiEwyOXftLe8Fz
         PmPahpuCZG/MtXk22rX//mN+jEUrTHrwgmy68B2VYutFENkFCf9k491vvL/hcCaHmRts
         bjNB2DAl0GeemYMzamX6l8IIXoLy1KP37YreHWwMLJc622nxSm2KBES1UDjpjTUSdwsD
         4Dtg+5fk7+FyLM83AEIrkXuidIdmyspH0MmtYDjF/tmZB3TGsKtccz5PNcpOXhdrNmeS
         2q6NafKOXd3GdlXivCcwduYHIxDal8vExGQs8enxGUiON98bi8z7g/IbtEsY3sK2mAtu
         CLNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AjT67sODfv8LIA3zVwUGB//ZCy/sHbwEFOtaC99aW5g=;
        fh=1Z+TmVYU27QnLiVXu4BvKkiKLBjJhBQUzQ3PAn3ADMQ=;
        b=hpMWPDA74DsJml7zofnMTkZaOZqxtQ4d4lJPvRCzLYh6YEWaPmCcdAcXrE+4eQYIwI
         2aAcdcL8X5Y926WbElEfwmUeSTW21NlLXYg9vlq2+vmEHsN3eEAgq8ZJhjdvDcWKcqW6
         3LPr7SUl3CGemtildleBocjCtK6PDXWK82Y4AnJbKcT5uEkCrMRCoGn7ljFs6UkopFuI
         eTb2IWT5OEcyRDC5f2aNaVI1HwdygWzWHg6T/xsLyeX76DQuZjWhxhITWhWC+9Az01VJ
         vUc31JnY2GCuLxtKoiifhVqNdFEz0txabMfAkHm8MVoudfqWksPfvID/xH2v5VW3hMZ9
         P2AA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793309748; x=1793914548; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AjT67sODfv8LIA3zVwUGB//ZCy/sHbwEFOtaC99aW5g=;
        b=Ny4Qf79msA3Ol1Y6e8/IcUAH9yOvaHBe2q/r2VBC2ELpk56XQeNul05malBDOFT8ku
         3iNV5LUh1WN6OSi58GJtPL1CdzJ6Gfdq1EwPPwQTHQ+fJYrr4uuUNxUlmh+B6VBLkI3H
         ZEj0B1DaLGuydvsPOrmNnyN+V5M9uzXhIOuB8IAfuS4x7RzFZc8EHwvHkIbq2HZsSAXO
         f8K9v16/gbB/xNpURIL1Ixe+3ZCyFOiwul7kpsyeMIznZ8WtYjV+3pMV90juEncbUJ39
         jANFHK4YH+YJxQHzX5N4bA9Y7nUKExBRqIOMrQJ2r0F5nLrYhReYCpQZmLjrgHbgSrOi
         AU7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793309748; x=1793914548;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AjT67sODfv8LIA3zVwUGB//ZCy/sHbwEFOtaC99aW5g=;
        b=YDTICPJhdQthnGoM1YQOp61XC8b1da0WVuXka+ZNLSJXwHJjoXGUNYzwO61FOKw8hS
         eFLRyyUxpxBt/BaxnsjKyZUm+edKm32Jmua+2BFG35nBaX8xV0/kDon8D8DKf33uhBXw
         OVRbSS/OVOIHQTL+ZDdyysHxqyoOlOuFL+grdcY4kE0DFXwKeTQFcA4TUUgMlHgtsYIU
         S0cI6DQ4UiIBQY1EmDF/W1UaPPn6pgTeiE49bDvqEhghJ2DGBjAFgpd0yRA1YLsd5z5v
         3cFgqTznMQxDyNMwhmHO/ftra/b//rEgE9tgzmUqFY3PR4iIwpKdecAuLw3R+4unMDaO
         PiAA==
X-Forwarded-Encrypted: i=1; AKwUvBy7H9niKrkiWkdy54PTuylpS/IDHoD2Od7FX7BgbqMp7+zSoseI728ALhNnsATgSHamLb4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKpHmfZXgR24yf0wn7zYoIUAz28gGMX4+cApXcLkWGfgYVmUe+w
	zcP+8JVR5ohIKsOM/YDh9SSiS858eIoMymYNcEodcZgt8D5IN2ZkCU0IIDozvX2yWRynKR7SF01
	jLEMiprc5PjIFrdk0rBMaFhwAUh73p+Wq6r7YY/W6
X-Gm-Gg: AYBFou2Al42Y6mtAigc7jRfjbaYpBiwpVFcAm7Jf2CokOkBmz2MTXMSdxVHbYZeykLE
	IewhjxNpbXvUpK0oA7kB9xPFW2qaKpXCQrQp0JOG8pIum5Jvcy6wap7fjGCsRS1oHSn3HdFxrei
	5VeuYyeS+8QLeeRYXqFMuVISZ+IgecO53ObAcjKBT/p5A4toHPOnDfyIZt0z3RKe6bK88Gw8IUj
	+CV/ujYMemUIWW/LlprYNstWF2elA5ABCnN03edAdA3a3nxXOGlSfBbTFnctEwrrO62OqLIC3eJ
	SNHsDYO1GZ4PiyMw6VUf2c75uovhvZXH7rzw0gKrT6P0rOL2i0d4jH3tf634Yfua2MC4gRg6n5B
	tP7KAYTq2uKUW9+33mOZs9hgj5c8QEX50qfW4lh28aHw33EpTGH7GUdyN/Ti90NMCgmZfc6I=
X-Received: by 2002:a17:907:805:b0:c3f:a728:b437 with SMTP id
 a640c23a62f3a-c4ca7ac07eemr32967066b.45.1793309747666; Thu, 29 Oct 2026
 14:35:47 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023001603.560210-8-wusamuel@google.com> <20261023001603.560210-12-wusamuel@google.com>
 <at8dNNb4vwovNZcZ@krava> <CAG2KctpMEuK5OJSedSFshNMSwOqe1g87m2ZOKBhn=Z5iCA45Aw@mail.gmail.com>
 <20261028140127.7bfeab46@pumpkin>
In-Reply-To: <20261028140127.7bfeab46@pumpkin>
From: Samuel Wu <wusamuel@google.com>
Date: Thu, 29 Oct 2026 14:35:36 -0700
X-Gm-Features: AclHuK84Rx0Zv6bqYRMUgm-AA1OaD1X9ao32PPa3PHwJ78sUr0bqSyZbITTizzQ
Message-ID: <CAG2Kctra0GYjkzggB0cdMxPK-b9U9x-m+gR6E8goAYvhsNXEdA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 4/6] libbpf: Resolve typeless ksyms via
 KALLSYMS_QUERY ioctl
To: David Laight <david.laight.linux@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 7:01=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Tue, 27 Oct 2026 15:07:44 -0700
> Samuel Wu <wusamuel@google.com> wrote:
>
> > On Mon, Oct 26, 2026 at 2:28=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> =
wrote:
> > >
> > > On Thu, Oct 22, 2026 at 05:16:05PM -0700, Samuel Wu wrote:
> > >
> > > SNIP
> > >
> > > > +static int bpf_object__query_ksyms(struct bpf_object *obj)
> > > > +{
> > > > +     struct kallsyms_query q;
> > > > +     struct extern_desc *ext;
> > > > +     int err =3D 0;
> > > > +     int fd;
> > > > +     int i;
> > > > +
> > > > +     fd =3D open("/proc/kallsyms", O_RDONLY | O_CLOEXEC);
> > > > +     if (fd < 0)
> > > > +             return -errno;
> > > > +
> > > > +     for (i =3D 0; i < obj->nr_extern; i++) {
> > > > +             ext =3D &obj->externs[i];
> > > > +             if (ext->type !=3D EXT_KSYM || ext->ksym.type_id)
> > > > +                     continue;
> > > > +
> > > > +             q =3D (struct kallsyms_query){
> > > > +                     .size =3D sizeof(q),
> > > > +                     .query_flags =3D KALLSYMS_QUERY_BY_SYMBOL,
> > > > +                     .sym_name_addr =3D ptr_to_u64(ext->name),
> > > > +             };
> > > > +
> > > > +                     err =3D -errno;
> > > > +                     if (err =3D=3D -ENOENT) {
> > > > +                             err =3D 0;
> > > > +                             continue;
> > > > +                     }
> > > > +                     if (err =3D=3D -EADDRNOTAVAIL)
> > > > +                             pr_warn("extern (ksym) '%s': resoluti=
on is ambiguous\n",
> > > > +                                     ext->name);
> > > > +                     break;
> > > > +             }
> > > > +             ext->is_set =3D true;
> > > > +             ext->ksym.addr =3D q.sym_addr;
> > > > +             pr_debug("extern (ksym) '%s': resolved in kernel to 0=
x%llx\n",
> > > > +                      ext->name, ext->ksym.addr);
> > > > +     }
> > > > +     close(fd);
> > > > +     return err;
> > > > +}
> > > > +
> > > > +static int bpf_object__resolve_typeless_ksyms(struct bpf_object *o=
bj)
> > > >  {
> > > > +     int err;
> > > > +
> > > > +     err =3D bpf_object__query_ksyms(obj);
> > >
> > > hi,
> > > we could also add similar support for libbpf_available_kallsyms_parse=
 and
> > > probably in some other places like bpf_get_ksyms.. which makes me thi=
nk it
> > > could be useful to have KALLSYMS_QUERY support for multiple symbols
> > >
> > > thanks,
> > > jirka
> > >
> >
> > Thanks for lookiing over this Jiri!
> >
> > Using KALLSYMS_QUERY for libbpf_available_kallsyms_parse() would
> > theoretically by O(m*log(n)) instead of O(n*log(m)), where m is the
> > number of tracefs symbols, and n is lines in kallsyms, with n >> m.
> > But AFAICT, libbpf_available_kallsyms_parse() would only be called in
> > pre-6.5 kernels, for kernels without commit 83f74441 (ftrace: Show all
> > functions with addresses in available_filter_functions_addrs); so this
> > ioctl could never be called.
>
> Isn't that code also O(n*log(m)) ?

Yes, sorry maybe I wasn't clear before, but the current code is
O(n*log(m)), and the ioctl approach would be better since it's m
lookups of O(log(n)) for vmlinux symbols, where n >> m. However, this
is a red herring because that path only runs on pre-6.5 kernels, which
won't have this ioctl.

> I've got a patch (I might send it after the merge window) that changes
> one of the ftrace functions to look up every symbol by name, not just
> when only asked to look up one.
> It can also use the 'callback' function to detect duplicates.
> That should be massively faster - especially with my ~18 fold improvement
> (also waiting for the merge window to end before posting a new
> (not much changed) version).

Excellent, I'll keep an eye out for it!

> Does look the the code could do with getting the 'symbol name table index=
'
> for the symbol so that it can read the entries sequentially from that
> point onwards.
>
> David
>
> >
> > And regarding bpf_get_ksyms(), it loads all traceable functions and
> > needs the full syms table, so a /proc/kallsyms should fits better.
> >
> > I did profile a slightly different form of querying multiple symbols
> > at once [1], but didn't see much benefit. struct kallsyms_query is
> > extensible via size and query_flags, so we can update in the future as
> > needed.
> >
> > [1]: https://lore.kernel.org/all/CAG2KctozPSev+EXSpHitM3JWfjufQaEjsPJHS=
_1HJ1wSm7sJ1w@mail.gmail.com/
> >
> > [...]
> >
>
