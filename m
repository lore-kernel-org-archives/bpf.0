Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56677256A
	for <bpf@vger.kernel.org>; Mon, 18 Mar 2024 18:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710786888; cv=none; b=bGmvPlWH3cAVl7G+RTf2iJ7zxZlMI5pjP5RpipQ6Iut2tRwabnDpTbDhnET0cvUTaJu/DCuuF/KyksVES9GoDANJCnl7MBMTHgQtoiGfdbRThwGCQPVJwS8a4/v6YVbJdByb02lkUG9c3vmL6zTnXYNialBL7Xd+jjbJokh/0Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710786888; c=relaxed/simple;
	bh=g5AZDsHJJKW6rdTZj1+zw52EtQABL0GnLqI+ia23ksw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y0KjvomPhHUzGA/S7p+wT7TQTaBJZPDoKATXDtQL6Fq1Xu0WLyV6kTQybqaEB4zFlyHK+1ZBlvVYKpvEnGpH84MuWqKwMLphv7d+MfPeHLiSFqYVqQ7nsZehTzXRpH6hOTaMcV3F5zoWKUAtcwm0Q88mNgTepu/b6CVxy/6xxtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OkSTqoRp; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OkSTqoRp"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1dd9568fc51so36598745ad.2
        for <bpf@vger.kernel.org>; Mon, 18 Mar 2024 11:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710786887; x=1711391687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=elCVoSqwTEZzTLKNOyP6tnw/qHOeQ1oESxP22/bBR1Q=;
        b=OkSTqoRpsIrTmrb/skpo1MyhGxXIF0vSpm/NUt4OJod0FkeBKOk3BerbJ6WMZWkjYy
         y8pzT6g5rlI/QhcM3K2dM5CbnHV1E6/pHGedwBMYkGiSaMagiDVrypoeGVwnOQLMp9Us
         q18LNp35zbFHLpnz87FMRgbfMg6Ifwkb/u5pMt8Y6BYoIKwp5K2Z51o4NqMAqMeM1Qwn
         dCj6cZP58s4Y9tuK4thPH6bDOVduTxKEX2O7/61ilAv+khwZ7UWbULqdnT06XNHEPNq7
         gEToVdUbBwpRwZslFuJ9vxNMiyzV3Tg1mZYayYeIYmwrUNJ6bFqqF4z+6VExrY/Wvn8h
         cFsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710786887; x=1711391687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=elCVoSqwTEZzTLKNOyP6tnw/qHOeQ1oESxP22/bBR1Q=;
        b=rufEwvsV3taqRD65p2cZdXNP5Gc0vKVI68MMNkNdiPNnGBR4xA+xR4d4NIZarITekc
         5RfNvh+Ayqbqsafs4J/e3eUwKfNv1Kp4rHlu6Yb7BbuinlZACjNum9Y/5hf9+ehzaif9
         fY/TEm0tEJdCil8N5E1MoDCHekwB5Y/XaVQLNIdlPBqQyS+a2rks1UsIdHm3BlwynFG7
         uDBCeTSAsyHJ1m5N/OZgkVfjPTLHhUeUcuwxXgztAa/+3m0Jqrrq3M1y0jtWAd/wIj8C
         C239LtUWAsXhHYT1Fe85x6VMhANbgM/FTVqudnGBXCFj9rn8Iax8AeOamlphVX6ka9IP
         WgtQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/hKbmcj6WZOdzomh4dF5oshEv4A/QIoQRNwRu0aEQvau8/IfNgm00lhJta8oOSU8oc/u+mPeJ5qency0QgLFKyAFO
X-Gm-Message-State: AOJu0YwiIefrSA4hXHbongjZyXipQs88dTHZbfY8382G/7WV+iSeSvfr
	sFKqJ0vFge8OPAT1mHIKVCA6VVfBTZnMrq9+tUcWGtb2uWJtrjuRckSnexvQAiVULd4rgOWVE2i
	7fKlugxumaADCrLsVOT0xQj08NPE=
