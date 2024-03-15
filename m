Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1766C1773D
	for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 16:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710518933; cv=none; b=O5WySibVf1aMB/x/MP7p1IjuuAhSnswCikb0qn9MOMdx61f6rjxwnwrYrzE86SkIbRm556M1IL97ZUFqrLecfIyn9+693QnT94/93M75xziqfzqTcjKNVpQajMCLp28oKrAS/5DtedsChXw9dRHA9kuiq7pCoSJ8rJL18Ejq/KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710518933; c=relaxed/simple;
	bh=Q/OjCwVnRUF4gG8qqYVAipMhW+tDRrQt2qNt5FKxpao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dAkwaUDqtenwWAA8PBWEvl6loWRJxUABJp0BoGiJDZlVy/Goy7dwGLgco+kumFW+k0cJNjPB6hYM5s+sLUGkkm+KXTCOdtToCHl1zLP4MdEMXhz8w1bXkqFATV1RHzcB7mli9RXvH6t212EEggCPTU0ttr+36hQDMBAgrjEkh9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l2bzwVAL; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2bzwVAL"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33ecb04e018so903462f8f.1
        for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 09:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710518930; x=1711123730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/WPwhN/U42f/0tpXypYL4/mhQ9Jj5/zrgJC+WYsTRTo=;
        b=l2bzwVALmNbVxi3l7/rMgG23qsnZumcNlY0zSOn1+cSKDPr8W7QpZOmFF21ULZqnat
         bF+Z9W+kGwPTTa1svxPpMO9/CzUULo5ly3mMjXJk9P24trQ7ZCR6Ik1tkrXUll9ueQuC
         HyMVI/7+2tF9gbwvATCpU0J1inWJVhb7nWLpS93EzD4py8+VbVT/5iCD5ee3w/gn3fK+
         fXruUIUEV4eSbNEr86hz+S0jIp8oZo7OYw7nVdLuh/3IfJQCN7+J8nbDnupYztkxBjyz
         /RFVg7wKdQxCCF7DrY7c8f1OxydOuImEiOdOM4Xm043vaEFlQIcAO94vM0trEdYsjbp1
         XcNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710518930; x=1711123730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/WPwhN/U42f/0tpXypYL4/mhQ9Jj5/zrgJC+WYsTRTo=;
        b=k6M4wDOqXHjPrZB4AfHFRMGuK7CH+Ewzxh+kF7772GrtrJJBiR/9Rp4SJXCRjLME/x
         oIVDReQ22D0ZATOamH0hZHK23T0iqJvMtRkHZrnA/wpcgRvFHL3PwdSk9Wl3BIm0m3W3
         Hj/iZSNvb8b2qKhgMa6oCIPEuoqX8L/eJksx+YT2UA0kHh68Wsrj1lFA6fxyZQQkeYPg
         NBrmL8WBrqgSmixqE+zzWzyAa7Q7qmUEVHv+E6pSYgID+qiEY2MapcF5bA0ME0EGGf7A
         iLfFF15eyv47w1KEhRQhDjbaluPsvthYJB9x1teExwo8GMd+uerS7x+PuFL2NH5/Yi9h
         Y3IQ==
X-Gm-Message-State: AOJu0YxtxwT64AtFfJPPESFsW5n1kHJ0YYZdmp2RZMFgUC8rk7pwoYVY
	5dT4fJhs3Q1D5a8QLhlpWz2Xqp6FCvLR7HDQkq54sFJyX39r7cVfIDrhGgP259M171IQkoKuM14
	9UDET1BMoicnV3MbkmUDGiPvrA7w=
X-Google-Smtp-Source: AGHT+IGteOkUTBKjzRIf33ZK4WjNvKtkRM9xsSra0v+APIHWb6jrvDnQIQbGD29SG1SicTc3xfqIMHhMXyngav2+j0I=
X-Received: by 2002:a5d:5383:0:b0:33d:1f11:33c1 with SMTP id
 d3-20020a5d5383000000b0033d1f1133c1mr2922472wrv.55.1710518930109; Fri, 15 Mar
 2024 09:08:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315051813.1320559-1-andrii@kernel.org>
