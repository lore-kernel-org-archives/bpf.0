Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794633515;
	b=ni0EQbHFkspCR08AsgxtDUkKtv4qE+VaJFUswG0M24YT3tMgBkoWj/BrPBQ9ViDCPXsZ
	 n8oJRrurtB+seeKXQO0bUoS5JUgpNQKFKZQujc3Ms6UidQaqREmiqk6v4ygpz6k8TLsi4
	 adE43M0QZq1k+3TKJYvTQepo9IxFF0dL2W6yfvOLbM1GHQCFuDTILk8yPeLk/YYWm516O
	 edqyaGRvTU12tlzB97pPPWAmVqLM2IVdtf16RwQ4ivRTl6QOIs+wR12lFtLIVauYUXhmi
	 aUSeVm1aUTpfoxslHuMSev8kcskgl2tB5Rad0l2qqvBFOc80wq+nwXhsQytd+ZtTIzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794633515;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=oczwGRSHkHgro1UTGV7sJdqStls2/TNNsLth85qKyco=;
	b=5phH5dt4zUmm4dqnQAk8jyjMTXam+KMpN1QPIGEOxNDIcDeR7C68vq4WFKpXAl8QIUKh
	 12SjjTCU9Izg2r/kM5r5olQupWSVC45ZrHJQiTd2ZVMqN1xdZeU9DZhTRDyXdKk20/yMV
	 xbvTUhGofyB5a1irkJnhW6AK8dMvQwRxkGsAg/7neGCgBIjwYqS3tVz4PVuw4iyowQvzi
	 LYWgkOaQDlTPfIhUkTnGLzLtiQvZSDLCw0T9IhmYO36oueShoc4tXioeHjsqQvCWVOHTQ
	 avPS6DExp6G3PpjFnV65iHOPCcKC1ULckMfuGt8iJ0kejzQpZocmkT0Av6N2DboO1ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HTXlsZ3g;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95449606A32D
	for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 05:18:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95449606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HTXlsZ3g
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3ac78f4c10bso839083a91.1
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 21:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794633514; x=1795238314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oczwGRSHkHgro1UTGV7sJdqStls2/TNNsLth85qKyco=;
        b=HTXlsZ3gfzPLVmrmltNIC5zGlMIqaZBcl4Y+jGN+JUF613D8eSJZfF5L+Wke85aeqN
         kXzrkWm5tRgWU9httZcCFVZ5OrZa91GcducfZpnBp97cCMMcEQZm9T8OC1TMf1FzgKsf
         1/LBLYYIsMV+WGU/WChpoqtNROpsls8BdpsRbIoRiMjJSjPWGKlWgd+sqVInFcKEfHhE
         +y+DIyS20eWnV0B06SnpUE2Z9i8q0WCy0/G5D4gDt4uWL6nsorgH+ot9ZOwWex0RQ82D
         VB+dk44A2fSm/wj6dTBp1vkl7Ta7s0ommlhKCvc3mPcZ4YVV8X8q0OdY/rmjQCQ2xBjw
         /vBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794633514; x=1795238314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oczwGRSHkHgro1UTGV7sJdqStls2/TNNsLth85qKyco=;
        b=eU6uYPxDxVEi890ZjiGQVy6nV8Tat4qIyaZt2mYdRANu+l8sw1ZoiDDPDnwzuWrHAb
         YxshUQdIpq1Y+QlwiiBlhwCcRxw9YyPk7j5e6BMZtab0qaT+ium+c3nZnComHEbvxskB
         5htk/oTDmd2ej58GwV0Fqhx3AmOzaXTLeGucS4ixqh9wqpXRUKX+gI6e8wzU9ZdFkFAz
         X/l6Crm+yyUGJ/J44Q4g6c8iJM/8kVCPCWnW7nnbObe+4S/LzG/fDUz2jFWc9yazQd6t
         k1x1RExPLQ5QpB5AhJc9FEmhffgHgUSC7tnEQt41U4bG+aw9k9l4TeMtf6gA9RDfRiIX
         uxjw==
X-Gm-Message-State: APuU4Z/3dLTJ3U0iviJjV5CIWJ4IIRb1nSBNy6JJ9aFi7qXONBZNw36/
	2hcSLi5dZrI3BH5hx8+NF3ck924ViH2PhAIA7kFJmnP/NH2wVt5zqiCKlDbURg==
X-Gm-Gg: AYBFou06RUSNGzE/TMu8SYxCyh2lRF5+HyxkE/d1NpzfDA3ktEFflDgwkJ0SWCx4MfU
	UVR69cF4vA5eZ1eAlIPFKjhmSK0AaMdr1SNueylKTXZOS0UqL3sM540x6B8JQ19jbpOAZ+KXXCS
	G7vCYSHY0W1eDdLEyG9/DYLETMVYZyWjkQZfkJnD5vR5Wn6Jp6hdFnz/S/BTm7+fdjL5ZyIS24G
	okwp341fe2Rly0kVSjbBR7Bz+FsrlwcES24wGi0dxjEbYhiVUE3r/qmu6LUJFtQZVVOY6VVkACd
	SbWVNLwbtxLo/gWa2gFc1M9vuE5ixZ+rLHLpQb+6i22ugn5JIzwzqUa8tKZBbeK8Hx6oVKEeI5v
	c6kFEK1gH9XtYar+QfrsoAEeziiALWGcmCGj1i+dg/zUV8G2xaZe2IQ2J7cpVDwEK7hwDKV+vRU
	bMP9Q6MFRErozRViOdLKiN5QmxQ4MCkS+uW7W0Bwlb5SrRkgELwXxqbAs5gV8yq7x351O2UIMjv
	d9HL6aBfurFaojBnMaaxNb5p2WbFg8JU0hNS60nvK4ssF2RT2wkFMA0J2io5kXSYMLJPjba6IXN
	E2htQRDdpFLjakXLfZW+Zq1msTql954Fkp3K/3rMLi1wXEByNUPsL3ZXRPyqrozVH3VKMpenz9U
	inDUF2yidCI8ctfxzPYUddZO1h9APgCh9W0rTG5NM/vAI3/7783giUpQG/qtpAnPY0p4/0sEiBQ
	==
X-Received: by 2002:a17:90b:4a43:b0:3ac:9669:846e with SMTP id 98e67ed59e1d1-3b1b0b4b1eamr3959818a91.27.1794633513805;
        Fri, 13 Nov 2026 21:18:33 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee228b2581sm9026765ad.63.2026.11.13.21.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 21:18:33 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	a.s.protopopov@gmail.com
Subject: [PATCH v3 bpf-next 04/11] resolve_btfids: Find the definitions that reach the return value
Date: Sat, 14 Nov 2026 05:17:58 +0000
Message-ID: <20261114051805.683966-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261114051805.683966-1-alexei.starovoitov@gmail.com>
References: <20261114051805.683966-1-alexei.starovoitov@gmail.com>
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

