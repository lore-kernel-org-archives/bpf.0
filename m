Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9601837A493
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 02:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790042507; cv=none; b=NB8L+8R+AV/MSCTxuZwxeKhC/4L6tAeCxYi68Vqs/8U9lxY5FZoplNz99ERMUXVkRqqLbKtqnzEuSP+Cf0I6Ve/n62cPEYwoELbO9MF80TDMT/oTN1q02cT6mUd0D1S+a/Mh6giG7ZyueJL3k8ZCbUNQWVSKZ8oNpllbHxctJ8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790042507; c=relaxed/simple;
	bh=kJmuVm4r1/ufIhULDGb/EYSrvR9v37XwOQbniJaCOiI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=TuIA/iOsYmjxRAUywz3E+uq6SOE2tmlxqAIvZ7ohvuW46dS6aUUjDZsA6Fcp2t/5ROCBR8DLo+uqkL9sJgnt3Zpf0auEfHIuvvqT9XSjEAnLdTuVpMsWxYHqo1LMmsxuCQncMyJlXhRJiC6l/YhblvfGbzhI7iTk0vrWpP9DBXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D3JjsPuI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D3JjsPuI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D51771F00893;
	Tue, 22 Sep 2026 02:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790042505;
	bh=2ScDJ2hUOSuDpGKOi4PLCAApjppK/bIXlY21M5rJWeU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=D3JjsPuIElvYk7403LfqDa8HS7TspJjsdSJxKEzKNJZD8R3D3Anr+8HvJZpjCptTe
	 cio+Y5x6pZOi1rjWcSm/v87w3xR04uBaO+BQ+Tptko+svNOIhLkjj4ApBFQw1FTzrm
	 /8FQCcIrqHOdYMnCOYAAHBsXpI3jwxLcJIXB5cI8K1M9ZdRoKACXw+UfKBb03jgt20
	 YvsP1hS2WAGankHyod82I6hgOH7g6nQmfA2EtEtbzQ76rm4n5aGgAnPZV2324Tv/tZ
	 W6yK9ffYt0evVVJuCmLZEre9yYYz8/c6jtcJN9g4JIAVaV+muks15ri25RSJIiLPtv
	 WW99Tmu45GkhQ==
Content-Type: multipart/mixed; boundary="===============2361510294543702674=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ae4e7d74d598b85321b01db812d1cf52fe4267205a0d8321bb4c4324786ec237@mail.kernel.org>
In-Reply-To: <20260922011323.1298619-17-alexei.starovoitov@gmail.com>
References: <20260922011323.1298619-17-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 16/17] selftests/bpf: Add tests for callx through pointers in read-only data
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,a.s.protopopov@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 22 Sep 2026 02:01:43 +0000 (UTC)

--===============2361510294543702674==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/Makefile.skel b/tools/testing/selftests/bpf/Makefile.skel
> index 580d1d82c186..3d92cdca62ed 100644
> --- a/tools/testing/selftests/bpf/Makefile.skel
> +++ b/tools/testing/selftests/bpf/Makefile.skel
> @@ -33,7 +33,7 @@ LINKED_SKELS := test_static_linked.skel.h linked_funcs.skel.h		\
>  LSKELS := fexit_sleep.c trace_printk.c trace_vprintk.c map_ptr_kern.c 	\
>  	core_kern.c core_kern_overflow.c test_ringbuf.c			\
>  	test_ringbuf_n.c test_ringbuf_map_key.c test_ringbuf_write.c    \
> -	test_ringbuf_overwrite.c
> +	test_ringbuf_overwrite.c callx_rodata.c
>
>  LSKELS_SIGNED := fentry_test.c fexit_test.c atomics.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/callx_func_ptr_map.c b/tools/testing/selftests/bpf/prog_tests/callx_func_ptr_map.c
> new file mode 100644
> index 000000000000..19f96792df5d
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/callx_func_ptr_map.c
> @@ -0,0 +1,192 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * The kernel replaces the offsets of functions in a frozen read-only map with
> + * their addresses when the program is loaded. The program has to be the only
> + * user of the map, and no other program can use the map after that.
> + */
> +#include <test_progs.h>
> +#include <linux/filter.h>
> +#include <bpf/btf.h>
> +
> +#if defined(__x86_64__) || defined(__aarch64__)

