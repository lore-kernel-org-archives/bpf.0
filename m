Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794401858;
	b=sPR+p7rbPnqAnCfs/UlZjC7DJvZyoyZYGdvpGW7Tft+KimuMFYE1A83AvgcDwe4/QCwg
	 jqfcnKMpN25AH8uakbp8QuFrnq4AAIGH8nhFjrHxeHp0+MVQJuAYV6sUcbqQq9yaD5o8v
	 s2cp4bMiTSWqZ0I1dzzaEXs9wxBDM1zI9ni+UjOBmjKVoPJUnbHDhH4nga7i3dlxkiG+J
	 ZGXnvWT0e4Gx5rPomKnAXo4VJZZEfwoYjFYRGN5ZKF7TMrjJt+HlFEkuT3Bx5D+DtJ73e
	 p6PtmFdtHE1um7Y7BUU8ODBpKtgP7hMoYRwD0V6w9N0pvqPvBH8HLmukdVfPJNh+iog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794401858;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=d6BNph8bLb3YphsZbOhd1LC2XVmGKL1FF2PgN3yYSLw=;
	b=bnsf8etCk+8PnnaA7pG+ylk+NxVDMKqP/bgqUiFu+XKpRuKjJtQhl3U9lTI5JnUFd1p9
	 Jg3D81XBD4SKxArEhUH8LoQF87HDqtHBgnxS0/TXxrYUmBrUwBxWsJMxGapF6FFozCz//
	 U0Yq+ExkfTL6Qyy93+SZs1qbjyZKSIDrUlHuvgDTXwOeqRaOUFcREYEefsdAZRvLCqzgj
	 9IiX+nJk8+eAyMMrSDr1MaxfXJkXxFPjl8uno2fbP2eFtkTiAojgvi8B49UlqOMAvf6du
	 m/UQaDCNOhHChwm10SP9HPVrGqsoIESWqFlVUyOdf3KIdTK52kkQ3JtqxAW7xad47sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nXs2tomL;
	arc=none smtp.remote-ip=74.125.225.139
Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC86C606A324
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 12:57:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC86C606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nXs2tomL
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-4a611dcb60dso7329745e9.0
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 04:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794401856; x=1795006656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d6BNph8bLb3YphsZbOhd1LC2XVmGKL1FF2PgN3yYSLw=;
        b=nXs2tomLR08lhPqrK3ex4LO2BRhIGF7gRJDscU2M/ixKYapEW1Jk2Bt83HmlkZTm69
         spxhyie9eRFA8Hrw9autM5FazlIS3gKW1Rf+aHjIQZI1f0TklKxP6bhmXxq4iPsM0bCA
         maD5I7/XY++8Fvw2J1H2RUkWX8fc2SB5vPbzwJZ3oHP0ouwaj3mam0wnWCHFmNfxp7sP
         xUWynDQ1kj0uCnqicihpkgxvJH15j8zj8ioWsQtHB4/+XFiu/MyQql40VLBcPAzmQqRq
         mHp3Zs6xMJIm2Jj/6nkG7HXrZeFvuaLRPTp128cluOkBiR98mN4YUr1t2SuThcTgj5uV
         Yq+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794401856; x=1795006656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=d6BNph8bLb3YphsZbOhd1LC2XVmGKL1FF2PgN3yYSLw=;
        b=FiAMb6Pa3y173tmBRye4VF79F5/pNrhb9dSFE0DtxjyZ/7S/IaFSiUkFbrHf7CAX1F
         x8CtivbBjjFZ+eYIsAHOHvbOQ9LS93B4xrPSdSb0+hdFIoFiANw2h3yM1eNKMpGdJztS
         7lkgzmlQaQmglq9GspvkXURKre6RwKpUocmwJa4ORozdbgY8F4d6fP+6T/pIi/azXd+1
         FR78cdcMUeewkeq+bC6ZdD8sHh6f7+0p3DRNwLwd9siSZydOq4yPFSJNxeVytUPK0xLB
         NZ8gchqAt4kC/53adgkuXaoDn4ShiKalBtXDfScGiXtJiiy/Ac0zdMnRSZYbTjDT4Mdh
         6j7A==
X-Gm-Message-State: APuU4Z8lldWzShXEm02CqeYQm98mR8ohgl5R5rpjNXJmw5d1p4SIXuNO
	x+7BwRXuj7MIy9JwVQQIJ8naQM7oK0KIwm/xy8/QBggG1FXvr0PmpHrVfc55rD/jv5Y=
