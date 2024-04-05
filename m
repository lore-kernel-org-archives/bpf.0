Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5656E171674
	for <bpf@vger.kernel.org>; Fri,  5 Apr 2024 17:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712339534; cv=none; b=Ue+v7dq5skR4MFsEYP3eDzwT/1fyM/+0dyMMUXNbAuJt4jDRobW1o/Nc+U0NUXSuWByhKUyFvfar6FG74aaugXKWsbj+OF4yDIVgKwEmQndNPKF8MmnTszbIlABlPysOVsgJLuxJuYoKxjFZadoq8UunyoZbEvp96KJBt+EN3is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712339534; c=relaxed/simple;
	bh=EqKzB53OabCbc+/hR/ZZStgFdDeD51CHxy6vNrU9KBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mtKFbZwDCT/8W50esDE/2isa6jI1GDXyDHc248YhTUw6wIlTTfbqFoxiy3kVRHNx75ZQ53rk59BaExfFxx14yYSUIZ+mCUBeuLmeKWhUK3Wv8jey9QXy/AWXln4uagRrCAP8ZxwL4D858meTaEfqWqz7Pav4lNqoEV1A8xOi+ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kixglCyr; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kixglCyr"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e3c7549078so4672195ad.0
        for <bpf@vger.kernel.org>; Fri, 05 Apr 2024 10:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712339532; x=1712944332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s1oh43RF2o5oW7Q654+xJldkgDSZNYHyZU6kE17dLE8=;
        b=kixglCyrox8qyrrPp4jypsiRdeeO/eOoyHM1p38L+gq+dOoR2fEhZts9oqJD2MaCls
         krztBT5nfxBswZgwSjoQEF6rKjFAWyCZtLSvgeza4jYeFCB1pgcr0du8Vnz1dLWystkZ
         f/EWp0vOhGCQn78YOwAnypXdpoDWjS1Sjh2le3GWF3GjKs0pUKbEL0SWrEhYvhUEg8Ht
         qMw7gezmKYG0in5wkZFWTEtI3YXYHYnVXoNE7F6RHGxUeOMK3Fg2luGVtXMcQUjxGITz
         4jw1FshwaEGs6NYXRoR6/Pl74IVi7QtTFXKp/Iu7NhAd//GoMnDmh+VPvzjR2r9Nt/8E
         0bgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712339532; x=1712944332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s1oh43RF2o5oW7Q654+xJldkgDSZNYHyZU6kE17dLE8=;
        b=OHi02mtNHoDg5l6FfZHh7x3ClIZFJvhHaFCPwM0SOqKtxTzIkQWpx/Ij66x6VL/K/8
         nrH6pKIU/XlHUoHacVltAViCaJBqnejsU0DV4rHILz3Fza+WyR40MqbrYxbDAJuU+Rft
         KsSBOrWpCwl1hkjQzVTCxZsTfQk1RvaZ2JuCj0KkP2Y2O73PXnbj9ja0EzEjFM0B54G8
         WeFvhspDxuQoFkiltmsI/NACaw8iLTCZzEg5jpX5Fq9jOmBbs7rtKGTBgremT2qzIRRr
         cy6iKZA0V0nrUvsuqd7R2biOz3RcCROaxqxlUUVSMXuPVhq7Kirpbr1Xu3s2SZaHCzbE
         Cd7g==
X-Forwarded-Encrypted: i=1; AJvYcCUXO2wYk9Oge/YDz2Z2FRqEKat5ekIX2eMgtwyoxkxyNWl+B+yNiWOl4ILhvpcmUyG6Igo6q3zn+TcZZ+DuZJ+wjqtI
X-Gm-Message-State: AOJu0YxXLMy6TGUGfAi6g5jA1oRB0e8xJ2jHx+ljdvwfsyozfny0F+3v
	6VGRJm6MUQIeFagUo8ETswDzyV2v9eYllbBzY+VINVgL2W+emVH3m8Ej05pcFcYdTjAI3BlZjyW
	FeEa1xGbLgMmcfnLQ2NizU2xWNEo=
X-Google-Smtp-Source: AGHT+IFyfDPyRMj3XsdcDL+aUagAkHzto22Fwixt9tuM1WT5xTpRBuS2YwFToifI5r45hGArW/rH1lJpFAQ3hShp9f8=
X-Received: by 2002:a17:902:da87:b0:1e0:1f53:a164 with SMTP id
 j7-20020a170902da8700b001e01f53a164mr3296603plx.0.1712339532478; Fri, 05 Apr
 2024 10:52:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405025536.18113-1-lulie@linux.alibaba.com>
 <20240405025536.18113-4-lulie@linux.alibaba.com> <CAEf4BzYTOeOhGOXihA-MWBt_yXt2ogubmqyGUTjpmG8Q5K5Oew@mail.gmail.com>
 <CAADnVQLcSBX4Pq-hF5f_r2p+JV7HeqcDgg+za0GjAKRH0TQssA@mail.gmail.com>
