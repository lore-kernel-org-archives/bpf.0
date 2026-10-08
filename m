Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE82383305
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 07:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791445879; cv=none; b=r1voNlTywFSh2hAaEBlw/pa3VsBd64cWUlQXXJC43lPXlEUuQ9b4/dBQcBd47QfdjHjZSF6cMsrfmTpHjEG7S5ZlHqmV17Uoj8kKV5pNKysKuPi1cZO5ih+o5ek24vpNhFKkN5WNAAQCGirgqwUZifjs95LYHatJgSj92dJVKlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791445879; c=relaxed/simple;
	bh=dkuSgntnKIpA8xjgoAyHT7X9CCpsXoOFCqP2I1611Nw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DX0GA/J63wOykUwtrkxFIupb5S7eczzKXuhoE7IAeKz/XWf8a5eWNpg5eb/HE8HU7NeWXF6XbJOqwuVXwL5UM1DSzbmPoKUi3QuwYNg+4eWoAHbMdPbQFAoI7U6inJeuKWn+nhyY/E5kKdVcOnTfhex/h0XoTozL+Ln5rV1S0Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 387D92FDA0C1F4; Thu,  8 Oct 2026 00:51:06 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v9 13/23] bpf, x86: Dispatch exception cleanup pads at run time
Date: Thu,  8 Oct 2026 00:51:06 -0700
Message-ID: <20261008075106.3002280-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261008074959.2993751-1-yonghong.song@linux.dev>
References: <20261008074959.2993751-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

 - arch_bpf_stack_walk_ra(): the ORC walk, handing out each frame's
   return address, state.ip, and the slot it was read from,
   unwind_get_return_address_ptr(). A BPF frame is unwound through its
   frame pointer, which the JIT always sets up.
 - aux->epilogue_ip: the address of the one epilogue the JIT emits per
   function, at the offset it keeps as ctx->cleanup_addr.
 - The native cleanup table, filled in once the image is final.
 - bpf_jit_supports_cleanup_pads() says yes with CONFIG_UNWINDER_ORC, as
   bpf_jit_supports_exceptions() does.

A pad needs no ENDBR: it is only reached as a return address.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 arch/x86/net/bpf_jit_comp.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 083fcd6cf15b..d434871b5a11 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -15,6 +15,7 @@
 #include <linux/memory.h>
 #include <linux/sort.h>
 #include <linux/execmem.h>
+#include <linux/kprobes.h>
 #include <asm/extable.h>
 #include <asm/ftrace.h>
 #include <asm/set_memory.h>
@@ -3279,6 +3280,8 @@ static int do_jit(struct bpf_verifier_env *env, str=
uct bpf_prog *bpf_prog, int *
 			seen_exit =3D true;
 			/* Update cleanup_addr */
 			ctx->cleanup_addr =3D proglen;
+			/* Where an unwind sends a frame with no pad. */
+			bpf_prog->aux->epilogue_ip =3D (u64)image + proglen;
 			if (bpf_prog_was_classic(bpf_prog) &&
 			    !ns_capable_noaudit(&init_user_ns, CAP_SYS_ADMIN)) {
 				if (emit_spectre_bhb_barrier(&prog, ip, bpf_prog))
@@ -4462,6 +4465,13 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_ve=
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
@@ -4600,6 +4610,11 @@ bool bpf_jit_supports_exceptions(void)
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
@@ -4621,6 +4636,27 @@ void arch_bpf_stack_walk(bool (*consume_fn)(void *=
cookie, u64 ip, u64 sp, u64 bp
 #endif
 }
=20
+notrace void arch_bpf_stack_walk_ra(bool (*consume_fn)(void *cookie, u64=
 ip, u64 sp, u64 bp,
+							u64 *ra),
+				    void *cookie)
+{
+#if defined(CONFIG_UNWINDER_ORC)
+	struct unwind_state state;
+	unsigned long addr, *ra;
+
+	for (unwind_start(&state, current, NULL, NULL); !unwind_done(&state);
+	     unwind_next_frame(&state)) {
+		addr =3D state.ip;
+		ra =3D unwind_get_return_address_ptr(&state);
+		if (!ra)
+			break;
+		if (!consume_fn(cookie, (u64)addr, (u64)state.sp, (u64)state.bp, (u64 =
*)ra))
+			break;
+	}
+#endif
+}
+NOKPROBE_SYMBOL(arch_bpf_stack_walk_ra);
+
 void bpf_arch_poke_desc_update(struct bpf_jit_poke_descriptor *poke,
 			       struct bpf_prog *new, struct bpf_prog *old)
 {
--=20
2.53.0-Meta

