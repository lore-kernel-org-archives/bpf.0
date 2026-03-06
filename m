Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C221D7995
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 04:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772772103; cv=pass; b=LDVa9N6XS0bNCIr+0t6x0qGDxasa5yKjISFb6r4dpOytkX4aHG+9AZ7UVM+ZXfsOtv22jKSVWG2liLeoTKvp+m5uWZVEsR2J1rvDmE24bw2MUQmS71DEC8oEfGB6iiKzLHlUBdIrv/QiA94QvbS0dHPgwxGzbEjTxZG+SWa+qZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772772103; c=relaxed/simple;
	bh=34zvV+1Bulc0vrEHcs4naD4PyMSNO71wh9u6T1j0C2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cbb2KPBKdE/UzdxGsPvG8CKRu4VOp4KYt6mQfTQcQk0860UGpwwxjGT8OVrcrzSGMSkT03hCfSeV1ZYB7VGMpiIjbLpDHS5Rw8qO2oLWLHXPtncvVXbhOMruEsD8hWexY2XZMWr6M1rDZ6XV8ifOsZfBNAr/PyBIJLD/oHtRdvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O7bETAAA; arc=pass smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7bETAAA"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-4836f4cbe0bso75672185e9.3
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 20:41:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772772100; cv=none;
        d=google.com; s=arc-20240605;
        b=kCChl+qj7nlVQKPslmXfZ4+b+5wNfn4LVAbaBWx+ckbEARANypyI1966VW77wNJjb4
         TqSyQG/Uzn9fqFG0HzQs3K6qS0Mcq5MbnJX3QS1tVhqsqGwh7Ik7iXNtjrMYpYrHOccT
         HtB8wbHVbHIosNehJGikxtyYy2jx1qTDymx39X6vH/eUaoQxs9ZYkE1Uijt/9cIb1mbo
         89jSaJ3rkBIEJXgYSqZUvu+dP4GWFRA4tvVCgnZt8jS5y4ny+eRQ28aatuv5g7f39be7
         HDGU7RRybiLTkE+ngZe4Q3MKaB3XnLyNuht0yD3hdk8f6qtqgs8jfVq8iWTJejIrs2eV
         EXoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=vVXqxaE88deNdcdJooVrKTDUCzlFYlo2Y/0NmbYMock=;
        fh=mV8Uwy03aTQpEc71kkKqimIDFbwq2oIhKiU5zAUO9K0=;
        b=M0q25fveqhHuzLympS220ImT6JQYqA4xInpZjcbr8lNK4DsMFLMyLDTx5mRm6eyoVm
         SUa38e2CJnpKSFfYumL6L6qehYwXrhb2Y537HUc9OrNj1d8yBDleSoWnj6WcQW0jmkEL
         mZ1KBRq3Y8UunLRH3FRcaFf8XpqMHXnT7oya+G8OO0Al8sJpZ/MOmjDs7aYZufN0x1NN
         cIhwiPCGLpYKbU4U6HukNyPMezyK7/ooU/SSfpdbA39UsWMqouklNNbHEB2RBrSSQZe4
         6lbLkwrUuwFZ4LenmmIo2EZla4u0799gOW9xFzH0euHSqcXbCXNn0Cct5MlbdjjIpctm
         VDYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772772100; x=1773376900; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vVXqxaE88deNdcdJooVrKTDUCzlFYlo2Y/0NmbYMock=;
        b=O7bETAAAV8YMSFO3VQXDxz4PMtumGS2DhWYxxXHPepWFt+E8meNWFS4nVQIZbIU6LU
         TyiAeNLuPIrY6Aq2vUX4frtPOnuGxafSV58bARLjoQouK0fdMqy7IaGYEDyY4mVLx/zM
         eaj9yAalJP078DuPqrxQ/Ij0gwtqEEb9YMiDdhQULBeb8QQzGmGTpjGK5NbeVmlezSD5
         7yonI8/S9rq8t/gYuwt8ZaXsz0R81H8H7/7pJ9juy28yQfkjYwJx5xxZKA2sdrpEPCjh
         WN6lBYWhqBRx9YpyZqTzyYwYvwC3LxXpKMdpwgt6b2BQt4PvtspMB8fLcfTShQaEkvC1
         lTHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772772100; x=1773376900;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vVXqxaE88deNdcdJooVrKTDUCzlFYlo2Y/0NmbYMock=;
        b=FSCx1qE2TI/PhAGWJvGy9T9fXxbCOAZYRGYRkO6J5vJ4v0zpoCWuz2i4NZdCIzpglr
         z0M9KGxtiI6twRNT5lP7kgsR4eN4dR+2wWK+2WNcZ+KRMhxNXTh5gtDFlIEQQtBNRl/N
         Ox7orK2Kdlxew4oeya1jnO9E3oboTnTdpfMBRWblBByMlIoHqt0MjkVZiE/wOb3gcsvg
         QXgXCMq46PF5/E6yeKnvGtoNzCPvLo/bwnoSG1Rwm/XJbXyyzGDm6v68nznLAAbyRYh4
         fca8POCxlxo0oEgFsVL5BcRaBUD0nfE2IdI7E/cLosqyuMF6ZNASkFrxuOXafKOpr75a
         xSIg==
