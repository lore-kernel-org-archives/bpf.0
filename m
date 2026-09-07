Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199D33B47E3
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 16:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788798625; cv=pass; b=Khi8XsColyRFHmMsvQemr07hFfBA5KFJ98jaH8X/7fsJ2PM/fqMlYMBAX7frh8wBLaie6HIcMFSoMQRC4X3POBo1rnGEdnVnXR/FVG81UJA16a1QmZ5aq36fqL8+0cexOjiktN3LAszVNXow5J8lxnDCqGpM8J3/QbrqmpDyaoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788798625; c=relaxed/simple;
	bh=YC3mhxg8agC1QmLG0YWgcyKb6yf+wfB6Z9Txvg/aqhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DSwBu54D0cYMWhuDdO75iUrppugzUyC/9/b/hv/8zKZK5Qpc8/qtUMWGjZVERjvDwmfiLxEUP6xb36SlylrSuY3rjwG/72KSuRPdzHq3rv4qT6PDFTyGTJCMIqE1Xb3vCGOofh2dE6sz72mBDHEbZcrgKX765aVqiwd3tM21NMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sko4QotE; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sko4QotE"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e4ab1b9f7so221646d50.1
        for <bpf@vger.kernel.org>; Mon, 07 Sep 2026 09:30:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788798622; cv=none;
        d=google.com; s=arc-20260327;
        b=jbbvWD7rBibYb1XFGxvjegBlBiVUQTdSJiPpBFZ5UEy07SmSN2+MVzWfYtpJjBYrJP
         gwtiUVhFGxVBeBypz3cZgdoso+EqdVb7Yg/7lvnZMn38ms8ejBZH8Div5w84sE2KtPhu
         tcPpLNMXgNQbl9/WgFXgSvT4Ix/f+0g7bniW4X7xfuyF5Z4tGBD8nEO5ZR5wt/IpCSs3
         MuQ7elMMOBuiC/XoLGIdyRppUbBVytFM9li3MnAsmacWD5MfdK+EAL5K5CeoF3CJZ91J
         UZaEoTWH2GTMv74R3kD9k3ozX/Y1PyusHKtwSHr3hK+5V4MLUI0LQYw9ll0rI+X5FXw3
         9fdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l5PIHtkIc5pX0hU6/4ifxzrM4s2XmDeqqUAq6heydbQ=;
        fh=HlL+TfSPL/YyZo0xbb8+v4bXLS5CbYJtwSiMXh+JE8U=;
        b=Txr7NcyLX/CawXIAqSOUrKIoh8BRSxoNwJtn/Hhzn4k5WfJBKrNX//v+r1beGCzoz5
         h/HTTPzPxxUtIkc+fAoCMfqkzPOq0m4C/WWIlcqvbXzC800vFasaPegsPsLqJ0Rs+dDe
         FJGpNkanADOV1s93iblRYM8KTiXzu48keXRSRVvs6GItJ8vrILgKDa4xUcdKvusxCVZJ
         5VjVmZcqL3t5LnH73afWh+dhMpi/42TByfxm+MmbffORDaXBL+lmrhAaQmBQ42d5KTke
         eIkhfP+mwzMQlIii+rlqiDs2ejoK3pI9u2GkkEQfsuC0RnH0O48HrVGVFxpmtYY5neGk
         lF4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788798622; x=1789403422; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=l5PIHtkIc5pX0hU6/4ifxzrM4s2XmDeqqUAq6heydbQ=;
        b=sko4QotE8VjuoLCsjy+3UR3MMkKGeLbPUtSwet5n4jDB1ouQ2dvMm4CVo6V+S8KUNE
         2qcXWjSiqKytPYDs/Oswr1QshadGy9aFDcJirXH466sTabZf8xo4IHK74WBQmfnlnU/v
         S8kMhZKBt9Sd4bad+qrOBw8WU/6zFEkWUHguJFgY1MaGvYg+8YER8+BK8braMrJyK/uT
         Ee47SDV/dVQURE7tebU7krWFAw9IB8rsZeyQNYgLZkqlAPOcHN4//s0w6MXGEECKuKG8
         lX62De20uOU0odpijIIVyFzZpVIzpHePknASOTyZq8gO921H9nW2KlAnK2CrjX1TTO6s
         xPMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788798622; x=1789403422;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l5PIHtkIc5pX0hU6/4ifxzrM4s2XmDeqqUAq6heydbQ=;
        b=tP0XACbtOIVtFZi4XvggsENi9ydVcomSHg/EHa5P8Ph853QoM4ONKFMKaSzw3fp+KV
         ny9BHT5Yv5VQhA0Tggz0CT70vlryOpK1SnkrUPhIF6OsGkoqN/VeLJXVE5ikbKrlVxDj
         SbI9yE4ZBORcF+4meYPIFD3SbWJuhqptYDIQSiM8jC24BzkQjxjmh4sx+HS9ua1dG1B/
         yxzaAD/DBztL8CV0ohjA/ktxUv8YSZ270mwSLFzgkWbg21v5bDVEaEeyDxbC7eGyNcvU
         GveBFPQ3kEPWSwJGSOzY7eL1V29Yv/uHIZ/A6zjpBFUatmRIZMtlW/7rcXzJi3n6q1WE
         qeIg==
