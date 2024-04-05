Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FCE1D530
	for <bpf@vger.kernel.org>; Fri,  5 Apr 2024 17:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712338882; cv=none; b=n8TCRtF3Fgyu0hewATAzjW/5SG067dycC+xyc9OQu8mZyVKeeNLQvbUdBJJV4wbcal1hkWtoDAaO7wdG3Ju0tumLWmgMC6I0fHEUjo9+bhoro8grkfciIKnbfRpglx1aNDThDx71IakzBTAwGa+1S7CXsNHJQlUnxDnBpDWQ9gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712338882; c=relaxed/simple;
	bh=Y90eMPvnLiNymCSzKAr6Y4ux1ECiDviUMzbOLP+TYVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gQgXxoavz3BAuZw89Eq0TAGNpbk5RO7eBmwSA6DSLWpPYuO6mcvY5gfVkoKKGCGrtO/YfV8dUX92BFRHZsyOh7BndBiIQJdqvB7ZRwLLCiwy90Cb3PZBqrfOIdjRgd87huuiyldPaFAxUR81fIjzKWPspYMzOzsk2qGe8HBHhFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R1D8kXeZ; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1D8kXeZ"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-343eb6cc46bso460500f8f.2
        for <bpf@vger.kernel.org>; Fri, 05 Apr 2024 10:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712338879; x=1712943679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JE8mIO/HEVkVkHgs6fwRjGFDpFkzdi/XLSXTgXvU7bQ=;
        b=R1D8kXeZ2shqSF5u5W2VAwS7tObKHkc/Vs36q++9uXh936sqlspmOKdHLjV4OCbefQ
         TB2XzL9b/oM8LiBkb+eIsoOfgyy56M2sT22jsMU46RUVSiExPXoYSeIZGU1ZvZSdux+g
         RNp6fkShUYNtlYyWGa1TUoAu5AiCCMhmx4QZHO/nVk3B49Y9JTaxmmFRBdk2tVqSKZdN
         EvbI0gnwy7xWU8YT4rzbmfe47L0T0c20HaQrtbpXjNJidmc2BZ1C5iV0B0NUvsAAErlL
         MFqYk7+9UfteDYLKgH2TBwOrmRF1suvDoh7M7Xm6Iyp09LKUMgrxJrAu7zMJT7QRGL4z
         0iPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712338879; x=1712943679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JE8mIO/HEVkVkHgs6fwRjGFDpFkzdi/XLSXTgXvU7bQ=;
        b=unBDABaNfdj0YHbSGsDO8JtAAceKY8PJEQKJ1JeNIjodgAeH1959z9gCBvmAYw1rXS
         QU0UrTUpOqfX7JeSmoBrjCdbDR/XPgQlXsD+RDbPJ9rGCJiYjEpji0nQdN4oaN5MUBVV
         Trbz1fLYCqA/dUGWM4jfIlTAaJ7T35MYnoxPWjkYnzi5Z19wsXv5cIVRjx+sp+cevpd9
         kYyOX9mgkwOpkNFLgHBjarTTiiPhYABadPfiTOc3nrkYE8jFhiZwC6e72RrJFhcLV20P
         Gu0aoUwuCWeml621DFppHJY8h6fopFwnEZ2qfscUP2I8jSG202bEVL8FFDpgqEiWJh3U
         qn0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXXX8vt/PFa9SGHDN0+EL5xP++PcdOtN5KsZKDNzJEHHs8HBxfLwqx0SYUllRKyjpx+a4v6grDXIXrd4w4hFYE5PYzd
X-Gm-Message-State: AOJu0Yxmq2JbyCa4kWPUpPPQ0M9iUTSnJ3vEaiRaIGFJnPhyaa61RoEm
	aVIsJV+p9P247mubVoRiq2mC3Q1Hy3Zu2o41w3LEvX6hmsxSlAgM6XYn7lOcDMsnrG1OY9PYjLB
	B8o74si9m+7UZOZS7MIOfnATwvgE=
