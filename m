Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9642A14293
	for <bpf@vger.kernel.org>; Tue, 12 Mar 2024 23:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710285018; cv=none; b=Mq19OU9ZKFuUIRUmbqkq5oVPaUH3IIWX94vfbqo0R+KXcUmTOXT4KaoHPknSqvfF9/XTzy+bsMA6/6Z04SKG5G2ErCDSaXSA/CkKcYvwxWhJkqs0OOGlGBKT9Yyy+v2dqt5PtCF9PymUXc8nb4Gm/ExmqysxSaygEEMkD1yga9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710285018; c=relaxed/simple;
	bh=+B1cV+lpbjm6ipjHa7LKHLmqIgHBrI926nYuHapb/DE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ld+gePZIHj0FByYId70yGNi5ybyezaqFVw6v3w7H+ZbgQftbt5m+tOul4Pb2mhoCje/0YDN9hKmnr58hlYMLuOSJu5iUuH3wXSq6eGeFyLlDECJDlAVQE0udZrJGzrt3gAYXoUPdPOo6DjNlclbn/yn3nNu3BZSHKIBOUH67gME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z6fqRp8w; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6fqRp8w"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-29b7164eef6so3707297a91.2
        for <bpf@vger.kernel.org>; Tue, 12 Mar 2024 16:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710285016; x=1710889816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S72nq305V8xfd8N1TRc42oftYMs4+cS89O23ww5LRYY=;
        b=Z6fqRp8wZb/o3QU/MocKdN/n45AwHX4cHETjkUAYKS1AaOjmsvNv72mAqcCp4lqCdU
         pceBIEF0loG0v759NPbFsu7YLtvjbg13nVklgKhgeerVRxJkxfMy8U9/BQn+thROcIH8
         HTpiaJ3NFdfZ5DZiGRCnXkAXz5RG8cTqU9qjRJgmQ8xwQp+Hp0d7yOhJRdGUf6ARFWFK
         56g1zkPWKclLyUr9c3hKZ56rckUNLp9WRb36mVTR2QHnfNKVPciNkYqHiLA6M7rI25eG
         mEDan4MmQpE4KBH5CM5RpcLoE/48n0P43ezVOa5BGHWqTRNnHUrh6yR+wi2KGo5ee6bM
         J7rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710285016; x=1710889816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S72nq305V8xfd8N1TRc42oftYMs4+cS89O23ww5LRYY=;
        b=iRZVLJHrqtqwjZsa9LXz7lgAxzTkQ7PWoTeFwqGG7aY0zoZY/ZKDm3ZpmmtDbOgrz9
         YiPY6wroBVWiMJ4z89suu8jA4RgjgqTK1kUsS3GQX5jxhWdoLkVK/mVB5r6LAu0Vbp0P
         4hWgNAF1gVwwjH2t5OSf9M0Kb+8X79w89v12gSMfeuUdyELBDbauELrJ8XZCRNC//QqE
         xX4I/qIcXR/t2r43qm1RzJjERI2Y6xWdOebn22uHhvktSV3Ww4jBpAbQ8y5MchIy/Bs6
         FQBjVHCojYZ3zTqHPEEHyyDtLMRmo2Uefn3Vvk4ByP6NwvPnuqcn23RyNIWhjsGjlwfo
         aOsg==
X-Gm-Message-State: AOJu0YzAF3RbidFOHdSr1P2yqV4A1BZCGqYuLYi/8SRvR2cqpMrUVhTi
	kc1zXME+MPTosAmfYyE99aQIAeggh5qTnLYose2LG0NVpLHfzCI623qDQMXpKjLri5/arDA3z/F
	Uz+UBxDWVlYpImgmEqxh3UXIDFfypi+dhErA=
X-Google-Smtp-Source: AGHT+IHlg/l3yku8PGHj1sVn8jY8P/qSNZQWwrL56mZZllA8WifEJEo1Kl7HrnoXvMJU5RbIsx6l7v5eEdKFpwERBEQ=
X-Received: by 2002:a17:90b:48d2:b0:299:3ebf:d180 with SMTP id
 li18-20020a17090b48d200b002993ebfd180mr1941730pjb.6.1710285015835; Tue, 12
 Mar 2024 16:10:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312183245.341141-1-thinker.li@gmail.com> <20240312183245.341141-3-thinker.li@gmail.com>
