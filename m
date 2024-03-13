Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE09347F45
	for <bpf@vger.kernel.org>; Wed, 13 Mar 2024 15:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710345188; cv=none; b=bzJ5I56IHsv0mxWg5MuyAMWRR16ETe30Haq65HOjicLz0kNpxfkTmF0bIIDmgRo52AYaz2as8ePRdP1R7VF+iOtY8iVbA5JajqYzofqMOhiWtuT66mLNtte+aEDVVQsSeW+jXeI8f6nrBPfw48+Thjp+X9qY9ZV6tvjUZRiaWjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710345188; c=relaxed/simple;
	bh=tAo7OhfBUuBprnqRGTaCRlOND0PkrpXsBSGSH+8uST4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mEn1OURudl3u6H416k0DnGZPWRFZjaDCRc0IChvkhgadEbd0zBpYWPlFBFn9PA41o20jNMjI8sG3dUoPuAuAnDq6U6AvU/9KNCYevSiOh/818K3be1IAfxYXcCxYCkhtVa505TYoJpSN0YWJSpfO6TDHZ1gPpY1zpWjfsGsIx5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gt52crbF; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gt52crbF"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5dca1efad59so986694a12.2
        for <bpf@vger.kernel.org>; Wed, 13 Mar 2024 08:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710345186; x=1710949986; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hGfB8FssVz9FMEFDazFhOQ1Esa2/c6mrm63Dq3fIld0=;
        b=Gt52crbFGml1xDiNfEfLZj0l7RlUJCPDmbY4++lfWW8ZoHSBdMztmdEjob99PJWImI
         701gPikmlKJ420Sy8BVdiOQmZxlvmzc6X1GfRJaiFKgN1txxiqV8yLcQm/CEg5VQCxr8
         kwq/+rVi341RMCD9NiQcVPdR3deUWeGmzdCf7vU70f2uTpv2qJ+LK9c3aqMgZewWN8Nw
         Kcb0dTmRVK+uZvilXO1X4J9b5g8T87fFI/LjWTGNDUh7Br8ttpt9BX72mgfBvOACe99l
         bKbP8oin7POSmeP5q9CkdtJfy90IBBIGKX3YLSuhtuXESTa7NVj9TA/KB7l8JxTfa4N+
         7w5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710345186; x=1710949986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hGfB8FssVz9FMEFDazFhOQ1Esa2/c6mrm63Dq3fIld0=;
        b=ir21rmobDOYNqXoRU7oYGcp4w/biWstjGZzQNvXE2uA1Oq1mNsGodYJG66zAEF078M
         Y9QU84RB19FbXRmpb7FPsqAakzui8Zs7oZ75FYZFHo9APGvpHYKZli3dHr4yX+Vh5Ok+
         pj/+pSuB0Feq/cw40H8mjW0FsMzi7GTdMJC+7WG8/mRm0k6X/5C5rdQ2iOWsGpgbOEvo
         Tl+kz1qlU+P9LJqTw75te+nNnJPJUXcg1h9ZwdYUWnOBd6UxKwHUNjOzef7j8obGtRua
         zyqOsfQu7/fsgQQtkIGFI4MOVUeHg1yVty5rYPrw+bDRnuMPa9/4p0U9RHpjgjiNlx4G
         DH4w==
X-Forwarded-Encrypted: i=1; AJvYcCXjUUhM5D3CBzHxX6dUpp7CMbl81Pzh/RhxXDSn/OdlsyBYAMCZn/ZNdSYUN42Wr7ApFLpMbSz3jTdO/W9ZxG5m27vj
X-Gm-Message-State: AOJu0YxKONFFiz8XWoI2JtLXl4ulsWIOvGro6VRA8YNdEQaGVlmre2PS
	0Ebxg9pgow3lqRwGG83kcVzm0uoHrQkVH/QeoS26cpFCWw7Qq2gY1wbYhYnP6wf/qAo3PYeL40d
	rkGfFys4T6bpIWoW/3ieMos1fHLk=
X-Google-Smtp-Source: AGHT+IHgEvirJZTUMFdw+hrD8lP3ldnvD1OlMwdJdLvcwpayqyV1okYy/GgUrb4siN6L/Lnv7MsQKxZsM5NjRi0HRVE=
X-Received: by 2002:a17:90a:c695:b0:29b:3106:7f24 with SMTP id
 n21-20020a17090ac69500b0029b31067f24mr3578212pjt.37.1710345186058; Wed, 13
 Mar 2024 08:53:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312183245.341141-1-thinker.li@gmail.com> <20240312183245.341141-3-thinker.li@gmail.com>
 <CAEf4BzYyDV5MAjB+0Jj64Fr6AqPg+JS_mHc2rGNovFPAHjxM2Q@mail.gmail.com> <cc07c8ad-d07c-4314-8f4f-ec1fe913b005@gmail.com>
In-Reply-To: <cc07c8ad-d07c-4314-8f4f-ec1fe913b005@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 13 Mar 2024 08:52:54 -0700
Message-ID: <CAEf4BzZAECegOMOj6dOzbFaB_wEF6ALiWaxCQ6FCCTtdRHgbaA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Ensure libbpf skip all-zeros
 fields of struct_ops maps.
To: Kui-Feng Lee <sinquersw@gmail.com>
Cc: Kui-Feng Lee <thinker.li@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com, 
	andrii@kernel.org, kuifeng@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 5:56=E2=80=AFPM Kui-Feng Lee <sinquersw@gmail.com> =
