Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A204A2E03
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 23:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780530390; cv=pass; b=hHVqfBWmT010YV2xK3koOIUYOt9qqoLqWScWaYpUbN2BfRV6BAfE/0Zuf2UxeRVjcqIAVH2sgqZQrAxYEeRco0YwB607ytCxa6k+00K19P4y/AbVKICp7IniFUEZ6ijVr518wL0EKdjXFxOkL4fSKHqtQn0bNuQXNbgETyFdTE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780530390; c=relaxed/simple;
	bh=oAiHPvkefT22A2SNqLflUZDL0oxDXGexjwhGo842xsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KCM3MjQ3O9u0pyhOUSOdCe63pZ+XEHJmTRlYzVW5rFNrtG6iOfdwszMI9MgJjN+AtIIty5u7DM72jyrXbmVnJq50RbwUvOoUuGzp/rNm2wVELb7YoUFnGo5vvfObWyqrDIZM2uV/7+TdTUErCznrPDo52OyH+cIi8AkTbz/driw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQMk/OUh; arc=pass smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQMk/OUh"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-36b9033d230so35085a91.1
        for <bpf@vger.kernel.org>; Wed, 03 Jun 2026 16:46:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780530388; cv=none;
        d=google.com; s=arc-20240605;
        b=RN/+AcfM3s3bvYn7c6BraA/iAgIX5OLOOuw38vqH5WnNnpC60WDMhN6pzVaosk6T/6
         6AGvXvfrMK2guahgHWg1Uyrs/NywBkrX5o+HXznvm4WU+z/JiWTSC4ORHJ/TWA0GA6hT
         Z/pSEQ7El/ySDB6kOwSSBo03cJGHkwXJYRhNAk6DPkg35rVh8envTwA0YJA3j24NYPXj
         ZCTXWQqECtBi9obDg4GIIGPl3/pU+gzCg3rk7kcL31a47qN7iatQ9wyAJEdzFIzWGyPG
         C2jPo5ysHhHVdffwwKALU5tOSYchoepuXcLaa55W42CiXoHkSUJ3PmmjrY+pvPoZjNrt
         iDIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=O+EP701GHq2NT2f+Tlg71zxl274vK+GPzaF1Gl25QX8=;
        fh=sv/udPchS3qGhQU4NBXqZaC7ol2XrgmvBzaYVzACk0M=;
        b=N3KcspYtzmDW9D0ZJztguk9ueYEgj+H3LFtL/kYPOl5CPAuDm9170wp7T/oGTU+CJh
         sRjpJhuEkMVjMx6SJMbiMKhAz28dIFgbW1lFmUc7YKJ5OdJc5VO5tM3s3FzViR7pzfg1
         Z3U7gMgMOAAod+5OXb8VqBnB6xY9xYdpyVOS50mF4bDXMMLUrDKQW8jU8C2V8v3f9uLl
         Ub/jovh/n2rMud96RPVPOrifH/f+9Dv9Lqf/BhYk9iwYhZGw5Uo4MZQwziuD2slE2hNx
         AWtoXE8I0l5XkQ+pEQqRw48WJhqmqeIN4LsmEDjylq9AdZ7FC5+cihBsBoJrh1ps/7aV
         p1xw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780530388; x=1781135188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O+EP701GHq2NT2f+Tlg71zxl274vK+GPzaF1Gl25QX8=;
        b=FQMk/OUhyxf3R4OtLoR8WNnUp1XdbpZdJHe8WMvWatVNDVsKqcX1kuaYz0yNytHkr1
         06o2jl2F13yLaYXwiATKIBIpHQcPbzIl68xiFB+HsvGhwWLYCwaQYK02NPQvc+ivbaBO
         9GJxQBn6LONHIQ90dBHctA9Dyq0xU8uc4TLj/Szmb3lA+cS96Bv41A1CZdJ5LlUtjSsk
         o9zZPe/vtUQlWogJOQvU5xiuOjSUI3/GJekzc/80dDFEK52abFdTFfSoMDJ5j4aU24K1
         ysyQm6RMqXN1il3Ica4Vb3ULzQENShp28zoTzcPsx1awGSYnpZmIfnTAWe9T0dsAr6R0
         X5cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780530388; x=1781135188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O+EP701GHq2NT2f+Tlg71zxl274vK+GPzaF1Gl25QX8=;
        b=BIkJe492XcDNmRu0H8QfdHYYhyGO3i6TGQ0DffWRZ4pdcv343ipLFWfuQfKgAqci3B
         XIpLMMk+vEWhKT0d151SNZiSMwz8YRgkrl1UPNrZFJNBNq+mRPIBbnOIMnau2BZlAMpx
         JZ9XCXDINSGCkWScn7OB71WFUfilZ4iWuEEIZtAXNuBGs4cRVwB7rMy5lJDpAne/le9G
         +vTyWGlu0nt2sxCWEJ719CdavBXbPfD2ZM2bGDs71LPAFwulKE2tFyxXArFygSwwmL5f
         7AKhCaArroWCYr29YCJFeEKxYiLusLlyopL9GbU/B1fDIFsOdotvc5nXslwdM6wdNbeS
         e6Sg==
