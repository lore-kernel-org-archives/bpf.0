Received: from mail-oo2-f10.google.com (mail-oo2-f10.google.com [74.125.231.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515534A0F0D
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 23:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792107723; cv=none; b=WfLFoU9F7Wh2oHRiXsryLfSvOCsBvuAAqlCogJ1SPiIchutQStRNX/MnuCHa8awWOX3JZnDsbLK5k5wItgwdqRe5qczoWRZ7PA/p4WzIsGVjikWVwSQuLVukgxDOJ28LVF6hMtM68v1oBk/h73Sx59URDatNL5o0G1PfOu/iie8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792107723; c=relaxed/simple;
	bh=EjNn2igiyEb/TL38JRfRQBa05uqy5b4js22OipF6aAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hosXitTfCQacILF7uragOIjWMmTZQpfMIro/iNZ8c+0PLRoWu1Zx7HY4ud9LqDUEppoc1c2xdq0O3iW9ezZ/w8MdO+HJpvum+YJ5mYt3qKZK2L3zdh5aozqFJgXXlOHxi/dOfRUcRqBXD4hnwhJi+Ysk1O6Zjq0AQ8QbnFMvEXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mn+op2MH; arc=none smtp.client-ip=74.125.231.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mn+op2MH"
Received: by mail-oo2-f10.google.com with SMTP id 46e09a7af769-820ff812cd8so1767092a34.1
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 16:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792107720; x=1792712520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mobPNCHEz+sMtFiegTydV/6MTeGEF8LfbVh5no6xe/4=;
        b=Mn+op2MHeMF8xlu2qJk2ytAmxcsb4BR6yEVUcbFQtg+ZbwjA0FcT7xBapmzYcYe+bK
         h4rS5nkJuD/XDRxVX+RsXoUFrLcIhS1iDq3GCB8jDJ1bN1xWsvkZUenImURETfAE+bEG
         aEr3hRS/Zt1cJ9E4vcypLTLzjZNCgXRJygK2jR9G8kku5U7YbyRLOnoVnXYSCP/WmTP5
         kJsjWgss9KMWFKk6ACdyBYVmt7+eyVUygbZSo7so4BlHlxqanrKm9PeivkhOnW4EgPhg
         aRFJ+R1sVAIHxjDzv1prJhyqUW1Qg+gBcTCJjJGBxmqVXHXnhMHWp0Gn47KMK9OA7m0s
         1lDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792107720; x=1792712520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mobPNCHEz+sMtFiegTydV/6MTeGEF8LfbVh5no6xe/4=;
        b=dn9j6uFwFzV3uoWVFumODqhTsNIWl28ayFP+aFfO005jQtEi0XrXkuAcS62nQPbfa1
         EvNyddZgb9QY2ld5VDo7NnDvpNPBJveKa5rjgVr5yjiyjrd6xxAPDMMXYW9SAdpcVuTz
         NnM6ALpXuWM55/m73E5fG/zRsXKM4thZoCiMG1UOFAXIcW6e8bnLDx45eQyLNZWfY5M0
         waRzTzanGqv4DMJWyeHuNGg888XB5i5CjwJP8KHFBv3mFRzh+UJkeOJ4QzZ+YHygGy+9
         i8F86zwHHZXiPmwnqqPYTWOsDCRaeO2MvaflUW5QdAQF47cEk82KmeGNbcuDS90bvFNq
         hl2w==
X-Gm-Message-State: AFq9FYKFlrCd40rfc+3TCVXWDnzxSDObbcUMabtxW7GTxa0Qpc3XPkQo
	4UI+fUPijg3D2LWbo7+fsrpw62TSFWHYGO7UvxCIOAg6zQWxd4HGe44RBUgpFIGa7U4=
X-Gm-Gg: AYBFou2NczmRS2ij3fZOI9kRkv45d1/jg1euluK/Wey9zla4RKp/JLgEC+P901yjERW
	t2xbAoSI8D6bfdvOgKaHsl89y+Z98KmSRJYa9AKyjSz8iD8NuklzFLxZGB1yD1zerG6zqW8USha
	4w5A3ZJvSI+NCCAvGFv4VL5L9uMQUcn6EwvKfCVEYpK6XEbcziogc9sxHrQ2uP6SKSkM2rmK/kt
	DcbTI0AucNgC/ff84fl+w4frQUMDzRLsYCsfLO5pI49GKXary5mlw0374wf5et/5aYjpz5XZZNP
	28VxRM/LTm/NKyJVKXm2jCR9Qb7ehm1ufvshvExqqpBSs/xe5aNwn4NiBV6FjQrzV3fzjL7nsSW
	qC02AHT5jZVy0E77I5d7jr8jcGK3VXBDEc+UyxXHx/X9V55vHaiw2VAxnIq2LV/ZYqRx1UwDsjc
	CN3rnt3IVjhqqmS9GJyYefM5Zn2q3WbXVt+JStCRK4bG+If1Tc5koS1kXvUwG9fNcoHJPM3SWjS
	uhG7MAUxo5PS4Ob7MiHXL9Icio4kow/OW4J6pXv0L7rLVq7AbaE4qZh/1KWDmn9jsTbFVC88V1z
	2uT2MQ==
X-Received: by 2002:a05:6808:1485:b0:4b5:b13a:9001 with SMTP id 5614622812f47-50c4e683212mr21435764b6e.14.1792107720145;
        Thu, 15 Oct 2026 16:42:00 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:50::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5388289f0bdsm301248b6e.1.2026.10.15.16.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 16:41:59 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 09/15] selftests/bpf: Test __arena pointer members
Date: Fri, 16 Oct 2026 01:41:15 +0200
Message-ID: <20261015234125.3152346-10-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015234125.3152346-1-memxor@gmail.com>
References: <20261015234125.3152346-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=27784; h=from:subject; bh=EjNn2igiyEb/TL38JRfRQBa05uqy5b4js22OipF6aAU=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIeti3OukyBXTZFZ4zyq5VTB9UrfHezUh5VXfDLeLpDgsnrbj 0iW9jlIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAEzkxDZGhh0zV+83nNwuHlz1refL+w N7Gba6/hRND1zzYe8ru7DdjIwM/yvPT3CKK/zj/aWTW9fKv0Hui7mUov0hyWnVSyZe1m/jYwEA
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
and the trigger checks the count. The first callback also reads a
member through a plain pointer to a bad address, a probed load that
faults, and checks that it reads as NULL rather than as an arena
pointer.

The failure cases cover a store to the member, a load from the
union, an atomic load, one insn loading the arena pointer on one path
and the scalar on another, and a program without an arena. On a kernel
whose module BTF carries no type tags the member tests are reported as
skipped.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../bpf/prog_tests/test_struct_ops_arena.c    | 75 ++++++++++++++
 .../bpf/progs/struct_ops_arena_member.c       | 99 +++++++++++++++++++
 .../struct_ops_arena_member_fail__load_acq.c  | 39 ++++++++
 .../struct_ops_arena_member_fail__mismatch.c  | 45 +++++++++
 ...ruct_ops_arena_member_fail__mismatch_mem.c | 54 ++++++++++
 .../struct_ops_arena_member_fail__no_arena.c  | 24 +++++
 .../struct_ops_arena_member_fail__union.c     | 34 +++++++
 .../struct_ops_arena_member_fail__write.c     | 32 ++++++
 .../progs/struct_ops_arena_member_render.c    | 82 +++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    | 24 +++++
 .../selftests/bpf/test_kmods/bpf_testmod.h    | 44 ++++++++-
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |  1 +
 12 files changed, 552 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena_member.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena_member_fail__load_acq.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena_member_fail__mismatch.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena_member_fail__mismatch_mem.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena_member_fail__no_arena.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena_member_fail__union.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena_member_fail__write.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena_member_render.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c
index 7f9f54ba3fbe..e828ab9124c0 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c
@@ -5,6 +5,14 @@
 #include "struct_ops_arena.skel.h"
 #include "struct_ops_arena_attach.skel.h"
 #include "struct_ops_arena_fail.skel.h"
+#include "struct_ops_arena_member.skel.h"
+#include "struct_ops_arena_member_render.skel.h"
+#include "struct_ops_arena_member_fail__union.skel.h"
+#include "struct_ops_arena_member_fail__load_acq.skel.h"
+#include "struct_ops_arena_member_fail__mismatch.skel.h"
+#include "struct_ops_arena_member_fail__mismatch_mem.skel.h"
+#include "struct_ops_arena_member_fail__write.skel.h"
+#include "struct_ops_arena_member_fail__no_arena.skel.h"
 
 #if defined(__x86_64__) || defined(__aarch64__)
 /*
@@ -101,6 +109,54 @@ static void arena_arg_attach(void)
 
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
@@ -110,6 +166,8 @@ static void arena_arg_attach(void)
  */
 void serial_test_struct_ops_arena(void)
 {
+	int has_tag;
+
 	/*
 	 * Arena struct_ops arguments need JIT support, currently x86-64 and
 	 * arm64 only. Elsewhere verification fails with "JIT does not support
@@ -122,6 +180,23 @@ void serial_test_struct_ops_arena(void)
 		arena_arg_fail();
 	if (test__start_subtest("arena_arg_attach"))
 		arena_arg_attach();
+	/* the tags reach the module BTF only from a toolchain with btf_type_tag support */
+	has_tag = testmod_member_has_type_tag("bpf_testmod_arena_member_args", "ptr", "arena");
+	if (ASSERT_GE(has_tag, 0, "testmod_btf") && has_tag) {
+		if (test__start_subtest("arena_member"))
+			arena_member();
+		if (test__start_subtest("arena_member_render"))
+			arena_member_render();
+		RUN_TESTS(struct_ops_arena_member_fail__union);
+		RUN_TESTS(struct_ops_arena_member_fail__load_acq);
+		RUN_TESTS(struct_ops_arena_member_fail__mismatch);
+		RUN_TESTS(struct_ops_arena_member_fail__mismatch_mem);
+		RUN_TESTS(struct_ops_arena_member_fail__write);
+		RUN_TESTS(struct_ops_arena_member_fail__no_arena);
+	} else if (test__start_subtest("arena_member")) {
+		/* so that the missing member tests show up as skipped */
+		test__skip();
+	}
 #else
 	test__skip();
 #endif
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_arena_member.c b/tools/testing/selftests/bpf/progs/struct_ops_arena_member.c
new file mode 100644
index 000000000000..615df62fc35b
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_arena_member.c
@@ -0,0 +1,99 @@
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
+	/*
+	 * @faulting is a plain kernel pointer, so the member behind it is read
+	 * with a probed load, which faults here and reads as NULL rather than
+	 * as an arena pointer.
+	 */
+	if (args->faulting->ptr)
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
index 000000000000..38f6e50fbf61
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_arena_member_fail__load_acq.c
@@ -0,0 +1,39 @@
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
+__failure __msg("arena pointer member ptr of struct "
+		"bpf_testmod_arena_member_args can only be read with a plain load")
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
index 000000000000..0b4147894122
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
+__failure __msg("loads an arena pointer member on one path and something else on another")
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
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_arena_member_fail__mismatch_mem.c b/tools/testing/selftests/bpf/progs/struct_ops_arena_member_fail__mismatch_mem.c
new file mode 100644
index 000000000000..ff6d4db47cfd
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_arena_member_fail__mismatch_mem.c
@@ -0,0 +1,54 @@
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
+ * The same load reads args->ptr on one path and the memory argument on the
+ * other. The verifier lets a load insn serve a kernel struct pointer and a
+ * memory pointer, see save_aux_ptr_type(), but the rewrite of the arena
+ * member would corrupt the value the other path loads. A global function
+ * is the only place a struct_ops program of this type gets a memory pointer.
+ * The loaded value goes nowhere: an ALU insn on it would be an arena
+ * pointer on one path and a scalar on the other, which the verifier rejects
+ * on its own before the fixup pass gets to the load.
+ */
+__noinline int load_either(unsigned long long *ctx __arg_ctx, u64 *mem __arg_nonnull)
+{
+	struct bpf_testmod_arena_member_args *args = (void *)ctx[0];
+	void *p = args;
+
+	if (args->cookie == 0)
+		p = mem;
+	/* one load insn, reached with both pointers */
+	asm volatile("r0 = *(u64 *)(%[p] + 0)" :: [p]"r"(p) : "r0");
+	return 0;
+}
+
+SEC("struct_ops/test_arena_member")
+__failure __msg("loads an arena pointer member on one path and something else on another")
+int BPF_PROG(mismatch_mem, struct bpf_testmod_arena_member_args *args)
+{
+	u64 local = 0;
+
+	asm volatile("" :: "r"(&arena));
+	return load_either(ctx, &local);
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops3 testmod_arena_member_fail = {
+	.test_arena_member = (void *)mismatch_mem,
+};
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_arena_member_fail__no_arena.c b/tools/testing/selftests/bpf/progs/struct_ops_arena_member_fail__no_arena.c
new file mode 100644
index 000000000000..cdd8ea740478
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_arena_member_fail__no_arena.c
@@ -0,0 +1,24 @@
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
+__failure __msg("arena pointer member ptr of struct bpf_testmod_arena_member_args "
+		"requires a program with an associated arena")
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
index 92495affa461..aa7237f71cf3 100644
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
 
@@ -513,6 +519,23 @@ __bpf_kfunc int bpf_testmod_ops3_call_test_arena_multislot(u64 *ptr__arena)
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
+		/* in the first page, which is never mapped */
+		.faulting = (void *)16,
+	};
+
+	if (!st_ops3 || !st_ops3->test_arena_member)
+		return -EOPNOTSUPP;
+	return st_ops3->test_arena_member(&args);
+}
+
 /*
  * The members of struct bpf_testmod_nullable_args are trusted the way the
  * verifier's BTF_TYPE_SAFE_TRUSTED() lists vmlinux members: through a struct
@@ -967,6 +990,7 @@ BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_arena)
 BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_arena_nullable)
 BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_arena_stack)
 BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_arena_multislot)
+BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_arena_member)
 BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_nullable)
 BTF_ID_FLAGS(func, bpf_kfunc_get_default_trusted_ptr_test);
 BTF_ID_FLAGS(func, bpf_kfunc_put_default_trusted_ptr_test);
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
index cde3a2f47959..e278736babd9 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
@@ -114,7 +114,22 @@ struct bpf_testmod_arena_pair {
 	u64 b;
 };
 
-/* The kernel defines the BPF pointer qualifiers, user space and BPF programs need them empty. */
+/*
+ * The kernel defines the BPF pointer qualifiers. A BPF program gets __arena
+ * from bpf_arena_common.h, and the same definition here when it includes this
+ * header first, and needs __nullable and __percpu empty. User space needs all
+ * of them empty.
+ */
+#if defined(__BPF__) && !defined(__arena)
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST) && !defined(BPF_ARENA_FORCE_ASM)
+#define __arena __attribute__((address_space(1))) __attribute__((btf_type_tag("arena")))
+#else
+#define __arena __attribute__((btf_type_tag("arena")))
+#endif
+#endif
+#ifndef __arena
+#define __arena
+#endif
 #ifndef __nullable
 #define __nullable
 #endif
@@ -126,6 +141,31 @@ struct bpf_testmod_pcpu {
 	int val;
 };
 
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
+	/* a bad pointer to a struct like this one, a load through it faults */
+	struct bpf_testmod_arena_member_args *faulting;
+};
+
 /* Arguments of test_nullable(), trusted through the __safe_trusted alias in the module */
 struct bpf_testmod_nullable_args {
 	/* never NULL */
@@ -151,6 +191,8 @@ struct bpf_testmod_ops3 {
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

