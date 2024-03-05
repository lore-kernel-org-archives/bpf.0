Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F4E84FC1
	for <bpf@vger.kernel.org>; Tue,  5 Mar 2024 19:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709668032; cv=none; b=kpafbUFjJrP1wRY1WVMGDjMHt6Ps8d6fScD4L5kege+txibVGhwWq/ou3lpkLxna7X8EZcF28KVM+b+lgCdF9L12PiaO2P/eJggi0GdbI7ixnHjElKG7O3fObFfJI8UQ6IFDoAgF7rKXUUY9njaRJfbzbKzZdb5ZXSq0pIt18Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709668032; c=relaxed/simple;
	bh=WTWrGVHQ3dEak37wxbfwvD+Ns1S8XH138hkAJkXnfok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TO061k90lj1WinGreJJhwYTIqEDwubhd5wRZ4U7O1CZI1v4v4pDCeq52lQLciKmcbxVqbbPAwqZ0S3MxU8ZL1PcPP5vE6JERJwL5g6Rre5WyKA613ZqiLjln3AncelEsqwcXzPQc6Bhg2f1q7JCKng7Rs9slhEDufVm/x/w/OO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SI9oWGhd; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SI9oWGhd"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5d8b887bb0cso81398a12.2
        for <bpf@vger.kernel.org>; Tue, 05 Mar 2024 11:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709668030; x=1710272830; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6RheQJ/8E72PkkCNc/ypf00eera2nRvF6mGI5bOqH2M=;
        b=SI9oWGhddnvCugvKvfA6GOMKZwqZDttG7Ak8K4FnVxn7dHr2RKfIDHhRY1zq8mTKJc
         lIwl/XqBqTj7UtyWtlizocP6wQGxCHIGfPN6L7HGPPCy9ve976Bb4ocY6jMXAPNIycfV
         uWDZFpr7XmGsM653/r350AJx14F/mDOx870n8SyntS2+ctd/wN/CwfhCTDGDbpHo+AGE
         cwrFB8kTo5lsearKEMZn1CtDCJU6Jz+IsOD1xjsoId4NX+eUHGuOjfE6LTtL9rZV/3yZ
         p0KTPmvDWh9QTpZtGN7hcwJN/tY6Tw2eAFR0i6nNJNJF8LknkBO3+2l6Z2VCBxBdb9y6
         PEjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709668030; x=1710272830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6RheQJ/8E72PkkCNc/ypf00eera2nRvF6mGI5bOqH2M=;
        b=Lxw9Ppn/SqCwsWfFQCrvu9hjLUoN5Yq83ZvdDYkHiiIIyNpRT+XFvdqr7+i6A65YKj
         VrzCHA+cHp0CNT0oEQcZSsWNP2ODjE7V3wvT+/PDfw/QP0+GN67thiEn15BALdQJRP+k
         Dxm9pHKWqgSxpVJIJ1oBtPP8TD4jOeNRvO8v5xRkuYrUSdAWjsHOuhqA7w1UiOFFmWhF
         V1vw9wYVuqMhJWJB25uMx/lVpIdMzGQ2dut8B1kyEMmJHDZFiDcZd/Ybj2oQSb7z1zWn
         Xe4ni1rNYBxBQdsV0gzYP3UxdYg+YhQScz7YuqcC/l+DU7UKrhair+nAZrIHvYZD7tce
         H7sQ==
X-Gm-Message-State: AOJu0YxPOH95DttFdk0/8N+wj2kOQsZofR8EBn38Dd4Afz6dL4RL6V2W
	b85+Q8hye4PVl5vcs7kbIlqLDg5jCDmsbtg4sVwucT5v9OpmNFpCee3X9czpCbuEb//x6yRXUpI
	s8z+CZf5ns4nOOXJGGCWc2eIvG9Q=
X-Google-Smtp-Source: AGHT+IErUEVIRs8479IIwXHq01g7uiGKrShW7OHrZpLSBe52XO4zKjSkUJRZcGGwcNp0bObbjUwGTatBXspBBsN31Aw=
X-Received: by 2002:a05:6a21:a582:b0:1a0:eea4:c612 with SMTP id
 gd2-20020a056a21a58200b001a0eea4c612mr2401966pzc.11.1709668029956; Tue, 05
 Mar 2024 11:47:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304225156.24765-1-eddyz87@gmail.com> <20240304225156.24765-9-eddyz87@gmail.com>
