Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793148295;
	b=o+D2k+dLAB9pmOnbrxUZI2j8RiZzOtSMrxQdpcxPSKXDqAlgB9EKX8AjPy6JaWELKYzb
	 Qqy0QjfENN5T7odwyEt6fra7gXJrWdV9234pTQ9+hoZTDEj3Nz66CkcJ9URArAdb7Ofxo
	 NKHDods++K0wTznAbCMia1vUYyww3y9PCFXps+WlERxFbN9gta/DCCBTg6nMDLFq1t1RC
	 p26nvGff4zeTgJsAHh/erXYXFQ4mrpZw6bmLnEcrfzlX1N1DVh5yvqomGXIeUB39yr/bp
	 a8s5cYqwHZz1STZC6F8yeXcaQq8uhckCY5NV//cA8splggs9oZJogi16aEu02zSrUzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793148295;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=8azHFD+7ZRWgW2BcKS9xLyTnpcC4TjZKXOV+pAqN3AI=;
	b=S6oCQmfF9nWD6FsnKVHKAxdRCoDGrCkI23QRkKGCMYqJZ2ixRua7N38nb7LnA63+gNMJ
	 hY3ii0ApvpzQK1sFMQox+kx2Z95IckCfZ8/5wL+i5MjBnaVqd0H7owmzL43z37qXT389M
	 P0fqipFR1xQF1763om0JyVyx8VFyaxaavsurWZFcDHMrTvNlwaogx4VUzbAl2rN2+g5OF
	 yHsOB9vfDeEDUP5FUcrPqoqPZUL8N2QHzmJw7wTOzBsrwiFuHpPVX2a4iE/1K33X7tjSf
	 +i+RB6RLW+XaQnMWize7D3FT9433FlJA3Zx/Hksw5q80LEY3wPrf1c9AvEuE2nHW4Kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="r1PXV7/q";
	arc=none smtp.remote-ip=74.125.225.72
