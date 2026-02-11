Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D866912B93
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 17:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770830422; cv=pass; b=VchwAsv1/5t1HcXJmDKQ78cPbx9nq6M+pBWYk5sz66Cvpzxh0OKj2a6non0HVpvp67mEQIkUAfQhuNgnFs2MS4hU7qM3nvt03XM6DK37cW7vXO/FFfMSYAg6QVZEATSjlVV1TfYTSgytaom8Vw3uC28aCquarztLsqhC3MQ+LoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770830422; c=relaxed/simple;
	bh=dqFGBKFUK/bbddcibV1aga3BkSDFYuP7l9ZVpDXtyR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NpmXMMKgnldTHVfMO/WgLSSBChQhFJ5u8jDq4bgMSE+1pBAvQxwSUsAI9kYVdy+TUYWr7VU7dGMUHSlrMZ7GR5wXOE6PluxLwTfF6oLMbc04T8MOSDkzggi+GI2YwL7nKOHV9oO2IBzrOv+twRq4jl3qVEPpXD+lsSI5L9ZVIdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ex3yoYcs; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ex3yoYcs"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-823210d1d8eso3032953b3a.1
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 09:20:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770830420; cv=none;
        d=google.com; s=arc-20240605;
        b=cWoAwwBG+jFz7PXxVPX9hv2yfjm4mjf3DWbTr1fwrSix+1uCzD2yK6OpnM6TgyHnEN
         hvpryyhj0p2z4+d2bekyJQFjcWoZE4o6BtyB8NgI4edlyeLceAra38rx/V5S9D5etwW1
         cwFYp2cMiVXPbEBhNPj9xHxD1Rqe5xsSJl5qt97SmlNaYrBTHSC6uwuchEI+xRhNFF5S
         mCmtXvnXj8vomcUS8mo0ZH2xezwcQ71pTgCgucOx1e6pJTt5PXXAxly2uwtVwUuTH44y
         bRH6n/5n041P0IsNWBPr7xXx0uD0jr/BXhih+AkzN3zRsAdgjjgUAMsg3JhwcT3fUGDU
         mCsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WhNgNhQcg8IYEmEQVTuZwF8/EC7eGnkCyUh12pVMiUE=;
        fh=LriVIOwDK6e7hfTyU1mKKReNKqC2UtJlcUCmS4uNZJc=;
        b=ZEtOUEkLkwzTkeySS6mbTNQNdHCDx/kIJMNc349f7KpiYSTu+fIom8CZ+wVmKgVb5i
         I9id3+qgRLyd6kZWzHA/AggShuRm0BbmirTppw81Xlkyr1koRwaYEaTCPeZAH6E6gnp6
         vW0Ekb+aK9u7CStDI0HPLeuQ2tiG+Bz7IERtAXUoQX8wEcT7IpiByERn8eawsr9bLeW7
         dAFdxGxSYkGERDZMIcolSG7Qdvv8xBo9DDBSRuLILXsf+UeB/SexiK3IMF1LRrWBWUrg
         JApylNbi3IdPXs7y+ky0RfRQ1gjVx4jJdoi39IOKxTW0/uJX6dmxyXfLCs6lhp64XnUM
         vSlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770830420; x=1771435220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WhNgNhQcg8IYEmEQVTuZwF8/EC7eGnkCyUh12pVMiUE=;
        b=ex3yoYcs0pufPMN238Ez3yd4LRDcKnVQzcAr3348kQS2FZia81hr19XbxiivWQ86V7
         H9I4GrYuxU7uEISZcFnwYc2/7uPlWtiWQuUUuGSA295hFVteI/9wsQqGqpEFSewWDJg4
         oDdGq+Ljk/WgO3e10XIe4mpcXOP7XUYpZYCs89ruwQ22QLpD6ChEhhEkGM3ZhKI2h+ow
         YujBXOKUtN+pdxVQEcTgtzyRd9XOIgGFs/AirsabYuCJQTJP4azf+Jkq+9bbBbpceAe8
         AnlWFvuu5KXS/p0S3ZMf1twFB+SgFE1dO4qmJFU1Hr5DkRjEGah0aC7eMrvITcngMmrJ
         /k4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770830420; x=1771435220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WhNgNhQcg8IYEmEQVTuZwF8/EC7eGnkCyUh12pVMiUE=;
        b=qFKxjRkowOZBFEO6LA4uEsdmyseBsYa3SU1j3AunX0HX//KvVaXgwXq6v/mStzbU23
         GeJi5k2qDEeiBgxkFtECsuGBEUjrTKDlObQobdqGPDNDnUCBss6kFmlwQqHF+d46PR5O
         4m5pr0TKmtjgVIibMOCqxfZ+TIPPQ/slXJJNrAgHMOhi6hcRuzfSN+vBB6Go+/bOb0x3
         a34mCu5ielHftkJIHeDT5Ax5G5F2KVVCtWNuF9iYnBzmWDCtpgqIZAjef/nEnZjapJ3f
         DAwmyW448pfnhneXIO3Q2m0KpIYIjZA9P1HGyDbQQMeMjbWx1WdbFY/pCpKxa6ECrGmA
         zYjg==
X-Forwarded-Encrypted: i=1; AJvYcCWqCtF6HU8iMl+NpJ/F3cbXTrh1NF6L8EKM5A7rA4G5TO76Vtl4VeaX1jV9txLgR4gWTJc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7YHMGSN6Z2NKA3KvTiMe9HypFIb0lyL8LRfN4BKVqEIGqIYVv
	Ed3wlv8a1rV4J2aHWS8M5UzOCxsz2B6s1cxVFjclUHV2auvl3JMQzd/vo1TO6aZgaeRYFwWU6W0
	rXS3gpBbVOj2BCwR9f3cp7NtXDvwM2GY=