X-Gm-Gg: AYBFou3OJJo4rpg9ODivjACTE6CYcmMMTfaOqpyzhzVY8QLpOGsNe1JbgCioKnvyUv7
	sVfc58auSg2bA0jPFrKGOzXQycurbyGmZWBfWUgkppNjQ1mhDHmbU8dx8oigl/uVIGZD9v6Wlks
	It+5/3nV4glcpmonX7HqDpEESx1wmGMRMLK8WE2CHnS8t5NmVzMgfJhReNWO5nlaPAIQ5ZkOBzz
	Sn8Te8UJa4OuiOtBCFzDYN7lruw3VJOeMm18g6FtIKwIoRCcdZwqLSUo1kx/KBjrmrF0bnB2i5S
	CJaY0FibThY/3npkRWZJZ8RPSu/ouf901ccCz71YUoy4Reg5/Zs+ibirZAcgbNYrFdaaYg5nn5F
	dUgn7x0I37KVIw0qPLEjLk9Bi4g0BLK02eExQ8BbDyr6ajTnTUgcf9jyxtgN7NKQ2I2yfK2u3rG
	D/3UP1KX0xH4qzZPEAuU8CZK5xhHQ3y4yljCgUpFEU8aoZcnxceqMCCDZ4c6nrSJgYq2mPVTohj
	PC4qoMmqQkHSfcn3cnZ2x9JWmjVsy9ho4nknwp1dh2kpHMTCIKmDXBshxV14pTJ+9uOMmulcmAW
	caW8QkBphBfiP0edOSwocd/M7G0wgDClbiD/argdGmEw5hvqgAz6F+R2Zg0qhddjqe57bL8bhq5
	rJg775R5HOIYFvMvQDFkAbcfJ1ALUQjE2P5KH55LXDFZaLtK5JhE2K7hvkuNwpph08jDV
X-Received: by 2002:a05:600c:6095:b0:4a2:167a:c93b with SMTP id 5b1f17b1804b1-4ba093b7527mr43677675e9.30.1794401856070;
        Wed, 11 Nov 2026 04:57:36 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba01fe61e6sm142219375e9.6.2026.11.11.04.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 04:57:35 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 03/29] bpf, x86: Capture registers in a native bpf_throw() entry
Date: Wed, 11 Nov 2026 13:57:01 +0100
Message-ID: <7317d71fc8a7251fe32b813e79a2b14d40bdac88.1794399387.git.memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794399387.git.memxor@gmail.com>
References: <cover.1794399387.git.memxor@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5607; i=memxor@gmail.com; h=from:subject:message-id; bh=MJo0L2WPPYKj9g+mUP0Y/WUirPr0QTkMQagh/mN08i0=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIetLzJxgj/o7Xc3BByau6LH79ftm2pW/i7a37L1nvp1Tq D+nVnxrRwkLgxgXg6yYIkvJ/31MxicqfwfaLuOGmcPKBDKEgYtTACayMpiR4eS7I4f2zplwtsQm 66yCzNwbHiKuHdslU2TV9ZY0X+D+t4Phq9gZD8U9gdZmcuuaeI7laocGTQy9d1rNcbZIAHf2zd+ 8AA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add bpf_throw_entry, which the verifier calls instead of bpf_throw(). It
saves the BPF registers of the throw site, R0-R9, on the stack in the
layout of struct bpf_throw_regs, passes the cookie from R1, and calls
bpf_throw_unwind(). That function does not return, so a ud2 follows the
call.

The unwinder needs the callee-saved R6-R9 to restore them for the frames
it discards. The entry also captures R0-R5:

 - later patches describe which register holds a reference at a throw
   site, and any of R0-R9 can hold one there;
 - bpf_throw() does not return, so the compiler has no reason to move a
   reference out of a caller-saved register before the call.

R0-R5 are stored before R6-R9, so the unwinder can index the saved
registers by BPF register number. An architecture may append callee-saved
registers that do not map to a BPF register after R9. None does yet.

The JIT calls the entry directly through __bpf_call_base + imm, so it
needs no ENDBR. objtool generates ORC data for its frame, so the stack
walk in bpf_throw_unwind() passes through the entry to the BPF frames,
where the frame pointer fallback of the ORC unwinder takes over as
before.

The entry calls bpf_throw_unwind(), which is only built with
CONFIG_BPF_SYSCALL. Build the entry with CONFIG_BPF_SYSCALL as well, and
have the JIT return it only then. The JIT itself is built with
CONFIG_BPF_JIT alone, for cBPF.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 arch/x86/net/Makefile       |  1 +
 arch/x86/net/bpf_jit_comp.c |  8 +++++++
 arch/x86/net/bpf_throw.S    | 43 +++++++++++++++++++++++++++++++++++++
 include/linux/bpf_throw.h   | 17 ++++++++++-----
 4 files changed, 64 insertions(+), 5 deletions(-)
 create mode 100644 arch/x86/net/bpf_throw.S