[ ... ]

> +	int_id = btf__add_int(btf, "int", 4, BTF_INT_SIGNED);
> +	proto_id = btf__add_func_proto(btf, int_id);
> +	func_info[0].insn_off = 0;
> +	func_info[0].type_id = btf__add_func(btf, "main_prog", BTF_FUNC_GLOBAL, proto_id);
> +	func_info[1].insn_off = CALLEE_INSN;
> +	func_info[1].type_id = btf__add_func(btf, "add1", BTF_FUNC_STATIC, proto_id);
> +	if (!ASSERT_GT(func_info[1].type_id, 0, "btf_add_func") ||

Can this assertion fail? func_info[1].type_id is __u32 (from struct
bpf_func_info in include/uapi/linux/bpf.h), so when btf__add_func() returns
-EINVAL and that gets stored in the u32 field it becomes 4294967274, which
compares greater than 0. Every error value passes this check; the test
would fail later at btf__load_into_kernel() instead.

> +	    !ASSERT_OK(btf__load_into_kernel(btf), "btf_load"))
> +		goto out;
> +	btf_fd = btf__fd(btf);
> +
> +	/*
> +	 * Another program relies on what the map has: it's verified with
> +	 * the data folded into constants. Pointers to functions are not looked
> +	 * for in such map.
> +	 */
> +	map_fd = create_map();
> +	if (map_fd < 0)
> +		goto out;
> +	reader_fd = LOAD(reader_insns, map_fd);
> +	if (!ASSERT_OK_FD(reader_fd, "load_reader"))
> +		goto out;
> +	fd = LOAD(callx_insns, map_fd);
> +	if (!ASSERT_LT(fd, 0, "load_shared"))
> +		close(fd);
> +	ASSERT_HAS_SUBSTR(log_buf, "unreachable insn 6", "log_shared");
> +	run(reader_fd, DATA, "run_reader");
> +	close(reader_fd);
> +	reader_fd = -1;
> +	close(map_fd);
> +
> +	map_fd = create_map();
> +	if (map_fd < 0)
> +		goto out;
> +
> +	/* a program that is rejected is not a user, libbpf loads it again to get the log */
> +	fd = LOAD(bad_insns, map_fd);
> +	if (!ASSERT_LT(fd, 0, "load_bad"))
> +		close(fd);
> +
> +	prog_fd = LOAD(callx_insns, map_fd);
> +	if (!ASSERT_OK_FD(prog_fd, "load_callx")) {

Does this test properly handle the absence of callx support? The test is
gated only by architecture at line 11, not by run-time capability. When
the kernel returns -EOPNOTSUPP (either because net.core.bpf_jit_enable=0,
which happens on any CONFIG_BPF_JIT=y kernel without
CONFIG_BPF_JIT_DEFAULT_ON/ALWAYS_ON, or because bpf_jit_supports_callx()
is false, which on x86_64 happens on any IBT-capable CFI kernel where
cfi_mode resolves to CFI_FINEIBT), this ASSERT_OK_FD fails and the test
reports a false regression instead of skipping.

check_func_callx() in kernel/bpf/verifier.c explicitly returns -EOPNOTSUPP
in both of these documented capability-absent scenarios. The documentation
added in the same series states "callx requires the BPF JIT".

The infrastructure already exists: is_jit_enabled() combined with
test__skip(), as used by prog_tests/kasan.c. The #else arm at line 187
already calls test__skip() for other architectures.

> +		printf("%s\n", log_buf);
> +		goto out;
> +	}

[ ... ]

> diff --git a/tools/testing/selftests/bpf/prog_tests/callx_rodata_lskel.c b/tools/testing/selftests/bpf/prog_tests/callx_rodata_lskel.c
> new file mode 100644
> index 000000000000..5c60f352ff44
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/callx_rodata_lskel.c
> @@ -0,0 +1,55 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <test_progs.h>
> +
> +#include "callx_rodata.lskel.h"
> +
> +#if defined(__x86_64__) || defined(__aarch64__)