X-Gm-Message-State: AFuF++nj8jJWbOm/InY5sJskySSdRhVreCkEcbENNP7TtF21q/fIEPid
	1lL5xFxewQpGKrpRPY/M+q3kaDpMSH2k6A92WINzwxOTn56hyny2kXkBdBLK/2yj21Q456TDbV4
	k25Q0NoZmAZR4CdNeFAtMFu1z4SSfdwM=
X-Gm-Gg: AYBFou2kXWkAcweAeXsC5j6cn1Xq6Pcvxjmp82zEeasvKBjKa2UWyBIgaP29mH+yyMb
	OtCOetK6SNGpky/9FpVbngHbgz4J+sO9kE/LN4edXJF2icWBLg9iwABKf6T8hp+66hwZeomUQBa
	y9flBfnP8zUXGhNTpLhvLQEQQAzJyXEo0lps8FlY87kM/npWkPS1zKnwCzYdElrv7ineUeQwVwx
	2xKPjiRhHucIxInfzJGY1us0QwIM+tEyhh8jLYDoGtLZhZCTwga62A0Swjh2yLPjfuVWUwzltT6
	/oEpblu7OaXSvZfBYpz3oboqZbb0bEituDaDLq7Kv4DYOarpOowhVjrtGmJ65lVxDoUuHrPNSWo
	rua0LPU0TH7mK3SI5aDsg7L5FLD9reXEdpA==
X-Received: by 2002:a05:690e:408a:b0:66d:1c2a:9e5e with SMTP id
 956f58d0204a3-670f494a6b1mr518322d50.19.1788798621518; Mon, 07 Sep 2026
 09:30:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABzjXVz3iBuump-pXFkefZ5v+2uu4fG61zqRyWD4xmz3PuBycw@mail.gmail.com>
 <20260907131021.34343-1-caomingpei@gmail.com> <20260907131021.34343-3-caomingpei@gmail.com>
 <f22d3b93-65b5-4b06-9af8-99d0e65eb33b@oracle.com>
In-Reply-To: <f22d3b93-65b5-4b06-9af8-99d0e65eb33b@oracle.com>
From: Mingpei CAO <caomingpei@gmail.com>
Date: Tue, 8 Sep 2026 00:30:10 +0800
X-Gm-Features: AcwNN1WhZ5rT0oxfci4q7JtVplVzL9Myrf1C4iCZvLlTzpXNUm78_4BW3BjeJiU
Message-ID: <CABzjXVzrCUEZBUuYFEpGZ9nzwKdeYpjdBcXnUqcFi=wwMnq-+A@mail.gmail.com>
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Test array element comparison in
 BTF dedup
To: Alan Maguire <alan.maguire@oracle.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, 
	eddyz87@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, Alan. I'll move the tests into prog_tests/btf.c and rerun them
against both the original and fixed libbpf for v2.

