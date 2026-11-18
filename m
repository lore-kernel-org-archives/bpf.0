Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794991521;
	b=VAZ88cARKLMzp1/8PCM6OFm9xxsquN/Z2K5Fv42YFajWr7tkU/pbU6tRka55LZibuE8l
	 OO3Bwb6pzSETEm10O5ZF+Gjd7yABTDS8m1r9lS9HP7X7F9oMCi502pf2s1gPZXPhRO4yo
	 lNPliLD66FV9ppzLpIcWegFJixO6ZpFwkanXqjmjIav7y5BSO87tW0u2JHitdQyQLbwQs
	 adW2628AS/dEMD9PCAM/0isWfqHfIolDlCseSJky2kvi61jmHpv5fvCYUfITwLnbfQZJi
	 pc5S3Qycab0uc6KZSSmsmaM0kLcsZ5KheVFZBUMtsgAjzx6yQO2M+HMRKAXukaMbxxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794991521;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=pwLw1PN0N5G0/zB/Y6J6/hvuDTRFVTY/2ACWaIVrQfg=;
	b=E7kyXyL8Ye5M0/UXJLQ6fMQ5K+eECUFzQvZ6H8ILtdVaOiLSA0OdTydXoqAaCXxWjCVB
	 0t3YIjimbjtDa+mqWEd3keKaBrw6zxu7DVq/kY6sQRV5gkcl0LFwvheKEAie8z3VEhR9t
	 XM74wYbdlr0/tiH/3sBsU9tQLoJkRsC0WAeZHViLE1zg/k1qdUWXTyCploGMOAakrkvdG
	 8hVjyS8cZGq0G+Aqcb5k0TRyAtPR1oYM4Psutyk8vPCQDMdUAuHzsh4sh3+eqadiXJtM+
	 jzxahwt8isXJn8Z+ifxz/fDlfXkRn4dJp8tN9BCOhnks8Fn21nmfECoOytfWjSSpo+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XEXixdfx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A08606A32A;
	Wed, 18 Nov 2026 08:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XEXixdfx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13FF81F000C4;
	Wed, 18 Nov 2026 08:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794991521;
	bh=pwLw1PN0N5G0/zB/Y6J6/hvuDTRFVTY/2ACWaIVrQfg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XEXixdfxIzWEjdmYVlLVXQKKC/1OSeLK4Dd2KI/ueBBJ2zsxZdV01ZPnYYNWVPzEW
	 aKSn5DRrdjMn96VrFDKoBWo3Ev/LzcHi2s7mSQnjtViNEbm+GleedWTNvwp3fG08CN
	 1CQJJbNAg0dO84aDdBlajIscTmlxNv9LWlsjdZFS7d5lSVLTM1V0u0I9hAGxeXFkxc
	 OlNJ/zRLaG0REmdXEZ4lNqW8+0MERdiuohXnQQzCK/SidctsNm/jJPr9Ex5b5O4NK6
	 7iK5eLYGfDfHBYuFeF3s34LutpI/mxoKWZ2XrZBmyPmEsMCjW1AO97sGOfu/9uhrnL
	 WWoLktO2YGCJQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>
Cc: bpf@vger.kernel.org,
	x86@kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Will Deacon <will@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Zijlstra <peterz@infradead.org>,
	rtm@csail.mit.edu
Subject: [PATCH bpf 2/2] selftests/bpf: Test which ctx registers a uprobe prog can write
Date: Wed, 18 Nov 2026 09:44:50 +0100
Message-ID: <20261118084451.12590-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118084451.12590-1-jolsa@kernel.org>
References: <20261118084451.12590-1-jolsa@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A uprobe program can write only the pt_regs fields that ptrace can set
to any value. Add verifier tests for x86-64, arm64 and riscv:

  - writes to the general registers, the stack pointer and the
    instruction pointer load
  - writes to cs, ss, flags and orig_ax on x86-64, to pstate and
    orig_x0 on arm64, and to status, badaddr and cause on riscv fail
    with "invalid bpf_context access"
  - a 4-byte write to the low half of a read-only field fails too
  - reading a read-only field still works
  - on x86-64, a kprobe program that writes ctx->flags fails to load

