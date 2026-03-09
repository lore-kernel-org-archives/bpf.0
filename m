Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5F31386C9
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 21:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773090678; cv=none; b=Tvz9V7S9V7ECe7n9J+WXack2oq7yAjvseZZFPs95W0BPicatuU3za0tIhCOM7q/J3sbvgtUhQAtaTufjM8HjJV/Gt7aNX5HBfZcURuP+h1JBTgBq4HxwStiCEMg5an1e0iWhimIzJ3Wf1LRb41xopbbtLjjoEeSAgeHvy1xj0Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773090678; c=relaxed/simple;
	bh=ceo7wSAMoJeQiavdAEEUzDv17n4fPFNfnazMhHh/5Bc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UtdcSq12HJCZwt2buov76ssEqzJnaUvhXDTFcTnQLp/eGdaE2G5aO2lI3ztXxDjadRUhsUhhhUnNHXpKD8xG+2hQSBAPtZvAssAv7KctI8/EeoY81SRVCAl9OChrnUZ2cxr/cMllHzORZmiP9TzuG9PqbIRLAMrszNVRoFML0UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=crQlZR41; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crQlZR41"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-439bcec8613so6392740f8f.3
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 14:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773090675; x=1773695475; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GwQsU988rmTRvoDjKYX9wewA7d8qNzh/mztz1K9n1wQ=;
        b=crQlZR41cJEojRO7lG6b0b/Wjoti/9wNUNVkBCkJtVmkld8NwdJ2fbMtX2JJRcwHLv
         1QBYgfN9mcOm0fYsoujGUU9nVdAzIFaR/SoImK1pCi5qZlDOcUVsb4sI7DHtTrpEoKFZ
         eFXYpGPh8eKWIp66GCPr72vFc33oh/u2ogUzxK01MiFabhmvMq6OgN7hI1rETs/cenu+
         g5mDfgpZG8ZYNweL+oCZKunXCFvZdfCx8Qc/MdSb/530QbZYbYq6yx72DZCC3ioOQYZx
         SeR6aCoMk1ubyD3RWwGniFStcgd/dN7fvmHG6nHbeQSfGd9gagd+1Ys3mhyZfmBmUDtX
         7QeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773090675; x=1773695475;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GwQsU988rmTRvoDjKYX9wewA7d8qNzh/mztz1K9n1wQ=;
        b=Z25KMA0IlHaL55o/BJq1KRONQI6zpKorK7zCI7CuV+QLJxG0rwU1RNdA3ZF5GCd3c2
         AxFcPpVS2tJxJmpu8eK03+YOlKfXm56fQmcFpzz+NBqBENV8ZrM970n+NZJQOeBCQcdE
         tQwcsQq0WDyqNZuiRk+1uSWg0BmZTFuNswQzucA8XnuQ1gLGUwwwJGvj4ckYo/Xtsenj
         Z9G0DqxNeCS4g0u3VRTmOiSB259i17ubDXkwbTUTAL+zFc8mbyXcZI/XWNcyt3u1gXIZ
         AK4vxG2DJS3bhqjjnSPqgwWBoeoojosHn/p+cc/KqMocxrRd6ApnifyorOFTGVKZ98bC
         aGMw==
X-Gm-Message-State: AOJu0YzXV0feqVHQWZFZVSnFK/ZNOmx0K0tSKLXYQZISVvm84KJizHLt
	XnkjRinXz7+4Dh6SPwNEO2TQzxk5rV77K25vt0XoxKEioURK6p2Kq0L+
X-Gm-Gg: ATEYQzyBgoTMn1r2eYF18EUfyAUYKrAb4fgB4pHDNi7qMLZvo25Ie54k5KYByZcAjH1
	ytnXnaCHPnSJusC+CSCjzI5JpslxcaXJZaklVFetjQo2JpuR1+j7G5AMOlIdhptR3iXn0LKszVW
	shbrqdMOg0VwQdiodpDM2qSaolfYk+CMV4qklHTDVfjn58W4ak5pzGMNulMOgURFk6WCiiuUIv6
	68uS5sjjZMGxy9zxX3hkaBa8cHC9UM8GkT4jtd27/r/soiExbqybrU4LZ0/33ApGsCvOjOpRKmt
	Ijx6T/HKZffhAHjXkUcchpCGcfSCbMLRBEp/+C8H6ero7k2/7T1NBGv58jC7fdgTRpwLOrSMNHZ
	5R/AHniOqL/SBdYTj7qfNtD8NMQUJz0l/dg1UruftGWRPcxzR3iNXC0w0FyWJj1VFDTQI8vRtl3
	NutLEWk7XHi9wPTjhcKXb8GQ==
