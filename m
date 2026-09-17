Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2525419FBE
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 05:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789624718; cv=none; b=X53qOz2HLw9hQwDFcDVglo6IZYd5UEZ69sA2sdlqq9W0QWvs/Uoctn/sNgtUVF6qJG8h84Ogug6erv8PGHrlVszkmXus/QcY5SM1/ZQVRx9jihfWYfDn11UnfLJKdQja2wteMIErYdCGJpiMuSKLy1YAJKxQtE9eN1yoE5PQRVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789624718; c=relaxed/simple;
	bh=JCL2WUNbuny7K7OCmXUq07t7rZuqke0ITEPIJEVVmjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wf9JgDMDXP6M9bIcQUsBAFytzP+B2lUGxGTZ9KMobUkqrTzS+Fzugkw1kKzZ2cz+pFCSLBdcShDgo8CiEGUXqwkaansMRqUobhniZ8GZp+o5SxFgRBThbcTTvx6x1JRMq7WSL0ymKf551txAvctoAMHcsQSor+IRi4lO+y5tKz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 7366B2B48B290B; Wed, 16 Sep 2026 22:58:23 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next 19/20] selftests/bpf: Cover the exception cleanup shapes the chain does not reach
Date: Wed, 16 Sep 2026 22:58:23 -0700
Message-ID: <20260917055823.3935111-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917055645.3926444-1-yonghong.song@linux.dev>
References: <20260917055645.3926444-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The end-to-end test walks one call chain with a pad in most of its frames=
.
This adds the shapes that chain does not reach: a callee called from both=
 a
covered and an uncovered site, a pad that reads its frame's callee-saved
registers, a tail-call-reachable callee, a tail call that is taken, an
extension standing in for a covered call, a pad in the main program's own
frame, a record covering bpf_throw() itself, a record covering only a
nounwind call, a throwing subprogram named by a BPF_PSEUDO_FUNC, a region
ending on a 16-byte instruction, a pad that reloads from and writes to it=
s
own frame, a pad two frames up, a pad that calls a subprogram which tail
calls, an extension carrying a table of its own, and a pad terminated by
_Unwind_Resume rather than bpf_unwind_resume.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/exceptions_cleanup.h        |  20 +
 .../bpf/prog_tests/exceptions_cleanup.c       | 314 +++++++
 .../bpf/progs/exceptions_cleanup_ext_table.c  |  48 +
 .../bpf/progs/exceptions_cleanup_freplace.c   |  17 +
 .../progs/exceptions_cleanup_pad_freplace.c   |  17 +
 .../bpf/progs/exceptions_cleanup_shapes.c     | 863 ++++++++++++++++++
 6 files changed, 1279 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/exceptions_cleanup_=
ext_table.c
 create mode 100644 tools/testing/selftests/bpf/progs/exceptions_cleanup_=
freplace.c
 create mode 100644 tools/testing/selftests/bpf/progs/exceptions_cleanup_=
pad_freplace.c
 create mode 100644 tools/testing/selftests/bpf/progs/exceptions_cleanup_=
shapes.c

diff --git a/tools/testing/selftests/bpf/exceptions_cleanup.h b/tools/tes=
ting/selftests/bpf/exceptions_cleanup.h
index 630d2e207119..5896cf83d15e 100644
--- a/tools/testing/selftests/bpf/exceptions_cleanup.h
+++ b/tools/testing/selftests/bpf/exceptions_cleanup.h
@@ -4,6 +4,7 @@
 #define __EXCEPTIONS_CLEANUP_H__
=20
 #define THROW_COOKIE		0x100
+#define INNER_COOKIE		0x200
=20
 /* progs/exceptions_cleanup.c: one bit per frame that reports it ran. */
 #define RAN_FOO3_PREEMPT	0x1
@@ -12,6 +13,25 @@
 #define RAN_FOO2_DROP		0x8
 #define RAN_BUMP		0x10
=20
+/* progs/exceptions_cleanup_shapes.c: one bit per shape, numbered its ow=
n way. */
+#define RAN_SWEEP		0x1
+#define RAN_SHARED		0x2
+#define RAN_REGS		0x4
+#define RAN_TAIL_CALL		0x8
+#define RAN_MAIN_PAD		0x10
+#define RAN_TC_TAKEN		0x20
+#define RAN_FREPLACE		0x40
+#define RAN_ADDR_TAKEN		0x80
+#define RAN_NO_SUBPROG		0x100
+#define RAN_PAD_CALLS		0x200
+#define RAN_PAD_FIRST		0x400
+#define RAN_WIDE_REC		0x800
+#define RAN_PAD_STACK		0x1000
+#define RAN_DEEP_PAD		0x2000
+#define RAN_NOUNWIND_REC	0x4000
+#define RAN_RESUME_ALIAS	0x8000
+#define RAN_PAD_TAIL_CALL	0x10000
+
 #define CLEANUP_REC(begin, end, landing_pad)			\
 	".pushsection .bpf_cleanup,\"a\",@progbits;"		\
 	".long " begin ";"					\
diff --git a/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c =
b/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
index d1e45b765af2..ffc0b9519168 100644
--- a/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
+++ b/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
@@ -4,6 +4,10 @@
 #include "exceptions_cleanup.h"
 #include "exceptions_cleanup.skel.h"
 #include "exceptions_cleanup_fail.skel.h"
+#include "exceptions_cleanup_shapes.skel.h"
+#include "exceptions_cleanup_freplace.skel.h"
+#include "exceptions_cleanup_pad_freplace.skel.h"
+#include "exceptions_cleanup_ext_table.skel.h"
=20
 /* foo3 threw: every frame that has a pad ran it. */
 #define PADS_FOO3_THREW \
@@ -35,6 +39,314 @@ static void run(struct exceptions_cleanup *skel, __u6=
4 input, __u32 retval,
 	ASSERT_EQ(skel->bss->pads_ran, pads | RAN_BUMP, "pads_ran");
 }
