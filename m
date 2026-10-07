Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C18440633
	for <bpf@vger.kernel.org>; Wed,  7 Oct 2026 22:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791411867; cv=pass; b=LFAr38HW7RA3wLgOWRMPZYq51LJJbbgwcN9PbnhIFEM3GfNyBY4Q1u1eoe2ClaTveSFwfE/Qoqu6EeLwz09ZGu+8foR/yyh+JV9rI2FgE/wt28JV4sDc5WtTiTVfZLnE/1+vZ3sC7MpUtxDbP08X/QVmnRVDDYNAAQ/xC3oVXsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791411867; c=relaxed/simple;
	bh=j1hldUczhaCmA9pPT03tsjvi/psIdM+Fkc0aCRQs3iY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ELBI6dLAVUabGyd8V9SF8mu3q8crEO1KIHojYmpCD74aLNgDmd729lSGzmX/DulpcS905UZ6ICwi9FHD8fDfHMHOEoyE++5J+MCZIm6dVrXjUm5N4Nu8Z1CDxO16BYisabgnf+XZmEEFo8uMyBbzyYe4w+1Nquasu0iZjCHwJ+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m/dl1cB6; arc=pass smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/dl1cB6"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-4f66bb2ab57so1062061b6e.3
        for <bpf@vger.kernel.org>; Wed, 07 Oct 2026 15:24:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791411865; cv=none;
        d=google.com; s=arc-20260327;
        b=CL8nwn3o5yKL4OdwKcsdiGSo//GkVNwrKrmXUlfZYxy7dex43K9ugg5R67E9egiP5F
         pNgDWeF3aQkbQ5wXAWtYKskkmiw07Jb2mStzieV/WdwkDqd/UWpRd/9KiV72OxzU7z3T
         pJFoDhnp6AIhCuhOjwF0xPy61gR16A895I8ykQJ5Tb3KJURgbVOFipGb/vs1wDohkFHN
         4YX95z6qC6Wieljm+wxj7TPsUgVjAFyGQZucpG6bLOe1OJZZfgiokqqI0Zaox+TI3NHt
         Zu4+n1tvGsiZN/JNoPzoTNXxBYyQ1OZXORUa+x3HtLK2WMx9ER5mqVi/JBEBvcxrPWA2
         ArOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S2K8HbBhL2mL5g4N2SG5IxowUfPkOB88+AD/Ddc3DyM=;
        fh=aBkD6WZyTTfsMP8yLE2GbSge/Q+kL379OLTdBErkPdc=;
        b=NJAGVqVpkeBjzNML82NjqiYbb2megHajNxO160q9OrE7LbMHLjy3P2fuugN/nx51nq
         a7yuzTYM9TmDhsS5e2O0HASXBVD8pZOcnHQIzHYDyo+ca9ExhkCj2JI3aldSdGSTkweL
         weCNvlbswi96GuMWGZOhiAwuwhPEkA0d2VL+J8j6w+Om0dXtT9zF/uU0fokIXa6s5ZwM
         nBoApV7HlNZa5P3zhXUUi9oHq+bOQj4z6/uJ32jFuaXuMc14kKLEQNq5ZipFjTu/sJrd
         a3yTsiDAXFKoAjheLfUG0OIpKPbMkh1t+9ACyvvQt3ut7P4494yiOi+HUijrBPW09kFf
         8Ojg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791411865; x=1792016665; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S2K8HbBhL2mL5g4N2SG5IxowUfPkOB88+AD/Ddc3DyM=;
        b=m/dl1cB6TDZfYKeGU5JcD6RqTzO6S/5Dj4fECxD8A8ae5TgjwrK4OPDt1Eruhh063a
         HWjqNvgBoYFSxGrE0p5SdHm5IPKitus9iZeKz0A3uB9qOFRDn5fJB+2sxXwQ9OxlbKvr
         KcBDRMjvt1CZ6DLtEalQltXc9Ubk2SKa87agg/slsfkzS586CvJKQR1vFM1m7gXkll7c
         UuQiAPrHx+uZ58E25DxFaU61Bxe8CVp2DgtQpDpCfrgxnsBx7BNwO4rzftkP533KhGmU
         V+GDgX6JbZepzmCa7zq6a4hvB468N/lcxA3YKJ5fP7bvubXUe85PQogt4QGUMRSzwwNH
         eg7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791411865; x=1792016665;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S2K8HbBhL2mL5g4N2SG5IxowUfPkOB88+AD/Ddc3DyM=;
        b=hnPT5/489LCamKOyPALioVZ7MQXaChetOTb2oCtLT8TkC6ZVC2ehUqM57sOhxvL0ZB
         mAZb8ubFYY1sUwXIFSlULs/dyPXtNP8+xKMDFhWI+2QQ4z5Lkdc0VRPAqI8/E+zECOq3
         AWH3+LhhCKTiu34enCRvoiCgS3Gz2/Hh5Ll7hkAp746Q6x6jiVrnpvfXodrTf+Acoeff
         UP4VYl6d3aVFEzcCvEZEP8f/UWzR0LFJ/OMbgzYwRc0FvGDNzbB4SYtgQ0oDIJCPa92M
         02XppfZbL+oONqHiRGbBEAWl1SLBup5iHIgQar2cv6gTod59S4wzqG5BWOPguh1ZVzWV
         ETCg==