X-Forwarded-Encrypted: i=1; AFNElJ/YjS9mallgtDE+xGNFEBEYI3kLpW/aGGqBQdH6LUiwfHmnhsDEfI4erRoPORL8gyDl78M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKnPMIsCqXoQ2EyznhOoNDl+6tN7CPeP8Yw/eK0amJeWZhGt3V
	4ikQCmQbZ2OzpGr3gnC3x7EKFuhfd2EPJkiiml3Ar18ckG+Jd+y3c/vMUzhks9QbDgS0nuIo8ph
	7nyS/fh3YOpghLjvyiY1/bq9RxqYOGV0=
X-Gm-Gg: Acq92OEJvoktzMGQBynp3FhB2F4masVXkfXDpH4/FXA341RDqKOvQOighbHeps8ZZYs
	/QQ8/xnOjaCDTipU9QzHB7BUs1eGpcwjswxPGidOOvGMEVF0hpNJxNGOmNnkRaCDdXGLxxpj3Xw
	LXaH2maO7Rtv9rDGdFM9rAAZ30MsRGuabTzKFmingisxayxhNNK9DAgud44wzDiTgKFkXfK2h4C
	YXR7sX3SMSHuxE2P420VLLIwscQ77Pas0hGPfoLbNE5uGwl7b75kW0vNZjUD3oUk8/tOxGX6+Nf
	qm7ZPkYDHCPm3rp/ni7YuZRMGBSLvg1pUDOgxaOEWTtyQnLyeC6mpKNUmo0ql9lwe4iU05Y8GIs
	=
X-Received: by 2002:a17:90b:3fc3:b0:369:9469:aeba with SMTP id
 98e67ed59e1d1-36f76481151mr954581a91.1.1780530387689; Wed, 03 Jun 2026
 16:46:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601221805.821394-1-ihor.solodrai@linux.dev> <20260601221805.821394-8-ihor.solodrai@linux.dev>
In-Reply-To: <20260601221805.821394-8-ihor.solodrai@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 3 Jun 2026 16:45:55 -0700
X-Gm-Features: AVHnY4Jo_VADawYPd5pXnQ_e_kHVo5REZQ64FS2sXI_sZCZGGKSN-ZvmGE4jQGQ
Message-ID: <CAEf4BzYtx5-6gpy=2BL0-f8ZggNdNUUmf7mddf_uSWG4dZ_tSA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 07/14] resolve_btfids: Emit bpf_kfunc BTF decl
 tag for discovered kfuncs
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 1, 2026 at 3:19=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.d=
ev> wrote:
>
> Now that collect_kfuncs() discovers kfuncs from BTF_SET8_KFUNCS sets,
> resolve_btfids can also be the source of truth for the bpf_kfunc decl
> tag in BTF.
>
> Today pahole emits it under --btf_features=3Ddecl_tag_kfuncs; moving the
> emission in-tree lets that flag be dropped from the kernel build once
> the rest of the kfunc annotations follow.
>
> The implementation in resolve_btfids is idempotent: if a decl_tag
> exists in the input BTF, no new tag will be emitted. This allows to be
> more independent of pahole's version and runtime flags used to
> generate the BTF.
>

