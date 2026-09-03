Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D464A0125
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 16:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788454686; cv=pass; b=krkVMnNnbL5q3RzP0b5z8TX2HdRn6AY8KRzSFBODYhJA2ACLyPn1Czhv6/80StcZffHiglOs4jpdQa6i+TJY7XN0qR2n7Sip/X25VYezyFR8AC51ly3AjEWpDhbq+LH2RVdkmEVcAqelF+YdD+lqGytRU4kzxxOMWlITDyWTdM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788454686; c=relaxed/simple;
	bh=5v0Q4fGhrUxAdCYXShOlUyChcpIspdM8rNBIvGy309A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hE/fW/Nveg4gjvSnNtmsE5mMB/Qzil/U8ZKPCPW+idALI6iAlcPKnKCz3vbT9jSVPd4ddFfybVqWwdhj2y65bEsAV8ZjcphDZVKnvtyW2xlrHgl7/1A1mddbHMzqOeto+auZ3YEc86oDw+J/gTrBNIIFbMYxe43rE82z2dRQsDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DYLATWSd; arc=pass smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DYLATWSd"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-4b2ff8ca537so63296b6e.3
        for <bpf@vger.kernel.org>; Thu, 03 Sep 2026 09:58:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788454684; cv=none;
        d=google.com; s=arc-20260327;
        b=qa7CocgkGrdx5K8y7itaLvES1uJ39kvb23NvWFNkkxDpAdzzy22q+GWg+tFG/ziJOe
         QhUaAc86N6Ob1gxsTz0AKotXNMiD1+MpjH8MKqI51J90M1jX40JJ71nzoJkGwi0ZD4O1
         e44T+kuCoCNzcL24hgyHgQxnwc5SLxNlCa6YGZvmQtYNuer2IlgijsKxlPN8KxYu/QiZ
         /JFktSyD4Tf6F3Xh5BSkrqrLBqc0w5d2dixLwHlx5zlN7Z6qIwdiUipLn78/sVLPDgpP
         GycacV352sDdvep9CQXPfh6Ma7n7hL+2jW1ocdxZ2wELBpKosCfrfnQOndonJYkWo028
         iMZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WbMjdElnP4E9FJJPQ3RIltMQzHwm/jXwzwr8DkbwvpA=;
        fh=ofyjMheACKDOyzGvlwXhw/ggJgJzyOvgdvqGapV6nCg=;
        b=Vo4UNkMe6vNyPKAJsUjy/DAmS7rNNzxBqx0dM8D6Ige1nTZ5Y3sYDewCDw2aXO37GT
         elAotq5RXrCtKwyM5hl5RYzect4Nuxp5g0aivFNWhHgwwZuY6N1XyBsXGiq90/o8uDS5
         SXQEg1qECAZksm2UErq4QCn8WbcpHwpOjNkujFhwOWkgnaU5AY1wqVp5hhpHtpAql+YA
         3e3MbDgnWN403CCVako5r5eA9DDQQsOoOLMnMAUzJdFpD3oi3VNX4h8MGvsryQmY9t8C
         DXGApnfARAjusk+lpm7KqTT+y2rgUcwtaggt9tZjnL4jhEHZtYC43XjCgJe8MQawkBCl
         jc9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788454684; x=1789059484; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WbMjdElnP4E9FJJPQ3RIltMQzHwm/jXwzwr8DkbwvpA=;
        b=DYLATWSdV9NyZPiBhy7yicWtHT5yu/abHB0X128fIx4cEWfYpsbGEkj55UivZEXNfc
         L79IDprDVxCHiGQns0cIN7YJzEPbDugXEYyd5wlwRXol71xyp+aCGQoWqL8ooWi4pXFP
         +fStclb1TptDamse9gcJZFCZ1Wff0h+AujlMbBALdIb2RG+x87p9gYTnbZVVtBfki+Yk
         +qvvdb5QLmnjAGkjo19Jh49hrhSBBHnARC/vkvjmIVvLAr0mDtknZtmMIa3JrHHYirMn
         ePLkzBaF/Du/WrJhh/dBUqywh85aAVIWmX/fWyoUtiNtFusyLsTjB0BWOR3Ks+Ulfv41
         pH4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788454684; x=1789059484;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WbMjdElnP4E9FJJPQ3RIltMQzHwm/jXwzwr8DkbwvpA=;
        b=A1IRDA4u/0zMwABIbv62rjQJXM1q41ES5HsSMhK3FT68+YGH9Pw7UAF1VIPEg7Qw3b
         3uMx8v4fpjLztBt0Bi6b47Nvt9rLjEv5r7UsKP0RCQ6ip3Z0KMqdKKzFvTTg2SBffhC2
         ofA0/JadwNCosW9OJf/ehU+bljbCMxBjM+NfRw3N9bPab9QjVVlTM+pjPPTVKScBs+CB
         1fZ4zPbnAOievBm6WM49nDO+LpjcGeEDkKcr0djuucb3/W6FKnZZLfZYABuC56I+Jhna
         fEUshZw0hBIu5Vn4rzSaZLTaTR1kWNhqAmgKHXDnhTNg8J6He7PGVwRVZoGAiMvRpTtx
         uZ1A==
