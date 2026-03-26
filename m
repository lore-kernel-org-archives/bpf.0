Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F82E3A6EE7
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 21:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774560585; cv=pass; b=Bb61H29mNkvZtUyZwkhgWISvfa9Hgy70+t3n7/kKuGCN/iVt1butEx+vTEVO4Xi3Q4ho3sg00MQt8P0BmT7U1nG4eQAi2ei5vePq46e72TX8tJdJfd4Z1DOayS0ZZrlaV8W9PnCSPGKFLPmY8hgbpAdyxoCxZc63UmuXU316pU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774560585; c=relaxed/simple;
	bh=qI9exwAmkDBjRH01c19fBBH57sSxNQDiBbwoNFgsSto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fMQ8+s/iIIggN+KsBcVSKgjOGBwUtbStUgWSPvm49amFDhMSOgn/QduCVaa1cOOAKNEDLBEpK+SCX/VDcYTcw1MfAgPLPCH2/lwZYgwqssIDx64exQ6W1aDN47w4MOY7K2C7f9TbbcxNKiAX8gF6/CxgEKA7AAeFUsVSPzJBxsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DpbPmtaj; arc=pass smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpbPmtaj"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c7358a7a8d1so1043020a12.3
        for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 14:29:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774560583; cv=none;
        d=google.com; s=arc-20240605;
        b=CHxwHtWHo/57InVoC/Pd6xi63CW6aRySIPRon0PlAQj7EituWpFU80/6PWOFBYJICU
         gxu044DfF1aipN/B2K7Zi4RIh1ODx5nLgoE9n0t/iSe7wOX8F+6eRzjCtIAeA7420qMI
         qhJj2jJwe+C/yyWT55W7et2WBBnmIO+fWX3aHcBDx/2YVF3QI7dMiVYkq8/urIi4bLJJ
         RSmpRHiILKmqbSNRgI7L+BdAj0di9LJ5TfbqaQVBdpERgSzNU17m1WeTYJdIxJx+exYF
         TnQ4HVRUbbritc8ypyZwGeVNM03QYQbP+vi6zlYun6lwGgGs6GJjoWLnSWEpSayW+j9O
         vEtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3QATeCF9NkbK+B+zyLGqij20iEocr3QZWaHD6xlU47E=;
        fh=KERhSiMs6Jkzo/qHAXPeYa8+9+fan3sPJlm6G5sbN0c=;
        b=C8MLCjvOeJDelnd2fG784c3bc1B1JrhrBiEVpXdxzjZbLj5gYKQsEsK/VfnkDX+zhR
         G2LaHnok0c4gb5pb9GkgAIkNUk5qMIfQQmIAnMGqdHtLWf//bEZJd9oD6/X7tNDT39d6
         CDSnkypUZZI/P0EvcIkubBpiN52eTL02NFnyon70s+6sh8tinqmat3p9Sfaa9MyZKfts
         KKkSifmNIvwsj6c7gPP6rYXf1Nh4/qV25Ezd3KV0LUG7yj0IRRHar2yfn8Jg0wezstFL
         o0Zoj9w3lxvV99JvOGnWGGN63Y8fPC4SHcf/bQuH5gVk6C9iiJJUa5XG+Mlrix2BnW8H
         TenA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774560583; x=1775165383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3QATeCF9NkbK+B+zyLGqij20iEocr3QZWaHD6xlU47E=;
        b=DpbPmtajoaQyQnJ7lkTy7yv43PU3mGvJy75TKmNQ83biAztFHprguhQHS/zvpB5VV2
         AopyDb6XytMltfsdUSzOSTUuBYWMjj3HRVB+OXshPHQS4VmwQ3H7Z8OlbwUFf+/fnsBz
         dvEfH2/nww3ybPJeAkITZF5AiNtiH9hgQd/e4NLTQ7K+jzpkMQQd5uO8PVhx3mY4g/fj
         y8BsWrih8Fay5qFn9S8aWH7TZNcKuNE6+ZrGZVmLM30tRGdraaWzU567eB0y9rAbgeay
         1p+nx/ZhG+gwbaoduUINt3v/oiTMHC9GRDb9eKcRrxstJvNWbsfu1GxEpBt6IVdW7bTE
         Odpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774560583; x=1775165383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3QATeCF9NkbK+B+zyLGqij20iEocr3QZWaHD6xlU47E=;
        b=aiFVew3Gfyn4GANcce5vjItsHwhTXgYxmo+cTrEYL/rUdy58lj5ddFt21klYH4C5Fi
         TcjnLMcPFGaR7io9gmW+4yu+9uAQaBmC/SLAFYNNfM0m0YOk8tru/T9TgZWVOxfbr4nt
         2xr3a4qJ3De6QkiH2I6ttiTbETgR8fC/GowdlZdOqGSzuceLZ4pzFRjmg1a2BcmPE4Ma
         yqIZA5dJ4MQSMgqAK2UhvJUM/QqdCB4E1Hxum9zGtOAvyq3sF45/IDlaUoEFxuYpExc+
         /XtVcocpZ4cWrI4nfas+OjhqO7qzTdugSMSz9RIkrni1rhbXbUxCmlGDIZLHSPQH1Ihw
         n0vA==
