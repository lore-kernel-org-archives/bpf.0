Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3FB13B2B8
	for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 22:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711749677; cv=none; b=Hnhz2LxjBa5/9Hwb1986YFyZtGtfBBFbG2+xqZWyp9bH8VjEqmNM6kxR4mPE6Wd5h7ucuCE/JOeHeH7q92s6aFpTu/G+zxLyw09u94XIYZJ8vjsBGaMRfjUFiJvkN0LCuU5+gS2iAXgC9pl5WHejWfIJLPvJEC/UJ9x1p5QaHD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711749677; c=relaxed/simple;
	bh=kG2ilv+ptdgx0p0VH4ytP2EfQEf92a4w9oQTtM0jEwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R67F3oMDMMd/SFbC24qAHr5djyP0RgohIQ26ddjRvMnmuOeWOYOskZfZ62b4pDR+fDe3kUmUWsN+RRjLGYeEdwszi6XKUozE8dJ603vFRYhYm/RDqLcEWmvF2/su2NInJ58k7rud5gCJRsSMUYRZtxnXPo0WMtqVvimJpqp0TJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WrV+yTcq; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WrV+yTcq"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56899d9bf52so3061519a12.2
        for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 15:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711749674; x=1712354474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M5kGyE0FX/ono87O7FcUBRC90Dg7H28s3LGhc9FYlXU=;
        b=WrV+yTcql0IgcKCtXPTwt7X3dPzu/P1y9t8qgfLjbFyqW2rMp7028FxD8OHCKZm0gQ
         LquavPibp7Y/WjTDxGxeMqEOcDpSztFyauoiQUwsTJtEKZkItDi7CS5VoUvjQoKUTCbm
         SBN2ei6i/2pSdRB3fbT8d8VdcPan9GWricMmeLexjzfGgIQ8kJTkuIqpeVYUqxKU84gc
         tiZffuBXDMSTRMauHOmi8+RIdnAoaZpoBw5lsW3wD0nj5huMZ56Tn20h+RbxUe3kojyL
         dRptC8u4lDZ5PsQpXsVenqmdpy9TZpQw8xkrYDhHk9NZ9gINC9IEdqBN/99etUywK5Rp
         pz+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711749674; x=1712354474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M5kGyE0FX/ono87O7FcUBRC90Dg7H28s3LGhc9FYlXU=;
        b=EFiDfIO2kmfr7H5qn0YYPIc3JJkxdpfF+OqqWxsZMruFPjf8oTljgxWCIGwVc1bg7i
         IxF0IcrdDdVUoz6QdKWtbv7aCp6FB38Ql13DwT7pY3t5gUx1YsMEzP/P4DtuEO9JtGRZ
         8iAxlTo4csg8NoSCgppacWX/D4i2y7VvtnmY+uO+WD2O1iLb/Y6lJ+Qgh/RXlxWtIJa3
         fhmg830qt3eJoH2ffaY/2Ir5zkAIkdyl7jwcFx5rFFo4tiz+/06NH3IHU0ax73Hy8d9I
         7r5p14hYaJVXBg6ZiFx+BgjABMPO1jEayYSL2DST7KJE/iVh7LCsrM15tSUYNXsb70sO
         o7HA==
X-Forwarded-Encrypted: i=1; AJvYcCXAo3N0ebL6ZDffqGw9qUSSDQcE41AHlLvEvbE3ghbWHZNuAmlH85IUB/Rq0st+7WOPjXHoWSCyEthkzZ7fv3BbR0wA
X-Gm-Message-State: AOJu0Yw9tEeVWMeB0m48wEz0GlWjwcrEKELy6UXb8YNwoO8RlR4u6Vzi
	l/JBw5rJ/QZvJrPcBJy3rIvLMgVOEYDeFhsz07et4iU3YghufcfKVEAFqqMhLihqP3YQixZyzhO
	T8F84xu/0DYDCLkLzPw9GWdRaNIc=
X-Google-Smtp-Source: AGHT+IHQAbHv4k7IMa/Hrc0/A+tszxaxsuDe+8BFvVDmWOLm9iolf5oHY1DobmmbvTBWuiu0MbRQva4B9CY6qTovKcw=
X-Received: by 2002:a17:906:1744:b0:a4e:2d7d:3fd5 with SMTP id
 d4-20020a170906174400b00a4e2d7d3fd5mr2516290eje.1.1711749673920; Fri, 29 Mar
 2024 15:01:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322102455.98558-1-alan.maguire@oracle.com> <20240322102455.98558-6-alan.maguire@oracle.com>
In-Reply-To: <20240322102455.98558-6-alan.maguire@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 29 Mar 2024 15:00:53 -0700
Message-ID: <CAEf4BzbWHPah0_QaU8a9kNo7C24RB4mR0mLcwXvFQyf3qNbYnA@mail.gmail.com>
Subject: Re: [RFC bpf-next 04/13] libbpf: add btf__parse_opts() API for
 flexible BTF parsing
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, jolsa@kernel.org, acme@redhat.com, 
	quentin@isovalent.com, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org, 
	masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 3:25=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> Options cover existing parsing scenarios (ELF, raw, retrieving
> .BTF.ext) and also allow specification of the ELF section name
> containing BTF.  This will allow consumers to retrieve BTF from
> .BTF.base_ref sections (BTF_BASE_REF_ELF_SEC) also.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/lib/bpf/btf.c      | 24 ++++++++++++++++++------
>  tools/lib/bpf/btf.h      | 32 ++++++++++++++++++++++++++++++++
>  tools/lib/bpf/libbpf.map |  1 +
>  3 files changed, 51 insertions(+), 6 deletions(-)
>

