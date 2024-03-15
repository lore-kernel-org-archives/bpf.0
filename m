Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD7E3D579
	for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 16:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710519749; cv=none; b=HuiiQYIYiKvzXKA1fL/OGxquGriNvJR5fQ9bSR4Dbju29lXNsoB4MhTB+vSUk1JBmOuTzkgnOGNUP/FZ8F2yQH1OSWaKBucHHmurwR3Vjzki5cUIwVRS50Bafod7Xx/0unEUia2Q13SU9WknTDWqMUwhZP4dWDkjPhzEEOEzw9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710519749; c=relaxed/simple;
	bh=cxt8lol8EWWG5hqEkwexuNLnzCTuX8vEKsV1SyvfzWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r5hdin9o08RewHj2nQcaXfqFdpVC/LOmGUAbGKtw2bglUCCN0oWJAIdMXtxtUGhZCSVVQgJwL4wKQgBWyhgu1iOKqL6qjtZ2p3rasJH7Q6s3QbO/DH2dmDz57f80lajtHK5xko0kb9MlsPD4YPuwCz5P+UvWXn4kx2cfAFc9q4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R9woGjZ6; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9woGjZ6"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5d81b08d6f2so1853353a12.0
        for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 09:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710519747; x=1711124547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UudZqKNJbQY2TSVQIDuCsX//YKW3u6NtnDQdKWQLTBk=;
        b=R9woGjZ63qtldirJKgv3P/4Mq3iomKr9iL+Hy0LuKKuc1jDzcs95h2AbLK7aZPbhY9
         zKkOlzIPJhdMpvTc2/GRYMBgNLyFqUZUK6UhrHiM1l+1X87XzdFum4mqBAjBDOrWgA+x
         RYBkPP/YBmDJEZhU7LsSJ+bv5SwDVbP4F6MOdUEtebkNERTiMdjAIrKWu5lX5JYo2z+q
         cpkCbx6w4hcpak4tudzi8rJp+gxsQCG1EPRLVjiSdxp0HbODQB5C34SVRRd01f1/1ZIG
         fbRBQNEYWVHg9rNjmYUfk+FkWB/1/Gyqs6W68YKg/dhu/QuZTj4dj4k5Payc49E91Hgf
         sdhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710519747; x=1711124547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UudZqKNJbQY2TSVQIDuCsX//YKW3u6NtnDQdKWQLTBk=;
        b=QP4Otv188v11Pv6pZebXIxeu2XAwM3AcxswLuRgErxGYwGJkeW/pWC8CygDUUbrP3i
         yb1dt2/WbUOH68T18O/BF57rkotrL51tnoQMN7rY9/e4REbGiUA+KuphUbo3U/yat1Nc
         UFMshxmH5EVOBbxBEeeN/v0Tbz95iQBUB0v5pDizg2hpjbj5Rc3U3MV4elDiNSifeimj
         JfTbI4nROkB1uJBV1pRm+C89/NG3dn+dGIbIxAUJAMJZ6FtV5bBAsWpsvhAfSwM/+5Vi
         wIRSXSTFf6otWGxqqeKQncKsYiTAOAitV7+3dTaFLo/qz3YX2IjCS7V4CbBJdLm9LxiQ
         zhDg==
X-Forwarded-Encrypted: i=1; AJvYcCUlJv+AiyqG29fJ+qIky5Znpw7GruQVySQnTz2kAsecPtbhyeFRm2Jiaat/BdkW22pPj7GmosIYfFeC+7I3bjocXHto
X-Gm-Message-State: AOJu0YwEpVhoeeuTJtZnu0oIOTHtUE4bhxzKyXgunpmbpiBMHetwDSmN
	HymfliUaWIQCsml+RJCsg6vP0TAFtwWUAOpNOmBG/a7f2YXU4G+89P6qBJl0UrGujfCLWKu1gLI
	BjvzfZaTTDeGNH+GvQblcqzGGoxc=
