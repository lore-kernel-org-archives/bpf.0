Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09D614F11B
	for <bpf@vger.kernel.org>; Wed, 27 Mar 2024 17:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711561734; cv=none; b=oV70yR0cttGVsL122d+cI2zK0nn2nea7PTI3IO/b4Afk7BVy6arDbcaxYVewKzVtF6y+65X4bH7dzguqRy+UFqM0VqLZtnMifG2fx1/k0+/sbnDSzeN564ggGE/ADWhRjkBnBqKNA4e80/Rfl1r1jni3e8T4RU/qcvKvC8dNdNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711561734; c=relaxed/simple;
	bh=Uovs2m0WfZOrIFyr8guADINh0W3uKJmSq1ynQ7d24IQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VQ10s/64E7Z+rDV9PnmCyJEnYB7GDuymqaUJft7+3DgnmKT82EoCbdJcjRzbTHc/souM3S2T4mu0fJbunigeyPfDchspST/lEKaOwtTb1L5toV6fns0f3jpGO904Tuy2E71vfxoqDG8Envi6aPENPtC1Tu5/wWtBrbrGtpVnlFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hsQpJXXp; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hsQpJXXp"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5cedfc32250so21785a12.0
        for <bpf@vger.kernel.org>; Wed, 27 Mar 2024 10:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711561732; x=1712166532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6r+pxOoD7xIz5A3KkBcNh5i66uHvK9XUW8awt6DoAsY=;
        b=hsQpJXXpenM8zCDP01y3RaEDNyT8Nb4tbf/IXLY2Uib8y+OMGGNWG1/lufkQocb7OQ
         +jkmFRmfTgdhtN0PnklgbZoE+zIFdT2lvf8l8sMRL9Qj5fSOXwQcslrZdKG0H54q7ht4
         uMBom8B1GAUyMHrrmxQProjhUFvk3GQPkJqdXYQwzYib1OBKosSS8BZJcTfYypMwfJgD
         b8ccQJBE1JzELmqq6a06RyD3OA10HBMTWmLS8QdU4cdesZQLgYjTX88KnIB8dZFyXjnn
         8SosmQGpnGknnYq2SXLfgHK8RrFdk/fkxoy1ioM9d0aQYNnhz8U47BpLRDKo/uXCG7hS
         nmdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711561732; x=1712166532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6r+pxOoD7xIz5A3KkBcNh5i66uHvK9XUW8awt6DoAsY=;
        b=SFyW8p8HfPtR9chhc4FpCB+VSlH661Pc55gfllQ55Rrb7RDzvZqHq5YSVCN27frJ+c
         22PvU3LGle9/HJXPt7lyMj9EJCE1CKjLK+vaEKiBNnP6AvjNodky0fIEJLN4wkv/cFFg
         WVK0MKJYqaSKwzKNcbiG2IpHUZXQqMKrDFwWWg/aVXZ5OIijQZ6vjWsqgGcSogn1I8zN
         +kRy2ZbWJOkmW2sWVvGa9AtvOVIKB99oiPNMv0kZ/CnX6n+1Br3sJ/6/hW15zPJYsm/r
         TmzTwUqJ9BjHrBDlfF8RsnkrtDRFJ3nPJ5uWC4YlIOF5BRXTDTvddXkFEZrUgZ0Ka28l
         K/SQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2ykLvW8UL21DYJYgM2BmdVVZcYDFWz3qsjq5S44E0a2LER5cgPFtq6dXeENpaaMD5ksdSbhqDiRhGXM91I1T48H3J
X-Gm-Message-State: AOJu0Yz2e2k6UP5YOf3pIz0OJZAPkLZM8kIu3lvm/KBOmq93tUU7wssT
	apX+euQnYLaN3ang10Rso7GjElxlZNb1nCLnpXbLaeoJV+AFAbGGvg0hzTpBEFTJOwuAhAn/DVb
	WL0sK95/80a216btqCWmIqPPlnk0=
X-Google-Smtp-Source: AGHT+IHsoonxMOPqihoLtIWTKfHhB7kj/9+PLaNiyOpJ77Y37tFYgYf8b0CYIfQwfBKk68yWSJYOwXRXB6SrqhpI9SU=
X-Received: by 2002:a17:90b:37c8:b0:2a0:2f77:842a with SMTP id
 nc8-20020a17090b37c800b002a02f77842amr391499pjb.42.1711561731924; Wed, 27 Mar
 2024 10:48:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327115848.84695-1-laoar.shao@gmail.com> <20240327115848.84695-3-laoar.shao@gmail.com>
