Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDA93D16E6
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 23:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784331404; cv=none; b=Lqh9zciYYMLusOoKqFezxngK39dIU/8eZd4GkDapK+C8aAAzqFNj9WDldS6iRC201mdXmtMqxf7Dh+PMU5vWBHpNT1lwMwdGlUFdXdEC4/i1uIg6K9mtDc4QwDcdWtwUCLfQx8VMGxj/Dx56HkR850Xh/OpZkXPycNEwluCcaPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784331404; c=relaxed/simple;
	bh=ncMj9L40lXzcjGh0MxGhNsLxc+/SuDoonZNw5sMS7TE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=RxxRRxhPNpYxTp0dEHhIVKMIdiwtxKppTFWR8A2nd8yP8CEsXfjq2+9exvcCvPPVjjYYGwpQAOBgwudYbNIGWYfKt/HsAPpFa5ie2r9DCAP+UQLrLe5SaNNKlAO0REU6J3mHhUP3zrYQC/jlTqbTuaeEfxkXOOUCubaCPpYk8JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=ozZ4oEGV; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="ozZ4oEGV"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so4497408a91.2
        for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 16:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1784331388; x=1784936188; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+KZS1oc+gl1cOm6iebRo3jlVRcyWqmkc0GoGAV0BGhI=;
        b=ozZ4oEGVRGSwtpoWJXHtIawpt1C6XmEGrkCSUFWfZzpJBGIlWPM4lTa1BR28VcXJll
         Lc6+py7qRbUD90ruEy0Brf+cQEjE8NQ+dOyaxmILO1BMWJCPnqTKGzW1fmNzM3NHCubH
         lQMNk6dsvVt0QOyg3263kiUZxm/0wXmg0FzXW9LGJhTv841ZAT58lnLj24C1zlWTWKAF
         bHmRdPqpxpjzehDYORor2QZoin28ZWe9brxbudFdeseRJW59sIvkX7btPEWO5yV8VqM6
         I7sMj+hQRhviJbTgPmFDcO+Exrv6e7hgLs75rCrzvE5UANMAsnd5qZsz/+JPBJKf8POz
         ipaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784331388; x=1784936188;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+KZS1oc+gl1cOm6iebRo3jlVRcyWqmkc0GoGAV0BGhI=;
        b=Tk1JLp7eKz7VsaocoMUUylh9ATD2u5pHpIDmicJw4EsFrOwm+1/4Ya9YW1BVQP46yW
         5tPh8kYjdo19Jg5pB8ynWzbTGczPkOg7kXRMOhedWUFAvFZiXeaeGB4ydRLDLcLE5wWL
         cfRGWZgwc2RpeMHq8NlkESv5o2YAiAOgDTwfUDFo9SilaJ8OG8vVp6W/2RwzNGPGi5Zc
         XkXjMXDJPGvTQK38EmmZk4WX4jrRYUGVm356nmXGW8PxBkwtyvRJ1K1Y1tjyVWtvnNCy
         +FT6Z2mmTHUlESNpYAtb4AqXyiwuDX1BKbBobgaZqt5Z6u9jZ7MRDsOFwMQhpuTNkShy
         xcMA==
X-Forwarded-Encrypted: i=1; AHgh+Roh8Ovsk7JhLKwmDrYKmZhDSP/NlPYJ6UMtYWSsbTD7CISArojqVZAYAkUVsoT/06hooT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YywC7cXkDih9qLQ2b13gWCoy/jvyWnOkzpyXZfRh/IZVJNFVyw9
	yymjU9I5G27fBFW6lMIjf/yAGDdXlFcveR0CmXSIygcn97wYdGoEe4+wzxf1qiHhyJI=
X-Gm-Gg: AfdE7cnmb9XeBKPWxEkpGWm3ztHAH5/FnSj+8+jAKdc40v/ub9/MkuNEzbQ6adP+4pn
	ah+d7rjb3OGdhlE9Ce8TnD8RBUlOUU2lfUGJ21elwYAPZUL8m21RrcdkcQFLY/4krUHv3ExoXN8
	YwzFaYZBdap934Wcp/qAxhbHifzKgiXTpwQXH7Nd8W8eZdn8xbuJ9s0Wx9TIj7PhxiFt8/bKj2I
	Q9lrfpb82++S/r0xRiUIZP2lCEQ0WBieAFDF9AYzRDq995y+1O+fplxUY7YAW/V9H9rDF91e6Yt
	XVOD4ijOEvkWCfb+RU+X1ROO4D+qFOSbYlkGxncVsYslm88mH2WEB/tlXFQcVTfzOMgz7dz/v7z
	WJ2Bn8YZhGnBzmIu77FVkEEg0v3ZTq5shtrgNZQnRtQ7xUJhqshOOAXcdPpw=
