Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1239048B36E
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 13:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785331395; cv=none; b=aMbnP2qrbq3Uun/vN73oG3vRTpOx75mI1Pon18kj8Gv/p6s8vn3VDznWvQ5oe98ecuAJkopLQyadfDJGs1j0iPcoY8sCjJRrFtbfy5NaIWfEqSu1xwmJvU3belfwYlX/qPZMbpDQCiiW8GUKU3udkMllCdughpkZ32/6VrE6ijI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785331395; c=relaxed/simple;
	bh=ZZMcD4I79X+ry5UESE8/y992VJr2AaCKGnCuH5RaWak=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lG9mz8vbncPxQv8fiE3mES/mM8pQ992IdCqfAimH+kVzcOCoS1XR+sKlrR5fpqw4Ct4qn8o3gTfY6g3aCb4fwyJzhVKzF3URwJJx6ejusewV9yyqq72621W2pqtNMDVsCkID89n3+rB1gJlAqMX21emZJV3nQKjbp6SJGzG+9+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mtj5NF+i; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mtj5NF+i"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47f6609c657so508495f8f.2
        for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 06:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785331392; x=1785936192; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qtisZXxp66Ja5qyzCPlhZzLSzh5LLKzx/lw7V4AEa14=;
        b=Mtj5NF+ifPcNI73a3yUm8BFklD35vDqm5ixoaMbyiggjeB5Vdi7EpiPH9LMMavUGKs
         zvKIcjdYEOh71TsPvL8JHDg8JblS2nNQVpFwIPFK/c4KV3G2zXsOrsUAnyU82qbxdPPN
         Huv421yVCrfIChkgQddM/D6eDWx79fuz1zBf9aXRG8oEMfY46M5m9EZp8ZpMKD4y12t/
         vlRv/aZ5fkHXcMOM97od/NQuM3b+Mp09yetxaFHiul/NZ1qLdJKYnjU8zFRrbQqZPnzD
         6C1W2V70ao7JnUufiW25n5nvRYV4kqpI4TaehMw3c9lqDEgSFuLCVEUs08zTqL5905w5
         xRTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785331392; x=1785936192;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qtisZXxp66Ja5qyzCPlhZzLSzh5LLKzx/lw7V4AEa14=;
        b=iYXH1QgIZs33YfBP5vW/BELpuCBCVX/bkjyGWlYJLmnRNjjyic/488Vbfgkr/w9l/F
         cl9lZNg2vgWiDxuAuyDcdXq2QlP2YroRgkuTe6ZXgzWxGOvVJIzxw4K7KtGlMS9LV1Ll
         JQ0HaK8+V/FzfLCkhq85fJLhBYQU5bfMi+lgtmDssCccyw6rKJUOjjjv85QVohySr6pD
         VsGMBheYmQ6PFGaeDjCsMkJD9OudJlSkC/8A9h9I3Uh2B+ae3gWOfzb2R7Y3M5400wHS
         DS8fSxNkJEwbORGqy5OqsvZHnjYQ4OvNyzEXauDoiNj31eb6MRmL3y3t0Z7DAUqRym8p
         9A7w==
X-Gm-Message-State: AOJu0YykPLsGalT4sQ95g4NjVDFZ3jUMDqtAzozspE+lHEuMPTSayF8j
	ZvsqA2a/LkiyXuATtev58PBTEJXwdMFoI2wv4tPWcn8+SfC/emqZx5Oe
X-Gm-Gg: AR+sD12KvAZZ3MD664wUw6auhdPD/7h8fV9ByDee3U1brlLh6DbNQxlA1d0fBD59cgk
	5pKA75nG3SRwYzNpAJN6sZknhuvOA2hHf17nsjGhHoCs/Ux0v887hQw26SVVxMBGHbA5AW7WdpS
	UpVQ2BKmfPqryyUVUQBKs1qdeO7nAeXrUy8+hka826mhJTIsqgbxozX/fmPBt6M9sD1Muje7IZK
	nMoW8vRe9offjSoSdPiDI8OX6Kr08KTmXeB9CV84bRA6ZGXvdoDwt1tTRgquSuay81PsnxT8c9w
	w3LqvE1lx5DxE63Glhk1AMgZmkqB57kXC5u6D7KtEqwP2mcjgIHdgY+ppjhY9qoVlduq3a2l96i
	DC6pr9AlM3mEYXMDfLApttvXOc7ctKsAg6tq5ZLg01w0MiZ1tZMvHA+2GU8RoUO6vKiV02dwM+3
	wlVTFM+Gock8rhWHi9RQvPTsOoUgZwnuxFXA==
