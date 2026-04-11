Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E415211A28
	for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 17:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775928827; cv=none; b=fSAPIHZ/yLjEYVplnRAYDNfvNzxqIhfHRnAJJLPkwpL8bLFc4mzWz9rRcIs5t339zYMtA8PL8MF7Z0BpG7HyaqNxyS76lfG9o8iWd+zg/FLWHlDNS+xPomzBWYzV6djx9tFZ31g7U6RXBuc/4a+vDxJvCqKsTOSB2BDGD1yGJ6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775928827; c=relaxed/simple;
	bh=IU/0pOkeFDc+FRkr7E9j+UCNzuCjih1QJGsPSy7fwU8=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=ipOKdelfBezQjiz5Eu5X1ujVokNq3XttCH6NEFNMeL5NuE5Yq9HQV9BcbTSmPkFv6XO6FRmSYXmv10mGHRIrYx+FtKDFH25ydPARdqPnCnO1N113zAgmsVjQEq1E1GFmrmPhjaFVWTbK94mm5THWgSYFrTKDHJt/GPg024lHHfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=o5U7q8Px; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="o5U7q8Px"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-35c2fe0d90fso2133678a91.1
        for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 10:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1775928824; x=1776533624; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7+fjhkgboTj6XpIyi85+VsmEIROTdfUbY9vPiAakbcs=;
        b=o5U7q8PxzKL7Cu4PulsTQ47TXAb10nPLJOI1ZebEABJ5QRsWqybXMrYp4corWRW1OC
         O9lJwdgPItCPxiOnRlTC8ITAWxKnmxLYY3u2uAoRxkqWmWAfX0iTRYgh6Bfw9nez2wSF
         f5zAH5GurWjyaQ2oYYtTbcgzdLSdOxG/qEiXCrW/kJJijgaMzh/pszvbJAsRSIf09pYj
         kZN/YpQK1lYBLMEbIgqRvXo8fwqYTs37cVcqRsjfy4k3zntWu049r/4bC3oLJbp8toIF
         +url3+OWb8I34pP9T203Aa/o4z23RVMZSFY7VpympO7hVFIGvWzHDyED0BPlpydLmKgT
         CrvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775928824; x=1776533624;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7+fjhkgboTj6XpIyi85+VsmEIROTdfUbY9vPiAakbcs=;
        b=cZvIgSLiqGCDPsJK28T3PzT80q0vpFVXf72NaPUzr4PJmDFwAna/siy0pE1TUAtUBD
         A9B7YyL/JVbkeYJgcP8IG3oead2KaqJLe13C/1yOR2TC9LyZeWXyCbpluhmpbaGhLqLK
         L47p7/DFppCcA+4Z9btqEjzCkS/0PvVl/pnaxuBS+RDLzuv1HFjX7e8QTSatUrCmfSgm
         3JLwVZ1lhMTAuPldfTksmFqsiG+5+o1pIQMtzWnhChqnpKIf9rvU7Ajx4+9IfHJtjhGp
         /wd0yjlBr+OWFxr/64uedFgH/+pqLLi6I+t+tmWnURgfgpSf3Nd8QesOEk2vZdv0aLJ7
         GNRw==
X-Forwarded-Encrypted: i=1; AFNElJ+UpXDe4N7P5CHt65ZRV1Svq3OSGFHgMVwGec0zDVySb+ubzcvMivpzHpWHt51JkjWFuXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbO8KImbiUWF/UiL+3SMtzVLRXAPGCBdwzW04bpMUn6G88mxmZ
	eZVjBd7lb2UPb49fi4Sz/IuBHljO0a86LYUI4Qd82DTBv7JpT+DUgQMWFC/CAuyIGp3is949CRg
	EyT4Np2rspSuG
X-Gm-Gg: AeBDies9TSjWBb7y93jRDtkUcQvG1H5qZ90PIV/bSvIy4Y3zo+pwfI/Zj5vaD8h/K1Q
	EplWMstmi5OdT+JS12M+RQXdU2N9N9NbAPcSX52DAXBJ74Son5D+GqAlt7c1IsTdScqSarLWOZv
	aGlgIjpnA5FEYIt78P9INT/iCmkdPeYvoC17Ip/soIZCgk/HF6YEhFilBR2vYOhHzm7bosGnOQw
	VSiybpELYQGXmCG5lm1S/nLvHjfBdtfx6/T5hWT0Df20CdPqPCZlbH4c/dw3clEn7ZMQ/vznwPL
	1/dGCyv1+pKM5fvMcQi3bcxhCvubst0tNSOzoRAC2ZyyoSeWSiBfzOtE2Q2bV48WVtEcDRnjU7u
	+GlXthhYsW0fZmmpmaI5fEeG1uRU47DI2bqnmwLd8Gp6GK6KOclIJN2c+NA+lqBWpEjlXDM6/ao
	C4fgx4l3U=
