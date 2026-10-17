Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10863B8D79
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 02:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792205592; cv=none; b=hF1W9AnaPYZAlCFiavZzW06mpaaQ8JamTkmHFyLHy7u3McObWBxfg2q6WTsBJmrpGF54VRllFIT7H7E29BX2IS4w5YuKH7W4YKuTuACbeud8RDrwNEFXKEk9/vER2LarxblhczcXhPCYF4W2tHAKB5alDVlS8Sw7a3wF4zfheOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792205592; c=relaxed/simple;
	bh=raNbR0mXfww8vQQXDL/O4k0kcVV3dcCFHuzPUjs9BwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ORo7DZp8v7/LU/YAgBxaBgLJ8c5eMYVz3MBgx1hKlhgPqn/2XB/bQIgZqaXk/NaYdX2BxosMMhu7WtTZl4PrGbdwFe8leEYEApphKXfmBtIcvQhn6AXw24/2nkNKf5dhlJgZYSxXX7YRDlcKgd0kvWKYc9oB6LimFvhcGu4VAKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 4713C31B3B00BC; Fri, 16 Oct 2026 19:52:53 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v12 16/25] bpf, arm64: Dispatch exception cleanup pads at run time
Date: Fri, 16 Oct 2026 19:52:53 -0700
Message-ID: <20261017025253.1926817-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261017025129.1914859-1-yonghong.song@linux.dev>
References: <20261017025129.1914859-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add what bpf_unwind() relies on to send each frame of a program to its
landing pad or its epilogue on arm64, as the previous patch does for
x86-64:

 - arch_bpf_stack_walk_ra(): walks the frame records with the kernel
   unwinder, handing each return address to the consumer and storing a
   new one back into the record it was read from. The first frame, whose
   return into bpf_unwind() comes from the walk's own record, is
   skipped.
 - With CONFIG_ARM64_PTR_AUTH_KERNEL and a CPU that supports address
   authentication, the new address is signed the way the BPF prologue's
   PACIASP signs the link register, key IA with the record + 16 as
   modifier, using PACIA1716 so that no assembler support for pointer
   authentication is needed.
 - Once the image is final, the JIT fills in the native cleanup table
   and records each function's epilogue address in aux->epilogue_ip,
   where an unwind sends a frame with no pad.
 - bpf_jit_supports_cleanup_pads() says yes, also with a shadow call
   stack: only JITed frames' records are written, and JITed code keeps
   no x18 copy of its return address.

A pad needs no BTI: it is only reached as a return address.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 arch/arm64/kernel/stacktrace.c | 77 ++++++++++++++++++++++++++++++++++
 arch/arm64/net/bpf_jit_comp.c  | 16 +++++++
 2 files changed, 93 insertions(+)

diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrac=
e.c
index 3ebcf8c53fb0..6ff485280da5 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -445,6 +445,83 @@ noinline noinstr void arch_bpf_stack_walk(bool (*con=
sume_entry)(void *cookie, u6
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
+/* PACIA1716 (hint #8): sign x17 with the modifier in x16, under key IA.=
 */
+static u64 bpf_unwind_sign_ra(u64 ra, u64 modifier)
+{
+	register u64 x17 asm("x17") =3D ra;
+	register u64 x16 asm("x16") =3D modifier;
+
+	asm volatile(ARM64_ASM_PREAMBLE
+		     "	hint	#8\n"
+		     : "+r" (x17) : "r" (x16));
+	return x17;
+}
+
+/* PACIASP's modifier is the entry sp, record + 16 for a BPF prologue. *=
/
+static void bpf_unwind_store_ra(unsigned long record, u64 ra)
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
+	    system_supports_address_auth())
+		ra =3D bpf_unwind_sign_ra(ra, record + sizeof(struct frame_record));
+	WRITE_ONCE(rec->lr, ra);
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
+	/* A consumer that stops still gets to redirect the frame it stopped on=
. */
+	cont =3D data->consume_entry(data->cookie, state->common.pc, 0,
+				   state->common.fp, &ra);
+	if (ra !=3D state->common.pc)
+		bpf_unwind_store_ra(record, ra);
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
index 506c4201fec8..c8c0328b3219 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -2422,6 +2422,17 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_ve=
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
@@ -3415,6 +3426,11 @@ bool bpf_jit_supports_exceptions(void)
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