X-Gm-Message-State: AOJu0YzlZr14bTVHXFHDIdprkws7BzuBPXE2NT/bXaWPGY48sbXVRvo5
	hpQX90E6ZEKyjWAdWoVNTC6FdH3V87f7Kdky3cp9KsQkQWsq0YQ1avNukir/PFHFP6mJbXqBlh2
	/mQ04otCkhP68CWDGyOFDl0xTcEVnQs3dHnaYZnsMRg==
X-Gm-Gg: ATEYQzxfVtXccZ86do6gNna57gQrVEy4PengwbnbEDCkx3mrhJufDSejQRwM04G39uZ
	6kiYGHxFc3sQxu9f84cMbp8ie8RI+RG5IfqCr3ZkP7TxxzxxU39P1v9SuscWkIhXmuFH0G1xHic
	C/WdkLDb5vQhnAaapautuIpKbCLhyt6aEIVo6V7Wuzi64MP1SxJROuo0go9OkwNBEjYOhLLfqR8
	/cEK1AVbJdLnshUMODdjbsKCq8ndgVeKZRvoTl8ljKOTrALbEr8J1hsSgKzK5b0K608Aj6Yv/Kp
	+OH1oFIaE3NiFeVodKhGB0/LFztk4wFAiscZ/1s49ozYYyR4gODCVHcnbcm7REz1TmJX4w==
X-Received: by 2002:a05:600c:620b:b0:483:6d4e:9811 with SMTP id
 5b1f17b1804b1-4852696d451mr9114745e9.31.1772772100000; Thu, 05 Mar 2026
 20:41:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225-sleepable_tracepoints-v2-0-0330dafd650f@meta.com> <20260225-sleepable_tracepoints-v2-6-0330dafd650f@meta.com>
In-Reply-To: <20260225-sleepable_tracepoints-v2-6-0330dafd650f@meta.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 6 Mar 2026 05:41:03 +0100
X-Gm-Features: AaiRm53m0ohLOe47VVgLr75sNEtzNxwtRRmu2GNmfP-U-yXjMvqM-0Y5i0toSDo
Message-ID: <CAP01T77gHpzcOHK3kDHsPCdyAu17i4kk5C+uYeD-xWdsmT6gYw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 6/6] selftests/bpf: Add tests for sleepable
 raw tracepoint programs
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Feb 2026 at 17:25, Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Add two subtests:
> - success: Attach a sleepable BPF program to the faultable sys_enter
>   tracepoint (tp_btf.s/sys_enter). Verify the program is triggered by
>   a syscall.
> - reject_non_faultable: Attempt to attach a sleepable BPF program to
>   a non-faultable tracepoint (tp_btf.s/sched_switch). Verify that
>   attachment is rejected.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

... but see nit below.

>  .../selftests/bpf/prog_tests/sleepable_raw_tp.c    | 56 ++++++++++++++++++++++
>  .../selftests/bpf/progs/test_sleepable_raw_tp.c    | 43 +++++++++++++++++
>  .../bpf/progs/test_sleepable_raw_tp_fail.c         | 16 +++++++
>  tools/testing/selftests/bpf/verifier/sleepable.c   |  5 +-
>  4 files changed, 117 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/sleepable_raw_tp.c b/tools/testing/selftests/bpf/prog_tests/sleepable_raw_tp.c
> new file mode 100644
> index 000000000000..9b0ec7cc4cac
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/sleepable_raw_tp.c
> @@ -0,0 +1,56 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
> +
> +#include <test_progs.h>
> +#include <time.h>
> +#include "test_sleepable_raw_tp.skel.h"
> +#include "test_sleepable_raw_tp_fail.skel.h"
> +
> +static void test_sleepable_raw_tp_success(void)
> +{
> +       struct test_sleepable_raw_tp *skel;
> +       int err;
> +
> +       skel = test_sleepable_raw_tp__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "skel_open_load"))
> +               return;
> +
> +       skel->bss->target_pid = getpid();

Shouldn't this be sys_gettid()? Otherwise the filter in prog only
works for the main thread (pid == tgid) in parallel test_progs mode.

