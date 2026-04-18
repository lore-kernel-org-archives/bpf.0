Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8F529AAF3
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 20:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776544526; cv=pass; b=TUJR+tOfNOfLOJdqgz38WqbGi2ULrUKQgreD2DMlr0juSzc6d7IXJumM7GODntehy8D9171YybbgkgtwlB9kuHRPJiPYUDolpoKv5dUpyX8jiE4iUcMOZE0UsvCKFQjeRBz0XbDzi1zBcgdHuMUkC5LJU4J8AVBaENrXvGlgkEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776544526; c=relaxed/simple;
	bh=ddY40nerMOGiy2obCVU74bBWLOYhBAtp8dWA0lZJlCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qmjR7Qe810/FOfMDSZ9fKZjQmda+Q9P9TtciL4FgXmalnhWY9Tx2GMVQ5Ab10ftY1dQIlSiiIAt6uTGYijJBNYNX8wrdPZWmsondo7e2stgnL9h6r4hw4izM9Mi5ufXWYimYHxwKc9z8uD0XU+2DeDx1QVJD66G2/USdkGI50UU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N9BHzw36; arc=pass smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9BHzw36"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-43d70c30767so1579903f8f.0
        for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 13:35:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776544524; cv=none;
        d=google.com; s=arc-20240605;
        b=YpBw3Eh/ZJ7a6hl5wyr9GVL/KaWefzjBrXKyewv/1mlxWxebPkDBrfEDUu02Y7sxV2
         HHaBx/czQPkVNgmsiZigAS7LmnrdFoTyjM+Fkxug5PHU5epZZqFq/w5z1f4TIwu3cRVH
         96o+jlgRMSpJ4uT2/RGQSjjKe0jTVaIJuVhBu9GpqMUYJn704qQZq5i5v/YIufYFfJno
         35KgzGtzDHMN29iLqHeCnIlKJo0byrbHQrZ/gy0C7A2qaAjqHcyUe2JnCbBfPzPOFotq
         psHSnNkCRQedGXck5kx6dY5+SmfZ+KuzfqAJU/OpUVBjdlAdsiMwHs/kAtuxGcKM2fNC
         UXRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gA6/qC3I22utPvICxA7yoeIbXFjRb2Lz3SXP6oyKczQ=;
        fh=7pQPbM1mTaKjUbZ75iTISJbipA72wUVZwkXXTYMxzFw=;
        b=ezVdbD1CSjZa6fQ6U1IEdcGFUJ5hHoqIZtrngDEeO0yoEZCmdr4yPfS1rqW10NA90s
         P9USpmjzK6ZX5Kylwe0Ox+iF37eFJ3Mb0IQaTnB0dpKPol9FZuh1eKkvID3ft487zeEb
         UbfQtjXfRjCYVhXFzMy00fbmDfOJ3E8Xrp2xV405Vy58PN47wrehHfgl4L+7gZ2Lafax
         /rUXZOTXy44EErniOCzV5DsMYBYME88jAxQ1C5w6pKAITybqaTwtPpYfdhSE+JcwTHcg
         R4DAImJ22yIj+gs9sUpX0ctQ9efDWRGeuSnJ484uMK1H6HNay6BLoUY9GolHGQx+1HRf
         PMDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776544524; x=1777149324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gA6/qC3I22utPvICxA7yoeIbXFjRb2Lz3SXP6oyKczQ=;
        b=N9BHzw36alicdaaDD9qMa38MfAaAHMRX0fKUpPmsYokIkd60AT1KrbPfekRHqR1iFo
         /B42rBVHXj+tzvAGPBAUzAsOEpAoXqd2TVWqoUlB3+oO2xn/e8JYrUVrOWyTl5pTIR/o
         EDQJMBUP42KTknQn6atUwj/tgGBdJHf/FcELHZFDWIggB+cCJjNQtWhlGGGAr1bPcLXX
         WJoP9HFBuTaFttTppXo0Jv54+4ysf7m7mK5DpNtI7GNNFuAOCnyPCK/IiuYP7nT+5dHf
         KzOKMHpxx1iNi16kdqJ5ZORq8dhZ6FOyRMgsfxgBaloQMAZzxHVe0EMHOBrpvP3ViiSp
         zTfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776544524; x=1777149324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gA6/qC3I22utPvICxA7yoeIbXFjRb2Lz3SXP6oyKczQ=;
        b=SyZvqv/H6KGfNDhnXdGfQOij3f+XZarUkcQkPFJcAvYMaQ+6Yj/G3j5B3KrjP/ACVf
         Bu3ILoTte9VDd6TAmtqa3++Ea4kWV3mN7ucuaKhKtNROQK0kftJE5dkEZ0nM+o66t2uf
         ic9S9P75lZTvx/K+IRtAe/HQpLuuRu1Rq/7b0trSAoGtRKU0uyKSiL7/NMNoTdbyYq+O
         M8qs/wvvvJvTOviiPw53g4Des3KhA1FVS0GVlsfJcXUkcaAZ1E6C8zl0k6/gfhlNhF+7
         /+XZqghEyWDk9ScO4XkWe/BZt4Y0Zdd3zBZUXjwTiFr9g83ruIJofTshrh2Jqj6t5NTT
         cTmg==
