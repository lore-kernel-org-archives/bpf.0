Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7981F224234
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 00:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788395546; cv=pass; b=Cmpr2SEUcQXPwmZvg32wSZyBd5eBOlHEToXhdgFkppaG7M6mEtWgm6MnYekAQNkkoW7d1BrLOUW/tJUHdBx3Yny5wJVfErZiNqdG5pVPvxcclvHAXpBPri0M+rz+9z/xAqDMMKq18Zx/zdW182H8Hny92QYC27ugODSqjIU6TCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788395546; c=relaxed/simple;
	bh=2jLCVEyTOu7enORfoyn4qAX/H9CGdtQm8tczTeRJKOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=faATk9ESa0Xo/bwfw4NtzedWzSNTq6a+6qkqeDmC7GF8NCQd/9haB2EACYXLFGX6ZbXBcCDcgqryBH48aa10I8lrc8wAS+z5mYQnbjjCZqs04NLiqtT9S9GeMfwgxvNSl1zz5eZER5GMcrj1Y5TDPr34v2HutOT+Zs68mY0G2Iw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sMCQJgx1; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sMCQJgx1"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8556ec44e9aso1685963b3a.3
        for <bpf@vger.kernel.org>; Wed, 02 Sep 2026 17:32:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788395545; cv=none;
        d=google.com; s=arc-20260327;
        b=I0mbXKW/93+mhUtNgWKE8fVvzVpXNQycDsrgdaXCctOJ8ZSmZYhPDUrSaaWmxQ9OyO
         cHgU1xovH4R2c6VAmWXxLBKTyJ51eSKkkiG17Q+nTcEHuByJOZK/qqGppTUyJOrEm/hu
         J+6rkdMri7Ao5pFSXyKbNWc+uV1znFa75SSPtxVoEkqTfTPOU+FnYJq1ZWgiBYA0iRer
         3Ow16+JNFSm7N78V/mo8DzrTWkfohfjLRbm3B3T9aD8nogeVar5JURDd8Aiy753QekW1
         Jsh6KGOYQGuGaaaCg+vV510EvYe6/izBngiRE1Zizl62bQdSMjooowboLXkFQxCEmAO2
         g2AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eFIFDsWKdpgTfW3uc7xRObLB/Ddh6TG5x2Js0xrqLKc=;
        fh=TUhYAtU/6Z+qkNMmvNGEClxTDnkWwuGnF0EKLcxZNv4=;
        b=FRLHEMK5Al69M9ePVGTGkIpL9Qh/2EupEtmMuDvXc82CJc1V5byOhZdHU/5zC5Qw2U
         UoKMhuJw2VQYYYyEtb/7EiCJeQbFvggKpWB+9cu5RhkWuIkx8/2PJHPgfUqY9Hn+JegA
         QfWE0tLDn2DGF2vPYboJPlQh46IlosS+clutnk9H5fxSZsmau0wM9TZ0MjijOzvJh9CT
         GFFiCnl12nJ77EMplqP6DwrznLpLk6dPRH6/91izdCzOx37ouoihLvtMb7QwNErq89aO
         EOarBI6OBWWIOC4Mw47DbBSUJKQ1On0JkYXJL1Y6uhm8epBrS94c5yDeU7x3PkF88nRQ
         bFYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788395545; x=1789000345; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eFIFDsWKdpgTfW3uc7xRObLB/Ddh6TG5x2Js0xrqLKc=;
        b=sMCQJgx1l4gSE9dPZflOsfqlck1C6c1I/hii8qjvwjwvyn4XQiUOQH8RJPRp3uGTSM
         w1Qg4OC7vb79a0tdwOBOZSVFLn4OVTLAE/1l0/RKGC9KMHmqGaE9Yt4/+EMkiL2ZLxVO
         wU7Lma1agWykLPTlgsQ/0rAEBR0LJxGfUFtWt32uSjXALd4dsHPHQKco4GD39nElW2IC
         EDLzuDR1KJllCxpindX/QWH6cgxpPdj0wKxUjTPthTLJ/2bV+7MibOcCYP+0dLzbW76Q
         ADYoJITHK88k/FfoOc9gJza02qXVZy8RnVaazwoeH3V6G5Bd9bF+QSZvCQgoE5SOzR9o
         RpaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788395545; x=1789000345;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eFIFDsWKdpgTfW3uc7xRObLB/Ddh6TG5x2Js0xrqLKc=;
        b=hvA3AXLNOgQVF4R1YAQfX8rmj8lkyv8UTb1CpX1TtNg9k/JiTvO7hD3ufmlRQSfVMs
         poZGU2duZSwKirusuzpwqWa6QK8I/VT1Rp+UrtyvAh4KcctJkVFRV2z9Yk2JPq3/u9P2
         gIoJ37rjkkxQxu1HArlZRpN6JkXRsBz+Vl+NkML3h7i3k2iTAok70+RcNUzWkptZNryj
         VjwCjY9rMebmBdeePXt/ShMhkqz7RkE+GDslavsh+CJB6bVWU7TZnAiKl0wcd/wwDO0W
         r3yYZGjEeZyUDIbvJ0KbWf7YtmnjZOT1wHeMhpgT+poFSGTC/35v44J+jUEsoxzzOEPF
         LcOw==
