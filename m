Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4BA3909A3
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 05:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790398865; cv=none; b=Ah6rvGl2We9p/HKUHgjv4C6aUOd+vXIK8lfuTKkzGOOmYZ8wBb1Z1EGJjPH0FiOB8nGYpr5Fd90VNlKAlm3wYO7rD5h4eenKDUlMD3Ruw2esi2wxfWVa/sQp0urCP2FS0tgN4Q7LxBJ/F0K0ev5oX0C4BUq65Ef2uk77U6kxEwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790398865; c=relaxed/simple;
	bh=uvRzCgLktQcDRszN9txVZZGVtSecQVzFYb2DG9o/6Fw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cVBQC1kXLGlsBrrkDVd47ICZ7UTnlCZfxlbACQeJmikNdafEzAmsWVCrplWu6VYIxAs2bMJ8+y9dH/ThJfll8u+2RB4ORXJEIxkFu107Umrb78vy3AaZQBfNxmy28nQgPj0wmps5WRq8QasjbQUFntZ0tYQ0hvpKjYvWfUDrJy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id C1A462D4596905; Fri, 25 Sep 2026 22:01:02 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v6 11/21] bpf, x86: Dispatch exception cleanup pads at run time
Date: Fri, 25 Sep 2026 22:01:02 -0700
Message-ID: <20260926050102.2218021-1-yonghong.song@linux.dev>
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

arch_bpf_stack_walk_ra() is the ORC walk with the return-address slot
alongside each frame, which unwind_get_return_address_ptr() already hands
out; writing there is what redirects a frame to its landing pad. The
feature is gated on CONFIG_UNWINDER_ORC for the same reason
arch_bpf_stack_walk() is -- there is no other unwinder here to ask.

aux->epilogue_ip comes for free: the JIT already emits one epilogue per
(sub)program and every other exit jumps to it, so the offset it keeps as
ctx->cleanup_addr, as a native address, is it. That field has always been
the epilogue and has nothing to do with the cleanup pads despite the name=
.

The rest is bookkeeping: build the native cleanup table from the JIT's
addrs[] once the image is final, and emit an ENDBR at each pad head.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 arch/x86/net/bpf_jit_comp.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 6c7a0578760e..fb7e8ca1aab2 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2150,7 +2150,8 @@ static int do_jit(struct bpf_verifier_env *env, str=
uct bpf_prog *bpf_prog, int *
 				dst_reg =3D X86_REG_R9;
 		}
=20
-		if (bpf_insn_is_indirect_target(env, bpf_prog, i - 1))
+		if (bpf_insn_is_indirect_target(env, bpf_prog, i - 1) ||
+		    bpf_exc_insn_is_pad(env, bpf_prog, i - 1))
 			EMIT_ENDBR();
=20
 		ip =3D image + addrs[i - 1] + (prog - temp);
@@ -3278,6 +3279,8 @@ static int do_jit(struct bpf_verifier_env *env, str=
uct bpf_prog *bpf_prog, int *
 			seen_exit =3D true;
 			/* Update cleanup_addr */
 			ctx->cleanup_addr =3D proglen;
+			/* Where an unwind sends a frame with no pad. */
+			bpf_prog->aux->epilogue_ip =3D (u64)image + proglen;
 			if (bpf_prog_was_classic(bpf_prog) &&
 			    !ns_capable_noaudit(&init_user_ns, CAP_SYS_ADMIN)) {
 				if (emit_spectre_bhb_barrier(&prog, ip, bpf_prog))
@@ -4455,6 +4458,13 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_ve=
rifier_env *env, struct bpf_pr
 		 */
 		bpf_prog_update_insn_ptrs(prog, addrs, image);
=20
+		/*
+		 * Same mapping, consumed by the bpf_unwind() walk:
+		 * turn the cleanup records into native address ranges now
+		 * that the image is final.
+		 */
+		bpf_exc_fill_native_ranges(prog, addrs, image);
+
 		/*
 		 * ctx.prog_offset is used when CFI preambles put code *before*
 		 * the function. See emit_cfi(). For FineIBT specifically this code
@@ -4593,6 +4603,11 @@ bool bpf_jit_supports_exceptions(void)
 	return IS_ENABLED(CONFIG_UNWINDER_ORC);
 }
=20
+bool bpf_jit_supports_cleanup_pads(void)
+{
+	return IS_ENABLED(CONFIG_UNWINDER_ORC);
+}
+
 bool bpf_jit_supports_private_stack(void)
 {
 	return true;
@@ -4614,6 +4629,24 @@ void arch_bpf_stack_walk(bool (*consume_fn)(void *=
cookie, u64 ip, u64 sp, u64 bp
 #endif
 }
=20
+void arch_bpf_stack_walk_ra(bool (*consume_fn)(void *cookie, u64 ip, u64=
 sp, u64 bp, u64 *ra),
+			    void *cookie)
+{
+#if defined(CONFIG_UNWINDER_ORC)
+	struct unwind_state state;
+	unsigned long addr, *ra;
+
+	for (unwind_start(&state, current, NULL, NULL); !unwind_done(&state);
+	     unwind_next_frame(&state)) {
+		addr =3D unwind_get_return_address(&state);
+		ra =3D unwind_get_return_address_ptr(&state);
+		if (!addr || !ra ||
+		    !consume_fn(cookie, (u64)addr, (u64)state.sp, (u64)state.bp, (u64 =
*)ra))
+			break;
+	}
+#endif
+}
+
 void bpf_arch_poke_desc_update(struct bpf_jit_poke_descriptor *poke,
 			       struct bpf_prog *new, struct bpf_prog *old)
 {
--=20
2.53.0-Meta

