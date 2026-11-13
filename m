Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794546569;
	b=FlY+AGm2LgIDsBBBmIPK11yI9ZSRK0bxeufKchuebDXLNrl/odHI0lMx7r/taXlNtv1U
	 tsVJlmyanKoR0FOj3s/5+R1CD7IaaOjC4wR+f3rqic2TMksx5Nb/PetHJ3VVX9HZ5cZXx
	 LC/rwyCPQdmjK6bfYwR25nXr+GJOUT99fQ5zt2BDQ+5jo702u1+egu/+mVAyW0m3JjlLM
	 72SR5bDGEONtLNq3pDmZFaJCG61qswJpng+RV+Z0BSI2uqS74vI3LdnH9X3OQR66cxCxc
	 IYzzagdZKiZfQ2bLu7V5ea6zsOuOrT2cWmNuRtqVJKK+Jxt24zNenFDEBTeALoDvldw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794546569;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=oczwGRSHkHgro1UTGV7sJdqStls2/TNNsLth85qKyco=;
	b=PPP+SH3ErNE7G6e43hPXJbnyNwmd3NQtC+qn5bJ5WHj/pd8N3CTgKg/LLqwfalX88m4x
	 WUdxlJBijmp5rFJK0zR+w/JASo1WAoHdDuUSUbGSUZ5N5QbNp1mNdQONSpoZw6N/Iglqk
	 YbPK5u3TrMteJCOS1m1//0i2fnqidM5q7Yshx6rJ8r6Ewstk2tFui/bdm7IGHTz3Sk0JA
	 bn14FZEI4N1NFgLUEGRFop8GeBZEg2Zuka1Z/icLid1teQNtM9ekZNJ7L1kb7uuTOmvIo
	 auAoWAOB4GdSSEzb2BshLkw/TeHMBz/eZDSKfaUDJ9XfFKl4VXI82+G9wcTXrTf3ixw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HmGREK5l;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE87606A327
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 05:09:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DE87606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HmGREK5l
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3b09c07b3d2so273675a91.3
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 21:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794546568; x=1795151368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oczwGRSHkHgro1UTGV7sJdqStls2/TNNsLth85qKyco=;
        b=HmGREK5lTxy+ukoOOsN4yKHgfVwFuDRQfo3DpCf+wyJqvfanImH5KEsKQoUH1ctTvi
         pRrFK8ABjL/nePZlFDlj9fKBqow+ppvXHUfAq6+XtThSKuxj4sxYQPs3WjjXUh2+pbK/
         jxEt8BC9fV/F+pTUfdG5ulRRudDakzKa1LHHErMllmEb7WhHlJmxNWLrh8u7otbaUHVp
         9elVaJIdo+LLyFBbzvJzaf/HUl9D8f2qPcv6yDbsGrlnr4cj9dbq/J8yNsavcypdksvK
         G4fEXJ4hnvp2uFT8giz2UttYgJV06WsJYf87ZUS2HPEBLB8I9DcnmdGHQl1nluJuefNj
         cnjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794546568; x=1795151368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oczwGRSHkHgro1UTGV7sJdqStls2/TNNsLth85qKyco=;
        b=2qJ/6qONsTs61gXcP2Mx1GkSOtoiWOvQRqQa8IoTpQovQ6Fm92ruHYzqC3TAAkgQJi
         sG5lgsE6yxc4+ierAmaIRkSnQ2OpLtnAuwAoPsnjYZ8bj4T5rUlLJBEZfV8LfFBWjsOd
         bsKZK+4GQUBgka7jVS7QMoTZl3mP378Reunqc0fJPGZYsbRCREbo4BUpfQQMjONu+eEf
         /LK6oh6phHDYCu5fy7mcB0gR2NvWM/wxY/N7Rpk5wiYVrO72DrP6zxTUOCH5zJESKQdm
         mgAg301dck5/yNFRY6qUq2b0OnkadmoNQTTpQ7GUJzvh/ooUpNRBn9fehwOIsugUikS5
         2iYw==
X-Gm-Message-State: APuU4Z9gKr9JjAi0JNqF2oxG3prbbDdnfrdcE4wYAUGWKtxVDUCSUAib
	kGnlJl9LAvJZbQjkSIjE5JHyOPXbR8omy6XpItxafKxEUv5g67VrBz7iwzoNFA==
