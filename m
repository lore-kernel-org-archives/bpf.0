Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F575128817
	for <bpf@vger.kernel.org>; Tue,  5 Mar 2024 21:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709674835; cv=none; b=TaFi/GJXw/Fgc/7oNxBi6eWRMYX81SefVfpNvXPSpHMM/LnqX3UzmvOcA+pq7hgCrPqCTtIKx2J6pKybfQql1phT5H+fsku6CEufuEeOxelaJPXYvczmCRO1ftgZjOZtZexKWG0ypjuR+HqWFINfyJPMHa5VNZgAOKr6b9i79H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709674835; c=relaxed/simple;
	bh=bqdBo9QBrGaIMrkDZ/U6rQQonTE1Wr4AjCV+ob/aIRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H1PC/hXn/56X7K+FuL5xPrT8TDq5U+sGQX0LXn07Eb9Bb33JCP/0O8jxidznmX23nWEv2pM4A51a0epo+TF+hmcG4BWWNc+c/lTXgd+SXtUZJ/W54bw9Q520vPwUR+IzgOg3KsKmVNEsUBMb4SeVi/PyQiYjZOql5G3JekRRS5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qh8fDKCu; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qh8fDKCu"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e56787e691so170663b3a.0
        for <bpf@vger.kernel.org>; Tue, 05 Mar 2024 13:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709674833; x=1710279633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w5VaGwcXsUiOjqdehXLk4iOjdbpWD4QCTNfxxKLumZ4=;
        b=Qh8fDKCux/5bt9cGIIauD1hXKLf7zwWLbn1YXFJwB1zXFFDM58qNHbSwJ1WuExMuhX
         MwA3vQnYE7I6Pl1eeVsDdeb4K1i1pldwl9QxYfAvUD4WUZfruIuAp7POjeQ6sTqYhtPN
         X6u6yuqAQAv0Akg+/QoHQy9C1bchOfGvdUyG98m0Xuluna9ZxBuPHAx0dLUiXe6eLzim
         GN7Rq9S2zS+amtpmgBfub6DEh1r3UGDC5hvlFocSBVThVtc9FYBwcNZWMhXig96WN6a+
         WNcDYv0OtlNa8HQoVTYG4xjP9oIg3nQzyJ5P7WhVpi50apcEl5oHm6krNeZpi6VaIYKw
         ORjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709674833; x=1710279633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w5VaGwcXsUiOjqdehXLk4iOjdbpWD4QCTNfxxKLumZ4=;
        b=C+WunGzn8GjROhDUH8oZzqgxDwFbBjzqvZOqL2MQ9Azzt82o1kSMvgFZQSTnNIaU79
         f7vxHBBsOb9ZJBXkoWQ5E4a7QDBL7BgeNJKJnyahBdWPGBRphpVQ7YoU8vPpznc36lnx
         ZNQSJlXlANwPH6GkUj0rk0rlz8VYU5k8BNMlk8E3nfLerxUtcgf1hTCTXJkUL3id1/mo
         2Y895/yn7YUrhql7KB0Z9m7aNzORSM7SDb0zgJSF2sUoyePqePoJDrFkchGDIuYUZQ3t
         WyLCZAyPX5sCEKTahJ7HUQSxU/fcpnO4NBIfhhkXtwjXp25lhlM0+sl6vr9qssMH+ZX7
         9mPQ==
X-Gm-Message-State: AOJu0YxGBzoJ9VWCiBhsdWiB3udFjosIWRiLT7sit7bmiblFHZbmPPb7
	wNVbNHZga2B8w7/f1LfCXUOCl55BiS7OyHLdAST+03hHMPId175p5prtODN9dTYJa79B0YnXUID
	USl1xrUtbqiQ/6LJJgc8zDj7F1ps=
X-Google-Smtp-Source: AGHT+IFY0YyVy1bOOSx+mdfbcegwBIuN6e+GbewWkSdzQi706Em91DBAUrhVlU5sfdil/TLqIPkmSBSNmsVz9yVtRYY=
X-Received: by 2002:a05:6a20:9150:b0:1a1:4aea:c665 with SMTP id
 x16-20020a056a20915000b001a14aeac665mr4023588pzc.19.1709674832744; Tue, 05
 Mar 2024 13:40:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304225156.24765-1-eddyz87@gmail.com> <20240304225156.24765-14-eddyz87@gmail.com>