diff --git a/arch/x86/net/Makefile b/arch/x86/net/Makefile
index dddbefc0f439..daef0aa8b28c 100644
--- a/arch/x86/net/Makefile
+++ b/arch/x86/net/Makefile
@@ -7,4 +7,5 @@ ifeq ($(CONFIG_X86_32),y)
         obj-$(CONFIG_BPF_JIT) += bpf_jit_comp32.o
 else
         obj-$(CONFIG_BPF_JIT) += bpf_jit_comp.o bpf_timed_may_goto.o
+        obj-$(CONFIG_BPF_SYSCALL) += bpf_throw.o
 endif
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 19fef39f1445..bdfc5329a00c 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -5135,6 +5135,14 @@ void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp
 #endif
 }
 
+#ifdef CONFIG_BPF_SYSCALL
+/* arch/x86/net/bpf_throw.S, which calls bpf_throw_unwind(); both need the syscall. */
+void *bpf_arch_throw_entry(void)
+{
+	return (void *)bpf_throw_entry;
+}
+#endif
+
 void bpf_arch_poke_desc_update(struct bpf_jit_poke_descriptor *poke,
 			       struct bpf_prog *new, struct bpf_prog *old)
 {
diff --git a/arch/x86/net/bpf_throw.S b/arch/x86/net/bpf_throw.S
new file mode 100644
index 000000000000..67983e5077a6
--- /dev/null
+++ b/arch/x86/net/bpf_throw.S
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <linux/linkage.h>
+#include <asm/nospec-branch.h>
+
+	.code64
+	.section .text, "ax"
+
+/*
+ * Native entry of the bpf_throw() kfunc. The verifier retargets the call to
+ * bpf_throw() here, so the BPF register file of the throw site is still intact
+ * on entry. Capture it on the stack as a struct bpf_throw_regs and hand it to
+ * bpf_throw_unwind(), which never returns.
+ */
+SYM_FUNC_START(bpf_throw_entry)
+	ANNOTATE_NOENDBR
+
+	/* Setup frame. */
+	pushq %rbp
+	movq %rsp, %rbp
+
+	/* Save R9..R0 so that [rsp + 8 * i] is r[i]. */
+	pushq %r15	/* R9 */
+	pushq %r14	/* R8 */
+	pushq %r13	/* R7 */
+	pushq %rbx	/* R6 */
+	pushq %r8	/* R5 */
+	pushq %rcx	/* R4 */
+	pushq %rdx	/* R3 */
+	pushq %rsi	/* R2 */
+	pushq %rdi	/* R1 */
+	pushq %rax	/* R0 */
+
+	/* bpf_throw_unwind(regs, cookie); the cookie is R1 of the caller. */
+	movq %rdi, %rsi
+	movq %rsp, %rdi
+
+	/* Emit call depth accounting for call below. */
+	CALL_DEPTH_ACCOUNT
+	call bpf_throw_unwind
+	ud2
+SYM_FUNC_END(bpf_throw_entry)
diff --git a/include/linux/bpf_throw.h b/include/linux/bpf_throw.h
index 57d974458750..2bb2c18796ac 100644
--- a/include/linux/bpf_throw.h
+++ b/include/linux/bpf_throw.h
@@ -6,21 +6,28 @@
 #ifndef _LINUX_BPF_THROW_H
 #define _LINUX_BPF_THROW_H
 
+/*
+ * The callee-saved registers of the architecture that no BPF register maps
+ * to, which an entry captures after R9. None yet.
+ */
+#define BPF_THROW_NR_EXTRA		0
 /* The callee-saved registers the unwinder tracks: R6..R9. */
 #define BPF_THROW_NR_CALLEE_SAVED	4
-/* The size of struct bpf_throw_regs, for the entries. */
-#define BPF_THROW_REGS_SIZE		(8 * BPF_THROW_NR_CALLEE_SAVED)
+/* The size of struct bpf_throw_regs, for the entries: R0..R9 and the extra ones. */
+#define BPF_THROW_REGS_SIZE		(8 * (10 + BPF_THROW_NR_EXTRA))
 
 #ifndef __ASSEMBLER__
 #include <linux/build_bug.h>
 #include <linux/types.h>
+#include <uapi/linux/bpf.h>
 
 /*
- * The callee-saved registers captured at a throw site, indexed like
- * bpf_prog_aux::callee_reg_off.
+ * The register file captured at a throw site: the BPF registers R0..R9, then
+ * the extra callee-saved registers of the architecture; from R6 on, indexed
+ * like bpf_prog_aux::callee_reg_off.
  */
 struct bpf_throw_regs {
-	u64 saved[BPF_THROW_NR_CALLEE_SAVED];
+	u64 r[BPF_REG_10 + BPF_THROW_NR_EXTRA];
 };
 static_assert(sizeof(struct bpf_throw_regs) == BPF_THROW_REGS_SIZE);
 
-- 
2.53.0

