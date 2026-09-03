Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E463B0AE7
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 09:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788427256; cv=none; b=JdqMQNDF6j0SggL18VA5WjWcLgPSUjhVybhP0GVasVML9xsXtTtBQJuIYTpwuHd/0mhpb+cnbXYMpFogLZbZTz6rJ1+V5Mtguv4TkvjrSKQ1rThmHNhcgGD3+BZpbwShbTrzh1CgCQ6Lh8mA1DbxnwLEfsRrpTj5mO2AQjuBo0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788427256; c=relaxed/simple;
	bh=l9g6LyObFZ33EAsrWRSIz4rFP0xgnltUJxSPZxyEsFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AFHuEFZ+SU+zjHVNgK8Wu1izoa64wzOOGIA2rKqFlUJnC9zMsk05O5n6/rD1G5iMWvwnUegYhygEVMpfuJMYnRZghcrnWcgCS/iR5fFZQIkFl+iBdEQne4QLnjhW1aFyvO/KQ8mRj1OXJqNHSwSMjtYy1qcji+gk0zbuymnuYA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P7/OpBFM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P7/OpBFM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 221831F000E9;
	Thu,  3 Sep 2026 09:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788427254;
	bh=B1OzFbsaHbhsCsrCw2vslX6tveU/UJDC0C317Ya+Glc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P7/OpBFMgReH2VqfVv773Lbwz+KOeXldvDdxyarKxyUEindKgGp/YlHlSLYgaLaNI
	 bZaPkAn4jskWPgiA+J1JVjlba2I6OQAvA2d9Ut6PUX58R2U1vXgndcAKZJ3tUG0MvS
	 +2FDN+fnbfm9wEaaxusJFXhH322jXbeQs4YicXVNt8Dm4WadSQNT1eDDe2u44fDPo8
	 sYPF74vokClHgz5/N2VZMO1TdSoMdVksJU796quMc2nw+pS+7HifdqvT7vNa5qbT0T
	 ecp+PhrFDC1jE6MkQ2VWdvGfwI3fDm2xm4b1y4qVEQ5c2gA69gQrzFL3LDh5jeMa7u
	 dnRvyCJZ4znow==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Mike Rapoport <rppt@kernel.org>
Subject: [PATCHv2 bpf-next 1/3] bpf, x86: Split x86_call_depth_emit_accounting in two functions
Date: Thu,  3 Sep 2026 11:20:37 +0200
Message-ID: <20260903092039.477827-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903092039.477827-1-jolsa@kernel.org>
References: <20260903092039.477827-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Splitting the code emitting part out of x86_call_depth_emit_accounting
into separate bpf_call_depth_emit_accounting function, that is defined
in bpf_jit_comp.c object.

There's no functionality change, but this change will ease up following
code emitting patch.

Also moving MAX_PATCH_LEN macro in common header, so we do not need to
define it for the 3rd time.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/include/asm/alternative.h   |  4 ++--
 arch/x86/include/asm/text-patching.h |  2 ++
 arch/x86/kernel/alternative.c        |  2 --
 arch/x86/kernel/callthunks.c         |  7 +------
 arch/x86/net/bpf_jit_comp.c          | 20 ++++++++++++++++----
 5 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 08af86ef090a..2ef493741186 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -83,7 +83,7 @@ extern void callthunks_patch_builtin_calls(void);
 extern void callthunks_patch_module_calls(struct callthunk_sites *sites,
 					  struct module *mod);
 extern void *callthunks_translate_call_dest(void *dest);
-extern int x86_call_depth_emit_accounting(u8 **pprog, void *func, void *ip);
+extern int x86_call_depth_emit_accounting(u8 *insn_buff, void *func, void *ip);
 #else
 static __always_inline void callthunks_patch_builtin_calls(void) {}
 static __always_inline void
@@ -93,7 +93,7 @@ static __always_inline void *callthunks_translate_call_dest(void *dest)
 {
 	return dest;
 }
