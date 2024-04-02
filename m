Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC34DDAB
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 02:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712023992; cv=none; b=NfEa3lAHwrmGyC7/luNiRaa1Tzk4k47vz93rmpLIqfI/887jjdyB6YU4+hKtIIJhBjcIukoIDIwCb6QO9M9ZjoyaXSou7f1XP/EbmrIeqEW7FINtTWWWvDATG7d9D2kqB84AmnMx0L4RiQoHB2qOii+WoL8VCcXFM2g2wtth6Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712023992; c=relaxed/simple;
	bh=qC2Mg8r4LjkI5CnhUDlFpiInGesZevfyKLovsjhZA3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T0fbfYqo8nfSCjBYYk+ObYlgxsGHDBcwarWIzbtXXA6ck+vCXlesn5QMc2VoY1ChaEzTntc2Om1Wbw1BEO498c4e5QTwu1ctha7+wuDOOZ/9Wcj7u7HlXN7OLEhj/s4ipJ9R0ToMkblWRCJDffkSXQ2b8sej+5u1kiXX6o5sBeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IaEzw19w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IaEzw19w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED1A2C433C7;
	Tue,  2 Apr 2024 02:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712023992;
	bh=qC2Mg8r4LjkI5CnhUDlFpiInGesZevfyKLovsjhZA3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IaEzw19wEQAezFNm2KZxfmYyYnJ9JmNFlq11slZpj/ATB+edn8JFQRD8YZ/aYytwF
	 u9oahRr6P9eeu60aK1FBPRmv4NdJ927SB1vSOqnC7KABe+rITms7Kf3V6r3y51ruBD
	 Mk92C/55Samfvd7fJ4IWvSQjDobF3pG0iuUT6N9uDy+/drNP4jBtSHJWjnpNBuJqtX
	 eaTJvCI9SEMNjkI/3AkqV/gCLY0YptAdgPckhJgm5YuR8XXZi3yQ9NdwxJTHBarqo5
	 /OdFgQKssla+u/dGEHHngmusYxB8u5hDvnaxcwUYfyoXde0gy80R9/FeXIpgfakmh0
	 YjVzxGwfXPVYg==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 1/4] bpf: add special internal-only MOV instruction to resolve per-CPU addrs
Date: Mon,  1 Apr 2024 19:13:02 -0700
Message-ID: <20240402021307.1012571-2-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240402021307.1012571-1-andrii@kernel.org>
References: <20240402021307.1012571-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new BPF instruction for resolving absolute addresses of per-CPU
data from their per-CPU offsets. This instruction is internal-only and
users are not allowed to use them directly. They will only be used for
internal inlining optimizations for now between BPF verifier and BPF JITs.

We use a special BPF_MOV | BPF_ALU64 | BPF_X form with insn->off field
set to BPF_ADDR_PERCPU = -1. I used negative offset value to distinguish
them from positive ones used by user-exposed instructions.

Such instruction performs a resolution of a per-CPU offset stored in
a register to a valid kernel address which can be dereferenced. It is
useful in any use case where absolute address of a per-CPU data has to
be resolved (e.g., in inlining bpf_map_lookup_elem()).

BPF disassembler is also taught to recognize them to support dumping
final BPF assembly code (non-JIT'ed version).

Add arch-specific way for BPF JITs to mark support for this instructions.

This patch also adds support for these instructions in x86-64 BPF JIT.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 arch/x86/net/bpf_jit_comp.c | 16 ++++++++++++++++
 include/linux/filter.h      | 20 ++++++++++++++++++++
 kernel/bpf/core.c           |  5 +++++
 kernel/bpf/disasm.c         | 14 ++++++++++++++
 4 files changed, 55 insertions(+)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 3b639d6f2f54..af89dd117dce 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1382,6 +1382,17 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
 				maybe_emit_mod(&prog, AUX_REG, dst_reg, true);
 				EMIT3(0x0F, 0x44, add_2reg(0xC0, AUX_REG, dst_reg));
 				break;
+			} else if (insn_is_mov_percpu_addr(insn)) {
+				u32 off = (u32)(unsigned long)&this_cpu_off;
+
+				/* mov <dst>, <src> (if necessary) */
+				EMIT_mov(dst_reg, src_reg);
+
+				/* add <dst>, gs:[<off>] */
+				EMIT2(0x65, add_1mod(0x48, dst_reg));
+				EMIT3(0x03, add_1reg(0x04, dst_reg), 0x25);
+				EMIT(off, 4);
+				break;
 			}
 			fallthrough;
 		case BPF_ALU | BPF_MOV | BPF_X:
@@ -3365,6 +3376,11 @@ bool bpf_jit_supports_subprog_tailcalls(void)
 	return true;
 }
 
+bool bpf_jit_supports_percpu_insn(void)
+{
+	return true;
+}
+
 void bpf_jit_free(struct bpf_prog *prog)
 {
 	if (prog->jited) {
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 44934b968b57..8bcfe6800400 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -178,6 +178,25 @@ struct ctl_table_header;
 		.off   = 0,					\
 		.imm   = 0 })
 
+/* Special (internal-only) form of mov, used to resolve per-CPU addrs:
+ * dst_reg = src_reg + <percpu_base_off>
+ * BPF_ADDR_PERCPU is used as a special insn->off value.
+ */
+#define BPF_ADDR_PERCPU	(-1)
+
+#define BPF_MOV64_PERCPU_REG(DST, SRC)				\
+	((struct bpf_insn) {					\
+		.code  = BPF_ALU64 | BPF_MOV | BPF_X,		\
+		.dst_reg = DST,					\
+		.src_reg = SRC,					\
+		.off   = BPF_ADDR_PERCPU,			\
+		.imm   = 0 })
+
+static inline bool insn_is_mov_percpu_addr(const struct bpf_insn *insn)
+{
+	return insn->code == (BPF_ALU64 | BPF_MOV | BPF_X) && insn->off == BPF_ADDR_PERCPU;
+}
+
 /* Short form of mov, dst_reg = imm32 */
 
 #define BPF_MOV64_IMM(DST, IMM)					\
@@ -970,6 +989,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog);
 void bpf_jit_compile(struct bpf_prog *prog);
 bool bpf_jit_needs_zext(void);
 bool bpf_jit_supports_subprog_tailcalls(void);
+bool bpf_jit_supports_percpu_insn(void);
 bool bpf_jit_supports_kfunc_call(void);
 bool bpf_jit_supports_far_kfunc_call(void);
 bool bpf_jit_supports_exceptions(void);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index ab400cdd7d7a..a996fd8dd303 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2945,6 +2945,11 @@ bool __weak bpf_jit_supports_subprog_tailcalls(void)
 	return false;
 }
 
+bool __weak bpf_jit_supports_percpu_insn(void)
+{
+	return false;
+}
+
 bool __weak bpf_jit_supports_kfunc_call(void)
 {
 	return false;
diff --git a/kernel/bpf/disasm.c b/kernel/bpf/disasm.c
index bd2e2dd04740..309c4aa1b026 100644
--- a/kernel/bpf/disasm.c
+++ b/kernel/bpf/disasm.c
@@ -172,6 +172,17 @@ static bool is_addr_space_cast(const struct bpf_insn *insn)
 		insn->off == BPF_ADDR_SPACE_CAST;
 }
 
+/* Special (internal-only) form of mov, used to resolve per-CPU addrs:
+ * dst_reg = src_reg + <percpu_base_off>
+ * BPF_ADDR_PERCPU is used as a special insn->off value.
+ */
+#define BPF_ADDR_PERCPU	(-1)
+
+static inline bool is_mov_percpu_addr(const struct bpf_insn *insn)
+{
+	return insn->code == (BPF_ALU64 | BPF_MOV | BPF_X) && insn->off == BPF_ADDR_PERCPU;
+}
+
 void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 		    const struct bpf_insn *insn,
 		    bool allow_ptr_leaks)
@@ -194,6 +205,9 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 			verbose(cbs->private_data, "(%02x) r%d = addr_space_cast(r%d, %d, %d)\n",
 				insn->code, insn->dst_reg,
 				insn->src_reg, ((u32)insn->imm) >> 16, (u16)insn->imm);
+		} else if (is_mov_percpu_addr(insn)) {
+			verbose(cbs->private_data, "(%02x) r%d = &(void __percpu *)(r%d)\n",
+				insn->code, insn->dst_reg, insn->src_reg);
 		} else if (BPF_SRC(insn->code) == BPF_X) {
 			verbose(cbs->private_data, "(%02x) %c%d %s %s%c%d\n",
 				insn->code, class == BPF_ALU ? 'w' : 'r',
-- 
2.43.0