X-Received: by 2002:a17:90b:3950:b0:35b:e4f8:7cc5 with SMTP id 98e67ed59e1d1-35e4284c7e0mr7604236a91.25.1775928824314;
        Sat, 11 Apr 2026 10:33:44 -0700 (PDT)
Received: from localhost ([2604:3d08:487d:cd00::5517])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f09e85sm70570795ad.47.2026.04.11.10.33.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Apr 2026 10:33:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 11 Apr 2026 13:33:43 -0400
Message-Id: <DHQI86CY1QDQ.16RMS5QSX99EC@etsalapatis.com>
To: "Weiming Shi" <bestswngs@gmail.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>
Cc: "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "John Fastabend" <john.fastabend@gmail.com>, "KP
 Singh" <kpsingh@kernel.org>, "Stanislav Fomichev" <sdf@fomichev.me>, "Hao
 Luo" <haoluo@google.com>, "Jiri Olsa" <jolsa@kernel.org>, "Barret Rhoden"
 <brho@google.com>, <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 "Xiang Mei" <xmei5@asu.edu>
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: Add test for arena VMA
 use-after-free on fork
From: "Emil Tsalapatis" <emil@etsalapatis.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260411112944.1455470-1-bestswngs@gmail.com>
 <20260411112944.1455470-3-bestswngs@gmail.com>
In-Reply-To: <20260411112944.1455470-3-bestswngs@gmail.com>

On Sat Apr 11, 2026 at 7:29 AM EDT, Weiming Shi wrote:
> Add a selftest that reproduces the arena VMA use-after-free fixed in
> the previous commit. The test creates an arena, mmaps it, allocates
> pages via BPF, forks, has the parent munmap the arena, then has the
> child call bpf_arena_free_pages. Without the fix this triggers a
> KASAN slab-use-after-free in zap_page_range_single.
>
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
>  .../selftests/bpf/prog_tests/arena_fork.c     | 86 +++++++++++++++++++
>  .../testing/selftests/bpf/progs/arena_fork.c  | 41 +++++++++
>  2 files changed, 127 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_fork.c
>  create mode 100644 tools/testing/selftests/bpf/progs/arena_fork.c
>

The test doesn't work for me as advertised. Does it fail for you under
vmtest without patch 1/2?

The test doesn't fail on base vmtest for me, even without the previous patc=
h,
because KASAN isn't turned on for the CI. With KASAN the test triggers
the splat just fine.=20

Should we maybe turn on KASAN and panic_on_warn by default on vmtest?

> diff --git a/tools/testing/selftests/bpf/prog_tests/arena_fork.c b/tools/=
testing/selftests/bpf/prog_tests/arena_fork.c
> new file mode 100644
> index 000000000000..445574827891
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/arena_fork.c
> @@ -0,0 +1,86 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 */
> +

No actual copyright holder.

> +/*
> + * Test that forking a process with an arena mmap does not cause a
> + * use-after-free when the parent unmaps and the child frees arena pages=
.
> + *
> + * The bug: arena_vm_open() only incremented a refcount but never regist=
ered
> + * the child's VMA. After parent munmap, vml->vma pointed to a freed
> + * vm_area_struct. bpf_arena_free_pages -> zap_pages would then UAF.

Remove this, there is no point keeping information about past bugs in
the tests. The first sentence is enough.

> + */
> +#include <test_progs.h>
> +#include <sys/mman.h>
> +#include <sys/wait.h>
> +#include <unistd.h>
> +#include <sys/user.h>
> +#ifndef PAGE_SIZE
> +#define PAGE_SIZE getpagesize()
> +#endif

Use sysconf to get the page size.

