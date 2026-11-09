Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794254299;
	b=t1qDPpGiEJ8IcASOpYnDtQp8wN6nZ2+yKKSw1eKxw6yZMa9c4GK/abQO/tHyqT9GH08t
	 txK0kx8S/bHHoagcQQYPQVcF9sP/uBC0Sb3wECwglxA1cyPzsfPocvUAaapr0+/ucARSj
	 lVf9jUkB1uCHhOiXJax4Zyap3SVV36O4VwhY188mcQb2AxvsOXbtzN22UVUp4dZELn2H8
	 bDxkgEOIcx6DqfPLq2+w9jY+KecJW+xq4lkjPYxtJIwpYgzsBJKgL18HU+JwlGnEkw9ym
	 ITJIBxogTIW9RlOMKQMqGRTmApWPlCMi2BzIiT6GRDEHJVBJlCFfEB69IokMlZTsmAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794254299;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=W4bMQNc+oDgrF+ZAnyEgoNSDSl071SjTbK2SmQPEkiA=;
	b=Lv07LzlCByxdYCECoVQNcBVeSXSO/K8p+8ktKxJ+XlLKgZdc6kEs0JYGlZXEMMCcuWMI
	 37grWS3tHml9CyvznQdPL62dIQ3kVCH9MC2dJ+VZs8VRev82DCcWnhAkahTYOFLEDQl8S
	 DKLoKb14c2/a4N/vgaB0xrUuXE38MEFZtmd07oXR/jalCH9M643JCx8bIYAmpfQjFAeLY
	 IEYTMi4GG3TK9MkNXyACKkrs3yT5LYih9WqAunXnFi+K2ZGV8DVkWqaipMsxSlWCYASjM
	 WHbIaDJZAbxSWQad0AqeUzBqEcozRwN7AYhtvKXAmmVbiuyqemsAwA7Y4Ji8ZxCB3iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FrQ00cIe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4BB606A321;
	Mon,  9 Nov 2026 19:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FrQ00cIe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EAEA1F0089F;
	Mon,  9 Nov 2026 19:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794254298;
	bh=W4bMQNc+oDgrF+ZAnyEgoNSDSl071SjTbK2SmQPEkiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FrQ00cIe2+88b33y7Ds2Z+J7tYdug1uBLhbPwcJZlzj0Ki4B1cikgZXP8PF07i+VG
	 4uZcGkOg8cJeMbqQDOWjN3+SrtKqZF9PvMuI8QYsqK7XcVKQAVj8PKhhO4I1u+f/j0
	 nRIY1Cho+igX+mFkOpuuorJhDBmPsLxJdJFIw9tEI96KzzD3A/DPGjDnxGrXoO+MND
	 JOFz9iKG6DDX6MooAsjmfhvVOqhl4/dpbOx7kn0f+F6H2/qiapAPEXNoYkeBX1u2ui
	 PO4a9TqlV/mVWXwYuFQGEw012gnuBPdCEaDj0zGERxKNKsIjEtPefeukgR3oCRo/aw
	 Lge6dgf8Bpd2Q==
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
Subject: [PATCH 12/13] x86/kprobes: Use kprobe address iterator in in copy_optimized_instructions
Date: Mon,  9 Nov 2026 20:58:13 +0100
Message-ID: <20261109195813.1091366-1-jolsa@kernel.org>
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

copy_optimized_instructions() copies whole instructions until it covers
the five-byte jump. Pass the iterator's kprobe to instruction recovery
at each instruction start, avoiding a separate lookup. Other
__copy_instruction() callers retain the lookup behavior by passing NULL.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/kernel/kprobes/common.h | 3 ++-
 arch/x86/kernel/kprobes/core.c   | 6 +++---
 arch/x86/kernel/kprobes/opt.c    | 9 +++++++--
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/kprobes/common.h b/arch/x86/kernel/kprobes/common.h
index 062746e20c35..c04d01fe075a 100644
--- a/arch/x86/kernel/kprobes/common.h
+++ b/arch/x86/kernel/kprobes/common.h
@@ -86,7 +86,8 @@ extern unsigned long recover_probed_instruction(kprobe_opcode_t *buf,
  * Copy an instruction and adjust the displacement if the instruction
  * uses the %rip-relative addressing mode.
  */
-extern int __copy_instruction(u8 *dest, u8 *src, u8 *real, struct insn *insn);
+extern int __copy_instruction(u8 *dest, u8 *src, u8 *real, struct insn *insn,
+			      struct kprobe **kp);
 
 /* Generate a relative-jump/call instruction */
 extern void synthesize_reljump(void *dest, void *from, void *to);
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 4d63826f6c04..ae6611fdb19a 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -395,10 +395,10 @@ kprobe_opcode_t *arch_adjust_kprobe_addr(unsigned long addr, unsigned long offse
  * instruction, displacement must be adjust by @real, not @dest.
  * This returns the length of copied instruction, or 0 if it has an error.
  */
-int __copy_instruction(u8 *dest, u8 *src, u8 *real, struct insn *insn)
+int __copy_instruction(u8 *dest, u8 *src, u8 *real, struct insn *insn, struct kprobe **kp)
 {
 	kprobe_opcode_t buf[MAX_INSN_SIZE];
-	unsigned long recovered_insn = recover_probed_instruction(buf, (unsigned long)src, NULL);
+	unsigned long recovered_insn = recover_probed_instruction(buf, (unsigned long)src, kp);
 	int ret;
 
 	if (!recovered_insn || !insn)
@@ -735,7 +735,7 @@ static int arch_copy_kprobe(struct kprobe *p)
 	int ret, len;
 
 	/* Copy an instruction with recovering if other optprobe modifies it.*/
-	len = __copy_instruction(buf, p->addr, p->ainsn.insn, &insn);
+	len = __copy_instruction(buf, p->addr, p->ainsn.insn, &insn, NULL);
 	if (!len)
 		return -EINVAL;
 
diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index 9f0af24155ba..058b32564ea0 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -201,14 +201,19 @@ NOKPROBE_SYMBOL(optimized_callback);
 
 static int copy_optimized_instructions(u8 *dest, u8 *src, u8 *real)
 {
+	struct kprobe_iter iter;
+	unsigned long addr;
+	struct kprobe *kp;
 	struct insn insn;
 	int len = 0, ret;
 
-	while (len < JMP32_INSN_SIZE) {
-		ret = __copy_instruction(dest + len, src + len, real + len, &insn);
+	addr = (unsigned long)src;
+	for_each_addr_kprobe(iter, kp, addr, (unsigned long)src + JMP32_INSN_SIZE - 1) {
+		ret = __copy_instruction(dest + len, src + len, real + len, &insn, &kp);
 		if (!ret || !can_boost(&insn, src + len))
 			return -EINVAL;
 		len += ret;
+		addr += ret;
 	}
 	/* Check whether the address range is reserved */
 	if (ftrace_text_reserved(src, src + len - 1) ||
-- 
2.43.0