In-Reply-To: <20240327115848.84695-3-laoar.shao@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 27 Mar 2024 10:48:39 -0700
Message-ID: <CAEf4BzZ6L2NWf25gJ2CaMo-+rY4tL2Z4UWTqut1BHUEhxLjpUw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/2] selftests/bpf: Add selftest for bits iter
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 5:00=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> Add selftests for the newly added bits iter.
> - bits_iter_success
>   - percpu data extracted from the percpu struct should be expected
>   - RCU lock is not required
>   - It is fine without calling bpf_iter_cpumask_next()
>   - It can work as expected when invalid arguments are passed
>
> - bits_iter_failure
>   - bpf_iter_bits_destroy() is required after calling
>     bpf_iter_bits_new()
>   - bpf_iter_bits_destroy() can only destroy an initialized iter
>   - bpf_iter_bits_next() must use an initialized iter
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  .../selftests/bpf/prog_tests/bits_iter.c      | 139 +++++++++++++++++
>  .../bpf/progs/test_bits_iter_failure.c        |  54 +++++++
>  .../bpf/progs/test_bits_iter_success.c        | 146 ++++++++++++++++++
>  3 files changed, 339 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/bits_iter.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_bits_iter_fail=
ure.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_bits_iter_succ=
ess.c
>

I think all the cgroup and bpf_iter related parts of tests seems like
an unnecessary complications and just more code to support than
necessary. We have tests for cgroup iterators, so we know it will
work. You are adding bits iterator, so let's just add tests that
validate bits iterator works. We don't need iterator programs and
cgroups for that. Can we just leave RUN_TESTS-based tests and not add
yet another test runner mini-setup (I mean those positive_testcases
and negative_testcases)?

> diff --git a/tools/testing/selftests/bpf/prog_tests/bits_iter.c b/tools/t=
esting/selftests/bpf/prog_tests/bits_iter.c
> new file mode 100644
> index 000000000000..0e2520a9dc62
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/bits_iter.c
> @@ -0,0 +1,139 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2024 Yafang Shao <laoar.shao@gmail.com> */
> +
> +#define _GNU_SOURCE
> +#include <sched.h>
> +
> +#include <test_progs.h>
> +#include "test_bits_iter_success.skel.h"
> +#include "test_bits_iter_failure.skel.h"

I'd cut out all of this code I cut out from email.

[...]

> +
> +       RUN_TESTS(test_bits_iter_success);
> +       RUN_TESTS(test_bits_iter_failure);

and I'd put these into prog_tests/verifier.c

> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_bits_iter_failure.c b=
/tools/testing/selftests/bpf/progs/test_bits_iter_failure.c
> new file mode 100644
> index 000000000000..974d0b7a540e
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_bits_iter_failure.c
> @@ -0,0 +1,54 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2024 Yafang Shao <laoar.shao@gmail.com> */
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +#include "bpf_misc.h"
> +#include "task_kfunc_common.h"
> +
> +char _license[] SEC("license") =3D "GPL";
> +
> +int bpf_iter_bits_new(struct bpf_iter_bits *it, const void *unsafe_ptr__=
ign,
> +                     u32 nr_bits) __ksym __weak;
> +int *bpf_iter_bits_next(struct bpf_iter_bits *it) __ksym __weak;
> +void bpf_iter_bits_destroy(struct bpf_iter_bits *it) __ksym __weak;
> +
> +SEC("iter.s/cgroup")
> +__failure __msg("Unreleased reference id=3D3 alloc_insn=3D10")

you don't control assembly instruction generation, so let's not rely
on specific instruction number in error message

> +int BPF_PROG(no_destroy, struct bpf_iter_meta *meta, struct cgroup *cgrp=
)
> +{
> +       struct bpf_iter_bits it;
> +       struct task_struct *p;
> +
> +       p =3D bpf_task_from_pid(1);
> +       if (!p)
> +               return 1;
> +
> +       bpf_iter_bits_new(&it, p->cpus_ptr, 8192);
> +
> +       bpf_iter_bits_next(&it);
> +       bpf_task_release(p);
> +       return 0;
> +}
> +
> +SEC("iter/cgroup")
> +__failure __msg("expected an initialized iter_bits as arg #1")
> +int BPF_PROG(next_uninit, struct bpf_iter_meta *meta, struct cgroup *cgr=
p)
> +{
> +       struct bpf_iter_bits *it =3D NULL;
> +
> +       bpf_iter_bits_next(it);
> +       return 0;
> +}
> +
> +SEC("iter/cgroup")
> +__failure __msg("expected an initialized iter_bits as arg #1")
> +int BPF_PROG(destroy_uninit, struct bpf_iter_meta *meta, struct cgroup *=
cgrp)
> +{
> +       struct bpf_iter_bits it =3D {};
> +
> +       bpf_iter_bits_destroy(&it);
> +       return 0;
> +}

[...]
