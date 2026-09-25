Received: from mail-pj2-f21.google.com (mail-pj2-f21.google.com [74.125.227.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830EF3E172D
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 23:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.149
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790380026; cv=pass; b=stU7JCXOdtzwh8lfOOQwnBxxUwRgLyYokjw/Ill8GVyxQZ7vrc9wBONr3DzMc85rp775jwrlcHjlLtxmA1LQxWWwtwvLSv5EomzCepbYJj2VInt1Df9ni8dZi75rWV5oIGBSkab3TP/7tvpAZ05VphGc6Y1r2V0RNiBoEAg3kno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790380026; c=relaxed/simple;
	bh=VJzV4jvYX1LlFM3xdDwgAm8eJvpb4l6xSZcsKg5P8Lc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ikZMyn6l4wpUYSFmV1eVMGyW1YwR4M3cLczgVyTXcPFiHRuQj649abcx3p13/uWgKmCBKYswSbBlg5xn1nrfK8/FGOihln+MpCdtZtA505seQ2bqB7sxoxbXjoRDUYCcPHLngdzHGB/Rl7L0GP+tqxgNtjdq8jlV+bINJxvc4HU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=By3v+c8Z; arc=pass smtp.client-ip=74.125.227.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="By3v+c8Z"
Received: by mail-pj2-f21.google.com with SMTP id d9443c01a7336-2d747f0b25dso9163955ad.2
        for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 16:47:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790380022; cv=none;
        d=google.com; s=arc-20260327;
        b=EqrVwV6z3J1TEZqzd4sNizFjarIOhn39KB0M2DRUhWSA8fy6XTU1vHpzxvyvSUYwEt
         PARlRfRU3hKltmqc+IY6jLPUfNiRm4RvTc7H/8nzSPgtoq1GINsI+flcauA1SiC4xHj9
         DBw4O6O/HrtFUNgqwVx6XsyzGr9/PY6trxl2ovvpg+0fSvI4yZOF1ZJrXqPaINM8KvZd
         GxUQhLT2M9VXjGPjhiwcNC7XMA/XokaEl948quAg/w9qqwJqrEhDOgZ2WS5kR+bbtUBb
         Tn2Rg61zXuz81jdf3UrEUd+Kp1yYTATONdMvJ1zMKBPZpwNjwgKpzoGJB6ZM4qeDlQR/
         Mk8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2aUg+eQxFKglV/spDAEZ8/+C6O2N290OG3yhGVJAvUA=;
        fh=wgIe5w5lMKTPdmy0hZfL71yntEK8sWxyhaHUu+FFrlY=;
        b=TwAePDdbW8ry0sApmr/dFdXkQOd5nkOHCC+spCQgLesFEO78hAy5RylMPRsbJuWkV1
         eoc1heqxDNgJU4bfSOpYbMLgqs4Nkoh9OgPX9mum4ACj5YF7XMqQGLM3iYRLBliLwhAG
         VJ2Xeu2UNm9FgRBVkqqOm7YRTowckH9jk8o2d/I2YAL7Lhugg7r7VV8FmhH1e3c3lAZ1
         2xhIZExxWSlp2PAdtglImhg7HW+tCp+hMBGdQaPvEwLL7KHbpBjFbmXUtwwBMfsRmj3u
         vAmRaVDRrZ2LYAuxgM/XLKUKiBihGDpzIGS6F+hWmHcqV9fcZv7XhDHawwpf5bKH5+qJ
         iquQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790380022; x=1790984822; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2aUg+eQxFKglV/spDAEZ8/+C6O2N290OG3yhGVJAvUA=;
        b=By3v+c8ZaCGnhMulNYiRoirIXOVOTy5YBcxPAsbuz0yfJV9wjC7phPsoc5RmQPsyN+
         Ddx0T/kToFeFoFLnFbeefoc3BJU2jXP28Sx8vW2Q050JUZ6FLM8A7887fSvD2SZrFyax
         rSuqkAzyf+3q4mKx29x3VL/L9xEKG+87EQfegUiz2aTpiz1k/PawBwHdnD/dg4ESJYGD
         NK4FhMYg+2MwcdfpwrBOCtd/NUY6OgvfMY5qPXRa5ZhioEafTpHSjMDKhsBWzMns/PNG
         pYtdWEmYkDXTDtKnX+vxulmMhwmiUJMAoRTahc0ryjvwGdbaC/gyQW/hOLcFD1AXn4mr
         n6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790380022; x=1790984822;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2aUg+eQxFKglV/spDAEZ8/+C6O2N290OG3yhGVJAvUA=;
        b=WpI3Kco0RrYKCGdIBgjjl3zg5uWF09zqUSviHmBpGPhGZp/0pIQRQOht4pg9BmPalL
         Yfoz5+z+lYeg9G352JJSKaTaKc+Vj4BjF8mYdp37C9ea8aoAUz8a0RZRM5KTEgNV7g8+
         bE1PPDnFztga7TnKFgHVinrYCbxaTPkxoome5AKdBgP7ohpeOH819nvkDyjnXh2MX0zr
         JWSiPGX4J3mRnEcNN8noe/g6fyaAO95C55PUhmwMYG3gARXkeMj5WvPSU8ivBdR4rEfA
         /ItoVcUpuENBTcv1ZIxZGIzdTU1jOw00DFJOKT7+H5roxvNlkUanV6KB36P0wEXtzQzG
         awsQ==
X-Forwarded-Encrypted: i=1; AKwUvBz8wbGjEC2f6GjrPFft+v1jg1IQpVqWea2xpMAVm0pTNRZvBYHaWr5ws/Ga1c+uR4afBXA=@vger.kernel.org
X-Gm-Message-State: AFuF++kXElaFrzxeZp3fsTpmU+R7Tc8xvs5wjVtCVMbRDxP+vMBFbEGb
	dM1qx+cwHtmCGLShQcu2Ruyi7jEyoSAjUAko6NMP3FRean90jMTaiKccQRVPUy/KhfNtLEeX9IF
	EqwshahL87tYz1OjNRXHBDH7y0Q6nG9M=
X-Gm-Gg: AYBFou10gmRj2lKV0YxERLsHyKC6mPyCaDG2RMmtplpt12XOM/+H/jmvMj4QaBa+YcO
	jMVBgEjCSgczzuJ3j8dBDEJyydxTOURIhjFH8ndZNX9Z5ICRDYgPABv7qOfAlIVghl9rMDSMpxG
	2oNlmGfNX0upjkJZih5JBsoZgsfLc6zheU1tlJRz7syslIlGO6ftJ8CuBqDU8pQfmtxlRrISYOq
	TH17/YxDCbb8/CSViL0NOTFCv8jIr77ujKWt/YQvo1ldL0beJ9WKtUozXijtxAppCOopbXqaLGp
	pEK5+GNeEPP4YFLCDzLXbgBJri1yGMVK2JLPvocfc5saynUCc09MRBma1uiLyh/TiLYftp+JGZM
	qlDrtjlUiiLgX0Je/iLclG+eHmkSYwoHpot6BpQ==
X-Received: by 2002:a17:902:e750:b0:2df:81d0:7c3a with SMTP id
 d9443c01a7336-2df81d07e13mr60907675ad.17.1790380021673; Fri, 25 Sep 2026
 16:47:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925224631.1490488-1-andrii@kernel.org> <1133351c9a9af13d20566a2336f08bb37a799b28f616363a9171223551b4513b@mail.kernel.org>
In-Reply-To: <1133351c9a9af13d20566a2336f08bb37a799b28f616363a9171223551b4513b@mail.kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 25 Sep 2026 16:46:48 -0700
X-Gm-Features: AclHuK8XZhtqcelxAzXO2U-_fz60X4ZM35cLZTORVUyqBRnJ6GVQFp7Upxn1sm0
Message-ID: <CAEf4BzbG6byWUgozZ_-vZBb4iBVB2oijmQM3H2GTjBeL2VvyhA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: Fix static linking of externs placed
 in allocated sections
To: bot+bpf-ci@kernel.org
Cc: andrii@kernel.org, bpf@vger.kernel.org, kernel-team@meta.com, 
	ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org, 
	eddyz87@gmail.com, yonghong.song@linux.dev, mason@kernel.org, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 4:35=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
> > index 53f64a1a1f25..0eaf98b093f0 100644
> > --- a/tools/lib/bpf/linker.c
> > +++ b/tools/lib/bpf/linker.c
> > @@ -2159,7 +2159,10 @@ static int linker_append_elf_sym(struct bpf_link=
er *linker, struct src_obj *obj,
> >       dst_sym->st_name =3D name_off;
> >       dst_sym->st_info =3D sym->st_info;
> >       dst_sym->st_other =3D sym->st_other;
> > -     dst_sym->st_shndx =3D dst_sec ? dst_sec->sec_idx : sym->st_shndx;
> > +     if (sym_is_extern)
> > +             dst_sym->st_shndx =3D SHN_UNDEF;
> > +     else
> > +             dst_sym->st_shndx =3D dst_sec ? dst_sec->sec_idx : sym->s=
t_shndx;
> >       dst_sym->st_value =3D (src_sec ? src_sec->dst_off : 0) + sym->st_=
value;
> >       dst_sym->st_size =3D sym->st_size;
>
> Does this code leave st_value non-zero for unresolved externs in
> allocated sections?
>
> For an extern placed in an allocated section (.maps, .addr_space.N),
> src_sec is the object's real section. The extend_sec() call sets
> src_sec->dst_off =3D dst_align_sz, which is non-zero whenever an earlier
> object in the same link already contributed to that section.

regardless of whether that's a problem or not, setting st_value to
zero for SHN_UNDEF is not a bad idea, will update

>
> So for unresolved externs, the output symbol would be:
>
>   {st_shndx =3D SHN_UNDEF, st_value =3D dst_off (> 0), NOTYPE, GLOBAL}
>
> Won't linker_sanity_check_elf_symtab() reject this when the output is
> linked again?
>
> linker.c:linker_sanity_check_elf_symtab() {
>   ...
>   if (sym->st_shndx =3D=3D 0) {
>     if (sym_type !=3D STT_NOTYPE || sym_bind =3D=3D STB_LOCAL
>         || sym->st_value !=3D 0 || sym->st_size !=3D 0) {
>       pr_warn("ELF sym #%d is invalid extern symbol in %s\n", ...);
>       return -EINVAL;
>
> This check requires st_value =3D=3D 0 for SHN_UNDEF symbols.
>
> For example, if stage 1 links c.bpf.o (defines "long __arena c_val =3D 3;=
")
> followed by linked_arena1.bpf.o (defines a_val and has "extern long __are=
na
> b_val;"), linked_arena1's .addr_space.1 lands at dst_off 8. The output
> would have b_val as UNDEF with st_value 8. Stage 2 links that output with
> linked_arena2.bpf.o, and bpf_linker__add_file() fails in
> linker_sanity_check_elf() with "ELF sym is invalid extern symbol".
>
> The same issue affects extern maps when another object with map
> definitions comes first. The outcome depends on input order. With a
> single object in stage 1, dst_off is always 0, so the issue only shows up
> with multiple objects.
>
> Would setting st_value to 0 for externs address this? For example:
>
>   dst_sym->st_value =3D sym_is_extern ? 0 : (src_sec ? src_sec->dst_off :=
 0) + sym->st_value;
>
> This would match what Clang emits and pass the sanity check.
>
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/361995=
05247