wrote:
>
>
>
> On 3/12/24 16:10, Andrii Nakryiko wrote:
> > On Tue, Mar 12, 2024 at 11:32=E2=80=AFAM Kui-Feng Lee <thinker.li@gmail=
.com> wrote:
> >>
> >> A new version of a type may have additional fields that do not exist i=
n
> >> older versions. Previously, libbpf would reject struct_ops maps with a=
 new
> >> version containing extra fields when running on a machine with an old
> >> kernel. However, we have updated libbpf to ignore these fields if thei=
r
> >> values are all zeros or null in order to provide backward compatibilit=
y.
> >>
> >> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> >> ---
> >>   .../bpf/prog_tests/test_struct_ops_module.c   | 35 +++++++++++++++++=
++
> >>   .../selftests/bpf/progs/struct_ops_module.c   | 13 +++++++
> >>   2 files changed, 48 insertions(+)
> >>
> >> diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_mo=
dule.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
> >> index ee5372c7f2c7..e0d9ff75121b 100644
> >> --- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
> >> +++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
> >> @@ -93,9 +93,44 @@ static void test_struct_ops_load(void)
> >>          struct_ops_module__destroy(skel);
> >>   }
> >>
> >> +static void test_struct_ops_not_zeroed(void)
> >> +{
> >> +       struct struct_ops_module *skel;
> >> +       int err;
> >> +
> >> +       skel =3D struct_ops_module__open();
> >> +       if (!ASSERT_OK_PTR(skel, "struct_ops_module_open"))
> >> +               return;
> >> +
> >> +       bpf_program__set_autoload(skel->progs.test_3, false);
> >
> > maybe mark test_3 program in progs/struct_ops_module.c as default
> > not-autoload (SEC("?struct_ops/test_3")), so you don't have to set
> > this to false everywhere?
>
> Sure! I forgot we have this new feature.
>
> >
> >> +
> >> +       err =3D struct_ops_module__load(skel);
> >> +       struct_ops_module__destroy(skel);
> >> +
> >> +       if (!ASSERT_OK(err, "struct_ops_module_load"))
> >> +               return;
> >> +
> >> +       skel =3D struct_ops_module__open();
> >> +       if (!ASSERT_OK_PTR(skel, "struct_ops_module_open_not_zeroed"))
> >> +               return;
> >> +
> >> +       bpf_program__set_autoload(skel->progs.test_3, false);
> >> +
> >> +       /* libbpf should reject the testmod_zeroed since the value of =
its
> >> +        * "zeroed" is non-zero.
> >> +        */
> >> +       skel->struct_ops.testmod_zeroed->zeroed =3D 0xdeadbeef;
> >> +       err =3D struct_ops_module__load(skel);
> >> +       ASSERT_ERR(err, "struct_ops_module_load_not_zeroed");
> >> +
> >> +       struct_ops_module__destroy(skel);
> >> +}
> >> +
> >>   void serial_test_struct_ops_module(void)
> >>   {
> >>          if (test__start_subtest("test_struct_ops_load"))
> >>                  test_struct_ops_load();
> >> +       if (test__start_subtest("test_struct_ops_not_zeroed"))
> >> +               test_struct_ops_not_zeroed();
> >>   }
> >>
> >> diff --git a/tools/testing/selftests/bpf/progs/struct_ops_module.c b/t=
ools/testing/selftests/bpf/progs/struct_ops_module.c
> >> index 026cabfa7f1f..d7d7606f639c 100644
> >> --- a/tools/testing/selftests/bpf/progs/struct_ops_module.c
> >> +++ b/tools/testing/selftests/bpf/progs/struct_ops_module.c
> >> @@ -54,3 +54,16 @@ struct bpf_testmod_ops___v2 testmod_2 =3D {
> >>          .test_1 =3D (void *)test_1,
> >>          .test_2 =3D (void *)test_2_v2,
> >>   };
> >> +
> >> +struct bpf_testmod_ops___zeroed {
> >> +       int (*test_1)(void);
> >> +       void (*test_2)(int a, int b);
> >> +       int (*test_maybe_null)(int dummy, struct task_struct *task);
> >> +       int zeroed;
> >> +};
> >> +
> >> +SEC(".struct_ops.link")
> >> +struct bpf_testmod_ops___zeroed testmod_zeroed =3D {
> >> +       .test_1 =3D (void *)test_1,
> >> +       .test_2 =3D (void *)test_2_v2,
> >> +};
> >
> > We should also test the case where we have local ops definition with
> > incompatible callback function signature (e.g., extra argument or
> > something). Test then would update the program pointer (through
> > skeleton's shadow type) to a compatible implementation.
> >
> > Can you please add a test like that? Because the goal is to have a
> > single struct_ops definition, if possible, and adjust it at runtime to
> > make it compatible with the old kernel, let's have a small demo of
> > this working.
>
> Do you want to check signatures at libbpf? Or you just want a small
> demo?

Small demo/test was my goal here, to make sure this scenario works as expec=
ted.

>
> For extra arguments, IIRC, the verifier should reject the program if the
> program did access these arguments since it accesses memory beyond the
> last byte of the context. Doing extra checking at libbpf can provide
> better error messages if that is what you want.

I think libbpf could have checked local callback signature and kernel
callback signature and emit warning. If we don't enforce callback
signature match today and no one complained about that, I'd leave it
as is.

So let's start with a test for now and no more libbpf changes.


>
> If a program never accesses an extra argument, it should be allowed.(?)
> WDYT?
>
>
> >
> >> --
> >> 2.34.1
> >>