X-Received: by 2002:a5d:5f48:0:b0:47f:9425:1a2a with SMTP id ffacd0b85a97d-47fb1ea7954mr7488293f8f.30.1785331392081;
        Wed, 29 Jul 2026 06:23:12 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::dd7e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fb6aa3b1csm8366628f8f.1.2026.07.29.06.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 06:23:11 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 29 Jul 2026 15:23:09 +0200
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, song@kernel.org,
	rostedt@goodmis.org, naveen@kernel.org, davem@davemloft.net,
	mhiramat@kernel.org, stable@vger.kernel.org,
	linux-open-source@crowdstrike.com
Subject: Re: [RFC PATCH bpf-next 3/3] selftests/bpf: add ftrace_permanent test
Message-ID: <amn-vbX6AitcIcC0@krava>
References: <20260729005959.3853865-1-andrey.grodzovsky@crowdstrike.com>
 <20260729005959.3853865-4-andrey.grodzovsky@crowdstrike.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729005959.3853865-4-andrey.grodzovsky@crowdstrike.com>

On Tue, Jul 28, 2026 at 08:59:59PM -0400, Andrey Grodzovsky wrote:
> Cover the FTRACE_OPS_FL_PERMANENT fix on BPF trampolines and
> ftrace-based kprobes/kretprobes: attach a fentry, fexit, kprobe, and
> kretprobe program in turn and confirm kernel.ftrace_enabled=0 is
> refused with EBUSY while attached, then succeeds once detached. Also
> confirm a new fentry/kprobe attach is itself refused while
> ftrace_enabled=0 is already in effect.
> 
> kprobe.multi/kretprobe.multi/kprobe.session are intentionally not
> covered, matching the production change's scope.
> 
> Skip the kprobe/kretprobe subtests when CONFIG_KPROBES_ON_FTRACE is
> off (e.g. arm64), read back via skel->kconfig->CONFIG_KPROBES_ON_FTRACE
> (same __kconfig idiom as progs/test_fill_link_info.c).
> 
> Assisted-by: Claude:claude-sonnet-5
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
> ---

hi,
I have some links active already after boot which makes test to fail:

  [root@qemu-1 bpf]# echo 0 > /proc/sys/kernel/ftrace_enabled
  bash: echo: write error: Device or resource busy

  [root@qemu-1 bpf]# ./test_progs -t ftrace_permanent -v
  bpf_testmod.ko is already unloaded.
  Loading bpf_testmod.ko...
  Successfully loaded bpf_testmod.ko.
  test_ftrace_permanent:PASS:skel_open_and_load 0 nsec
  check_blocks_disable:PASS:attach_fentry 0 nsec
  check_blocks_disable:PASS:disable_refused 0 nsec
  check_blocks_disable:PASS:read_back 0 nsec
  check_blocks_disable:PASS:still_enabled 0 nsec
  check_blocks_disable:FAIL:disable_after_detach unexpected error: -16 (errno 16)
  check_blocks_disable:PASS:reenable 0 nsec
  #145/1   ftrace_permanent/fentry_blocks_disable:FAIL
  check_blocks_disable:PASS:attach_fexit 0 nsec
  check_blocks_disable:PASS:disable_refused 0 nsec
  check_blocks_disable:PASS:read_back 0 nsec
  check_blocks_disable:PASS:still_enabled 0 nsec
  check_blocks_disable:FAIL:disable_after_detach unexpected error: -16 (errno 16)
  check_blocks_disable:PASS:reenable 0 nsec
  #145/2   ftrace_permanent/fexit_blocks_disable:FAIL
  check_blocks_disable:PASS:attach_kprobe 0 nsec
  check_blocks_disable:PASS:disable_refused 0 nsec
  check_blocks_disable:PASS:read_back 0 nsec
  check_blocks_disable:PASS:still_enabled 0 nsec
  check_blocks_disable:FAIL:disable_after_detach unexpected error: -16 (errno 16)
  check_blocks_disable:PASS:reenable 0 nsec
  #145/3   ftrace_permanent/kprobe_blocks_disable:FAIL
  check_blocks_disable:PASS:attach_kretprobe 0 nsec
  check_blocks_disable:PASS:disable_refused 0 nsec
  check_blocks_disable:PASS:read_back 0 nsec
  check_blocks_disable:PASS:still_enabled 0 nsec
  check_blocks_disable:FAIL:disable_after_detach unexpected error: -16 (errno 16)
  check_blocks_disable:PASS:reenable 0 nsec
  #145/4   ftrace_permanent/kretprobe_blocks_disable:FAIL
  check_attach_while_disabled_refused:FAIL:disable unexpected error: -16 (errno 16)
  #145/5   ftrace_permanent/fentry_attach_while_disabled_refused:FAIL
  check_attach_while_disabled_refused:FAIL:disable unexpected error: -16 (errno 16)
  #145/6   ftrace_permanent/kprobe_attach_while_disabled_refused:FAIL
  #145     ftrace_permanent:FAIL
  Summary: 0/0 PASSED, 0 SKIPPED, 1 FAILED
  Successfully unloaded bpf_testmod.ko.

