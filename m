Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AB4361DC9
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 19:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773256331; cv=none; b=I8915zUkIgGbkbbVI2PEVLD4e88HbJqThrcBLWTMODIdj8QVVBrWdP5H4xF1YQn5ir5d08Q4Y2h957aNKp5ft+/XgxsWJkWVD7UV44X9z31JZenhWkyIf4UD2IL/KC5oJANwAM2cG1AL8bu0zNWyihKlDienrX8IIodZhP5Fi7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773256331; c=relaxed/simple;
	bh=H2h+IHVq6KRMt28P/BYo1uLDIF7og1kcwIA3V23L8iE=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=YcJ1KG//tmSSqvIBLBIR/4olVhO+nKeCNEef1YznBAhksHF3KVcmSeVhy3N0Y+qoQA8mJkC8TRV1Suz7JvImY055BdBATLMLT8pA1//O/JdhSZe+eHpv8vshJy2CJbw9EZ01NxTx2p0c+fBIsPhZSqtwoIacTXWg8dTei0hs6aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=k9m7v3lu; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="k9m7v3lu"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5091d71aa11so3410281cf.1
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 12:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1773256329; x=1773861129; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TC3K/5wfXIxiBIr8KqtBIzF0nyDKtjRfg2Ash+hbC8M=;
        b=k9m7v3lutcmKef0HrXDZOovkSYoNSPiK5fyjqGCzoM/G17U4mTSR0a1VqbkBJCfzIF
         lu26Ju8xQdOtA4tl9Izs0zGL6tNUA358A95xlhm5dpLW++68LxsAEP3cDl6BUGtL+AsD
         t7P/9I25kgKdMz6Hp5xWCcw2p19Ttp3724gUnV3c89Rg41H5sweVrC38f093Luay5VVz
         IENz/F3oheV4egCmZC7VFskR6iSSRHCE+wnsm9YteR1liUp+5WkaiO1DYx6lpoy1UBRD
         b0wQgK5IPS5ZaNHDDlYYON3kWkzClQm/mmS9v+at4dN44ctdIdhyo+QZT7dQRh4fG7YV
         Tr/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773256329; x=1773861129;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TC3K/5wfXIxiBIr8KqtBIzF0nyDKtjRfg2Ash+hbC8M=;
        b=b/Kaq8IWBAAerUcioPHsCDx38TmZ4enp8v00mw3sC5nRMZd6CEhGvj2+MuSETg0ab0
         OgJswdP0zEdLbTQAJAXCA3nPouRwgJuxYV1CiOrHSuQRSlrW5LT86AWcvBOYXINvQ/92
         N8M7HZDgxE53VamLISm5md+C60UgVRBEeLXQOT2ZEcKGoT0NKuKrw61nKVzH0vkzPVVN
         5ehHXSXLPmqttATxoJ7zGvCmQ15qwaN8gXYZPm6YsJbb+ocmnjWbnBXEzY91YhAC8/MB
         BWRW5FfA5IB94PQHLl/nY2uLfzvk6LgMzB16TXJdTKU7thWhqnKo5USWdxFU+VG8ZHUk
         2RBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUr2Ng3FYe/pRHAwOOsCir42GKiTY/1ebhHHduRBJzjtX4w+DWv8LBhzBpV0fdnxJadcE4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJeMfrbU78D3T8yIny8TjTrDcB/oTcnp6iywCl2RVtftmlzSsm
	wSMeqlqhnfWmuDJhM8NVWLNoECEdHt6qkUjAQWij3iVnn6BPJfUhLhkMNxdC1VSlHTU=
X-Gm-Gg: ATEYQzywqqRgBQmHrRbtUC3SVJY1ZwY/IgZtjqqmzuARQB++zAqXwT/KnPPPjOjvWeb
	+KldeyiMJMk0sgsXfl1vGQop7We3UrdPyxd8X0QgMsdiydTlrnalOTxszL5QAiniBk0MZnpIT2f
	s9bZLk9RnkLCll3sUUXPR5S8bGNTuYNXiOaz/pKF17JTeL9FIuga05A+bUGu3Kvrixai2CmD1p6
	lQaL/HW1vuIlFIscOSf4My54Qu5QYSftlUzetN3q6zqeR2B5I+XfE0M81l/C3DcYGWuPideQmJo
	DGsNXg0X/Qqo+h51QLQ0klgh7zOb/JIE6sjwxgwlidMK9+YM5088lG9i856eODZzoDa6BOlJX0q
	OGU5VTFXcSQpiIX19wf1a1OU+CdrSE0+Cyk92CMuColn9ieUCZ6YjUWKMlUFrzAxUOzwFT4b9P2
	FvFMCBaEXGjcEAkkTS7iRXDU4=
X-Received: by 2002:a05:622a:15d5:b0:509:195d:5ef0 with SMTP id d75a77b69052e-509471bbe56mr10287511cf.12.1773256328799;
        Wed, 11 Mar 2026 12:12:08 -0700 (PDT)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a65d0a7b6sm20016406d6.44.2026.03.11.12.12.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 12:12:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Mar 2026 15:12:06 -0400
Message-Id: <DH06WMLZKIN0.Y9TVEDM7QPB8@etsalapatis.com>
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>, <bpf@vger.kernel.org>,
 <ast@kernel.org>, <andrii@kernel.org>, <daniel@iogearbox.net>,
 <kafai@meta.com>, <kernel-team@meta.com>, <eddyz87@gmail.com>
