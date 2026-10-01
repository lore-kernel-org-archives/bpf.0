Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9995047C11C
	for <bpf@vger.kernel.org>; Thu,  1 Oct 2026 13:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790861476; cv=none; b=COHVGKo7Ogu1TJQjY95duRfySVBSYjvxSZAkFPCctTh383P/N0KwfngSJB/GIaJCP1jxtVr81FVRHtyDJ9j3Tt212eAu7fZ72+isyo4ck1By8dw8BLaoAC4BF4i+cnnuZ/eAIrRVe3ovaQTeolYaSk9Fg8sgRvNQRwVhc0rOwkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790861476; c=relaxed/simple;
	bh=gjqCpxI59habS7VZPRzr4XuC4vY0Qp4QFgHb9FlXWZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=peCIv+fLb6zU98OLV3+Zy4X0nh5puUeG1iHrxRuhJcV2vRhDsjkzNq88HBRDGgBGFPMus/zU5d7eD5DCVfuTIi/f9OpTgqxbtIlNn+nYft2oRMv3yqxECpB7dW0WYGrmVKgebdSSPdVzVsfzjAmCdEe1VAyXDBTcQ5ao3tKZo+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 5CB2E2E6E0DE97; Thu,  1 Oct 2026 06:31:08 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v8 12/22] bpf, x86: Dispatch exception cleanup pads at run time
Date: Thu,  1 Oct 2026 06:31:08 -0700
Message-ID: <20261001133108.1341965-1-yonghong.song@linux.dev>
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

arch_bpf_stack_walk_ra() is the ORC walk with the return-address slot
alongside each frame, which unwind_get_return_address_ptr() already hands
out; writing there is what redirects a frame to its landing pad. The
feature is gated on CONFIG_UNWINDER_ORC for the same reason
arch_bpf_stack_walk() is -- there is no other unwinder here to ask -- and
bpf_jit_supports_cleanup_pads() says yes wherever it is built.

A frame whose return a tracer has hooked is left alone, and the walk stop=
s
there. The unwinder recovers the address such a frame will really return
to, but the slot still holds the function graph or kretprobe trampoline,
so writing it would skip the trampoline and leave its entry for the next
hooked return to pop. x86 has no flag saying a frame was hooked, so the
recovered address and the slot are compared instead. Stopping leaves the
BPF frames returning to paths the verifier never walked, so it warns.

aux->epilogue_ip comes for free: the JIT already emits one epilogue per
(sub)program and every other exit jumps to it, so the offset it keeps as
ctx->cleanup_addr, as a native address, is it. That field has always been
the epilogue and has nothing to do with the cleanup pads despite the name=
.

The rest is bookkeeping: build the native cleanup table from the JIT's
addrs[] once the image is final. A pad head needs no ENDBR of its own: it
is only ever reached as a return address, and IBT checks indirect jumps
and calls, not returns.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 arch/x86/net/bpf_jit_comp.c | 40 +++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 6c7a0578760e..544e8fd759ad 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3278,6 +3278,8 @@ static int do_jit(struct bpf_verifier_env *env, str=
uct bpf_prog *bpf_prog, int *
 			seen_exit =3D true;
 			/* Update cleanup_addr */
 			ctx->cleanup_addr =3D proglen;
+			/* Where an unwind sends a frame with no pad. */
+			bpf_prog->aux->epilogue_ip =3D (u64)image + proglen;
 			if (bpf_prog_was_classic(bpf_prog) &&
 			    !ns_capable_noaudit(&init_user_ns, CAP_SYS_ADMIN)) {
 				if (emit_spectre_bhb_barrier(&prog, ip, bpf_prog))
@@ -4455,6 +4457,13 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_ve=
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
@@ -4593,6 +4602,11 @@ bool bpf_jit_supports_exceptions(void)
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
@@ -4614,6 +4628,32 @@ void arch_bpf_stack_walk(bool (*consume_fn)(void *=
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
+		if (!addr || !ra)
+			break;
+		/*
+		 * A traced return: the slot holds a function graph or kretprobe
+		 * trampoline, not @addr, so it cannot be rewritten. Stopping
+		 * leaves BPF frames returning to unverified paths, so warn.
+		 */
+		if (WARN_ON_ONCE(READ_ONCE_NOCHECK(*ra) !=3D addr))
+			break;
+		if (!consume_fn(cookie, (u64)addr, (u64)state.sp, (u64)state.bp, (u64 =
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