Received: from mail-wr2-f8.google.com (mail-wr2-f8.google.com [74.125.225.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DAC606A320
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 00:44:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2DAC606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r1PXV7/q
Received: by mail-wr2-f8.google.com with SMTP id ffacd0b85a97d-48df4afd489so107893f8f.0
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 17:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793148293; x=1793753093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8azHFD+7ZRWgW2BcKS9xLyTnpcC4TjZKXOV+pAqN3AI=;
        b=r1PXV7/qP3TrFjsVxqHYgW7o+FLNATjfver5mSPXxGAnGyp+7W6FW0zCATDH2ia0K1
         6XWEfAq5uauw/ZHaWL3tjd0jGld+j9mZlimy6nZpMGRFFsbZm5I4kjuu2qRVLWRdDF7y
         Tt5/ZNPk4Vrve6CCMSUiU3XaBqEOPUFjVGIkxBNEW7d1/Z/tTtP1T/wgnkXGX9MQ5Jyc
         UTqg59bCqFHiVu+hpoggJ5XFkHktYP8YVitF2kS4SM2+PwSmG5dGuWzMjQZg2wpVSSow
         xBzoISJkOpO/9fwLZez7XHvuQF23A3vPpQT+pv0HrQLjM/bqRGZh39EaSYDl0v0VQW1B
         K1kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793148293; x=1793753093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8azHFD+7ZRWgW2BcKS9xLyTnpcC4TjZKXOV+pAqN3AI=;
        b=glr0tB45bFcvOsL/oXjdWOiUN+5L/V8b73OSx52IFvupvKKD7aNYdqUNqPo9iSRhnD
         zY4x7YC3q2LjbumS/9tKLkt9Vr0M6HtWbeumLzIXb+qCnG5Q0O69rWN2n+MlOpE8470d
         oAVYQaBFivQ7E6TuGFLLYy6B2vXGboQAgKomemn1x338SFEFpb4VHoJWfhpI06rt6bvS
         ozjw7XJ4MyymmVSy+ZKTOxTBKR2AGKJZiRCzUVyY0cw00wMlvIqGF5YKdaQ2fyqDOdSD
         4vOKuDNYiDAQLTJ0wku8G+mzHYYT432jZwbrAT9lWKpJmsQnc1JpkQn61bl9h3QMpplr
         xMSA==
X-Gm-Message-State: AFq9FYLgLfbnvIo81BoVaWvPXTkxt+RwsFOZsDG09G1xNo2RlHE4KGO3
	eoPUtFG+Lw3O7l4c30JBnk4TW56O2YFy27/RAyjP4Pev3ZJiNLwGaUPPp3snOida
X-Gm-Gg: AYBFou0LWkLmUATKC9CzM+yChHmcoWDnqlVNh/U46JiremOmFri1hCmdr1oLXBvngZ5
	6canaX8Vd29iJaMlPIYvXKKGtmh2BJFdDxJN8b2Rbq1dGo3U8XGZNHv6JCJL5G+vjbcukSym9vx
	3qeAedY34kWRaEudoHggbc+CLNYdgKJyJelHVlQ8sKRB6ndqlKzV7fPpujEwaHfcX7r5lgjUlhR
	UijF4u+XTpUtnEf2YUYMah7hk8OmmZ9a1h6dPoNXeK/b5BYFlGKn/elcnA3KpekjzO9bVg0ZVWO
	Al987MIrbuZnKv/9LkV8xLWZYVPUO0h50ztt5M0ukva7tLJy6uVlLYrTediJq1cSAMgen4rG6EL
	VoGNjF3gCp1W06g+GdrG8yUnKmx2iF2q1y80gkdYT6MroqCTHcj+99n9khtR8WSOvFrd5pp9q+m
	KvGmIXU1CEWhs02tawohSCBuEj4l/DbTvvDGbqjgwqU6eAbvzejYfvXLDNhy9G23ZjTH1pEjhFl
	2mADtWkWvuPw8nzh5ZG7Nw3zGEiQUwYrVJLi9aAn+syvW5tYFCB5SH6VntcYoPAdZgS/jA5zfwV
	WTMrxmK3YrqAU8XGzC05WCl4PGDhnbn1CxiOfxoZw0kNH8tvUwuhRHJ5ZVLEJYYc9qRljP3A67Q
	73ST4ZtN97u9jxcS9JCSx
X-Received: by 2002:a05:6000:607:b0:48d:f034:7fcd with SMTP id ffacd0b85a97d-48e5d5d1486mr2212316f8f.51.1793148292742;
        Tue, 27 Oct 2026 17:44:52 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3eb8f37csm20662724f8f.8.2026.10.27.17.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 17:44:52 -0700 (PDT)
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
Subject: [RFC PATCH bpf-next v1 01/11] bpf: Give a helper a way to call its callback with a pad
Date: Wed, 28 Oct 2026 01:44:38 +0100
Message-ID: <03d6c53ccdf3eb0f5503eae9f9ffa5e6570549c3.1793147364.git.memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793147364.git.memxor@gmail.com>
References: <cover.1793147364.git.memxor@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=20994; i=memxor@gmail.com; h=from:subject:message-id; bh=5TCqikw44z4kd8w4+7TXs4/i4cdhNepuP5YeSMhIg2E=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIeuh49OVfNs8t3Zdn/dHNdQxjtdxN69/yDyxistzwj4I7 z1/aEp4RykLgxgXg6yYIkvJ/31MxicqfwfaLuOGmcPKBDKEgYtTACby7hsjw/Gju1W6XC/WP9dY yPJ/+dIJc7w0bzdlfzd+Fiwnw5D6zZDhD/8LWc+JjwS4Jja2faiJtdsrvIMn5QMTvySXwjdRi7v 7eAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

A callback that bpf_loop() or another helper calls cannot unwind. The
helper is a C frame between the callback and the BPF code that called the
helper: unwind_exit of the callback finds no pad at its return address and
returns, the helper reads r0 and goes on, and the exception is lost in the
middle of the loop. The callback cannot skip the frame either, since the
helper holds things that only its epilogue drops: the mmap lock in
bpf_find_vma(), the RCU section of the bucket in the hash iterators, the
busy bit and the sample in bpf_user_ringbuf_drain().

Let the helper have a pad of its own. bpf_call_cb() calls the callback
from inline asm with an extable entry at the return address that points to
a label in the helper, and asm goto tells the compiler that control may
leave for it. unwind_exit of the callback finds the entry and lands on the
label, with the callee-saved registers and the stack as after a return.
There the helper stops, drops what it holds, and leaves the way a BPF frame
leaves at unwind_exit: bpf_unwind_leave() makes its return address the pad
after the call of the helper, which the verifier insists on. Nothing is
signalled anywhere: the callback leaves as any subprog does, and so does
the helper.

The return address of the helper sits where the compiler knows it to be,
below the canonical frame address, which __builtin_dwarf_cfa() gives as an
offset from the stack pointer. So the normal path pays nothing: no stub, no
frame set aside, no unwinder. On arm64 the frame record holds it, signed
with the stack pointer at entry, which is that same address, so the new one
is signed the same way, and written to the shadow call stack as well, which
the epilogue prefers, when it is on: a dynamic one stays off where there
is pointer authentication. clang has __builtin_dwarf_cfa() stand for the
frame pointer on arm64, so the modifier is __builtin_sponentry() there. On
x86-64 clang takes the canonical frame address through a frame pointer, so
there the helpers get one: push, mov and pop, on a kernel that otherwise
does without. That makes the pad part of the frame that the BPF code
called, or of one called with a pad in turn: a body that two kfuncs share
is inlined into both, not called by them, and a function with a pad is
noinline, so that the compiler neither inlines it into another frame nor
splits the pad, cold as it is, out of it into a part of its own, as gcc's
ipa-split otherwise does. A miss at the return address of the helper is a
bug then, and bpf_unwind_leave() warns of it, since the exception would
come back as a return.

The call itself is the one the compiler would make, kCFI check included.
The check is spelled out byte for byte, with the type id that clang emits
for the declaration of __bpf_callback_fn, negated by the assembler, the
hash where the JIT and the compiler put it, the trap in .kcfi_traps and the
target in r11: apply_fineibt() and handle_cfi_failure() take the site for
one of the compiler's. On arm64 it's the ldur, movz, movk, cmp and brk of
the compiler, with the type in w17 and the target in x15.

The entries are EX_TYPE_BPF, since only bpf_unwind_target() looks them up,
and they are keyed at the return address itself. No fault lands there as
long as the insn after bpf_call_cb() carries no fixup of its own, which in
the helpers it never does. objtool reads __ex_table as alternatives and
wants the key to be an insn, which is why it isn't ret_addr - 1 as in the
JITs. bpf_unwind_target() asks the kernel extables after the BPF ones, for
entries of that kind only, so that a fixup of some caller's own at the
return address of a main prog is not taken for a pad, and is shared with
the helpers through filter.h, with a weak default for the arches whose JIT
does no unwinding.

The pad leaves with the r0 the callback unwound with, as the pad of a BPF
caller does: r0 is an output of the asm, and the outputs of an asm goto are
valid on the way to a label as well as on the way out with every compiler
that has them and that the kernel takes, see CC_HAS_ASM_GOTO_OUTPUT. On
x86-64 that output is rax, the caller's variable. On arm64 it is x0,
which only a register variable of the macro can name, so the macro lands
at a label of its own first, assigns it there and goes on to the pad of
the helper.

The registers the call clobbers are outputs of the asm, so that none of
them is an operand. On arm64 x18 is among the clobbers unless it holds the
shadow call stack, which the callee keeps and the compiler has reserved.
That takes asm goto with outputs. Without it, or on an arch other than
x86-64 and arm64, bpf_call_cb() is the plain call and BPF_HAS_CB_PADS is 0:
the verifier keeps refusing a callback that unwinds.

Nothing uses this yet. The verifier learns next what a callback that
unwinds into such a pad means, and the helpers follow one by one, each
opened as it gets its pad.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 arch/arm64/net/bpf_jit_comp.c |  32 +++-
 arch/x86/net/bpf_jit_comp.c   |  25 ++-
 include/linux/bpf_unwind.h    | 282 ++++++++++++++++++++++++++++++++++
 include/linux/filter.h        |   1 +
 kernel/bpf/core.c             |  10 ++
 5 files changed, 340 insertions(+), 10 deletions(-)
 create mode 100644 include/linux/bpf_unwind.h

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index aaa34c739004..b8fb49b00063 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -1266,16 +1266,38 @@ static int add_unwind_exentry(struct jit_ctx *ctx, int pad)
 	return 0;
 }
 
-static long bpf_unwind_fixup(u64 lr)
+/*
+ * The verifier made sure that unwind_goto follows a call in a prog. When the
+ * kernel called an async callback, it's exit. A helper that calls a callback
+ * has a pad when it wants one, see bpf_call_cb().
+ */
+u64 bpf_unwind_target(u64 ret_addr)
 {
 	const struct exception_table_entry *e;
 
-	e = search_bpf_extables(ptrauth_strip_kernel_insn_pac(lr) - 1);
+	e = search_bpf_extables(ret_addr - 1);
+	if (e)
+		return ret_addr + e->fixup;
 	/*
-	 * The verifier made sure that unwind_goto follows a call in a prog. When
-	 * the kernel called an async callback, it's exit.
+	 * The pad of a helper that called a callback with bpf_call_cb(): its
+	 * entries are the EX_TYPE_BPF ones of the kernel and module tables.
+	 * Anything else at a return address is some caller's own fixup, and
+	 * what a JIT keyed there is a fixup of the insn after the call.
 	 */
-	return e ? e->fixup : 0;
+	e = search_kernel_exception_table(ret_addr);
+	if (!e)
+		e = search_module_extables(ret_addr);
+	if (e && e->type == EX_TYPE_BPF)
+		return (unsigned long)&e->fixup + e->fixup;
+	return ret_addr;
+}
+
+/* The offset that the epilogue adds to LR once it is authenticated */
+static long bpf_unwind_fixup(u64 lr)
+{
+	u64 ret_addr = ptrauth_strip_kernel_insn_pac(lr);
+
+	return bpf_unwind_target(ret_addr) - ret_addr;
 }
 
 /*
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 6a2fe3d0039d..a092a84157a9 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2546,15 +2546,30 @@ static int add_unwind_exentry(struct bpf_prog *prog, u8 *image, u8 *rw_image, in
 	return 0;
 }
 
-static u64 bpf_unwind_target(u64 ret_addr)
+/*
+ * The verifier made sure that unwind_goto follows a call in a prog. When the
+ * kernel called an async callback, it's exit. A helper that calls a callback
+ * has a pad when it wants one, see bpf_call_cb().
+ */
+u64 bpf_unwind_target(u64 ret_addr)
 {
-	const struct exception_table_entry *e = search_bpf_extables(ret_addr - 1);
+	const struct exception_table_entry *e;
 
+	e = search_bpf_extables(ret_addr - 1);
+	if (e)
+		return ret_addr + e->fixup;
 	/*
-	 * The verifier made sure that unwind_goto follows a call in a prog. When
-	 * the kernel called an async callback, it's exit.
+	 * The pad of a helper that called a callback with bpf_call_cb(): its
+	 * entries are the EX_TYPE_BPF ones of the kernel and module tables.
+	 * Anything else at a return address is some caller's own fixup, and
+	 * what a JIT keyed there is a fixup of the insn after the call.
 	 */
-	return e ? ret_addr + e->fixup : ret_addr;
+	e = search_kernel_exception_table(ret_addr);
+	if (!e)
+		e = search_module_extables(ret_addr);
+	if (e && (e->data & EX_DATA_TYPE_MASK) == EX_TYPE_BPF)
+		return (unsigned long)&e->fixup + e->fixup;
+	return ret_addr;
 }
 
 /* unwind_exit: fix the return address of this frame. r0 and r2 are returned. */
diff --git a/include/linux/bpf_unwind.h b/include/linux/bpf_unwind.h
new file mode 100644
index 000000000000..190d6dbae856
--- /dev/null
+++ b/include/linux/bpf_unwind.h
@@ -0,0 +1,282 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_BPF_UNWIND_H
+#define _LINUX_BPF_UNWIND_H
+
+/*
+ * A helper that calls a callback is a C frame between the callback and the BPF
+ * code that called the helper. unwind_exit of the callback returns to the pad of
+ * its caller when the caller has one, so a helper lets its callback unwind by
+ * having one: bpf_call_cb() calls the callback with an extable entry at the
+ * return address that points to a label in the helper. There the helper drops
+ * what it holds and leaves the way a BPF frame leaves at unwind_exit, with
+ * bpf_unwind_leave(): its return address becomes the pad of its caller, which
+ * the verifier insists on, and r0 is what the callback unwound with, since the
+ * output of the call is valid on both edges. The slot that holds the return
+ * address is where the compiler knows it to be, at the canonical frame address
+ * of the helper, so nothing is looked up and nothing is saved beforehand. That
+ * makes the pad part of the frame that the BPF code called, or of one called
+ * with a pad in turn: a body that two entry points share is inlined into both,
+ * not called by them, and a function with a pad is noinline, so that the
+ * compiler neither inlines it into another frame nor splits the pad, cold as it
+ * is, out of it into a part of its own, as gcc's ipa-split otherwise does.
+ *
+ * The call is the one the compiler would make, kCFI check included: against
+ * the type of a callback, or, with __bpf_call_cb(), against the type of a
+ * function declared with BPF_CB_PAD_TYPE(). The entry is EX_TYPE_BPF, keyed at
+ * the return address: only bpf_unwind_target() looks it up, and takes no other
+ * kind from the kernel tables, and no fault lands on an insn after a call of
+ * ours. For that the insn after bpf_call_cb() must not carry a fixup of its
+ * own, which in the helpers it never does. objtool reads __ex_table and wants
+ * the key to be an insn, which is why it isn't ret_addr - 1 as in the JITs.
+ *
+ * The outputs of an asm goto are valid on the way to a label as well as on the
+ * way out with every compiler that has them and that the kernel takes, see
+ * CC_HAS_ASM_GOTO_OUTPUT. So r0 is what the callback left on either edge.
+ * Without asm goto outputs, or on an arch whose JIT does no unwinding, the
+ * callback is called the plain way and BPF_HAS_CB_PADS tells the verifier that
+ * a callback cannot unwind.
+ */
+
+#include <linux/bug.h>
+#include <linux/types.h>
+#include <linux/filter.h>
+#include <linux/stringify.h>
+
+#if defined(CONFIG_X86_64) && defined(CONFIG_CC_HAS_ASM_GOTO_OUTPUT)
+
+#include <asm/asm.h>
+#include <asm/extable_fixup_types.h>
+#include <asm/nospec-branch.h>
+
+#define BPF_HAS_CB_PADS 1
+
+#ifdef CONFIG_CFI
+/*
+ * The kCFI check of the compiler, byte for byte: the hash where the compiler
+ * and the JIT put it, the trap in .kcfi_traps, the target in r11 for the
+ * FineIBT form. apply_fineibt() and handle_cfi_failure() take the site for one
+ * of the compiler's. The type id is the symbol clang emits for a declaration
+ * of that type once its address is taken, which BPF_CB_PAD_TYPE() sees to, and
+ * the assembler negates it, since the symbol is absolute.
+ */
+#define BPF_CB_PAD_TYPE(name, type)						\
+	extern type name;							\
+	__ADDRESSABLE(name)
+
+#ifdef CONFIG_CALL_PADDING
+#define BPF_KCFI_HASH_OFF	(4 + CONFIG_FUNCTION_PADDING_CFI)
+#else
+#define BPF_KCFI_HASH_OFF	4
+#endif
+
+#define BPF_KCFI_CHECK(type)							\
+	"	movl $-__kcfi_typeid_" #type ", %%r10d\n"			\
+	"	addl -" __stringify(BPF_KCFI_HASH_OFF) "(%%r11), %%r10d\n"	\
+	"	je 2f\n"							\
+	"3:	ud2\n"								\
+	"	.pushsection .kcfi_traps, \"ao\", @progbits, .text\n"		\
+	"	.long 3b - .\n"							\
+	"	.popsection\n"							\
+	"2:\n"
+#else
+#define BPF_CB_PAD_TYPE(name, type)
+#define BPF_KCFI_CHECK(type)
+#endif
+
+/*
+ * The registers the call clobbers are outputs, so that none of them can be an
+ * operand of anything else. r0 is rax, on the way out and on the way to the pad.
+ * The return address stays the byte after the call through what
+ * apply_retpolines() and apply_fineibt() make of the call: they pad in front of
+ * it, never behind it.
+ */
+#define __bpf_call_cb(type, fn, a1, a2, a3, a4, a5, r0, unwound)		\
+do {										\
+	register u64 __fn asm("r11") = (u64)(long)(fn);				\
+	register u64 __a5 asm("r8") = (u64)(long)(a5);				\
+	register u64 __c5 asm("r8");						\
+	register u64 __c11 asm("r11");						\
+	u64 __c1, __c2, __c3, __c4;						\
+										\
+	asm_goto_output(BPF_KCFI_CHECK(type)					\
+		 "	" CALL_NOSPEC "\n"					\
+		 "1:\n"								\
+		 _ASM_EXTABLE_TYPE(1b, %l[unwound], EX_TYPE_BPF)		\
+		 : "=a"(r0), "=D"(__c1), "=S"(__c2), "=d"(__c3), "=c"(__c4),	\
+		   "=r"(__c5), "=r"(__c11)					\
+		 : [thunk_target] "r"(__fn), "D"((u64)(long)(a1)),		\
+		   "S"((u64)(long)(a2)), "d"((u64)(long)(a3)),			\
+		   "c"((u64)(long)(a4)), "r"(__a5)				\
+		 : "r9", "r10", "memory", "cc"					\
+		 : unwound);							\
+} while (0)
+
+/*
+ * The return address of the helper is the word below its canonical frame
+ * address. The pad is in the frame that BPF code called, see above, so there is
+ * a pad to go to: a miss is a bug, and the exception would be lost in a return.
+ */
+static __always_inline void bpf_unwind_leave(void)
+{
+	unsigned long *slot = (unsigned long *)__builtin_dwarf_cfa() - 1;
+	unsigned long to = bpf_unwind_target(*slot);
+
+	WARN_ON_ONCE(to == *slot);
+	*slot = to;
+}
+
+#elif defined(CONFIG_ARM64) && defined(CONFIG_CC_HAS_ASM_GOTO_OUTPUT)
+
+#include <linux/scs.h>
+#include <asm/asm-extable.h>
+#include <asm/brk-imm.h>
+#include <asm/compiler.h>
+
+#define BPF_HAS_CB_PADS 1
+
+#ifdef CONFIG_CFI
+/*
+ * The kCFI check of the compiler: the type id comes in w17, the target is in
+ * x15, and the brk says so. The hash of the callee is the word before it.
+ */
+#define BPF_CB_PAD_TYPE(name, type)						\
+	extern type name;							\
+	__ADDRESSABLE(name)
+
+#define BPF_KCFI_CHECK(type)							\
+	"	ldur w16, [x15, #-4]\n"						\
+	"	movz w17, #:abs_g0_nc:__kcfi_typeid_" #type "\n"		\
+	"	movk w17, #:abs_g1_nc:__kcfi_typeid_" #type "\n"		\
+	"	cmp w16, w17\n"							\
+	"	b.eq 2f\n"							\
+	"	brk #" __stringify((CFI_BRK_IMM_BASE | (17 << 5) | 15)) "\n"	\
+	"2:\n"
+#else
+#define BPF_CB_PAD_TYPE(name, type)
+#define BPF_KCFI_CHECK(type)
+#endif
+
+/*
+ * With a shadow call stack x18 holds it, the callee keeps it, and the compiler
+ * has it reserved. Without one it's a temporary like the rest.
+ */
+#ifdef CONFIG_SHADOW_CALL_STACK
+#define BPF_CB_CLOBBER_X18
+#else
+#define BPF_CB_CLOBBER_X18	"x18",
+#endif
+
+/*
+ * r0 is x0, which only a register variable of the macro can name. So the macro
+ * lands at a label of its own, assigns it there as on the way out, and goes on
+ * to the pad.
+ */
+#define __bpf_call_cb(type, fn, a1, a2, a3, a4, a5, r0, unwound)		\
+	___bpf_call_cb(__UNIQUE_ID(unwound), type, fn, a1, a2, a3, a4, a5, r0, unwound)
+
+#define ___bpf_call_cb(lbl, type, fn, a1, a2, a3, a4, a5, r0, unwound)		\
+do {										\
+	register u64 __fn asm("x15") = (u64)(long)(fn);				\
+	register u64 __a0 asm("x0") = (u64)(long)(a1);				\
+	register u64 __a1 asm("x1") = (u64)(long)(a2);				\
+	register u64 __a2 asm("x2") = (u64)(long)(a3);				\
+	register u64 __a3 asm("x3") = (u64)(long)(a4);				\
+	register u64 __a4 asm("x4") = (u64)(long)(a5);				\
+	register u64 __c0 asm("x0");						\
+	register u64 __c1 asm("x1");						\
+	register u64 __c2 asm("x2");						\
+	register u64 __c3 asm("x3");						\
+	register u64 __c4 asm("x4");						\
+	register u64 __c15 asm("x15");						\
+										\
+	asm_goto_output(BPF_KCFI_CHECK(type)					\
+		 "	blr x15\n"						\
+		 "1:\n"								\
+		 __ASM_EXTABLE_RAW("1b", "%l[" __stringify(lbl) "]",		\
+				   __stringify(EX_TYPE_BPF), "0")			\
+		 : "=r"(__c0), "=r"(__c1), "=r"(__c2), "=r"(__c3), "=r"(__c4),	\
+		   "=r"(__c15)							\
+		 : "r"(__fn), "r"(__a0), "r"(__a1), "r"(__a2), "r"(__a3),	\
+		   "r"(__a4)							\
+		 : "x5", "x6", "x7", "x8", "x9", "x10", "x11", "x12", "x13",	\
+		   "x14", "x16", "x17", BPF_CB_CLOBBER_X18 "x30", "memory", "cc"	\
+		 : lbl);							\
+	if (0) {								\
+lbl:		(r0) = __c0;							\
+		goto unwound;							\
+	}									\
+	(r0) = __c0;								\
+} while (0)
+
+/*
+ * The return address of the helper is the second word of its frame record. The
+ * pad is in the frame that BPF code called, see above, so there is a pad to go
+ * to: a miss is a bug, and the exception would be lost in a return.
+ *
+ * With pointer authentication the return address is signed with the stack
+ * pointer at entry, which is the canonical frame address, so the new one is
+ * signed the same way; pacia1716 is a hint, a nop without pointer
+ * authentication, like paciasp. clang has __builtin_dwarf_cfa() stand for the
+ * frame pointer on arm64 and __builtin_sponentry() for the stack pointer at
+ * entry. The shadow call stack holds a copy, which the epilogue prefers, when
+ * it is on: a dynamic one stays off where there is pointer authentication.
+ */
+static __always_inline void bpf_unwind_leave(void)
+{
+	unsigned long *slot = (unsigned long *)__builtin_frame_address(0) + 1;
+	unsigned long from = ptrauth_strip_kernel_insn_pac(*slot);
+	unsigned long to = bpf_unwind_target(from);
+
+	WARN_ON_ONCE(to == from);
+#ifdef CONFIG_ARM64_PTR_AUTH_KERNEL
+	{
+		register unsigned long x17 asm("x17") = to;
+#ifdef __clang__
+		register unsigned long x16 asm("x16") = (unsigned long)__builtin_sponentry();
+#else
+		register unsigned long x16 asm("x16") = (unsigned long)__builtin_dwarf_cfa();
+#endif
+
+		asm("pacia1716" : "+r"(x17) : "r"(x16));
+		to = x17;
+	}
+#endif
+	*slot = to;
+#ifdef CONFIG_SHADOW_CALL_STACK
+	if (scs_is_enabled()) {
+		unsigned long *scs;
+
+		asm("mov %0, x18" : "=r"(scs));
+		scs[-1] = to;
+	}
+#endif
+}
+
+#else
+
+#define BPF_HAS_CB_PADS 0
+
+#define BPF_CB_PAD_TYPE(name, type)
+
+#define __bpf_call_cb(type, fn, a1, a2, a3, a4, a5, r0, unwound)		\
+do {										\
+	(r0) = ((bpf_callback_t)(void *)(fn))((u64)(long)(a1), (u64)(long)(a2),	\
+					      (u64)(long)(a3), (u64)(long)(a4),	\
+					      (u64)(long)(a5));			\
+	if (0)									\
+		goto unwound;							\
+} while (0)
+
+static __always_inline void bpf_unwind_leave(void)
+{
+}
+
+#endif
+
+/* A callback: bpf_callback_t */
+BPF_CB_PAD_TYPE(__bpf_callback_fn, typeof(*(bpf_callback_t)0));
+
+#define bpf_call_cb(fn, a1, a2, a3, a4, a5, r0, unwound)			\
+	__bpf_call_cb(__bpf_callback_fn, fn, a1, a2, a3, a4, a5, r0, unwound)
+
+#endif /* _LINUX_BPF_UNWIND_H */
diff --git a/include/linux/filter.h b/include/linux/filter.h
index e0218e677a1d..9f670b3d8375 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1281,6 +1281,7 @@ bool bpf_jit_supports_kfunc_call(void);
 bool bpf_jit_supports_callx(void);
 bool bpf_jit_supports_kfunc_ret_reg_pair(void);
 bool bpf_jit_supports_unwind(void);
+u64 bpf_unwind_target(u64 ret_addr);
 bool bpf_jit_supports_stack_args(void);
 bool bpf_jit_supports_arena_args(void);
 bool bpf_jit_supports_far_kfunc_call(void);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 3030beb531d9..1096b2adc695 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3405,6 +3405,16 @@ bool __weak bpf_jit_supports_unwind(void)
 	return false;
 }
 
+/*
+ * Where unwind_exit returns: to the pad of the caller when the caller has one,
+ * and where exit would otherwise. The JITs that support unwinding have the real
+ * one. Without it no callback unwinds, so a helper never asks.
+ */
+u64 __weak bpf_unwind_target(u64 ret_addr)
+{
+	return ret_addr;
+}
+
 /*
  * How this arch places a by-value kfunc argument, or NULL for one that has
  * not opted in and so only takes an argument of a single eightbyte, which
-- 
2.53.0