-static __always_inline int x86_call_depth_emit_accounting(u8 **pprog,
+static __always_inline int x86_call_depth_emit_accounting(u8 *insn_buff,
 							  void *func, void *ip)
 {
 	return 0;
diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
index f2d142a0a862..a0a7c778b0a2 100644
--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -13,6 +13,8 @@
  */
 #define TEXT_POKE_MAX_OPCODE_SIZE	5
 
+#define MAX_PATCH_LEN	(255-1)
+
 extern void text_poke_early(void *addr, const void *opcode, size_t len);
 
 extern void text_poke_apply_relocation(u8 *buf, const u8 * const instr, size_t instrlen, u8 *repl, size_t repl_len);
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 91b1cdd16569..5f9989c8559e 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -18,8 +18,6 @@ int __read_mostly alternatives_patched;
 
 EXPORT_SYMBOL_GPL(alternatives_patched);
 
-#define MAX_PATCH_LEN (255-1)
-
 #define DA_ALL		(~0)
 #define DA_ALT		0x01
 #define DA_RET		0x02
diff --git a/arch/x86/kernel/callthunks.c b/arch/x86/kernel/callthunks.c
index e37728f70322..15b221d06901 100644
--- a/arch/x86/kernel/callthunks.c
+++ b/arch/x86/kernel/callthunks.c
@@ -23,8 +23,6 @@
 
 static int __initdata_or_module debug_callthunks;
 
-#define MAX_PATCH_LEN (255-1)
-
 #define prdbg(fmt, args...)					\
 do {								\
 	if (debug_callthunks)					\
@@ -298,10 +296,9 @@ static bool is_callthunk(void *addr)
 	return !bcmp(pad, insn_buff, tmpl_size);
 }
 
-int x86_call_depth_emit_accounting(u8 **pprog, void *func, void *ip)
+int x86_call_depth_emit_accounting(u8 *insn_buff, void *func, void *ip)
 {
 	unsigned int tmpl_size = SKL_TMPL_SIZE;
-	u8 insn_buff[MAX_PATCH_LEN];
 
 	if (!thunks_initialized)
 		return 0;
@@ -313,8 +310,6 @@ int x86_call_depth_emit_accounting(u8 **pprog, void *func, void *ip)
 	memcpy(insn_buff, skl_call_thunk_template, tmpl_size);
 	text_poke_apply_relocation(insn_buff, ip, tmpl_size, skl_call_thunk_template, tmpl_size);
 
-	memcpy(*pprog, insn_buff, tmpl_size);
-	*pprog += tmpl_size;
 	return tmpl_size;
 }
 #endif
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 48429fae0641..5922bb4728aa 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -149,6 +149,18 @@ static int bpf_size_to_x86_bytes(int bpf_size)
 		return 0;
 }
 
+static int bpf_call_depth_emit_accounting(u8 **pprog, void *func, void *ip)
+{
+	u8 insn_buff[MAX_PATCH_LEN];
+	int size;
+
+	size = x86_call_depth_emit_accounting(insn_buff, func, ip);
+	memcpy(*pprog, insn_buff, size);
+
+	*pprog += size;
+	return size;
+}
+
 /*
  * List of x86 cond jumps opcodes (. + s8)
  * Add 0x10 (and an extra 0x0f) to generate far jumps (. + s32)
@@ -608,7 +620,7 @@ static int emit_call(u8 **pprog, void *func, void *ip)
 static int emit_rsb_call(u8 **pprog, void *func, void *ip)
 {
 	OPTIMIZER_HIDE_VAR(func);
-	ip += x86_call_depth_emit_accounting(pprog, func, ip);
+	ip += bpf_call_depth_emit_accounting(pprog, func, ip);
 	return emit_patch(pprog, func, ip, 0xE8);
 }
 
@@ -1653,7 +1665,7 @@ static int emit_spectre_bhb_barrier(u8 **pprog, u8 *ip,
 		ip += 2;
 
 		func = (u8 *)clear_bhb_loop;
-		ip += x86_call_depth_emit_accounting(&prog, func, ip);
+		ip += bpf_call_depth_emit_accounting(&prog, func, ip);
 
 		if (emit_call(&prog, func, ip))
 			return -EINVAL;
@@ -2661,7 +2673,7 @@ st:			insn_off = insn->off;
 				push_r9(&prog);
 				ip += 2;
 			}
-			ip += x86_call_depth_emit_accounting(&prog, func, ip);
+			ip += bpf_call_depth_emit_accounting(&prog, func, ip);
 			if (emit_call(&prog, func, ip))
 				return -EINVAL;
 			if (priv_frame_ptr)
@@ -3598,7 +3610,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 		 * Direct-call fentry stub, as such it needs accounting for the
 		 * __fentry__ call.
 		 */
-		x86_call_depth_emit_accounting(&prog, NULL, image);
+		bpf_call_depth_emit_accounting(&prog, NULL, image);
 	}
 	EMIT1(0x55);		 /* push rbp */
 	EMIT3(0x48, 0x89, 0xE5); /* mov rbp, rsp */
-- 
2.54.0