X-Received: by 2002:a17:90b:3b48:b0:37f:9cdf:f03d with SMTP id 98e67ed59e1d1-38e4b540a90mr4834931a91.32.1784331388284;
        Fri, 17 Jul 2026 16:36:28 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::f5f9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13ce2cbb6e8sm8278622c88.9.2026.07.17.16.36.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2026 16:36:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Jul 2026 19:36:25 -0400
Message-Id: <DK18OQD8NUIY.DCLKET294PNM@etsalapatis.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa"
 <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Shuah Khan"
 <shuah@kernel.org>, "Woojin Ji" <random6.xyz@gmail.com>, "Puranjay Mohan"
 <puranjay@kernel.org>, "Saket Kumar Bhaskar" <skb99@linux.ibm.com>, "Ihor
 Solodrai" <ihor.solodrai@linux.dev>, <linux-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 4/4] selftests/bpf: Add tests for memory
 usage for arena
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260717114117.350851-1-jiayuan.chen@linux.dev>
 <20260717114117.350851-5-jiayuan.chen@linux.dev>
In-Reply-To: <20260717114117.350851-5-jiayuan.chen@linux.dev>

On Fri Jul 17, 2026 at 7:37 AM EDT, Jiayuan Chen wrote:
> Allocate and free arena pages, both from BPF and via user-space fault-in,
> and check that the map's memlock in fdinfo tracks the number of pages tha=
t
> are actually populated.
>
> Like the other arena tests it runs serially.
>
> test:
>   ./test_progs -a arena_mem_usage
>   #5       arena_mem_usage:OK
>   Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

The Sashiko nit is worth addressing, but overall looks fine.