X-Forwarded-Encrypted: i=1; AKwUvBx6ryDeoDmP4dDAXM7i0oynNoYobBj1Z0XLc1yT/xhViNro8q0c8c2BIG+UpB5FqeT3YqQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lwVmkEuG37zR936VRvGF6d9bMNxgDXGrzPFoG7GbwMPRaxZMHE
	FoQpmeOCDuxratUskmdPHSvsVJWKJjhl5BULrU1Iw9UWJhhsV80WNXnRISh1KdE+LOEJsCh8i2t
	IYz/AQxe5Bd+kjoxrrLJah65gO4+j++A=
X-Gm-Gg: AYBFou0brkbSoPoFdDUaOowQmjShRprt9+Rnt7XF2cx2N7hlW0LSz079p+Qc4MIilLT
	KM51SBRHwWudbWnTXCRiNQBsVb0g4mSNEzR2em0qsW2eRQaX0ZdkyYtzgo8bXq1S+MzlaAPbmXe
	Efo3T3oDAoB/NPYyS7U0c9Zs5Ahczohpgh9MZ+oHe/8h7LYyOePZm28OSddNKNBYJdKAqFi1iF+
	I00hd8jSkAIF3yQO3M3ccBPNvrqvREdU2mTyhXboxi1vAA7hMD3Ng3E050K4EiDD06LGBf+Xpgf
	0tgkZ4magBQ/55rIZHd4xHzFH3UqTDhrjR/joLfSEGBihRGg/I3j21tV2O5Gck0luwYLdgOTuUR
	Mq2gsev3E5Lex4yph4qLZ7ABPGaVvGiRbOIfR
X-Received: by 2002:a05:6a00:408f:b0:857:72ba:ff0a with SMTP id
 d2e1a72fcca58-85ed3f7037amr14628468b3a.18.1788395544725; Wed, 02 Sep 2026
 17:32:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901141954.29449-1-suchitkarunakaran@gmail.com>
In-Reply-To: <20260901141954.29449-1-suchitkarunakaran@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 2 Sep 2026 17:32:11 -0700
X-Gm-Features: AcwNN1V-qWBcxzc6uVnaZe41jS2cEpg1nCoSdKsbr4-IBlSBAnW0ZGSIW3ssxGY
Message-ID: <CAEf4Bza6wQb1mSiKA_6U7FovYivcZvf3MCvU9NMdt01w-wAZPQ@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: Fix map_lookup_percpu_elem on sparse CPU IDs
To: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, 
	memxor@gmail.com, shuah@kernel.org, emil@etsalapatis.com, 
	ihor.solodrai@linux.dev, jolsa@kernel.org, martin.lau@linux.dev, 
	song@kernel.org, yonghong.song@linux.dev, zhoufeng.zf@bytedance.com, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 7:20=E2=80=AFAM Suchit Karunakaran
<suchitkarunakaran@gmail.com> wrote:
>
> libbpf_num_possible_cpus() returns the number of possible CPUs, which is
> appropriate for sizing packed per-CPU map value buffers. It is not the
> upper bound for logical CPU IDs.
>
> For a possible CPU mask such as 0,2-3, the test loops over CPU IDs 0
> through 2. This incorrectly visits CPU 1 and misses CPU 3. It also
> initializes packed per-CPU slots using their slot indexes rather than
> the corresponding logical CPU IDs.
>
> Parse the possible CPU mask and keep the packed slot count separate
> from the logical CPU ID range. Populate each dense per-CPU slot with
> its logical CPU ID, calculate the corresponding expected sum, and make
> the BPF program iterate over the full CPU ID range.
>

Is this the issue you ran into in practice or it's just another of
those found by AI reading code?