X-Google-Smtp-Source: AGHT+IGHnjBMu+rVNZld7AaJwLcJzg3bdMo5yD0yuFhIrYrfRi4kMiJ6/QYNlJ6WgZG7f5P4g3jg4BrBbqcCSvxpweY=
X-Received: by 2002:a17:90a:5213:b0:29b:eb6a:4b02 with SMTP id
 v19-20020a17090a521300b0029beb6a4b02mr4879985pjh.22.1710519747177; Fri, 15
 Mar 2024 09:22:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315051813.1320559-1-andrii@kernel.org> <CAADnVQLKqrxEWjRcLEV0hJXiDGveob2yA-Pc=41K0o6=XoTtng@mail.gmail.com>
In-Reply-To: <CAADnVQLKqrxEWjRcLEV0hJXiDGveob2yA-Pc=41K0o6=XoTtng@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 15 Mar 2024 09:22:14 -0700
Message-ID: <CAEf4BzYU_A6sku5sQyCwjjJ0hKzfGELWWYZqZYj+pw4DE+Myag@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/2] selftests/bpf: scale benchmark counting
 by using per-CPU counters
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 9:08=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Mar 14, 2024 at 10:18=E2=80=AFPM Andrii Nakryiko <andrii@kernel.o=
rg> wrote:
> >
> > When benchmarking with multiple threads (-pN, where N>1), we start
> > contending on single atomic counter that both BPF trigger benchmarks ar=
e
> > using, as well as "baseline" tests in user space (trig-base and
> > trig-uprobe-base benchmarks). As such, we start bottlenecking on
> > something completely irrelevant to benchmark at hand.
> >
> > Scale counting up by using per-CPU counters on BPF side. On use space
> > side we do the next best thing: hash thread ID to approximate per-CPU
> > behavior. It seems to work quite well in practice.
> >
> > To demonstrate the difference, I ran three benchmarks with 1, 2, 4, 8,
> > 16, and 32 threads:
> >   - trig-uprobe-base (no syscalls, pure tight counting loop in user-spa=
ce);
> >   - trig-base (get_pgid() syscall, atomic counter in user-space);
> >   - trig-fentry (syscall to trigger fentry program, atomic uncontended =
per-CPU
> >     counter on BPF side).
> >
> > Command used:
> >
> >   for b in uprobe-base base fentry; do \
> >     for p in 1 2 4 8 16 32; do \
> >       printf "%-11s %2d: %s\n" $b $p \
> >         "$(sudo ./bench -w2 -d5 -a -p$p trig-$b | tail -n1 | cut -d'(' =
-f1 | cut -d' ' -f3-)"; \
> >     done; \
> >   done
> >
> > Before these changes, aggregate throughput across all threads doesn't
> > scale well with number of threads, it actually even falls sharply for
> > uprobe-base due to a very high contention:
> >
> >   uprobe-base  1:  138.998 =C2=B1 0.650M/s
> >   uprobe-base  2:   70.526 =C2=B1 1.147M/s
> >   uprobe-base  4:   63.114 =C2=B1 0.302M/s
> >   uprobe-base  8:   54.177 =C2=B1 0.138M/s
> >   uprobe-base 16:   45.439 =C2=B1 0.057M/s
> >   uprobe-base 32:   37.163 =C2=B1 0.242M/s
> >   base         1:   16.940 =C2=B1 0.182M/s
> >   base         2:   19.231 =C2=B1 0.105M/s
> >   base         4:   21.479 =C2=B1 0.038M/s
> >   base         8:   23.030 =C2=B1 0.037M/s
> >   base        16:   22.034 =C2=B1 0.004M/s
> >   base        32:   18.152 =C2=B1 0.013M/s
> >   fentry       1:   14.794 =C2=B1 0.054M/s
> >   fentry       2:   17.341 =C2=B1 0.055M/s
> >   fentry       4:   23.792 =C2=B1 0.024M/s
> >   fentry       8:   21.557 =C2=B1 0.047M/s
> >   fentry      16:   21.121 =C2=B1 0.004M/s
> >   fentry      32:   17.067 =C2=B1 0.023M/s
> >
> > After these changes, we see almost perfect linear scaling, as expected.
> > The sub-linear scaling when going from 8 to 16 threads is interesting
> > and consistent on my test machine, but I haven't investigated what is
> > causing it this peculiar slowdown (across all benchmarks, could be due
> > to hyperthreading effects, not sure).
> >
> >   uprobe-base  1:  139.980 =C2=B1 0.648M/s
> >   uprobe-base  2:  270.244 =C2=B1 0.379M/s
> >   uprobe-base  4:  532.044 =C2=B1 1.519M/s
> >   uprobe-base  8: 1004.571 =C2=B1 3.174M/s
> >   uprobe-base 16: 1720.098 =C2=B1 0.744M/s
> >   uprobe-base 32: 3506.659 =C2=B1 8.549M/s
> >   base         1:   16.869 =C2=B1 0.071M/s
> >   base         2:   33.007 =C2=B1 0.092M/s
> >   base         4:   64.670 =C2=B1 0.203M/s
> >   base         8:  121.969 =C2=B1 0.210M/s
> >   base        16:  207.832 =C2=B1 0.112M/s
> >   base        32:  424.227 =C2=B1 1.477M/s
> >   fentry       1:   14.777 =C2=B1 0.087M/s
> >   fentry       2:   28.575 =C2=B1 0.146M/s
> >   fentry       4:   56.234 =C2=B1 0.176M/s
> >   fentry       8:  106.095 =C2=B1 0.385M/s
> >   fentry      16:  181.440 =C2=B1 0.032M/s
> >   fentry      32:  369.131 =C2=B1 0.693M/s
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  .../selftests/bpf/benchs/bench_trigger.c      | 40 ++++++++++++++++---
> >  .../selftests/bpf/progs/trigger_bench.c       | 39 ++++++++++++------
> >  2 files changed, 62 insertions(+), 17 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/benchs/bench_trigger.c b/tools=
/testing/selftests/bpf/benchs/bench_trigger.c
> > index ace0d1011a8e..8fbc78d5f8a4 100644
> > --- a/tools/testing/selftests/bpf/benchs/bench_trigger.c
> > +++ b/tools/testing/selftests/bpf/benchs/bench_trigger.c
> > @@ -1,15 +1,45 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  /* Copyright (c) 2020 Facebook */
> > +#define _GNU_SOURCE
> > +#include <unistd.h>
> >  #include "bench.h"
> >  #include "trigger_bench.skel.h"
> >  #include "trace_helpers.h"
> >
> > +/* adjust slot shift in inc_hits() if changing */
> > +#define MAX_BUCKETS 256
> > +
> >  /* BPF triggering benchmarks */
> >  static struct trigger_ctx {
> >         struct trigger_bench *skel;
> >  } ctx;
> >
> > -static struct counter base_hits;
> > +static struct counter base_hits[MAX_BUCKETS];
> > +
> > +static __always_inline void inc_counter(struct counter *counters)
> > +{
> > +       static __thread int tid =3D 0;
> > +       unsigned slot;
> > +
> > +       if (unlikely(tid =3D=3D 0))
> > +               tid =3D gettid();
> > +
> > +       /* multiplicative hashing, it's fast */
> > +       slot =3D 2654435769U * tid;
> > +       slot >>=3D 24;
> > +
> > +       atomic_inc(&base_hits[slot].value); /* use highest byte as an i=
ndex */
> > +}
> > +
> > +static __always_inline long sum_and_reset_counters(struct counter *cou=
nters)
>
> Why __always_inline ?
> It's a slow path. Inlining or not shouldn't make any difference.

copy/paste of inc_counter signature originally, you are right, it's
not necessary

>
> > +{
> > +       int i;
> > +       long sum =3D 0;
> > +
> > +       for (i =3D 0; i < MAX_BUCKETS; i++)
> > +               sum +=3D atomic_swap(&counters[i].value, 0);
> > +       return sum;
> > +}
