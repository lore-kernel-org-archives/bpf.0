Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA2724A1D
	for <bpf@vger.kernel.org>; Tue,  5 Mar 2024 19:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709668106; cv=none; b=ATWaWQ9GYnSX3EndPiAqbHJc+Qog2ROviGAvtCcE4/yLWZxyfS87A6e2qIhAXL6+2xIN08BUm6PwmUxnLANXMK44QawO1hwPn6dxmaWHW/+QAV2Av6dqG0sz2k7DrCO26/xjR+7NIOsWaSc2tVBWqsFGMbEjQjJlH8bGY3ilkCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709668106; c=relaxed/simple;
	bh=+fNedEtrDw+guKnTe9V7E1i1asrXKeG7lRchhCsP07c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OC38LNPx0BYvoNtWXloz50Mjy3qkv+LkAn4lENxTgL/NWII6mciUiZdUktVzNzrlt59VHssv6W1VtED1ClqJ3y+GKTYJjHBIyLrCxEiirJB0gDOkIKa1yLeOQB1LbMjBN8+RXi6hxGdGPvciTn+pnTm5Z2db0tT01uo19CEfChw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=evLfJ3+L; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evLfJ3+L"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e627596554so1910628b3a.2
        for <bpf@vger.kernel.org>; Tue, 05 Mar 2024 11:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709668104; x=1710272904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R1LqwjEE2t0US5cgX2iUuhvFybaqVn+kFFzY12lS8r0=;
        b=evLfJ3+Ls5BozlIlYYltnjEG2pKoKXvCfO3SJZVRvNW1nKibs0SJ6jVurMvR8F7bWV
         WBULcTiPRaYcfqNSq8sWpo88uq1LCehFWBjQl+aALH9vSxk5w/GubIWu8+Amktz5tzwo
         P6LHF90nG01nLSdFUO3mykmxLYkbrdJaWxPLnt+7BLkeoyZUghdYcfQc2zeoZB8UsFJ4
         qOqU0S5cxE2rC4Mhb9gJiTdCiI90vI8KCs4+LrXHSCL0u/TGJDcxRQPIs0oVo7BwCYYz
         f++1Wxq2toxeF7N0oBv0RyPcypL2YfxfL3LSGYIladoL1xmlzcifxIi3XyRznsPw5mzF
         xINA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709668104; x=1710272904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R1LqwjEE2t0US5cgX2iUuhvFybaqVn+kFFzY12lS8r0=;
        b=sf/ovfLWH4J0wh155ZYlE/iQri1wprmJ+pbZ1I1V1nFjUxgxB38sfHGB3UgHCuuWt5
         oPluPdQrQSEeywUIdXhT3IIohEgD7AWddKj78YFwsejQh6OqH/YlBPDhrhQQSW6ZTmnS
         LQcg43M9BX7NJUrj9dO8EF/dzziyi2U7488KXRbEoMjg0MiElbkWiuE45K+unyw8ipne
         pMe555ahCaEz8cfdhMOuRxaX879xqkrLJCK6ybNOQznemhYGrf9Fr1eb9pt0PdYSaS9P
         1hskE0EizScJLkFCgc7L9Jk+g5klok+VXLcy9UpFwx9LpzEE9c5eoyjOjMSV/k7mq2P4
         eYTg==
X-Gm-Message-State: AOJu0YyifFvEW/mE0wbkoP0nHLJqQSvyUXkO9G/cT1w1NrYzx7lWcl+1
	y95QV+iXb+5qHbcHS7u2ZnjHYVd7QQCYiANiC0gD4EH7CE5sD9RV7PlVUTUNDrliy8eBRyASewo
	ZU5L8joUEUQuh8bhixGwDgFOlyDU=
X-Google-Smtp-Source: AGHT+IFxr0Vwx24PeK4NXZeyiz+APyp6nOWTVHvOYjFJFTejBt33pBRHKsTo5ZzJhX0/pUdi8lUc/8UpNDArGLsOhn0=
X-Received: by 2002:a05:6a00:2308:b0:6e6:215b:fce7 with SMTP id
 h8-20020a056a00230800b006e6215bfce7mr7691822pfh.25.1709668104346; Tue, 05 Mar
 2024 11:48:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304225156.24765-1-eddyz87@gmail.com> <20240304225156.24765-10-eddyz87@gmail.com>