In-Reply-To: <20240304225156.24765-14-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 5 Mar 2024 13:40:20 -0800
Message-ID: <CAEf4BzYkAKW6dq6r+ircdES6x4hpooA-U3Mgm5mLGW1rhp8Ybw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 13/15] selftests/bpf: test case for SEC("?.struct_ops")
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, void@manifault.com, sinquersw@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 2:52=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> Check that "?.struct_ops" and "?.struct_ops.link" section names define
> struct_ops maps with autocreate =3D=3D false after open.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  .../bpf/prog_tests/struct_ops_autocreate.c    | 58 +++++++++++++++++--
>  .../bpf/progs/struct_ops_autocreate.c         | 10 ++++
>  2 files changed, 62 insertions(+), 6 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/struct_ops_autocreate=
.c b/tools/testing/selftests/bpf/prog_tests/struct_ops_autocreate.c
> index 35910cbb9ca4..a89ba036e2e2 100644
> --- a/tools/testing/selftests/bpf/prog_tests/struct_ops_autocreate.c
> +++ b/tools/testing/selftests/bpf/prog_tests/struct_ops_autocreate.c
> @@ -34,10 +34,24 @@ static void cant_load_full_object(void)
>         struct_ops_autocreate__destroy(skel);
>  }
>
> +static int check_test_1_link(struct struct_ops_autocreate *skel, struct =
bpf_map *map)
> +{
> +       struct bpf_link *link;
> +       int err;
> +
> +       link =3D bpf_map__attach_struct_ops(skel->maps.testmod_1);
> +       if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops"))
> +               return -1;
> +
> +       /* test_1() would be called from bpf_dummy_reg2() in bpf_testmod.=
c */
> +       err =3D ASSERT_EQ(skel->bss->test_1_result, 42, "test_1_result");
> +       bpf_link__destroy(link);
> +       return err;
> +}
> +
>  static void can_load_partial_object(void)
>  {
>         struct struct_ops_autocreate *skel;
> -       struct bpf_link *link =3D NULL;
>         int err;
>
>         skel =3D struct_ops_autocreate__open();
> @@ -52,15 +66,45 @@ static void can_load_partial_object(void)
>         if (ASSERT_OK(err, "struct_ops_autocreate__load"))
>                 goto cleanup;
>
> -       link =3D bpf_map__attach_struct_ops(skel->maps.testmod_1);
> -       if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops"))
> +       check_test_1_link(skel, skel->maps.testmod_1);
> +
> +cleanup:
> +       struct_ops_autocreate__destroy(skel);
> +}
> +
> +static void optional_maps(void)
> +{
> +       struct struct_ops_autocreate *skel;
> +       int err;
> +
> +       skel =3D struct_ops_autocreate__open();
> +       if (!ASSERT_OK_PTR(skel, "struct_ops_autocreate__open"))
> +               return;
> +
> +       err  =3D !ASSERT_TRUE(bpf_map__autocreate(skel->maps.testmod_1),
> +                           "default autocreate for testmod_1");
> +       err |=3D !ASSERT_TRUE(bpf_map__autocreate(skel->maps.testmod_2),
> +                           "default autocreate for testmod_2");
> +       err |=3D !ASSERT_FALSE(bpf_map__autocreate(skel->maps.optional_ma=
p),
> +                            "default autocreate for optional_map");
> +       err |=3D !ASSERT_FALSE(bpf_map__autocreate(skel->maps.optional_ma=
p2),
> +                           "default autocreate for optional_map2");
> +       if (err)
>                 goto cleanup;

The above is a bit ugly. I think we can keep it simple just by not
exiting early, just do

ASSERT_TRUE(...);
ASSERT_TRUE(...);
ASSERT_FALSE(...);
ASSERT_FALSE(...);

.. then continue to bpf_map__set_autocreate() tests, even if previous
assertions already failed.

Nothing will crash, you'll just get more errors, potentially (because
some preconditions weren't set correctly or something).

>
> -       /* test_1() would be called from bpf_dummy_reg2() in bpf_testmod.=
c */
> -       ASSERT_EQ(skel->bss->test_1_result, 42, "test_1_result");
> +       err  =3D bpf_map__set_autocreate(skel->maps.testmod_1, false);
> +       err |=3D bpf_map__set_autocreate(skel->maps.testmod_2, false);
> +       err |=3D bpf_map__set_autocreate(skel->maps.optional_map2, true);
> +       if (!ASSERT_OK(err, "bpf_map__set_autocreate"))
> +               goto cleanup;
> +
> +       err =3D struct_ops_autocreate__load(skel);
> +       if (ASSERT_OK(err, "struct_ops_autocreate__load"))
> +               goto cleanup;
> +
> +       check_test_1_link(skel, skel->maps.optional_map2);
>
>  cleanup:
> -       bpf_link__destroy(link);
>         struct_ops_autocreate__destroy(skel);
>  }
>
> @@ -108,4 +152,6 @@ void test_struct_ops_autocreate(void)
>                 can_load_partial_object();
>         if (test__start_subtest("autoload_and_shadow_vars"))
>                 autoload_and_shadow_vars();
> +       if (test__start_subtest("optional_maps"))
> +               optional_maps();
>  }
> diff --git a/tools/testing/selftests/bpf/progs/struct_ops_autocreate.c b/=
tools/testing/selftests/bpf/progs/struct_ops_autocreate.c
> index 9a951ee6f55c..ba10c3896213 100644
> --- a/tools/testing/selftests/bpf/progs/struct_ops_autocreate.c
> +++ b/tools/testing/selftests/bpf/progs/struct_ops_autocreate.c
> @@ -40,3 +40,13 @@ struct bpf_testmod_ops___v2 testmod_2 =3D {
>         .test_1 =3D (void *)test_1,
>         .does_not_exist =3D (void *)test_2
>  };
> +
> +SEC("?.struct_ops")
> +struct bpf_testmod_ops___v1 optional_map =3D {
> +       .test_1 =3D (void *)test_1,
> +};
> +
> +SEC("?.struct_ops.link")
> +struct bpf_testmod_ops___v1 optional_map2 =3D {
> +       .test_1 =3D (void *)test_1,
> +};
> --
> 2.43.0
>
