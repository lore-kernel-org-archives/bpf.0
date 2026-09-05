Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8177F3859DC
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 08:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788595348; cv=none; b=GT2PDXY92GhGAcx4XfzbfB9Z58XFE51kJZayyA6c3PoABcOrcjxkHConAj56bXOOR6veMMaQGK4ZK/tYyb1sZjZuMHKMD1Q9UXoBQ4o7B5YL5zfrNTz7FQnbgbCdnfDFd4ayiRXVozZioM35ILTrj+kP4ZN+WP4Y6kEu+uEC+xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788595348; c=relaxed/simple;
	bh=fBJ97Su5/P/bfwqdpEkUYb6AgBQbCA0o9k0u891ZSLU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=LcuSXbaguSsG3F8mo1r6zKnP+LW6As4DrG7QSbEJPWnD76HtSO68DvY69l6epDpZJ8/xtqHUrVHxV8pTW34sRjeanDOyWd5nN1tLTM19zyzGjXCZOdAj05y7ZZNJC8XAen28o4KhGN9dn/3QZ1v4qm1tzxtzVt4+Pd3I8h3lE8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cSRSegcU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cSRSegcU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 645CB1F00A3E;
	Sat,  5 Sep 2026 08:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788595347;
	bh=27kZHUZ28ODpJY9WrsTuwojj5b23CTuiNuRp07FwLDw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=cSRSegcURTu8idy7TQVO0S1EJ1TA0Yv1zfKCeOC6vLVMP27PBdOLFTfcuGOC7zKl3
	 1c4JANOMTVr8vf8BIhGta4J2MV6OxZc2rvsyv0I0vOgehlg6NJHTSsIJHxOgqbedB5
	 BlXVJLxgPcMFTnQfpRXRtln2G274nyYak9t04WukkRjs/NLDdWZCH2ib8IoUqCBw4D
	 rpomjK+7YHWx5QHcXOYRR7BfMkKMS6MAGW3KaHLRR/HTLksSn0m8aumH6+u+f2ca1i
	 R7sGfxbCBCL/PGP2p9SSWSH+Xestuw60NZo+TAsDDIUvE1VXXKNWF6ECfu6VlK5Wga
	 Bw1+wHnO+x9Bw==
Content-Type: multipart/mixed; boundary="===============3088636442108631682=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <68717c2c3378b0a3acb915360911f1070e2afbe60f60491f54ce8f76d5ec11c9@mail.kernel.org>
In-Reply-To: <20260905070003.3193366-3-memxor@gmail.com>
References: <20260905070003.3193366-3-memxor@gmail.com>
Subject: Re: [PATCH bpf v1 2/8] selftests/bpf: Test killing a loader during instruction rewrites
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,npc@anthropic.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat,  5 Sep 2026 08:02:26 +0000 (UTC)

--===============3088636442108631682==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/prog_load_signal.c b/tools/testing/selftests/bpf/prog_tests/prog_load_signal.c
> new file mode 100644
> index 000000000000..0f78db3bccc7
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/prog_load_signal.c
> @@ -0,0 +1,131 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> +#include <test_progs.h>
> +
> +#define NOP_CNT		32768
> +#define MIN_KILL_DELAY_NS	(100ULL * 1000 * 1000)
> +#define REAP_TIMEOUT_NS		(1000ULL * 1000 * 1000)
> +
> +static __u64 monotonic_ns(void)
> +{
> +	struct timespec ts;
> +
> +	clock_gettime(CLOCK_MONOTONIC, &ts);
> +	return ts.tv_sec * 1000000000ULL + ts.tv_nsec;
> +}
                ^^^

A subsystem pattern flags this as potentially concerning: monotonic_ns()
re-implements a helper that the BPF selftests test-util header already
provides.

tools/testing/selftests/bpf/testing_helpers.h defines get_time_ns():

    static inline __u64 get_time_ns(void)
    {
        struct timespec t;

        clock_gettime(CLOCK_MONOTONIC, &t);

        return (u64)t.tv_sec * 1000000000 + t.tv_nsec;
    }

That header is already pulled in by test_progs.h, so get_time_ns() is in
scope here with no extra include. It's the helper the rest of prog_tests/
uses for exactly this purpose:

  kprobe_multi_test.c
  reg_bounds.c
  lru_lock_nmi.c
  perf_link.c
  test_tc_edt.c
  uprobe_multi_test.c

The new monotonic_ns() body is functionally identical (the only difference is
the missing (u64) cast on tv_sec, which is harmless here because the
multiplier is 1000000000ULL).

> +
> +static void sleep_ns(__u64 duration)
> +{
> +	struct timespec ts = {
> +		.tv_sec = duration / 1000000000ULL,
> +		.tv_nsec = duration % 1000000000ULL,
> +	};
> +
> +	while (nanosleep(&ts, &ts) && errno == EINTR)
> +		;
> +}
> +
> +static int waitpid_timeout(pid_t pid, int *status, __u64 timeout)
> +{
> +	__u64 deadline = monotonic_ns() + timeout;
> +	int ret;
> +
> +	do {
> +		ret = waitpid(pid, status, WNOHANG);
> +		if (ret)
> +			return ret;
> +		usleep(1000);
> +	} while (monotonic_ns() < deadline);
> +
> +	return 0;
> +}
              ^^^

Similarly, waitpid_timeout() hand-rolls a deadline/usleep(1000) polling loop,
and lru_lock_nmi.c and perf_link.c show the established get_time_ns()-based
deadline idiom in this directory. Would using the shared helper keep a single
implementation to fix and keep the call sites consistent with the rest of the
suite?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33952325041
--===============3088636442108631682==--
