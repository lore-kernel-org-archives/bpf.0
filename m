Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942893C279B;
	Mon, 14 Sep 2026 23:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789429390; cv=none; b=k7tm91LnkSdEspbU3AS3ytRyo3cNs5SVkbxgosOygGlg+y+rG5KDD5/nQmuPB+/qpUpVU+FV/50IbSXQVxN9qO59yNDjNJyOCZjdgR/BegTVryhoVUhTYuFIuA3eE4pfhCOo/2Qmlb9ctTQy35aXe3R+TT/gKKmacEqZeS/I+/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789429390; c=relaxed/simple;
	bh=rd9cH6uYqdbcqqWAKE/6dakACodS2cOjW2Bgl+3BLeY=;
	h=Date:Message-ID:From:To:Cc:Subject; b=kADZXyWkuQpkC9fb5k5TI2H2zH8nfmJ5/ztxgxb7OBqV8XDMvy/tb1TgMB5q2uS9z16XEYAAbjNb0Z+MoH8TIgwS37Jc6fV2KQ7BgzfP60s/XmIah0twZAHJHNtsBdOsukKGdc+jisJQjDRBfmRKvNJnbRAzFpUCIbks6AXGBIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZanldW2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZanldW2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BED31F000FF;
	Mon, 14 Sep 2026 23:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789429384;
	bh=rG/P63XRfAjkiK3v29BDNXfccJdl4Bv1mJbDPEn8nDY=;
	h=Date:From:To:Cc:Subject;
	b=mZanldW2Q1PKl5NiXiDNutUQdo9be+MqVVBHLdBd9rfEXm9Ug/b5R1cqobcT2MkMp
	 tfz1YMeAFOj4+MuWsRvzRkt2s9uPbNGhrDBIaDMf4fkeq8ue75s0YTHEwVil+lsq5X
	 T6bviSDOFIVEYcV4S11OrBXC2vfpKW4mzOdit2Dfjdeixav0r1pGBnlXxRBwqN3iot
	 mY2bD0GXs3imc1+DiljjHladB/oQwEwq3W4RyUsIL9WhCFry+AV6kDTW81u+AU1WFR
	 c4Y9GBgRDtgSf8N50/de+2GfAwLpiIU571B6Ldu69vkAbsVnRa19W8qYQr6pZ8Seih
	 Clx2RtKlyjIig==
