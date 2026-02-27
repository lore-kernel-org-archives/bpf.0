Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBBC1D416C
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 02:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772158680; cv=none; b=pxUzhgNNuFMws94TLmZjAB4dvtFHmfEqqq1Wf9QS3h3Z589S2R7ctgOaClwdJVyjosUA5drE6vk8tU3hdLuY/SO2kuIF3oLPBQ+s2mIelnXl6kV/uWdWebWpBlGkY0/rfClmhIrCH7eopA5vOQ6IqzrDpL0dxXyL+PtH89lvgHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772158680; c=relaxed/simple;
	bh=sU2fQ1j5Oof1nM8EVZIks1PoBPuZvqFnmgn0uo+1DMc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=GUUSk1W2bf9UqvRd/TNHTVLB1M17EGAKvcPDVURra6eyY8H8GkNw5VnlO0/8galcAXE2hwDtpISYEThW3IEcX8u6Y+NBa24sSzCi2T6QyoOEw/U69vvacA7ONcXwiRFGNR0/nk1Z/0vo84t2SJD12woUqDnYZKvY9PGurVlr+h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=WM+4Qxj4; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="WM+4Qxj4"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-897002b7576so26298176d6.3
        for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 18:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1772158678; x=1772763478; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xjZyCdl0Po02cxZ0BlZ7T/EyyUR5kOgkpQk52R9UD48=;
        b=WM+4Qxj4xAcWu8q7bkMN2edp1GuU6OCy8hHxFN6ZVj/XspbzOI7f/ugeMBRuOQtiFb
         J79nUZBUhmC9qRDK6gDl6gblu5fvSXyWbL8X6T17N7ZJGV/NoXhRfhgigmtmH+wExrfl
         hve0eogn+cGVHPvQ4t3iOZfSCstTMzpyWDbk68M4zbxLiljl09Q8c6Do2dznYs/G22ZQ
         YmOEh8FbiAOLaLcTLgl6ThcQJM4IBfAA1m/H03vOc4PvNqavmfQEmsDiTSkN7uI8sY4a
         qLtlllzeKNIc/GDcnmuq1A4Mruo/NWPJk2lMAWZzvxb61KEUlNzrnN9I/+NpiAnzI+s8
         q8Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772158678; x=1772763478;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xjZyCdl0Po02cxZ0BlZ7T/EyyUR5kOgkpQk52R9UD48=;
        b=t5pKjldOrFwMw6KmpJ6OXs/bKs6CD2tB/K5qELhy2DC8z/cUbQyefg4YfHUWE7+s2X
         hfT+a7rKszhD1ZCjRF40h+/DfIbKh7fPHl3EZQgo9vjyjHtXBRcapQqdLVOlWW7dyzQ0
         2F+C7x5HF+EjXRSz1xVqAOpY+5RBPA2fxutx1YvsDyjvFD9RCPA2ICWFcjzmEEmYTMnb
         FOcrPezkbtn9vot+1A+cOkNLSb8TF3qv0oNAHMqkvnPKa+GiJo77rU5N5aZwVORkA/Qp
         B1vvtGor7i+G2M39yrbUUgvOCLFKOpthzu9DbUxeClonCQ+hIAmlTG8+OGiUKo10pZLM
         sItQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhQbbVN0nGiQbKFLI9ASn/1zxd4bNk3HfJDUSmyuB1nSsq7VbiVz4RGPUoKLO2lQUCAG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbLiS8mPfrFX/0hfZIFwz9qbuNyaJoDKCcfKqCa2BXBGI2/NAx
	Vq764YpMI/JW4QvD3fQgwMZM99bsGHPL7BfdHk0Z+noTEo7FRMSIS7Z84RfQDp1IEYUTVXkVrpI
	bzZbC5NU=