X-Google-Smtp-Source: AGHT+IHYfMqQheEjZXjcYbv7H9hfds/H2hA2dVxMOOsF5D+Kh/mGlidcqxSBg8FRqJjS95OV38dsbppNfSjX/mO6Hlw=
X-Received: by 2002:a17:903:1d0:b0:1dd:7de5:7ac4 with SMTP id
 e16-20020a17090301d000b001dd7de57ac4mr447961plh.38.1710786886628; Mon, 18 Mar
 2024 11:34:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313214139.685112-1-thinker.li@gmail.com> <CAEf4BzYXe8xbB5BH97ggYzokdFjqAv5Zuz_MRV9fyzCt+yJJvQ@mail.gmail.com>
 <521a3085-c98e-404f-a30e-d981dc2cd674@gmail.com>
In-Reply-To: <521a3085-c98e-404f-a30e-d981dc2cd674@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 18 Mar 2024 11:34:34 -0700
Message-ID: <CAEf4BzbpGDfoHYFrKGS7sabW=XxNm83Lt5mYt1LpBSy6vjZ+eg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/3] Ignore additional fields in the
 struct_ops maps in an updated version.
To: Kui-Feng Lee <sinquersw@gmail.com>
Cc: Kui-Feng Lee <thinker.li@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com, 
	andrii@kernel.org, kuifeng@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 4:44=E2=80=AFPM Kui-Feng Lee <sinquersw@gmail.com> =
wrote:
>
>
>
> On 3/14/24 13:59, Andrii Nakryiko wrote:
> > On Wed, Mar 13, 2024 at 2:41=E2=80=AFPM Kui-Feng Lee <thinker.li@gmail.=
com> wrote:
> >>
> >> According to an offline discussion, it would be beneficial to
> >> implement a backward-compatible method for struct_ops types with
> >> additional fields that are not present in older kernels.
> >>
> >> This patchset accepts additional fields of a struct_ops map with all
> >> zero values even if these fields are not in the corresponding type in
> >> the kernel. This provides a way to be backward compatible. User space
> >> programs can use the same map on a machine running an old kernel by
> >> clearing fields that do not exist in the kernel.
> >>
> >> For example, in a test case, it adds an additional field "zeroed" that
> >> doesn't exist in struct bpf_testmod_ops of the kernel.
> >>
> >>      struct bpf_testmod_ops___zeroed {
> >>          int (*test_1)(void);
> >>          void (*test_2)(int a, int b);
> >>          int (*test_maybe_null)(int dummy, struct task_struct *task);
> >>          int zeroed;
> >>      };
> >>
> >>      SEC(".struct_ops.link")
> >>      struct bpf_testmod_ops___zeroed testmod_zeroed =3D {
> >>          .test_1 =3D (void *)test_1,
> >>          .test_2 =3D (void *)test_2_v2,
> >>      };
> >>
> >> Here, it doesn't assign a value to "zeroed" of testmod_zeroed, and by
> >> default the value of this field will be zero. So, the map will be
> >> accepted by libbpf, but libbpf will skip the "zeroed" field. However,
> >> if the "zeroed" field is assigned to any value other than "0", libbpf
> >> will reject to load this map.
> >>
> >> ---
> >> Changes from v1:
> >>
> >>   - Fix the issue about function pointer fields.
> >>
> >>   - Change a warning message, and add an info message for skipping
> >>     fields.
> >>
> >>   - Add a small demo of additional arguments that are not in the
> >>     function pointer prototype in the kernel.
> >>
> >> v1: https://lore.kernel.org/all/20240312183245.341141-1-thinker.li@gma=
il.com/
> >>
> >> Kui-Feng Lee (3):
> >>    libbpf: Skip zeroed or null fields if not found in the kernel type.
> >>    selftests/bpf: Ensure libbpf skip all-zeros fields of struct_ops ma=
ps.
> >>    selftests/bpf: Accept extra arguments if they are not used.
> >
> > I applied the first two patches and dropped the third one, as I don't
> > think it's actually testing any new condition. What I actually had in
> > mind is more along the following lines:
> >
> > $ git diff
> > diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_mod=
ule.c
> > b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
> > index 098776d00ab4..9585504ce6b5 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
> > @@ -103,6 +103,8 @@ static void test_struct_ops_not_zeroed(void)
> >          if (!ASSERT_OK_PTR(skel, "struct_ops_module_open"))
> >                  return;
> >
> > +       skel->struct_ops.testmod_fn_proto->test_2 =3D skel->progs.test_=
2;
> > +
> >          err =3D struct_ops_module__load(skel);
> >          ASSERT_OK(err, "struct_ops_module_load");
> >
> > diff --git a/tools/testing/selftests/bpf/progs/struct_ops_module.c
> > b/tools/testing/selftests/bpf/progs/struct_ops_module.c
> > index 86e1e50c5531..d3e0f941c16c 100644
> > --- a/tools/testing/selftests/bpf/progs/struct_ops_module.c
> > +++ b/tools/testing/selftests/bpf/progs/struct_ops_module.c
> > @@ -68,3 +68,13 @@ struct bpf_testmod_ops___zeroed testmod_zeroed =3D {
> >          .test_1 =3D (void *)test_1,
> >          .test_2 =3D (void *)test_2_v2,
> >   };
> > +
> > +struct bpf_testmod_ops___diff_fn_proto {
> > +       /* differs from expected void (*test_2)(int a, int b) */
> > +       void (*test_2)(int a);
> > +};
> > +
> > +SEC(".struct_ops.link")
> > +struct bpf_testmod_ops___zeroed testmod_fn_proto =3D {
> > +       .test_2 =3D (void *)test_2_v2,
> > +};
>
> It is an interesting combination. The newer versions usually have more
> arguments although it is not always true. But, you used the old version
> of a type intentionally. Most people would do opposite, right?
>
> How about to use a version with more arguments than what the kernel
> expected, but assign a function pointer with fewer arguments?  For exampl=
e,