[ ... ]

> +void test_callx_rodata_lskel(void)
> +{
> +	struct callx_rodata_lskel *skel;
> +
> +	skel = callx_rodata_lskel__open();
> +	if (!ASSERT_OK_PTR(skel, "open"))
> +		return;
> +
> +	skel->rodata->bias = 7;
> +
> +	if (!ASSERT_OK(callx_rodata_lskel__load(skel), "load"))

Does this test properly handle the absence of callx support? The only gate
is the architecture check at line 6, not a run-time capability check.
progs/callx_rodata.c calls through static op_fn const ops[], so every
program in it needs callx, and check_func_callx() returns -EOPNOTSUPP
either when net.core.bpf_jit_enable=0 or when bpf_jit_supports_callx() is
false (which on x86_64 happens when cfi_mode is CFI_FINEIBT on IBT-capable
CFI kernels).

callx_rodata_lskel__load(skel) then returns that error and ASSERT_OK(...)
reports a FAILURE, where the correct behavior for an absent capability is
test__skip().

The convention is available in the same directory: is_jit_enabled() plus
test__skip(), as used by prog_tests/kasan.c. The #else arm at line 50
already calls test__skip() for other architectures. The documentation added
later in the same series records "callx requires the BPF JIT" as a
limitation.

> +		goto out;

[ ... ]

> diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
> index dc4ed6d9e5e4..3e07b957ee80 100644
> --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
> +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
> @@ -28,6 +28,7 @@
>  #include "verifier_btf_unreliable_prog.skel.h"
>  #include "verifier_call_large_imm.skel.h"
>  #include "verifier_callx.skel.h"
> +#include "verifier_callx_rodata.skel.h"
>  #include "verifier_cfg.skel.h"
>  #include "verifier_cgroup_inv_retcode.skel.h"
>  #include "verifier_cgroup_skb.skel.h"
> @@ -198,6 +199,7 @@ void test_verifier_btf_ctx_access(void)       { RUN(verifier_btf_ctx_access); }
>  void test_verifier_btf_unreliable_prog(void)  { RUN(verifier_btf_unreliable_prog); }
>  void test_verifier_call_large_imm(void)       { RUN(verifier_call_large_imm); }
>  void test_verifier_callx(void)                { RUN(verifier_callx); }
> +void test_verifier_callx_rodata(void)         { RUN(verifier_callx_rodata); }
>  void test_verifier_cfg(void)                  { RUN(verifier_cfg); }
>  void test_verifier_cgroup_inv_retcode(void)   { RUN(verifier_cgroup_inv_retcode); }
>  void test_verifier_cgroup_skb(void)           { RUN(verifier_cgroup_skb); }

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c b/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c
> new file mode 100644
> index 000000000000..419a90b1f894
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c

[ ... ]

> +SEC("socket")
> +__success __retval(433)
> +int callx_c_ops_mixed_with_data(void *ctx)
> +{
> +	/*
> +	 * square: op1(2) * 10 + op2(1) = 7 * 10 + 6 = 76
> +	 * circle: op3(3) * 20 + op1(2) = 18 * 20 + 7 = 367
> +	 * minus 10 when op_idx is not what it is set to

The comment states the condition inverted with respect to the code. op_idx
is defined as int op_idx = 11 at line 509 and nothing changes it, so
(op_idx == 11 ? 10 : 0) evaluates to 10, and 10 is subtracted exactly when
op_idx IS what it is set to. The expected value confirms it: 76 + 367 =
443, and __retval(433) = 443 - 10. If op_idx were not 11 the result would
be 443, not 433. Should this read "minus 10, since op_idx is 11" or
similar?

> +	 */
> +	return use_shape(&square_ops, 2) + use_shape(&circle_ops, 3) - (op_idx == 11 ? 10 : 0);
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35675730306
--===============2361510294543702674==--