X-Gm-Message-State: AOJu0Yzwd+lwn9Bnpu9omnfZbUysJfodraGJPe2HZy8OQ7bGzN+o4e7I
	Id097ZYeYSqGD5LWL7d8TBeTYLxSaZ3+7u96NF5X/8PjvDeJf9aCzcv5DMwK7F8JpCR5RLNY9Xc
	BbCX0C9J+59tYhUPagJRnmkpUNjdWhAJMJ0zlB3yKAxqi
X-Gm-Gg: AeBDiesAVAxnqdLRN7iMQT6dyv2Y7FW3vRnJi+PYr1FPfNy45nhI6B2UWOnbUZGT+Ow
	819bYoxdX7J7CVCO9r2mk8q/SClM3YQgxqKc/6jKaZ2OZJ/WF5/syASx97KiXKXTgPI7Yb3nyx4
	bqS2YMzbM5TesxyZc6KM6fcCKKDwbLHiacIoZZEwskSa3V0xtR/2Ymg5bbeJTBdGh1ag3cmxJTJ
	YFadQWNhXcFsE2CkrYSRnchTa01Drphrie3DeTylb4qxxHuOSy4RTw8Ix/aAEwvUryvr67sYj3d
	46qyCR9DWeuD2MxiOuwtlb+xP+6BH/qjYR3NlJMlRVR58fRucH/blMocAfa+vDVk/w+N3Zprqzv
	7iUwsUO+3iScLEIgBpqLrlMat9dlDhFAW5WmKMW2tl9T0uUTEyX0=
X-Received: by 2002:a5d:64e5:0:b0:43d:7606:5a47 with SMTP id
 ffacd0b85a97d-43fe3f358a5mr11579550f8f.2.1776544523619; Sat, 18 Apr 2026
 13:35:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260418171701.610025-3-memxor@gmail.com> <20260418180642.14D95C19424@smtp.kernel.org>
In-Reply-To: <20260418180642.14D95C19424@smtp.kernel.org>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sat, 18 Apr 2026 21:34:45 +0100
X-Gm-Features: AQROBzBJQZijfK8thBE_ks-0Wf_4ARb0VikANfnwPf_KRKEL7Stt8g5mV5ir04U
Message-ID: <CAP01T76Z7oBJ2TyUOPqaKZnJogqYhrdZDMwi_q1N8-woaauz=g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/4] bpf: Introduce __bpf_kfunc_mark_deprecated
 annotation
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 18 Apr 2026 at 19:06, <sashiko-bot@kernel.org> wrote:
>
> Sashiko AI review found 1 potential issue(s):
> - [Medium] Programs loaded without BTF will silently bypass deprecation w=
arnings.
> --
>
> commit 90e501a1948d112dbb3b96a16249f1f76f84b290
> Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>
> bpf: Introduce __bpf_kfunc_mark_deprecated annotation
>
> This commit introduces the __bpf_kfunc_mark_deprecated macro to annotate
> deprecated kfuncs with a replacement. It applies this annotation to exist=
ing
> impl-suffixed kfuncs and modifies the verifier to emit warnings when thes=
e
> deprecated kfuncs are used.
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
>
> [ ... ]
>
> > @@ -12987,6 +12987,45 @@ static int check_return_code(struct bpf_verifi=
er_env *env, int regno, const char
> >  static int process_bpf_exit_full(struct bpf_verifier_env *env,
> >                                bool *do_print_state, bool exception_exi=
t);
> >
> > +static void warn_for_deprecated_kfuncs(struct bpf_verifier_env *env,
> > +                                    struct bpf_kfunc_call_arg_meta *me=
ta,
> > +                                    int insn_idx, s16 offset)
> > +{
> > +     const struct bpf_line_info *linfo;
> > +     const char *replacement;
> > +     const struct btf_type *t;
> > +     struct bpf_kfunc_desc *desc;
> > +     const char *file;
> > +     int line_num;
> > +
> > +     if (!env->prog->aux->btf)
> > +             return;
>
> Will programs loaded without BTF silently bypass the deprecation warning?
>
> The kfunc deprecation tags are stored in the kernel or module BTF
> (meta->btf), not the program's BTF.
>
> If we return early here, we skip evaluating the tag entirely. There is a
> fallback branch below that handles missing line info which could be used =
to
> emit the warning even if the program doesn't have BTF.

Programs not using BTF are legacy, it is better to just ignore them.
Program BTF is needed for bpf_get_linfo_file_line().

>
> > +
> > +     t =3D btf_type_by_id(meta->btf, meta->func_id);
> > +     replacement =3D btf_find_decl_tag_value(meta->btf, t, -1, BPF_KFU=
NC_DECL_TAG_DEPRECATED);
>
> [ ... ]
>
> > +     linfo =3D bpf_find_linfo(env->prog, insn_idx);
> > +     if (linfo) {
> > +             bpf_get_linfo_file_line(env->prog->aux->btf, linfo, &file=
, NULL, &line_num);
> > +             warn(env, "%s:%d (insn #%d) uses deprecated kfunc %s(), w=
hich will be removed.\n",
> > +                  file, line_num, insn_idx, meta->func_name);
> > +     } else {
> > +             warn(env, "(insn #%d) uses deprecated kfunc %s(), which w=
ill be removed.\n",
> > +                  insn_idx, meta->func_name);
> > +     }
> > +
> > +     warn(env, "Switch to kfunc %s() instead.\n", replacement);
> > +     warn(env, "For older kernels, choose the correct kfunc using bpf_=
ksym_exists().\n");
> > +
> > +     desc->warned_deprecated =3D true;
> > +}
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260418171701.61=
0025-1-memxor@gmail.com?part=3D2
