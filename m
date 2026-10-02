Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67474B1295
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 13:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790948980; cv=none; b=p0Ksr1MJ9Y+S5WeX0BkJR4OKGXLQjybMQV5vVq72f3tyNru8pOg8ft+bD09+xRFI0xHWHoiPtV4cQmpFnyurn8dpR2kNbmJmSlUez/ktlqjykNGV/XZhf98SPoYL2ZmU65p0/rZrrVmwx6r6ulA0dtaD3fYIv6eEtLFtvBSu1Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790948980; c=relaxed/simple;
	bh=5q7E2JN4oR739XJOXbbpwRyKxZn1k+c1MQCNlKM2KYE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=JSjxl+avQQ2Go46QEBxOjg924tad1Z/GifsjuXmQyLjW4auFKxNS+vLCTyD4xExcz/qOB2DGOTyPuZ64Yc7HfxAHHate4i1AKvsaCkR3w19DFWSUkozG3rqNjmCMZWTsmgd7erZkosM9Ta0bAE4JQYIz6J1gd0f4iVPYdRYFxWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kvTAfDgd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvTAfDgd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9F941F00893;
	Fri,  2 Oct 2026 13:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790948978;
	bh=LeNfO/3pRxOh24KYpV9j1NE8pwUX0cKPFMl0PH6bCfE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=kvTAfDgd0cAgAxUIL1p6XDi+6n13pVaJekRkabfQ+0Errnj1VyS1X+NFdIgolqnwZ
	 WCLJ3W1w/by8PAJgzhg3/t92b1lemrOiZu0hyIG+XlYABXruwAW1eI2qoR2bfGmodv
	 mmJDLp2zN8jcAu3m1es6X8aC2mqhA0mp/rkSZW6+svg0EIh8eKEqjmoGvzkiV+eRku
	 3eSCHm6u66T2JpJxf6tEIvzUq2MBanboRA8P3tLUA7jeCpzo4cNTE4hLw9JSWnN3Dz
	 N++Zs/cUpkyEIFO0olXaE5RV1EHipaqqfOhungN99jK/tqp7zWrPDmUF6KPr/JXyLp
	 ++Zz7jcRa1X2g==
Content-Type: multipart/mixed; boundary="===============1287848303079152369=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1fca4874a269a0a5eed6bcb6ee1df64b7c19dbaaf546fe7a4896378fec0b9270@mail.kernel.org>
In-Reply-To: <20261002124714.180012-15-alexei.starovoitov@gmail.com>
References: <20261002124714.180012-15-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v2 14/15] selftests/bpf: Add test for global data in arena
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  2 Oct 2026 13:49:37 +0000 (UTC)

--===============1287848303079152369==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Add test for global data in arena

TL;DR:
- Selftest arena_var_no_map may fail with bpf-gcc or older clang, where
  __arena variables land in .data and open succeeds
- Changelog and a comment misdescribe the kernel-variable test: open fails,
  not load

>     selftests/bpf: Add test for global data in arena
>
>     Load the program that reads and writes .data, .bss and .rodata from
>     the object with .arena.data section. Check that initial values set
>     through the skeleton reach the program and that the values written by
>     the program are seen through the skeleton.
>
>     Also check:
>     - alignment of a section.
>     - pointers to data and to a const string that are stored in data and
>       in read-only data, next to a pointer to a function that callx uses.
>     - bpf_strncmp() with a string literal, bpf_printk() and BPF_SNPRINTF().
>     - an object that has an arena map and __arena variables.
>     - the load fails when a pointer in data points to a section that is
>       not in arena or to a variable of the kernel.
>     - the load fails when there are pointers in data and the arena is
>       pinned or reused.
>     - the open fails when there are __arena variables and no arena map.
>
>     Signed-off-by: Alexei Starovoitov <ast@kernel.org>

The changelog says "the load fails when a pointer in data points to ... a
variable of the kernel."  Is that what the test does?

data_in_arena_extern.c keeps "const void *kp = &bpf_prog_active;" in .data,
and test_ptr_to_extern() checks the failure at open time:

> diff --git a/tools/testing/selftests/bpf/prog_tests/data_in_arena.c b/tools/testing/selftests/bpf/prog_tests/data_in_arena.c
> new file mode 100644
> index 000000000000..86dc6798bbde
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/data_in_arena.c
> @@ -0,0 +1,191 @@

[ ... ]

> +/* So does a pointer to a variable of the kernel. There is no skeleton: the open fails. */
> +static void test_ptr_to_extern(void)
> +{
> +	struct bpf_object *obj;
> +
> +	obj = bpf_object__open_file("./data_in_arena_extern.bpf.o", NULL);
> +	if (!ASSERT_ERR_PTR(obj, "open"))
> +		bpf_object__close(obj);
> +}

With .arena.data present, bpf_object__open_file() runs
bpf_object__collect_relos() -> bpf_object__collect_data_relos() ->
bpf_object__collect_data_ptr(), which rejects the SHN_UNDEF target of the
relocation with -LIBBPF_ERRNO__RELOC.  So it is the open that fails here,
not the load, and this is also why data_in_arena_extern.c had to be added to
SKEL_BLACKLIST.

Could the kernel-variable item in the changelog be moved next to "the open
fails when there are __arena variables and no arena map"?

Also, the comment above test_ptr_to_extern() starts with "So does a pointer
to a variable of the kernel" and continues with "the open fails".  It follows
a comment about a failing load, so it reads as self-contradicting.  Could it
be reworded so it doesn't start with "So does"?

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/data_in_arena_nomap.c b/tools/testing/selftests/bpf/progs/data_in_arena_nomap.c
> new file mode 100644
> index 000000000000..da27a8f10d6f
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/data_in_arena_nomap.c
> @@ -0,0 +1,20 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_arena_common.h"
> +
> +/* global data of the object is in arena */
> +char data_in_arena SEC(".arena.data");
> +
> +int counter = 5;
> +/* needs an arena map that is declared. The one that libbpf creates won't do. */
> +int __arena avar = 11;

Does the arena_var_no_map subtest depend on the compiler here?

When __BPF_FEATURE_ADDR_SPACE_CAST is not defined (bpf-gcc, which the
test_progs-bpf_gcc runner uses, or older clang), bpf_arena_common.h defines
__arena as only the btf_type_tag attribute:

    #else
    #define __arena __attribute__((btf_type_tag("arena")))
    #define __arena_global SEC(".addr_space.1")

In that case "int __arena avar = 11;" lands in plain .data and the object
has no .addr_space.1 section, so obj->efile.arena_data is NULL.
bpf_object__init_arena_data() then takes the branch where libbpf creates
the arena itself, instead of returning -ENOENT:

    if (obj->arena_map_idx < 0) {
        if (obj->efile.arena_data) {
            pr_warn(... "to use global __arena variables the ARENA map should be explicitly declared" ...);
            return -ENOENT;
        }
        map = bpf_object__add_map(obj);
        ...

bpf_object__open_file("./data_in_arena_nomap.bpf.o") would then succeed and
ASSERT_ERR_PTR(obj, "open") in test_arena_var_no_map() would fail.

data_in_arena_decl.c in this same patch handles that case with
"#if defined(__BPF_FEATURE_ADDR_SPACE_CAST) int __arena avar = 11; #else int
avar = 11; #endif", and linked_arena1.c and linked_arena2.c use
__arena_global, which is SEC(".addr_space.1") when the feature is absent.

Would "int __arena_global avar = 11;" work here so the variable stays in
.addr_space.1 with any compiler?  Alternatively, could the subtest be
skipped when the feature is missing?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37011822731
--===============1287848303079152369==--