As I mentioned in cover letter reply, I think this is unnecessary and
we shouldn't do this. What's the real situations where this is
*necessary*?


> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>  tools/bpf/resolve_btfids/main.c | 49 ++++++++++++++++++++++++++++++---
>  1 file changed, 45 insertions(+), 4 deletions(-)
>
> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/m=
ain.c
> index d35a7b2460e8..30a07ec4ebb6 100644
> --- a/tools/bpf/resolve_btfids/main.c
> +++ b/tools/bpf/resolve_btfids/main.c
> @@ -1255,6 +1255,44 @@ static int process_kfunc_with_implicit_args(struct=
 btf2btf_context *ctx, struct
>         return 0;
>  }
>
> +static bool btf_has_decl_tag(struct btf2btf_context *ctx, const char *ta=
g_name,
> +                            u32 target_btf_id, int component_idx)
> +{
> +       const struct btf_type *t;
> +       const char *name;
> +
> +       for (u32 i =3D 0; i < ctx->nr_decl_tags; i++) {
> +               t =3D btf__type_by_id(ctx->btf, ctx->decl_tags[i]);
> +               if (t->type !=3D target_btf_id)
> +                       continue;
> +               if (btf_decl_tag(t)->component_idx !=3D component_idx)
> +                       continue;
> +               name =3D btf__name_by_offset(ctx->btf, t->name_off);
> +               if (name && strcmp(name, tag_name) =3D=3D 0)
> +                       return true;
> +       }
> +       return false;
> +}
> +
> +/* Add a decl tag if an identical one is not already present. */
> +static int ensure_decl_tag(struct btf2btf_context *ctx, const char *tag_=
name,
> +                          u32 target_btf_id, int component_idx)
> +{
> +       int new_id;
> +
> +       if (btf_has_decl_tag(ctx, tag_name, target_btf_id, component_idx)=
)
> +               return 0;
> +
> +       new_id =3D btf__add_decl_tag(ctx->btf, tag_name, target_btf_id, c=
omponent_idx);
> +       if (new_id < 0) {
> +               pr_err("ERROR: resolve_btfids: failed to add '%s' decl ta=
g for BTF id %u: %d\n",
> +                      tag_name, target_btf_id, new_id);
> +               return new_id;
> +       }
> +
> +       return push_decl_tag_id(ctx, new_id);
> +}
> +
>  static int btf2btf(struct object *obj)
>  {
>         struct btf2btf_context ctx =3D {};
> @@ -1267,12 +1305,15 @@ static int btf2btf(struct object *obj)
>         for (u32 i =3D 0; i < ctx.nr_kfuncs; i++) {
>                 struct kfunc *kfunc =3D &ctx.kfuncs[i];
>
> -               if (!(kfunc->flags & KF_IMPLICIT_ARGS))
> -                       continue;
> -
> -               err =3D process_kfunc_with_implicit_args(&ctx, kfunc);
> +               err =3D ensure_decl_tag(&ctx, "bpf_kfunc", kfunc->btf_id,=
 -1);
>                 if (err)
>                         goto out;
> +
> +               if (kfunc->flags & KF_IMPLICIT_ARGS) {
> +                       err =3D process_kfunc_with_implicit_args(&ctx, kf=
unc);
> +                       if (err)
> +                               goto out;
> +               }
>         }
>
>         err =3D 0;
> --
> 2.54.0
>