X-Forwarded-Encrypted: i=1; AKwUvBwTSY/8yNI0kQiPFLZThvmHQHpuL+bfBV1FGR2CpCV0IP2Z+SkXyPxwUz77lKYiZx98GWQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mv6F3me/QjB++SmS4I6z/laihPkHpgm6iV+EUllI9scOupqrjo
	vI0pX3hUI630z+MBqOhj2UR25xb4tKBOByZ3ffbLcGllRJD7sxOPsYH/afuBTde5gzlvEDphwk/
	+rsM3FLOTaUJGt0bXtCvtz2GCl1XcNLU=
X-Gm-Gg: AYBFou2xLLUR5rMLczjjdxqioPYuO+4UVajrm2sNJbe/yyURfRYfLmmjYYHme1ploJ9
	RGsGtu3npfETlTuUrmJ3NEf+z3/RzV3kODcglUoqKcgQ8AP4pC8u2XKIaO8hShNbGm38pM8d9YW
	wWUGYyGshUc6DHKdZBc9qxp8KemO7VyDtUS/i3TJAvmCRwonOoJ3f1pb2ZeNd4XM63G+R/yAZXe
	apgsF0wKTLLkGs43eATLXwZkxbinAgs5XxPyGkw9I/iLe2GfDWub9dLTbAitJPnb14fURQvCTKM
	zsYWwnee7I6Ysn42vJvNy2rPmn0ccO6Zw0vUiQJKqUqCT8xJmPzKwoU8HsKKBt7UVA==
X-Received: by 2002:a05:6808:c18f:b0:4f6:1336:cdf9 with SMTP id
 5614622812f47-4fc4677cbffmr3710852b6e.35.1791411864709; Wed, 07 Oct 2026
 15:24:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007-a3-arg-trusted-v4-v4-0-253ef3a1a69a@mails.tsinghua.edu.cn>
 <20261007-a3-arg-trusted-v4-v4-2-253ef3a1a69a@mails.tsinghua.edu.cn>
In-Reply-To: <20261007-a3-arg-trusted-v4-v4-2-253ef3a1a69a@mails.tsinghua.edu.cn>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 7 Oct 2026 15:24:13 -0700
X-Gm-Features: AclHuK9gTsp7jsRrpHs1cx8Ph74rNFmBjbvSX0u-AULTjQs9ENLQ5IRNn8neVso
Message-ID: <CAMB2axPoPSJen57E2Suc1hFcwhHJjjEruC+8tthRA+-JhDA6Og@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/2] selftests/bpf: Cover trusted BTF ID
 argument provenance
To: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Brahmajit Das <listout@listout.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 7, 2026 at 9:25=E2=80=AFAM Yiyang Chen
<chenyy23@mails.tsinghua.edu.cn> wrote:
>
> Extend verifier_global_ptr_args.c with calls that pass bare and
> RCU-protected task pointers to a global __arg_trusted parameter. Both
> calls must be rejected because neither pointer is referenced or trusted.
>
> Add paired test-module kfuncs that return and accept a nullable trusted
> task pointer. Passing the return value directly must succeed, covering
> PTR_TRUSTED | PTR_MAYBE_NULL handling in the common argument checker.
>
> Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>

Reviewed-by: Amery Hung <ameryhung@gmail.com>

> ---
>  tools/testing/selftests/bpf/progs/iters_testmod.c  | 11 +++++++
>  .../selftests/bpf/progs/verifier_global_ptr_args.c | 35 ++++++++++++++++=
++++++
>  .../testing/selftests/bpf/test_kmods/bpf_testmod.c | 11 +++++++
>  .../selftests/bpf/test_kmods/bpf_testmod_kfunc.h   |  2 ++
>  4 files changed, 59 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/iters_testmod.c b/tools/te=
sting/selftests/bpf/progs/iters_testmod.c
> index f65cc9766633e..145750bb64ef8 100644
> --- a/tools/testing/selftests/bpf/progs/iters_testmod.c
> +++ b/tools/testing/selftests/bpf/progs/iters_testmod.c
> @@ -46,6 +46,17 @@ int iter_next_trusted_or_null(const void *ctx)
>         return 0;
>  }
>
> +SEC("syscall")
> +__success
> +int trusted_nullable_kfunc(const void *ctx)
> +{
> +       struct task_struct *task;
> +
> +       task =3D bpf_kfunc_trusted_null_test();
> +       bpf_kfunc_trusted_nullable_test(task);
> +       return 0;
> +}
> +

nit: tools/testing/selftests/bpf/progs/test_kfunc_param_nullable.c
feels like a better place than iters_testmod.c for the test.