X-Gm-Gg: AZuq6aJ0/Kkl1gj6ST44/pLGg1Rzw+9fkHyVu3ASSXq7R7hh6uB1N8tnCb6UYJDgUqh
	wRaOvoU6ixRfBs1vx+CZQc86qcoA9n/EQrMyHRCQ5Nq+whaOeZ7Yb1z+Y0W/odowlw6uFNCuTRN
	cIaeAPeeUgGTsopsZqlwXCHdVR6GBfYpJG5kTUqSYeZlKbbnUytDtOw9gs37U2G3nL+dCN5SJeO
	51YLN1wSfyL3fnFf7i/ANLIyyDXmY3NQ1TikPD/UpmoO3oRrCFjHnaN4VXR8WuLXm67n6246Ohz
	Vcue4cEbt4m2UXarTeVOBuc=
X-Received: by 2002:a17:90b:3503:b0:352:c995:808a with SMTP id
 98e67ed59e1d1-3568f327382mr108536a91.14.1770830419972; Wed, 11 Feb 2026
 09:20:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211125737.1315848-1-dongml2@chinatelecom.cn>
In-Reply-To: <20260211125737.1315848-1-dongml2@chinatelecom.cn>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 11 Feb 2026 09:20:07 -0800
X-Gm-Features: AZwV_QjAMcaS7OjV7gGRvQT3Ys7tXoGGFbbk4hnPjqvbyYZdGG1dAB8Dv85wu28
Message-ID: <CAEf4Bzb6ay+gLD0gqZ8j8-=9onZE396YQmyGX-ZLELqF73iDGA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: skip compat check for session kfuncs
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 11, 2026 at 4:57=E2=80=AFAM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> The function prototype of bpf_session_{cookie,is_return} is changed in
> the commit 8fe4dc4f6456 ("bpf: change prototype of
> bpf_session_{cookie,is_return}"), which is not friendly to the old kernel=
,
> as the libbpf will fail on the compatible checking.
>
> Therefore, let's skip the checking of bpf_session_{cookie,is_return} in
> libbpf, and just let the kernel do the checking.
>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
>  tools/lib/bpf/libbpf.c | 31 ++++++++++++++++++++-----------
>  1 file changed, 20 insertions(+), 11 deletions(-)
>

This is not the way. Use bpf_ksym_exists() check and have custom
legacy bpf_session_cookie___legacy() definition with old prototype.
You can then detect whether
bpf_ksym_exists(bpf_session_cookie___legacy) is true and use the
legacy version, otherwise use the current version.

pw-bot: cr


> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 0c8bf0b5cce4..71bdd1c1ac39 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -8557,6 +8557,12 @@ static int find_ksym_btf_id(struct bpf_object *obj=
, const char *ksym_name,
>         return id;
>  }
>
> +static bool kfunc_skip_compat_check(const char *name)
> +{
> +       return name && (strcmp(name, "bpf_session_cookie") =3D=3D 0 ||
> +                       strcmp(name, "bpf_session_is_return") =3D=3D 0);
> +}
> +
>  static int bpf_object__resolve_ksym_var_btf_id(struct bpf_object *obj,
>                                                struct extern_desc *ext)
>  {
> @@ -8617,12 +8623,13 @@ static int bpf_object__resolve_ksym_func_btf_id(s=
truct bpf_object *obj,
>         struct module_btf *mod_btf =3D NULL;
>         const struct btf_type *kern_func;
>         struct btf *kern_btf =3D NULL;
> +       const char *kfunc_name;
>         int ret;
>
>         local_func_proto_id =3D ext->ksym.type_id;
>
> -       kfunc_id =3D find_ksym_btf_id(obj, ext->essent_name ?: ext->name,=
 BTF_KIND_FUNC, &kern_btf,
> -                                   &mod_btf);
> +       kfunc_name =3D ext->essent_name ?: ext->name;
> +       kfunc_id =3D find_ksym_btf_id(obj, kfunc_name, BTF_KIND_FUNC, &ke=
rn_btf, &mod_btf);
>         if (kfunc_id < 0) {
>                 if (kfunc_id =3D=3D -ESRCH && ext->is_weak)
>                         return 0;
> @@ -8634,16 +8641,18 @@ static int bpf_object__resolve_ksym_func_btf_id(s=
truct bpf_object *obj,
>         kern_func =3D btf__type_by_id(kern_btf, kfunc_id);
>         kfunc_proto_id =3D kern_func->type;
>
> -       ret =3D bpf_core_types_are_compat(obj->btf, local_func_proto_id,
> -                                       kern_btf, kfunc_proto_id);
> -       if (ret <=3D 0) {
> -               if (ext->is_weak)
> -                       return 0;
> +       if (!kfunc_skip_compat_check(kfunc_name)) {
> +               ret =3D bpf_core_types_are_compat(obj->btf, local_func_pr=
oto_id,
> +                                               kern_btf, kfunc_proto_id)=
;
> +               if (ret <=3D 0) {
> +                       if (ext->is_weak)
> +                               return 0;
>
> -               pr_warn("extern (func ksym) '%s': func_proto [%d] incompa=
tible with %s [%d]\n",
> -                       ext->name, local_func_proto_id,
> -                       mod_btf ? mod_btf->name : "vmlinux", kfunc_proto_=
id);
> -               return -EINVAL;
> +                       pr_warn("extern (func ksym) '%s': func_proto [%d]=
 incompatible with %s [%d]\n",
> +                               ext->name, local_func_proto_id,
> +                               mod_btf ? mod_btf->name : "vmlinux", kfun=
c_proto_id);
> +                       return -EINVAL;
> +               }
>         }
>
>         /* set index for module BTF fd in fd_array, if unset */
> --
> 2.53.0
>