Alan Maguire <alan.maguire@oracle.com> =E4=BA=8E2026=E5=B9=B49=E6=9C=887=E6=
=97=A5=E5=91=A8=E4=B8=80 23:46=E5=86=99=E9=81=93=EF=BC=9A
>
> On 07/09/2026 14:10, Mingpei CAO wrote:
> > Exercise recursive array comparison with different and identical
> > element definitions. Check that distinct containers remain separate
> > and identical types are deduplicated, including their references.
> >
> > The negative case fails before the fix and passes afterwards.
> > The positive case passes both before and after the fix.
> >
> > Assisted-by: LLM
> > Signed-off-by: Mingpei CAO <caomingpei@gmail.com>
>
> this test would be better placed in prog_tests/btf.c I think where there
> are a number of other BTF dedup tests; something like the following
> is roughly equivalent to what you have:
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing=
/selftests/bpf/prog_tests/btf.c
> index 67b9015cbd98..1c4a46e2a64d 100644
> --- a/tools/testing/selftests/bpf/prog_tests/btf.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf.c
> @@ -7062,6 +7062,94 @@ static struct btf_dedup_test dedup_tests[] =3D {
>                 BTF_STR_SEC("\0int\0long int"),
>         },
>  },
> +{
> +       .descr =3D "dedup: array element comparison",
> +       .input =3D {
> +               .raw_types =3D {
> +                       /* signed int */
> +                       BTF_TYPE_INT_ENC(NAME_NTH(1), BTF_INT_SIGNED, 0, =
32, 4),
>  /* [1] */
> +                       /* unsigned int */
> +                       BTF_TYPE_INT_ENC(NAME_NTH(2), 0, 0, 32, 4),
>         /* [2] */
> +                       /* signed int[1] */
> +                       BTF_TYPE_ARRAY_ENC(1, 1, 1),
>         /* [3] */
> +                       /* duplicate signed int[1] */
> +                       BTF_TYPE_ARRAY_ENC(1, 1, 1),                     =
               /* [4] */
> +                       /* unsigned int[1] */
> +                       BTF_TYPE_ARRAY_ENC(2, 2, 1),                     =
               /* [5] */
> +                       /* struct s { signed int a[1]; signed int b[1]; }=
 */
> +                       BTF_STRUCT_ENC(NAME_NTH(3), 2, 8),               =
               /* [6] */
> +                       BTF_MEMBER_ENC(NAME_NTH(4), 3, 0),
> +                       BTF_MEMBER_ENC(NAME_NTH(5), 3, 32),
> +                       /* struct s { signed int a[1]; unsigned int b[1];=
 } */
> +                       BTF_STRUCT_ENC(NAME_NTH(3), 2, 8),               =
               /* [7] */
> +                       BTF_MEMBER_ENC(NAME_NTH(4), 4, 0),
> +                       BTF_MEMBER_ENC(NAME_NTH(5), 5, 32),
> +                       BTF_END_RAW,
> +               },
> +               BTF_STR_SEC("\0int\0unsigned int\0s\0a\0b"),
> +       },
> +       .expect =3D {
> +               .raw_types =3D {
> +                       BTF_TYPE_INT_ENC(NAME_NTH(1), BTF_INT_SIGNED, 0, =
32, 4), /* [1] */
> +                       BTF_TYPE_INT_ENC(NAME_NTH(2), 0, 0, 32, 4),      =
               /* [2] */
> +                       BTF_TYPE_ARRAY_ENC(1, 1, 1),                     =
               /* [3] */
> +                       BTF_TYPE_ARRAY_ENC(2, 2, 1),                     =
               /* [4] */
> +                       BTF_STRUCT_ENC(NAME_NTH(3), 2, 8),               =
               /* [5] */
> +                       BTF_MEMBER_ENC(NAME_NTH(4), 3, 0),
> +                       BTF_MEMBER_ENC(NAME_NTH(5), 3, 32),
> +                       BTF_STRUCT_ENC(NAME_NTH(3), 2, 8),               =
               /* [6] */
> +                       BTF_MEMBER_ENC(NAME_NTH(4), 3, 0),
> +                       BTF_MEMBER_ENC(NAME_NTH(5), 4, 32),
> +                       BTF_END_RAW,
> +               },
> +               BTF_STR_SEC("\0int\0unsigned int\0s\0a\0b"),
> +       },
> +},
> +{
> +       .descr =3D "dedup: identical array element comparison",
> +       .input =3D {
> +               .raw_types =3D {
> +                       /* int */
> +                       BTF_TYPE_INT_ENC(NAME_NTH(1), BTF_INT_SIGNED, 0, =
32, 4), /* [1] */
> +                       /* struct container { struct elem first[1]; struc=
t elem second[1]; } */
> +                       BTF_STRUCT_ENC(NAME_NTH(2), 2, 8),               =
               /* [2] */
> +                       BTF_MEMBER_ENC(NAME_NTH(3), 3, 0),
> +                       BTF_MEMBER_ENC(NAME_NTH(4), 3, 32),
> +                       /* struct elem[1] */
> +                       BTF_TYPE_ARRAY_ENC(4, 1, 1),                     =
               /* [3] */
> +                       /* struct elem { int x; } */
> +                       BTF_STRUCT_ENC(NAME_NTH(5), 1, 4),               =
               /* [4] */
> +                       BTF_MEMBER_ENC(NAME_NTH(6), 1, 0),
> +                       /* duplicate struct container */
> +                       BTF_STRUCT_ENC(NAME_NTH(2), 2, 8),               =
               /* [5] */
> +                       BTF_MEMBER_ENC(NAME_NTH(3), 6, 0),
> +                       BTF_MEMBER_ENC(NAME_NTH(4), 7, 32),
> +                       /* duplicate struct elem[1] */
> +                       BTF_TYPE_ARRAY_ENC(8, 1, 1),                     =
               /* [6] */
> +                       BTF_TYPE_ARRAY_ENC(9, 1, 1),                     =
               /* [7] */
> +                       /* duplicate struct elem */
> +                       BTF_STRUCT_ENC(NAME_NTH(5), 1, 4),               =
               /* [8] */
> +                       BTF_MEMBER_ENC(NAME_NTH(6), 1, 0),
> +                       BTF_STRUCT_ENC(NAME_NTH(5), 1, 4),               =
               /* [9] */
> +                       BTF_MEMBER_ENC(NAME_NTH(6), 1, 0),
> +                       BTF_END_RAW,
> +               },
> +               BTF_STR_SEC("\0int\0container\0first\0second\0elem\0x"),
> +       },
> +       .expect =3D {
> +               .raw_types =3D {
> +                       BTF_TYPE_INT_ENC(NAME_NTH(1), BTF_INT_SIGNED, 0, =
32, 4), /* [1] */
> +                       BTF_STRUCT_ENC(NAME_NTH(2), 2, 8),               =
               /* [2] */
> +                       BTF_MEMBER_ENC(NAME_NTH(3), 3, 0),
> +                       BTF_MEMBER_ENC(NAME_NTH(4), 3, 32),
> +                       BTF_TYPE_ARRAY_ENC(4, 1, 1),                     =
               /* [3] */
> +                       BTF_STRUCT_ENC(NAME_NTH(5), 1, 4),               =
               /* [4] */
> +                       BTF_MEMBER_ENC(NAME_NTH(6), 1, 0),
> +                       BTF_END_RAW,
> +               },
> +               BTF_STR_SEC("\0int\0container\0first\0second\0elem\0x"),
> +       },
> +},
>  {
>         .descr =3D "dedup: struct example #1",
>         /*
>
> > ---
> >  .../selftests/bpf/prog_tests/btf_dedup.c      | 68 +++++++++++++++++++
> >  1 file changed, 68 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_dedup.c
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dedup.c b/tools=
/testing/selftests/bpf/prog_tests/btf_dedup.c
> > new file mode 100644
> > index 000000000000..3e889c0bed53
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/btf_dedup.c
> > @@ -0,0 +1,68 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include <test_progs.h>
> > +#include <bpf/btf.h>
> > +#include "btf_helpers.h"
> > +
> > +static void test_array_element_types(bool identical)
> > +{
> > +     struct btf *btf;
> > +
> > +     btf =3D btf__new_empty();
> > +     if (!ASSERT_OK_PTR(btf, "btf_new"))
> > +             return;
> > +
> > +     /*
> > +      * Comparing the first fields maps array [3] to [6]. The second
> > +      * fields reuse [3], requiring an identical-type check of [6]/[7]=
.
> > +      * Place container [5] before its elements [8]/[9] so they still
> > +      * have distinct IDs when their definitions are compared.
> > +      */
> > +     if (!ASSERT_EQ(btf__add_int(btf, "int", 4, BTF_INT_SIGNED), 1, "i=
nt") ||
> > +         !ASSERT_EQ(btf__add_struct(btf, "container", 8), 2, "containe=
r1") ||
> > +         !ASSERT_OK(btf__add_field(btf, "first", 3, 0, 0), "first1") |=
|
> > +         !ASSERT_OK(btf__add_field(btf, "second", 3, 32, 0), "second1"=
) ||
> > +         !ASSERT_EQ(btf__add_array(btf, 1, 4, 1), 3, "array1") ||
> > +         !ASSERT_EQ(btf__add_struct(btf, "elem", 4), 4, "elem1") ||
> > +         !ASSERT_OK(btf__add_field(btf, "x", 1, 0, 0), "elem1_field") =
||
> > +         !ASSERT_EQ(btf__add_struct(btf, "container", 8), 5, "containe=
r2") ||
> > +         !ASSERT_OK(btf__add_field(btf, "first", 6, 0, 0), "first2") |=
|
> > +         !ASSERT_OK(btf__add_field(btf, "second", 7, 32, 0), "second2"=
) ||
> > +         !ASSERT_EQ(btf__add_array(btf, 1, 8, 1), 6, "array2") ||
> > +         !ASSERT_EQ(btf__add_array(btf, 1, 9, 1), 7, "array3") ||
> > +         !ASSERT_EQ(btf__add_struct(btf, "elem", 4), 8, "elem2") ||
> > +         !ASSERT_OK(btf__add_field(btf, "x", 1, 0, 0), "elem2_field") =
||
> > +         !ASSERT_EQ(btf__add_struct(btf, "elem", 4), 9, "elem3") ||
> > +         !ASSERT_OK(btf__add_field(btf, identical ? "x" : "y", 1, 0, 0=
), "elem3_field"))
> > +             goto out;
> > +
> > +     if (!ASSERT_OK(btf__dedup(btf, NULL), "dedup"))
> > +             goto out;
> > +
> > +     /* Identical elements leave only the first four expected types. *=
/
> > +     btf_validate_raw(btf, identical ? 4 : 7, (const char *[]) {
> > +             "[1] INT 'int' size=3D4 bits_offset=3D0 nr_bits=3D32 enco=
ding=3DSIGNED",
> > +             "[2] STRUCT 'container' size=3D8 vlen=3D2\n"
> > +             "\t'first' type_id=3D3 bits_offset=3D0\n"
> > +             "\t'second' type_id=3D3 bits_offset=3D32",
> > +             "[3] ARRAY '(anon)' type_id=3D4 index_type_id=3D1 nr_elem=
s=3D1",
> > +             "[4] STRUCT 'elem' size=3D4 vlen=3D1\n"
> > +             "\t'x' type_id=3D1 bits_offset=3D0",
> > +             "[5] STRUCT 'container' size=3D8 vlen=3D2\n"
> > +             "\t'first' type_id=3D3 bits_offset=3D0\n"
> > +             "\t'second' type_id=3D6 bits_offset=3D32",
> > +             "[6] ARRAY '(anon)' type_id=3D7 index_type_id=3D1 nr_elem=
s=3D1",
> > +             "[7] STRUCT 'elem' size=3D4 vlen=3D1\n"
> > +             "\t'y' type_id=3D1 bits_offset=3D0",
> > +     });
> > +
> > +out:
> > +     btf__free(btf);
> > +}
> > +
> > +void test_btf_dedup(void)
> > +{
> > +     if (test__start_subtest("array_different_element_types"))
> > +             test_array_element_types(false);
> > +     if (test__start_subtest("array_identical_element_types"))
> > +             test_array_element_types(true);
> > +}
>