In-Reply-To: <20240304225156.24765-9-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 5 Mar 2024 11:46:57 -0800
Message-ID: <CAEf4BzYMJftu7S0AUZ2BdU6c70sVNX69kXS0kpWK2vheGMP7Qw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 08/15] libbpf: sync progs autoload with maps
 autocreate for struct_ops maps
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, void@manifault.com, sinquersw@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 2:52=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> Automatically select which struct_ops programs to load depending on
> which struct_ops maps are selected for automatic creation.
> E.g. for the BPF code below:
>
>     SEC("struct_ops/test_1") int BPF_PROG(foo) { ... }
>     SEC("struct_ops/test_2") int BPF_PROG(bar) { ... }
>
>     SEC(".struct_ops.link")
>     struct test_ops___v1 A =3D {
>         .foo =3D (void *)foo
>     };
>
>     SEC(".struct_ops.link")
>     struct test_ops___v2 B =3D {
>         .foo =3D (void *)foo,
>         .bar =3D (void *)bar,
>     };
>
> And the following libbpf API calls:
>
>     bpf_map__set_autocreate(skel->maps.A, true);
>     bpf_map__set_autocreate(skel->maps.B, false);
>
> The autoload would be enabled for program 'foo' and disabled for
> program 'bar'.
>
> During load, for each struct_ops program P, referenced from some
> struct_ops map M:
> - set P.autoload =3D true if M.autocreate is true for some M;
> - set P.autoload =3D false if M.autocreate is false for all M;
> - don't change P.autoload, if P is not referenced from any map.
>
> Do this after bpf_object__init_kern_struct_ops_maps()
> to make sure that shadow vars assignment is done.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  tools/lib/bpf/libbpf.c | 48 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 25c452c20d7d..ce39ae34fec0 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -1031,6 +1031,53 @@ static bool is_valid_st_ops_program(struct bpf_obj=
ect *obj,
>         return false;
>  }
>
> +/* For each struct_ops program P, referenced from some struct_ops map M,
> + * enable P.autoload if there are Ms for which M.autocreate is true,
> + * disable P.autoload if for all Ms M.autocreate is false.
> + * Don't change P.autoload for programs that are not referenced from any=
 maps.
> + */
> +static int bpf_object__adjust_struct_ops_autoload(struct bpf_object *obj=
)

nit: we try not to use double underscore separate for non-public
internal helper functions (see bpf_object_init_prog_arrays and
bpf_object_prepare_struct_ops)

> +{
> +       struct bpf_program *prog;
> +       struct bpf_map *map;
> +       int i, j, k, vlen;
> +       struct {
> +               __u8 any_map_autocreate:1;
> +               __u8 used_in_struct_ops_map:1;
> +       } *refs;

bit masks just for this to save a few bytes?...

but generally, how about we keep all this much dumber:

for (each program) {
    int use_cnt =3D 0;
    int should_load =3D false;

    if (!is_struct_ops_program)
        continue;
    for (each map) {
        if (!is_struct_ops_map)
            continue;
        for (each prog entry in map->st_ops->progs[]) {
            if (prog !=3D slot_prog)
                continue;
            use_cnt++;
            if (map->autocreate)
               should_load =3D true;
        }
    }
    if (use_cnt)
        prog->autocreate =3D should_load;
}


Sure it does a few more iterations, but we avoid unnecessary
allocation/cleanup and keep things literally working how you describe
in your comment.

WDYT?

> +
> +       refs =3D calloc(obj->nr_programs, sizeof(refs[0]));
> +       if (!refs)
> +               return -ENOMEM;
> +
> +       for (i =3D 0; i < obj->nr_maps; i++) {
> +               map =3D &obj->maps[i];
> +               if (!bpf_map__is_struct_ops(map))
> +                       continue;
> +
> +               vlen =3D btf_vlen(map->st_ops->type);
> +               for (j =3D 0; j < vlen; ++j) {

nit: stay consistent with ++j vs j++?

> +                       prog =3D map->st_ops->progs[j];
> +                       if (!prog)
> +                               continue;
> +
> +                       k =3D prog - obj->programs;
> +                       if (k < 0 || k > obj->nr_programs)

>=3D ? But a clever trick, I like it!

> +                               continue;
> +
> +                       refs[k].used_in_struct_ops_map =3D true;
> +                       refs[k].any_map_autocreate |=3D map->autocreate;
> +               }
> +       }
> +
> +       for (i =3D 0; i < obj->nr_programs; ++i)
> +               if (refs[i].used_in_struct_ops_map)
> +                       obj->programs[i].autoload =3D refs[i].any_map_aut=
ocreate;
> +
> +       free(refs);
> +       return 0;
> +}
> +
>  /* Init the map's fields that depend on kern_btf */
>  static int bpf_map__init_kern_struct_ops(struct bpf_map *map)
>  {
> @@ -8163,6 +8210,7 @@ static int bpf_object_load(struct bpf_object *obj, =
int extra_log_level, const ch
>         err =3D err ? : bpf_object__resolve_externs(obj, obj->kconfig);
>         err =3D err ? : bpf_object__sanitize_maps(obj);
>         err =3D err ? : bpf_object__init_kern_struct_ops_maps(obj);
> +       err =3D err ? : bpf_object__adjust_struct_ops_autoload(obj);
>         err =3D err ? : bpf_object__relocate(obj, obj->btf_custom_path ? =
: target_btf_path);
>         err =3D err ? : bpf_object__sanitize_and_load_btf(obj);
>         err =3D err ? : bpf_object__create_maps(obj);
> --
> 2.43.0
>