> Fixes: 7aa424e02a04bba5ecc84afe9b58b16e9e0b34f8 ("selftests/bpf: Fix some=
 bugs in map_lookup_percpu_elem testcase")
>
> Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
> ---
>  .../bpf/prog_tests/map_lookup_percpu_elem.c   | 34 ++++++++++++++-----
>  .../bpf/progs/test_map_lookup_percpu_elem.c   |  8 ++---
>  2 files changed, 30 insertions(+), 12 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/map_lookup_percpu_ele=
m.c b/tools/testing/selftests/bpf/prog_tests/map_lookup_percpu_elem.c
> index bfb1bf3fd427..849f33259c00 100644
> --- a/tools/testing/selftests/bpf/prog_tests/map_lookup_percpu_elem.c
> +++ b/tools/testing/selftests/bpf/prog_tests/map_lookup_percpu_elem.c
> @@ -2,29 +2,45 @@
>  /* Copyright (c) 2022 Bytedance */
>
>  #include <test_progs.h>
> +#include "bpf/libbpf_internal.h"
>  #include "test_map_lookup_percpu_elem.skel.h"
>
>  void test_map_lookup_percpu_elem(void)
>  {
>         struct test_map_lookup_percpu_elem *skel;
> -       __u64 key =3D 0, sum;
> -       int ret, i, nr_cpus =3D libbpf_num_possible_cpus();
> +       bool *possible =3D NULL;
> +       __u64 key =3D 0, sum =3D 0;
> +       int cpu, nr_cpu_ids, nr_cpus, ret, slot =3D 0;
>         __u64 *buf;
>
> -       buf =3D malloc(nr_cpus*sizeof(__u64));
> -       if (!ASSERT_OK_PTR(buf, "malloc"))
> +       ret =3D parse_cpu_mask_file("/sys/devices/system/cpu/possible", &=
possible,
> +                                 &nr_cpu_ids);
> +       if (!ASSERT_OK(ret, "parse possible CPU mask"))
>                 return;
>
> -       for (i =3D 0; i < nr_cpus; i++)
> -               buf[i] =3D i;
> -       sum =3D (nr_cpus - 1) * nr_cpus / 2;
> +       nr_cpus =3D libbpf_num_possible_cpus();
> +       if (!ASSERT_GT(nr_cpus, 0, "libbpf_num_possible_cpus"))
> +               goto free_mask;
> +
> +       buf =3D malloc(nr_cpus * sizeof(*buf));
> +       if (!ASSERT_OK_PTR(buf, "malloc"))
> +               goto free_mask;
> +
> +       for (cpu =3D 0; cpu < nr_cpu_ids; cpu++) {
> +               if (!possible[cpu])
> +                       continue;
> +               buf[slot++] =3D cpu;
> +               sum +=3D cpu;
> +       }
> +       if (!ASSERT_EQ(slot, nr_cpus, "possible CPU mask weight"))
> +               goto exit;
>
>         skel =3D test_map_lookup_percpu_elem__open();
>         if (!ASSERT_OK_PTR(skel, "test_map_lookup_percpu_elem__open"))
>                 goto exit;
>
>         skel->rodata->my_pid =3D getpid();
> -       skel->rodata->nr_cpus =3D nr_cpus;
> +       skel->rodata->nr_cpu_ids =3D nr_cpu_ids;
>
>         ret =3D test_map_lookup_percpu_elem__load(skel);
>         if (!ASSERT_OK(ret, "test_map_lookup_percpu_elem__load"))
> @@ -55,4 +71,6 @@ void test_map_lookup_percpu_elem(void)
>         test_map_lookup_percpu_elem__destroy(skel);
>  exit:
>         free(buf);
> +free_mask:
> +       free(possible);
>  }
> diff --git a/tools/testing/selftests/bpf/progs/test_map_lookup_percpu_ele=
m.c b/tools/testing/selftests/bpf/progs/test_map_lookup_percpu_elem.c
> index ca827b1092da..d8da0696b97c 100644
> --- a/tools/testing/selftests/bpf/progs/test_map_lookup_percpu_elem.c
> +++ b/tools/testing/selftests/bpf/progs/test_map_lookup_percpu_elem.c
> @@ -7,7 +7,7 @@
>  __u64 percpu_array_elem_sum =3D 0;
>  __u64 percpu_hash_elem_sum =3D 0;
>  __u64 percpu_lru_hash_elem_sum =3D 0;
> -const volatile int nr_cpus;
> +const volatile int nr_cpu_ids;
>  const volatile int my_pid;
>
>  struct {
> @@ -57,17 +57,17 @@ int sysenter_getuid(const void *ctx)
>
>         map_ctx.map =3D &percpu_array_map;
>         map_ctx.sum =3D 0;
> -       bpf_loop(nr_cpus, read_percpu_elem_callback, &map_ctx, 0);
> +       bpf_loop(nr_cpu_ids, read_percpu_elem_callback, &map_ctx, 0);
>         percpu_array_elem_sum =3D map_ctx.sum;
>
>         map_ctx.map =3D &percpu_hash_map;
>         map_ctx.sum =3D 0;
> -       bpf_loop(nr_cpus, read_percpu_elem_callback, &map_ctx, 0);
> +       bpf_loop(nr_cpu_ids, read_percpu_elem_callback, &map_ctx, 0);
>         percpu_hash_elem_sum =3D map_ctx.sum;
>
>         map_ctx.map =3D &percpu_lru_hash_map;
>         map_ctx.sum =3D 0;
> -       bpf_loop(nr_cpus, read_percpu_elem_callback, &map_ctx, 0);
> +       bpf_loop(nr_cpu_ids, read_percpu_elem_callback, &map_ctx, 0);
>         percpu_lru_hash_elem_sum =3D map_ctx.sum;
>
>         return 0;
> --
> 2.55.0
>
