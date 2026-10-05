Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9344D4A3F2E
	for <bpf@vger.kernel.org>; Mon,  5 Oct 2026 14:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791210165; cv=none; b=tm9S8RoDGzyeFPYBNBQprp2Lb9ZAIwftcqVeq5PVxfwrN+0YDlNOTZL6RZdNvHUQXq54dOxB1tdz5L+Bg4MV8eImEtdxBqc4Mso/GrrPbfZMM3T5BPmZH95QvkMIO/OgiWitaj4dpSsa9Zu2eA5oSkU91jBfwYJgLPAoiDSJ038=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791210165; c=relaxed/simple;
	bh=n4s7MlEsUo00XAftSPMghfNVJGRQRpi8uEPqCQA1gMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cXblMLTrquKj+UJ18Jc5Yfk0e5JFp+WVMtBOYsL8AGAnThKBFwlbiOVazXwlVUX1LkQIzjza0RvraHgZ+QzWqMmv9LkMtQLdqWIwRv1fYSnOAldp6T56EqI8WauwJzY91IhIFR8xoo3XBsMJbWcKrdbUzBIZ12cLZQcaYfnE0kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZ3/XCWc; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZ3/XCWc"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-48b042e00f7so959074f8f.0
        for <bpf@vger.kernel.org>; Mon, 05 Oct 2026 07:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791210154; x=1791814954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RJM6wG6rWxjrMH1I/Utc3TiaeCB0SkgfdzSdr61wbxM=;
        b=YZ3/XCWc3qXM3SU48Y/OP7OiXScPzHrwAsLs70TMtaXwsaQZamaKrIYiP+/KIWiMp7
         7EOvU1LlP7xBh+2je3UyiRxDImCWxq6vBviV03fHrmcl1bCkLenODzietj0LtgFyrKCr
         RLPeADM6HCjhpiG09KjEE8g9hJplBKVtuMYcKq7iHud7xDdpbM4qA1e2D4lmH5kTia1Y
         4Vas7xSiYh1c+o1j0ZQyKAYew7kjnr4AJwgKQ1CYEbijNGZE/0oFKOkSBZs5W9uq26SK
         NC0Iq+/J0E21QArIRYyj83s0DTo2NtaiDfmlPuqeCrI1JZl2yz9d/LMbl6YXvo55/vsO
         k3Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791210154; x=1791814954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RJM6wG6rWxjrMH1I/Utc3TiaeCB0SkgfdzSdr61wbxM=;
        b=i8fCYfSMgDqDDTP8JJJ3UQzruEm+r2ncX+TNYJ36c4rhBpiWMZrNLzBh3KTutqnqOJ
         n//ZikVmgI7NjZcjfW4lkHmrE6u7XsZYmirMu3BUXPU9Hcr2+iGH9x8hdblD16YZlhCO
         iNgFEGgGYFdw4VuvFfrPnhrvJODy5LswDC/s5+r1baN1ApcBSSg56TgrnFubwXMGZgBt
         zudUF6lyVqEQYh8O4iXlhKuOFbmSuJWmYqJJ2SCj7Yukg5XavLp/d+NYsldouKHLe9UN
         tcUYvGx4iwHUZtGvJVLFJWbUsKA172y6KHK54UW3WSDGnZHJQC68SIgEeKn3CRgL9/5K
         t1Sg==
X-Gm-Message-State: AFq9FYIk/Sm/kfqXwq5H2xLofpOrZxkS1QkMkunmCNg3jmv1p3eZb5hi
	Leg5B0FTivS4+Ff6EbxUO79DSi9HfPuhXy6eTLS6PTAdVIkDuCUW/kTEX/+nwKgw8vW6NPdj
