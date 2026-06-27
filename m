Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671153B4E84;
	Sat, 27 Jun 2026 14:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782571985; cv=none; b=creSlH6SEEBfAgnXN/06rOoMqjh1um8TeqB0jM5ZHEk544dhe+D2Dcn58MjOdJIIs0Eykv2LZk1VM0sp4J2R3uFENJN1WiJSaKVma07fNBiJRlXahM3rG09bcfC6mG2nZLo/1uBn+FBbTBoCH4CflwOlI24elste5g/J1+Vv3Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782571985; c=relaxed/simple;
	bh=7rsGQi/uYvkzFED0D36thBUZsjS2JW0WwlTF6eao9EM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pDnSBcfAVRgwrfzkpw8eiH7PQ6Fyrp1BD+Zp05T9kcw+IrLmphNTm3HYEyngZAbfInHxypuLztUgnUvPvVEvM5bK2WibA6cs75VBomK/kGz1ivxUXAY68uO/n3fyM8Z70auqQYE83ZEIrDDfo2jCtE7oOHrw7CQaFxTtOKMnqZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gnb9B70MtzYQtJF;
	Sat, 27 Jun 2026 22:51:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id C0C234056E;
	Sat, 27 Jun 2026 22:52:46 +0800 (CST)
Received: from localhost.huawei.com (unknown [10.67.174.243])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgAHPCa94z9qh0oVAA--.10903S4;
	Sat, 27 Jun 2026 22:52:46 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	KP Singh <kpsingh@kernel.org>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Eyal Birger <eyal.birger@gmail.com>,
	Rong Tao <rongtao@cestc.cn>
Subject: [RFC PATCH bpf-next 02/12] libbpf: Introduce bpf SDT probe macros
Date: Sat, 27 Jun 2026 22:51:36 +0000
Message-ID: <8d42452bd09872847be4c1953e4e1362db898d9a.1782571533.git.xukuohai@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1782571533.git.xukuohai@huawei.com>
References: <cover.1782571533.git.xukuohai@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgAHPCa94z9qh0oVAA--.10903S4
X-Coremail-Antispam: 1UD129KBjvAXoW3KFW5urW7KrWrtrykZFyftFb_yoW8Wr47Ao
	W7CF4YkanYqryxCFn3WF1xGFWkW3WxGF1rtF4UX398W3ZrtrZ5ur1xW3s3JFsrXrZ8Jrsx
	Z347X3WkKwnFvF4rn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUO37kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8Xw
	A2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IE
	w2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84
	ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0D
	M28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I
	0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCa
	FVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_Jr
	Wlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j
	6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr
	0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUv
	cSsGvfC2KfnxnUUI43ZEXa7IU0-txDUUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

Introduce macros to declare and define bpf SDT probes. The declaration is
used to generate BTF ID of FUNC_PROTO for each probe site, so the probe
sites can be validated by the kernel, and observer programs can be attached
to the FUNC_PROTO like normal tracing programs.

1. Example

A probe in the target program can be declared and defined like:

    BPF_SDT_DECLARE2(my_trace, int, int);

    SEC("xdp")
    int xdp_prog(struct xdp_md *ctx)
    {
        int len = ctx->data_end - ctx->data;
        int ret = XDP_DROP;
        ...
        BPF_SDT_PROBE2(my_trace, len, ret);
        ...
    }

An observer would be like:

    SEC("bpf_sdt")
    int BPF_PROG(observer_prog, int len, int ret)
    {
        bpf_printk("len=%d ret=%d\n", len, ret);
        return 0;
    }

The target program and probe site is set at attach time dynamically.

2. Design

2.1 declaration macro