=20
+static void run_shape(struct exceptions_cleanup_shapes *skel, struct bpf=
_program *prog,
+		      __u64 input, __u32 retval, __u64 pads)
+{
+	__u64 ctx =3D 0;
+	int err;
+
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		    .ctx_in =3D &ctx,
+		    .ctx_size_in =3D sizeof(ctx),
+	);
+
+	skel->bss->input =3D input;
+	skel->bss->pads_ran =3D 0;
+
+	err =3D bpf_prog_test_run_opts(bpf_program__fd(prog), &topts);
+	if (!ASSERT_OK(err, "run"))
+		return;
+	ASSERT_EQ(topts.retval, retval, "retval");
+	ASSERT_EQ(skel->bss->pads_ran, pads, "pads_ran");
+}
+
+static void test_freplace(struct exceptions_cleanup_shapes *skel)
+{
+	struct exceptions_cleanup_freplace *fr;
+	struct bpf_link *link;
+	int tgt_fd;
+
+	tgt_fd =3D bpf_program__fd(skel->progs.entry_freplace);
+
+	fr =3D exceptions_cleanup_freplace__open();
+	if (!ASSERT_OK_PTR(fr, "freplace open"))
+		return;
+
+	if (!ASSERT_OK(bpf_program__set_attach_target(fr->progs.new_fr_callee,
+						      tgt_fd, "fr_callee"),
+		       "set_attach_target"))
+		goto out;
+	if (!ASSERT_OK(exceptions_cleanup_freplace__load(fr), "freplace load"))
+		goto out;
+
+	link =3D bpf_program__attach_freplace(fr->progs.new_fr_callee, tgt_fd,
+					    "fr_callee");
+	if (!ASSERT_OK_PTR(link, "attach_freplace"))
+		goto out;
+
+	run_shape(skel, skel->progs.entry_freplace, 101, THROW_COOKIE, 0);
+	bpf_link__destroy(link);
+out:
+	exceptions_cleanup_freplace__destroy(fr);
+}
+
+static void test_pad_calls_freplace(struct exceptions_cleanup_shapes *sk=
el)
+{
+	struct exceptions_cleanup_pad_freplace *fr;
+	struct bpf_link *link;
+	__u64 ctx =3D 0;
+	int tgt_fd, err;
+
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		    .ctx_in =3D &ctx,
+		    .ctx_size_in =3D sizeof(ctx),
+	);
+
+	tgt_fd =3D bpf_program__fd(skel->progs.entry_pad_calls);
+
+	fr =3D exceptions_cleanup_pad_freplace__open();
+	if (!ASSERT_OK_PTR(fr, "pad freplace open"))
+		return;
+
+	if (!ASSERT_OK(bpf_program__set_attach_target(fr->progs.new_pad_callee,
+						      tgt_fd, "pad_callee"),
+		       "set_attach_target"))
+		goto out;
+	if (!ASSERT_OK(exceptions_cleanup_pad_freplace__load(fr), "pad freplace=
 load"))
+		goto out;
+
+	link =3D bpf_program__attach_freplace(fr->progs.new_pad_callee, tgt_fd,
+					    "pad_callee");
+	if (!ASSERT_OK_PTR(link, "attach_freplace"))
+		goto out;
+
+	skel->bss->input =3D 101;
+	skel->bss->pads_ran =3D 0;
+	skel->bss->pad_runs =3D 0;
+
+	err =3D bpf_prog_test_run_opts(tgt_fd, &topts);
+	if (!ASSERT_OK(err, "run"))
+		goto out_link;
+
+	ASSERT_EQ(skel->bss->pad_runs, 1, "pad_runs");
+	ASSERT_EQ(skel->bss->pads_ran, RAN_PAD_CALLS, "pads_ran");
+	ASSERT_EQ(topts.retval, THROW_COOKIE, "retval");
+out_link:
+	bpf_link__destroy(link);
+out:
+	exceptions_cleanup_pad_freplace__destroy(fr);
+}
+
+static void test_ext_table(struct exceptions_cleanup_shapes *skel)
+{
+	struct exceptions_cleanup_ext_table *fr;
+	struct bpf_link *link;
+	int tgt_fd;
+
+	tgt_fd =3D bpf_program__fd(skel->progs.entry_freplace);
+
+	fr =3D exceptions_cleanup_ext_table__open();
+	if (!ASSERT_OK_PTR(fr, "ext table open"))
+		return;
+
+	if (!ASSERT_OK(bpf_program__set_attach_target(fr->progs.new_fr_callee,
+						      tgt_fd, "fr_callee"),
+		       "set_attach_target"))
+		goto out;
+	if (!ASSERT_OK(exceptions_cleanup_ext_table__load(fr), "ext table load"=
))
+		goto out;
+
+	link =3D bpf_program__attach_freplace(fr->progs.new_fr_callee, tgt_fd,
+					    "fr_callee");
+	if (!ASSERT_OK_PTR(link, "attach_freplace"))
+		goto out;
+
+	fr->bss->ext_pad_ran =3D 0;
+	run_shape(skel, skel->progs.entry_freplace, 101, THROW_COOKIE, 0);
+	ASSERT_EQ(fr->bss->ext_pad_ran, 1, "ext_pad_ran");
+
+	bpf_link__destroy(link);
+out:
+	exceptions_cleanup_ext_table__destroy(fr);
+}
+
+static void test_shapes(void)
+{
+	struct exceptions_cleanup_shapes *skel;
+
+	skel =3D exceptions_cleanup_shapes__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "shapes open_and_load"))
+		return;
+
+	/* The frame loads at all only if everything unreachable in it went. */
+	if (test__start_subtest("sweep_no_throw"))
+		run_shape(skel, skel->progs.entry_sweep, 1, 0, 0);
+	if (test__start_subtest("sweep_throw"))
+		run_shape(skel, skel->progs.entry_sweep, 101, THROW_COOKIE, RAN_SWEEP)=
;
+
+	/* The covered call unwinds to the pad; the uncovered one never does. *=
/
+	if (test__start_subtest("shared_callee_no_throw"))
+		run_shape(skel, skel->progs.entry_shared, 1, 2, 0);
+	if (test__start_subtest("shared_callee_throw"))
+		run_shape(skel, skel->progs.entry_shared, 101, THROW_COOKIE, RAN_SHARE=
D);
+
+	/* The pad only sets its bit if it got the frame's own r6-r9 back. */
+	if (test__start_subtest("pad_sees_callee_saved"))
+		run_shape(skel, skel->progs.entry_regs, 101, THROW_COOKIE, RAN_REGS);
+
+	/* Same check, with a tail-call-reachable callee: its spill moves. */
+	if (test__start_subtest("tail_call_no_throw"))
+		run_shape(skel, skel->progs.entry_tail_call, 1, 0, 0);
+	if (test__start_subtest("tail_call_throw"))
+		run_shape(skel, skel->progs.entry_tail_call, 101, THROW_COOKIE,
+			  RAN_TAIL_CALL);
+
+	/* A region around a nounwind call: no pad dispatched, still loads. */
+	if (test__start_subtest("nounwind_region"))
+		run_shape(skel, skel->progs.entry_nounwind_rec, 1, 0, 0);
+
+	/* A pad in the main program's own frame, not in a subprogram. */
+	if (test__start_subtest("main_program_pad"))
+		run_shape(skel, skel->progs.entry_main_pad, 101, THROW_COOKIE,
+			  RAN_MAIN_PAD);
+
+	/* The same call site either way: the subprogram's throw unwinds into
+	 * this frame and runs its pad, an extension's stops at its own boundar=
y.
+	 */
+	if (test__start_subtest("freplace_subprog_throws"))
+		run_shape(skel, skel->progs.entry_freplace, 7, THROW_COOKIE,
+			  RAN_FREPLACE);
+	if (test__start_subtest("freplace_extension_throws"))
+		test_freplace(skel);
+
+	/* A tail call that is taken: the walk ends at the target, so the cooki=
e
+	 * comes back from there and this frame's pad does not run.
+	 */
+	if (test__start_subtest("tail_call_taken")) {
+		int key =3D 0, prog_fd =3D bpf_program__fd(skel->progs.tc_target);
+
+		if (ASSERT_OK(bpf_map_update_elem(bpf_map__fd(skel->maps.taken_table),
+						  &key, &prog_fd, BPF_ANY),
+			      "populate taken_table"))
+			run_shape(skel, skel->progs.entry_tail_taken, 101,
+				  THROW_COOKIE, 0);
+	}
+
+	/* A throwing subprog named by a BPF_PSEUDO_FUNC no helper is handed: t=
he
+	 * callback check has to look at the bpf_loop(), not at the ld_imm64.
+	 */
+	if (test__start_subtest("addr_taken_no_throw"))
+		run_shape(skel, skel->progs.entry_addr_taken, 1, 2, 0);
+	if (test__start_subtest("addr_taken_throw"))
+		run_shape(skel, skel->progs.entry_addr_taken, 101, THROW_COOKIE,
+			  RAN_ADDR_TAKEN);
+
+	/* A record covering bpf_throw() itself rather than a call to a frame
+	 * that throws: raised, caught up with and delivered in one frame.
+	 */
+	if (test__start_subtest("no_subprog_no_throw"))
+		run_shape(skel, skel->progs.entry_no_subprog, 1, 0, 0);
+	if (test__start_subtest("no_subprog_throw"))
+		run_shape(skel, skel->progs.entry_no_subprog, 101, THROW_COOKIE,
+			  RAN_NO_SUBPROG);
+
+	/* A pad that calls a subprogram; with a throwing extension in its plac=
e,
+	 * the nested exception has to stop there, not restart this pad.
+	 */
+	if (test__start_subtest("pad_calls_subprog")) {
+		skel->bss->pad_runs =3D 0;
+		run_shape(skel, skel->progs.entry_pad_calls, 101, THROW_COOKIE,
+			  RAN_PAD_CALLS);
+		ASSERT_EQ(skel->bss->pad_runs, 1, "pad_runs");
+	}
+	if (test__start_subtest("pad_calls_throwing_extension"))
+		test_pad_calls_freplace(skel);
+
+	/* A covered throw the sweep leaves last, where the default exception
+	 * callback is patched in; the pad's bit needs r6-r9 still spilled.
+	 */
+	if (test__start_subtest("pad_before_throw"))
+		run_shape(skel, skel->progs.entry_pad_first, 101, THROW_COOKIE,
+			  RAN_PAD_FIRST);
+
+	/* A region whose last instruction is a 16-byte one, so that end - 1
+	 * names the half of it that is not an instruction.
+	 */
+	if (test__start_subtest("region_ends_on_ldimm64"))
+		run_shape(skel, skel->progs.entry_wide_rec, 101, THROW_COOKIE,
+			  RAN_WIDE_REC);
+
+	/* A pad that reloads from and writes to its own frame's stack, which a
+	 * JIT addressing the frame through the stack pointer gets wrong.
+	 */
+	if (test__start_subtest("pad_uses_own_frame"))
+		run_shape(skel, skel->progs.entry_pad_stack, 101, THROW_COOKIE,
+			  RAN_PAD_STACK);
+
+	/* The same, with an uncovered frame between the throw and the pad. */
+	if (test__start_subtest("pad_two_frames_up"))
+		run_shape(skel, skel->progs.entry_deep_pad, 101, THROW_COOKIE,
+			  RAN_DEEP_PAD);
+
+	/* An extension program with a cleanup table of its own. */
+	if (test__start_subtest("extension_carries_table"))
+		test_ext_table(skel);
+
+	/* A pad terminated by _Unwind_Resume, which libbpf maps onto the kfunc=
;
+	 * every other program here calls bpf_unwind_resume directly.
+	 */
+	if (test__start_subtest("resume_alias"))
+		run_shape(skel, skel->progs.entry_resume_alias, 101,
+			  THROW_COOKIE, RAN_RESUME_ALIAS);
+
+	/* A pad that calls a subprogram which tail calls, array empty and then
+	 * populated: the tail call releases only the callee's own prologue.
+	 */
+	if (test__start_subtest("pad_callee_tail_call")) {
+		int key =3D 0, prog_fd =3D bpf_program__fd(skel->progs.pad_tc_target);
+
+		skel->bss->pad_tc_target_ran =3D 0;
+		skel->bss->pad_runs =3D 0;
+		run_shape(skel, skel->progs.entry_pad_tail_call, 101,
+			  THROW_COOKIE, RAN_PAD_TAIL_CALL);
+		ASSERT_EQ(skel->bss->pad_tc_target_ran, 0, "target not run");
+		ASSERT_EQ(skel->bss->pad_runs, 1, "pad_runs");
+
+		if (ASSERT_OK(bpf_map_update_elem(bpf_map__fd(skel->maps.pad_tc_table)=
,
+						  &key, &prog_fd, BPF_ANY),
+			      "populate pad_tc_table")) {
+			skel->bss->pad_runs =3D 0;
+			run_shape(skel, skel->progs.entry_pad_tail_call, 101,
+				  THROW_COOKIE, RAN_PAD_TAIL_CALL);
+			ASSERT_EQ(skel->bss->pad_tc_target_ran, 1, "target ran");
+			ASSERT_EQ(skel->bss->pad_runs, 1, "pad_runs");
+		}
+	}
+
+	/* The same, into a target that carries a table and throws: that target
+	 * is a boundary, so the outer pad runs once, not twice.
+	 */
+	if (test__start_subtest("pad_callee_tail_call_throws")) {
+		int key =3D 0, prog_fd =3D bpf_program__fd(skel->progs.pad_tc_throw_ta=
rget);
+
+		if (ASSERT_OK(bpf_map_update_elem(bpf_map__fd(skel->maps.pad_tc_table)=
,
+						  &key, &prog_fd, BPF_ANY),
+			      "populate pad_tc_table")) {
+			skel->bss->pad_runs =3D 0;
+			skel->bss->tc_target_pad_runs =3D 0;
+			run_shape(skel, skel->progs.entry_pad_tail_call, 101,
+				  THROW_COOKIE, RAN_PAD_TAIL_CALL);
+			/* The target cleaned up after itself, once. */
+			ASSERT_EQ(skel->bss->tc_target_pad_runs, 1,
+				  "tc_target_pad_runs");
+			/* And the outer pad was not started over. */
+			ASSERT_EQ(skel->bss->pad_runs, 1, "pad_runs");
+		}
+	}
+
+	exceptions_cleanup_shapes__destroy(skel);
+}
+
 void test_exceptions_cleanup(void)
 {
 	char log[8192] =3D {};
@@ -75,5 +387,7 @@ void test_exceptions_cleanup(void)
=20
 	exceptions_cleanup__destroy(skel);
=20
+	test_shapes();
+
 	RUN_TESTS(exceptions_cleanup_fail);
 }