X-Google-Smtp-Source: AGHT+IExopTjH0vmRoD/OEWtiitROCqJHr3lFD+DSd2T1jOxeoZpDxSGziUVkYIn+B+xxHUAHN2D4jcsIO30u0ot/Z4=
X-Received: by 2002:a5d:444e:0:b0:343:83fb:5148 with SMTP id
 x14-20020a5d444e000000b0034383fb5148mr1499570wrr.25.1712338879033; Fri, 05
 Apr 2024 10:41:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405025536.18113-1-lulie@linux.alibaba.com>
 <20240405025536.18113-4-lulie@linux.alibaba.com> <CAEf4BzYTOeOhGOXihA-MWBt_yXt2ogubmqyGUTjpmG8Q5K5Oew@mail.gmail.com>
In-Reply-To: <CAEf4BzYTOeOhGOXihA-MWBt_yXt2ogubmqyGUTjpmG8Q5K5Oew@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 5 Apr 2024 10:41:07 -0700
Message-ID: <CAADnVQLcSBX4Pq-hF5f_r2p+JV7HeqcDgg+za0GjAKRH0TQssA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 3/3] selftests/bpf: add test for
 bpf_for_each_map_elem() with different maps
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
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

On Fri, Apr 5, 2024 at 10:36=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Apr 4, 2024 at 7:55=E2=80=AFPM Philo Lu <lulie@linux.alibaba.com>=
 wrote:
> >
> > A test is added for bpf_for_each_map_elem() with either an arraymap or =
a
> > hashmap.
> > $ tools/testing/selftests/bpf/test_progs -t for_each
> >  #93/1    for_each/hash_map:OK
> >  #93/2    for_each/array_map:OK
> >  #93/3    for_each/write_map_key:OK
> >  #93/4    for_each/multi_maps:OK
> >  #93      for_each:OK
> > Summary: 1/4 PASSED, 0 SKIPPED, 0 FAILED
> >
> > Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
> > ---
> >  .../selftests/bpf/prog_tests/for_each.c       | 62 +++++++++++++++++++
> >  .../selftests/bpf/progs/for_each_multi_maps.c | 49 +++++++++++++++
> >  2 files changed, 111 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/progs/for_each_multi_ma=
ps.c
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/for_each.c b/tools/=
testing/selftests/bpf/prog_tests/for_each.c
> > index 8963f8a549f2..09f6487f58b9 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/for_each.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/for_each.c
> > @@ -5,6 +5,7 @@
> >  #include "for_each_hash_map_elem.skel.h"
> >  #include "for_each_array_map_elem.skel.h"
> >  #include "for_each_map_elem_write_key.skel.h"
> > +#include "for_each_multi_maps.skel.h"
> >
> >  static unsigned int duration;
> >
> > @@ -143,6 +144,65 @@ static void test_write_map_key(void)
> >                 for_each_map_elem_write_key__destroy(skel);
> >  }
> >
> > +static void test_multi_maps(void)
> > +{
> > +       struct for_each_multi_maps *skel;
> > +       __u64 val, array_total, hash_total;
> > +       __u32 key, max_entries;
> > +       int i, err;
> > +
> > +       LIBBPF_OPTS(bpf_test_run_opts, topts,
> > +               .data_in =3D &pkt_v4,
> > +               .data_size_in =3D sizeof(pkt_v4),
> > +               .repeat =3D 1,
> > +       );
> > +
> > +       skel =3D for_each_multi_maps__open_and_load();
> > +       if (!ASSERT_OK_PTR(skel, "for_each_multi_maps__open_and_load"))
> > +               return;
> > +
> > +       array_total =3D 0;
> > +       max_entries =3D bpf_map__max_entries(skel->maps.arraymap);
> > +       for (i =3D 0; i < max_entries; i++) {
> > +               key =3D i;
> > +               val =3D i + 1;
> > +               array_total +=3D val;
> > +               err =3D bpf_map__update_elem(skel->maps.arraymap, &key,=
 sizeof(key),
> > +                                          &val, sizeof(val), BPF_ANY);
> > +               if (!ASSERT_OK(err, "array_map_update"))
> > +                       goto out;
> > +       }
> > +
> > +       hash_total =3D 0;
> > +       max_entries =3D bpf_map__max_entries(skel->maps.hashmap);
> > +       for (i =3D 0; i < max_entries; i++) {
> > +               key =3D i + 100;
> > +               val =3D i + 1;
> > +               hash_total +=3D val;
> > +               err =3D bpf_map__update_elem(skel->maps.hashmap, &key, =
sizeof(key),
> > +                                          &val, sizeof(val), BPF_ANY);
> > +               if (!ASSERT_OK(err, "hash_map_update"))
> > +                       goto out;
> > +       }
> > +
> > +       skel->bss->data_output =3D 0;
> > +       skel->bss->use_array =3D 1;
> > +       err =3D bpf_prog_test_run_opts(bpf_program__fd(skel->progs.test=
_pkt_access), &topts);
> > +       ASSERT_OK(err, "bpf_prog_test_run_opts");
> > +       ASSERT_OK(topts.retval, "retval");
> > +       ASSERT_EQ(skel->bss->data_output, array_total, "array output");
> > +
> > +       skel->bss->data_output =3D 0;
> > +       skel->bss->use_array =3D 0;
> > +       err =3D bpf_prog_test_run_opts(bpf_program__fd(skel->progs.test=
_pkt_access), &topts);
> > +       ASSERT_OK(err, "bpf_prog_test_run_opts");
> > +       ASSERT_OK(topts.retval, "retval");
> > +       ASSERT_EQ(skel->bss->data_output, hash_total, "hash output");
> > +
> > +out:
> > +       for_each_multi_maps__destroy(skel);
> > +}
> > +
> >  void test_for_each(void)
> >  {
> >         if (test__start_subtest("hash_map"))
> > @@ -151,4 +211,6 @@ void test_for_each(void)
> >                 test_array_map();
> >         if (test__start_subtest("write_map_key"))
> >                 test_write_map_key();
> > +       if (test__start_subtest("multi_maps"))
> > +               test_multi_maps();
> >  }
> > diff --git a/tools/testing/selftests/bpf/progs/for_each_multi_maps.c b/=
tools/testing/selftests/bpf/progs/for_each_multi_maps.c
> > new file mode 100644
> > index 000000000000..ff0bed7d4459
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/for_each_multi_maps.c
> > @@ -0,0 +1,49 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include "vmlinux.h"
> > +#include <bpf/bpf_helpers.h>
> > +
> > +char _license[] SEC("license") =3D "GPL";
> > +
> > +struct {
> > +       __uint(type, BPF_MAP_TYPE_ARRAY);
> > +       __uint(max_entries, 3);
> > +       __type(key, __u32);
> > +       __type(value, __u64);
> > +} arraymap SEC(".maps");
> > +
> > +struct {
> > +       __uint(type, BPF_MAP_TYPE_HASH);
> > +       __uint(max_entries, 5);
> > +       __type(key, __u32);
> > +       __type(value, __u64);
> > +} hashmap SEC(".maps");
> > +
> > +struct callback_ctx {
> > +       int output;
> > +};
> > +
> > +u32 data_output =3D 0;
> > +int use_array =3D 0;
> > +
> > +static __u64
> > +check_map_elem(struct bpf_map *map, __u32 *key, __u64 *val,
> > +              struct callback_ctx *data)
> > +{
> > +       data->output +=3D *val;
> > +       return 0;
> > +}
> > +
> > +SEC("tc")
> > +int test_pkt_access(struct __sk_buff *skb)
> > +{
> > +       struct callback_ctx data;
> > +
> > +       data.output =3D 0;
> > +       if (use_array)
> > +               bpf_for_each_map_elem(&arraymap, check_map_elem, &data,=
 0);
> > +       else
> > +               bpf_for_each_map_elem(&hashmap, check_map_elem, &data, =
0);
>
> you are relying on the compiler to combine bpf_for_each_map_elem calls
> to one call instruction and just passing different map pointers,
> right? It would be best to code this in BPF assembly so that this
> doesn't rely on compiler decisions and optimizations.

It will look sad in asm. C is fine.
Maybe a follow up with
void *map;
if (..)
   map =3D &array;
else
   map =3D &hash;

bpf_for_each_map_elem(map, ...);

but optional. imo.