[...]

> +struct btf *btf__parse_opts(const char *path, struct btf_parse_opts *opt=
s)
> +{
> +       if (!OPTS_VALID(opts, btf_parse_opts))
> +               return libbpf_err_ptr(-EINVAL);
> +       if (opts && !opts->btf_sec)

please use OPTS_GET() macro to access members of opts structs

> +               return btf__parse_raw_split(path, opts ? opts->base_btf :=
 NULL);

this should still work for ELF parsing, so use btf_parse() which can
deal both with raw BTF and parse ELF (defaulting to .BTF section)

> +       return libbpf_ptr(btf_parse_elf(path,
> +                                       opts ? opts->btf_sec : BTF_ELF_SE=
C,
> +                                       opts ? opts->base_btf : NULL,
> +                                       opts ? &opts->btf_ext : NULL));

ditto

> +}
> +
>  static struct btf *btf_parse(const char *path, struct btf *base_btf, str=
uct btf_ext **btf_ext)
>  {
>         struct btf *btf;
> @@ -1307,7 +1319,7 @@ static struct btf *btf_parse(const char *path, stru=
ct btf *base_btf, struct btf_
>                 return btf;
>         if (err !=3D -EPROTO)
>                 return ERR_PTR(err);
> -       return btf_parse_elf(path, base_btf, btf_ext);
> +       return btf_parse_elf(path, BTF_ELF_SEC, base_btf, btf_ext);
>  }
>
>  struct btf *btf__parse(const char *path, struct btf_ext **btf_ext)
> diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> index f2a853d6fa55..c63043520149 100644
> --- a/tools/lib/bpf/btf.h
> +++ b/tools/lib/bpf/btf.h
> @@ -18,6 +18,7 @@ extern "C" {
>
>  #define BTF_ELF_SEC ".BTF"
>  #define BTF_EXT_ELF_SEC ".BTF.ext"
> +#define BTF_BASE_REF_ELF_SEC ".BTF.base_ref"
>  #define MAPS_ELF_SEC ".maps"
>
>  struct btf;
> @@ -129,6 +130,37 @@ LIBBPF_API struct btf *btf__parse_elf_split(const ch=
ar *path, struct btf *base_b
>  LIBBPF_API struct btf *btf__parse_raw(const char *path);
>  LIBBPF_API struct btf *btf__parse_raw_split(const char *path, struct btf=
 *base_btf);
>
> +struct btf_parse_opts {
> +       size_t sz;
> +       /* use base BTF to parse split BTF */
> +       struct btf *base_btf;
> +       /* retrieve optional .BTF.ext info */
> +       struct btf_ext *btf_ext;

shouldn't this be a pointer to a pointer, it's an output parameter,
right? This will give control to users to define if they are
interested in .BTF.ext content or not (NULL means "don't bother
parsing")

> +       /* BTF section name */
> +       const char *btf_sec;
> +        size_t:0;
> +};
> +
> +#define btf_parse_opts__last_field btf_sec
> +
> +/* @brief **btf__parse_opts()** parses BTF information from either a
> + * raw BTF file (*btf_sec* is NULL) or from the specified BTF section,
> + * also retrieving  .BTF.ext info if *btf_ext* is non-NULL.  If
> + * *base_btf* is specified, use it to parse split BTF from the
> + * specified location.
> + *
> + * @return new BTF object instance which has to be eventually freed with
> + * **btf__free()**
> + *
> + * On error, error-code-encoded-as-pointer is returned, not a NULL. To e=
xtract
> + * error code from such a pointer `libbpf_get_error()` should be used. I=
f
> + * `libbpf_set_strict_mode(LIBBPF_STRICT_CLEAN_PTRS)` is enabled, NULL i=
s
> + * returned on error instead. In both cases thread-local `errno` variabl=
e is
> + * always set to error code as well.
> + */
> +
> +LIBBPF_API struct btf *btf__parse_opts(const char *path, struct btf_pars=
e_opts *opts);
> +
>  LIBBPF_API struct btf *btf__load_vmlinux_btf(void);
>  LIBBPF_API struct btf *btf__load_module_btf(const char *module_name, str=
uct btf *vmlinux_btf);
>
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 3d53b1781af1..e9a7cb9c3c5b 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -415,5 +415,6 @@ LIBBPF_1.4.0 {
>                 bpf_token_create;
>                 btf__new_split;
>                 btf__new_split_base_ref;
> +               btf__parse_opts;

for the next revision, please put it into 1.5.0 section, we'll have
1.4 release soon, so let's avoid accidentally adding this back to 1.4

>                 btf_ext__raw_data;
>  } LIBBPF_1.3.0;

> --
> 2.39.3
>