> +
> +#include "arena_fork.skel.h"
> +
> +void test_arena_fork(void)
> +{
> +	LIBBPF_OPTS(bpf_test_run_opts, opts);
> +	struct bpf_map_info info =3D {};
> +	__u32 info_len =3D sizeof(info);
> +	struct arena_fork *skel;
> +	size_t arena_sz;
> +	void *arena_addr;
> +	int arena_fd, ret, status;
> +	pid_t pid;
> +
> +	skel =3D arena_fork__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "open_and_load"))
> +		return;
> +
> +	arena_fd =3D bpf_map__fd(skel->maps.arena);
> +
> +	/* libbpf mmaps the arena via initial_value */
> +	arena_addr =3D bpf_map__initial_value(skel->maps.arena, &arena_sz);
> +	if (!ASSERT_OK_PTR(arena_addr, "arena_mmap"))
> +		goto out;
> +
> +	/* Get real arena byte size for munmap */
> +	bpf_map_get_info_by_fd(arena_fd, &info, &info_len);
> +	arena_sz =3D (size_t)info.max_entries * PAGE_SIZE;
> +
> +	/* Allocate 4 pages in the arena via BPF */
> +	ret =3D bpf_prog_test_run_opts(bpf_program__fd(skel->progs.arena_alloc)=
,
> +				     &opts);
> +	if (!ASSERT_OK(ret, "alloc_run") ||
> +	    !ASSERT_OK(opts.retval, "alloc_ret"))
> +		goto out;
> +
> +	/* Fault in a page so zap_pages has work to do */
> +	((char *)arena_addr)[0] =3D 'A';
> +
> +	/* Fork: child inherits the arena VMA */
> +	pid =3D fork();
> +	if (!ASSERT_GE(pid, 0, "fork"))
> +		goto out;
> +
> +	if (pid =3D=3D 0) {
> +		/* Child: parent will unmap first, then we free pages.
> +		 * Without the fix, this triggers UAF in zap_pages.

Again, "the fix" isn't clear. Remove the second sentence.

> +		 */
> +		LIBBPF_OPTS(bpf_test_run_opts, child_opts);
> +		int free_fd =3D bpf_program__fd(skel->progs.arena_free);
> +
> +		usleep(200000); /* let parent munmap first */

This is dependable on vmtest, and we do use usleep in other tests
so I'd say it's a valid use.

> +
> +		ret =3D bpf_prog_test_run_opts(free_fd, &child_opts);
> +		_exit(ret || child_opts.retval);
> +	}
> +
> +	/* Parent: unmap the arena, making vml->vma stale */
> +	munmap(arena_addr, arena_sz);
> +
> +	/* Wait for child -- if kernel UAFs, child will crash/hang */

That's not the case. The test exits with a success for me.

> +	waitpid(pid, &status, 0);
> +	ASSERT_TRUE(WIFEXITED(status), "child_exited");
> +	ASSERT_EQ(WEXITSTATUS(status), 0, "child_exit_code");
> +out:
> +	arena_fork__destroy(skel);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/arena_fork.c b/tools/testi=
ng/selftests/bpf/progs/arena_fork.c
> new file mode 100644
> index 000000000000..b1f8435f1834
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/arena_fork.c
> @@ -0,0 +1,41 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 */

There's no copyright holder here, add one or remove the line it.

> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_arena_common.h"
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_ARENA);
> +	__uint(map_flags, BPF_F_MMAPABLE);
> +	__uint(max_entries, 16); /* number of pages */
> +#ifdef __TARGET_ARCH_arm64
> +	__ulong(map_extra, 0x1ull << 32); /* start of mmap() region */
> +#else
> +	__ulong(map_extra, 0x1ull << 44); /* start of mmap() region */
> +#endif
> +} arena SEC(".maps");
> +
> +void __arena *alloc_addr;
> +
> +SEC("syscall")
> +int arena_alloc(void *ctx)
> +{
> +	void __arena *p;
> +
> +	p =3D bpf_arena_alloc_pages(&arena, NULL, 4, NUMA_NO_NODE, 0);
> +	if (!p)
> +		return 1;
> +	alloc_addr =3D p;
> +	return 0;
> +}
> +
> +SEC("syscall")
> +int arena_free(void *ctx)
> +{
> +	if (!alloc_addr)
> +		return 1;
> +	bpf_arena_free_pages(&arena, alloc_addr, 4);
> +	return 0;
> +}
> +
> +char _license[] SEC("license") =3D "GPL";