X-Gm-Gg: AYBFou3pqmT49Kn5fkxPHMphEjPb12rwfhIlasc0BswNHQug0mJvmtf8Gsn8YXHAe8K
	oYbT+NsdNprYvlIpWfA+S05AUZDwEzCtjmduHrQIn9o3bX+KTXtQ2pG7ELNwcXNt/8yWRqqz+0L
	WAibfWmqSVnUlC5RYBoiqF6wi0cpI0wwNPlnxS76TPSMyOBMBN+Rulckz8jJ61ST/eNTYY3JmgE
	mqwHe9ugeEn6tbfkBwWvpvEf719urjOoTqblsTMymkgWLjVuiMK/8SuAF8pBKdM+XU+x6c4WX05
	PnyzRosEC/Ld9M2j/NZlSnzsgD4Fd94XOCgXCI2P1ZdGPM+/Tc3S6UlGWt2rUVkbPy8aYPoW2bq
	WRhqRrTDkWBoDgbAuvi4xFGoWZCXE+9pSj1bv0fs3pmlJzCNbcU2sRvOi+0F9kcPUED0l656mz3
	jbHkGx4J1BL0yEDy1AOaF3GI+/wgFunZEO6vJHx+poERx9GH5xD/eg6ZvoNthadWt8zOZqvxCOo
	QYa5Vrfkv8/+wRZSwwVBLWYQR335wwZdk5T+1gnZXfpapqAgxZKYwPqpFwRNLqzVAOEbYjATHCR
	E2cUHuTtbdEbgeLisNObBmbKcILQGD+nAKtD+GXVaYSvHsVYWgJlUOmObAABiBhkwRyJVrll1rT
	WS1vAXmsOLe8qUqJAlp3ppL2NzQqFBeL/1044dsOhOg7Sc1BLvl633nxvaeIyVAvq4uGzXh3YBW
	8=
X-Received: by 2002:a17:90b:4b12:b0:3ac:9d14:feb1 with SMTP id 98e67ed59e1d1-3b1b0b87a53mr1142041a91.43.1794546567873;
        Thu, 12 Nov 2026 21:09:27 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b1e9ef15sm946932a91.0.2026.11.12.21.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 21:09:27 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	a.s.protopopov@gmail.com
Subject: [PATCH v2 bpf-next 04/13] resolve_btfids: Find the definitions that reach the return value
Date: Fri, 13 Nov 2026 05:08:52 +0000
Message-ID: <20261113050901.1399091-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261113050901.1399091-1-alexei.starovoitov@gmail.com>
References: <20261113050901.1399091-1-alexei.starovoitov@gmail.com>
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

From: Anton Protopopov <a.s.protopopov@gmail.com>

	int f(struct file *file, int mode)
	{
		int ret = -EINVAL;

		if (mode & ~MASK)
			goto out;
		ret = g(file);
	out:
		return ret;
	}

Which constants does f() return? A compiler loads a constant into any
register. Copies, sign extensions and selects carry it to the return
value register.

Run a data flow analysis on the instructions of one function. It is
backward and "may", like liveness. The fact at a point is the set of
registers whose value may become the return value:

	                                   fact before the instruction
	   mov    $0xffffffea,%ebx         {}       -22 is returned
	   test   $0xfffffff8,%esi         {rbx}
	   jne    1f                       {rbx}    join: {} + {rbx}
	   call   g                        {}       a call writes rax
	   mov    %eax,%ebx                {rax}
	1: mov    %ebx,%eax                {rbx}
	   ret                             {rax}

	transfer functions and join
	return            { return value register }
	dst = src         src takes the place of dst
	another write     the register leaves the set
	call              the caller-saved registers leave the set
	join              union

An instruction that loads a constant into dst is a definition that reaches
the return value, if dst is in the fact after it. One run answers the
question for all constants of the function.

It is a may analysis. Branches are not evaluated: a constant counts if a
path of the control flow graph carries it. Memory is not tracked: a
constant that is spilled to the stack is not found.

