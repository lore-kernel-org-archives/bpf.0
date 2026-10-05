Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25789492E20
	for <bpf@vger.kernel.org>; Mon,  5 Oct 2026 14:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791210159; cv=none; b=AZjYLTNYSOK0LXA57Zrl2MZy8OJ8xXof5KX+5bMguudNQW5+6sOufQiy+9TLlGO0aUl7iM+cL2hZcC/ydzz89tk7cKqesJ3VwB5B16XU7M7Zu10Iaul/KjA8+VrzBojMifAHruYPPaddLzCQZZ5nVjrzVUNoRXUbrwwFchxlYDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791210159; c=relaxed/simple;
	bh=Lt7G/mknfW9u87mpXqyhK0xm1w2okf4RGX7PbZG/JOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CTLuDM6X8A7b6iQ6cQvfugeVSldAskwgAVbqObksBOLCOW6YAnw3JGcvNM/eqW2+ii5fPZMERpkDYT+B8WCMwzIifqLiOxfWVuF1d/LHdddGMIbs4GgD5fsQHjpENOI98dYrpwm3ah3DnC5OMENiNPZd4n6b5ZiO2+cidSMYAjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KP1pv7vt; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KP1pv7vt"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49fe8bf173aso11161215e9.3
        for <bpf@vger.kernel.org>; Mon, 05 Oct 2026 07:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791210149; x=1791814949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mZQZDqoTxehiXIWg6WfJWmUQf7d3lEZqs6KGqhPBbaI=;
        b=KP1pv7vtWbUVkq8DXoIaAYTfsz6SICz42TOdQ2qg6q16yiIh4kQueo/n0GZDQJ3ryO
         XAK/NKh0yf/5orlQJSC7IxXZiD198Uz5ouG6Dbkqp6h36+8ugsyViXqa4uSshi1fHdgX
         6LqxQTnzpOr0h9GnFFi5kQ8u88Dx12ACDhpInMQxGtHC7m0qpsr47nTbR/LO2FPcka23
         pLGSSVZW3kVNx12G//qQ85EXY9dvEO55ktwSGTAu1iY3LqdCAfz7XdYDTIa8EZ4GMsZ7
         sQR+X8Ud+9ZvnEYNE9E0XgVXSrTIAZv4jB0xQ+W8Mar0VTL83TWYKCnYE/w9ad2CRxUT
         3NZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791210149; x=1791814949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mZQZDqoTxehiXIWg6WfJWmUQf7d3lEZqs6KGqhPBbaI=;
        b=rMqHkwL9fLGya60C6h9cCrwWeBaeGhqtGHsyi0xPYpnDGzcrG/+ucNRpHqYvryxU4g
         T7O3KJEzxRzO4QcO59EZgIeAfO79XIokVrD6XVkSyG4LDIPzGQ0D8XiOKEhuLM/0JoVN
         NXqp06yCJ8loPCFxArbbXd4HU4e/HhXNJaJgitRRTLT+ccLQosR1xrFLNB6jtIcmd4e3
         7Uo4bCsgkjmUn2HelJ0z0pthwl4wdKkAN0yy03TjvyM1pqmHok5hREAPZxDpx475RHjS
         xihuncQ3HdsTYDO4um+UirDKUSkILOsCzYckSzPJi7GArWGP85qI6PlJap4+ebR4eKMN
         /N3A==
X-Gm-Message-State: AFuF++kuj7QDx4XE0QyxF0QkbAookNEUV+lWdeA+lvvBN/9qPC3izIDc
	v0LOm8GSVx9KGpccOsTsyBRbIfBqm1ouVpoYDcPMYlrw72ogZ223qDHDlsnCf6TEQ5nTCn+T
X-Gm-Gg: AYBFou0nZ48DqPDDVXq3NPFAZeozaRBPVHjzNFQ2L5E0ScBjNgWmINtVxbIAo5VPRe1
	MnBxM1rzsnI/suq7qdVwgTah0mGAV83qbL+bnqqCc1qshChMIt9cBNhrF314pW/dho2GTP6UsoI
	+J8YK33PLsd1KzVs6cziDkhg3QCd3GdrURycYWQ++oFjHzkOhFqWL50zjbZcSt5YB8yWKoGC/Cg
	zdpuPB8kKT18CIiALI5/jwFmxw2g676YvxbR8pzRNJINhTm6YThkmhyZSvX6tbtqNckdPJCGlQO
	uvtVO4u5p/74hms8hTPR8cd3AYA2e2RPkHwHhbYBzi/1MZI2zqQzi3zfyWmcwhEWQDIWjjxidXc
	MaonqMz1QGUcq+ggHfIsG3M33/kxy4jn73Gh6Jhivyncsu081TQCJrm5HHZ7gRELAchMt8Z7L8V
	UcPHxrgui3jzCM6/wQUM1zospBAyuJjgSGmC0i6x9VPRlha5q6SGL0LgsTbC/Dxv3mda+TQI5OH
	mx1Y+B3khqqetSOMyBbuEjkPWJcou52uwhUYumu1AqRE8jm6W/5VFca/loTOnXSTquSFWuaSufQ
	UsjjzGu8lp3YmGl9hiBXxShkX4GBR7HC2fbaCJ8=