Other arches get one test that just loads.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../bpf/progs/verifier_uprobe_write_ctx.c     | 196 ++++++++++++++++++
 2 files changed, 198 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_uprobe_write_ctx.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 6a494c381266..5a31f04677e0 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -131,6 +131,7 @@
 #include "verifier_unpriv.skel.h"
 #include "verifier_unwind.skel.h"
 #include "verifier_unpriv_perf.skel.h"
+#include "verifier_uprobe_write_ctx.skel.h"
 #include "verifier_value_adj_spill.skel.h"
 #include "verifier_value.skel.h"
 #include "verifier_value_illegal_alu.skel.h"
@@ -321,6 +322,7 @@ void test_verifier_uninit(void)               { RUN(verifier_uninit); }
 void test_verifier_unpriv(void)               { RUN(verifier_unpriv); }
 void test_verifier_unwind(void)               { RUN(verifier_unwind); }
 void test_verifier_unpriv_perf(void)          { RUN(verifier_unpriv_perf); }
+void test_verifier_uprobe_write_ctx(void)     { RUN(verifier_uprobe_write_ctx); }
 void test_verifier_value_adj_spill(void)      { RUN(verifier_value_adj_spill); }
 void test_verifier_value(void)                { RUN(verifier_value); }
 void test_verifier_value_illegal_alu(void)    { RUN(verifier_value_illegal_alu); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_uprobe_write_ctx.c b/tools/testing/selftests/bpf/progs/verifier_uprobe_write_ctx.c
new file mode 100644
index 000000000000..f5ed453b1798
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_uprobe_write_ctx.c
@@ -0,0 +1,196 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+/*
+ * A uprobe prog can write only the registers that ptrace can set to any
+ * value. The fields the kernel restores on the way to user space (segments,
+ * flags, privilege state) are read-only.
+ */
+
+#define WRITE_CTX(name, field, sz)					\
+__naked void name(void)							\
+{									\
+	asm volatile ("							\
+	r2 = 0;								\
+	*(" #sz " *)(r1 + %[off]) = r2;					\
+	r0 = 0;								\
+	exit;								\
+"	:								\
+	: __imm_const(off, offsetof(struct pt_regs, field))		\
+	: __clobber_all);						\
+}
+
+#define READ_CTX(name, field)						\
+__naked void name(void)							\
+{									\
+	asm volatile ("							\
+	r0 = *(u64 *)(r1 + %[off]);					\
+	r0 = 0;								\
+	exit;								\
+"	:								\
+	: __imm_const(off, offsetof(struct pt_regs, field))		\
+	: __clobber_all);						\
+}
+
+#if defined(__TARGET_ARCH_x86)
+
+SEC("uprobe")
+__description("uprobe: write ctx->ax")
+__success
+WRITE_CTX(write_ax, ax, u64)
+
+SEC("uprobe")
+__description("uprobe: write ctx->r15")
+__success
+WRITE_CTX(write_r15, r15, u64)
+
+SEC("uprobe")
+__description("uprobe: write ctx->di")
+__success
+WRITE_CTX(write_di, di, u64)
+
+SEC("uprobe")
+__description("uprobe: write ctx->ip")
+__success
+WRITE_CTX(write_ip, ip, u64)
+
+SEC("uprobe")
+__description("uprobe: write ctx->sp")
+__success
+WRITE_CTX(write_sp, sp, u64)
+
+SEC("uprobe")
+__description("uprobe: write lower half of ctx->ax")
+__success
+WRITE_CTX(write_ax_u32, ax, u32)
+
+SEC("uprobe")
+__description("uprobe: write ctx->orig_ax")
+__failure __msg("invalid bpf_context access")
+WRITE_CTX(write_orig_ax, orig_ax, u64)
+
+SEC("uprobe")
+__description("uprobe: write ctx->cs")
+__failure __msg("invalid bpf_context access")
+WRITE_CTX(write_cs, cs, u64)
+
+SEC("uprobe")
+__description("uprobe: write lower half of ctx->cs")
+__failure __msg("invalid bpf_context access")
+WRITE_CTX(write_cs_u32, cs, u32)
+
+SEC("uprobe")
+__description("uprobe: write ctx->flags")
+__failure __msg("invalid bpf_context access")
+WRITE_CTX(write_flags, flags, u64)
+
+SEC("uprobe")
+__description("uprobe: write ctx->ss")
+__failure __msg("invalid bpf_context access")
+WRITE_CTX(write_ss, ss, u64)
+
+SEC("uprobe")
+__description("uprobe: read ctx->flags")
+__success
+READ_CTX(read_flags, flags)
+
+SEC("kprobe")
+__description("kprobe: write ctx->flags")
+__failure __msg("invalid bpf_context access")
+WRITE_CTX(kprobe_write_flags, flags, u64)
+
+#elif defined(__TARGET_ARCH_arm64)
+
+SEC("uprobe")
+__description("uprobe: write ctx->regs[0]")
+__success
+WRITE_CTX(write_x0, regs[0], u64)
+
+SEC("uprobe")
+__description("uprobe: write ctx->regs[30]")
+__success
+WRITE_CTX(write_x30, regs[30], u64)
+
+SEC("uprobe")
+__description("uprobe: write ctx->sp")
+__success
+WRITE_CTX(write_sp, sp, u64)
+
+SEC("uprobe")
+__description("uprobe: write ctx->pc")
+__success
+WRITE_CTX(write_pc, pc, u64)
+
+SEC("uprobe")
+__description("uprobe: write ctx->pstate")
+__failure __msg("invalid bpf_context access")
+WRITE_CTX(write_pstate, pstate, u64)
+
+SEC("uprobe")
+__description("uprobe: write lower half of ctx->pstate")
+__failure __msg("invalid bpf_context access")
+WRITE_CTX(write_pstate_u32, pstate, u32)
+
+SEC("uprobe")
+__description("uprobe: write ctx->orig_x0")
+__failure __msg("invalid bpf_context access")
+WRITE_CTX(write_orig_x0, orig_x0, u64)
+
+SEC("uprobe")
+__description("uprobe: read ctx->pstate")
+__success
+READ_CTX(read_pstate, pstate)
+
+#elif defined(__TARGET_ARCH_riscv)
+
+SEC("uprobe")
+__description("uprobe: write ctx->epc")
+__success
+WRITE_CTX(write_epc, epc, u64)
+
+SEC("uprobe")
+__description("uprobe: write ctx->a0")
+__success
+WRITE_CTX(write_a0, a0, u64)
+
+SEC("uprobe")
+__description("uprobe: write ctx->t6")
+__success
+WRITE_CTX(write_t6, t6, u64)
+
+SEC("uprobe")
+__description("uprobe: write ctx->status")
+__failure __msg("invalid bpf_context access")
+WRITE_CTX(write_status, status, u64)
+
+SEC("uprobe")
+__description("uprobe: write ctx->badaddr")
+__failure __msg("invalid bpf_context access")
+WRITE_CTX(write_badaddr, badaddr, u64)
+
+SEC("uprobe")
+__description("uprobe: write ctx->cause")
+__failure __msg("invalid bpf_context access")
+WRITE_CTX(write_cause, cause, u64)
+
+SEC("uprobe")
+__description("uprobe: read ctx->status")
+__success
+READ_CTX(read_status, status)
+
+#else
+
+SEC("uprobe")
+__description("uprobe: ctx writes not checked on this arch")
+__success
+__naked void unsupported(void)
+{
+	asm volatile ("r0 = 0; exit;" ::: __clobber_all);
+}
+
+#endif
+
+char _license[] SEC("license") = "GPL";
-- 
2.43.0