"mov $-22,%eax" makes 0xffffffea. That is an error for a function that
returns int. For a function that returns long it is a large number,
unless cltq follows. So there are three sets: returned as it is, zero
extended, sign extended. Nothing in the analysis depends on the arch.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
Co-developed-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/bpf/resolve_btfids/Build       |   4 +
 tools/bpf/resolve_btfids/text_flow.c | 145 +++++++++++++++++++++++++++
 tools/bpf/resolve_btfids/text_flow.h |  44 ++++++++
 3 files changed, 193 insertions(+)
 create mode 100644 tools/bpf/resolve_btfids/text_flow.c
 create mode 100644 tools/bpf/resolve_btfids/text_flow.h

diff --git a/tools/bpf/resolve_btfids/Build b/tools/bpf/resolve_btfids/Build
index b9e5bf21439f..cd42283bb929 100644
--- a/tools/bpf/resolve_btfids/Build
+++ b/tools/bpf/resolve_btfids/Build
@@ -3,6 +3,7 @@ hostprogs := resolve_btfids
 resolve_btfids-y += main.o
 resolve_btfids-y += btf_colors.o
 resolve_btfids-y += image.o
+resolve_btfids-y += text_flow.o
 resolve_btfids-$(LLVM_MC) += text_mc.o
 resolve_btfids-$(LLVM_MC) += text_mc_$(SRCARCH).o
 resolve_btfids-y += rbtree.o
@@ -11,6 +12,9 @@ resolve_btfids-y += string.o
 resolve_btfids-y += ctype.o
 resolve_btfids-y += str_error_r.o
 
+# The inner loops of --fmodret_scan
+HOSTCFLAGS_text_flow.o += -O2
+
 # LLVM's C++ API may have moved on, see Makefile
 $(OUTPUT)text_mc.o: cmd_cxx_o_c += $(or_llvm_mc_help)
 
