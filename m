Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603787FA
	for <bpf@vger.kernel.org>; Sat,  9 Mar 2024 01:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709946185; cv=none; b=Z3bM5oXLfHNm/q+nfRKOofMpA6A0hK3DV+l5kl0gEIG6BrTXFYYJQyhzQ4yPKNGi7YAgvskBlX9w4MbVQi3i2rKpT/nhPMC+0esJvmESxiZbfeK7i+q4aIZ9iuL5UBuJkRCj0I4ypsvnXoUheWdm1LRk7G52Rtka7v/MUqx5LTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709946185; c=relaxed/simple;
	bh=Gs3A25pAEeZrLMU5zeomp2hdm1slwwHpDsfYFHjREos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gplZpPWkbfOrmYYu/HJHLbWxSAAAtG3FgOspVYNfZ06LyVIomaYQU3R08PY1KLeDNO+d88iVY7u5DnwxAZGogw4LmL1AhOEjuIN3fT8UsVQs79eErhIILE0lLr00jW8sUs3KOzLHEo9l9ifE1eUc6GlUCz9fY5t3q3/JpH5lNUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JBDlDyfd; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBDlDyfd"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a3ed9cae56fso674130566b.1
        for <bpf@vger.kernel.org>; Fri, 08 Mar 2024 17:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709946181; x=1710550981; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I/2rPjPRCZqz5sOPw1HRuma6gCoF1e+0nsF6ljaER7g=;
        b=JBDlDyfd1c9Mv8gTwrgBXA7QKxDKQysC0/WqkU+vuKSrb+g/peb4sho6cY57s8gWzf
         o3m8Mg3EN39nEcmyuLaDNNf61BulaTR9f6jBmkw/o4qLoqjngwcBIj9XrnadVeVH13OJ
         XVKNNZSk8T+5f17orKGFU0yvwMpuvJkc8crL9O+B7dbpzOKta9r2sZnL11xRkN7U+zew
         uYTUaUwS5L+yYMKTQBjzpk3C5JwVcR4dQwM5WVSLicMB+p19J531oEqdF//JUXvWEGMh
         kSPHYQQDhnnzhTiY7wtJLnKG6b983/NCnCrfoncJt7uMycb0eEaGJ7fIYwn6S7chicyI
         n1sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709946181; x=1710550981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I/2rPjPRCZqz5sOPw1HRuma6gCoF1e+0nsF6ljaER7g=;
        b=b+NZ7V7Pxx9AOrZNeSfo2C0uxQXR1AcVmjOvhfG0xydqAESol45BfpWh9JBCW07beM
         afnwtX1XlwcZthO6Tui9b0tutsF3InwEh3lGqN+4e+lEO8Yl+QCZZ7athSBEqA8CNXeP
         UIC6Eq3NeRbEyNXuTEnYQL1+jHOeRwuqiSm0WWioSypTcaGUSBB3N65wYeB4l20Iz4as
         5TyljRfK04l4x4KrWxOloizTdrJtl46K2ZHd4WJTZ6BLh5xDeiBoTGijnAGk9JjKC15o
         s92apONKYWmY+CI6zqsH0du7VfNPV9p2LgDX3Ld7JQZyKFViyHJgIpO07X/oNVRc8lQz
         QRxQ==
X-Gm-Message-State: AOJu0YwRDlsS2/PQbhDeon4n2UTrzipK3bb9rXU334HPVY1SbVxYZruC
	l7d3+KhjzIk1hXOcaSBUj4uPpwAY5GPW9K2emEde6C3pRwqAUtKrO0CWXQYzAabJ1EFUtuo9fa9
	nSuOvdE8uJH7MnfqjVSy5GvFMI1w=
X-Google-Smtp-Source: AGHT+IF3z8WEYPiS88Rd9qEsmoOD3++gy7rQ8pUqNod613mNWmKEdlasnulxVo7bJmjrHYOwvu5AANivoBPnQ8SeBgk=
X-Received: by 2002:a17:906:f209:b0:a45:ffbe:f6f7 with SMTP id
 gt9-20020a170906f20900b00a45ffbef6f7mr281588ejb.30.1709946181468; Fri, 08 Mar
 2024 17:03:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305202155.3890667-1-yonghong.song@linux.dev> <20240305202206.3891411-1-yonghong.song@linux.dev>
In-Reply-To: <20240305202206.3891411-1-yonghong.song@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 8 Mar 2024 17:02:47 -0800
Message-ID: <CAEf4Bza0sbBXRmFQDN82cE0=v7xiRqx5tcHG-tu+MwaLNqzn+w@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 2/5] libbpf: Refactor bpf_program_attach_fd()
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 12:22=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> Refactor function bpf_program_attach_fd() to provide a helper function
> which has attach_type as one of input parameters. This will make later
> libbpf change easier to understand.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  tools/lib/bpf/libbpf.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 6c2979f1b471..97b573516675 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -12151,11 +12151,10 @@ static int attach_lsm(const struct bpf_program =
*prog, long cookie, struct bpf_li
>  }
>
>  static struct bpf_link *
> -bpf_program_attach_fd(const struct bpf_program *prog,
> -                     int target_fd, const char *target_name,
> -                     const struct bpf_link_create_opts *opts)
> +__bpf_program_attach_fd(const struct bpf_program *prog, int target_fd,

I hope we won't need this patch at all (see my comment on later
patch), but if we do need to do this refactoring then a) let's not
used underscore-prefixed names, this is not a common practice in
libbpf code base and b) I think we can just update all callers of
bpf_program_attach_fd() to pass attach_type directly, there are just 6
of them.

> +                       enum bpf_attach_type attach_type, const char *tar=
get_name,
> +                       const struct bpf_link_create_opts *opts)
>  {
> -       enum bpf_attach_type attach_type;
>         char errmsg[STRERR_BUFSIZE];
>         struct bpf_link *link;
>         int prog_fd, link_fd;
> @@ -12171,7 +12170,6 @@ bpf_program_attach_fd(const struct bpf_program *p=
rog,
>                 return libbpf_err_ptr(-ENOMEM);
>         link->detach =3D &bpf_link__detach_fd;
>
> -       attach_type =3D bpf_program__expected_attach_type(prog);
>         link_fd =3D bpf_link_create(prog_fd, target_fd, attach_type, opts=
);
>         if (link_fd < 0) {
>                 link_fd =3D -errno;
> @@ -12185,6 +12183,16 @@ bpf_program_attach_fd(const struct bpf_program *=
prog,
>         return link;
>  }
>
> +static struct bpf_link *
> +bpf_program_attach_fd(const struct bpf_program *prog,
> +                     int target_fd, const char *target_name,
> +                     const struct bpf_link_create_opts *opts)
> +{
> +       return __bpf_program_attach_fd(prog, target_fd,
> +                                      bpf_program__expected_attach_type(=
prog),
> +                                      target_name, opts);
> +}
> +
>  struct bpf_link *
>  bpf_program__attach_cgroup(const struct bpf_program *prog, int cgroup_fd=
)
>  {
> --
> 2.43.0
>