Date: Mon, 14 Sep 2026 13:43:03 -1000
Message-ID: <86d966ec88bbf27d21b2bb4e18c8aa00@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Amery Hung <ameryhung@gmail.com>,
	bpf@vger.kernel.org,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf] bpf: Keep generic __uninit kfunc arguments live
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Stack liveness models a kfunc's __uninit pointer argument as a pure write:
whatever the buffer holds before the call is dead, and 2cb27158adb3 ("bpf:
poison dead stack slots") poisons those slots at every checkpoint the path
visits before the call. Argument validation disagrees. Only dynptr arguments
honor __uninit. A generic fixed-size buffer goes through check_mem_reg(),
whose read pass requires every byte readable. The two rules meet at the call
and the poisoned buffer is rejected with "slot poisoned by dead code
elimination", even when the program initialized it.

Every kfunc with a generic __uninit output argument is affected,
bpf_ksock_create() through err__uninit and sched_ext's scx_bpf_cid_topo()
through its output struct. The rejection needs the buffer's slots to be
allocated and dead at a checkpoint, for example on the second iteration of a
loop around the call. Before e566701b9b0c ("bpf: Check fixed-size mem args
of helpers and kfuncs the same way") kfunc arguments could read poisoned
slots, so the call passed, but the slots stayed poisoned and the program's
next read of the buffer was rejected instead.

Restrict the liveness write-only exception to dynptr arguments, where
validation accepts uninitialized output. A generic __uninit buffer stays
live and is never poisoned, and validation keeps requiring it to be
initialized. Add a selftest with a scalar output buffer and a checkpoint
between its initialization and the call.

Fixes: 2cb27158adb3 ("bpf: poison dead stack slots")
Cc: stable@vger.kernel.org # v7.1+
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/bpf/verifier.c                                      |    3 
 tools/testing/selftests/bpf/prog_tests/verifier.c          |    2 
 tools/testing/selftests/bpf/progs/verifier_kfunc_uninit.c  |   45 +++++++++++++
 tools/testing/selftests/bpf/test_kmods/bpf_testmod.c       |    9 ++
 tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h |    1 
 5 files changed, 59 insertions(+), 1 deletion(-)

--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12755,7 +12755,8 @@ out:
 	/* KF_ITER_NEW kfuncs initialize the iterator state at arg 0 */
 	if (arg == 0 && meta.kfunc_flags & KF_ITER_NEW)
 		return -size;
-	if (is_kfunc_arg_uninit(btf, &args[arg]))
+	/* only dynptr validation accepts an uninitialized __uninit argument */
+	if (is_kfunc_arg_dynptr(btf, &args[arg]) && is_kfunc_arg_uninit(btf, &args[arg]))
 		return -size;
 	return size;
 }
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -53,6 +53,7 @@
 #include "verifier_iterating_callbacks.skel.h"
 #include "verifier_jeq_infer_not_null.skel.h"
 #include "verifier_jit_convergence.skel.h"
+#include "verifier_kfunc_uninit.skel.h"
 #include "verifier_ld_ind.skel.h"
 #include "verifier_ldsx.skel.h"
 #include "verifier_leak_ptr.skel.h"
@@ -214,6 +215,7 @@ void test_verifier_int_ptr(void)
 void test_verifier_iterating_callbacks(void)  { RUN(verifier_iterating_callbacks); }
 void test_verifier_jeq_infer_not_null(void)   { RUN(verifier_jeq_infer_not_null); }
 void test_verifier_jit_convergence(void)      { RUN(verifier_jit_convergence); }
+void test_verifier_kfunc_uninit(void)         { RUN_TESTS(verifier_kfunc_uninit); }
 void test_verifier_load_acquire(void)         { RUN(verifier_load_acquire); }
 void test_verifier_ld_ind(void)               { RUN(verifier_ld_ind); }
 void test_verifier_ldsx(void)                  { RUN(verifier_ldsx); }
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_kfunc_uninit.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Tejun Heo <tj@kernel.org> */
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "../test_kmods/bpf_testmod_kfunc.h"
+
+char _license[] SEC("license") = "GPL";
+
+/* keep the BTF FUNC record for the inline assembly reference */
+void __kfunc_btf_root(void)
+{
+	bpf_kfunc_call_test_uninit(0);
+}
+
+SEC("tc")
+__success __retval(42)
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked void uninit_scalar_struct(void)
+{
+	/* dead before the call, so poisoned at the checkpoint */
+	asm volatile (
+	"*(u64 *)(r10 - 16) = 0;"
+	"*(u64 *)(r10 - 8) = 0;"
+	"goto +0;"
+	"r1 = r10;"
+	"r1 += -16;"
+	"call %[bpf_kfunc_call_test_uninit];"
+	"r1 = *(u32 *)(r10 - 16);"
+	"if r1 != 1 goto 1f;"
+	"r1 = *(u32 *)(r10 - 12);"
+	"if r1 != 2 goto 1f;"
+	"r1 = *(u32 *)(r10 - 8);"
+	"if r1 != 3 goto 1f;"
+	"r1 = *(u32 *)(r10 - 4);"
+	"if r1 != 4 goto 1f;"
+	"r0 = 42;"
+	"exit;"
+"1:"
+	"r0 = 0;"
+	"exit;"
+	:: __imm(bpf_kfunc_call_test_uninit)
+	: __clobber_all);
+}
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -1087,6 +1087,14 @@ __bpf_kfunc void bpf_kfunc_call_test_pas
 {
 }
 
+__bpf_kfunc void bpf_kfunc_call_test_uninit(struct prog_test_pass1 *out__uninit)
+{
+	out__uninit->x0 = 1;
+	out__uninit->x1 = 2;
+	out__uninit->x2 = 3;
+	out__uninit->x3 = 4;
+}
+
 __bpf_kfunc void bpf_kfunc_call_test_fail1(struct prog_test_fail1 *p)
 {
 }
@@ -1493,6 +1501,7 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_int_me
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_pass_ctx)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_pass1)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_pass2)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_uninit)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_fail1)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_fail2)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_fail3)
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
@@ -160,6 +160,7 @@ __u64 bpf_kfunc_call_stack_arg_big(__u64
 void bpf_kfunc_call_test_pass_ctx(struct __sk_buff *skb) __ksym;
 void bpf_kfunc_call_test_pass1(struct prog_test_pass1 *p) __ksym;
 void bpf_kfunc_call_test_pass2(struct prog_test_pass2 *p) __ksym;
+void bpf_kfunc_call_test_uninit(struct prog_test_pass1 *out__uninit) __ksym;
 void bpf_kfunc_call_test_mem_len_fail2(__u64 *mem, int len) __ksym;
 
 void bpf_kfunc_call_test_destructive(void) __ksym;