X-Received: by 2002:a05:600c:3b9f:b0:4a0:c2a:485e with SMTP id 5b1f17b1804b1-4a1780acb17mr1960815e9.33.1791210148329;
        Mon, 05 Oct 2026 07:22:28 -0700 (PDT)
Received: from macbook (90-182-211-1.rcp.o2.cz. [90.182.211.1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c622ab5a1sm3881623f8f.36.2026.10.05.07.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 07:22:28 -0700 (PDT)
From: Yusheng Zheng <yunwei356@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	x86@kernel.org,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>,
	Hao Sun <sunhao.th@gmail.com>,
	Yusheng Zheng <yunwei356@gmail.com>
Subject: [RFC PATCH bpf-next 5/7] bpf, x86: Add native code for some inline kfuncs
Date: Mon,  5 Oct 2026 07:22:17 -0700
Message-ID: <20261005142219.33451-6-yunwei356@gmail.com>
X-Mailer: git-send-email 2.54.0.windows.1
In-Reply-To: <20261005142219.33451-1-yunwei356@gmail.com>
References: <20261005142219.33451-1-yunwei356@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A copy of a compiled kfunc keeps constant arguments in registers and
cannot put the result in the register of an argument. Give five of the
kfuncs in insn_kfuncs an emit callback that writes x86-64 code: rol by
an immediate, or rorx with BMI2 into another register; test and cmovcc,
with the inverse condition when the result is in the register of the
first value; mov of the control word and bextr with BMI1; movbe; and
lea. Rotating a register in place by 13 is then "rol $13, %rbx" where a
copy takes five instructions. Without BMI1 or MOVBE, or with constants
that the instruction cannot take, the callback returns an error and the
JIT copies the kfunc.

The code is in insn_kfuncs/x86/insn_kfuncs.h, which bpf_insn_kfuncs.c
includes under CONFIG_BPF_INSN_KFUNCS_ARCH, as lib/crc includes the code
for each architecture. The prefetch and the 16-byte copy compile to the
instructions themselves, so they have no callback.

Assisted-by: LLM
Signed-off-by: Yusheng Zheng <yunwei356@gmail.com>
---
 kernel/bpf/insn_kfuncs/Kconfig           |   5 +
 kernel/bpf/insn_kfuncs/Makefile          |   3 +
 kernel/bpf/insn_kfuncs/bpf_insn_kfuncs.c |  21 ++-
 kernel/bpf/insn_kfuncs/x86/insn_kfuncs.h | 155 +++++++++++++++++++++++
 4 files changed, 179 insertions(+), 5 deletions(-)
 create mode 100644 kernel/bpf/insn_kfuncs/x86/insn_kfuncs.h

diff --git a/kernel/bpf/insn_kfuncs/Kconfig b/kernel/bpf/insn_kfuncs/Kconfig
index b2469853899dc..179236855d652 100644
--- a/kernel/bpf/insn_kfuncs/Kconfig
+++ b/kernel/bpf/insn_kfuncs/Kconfig
@@ -9,3 +9,8 @@ config BPF_INSN_KFUNCS
 	  puts native code in its place where it can.
 
 	  If unsure, say N.
+
+config BPF_INSN_KFUNCS_ARCH
+	bool
+	depends on BPF_INSN_KFUNCS
+	default y if X86_64
diff --git a/kernel/bpf/insn_kfuncs/Makefile b/kernel/bpf/insn_kfuncs/Makefile
index e397f626a17a8..31e7ef567c90f 100644
--- a/kernel/bpf/insn_kfuncs/Makefile
+++ b/kernel/bpf/insn_kfuncs/Makefile
@@ -1,2 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_BPF_INSN_KFUNCS) += bpf_insn_kfuncs.o
+ifeq ($(CONFIG_BPF_INSN_KFUNCS_ARCH),y)
+CFLAGS_bpf_insn_kfuncs.o += -I$(src)/$(SRCARCH)
+endif
diff --git a/kernel/bpf/insn_kfuncs/bpf_insn_kfuncs.c b/kernel/bpf/insn_kfuncs/bpf_insn_kfuncs.c
index 1bcc049a5603f..1fcd0d7d0690c 100644
--- a/kernel/bpf/insn_kfuncs/bpf_insn_kfuncs.c
+++ b/kernel/bpf/insn_kfuncs/bpf_insn_kfuncs.c
@@ -118,6 +118,16 @@ static const struct bpf_insn lea64_body[] = {
 	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_4),
 };
 