X-Gm-Message-State: AOJu0Yya9A3qDT9zbSyj7Ullx1CYpzpvSZC9oydWn561zWOsX6Z+7byW
	QME4OXUF0NqJvx0+mYfUBnC9Dqii20atd+C3Uc5YfhGe9SG0PjHRPTe9Yh+hWglh2SEu80cUddo
	GphUpVfiIGXw07lo2J83Q3Te/ft/8XHI=
X-Gm-Gg: ATEYQzyS9XY61YW1eDYktPTrSMEoE3ymQu4oa3cJauAizAgKX9SJM4uD2vuts8HYokU
	zEZnEZSxK2gOmDAcC2TbXAGoJ/NkrNuwjTkCIzI/hIQn+6jhq3DJywWy8PsOCz34n5eMJ+FBHfS
	aUmTvcq7EjwvMvTRJ6ITh7g0n9oFrlj+4lWcKv5zC9dh+u9dggRAxXH+hVufRJHyr6ajzPtp8gR
	ydmzJlnFQ6UveoqpmwNEflohLu12kyh1v/fNsXmD+9ul4W9b9qNd6ylbmkLglLxzt17fux6MbIN
	V1Fdlkw10nhKh39/Mqd0sGvaaOPH8UPmmA==
X-Received: by 2002:a05:6a20:918c:b0:398:7d6e:27f4 with SMTP id
 adf61e73a8af0-39c877ea44amr236776637.1.1774560583359; Thu, 26 Mar 2026
 14:29:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326204335.3756885-1-suzhidao@xiaomi.com>
In-Reply-To: <20260326204335.3756885-1-suzhidao@xiaomi.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 26 Mar 2026 14:29:31 -0700
X-Gm-Features: AQROBzDHSCVfkJYst2_nm2hm-Lt62FEoPxrr-U4kjkt2KElJQNQYMKfuKmX7V6w
Message-ID: <CAEf4Bzb4EQVSTguMjmd=sYXYFxmyqYnGxBdRfg6dMnRoSYwORQ@mail.gmail.com>
Subject: Re: [PATCH] libbpf: resolve versioned kfuncs by exact name before
 essential-name lookup