> +
> +       err = test_sleepable_raw_tp__attach(skel);
> +       if (!ASSERT_OK(err, "skel_attach"))
> +               goto cleanup;
> +
> +       syscall(__NR_nanosleep, &(struct timespec){ .tv_nsec = 555 }, NULL);
> +
> +       ASSERT_EQ(skel->bss->triggered, 1, "triggered");
> +       ASSERT_EQ(skel->bss->err, 0, "err");
> +       ASSERT_EQ(skel->bss->copied_tv_nsec, 555, "copied_tv_nsec");
> +
> +cleanup:
> +       test_sleepable_raw_tp__destroy(skel);
> +}
> +
> +static void test_sleepable_raw_tp_reject(void)
> +{
> +       struct test_sleepable_raw_tp_fail *skel;
> +       int err;
> +
> +       skel = test_sleepable_raw_tp_fail__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "skel_open_load"))
> +               goto cleanup;
> +
> +       err = test_sleepable_raw_tp_fail__attach(skel);
> +       ASSERT_ERR(err, "skel_attach_should_fail");
> +
> +cleanup:
> +       test_sleepable_raw_tp_fail__destroy(skel);
> +}
> +
> +void test_sleepable_raw_tp(void)
> +{
> +       if (test__start_subtest("success"))
> +               test_sleepable_raw_tp_success();
> +       if (test__start_subtest("reject_non_faultable"))
> +               test_sleepable_raw_tp_reject();
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_sleepable_raw_tp.c b/tools/testing/selftests/bpf/progs/test_sleepable_raw_tp.c
> new file mode 100644
> index 000000000000..ebacc766df57
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_sleepable_raw_tp.c
> @@ -0,0 +1,43 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
> +
> +#include <vmlinux.h>
> +#include <asm/unistd.h>
> +#include <bpf/bpf_tracing.h>
> +#include <bpf/bpf_core_read.h>
> +#include <bpf/bpf_helpers.h>
> +
> +char _license[] SEC("license") = "GPL";
> +
> +int target_pid;
> +int triggered;
> +long err;
> +long copied_tv_nsec;
> +
> +SEC("tp_btf.s/sys_enter")
> +int BPF_PROG(test_sleepable_sys_enter, struct pt_regs *regs, long id)
> +{
> +       struct task_struct *task = bpf_get_current_task_btf();
> +       struct __kernel_timespec *ts;
> +       long tv_nsec;
> +
> +       if (task->pid != target_pid)
> +               return 0;
> +
> +       if (id != __NR_nanosleep)
> +               return 0;
> +
> +       ts = (void *)PT_REGS_PARM1_CORE_SYSCALL(regs);
> +
> +       /*
> +        * Use bpf_copy_from_user() - a sleepable helper - to read user memory.
> +        * This exercises the sleepable execution path of raw tracepoints.
> +        */
> +       err = bpf_copy_from_user(&tv_nsec, sizeof(tv_nsec), &ts->tv_nsec);
> +       if (err)
> +               return err;
> +
> +       copied_tv_nsec = tv_nsec;
> +       triggered = 1;
> +       return 0;
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_sleepable_raw_tp_fail.c b/tools/testing/selftests/bpf/progs/test_sleepable_raw_tp_fail.c
> new file mode 100644
> index 000000000000..ef5dc3888df6
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_sleepable_raw_tp_fail.c
> @@ -0,0 +1,16 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
> +
> +#include <vmlinux.h>
> +#include <bpf/bpf_tracing.h>
> +#include <bpf/bpf_helpers.h>
> +
> +char _license[] SEC("license") = "GPL";
> +
> +/* Sleepable program on a non-faultable tracepoint should fail at attach */
> +SEC("tp_btf.s/sched_switch")
> +int BPF_PROG(test_sleepable_sched_switch, bool preempt,
> +            struct task_struct *prev, struct task_struct *next)
> +{
> +       return 0;
> +}
> diff --git a/tools/testing/selftests/bpf/verifier/sleepable.c b/tools/testing/selftests/bpf/verifier/sleepable.c
> index 1f0d2bdc673f..39522b7cd317 100644
> --- a/tools/testing/selftests/bpf/verifier/sleepable.c
> +++ b/tools/testing/selftests/bpf/verifier/sleepable.c
> @@ -76,7 +76,7 @@
>         .runs = -1,
>  },
>  {
> -       "sleepable raw tracepoint reject",
> +       "sleepable raw tracepoint accept",
>         .insns = {
>         BPF_MOV64_IMM(BPF_REG_0, 0),
>         BPF_EXIT_INSN(),
> @@ -84,8 +84,7 @@
>         .prog_type = BPF_PROG_TYPE_TRACING,
>         .expected_attach_type = BPF_TRACE_RAW_TP,
>         .kfunc = "sched_switch",
> -       .result = REJECT,
> -       .errstr = "Only fentry/fexit/fmod_ret, lsm, iter, uprobe, and struct_ops programs can be sleepable",
> +       .result = ACCEPT,
>         .flags = BPF_F_SLEEPABLE,
>         .runs = -1,
>  },
>
> --
> 2.47.3
>
>