In-Reply-To: <CAADnVQLcSBX4Pq-hF5f_r2p+JV7HeqcDgg+za0GjAKRH0TQssA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 5 Apr 2024 10:52:00 -0700
Message-ID: <CAEf4BzarN_-te3N2wdv6CvpWk6TPy5wHBvRaOfmyAzoDyWr+hg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 3/3] selftests/bpf: add test for
 bpf_for_each_map_elem() with different maps
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Philo Lu <lulie@linux.alibaba.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 10:41=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Apr 5, 2024 at 10:36=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Apr 4, 2024 at 7:55=E2=80=AFPM Philo Lu <lulie@linux.alibaba.co=
m> wrote:
> > >
> > > A test is added for bpf_for_each_map_elem() with either an arraymap o=
r a
> > > hashmap.
> > > $ tools/testing/selftests/bpf/test_progs -t for_each
> > >  #93/1    for_each/hash_map:OK
> > >  #93/2    for_each/array_map:OK
> > >  #93/3    for_each/write_map_key:OK
> > >  #93/4    for_each/multi_maps:OK
> > >  #93      for_each:OK
> > > Summary: 1/4 PASSED, 0 SKIPPED, 0 FAILED
> > >
> > > Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
> > > ---
> > >  .../selftests/bpf/prog_tests/for_each.c       | 62 +++++++++++++++++=
++
> > >  .../selftests/bpf/progs/for_each_multi_maps.c | 49 +++++++++++++++
> > >  2 files changed, 111 insertions(+)
> > >  create mode 100644 tools/testing/selftests/bpf/progs/for_each_multi_=
maps.c
> > >
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/for_each.c b/tool=
s/testing/selftests/bpf/prog_tests/for_each.c
> > > index 8963f8a549f2..09f6487f58b9 100644
> > > --- a/tools/testing/selftests/bpf/prog_tests/for_each.c
> > > +++ b/tools/testing/selftests/bpf/prog_tests/for_each.c
> > > @@ -5,6 +5,7 @@
> > >  #include "for_each_hash_map_elem.skel.h"
> > >  #include "for_each_array_map_elem.skel.h"
> > >  #include "for_each_map_elem_write_key.skel.h"
> > > +#include "for_each_multi_maps.skel.h"
> > >
> > >  static unsigned int duration;
> > >
> > > @@ -143,6 +144,65 @@ static void test_write_map_key(void)
> > >                 for_each_map_elem_write_key__destroy(skel);
> > >  }
> > >
> > > +static void test_multi_maps(void)
> > > +{
> > > +       struct for_each_multi_maps *skel;
> > > +       __u64 val, array_total, hash_total;
> > > +       __u32 key, max_entries;
> > > +       int i, err;
> > > +
> > > +       LIBBPF_OPTS(bpf_test_run_opts, topts,
> > > +               .data_in =3D &pkt_v4,
> > > +               .data_size_in =3D sizeof(pkt_v4),
> > > +               .repeat =3D 1,
> > > +       );
> > > +
> > > +       skel =3D for_each_multi_maps__open_and_load();
> > > +       if (!ASSERT_OK_PTR(skel, "for_each_multi_maps__open_and_load"=
))
> > > +               return;
> > > +
> > > +       array_total =3D 0;
> > > +       max_entries =3D bpf_map__max_entries(skel->maps.arraymap);
> > > +       for (i =3D 0; i < max_entries; i++) {
> > > +               key =3D i;
> > > +               val =3D i + 1;
> > > +               array_total +=3D val;
> > > +               err =3D bpf_map__update_elem(skel->maps.arraymap, &ke=
y, sizeof(key),
> > > +                                          &val, sizeof(val), BPF_ANY=
);
> > > +               if (!ASSERT_OK(err, "array_map_update"))
> > > +                       goto out;
> > > +       }
> > > +
> > > +       hash_total =3D 0;
> > > +       max_entries =3D bpf_map__max_entries(skel->maps.hashmap);
> > > +       for (i =3D 0; i < max_entries; i++) {
> > > +               key =3D i + 100;
> > > +               val =3D i + 1;
> > > +               hash_total +=3D val;
> > > +               err =3D bpf_map__update_elem(skel->maps.hashmap, &key=
, sizeof(key),
> > > +                                          &val, sizeof(val), BPF_ANY=
);
> > > +               if (!ASSERT_OK(err, "hash_map_update"))
> > > +                       goto out;
> > > +       }
> > > +
> > > +       skel->bss->data_output =3D 0;
> > > +       skel->bss->use_array =3D 1;
> > > +       err =3D bpf_prog_test_run_opts(bpf_program__fd(skel->progs.te=
st_pkt_access), &topts);
> > > +       ASSERT_OK(err, "bpf_prog_test_run_opts");
> > > +       ASSERT_OK(topts.retval, "retval");
> > > +       ASSERT_EQ(skel->bss->data_output, array_total, "array output"=
);
> > > +
> > > +       skel->bss->data_output =3D 0;
> > > +       skel->bss->use_array =3D 0;
> > > +       err =3D bpf_prog_test_run_opts(bpf_program__fd(skel->progs.te=
st_pkt_access), &topts);
> > > +       ASSERT_OK(err, "bpf_prog_test_run_opts");
> > > +       ASSERT_OK(topts.retval, "retval");
> > > +       ASSERT_EQ(skel->bss->data_output, hash_total, "hash output");
> > > +
> > > +out:
> > > +       for_each_multi_maps__destroy(skel);
> > > +}
> > > +
> > >  void test_for_each(void)
> > >  {
> > >         if (test__start_subtest("hash_map"))
> > > @@ -151,4 +211,6 @@ void test_for_each(void)
> > >                 test_array_map();
> > >         if (test__start_subtest("write_map_key"))
> > >                 test_write_map_key();
> > > +       if (test__start_subtest("multi_maps"))
> > > +               test_multi_maps();
> > >  }
> > > diff --git a/tools/testing/selftests/bpf/progs/for_each_multi_maps.c =
b/tools/testing/selftests/bpf/progs/for_each_multi_maps.c
> > > new file mode 100644
> > > index 000000000000..ff0bed7d4459
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/bpf/progs/for_each_multi_maps.c
> > > @@ -0,0 +1,49 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +#include "vmlinux.h"
> > > +#include <bpf/bpf_helpers.h>
> > > +
> > > +char _license[] SEC("license") =3D "GPL";
> > > +
> > > +struct {
> > > +       __uint(type, BPF_MAP_TYPE_ARRAY);
> > > +       __uint(max_entries, 3);
> > > +       __type(key, __u32);
> > > +       __type(value, __u64);
> > > +} arraymap SEC(".maps");
> > > +
> > > +struct {
> > > +       __uint(type, BPF_MAP_TYPE_HASH);
> > > +       __uint(max_entries, 5);
> > > +       __type(key, __u32);
> > > +       __type(value, __u64);
> > > +} hashmap SEC(".maps");
> > > +
> > > +struct callback_ctx {
> > > +       int output;
> > > +};
> > > +
> > > +u32 data_output =3D 0;
> > > +int use_array =3D 0;
> > > +
> > > +static __u64
> > > +check_map_elem(struct bpf_map *map, __u32 *key, __u64 *val,
> > > +              struct callback_ctx *data)
> > > +{
> > > +       data->output +=3D *val;
> > > +       return 0;
> > > +}
> > > +
> > > +SEC("tc")
> > > +int test_pkt_access(struct __sk_buff *skb)
> > > +{
> > > +       struct callback_ctx data;
> > > +
> > > +       data.output =3D 0;
> > > +       if (use_array)
> > > +               bpf_for_each_map_elem(&arraymap, check_map_elem, &dat=
a, 0);
> > > +       else
> > > +               bpf_for_each_map_elem(&hashmap, check_map_elem, &data=
, 0);
> >
> > you are relying on the compiler to combine bpf_for_each_map_elem calls
> > to one call instruction and just passing different map pointers,
> > right? It would be best to code this in BPF assembly so that this
> > doesn't rely on compiler decisions and optimizations.
>
> It will look sad in asm. C is fine.
> Maybe a follow up with
> void *map;
> if (..)
>    map =3D &array;
> else
>    map =3D &hash;
>

yep, this is simpler, no need to go for assembly

Though not sure why assembly would be sad, we do call subprograms by
their name (it's just symbols after all), so passing a pointer to
subprog should work just as well.

> bpf_for_each_map_elem(map, ...);
>
> but optional. imo.
