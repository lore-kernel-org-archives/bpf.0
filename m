Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5809B64CF8
	for <bpf@vger.kernel.org>; Wed, 13 Mar 2024 17:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710351568; cv=none; b=k5DQYhpOA0sAndwfq0G9JTioasRLyum6/IW45ZGTr0eWi0Ki7zlwHPEBsf+YdIX+OlL1jtzy5TtaXAUWc2EoZy+yP+XsXD7p5Yia6qiH18EIpeKsLu+7LWXPyx35zVLvAsSAjWQiqWTnbQMBn3pKoc9Du5AM7cZWUwjREFARUa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710351568; c=relaxed/simple;
	bh=X+3qZNk/byvBIKs2r9FC/BQkxdS40QJKaq/JSoQdhsg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IG7+5rmRtp511x2tI/7st3Blz8rXcsRF4hmS/t9peeaCHNY7n2Wo/P2kkmT+QJc18TSExm7rbFCM6G1nlPOWsAKT/IAj968/Ex66JFkJNZmHscvLRZ8Scv1YbdBfhy2gKfAMWLseeJPDUOvXdNG7PsK1ZgDxRBhBK1YknI3ftfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PwDFx8do; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PwDFx8do"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so61813a12.1
        for <bpf@vger.kernel.org>; Wed, 13 Mar 2024 10:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710351566; x=1710956366; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EciaWl2XoGo7HAVyCzLO4UG7wdpzJT8CFck+TMl0V2s=;
        b=PwDFx8doqhXNcVkjYfr+xoII0/ogOUX1IYNSAbNaA+wZNjvwnpBtyb74IKjFxTTSWR
         8hsnswEEQ/M39Xp3X8cHbyPa0P80xDBNn2dbe0nMKPeVmBTSEcBfv8xbyfLKjV9hmSBy
         qweqC3TMv99Mk9itaiF4BNuwyxho5bL75VQ/ew7GU6cvjvSbgns0BhZ0GCtzImLpWCAF
         MWSZBHqAATrVBt7VzLihc5eWpYApD+aB4r4UzWIc2u8yFqULMKF2AcaoBfb4xzuZLAyJ
         mM55PcNDCAlsb23HpZ5Nc4xNzel1OYrVi0jOjp6pRY6qS79uDFsVQ8vyDQzTHyeB32a3
         qEJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710351566; x=1710956366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EciaWl2XoGo7HAVyCzLO4UG7wdpzJT8CFck+TMl0V2s=;
        b=PU+yXeGXxqc338GJJOt+TNj1zqrhtUam1jH5vbr3Z/X3YOH10nmVSBUH3HeQHATBYk
         0Sq3EGAYxqC2wMwKK+ofrEODkCyxjnMP51b67Z/HJAojyAUxV99A5i3b+Nx+tPzWfRui
         ravhxNlRx5OjXp5a90WxAmyyLk6k6F3Qz+h9cD2muizZwMmjV1u7Lo6Y8LTow6qGfGew
         U7M8aVioJ+EU35U8fTLDwxtnq+ugh5zNYHqNXqx4QRmvPHPTvBYfGfz7TntFtDw8/Z+H
         gccnjD9olzpnwcOSCdvCodsqUcY5AdNVdJKAVvOCSi6SH8CxyMaJgtemNCQWh5Roldin
         ZTdw==
X-Forwarded-Encrypted: i=1; AJvYcCWtWx9MbFe91vp1TJtMqOO/vG+3xOhSzs+bRwlxdSGARIWxh5cu2fFAS/8S3unmPYcqzqu+0FIXpk4MEzyIEfoZHpy3
X-Gm-Message-State: AOJu0YxTZxsjXFmiD4Jk2m8oDId1ith3XQuVXUNkKcKqmwKGLD/zzA4/
	vT8XvQOj+u1BIxxD/siBMVndT/QI0kqktXZgzRVG7Aq6zrKc46VA+ST6fELUIXdtQebqEwlZtPj
	GdzVprZVjtID6kJ6nUzy58pySWKQ=
X-Google-Smtp-Source: AGHT+IEW2GHLx0Cf0KoQSW/GMpRzJ882wWEGpFVUJey+ULIs5hameV4wnzZUTWDBvvX7MnnJ2cC84LmGrzh4MJ2WDFs=
X-Received: by 2002:a17:90a:fb4d:b0:29b:9a08:6007 with SMTP id
 iq13-20020a17090afb4d00b0029b9a086007mr10645987pjb.46.1710351566522; Wed, 13
 Mar 2024 10:39:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313172345.75270-1-quentin@isovalent.com>
In-Reply-To: <20240313172345.75270-1-quentin@isovalent.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 13 Mar 2024 10:39:14 -0700
Message-ID: <CAEf4BzbC4_x6qNT-9Tzq0D85NrxU5vDz_rpT83mg0PHypDRnQA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] Revert "libbpf: make uniform use of btf__fd()
 accessor inside libbpf"
To: Quentin Monnet <quentin@isovalent.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 10:24=E2=80=AFAM Quentin Monnet <quentin@isovalent.=
com> wrote:
>
> This reverts commit df7c3f7d3a3ddab31ca8cfa9b86a8729ec43fd2e.
>
> There's no guarantee that obj->btf is non-NULL when passing it to
> btf__fd(), and this function doesn't perform any check before
> dereferencing its argument. As a consequence, this commit caused
> segmentation faults in bpftool (for example) when trying to load
> programs that come without BTF info.
>
> Signed-off-by: Quentin Monnet <quentin@isovalent.com>
> ---
>  tools/lib/bpf/libbpf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index efab29b8935b..0f9a4d232468 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -7343,7 +7343,7 @@ static int bpf_object_load_prog(struct bpf_object *=
obj, struct bpf_program *prog
>         load_attr.prog_ifindex =3D prog->prog_ifindex;
>
>         /* specify func_info/line_info only if kernel supports them */
> -       btf_fd =3D btf__fd(obj->btf);
> +       btf_fd =3D bpf_object__btf_fd(obj);

oh, my bad, sorry about that. But I'd still like to stick to using
btf__fd(), so maybe let's fix forward by dropping btf_fd variable here
and doing what bpf_object__create_map() does:

if (obj->btf && btf__fd(obj->btf) >=3D 0 && kernel_supports(...)) {
    load_attr.prog_btf_fd =3D btf__fd(obj->btf);
    ...
}

?

>         if (btf_fd >=3D 0 && kernel_supports(obj, FEAT_BTF_FUNC)) {
>                 load_attr.prog_btf_fd =3D btf_fd;
>                 load_attr.func_info =3D prog->func_info;
> --
> 2.34.1
>