BPF_SDT_DECLARE<N>(name, types...) generates:

  - A BTF function-pointer variable in a .debug_* section:

        static void (*const __sdt_type_##name)(types...);

    which produces a BTF VAR -> PTR -> FUNC_PROTO(types...) chain
    tagged with btf_decl_tag("bpf_sdt:<name>:<nargs>"). The BPF
    linker discards the .debug_* section but preserves the BTF
    entries, so the argument types survive into the final object.
    The type will be passed to the kernel for the verifier to check
    if it matches the real value type in the argument register.

  - One dummy static variable per argument:

        __attribute__((section(".debug_bpf_sdt_chk")))
        typeof(declared_type) __sdt_chk_##name##_N;

    The dummy variable carries the declared type. At the
    BPF_SDT_PROBE call site, _Static_assert with
    __builtin_types_compatible_p() compares the caller's actual
    argument type against the dummy variable's type:

        _Static_assert(__builtin_types_compatible_p(
                        typeof(caller_arg),
                        typeof(__sdt_chk_##name##_N)),
                        "type mismatch");

    For example, if the caller passes an int where the declaration
    said char *, the compiler fails with a message naming the
    mismatched argument.

2.2 probe macro

BPF_SDT_PROBE<N> is an inline assembly sequence that emits into two
ELF sections simultaneously. A goto+0 instruction is inserted at the
call site in the bpf prog code section. It works as a NOP, and will be
patched to a jump instruction when an observer is attached. The call
site address and argument information are recorded into a separate
section .bpf_sdt_notes. This section is not executed, it is used as
metadata. libbpf will convert the metadata to an insn_array map at
load time.

An interesting note is that the argument registers are recorded in
BPF move instructions, like r1 = %[arg_reg0]. The instruction is not
executed, it is only used by the linker to extract the argument
register from the src_reg.

For BPF_SDT_PROBE2(my_trace, len, ret) the compiler produces:

  [code section, e.g. xdp]
      goto +0                  // NOP, patched to CALL at attach time

  [.bpf_sdt_notes]
      ___sdt_jt_my_trace:      // symbol marking this entry's boundary
      .quad  0b                // 8 bytes: offset of the NOP in the code
                               // section (resolved by the linker via
                               // R_BPF_64_ABS64 relocation)
      r1 = %[arg1_reg]         // 8 bytes per argument: BPF move insn
                               // whose src_reg field encodes the BPF
                               // register holding each probe argument
      r2 = %[arg2_reg]

      ....

  [.BTF]
      FUNC_PROTO (int, int) -> void   // from BPF_SDT_DECLARE2 stub
      DECL_TAG "bpf_sdt:my_trace:2"   // keyed by name + nargs

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 tools/lib/bpf/Makefile  |   2 +-
 tools/lib/bpf/bpf_sdt.h | 346 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 347 insertions(+), 1 deletion(-)
 create mode 100644 tools/lib/bpf/bpf_sdt.h

diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index eca584fb061e..1f6f027a327b 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -235,7 +235,7 @@ install_lib: all_cmd
 
 SRC_HDRS := bpf.h libbpf.h btf.h libbpf_common.h libbpf_legacy.h	     \
 	    bpf_helpers.h bpf_tracing.h bpf_endian.h bpf_core_read.h	     \
-	    skel_internal.h libbpf_version.h usdt.bpf.h
+	    skel_internal.h libbpf_version.h usdt.bpf.h bpf_sdt.h
 GEN_HDRS := $(BPF_GENERATED)
 
 INSTALL_PFX := $(DESTDIR)$(prefix)/include/bpf
diff --git a/tools/lib/bpf/bpf_sdt.h b/tools/lib/bpf/bpf_sdt.h
new file mode 100644
index 000000000000..23f84460aa36
--- /dev/null
+++ b/tools/lib/bpf/bpf_sdt.h
@@ -0,0 +1,346 @@
+/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
+
+/*
+ * USDT-like probe for BPF programs.
+ *
+ * 1. Example
+ *
+ * A probe in the target program can be declared and defined like:
+ *
+ *   BPF_SDT_DECLARE2(my_trace, int, int);
+ *
+ *   SEC("xdp")
+ *   int xdp_prog(struct xdp_md *ctx)
+ *   {
+ *       int len = ctx->data_end - ctx->data;
+ *       int ret = XDP_DROP;
+ *       ...
+ *       BPF_SDT_PROBE2(my_trace, len, ret);
+ *       ...
+ *   }
+ *
+ * An observer would be like:
+ *
+ *   SEC("bpf_sdt")
+ *   int BPF_PROG(observer_prog, int len, int ret)
+ *   {
+ *       bpf_printk("len=%d ret=%d\n", len, ret);
+ *       return 0;
+ *   }
+ *
+ * The target program and probe site is set at attach time dynamically.
+ *
+ * 2. Design
+ *
+ * 2.1 declaration macro
+ *
+ * BPF_SDT_DECLARE<N>(name, types...) generates:
+ *
+ *  - A BTF function-pointer variable in a .debug_* section:
+ *
+ *       static void (*const __sdt_type_##name)(types...);
+ *
+ *   which produces a BTF VAR -> PTR -> FUNC_PROTO(types...) chain
+ *   tagged with btf_decl_tag("bpf_sdt:<name>:<nargs>"). The BPF
+ *   linker discards the .debug_* section but preserves the BTF
+ *   entries, so the argument types survive into the final object.
+ *   The type will be passed to the kernel for the verifier to check
+ *   if it matches the real value type in the argument register.
+ *
+ *  - One dummy static variable per argument:
+ *
+ *       __attribute__((section(".debug_bpf_sdt_chk")))
+ *       typeof(declared_type) __sdt_chk_##name##_N;
+ *
+ *   The dummy variable carries the declared type. At the
+ *   BPF_SDT_PROBE call site, _Static_assert with
+ *   __builtin_types_compatible_p() compares the caller's actual
+ *   argument type against the dummy variable's type:
+ *
+ *       _Static_assert(__builtin_types_compatible_p(
+ *                       typeof(caller_arg),
+ *                       typeof(__sdt_chk_##name##_N)),
+ *                       "type mismatch");
+ *
+ *   For example, if the caller passes an int where the declaration
+ *   said char *, the compiler fails with a message naming the
+ *   mismatched argument.
+ *
+ * 2.2 probe macro
+ *
+ * BPF_SDT_PROBE<N> is an inline assembly sequence that emits into two
+ * ELF sections simultaneously. A goto+0 instruction is inserted at the
+ * call site in the bpf prog code section. It works as a NOP, and will be
+ * patched to a jump instruction when an observer is attached. The call
+ * site address and argument information are recorded into a separate
+ * section .bpf_sdt_notes. This section is not executed, it is used as
+ * metadata. libbpf will convert the metadata to an insn_array map at
+ * load time.
+ *
+ * An interesting note is that the argument registers are recorded in
+ * BPF move instructions, like r1 = %[arg_reg0]. The instruction is not
+ * executed, it is only used by the linker to extract the argument
+ * register from the src_reg.
+ *
+ * For BPF_SDT_PROBE2(my_trace, len, ret) the compiler produces:
+ *
+ * [code section, e.g. xdp]
+ *     goto +0                  // NOP, patched to CALL at attach time
+ *
+ * [.bpf_sdt_notes]
+ *     ___sdt_jt_my_trace:      // symbol marking this entry's boundary
+ *     .quad  0b                // 8 bytes: offset of the NOP in the code
+ *                              // section (resolved by the linker via
+ *                              // R_BPF_64_ABS64 relocation)
+ *     r1 = %[arg1_reg]         // 8 bytes per argument: BPF move instruction
+ *                              // whose src_reg field encodes the BPF
+ *                              // register holding each probe argument
+ *     r2 = %[arg2_reg]
+ *
+ *     ....
+ *
+ *  [.BTF]
+ *     FUNC_PROTO (int, int) -> void   // from BPF_SDT_DECLARE2 stub
+ *     DECL_TAG "bpf_sdt:my_trace:2"   // keyed by name + nargs
+ */
+
+#ifndef __BPF_SDT_PROBE_H
+#define __BPF_SDT_PROBE_H
+
+#define ___sdt_decl_attr(name, nargs)					\
+	__attribute__((used, section(".debug_bpf_sdt_types"),		\
+			btf_decl_tag("bpf_sdt:" #name ":" #nargs)))
+
+#define ___sdt_chk_attr							\
+	 __attribute__((unused, section(".debug_bpf_sdt_chk")))
+
+#define BPF_SDT_DECLARE(name)						\
+	___sdt_decl_attr(name, 0)					\
+	static void (*const __sdt_type_##name)(void)
+
+#define BPF_SDT_DECLARE1(name, t0)					\
+	___sdt_decl_attr(name, 1)					\
+	static void (*const __sdt_type_##name)(t0);			\
+	___sdt_chk_attr t0 __sdt_chk_##name##_0
+
+#define BPF_SDT_DECLARE2(name, t0, t1)					\
+	___sdt_decl_attr(name, 2)					\
+	static void (*const __sdt_type_##name)(t0, t1);			\
+	___sdt_chk_attr t0 __sdt_chk_##name##_0;			\
+	___sdt_chk_attr t1 __sdt_chk_##name##_1
+
+#define BPF_SDT_DECLARE3(name, t0, t1, t2)				\
+	___sdt_decl_attr(name, 3)					\
+	static void (*const __sdt_type_##name)(t0, t1, t2);		\
+	___sdt_chk_attr t0 __sdt_chk_##name##_0;			\
+	___sdt_chk_attr t1 __sdt_chk_##name##_1;			\
+	___sdt_chk_attr t2 __sdt_chk_##name##_2
+
+#define BPF_SDT_DECLARE4(name, t0, t1, t2, t3)				\
+	___sdt_decl_attr(name, 4)					\
+	static void (*const __sdt_type_##name)(t0, t1, t2, t3);		\
+	___sdt_chk_attr t0 __sdt_chk_##name##_0;			\
+	___sdt_chk_attr t1 __sdt_chk_##name##_1;			\
+	___sdt_chk_attr t2 __sdt_chk_##name##_2;			\
+	___sdt_chk_attr t3 __sdt_chk_##name##_3
+
+#define BPF_SDT_DECLARE5(name, t0, t1, t2, t3, t4)			\
+	___sdt_decl_attr(name, 5)					\
+	static void (*const __sdt_type_##name)(t0, t1, t2, t3, t4);	\
+	___sdt_chk_attr t0 __sdt_chk_##name##_0;			\
+	___sdt_chk_attr t1 __sdt_chk_##name##_1;			\
+	___sdt_chk_attr t2 __sdt_chk_##name##_2;			\
+	___sdt_chk_attr t3 __sdt_chk_##name##_3;			\
+	___sdt_chk_attr t4 __sdt_chk_##name##_4
+
+/* probe macros, 0-5 arguments
+ *
+ * Each probe emits a NOP (goto +0) in the program stream plus a
+ * .bpf_sdt_notes entry.  The entry begins with the ___sdt_jt_<name>
+ * label so that libbpf can locate each entry boundary at load time.
+ * One BPF_SDT_PROBE<N> invocation per probe name is required; invoking
+ * the same name twice produces a duplicate symbol.
+ */
+#define BPF_SDT_PROBE(name)						\
+({									\
+	asm volatile(							\
+		"0:\n"							\
+		"goto +0\n"						\
+		".pushsection .bpf_sdt_notes,\"\",@progbits\n"		\
+		"___sdt_jt_" #name ":\n"				\
+		".quad 0b\n"						\
+		".popsection\n"						\
+	);								\
+})
+
+#define BPF_SDT_PROBE1(name, a)						\
+({									\
+	_Static_assert(__builtin_types_compatible_p(typeof(a),		\
+			typeof(__sdt_chk_##name##_0)),			\
+			"BPF_SDT_PROBE1: arg0 type mismatch");		\
+	_Static_assert(sizeof(typeof(a)) <= 8,				\
+			"BPF_SDT_PROBE1: arg0 too large, use pointer");	\
+	typeof(a) __a0 = (a);						\
+	asm volatile(							\
+		"0:\n"							\
+		"goto +0\n"						\
+		".pushsection .bpf_sdt_notes,\"\",@progbits\n"		\
+		"___sdt_jt_" #name ":\n"				\
+		".quad 0b\n"						\
+		"r1 = %0\n"						\
+		".popsection\n"						\
+		:: "r"(__a0)						\
+	);								\
+})
+
+#define BPF_SDT_PROBE2(name, a, b)					\
+({									\
+	_Static_assert(__builtin_types_compatible_p(typeof(a),		\
+			typeof(__sdt_chk_##name##_0)),			\
+			"BPF_SDT_PROBE2: arg0 type mismatch");		\
+	_Static_assert(sizeof(typeof(a)) <= 8,				\
+			"BPF_SDT_PROBE2: arg0 too large, use pointer");	\
+	_Static_assert(__builtin_types_compatible_p(typeof(b),		\
+			typeof(__sdt_chk_##name##_1)),			\
+			"BPF_SDT_PROBE2: arg1 type mismatch");		\
+	_Static_assert(sizeof(typeof(b)) <= 8,				\
+			"BPF_SDT_PROBE2: arg1 too large, use pointer");	\
+	typeof(a) __a0 = (a);						\
+	typeof(b) __a1 = (b);						\
+	asm volatile(							\
+		"0:\n"							\
+		"goto +0\n"						\
+		".pushsection .bpf_sdt_notes,\"\",@progbits\n"		\
+		"___sdt_jt_" #name ":\n"				\
+		".quad 0b\n"						\
+		"r1 = %0\n"						\
+		"r2 = %1\n"						\
+		".popsection\n"						\
+		:: "r"(__a0), "r"(__a1)					\
+	);								\
+})
+
+#define BPF_SDT_PROBE3(name, a, b, c)					\
+({									\
+	_Static_assert(__builtin_types_compatible_p(typeof(a),		\
+			typeof(__sdt_chk_##name##_0)),			\
+			"BPF_SDT_PROBE3: arg0 type mismatch");		\
+	_Static_assert(sizeof(typeof(a)) <= 8,				\
+			"BPF_SDT_PROBE3: arg0 too large, use pointer");	\
+	_Static_assert(__builtin_types_compatible_p(typeof(b),		\
+			typeof(__sdt_chk_##name##_1)),			\
+			"BPF_SDT_PROBE3: arg1 type mismatch");		\
+	_Static_assert(sizeof(typeof(b)) <= 8,				\
+			"BPF_SDT_PROBE3: arg1 too large, use pointer");	\
+	_Static_assert(__builtin_types_compatible_p(typeof(c),		\
+			typeof(__sdt_chk_##name##_2)),			\
+			"BPF_SDT_PROBE3: arg2 type mismatch");		\
+	_Static_assert(sizeof(typeof(c)) <= 8,				\
+			"BPF_SDT_PROBE3: arg2 too large, use pointer");	\
+	typeof(a) __a0 = (a);						\
+	typeof(b) __a1 = (b);						\
+	typeof(c) __a2 = (c);						\
+	asm volatile(							\
+		"0:\n"							\
+		"goto +0\n"						\
+		".pushsection .bpf_sdt_notes,\"\",@progbits\n"		\
+		"___sdt_jt_" #name ":\n"				\
+		".quad 0b\n"						\
+		"r1 = %0\n"						\
+		"r2 = %1\n"						\
+		"r3 = %2\n"						\
+		".popsection\n"						\
+		:: "r"(__a0), "r"(__a1), "r"(__a2)			\
+	);								\
+})
+
+#define BPF_SDT_PROBE4(name, a, b, c, d)				\
+({									\
+	_Static_assert(__builtin_types_compatible_p(typeof(a),		\
+			typeof(__sdt_chk_##name##_0)),			\
+			"BPF_SDT_PROBE4: arg0 type mismatch");		\
+	_Static_assert(sizeof(typeof(a)) <= 8,				\
+			"BPF_SDT_PROBE4: arg0 too large, use pointer");	\
+	_Static_assert(__builtin_types_compatible_p(typeof(b),		\
+			typeof(__sdt_chk_##name##_1)),			\
+			"BPF_SDT_PROBE4: arg1 type mismatch");		\
+	_Static_assert(sizeof(typeof(b)) <= 8,				\
+			"BPF_SDT_PROBE4: arg1 too large, use pointer");	\
+	_Static_assert(__builtin_types_compatible_p(typeof(c),		\
+			typeof(__sdt_chk_##name##_2)),			\
+			"BPF_SDT_PROBE4: arg2 type mismatch");		\
+	_Static_assert(sizeof(typeof(c)) <= 8,				\
+			"BPF_SDT_PROBE4: arg2 too large, use pointer");	\
+	_Static_assert(__builtin_types_compatible_p(typeof(d),		\
+			typeof(__sdt_chk_##name##_3)),			\
+			"BPF_SDT_PROBE4: arg3 type mismatch");		\
+	_Static_assert(sizeof(typeof(d)) <= 8,				\
+			"BPF_SDT_PROBE4: arg3 too large, use pointer");	\
+	typeof(a) __a0 = (a);						\
+	typeof(b) __a1 = (b);						\
+	typeof(c) __a2 = (c);						\
+	typeof(d) __a3 = (d);						\
+	asm volatile(							\
+		"0:\n"							\
+		"goto +0\n"						\
+		".pushsection .bpf_sdt_notes,\"\",@progbits\n"		\
+		"___sdt_jt_" #name ":\n"				\
+		".quad 0b\n"						\
+		"r1 = %0\n"						\
+		"r2 = %1\n"						\
+		"r3 = %2\n"						\
+		"r4 = %3\n"						\
+		".popsection\n"						\
+		:: "r"(__a0), "r"(__a1), "r"(__a2), "r"(__a3)		\
+	);								\
+})
+
+#define BPF_SDT_PROBE5(name, a, b, c, d, e)				\
+({									\
+	_Static_assert(__builtin_types_compatible_p(typeof(a),		\
+			typeof(__sdt_chk_##name##_0)),			\
+			"BPF_SDT_PROBE5: arg0 type mismatch");		\
+	_Static_assert(sizeof(typeof(a)) <= 8,				\
+			"BPF_SDT_PROBE5: arg0 too large, use pointer");	\
+	_Static_assert(__builtin_types_compatible_p(typeof(b),		\
+			typeof(__sdt_chk_##name##_1)),			\
+			"BPF_SDT_PROBE5: arg1 type mismatch");		\
+	_Static_assert(sizeof(typeof(b)) <= 8,				\
+			"BPF_SDT_PROBE5: arg1 too large, use pointer");	\
+	_Static_assert(__builtin_types_compatible_p(typeof(c),		\
+			typeof(__sdt_chk_##name##_2)),			\
+			"BPF_SDT_PROBE5: arg2 type mismatch");		\
+	_Static_assert(sizeof(typeof(c)) <= 8,				\
+			"BPF_SDT_PROBE5: arg2 too large, use pointer");	\
+	_Static_assert(__builtin_types_compatible_p(typeof(d),		\
+			typeof(__sdt_chk_##name##_3)),			\
+			"BPF_SDT_PROBE5: arg3 type mismatch");		\
+	_Static_assert(sizeof(typeof(d)) <= 8,				\
+			"BPF_SDT_PROBE5: arg3 too large, use pointer");	\
+	_Static_assert(__builtin_types_compatible_p(typeof(e),		\
+			typeof(__sdt_chk_##name##_4)),			\
+			"BPF_SDT_PROBE5: arg4 type mismatch");		\
+	_Static_assert(sizeof(typeof(e)) <= 8,				\
+			"BPF_SDT_PROBE5: arg4 too large, use pointer");	\
+	typeof(a) __a0 = (a);						\
+	typeof(b) __a1 = (b);						\
+	typeof(c) __a2 = (c);						\
+	typeof(d) __a3 = (d);						\
+	typeof(e) __a4 = (e);						\
+	asm volatile(							\
+		"0:\n"							\
+		"goto +0\n"						\
+		".pushsection .bpf_sdt_notes,\"\",@progbits\n"		\
+		"___sdt_jt_" #name ":\n"				\
+		".quad 0b\n"						\
+		"r1 = %0\n"						\
+		"r2 = %1\n"						\
+		"r3 = %2\n"						\
+		"r4 = %3\n"						\
+		"r5 = %4\n"						\
+		".popsection\n"						\
+		:: "r"(__a0), "r"(__a1), "r"(__a2), "r"(__a3), "r"(__a4)\
+	);								\
+})
+
+#endif /* __BPF_SDT_PROBE_H */
-- 
2.47.3