+#ifdef CONFIG_BPF_INSN_KFUNCS_ARCH
+#include "insn_kfuncs.h" /* $(SRCARCH)/insn_kfuncs.h */
+#else
+#define rol64_emit	NULL
+#define select64_emit	NULL
+#define extract64_emit	NULL
+#define load_be64_emit	NULL
+#define lea64_emit	NULL
+#endif
+
 BTF_KFUNCS_START(insn_kfunc_ids)
 BTF_ID_FLAGS(func, bpf_rol64)
 BTF_ID_FLAGS(func, bpf_select64)
@@ -139,14 +149,15 @@ BTF_ID(func, bpf_lea64)
 
 #define BODY(i, op, emit)	{ &body_ids[i], op##_body, ARRAY_SIZE(op##_body), emit }
 
+/* without emit, the JIT copies the kfunc, whose code is the instruction itself */
 static const struct bpf_kfunc_body bodies[] = {
-	BODY(0, rol64, NULL),
-	BODY(1, select64, NULL),
-	BODY(2, extract64, NULL),
-	BODY(3, load_be64, NULL),
+	BODY(0, rol64, rol64_emit),
+	BODY(1, select64, select64_emit),
+	BODY(2, extract64, extract64_emit),
+	BODY(3, load_be64, load_be64_emit),
 	BODY(4, prefetch, NULL),
 	BODY(5, copy16, NULL),
-	BODY(6, lea64, NULL),
+	BODY(6, lea64, lea64_emit),
 };
 
 static const struct btf_kfunc_id_set insn_kfunc_set = {
diff --git a/kernel/bpf/insn_kfuncs/x86/insn_kfuncs.h b/kernel/bpf/insn_kfuncs/x86/insn_kfuncs.h
new file mode 100644
index 0000000000000..5809bb69b4cd6
--- /dev/null
+++ b/kernel/bpf/insn_kfuncs/x86/insn_kfuncs.h
@@ -0,0 +1,155 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* x86-64 code for the kfuncs in bpf_insn_kfuncs.c, see struct bpf_kfunc_body */
+#include <linux/cpufeature.h>
+#include <linux/log2.h>
+#include <linux/unaligned.h>
+
+static u8 *x86_rex(u8 *p, bool w, u8 reg, u8 rm)
+{
+	u8 b = 0x40 | (w ? 8 : 0) | (reg & 8 ? 4 : 0) | (rm & 8 ? 1 : 0);
+
+	if (b != 0x40)
+		*p++ = b;
+	return p;
+}
+
+/* 64-bit op %reg, %rm */
+static u8 *x86_op_rr(u8 *p, u8 op, u8 reg, u8 rm)
+{
+	p = x86_rex(p, true, reg, rm);
+	*p++ = op;
+	*p++ = 0xc0 | (reg & 7) << 3 | (rm & 7);
+	return p;
+}
+
+/*
+ * ModRM, SIB and displacement of disp(%base, %index, 1 << scale), with @reg in
+ * the reg field. An @index of 4 (%rsp) is none.
+ */
+static u8 *x86_mem(u8 *p, u8 reg, u8 base, u8 index, u8 scale, s32 disp)
+{
+	u8 mod = !disp && (base & 7) != 5 ? 0 : disp == (s8)disp ? 1 : 2;
+	bool sib = index != 4 || (base & 7) == 4;
+
+	*p++ = mod << 6 | (reg & 7) << 3 | (sib ? 4 : base & 7);
+	if (sib)
+		*p++ = scale << 6 | (index & 7) << 3 | (base & 7);
+	if (mod == 1)
+		*p++ = disp;
+	if (mod == 2) {
+		put_unaligned_le32(disp, p);
+		p += 4;
+	}
+	return p;
+}
+
+static int rol64_emit(const u8 *reg, const s32 *imm, u8 *buf)
+{
+	u8 dst = reg[0], src = reg[1], n = imm[BPF_REG_2] & 63, *p = buf;
+
+	if (n && dst != src && cpu_feature_enabled(X86_FEATURE_BMI2)) {
+		/* rorx $(64 - n), %src, %dst */
+		*p++ = 0xc4;
+		*p++ = (dst & 8 ? 0 : 0x80) | 0x40 | (src & 8 ? 0 : 0x20) | 0x03;
+		*p++ = 0xfb;
+		*p++ = 0xf0;
+		*p++ = 0xc0 | (dst & 7) << 3 | (src & 7);
+		*p++ = 64 - n;
+		return p - buf;
+	}
+	if (dst != src || !n)
+		p = x86_op_rr(p, 0x89, src, dst);	/* mov %src, %dst */
+	if (n) {
+		/* rol $n, %dst */
+		p = x86_rex(p, true, 0, dst);
+		*p++ = 0xc1;
+		*p++ = 0xc0 | (dst & 7);
+		*p++ = n;
+	}
+	return p - buf;
+}
+
+/* cmovcc %src, %dst */
+static u8 *x86_cmov(u8 *p, u8 cc, u8 dst, u8 src)
+{
+	p = x86_rex(p, true, dst, src);
+	*p++ = 0x0f;
+	*p++ = 0x40 | cc;
+	*p++ = 0xc0 | (dst & 7) << 3 | (src & 7);
+	return p;
+}
+
+/*
+ * dst = cc ? a : b, after the test or compare at @p. The flags come first, so
+ * the result may take the register of an operand they read. A result in the
+ * register of a takes b with the inverse condition, which a copy of the
+ * compiled kfunc cannot do.
+ */
+static int x86_select(u8 *buf, u8 *p, u8 cc, u8 dst, u8 a, u8 b)
+{
+	if (dst == a)
+		return x86_cmov(p, cc ^ 1, dst, b) - buf;
+	if (dst != b)
+		p = x86_op_rr(p, 0x89, b, dst);	/* mov %b, %dst */
+	return x86_cmov(p, cc, dst, a) - buf;
+}
+
+static int select64_emit(const u8 *reg, const s32 *imm, u8 *buf)
+{
+	u8 cond = reg[1];
+
+	/* test %cond, %cond; cmovne */
+	return x86_select(buf, x86_op_rr(buf, 0x85, cond, cond), 0x5, reg[0],
+			   reg[2], reg[3]);
+}
+
+/* R4 is free for the control word, as there are three arguments */
+static int extract64_emit(const u8 *reg, const s32 *imm, u8 *buf)
+{
+	u8 dst = reg[0], src = reg[1], ctl = dst != src ? dst : reg[4];
+	u32 start = imm[BPF_REG_2], len = imm[BPF_REG_3];
+	u8 *p = buf;
+
+	if (!cpu_feature_enabled(X86_FEATURE_BMI1) || start > 63 || !len || len > 64 - start)
+		return -EOPNOTSUPP;
+	/* mov $(start | len << 8), %ctl */
+	p = x86_rex(p, false, 0, ctl);
+	*p++ = 0xb8 | (ctl & 7);
+	put_unaligned_le32(start | len << 8, p);
+	p += 4;
+	/* bextr %ctl, %src, %dst */
+	*p++ = 0xc4;
+	*p++ = (dst & 8 ? 0 : 0x80) | 0x40 | (src & 8 ? 0 : 0x20) | 0x02;
+	*p++ = 0x80 | (~ctl & 0xf) << 3;
+	*p++ = 0xf7;
+	*p++ = 0xc0 | (dst & 7) << 3 | (src & 7);
+	return p - buf;
+}
+
+static int load_be64_emit(const u8 *reg, const s32 *imm, u8 *buf)
+{
+	u8 dst = reg[0], base = reg[1], *p = buf;
+
+	if (!cpu_feature_enabled(X86_FEATURE_MOVBE))
+		return -EOPNOTSUPP;
+	/* movbe off(%base), %dst */
+	p = x86_rex(p, true, dst, base);
+	*p++ = 0x0f;
+	*p++ = 0x38;
+	*p++ = 0xf0;
+	return x86_mem(p, dst, base, 4, 0, imm[BPF_REG_2]) - buf;
+}
+
+static int lea64_emit(const u8 *reg, const s32 *imm, u8 *buf)
+{
+	u8 dst = reg[0], base = reg[1], index = reg[2], *p = buf;
+	u32 scale = imm[BPF_REG_3];
+
+	/* %rsp cannot be an index, and the scale is 1, 2, 4 or 8 */
+	if (index == 4 || !is_power_of_2(scale) || scale > 8)
+		return -EOPNOTSUPP;
+	/* lea disp(%base, %index, scale), %dst */
+	*p++ = 0x48 | (dst & 8 ? 4 : 0) | (index & 8 ? 2 : 0) | (base & 8 ? 1 : 0);
+	*p++ = 0x8d;
+	return x86_mem(p, dst, base, index, ilog2(scale), imm[BPF_REG_4]) - buf;
+}
-- 
2.51.1

