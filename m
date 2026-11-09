Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794254272;
	b=Hx1GP47BQ5oVKj8f5RZVGY20rI8OPnzUTuUv2VQlXP1sab5EXOU2t1CtBYcox4P1Zi5g
	 /7xbS8wczKegOqblvkmUmbkbwGKw24k70vqEr/8z8uYIdsqDkWQrOXP9p9xf05ORNrMvf
	 COwz7QjoKZl21qYdpa0JDw0sdHKLwl0nE3dRA+nY+I/jD7e+mN4N1hfscqAHEvK93Axlq
	 enSEQXExEKIUwzDUMTrf5qssp2BIv/E7UTuk4fwRZliPmoLHkqNmSWtFr0K3c+epYSARw
	 n7UaPW9MdIPsfKdCuSnRcNeGphrfQ3jDjhFWChjHj2xO1iB6MDCzS/JphOMkndpqIaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794254272;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=WtB/Gr4QweurnoloccjcgKRxHU5lEYYL+FSGbDrO0tA=;
	b=M2krIpAiVT3a/OyqskJIHyNsrIz0s0oYmz9txjngYL3hPjxU+2enhGX+XsAehjg9PmrR
	 LIpVy7BHVaOI1Q79pF7pz5i0t5TlC8qr8UVKJ2yziSUs5Q2J7t7V9O6a/RATkMr5OSqX3
	 8o9z9XV9eEtB0yGmEV7gSqGr9ODn40p9lA7/ioiXPsEJTBWN4RRN6K3oDe8IygSSUC1yv
	 1DKHqMQ30ibXGIqaBJbHF4aVg4XqbzmFe/b9Bok0gu/UF8sf9bleufhgm2mptZS7h36xa
	 dOfI+mGKjDlBjWYkhpdlZ+pl5fmd2omBPRz84IqZdw34GQpZa80sFNI5QWfgxVM+8pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a89C+eFN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFC5606A321;
	Mon,  9 Nov 2026 19:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a89C+eFN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4BD81F008A2;
	Mon,  9 Nov 2026 19:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794254271;
	bh=WtB/Gr4QweurnoloccjcgKRxHU5lEYYL+FSGbDrO0tA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a89C+eFNd8/KkXbIbi0LVjpFX3kOGiyteMsHga82TGMmCsczYc0+/GSNS7ulHIcWc
	 adAwO7baoKuufcHJeg4V1obqk0HTnNkIXsmSd0ynHxkZkuVZqkD/0RTjGgxTGAVHDP
	 hD8/KMcQw0IBpg5fZA5d12ImvvkmMcRcnBKBHRtCikZ42LVjIk4KjVq0ZcZdO4xaC3
	 d9y/hctaN76YRzHB849g2pbtMOqV2h/diqLc0B0k9RlU57PyaBQas4D02XZ6ZGwu6y
	 nhekpWaX+QsKV+OZ9l3YnH5Sw1zgKk42JVoj2bov+vT+FOf9E1Is5GMJLoc8qrkoeS
	 NdAHTkgIG9nGw==
From: Jiri Olsa <jolsa@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alan Maguire <almagui@kernel.org>,
	x86@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH 10/13] x86/kprobes: Use kprobe address iterator in can_optimize
Date: Mon,  9 Nov 2026 20:57:46 +0100
Message-ID: <20261109195746.1091275-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109194916.1089703-1-jolsa@kernel.org>
References: <20261109194916.1089703-1-jolsa@kernel.org>
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

can_optimize() already iterates over kprobes in the function. Pass the
iterator's kprobe to recover_probed_instruction() so it doesn't need to
look up the kprobe again for each address. Keep the lookup for callers
that pass NULL.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/kernel/kprobes/common.h |  4 ++--
 arch/x86/kernel/kprobes/core.c   | 16 ++++++++--------
 arch/x86/kernel/kprobes/opt.c    |  9 ++++++---
 3 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/kprobes/common.h b/arch/x86/kernel/kprobes/common.h
index e772276f5aa9..062746e20c35 100644
--- a/arch/x86/kernel/kprobes/common.h
+++ b/arch/x86/kernel/kprobes/common.h
@@ -79,9 +79,9 @@
 
 /* Ensure if the instruction can be boostable */
 extern bool can_boost(struct insn *insn, void *orig_addr);