To: zhidao su <soolaugust@gmail.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	sched-ext@lists.linux.dev, zhidao su <suzhidao@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 1:43=E2=80=AFPM zhidao su <soolaugust@gmail.com> wr=
ote:
>
> Some kfuncs use KF_IMPLICIT_ARGS and export both a base name (where
> the verifier strips the implicit aux parameter from the prototype) and
> a versioned name with additional user-visible parameters (e.g.
> scx_bpf_dsq_move_to_local vs scx_bpf_dsq_move_to_local___v2).
>
> When a BPF program declares a weak __ksym with a flavor suffix such as
> func___v2, libbpf strips the suffix to obtain the essential name and
> looks up the base entry first.  For KF_IMPLICIT_ARGS kfuncs the base
> entry has fewer parameters (aux was stripped); the prototype
> compatibility check against the versioned declaration (which has the
> extra user parameter) then fails, and libbpf leaves the weak symbol
> unresolved even though a perfectly-matching versioned kernel entry exists=
.
>
> Fix by trying an exact-name lookup first when the symbol has an
> essential name (i.e. it has a flavor suffix).  If the exact name is
> found in kernel BTF and its prototype is compatible, use it directly.
> Only fall through to the essential-name lookup when the exact name is
> absent or incompatible.
>
> Signed-off-by: zhidao su <suzhidao@xiaomi.com>
> ---
>  tools/lib/bpf/libbpf.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>

libbpf doesn't support (yet) matching triple-underscore-suffixed
kfuncs on the kernel side. We plan to support that, but it should be
done differently.

For now, as a work around, if you need libbpf to match
scx_bpf_dsq_move_to_local___v2, you can add yet another triple
underscore: scx_bpf_dsq_move_to_local___v2___andimeanit

pw-bot: cr


> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 0be7017800fe..80e495aebe68 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -8630,6 +8630,40 @@ static int bpf_object__resolve_ksym_func_btf_id(st=
ruct bpf_object *obj,
>
>         local_func_proto_id =3D ext->ksym.type_id;
>
> +       /*
> +        * For kfuncs with a flavor suffix (e.g. "func___v2"), first try =
the
> +        * exact name.  If the exact name exists in kernel BTF and its
> +        * prototype is compatible, use it directly.  This is necessary f=
or
> +        * KF_IMPLICIT_ARGS kfuncs that export both a base name (with the
> +        * implicit aux parameter stripped) and a versioned name with ext=
ra
> +        * parameters: the essential-name lookup would find the base entr=
y
> +        * (fewer params) and fail the compat check, leaving the weak sym=
bol
> +        * unresolved even though the versioned kernel entry is a perfect
> +        * match.
> +        */
> +       if (ext->essent_name) {
> +               struct module_btf *exact_mod_btf =3D NULL;
> +               struct btf *exact_btf =3D NULL;
> +               int exact_id;
> +
> +               exact_id =3D find_ksym_btf_id(obj, ext->name, BTF_KIND_FU=
NC,
> +                                           &exact_btf, &exact_mod_btf);
> +               if (exact_id >=3D 0) {
> +                       kern_func =3D btf__type_by_id(exact_btf, exact_id=
);
> +                       kfunc_proto_id =3D kern_func->type;
> +                       ret =3D bpf_core_types_are_compat(obj->btf,
> +                                                       local_func_proto_=
id,
> +                                                       exact_btf,
> +                                                       kfunc_proto_id);
> +                       if (ret > 0) {
> +                               kern_btf =3D exact_btf;
> +                               mod_btf =3D exact_mod_btf;
> +                               kfunc_id =3D exact_id;
> +                               goto found;
> +                       }
> +               }
> +       }
> +
>         kfunc_id =3D find_ksym_btf_id(obj, ext->essent_name ?: ext->name,=
 BTF_KIND_FUNC, &kern_btf,
>                                     &mod_btf);
>         if (kfunc_id < 0) {
> @@ -8655,6 +8689,7 @@ static int bpf_object__resolve_ksym_func_btf_id(str=
uct bpf_object *obj,
>                 return -EINVAL;
>         }
>
> +found:
>         /* set index for module BTF fd in fd_array, if unset */
>         if (mod_btf && !mod_btf->fd_array_idx) {
>                 /* insn->off is s16 */
> --
> 2.43.0
>