X-Forwarded-Encrypted: i=1; AKwUvBxr+vbGPb2mO98P02I90N6vfMC1R1EW4mtJtLEhbGW3fulQ74y9h4+MxUwPlPEPFkq83WE=@vger.kernel.org
X-Gm-Message-State: AFuF++mUVj0wej48gDO3qNzbsHD6hr9E2zHvnY4/22SQ2Z6AaLk6KuIR
	9r8dMdmfk2dcQ18erYsQxi3zwuYlJuIi8pnJtdsVe/9WWhL2NY3pPuE5xz2/RFWSgx/+qiLgZQa
	MeJNfV1RcZbDpLCSjuFoYQhL+hBtbaWk=
X-Gm-Gg: AYBFou2tloDo0WL0Cw90HRW2diM7wrSeWXbDlfb2ACw/zwJ+j97x9LMESjImOLb4S+b
	CC6B1MUtL/FlG229//GmwUbdEMfCGRKKdElcq1HsjDx4+xZHIoaFSHa9ttmupcp3xPpDDGhYkZP
	afytga9NxVtrLEv29oWvVfjgiJM1fIRfVGNNIPm0vjgTrnp2HmyCsubCuRvJliUVB5HJaYqxBmP
	e36eVzlQJItiwfuaFVnT6JVfg44ty3MKhPj87JIfEZjY04zOJ7Gv9D/Zk8L0u8uOQ8OAkC+j66S
	8BlK8Cyt1+AzZKEzyIptbPU4qKZ1drn78pQ5te8V5jFs45amc9rAPm7i0fR5b27SL/dADn8h1xc
	B5Auy3C1MtGvA8w==
X-Received: by 2002:a05:6808:6808:b0:496:10e6:f76e with SMTP id
 5614622812f47-4b6bc444fb4mr13064884b6e.4.1788454683721; Thu, 03 Sep 2026
 09:58:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901141954.29449-1-suchitkarunakaran@gmail.com>
 <CAEf4Bza6wQb1mSiKA_6U7FovYivcZvf3MCvU9NMdt01w-wAZPQ@mail.gmail.com>
 <CAO9wTFiA6BHbTtP8Y8GCNnEQqXgsOzecuibK3zsjBKfyN8Nfkw@mail.gmail.com> <CAEf4BzYUREsJYXw7ZU9twCDcfEJ6cTpR4Ypbvf5JTABK0uGi2g@mail.gmail.com>
In-Reply-To: <CAEf4BzYUREsJYXw7ZU9twCDcfEJ6cTpR4Ypbvf5JTABK0uGi2g@mail.gmail.com>
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Date: Thu, 3 Sep 2026 22:27:51 +0530
X-Gm-Features: AcwNN1WsOO7p478pqpygOQboyXuQktY5bosuhGvq_GnaRXHWGgYlJR25dqj6rcU
Message-ID: <CAO9wTFiWkUUu5AE-C=sjwBLOxTDy6LAE-BA5oPoGCg2NmjSruA@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: Fix map_lookup_percpu_elem on sparse CPU IDs
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, 
	memxor@gmail.com, shuah@kernel.org, emil@etsalapatis.com, 
	ihor.solodrai@linux.dev, jolsa@kernel.org, martin.lau@linux.dev, 
	song@kernel.org, yonghong.song@linux.dev, zhoufeng.zf@bytedance.com, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 3 Sept 2026 at 21:31, Andrii Nakryiko <andrii.nakryiko@gmail.com> w=