-/* Recover instruction if given address is probed */
+/* Recover instruction; @kp is NULL if the caller needs a kprobe lookup. */
 extern unsigned long recover_probed_instruction(kprobe_opcode_t *buf,
-					 unsigned long addr);
+					 unsigned long addr, struct kprobe **kp);
 /*
  * Copy an instruction and adjust the displacement if the instruction
  * uses the %rip-relative addressing mode.
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 133ff20caccd..6ad8b89a9ba1 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -201,12 +201,11 @@ bool can_boost(struct insn *insn, void *addr)
 }
 
 static unsigned long
-__recover_probed_insn(kprobe_opcode_t *buf, unsigned long addr)
+__recover_probed_insn(kprobe_opcode_t *buf, unsigned long addr, struct kprobe **kpp)
 {
-	struct kprobe *kp;
+	struct kprobe *kp = kpp ? *kpp : get_kprobe((void *)addr);
 	bool faddr;
 
-	kp = get_kprobe((void *)addr);
 	faddr = ftrace_location(addr) == addr;
 	/*
 	 * Use the current code if it is not modified by Kprobe
@@ -251,7 +250,8 @@ __recover_probed_insn(kprobe_opcode_t *buf, unsigned long addr)
  * for preventing to release referencing kprobes.
  * Returns zero if the instruction can not get recovered (or access failed).
  */
-unsigned long recover_probed_instruction(kprobe_opcode_t *buf, unsigned long addr)
+unsigned long recover_probed_instruction(kprobe_opcode_t *buf, unsigned long addr,
+					 struct kprobe **kp)
 {
 	unsigned long __addr;
 
@@ -259,7 +259,7 @@ unsigned long recover_probed_instruction(kprobe_opcode_t *buf, unsigned long add
 	if (__addr != addr)
 		return __addr;
 
-	return __recover_probed_insn(buf, addr);
+	return __recover_probed_insn(buf, addr, kp);
 }
 
 /* Check if insn is INT or UD */
@@ -304,7 +304,7 @@ static bool can_probe(unsigned long paddr)
 		 * relative-jump. Since the relative-jump itself is
 		 * normally used, we just go through if there is no kprobe.
 		 */
-		__addr = recover_probed_instruction(buf, addr);
+		__addr = recover_probed_instruction(buf, addr, NULL);
 		if (!__addr)
 			return false;
 
@@ -327,7 +327,7 @@ static bool can_probe(unsigned long paddr)
 	if (addr != paddr)
 		return false;
 
-	__addr = recover_probed_instruction(buf, addr);
+	__addr = recover_probed_instruction(buf, addr, NULL);
 	if (!__addr)
 		return false;
 
@@ -394,7 +394,7 @@ kprobe_opcode_t *arch_adjust_kprobe_addr(unsigned long addr, unsigned long offse
 int __copy_instruction(u8 *dest, u8 *src, u8 *real, struct insn *insn)
 {
 	kprobe_opcode_t buf[MAX_INSN_SIZE];
-	unsigned long recovered_insn = recover_probed_instruction(buf, (unsigned long)src);
+	unsigned long recovered_insn = recover_probed_instruction(buf, (unsigned long)src, NULL);
 	int ret;
 
 	if (!recovered_insn || !insn)
diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index cdf69c939631..9f0af24155ba 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -257,7 +257,9 @@ static int insn_jump_into_range(struct insn *insn, unsigned long start, int len)
 /* Decode whole function to ensure any instructions don't jump into target */
 static int can_optimize(unsigned long paddr)
 {
-	unsigned long addr, size = 0, offset = 0;
+	unsigned long addr, end, size = 0, offset = 0;
+	struct kprobe_iter iter;
+	struct kprobe *kp;
 	struct insn insn;
 	kprobe_opcode_t buf[MAX_INSN_SIZE];
 
@@ -279,7 +281,8 @@ static int can_optimize(unsigned long paddr)
 
 	/* Decode instructions */
 	addr = paddr - offset;
-	while (addr < paddr - offset + size) { /* Decode until function end */
+	end = paddr - offset + size - 1;
+	for_each_addr_kprobe(iter, kp, addr, end) { /* Decode until function end */
 		unsigned long recovered_insn;
 		int ret;
 
@@ -289,7 +292,7 @@ static int can_optimize(unsigned long paddr)
 			 * we can't optimize kprobe in this function.
 			 */
 			return 0;
-		recovered_insn = recover_probed_instruction(buf, addr);
+		recovered_insn = recover_probed_instruction(buf, addr, &kp);
 		if (!recovered_insn)
 			return 0;
 
-- 
2.43.0