It doesn't matter. I wanted to check that libbpf doesn't enforce type
signatures. Whether it's more or fewer arguments doesn't really
matter. In practice users will need to supply the correct BPF program
that would be verified by the kernel, and that's what I cared about:
whether libbpf will allow users to achieve that.

>
> SEC("struct_ops/test_2_arg3v")
> void BPF_PROG(test_2_arg3v, int a, int b, int c)
> {
>      ......
> }
>
> struct bpf_test_ops___new_fn_proto {
>      void (*test_2)(int a, int b, int c);
> };
>
> SEC(".struct_ops.link")
> struct bpf_testmod_ops___new_fn_proto testmod_fn_proto =3D {
>      .test_2 =3D (void *)test_2_arg3v
> };
>
> Basically, we don't check signatures of function pointers so far.
> We have the ability to *decrease* the number of arguments.
>
> >
> >
> > see how bpf_testmod_ops___diff_fn_proto defines test_2 callback with
> > an incompatible signature, but at runtime we are switching the program
> > to the one that the kernel actually expects. This is the scenario
> > (incompatible struct ops type definition) that I wanted to test and
> > make sure it works.
> >
> > I quickly checked that it does work because libbpf doesn't enforce any
> > type signature (which is both good and bad, but it is what it is). It
> > would still be nice to have a selftest added with an incompatible
> > struct_ops type which is "fixed up" by setting thhe correct program
> > instance. Consider for a follow up.
> >
> >
> >>
> >>   tools/lib/bpf/libbpf.c                        |  24 +++-
> >>   .../bpf/prog_tests/test_struct_ops_module.c   | 103 ++++++++++++++++=
++
> >>   .../bpf/progs/struct_ops_extra_arg.c          |  49 +++++++++
> >>   .../selftests/bpf/progs/struct_ops_module.c   |  16 ++-
> >>   4 files changed, 186 insertions(+), 6 deletions(-)
> >>   create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_extr=
a_arg.c
> >>
> >> --
> >> 2.34.1
> >>