X-Received: by 2002:a5d:5848:0:b0:439:c3d1:a399 with SMTP id ffacd0b85a97d-439da351f2bmr23402787f8f.21.1773090674557;
        Mon, 09 Mar 2026 14:11:14 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae3d98asm33136496f8f.30.2026.03.09.14.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 14:11:14 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 9 Mar 2026 22:11:12 +0100
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
	eddyz87@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
Subject: Re: [PATCH bpf-next v2 6/6] selftests/bpf: Add tests for sleepable
 raw tracepoint programs
Message-ID: <aa83cJrghkxkIs9A@krava>
References: <20260225-sleepable_tracepoints-v2-0-0330dafd650f@meta.com>
 <20260225-sleepable_tracepoints-v2-6-0330dafd650f@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225-sleepable_tracepoints-v2-6-0330dafd650f@meta.com>

On Wed, Feb 25, 2026 at 08:23:54AM -0800, Mykyta Yatsenko wrote:
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
> +	struct test_sleepable_raw_tp *skel;
> +	int err;
> +
> +	skel = test_sleepable_raw_tp__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel_open_load"))
> +		return;
> +
> +	skel->bss->target_pid = getpid();
> +
> +	err = test_sleepable_raw_tp__attach(skel);
> +	if (!ASSERT_OK(err, "skel_attach"))
> +		goto cleanup;
> +
> +	syscall(__NR_nanosleep, &(struct timespec){ .tv_nsec = 555 }, NULL);
> +
> +	ASSERT_EQ(skel->bss->triggered, 1, "triggered");
> +	ASSERT_EQ(skel->bss->err, 0, "err");
> +	ASSERT_EQ(skel->bss->copied_tv_nsec, 555, "copied_tv_nsec");
> +
> +cleanup:
> +	test_sleepable_raw_tp__destroy(skel);
> +}
> +
> +static void test_sleepable_raw_tp_reject(void)
> +{
> +	struct test_sleepable_raw_tp_fail *skel;
> +	int err;
> +
> +	skel = test_sleepable_raw_tp_fail__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel_open_load"))
> +		goto cleanup;
> +
> +	err = test_sleepable_raw_tp_fail__attach(skel);
> +	ASSERT_ERR(err, "skel_attach_should_fail");

would it be better to call RUN_TESTS(test_sleepable_raw_tp_fail) instead?
you could also check the verifier output

jirka


> +
> +cleanup:
> +	test_sleepable_raw_tp_fail__destroy(skel);
> +}
> +
> +void test_sleepable_raw_tp(void)
> +{
> +	if (test__start_subtest("success"))
> +		test_sleepable_raw_tp_success();
> +	if (test__start_subtest("reject_non_faultable"))
> +		test_sleepable_raw_tp_reject();
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
> +	struct task_struct *task = bpf_get_current_task_btf();
> +	struct __kernel_timespec *ts;
> +	long tv_nsec;
> +
> +	if (task->pid != target_pid)
> +		return 0;
> +
> +	if (id != __NR_nanosleep)
> +		return 0;
> +
> +	ts = (void *)PT_REGS_PARM1_CORE_SYSCALL(regs);
> +
> +	/*
> +	 * Use bpf_copy_from_user() - a sleepable helper - to read user memory.
> +	 * This exercises the sleepable execution path of raw tracepoints.
> +	 */
> +	err = bpf_copy_from_user(&tv_nsec, sizeof(tv_nsec), &ts->tv_nsec);
> +	if (err)
> +		return err;
> +
> +	copied_tv_nsec = tv_nsec;
> +	triggered = 1;
> +	return 0;
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
> +	     struct task_struct *prev, struct task_struct *next)
> +{
> +	return 0;
> +}
> diff --git a/tools/testing/selftests/bpf/verifier/sleepable.c b/tools/testing/selftests/bpf/verifier/sleepable.c
> index 1f0d2bdc673f..39522b7cd317 100644
> --- a/tools/testing/selftests/bpf/verifier/sleepable.c
> +++ b/tools/testing/selftests/bpf/verifier/sleepable.c
> @@ -76,7 +76,7 @@
>  	.runs = -1,
>  },
>  {
> -	"sleepable raw tracepoint reject",
> +	"sleepable raw tracepoint accept",
>  	.insns = {
>  	BPF_MOV64_IMM(BPF_REG_0, 0),
>  	BPF_EXIT_INSN(),
> @@ -84,8 +84,7 @@
>  	.prog_type = BPF_PROG_TYPE_TRACING,
>  	.expected_attach_type = BPF_TRACE_RAW_TP,
>  	.kfunc = "sched_switch",
> -	.result = REJECT,
> -	.errstr = "Only fentry/fexit/fmod_ret, lsm, iter, uprobe, and struct_ops programs can be sleepable",
> +	.result = ACCEPT,
>  	.flags = BPF_F_SLEEPABLE,
>  	.runs = -1,
>  },
> 
> -- 
> 2.47.3
> 
> 
