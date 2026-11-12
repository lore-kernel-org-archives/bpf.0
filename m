Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794501999;
	b=FaY7nLBLBvwUOgWOjYFBwitxwA2fmozp6excjd9W3VKoH/z4Cjlz3rfGE4J1tphxq9Fs
	 CEuVYcxVNZnX60gds3peqqWJCxRjbhjjLx9V79tLGwiARMzTyTLo2yb/J0WxCWdS7YVxD
	 58RS+i3UNwxEVFrRk7aDEF8TvEaZuMtiqBwSrqWRV0Djo2IJY02Uxk6GSLS9kBBDSpmZD
	 4joqfrj7lp/ZXn0S0IoY1FDTe7i5xr2XuGiwt0cFjVufW/SzPbYBgDjXXOaecPShNvz2x
	 6jB9Pml1RygYvYroCCycNGRhfyX5BGHx0QCW/nQfSDyQQP/Wszj+vgg84+Q+tgwo4vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794501999;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=oczwGRSHkHgro1UTGV7sJdqStls2/TNNsLth85qKyco=;
	b=wtgT0+vHrmVvEYhHoDiyrsVyeWMk2Ryfe+84IMmGmaVfT5ikqtZrpU8vGJ3RCwM8pb6d
	 1rUrxI5G83ocXYEZMUww47a/RTaPRTVatWC/drsUdbpDXna0dv5lTA0zNckg4omroAeJF
	 K7lin9MnAi24GAL0xK5vgyGgu2YVZGUmbhqhm5+UQ4dWI7HHGGUDAmZeITUxdWwdRN01/
	 70EuVNxjBNTbM4PV0THQOI0KYJgJDRqe58zsL+C8ndf/vK0mSvOMQQk9udVZ/lFjqiv7v
	 49rfkABu+mZD4AVl/+j2C9pUyawqz3/EpkzHtBr7X0S9IZR2q51xi3vLsSz95aRRjlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xIcyNSLV;
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6CA60A261C
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 16:46:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD6CA60A261C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xIcyNSLV
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cdd89d84521so481059a12.1
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 08:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794501998; x=1795106798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oczwGRSHkHgro1UTGV7sJdqStls2/TNNsLth85qKyco=;
        b=xIcyNSLVrb2d5EbuygZUP+LiQ/0VHrgM5VYY8LEw66FILlsShsX4/bxAo3MKk2129Z
         xTdNldmphnwS0lyb6vkONuHV4YY+K9EP9KdJnAG0uqeZifB0C2MdTYZUmeXd5746TQDd
         3o3s828R57LX4P7raDiuPPt440yMbSbfpzWoV64WyT70vCYn3slXp9NZXRBbiRLrbmq8
         sC9khaNhzkAmWDN7cbjTvkrXp7tq2OQCcLrAvGwtuOhthgpEw3WYmzlVn4dsNd6V7TYV
         n1xxcA22RTKwNppOKlb3MPHy+JCfkTpeitjBS5SLhnTnA/JHDb9/Dkx9Owt6Xn/RMcqB
         MoWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794501998; x=1795106798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oczwGRSHkHgro1UTGV7sJdqStls2/TNNsLth85qKyco=;
        b=xeUb//YWGjtolDuZ1Y6XBNONrYmoraQTAdR7MfoeXM3rcTRmlO88ic5Y3bKVwcNkxb
         r1YzWxh0LVQy49BRS8kCnra43h98jZArQAUIEXLKMaoy31xV2ZVOH36TCArHREjUmBQB
         UNIAOKWsgXqKImat9q1yrglQP9El+FN1TrqS2wXVnqpVgNT+rQnkyGTIwZ1kefPnXztZ
         2fMTY/wQi9e7zO1aorLUslFtqZAQbyiIyNx0u2JFOU3mCtKSWZ6mCEbapFpXUAzKwFlr
         Z9u2lIAKDMzVk4/kOoMYI7fh40DByT7SQyN/Cy9tnjCm6y/aYHotIAwD7MfSUmoHCSVE
         X0/Q==
X-Gm-Message-State: APuU4Z9wdlcjXFbzuilODdfuMhrhVDFbwFO6IcBY/JAgGdmGbWo+iD9P
	cW5JUy0UTquahzKQk0nKSxeUfalwzXTNu3VsGmy30DxZBhOcqTPQYD0Y4Hqh3w==
X-Gm-Gg: AYBFou3kGDeMLHFZ0I3k1K3KqesVHqi6a2MgjLF6tTzAi8Wn+ztHrw+t00ZAleSd+aE
	hgJ5+eGJx997wGN0tfCPWPSZg+B13cTZAUu5GOkpb8eWUA0xdB7DAz6E8YpbzymidbtEDI0ocoP
	oZRfLkB57arKYQMfgAYVNiC52E9nTs7AiGw7MP55CQ7NT8W2YEpzSvl4KnRmXh3tCd7u7u53g+6
	biOo2lYYziHLy5ArItjmKXRJIEtjUVavv9cGOIYxUEBXMUkwxnd5+vqgFxsOkfcAvsc5QOoM+Ll
	n2qw3XdiLUe/Fvlnde90Ns62bmdpQuYyXqMviw8HD2Lw+RAYBCPFcZZBVudzuTJpFaJS30iFpbJ
	YABs1+NsNCvSCB8xLK33H+8X9s8TKgQMoj6ECAiR+xeEgUaDXoT4rT+aTzToXKc1f1T9HdGCAUC
	0dVn/KahW8LgQRIWhBSJRK4XlE51I/QvgxrsoW9zZEenvyw2nZXrpyGK51Pworvpe0NG2H9Arl5
	s0n3PpBqpzOEMJ3JKsXQp7nBrQupYef5iYRBs7/FcjhSE7Bznc5lEa++gNpdzXjNRjz9eD1Evqy
	o7+hUsZIUTX13gUum+lL9K1Jn5SoKYdL5uCdK0+Ord1ZG9/YM9KGz52Vr5fmwpLt51srL8Ih1ee
	Wpt4geSYdOmIjU7FtQZd+FcigikZwCJZiL5zpSR2wWcgwbGt+BETLioyfd+LetfpZ6Nu2uP7fUC
	M=
X-Received: by 2002:a17:90a:c2cc:b0:3a7:9ec3:ea0e with SMTP id 98e67ed59e1d1-3b197caa440mr2132266a91.22.1794501998000;
        Thu, 12 Nov 2026 08:46:38 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d0fdbdsm5439515a91.10.2026.11.12.08.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 08:46:37 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	a.s.protopopov@gmail.com
Subject: [PATCH bpf-next 04/10] resolve_btfids: Find the definitions that reach the return value
Date: Thu, 12 Nov 2026 16:46:04 +0000
Message-ID: <20261112164610.1917256-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261112164610.1917256-1-alexei.starovoitov@gmail.com>
References: <20261112164610.1917256-1-alexei.starovoitov@gmail.com>
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