diff --git a/tools/testing/selftests/bpf/progs/exceptions_cleanup_ext_tab=
le.c b/tools/testing/selftests/bpf/progs/exceptions_cleanup_ext_table.c
new file mode 100644
index 000000000000..d14db48d6b29
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/exceptions_cleanup_ext_table.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "exceptions_cleanup.h"
+
+__u64 ext_pad_ran =3D 0;
+
+/* Without a 32-bit int in BTF, libbpf's dummy_ksym var gets type id 0. =
*/
+int btf_int_anchor;
+
+static __used __noinline void __kfunc_btf_anchor(void)
+{
+	bpf_throw(0);
+	bpf_preempt_disable();
+	bpf_preempt_enable();
+	bpf_unwind_resume();
+}
+
+static __used __naked __noinline __u64 ext_frame(void)
+{
+	asm volatile (
+	"call bpf_preempt_disable;"
+	"r1 =3D %[cookie];"
+"1:"	"call bpf_throw;"		/* cleanup region */
+"2:"
+	"exit;"
+"3:"					/* landing pad */
+	"call bpf_preempt_enable;"
+	"r1 =3D %[ext_pad_ran] ll;"
+	"r2 =3D 1;"
+	"*(u64 *)(r1 + 0) =3D r2;"
+	"call bpf_unwind_resume;"
+	"exit;"
+	CLEANUP_REC("1b", "2b", "3b")
+	:
+	: [cookie]"i"(THROW_COOKIE), __imm_addr(ext_pad_ran)
+	: __clobber_all);
+}
+
+SEC("freplace/fr_callee")
+__u64 new_fr_callee(__u64 x)
+{
+	return ext_frame();
+}
+
+char _license[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/progs/exceptions_cleanup_freplac=
e.c b/tools/testing/selftests/bpf/progs/exceptions_cleanup_freplace.c
new file mode 100644
index 000000000000..afb358fd3d40
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/exceptions_cleanup_freplace.c
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "exceptions_cleanup.h"
+
+/* Without a 32-bit int in BTF, libbpf's dummy_ksym var gets type id 0. =
*/
+int btf_int_anchor;
+
+SEC("freplace/fr_callee")
+__u64 new_fr_callee(__u64 x)
+{
+	bpf_throw(THROW_COOKIE);
+	return 0;
+}
+
+char _license[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/progs/exceptions_cleanup_pad_fre=
place.c b/tools/testing/selftests/bpf/progs/exceptions_cleanup_pad_frepla=
ce.c
new file mode 100644
index 000000000000..eabac6baabb7
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/exceptions_cleanup_pad_freplace.c
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "exceptions_cleanup.h"
+
+/* Without a 32-bit int in BTF, libbpf's dummy_ksym var gets type id 0. =
*/
+int btf_int_anchor;
+
+SEC("freplace/pad_callee")
+__u64 new_pad_callee(__u64 x)
+{
+	bpf_throw(INNER_COOKIE);
+	return 0;
+}
+
+char _license[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/progs/exceptions_cleanup_shapes.=
c b/tools/testing/selftests/bpf/progs/exceptions_cleanup_shapes.c
new file mode 100644
index 000000000000..f5eb2ff15c89
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/exceptions_cleanup_shapes.c
@@ -0,0 +1,863 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "exceptions_cleanup.h"
+
+#define PAD_COUNT						\
+	"r1 =3D %[pad_runs] ll;"					\
+	"r2 =3D *(u64 *)(r1 + 0);"				\
+	"r2 +=3D 1;"						\
+	"*(u64 *)(r1 + 0) =3D r2;"
+
+static __used __noinline void __kfunc_btf_anchor(void)
+{
+	bpf_throw(0);
+	bpf_rcu_read_lock();
+	bpf_rcu_read_unlock();
+	bpf_preempt_disable();
+	bpf_preempt_enable();
+	bpf_unwind_resume();
+}
+
+__u64 input =3D 0;
+__u64 magic =3D 0x5eed;
+__u64 pads_ran =3D 0;
+__u64 pad_runs =3D 0;
+
+/*
+ * 1. Everything a cleanup table leaves dead: the continuation after a t=
hrow,
+ * the tail after a pad's resume, an ld_imm64 and a conditional branch i=
nside
+ * that tail, and a block reached only by the dead continuation.
+ */
+static __used __naked __noinline __u64 sweep_frame(void)
+{
+	asm volatile (
+	"r1 =3D %[input] ll;"
+	"r6 =3D *(u64 *)(r1 + 0);"
+	"call bpf_preempt_disable;"
+	"if r6 < 101 goto 6f;"
+	"r1 =3D %[cookie];"
+"1:"	"call bpf_throw;"		/* cleanup region */
+"2:"
+	"goto 3f;"
+"4:"					/* landing pad */
+	"r7 =3D r0;"
+	"call bpf_preempt_enable;"
+	PAD_RAN("%[ran]")
+	"r1 =3D r7;"
+	"call bpf_unwind_resume;"
+	"r1 =3D %[pads_ran] ll;"
+	"r2 =3D *(u64 *)(r1 + 0);"
+	"if r2 =3D=3D 0 goto 5f;"
+	"call bpf_preempt_enable;"
+	"r0 =3D 7;"
+	"exit;"
+"5:"
+	"r0 =3D 8;"
+	"exit;"
+"3:"					/* dead: only the dead goto reaches it */
+	"r0 =3D 9;"
+	"exit;"
+"6:"					/* live: the ordinary return */
+	"call bpf_preempt_enable;"
+	"r0 =3D 0;"
+	"exit;"
+	CLEANUP_REC("1b", "2b", "4b")
+	:
+	: [cookie]"i"(THROW_COOKIE), [ran]"i"(RAN_SWEEP),
+	  __imm_addr(input), __imm_addr(pads_ran)
+	: __clobber_all);
+}
+
+SEC("syscall")
+int entry_sweep(void *ctx)
+{
+	return sweep_frame();
+}
+
+/*
+ * 2. A callee called from both a covered and an uncovered site: the pad=
 is
+ * recorded on the call site, not on the callee. The lock sits between t=
he two
+ * calls because the frame really would leak it if the uncovered call un=
wound.
+ */
+static __used __noinline __u64 shared_callee(__u64 x)
+{
+	if (x > 100)
+		bpf_throw(THROW_COOKIE);
+	return x + 1;
+}
+
+static __used __naked __noinline __u64 shared_frame(void)
+{
+	asm volatile (
+	"r1 =3D %[input] ll;"
+	"r6 =3D *(u64 *)(r1 + 0);"
+	"r1 =3D 0;"
+	"call shared_callee;"
+	"call bpf_rcu_read_lock;"
+	"r1 =3D r6;"
+"1:"	"call shared_callee;"		/* cleanup region */
+"2:"
+	"r6 =3D r0;"
+	"call bpf_rcu_read_unlock;"
+	"r0 =3D r6;"
+	"exit;"
+"3:"					/* landing pad */
+	"r7 =3D r0;"
+	"call bpf_rcu_read_unlock;"
+	PAD_RAN("%[ran]")
+	"r1 =3D r7;"
+	"call bpf_unwind_resume;"
+	"exit;"
+	CLEANUP_REC("1b", "2b", "3b")
+	:
+	: [ran]"i"(RAN_SHARED), __imm_addr(input), __imm_addr(pads_ran)
+	: __clobber_all);
+}
+
+SEC("syscall")
+int entry_shared(void *ctx)
+{
+	return shared_frame();
+}
+
+/*
+ * 3. A landing pad that reads its frame's callee-saved registers, which=
 only
+ * the spill in the discarded callee's prologue still holds. The callee =
fills
+ * r6-r9 with something else before it throws, so the pad's check passes=
 only
+ * if the walker found that spill.
+ */
+#define LOAD_MAGIC_REGS						\
+	"r1 =3D %[magic] ll;"					\
+	"r6 =3D *(u64 *)(r1 + 0);"				\
+	"r7 =3D r6;"						\
+	"r7 +=3D 1;"						\
+	"r8 =3D r6;"						\
+	"r8 +=3D 2;"						\
+	"r9 =3D r6;"						\
+	"r9 +=3D 3;"
+
+/* Set @bit only if r6-r9 still hold what LOAD_MAGIC_REGS put there. */
+#define CHECK_MAGIC_REGS(bit)					\
+	"r1 =3D %[magic] ll;"					\
+	"r2 =3D *(u64 *)(r1 + 0);"				\
+	"if r6 !=3D r2 goto 9f;"					\
+	"r2 +=3D 1;"						\
+	"if r7 !=3D r2 goto 9f;"					\
+	"r2 +=3D 1;"						\
+	"if r8 !=3D r2 goto 9f;"					\
+	"r2 +=3D 1;"						\
+	"if r9 !=3D r2 goto 9f;"					\
+	PAD_RAN(bit)						\
+	"9:"
+
+static __used __naked __noinline __u64 regs_thrower(void)
+{
+	asm volatile (
+	/* Not this frame's to keep, and that is the point. */
+	"r6 =3D 0xdead;"
+	"r7 =3D 0xbeef;"
+	"r8 =3D 0xcafe;"
+	"r9 =3D 0xf00d;"
+	"r1 =3D %[cookie];"
+	"call bpf_throw;"
+	"r0 =3D 0;"
+	"exit;"
+	:
+	: [cookie]"i"(THROW_COOKIE)
+	: __clobber_all);
+}
+
+static __used __naked __noinline __u64 regs_frame(void)
+{
+	asm volatile (
+	LOAD_MAGIC_REGS
+	"call bpf_preempt_disable;"
+"1:"	"call regs_thrower;"		/* cleanup region */
+"2:"
+	"call bpf_preempt_enable;"
+	"r0 =3D 0;"
+	"exit;"
+"3:"					/* landing pad */
+	"call bpf_preempt_enable;"
+	CHECK_MAGIC_REGS("%[ran]")
+	"call bpf_unwind_resume;"
+	"exit;"
+	CLEANUP_REC("1b", "2b", "3b")
+	:
+	: [cookie]"i"(THROW_COOKIE), [ran]"i"(RAN_REGS),
+	  __imm_addr(magic), __imm_addr(pads_ran)
+	: __clobber_all);
+}
+
+SEC("syscall")
+int entry_regs(void *ctx)
+{
+	return regs_frame();
+}
+
+/*
+ * 4. The same, with a tail-call-reachable callee: its prologue pushes t=
he tail
+ * call counter between the program stack and the spill area, so the spi=
ll the
+ * walker reads moves. The array is left empty; being reachable is the p=
oint.
+ */
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u32));
+} jmp_table SEC(".maps");
+
+static __used __noinline __u64 tc_thrower(void *ctx)
+{
+	/* Never taken; its presence is what makes this frame, whose spill the
+	 * walker reads, tail-call-reachable.
+	 */
+	bpf_tail_call_static(ctx, &jmp_table, 0);
+	asm volatile (
+	"r6 =3D 0xdead;"
+	"r7 =3D 0xbeef;"
+	"r8 =3D 0xcafe;"
+	"r9 =3D 0xf00d;"
+	"r1 =3D %[cookie];"
+	"call bpf_throw;"
+	:
+	: [cookie]"i"(THROW_COOKIE)
+	: __clobber_all);
+	return 0;
+}
+
+/*
+ * The frame with the pad is the program itself, and __naked: r1 holds t=
he
+ * context at entry, which is the only place to get one for bpf_tail_cal=
l().
+ */
+SEC("syscall")
+__naked int entry_tail_call(void)
+{
+	asm volatile (
+	"*(u64 *)(r10 - 8) =3D r1;"	/* the context, straight from entry */
+	LOAD_MAGIC_REGS
+	"r1 =3D %[input] ll;"
+	"r1 =3D *(u64 *)(r1 + 0);"
+	"if r1 < 101 goto 8f;"
+	"r1 =3D *(u64 *)(r10 - 8);"
+"1:"	"call tc_thrower;"		/* cleanup region */
+"2:"
+"8:"
+	"r0 =3D 0;"
+	"exit;"
+"3:"					/* landing pad */
+	CHECK_MAGIC_REGS("%[ran]")
+	"call bpf_unwind_resume;"
+	"exit;"
+	CLEANUP_REC("1b", "2b", "3b")
+	:
+	: [ran]"i"(RAN_TAIL_CALL), __imm_addr(input),
+	  __imm_addr(magic), __imm_addr(pads_ran)
+	: __clobber_all);
+}
+
+/*
+ * 5. A landing pad in the main program's own frame. jit_subprogs() comp=
iles it
+ * as func[0], but the ksym the walker finds is the outer bpf_prog's, so=
 the
+ * table has to be handed over or the pad is never dispatched -- silentl=
y.
+ */
+SEC("syscall")
+__naked int entry_main_pad(void)
+{
+	asm volatile (
+	LOAD_MAGIC_REGS
+	"r1 =3D %[input] ll;"
+	"r1 =3D *(u64 *)(r1 + 0);"
+	"if r1 < 101 goto 8f;"
+"1:"	"call regs_thrower;"		/* cleanup region */
+"2:"
+"8:"
+	"r0 =3D 0;"
+	"exit;"
+"3:"					/* landing pad */
+	CHECK_MAGIC_REGS("%[ran]")
+	"call bpf_unwind_resume;"
+	"exit;"
+	CLEANUP_REC("1b", "2b", "3b")
+	:
+	: [ran]"i"(RAN_MAIN_PAD), __imm_addr(input),
+	  __imm_addr(magic), __imm_addr(pads_ran)
+	: __clobber_all);
+}
+
+/*
+ * 6. A tail call that is really taken: the target is a program in its o=
wn
+ * right, so the walk ends there and this frame's pad does not run. The =
callee
+ * can also throw on a path never taken, which keeps the pad out of the =
sweep.
+ */
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u32));
+} taken_table SEC(".maps");
+
+SEC("syscall")
+int tc_target(void *ctx)
+{
+	bpf_throw(THROW_COOKIE);
+	return 0;
+}
+
+static __used __noinline __u64 tc_taken_callee(void *ctx, __u64 x)
+{
+	/* Never true at run time; the verifier cannot know that, and its
+	 * unwind out of here is what keeps the caller's pad alive.
+	 */
+	if (x =3D=3D 7)
+		bpf_throw(THROW_COOKIE);
+	bpf_tail_call_static(ctx, &taken_table, 0);
+	return 0;
+}
+
+SEC("syscall")
+__naked int entry_tail_taken(void)
+{
+	asm volatile (
+	"*(u64 *)(r10 - 8) =3D r1;"	/* the context, straight from entry */
+	"r1 =3D %[input] ll;"
+	"r2 =3D *(u64 *)(r1 + 0);"
+	"if r2 < 101 goto 8f;"
+	"r1 =3D *(u64 *)(r10 - 8);"
+"1:"	"call tc_taken_callee;"		/* cleanup region */
+"2:"
+	"exit;"				/* the cookie, delivered at tc_target */
+"8:"
+	"r0 =3D 0;"
+	"exit;"
+"3:"					/* landing pad: must not run */
+	PAD_RAN("%[ran]")
+	"call bpf_unwind_resume;"
+	"exit;"
+	CLEANUP_REC("1b", "2b", "3b")
+	:
+	: [ran]"i"(RAN_TC_TAKEN), __imm_addr(input), __imm_addr(pads_ran)
+	: __clobber_all);
+}
+
+/*
+ * 7. An extension program over the callee of a covered call. The walk e=
nds in
+ * the extension's frame, as it does for a tail call target, so the pad =
does
+ * not run; fr_callee() can also throw by itself, giving the same call s=
ite
+ * both answers.
+ */
+__noinline __u64 fr_callee(__u64 x)
+{
+	if (x =3D=3D 7)
+		bpf_throw(THROW_COOKIE);
+	return x + 1;
+}
+
+SEC("syscall")
+__naked int entry_freplace(void)
+{
+	asm volatile (
+	"r1 =3D %[input] ll;"
+	"r1 =3D *(u64 *)(r1 + 0);"
+"1:"	"call fr_callee;"		/* cleanup region */
+"2:"
+	"exit;"
+"3:"					/* landing pad */
+	PAD_RAN("%[ran]")
+	"call bpf_unwind_resume;"
+	"exit;"
+	CLEANUP_REC("1b", "2b", "3b")
+	:
+	: [ran]"i"(RAN_FREPLACE), __imm_addr(input), __imm_addr(pads_ran)
+	: __clobber_all);
+}
+
+/*
+ * 8. A throwing subprogram named by a BPF_PSEUDO_FUNC on a path never t=
aken.
+ * Handing one to a helper is what is refused, not naming it, so anythin=
g going
+ * by the ld_imm64 alone turns this program away.
+ */
+static __used __noinline int cb_thrower(__u32 idx, void *ctx)
+{
+	bpf_throw(THROW_COOKIE);
+	return 0;
+}
+
+static __used __noinline __u64 addr_taken_callee(__u64 x)
+{
+	if (x <=3D 100)
+		return x + 1;
+	bpf_throw(THROW_COOKIE);
+	return bpf_loop(1, cb_thrower, NULL, 0);
+}
+
+SEC("syscall")
+__naked int entry_addr_taken(void)
+{
+	asm volatile (
+	"r1 =3D %[input] ll;"
+	"r1 =3D *(u64 *)(r1 + 0);"
+"1:"	"call addr_taken_callee;"	/* cleanup region */
+"2:"
+	"exit;"
+"3:"					/* landing pad */
+	PAD_RAN("%[ran]")
+	"call bpf_unwind_resume;"
+	"exit;"
+	CLEANUP_REC("1b", "2b", "3b")
+	:
+	: [ran]"i"(RAN_ADDR_TAKEN), __imm_addr(input), __imm_addr(pads_ran)
+	: __clobber_all);
+}
+
+/*
+ * 9. A record that covers bpf_throw() itself: the frame that raises the
+ * exception is the frame the record covers and the boundary both, so th=
e pad
+ * runs on the way to delivering the cookie out of the program it came f=
rom.
+ */
+SEC("syscall")
+__naked int entry_no_subprog(void)
+{
+	asm volatile (
+	"r1 =3D %[input] ll;"
+	"r1 =3D *(u64 *)(r1 + 0);"
+	"if r1 < 101 goto 8f;"
+	"call bpf_preempt_disable;"
+	"r1 =3D %[cookie];"
+"1:"	"call bpf_throw;"		/* cleanup region */
+"2:"
+	"exit;"
+"8:"
+	"r0 =3D 0;"
+	"exit;"
+"3:"					/* landing pad */
+	"call bpf_preempt_enable;"
+	PAD_RAN("%[ran]")
+	"call bpf_unwind_resume;"
+	"exit;"
+	CLEANUP_REC("1b", "2b", "3b")
+	:
+	: [cookie]"i"(THROW_COOKIE), [ran]"i"(RAN_NO_SUBPROG),
+	  __imm_addr(input), __imm_addr(pads_ran)
+	: __clobber_all);
+}
+
+/*
+ * 10. A landing pad that calls a subprogram an extension can replace. T=
he
+ * load-time rule cannot see the extension coming, so what stops a neste=
d
+ * exception is the walk, which ends in the extension's own frame. pad_r=
uns
+ * says the pad ran once rather than twice.
+ */
+__noinline __u64 pad_callee(__u64 x)
+{
+	return x + 1;
+}
+
+static __used __noinline __u64 pc_thrower(__u64 x)
+{
+	if (x > 100)
+		bpf_throw(THROW_COOKIE);
+	return x + 1;
+}
+
+static __used __naked __noinline __u64 pad_calls_frame(void)
+{
+	asm volatile (
+	"r1 =3D %[input] ll;"
+	"r1 =3D *(u64 *)(r1 + 0);"
+"1:"	"call pc_thrower;"		/* cleanup region */
+"2:"
+	"exit;"
+"3:"					/* landing pad */
+	"r6 =3D r0;"
+	"r1 =3D 1;"
+	"call pad_callee;"		/* an extension can stand in here */
+	PAD_COUNT
+	PAD_RAN("%[ran]")
+	"r1 =3D r6;"
+	"call bpf_unwind_resume;"
+	"exit;"
+	CLEANUP_REC("1b", "2b", "3b")
+	:
+	: [ran]"i"(RAN_PAD_CALLS), __imm_addr(input), __imm_addr(pads_ran),
+	  __imm_addr(pad_runs)
+	: __clobber_all);
+}
+
+SEC("syscall")
+int entry_pad_calls(void *ctx)
+{
+	return pad_calls_frame();
+}
+
+/*
+ * 11. A covered bpf_throw() the sweep leaves as the last instruction, w=
here
+ * the default exception callback is then patched in -- the one patchlet=
 that
+ * does not keep the call it replaced in the last slot, so the marks hav=
e to
+ * follow it. The r6-r9 check is what reports a lost throw site mark.
+ */
+SEC("syscall")
+__naked int entry_pad_first(void)
+{
+	asm volatile (
+	LOAD_MAGIC_REGS
+	"r1 =3D %[input] ll;"
+	"r1 =3D *(u64 *)(r1 + 0);"
+	"if r1 < 101 goto 7f;"
+	"goto 4f;"
+"3:"					/* landing pad, ahead of the call */
+	CHECK_MAGIC_REGS("%[ran]")
+	"call bpf_unwind_resume;"
+	"exit;"
+"7:"
+	"r0 =3D 0;"
+	"exit;"
+"4:"
+	"r1 =3D %[cookie];"
+"1:"	"call bpf_throw;"		/* cleanup region */
+"2:"
+	"exit;"				/* dead: swept, leaving the call last */
+	CLEANUP_REC("1b", "2b", "3b")
+	:
+	: [cookie]"i"(THROW_COOKIE), [ran]"i"(RAN_PAD_FIRST),
+	  __imm_addr(input), __imm_addr(magic), __imm_addr(pads_ran)
+	: __clobber_all);
+}
+
+/*
+ * 12. A cleanup region whose last instruction is a 16-byte one, so end =
- 1
+ * names the half that is not an instruction of its own. A well formed r=
egion
+ * that a rule against it would turn away.
+ */
+static __used __naked __noinline __u64 wide_rec_frame(void)
+{
+	asm volatile (
+	"r1 =3D %[input] ll;"
+	"r6 =3D *(u64 *)(r1 + 0);"
+	"call bpf_rcu_read_lock;"
+	"r1 =3D r6;"
+"1:"	"call shared_callee;"		/* cleanup region begins */
+	"r1 =3D %[magic] ll;"		/* ... and ends on this pair */
+"2:"
+	"r6 =3D r0;"
+	"call bpf_rcu_read_unlock;"
+	"r0 =3D r6;"
+	"exit;"
+"3:"					/* landing pad */
+	"r7 =3D r0;"
+	"call bpf_rcu_read_unlock;"
+	PAD_RAN("%[ran]")
+	"r1 =3D r7;"
+	"call bpf_unwind_resume;"
+	"exit;"
+	CLEANUP_REC("1b", "2b", "3b")
+	:
+	: [ran]"i"(RAN_WIDE_REC), __imm_addr(input), __imm_addr(magic),
+	  __imm_addr(pads_ran)
+	: __clobber_all);
+}
+
+SEC("syscall")
+int entry_wide_rec(void *ctx)
+{
+	return wide_rec_frame();
+}
+
+/*
+ * 13. A pad that works out of its own frame's stack, the shape every
+ * compiler-generated pad has. A JIT that addresses the frame through th=
e
+ * stack pointer -- arm64 -- has to address a pad's frame some other way=
. Both
+ * directions are here: the reload sees the frame, and the store lands i=
n it.
+ */
+static __used __naked __noinline __u64 pad_stack_frame(void)
+{
+	asm volatile (
+	"r1 =3D %[magic] ll;"
+	"r1 =3D *(u64 *)(r1 + 0);"
+	"*(u64 *)(r10 - 8) =3D r1;"	/* what the pad will want */
+	"r1 =3D %[input] ll;"
+	"r1 =3D *(u64 *)(r1 + 0);"
+"1:"	"call pc_thrower;"		/* cleanup region */
+"2:"
+	"r0 =3D 0;"
+	"exit;"
+"3:"					/* landing pad */
+	"r6 =3D r0;"
+	"r7 =3D *(u64 *)(r10 - 8);"	/* reload it out of the frame */
+	"*(u64 *)(r10 - 16) =3D r7;"	/* and write the frame while here */
+	"r1 =3D %[magic] ll;"
+	"r2 =3D *(u64 *)(r1 + 0);"
+	"if r7 !=3D r2 goto 9f;"
+	"r3 =3D *(u64 *)(r10 - 16);"
+	"if r3 !=3D r2 goto 9f;"
+	PAD_RAN("%[ran]")
+"9:"
+	"r1 =3D r6;"
+	"call bpf_unwind_resume;"
+	"exit;"
+	CLEANUP_REC("1b", "2b", "3b")
+	:
+	: [ran]"i"(RAN_PAD_STACK), __imm_addr(input), __imm_addr(magic),
+	  __imm_addr(pads_ran)
+	: __clobber_all);
+}
+
+SEC("syscall")
+int entry_pad_stack(void *ctx)
+{
+	return pad_stack_frame();
+}
+
+/*
+ * 14. The same, with a frame in between that has no pad of its own, so =
the
+ * liveness query for an outer frame has more than one frame to walk and=
 the
+ * pad has to be counted at every step.
+ */
+static __used __noinline __u64 deep_mid(__u64 x)
+{
+	return pc_thrower(x) + 1;
+}
+
+static __used __naked __noinline __u64 deep_frame(void)
+{
+	asm volatile (
+	"r1 =3D %[magic] ll;"
+	"r1 =3D *(u64 *)(r1 + 0);"
+	"*(u64 *)(r10 - 8) =3D r1;"	/* nothing but the pad reads this */
+	"r1 =3D %[input] ll;"
+	"r1 =3D *(u64 *)(r1 + 0);"
+"1:"	"call deep_mid;"		/* cleanup region */
+"2:"
+	"r0 =3D 0;"
+	"exit;"
+"3:"					/* landing pad */
+	"r6 =3D r0;"
+	"r7 =3D *(u64 *)(r10 - 8);"
+	"r1 =3D %[magic] ll;"
+	"r2 =3D *(u64 *)(r1 + 0);"
+	"if r7 !=3D r2 goto 9f;"
+	PAD_RAN("%[ran]")
+"9:"
+	"r1 =3D r6;"
+	"call bpf_unwind_resume;"
+	"exit;"
+	CLEANUP_REC("1b", "2b", "3b")
+	:
+	: [ran]"i"(RAN_DEEP_PAD), __imm_addr(input), __imm_addr(magic),
+	  __imm_addr(pads_ran)
+	: __clobber_all);
+}
+
+SEC("syscall")
+int entry_deep_pad(void *ctx)
+{
+	return deep_frame();
+}
+
+/*
+ * 15. A region around a call the kernel knows cannot unwind: no call si=
te is
+ * marked, nothing reaches the pad, and the sweep removes it. The progra=
m is
+ * otherwise ordinary and has to load.
+ */
+static __used __naked __noinline __u64 nounwind_rec_frame(void)
+{
+	asm volatile (
+	"call bpf_preempt_disable;"
+"1:"	"call bpf_preempt_enable;"	/* cleanup region: nounwind */
+"2:"
+	"r0 =3D 0;"
+	"exit;"
+"3:"					/* landing pad, never dispatched */
+	PAD_RAN("%[ran]")
+	"call bpf_unwind_resume;"
+	"exit;"
+	CLEANUP_REC("1b", "2b", "3b")
+	:
+	: [ran]"i"(RAN_NOUNWIND_REC), __imm_addr(pads_ran)
+	: __clobber_all);
+}
+
+SEC("syscall")
+int entry_nounwind_rec(void *ctx)
+{
+	return nounwind_rec_frame();
+}
+
+/*
+ * 16. The name a frontend gives the resume. Every pad above calls
+ * bpf_unwind_resume(); LLVM emits _Unwind_Resume() and libbpf maps one =
onto
+ * the other, so this program is what keeps that mapping tested.
+ */
+extern void _Unwind_Resume(void) __ksym;
+
+static __used __noinline void __resume_alias_btf_anchor(void)
+{
+	_Unwind_Resume();
+}
+
+static __used __naked __noinline __u64 resume_alias_frame(void)
+{
+	asm volatile (
+"1:"	"call regs_thrower;"		/* cleanup region */
+"2:"
+	"r0 =3D 0;"
+	"exit;"
+"3:"					/* landing pad */
+	PAD_RAN("%[ran]")
+	"call _Unwind_Resume;"		/* the frontend's name for it */
+	"exit;"
+	CLEANUP_REC("1b", "2b", "3b")
+	:
+	: [ran]"i"(RAN_RESUME_ALIAS), __imm_addr(pads_ran)
+	: __clobber_all);
+}
+
+SEC("syscall")
+int entry_resume_alias(void *ctx)
+{
+	return resume_alias_frame();
+}
+
+/*
+ * 17. A landing pad that calls a subprogram which tail calls. What a pa=
d may
+ * not contain is a tail call of its own, which would unwind a prologue =
the
+ * walker's stack never held; a callee's prologue really did run there, =
so its
+ * tail call releases exactly that and the target returns into the pad. =
The
+ * tail call counter comes out of the unwinding frame, which is one of t=
he
+ * pad's own subprogram and so really holds one.
+ */
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u32));
+} pad_tc_table SEC(".maps");
+
+__u64 pad_tc_target_ran =3D 0;
+
+SEC("syscall")
+int pad_tc_target(void *ctx)
+{
+	pad_tc_target_ran +=3D 1;
+	return 0;
+}
+
+static __used __noinline __u64 pad_tc_callee(void *ctx)
+{
+	/* Taken only once the test has populated the array. */
+	bpf_tail_call_static(ctx, &pad_tc_table, 0);
+	return 0;
+}
+
+/*
+ * The frame with the pad is the program itself, and __naked: r1 holds t=
he
+ * context at entry, which is the only place to get one for bpf_tail_cal=
l().
+ * The pad reloads it from its own frame's stack.
+ */
+SEC("syscall")
+__naked int entry_pad_tail_call(void)
+{
+	asm volatile (
+	"*(u64 *)(r10 - 8) =3D r1;"	/* the context, straight from entry */
+	LOAD_MAGIC_REGS
+	"r1 =3D %[input] ll;"
+	"r1 =3D *(u64 *)(r1 + 0);"
+	"if r1 < 101 goto 8f;"
+"1:"	"call regs_thrower;"		/* cleanup region */
+"2:"
+"8:"
+	"r0 =3D 0;"
+	"exit;"
+"3:"					/* landing pad */
+	PAD_COUNT
+	"r1 =3D *(u64 *)(r10 - 8);"
+	"call pad_tc_callee;"
+	/* Only if the frame survived the callee's tail call. */
+	CHECK_MAGIC_REGS("%[ran]")
+	"call bpf_unwind_resume;"
+	"exit;"
+	CLEANUP_REC("1b", "2b", "3b")
+	:
+	: [ran]"i"(RAN_PAD_TAIL_CALL), __imm_addr(input),
+	  __imm_addr(magic), __imm_addr(pads_ran), __imm_addr(pad_runs)
+	: __clobber_all);
+}
+
+/*
+ * 18. The other target for that same tail call: a program carrying a cl=
eanup
+ * table of its own, which throws while the outer exception is still in =
flight.
+ * The tail call made it a boundary, so the inner walk runs its pad and =
ends in
+ * its own frame, never reaching the walker's frames above it: the outer=
 pad is
+ * not restarted and the outer cookie is still the one delivered. The ou=
ter
+ * pad's r6-r9, which this target overwrites, come back with its frame.
+ */
+__u64 tc_target_pad_runs =3D 0;
+__u64 inner_magic =3D 0xd00d;
+
+static __used __naked __noinline __u64 inner_thrower(void)
+{
+	asm volatile (
+	/* Not this frame's to keep, the same as regs_thrower. */
+	"r6 =3D 0xf00d;"
+	"r7 =3D 0xcafe;"
+	"r8 =3D 0xbeef;"
+	"r9 =3D 0xdead;"
+	"r1 =3D %[cookie];"
+	"call bpf_throw;"
+	"r0 =3D 0;"
+	"exit;"
+	:
+	: [cookie]"i"(INNER_COOKIE)
+	: __clobber_all);
+}
+
+SEC("syscall")
+__naked int pad_tc_throw_target(void)
+{
+	asm volatile (
+	/* Distinct from the outer pad's, so neither can stand in for it. */
+	"r1 =3D %[inner_magic] ll;"
+	"r6 =3D *(u64 *)(r1 + 0);"
+	"r7 =3D r6;"
+	"r7 +=3D 1;"
+	"r8 =3D r6;"
+	"r8 +=3D 2;"
+	"r9 =3D r6;"
+	"r9 +=3D 3;"
+	"r1 =3D %[input] ll;"
+	"r1 =3D *(u64 *)(r1 + 0);"
+	"if r1 < 101 goto 8f;"
+"1:"	"call inner_thrower;"		/* cleanup region */
+"2:"
+"8:"
+	"r0 =3D 0;"
+	"exit;"
+"3:"					/* landing pad */
+	/* This frame's own r6-r9, not the outer pad's. */
+	"r1 =3D %[inner_magic] ll;"
+	"r2 =3D *(u64 *)(r1 + 0);"
+	"if r6 !=3D r2 goto 9f;"
+	"r2 +=3D 1;"
+	"if r7 !=3D r2 goto 9f;"
+	"r2 +=3D 1;"
+	"if r8 !=3D r2 goto 9f;"
+	"r2 +=3D 1;"
+	"if r9 !=3D r2 goto 9f;"
+	"r1 =3D %[tc_target_pad_runs] ll;"
+	"r2 =3D *(u64 *)(r1 + 0);"
+	"r2 +=3D 1;"
+	"*(u64 *)(r1 + 0) =3D r2;"
+"9:"
+	"call bpf_unwind_resume;"
+	"exit;"
+	CLEANUP_REC("1b", "2b", "3b")
+	:
+	: __imm_addr(input), __imm_addr(inner_magic),
+	  __imm_addr(tc_target_pad_runs)
+	: __clobber_all);
+}
+
+char _license[] SEC("license") =3D "GPL";
--=20
2.53.0-Meta

