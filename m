Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAAB384232;
	Sat, 12 Sep 2026 10:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789210398; cv=none; b=oxP4kgItHOsGVj/Q01GdN+LgGBb9WUxL7VyP3D7OH9fm1ATuRm3ULdOz7NRtvpHfJzJ5Yc+I6EwtMmfL/uVfodPo7yldkUvsYq/gutJznjJl2c+ACh0R1Yytgmct9ag/KkofvWFCsYpXKc0G3Xz3deLuHekn6BP04UchGSusRhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789210398; c=relaxed/simple;
	bh=/+KZg0RKCSnx65PjYKfMuysZFyRk2WJLynvH5ZSYUoI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=o/x4ySC17OPhpA5hhqcdpRJtRL7J2JctaDlwN1FhKLSs8ItG3XBW2eYjtEBQoTrfa2HvGftleRYIuhmiphjwdLvkyE0ZS462tICQBZFq+ZqWni4Qoc60dfXZjh5NShTYH6UbzRoFwZDcgnJOwupb9/763UNtNJWCyUvYJaHBnW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cea0OrAS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cea0OrAS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D60501F000FF;
	Sat, 12 Sep 2026 10:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789210397;
	bh=byZPI+r2Fr+aYMUGbjM0ZtK8dE0rAJeeApwUYkR2mNw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=cea0OrAS7lPCJZCrzoKLi9a6R1AZShc42sxqpnm+4YoE3AGef81SrrruoBIc+x5qw
	 aSwZelQsn/xKiM/JefuBYbjKJKBqJ6Uq3o20GhFxWc8Nt0Dk/gY7Wu7c0vhU/1wQFi
	 x4Z/MMGEzb1ddxBSCxNS07IV2QJuxBWQRAWU6mm1P9euBgKiNMf8Yv0Jfu8unppPs2
	 TT7STocGIkK0sNlHGWyZ9J6DVSYjE3ozJTkRaHQKeHVjAASiMytu3RzK2Q7CS1UWrW
	 TjtSRrEizztgCPn9kVusHMSq5i+vXHM31WrdJ33pxL0Z1H1JVFNFVhsR4mNFOq7oe9
	 tsjOPdb+mJ2Ow==
Content-Type: multipart/mixed; boundary="===============3303375958296002518=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1846328ba25c25cd5bfe44219f2836f50f90e4c5e243a40042800f67e8d5f372@mail.kernel.org>
In-Reply-To: <20260912095924.866254-3-florent.revest@linux.dev>
References: <20260912095924.866254-3-florent.revest@linux.dev>
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: Detach a trampoline prog while a task sleeps before it
From: bot+bpf-ci@kernel.org
To: florent.revest@linux.dev,bpf@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: florent.revest@linux.dev,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,kpsingh@kernel.org,john.fastabend@gmail.com,leon.hwang@linux.dev,zirajs7@gmail.com,rhkrqnwk98@gmail.com,puranjay@kernel.org,xukuohai@huaweicloud.com,iii@linux.ibm.com,hbathini@linux.ibm.com,chleroy@kernel.org,naveen@kernel.org,bjorn@kernel.org,pulehui@huawei.com,yangtiezhu@loongson.cn,hengqi.chen@gmail.com,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 12 Sep 2026 10:53:15 +0000 (UTC)

--===============3303375958296002518==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/tramp_prog_detach.c b/tools/testing/selftests/bpf/prog_tests/tramp_prog_detach.c
> new file mode 100644
> index 000000000000..9a0e1fc44c74
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/tramp_prog_detach.c
> @@ -0,0 +1,191 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <test_progs.h>
> +#include <pthread.h>
> +#include <poll.h>
> +#include <sys/mman.h>
> +#include <sys/syscall.h>
> +#include <linux/userfaultfd.h>
> +#include "tramp_prog_detach.skel.h"
> +#include "testing_helpers.h"
> +
> +/*
> + * Detach and free a prog while a task sleeps in the prog that runs before it
> + * in the same trampoline image, then let that task continue through the
> + * image. It must not call into the freed prog.
> + *
> + * The task is held in a sleepable fentry prog with userfaultfd, like
> + * bpf_mod_race does.
> + */

This isn't a bug, but does "a sleepable fentry prog" still cover both
subtests?  serial_test_tramp_prog_detach() runs test_detach(false) and
test_detach(true), and the second one holds the task in the prog from
SEC("?fexit.s/bpf_fentry_test1").

Would dropping "fentry" here, so it just reads "a sleepable prog", match
what the file does now?  The per-subtest comments in
serial_test_tramp_prog_detach() already spell out the fentry and fexit
cases.

> +
> +static int test_setup_uffd(void *fault_addr)
> +{
> +	struct uffdio_register uffd_register = {};
> +	struct uffdio_api uffd_api = {};
> +	int uffd;
> +
> +	uffd = syscall(__NR_userfaultfd, O_CLOEXEC);
> +	if (uffd < 0)
> +		return -errno;
> +
> +	uffd_api.api = UFFD_API;
> +	uffd_api.features = 0;
> +	if (ioctl(uffd, UFFDIO_API, &uffd_api)) {
> +		close(uffd);
> +		return -1;
> +	}
> +
> +	uffd_register.range.start = (unsigned long)fault_addr;
> +	uffd_register.range.len = getpagesize();
> +	uffd_register.mode = UFFDIO_REGISTER_MODE_MISSING;
> +	if (ioctl(uffd, UFFDIO_REGISTER, &uffd_register)) {
> +		close(uffd);
> +		return -1;
> +	}
> +	return uffd;
> +}

This isn't a bug either, but this test_setup_uffd() looks like the
same helper that already lives in prog_tests/bpf_mod_race.c: same
name, same uffd_register/uffd_api/uffd locals, same UFFDIO_API then
UFFDIO_REGISTER order, and the same close()/return -1 handling.  The
only difference is that bpf_mod_race.c goes through its local
sys_userfaultfd() wrapper instead of calling
syscall(__NR_userfaultfd, O_CLOEXEC) directly.

There is no shared userfaultfd helper in testing_helpers.h today, so
the two copies would have to be kept in sync by hand.  Would it be
worth moving it into testing_helpers.c so both tests share one copy?

[ ... ]

> +void serial_test_tramp_prog_detach(void)
> +{
> +	/* a task sleeping before the original function is called */
> +	if (test__start_subtest("fentry"))
> +		test_detach(false);
> +	/* a task sleeping after it returned, past the jmp that detach installs */
> +	if (test__start_subtest("fexit"))
> +		test_detach(true);
> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34688142088
--===============3303375958296002518==--