X-Gm-Gg: ATEYQzxUjrzNwkjfRiI/Mtnnhp5Bodf6JwZoPMVoeH7nXHgK3luGD0ossaT9F1ElHTP
	5Uxz3vKLIWuoAMfOTt6LFzJTOElA9fB1rSrwK0LhXhBp0JFyi4/1Kux9UOf3Rl7BlWn+KWNNM9W
	o+51CydGJztCp6R0dSOc2LcLinNINrbEMivVPOfpd8k0ld3cjk4n+Lpq/h15J+8ST6JA0zoaj6t
	kV69Yu6S7fxUTe29RRAeg2SGEAgXvQztxg5YCCS/Gc2SFPbWP++xyuWPt1vFbZ7d3rNWMC9PmeT
	e5zXowGwroxcqfv5uLBs7AX2x9iJeuDzM3HnsX8q7uoZtldOhw4eBixTGZP6WjcY/MPgpzQDGYh
	k0C9wW5TNloCCyDmTywW2iS1Nmpx63e+YRVq4MvBMMaAP9DyZhJyQ35Q9RmiWFQy+4E3IWjBKf5
	n5mXSNSoaOoe9xXWM9gSJahuU=
X-Received: by 2002:ad4:4eeb:0:b0:895:d652:e39f with SMTP id 6a1803df08f44-899d1d98d65mr19827566d6.17.1772158678130;
        Thu, 26 Feb 2026 18:17:58 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c7375f30sm31432456d6.27.2026.02.26.18.17.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Feb 2026 18:17:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Feb 2026 21:17:56 -0500
Message-Id: <DGPDTKY115N9.2GDLOCO8AU19S@etsalapatis.com>
Cc: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
 <jolsa@kernel.org>, <linux-open-source@crowdstrike.com>
Subject: Re: [RFC PATCH bpf-next v2 2/2] selftests/bpf: Add tests for
 duplicate kprobe symbol handling
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Andrey Grodzovsky" <andrey.grodzovsky@crowdstrike.com>,
 <bpf@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20260224172340.1704618-1-andrey.grodzovsky@crowdstrike.com>
 <20260224172340.1704618-3-andrey.grodzovsky@crowdstrike.com>
In-Reply-To: <20260224172340.1704618-3-andrey.grodzovsky@crowdstrike.com>

On Tue Feb 24, 2026 at 12:23 PM EST, Andrey Grodzovsky wrote:
> Add test_attach_probe_dup_sym() which loads bpf_testmod_dup_sym.ko to
> create a duplicate symbol scenario, then verifies kprobe and kretprobe
> attachment succeeds across default, legacy, perf_event, and link modes.
>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
> ---
>  tools/testing/selftests/bpf/Makefile          |  2 +-
>  .../selftests/bpf/prog_tests/attach_probe.c   | 63 +++++++++++++++++++
>  .../testing/selftests/bpf/test_kmods/Makefile |  2 +-
>  .../bpf/test_kmods/bpf_testmod_dup_sym.c      | 50 +++++++++++++++
>  4 files changed, 115 insertions(+), 2 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/test_kmods/bpf_testmod_du=
p_sym.c
>

Looks reasonable, after making the change below feel free to add:

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index 6776158f1f3e..fe9671268c6f 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -117,7 +117,7 @@ TEST_PROGS_EXTENDED :=3D \
>  	test_bpftool.py
> =20
>  TEST_KMODS :=3D bpf_testmod.ko bpf_test_no_cfi.ko bpf_test_modorder_x.ko=
 \