> ---
>  .../bpf/prog_tests/arena_mem_usage.c          | 122 ++++++++++++++++++
>  .../selftests/bpf/progs/arena_mem_usage.c     |  40 ++++++
>  2 files changed, 162 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_mem_usag=
e.c
>  create mode 100644 tools/testing/selftests/bpf/progs/arena_mem_usage.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/arena_mem_usage.c b/t=
ools/testing/selftests/bpf/prog_tests/arena_mem_usage.c
> new file mode 100644
> index 000000000000..14c2d1a1d673
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/arena_mem_usage.c
> @@ -0,0 +1,122 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <test_progs.h>
> +#include <sys/user.h>
> +#ifndef PAGE_SIZE /* on some archs it comes in sys/user.h */
> +#include <unistd.h>
> +#define PAGE_SIZE getpagesize()
> +#endif
> +
> +#include "arena_mem_usage.skel.h"
> +
> +/*
> + * arena_map_mem_usage() is surfaced to user space through the map's
> + * /proc/<pid>/fdinfo/<fd> "memlock:" line (the same value bpftool map s=
how
> + * prints). Read it directly so the test has no external dependency.
> + */
> +static long map_memlock(int map_fd)
> +{
> +	char path[64], line[128];
> +	long memlock =3D -1;
> +	FILE *f;
> +
> +	snprintf(path, sizeof(path), "/proc/self/fdinfo/%d", map_fd);
> +	f =3D fopen(path, "r");
> +	if (!ASSERT_OK_PTR(f, "open_fdinfo"))
> +		return -1;
> +	while (fgets(line, sizeof(line), f)) {
> +		if (sscanf(line, "memlock:\t%ld", &memlock) =3D=3D 1)
> +			break;
> +	}
> +	fclose(f);
> +	ASSERT_NEQ(memlock, -1, "parse_memlock");
> +	return memlock;
> +}
> +
> +static int run(struct bpf_program *prog, const char *name)
> +{
> +	LIBBPF_OPTS(bpf_test_run_opts, opts);
> +	int err =3D bpf_prog_test_run_opts(bpf_program__fd(prog), &opts);
> +
> +	if (!ASSERT_OK(err, name))
> +		return -1;
> +	if (!ASSERT_OK(opts.retval, name))
> +		return -1;
> +	return 0;
> +}
> +
> +void serial_test_arena_mem_usage(void)
> +{
> +	struct arena_mem_usage *skel;
> +	const long ps =3D PAGE_SIZE;
> +	char *base;
> +	size_t sz;
> +	int fd, i;
> +
> +	skel =3D arena_mem_usage__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "open_load"))
> +		return;
> +	fd =3D bpf_map__fd(skel->maps.arena);
> +
> +	/* Fresh arena: no data pages, and the scratch page is not counted. */
> +	ASSERT_EQ(map_memlock(fd), 0, "initial");
> +
> +	/* BPF-side allocation of 17 pages. */
> +	skel->bss->alloc_cnt =3D 17;
> +	if (run(skel->progs.alloc, "alloc"))
> +		goto out;
> +	/*
> +	 * A NULL ptr means bpf_arena_alloc_pages() itself failed (e.g. the hos=
t
> +	 * is under memory pressure), not a miscount -- flag it distinctly so a
> +	 * red CI run is not mistaken for a counting bug.
> +	 */
> +	if (!ASSERT_OK_PTR(skel->bss->ptr, "arena_alloc_pages"))
> +		goto out;
> +	ASSERT_EQ(map_memlock(fd), 17 * ps, "after_alloc");
> +
> +	/* Free a single page (arena_free_pages page_cnt=3D=3D1 path). */
> +	skel->bss->free_byte_off =3D 0;
> +	skel->bss->free_cnt =3D 1;
> +	if (run(skel->progs.free_pages, "free_one"))
> +		goto out;
> +	ASSERT_EQ(map_memlock(fd), 16 * ps, "after_free_one");
> +
> +	/* Free ten pages in one call (bulk path); only the freed pages count. =
*/
> +	skel->bss->free_byte_off =3D 1 * ps;
> +	skel->bss->free_cnt =3D 10;
> +	if (run(skel->progs.free_pages, "free_bulk"))
> +		goto out;
> +	ASSERT_EQ(map_memlock(fd), 6 * ps, "after_free_bulk");
> +
> +	/* Free the remaining six -> arena empty again. */
> +	skel->bss->free_byte_off =3D 11 * ps;
> +	skel->bss->free_cnt =3D 6;
> +	if (run(skel->progs.free_pages, "free_rest"))
> +		goto out;
> +	ASSERT_EQ(map_memlock(fd), 0, "after_free_rest");
> +
> +	/*
> +	 * User-space fault-in: touching unallocated arena pages allocates them
> +	 * through arena_vm_fault(). libbpf mmap()s the arena at map_extra duri=
ng
> +	 * load, so bpf_map__initial_value() hands back that base.
> +	 */
> +	base =3D bpf_map__initial_value(skel->maps.arena, &sz);
> +	if (!ASSERT_OK_PTR(base, "arena_base"))
> +		goto out;
> +	for (i =3D 0; i < 8; i++)
> +		base[i * ps] =3D 1;
> +	ASSERT_EQ(map_memlock(fd), 8 * ps, "after_faultin");
> +
> +	/*
> +	 * Free the faulted-in pages from BPF. They are mapped into the user vm=
a
> +	 * (elevated refcount), so this also exercises the zap path.
> +	 */
> +	skel->bss->ptr =3D base;
> +	skel->bss->free_byte_off =3D 0;
> +	skel->bss->free_cnt =3D 8;
> +	if (run(skel->progs.free_pages, "free_faulted"))
> +		goto out;
> +	ASSERT_EQ(map_memlock(fd), 0, "after_free_faulted");
> +out:
> +	arena_mem_usage__destroy(skel);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/arena_mem_usage.c b/tools/=
testing/selftests/bpf/progs/arena_mem_usage.c
> new file mode 100644
> index 000000000000..455ecd669a5a
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/arena_mem_usage.c
> @@ -0,0 +1,40 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_arena_common.h"
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_ARENA);
> +	__uint(map_flags, BPF_F_MMAPABLE);
> +	__uint(max_entries, 1000); /* number of pages */
> +#ifdef __TARGET_ARCH_arm64
> +	__ulong(map_extra, 0x1ull << 32); /* start of mmap() region */
> +#else
> +	__ulong(map_extra, 0x1ull << 44); /* start of mmap() region */
> +#endif
> +} arena SEC(".maps");
> +
> +void __arena *ptr;
> +int alloc_cnt;		/* in:  pages to allocate */
> +long free_byte_off;	/* in:  byte offset within ptr to start freeing */
> +int free_cnt;		/* in:  pages to free */
> +
> +SEC("syscall")
> +int alloc(void *ctx)
> +{
> +	ptr =3D bpf_arena_alloc_pages(&arena, NULL, alloc_cnt, NUMA_NO_NODE, 0)=
;
> +	/* Success/failure is checked from user space via skel->bss->ptr. */
> +	return 0;
> +}
> +
> +SEC("syscall")
> +int free_pages(void *ctx)
> +{
> +	if (!ptr)
> +		return 1;
> +	bpf_arena_free_pages(&arena, (char __arena *)ptr + free_byte_off, free_=
cnt);
> +	return 0;
> +}
> +
> +char _license[] SEC("license") =3D "GPL";