jirka


>  .../bpf/prog_tests/ftrace_permanent.c         | 144 ++++++++++++++++++
>  .../selftests/bpf/progs/ftrace_permanent.c    |  43 ++++++
>  2 files changed, 187 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/ftrace_permanent.c
>  create mode 100644 tools/testing/selftests/bpf/progs/ftrace_permanent.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/ftrace_permanent.c b/tools/testing/selftests/bpf/prog_tests/ftrace_permanent.c
> new file mode 100644
> index 000000000000..dbe78009a291
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/ftrace_permanent.c
> @@ -0,0 +1,144 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 CrowdStrike */
> +#include <test_progs.h>
> +#include "ftrace_permanent.skel.h"
> +
> +/*
> + * fentry/fexit/kprobe/kretprobe now carry FTRACE_OPS_FL_PERMANENT, so
> + * kernel.ftrace_enabled=0 must be refused with EBUSY while any of them
> + * is attached, and allowed again once detached.
> + *
> + * kprobe.multi/kretprobe.multi/kprobe.session are out of scope.
> + * kprobe/kretprobe subtests need CONFIG_KPROBES_ON_FTRACE (e.g. not on
> + * arm64) and are skipped otherwise.
> + */
> +
> +#define FTRACE_ENABLED_PATH "/proc/sys/kernel/ftrace_enabled"
> +
> +static int read_ftrace_enabled(int *val)
> +{
> +	char buf[16] = {};
> +	int fd, n;
> +
> +	fd = open(FTRACE_ENABLED_PATH, O_RDONLY);
> +	if (fd < 0)
> +		return -errno;
> +	n = read(fd, buf, sizeof(buf) - 1);
> +	close(fd);
> +	if (n <= 0)
> +		return -EIO;
> +	*val = atoi(buf);
> +	return 0;
> +}
> +
> +/* Returns 0 on success, or -errno on write failure. */
> +static int write_ftrace_enabled(int val)
> +{
> +	char buf[4];
> +	int fd, n, len, err = 0;
> +
> +	fd = open(FTRACE_ENABLED_PATH, O_WRONLY);
> +	if (fd < 0)
> +		return -errno;
> +	len = snprintf(buf, sizeof(buf), "%d", val);
> +	n = write(fd, buf, len);
> +	if (n < 0)
> +		err = -errno;
> +	close(fd);
> +	return err;
> +}
> +
> +/*
> + * Attach @prog, assert kernel.ftrace_enabled=0 is refused while attached
> + * and stays at 1, then detach and assert the disable now succeeds.
> + */
> +static void check_blocks_disable(struct bpf_program *prog, const char *name)
> +{
> +	struct bpf_link *link;
> +	int val, err;
> +
> +	link = bpf_program__attach(prog);
> +	if (!ASSERT_OK_PTR(link, name))
> +		return;
> +
> +	err = write_ftrace_enabled(0);
> +	ASSERT_EQ(err, -EBUSY, "disable_refused");
> +	if (!ASSERT_OK(read_ftrace_enabled(&val), "read_back"))
> +		goto detach;
> +	ASSERT_EQ(val, 1, "still_enabled");
> +
> +detach:
> +	bpf_link__destroy(link);
> +
> +	ASSERT_OK(write_ftrace_enabled(0), "disable_after_detach");
> +	ASSERT_OK(write_ftrace_enabled(1), "reenable");
> +}
> +
> +/* Attach @prog while ftrace_enabled=0 and assert it is refused. */
> +static void check_attach_while_disabled_refused(struct bpf_program *prog, const char *name)
> +{
> +	struct bpf_link *link;
> +
> +	if (!ASSERT_OK(write_ftrace_enabled(0), "disable"))
> +		return;
> +
> +	link = bpf_program__attach(prog);
> +	if (!ASSERT_ERR_PTR(link, name))
> +		bpf_link__destroy(link);
> +
> +	ASSERT_OK(write_ftrace_enabled(1), "reenable");
> +}
> +
> +void test_ftrace_permanent(void)
> +{
> +	struct ftrace_permanent *skel;
> +	bool kprobes_on_ftrace;
> +	int orig = 1;
> +
> +	/* Save and always restore ftrace_enabled. */
> +	if (read_ftrace_enabled(&orig)) {
> +		test__skip();
> +		return;
> +	}
> +
> +	skel = ftrace_permanent__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
> +		goto restore;
> +
> +	kprobes_on_ftrace = skel->kconfig->CONFIG_KPROBES_ON_FTRACE;
> +
> +	if (test__start_subtest("fentry_blocks_disable"))
> +		check_blocks_disable(skel->progs.test_fentry, "attach_fentry");
> +
> +	if (test__start_subtest("fexit_blocks_disable"))
> +		check_blocks_disable(skel->progs.test_fexit, "attach_fexit");
> +
> +	if (test__start_subtest("kprobe_blocks_disable")) {
> +		if (kprobes_on_ftrace)
> +			check_blocks_disable(skel->progs.test_kprobe, "attach_kprobe");
> +		else
> +			test__skip();
> +	}
> +
> +	if (test__start_subtest("kretprobe_blocks_disable")) {
> +		if (kprobes_on_ftrace)
> +			check_blocks_disable(skel->progs.test_kretprobe, "attach_kretprobe");
> +		else
> +			test__skip();
> +	}
> +
> +	if (test__start_subtest("fentry_attach_while_disabled_refused"))
> +		check_attach_while_disabled_refused(skel->progs.test_fentry, "attach_fentry");
> +
> +	if (test__start_subtest("kprobe_attach_while_disabled_refused")) {
> +		if (kprobes_on_ftrace)
> +			check_attach_while_disabled_refused(skel->progs.test_kprobe,
> +							    "attach_kprobe");
> +		else
> +			test__skip();
> +	}
> +
> +	ftrace_permanent__destroy(skel);
> +restore:
> +	write_ftrace_enabled(orig);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/ftrace_permanent.c b/tools/testing/selftests/bpf/progs/ftrace_permanent.c
> new file mode 100644
> index 000000000000..ca706d8edc23
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/ftrace_permanent.c
> @@ -0,0 +1,43 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 CrowdStrike */
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include <stdbool.h>
> +
> +char _license[] SEC("license") = "GPL";
> +
> +extern bool CONFIG_KPROBES_ON_FTRACE __kconfig __weak;
> +
> +/* This function is here to have CONFIG_KPROBES_ON_FTRACE used and
> + * added to object BTF, so the userspace side can read it back via
> + * skel->kconfig->CONFIG_KPROBES_ON_FTRACE.
> + */
> +int unused(void)
> +{
> +	return CONFIG_KPROBES_ON_FTRACE ? 0 : 1;
> +}
> +
> +SEC("fentry/bpf_fentry_test1")
> +int BPF_PROG(test_fentry, int a)
> +{
> +	return 0;
> +}
> +
> +SEC("fexit/bpf_fentry_test2")
> +int BPF_PROG(test_fexit, int a, __u64 b)
> +{
> +	return 0;
> +}
> +
> +SEC("kprobe/bpf_fentry_test3")
> +int test_kprobe(struct pt_regs *ctx)
> +{
> +	return 0;
> +}
> +
> +SEC("kretprobe/bpf_fentry_test4")
> +int BPF_KRETPROBE(test_kretprobe)
> +{
> +	return 0;
> +}
> -- 
> 2.34.1
> 