In-Reply-To: <20240315051813.1320559-1-andrii@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 15 Mar 2024 09:08:38 -0700
Message-ID: <CAADnVQLKqrxEWjRcLEV0hJXiDGveob2yA-Pc=41K0o6=XoTtng@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/2] selftests/bpf: scale benchmark counting
 by using per-CPU counters
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 10:18=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org=
> wrote:
>
> When benchmarking with multiple threads (-pN, where N>1), we start
> contending on single atomic counter that both BPF trigger benchmarks are
> using, as well as "baseline" tests in user space (trig-base and
> trig-uprobe-base benchmarks). As such, we start bottlenecking on
> something completely irrelevant to benchmark at hand.
>
> Scale counting up by using per-CPU counters on BPF side. On use space
> side we do the next best thing: hash thread ID to approximate per-CPU
> behavior. It seems to work quite well in practice.
>
> To demonstrate the difference, I ran three benchmarks with 1, 2, 4, 8,
> 16, and 32 threads:
>   - trig-uprobe-base (no syscalls, pure tight counting loop in user-space=
);
>   - trig-base (get_pgid() syscall, atomic counter in user-space);
>   - trig-fentry (syscall to trigger fentry program, atomic uncontended pe=
r-CPU
>     counter on BPF side).
>
> Command used:
>
>   for b in uprobe-base base fentry; do \
>     for p in 1 2 4 8 16 32; do \
>       printf "%-11s %2d: %s\n" $b $p \
>         "$(sudo ./bench -w2 -d5 -a -p$p trig-$b | tail -n1 | cut -d'(' -f=
1 | cut -d' ' -f3-)"; \
>     done; \
>   done
>
> Before these changes, aggregate throughput across all threads doesn't
> scale well with number of threads, it actually even falls sharply for
> uprobe-base due to a very high contention:
>
>   uprobe-base  1:  138.998 =C2=B1 0.650M/s
>   uprobe-base  2:   70.526 =C2=B1 1.147M/s
>   uprobe-base  4:   63.114 =C2=B1 0.302M/s
>   uprobe-base  8:   54.177 =C2=B1 0.138M/s
>   uprobe-base 16:   45.439 =C2=B1 0.057M/s
>   uprobe-base 32:   37.163 =C2=B1 0.242M/s
>   base         1:   16.940 =C2=B1 0.182M/s
>   base         2:   19.231 =C2=B1 0.105M/s
>   base         4:   21.479 =C2=B1 0.038M/s
>   base         8:   23.030 =C2=B1 0.037M/s
>   base        16:   22.034 =C2=B1 0.004M/s
>   base        32:   18.152 =C2=B1 0.013M/s
>   fentry       1:   14.794 =C2=B1 0.054M/s
>   fentry       2:   17.341 =C2=B1 0.055M/s
>   fentry       4:   23.792 =C2=B1 0.024M/s
>   fentry       8:   21.557 =C2=B1 0.047M/s
>   fentry      16:   21.121 =C2=B1 0.004M/s
>   fentry      32:   17.067 =C2=B1 0.023M/s
>
> After these changes, we see almost perfect linear scaling, as expected.
> The sub-linear scaling when going from 8 to 16 threads is interesting
> and consistent on my test machine, but I haven't investigated what is
> causing it this peculiar slowdown (across all benchmarks, could be due
> to hyperthreading effects, not sure).
>
>   uprobe-base  1:  139.980 =C2=B1 0.648M/s
>   uprobe-base  2:  270.244 =C2=B1 0.379M/s
>   uprobe-base  4:  532.044 =C2=B1 1.519M/s
>   uprobe-base  8: 1004.571 =C2=B1 3.174M/s
>   uprobe-base 16: 1720.098 =C2=B1 0.744M/s
>   uprobe-base 32: 3506.659 =C2=B1 8.549M/s
>   base         1:   16.869 =C2=B1 0.071M/s
>   base         2:   33.007 =C2=B1 0.092M/s
>   base         4:   64.670 =C2=B1 0.203M/s
>   base         8:  121.969 =C2=B1 0.210M/s
>   base        16:  207.832 =C2=B1 0.112M/s
>   base        32:  424.227 =C2=B1 1.477M/s
>   fentry       1:   14.777 =C2=B1 0.087M/s
>   fentry       2:   28.575 =C2=B1 0.146M/s
>   fentry       4:   56.234 =C2=B1 0.176M/s
>   fentry       8:  106.095 =C2=B1 0.385M/s
>   fentry      16:  181.440 =C2=B1 0.032M/s
>   fentry      32:  369.131 =C2=B1 0.693M/s
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  .../selftests/bpf/benchs/bench_trigger.c      | 40 ++++++++++++++++---
>  .../selftests/bpf/progs/trigger_bench.c       | 39 ++++++++++++------
>  2 files changed, 62 insertions(+), 17 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/benchs/bench_trigger.c b/tools/t=
esting/selftests/bpf/benchs/bench_trigger.c
> index ace0d1011a8e..8fbc78d5f8a4 100644
> --- a/tools/testing/selftests/bpf/benchs/bench_trigger.c
> +++ b/tools/testing/selftests/bpf/benchs/bench_trigger.c
> @@ -1,15 +1,45 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /* Copyright (c) 2020 Facebook */
> +#define _GNU_SOURCE
> +#include <unistd.h>
>  #include "bench.h"
>  #include "trigger_bench.skel.h"
>  #include "trace_helpers.h"
>
> +/* adjust slot shift in inc_hits() if changing */
> +#define MAX_BUCKETS 256
> +
>  /* BPF triggering benchmarks */
>  static struct trigger_ctx {
>         struct trigger_bench *skel;
>  } ctx;
>
> -static struct counter base_hits;
> +static struct counter base_hits[MAX_BUCKETS];
> +
> +static __always_inline void inc_counter(struct counter *counters)
> +{
> +       static __thread int tid =3D 0;
> +       unsigned slot;
> +
> +       if (unlikely(tid =3D=3D 0))
> +               tid =3D gettid();
> +
> +       /* multiplicative hashing, it's fast */
> +       slot =3D 2654435769U * tid;
> +       slot >>=3D 24;
> +
> +       atomic_inc(&base_hits[slot].value); /* use highest byte as an ind=
ex */
> +}
> +
> +static __always_inline long sum_and_reset_counters(struct counter *count=
ers)

Why __always_inline ?
It's a slow path. Inlining or not shouldn't make any difference.

> +{
> +       int i;
> +       long sum =3D 0;
> +
> +       for (i =3D 0; i < MAX_BUCKETS; i++)
> +               sum +=3D atomic_swap(&counters[i].value, 0);
> +       return sum;
> +}
