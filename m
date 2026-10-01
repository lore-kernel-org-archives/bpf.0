Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAC54A49A3
	for <bpf@vger.kernel.org>; Thu,  1 Oct 2026 13:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790861479; cv=none; b=MnZhSLdVlU0P4jfrpwZPNCT0qW8exdy/28yq/Sj1sjVg0dlbLGyBljH1JarmnHxw7f3iORGrXuEneUQLybawm2Ay14RNkFyC390mllle7aSAyOiVH5MKjsnhHMzgIVrM0eWwC5xK2MDhqj1nsM7lVsXwpatB5UHyUv75Ex/cbMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790861479; c=relaxed/simple;
	bh=ttoNprV+Dww+ZMmeeVAAJEjXs1hRQ5m5p+ldBODTua0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lffgB8Yr6U55x+X6ifO+Xb5CQDm6J1siixBw5pmuA//ylO9uJSwC/VJDZm4fLZAsjGu8uIOQ1f3/6vQifixtpof7xizs8XxEMbQ3YDFdC8fO7oFFo4R9fZEo5XdBTtFMlbFixFrS9P8pigT4b4tepFXUeQAjqEs/Jm1aMLdeRps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 8A5262E6E12410; Thu,  1 Oct 2026 06:31:13 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v8 13/22] bpf, arm64: Dispatch exception cleanup pads at run time
Date: Thu,  1 Oct 2026 06:31:13 -0700
Message-ID: <20261001133113.1342612-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261001133006.1335369-1-yonghong.song@linux.dev>
References: <20261001133006.1335369-1-yonghong.song@linux.dev>
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

The dispatch is arch_bpf_stack_walk_ra(). arm64's unwinder reads a frame'=
s
return address from the frame record its callee pushed, so the walk hands
the unwind a copy and, when the unwind changes it, stores the new address
back into that record, the one the previous entry stepped through.

Writing it has to respect pointer authentication: a BPF prologue signs th=
e
link register with PACIASP and the epilogue authenticates it, so what goe=
s
back has to carry the same signature. Its modifier is the stack pointer t=
he
owner was entered with, the record + 16 for a BPF prologue, and only a BP=
F
frame's record is written: bpf_unwind() leaves its own caller's return
address alone. Re-signing the address the unwinder stripped checks that
modifier against the slot before anything is signed with it.

Whether a slot is signed is asked of the build rather than read off the
value: CONFIG_ARM64_PTR_AUTH_KERNEL is what the prologue signs under.
Reading it off the value instead would take a signed address for an
unsigned one whenever its PAC equalled the bits stripping puts back. The
CPU has to implement address authentication too, since "pacia Xd, Xn" is
not in the HINT space and would be undefined without it.

Two frames are not redirected: the first, whose return into bpf_unwind()
comes out of the walk's own frame record, and one the function graph
tracer or a kretprobe has hooked, whose slot holds the trampoline rather
than the address the unwinder reports -- the walk stops there, with a
warning, since the BPF frames are then left returning to paths the
verifier never walked. The frame that called bpf_unwind() is left alone b=
y
the generic code.

bpf_jit_supports_cleanup_pads() can now say yes. A shadow call stack does
not change that: only JITed frames' records are written, JITed code keeps
no x18 copy of its return address, and bpf_unwind()'s own return is never
rewritten.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 arch/arm64/kernel/stacktrace.c | 104 +++++++++++++++++++++++++++++++++
 arch/arm64/net/bpf_jit_comp.c  |  21 +++++++
 2 files changed, 125 insertions(+)

diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrac=
e.c
index 3ebcf8c53fb0..66e3e2eefff4 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -445,6 +445,110 @@ noinline noinstr void arch_bpf_stack_walk(bool (*co=
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
+ * PACIASP's modifier is the stack pointer the owner was entered with, t=
he
+ * record + 16 for a BPF prologue. Only a BPF frame's record is rewritte=
n --
+ * bpf_unwind() leaves its own caller's return address alone -- so that =
is
+ * the modifier; check it by re-signing @pc, which the unwinder stripped
+ * from @stored, before signing anything with it.
+ */
+static bool bpf_unwind_ra_modifier(unsigned long record, u64 stored, u64=
 pc,
+				   u64 *modifier)
+{
+	*modifier =3D record + sizeof(struct frame_record);
+	return bpf_unwind_sign_ra(pc, *modifier) =3D=3D stored;
+}
+
+static bool bpf_unwind_store_ra(unsigned long record, u64 pc, u64 ra)
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
+		if (WARN_ON_ONCE(!bpf_unwind_ra_modifier(record, stored, pc,
+							 &modifier)))
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
+	/*
+	 * The first pc returns into bpf_unwind(), from this walk's own frame
+	 * record: not a BPF frame, and not one to redirect.
+	 */
+	if (!seen_first)
+		return true;
+	/*
+	 * A traced return: the slot holds the tracer's trampoline, not @pc.
+	 * Stopping leaves the BPF frames returning to paths the verifier
+	 * never walked, so warn.
+	 */
+	if (WARN_ON_ONCE(state->flags.fgraph || state->flags.kretprobe))
+		return false;
+
+	/* A consumer that stops still gets to redirect the frame it stopped on=
. */
+	cont =3D data->consume_entry(data->cookie, state->common.pc, 0,
+				   state->common.fp, &ra);
+	if (ra !=3D state->common.pc &&
+	    !bpf_unwind_store_ra(record, state->common.pc, ra))
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
index 475e70653454..8ac98b024194 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -2423,6 +2423,17 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_ve=
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
@@ -3408,6 +3419,16 @@ bool bpf_jit_supports_exceptions(void)
 	return true;
 }
=20
+bool bpf_jit_supports_cleanup_pads(void)
+{
+	/*
+	 * An unwind rewrites the return addresses in JITed frames' records,
+	 * which is what JITed code returns through, shadow call stack or not:
+	 * it keeps no x18 copy. bpf_unwind()'s own return is never rewritten.
+	 */
+	return true;
+}
+
 bool bpf_jit_supports_arena(void)
 {
 	return true;
--=20
2.53.0-Meta

