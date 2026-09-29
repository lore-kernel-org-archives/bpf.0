Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83733264D9
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 00:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790641042; cv=none; b=npa+PNI/cWwqyfHAgsGq/GIXszrKsfchhHJRzDsZOgP3wFXE/EBKqIimwR8wIFf3dwtpPJccNjbxip0CTzosSkqVF27LFhVkm0c6haLf0tQLj0PwDssdDhj4YiMjx70FV14fAaGqeu24of6x3aP4BokqLrfMAe9b8BDsFnM2wrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790641042; c=relaxed/simple;
	bh=OqbiXHH64ihHDaUhfGjSBwi0/bI5+LATY43ZTmM1Mtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VBYHifOKMl2TjfuKeXJ7bqjgXqskt/tUagaxgKV9ZBxZ3cq/S+xQSNngEyuBbPZZnZzATyzhWET6F1+ETK87GpKXh6yB8xLf7CtsXIPdlHv12ksqkKylMxOGDKO1UCX3zfuuyXU+iDopzyez2DvqmLCCZCk4mW03K/r5BkBq1u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 078892DE0758E8; Mon, 28 Sep 2026 17:17:09 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v7 13/22] bpf, arm64: Dispatch exception cleanup pads at run time
Date: Mon, 28 Sep 2026 17:17:09 -0700
Message-ID: <20260929001709.3252802-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929001601.3242665-1-yonghong.song@linux.dev>
References: <20260929001601.3242665-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The JIT half: build the native cleanup table from the JIT's byte offsets
once the image is final, and record the one epilogue so a frame the unwin=
d
passes over can return through it. A pad head needs no BTI of its own: it
is only ever reached as a return address, and a return sets no BTYPE, so
no branch-target check is made.

The dispatch is arch_bpf_stack_walk_ra(), which hands the unwind the slot=
 a
frame's return address came out of rather than just the address. arm64's
unwinder reads that address from the frame record the callee pushed, so t=
he
slot belongs to the record the previous entry stepped through.

Writing it has to respect pointer authentication: a BPF prologue signs th=
e
link register with PACIASP and the epilogue authenticates it, so what goe=
s
back has to carry the same signature. Its modifier is the stack pointer t=
he
owner was entered with, which is not known here, so recover it by
re-signing the address the unwinder stripped until that matches the slot.

Whether a slot is signed is asked of the build rather than read off the
value: CONFIG_ARM64_PTR_AUTH_KERNEL is what the prologue signs under and
what -mbranch-protection is added for. Reading it off the value instead
would take a signed address for an unsigned one whenever its PAC equalled
the bits stripping puts back. The CPU has to implement address
authentication too, since "pacia Xd, Xn" is not in the HINT space and
would be undefined without it.

Two frames are not redirected: the walk's own first frame, not returning
anywhere yet, and one the function graph tracer or a kretprobe has hooked=
,
whose slot holds the trampoline rather than the address the unwinder
reports -- the walk stops there.

bpf_jit_supports_cleanup_pads() can now say yes, except where a shadow
call stack is in use. JITed code restores x30 from the frame record this
walk rewrites, but bpf_unwind() is C and returns from its x18 copy
instead, so the frame that called it would carry on as though nothing had
happened while the frames above it resumed at their pads.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 arch/arm64/kernel/stacktrace.c | 103 +++++++++++++++++++++++++++++++++
 arch/arm64/net/bpf_jit_comp.c  |  26 +++++++++
 2 files changed, 129 insertions(+)

diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrac=
e.c
index 3ebcf8c53fb0..1e46a22cafbd 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -445,6 +445,109 @@ noinline noinstr void arch_bpf_stack_walk(bool (*co=
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
+
+	/*
+	 * Whether the slot holds a signed address is a property of the build,
+	 * not one to be read off the value: a PAC can come out equal to the
+	 * bits stripping puts back, and a signed address would then be taken
+	 * for an unsigned one. What signs is CONFIG_ARM64_PTR_AUTH_KERNEL --
+	 * the prologue here, and -mbranch-protection for everything the
+	 * compiler emits.
+	 */
+	if (IS_ENABLED(CONFIG_ARM64_PTR_AUTH_KERNEL) &&
+	    system_supports_address_auth()) {
+		u64 stored =3D READ_ONCE(rec->lr);
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
index 475e70653454..e483e1e7a2d4 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -10,10 +10,12 @@
 #include <linux/arm-smccc.h>
 #include <linux/bitfield.h>
 #include <linux/bpf.h>
+#include <linux/bpf_verifier.h>
 #include <linux/cfi.h>
 #include <linux/filter.h>
 #include <linux/memory.h>
 #include <linux/printk.h>
+#include <linux/scs.h>
 #include <linux/slab.h>
=20
 #include <asm/asm-extable.h>
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
@@ -3408,6 +3421,19 @@ bool bpf_jit_supports_exceptions(void)
 	return true;
 }
=20
+bool bpf_jit_supports_cleanup_pads(void)
+{
+	/*
+	 * An unwind redirects a frame by rewriting the frame record its
+	 * callee's return address came out of. JITed code restores x30 from
+	 * there, but bpf_unwind() is C: with a shadow call stack it returns
+	 * from the x18 copy instead, so the frame that called it would keep
+	 * going as if nothing had happened while the frames above it resumed
+	 * at their pads.
+	 */
+	return !scs_is_enabled();
+}
+
 bool bpf_jit_supports_arena(void)
 {
 	return true;
--=20
2.53.0-Meta

