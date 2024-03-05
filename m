Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5725F171CC
	for <bpf@vger.kernel.org>; Tue,  5 Mar 2024 19:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709666969; cv=none; b=Low28z0jGzLtKhFwxq/MjSLTFQuPCbrQ4ucuFvzLEmhTiEfEZ6fzPMlI+C5zrA0sWEy8/eox6UOTlFU/3fIut78GY3YqsqwYyxJsfUOwn1KGun03bFRHQs3yxBxWYSokcHoCBxuzF6xhtWTtxgKwlG/jSGJTAN5OnRn/TBicX7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709666969; c=relaxed/simple;
	bh=0lbUjijKeovuimOFIZcZUjDBH8D3eTJ3Nim75r7NCV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aX3nE+yXgPzKr9KYR/s7vNl6KGvpXRU6h1x0Oi7wb0puf/wfc0A2aYzzuHQHa7KkW32MIa/Y6evLL+P+I04YA3ktbUy6cyrOTLRk7ZnZTx3NCB1CwedWZw5tP/H3bLXOly10nCzpHbciSkB4tl1BEhB5ENEE6yhaQfwoy88RLI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d+oieL5h; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+oieL5h"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5ce6b5e3c4eso4465620a12.2
        for <bpf@vger.kernel.org>; Tue, 05 Mar 2024 11:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709666967; x=1710271767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k5PSoJhtj/0hqw3yFY3M2h1d3fhh0a1ww6QhPEk+4dc=;
        b=d+oieL5huRHp7Una4mlmmSHS967dsxlE4fQiSsy066Ov84rlOLB3P5i7s3fRgidP4f
         v2D8zM4wSVptrZvKccyBwSNzyPCZ9mbQ3m8FINreTH4a9IKyCBy039Ke7GzKY5CBmc09
         VbfrZ6aOGvG390tnCscYohUXsQpX0r2yPgB8gL6HyZlOhjEkCVhK5aTPIVDS01wGRdkp
         NdpyRU1MOk6hCel8LwwRoIoHCqG+5WYpGTVlR7ZcdrOyGaqxFnHM5h0Qyr8FMn7sM2OX
         3JndwqlnUOY0Fqwl8GeomJLypF6SLpK1i8V4eImVrKPXqP5ge7XOQoLc6TY6xPLhBI7U
         Nu2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709666967; x=1710271767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k5PSoJhtj/0hqw3yFY3M2h1d3fhh0a1ww6QhPEk+4dc=;
        b=t01U7RotkRd8fYPg3hO7n3av4rV4RIGqjhfCTyCSDPoQMGIytmEkJj6ZPwXdnDv7db
         vWQkRbqRfT/sIyLUgdpEMMzQg8wHyXvOcyunJwjGPpa3Xjz3JlT+IONcRVbMYmkiX3Ci
         RlVMiUG8BDtKdmdYAOmEN6MfoPF7uU0GVEFM9xX63D19Kp2jVWmmkbZHUUEUoofnwiwJ
         3hOIANex9zUTkn3nlxf7OgzV/QVhtFzvM8FzoiEZIAafNbkdwiE5A6IMkX/KgT801Oip
         6Ee1sNA8daH61MYARyEkfb+mfir5MQLRXrZNvq4mAO15bc++na0LWqk0Zm1L15kBCyVf
         zbMw==
X-Gm-Message-State: AOJu0Yx6Rl0K51d44cap2e4r/R8nmEyiyFhClbP7r8/HZGeiaP1r4B++
	0cacq+fKX2glxuk0OhJDpaPfdxDqmoRE9p0NvT/GHZULxIFT79vkvICydN2wdve4dUpUwMnafmQ
	rFcjRbQLvFulkLlFLCOicLV7pPzg=
X-Google-Smtp-Source: AGHT+IHciPSraIVeUvcAXD0NLd6eCpA5DSSPEyyZ7aPejBkS7HXxtdG7ch0nE4W0V1+OvlJtuq9Eu36wFPei4HAbvhk=
X-Received: by 2002:a05:6a21:2d8e:b0:1a1:5505:df6c with SMTP id
 ty14-20020a056a212d8e00b001a15505df6cmr2744759pzb.43.1709666967640; Tue, 05
 Mar 2024 11:29:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304225156.24765-1-eddyz87@gmail.com> <20240304225156.24765-7-eddyz87@gmail.com>
In-Reply-To: <20240304225156.24765-7-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 5 Mar 2024 11:29:15 -0800
Message-ID: <CAEf4BzbhBw-xhiSoUAP5bXefSNiQwXY6eADk6fkLj=HCc6YbuQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 06/15] selftests/bpf: bad_struct_ops test
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, void@manifault.com, sinquersw@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 2:52=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> When loading struct_ops programs kernel requires BTF id of the
> struct_ops type and member index for attachment point inside that
> type. This makes it not possible to have same BPF program used in
> struct_ops maps that have different struct_ops type.
> Check if libbpf rejects such BPF objects files.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 24 +++++++++++++
>  .../selftests/bpf/bpf_testmod/bpf_testmod.h   |  4 +++
>  .../selftests/bpf/prog_tests/bad_struct_ops.c | 35 +++++++++++++++++++
>  .../selftests/bpf/progs/bad_struct_ops.c      | 25 +++++++++++++
>  4 files changed, 88 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/bad_struct_ops=
.c
>  create mode 100644 tools/testing/selftests/bpf/progs/bad_struct_ops.c
>

CI reports kernel crashes, so please check that, but overall things look go=
od:

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tool=
s/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> index b9ff88e3d463..2de7e80dbb4b 100644
> --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> @@ -610,6 +610,29 @@ struct bpf_struct_ops bpf_bpf_testmod_ops =3D {
>         .owner =3D THIS_MODULE,
>  };
>

[...]

> diff --git a/tools/testing/selftests/bpf/prog_tests/bad_struct_ops.c b/to=
ols/testing/selftests/bpf/prog_tests/bad_struct_ops.c
> new file mode 100644
> index 000000000000..9f5dbefa0dd9
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/bad_struct_ops.c
> @@ -0,0 +1,35 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <test_progs.h>
> +#include "bad_struct_ops.skel.h"
> +
> +static void invalid_prog_reuse(void)
> +{
> +       struct bad_struct_ops *skel;
> +       char *log =3D NULL;
> +       int err;
> +
> +       skel =3D bad_struct_ops__open();
> +       if (!ASSERT_OK_PTR(skel, "bad_struct_ops__open"))
> +               return;
> +
> +       if (start_libbpf_log_capture())
> +               goto cleanup;
> +
> +       err =3D bad_struct_ops__load(skel);
> +       log =3D stop_libbpf_log_capture();
> +       ASSERT_ERR(err, "bad_struct_ops__load should fail");

second argument isn't actually a test description, it's meant to be
used as a (relatively) short identifier of *what* is being checked
(see how ASSERT_xxx() macro are using them)

> +       ASSERT_HAS_SUBSTR(log,
> +               "struct_ops init_kern testmod_2 func ptr test_1: invalid =
reuse of prog test_1",
> +               "expected init_kern message");
> +
> +cleanup:
> +       free(log);
> +       bad_struct_ops__destroy(skel);
> +}
> +
> +void test_bad_struct_ops(void)
> +{
> +       if (test__start_subtest("invalid_prog_reuse"))
> +               invalid_prog_reuse();
> +}

[...]