diff --git a/tools/bpf/resolve_btfids/text_flow.c b/tools/bpf/resolve_btfids/text_flow.c
new file mode 100644
index 000000000000..2d58ffb2e939
--- /dev/null
+++ b/tools/bpf/resolve_btfids/text_flow.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Which values does a function return? See text_flow.h */
+
+#include <linux/bits.h>
+#include <linux/compiler.h>
+
+#include "text_flow.h"
+
+/* Return the index of the instruction which runs after I if I does not branch */
+static u32 next_insn(const struct text_flow *flow, u32 i)
+{
+	const struct text_insn *insn = &flow->insns[i];
+
+	/* A function and its cold subfunctions are not adjacent */
+	return i + 1 < flow->nr_insns && insn[1].addr == insn->addr + insn->len ?
+	       i + 1 : TEXT_NO_INSN;
+}
+
+static u32 insn_at(const struct text_flow *flow, u64 addr)
+{
+	u32 lo = 0, hi = flow->nr_insns;
+
+	while (lo < hi) {
+		u32 mid = lo + (hi - lo) / 2;
+
+		if (flow->insns[mid].addr < addr)
+			lo = mid + 1;
+		else
+			hi = mid;
+	}
+	return lo < flow->nr_insns && flow->insns[lo].addr == addr ? lo : TEXT_NO_INSN;
+}
+
+static void join(struct text_facts *facts, const struct text_flow *flow, u32 i)
+{
+	if (i == TEXT_NO_INSN)
+		return;
+	facts->same |= flow->facts[i].same;
+	facts->zext |= flow->facts[i].zext;
+	facts->sext |= flow->facts[i].sext;
+}
+
+static void kill(struct text_facts *facts, u32 regs)
+{
+	facts->same &= ~regs;
+	facts->zext &= ~regs;
+	facts->sext &= ~regs;
+}
+
+enum cast { SAME, ZEXT, SEXT };
+
+/* The facts of DST behind "dst = cast(src)" are those of SRC before it */
+static void copy(struct text_facts *in, const struct text_facts *out, u8 dst, u8 src,
+		 enum cast cast)
+{
+	bool same = out->same & BIT(dst), zext = out->zext & BIT(dst), sext = out->sext & BIT(dst);
+
+	if (same && cast == SAME)
+		in->same |= BIT(src);
+	if (zext || (same && cast == ZEXT))
+		in->zext |= BIT(src);
+	if (sext || (same && cast == SEXT))
+		in->sext |= BIT(src);
+}
+
+/* Return the facts before instruction I */
+static struct text_facts transfer(const struct text_flow *flow, u32 i)
+{
+	const struct text_insn *insn = &flow->insns[i];
+	struct text_facts out = {}, in;
+	enum cast cast;
+
+	switch (insn->kind) {
+	case TEXT_RETURN:
+		out.same = BIT(flow->arch->retval);
+		return out;
+	case TEXT_BRANCH:
+		join(&out, flow, insn->target);
+		return out;
+	case TEXT_COND_BRANCH:
+		join(&out, flow, insn->target);
+		break;
+	}
+	join(&out, flow, next_insn(flow, i));
+
+	in = out;
+	kill(&in, insn->defs);
+	switch (insn->kind) {
+	case TEXT_CALL:
+		kill(&in, flow->arch->caller_saved);
+		break;
+	case TEXT_MOV_IMM:
+		kill(&in, BIT(insn->dst));
+		break;
+	case TEXT_MOV:
+	case TEXT_SEXT32:
+	case TEXT_SELECT:
+	case TEXT_SELECT_IMM:
+		cast = insn->kind == TEXT_SEXT32 ? SEXT : insn->is32 ? ZEXT : SAME;
+		kill(&in, BIT(insn->dst));
+		copy(&in, &out, insn->dst, insn->src, cast);
+		if (insn->kind == TEXT_SELECT)
+			copy(&in, &out, insn->dst, insn->src2, cast);
+		break;
+	}
+	return in;
+}
+
+/*
+ * Sweep from the last instruction to the first one until nothing changes. The
+ * sets only grow, and one more sweep is needed only for what goes around a loop.
+ */
+void text_flow_solve(struct text_flow *flow)
+{
+	bool changed;
+	u32 i;
+
+	for (i = 0; i < flow->nr_insns; i++) {
+		struct text_insn *insn = &flow->insns[i];
+
+		flow->facts[i] = (struct text_facts){};
+		insn->target = TEXT_NO_INSN;
+		if ((insn->kind == TEXT_BRANCH || insn->kind == TEXT_COND_BRANCH) && insn->imm)
+			insn->target = insn_at(flow, insn->imm);
+	}
+	do {
+		changed = false;
+		for (i = flow->nr_insns; i--; ) {
+			struct text_facts *old = &flow->facts[i], new = transfer(flow, i);
+
+			if (new.same == old->same && new.zext == old->zext && new.sext == old->sext)
+				continue;
+			*old = new;
+			changed = true;
+		}
+	} while (changed);
+}
+
+struct text_facts text_flow_out(const struct text_flow *flow, u32 i)
+{
+	struct text_facts out = {};
+
+	join(&out, flow, next_insn(flow, i));
+	return out;
+}
diff --git a/tools/bpf/resolve_btfids/text_flow.h b/tools/bpf/resolve_btfids/text_flow.h
new file mode 100644
index 000000000000..b307c08fd163
--- /dev/null
+++ b/tools/bpf/resolve_btfids/text_flow.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __TEXT_FLOW_H
+#define __TEXT_FLOW_H
+
+#include "text_insn.h"
+
+/*
+ * Which values does a function return? A backward may data flow analysis of
+ * the machine code of one function.
+ *
+ * The fact at a point of the code is the set of registers whose value at that
+ * point may become the return value: the return value register at a return,
+ * and before "dst = src" the register src if dst is in the set behind it. The
+ * join is the union. Branches are not evaluated, calls write what the ABI lets
+ * them write, memory is not tracked.
+ *
+ * A copy may convert the value, and only the last conversion counts. So there
+ * are three sets.
+ */
+struct text_facts {
+	u32 same;	/* returned as it is */
+	u32 zext;	/* the low 32 bits are returned, zero extended */
+	u32 sext;	/* the low 32 bits are returned, sign extended */
+};
+
+struct text_flow {
+	const struct text_arch *arch;
+	/*
+	 * All instructions of the function in the order of their addresses,
+	 * whether they can be reached or not: the way to a block may be a jump
+	 * which is patched in at run time, or an exception.
+	 */
+	struct text_insn *insns;
+	u32 nr_insns;
+	/* The result: the facts before each instruction */
+	struct text_facts *facts;
+};
+
+/* Compute the facts */
+void text_flow_solve(struct text_flow *flow);
+/* Return the facts behind instruction I, which is not a branch */
+struct text_facts text_flow_out(const struct text_flow *flow, u32 i);
+
+#endif
-- 
2.55.0

