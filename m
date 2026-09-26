Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10DB38C426
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 05:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790398874; cv=none; b=PausdvN2PAhGrNCQzKQgJQbYKufh34FJMR3f5KLB/rH7YMHTdU6XWJAgNDfdel2XZRWzHKpWY0y/xEtfktaEaplsUC6/GO+mJolwqmjl9suQioTpPftcEF+tG+7+3GzzgZJCnVTf/g4sFxHkk07X4Uxox3DSmTN9uZ5N4eN5H9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790398874; c=relaxed/simple;
	bh=O+rjHl52fA7GlcyowuJOODsak991adqncbA9/qPP2SQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XBosfNMFciuGLszAhlBIPFLGhl98F6oThECUztJ5VH4qbvxsaQ2SGLUL+TRD7BU6lP4PIq2wsrkLCGoxeHoqH39OcZELmPtmS5II1l0iB/xcRY6Wnt/buVksNJApLM04hcooDEKfQtvw9A7ewrActGa8qeYwsfvmL0VwyZ+wD7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id DE3D62D459693E; Fri, 25 Sep 2026 22:01:07 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v6 12/21] bpf, arm64: Dispatch exception cleanup pads at run time
Date: Fri, 25 Sep 2026 22:01:07 -0700
Message-ID: <20260926050107.2218786-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260926050006.2213110-1-yonghong.song@linux.dev>
References: <20260926050006.2213110-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The JIT half: build the native cleanup table from the JIT's byte offsets
once the image is final, emit a BTI at each pad head, address the frame
through the private stack pointer where one is in use, and record the one
epilogue so a frame the unwind passes over can return straight through it=
.

The dispatch is arch_bpf_stack_walk_ra(), which hands the unwind the slot=
 a
frame's return address came out of rather than just the address. arm64's
unwinder reads that address from the frame record the callee pushed, so t=
he
slot belongs to the record the previous entry stepped through.

Writing it has to respect pointer authentication: a BPF prologue signs th=
e
link register with PACIASP and the epilogue authenticates it, so what is
written back has to carry the same signature. Its modifier is the stack
pointer the owner was entered with, which is not known here -- so recover
it by re-signing the address the unwinder stripped until that matches wha=
t
the slot holds. Only where the CPU implements address authentication, and
only where the slot was signed to begin with.

Two frames are not redirected. The walk's own first frame is not returnin=
g
anywhere yet, and a frame whose return the function graph tracer or a
kretprobe has hooked holds the tracer's trampoline in its slot rather tha=
n
the address the unwinder reports, so the walk stops there.

bpf_jit_supports_cleanup_pads() can now say yes.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 arch/arm64/kernel/stacktrace.c | 94 ++++++++++++++++++++++++++++++++++
 arch/arm64/net/bpf_jit_comp.c  | 20 +++++++-
 2 files changed, 113 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrac=
