Received: from mail-oo2-f11.google.com (mail-oo2-f11.google.com [74.125.231.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5767A378D70
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 13:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791812259; cv=none; b=XB6658GOiUtb/COPWOaqDx7wl3hg43vhKSu32sePA9IAhxmHk775M1AhHBRIgSypTdmtO2soNfPZbvRhQDvlKABj1+E9fnEkIq2vJcu1t6kaZrajrlkC9YQxRK8x5KhvWQPHbir5ibLJTx0KO5SxCfg1MtEngSw3oG2xUPcDNzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791812259; c=relaxed/simple;
	bh=59lbaLiskyjKhCO8QcK/QgDTsfIjm2ALK6o6sGTz9BY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZVfKJdQSRbZd1C/jQ2Q/WTDT7k2HPzWpuKNmmWm44/Qk8OODWUnQctIGJlL28UWkys5TMR7Q6/epGoH/J992V0dNBwnYkKVLiTtrl5WKRnr2TYoueOJCjVs+ZD1EngHo38b6d9n3856gMyjnuW+ScUma3oJDCfFAdK6X6UDOX/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iyuhvty1; arc=none smtp.client-ip=74.125.231.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iyuhvty1"
Received: by mail-oo2-f11.google.com with SMTP id 46e09a7af769-826f42e479dso1431497a34.1
        for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 06:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791812256; x=1792417056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PXrMWUHAZp2yjmzc3cL7MTKn6mGudSCG4d2CCLA+Ak8=;
        b=iyuhvty1NGjXppsIg63zmQ2fB+6NU42ro2deW4nm+kQ4Wxu1LO+T/s+0TBwRlk1WDa
         MwGJiA1xcb+MeaZOd+/Thncf8H0j0B1s6EQcUdk+V7/v8G7hXb8PD/jLbnVVPgl+qPMN
         NMo+0d7RmNZJLNjGhE0c2XhLHK25pMJcBOHzQaCjlGEaos2FEFeeqhlWLGGyNAV0rXzh
         Lbw0BIsfNUC+h8xe2UOFEghgByjb1c3wVPpSSNGPaW/RpHvcvAJOnMpqYMRzokvy1Sk/
         qOeTtEh4tCzy6hsZCCYf9N7cyAMqdRJcOEKNpM1YKct5Kh2yZHe3YNF3FVrWUvAFMoYN
         pvaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791812256; x=1792417056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PXrMWUHAZp2yjmzc3cL7MTKn6mGudSCG4d2CCLA+Ak8=;
        b=MsJlX08oL3PGCqAMnuQcHBI9ZdEjZEa/HKmmRoPnd5WIFnb8bmw1CCqcV6EwaHLCm4
         qJ2IvBMZ0iqydkWwK/46oNt/z0YHsNMZP1l54aR6USOQRcjxtSZ4QWo0LgqlHBJmfNdH
         y+Er/aVLx2m/dHf+4uGLHd3PJ/DGTrqBmds/E1GVKSQlzJeqJDrh5LUWnSxQ3+J1RVUo
         GwYiY5dv7DHPhZqR/Vrv/V2cDcAUbZUETvd+vPG/FzqGfcpUGlaJoId67SAovV/dfBwf
         uuZYcQ9qKk+1qW2L2lK32FSfNw9GEpwIej5T6N/0QfbO+7SBbyyBhpbztvBmJjIj4vxs
         PaJA==
X-Gm-Message-State: AFq9FYJDnK+v/HZoOcjrb8s3gMVvdv4xmW7y1MLJ6qcNP/L3r+OumF1r
	rXZoqPwJSPhodBhPmXAg1IrQxTRwAjESxlL5PHgf8D41ebfRcDeqYJ8djlIJo/nUCUk=
X-Gm-Gg: AYBFou0Y5ERVCuWLi4fXdxC3XlMlz9m8XKH8P3G/yaqBkYpdyJtgFQrmvK1vuOx1UWi
	+f+AwJ515yHId9fFz3quJ/IJNRe3oE9z5wdMhmGcym6+eXuwetIoUrGPG/ZSbN19AnuCgCgnoNj
	tqKMdDvJCgzrnqgQeh6lleFgqJ8hXxaZHuDFdotuswI089Jt3x9KBBTpFs4shNGZFzzol7tahVa
	romA2Wh1vUxLNgqzeotFdCiOkwnmxKDJMz6f02abvnnzzOpkcLDGddDTVzJTnelYiocGfSI3Hk9
	XgtPXPzBDNdh8XY/CunBYkRCzweTiiTd04/G2n4kr2DdMO7Viu/FrTuJVzEc0rwiA7s0BMPVK9P
	FEflCp+jItPziBzjb7fcS0keHjYozipahWzW+l2sou6VVDU3acVx3lMo4HcVYdaTZtJgnC/8+WM
	onR5QNuTV4Sf953iVjvXpzqMRPlP7RPD83DrFg5sRiM1jA+4kKLwU1L9ZRbu0XVlwgq9U9nOX1k
	mA54OIUPMVYbHecWeW8nb+swerE86+gfQjvPeYF0M+Rt4k+wvc8nSWiGzQ91LezSnvsH8P5CdMR
	4aW4Dw==
X-Received: by 2002:a05:6830:83aa:b0:81c:37e2:2008 with SMTP id 46e09a7af769-83095e1b7camr8981518a34.14.1791812256085;
        Mon, 12 Oct 2026 06:37:36 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:b::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-830385b9c4asm9419963a34.9.2026.10.12.06.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 06:37:34 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 05/10] selftests/bpf: Test __arena pointer members
Date: Mon, 12 Oct 2026 15:37:02 +0200
Message-ID: <20261012133711.4030594-6-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261012133711.4030594-1-memxor@gmail.com>
References: <20261012133711.4030594-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=23342; h=from:subject; bh=59lbaLiskyjKhCO8QcK/QgDTsfIjm2ALK6o6sGTz9BY=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIevMw7WSDDx7lde9fe1cxqEeMafkQJVty+u7zmfFu+Si3K+o 3HvWUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgIlsUWVkuL5f4pRAWv4fjwe67hYeD2 8vZNG4P/PwPNV9If1unzPmRDD892ZY71Q7fy/v9W+7V+zsf7Gq4QRb7CqPxR3leltsr7Vo8wIA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add a struct_ops member to bpf_testmod whose argument struct publishes
arena pointers: a plain one, a __nullable one that is left NULL, one
behind a nested struct, one inside a union, next to a scalar, together
with a kfunc that fills the struct with the kernel address of an __arena
argument and calls the member.

Two callbacks read the pointers back. One shares the header with the
module, so the members are arena pointers on the program side as well
and need no cast; it also records the register a load produces, which
must be the arena offset with the upper 32 bits clear, and hands the
pointer to an __arena kfunc. The other mirrors the vmlinux.h rendering
of the struct, a kernel pointer with the type tag as an attribute, and
casts the members to the arena address space the way a program built
against vmlinux.h has to. Both increment the value through each pointer
and the trigger checks the count.

The failure cases cover a store through the member, a load from the
union, an atomic load, one insn loading the arena pointer on one path
and the scalar on another, and a program without an arena.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../bpf/prog_tests/test_struct_ops_arena.c    | 64 +++++++++++++
 .../bpf/progs/struct_ops_arena_member.c       | 92 +++++++++++++++++++
 .../struct_ops_arena_member_fail__load_acq.c  | 38 ++++++++
 .../struct_ops_arena_member_fail__mismatch.c  | 45 +++++++++
 .../struct_ops_arena_member_fail__no_arena.c  | 23 +++++
 .../struct_ops_arena_member_fail__union.c     | 34 +++++++
 .../struct_ops_arena_member_fail__write.c     | 32 +++++++
 .../progs/struct_ops_arena_member_render.c    | 82 +++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    | 20 ++++
 .../selftests/bpf/test_kmods/bpf_testmod.h    | 33 ++++++-
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |  1 +
 11 files changed, 463 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena_member.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena_member_fail__load_acq.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena_member_fail__mismatch.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena_member_fail__no_arena.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena_member_fail__union.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena_member_fail__write.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena_member_render.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c
index 7f9f54ba3fbe..1a7fe0d6c5a4 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c
@@ -5,6 +5,13 @@
 #include "struct_ops_arena.skel.h"
 #include "struct_ops_arena_attach.skel.h"
 #include "struct_ops_arena_fail.skel.h"
+#include "struct_ops_arena_member.skel.h"
+#include "struct_ops_arena_member_render.skel.h"
+#include "struct_ops_arena_member_fail__union.skel.h"
+#include "struct_ops_arena_member_fail__load_acq.skel.h"
+#include "struct_ops_arena_member_fail__mismatch.skel.h"
+#include "struct_ops_arena_member_fail__write.skel.h"
+#include "struct_ops_arena_member_fail__no_arena.skel.h"
 
 #if defined(__x86_64__) || defined(__aarch64__)
 /*
@@ -101,6 +108,54 @@ static void arena_arg_attach(void)
 
 	struct_ops_arena__destroy(skel);
 }
+
+/* Attach @st_ops and run @trigger once, it returns 0 when everything checked out. */
+static void attach_and_trigger(struct bpf_map *st_ops, struct bpf_program *trigger)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	struct bpf_link *link;
+	int err;
+
+	link = bpf_map__attach_struct_ops(st_ops);
+	if (!ASSERT_OK_PTR(link, "attach_struct_ops"))
+		return;
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(trigger), &topts);
+	ASSERT_OK(err, "test_run");
+	ASSERT_EQ(topts.retval, 0, "trigger_retval");
+
+	bpf_link__destroy(link);
+}
+
+/*
+ * Attach a callback that reads arena pointers out of its argument struct.
+ * The header is shared with the module, so the members are arena pointers
+ * on the program side as well.
+ */
+static void arena_member(void)
+{
+	struct struct_ops_arena_member *skel;
+
+	skel = struct_ops_arena_member__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "struct_ops_arena_member__open_and_load"))
+		return;
+
+	attach_and_trigger(skel->maps.testmod_arena_member, skel->progs.trigger);
+	struct_ops_arena_member__destroy(skel);
+}
+
+/* The same through the vmlinux.h rendering of the members, which takes casts. */
+static void arena_member_render(void)
+{
+	struct struct_ops_arena_member_render *skel;
+
+	skel = struct_ops_arena_member_render__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "struct_ops_arena_member_render__open_and_load"))
+		return;
+
+	attach_and_trigger(skel->maps.testmod_arena_member_render, skel->progs.trigger);
+	struct_ops_arena_member_render__destroy(skel);
+}
 #endif
 
 /*
@@ -122,6 +177,15 @@ void serial_test_struct_ops_arena(void)
 		arena_arg_fail();
 	if (test__start_subtest("arena_arg_attach"))
 		arena_arg_attach();
+	if (test__start_subtest("arena_member"))
+		arena_member();
+	if (test__start_subtest("arena_member_render"))
+		arena_member_render();
+	RUN_TESTS(struct_ops_arena_member_fail__union);
+	RUN_TESTS(struct_ops_arena_member_fail__load_acq);
+	RUN_TESTS(struct_ops_arena_member_fail__mismatch);
+	RUN_TESTS(struct_ops_arena_member_fail__write);
+	RUN_TESTS(struct_ops_arena_member_fail__no_arena);
 #else
 	test__skip();
 #endif
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_arena_member.c b/tools/testing/selftests/bpf/progs/struct_ops_arena_member.c
new file mode 100644
index 000000000000..469e62e383f2
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_arena_member.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#define BPF_NO_KFUNC_PROTOTYPES
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_experimental.h"
+#include <bpf_arena_common.h>
+#include "../test_kmods/bpf_testmod.h"
+#include "../test_kmods/bpf_testmod_kfunc.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE);
+	/* page 0 hosts the arena globals, page 1 is for allocations */
+	__uint(max_entries, 2);
+} arena SEC(".maps");
+
+/* also associates the callback with the arena */
+u64 __arena arena_touch;
+/* the register value a load of args->ptr produced in the callback */
+u64 __arena member_ptr_val;
+
+/*
+ * The header is shared with the module, so the members are u64 __arena * on
+ * this side too and the loads need no cast. The verifier derives the type of
+ * the loaded value from the module BTF, where the members carry the tag.
+ */
+SEC("struct_ops/test_arena_member")
+int BPF_PROG(test_arena_member_cb, struct bpf_testmod_arena_member_args *args)
+{
+	u64 __arena *ptr = args->ptr;
+	u64 raw;
+
+	arena_touch++;
+
+	/* the register right after the load, untouched by the compiler */
+	asm volatile("%[raw] = *(u64 *)(%[args] + %[off])"
+		     : [raw]"=r"(raw)
+		     : [args]"r"(args),
+		       [off]"i"(offsetof(struct bpf_testmod_arena_member_args, ptr)));
+	member_ptr_val = raw;
+
+	*ptr += 1;
+	if (args->null_ptr)
+		return 0xbad;
+	*args->nested.ptr += 1;
+	if (args->cookie != 0xc00c1e)
+		return 0xbad;
+	/* an arena pointer to kfuncs as well, the kfunc adds one */
+	bpf_kfunc_arena_arg_test((u64 *)args->ptr);
+	return 0;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops3 testmod_arena_member = {
+	.test_arena_member = (void *)test_arena_member_cb,
+};
+
+SEC("syscall")
+int trigger(void *ctx)
+{
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
+	u64 __arena *val;
+	int ret;
+
+	val = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+	if (!val)
+		return 1;
+
+	*val = 41;
+	ret = bpf_testmod_ops3_call_test_arena_member((u64 *)val);
+	if (ret)
+		return 2;
+	/* ptr, nested.ptr and the kfunc each added one */
+	if (*val != 44)
+		return 3;
+
+	/*
+	 * The callback saw (u32)(kaddr - kern_vm_start), the arena offset of
+	 * val with the upper 32 bits clear, the same as an __arena argument.
+	 */
+	if (member_ptr_val != (u32)(u64)val)
+		return 4;
+
+	bpf_arena_free_pages(&arena, (void __arena *)val, 1);
+#endif
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_arena_member_fail__load_acq.c b/tools/testing/selftests/bpf/progs/struct_ops_arena_member_fail__load_acq.c
new file mode 100644
index 000000000000..9d7972ae5c55
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_arena_member_fail__load_acq.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf_arena_common.h>
+#include "bpf_misc.h"
+#include "../test_kmods/bpf_testmod.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE);
+	__uint(max_entries, 1);
+} arena SEC(".maps");
+
+/* Only a plain load is rewritten to translate the member. */
+SEC("struct_ops/test_arena_member")
+__failure __msg("arena pointer member ptr of struct bpf_testmod_arena_member_args can only be read with a plain load")
+__naked int load_acq_member(void)
+{
+	asm volatile (
+	"r1 = *(u64 *)(r1 + 0);"
+	"r2 = %[arena] ll;"
+	/* r0 = load_acquire((u64 *)(r1 + 0)): BPF_STX | BPF_ATOMIC | BPF_DW, imm BPF_LOAD_ACQ */
+	".8byte 0x00000100000010db;"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm_addr(arena)
+	: __clobber_all);
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops3 testmod_arena_member_fail = {
+	.test_arena_member = (void *)load_acq_member,
+};
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_arena_member_fail__mismatch.c b/tools/testing/selftests/bpf/progs/struct_ops_arena_member_fail__mismatch.c
new file mode 100644
index 000000000000..88ed0fa7cc33
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_arena_member_fail__mismatch.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf_arena_common.h>
+#include "bpf_misc.h"
+#include "../test_kmods/bpf_testmod.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE);
+	__uint(max_entries, 1);
+} arena SEC(".maps");
+
+/*
+ * The same load reaches args->ptr on one path and args->cookie on the other,
+ * the branch on the unknown cookie value makes the verifier walk both. The
+ * rewrite is per insn, so the paths have to agree on what they load.
+ */
+SEC("struct_ops/test_arena_member")
+__failure __msg("loads an arena pointer member on one path and a different member on another")
+__naked int mismatch_member(void)
+{
+	asm volatile (
+	"r6 = *(u64 *)(r1 + 0);"
+	"r2 = %[arena] ll;"
+	"r0 = *(u64 *)(r6 + %[cookie_off]);"
+	"if r0 == 0 goto 1f;"
+	"r6 += %[cookie_off];"
+"1:	r0 = *(u64 *)(r6 + 0);"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm_addr(arena),
+	  __imm_const(cookie_off, offsetof(struct bpf_testmod_arena_member_args, cookie))
+	: __clobber_all);
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops3 testmod_arena_member_fail = {
+	.test_arena_member = (void *)mismatch_member,
+};
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_arena_member_fail__no_arena.c b/tools/testing/selftests/bpf/progs/struct_ops_arena_member_fail__no_arena.c
new file mode 100644
index 000000000000..3cf76e661583
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_arena_member_fail__no_arena.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+#include "../test_kmods/bpf_testmod.h"
+
+char _license[] SEC("license") = "GPL";
+
+/* No arena in the object: the member cannot be translated into anything. */
+SEC("struct_ops/test_arena_member")
+__failure __msg("arena pointer member ptr of struct bpf_testmod_arena_member_args requires a program with an associated arena")
+int BPF_PROG(no_arena_member, struct bpf_testmod_arena_member_args *args)
+{
+	return args->ptr != NULL;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops3 testmod_arena_member_fail = {
+	.test_arena_member = (void *)no_arena_member,
+};
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_arena_member_fail__union.c b/tools/testing/selftests/bpf/progs/struct_ops_arena_member_fail__union.c
new file mode 100644
index 000000000000..d45666fd482c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_arena_member_fail__union.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf_arena_common.h>
+#include "bpf_misc.h"
+#include "../test_kmods/bpf_testmod.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE);
+	__uint(max_entries, 1);
+} arena SEC(".maps");
+
+/*
+ * An offset into a union resolves to its first member, so a program reading
+ * raw there would get an arena pointer it did not ask for.
+ */
+SEC("struct_ops/test_arena_member")
+__failure __msg("arena pointer member ptr of bpf_testmod_arena_union is inside a union")
+int BPF_PROG(union_member, struct bpf_testmod_arena_member_args *args)
+{
+	asm volatile("" :: "r"(&arena));
+	return *args->u.ptr != 0;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops3 testmod_arena_member_fail = {
+	.test_arena_member = (void *)union_member,
+};
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_arena_member_fail__write.c b/tools/testing/selftests/bpf/progs/struct_ops_arena_member_fail__write.c
new file mode 100644
index 000000000000..bcf1f6586e19
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_arena_member_fail__write.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf_arena_common.h>
+#include "bpf_misc.h"
+#include "../test_kmods/bpf_testmod.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE);
+	__uint(max_entries, 1);
+} arena SEC(".maps");
+
+/* The kernel owns the member, a program only reads it. */
+SEC("struct_ops/test_arena_member")
+__failure __msg("only read is supported")
+int BPF_PROG(write_member, struct bpf_testmod_arena_member_args *args)
+{
+	asm volatile("" :: "r"(&arena));
+	args->ptr = NULL;
+	return 0;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops3 testmod_arena_member_fail = {
+	.test_arena_member = (void *)write_member,
+};
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_arena_member_render.c b/tools/testing/selftests/bpf/progs/struct_ops_arena_member_render.c
new file mode 100644
index 000000000000..0a6b7c5f494b
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_arena_member_render.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#define BPF_NO_KFUNC_PROTOTYPES
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_experimental.h"
+#include <bpf_arena_common.h>
+
+char _license[] SEC("license") = "GPL";
+
+/*
+ * The module types as vmlinux.h renders them: the tag is an attribute on a
+ * pointer in the kernel address space, so the program has to cast the member
+ * to the arena address space before using it. That is what a program built
+ * against vmlinux.h sees for a kernel struct with an __arena member.
+ */
+struct bpf_testmod_arena_member_args {
+	__u64 __attribute__((btf_type_tag("arena"))) *ptr;
+	__u64 __attribute__((btf_type_tag("arena"))) __attribute__((btf_type_tag("nullable"))) *null_ptr;
+	struct {
+		__u64 __attribute__((btf_type_tag("arena"))) *ptr;
+	} nested;
+} __attribute__((preserve_access_index));
+
+struct bpf_testmod_ops3 {
+	int (*test_arena_member)(struct bpf_testmod_arena_member_args *args);
+};
+
+int bpf_testmod_ops3_call_test_arena_member(__u64 *ptr__arena) __ksym;
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE);
+	__uint(max_entries, 2);
+} arena SEC(".maps");
+
+/* also associates the callback with the arena */
+u64 __arena arena_touch;
+
+SEC("struct_ops/test_arena_member")
+int BPF_PROG(test_arena_member_render_cb, struct bpf_testmod_arena_member_args *args)
+{
+	u64 __arena *ptr = (u64 __arena *)args->ptr;
+
+	arena_touch++;
+	*ptr += 1;
+	if (args->null_ptr)
+		return 0xbad;
+	*(u64 __arena *)args->nested.ptr += 1;
+	return 0;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops3 testmod_arena_member_render = {
+	.test_arena_member = (void *)test_arena_member_render_cb,
+};
+
+SEC("syscall")
+int trigger(void *ctx)
+{
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
+	u64 __arena *val;
+	int ret;
+
+	val = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+	if (!val)
+		return 1;
+
+	*val = 41;
+	ret = bpf_testmod_ops3_call_test_arena_member((u64 *)val);
+	if (ret)
+		return 2;
+	/* ptr and nested.ptr each added one */
+	if (*val != 43)
+		return 3;
+
+	bpf_arena_free_pages(&arena, (void __arena *)val, 1);
+#endif
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 0c0152885da3..5a0556d4ce31 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -460,6 +460,11 @@ static int bpf_testmod_ops3__test_arena_multislot(struct bpf_testmod_arena_pair
 	return 0;
 }
 
+static int bpf_testmod_ops3__test_arena_member(struct bpf_testmod_arena_member_args *args)
+{
+	return 0;
+}
+
 static int bpf_testmod_ops3__test_nullable(struct bpf_testmod_nullable_args *args)
 {
 	return 0;
@@ -472,6 +477,7 @@ static struct bpf_testmod_ops3 __bpf_testmod_ops3 = {
 	.test_arena_nullable = bpf_testmod_ops3__test_arena_nullable,
 	.test_arena_stack = bpf_testmod_ops3__test_arena_stack,
 	.test_arena_multislot = bpf_testmod_ops3__test_arena_multislot,
+	.test_arena_member = bpf_testmod_ops3__test_arena_member,
 	.test_nullable = bpf_testmod_ops3__test_nullable,
 };
 
@@ -513,6 +519,19 @@ __bpf_kfunc int bpf_testmod_ops3_call_test_arena_multislot(u64 *ptr__arena)
 	return st_ops3->test_arena_multislot(p, ptr__arena);
 }
 
+/* The callback gets the kernel address of @ptr__arena behind each __arena member. */
+__bpf_kfunc int bpf_testmod_ops3_call_test_arena_member(u64 *ptr__arena)
+{
+	struct bpf_testmod_arena_member_args args = {
+		.ptr = ptr__arena,
+		.nested.ptr = ptr__arena,
+		.u.ptr = ptr__arena,
+		.cookie = 0xc00c1e,
+	};
+
+	return st_ops3->test_arena_member(&args);
+}
+
 /*
  * The members of struct bpf_testmod_nullable_args are trusted the way the
  * verifier's BTF_TYPE_SAFE_TRUSTED() lists vmlinux members: through a struct
@@ -958,6 +977,7 @@ BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_arena)
 BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_arena_nullable)
 BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_arena_stack)
 BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_arena_multislot)
+BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_arena_member)
 BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_nullable)
 BTF_ID_FLAGS(func, bpf_kfunc_get_default_trusted_ptr_test);
 BTF_ID_FLAGS(func, bpf_kfunc_put_default_trusted_ptr_test);
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
index b905c35490eb..e92f9fbfe6a6 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
@@ -114,11 +114,40 @@ struct bpf_testmod_arena_pair {
 	u64 b;
 };
 
-/* The kernel defines the BPF pointer qualifiers, user space and BPF programs need them empty. */
+/*
+ * The kernel defines the BPF pointer qualifiers, a BPF program gets __arena
+ * from bpf_arena_common.h and user space needs neither.
+ */
+#ifndef __arena
+#define __arena
+#endif
 #ifndef __nullable
 #define __nullable
 #endif
 
+struct bpf_testmod_arena_nested {
+	u64 __arena *ptr;
+};
+
+union bpf_testmod_arena_union {
+	u64 __arena *ptr;
+	u64 raw;
+};
+
+/* Arguments of test_arena_member(), the pointers hold kernel addresses of arena memory */
+struct bpf_testmod_arena_member_args {
+	/* the value the caller passed, never NULL */
+	u64 __arena *ptr;
+	/* always NULL */
+	u64 __arena __nullable *null_ptr;
+	/* the same value again, behind a nested struct */
+	struct bpf_testmod_arena_nested nested;
+	/* the same value again, but a load from a union is rejected */
+	union bpf_testmod_arena_union u;
+	/* a scalar, loaded by the same insn as @ptr in a verifier test */
+	u64 cookie;
+};
+
 /* Arguments of test_nullable(), trusted through the __safe_trusted alias in the module */
 struct bpf_testmod_nullable_args {
 	/* never NULL */
@@ -138,6 +167,8 @@ struct bpf_testmod_ops3 {
 				u64 g, u64 h, u64 *ptr);
 	/* a multi-slot leading arg, so @ptr is not at the slot its arg index suggests */
 	int (*test_arena_multislot)(struct bpf_testmod_arena_pair p, u64 *ptr);
+	/* Used to test __arena pointer members. */
+	int (*test_arena_member)(struct bpf_testmod_arena_member_args *args);
 	/* Used to test __nullable pointer members. */
 	int (*test_nullable)(struct bpf_testmod_nullable_args *args);
 };
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
index d88c99109c31..8b85b2d73e1c 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
@@ -218,6 +218,7 @@ int bpf_testmod_ops3_call_test_arena(__u64 *ptr__arena) __ksym;
 int bpf_testmod_ops3_call_test_arena_nullable(__u64 *ptr__arena__nullable) __ksym;
 int bpf_testmod_ops3_call_test_arena_stack(__u64 *ptr__arena) __ksym;
 int bpf_testmod_ops3_call_test_arena_multislot(__u64 *ptr__arena) __ksym;
+int bpf_testmod_ops3_call_test_arena_member(__u64 *ptr__arena) __ksym;
 int bpf_testmod_ops3_call_test_nullable(void) __ksym;
 
 __u64 bpf_kfunc_call_test1(struct sock *sk, __u32 a, __u64 b,
-- 
2.53.0-Meta