rote:
>
> On Wed, Sep 2, 2026 at 10:29=E2=80=AFPM Suchit Karunakaran
> <suchitkarunakaran@gmail.com> wrote:
> >
> > On Thu, 3 Sept 2026 at 06:02, Andrii Nakryiko <andrii.nakryiko@gmail.co=
m> wrote:
> > >
> > > On Tue, Sep 1, 2026 at 7:20=E2=80=AFAM Suchit Karunakaran
> > > <suchitkarunakaran@gmail.com> wrote:
> > > >
> > > > libbpf_num_possible_cpus() returns the number of possible CPUs, whi=
ch is
> > > > appropriate for sizing packed per-CPU map value buffers. It is not =
the
> > > > upper bound for logical CPU IDs.
> > > >
> > > > For a possible CPU mask such as 0,2-3, the test loops over CPU IDs =
0
> > > > through 2. This incorrectly visits CPU 1 and misses CPU 3. It also
> > > > initializes packed per-CPU slots using their slot indexes rather th=
an
> > > > the corresponding logical CPU IDs.
> > > >
> > > > Parse the possible CPU mask and keep the packed slot count separate
> > > > from the logical CPU ID range. Populate each dense per-CPU slot wit=
h
> > > > its logical CPU ID, calculate the corresponding expected sum, and m=
ake
> > > > the BPF program iterate over the full CPU ID range.
> > > >
> > >
> > > Is this the issue you ran into in practice or it's just another of
> > > those found by AI reading code?
> > >
> > >
> > > > Fixes: 7aa424e02a04bba5ecc84afe9b58b16e9e0b34f8 ("selftests/bpf: Fi=
x some bugs in map_lookup_percpu_elem testcase")
> > > >
> > > > Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
> > > > ---
> > > >  .../bpf/prog_tests/map_lookup_percpu_elem.c   | 34 ++++++++++++++-=
----
> > > >  .../bpf/progs/test_map_lookup_percpu_elem.c   |  8 ++---
> > > >  2 files changed, 30 insertions(+), 12 deletions(-)
> > > >
> > > > diff --git a/tools/testing/selftests/bpf/prog_tests/map_lookup_perc=
pu_elem.c b/tools/testing/selftests/bpf/prog_tests/map_lookup_percpu_elem.c
> > > > index bfb1bf3fd427..849f33259c00 100644
> > > > --- a/tools/testing/selftests/bpf/prog_tests/map_lookup_percpu_elem=
.c
> > > > +++ b/tools/testing/selftests/bpf/prog_tests/map_lookup_percpu_elem=
.c
> > > > @@ -2,29 +2,45 @@
> > > >  /* Copyright (c) 2022 Bytedance */
> > > >
> > > >  #include <test_progs.h>
> > > > +#include "bpf/libbpf_internal.h"
> > > >  #include "test_map_lookup_percpu_elem.skel.h"
> > > >
> > > >  void test_map_lookup_percpu_elem(void)
> > > >  {
> > > >         struct test_map_lookup_percpu_elem *skel;
> > > > -       __u64 key =3D 0, sum;
> > > > -       int ret, i, nr_cpus =3D libbpf_num_possible_cpus();
> > > > +       bool *possible =3D NULL;
> > > > +       __u64 key =3D 0, sum =3D 0;
> > > > +       int cpu, nr_cpu_ids, nr_cpus, ret, slot =3D 0;
> > > >         __u64 *buf;
> > > >
> > > > -       buf =3D malloc(nr_cpus*sizeof(__u64));
> > > > -       if (!ASSERT_OK_PTR(buf, "malloc"))
> > > > +       ret =3D parse_cpu_mask_file("/sys/devices/system/cpu/possib=
le", &possible,
> > > > +                                 &nr_cpu_ids);
> > > > +       if (!ASSERT_OK(ret, "parse possible CPU mask"))
> > > >                 return;
> > > >
> > > > -       for (i =3D 0; i < nr_cpus; i++)
> > > > -               buf[i] =3D i;
> > > > -       sum =3D (nr_cpus - 1) * nr_cpus / 2;
> > > > +       nr_cpus =3D libbpf_num_possible_cpus();
> > > > +       if (!ASSERT_GT(nr_cpus, 0, "libbpf_num_possible_cpus"))
> > > > +               goto free_mask;
> > > > +
> > > > +       buf =3D malloc(nr_cpus * sizeof(*buf));
> > > > +       if (!ASSERT_OK_PTR(buf, "malloc"))
> > > > +               goto free_mask;
> > > > +
> > > > +       for (cpu =3D 0; cpu < nr_cpu_ids; cpu++) {
> > > > +               if (!possible[cpu])
> > > > +                       continue;
> > > > +               buf[slot++] =3D cpu;
> > > > +               sum +=3D cpu;
> > > > +       }
> > > > +       if (!ASSERT_EQ(slot, nr_cpus, "possible CPU mask weight"))
> > > > +               goto exit;
> > > >
> > > >         skel =3D test_map_lookup_percpu_elem__open();
> > > >         if (!ASSERT_OK_PTR(skel, "test_map_lookup_percpu_elem__open=
"))
> > > >                 goto exit;
> > > >
> > > >         skel->rodata->my_pid =3D getpid();
> > > > -       skel->rodata->nr_cpus =3D nr_cpus;
> > > > +       skel->rodata->nr_cpu_ids =3D nr_cpu_ids;
> > > >
> > > >         ret =3D test_map_lookup_percpu_elem__load(skel);
> > > >         if (!ASSERT_OK(ret, "test_map_lookup_percpu_elem__load"))
> > > > @@ -55,4 +71,6 @@ void test_map_lookup_percpu_elem(void)
> > > >         test_map_lookup_percpu_elem__destroy(skel);
> > > >  exit:
> > > >         free(buf);
> > > > +free_mask:
> > > > +       free(possible);
> > > >  }
> > > > diff --git a/tools/testing/selftests/bpf/progs/test_map_lookup_perc=
pu_elem.c b/tools/testing/selftests/bpf/progs/test_map_lookup_percpu_elem.c
> > > > index ca827b1092da..d8da0696b97c 100644
> > > > --- a/tools/testing/selftests/bpf/progs/test_map_lookup_percpu_elem=
.c
> > > > +++ b/tools/testing/selftests/bpf/progs/test_map_lookup_percpu_elem=
.c
> > > > @@ -7,7 +7,7 @@
> > > >  __u64 percpu_array_elem_sum =3D 0;
> > > >  __u64 percpu_hash_elem_sum =3D 0;
> > > >  __u64 percpu_lru_hash_elem_sum =3D 0;
> > > > -const volatile int nr_cpus;
> > > > +const volatile int nr_cpu_ids;
> > > >  const volatile int my_pid;
> > > >
> > > >  struct {
> > > > @@ -57,17 +57,17 @@ int sysenter_getuid(const void *ctx)
> > > >
> > > >         map_ctx.map =3D &percpu_array_map;
> > > >         map_ctx.sum =3D 0;
> > > > -       bpf_loop(nr_cpus, read_percpu_elem_callback, &map_ctx, 0);
> > > > +       bpf_loop(nr_cpu_ids, read_percpu_elem_callback, &map_ctx, 0=
);
> > > >         percpu_array_elem_sum =3D map_ctx.sum;
> > > >
> > > >         map_ctx.map =3D &percpu_hash_map;
> > > >         map_ctx.sum =3D 0;
> > > > -       bpf_loop(nr_cpus, read_percpu_elem_callback, &map_ctx, 0);
> > > > +       bpf_loop(nr_cpu_ids, read_percpu_elem_callback, &map_ctx, 0=
);
> > > >         percpu_hash_elem_sum =3D map_ctx.sum;
> > > >
> > > >         map_ctx.map =3D &percpu_lru_hash_map;
> > > >         map_ctx.sum =3D 0;
> > > > -       bpf_loop(nr_cpus, read_percpu_elem_callback, &map_ctx, 0);
> > > > +       bpf_loop(nr_cpu_ids, read_percpu_elem_callback, &map_ctx, 0=
);
> > > >         percpu_lru_hash_elem_sum =3D map_ctx.sum;
> > > >
> > > >         return 0;
> > > > --
> > > > 2.55.0
> > > >
> >
> > Hi Andrii, I did use AI to find this. I often go through recent
> > commits and then ask AI to check whether the related selftests have
> > been updated and that's how I found this.
>
> in that case I'm inclined to leave selftest as is. This set up where
> possible cpu mask is not contiguous seems to be some fancy qemu-based
> setups so far, and frankly a bunch of other code is probably broken in
> such situations anyways. let's keep things as is for now
>
> pw-bot: cr

Yup got it. Thanks!
