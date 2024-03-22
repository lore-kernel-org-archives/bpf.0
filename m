Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823605674C
	for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 16:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711124053; cv=none; b=rloAYu/TRsl53rDXX14YTrhZwCZQcvktN29zHxvV9gPe3M43IMf2/zZr8yEsDB/54YNjcW4XMPp0HmJzbDRz+WuM1r+WrgTddQthszVI0OTZxtd00T+YCWawSBqqvkzOdP+nfjHJ1XD34OgEAYlPzz64yTKMF99SbtIpRJJ2GXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711124053; c=relaxed/simple;
	bh=/yzI5XshXGTpFrwyAuSr0xFZ09Mhg7p7WUvGqSqeeQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a2YB0+Ymzzsqpj7qs18IEr7VHrl5PjfWhZigzB39dIR/n19Df8dWXf8PD2ey1ClEf0GyAGEyQXCCpD/RPzNNv+DBAkqDZIjqrCp+Lwr7/BgEKCFSmg/RUs82lySusFZkkpi5jNDhf6qjy2vR5b2B1KMwDi8zRH3OvpGXFaBA5kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HrBqZapn; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HrBqZapn"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5e8470c1cb7so1495816a12.2
        for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 09:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711124051; x=1711728851; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=taBJ85yad02Lo6nYJlrnb2BH0iJc4atw+xcI6vfeVDk=;
        b=HrBqZapn7KxF7Bpn95oJRtk2jXg5ng+lQ2Iotq57lPS3tjp4KQ4TBETKpW9MBt4w2R
         yNn5uA8Buxg/rag8KhG8hW3HFNqYFjotZKQKPW6tdeNjegrUyvTGQ6xfBh3sDi1CzXjC
         ihaQhfaaZAZYhlTvoVZjMcZ2/XGdBf2PYMfN9aY9fAoqlg/rTFMJQkIh/v/E+6b4qDdf
         OZg+7ZRANXqr9xZyNiCof7iYby+dUtilitHMj8eTi6rKYkSiN3FJ0BA7KqL9WkzEM5xP
         y9R+65FZQdfasKWzIxHh+WZ+8PbZEAEY04E74CH8D7cOtEoGWEhglzKy8C9dpHj8/a3f
         eRkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711124051; x=1711728851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=taBJ85yad02Lo6nYJlrnb2BH0iJc4atw+xcI6vfeVDk=;
        b=VJ+mQ6ZGEaE90pT7GWkltpNYclJr698A8A9Dezj9EP6s7rKAwy/7eK2pyzNmEpy6vs
         gElWVVWzzRGxOT+P+iVbXNht72eDmrhFEgvmfkzVezO57mq749a/BQvbY297M5a3F8+O
         OVaQUqCSmZfQZYV9UPTA8aifz9cCgZTVG6DHQJozrTxFUVNaAIxldPeZpkqavYNkNwsS
         s9O9qdkMIJsBjrdkC6B+uk7Nv8seZ2kiZoq54QMhZZvypxH+ruJaerMyhoL6l7DrkrSa
         NWSxUmlhMYP7NQj0G10D1o8w0SDcUjpVDtnBaDNA884FFx6Y5RorbZ2QAm9ovGAe+jXq
         oM/w==
X-Gm-Message-State: AOJu0Yw9FAgjfRE1himF/cX0FaGQCEnmKFJwlToXDtcZbL3yfL0x2jGa
	08Ps5m2MDp698VYK2odmLHduJIL2B6pI9uXcfKsaa6/xw3foiXNeak4KU1LSYtHwOM2xvLf6NH1
	wLrmXyvWjfqYkzzEn3JoPxuoVkJg=
X-Google-Smtp-Source: AGHT+IEmTWCUxNIbE7GrSpNcm6ypa8VJ9H5/G/j6yu5sEsnuqOSgJ6DziJalj8T1LJIfDOGwb3b03J6ys02nMF1vIwc=
X-Received: by 2002:a17:90a:d710:b0:29c:7592:febf with SMTP id
 y16-20020a17090ad71000b0029c7592febfmr92972pju.16.1711124050605; Fri, 22 Mar
 2024 09:14:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321200058.2218328-1-yonghong.song@linux.dev> <20240321200103.2218888-1-yonghong.song@linux.dev>
