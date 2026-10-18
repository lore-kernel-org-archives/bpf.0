Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8339E175A95
	for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 01:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792287496; cv=none; b=K5rbk++6oF0yRw29Ty/VzVveO/hyNm7XDVsVCashVi3F5zslzdps9u6U8zjHkfJoV6VG++7J8rQcV897ZnD4+DMo27cfT4nGqfK2NOneiN1/DISslxKducPy6r08so5z/2ANw9xhqGu9OViqbQh/piRxDobvo6eTvWKQymHzdqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792287496; c=relaxed/simple;
	bh=MS3W3iQ/d6YPbu5aaGwhaaBO2VIb2J+oXLudON7814w=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=GC5p5VDMBd4D2r/Ksb5btwt0FGX84/Nu/AtUR93UmlYlowuW2cQ1sQRlHJt5NmW1iR1iGiLODnpVPFRYQLrdj8+ZhPRCx3YRA/H3JFS00eqWsTQ3irnNtSs2tL4VK6tsVOd263B3KhjgLtRgAgGRmy25TG4TNbm2X7i8qEQdm/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gcjMk7lO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gcjMk7lO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 353491F000C4;
	Sun, 18 Oct 2026 01:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792287495;
	bh=Iis3ysHIDQRRcqyxUEyPNxOLH7DDGkYokFipffZneNM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=gcjMk7lOdLYgXYktb15Q1ch7d32ZXClav/UdMDbIo7ygyjxv7nvK9rQPkQTSrAD1p
	 LtGwXX3X6SsTjRuEMI9LMtqe/LZWlE3QlkHD8c7QQkM3F/NJ40S/UubWjgbJ+3yGeU
	 +K8mmVgnJ2ZcqUXeCWxN8Z1jHY0dwPEojafVCVK/8dDlY/kJfPSLDMokWFmwaXMvFC
	 1AWOHkbjSXz0hLkWEhqUQK3V7mZ4KBaxgToYqY9gCSV3urz89EtU5Xz37eRMXVS9mc
	 TklSE21osX9DNlo00SfV4XECqXTY84zuP4JpuSEFaLAX96/wnQ8jLJdbgxmTRreSD9
	 9hp6iI7GeqV4Q==
Content-Type: multipart/mixed; boundary="===============3629620460694473961=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <bf338f91821e91b295fb4489600873abad8d7255658c55383e820aeb86c3e4f5@mail.kernel.org>
In-Reply-To: <20261018010246.1643877-5-alexei.starovoitov@gmail.com>
References: <20261018010246.1643877-5-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 4/5] selftests/bpf: Add tests for unwinding via r3
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 18 Oct 2026 01:38:14 +0000 (UTC)

--===============3629620460694473961==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Add tests for unwinding via r3

TL;DR:
- unwind_attach.c: unused attach() on non-x86/arm64 may fail the whole
  selftest build under -Werror
- fmod_ret negative test passes without the new check; error-only assertions
  are weak

> diff --git a/tools/testing/selftests/bpf/prog_tests/unwind_attach.c b/tools/testing/selftests/bpf/prog_tests/unwind_attach.c
> new file mode 100644
> index 000000000000..6927757a15b6
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/unwind_attach.c
> @@ -0,0 +1,67 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <test_progs.h>
> +#include "verifier_unwind.skel.h"
> +#include "unwind_attach.skel.h"
> +
> +/*
> + * A trampoline that calls the subprog and an extension that replaces it don't
> + * keep r3, so only fentry can attach to a subprog that can unwind.
> + */
> +static void attach(int tgt_fd, const char *name, bool ok)
> +{

Will this build on architectures other than x86_64 and aarch64?

attach() is a non-inline static function, but every caller is inside the
#if defined(__x86_64__) || defined(__aarch64__) block in
test_unwind_attach().  On s390x, riscv64, ppc64le, loongarch and the rest,
the #else branch only calls test__skip(), so attach() is defined but never
used.

The selftests build prog_tests/*.c with the flags from Makefile.buildvars:

    COMMON_CFLAGS = -g $(OPT_FLAGS) -rdynamic -std=gnu11 \
              -Wall -Werror -fno-omit-frame-pointer ...

-Wall enables -Wunused-function, so compiling unwind_attach.test.o should
fail there with "'attach' defined but not used
[-Werror=unused-function]", which breaks the test_progs build for the whole
suite.  s390x and riscv64 both have DENYLIST files in the selftests tree, so
they are built.

The skeleton helpers from the two included .skel.h files are static inline
and don't warn, so only attach() is affected.  No later patch in this series
touches this file.

Could attach() move inside the arch #if block, or be marked __maybe_unused?

[ ... ]

> +void test_unwind_attach(void)
> +{
> +#if defined(__x86_64__) || defined(__aarch64__)

[ ... ]

> +	attach(tgt_fd, "fentry_unwind", true);
> +	attach(tgt_fd, "fexit_unwind", false);
> +	attach(tgt_fd, "fmod_ret_unwind", false);
> +	attach(tgt_fd, "freplace_unwind", false);

This isn't a bug, but does the fmod_ret_unwind case test the new restriction?

Every expected failure in attach() is checked only with ASSERT_ERR(err,
name), and bpf_check_attach_target() already rejects BPF_MODIFY_RETURN
against any BPF program target, whether or not the target can unwind:

    } else if (prog->expected_attach_type == BPF_MODIFY_RETURN) {
        if (tgt_prog) {
            module_put(mod);
            bpf_log(log, "can't modify return codes of BPF programs\n");
            return -EINVAL;
        }

So with the new "Only fentry can attach to %s, which can unwind" check the
load returns -EINVAL, and without it the load still returns -EINVAL from the
check above.  The fmod_ret case can't catch a regression in the restriction
described in the commit message.

The fexit and freplace cases do discriminate, since fexit on a BPF subprog
is otherwise allowed and freplace_unwind() matches global_unwinds() in
btf_check_func_type_match().  But they accept any error, so an unrelated
load failure would make them pass too.

fexit_bpf2bpf.c's test_obj_load_failure_common() captures the verifier log
and checks it with ASSERT_HAS_SUBSTR(log_buf, exp_msg, ...).  Could the
negative cases here check for "which can unwind" in the log in the same way,
so each one exercises the new check?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39085585797
--===============3629620460694473961==--