Cc: "Mykyta Yatsenko" <yatsenko@meta.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>
Subject: Re: [PATCH bpf-next v3 4/4] selftests/bpf: Add tests for sleepable
 raw tracepoint programs
X-Mailer: aerc 0.20.1
References: <20260311-sleepable_tracepoints-v3-0-3e9bbde5bd22@meta.com>
 <20260311-sleepable_tracepoints-v3-4-3e9bbde5bd22@meta.com>
In-Reply-To: <20260311-sleepable_tracepoints-v3-4-3e9bbde5bd22@meta.com>

On Wed Mar 11, 2026 at 2:22 PM EDT, Mykyta Yatsenko wrote:
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

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  .../selftests/bpf/prog_tests/sleepable_raw_tp.c    | 40 ++++++++++++++++=
++++
>  .../selftests/bpf/progs/test_sleepable_raw_tp.c    | 43 ++++++++++++++++=
++++++
>  .../bpf/progs/test_sleepable_raw_tp_fail.c         | 18 +++++++++
>  tools/testing/selftests/bpf/verifier/sleepable.c   | 17 ++++++++-
>  4 files changed, 116 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/sleepable_raw_tp.c b/=
tools/testing/selftests/bpf/prog_tests/sleepable_raw_tp.c
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
> +	skel =3D test_sleepable_raw_tp__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel_open_load"))
> +		return;
> +
> +	skel->bss->target_pid =3D getpid();
> +
> +	err =3D test_sleepable_raw_tp__attach(skel);
> +	if (!ASSERT_OK(err, "skel_attach"))
> +		goto cleanup;
> +
> +	syscall(__NR_nanosleep, &(struct timespec){ .tv_nsec =3D 555 }, NULL);
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
> diff --git a/tools/testing/selftests/bpf/progs/test_sleepable_raw_tp.c b/=
tools/testing/selftests/bpf/progs/test_sleepable_raw_tp.c
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
> +char _license[] SEC("license") =3D "GPL";
> +
> +int target_pid;
> +int triggered;
> +long err;
> +long copied_tv_nsec;
> +
> +SEC("tp_btf.s/sys_enter")
> +int BPF_PROG(test_sleepable_sys_enter, struct pt_regs *regs, long id)
> +{
> +	struct task_struct *task =3D bpf_get_current_task_btf();
> +	struct __kernel_timespec *ts;
> +	long tv_nsec;
> +
> +	if (task->pid !=3D target_pid)
> +		return 0;
> +
> +	if (id !=3D __NR_nanosleep)
> +		return 0;
> +
> +	ts =3D (void *)PT_REGS_PARM1_CORE_SYSCALL(regs);
> +
> +	/*
> +	 * Use bpf_copy_from_user() - a sleepable helper - to read user memory.
> +	 * This exercises the sleepable execution path of raw tracepoints.
> +	 */
> +	err =3D bpf_copy_from_user(&tv_nsec, sizeof(tv_nsec), &ts->tv_nsec);
> +	if (err)
> +		return err;
> +
> +	copied_tv_nsec =3D tv_nsec;
> +	triggered =3D 1;
> +	return 0;
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_sleepable_raw_tp_fail=
.c b/tools/testing/selftests/bpf/progs/test_sleepable_raw_tp_fail.c
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
> +char _license[] SEC("license") =3D "GPL";
> +
> +/* Sleepable program on a non-faultable tracepoint should fail to load *=
/
> +SEC("tp_btf.s/sched_switch")
> +__failure __msg("Sleepable program cannot attach to non-faultable tracep=
oint")
> +int BPF_PROG(test_sleepable_sched_switch, bool preempt,
> +	     struct task_struct *prev, struct task_struct *next)
> +{
> +	return 0;
> +}
> diff --git a/tools/testing/selftests/bpf/verifier/sleepable.c b/tools/tes=
ting/selftests/bpf/verifier/sleepable.c
> index 1f0d2bdc673f..6dabc5522945 100644
> --- a/tools/testing/selftests/bpf/verifier/sleepable.c
> +++ b/tools/testing/selftests/bpf/verifier/sleepable.c
> @@ -76,7 +76,20 @@
>  	.runs =3D -1,
>  },
>  {
> -	"sleepable raw tracepoint reject",
> +	"sleepable raw tracepoint accept",
> +	.insns =3D {
> +	BPF_MOV64_IMM(BPF_REG_0, 0),
> +	BPF_EXIT_INSN(),
> +	},
> +	.prog_type =3D BPF_PROG_TYPE_TRACING,
> +	.expected_attach_type =3D BPF_TRACE_RAW_TP,
> +	.kfunc =3D "sys_enter",
> +	.result =3D ACCEPT,
> +	.flags =3D BPF_F_SLEEPABLE,
> +	.runs =3D -1,
> +},
> +{
> +	"sleepable raw tracepoint reject non-faultable",
>  	.insns =3D {
>  	BPF_MOV64_IMM(BPF_REG_0, 0),
>  	BPF_EXIT_INSN(),
> @@ -85,7 +98,7 @@
>  	.expected_attach_type =3D BPF_TRACE_RAW_TP,
>  	.kfunc =3D "sched_switch",
>  	.result =3D REJECT,
> -	.errstr =3D "Only fentry/fexit/fmod_ret, lsm, iter, uprobe, and struct_=
ops programs can be sleepable",
> +	.errstr =3D "Sleepable program cannot attach to non-faultable tracepoin=
t",
>  	.flags =3D BPF_F_SLEEPABLE,
>  	.runs =3D -1,
>  },