e.c
index 3ebcf8c53fb0..c750c520f24d 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -445,6 +445,100 @@ noinline noinstr void arch_bpf_stack_walk(bool (*co=
nsume_entry)(void *cookie, u6
 	kunwind_stack_walk(arch_bpf_unwind_consume_entry, &data, current, NULL)=
;
 }
=20
+struct bpf_unwind_ra_consume_entry_data {
+	bool (*consume_entry)(void *cookie, u64 ip, u64 sp, u64 fp, u64 *ra);
+	void *cookie;
+	unsigned long record;
+	bool seen_first;
+};
+
+static u64 bpf_unwind_sign_ra(u64 ra, u64 modifier)
+{
+	asm volatile(ARM64_ASM_PREAMBLE
+		     ".arch_extension pauth\n"
+		     "	pacia %0, %1"
+		     : "+r" (ra) : "r" (modifier));
+	return ra;
+}
+
+/*
+ * PACIASP's modifier is the stack pointer the owner was entered with: r=
ecord
+ * + 16 for a BPF prologue, but further up for bpf_unwind()'s own C fram=
e.
+ * Recognise it by re-signing @pc, which the unwinder stripped from @sto=
red.
+ */
+static bool bpf_unwind_ra_modifier(unsigned long record, unsigned long c=
aller_fp,
+				   u64 stored, u64 pc, u64 *modifier)
+{
+	u64 m;
+
+	for (m =3D record + sizeof(struct frame_record); m <=3D caller_fp; m +=3D=
 16) {
+		if (bpf_unwind_sign_ra(pc, m) =3D=3D stored) {
+			*modifier =3D m;
+			return true;
+		}
+	}
+	return false;
+}
+
+static bool bpf_unwind_store_ra(unsigned long record, unsigned long call=
er_fp,
+				u64 pc, u64 ra)
+{
+	struct frame_record *rec =3D (struct frame_record *)record;
+	u64 stored =3D READ_ONCE(rec->lr);
+
+	if (system_supports_address_auth() && stored !=3D pc) {
+		u64 modifier;
+
+		if (WARN_ON_ONCE(!bpf_unwind_ra_modifier(record, caller_fp,
+							 stored, pc, &modifier)))
+			return false;
+		ra =3D bpf_unwind_sign_ra(ra, modifier);
+	}
+	WRITE_ONCE(rec->lr, ra);
+	return true;
+}
+
+static bool
+arch_bpf_unwind_ra_consume_entry(const struct kunwind_state *state, void=
 *cookie)
+{
+	struct bpf_unwind_ra_consume_entry_data *data =3D cookie;
+	unsigned long record =3D data->record;
+	bool seen_first =3D data->seen_first;
+	u64 ra =3D state->common.pc;
+	bool cont;
+
+	/* The record this frame's return address will have come out of. */
+	data->record =3D state->common.fp;
+	data->seen_first =3D true;
+
+	/* The first pc is where the walk runs, not an address it returns to. *=
/
+	if (!seen_first)
+		return true;
+	/* A traced return: the slot holds the tracer's trampoline, not @pc. */
+	if (state->flags.fgraph || state->flags.kretprobe)
+		return false;
+
+	/* A consumer that stops still gets to redirect the frame it stopped on=
. */
+	cont =3D data->consume_entry(data->cookie, state->common.pc, 0,
+				   state->common.fp, &ra);
+	if (ra !=3D state->common.pc &&
+	    !bpf_unwind_store_ra(record, state->common.fp, state->common.pc, ra=
))
+		return false;
+	return cont;
+}
+
+noinline noinstr void arch_bpf_stack_walk_ra(bool (*consume_entry)(void =
*cookie, u64 ip, u64 sp,
+								   u64 fp, u64 *ra),
+					     void *cookie)
+{
+	struct bpf_unwind_ra_consume_entry_data data =3D {
+		.consume_entry =3D consume_entry,
+		.cookie =3D cookie,
+	};
+
+	kunwind_stack_walk(arch_bpf_unwind_ra_consume_entry, &data, current, NU=
LL);
+}
+
 static const char *state_source_string(const struct kunwind_state *state=
)
 {
 	switch (state->source) {
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.=
c
index 475e70653454..2422a1ae1256 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -10,6 +10,7 @@
 #include <linux/arm-smccc.h>
 #include <linux/bitfield.h>
 #include <linux/bpf.h>
+#include <linux/bpf_verifier.h>
 #include <linux/cfi.h>
 #include <linux/filter.h>
 #include <linux/memory.h>
@@ -1380,7 +1381,8 @@ static int build_insn(const struct bpf_verifier_env=
 *env, const struct bpf_insn
 	int ret;
 	bool sign_extend;
=20
-	if (bpf_insn_is_indirect_target(env, ctx->prog, i))
+	if (bpf_insn_is_indirect_target(env, ctx->prog, i) ||
+	    bpf_exc_insn_is_pad(env, ctx->prog, i))
 		emit_bti(A64_BTI_J, ctx);
=20
 	switch (code) {
@@ -2423,6 +2425,17 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_ve=
rifier_env *env, struct bpf_pr
 		 * reasons, expects to point to the next instruction)
 		 */
 		bpf_prog_update_insn_ptrs(prog, ctx.offset, ctx.ro_image);
+
+		/*
+		 * Same byte offsets, consumed by the bpf_unwind() walk:
+		 * turn the cleanup records into native address ranges now that
+		 * the image is final.
+		 */
+		bpf_exc_fill_native_ranges(prog, ctx.offset, ctx.ro_image);
+
+		/* Where an unwind sends a frame with no pad. */
+		prog->aux->epilogue_ip =3D (u64)ctx.ro_image +
+					 ctx.epilogue_offset * AARCH64_INSN_SIZE;
 out_off:
 		if (!ro_header && priv_stack_ptr) {
 			free_percpu(priv_stack_ptr);
@@ -3408,6 +3421,11 @@ bool bpf_jit_supports_exceptions(void)
 	return true;
 }
=20
+bool bpf_jit_supports_cleanup_pads(void)
+{
+	return true;
+}
+
 bool bpf_jit_supports_arena(void)
 {
 	return true;
--=20
2.53.0-Meta

