Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D880171664
	for <bpf@vger.kernel.org>; Fri,  5 Apr 2024 17:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712338558; cv=none; b=IBwEd/XvVxTUNA0r8Po1e9sFp3ib8ihGH/9N8fgtoHycNNCFA1PqElm13E31a3/UTAXXAeiyJCJCOxYOOitg2a9fjoZNnUXKeXLQ+TrvxQtOySGGfqx7TujqOgwWpgT8/ukNPG/U8QWM0WGjfbpxdEk/hWDLtKg46zcb/seiWN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712338558; c=relaxed/simple;
	bh=Z4i/TzxWMH8U/mLk9Bw5INIIN8GvLnLrRrAUeZjHpSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qBy+kyLgmTlQsrl1uTmq45n6hYkczdPB2atrRYD76mP8kRKcxrcxCyhsXZj2G8/We3YNJXeYoafL5O81rYmQjnisXDdn6/42nTJxylmn7xWMIeIaLyAeKXRrU9HydH/KcbgGVsnFkJMma2mt2Mn55Yj0q/S2c+OelDv2+XfijAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TxR7YDq7; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TxR7YDq7"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e0d8403257so21922545ad.1
        for <bpf@vger.kernel.org>; Fri, 05 Apr 2024 10:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712338557; x=1712943357; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dv+yaK5hzGkv+cl9dZjWW8BxHbrbGkhTud+78mVD9IY=;
        b=TxR7YDq7NqZZ4WRghIRiIrZD4EXKDL+PR7UrfMxdBlL2n+P+Az6sF8AMt1NdWkxXt+
         7lxrtvDtjGhMruwiIc+T37aAkMIqri8uoKIKXgFS7O9uGWmMCnL31Y1b43AIcIo2cH/x
         ntAYDutX/IrwpLOnUzT/IeR29PwIjFnGc0aigVo0EkqotX3oI95XB/yQmXT6IAr4hdHK
         DlAZ3oOtiWbIuyrYhkyA+B1ZdousZ8lu6cGaO+68lASPJPgJOkC4Sr9IlB9UtfCpEL5n
         QpkTa5MmCThpr3JTUg2xAfPOjr70as3f7yZeD2g5q/c4PVYdGbGgq0rFaPLiJSw70Awd
         HQag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712338557; x=1712943357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dv+yaK5hzGkv+cl9dZjWW8BxHbrbGkhTud+78mVD9IY=;
        b=l2Z5IMsgEHmHU6kIwrw8JN42bxX6MYaJ3ulucMs18mqu670P57YwMy5NAfirlTzSs2
         +SzmWKlkdPF6QRwdNYWB4OIx5aPp4fwVA7itlav29PY2tTAO5Tk+O6oOuAcl2SY34Ra3
         bdKfCM2IQFCCgTz/LIgWG2h5pH1XCO2Ow8UamE8xg26MD9pd7iSgaldaDtok2LwsvpTU
         cSpVAw25nYSUpTRoqargMj4asKLAciz0dSPJ4Ph7iYrqjgCTeuTf4g4X587+eedhUZeV
         guQf/eYoyWmr0BM0uGV0hYG8NG2Kk/BzJslVJXkcZA6ksU3qPKB1Owed/JPXqp6OGZSX
         /0YA==
X-Gm-Message-State: AOJu0Yyng1t3udGEZGEcfHY1hGqqOvBbKlm9j0rfe9VizAJtB9isO83F
	C6jWPJgSYnJTA41NVPqfd5guR+6x8G7yrQlZRtgT9lFUcNPUBmpL4UUY2bx8H5H19cPMM5frdHJ
	yNM+bLzMcTI2YHfvw1pWDgJZUgxc=
X-Google-Smtp-Source: AGHT+IHxe30XJT/rd7k75kjefrmwvy77bsNHD3N9y9c8bLOgxuFAdDSiCqfkS9JXROt2vVR53eU/ywtlUfFWjhTP2pE=
X-Received: by 2002:a17:902:da8e:b0:1e3:d38c:9e4b with SMTP id
 j14-20020a170902da8e00b001e3d38c9e4bmr198339plx.67.1712338556527; Fri, 05 Apr
 2024 10:35:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405025536.18113-1-lulie@linux.alibaba.com> <20240405025536.18113-4-lulie@linux.alibaba.com>
In-Reply-To: <20240405025536.18113-4-lulie@linux.alibaba.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 5 Apr 2024 10:35:44 -0700
Message-ID: <CAEf4BzYTOeOhGOXihA-MWBt_yXt2ogubmqyGUTjpmG8Q5K5Oew@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 3/3] selftests/bpf: add test for
 bpf_for_each_map_elem() with different maps
