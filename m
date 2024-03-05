Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08B11113
	for <bpf@vger.kernel.org>; Tue,  5 Mar 2024 00:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709597886; cv=none; b=X12yglocPIoqrCr98pieprGm5Lly7SNhi9rNHR/aH9CLPjvVlNHov+OYXSn2h5+tpYW3uqaPaFTCFVWZUdK3PH4z4FjQ3o5QLOlCRQjSKs5V8gFspfYYEijFRQ0aX0c8LtJrASsxJe2ZY5Ock8lztvxwdhRq3u0IWgQPljBq/sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709597886; c=relaxed/simple;
	bh=uySm4z6U/0vJVsznX89jdK9NcjB3RiRRROKnWSZinGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ksROUhH2or/Ld4TcV9+D8+SDF5ZG+svq2Vlzw+KtO6AwQvkd4fsn96dr/mwYrv8cbQQFde8qpZwOAD5kz/KyeHKSLLDaYd7+OmbVhLFOzFFdjAE8Be3iI1AiPFNOSSIWS9Lf9ulVfFIAvcWEF0DS/kBn5t9JyvY6xb31d87OOPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SDzyxY/Y; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDzyxY/Y"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e57ab846a1so3226503b3a.3
        for <bpf@vger.kernel.org>; Mon, 04 Mar 2024 16:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709597884; x=1710202684; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uJ71UrtZGDbSsw3aMMaO1PN8F8dYYo4QJ0+cPi//V5A=;
        b=SDzyxY/YGYogaPVWepzXQ0jWivuRguB1xp1sfIYiGzmXxRnUEJnqz5KEYpUFsxr72N
         jeps8vIHx1x80UEKY7sKWehZU1aK4IIfe09Vkk8qqDr3NBrLZ+KPG5AwnVJt/QQerlLd
         93gJeCXCi6WP0I1WyQwPa1LS9PgsTuiCuvSQL+XomDOx5hWckYwKZkKBxaxgdrEWicvB
         DAOscliconrnAHasYy0LhPtwnBWWl8GHmBKmkAqBj2LetSJzrw6UvsnxfL1oCC4LW4wn
         dvwo/ivtqbQQqYaHD8KGws36SRhNxvid/ATFanSjg7eYxxQwEdinxFVB3gRFRbTzsVZW
         0ezQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709597884; x=1710202684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uJ71UrtZGDbSsw3aMMaO1PN8F8dYYo4QJ0+cPi//V5A=;
        b=RlGgVZqLW1w5IIe/mhrMP3ihdPcdROHZBD10/5t8PDBIfILKvPu8kkXp7a32v52hhV
         e2DsUXIASKbVp1DQFzxl/QCVCteBx9GtXzeSxo9KMba6vXArlae1KQK5I2kxxmfl7Ltz
         hHRHFrAtENvaTJp08ujAqZI+eTAyOLhl6WVIOZTO5OmBIvUeDKnRrZ+A32IZp/6iqfMH
         wBGjzVOL8snkuTdNd9pJNH+9YX4+H96EFZ06d4sXxUuogvZwJ4xplL0zVZnQZ3GjJNhq
         KX4WeWrdd36FGgHUjqMpvPWusw3c2NvbJvp/qpNh9Q/9gpqOw30/R8lbDLFPBczt8ziH
         XWjg==
X-Gm-Message-State: AOJu0YxJ/jfyFevVd7PsiSObL93GQr6tqSLmWwVlyr6t8KNEiTOeuccw
	309+cix6DDWkO4/h2JIhkmJUU5qBP1luNh5M20ZvgRiINDLGbOPWT8ydP9GtBI+hwhH/3/+ptYg
	OvLX0MC1gDZns0Xp6IL7P5XcS0OE=
X-Google-Smtp-Source: AGHT+IGio56gJlGom6NxVmzkD7K//bhGXv7R0x4OmbxMp2nYmoyjOnR1Da32s2kqkINrp6i+dg0efVBdHp+XJ1Cf/7s=
X-Received: by 2002:a05:6a20:ceaf:b0:1a1:4508:8ea3 with SMTP id
 if47-20020a056a20ceaf00b001a145088ea3mr256969pzb.59.1709597884088; Mon, 04
 Mar 2024 16:18:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240302165017.1627295-1-yonghong.song@linux.dev> <20240302165022.1627562-1-yonghong.song@linux.dev>
In-Reply-To: <20240302165022.1627562-1-yonghong.song@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 4 Mar 2024 16:17:51 -0800
Message-ID: <CAEf4Bzad8b4ZxNjx_sK=pxGrEdz_M1-2VJAj6bsg7ZLA+5s_fg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/4] selftests/bpf: Replace CHECK with ASSERT
 macros for ksyms test
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 2, 2024 at 8:50=E2=80=AFAM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
> I am going to modify ksyms test later so take this opportunity
> to replace old CHECK macros with new ASSERT macros.
> No functionality change.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  .../testing/selftests/bpf/prog_tests/ksyms.c  | 38 +++++++++----------
>  1 file changed, 19 insertions(+), 19 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/ksyms.c b/tools/testi=
ng/selftests/bpf/prog_tests/ksyms.c
> index b295969b263b..e081f8bf3f17 100644
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
> @@ -18,43 +16,45 @@ void test_ksyms(void)
>         int err;
>
>         err =3D kallsyms_find("bpf_link_fops", &link_fops_addr);
> -       if (CHECK(err =3D=3D -EINVAL, "kallsyms_fopen", "failed to open: =
%d\n", errno))
> +       if (err =3D=3D -EINVAL) {
> +               ASSERT_TRUE(false, "kallsyms_fopen for bpf_link_fops");

should this (and few other cases below) be ASSERT_EQ()/ASSERT_NEQ()
(whichever makes sense, I can't reason about CHECK() conditions).

ASSERT_TRUE(false) is a last resort way, we have more meaningful checks.

>                 return;
> -       if (CHECK(err =3D=3D -ENOENT, "ksym_find", "symbol 'bpf_link_fops=
' not found\n"))
> +       }
> +       if (err =3D=3D -ENOENT) {
> +               ASSERT_TRUE(false, "ksym_find for bpf_link_fops");
>                 return;
> +       }
>
>         err =3D kallsyms_find("__per_cpu_start", &per_cpu_start_addr);
> -       if (CHECK(err =3D=3D -EINVAL, "kallsyms_fopen", "failed to open: =
%d\n", errno))
> +       if (err =3D=3D -EINVAL) {
> +               ASSERT_TRUE(false, "kallsyms_fopen for __per_cpu_start");
>                 return;
> -       if (CHECK(err =3D=3D -ENOENT, "ksym_find", "symbol 'per_cpu_start=
' not found\n"))
> +       }
> +       if (err =3D=3D -ENOENT) {
> +               ASSERT_TRUE(false, "ksym_find for __per_cpu_start");
>                 return;
> +       }
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
>