X-Gm-Gg: AYBFou36/qFnq0YI9TTUi06RU0gxGu2VYje1UBBqT80zpVyHWRh/aO4n2VeU/QHAFen
	M0AQ2DgTj0+/AcP+MKXvRPxBJN7N4RivClNbg1z/84C9estztfF6QfupKYSwsq0lPTKj6a9Xr/x
	IAWTO16lEFWD4qlkZI4VW1egGYx4IA7qDxG4qTDQqnWfnkkW252HJA+qidaW34hSFsigz3N+VaF
	6chdvfJw89Oxu0M7hCh7maZWVK/VUmQd85F+kfTItCUKE128/cnh3vwQOmUp3Jh2eG3Sh+QDJni
	s2aebNeSGE0l6WDoa9EHSE1W1N2Jh/DaPaNLUG7qmzOuqdqXGhSIIsnUe+Quk7V10gL3w6Hj0+I
	Blzj4xW0EG6Qd11AkrYVc4qxj2Eh2Pdoj60/QX/UOxpu1cG+3NX0JupdCNUsPYvEaC4xQ0+YYFC
	ev8DVcCrsYLr/lPCrZ4LRRNYd+MKD2OIRMTW05hMnbn6GurBYM8u/hF9/wcKbzMkEiAB30hbAw3
	kRw136m8qUSbCLDz4QeQTxd/OgUESEQETRJIy3k+dljldjmZJvo1I/js/8pl+nuaQ8C5XZTNqzM
	7vwz2SYa+OACUxd5VZPD593QQIPh2YZAGqWG4w==
X-Received: by 2002:a05:6000:605:b0:488:89ad:56c0 with SMTP id ffacd0b85a97d-48b1270fbb0mr19700006f8f.11.1791210146929;
        Mon, 05 Oct 2026 07:22:26 -0700 (PDT)