To: Philo Lu <lulie@linux.alibaba.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	mykolal@fb.com, shuah@kernel.org, xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 7:55=E2=80=AFPM Philo Lu <lulie@linux.alibaba.com> w=
rote:
>
> A test is added for bpf_for_each_map_elem() with either an arraymap or a
> hashmap.
> $ tools/testing/selftests/bpf/test_progs -t for_each
>  #93/1    for_each/hash_map:OK
>  #93/2    for_each/array_map:OK
>  #93/3    for_each/write_map_key:OK
>  #93/4    for_each/multi_maps:OK
>  #93      for_each:OK
> Summary: 1/4 PASSED, 0 SKIPPED, 0 FAILED
>
> Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
> ---
>  .../selftests/bpf/prog_tests/for_each.c       | 62 +++++++++++++++++++
>  .../selftests/bpf/progs/for_each_multi_maps.c | 49 +++++++++++++++
>  2 files changed, 111 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/for_each_multi_maps=
.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/for_each.c b/tools/te=
sting/selftests/bpf/prog_tests/for_each.c
> index 8963f8a549f2..09f6487f58b9 100644
> --- a/tools/testing/selftests/bpf/prog_tests/for_each.c
> +++ b/tools/testing/selftests/bpf/prog_tests/for_each.c
> @@ -5,6 +5,7 @@
>  #include "for_each_hash_map_elem.skel.h"
>  #include "for_each_array_map_elem.skel.h"
>  #include "for_each_map_elem_write_key.skel.h"
> +#include "for_each_multi_maps.skel.h"
>
>  static unsigned int duration;
>
> @@ -143,6 +144,65 @@ static void test_write_map_key(void)
>                 for_each_map_elem_write_key__destroy(skel);
>  }
>
> +static void test_multi_maps(void)
> +{
> +       struct for_each_multi_maps *skel;
> +       __u64 val, array_total, hash_total;
> +       __u32 key, max_entries;
> +       int i, err;
> +
> +       LIBBPF_OPTS(bpf_test_run_opts, topts,
> +               .data_in =3D &pkt_v4,
> +               .data_size_in =3D sizeof(pkt_v4),
> +               .repeat =3D 1,
> +       );
> +
> +       skel =3D for_each_multi_maps__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "for_each_multi_maps__open_and_load"))
> +               return;
> +
> +       array_total =3D 0;
> +       max_entries =3D bpf_map__max_entries(skel->maps.arraymap);
> +       for (i =3D 0; i < max_entries; i++) {
> +               key =3D i;
> +               val =3D i + 1;
> +               array_total +=3D val;
> +               err =3D bpf_map__update_elem(skel->maps.arraymap, &key, s=
izeof(key),
> +                                          &val, sizeof(val), BPF_ANY);
> +               if (!ASSERT_OK(err, "array_map_update"))
> +                       goto out;
> +       }
> +
> +       hash_total =3D 0;
> +       max_entries =3D bpf_map__max_entries(skel->maps.hashmap);
> +       for (i =3D 0; i < max_entries; i++) {
> +               key =3D i + 100;
> +               val =3D i + 1;
> +               hash_total +=3D val;
> +               err =3D bpf_map__update_elem(skel->maps.hashmap, &key, si=
zeof(key),
> +                                          &val, sizeof(val), BPF_ANY);
> +               if (!ASSERT_OK(err, "hash_map_update"))
> +                       goto out;
> +       }
> +
> +       skel->bss->data_output =3D 0;
> +       skel->bss->use_array =3D 1;
> +       err =3D bpf_prog_test_run_opts(bpf_program__fd(skel->progs.test_p=
kt_access), &topts);
> +       ASSERT_OK(err, "bpf_prog_test_run_opts");
> +       ASSERT_OK(topts.retval, "retval");
> +       ASSERT_EQ(skel->bss->data_output, array_total, "array output");
> +
> +       skel->bss->data_output =3D 0;
> +       skel->bss->use_array =3D 0;
> +       err =3D bpf_prog_test_run_opts(bpf_program__fd(skel->progs.test_p=
kt_access), &topts);
> +       ASSERT_OK(err, "bpf_prog_test_run_opts");
> +       ASSERT_OK(topts.retval, "retval");
> +       ASSERT_EQ(skel->bss->data_output, hash_total, "hash output");
> +
> +out:
> +       for_each_multi_maps__destroy(skel);
> +}
> +
>  void test_for_each(void)
>  {
>         if (test__start_subtest("hash_map"))
> @@ -151,4 +211,6 @@ void test_for_each(void)
>                 test_array_map();
>         if (test__start_subtest("write_map_key"))
>                 test_write_map_key();
> +       if (test__start_subtest("multi_maps"))
> +               test_multi_maps();
>  }
> diff --git a/tools/testing/selftests/bpf/progs/for_each_multi_maps.c b/to=
ols/testing/selftests/bpf/progs/for_each_multi_maps.c
> new file mode 100644
> index 000000000000..ff0bed7d4459
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/for_each_multi_maps.c
> @@ -0,0 +1,49 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +
> +char _license[] SEC("license") =3D "GPL";
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_ARRAY);
> +       __uint(max_entries, 3);
> +       __type(key, __u32);
> +       __type(value, __u64);
> +} arraymap SEC(".maps");
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_HASH);
> +       __uint(max_entries, 5);
> +       __type(key, __u32);
> +       __type(value, __u64);
> +} hashmap SEC(".maps");
> +
> +struct callback_ctx {
> +       int output;
> +};
> +
> +u32 data_output =3D 0;
> +int use_array =3D 0;
> +
> +static __u64
> +check_map_elem(struct bpf_map *map, __u32 *key, __u64 *val,
> +              struct callback_ctx *data)
> +{
> +       data->output +=3D *val;
> +       return 0;
> +}
> +
> +SEC("tc")
> +int test_pkt_access(struct __sk_buff *skb)
> +{
> +       struct callback_ctx data;
> +
> +       data.output =3D 0;
> +       if (use_array)
> +               bpf_for_each_map_elem(&arraymap, check_map_elem, &data, 0=
);
> +       else
> +               bpf_for_each_map_elem(&hashmap, check_map_elem, &data, 0)=
;

you are relying on the compiler to combine bpf_for_each_map_elem calls
to one call instruction and just passing different map pointers,
right? It would be best to code this in BPF assembly so that this
doesn't rely on compiler decisions and optimizations.

> +       data_output =3D data.output;
> +
> +       return 0;
> +}
> --
> 2.32.0.3.g01195cf9f
>
