Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF103F3288;
	Mon, 24 Aug 2026 10:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787566725; cv=none; b=SfQ+7x/jeq1Z/L3E8EVFXewSYQQx2DCfAbaMrvRKub48qpJUiJqsJQu4E6OdeHsO2ARA3KVzJUrNom/gaVLFBl+Owv2Uf3wfHxH/vS9NQLFYE+yg0/sQxsd6Us56JDfFAu2ytWQ43UAISEXG6lVmNH6MuYlYKjj9a1Q5b31NNd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787566725; c=relaxed/simple;
	bh=8GIhY6ChDBEehkhWNqytYkaTSt0wJ4ExfN4jgPKFXQs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=b5ERrJ1Lni1FQSgckCk7efPxcCrY7ql6c3GnCZYJmsjbw7Wg713gi9H3nU9jzodaPawa7S10w8YD57h1KOA/KzDhs+P0nDfj7gTJ2JG1VgPNW55NA52gLWC5C8wqjcpWePft/hhN4GoWOLs/I/MacOUcWZe4ra9PDe3DUaEvulY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G80pTPbt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G80pTPbt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 488F61F00A3A;
	Mon, 24 Aug 2026 10:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787566723;
	bh=tCVy6tO25b1C0EBMahBMXTxY265+oZLsyi3tsJ1HWiw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=G80pTPbt24dmJxKUm1lLBKABnx2Hz6gfYAPAunMLZwYbWrBb6EcgVTfBAc9vfQm91
	 zuLwnEbZOi6Tq53LaWnXTg7EPw8Iub9X12P4mpFpxgdSBeI9Vojif4aIP87ast7nvO
	 Afxu5T0ry2ZP3QhSEk6BByFIrX+30UT0lpBzu/il118Ee94o3f9XtmZhFCje+tWyLd
	 vEHRfaD6KwOYT6Dz/NeaLJRFBzqK63dAU1ZK9JbyZri940rglJ6/6mye91daooMvc2
	 Ln5KD+rdKBoLuZ8FCD1tEdxNEJjlRSxScP+fIEIF0CCBlvg+VWxiwDmzvMUhdePh4Q
	 KF4XAp4RSnvfQ==
Content-Type: multipart/mixed; boundary="===============9062433700612394963=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <df25bcf177930345988034cd7ccf4c7f11036b7aad52f98262b39a7c34e7c3be@mail.kernel.org>
In-Reply-To: <20260824093122.362135-5-jiayuan.chen@linux.dev>
References: <20260824093122.362135-5-jiayuan.chen@linux.dev>
Subject: Re: [PATCH bpf-next v5 4/4] selftests/bpf: Add a test for arena fault-in under memory.max
From: bot+bpf-ci@kernel.org
To: jiayuan.chen@linux.dev,bpf@vger.kernel.org
Cc: jiayuan.chen@linux.dev,emil@etsalapatis.com,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,ihor.solodrai@linux.dev,shuah@kernel.org,bigeasy@linutronix.de,clrkwllms@kernel.org,rostedt@goodmis.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-rt-devel@lists.linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 24 Aug 2026 10:18:43 +0000 (UTC)

--===============9062433700612394963==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/arena_memcg.c b/tools/testing/selftests/bpf/prog_tests/arena_memcg.c
> new file mode 100644
> index 000000000000..c57b98494cfa
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/arena_memcg.c
> @@ -0,0 +1,158 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <test_progs.h>
> +#include <fcntl.h>
> +#include <signal.h>
> +#include <sys/mman.h>
> +#include <sys/wait.h>
> +#include <unistd.h>
> +#include <sys/user.h>
> +#ifndef PAGE_SIZE /* on some archs it comes in sys/user.h */
> +#include <unistd.h>
> +#define PAGE_SIZE getpagesize()
> +#endif

This isn't a bug, but are fcntl.h, signal.h and sys/mman.h needed here?
Nothing in the file appears to use open()/O_* flags, signal APIs (SIGSEGV
and SIGKILL appear only in comments, and WIFSIGNALED comes from
sys/wait.h), or mmap()/PROT_*/MAP_* constants.

Also, since unistd.h is already included above, could the copy inside the
PAGE_SIZE block be dropped?

> +
> +#include "cgroup_helpers.h"
> +#include "arena_memcg.skel.h"

[ ... ]

> +void serial_test_arena_memcg(void)
> +{

A subsystem pattern flags this as potentially concerning: a new standalone
test file is added to prog_tests/ for user-space arena fault-in, while
prog_tests/arena_mem_usage.c in the same directory already exercises that
same interface. arena_mem_usage.c's 'User-space fault-in' block does
exactly the same thing this test's inner loop does:

  base = bpf_map__initial_value(skel->maps.arena, &sz);
  ...
  for (i = 0; i < 8; i++)
          base[i * ps] = 1;

Both files are serial_ tests, both duplicate the same PAGE_SIZE preamble,
the same page-size local, and the same bpf_map__initial_value() /
base[i * ps] = 1 fault-in idiom, and progs/arena_memcg.c's map stanza is
byte-identical to progs/arena_mem_usage.c's apart from max_entries. The
question is whether this belongs as an additional case or subtest in the
existing arena fault-in test rather than a new binary-level test with its
own setup.

On the other hand, the two tests assert different behaviour, not a narrow
variant of one behaviour: arena_mem_usage.c asserts the memlock accounting
value after fault-in, while this test asserts that hitting memory.max
during fault-in produces a memcg OOM kill rather than a SIGSEGV on a valid
address. The new test also needs a harness the existing one does not have:
setup_cgroup_environment(), a cgroup created and joined before skeleton
load so the map is charged to the right memcg, a forked child (the arena
vma is VM_DONTCOPY and the parent must stay outside the limit so the memcg
OOM cannot pick test_progs), and exit-code-based error reporting because
ASSERT_* does not cross fork(). Folding that into arena_mem_usage.c would
put every one of its existing assertions behind a fork and a memory limit.

Is the separate file the right call here, or should this be integrated
into the existing test?

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/arena_memcg.c b/tools/testing/selftests/bpf/progs/arena_memcg.c
> new file mode 100644
> index 000000000000..88259cfea06b
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/arena_memcg.c
> @@ -0,0 +1,24 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_arena_common.h"
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_ARENA);
> +	__uint(map_flags, BPF_F_MMAPABLE);
> +	__uint(max_entries, 50000); /* number of pages */
> +#ifdef __TARGET_ARCH_arm64
> +	__ulong(map_extra, 0x1ull << 32); /* start of mmap() region */
> +#else
> +	__ulong(map_extra, 0x1ull << 44); /* start of mmap() region */
> +#endif
> +} arena SEC(".maps");
> +
> +SEC("syscall")
> +int noop(void *ctx)
> +{
> +	return 0;
> +}

This isn't a bug, but is the noop program load-bearing here - does the
object need at least one program for the skeleton/load path - or could
progs/arena_memcg.c be just the arena map definition? The test only calls
arena_memcg__open_and_load() and then works through bpf_map__initial_value()
/ bpf_map__max_entries() on maps.arena, so cskel->progs.noop is never
referenced.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32713810092
--===============9062433700612394963==--