In-Reply-To: <20240321200103.2218888-1-yonghong.song@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 22 Mar 2024 09:13:57 -0700
Message-ID: <CAEf4BzZnaWjyUBonL=YBFS+9z7E_FBcJAwEaYuDGGrA-Z6zZ0Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/5] selftests/bpf: Replace CHECK with ASSERT
 macros for ksyms test
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 1:01=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> I am going to modify ksyms test later so take this opportunity
> to replace old CHECK macros with new ASSERT macros.
> No functionality change.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  .../testing/selftests/bpf/prog_tests/ksyms.c  | 30 ++++++-------------
>  1 file changed, 9 insertions(+), 21 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/ksyms.c b/tools/testi=
ng/selftests/bpf/prog_tests/ksyms.c
> index b295969b263b..6a86d1f07800 100644
> --- a/tools/testing/selftests/bpf/prog_tests/ksyms.c
> +++ b/tools/testing/selftests/bpf/prog_tests/ksyms.c
> @@ -5,8 +5,6 @@
>  #include "test_ksyms.skel.h"
>  #include <sys/stat.h>
>
> -static int duration;
> -
>  void test_ksyms(void)
>  {
>         const char *btf_path =3D "/sys/kernel/btf/vmlinux";
> @@ -18,43 +16,33 @@ void test_ksyms(void)
>         int err;
>
>         err =3D kallsyms_find("bpf_link_fops", &link_fops_addr);
> -       if (CHECK(err =3D=3D -EINVAL, "kallsyms_fopen", "failed to open: =
%d\n", errno))
> -               return;
> -       if (CHECK(err =3D=3D -ENOENT, "ksym_find", "symbol 'bpf_link_fops=
' not found\n"))
> +       if (!ASSERT_TRUE(err !=3D -EINVAL && err !=3D -ENOENT, "bpf_link_=
fops"))
>                 return;

it's best to keep each individual equality test as ASSERT_EQ(), that
way we get more specific and detailed error (with expected vs actual
value), which here we'll just get "wanted true but got false", and
then we'd have to debug some more which of the conditions it is. So
please keep the original granularity of checks everywhere.

>
>         err =3D kallsyms_find("__per_cpu_start", &per_cpu_start_addr);
> -       if (CHECK(err =3D=3D -EINVAL, "kallsyms_fopen", "failed to open: =
%d\n", errno))
> -               return;
> -       if (CHECK(err =3D=3D -ENOENT, "ksym_find", "symbol 'per_cpu_start=
' not found\n"))
> +       if (!ASSERT_TRUE(err !=3D -EINVAL && err !=3D -ENOENT, "__per_cpu=
_start"))
>                 return;
>
> -       if (CHECK(stat(btf_path, &st), "stat_btf", "err %d\n", errno))
> +       if (!ASSERT_OK(stat(btf_path, &st), "stat_btf"))
>                 return;
>         btf_size =3D st.st_size;
>
>         skel =3D test_ksyms__open_and_load();
> -       if (CHECK(!skel, "skel_open", "failed to open and load skeleton\n=
"))
> +       if (!ASSERT_OK_PTR(skel, "test_ksyms__open_and_load"))
>                 return;
>
>         err =3D test_ksyms__attach(skel);
> -       if (CHECK(err, "skel_attach", "skeleton attach failed: %d\n", err=
))
> +       if (!ASSERT_OK(err, "test_ksyms__attach"))
>                 goto cleanup;
>
>         /* trigger tracepoint */
>         usleep(1);
>
>         data =3D skel->data;
> -       CHECK(data->out__bpf_link_fops !=3D link_fops_addr, "bpf_link_fop=
s",
> -             "got 0x%llx, exp 0x%llx\n",
> -             data->out__bpf_link_fops, link_fops_addr);
> -       CHECK(data->out__bpf_link_fops1 !=3D 0, "bpf_link_fops1",
> -             "got %llu, exp %llu\n", data->out__bpf_link_fops1, (__u64)0=
);
> -       CHECK(data->out__btf_size !=3D btf_size, "btf_size",
> -             "got %llu, exp %llu\n", data->out__btf_size, btf_size);
> -       CHECK(data->out__per_cpu_start !=3D per_cpu_start_addr, "__per_cp=
u_start",
> -             "got %llu, exp %llu\n", data->out__per_cpu_start,
> -             per_cpu_start_addr);
> +       ASSERT_EQ(data->out__bpf_link_fops, link_fops_addr, "bpf_link_fop=
s");
> +       ASSERT_EQ(data->out__bpf_link_fops1, 0, "bpf_link_fops1");
> +       ASSERT_EQ(data->out__btf_size, btf_size, "btf_size");
> +       ASSERT_EQ(data->out__per_cpu_start, per_cpu_start_addr, "__per_cp=
u_start");
>
>  cleanup:
>         test_ksyms__destroy(skel);
> --
> 2.43.0
>