In-Reply-To: <20240312183245.341141-3-thinker.li@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 12 Mar 2024 16:10:04 -0700
Message-ID: <CAEf4BzYyDV5MAjB+0Jj64Fr6AqPg+JS_mHc2rGNovFPAHjxM2Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Ensure libbpf skip all-zeros
 fields of struct_ops maps.
To: Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	kernel-team@meta.com, andrii@kernel.org, sinquersw@gmail.com, 
	kuifeng@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 11:32=E2=80=AFAM Kui-Feng Lee <thinker.li@gmail.com=
> wrote:
>
> A new version of a type may have additional fields that do not exist in
> older versions. Previously, libbpf would reject struct_ops maps with a ne=
w
> version containing extra fields when running on a machine with an old
> kernel. However, we have updated libbpf to ignore these fields if their
> values are all zeros or null in order to provide backward compatibility.
>
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>  .../bpf/prog_tests/test_struct_ops_module.c   | 35 +++++++++++++++++++
>  .../selftests/bpf/progs/struct_ops_module.c   | 13 +++++++
>  2 files changed, 48 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_modul=
e.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
> index ee5372c7f2c7..e0d9ff75121b 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
> @@ -93,9 +93,44 @@ static void test_struct_ops_load(void)
>         struct_ops_module__destroy(skel);
>  }
>
> +static void test_struct_ops_not_zeroed(void)
> +{
> +       struct struct_ops_module *skel;
> +       int err;
> +
> +       skel =3D struct_ops_module__open();
> +       if (!ASSERT_OK_PTR(skel, "struct_ops_module_open"))
> +               return;
> +
> +       bpf_program__set_autoload(skel->progs.test_3, false);

maybe mark test_3 program in progs/struct_ops_module.c as default
not-autoload (SEC("?struct_ops/test_3")), so you don't have to set
this to false everywhere?

> +
> +       err =3D struct_ops_module__load(skel);
> +       struct_ops_module__destroy(skel);
> +
> +       if (!ASSERT_OK(err, "struct_ops_module_load"))
> +               return;
> +
> +       skel =3D struct_ops_module__open();
> +       if (!ASSERT_OK_PTR(skel, "struct_ops_module_open_not_zeroed"))
> +               return;
> +
> +       bpf_program__set_autoload(skel->progs.test_3, false);
> +
> +       /* libbpf should reject the testmod_zeroed since the value of its
> +        * "zeroed" is non-zero.
> +        */
> +       skel->struct_ops.testmod_zeroed->zeroed =3D 0xdeadbeef;
> +       err =3D struct_ops_module__load(skel);
> +       ASSERT_ERR(err, "struct_ops_module_load_not_zeroed");
> +
> +       struct_ops_module__destroy(skel);
> +}
> +
>  void serial_test_struct_ops_module(void)
>  {
>         if (test__start_subtest("test_struct_ops_load"))
>                 test_struct_ops_load();
> +       if (test__start_subtest("test_struct_ops_not_zeroed"))
> +               test_struct_ops_not_zeroed();
>  }
>
> diff --git a/tools/testing/selftests/bpf/progs/struct_ops_module.c b/tool=
s/testing/selftests/bpf/progs/struct_ops_module.c
> index 026cabfa7f1f..d7d7606f639c 100644
> --- a/tools/testing/selftests/bpf/progs/struct_ops_module.c
> +++ b/tools/testing/selftests/bpf/progs/struct_ops_module.c
> @@ -54,3 +54,16 @@ struct bpf_testmod_ops___v2 testmod_2 =3D {
>         .test_1 =3D (void *)test_1,
>         .test_2 =3D (void *)test_2_v2,
>  };
> +
> +struct bpf_testmod_ops___zeroed {
> +       int (*test_1)(void);
> +       void (*test_2)(int a, int b);
> +       int (*test_maybe_null)(int dummy, struct task_struct *task);
> +       int zeroed;
> +};
> +
> +SEC(".struct_ops.link")
> +struct bpf_testmod_ops___zeroed testmod_zeroed =3D {
> +       .test_1 =3D (void *)test_1,
> +       .test_2 =3D (void *)test_2_v2,
> +};

We should also test the case where we have local ops definition with
incompatible callback function signature (e.g., extra argument or
something). Test then would update the program pointer (through
skeleton's shadow type) to a compatible implementation.

Can you please add a test like that? Because the goal is to have a
single struct_ops definition, if possible, and adjust it at runtime to
make it compatible with the old kernel, let's have a small demo of
this working.

> --
> 2.34.1
>
