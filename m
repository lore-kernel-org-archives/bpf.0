Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2318247D459
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 11:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788522440; cv=none; b=ulrfYZrEtARc3YB+UuUqXP+EdIUPOIbmuD0rFBpU54CLFsFyg3TpSCDGBGJRZZcDsZzC9aBbYUjt4lzwSXpKQx3XR/6Q/f+JoF/qfskf9aDGEQ8KFgc6u032kKPxoOOMQoYRUZivZnvhvTTb8nHREnfcBxdCYlcRMg3oEI/qikk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788522440; c=relaxed/simple;
	bh=s4pyGZDLiMw1YOkq6ScewuuspG12Z3tXwunF2G7zYws=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Yp7HtZGbMYb8IRGRz+nSJ8K4VfCXPdb40zYtGrwBMniwrkgd1CqJsXIojmAAcZAOd2P2trHfpWaGVbXM7FOvPunhB0uF8BGhWdE51NwgiyB3lGR49w66/9hq7pK5RPYZS6RIm8X8gQVysbtH20KwNnjk6eQlsIY/aE1xlUZJYa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nc/TSj4v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nc/TSj4v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52A6F1F00A3E;
	Fri,  4 Sep 2026 11:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788522439;
	bh=gLcDFRw8CYFLuQfHDT+0WGfwCdlMlDp+ckMrcSFxVFc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Nc/TSj4vSZwa/Dil2Sv/SLJUgni5X03GyJ7vgqqUJ2ftvXgxDbNnyYiNYjgO1iS/m
	 i3ydXWYjGSH3f/fPwAHoWDMkIIxq23fwN+kocNucesqOqyNMGeMGZlGKzJw6X2WCVr
	 l9ougLp4bD1NyOor1AARLcYsSF5pVsYHMykBLvfHr0TrWKRZSWASNRl7lCClGFShGF
	 hXmpjkZ6PqWlRzjF4lQHvoV8thqhwAHtfoAa6n2axiDJ0MUUlXTavizlLCqLq+y21v
	 Hl1Xk+ZsdlqsjV5KAsj/Ib36KlmYedgbhDDIhMOsZjoA8q55wnTGsIJNUULKcqiWL9
	 L4hjw5EtGeSvQ==
Content-Type: multipart/mixed; boundary="===============1012269462484494197=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6745520ee90c5c85f1940bcb311d98e6f657ff4ae4096a471bcc9300cfe796bf@mail.kernel.org>
In-Reply-To: <20260904104203.345917-3-memxor@gmail.com>
References: <20260904104203.345917-3-memxor@gmail.com>
Subject: Re: [PATCH bpf v1 2/8] selftests/bpf: Test timer field on recycled rhtab element
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,npc@anthropic.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  4 Sep 2026 11:47:18 +0000 (UTC)

--===============1012269462484494197==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/rhash_timer.c b/tools/testing/selftests/bpf/prog_tests/rhash_timer.c
> new file mode 100644
> index 0000000000000..3aad9fc02e063
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/rhash_timer.c
> @@ -0,0 +1,141 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#define _GNU_SOURCE
> +#include <sched.h>
> +
> +#include <test_progs.h>
> +#include "rhash_timer.skel.h"

A subsystem pattern flags this as potentially concerning: two brand-new
standalone selftest files are added for one narrow internal rhtab code
path - preservation of the BPF_TIMER special field when a deleted rhtab
element's bpf_mem_alloc unit is recycled by an insert.

tools/testing/selftests/bpf/prog_tests/rhash.c (183 lines, subtests
rhash_run, rhash_map_extra_presize, rhash_map_extra_too_big,
rhash_iter_test) and tools/testing/selftests/bpf/progs/rhash.c (248
lines, 7 SEC("syscall") programs) already exist in the same two
directories and cover BPF_MAP_TYPE_RHASH behaviour generally, including
map creation, update/lookup/delete and iteration.

Same-series commit e5013fee53d73 adds rhtab special-field (kptr)
coverage as new cases inside tools/testing/selftests/bpf/prog_tests/
rhash.c and tools/testing/selftests/bpf/progs/rhash.c rather than as a
new file, which is direct evidence of the convention this change departs
from.

Would adding a fifth subtest to test_rhash() plus one more SEC("syscall")
pair in progs/rhash.c give the same coverage without a new test binary
entry, a second skeleton and a duplicated map definition?

[ ... ]

> +	for (attempt = 0; attempt < MAX_ATTEMPTS; attempt++) {
> +		err = run_prog(arm_fd, &opts);
> +		if (err) {
> +			ASSERT_OK(err, "arm_deleted_timer");
> +			goto out;
> +		}
> +		if (skel->bss->armed != attempt + 1) {
> +			ASSERT_EQ(skel->bss->armed, attempt + 1, "armed");
> +			goto out;
> +		}
> +		if (skel->bss->timer_init_err) {
> +			ASSERT_OK(skel->bss->timer_init_err, "timer_init_err");
> +			goto out;
> +		}
> +		if (skel->bss->timer_set_callback_err) {
> +			ASSERT_OK(skel->bss->timer_set_callback_err,
> +				  "timer_set_callback_err");
> +			goto out;
> +		}
> +		if (skel->bss->timer_start_err) {
> +			ASSERT_OK(skel->bss->timer_start_err, "timer_start_err");
> +			goto out;
> +		}

This isn't a bug, but can the three diagnostic checks for timer_init_err,
timer_set_callback_err and timer_start_err ever fire?

The armed counter check precedes them and catches every failure that sets
those variables. In progs/rhash_timer.c:arm_timer_cb() each of the three
error paths records the errno and returns 1 without running
__sync_fetch_and_add(&armed, 1), so any of those failures leaves armed
behind attempt + 1, the ASSERT_EQ(skel->bss->armed, attempt + 1, "armed")
fails, and the function goes to out before reaching the three errno
checks.

Armed can never catch up in a later iteration either, since it increments
at most once per arm run. The net effect is that the three per-helper
errno variables - the whole point of which is a precise failure message -
are unreachable, and a bpf_timer_init() failure reports the uninformative
"armed 3 != 4".

The analogous timer_cancel_err check later in the loop is reachable,
because cancel_timer_cb() records the errno without incrementing
cancelled and the test checks timer_cancel_err before it checks
cancelled.

Would checking the three errno variables before the armed count (as is
already done for timer_cancel_err vs cancelled) make the diagnostic
messages reachable?

[ ... ]

This isn't a bug, but inside the loop the same three-line shape is
repeated nine times:

	if (cond) {
		ASSERT_x(...);
		goto out;
	}

instead of the idiomatic one-liner:

	if (!ASSERT_x(...))
		goto out;

The occurrences are in the loop body where the test checks err,
skel->bss->armed, timer_init_err, timer_set_callback_err, timer_start_err,
kern_sync_rcu, update_timer_map, run_prog for cancel, and timer_cancel_err.

The same function already uses the idiomatic form six times immediately
above (after pin_to_first_cpu, after open_and_load, for the three fd
assignments, and after seed_timer_map), so the file is internally
inconsistent and the loop body is roughly twice as long as it needs to be.

Effectively all of tools/testing/selftests/bpf/prog_tests/ uses
if (!ASSERT_x(...)) goto/return, including prog_tests/rhash.c which this
test sits beside. Could the nine blocks be collapsed to
if (!ASSERT_x(...)) goto out?

[ ... ]

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33865340224
--===============1012269462484494197==--