> -	bpf_test_modorder_y.ko bpf_test_rqspinlock.ko
> +	bpf_test_modorder_y.ko bpf_test_rqspinlock.ko bpf_testmod_dup_sym.ko
>  TEST_KMOD_TARGETS =3D $(addprefix $(OUTPUT)/,$(TEST_KMODS))
> =20
>  # Compile but not part of 'make run_tests'
> diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tool=
s/testing/selftests/bpf/prog_tests/attach_probe.c
> index 9e77e5da7097..75c22af2f1b3 100644
> --- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> +++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> @@ -4,6 +4,7 @@
>  #include "test_attach_probe_manual.skel.h"
>  #include "test_attach_probe.skel.h"
>  #include "kprobe_write_ctx.skel.h"
> +#include "testing_helpers.h"
> =20
>  /* this is how USDT semaphore is actually defined, except volatile modif=
ier */
>  volatile unsigned short uprobe_ref_ctr __attribute__((unused)) __attribu=
te((section(".probes")));
> @@ -123,6 +124,59 @@ static void test_attach_probe_manual(enum probe_atta=
ch_mode attach_mode)
>  	test_attach_probe_manual__destroy(skel);
>  }
> =20
> +/* Test kprobe attachment with duplicate symbols.
> + * This test loads bpf_testmod_dup_sym.ko which creates a duplicate
> + * __x64_sys_nanosleep symbol. The libbpf fix should prefer the vmlinux
> + * symbol over the module symbol when attaching kprobes.
> + */
> +static void test_attach_probe_dup_sym(enum probe_attach_mode attach_mode=
)
> +{
> +	DECLARE_LIBBPF_OPTS(bpf_kprobe_opts, kprobe_opts);
> +	struct bpf_link *kprobe_link, *kretprobe_link;
> +	struct test_attach_probe_manual *skel;
> +	int err;
> +
> +	/* Load module with duplicate symbol */
> +	err =3D load_module("bpf_testmod_dup_sym.ko", false);
> +	if (!ASSERT_OK(err, "load_bpf_testmod_dup_sym")) {
> +		test__skip();
> +		return;
> +	}
> +
> +	skel =3D test_attach_probe_manual__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel_dup_sym_open_and_load"))
> +		goto unload_module;
> +
> +	/* manual-attach kprobe/kretprobe with duplicate symbol present */
> +	kprobe_opts.attach_mode =3D attach_mode;
> +	kprobe_opts.retprobe =3D false;
> +	kprobe_link =3D bpf_program__attach_kprobe_opts(skel->progs.handle_kpro=
be,
> +						      SYS_NANOSLEEP_KPROBE_NAME,
> +						      &kprobe_opts);
> +	if (!ASSERT_OK_PTR(kprobe_link, "attach_kprobe_dup_sym"))
> +		goto cleanup;
> +	skel->links.handle_kprobe =3D kprobe_link;
> +
> +	kprobe_opts.retprobe =3D true;
> +	kretprobe_link =3D bpf_program__attach_kprobe_opts(skel->progs.handle_k=
retprobe,
> +							 SYS_NANOSLEEP_KPROBE_NAME,
> +							 &kprobe_opts);
> +	if (!ASSERT_OK_PTR(kretprobe_link, "attach_kretprobe_dup_sym"))
> +		goto cleanup;
> +	skel->links.handle_kretprobe =3D kretprobe_link;
> +
> +	/* trigger & validate kprobe && kretprobe */
> +	usleep(1);
> +
> +	ASSERT_EQ(skel->bss->kprobe_res, 1, "check_kprobe_dup_sym_res");
> +	ASSERT_EQ(skel->bss->kretprobe_res, 2, "check_kretprobe_dup_sym_res");
> +
> +cleanup:
> +	test_attach_probe_manual__destroy(skel);
> +unload_module:
> +	unload_module("bpf_testmod_dup_sym", false);
> +}
> +
>  /* attach uprobe/uretprobe long event name testings */
>  static void test_attach_uprobe_long_event_name(void)
>  {
> @@ -417,6 +471,15 @@ void test_attach_probe(void)
>  	if (test__start_subtest("manual-link"))
>  		test_attach_probe_manual(PROBE_ATTACH_MODE_LINK);
> =20
> +	if (test__start_subtest("dup-sym-default"))
> +		test_attach_probe_dup_sym(PROBE_ATTACH_MODE_DEFAULT);
> +	if (test__start_subtest("dup-sym-legacy"))
> +		test_attach_probe_dup_sym(PROBE_ATTACH_MODE_LEGACY);
> +	if (test__start_subtest("dup-sym-perf"))
> +		test_attach_probe_dup_sym(PROBE_ATTACH_MODE_PERF);
> +	if (test__start_subtest("dup-sym-link"))
> +		test_attach_probe_dup_sym(PROBE_ATTACH_MODE_LINK);
> +
>  	if (test__start_subtest("auto"))
>  		test_attach_probe_auto(skel);
>  	if (test__start_subtest("kprobe-sleepable"))
> diff --git a/tools/testing/selftests/bpf/test_kmods/Makefile b/tools/test=
ing/selftests/bpf/test_kmods/Makefile
> index 63c4d3f6a12f..938c462a103b 100644
> --- a/tools/testing/selftests/bpf/test_kmods/Makefile
> +++ b/tools/testing/selftests/bpf/test_kmods/Makefile
> @@ -8,7 +8,7 @@ Q =3D @
>  endif
> =20
>  MODULES =3D bpf_testmod.ko bpf_test_no_cfi.ko bpf_test_modorder_x.ko \
> -	bpf_test_modorder_y.ko bpf_test_rqspinlock.ko
> +	bpf_test_modorder_y.ko bpf_test_rqspinlock.ko bpf_testmod_dup_sym.ko
> =20
>  $(foreach m,$(MODULES),$(eval obj-m +=3D $(m:.ko=3D.o)))
> =20
> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_dup_sym.c=
 b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_dup_sym.c
> new file mode 100644
> index 000000000000..c6a5a32799e9
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_dup_sym.c
> @@ -0,0 +1,50 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2025 CrowdStrike */
> +/* Test module for duplicate kprobe symbol handling */
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +
> +/* Duplicate symbol to test kprobe attachment with duplicate symbols.
> + * This creates a duplicate of the syscall wrapper used in attach_probe =
tests.
> + * The libbpf fix should handle this by preferring the vmlinux symbol.
> + * This function should NEVER be called - kprobes should attach to vmlin=
ux version.
> + */
> +#ifdef __x86_64__
> +int __x64_sys_nanosleep(void);
> +noinline int __x64_sys_nanosleep(void)
> +#elif defined(__s390x__)
> +int __s390x_sys_nanosleep(void);
> +noinline int __s390x_sys_nanosleep(void)
> +#elif defined(__aarch64__)
> +int __arm64_sys_nanosleep(void);
> +noinline int __arm64_sys_nanosleep(void)
> +#elif defined(__riscv)
> +int __riscv_sys_nanosleep(void);
> +noinline int __riscv_sys_nanosleep(void)
> +#else
> +int sys_nanosleep(void);
> +noinline int sys_nanosleep(void)
> +#endif

AFAICT This is kinda ugly but necessary since we can't really include test_=
progs.h.=20
Would be nice if there was an alternative.

> +{
> +	WARN_ONCE(1, "bpf_testmod_dup_sym: dummy nanosleep symbol called - this=
 should never execute!\n");
> +	return -EINVAL;
> +}
> +
> +static int __init bpf_testmod_dup_sym_init(void)
> +{
> +	pr_info("bpf_testmod_dup_sym: loaded (duplicate symbol test module)\n")=
;

Can we remove the pr_info calls? They don't provide anything and no
other kmod emits diagnostics AFAICT.

> +	return 0;
> +}
> +
> +static void __exit bpf_testmod_dup_sym_exit(void)
> +{
> +	pr_info("bpf_testmod_dup_sym: unloaded\n");
> +}
> +
> +module_init(bpf_testmod_dup_sym_init);
> +module_exit(bpf_testmod_dup_sym_exit);
> +
> +MODULE_AUTHOR("Andrey Grodzovsky");
> +MODULE_DESCRIPTION("BPF selftest duplicate symbol module");
> +MODULE_LICENSE("GPL");

