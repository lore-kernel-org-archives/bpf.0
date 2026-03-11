Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2744A2882D6
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 23:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773272484; cv=none; b=O83YXEtx3YK+B8zgSRGaUxARcnENLD2M7t2gLM4XTQjAv4wP+P4DYUDXMRXaBCCu1Lxh2ctwogS1yMIdbDNFBKQNEI5qZBXatM19Tj4tQl8HeE2+EwOP9rC079tBQvNtzS5uwTAY0iO6ododr7dz5PDgvPM5v9QmNAaM2kPJ5KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773272484; c=relaxed/simple;
	bh=xWq3YYa49300xj3E4CHoWQAiIReuu8RTF0hxuWUSH4o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TrT+kizVmaVH9D9llmWd0NiBm3KQ6qEtrUmyJPO03lCB70aVAO4rU9UVieZZTyz+1cmEXSmRtrwvUybP9l09X7c+6VcgNdo24yqxpkqQ7rkvq6dkAidCI8f60IHfDKgYKYjirepAzCsok2qoB1tfDoJdYEDV2WBS6kq93WBXqd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HV+ws/vx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HV+ws/vx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 505C0C4CEF7;
	Wed, 11 Mar 2026 23:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773272483;
	bh=xWq3YYa49300xj3E4CHoWQAiIReuu8RTF0hxuWUSH4o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=HV+ws/vxtGdobVj7lWAK/NTb5EvRRxib5z4l+EdAFvZ/YWLfJ/2uYBKEsV5v6Tj/I
	 SniVPxoB0fPnTqlvBZpt4zB5V45z+kx+uC7rJcz7XGR8nJLrZ4PJS/PQLAcWUvDJbc
	 a5lIZ/DQFE5GqvdhJ8tdS5ihbVfrdbTKlJkbY/rtoxaR+++E41iN3FrBNuNddUhflO
	 atxYw+qwh1eLXUhJjfAhUss1BCDk/2jLs3tOw3UkNOcQlbdif+TccvAPOWQ+w2+Xbz
	 VdUgrtXB3Q9L2LLFRRZ9k86uZIAZWjhxu0PvkeObQ5U7Df15bf86Xq1fErV49ZW5eR
	 wxWgdCkXgbFMw==
From: Puranjay Mohan <puranjay@kernel.org>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>
Subject: Re: [PATCH bpf-next v3 4/4] selftests/bpf: Add tests for sleepable
 raw tracepoint programs
In-Reply-To: <20260311-sleepable_tracepoints-v3-4-3e9bbde5bd22@meta.com>
References: <20260311-sleepable_tracepoints-v3-0-3e9bbde5bd22@meta.com>
 <20260311-sleepable_tracepoints-v3-4-3e9bbde5bd22@meta.com>
Date: Wed, 11 Mar 2026 23:41:19 +0000
Message-ID: <m2bjguj5nk.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mykyta Yatsenko <mykyta.yatsenko5@gmail.com> writes:

> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Add tests for sleepable raw tracepoint programs:
> - success: Attach a sleepable BPF program to the faultable sys_enter
>   tracepoint (tp_btf.s/sys_enter). Verify the program is triggered by
>   a syscall.
> - reject_non_faultable: Verify that loading a sleepable BPF program
>   targeting a non-faultable tracepoint (tp_btf.s/sched_switch) is
>   rejected by the verifier.
>
> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>

Acked-by: Puranjay Mohan <puranjay@kernel.org>

> ---
>  .../selftests/bpf/prog_tests/sleepable_raw_tp.c    | 40 ++++++++++++++++++++
>  .../selftests/bpf/progs/test_sleepable_raw_tp.c    | 43 ++++++++++++++++++++++
>  .../bpf/progs/test_sleepable_raw_tp_fail.c         | 18 +++++++++
>  tools/testing/selftests/bpf/verifier/sleepable.c   | 17 ++++++++-
>  4 files changed, 116 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/sleepable_raw_tp.c b/tools/testing/selftests/bpf/prog_tests/sleepable_raw_tp.c
> new file mode 100644
> index 000000000000..e902b41591e7
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/sleepable_raw_tp.c
> @@ -0,0 +1,40 @@
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
> +void test_sleepable_raw_tp(void)
> +{
> +	if (test__start_subtest("success"))
> +		test_sleepable_raw_tp_success();
> +
> +	RUN_TESTS(test_sleepable_raw_tp_fail);
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
> index 000000000000..54100899f728
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_sleepable_raw_tp_fail.c
> @@ -0,0 +1,18 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
> +
> +#include <vmlinux.h>
> +#include <bpf/bpf_tracing.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +
> +char _license[] SEC("license") = "GPL";
> +
> +/* Sleepable program on a non-faultable tracepoint should fail to load */
> +SEC("tp_btf.s/sched_switch")
> +__failure __msg("Sleepable program cannot attach to non-faultable tracepoint")
> +int BPF_PROG(test_sleepable_sched_switch, bool preempt,
> +	     struct task_struct *prev, struct task_struct *next)
> +{
> +	return 0;
> +}
> diff --git a/tools/testing/selftests/bpf/verifier/sleepable.c b/tools/testing/selftests/bpf/verifier/sleepable.c
> index 1f0d2bdc673f..6dabc5522945 100644
> --- a/tools/testing/selftests/bpf/verifier/sleepable.c
> +++ b/tools/testing/selftests/bpf/verifier/sleepable.c
> @@ -76,7 +76,20 @@
>  	.runs = -1,
>  },
>  {
> -	"sleepable raw tracepoint reject",
> +	"sleepable raw tracepoint accept",
> +	.insns = {
> +	BPF_MOV64_IMM(BPF_REG_0, 0),
> +	BPF_EXIT_INSN(),
> +	},
> +	.prog_type = BPF_PROG_TYPE_TRACING,
> +	.expected_attach_type = BPF_TRACE_RAW_TP,
> +	.kfunc = "sys_enter",
> +	.result = ACCEPT,
> +	.flags = BPF_F_SLEEPABLE,
> +	.runs = -1,
> +},
> +{
> +	"sleepable raw tracepoint reject non-faultable",
>  	.insns = {
>  	BPF_MOV64_IMM(BPF_REG_0, 0),
>  	BPF_EXIT_INSN(),
> @@ -85,7 +98,7 @@
>  	.expected_attach_type = BPF_TRACE_RAW_TP,
>  	.kfunc = "sched_switch",
>  	.result = REJECT,
> -	.errstr = "Only fentry/fexit/fmod_ret, lsm, iter, uprobe, and struct_ops programs can be sleepable",
> +	.errstr = "Sleepable program cannot attach to non-faultable tracepoint",
>  	.flags = BPF_F_SLEEPABLE,
>  	.runs = -1,
>  },
>
> -- 
> 2.52.0