In-Reply-To: <20240304225156.24765-10-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 5 Mar 2024 11:48:12 -0800
Message-ID: <CAEf4Bzai=sr9yNareReh6bcEWXaHQQRnGzkkXSdvyu4z3M5p0g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 09/15] selftests/bpf: verify struct_ops
 autoload/autocreate sync
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, void@manifault.com, sinquersw@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 2:52=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> Check that autocreate flags of struct_ops map cause autoload of
> struct_ops corresponding programs:
> - when struct_ops program is referenced only from a map for which
>   autocreate is set to false, that program should not be loaded;
> - when struct_ops program with autoload =3D=3D false is set to be used
>   from a map with autocreate =3D=3D true using shadow var,
>   that program should be loaded;
> - when struct_ops program is not referenced from any map object load
>   should fail.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  .../selftests/bpf/prog_tests/bad_struct_ops.c | 32 ++++++++++++++
>  .../bpf/prog_tests/struct_ops_autocreate.c    | 43 +++++++++++++++++--
>  .../selftests/bpf/progs/bad_struct_ops2.c     | 14 ++++++
>  .../bpf/progs/struct_ops_autocreate2.c        | 32 ++++++++++++++
>  4 files changed, 117 insertions(+), 4 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/bad_struct_ops2.c
>  create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_autocrea=
te2.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/bad_struct_ops.c b/to=
ols/testing/selftests/bpf/prog_tests/bad_struct_ops.c
> index 9f5dbefa0dd9..6a707213e46b 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bad_struct_ops.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bad_struct_ops.c
> @@ -2,6 +2,7 @@
>
>  #include <test_progs.h>
>  #include "bad_struct_ops.skel.h"
> +#include "bad_struct_ops2.skel.h"
>
>  static void invalid_prog_reuse(void)
>  {
> @@ -28,8 +29,39 @@ static void invalid_prog_reuse(void)
>         bad_struct_ops__destroy(skel);
>  }
>
> +static void unused_program(void)
> +{
> +       struct bad_struct_ops2 *skel;
> +       char *log =3D NULL;
> +       int err;
> +
> +       skel =3D bad_struct_ops2__open();
> +       if (!ASSERT_OK_PTR(skel, "bad_struct_ops2__open"))
> +               return;
> +
> +       /* struct_ops programs not referenced from any maps are open
> +        * with autoload set to true.
> +        */
> +       ASSERT_TRUE(bpf_program__autoload(skel->progs.foo), "foo autoload=
 =3D=3D true");
> +
> +       if (start_libbpf_log_capture())
> +               goto cleanup;
> +
> +       err =3D bad_struct_ops2__load(skel);
> +       ASSERT_ERR(err, "bad_struct_ops2__load should fail");
> +       log =3D stop_libbpf_log_capture();
> +       ASSERT_HAS_SUBSTR(log, "prog 'foo': failed to load",
> +                         "message about 'foo' failing to load");
> +
> +cleanup:
> +       free(log);
> +       bad_struct_ops2__destroy(skel);
> +}
> +
>  void test_bad_struct_ops(void)
>  {
>         if (test__start_subtest("invalid_prog_reuse"))
>                 invalid_prog_reuse();
> +       if (test__start_subtest("unused_program"))
> +               unused_program();
>  }
> diff --git a/tools/testing/selftests/bpf/prog_tests/struct_ops_autocreate=
.c b/tools/testing/selftests/bpf/prog_tests/struct_ops_autocreate.c
> index 883f938d518c..35910cbb9ca4 100644
> --- a/tools/testing/selftests/bpf/prog_tests/struct_ops_autocreate.c
> +++ b/tools/testing/selftests/bpf/prog_tests/struct_ops_autocreate.c
> @@ -2,6 +2,7 @@
>
>  #include <test_progs.h>
>  #include "struct_ops_autocreate.skel.h"
> +#include "struct_ops_autocreate2.skel.h"
>
>  static void cant_load_full_object(void)
>  {
> @@ -43,10 +44,6 @@ static void can_load_partial_object(void)
>         if (!ASSERT_OK_PTR(skel, "struct_ops_autocreate__open_opts"))
>                 return;
>
> -       err =3D bpf_program__set_autoload(skel->progs.test_2, false);
> -       if (!ASSERT_OK(err, "bpf_program__set_autoload"))
> -               goto cleanup;
> -
>         err =3D bpf_map__set_autocreate(skel->maps.testmod_2, false);
>         if (!ASSERT_OK(err, "bpf_map__set_autocreate"))
>                 goto cleanup;
> @@ -67,10 +64,48 @@ static void can_load_partial_object(void)
>         struct_ops_autocreate__destroy(skel);
>  }
>
> +/* Swap test_mod1->test_1 program from 'bar' to 'foo' using shadow vars.
> + * test_mod1 load should enable autoload for 'foo'.
> + */
> +static void autoload_and_shadow_vars(void)
> +{
> +       struct struct_ops_autocreate2 *skel =3D NULL;
> +       struct bpf_link *link =3D NULL;
> +       int err;
> +
> +       skel =3D struct_ops_autocreate2__open();
> +       if (!ASSERT_OK_PTR(skel, "struct_ops_autocreate__open_opts"))
> +               return;
> +
> +       ASSERT_FALSE(bpf_program__autoload(skel->progs.foo), "foo default=
 autoload");
> +       ASSERT_FALSE(bpf_program__autoload(skel->progs.bar), "bar default=
 autoload");
> +
> +       /* loading map testmod_1 would switch foo's autoload to true */
> +       skel->struct_ops.testmod_1->test_1 =3D skel->progs.foo;
> +
> +       err =3D struct_ops_autocreate2__load(skel);
> +       if (ASSERT_OK(err, "struct_ops_autocreate__load"))
> +               goto cleanup;
> +
> +

let's assert autoload state here as well?

> +       link =3D bpf_map__attach_struct_ops(skel->maps.testmod_1);
> +       if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops"))
> +               goto cleanup;
> +
> +       /* test_1() would be called from bpf_dummy_reg2() in bpf_testmod.=
c */
> +       err =3D ASSERT_EQ(skel->bss->test_1_result, 42, "test_1_result");
> +
> +cleanup:
> +       bpf_link__destroy(link);
> +       struct_ops_autocreate2__destroy(skel);
> +}
> +
>  void test_struct_ops_autocreate(void)
>  {
>         if (test__start_subtest("cant_load_full_object"))
>                 cant_load_full_object();
>         if (test__start_subtest("can_load_partial_object"))
>                 can_load_partial_object();
> +       if (test__start_subtest("autoload_and_shadow_vars"))
> +               autoload_and_shadow_vars();
>  }
> diff --git a/tools/testing/selftests/bpf/progs/bad_struct_ops2.c b/tools/=
testing/selftests/bpf/progs/bad_struct_ops2.c
> new file mode 100644
> index 000000000000..64a95f6be86d
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/bad_struct_ops2.c
> @@ -0,0 +1,14 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +
> +char _license[] SEC("license") =3D "GPL";
> +
> +/* This is an unused struct_ops program, it lacks corresponding
> + * struct_ops map, which provides attachment information.
> + * W/o additional configuration attempt to load such
> + * BPF object file would fail.
> + */
> +SEC("struct_ops/foo")
> +void foo(void) {}
> diff --git a/tools/testing/selftests/bpf/progs/struct_ops_autocreate2.c b=
/tools/testing/selftests/bpf/progs/struct_ops_autocreate2.c
> new file mode 100644
> index 000000000000..6049d9c902d3
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/struct_ops_autocreate2.c
> @@ -0,0 +1,32 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +char _license[] SEC("license") =3D "GPL";
> +
> +int test_1_result =3D 0;
> +
> +SEC("?struct_ops/test_1")
> +int BPF_PROG(foo)
> +{
> +       test_1_result =3D 42;
> +       return 0;
> +}
> +
> +SEC("?struct_ops/test_1")
> +int BPF_PROG(bar)
> +{
> +       test_1_result =3D 24;
> +       return 0;
> +}
> +
> +struct bpf_testmod_ops {
> +       int (*test_1)(void);
> +};
> +
> +SEC(".struct_ops.link")
> +struct bpf_testmod_ops testmod_1 =3D {
> +       .test_1 =3D (void *)bar
> +};
> --
> 2.43.0
>