Received: from macbook (90-182-211-1.rcp.o2.cz. [90.182.211.1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c622ab5a1sm3881623f8f.36.2026.10.05.07.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 07:22:26 -0700 (PDT)
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
Subject: [RFC PATCH bpf-next 4/7] bpf: Add kfuncs with bodies for common operations
Date: Mon,  5 Oct 2026 07:22:16 -0700
Message-ID: <20261005142219.33451-5-yunwei356@gmail.com>
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

Add kfuncs with bodies for the operation families evaluated in [1]:
bpf_rol64() (rotate), bpf_select64() (conditional select),
bpf_extract64() (bit field extract), bpf_load_be64() (big-endian load),
bpf_prefetch(), bpf_copy16() (16-byte copy) and bpf_lea64() (address
computation). They are in kernel/bpf/insn_kfuncs/, apart from the
verifier and the JITs, under the new CONFIG_BPF_INSN_KFUNCS, which can
be built in or as a module. The x86-64 JIT inlines copies of their
compiled code.

A prefetch is a load whose value is not used, so the verifier checks the
address like that of any load. bpf_copy16() loads both halves before it
stores them, like its body, so that a copy of it and the body agree
when the buffers overlap.

[1] https://arxiv.org/abs/2606.24213

Assisted-by: LLM
Signed-off-by: Yusheng Zheng <yunwei356@gmail.com>
---
 kernel/bpf/Kconfig                       |   1 +
 kernel/bpf/Makefile                      |   1 +
 kernel/bpf/insn_kfuncs/Kconfig           |  11 ++
 kernel/bpf/insn_kfuncs/Makefile          |   2 +
 kernel/bpf/insn_kfuncs/bpf_insn_kfuncs.c | 173 +++++++++++++++++++++++
 5 files changed, 188 insertions(+)
 create mode 100644 kernel/bpf/insn_kfuncs/Kconfig
 create mode 100644 kernel/bpf/insn_kfuncs/Makefile
 create mode 100644 kernel/bpf/insn_kfuncs/bpf_insn_kfuncs.c

diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
index 98493e32db2ad..ca0dbfa1f81c5 100644
--- a/kernel/bpf/Kconfig
+++ b/kernel/bpf/Kconfig
@@ -101,6 +101,7 @@ config BPF_CRYPTO
 	  data. The supported algorithms are AES-CBC and AES-ECB.
 
 source "kernel/bpf/preload/Kconfig"
+source "kernel/bpf/insn_kfuncs/Kconfig"
 
 config BPF_LSM
 	bool "Enable BPF LSM Instrumentation"
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index ae3d04dae2d33..94c81491a8e65 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -60,6 +60,7 @@ obj-${CONFIG_BPF_LSM} += bpf_lsm_proto.o bpf_lsm.o
 endif
 obj-$(CONFIG_BPF_CRYPTO) += crypto.o
 obj-$(CONFIG_BPF_PRELOAD) += preload/
+obj-$(CONFIG_BPF_INSN_KFUNCS) += insn_kfuncs/
 
 obj-$(CONFIG_BPF_SYSCALL) += relo_core.o
 obj-$(CONFIG_BPF_SYSCALL) += btf_iter.o
diff --git a/kernel/bpf/insn_kfuncs/Kconfig b/kernel/bpf/insn_kfuncs/Kconfig
new file mode 100644
index 0000000000000..b2469853899dc
--- /dev/null
+++ b/kernel/bpf/insn_kfuncs/Kconfig
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config BPF_INSN_KFUNCS
+	tristate "Kfuncs for CPU instructions that BPF lacks"
+	depends on BPF_SYSCALL && BPF_JIT && DEBUG_INFO_BTF
+	help
+	  Provide kfuncs for rotate, conditional select, bit field extract,
+	  big-endian load, prefetch, 16-byte copy and address computation.
+	  The verifier checks each call as the kfunc's BPF body, and the JIT
+	  puts native code in its place where it can.
+
+	  If unsure, say N.
diff --git a/kernel/bpf/insn_kfuncs/Makefile b/kernel/bpf/insn_kfuncs/Makefile
new file mode 100644
index 0000000000000..e397f626a17a8
--- /dev/null
+++ b/kernel/bpf/insn_kfuncs/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_BPF_INSN_KFUNCS) += bpf_insn_kfuncs.o
diff --git a/kernel/bpf/insn_kfuncs/bpf_insn_kfuncs.c b/kernel/bpf/insn_kfuncs/bpf_insn_kfuncs.c
new file mode 100644
index 0000000000000..1bcc049a5603f
--- /dev/null
+++ b/kernel/bpf/insn_kfuncs/bpf_insn_kfuncs.c
@@ -0,0 +1,173 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Kfuncs for CPU instructions that BPF lacks, with BPF bodies, see struct
+ * bpf_kfunc_body. Arguments named __k must be known constants.
+ */
+#include <linux/bitops.h>
+#include <linux/btf.h>
+#include <linux/btf_ids.h>
+#include <linux/filter.h>
+#include <linux/module.h>
+#include <linux/unaligned.h>
+
+__bpf_kfunc_start_defs();
+
+__bpf_kfunc u64 bpf_rol64(u64 x, u32 n__k)
+{
+	return rol64(x, n__k);
+}
+
+__bpf_kfunc u64 bpf_select64(u64 cond, u64 a, u64 b)
+{
+	return cond ? a : b;
+}
+
+__bpf_kfunc u64 bpf_extract64(u64 x, u32 start__k, u32 len__k)
+{
+	return x << (64 - start__k - len__k) >> (64 - len__k);
+}
+
+__bpf_kfunc u64 bpf_load_be64(const void *p, s32 off__k)
+{
+	return get_unaligned_be64(p + off__k);
+}
+
+__bpf_kfunc void bpf_prefetch(const void *p)
+{
+	/* not prefetch(), which boot-time alternatives may rewrite */
+	__builtin_prefetch(p);
+}
+
+__bpf_kfunc void bpf_copy16(void *dst, const void *src)
+{
+	/* both loads first, as in the body, in case the buffers overlap */
+	u64 lo = get_unaligned((const u64 *)src);
+	u64 hi = get_unaligned((const u64 *)(src + 8));
+
+	put_unaligned(lo, (u64 *)dst);
+	put_unaligned(hi, (u64 *)(dst + 8));
+}
+
+__bpf_kfunc u64 bpf_lea64(u64 base, u64 index, u32 scale__k, s32 disp__k)
+{
+	return base + index * scale__k + disp__k;
+}
+
+__bpf_kfunc_end_defs();
+
+/* x << n | x >> (-n & 63) */
+static const struct bpf_insn rol64_body[] = {
+	BPF_ALU64_IMM(BPF_AND, BPF_REG_2, 63),
+	BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
+	BPF_ALU64_REG(BPF_LSH, BPF_REG_0, BPF_REG_2),
+	BPF_ALU64_IMM(BPF_NEG, BPF_REG_2, 0),
+	BPF_ALU64_IMM(BPF_AND, BPF_REG_2, 63),
+	BPF_ALU64_REG(BPF_RSH, BPF_REG_1, BPF_REG_2),
+	BPF_ALU64_REG(BPF_OR, BPF_REG_0, BPF_REG_1),
+};
+
+/* the jump lands within the body, here on its last instruction */
+static const struct bpf_insn select64_body[] = {
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 1),
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_3),
+	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
+};
+
+/* x << (64 - start - len) >> (64 - len) */
+static const struct bpf_insn extract64_body[] = {
+	BPF_MOV32_IMM(BPF_REG_4, 64),
+	BPF_ALU32_REG(BPF_SUB, BPF_REG_4, BPF_REG_2),
+	BPF_ALU32_REG(BPF_SUB, BPF_REG_4, BPF_REG_3),
+	BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
+	BPF_ALU64_REG(BPF_LSH, BPF_REG_0, BPF_REG_4),
+	BPF_MOV32_IMM(BPF_REG_4, 64),
+	BPF_ALU32_REG(BPF_SUB, BPF_REG_4, BPF_REG_3),
+	BPF_ALU64_REG(BPF_RSH, BPF_REG_0, BPF_REG_4),
+};
+
+/* the offset is an s32 */
+static const struct bpf_insn load_be64_body[] = {
+	BPF_ALU64_IMM(BPF_LSH, BPF_REG_2, 32),
+	BPF_ALU64_IMM(BPF_ARSH, BPF_REG_2, 32),
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_2),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, 0),
+	BPF_ENDIAN(BPF_TO_BE, BPF_REG_0, 64),
+};
+
+/* a load whose value is not used, of memory that the program may read */
+static const struct bpf_insn prefetch_body[] = {
+	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_1, 0),
+};
+
+/* two loads, then two stores */
+static const struct bpf_insn copy16_body[] = {
+	BPF_LDX_MEM(BPF_DW, BPF_REG_4, BPF_REG_2, 0),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_5, BPF_REG_2, 8),
+	BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_4, 0),
+	BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_5, 8),
+};
+
+/* base + index * scale + disp, scale a u32 and disp an s32 */
+static const struct bpf_insn lea64_body[] = {
+	BPF_MOV32_REG(BPF_REG_3, BPF_REG_3),
+	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
+	BPF_ALU64_REG(BPF_MUL, BPF_REG_0, BPF_REG_3),
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
+	BPF_ALU64_IMM(BPF_LSH, BPF_REG_4, 32),
+	BPF_ALU64_IMM(BPF_ARSH, BPF_REG_4, 32),
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_4),
+};
+
+BTF_KFUNCS_START(insn_kfunc_ids)
+BTF_ID_FLAGS(func, bpf_rol64)
+BTF_ID_FLAGS(func, bpf_select64)
+BTF_ID_FLAGS(func, bpf_extract64)
+BTF_ID_FLAGS(func, bpf_load_be64)
+BTF_ID_FLAGS(func, bpf_prefetch)
+BTF_ID_FLAGS(func, bpf_copy16)
+BTF_ID_FLAGS(func, bpf_lea64)
+BTF_KFUNCS_END(insn_kfunc_ids)
+
+BTF_ID_LIST(body_ids)
+BTF_ID(func, bpf_rol64)
+BTF_ID(func, bpf_select64)
+BTF_ID(func, bpf_extract64)
+BTF_ID(func, bpf_load_be64)
+BTF_ID(func, bpf_prefetch)
+BTF_ID(func, bpf_copy16)
+BTF_ID(func, bpf_lea64)
+
+#define BODY(i, op, emit)	{ &body_ids[i], op##_body, ARRAY_SIZE(op##_body), emit }
+
+static const struct bpf_kfunc_body bodies[] = {
+	BODY(0, rol64, NULL),
+	BODY(1, select64, NULL),
+	BODY(2, extract64, NULL),
+	BODY(3, load_be64, NULL),
+	BODY(4, prefetch, NULL),
+	BODY(5, copy16, NULL),
+	BODY(6, lea64, NULL),
+};
+
+static const struct btf_kfunc_id_set insn_kfunc_set = {
+	.owner    = THIS_MODULE,
+	.set      = &insn_kfunc_ids,
+	.bodies   = bodies,
+	.body_cnt = ARRAY_SIZE(bodies),
+};
+
+static int __init insn_kfuncs_init(void)
+{
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC, &insn_kfunc_set);
+}
+
+/* the kfunc set goes away with the module's BTF */
+static void __exit insn_kfuncs_exit(void)
+{
+}
+
+module_init(insn_kfuncs_init);
+module_exit(insn_kfuncs_exit);
+
+MODULE_DESCRIPTION("Kfuncs for CPU instructions that BPF lacks");
+MODULE_LICENSE("GPL");
-- 
2.51.1

