Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794501994;
	b=HcrgzjBPEqrdzx4yLRgl9QJWYEPdBjGUtfUyzl9/Lw8g4YoIu9T+Tfi2CtNBhuWc/1AK
	 vNj+YmGVrGwDk8Bzd0cRV7Xoj8mC1zISmNNMlJC+0l4jWXv2BLJWHloSLSPcdQZ2aX1zu
	 cZCZZmLAPubsFnxNMdf7hgPg/gX9LX0C5EacEuag5hfSvkw8YnxWFB3DEvhBce2rNDtk6
	 PmNCyGCqvIHAfzqh7SFpqRISNGvR2cv/FmlEi01B1xXWQBhbj8Hx+MmkRnDEC5EJtmhn5
	 Ba0K9xSMNaCIz5fjmVR2uIm1f28bYn4nGDFj+Gb7hjrd/qyt13NLQA4u36I6AwqouPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794501994;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+PKwOflKRnP/2Jf1TZUoTXm6kDrnTGKFQ3SkACeWvc8=;
	b=YnbVBLdoLd1gjhNFR1uZBajLmjHsJcD+EFJSbPP074FA/dHN/GlVdNWNnGh54rRLX5CV
	 4LUYBnt7dSEaMFy+E7DLsDBeKfh4bIiQk911yOmjJJAmkMFHCdNA7e+m6t0xonVyYAUei
	 idDm3Gx5DYUAjEjGtgdifOT78cfnrJqok8FooSiGjyhxbf9KYTT5tYXKMN9lK+MMUFfUJ
	 77y+eUyjopi0O6wwfrRAw+MvtOZWtq2FY6z300FXzpdjmKnsOlWW1YJV0EUV8GPQSHhK2
	 0Smgzqzky/OE4yH3hdhOEhmSnA/RKUYUEts1MwcKJ4jOVK1t6A5ZPA2qlW0kMngxqOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M8UIPup3;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63F1606A330
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 16:46:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A63F1606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M8UIPup3
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3ae691283ecso8398a91.0
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 08:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794501993; x=1795106793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+PKwOflKRnP/2Jf1TZUoTXm6kDrnTGKFQ3SkACeWvc8=;
        b=M8UIPup3E8xUf7jUGm7fAa5W8isBzyhXf49s7EWdzFC4B8i7zlH3IgZTDg3OPL7KIu
         +LQKMORufsNdccphYPMW3DXUKpEO//tin7ZDBnCYE8QPZYnCbsZ7Qv9RGASR1vm9COIh
         HW9dqBtskPTmjBzXF81jTyLQ2HpoPeI3i64BL9dgsuHX2L0gOmt8Wtxcxs6Qum1QrlcG
         q7PanE+DcgsdqZw97kEHtqpYj4QjZ6w/vkvlykXkLpJamPaKTqNt2aEyUxqQvyvyTN3E
         N4FPbvE527VV7hLL3xJTuj11x0GXkBfwtdygeU5aJhbPj+u220yhbyCuKieyZWhpMz8t
         bFng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794501993; x=1795106793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+PKwOflKRnP/2Jf1TZUoTXm6kDrnTGKFQ3SkACeWvc8=;
        b=yNfRxZECStFArrU0Vl6UI89TWtYc+tG1yPYbBDoFCGQ8JvPo1OUOjTQY/qj7Mq2Wjk
         aT4sBi5B6F0lb3MvB99DkScUezCQQiKEPNkOWps2SoGqEg8/eIAJ9joq3/ixO+1WkuHS
         sgS1I7eevs/fYoBA0nmy3OZEMTvyF6ZFj7IXMQ+8M5Qi9eJ7q1FPqt3lc3pOOLDJpXMD
         z2OWAjnok25bWIKVSe0XWWwwrDwyGcAJkD3uopp5b2S4uG2+xWJ/wlx3UuQccvFGAUwL
         1YXDPsEzdSrU4j6gjAawiWJ94FmMhMdA509zyapUtO6woKQ7pf1ylyH19J2YYCJ3liGg
         37xA==
X-Gm-Message-State: APuU4Z8O22dijqiT56ncb4oXnU8ixe1gtLlGc/bjvtHOwt0ep1/nMFEN
	61iiWtyILaS+9LZ2H3iKorT8a0Cv+HxMOmzOndah5RNNY7zEB3WNTxkEZIS8Bw==
X-Gm-Gg: AYBFou2hXVHTzGeqVfPdQfp35Pstkq+h8iZkQuWfhD+OrX0BUqJcX/OS3V1PlWT0Uxn
	ydEzlEgSlY6wrJhvtlX0Yy1rvOnWkAH50jI04gP6uwxvBBYT7diocXCJ/3Y9bt+nV0IG6uKlEb1
	xeUgpEQrJhlWdsjvhhD8papNqfDyPKSDVYBx6OzSPHrmSaGuETc3eiFG8vUnMx7zNtYtAhLqDdT
	vhQGixNR2uerOd9rOkg2QT566wpQKIf4RG8Pp139ocggQHsaYIW1rSJ5OWQo0A4/Gyy1sqWiPHf
	UZ3beJK7TvOsU6VCKztFlV9dqGq1X/1ZXgHbzkALHQNvz18lBr/wch8ep9bHND/0gm7xu9BBFso
	Ie92WoEwlA9Sl3Xt8peNBj0Gx6o3sFJFzacXE5f6ohHPkr2k8uaBJ2NsVKAqhJVmty//S3hGrua
	F7WtR6njYi6JvTbxrKSyJd9/yd9yvlC+szdyCL/cxTdTmzwV4iFEbUkNCjq6OF/grttWhAH5sQv
	I/AZ8TToSYzYAdGZs5FeJDsYrdJjv1M6jFMqTBl1KAnOTaf6Rix5aHZEJZLdGLNuRL5ckt1AB+l
	SLVbnWzNO2hHtn13RKiaxVXL32xnfyEylEGQebaOxuI0DJ8V4LGIJcKX6QW2c5yfd5k7oActPaD
	85BEZ0HOjOo77pjQSnsDXjjc+V5YLd7RWkTGIZhwA4A2scFYgNAr9LQcR+ng+eESyBSyxi19ZFA
	==
X-Received: by 2002:a17:90b:4b84:b0:3ae:3b3d:c617 with SMTP id 98e67ed59e1d1-3b197cca4b8mr1998258a91.29.1794501992031;
        Thu, 12 Nov 2026 08:46:32 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197c6c9c5sm5388950a91.1.2026.11.12.08.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 08:46:31 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	a.s.protopopov@gmail.com
Subject: [PATCH bpf-next 03/10] resolve_btfids: Describe machine instructions with LLVM's MC layer
Date: Thu, 12 Nov 2026 16:46:03 +0000
Message-ID: <20261112164610.1917256-4-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

	mov    $0xffffffea,%eax
	...                             does -22 reach the ret?
	ret

The answer needs three facts about each instruction in between: its
length, where it branches, each register that it writes. Implicit writes
count too: mul, cmpxchg, ldp, a post-index load. After one missed write
the tool says that a function returns an error that it never returns.

A decoder written by hand is 300 - 800 lines per arch, for ever. LLVM's MC
(machine code) layer knows the three facts for each arch:

	bytes
	  |  MCDisassembler       length, MCInst
	  |  MCInstrAnalysis      branch, call, target
	  |  MCInstrDesc          explicit and implicit defs
	  |  MCRegAliasIterator   eax is a part of rax
	  |  table of the arch    what an opcode computes
	  v
	struct text_insn          kind, dst, src, imm, defs: no arch in it

LLVM's C API returns only text. So text_mc.cpp is one C++ file with a C
interface, like tools/perf/util/llvm-c-helpers.cpp.

MC does not say what an instruction computes. The table of an arch does,
by the names of opcodes and registers. The headers with the enums of a
target are not installed.

	                     x86-64  arm64
	patterns               13      11    opcode -> mov of an immediate,
	                                     mov, sign extension, select
	return                  1       1    RET64, RET
	test instructions      55      55    bytes -> expected text_insn

Where the table says nothing, the tool drops an error. It adds none:
 - An opcode without a pattern makes an unknown value.
 - An opcode with hasUnmodeledSideEffects() writes all registers: its
   defs are not complete, hvc and vmcall have none. The table says of 17
   frequent opcodes that their defs are complete: lock, mrs, ldxr ..
 - isReturn() holds for iret and eret too. Only the opcode that the table
   names is a return to the caller.

LLVM's API, opcode names and defs change between releases. text_arch_init()
looks up all names and decodes all test instructions at each start of
the tool. The build stops if one of them differs.

llvm-mc.sh is the one place that runs llvm-config. A later patch lets
Kconfig take its exit code: is there a C++ compiler, LLVM 17 or later,
its headers, the target? The script compiles nothing: 3 ms. The Makefile
takes flags and libraries from it, only if kbuild passes --fmodret_scan.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/bpf/resolve_btfids/Build           |   5 +
 tools/bpf/resolve_btfids/Makefile        |  23 +-
 tools/bpf/resolve_btfids/llvm-mc.sh      |  59 ++++
 tools/bpf/resolve_btfids/text_insn.h     |  71 ++++
 tools/bpf/resolve_btfids/text_mc.cpp     | 406 +++++++++++++++++++++++
 tools/bpf/resolve_btfids/text_mc.h       | 105 ++++++
 tools/bpf/resolve_btfids/text_mc_arm64.c | 117 +++++++
 tools/bpf/resolve_btfids/text_mc_x86.c   | 117 +++++++
 8 files changed, 902 insertions(+), 1 deletion(-)
 create mode 100755 tools/bpf/resolve_btfids/llvm-mc.sh
 create mode 100644 tools/bpf/resolve_btfids/text_insn.h
 create mode 100644 tools/bpf/resolve_btfids/text_mc.cpp
 create mode 100644 tools/bpf/resolve_btfids/text_mc.h
 create mode 100644 tools/bpf/resolve_btfids/text_mc_arm64.c
 create mode 100644 tools/bpf/resolve_btfids/text_mc_x86.c

diff --git a/tools/bpf/resolve_btfids/Build b/tools/bpf/resolve_btfids/Build
index 65af9dee7659..b9e5bf21439f 100644
--- a/tools/bpf/resolve_btfids/Build
+++ b/tools/bpf/resolve_btfids/Build
@@ -3,12 +3,17 @@ hostprogs := resolve_btfids
 resolve_btfids-y += main.o
 resolve_btfids-y += btf_colors.o
 resolve_btfids-y += image.o
+resolve_btfids-$(LLVM_MC) += text_mc.o
+resolve_btfids-$(LLVM_MC) += text_mc_$(SRCARCH).o
 resolve_btfids-y += rbtree.o
 resolve_btfids-y += zalloc.o
 resolve_btfids-y += string.o
 resolve_btfids-y += ctype.o
 resolve_btfids-y += str_error_r.o
 
+# LLVM's C++ API may have moved on, see Makefile
+$(OUTPUT)text_mc.o: cmd_cxx_o_c += $(or_llvm_mc_help)
+
 $(OUTPUT)%.o: ../../lib/%.c FORCE
 	$(call rule_mkdir)
 	$(call if_changed_dep,host_cc_o_c)
diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
index 6f5206ca00d4..d0fda987d55d 100644
--- a/tools/bpf/resolve_btfids/Makefile
+++ b/tools/bpf/resolve_btfids/Makefile
@@ -79,7 +79,28 @@ HOSTCFLAGS_resolve_btfids += -g \
 
 LIBS = $(LIBELF_LIBS) $(ZLIB_LIBS)
 
+# text_mc.cpp reads machine code with LLVM's MC layer. Only --fmodret_scan needs
+# it: don't touch LLVM unless kbuild is going to run the tool with that flag.
+ifneq ($(filter --fmodret_scan,$(RESOLVE_BTFIDS_FLAGS)),)
+LLVM_MC := y
+HOSTCXX ?= g++
+LLVM_MC_SH := LLVM_CONFIG="$(LLVM_CONFIG)" HOSTCXX="$(HOSTCXX)" \
+	      $(srctree)/tools/bpf/resolve_btfids/llvm-mc.sh $(SRCARCH)
+# Kconfig knows from llvm-mc.sh that LLVM is installed. Whether text_mc.cpp can
+# be built with it shows here.
+LLVM_MC_HELP := CONFIG_BPF_FMODRET_SCAN=y needs a C++17 compiler (HOSTCXX=$(HOSTCXX)) and the \
+		headers and libraries of LLVM 17 or later (LLVM_CONFIG=$(LLVM_CONFIG), packages \
+		llvm-dev, llvm-devel). See above what is wrong, or switch the option off
+or_llvm_mc_help := || { echo '$(LLVM_MC_HELP)' >&2; false; }
+HOSTCFLAGS_resolve_btfids += -DHAVE_LLVM_MC
+CXX := $(HOSTCXX)
+CXXFLAGS := $(filter-out -Werror,$(HOSTCFLAGS_resolve_btfids)) -O2 \
+	    $(or $(shell $(LLVM_MC_SH) cxxflags),$(error $(LLVM_MC_HELP)))
+LIBS += $(or $(shell $(LLVM_MC_SH) libs),$(error $(LLVM_MC_HELP)))
+endif
+
 export srctree OUTPUT HOSTCFLAGS_resolve_btfids Q HOSTCC HOSTLD HOSTAR
+export CXX CXXFLAGS SRCARCH LLVM_MC or_llvm_mc_help
 include $(srctree)/tools/build/Makefile.include
 
 $(BINARY_IN): fixdep FORCE prepare | $(OUTPUT)
@@ -87,7 +108,7 @@ $(BINARY_IN): fixdep FORCE prepare | $(OUTPUT)
 
 $(BINARY): $(BPFOBJ) $(SUBCMDOBJ) $(BINARY_IN)
 	$(call msg,LINK,$@)
-	$(Q)$(HOSTCC) $(BINARY_IN) $(KBUILD_HOSTLDFLAGS) $(EXTRA_LDFLAGS) -o $@ $(BPFOBJ) $(SUBCMDOBJ) $(LIBS)
+	$(Q)$(HOSTCC) $(BINARY_IN) $(KBUILD_HOSTLDFLAGS) $(EXTRA_LDFLAGS) -o $@ $(BPFOBJ) $(SUBCMDOBJ) $(LIBS) $(or_llvm_mc_help)
 
 clean_objects := $(wildcard $(OUTPUT)/*.o                \
                             $(OUTPUT)/.*.o.cmd           \
diff --git a/tools/bpf/resolve_btfids/llvm-mc.sh b/tools/bpf/resolve_btfids/llvm-mc.sh
new file mode 100755
index 000000000000..bc62c4e43406
--- /dev/null
+++ b/tools/bpf/resolve_btfids/llvm-mc.sh
@@ -0,0 +1,59 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# usage: llvm-mc.sh SRCARCH [cxxflags | libs]
+#
+# text_mc.cpp reads the machine code of the kernel arch SRCARCH with LLVM's MC
+# layer. Fail, and say why, if this host lacks what it takes to build it.
+# CONFIG_BPF_FMODRET_SCAN depends on that. Each Kconfig run pays for it, so it is
+# one run of llvm-config. Whether text_mc.cpp works with this LLVM shows when the
+# tool is built, and in text_arch_init() when it starts.
+#
+# For the Makefile print the flags to compile text_mc.cpp, or the libraries.
+#
+# The host's LLVM need not be the one which compiles the kernel, if any does.
+
+die()
+{
+	echo "$0: $*" >&2
+	exit 1
+}
+
+case "$1" in
+x86)	target=X86 ;;
+arm64)	target=AArch64 ;;
+*)	die "no text_mc_$1.c" ;;
+esac
+print=$2
+
+if [ -z "$LLVM_CONFIG" ]; then
+	case "$LLVM" in
+	*/)	LLVM_CONFIG=${LLVM}llvm-config ;;
+	-*)	LLVM_CONFIG=llvm-config$LLVM ;;
+	*)	LLVM_CONFIG=llvm-config ;;
+	esac
+fi
+
+command -v ${HOSTCXX:-g++} > /dev/null || die "no C++ compiler ${HOSTCXX:-g++}"
+set -- $($LLVM_CONFIG --version --includedir --targets-built 2> /dev/null)
+[ $# -gt 2 ] || die "cannot run $LLVM_CONFIG"
+[ "${1%%.*}" -ge 17 ] || die "$LLVM_CONFIG is LLVM $1, not 17 or later"
+[ -e "$2/llvm/MC/MCInstrDesc.h" ] || die "$2 lacks the headers of LLVM $1"
+case " $* " in
+*" $target "*)	;;
+*)	die "$LLVM_CONFIG, LLVM $1, lacks the target $target" ;;
+esac
+
+case "$print" in
+cxxflags)
+	echo "$($LLVM_CONFIG --cxxflags) -DMC_TARGET=$target"
+	;;
+libs)
+	# A static link starts faster, which counts for each module, and does not tie the
+	# tool, which is shipped for the build of external modules, to a shared library
+	set -- --ldflags --libs --system-libs ${target}Desc ${target}Disassembler ${target}Info
+	libs=$($LLVM_CONFIG --link-static "$@" 2> /dev/null) ||
+	libs=$($LLVM_CONFIG --link-shared "$@") || die "no libraries of LLVM"
+	echo $libs -lstdc++ -lm
+	;;
+esac
diff --git a/tools/bpf/resolve_btfids/text_insn.h b/tools/bpf/resolve_btfids/text_insn.h
new file mode 100644
index 000000000000..210d749439e7
--- /dev/null
+++ b/tools/bpf/resolve_btfids/text_insn.h
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __TEXT_INSN_H
+#define __TEXT_INSN_H
+
+#include <linux/types.h>
+
+/*
+ * What one machine instruction does to the integer registers and to the
+ * control flow, in terms which do not depend on the arch. It is what a data
+ * flow analysis of copies needs, see text_flow.h.
+ *
+ * A decoder looks at one instruction and keeps no state. It has to get right
+ * the length, the kind and the registers which are written. An instruction
+ * which it does not know is TEXT_OTHER and writes TEXT_ALL_REGS. It may leave
+ * out a value which dst can get, and never names one which dst cannot get:
+ * "dst = src or a value which is computed" is a TEXT_SELECT of src and src.
+ */
+enum text_insn_kind {
+	TEXT_OTHER,
+	TEXT_MOV_IMM,		/* dst = imm or imm2 */
+	TEXT_MOV,		/* dst = src */
+	TEXT_SEXT32,		/* dst = (s32)src */
+	TEXT_SELECT,		/* dst = src or src2 */
+	TEXT_SELECT_IMM,	/* dst = src or imm */
+	TEXT_BRANCH,		/* to imm, 0 if it is computed */
+	TEXT_COND_BRANCH,	/* to imm or to the next instruction */
+	TEXT_CALL,		/* of imm, 0 if it is computed */
+	TEXT_RETURN,
+};
+
+/* The arch numbers its registers */
+#define TEXT_MAX_REGS	32
+#define TEXT_ALL_REGS	(~0U)
+#define TEXT_NO_INSN	(~0U)
+
+struct text_insn {
+	u8 kind;
+	u8 len;
+	u8 dst, src, src2;
+	bool is32;	/* It works on the low 32 bits and zero extends the result */
+	/* The registers which it writes, but for dst */
+	u32 defs;
+	u64 imm, imm2;
+	/* For the user of the decoder */
+	u64 addr;
+	u32 target;	/* the index of the instruction at imm */
+};
+
+struct text_arch {
+	u8 retval;		/* the register with the return value */
+	u32 caller_saved;	/* the registers which a call may write */
+	/* A branch to this symbol is a return */
+	const char *return_thunk;
+	/*
+	 * Describe the instruction at ADDR, whose bytes are at CODE. At most LEN
+	 * bytes can be read. Return a negative value if it is not an instruction.
+	 */
+	int (*decode)(const void *code, unsigned int len, u64 addr, struct text_insn *insn);
+};
+
+#ifdef HAVE_LLVM_MC
+/* Return the arch of the ELF machine MACHINE, or NULL, after a message, if it cannot be decoded */
+const struct text_arch *text_arch_init(unsigned int machine);
+#else
+static inline const struct text_arch *text_arch_init(unsigned int machine)
+{
+	return NULL;
+}
+#endif
+
+#endif
diff --git a/tools/bpf/resolve_btfids/text_mc.cpp b/tools/bpf/resolve_btfids/text_mc.cpp
new file mode 100644
index 000000000000..e7166ad4b871
--- /dev/null
+++ b/tools/bpf/resolve_btfids/text_mc.cpp
@@ -0,0 +1,406 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * The instructions of any arch in the terms of text_insn.h, on top of LLVM's MC
+ * layer. Nothing in this file depends on the arch: see text_mc.h for the rest.
+ *
+ *	length, MCInst			MCDisassembler::getInstruction()
+ *	branch, call			MCInstrAnalysis, which asks MCInstrDesc
+ *	target				MCInstrAnalysis::evaluateBranch()
+ *	registers written		MCInstrDesc: defs, implicit defs
+ *	eax and rax, w0 and x0		MCRegAliasIterator
+ *
+ * Whatever MC does not describe completely writes TEXT_ALL_REGS.
+ */
+
+#include <llvm/Config/llvm-config.h>
+#include <llvm/MC/MCAsmInfo.h>
+#include <llvm/MC/MCContext.h>
+#include <llvm/MC/MCDisassembler/MCDisassembler.h>
+#include <llvm/MC/MCInst.h>
+#include <llvm/MC/MCInstrAnalysis.h>
+#include <llvm/MC/MCInstrDesc.h>
+#include <llvm/MC/MCInstrInfo.h>
+#include <llvm/MC/MCRegisterInfo.h>
+#include <llvm/MC/MCSubtargetInfo.h>
+#include <llvm/MC/MCTargetOptions.h>
+#include <llvm/MC/TargetRegistry.h>
+#include <llvm/Support/Format.h>
+#include <llvm/Support/TargetSelect.h>
+#include <llvm/Support/raw_ostream.h>
+
+#include <memory>
+#include <sstream>
+#include <string>
+#include <string_view>
+#include <unordered_map>
+#include <vector>
+
+extern "C" {
+#include "text_mc.h"
+}
+
+#if LLVM_VERSION_MAJOR < 17
+#error "LLVM 17, the oldest one which can build the kernel, or later"
+#endif
+
+using namespace llvm;
+
+namespace {
+
+enum { NO_REG = 0xff, ZERO_REG = 0xfe };
+
+/* An LLVM register in the terms of text_insn.h */
+struct Reg {
+	u32 mask = 0;		/* the registers which it overlaps */
+	u8 nr = NO_REG;		/* the register if it overlaps one, or ZERO_REG */
+	u8 bits = 0;		/* 64: all of it, 32: the low half, a write zero extends, 0: some part */
+};
+
+/* What is known about an opcode before its operands are */
+struct Opcode {
+	u32 implicit_defs = 0;
+	unsigned int implicit_def = 0, implicit_use = 0;	/* the first ones, LLVM registers */
+	bool unmodeled = false, is_return = false;
+	std::vector<const mc_pattern *> patterns;
+};
+
+struct Decoder {
+	std::unique_ptr<MCRegisterInfo> MRI;
+	std::unique_ptr<MCAsmInfo> MAI;
+	std::unique_ptr<MCInstrInfo> MII;
+	std::unique_ptr<MCSubtargetInfo> STI;
+	std::unique_ptr<MCContext> Ctx;
+	std::unique_ptr<MCDisassembler> Dis;
+	std::unique_ptr<MCInstrAnalysis> MIA;
+	std::vector<Reg> regs;
+	std::vector<Opcode> opcodes;
+	MCInst inst;
+};
+
+Decoder d;
+
+/* MC_TARGET is LLVM's name of the arch, see llvm-mc.sh */
+#define INITIALIZE_(target, what)	LLVMInitialize##target##what()
+#define INITIALIZE(target, what)	INITIALIZE_(target, what)
+
+raw_ostream &error()
+{
+	return errs() << "text_mc: LLVM " LLVM_VERSION_STRING ": ";
+}
+
+bool create()
+{
+	MCTargetOptions options;
+	std::string message;
+#if LLVM_VERSION_MAJOR >= 22
+	Triple triple(mc_arch.triple);
+#else
+	const char *triple = mc_arch.triple;
+#endif
+	const Target *target;
+
+	INITIALIZE(MC_TARGET, TargetInfo);
+	INITIALIZE(MC_TARGET, TargetMC);
+	INITIALIZE(MC_TARGET, Disassembler);
+	target = TargetRegistry::lookupTarget(triple, message);
+	if (!target) {
+		error() << message << "\n";
+		return false;
+	}
+	d.MRI.reset(target->createMCRegInfo(triple));
+	d.MAI.reset(target->createMCAsmInfo(*d.MRI, triple, options));
+	d.MII.reset(target->createMCInstrInfo());
+	d.STI.reset(target->createMCSubtargetInfo(triple, "", mc_arch.features));
+#if LLVM_VERSION_MAJOR >= 23
+	d.Ctx.reset(new MCContext(triple, *d.MAI, *d.MRI, *d.STI));
+#else
+	d.Ctx.reset(new MCContext(Triple(mc_arch.triple), d.MAI.get(), d.MRI.get(), d.STI.get()));
+#endif
+	d.Dis.reset(target->createMCDisassembler(*d.STI, *d.Ctx));
+	d.MIA.reset(target->createMCInstrAnalysis(d.MII.get()));
+	return d.Dis && d.MIA;
+}
+
+/* Call FN(LLVM register, index) for each of the NAMES */
+template <typename Fn> bool for_each_reg(const char *names, Fn fn)
+{
+	std::istringstream in(names ?: "");
+	std::string name;
+	bool ok = true;
+
+	for (unsigned int i = 0, r; in >> name; i++) {
+		for (r = 1; r < d.MRI->getNumRegs() && name != d.MRI->getName(r); r++)
+			;
+		if (r < d.MRI->getNumRegs()) {
+			fn(r, i);
+			continue;
+		}
+		error() << "no register " << name << "\n";
+		ok = false;
+	}
+	return ok;
+}
+
+bool read_regs()
+{
+	bool ok;
+
+	d.regs.resize(d.MRI->getNumRegs());
+	ok = for_each_reg(mc_arch.regs, [&](unsigned int r, unsigned int nr) {
+		for (MCRegAliasIterator alias(r, d.MRI.get(), true); alias.isValid(); ++alias) {
+			Reg &reg = d.regs[*alias];
+
+			/* The iterator may come to a register more than once */
+			reg.mask |= 1U << nr;
+			reg.nr = reg.mask == 1U << nr ? nr : NO_REG;
+			reg.bits = *alias == r ? 64 : 0;
+		}
+	});
+	ok &= for_each_reg(mc_arch.regs32, [&](unsigned int r, unsigned int) { d.regs[r].bits = 32; });
+	ok &= for_each_reg(mc_arch.zero_regs, [&](unsigned int r, unsigned int) { d.regs[r].nr = ZERO_REG; });
+	return ok;
+}
+
+bool read_opcodes()
+{
+	std::unordered_map<std::string_view, Opcode *> by_name;
+	bool ok = true;
+
+	d.opcodes.resize(d.MII->getNumOpcodes());
+	by_name.reserve(d.opcodes.size());
+	for (unsigned int op = 0; op < d.opcodes.size(); op++) {
+		const MCInstrDesc &desc = d.MII->get(op);
+		Opcode &o = d.opcodes[op];
+
+		by_name[d.MII->getName(op)] = &o;
+		for (MCPhysReg r : desc.implicit_defs()) {
+			o.implicit_defs |= d.regs[r].mask;
+			if (!o.implicit_def && d.regs[r].mask)
+				o.implicit_def = r;
+		}
+		for (MCPhysReg r : desc.implicit_uses())
+			if (!o.implicit_use && d.regs[r].mask)
+				o.implicit_use = r;
+		/* defs_of() does not look for the last two */
+		o.unmodeled = desc.hasUnmodeledSideEffects() || desc.hasOptionalDef() ||
+			      desc.variadicOpsAreDefs();
+	}
+	for (const mc_pattern *pattern = mc_arch.patterns; pattern->opcode; pattern++) {
+		auto it = by_name.find(pattern->opcode);
+
+		if (it == by_name.end()) {
+			error() << "no opcode " << pattern->opcode << "\n";
+			ok = false;
+		} else if (pattern->kind == TEXT_RETURN) {
+			it->second->is_return = true;
+		} else if (pattern->kind != TEXT_OTHER) {
+			it->second->patterns.push_back(pattern);
+		} else {
+			it->second->unmodeled = false;
+			it->second->implicit_defs |= pattern->defs;
+		}
+	}
+	return ok;
+}
+
+const Reg &reg_of(const MCInst &inst, const Opcode &o, u8 nr, bool def)
+{
+	static const Reg none;
+
+	if (nr == MC_IMPLICIT)
+		return d.regs[def ? o.implicit_def : o.implicit_use];
+	if (nr >= inst.getNumOperands() || !inst.getOperand(nr).isReg())
+		return none;
+	return d.regs[inst.getOperand(nr).getReg()];
+}
+
+bool holds(const MCInst &inst, const mc_predicate &p)
+{
+	const MCOperand *a, *b;
+
+	if (p.kind == MC_TRUE)
+		return true;
+	if (p.a >= inst.getNumOperands())
+		return false;
+	a = &inst.getOperand(p.a);
+	switch (p.kind) {
+	case MC_ZERO_REG:
+		return a->isReg() && d.regs[a->getReg()].nr == ZERO_REG;
+	case MC_SAME_REG:
+		if ((unsigned int)p.b >= inst.getNumOperands())
+			return false;
+		b = &inst.getOperand(p.b);
+		return a->isReg() && b->isReg() && a->getReg() == b->getReg();
+	case MC_IMM:
+		return a->isImm() && a->getImm() == p.b;
+	}
+	return false;
+}
+
+/* Describe INST as PATTERN says. Return false, and leave TI alone, if it does not match */
+bool match(const MCInst &inst, const Opcode &o, const mc_pattern &pattern, text_insn *ti)
+{
+	const Reg &dst = reg_of(inst, o, pattern.dst, true);
+	u8 kind = pattern.kind, src = 0, src2 = 0;
+	bool is32 = dst.bits == 32;
+	u64 imm = pattern.value;
+
+	if (!holds(inst, pattern.predicates[0]) || !holds(inst, pattern.predicates[1]))
+		return false;
+	if (dst.nr >= TEXT_MAX_REGS || !dst.bits)
+		return false;
+	if (kind != TEXT_MOV && kind != TEXT_SEXT32 && kind != TEXT_SELECT) {
+		if (!pattern.fixed) {
+			if (pattern.imm >= inst.getNumOperands() || !inst.getOperand(pattern.imm).isImm())
+				return false;
+			imm = inst.getOperand(pattern.imm).getImm();
+		}
+		if (pattern.shift >= inst.getNumOperands())
+			return false;
+		if (pattern.shift)
+			imm <<= inst.getOperand(pattern.shift).getImm();
+		if (pattern.invert)
+			imm = ~imm;
+		if (is32)
+			imm = (u32)imm;
+	}
+	if (kind != TEXT_MOV_IMM) {
+		src = src2 = reg_of(inst, o, pattern.src, false).nr;
+		if (kind == TEXT_SELECT)
+			src2 = reg_of(inst, o, pattern.src2, false).nr;
+		/* The zero register is a constant which is not an error: only the other source counts */
+		if (src == ZERO_REG)
+			src = src2;
+		if (src2 == ZERO_REG)
+			src2 = src;
+		if (src >= TEXT_MAX_REGS || src2 >= TEXT_MAX_REGS)
+			return false;
+	}
+	ti->kind = kind;
+	ti->is32 = is32;
+	ti->dst = dst.nr;
+	ti->src = src;
+	ti->src2 = src2;
+	ti->imm = imm;
+	ti->imm2 = pattern.or_zero ? 0 : imm;
+	return true;
+}
+
+void control_flow(const MCInst &inst, const Opcode &o, u64 addr, text_insn *ti)
+{
+	const MCInstrDesc &desc = d.MII->get(inst.getOpcode());
+	const MCInstrAnalysis &MIA = *d.MIA;
+	u64 target;
+
+	if (o.is_return)
+		ti->kind = TEXT_RETURN;
+	else if (MIA.isCall(inst))
+		ti->kind = TEXT_CALL;
+	else if (MIA.isUnconditionalBranch(inst) || (MIA.isIndirectBranch(inst) && desc.isBarrier()))
+		ti->kind = TEXT_BRANCH;
+	else if (MIA.isBranch(inst))
+		ti->kind = TEXT_COND_BRANCH;
+	if (ti->kind >= TEXT_BRANCH && MIA.evaluateBranch(inst, addr, ti->len, target))
+		ti->imm = target;
+	if (ti->kind == TEXT_BRANCH || ti->kind == TEXT_RETURN)
+		ti->defs = 0;
+}
+
+/* Return the registers which INST writes */
+u32 defs_of(const MCInst &inst, const Opcode &o)
+{
+	const MCInstrDesc &desc = d.MII->get(inst.getOpcode());
+	u32 defs = o.implicit_defs;
+
+	if (o.unmodeled)
+		return TEXT_ALL_REGS;
+	/* The operands are not those of the description: which ones are the defs? */
+	if (desc.getNumDefs() && inst.getNumOperands() < desc.getNumOperands())
+		return TEXT_ALL_REGS;
+	for (unsigned int i = 0; i < desc.getNumDefs(); i++) {
+		if (!inst.getOperand(i).isReg())
+			return TEXT_ALL_REGS;
+		defs |= d.regs[inst.getOperand(i).getReg()].mask;
+	}
+	return defs;
+}
+
+int decode(const void *code, unsigned int len, u64 addr, text_insn *ti)
+{
+	MCInst &inst = d.inst;
+	uint64_t size = 0;
+
+	inst = MCInst();
+	*ti = text_insn{};
+	/* After SoftFail the MCInst is valid: LLVM has it for "ldtr w8, [x8]" */
+	if (d.Dis->getInstruction(inst, size, ArrayRef<uint8_t>((const uint8_t *)code, len), addr,
+				  nulls()) == MCDisassembler::Fail)
+		return -1;
+	ti->len = size;
+
+	const Opcode &o = d.opcodes[inst.getOpcode()];
+
+	ti->defs = defs_of(inst, o);
+	for (const mc_pattern *pattern : o.patterns) {
+		if (match(inst, o, *pattern, ti)) {
+			ti->defs &= ~(1U << ti->dst);
+			return 0;
+		}
+	}
+	control_flow(inst, o, addr, ti);
+	return 0;
+}
+
+void print(raw_ostream &os, const text_insn &ti)
+{
+	os << "kind " << (int)ti.kind << " is32 " << ti.is32 << " dst " << (int)ti.dst
+	   << " src " << (int)ti.src << " src2 " << (int)ti.src2
+	   << " defs " << format_hex(ti.defs, 1) << " imm " << format_hex(ti.imm, 1)
+	   << " imm2 " << format_hex(ti.imm2, 1);
+}
+
+bool run_tests()
+{
+	bool ok = true;
+
+	for (const mc_test *test = mc_arch.tests; test->code; test++) {
+		const text_insn &want = test->insn;
+		std::istringstream in(test->code);
+		std::vector<uint8_t> code;
+		unsigned int byte;
+		text_insn ti;
+
+		while (in >> std::hex >> byte)
+			code.push_back(byte);
+		if (!decode(code.data(), code.size(), MC_TEST_ADDR, &ti) && ti.len == code.size() &&
+		    ti.kind == want.kind && ti.is32 == want.is32 && ti.dst == want.dst &&
+		    ti.src == want.src && ti.src2 == want.src2 &&
+		    ti.defs == want.defs && ti.imm == want.imm && ti.imm2 == want.imm2)
+			continue;
+		print(error() << test->code << " is " << d.MII->getName(d.inst.getOpcode()) << ", length "
+			      << (int)ti.len << ", ", ti);
+		print(errs() << "\n\texpected: ", want);
+		errs() << "\n";
+		ok = false;
+	}
+	return ok;
+}
+
+} /* namespace */
+
+extern "C" const struct text_arch *text_arch_init(unsigned int machine)
+{
+	static text_arch arch = mc_arch.arch;
+
+	if (machine != mc_arch.machine) {
+		errs() << "text_mc: built for " << mc_arch.triple << ", not for ELF machine " << machine << "\n";
+		return nullptr;
+	}
+	if (!create() || !read_regs() || !read_opcodes() || !run_tests()) {
+		error() << "the table of the arch does not fit it. Set LLVM_CONFIG to the "
+			   "llvm-config of another LLVM, or switch CONFIG_BPF_FMODRET_SCAN off\n";
+		return nullptr;
+	}
+	arch.decode = decode;
+	return &arch;
+}
diff --git a/tools/bpf/resolve_btfids/text_mc.h b/tools/bpf/resolve_btfids/text_mc.h
new file mode 100644
index 000000000000..9d39095aab20
--- /dev/null
+++ b/tools/bpf/resolve_btfids/text_mc.h
@@ -0,0 +1,105 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __TEXT_MC_H
+#define __TEXT_MC_H
+
+#include "text_insn.h"
+
+/*
+ * What text_mc.cpp has to be told about an arch to describe its instructions
+ * in the terms of text_insn.h with LLVM's MC layer.
+ *
+ * MC gives the length, the MCInst, the flags of MCInstrDesc, the explicit and
+ * the implicit defs, the aliases of a register and the target of a branch.
+ * It does not say what an instruction computes: the selection patterns are not
+ * a part of it. And the headers with the enums of a target are not installed.
+ * So opcodes and registers are given by name, as MCInstrInfo::getName() and
+ * MCRegisterInfo::getName() return them, and looked up once. A name which this
+ * LLVM does not have is an error.
+ */
+
+/* A condition on the operands of an MCInst, like an MCInstPredicate of TableGen */
+enum mc_predicate_kind {
+	MC_TRUE,
+	MC_ZERO_REG,	/* operand A is the zero register */
+	MC_SAME_REG,	/* operands A and B are the same register */
+	MC_IMM,		/* operand A is the immediate B */
+};
+
+struct mc_predicate {
+	u8 kind;
+	u8 a;
+	s32 b;
+};
+
+#define ZERO_REG(a)	{ MC_ZERO_REG, a, 0 }
+#define SAME_REG(a, b)	{ MC_SAME_REG, a, b }
+#define IMM(a, b)	{ MC_IMM, a, b }
+#define VALUE(v)	.fixed = true, .value = v
+
+/* Instead of the number of an operand: the first implicit def or use */
+#define MC_IMPLICIT	0xff
+
+/*
+ * What an opcode computes, if it makes or copies a value. The patterns of an
+ * opcode are tried in their order. The width of the operation is that of the
+ * register DST.
+ *
+ * A pattern of kind TEXT_OTHER is about the defs. hasUnmodeledSideEffects() is
+ * how LLVM says that MCInstrDesc does not tell all about an opcode: it writes
+ * TEXT_ALL_REGS, unless such a pattern says that it writes what MCInstrDesc
+ * has, and DEFS.
+ *
+ * A pattern of kind TEXT_RETURN names a return to the caller. isReturn() holds
+ * for a return from an exception as well, which does not hand the return value
+ * register to a caller. Without such a pattern it is an opcode like any other,
+ * and LLVM says hasUnmodeledSideEffects() of it.
+ *
+ * Without a pattern errors are lost, none is made up. So an opcode has one only
+ * if that brings more than a few errors in some kernel.
+ */
+struct mc_pattern {
+	const char *opcode;
+	u8 kind;		/* enum text_insn_kind */
+	u8 dst, src, src2;	/* the numbers of the operands. DST is 0 unless it is given */
+	u8 imm;			/* the operand with the immediate */
+	u8 shift;		/* the operand which says how far the immediate is shifted left */
+	bool invert;		/* the immediate */
+	bool or_zero;		/* TEXT_MOV_IMM: the immediate or 0 */
+	bool fixed;		/* the immediate is VALUE, not an operand */
+	s64 value;
+	u32 defs;		/* of TEXT_OTHER */
+	struct mc_predicate predicates[2];
+};
+
+/* An instruction, in hex, and what text_arch.decode() has to say about it at MC_TEST_ADDR */
+struct mc_test {
+	const char *code;
+	struct text_insn insn;
+};
+
+#define MC_TEST_ADDR	0x1000
+
+struct mc_arch {
+	struct text_arch arch;
+	unsigned int machine;	/* of the ELF header */
+	const char *triple, *features;
+	/*
+	 * The names of registers 0, 1, ... of text_insn.h, separated by spaces.
+	 * A write of a register in REGS32 zero extends. A write of any other
+	 * alias is not a copy.
+	 */
+	const char *regs, *regs32;
+	const char *zero_regs;
+	const struct mc_pattern *patterns;
+	/*
+	 * LLVM's tables and names change from release to release, and the ones
+	 * above were written for some of them. text_arch_init() fails if one of
+	 * these instructions is no longer described as it was.
+	 */
+	const struct mc_test *tests;
+};
+
+/* The arch which the tool is built for, see Build */
+extern const struct mc_arch mc_arch;
+
+#endif
diff --git a/tools/bpf/resolve_btfids/text_mc_arm64.c b/tools/bpf/resolve_btfids/text_mc_arm64.c
new file mode 100644
index 000000000000..31f3d932056b
--- /dev/null
+++ b/tools/bpf/resolve_btfids/text_mc_arm64.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* arm64 for text_mc.cpp */
+
+#include <elf.h>
+#include <linux/bits.h>
+
+#include "text_mc.h"
+
+/* The W and the X form of an opcode */
+#define WX(before, after, ...) \
+	{ before "W" after, __VA_ARGS__ }, { before "X" after, __VA_ARGS__ }
+
+static const struct mc_pattern arm64_patterns[] = {
+	WX("MOVN", "i",	 TEXT_MOV_IMM, .imm = 1, .shift = 2, .invert = true),
+	WX("ORR", "rs",	 TEXT_MOV, .src = 2, .predicates = { ZERO_REG(1), IMM(3, 0) }),		/* mov */
+	{ "SBFMXri",	 TEXT_SEXT32, .src = 1, .predicates = { IMM(2, 0), IMM(3, 31) } },	/* sxtw */
+	WX("CSEL", "r",	 TEXT_SELECT, .src = 1, .src2 = 2),
+	{ "CSINVWr",	 TEXT_MOV_IMM, VALUE(-1), .or_zero = true,
+			 .predicates = { ZERO_REG(1), ZERO_REG(2) } },				/* csetm */
+	{ "CSINVWr",	 TEXT_SELECT_IMM, .src = 1, VALUE(-1), .predicates = { ZERO_REG(2) } },
+	/* rn, or a function of rm */
+	{ "CSINCWr",	 TEXT_SELECT, .src = 1, .src2 = 1 },
+	/* and rd, rn, rm, asr #31: rn or 0 */
+	{ "ANDWrs",	 TEXT_SELECT, .src = 1, .src2 = 1, .predicates = { IMM(3, 2 << 6 | 31) } },
+	/* HINT: nop, bti, yield, wfe ... */
+	{ "HINT", TEXT_OTHER }, { "AUTIASP", TEXT_OTHER }, { "PRFMui", TEXT_OTHER },
+	{ "DMB", TEXT_OTHER }, { "BRK", TEXT_OTHER }, { "MRS", TEXT_OTHER }, { "MSR", TEXT_OTHER },
+	{ "STLRB", TEXT_OTHER }, { "STLRW", TEXT_OTHER },
+	WX("LDXR", "", TEXT_OTHER), WX("STXR", "", TEXT_OTHER), WX("STLXR", "", TEXT_OTHER),
+	{ "RET", TEXT_RETURN },
+	{}
+};
+
+#define T(code, insn_kind, ...)	{ code, { .kind = insn_kind, __VA_ARGS__ } }
+#define IMMS(a, b)		.imm = a, .imm2 = b
+#define SRC(reg)		.src = reg, .src2 = reg
+
+/* Each pattern, and what must not match it */
+static const struct mc_test arm64_tests[] = {
+	T("a0 02 80 12", TEXT_MOV_IMM, .is32 = true, IMMS(0xffffffea, 0xffffffea)),	/* mov w0, #-22 */
+	T("a0 02 80 92", TEXT_MOV_IMM, IMMS(-22, -22)),			/* mov x0, #-22 */
+	T("20 00 a0 12", TEXT_MOV_IMM, .is32 = true, IMMS(0xfffeffff, 0xfffeffff)),	/* mov w0, #-0x10001 */
+	T("e0 03 13 2a", TEXT_MOV, .is32 = true, SRC(19)),		/* mov w0, w19 */
+	T("e0 03 13 aa", TEXT_MOV, SRC(19)),				/* mov x0, x19 */
+	T("20 00 02 2a", TEXT_OTHER, .defs = BIT(0)),			/* orr w0, w1, w2 */
+	T("20 00 02 aa", TEXT_OTHER, .defs = BIT(0)),			/* orr x0, x1, x2 */
+	T("e0 07 13 2a", TEXT_OTHER, .defs = BIT(0)),			/* orr w0, wzr, w19, lsl #1 */
+	T("60 7e 40 93", TEXT_SEXT32, SRC(19)),				/* sxtw x0, w19 */
+	T("60 3e 40 93", TEXT_OTHER, .defs = BIT(0)),			/* sxth x0, w19 */
+	T("00 01 89 1a", TEXT_SELECT, .is32 = true, .src = 8, .src2 = 9),	/* csel w0, w8, w9, eq */
+	T("00 01 89 9a", TEXT_SELECT, .src = 8, .src2 = 9),		/* csel x0, x8, x9, eq */
+	T("00 01 9f 9a", TEXT_SELECT, SRC(8)),				/* csel x0, x8, xzr, eq */
+	T("e0 03 9f 5a", TEXT_MOV_IMM, .is32 = true, IMMS(0xffffffff, 0)),	/* csetm w0, ne */
+	T("00 01 9f 5a", TEXT_SELECT_IMM, .is32 = true, SRC(8), IMMS(0xffffffff, 0xffffffff)), /* csinv w0, w8, wzr, eq */
+	T("00 01 89 5a", TEXT_OTHER, .defs = BIT(0)),			/* csinv w0, w8, w9, eq */
+	T("00 05 89 1a", TEXT_SELECT, .is32 = true, SRC(8)),		/* csinc w0, w8, w9, eq */
+	T("00 7d 89 0a", TEXT_SELECT, .is32 = true, SRC(8)),		/* and w0, w8, w9, asr #31 */
+	T("00 01 09 0a", TEXT_OTHER, .defs = BIT(0)),			/* and w0, w8, w9 */
+	T("5f 24 03 d5", TEXT_OTHER),					/* bti c */
+	T("bf 23 03 d5", TEXT_OTHER, .defs = BIT(30)),			/* autiasp */
+	T("20 00 80 f9", TEXT_OTHER),					/* prfm pldl1keep, [x1] */
+	T("bf 3b 03 d5", TEXT_OTHER),					/* dmb ish */
+	T("00 00 21 d4", TEXT_OTHER),					/* brk #0x800 */
+	T("80 d0 38 d5", TEXT_OTHER, .defs = BIT(0)),			/* mrs x0, tpidr_el1 */
+	T("80 d0 18 d5", TEXT_OTHER),					/* msr tpidr_el1, x0 */
+	T("20 fc 9f 08", TEXT_OTHER),					/* stlrb w0, [x1] */
+	T("20 fc 9f 88", TEXT_OTHER),					/* stlr w0, [x1] */
+	T("20 7c 5f 88", TEXT_OTHER, .defs = BIT(0)),			/* ldxr w0, [x1] */
+	T("20 7c 5f c8", TEXT_OTHER, .defs = BIT(0)),			/* ldxr x0, [x1] */
+	T("41 7c 00 88", TEXT_OTHER, .defs = BIT(0)),			/* stxr w0, w1, [x2] */
+	T("41 7c 00 c8", TEXT_OTHER, .defs = BIT(0)),			/* stxr w0, x1, [x2] */
+	T("41 fc 00 88", TEXT_OTHER, .defs = BIT(0)),			/* stlxr w0, w1, [x2] */
+	T("41 fc 00 c8", TEXT_OTHER, .defs = BIT(0)),			/* stlxr w0, x1, [x2] */
+	/* hasUnmodeledSideEffects() */
+	T("02 00 00 d4", TEXT_OTHER, .defs = TEXT_ALL_REGS),		/* hvc #0 */
+	/* A write of these which is missed would change the errors of a function in some kernel */
+	T("20 00 a0 52", TEXT_OTHER, .defs = BIT(0)),			/* mov w0, #0x10000 */
+	T("20 78 1d 12", TEXT_OTHER, .defs = BIT(0)),			/* and w0, w1, #0xfffffffb */
+	T("00 01 09 8a", TEXT_OTHER, .defs = BIT(0)),			/* and x0, x8, x9 */
+	T("00 01 09 6a", TEXT_OTHER, .defs = BIT(0)),			/* ands w0, w8, w9 */
+	T("00 01 29 0a", TEXT_OTHER, .defs = BIT(0)),			/* bic w0, w8, w9 */
+	T("20 00 00 32", TEXT_OTHER, .defs = BIT(0)),			/* orr w0, w1, #1 */
+	T("20 04 00 11", TEXT_OTHER, .defs = BIT(0)),			/* add w0, w1, #1 */
+	T("20 08 01 53", TEXT_OTHER, .defs = BIT(0)),			/* ubfx w0, w1, #1, #2 */
+	T("20 00 40 f9", TEXT_OTHER, .defs = BIT(0)),			/* ldr x0, [x1] */
+	T("20 00 40 b9", TEXT_OTHER, .defs = BIT(0)),			/* ldr w0, [x1] */
+	T("20 c0 5f b8", TEXT_OTHER, .defs = BIT(0)),			/* ldur w0, [x1, #-4] */
+	T("20 c0 9f b8", TEXT_OTHER, .defs = BIT(0)),			/* ldursw x0, [x1, #-4] */
+	T("08 09 40 b8", TEXT_OTHER, .defs = BIT(8)),			/* ldtr w8, [x8] */
+	/* The control flow */
+	T("10 00 00 14", TEXT_BRANCH, .imm = MC_TEST_ADDR + 0x40),	/* b */
+	T("00 01 1f d6", TEXT_BRANCH),					/* br x8 */
+	T("00 02 00 b4", TEXT_COND_BRANCH, .imm = MC_TEST_ADDR + 0x40),	/* cbz x0 */
+	T("10 00 00 94", TEXT_CALL, .defs = BIT(30), .imm = MC_TEST_ADDR + 0x40),	/* bl */
+	T("00 01 3f d6", TEXT_CALL, .defs = BIT(30)),			/* blr x8 */
+	T("c0 03 5f d6", TEXT_RETURN),					/* ret */
+	T("e0 03 9f d6", TEXT_OTHER, .defs = TEXT_ALL_REGS),		/* eret */
+	{}
+};
+
+const struct mc_arch mc_arch = {
+	.arch = {
+		.retval = 0,
+		/* AAPCS64: x0 to x17 and x30. x18 is fixed in the kernel */
+		.caller_saved = 0x4003ffff,
+	},
+	.machine = EM_AARCH64,
+	.triple = "aarch64-unknown-linux-gnu",
+	.features = "+all",
+	.regs = "X0 X1 X2 X3 X4 X5 X6 X7 X8 X9 X10 X11 X12 X13 X14 X15 X16 X17 X18 X19 X20 "
+		"X21 X22 X23 X24 X25 X26 X27 X28 FP LR",
+	.regs32 = "W0 W1 W2 W3 W4 W5 W6 W7 W8 W9 W10 W11 W12 W13 W14 W15 W16 W17 W18 W19 W20 "
+		  "W21 W22 W23 W24 W25 W26 W27 W28 W29 W30",
+	.zero_regs = "WZR XZR",
+	.patterns = arm64_patterns,
+	.tests = arm64_tests,
+};
diff --git a/tools/bpf/resolve_btfids/text_mc_x86.c b/tools/bpf/resolve_btfids/text_mc_x86.c
new file mode 100644
index 000000000000..8099bbc05d8e
--- /dev/null
+++ b/tools/bpf/resolve_btfids/text_mc_x86.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* x86-64 for text_mc.cpp */
+
+#include <elf.h>
+#include <linux/bits.h>
+
+#include "text_mc.h"
+
+enum { RAX, RCX, RDX, RBX, RSP, RBP, RSI, RDI, R8, R9, R10, R11 };
+
+#define I	MC_IMPLICIT
+
+static const struct mc_pattern x86_patterns[] = {
+	/* A 64-bit immediate, MOV64ri, may be a runtime constant, which the kernel patches */
+	{ "MOV32ri",		TEXT_MOV_IMM, .imm = 1 },
+	{ "MOV64ri32",		TEXT_MOV_IMM, .imm = 1 },
+	{ "OR32ri8",		TEXT_MOV_IMM, .imm = 2, .predicates = { IMM(2, -1) } },
+	{ "OR64ri8",		TEXT_MOV_IMM, .imm = 2, .predicates = { IMM(2, -1) } },
+	{ "MOV32rr",		TEXT_MOV, .src = 1 },
+	{ "MOV64rr",		TEXT_MOV, .src = 1 },
+	{ "MOVSX64rr32",	TEXT_SEXT32, .src = 1 },
+	{ "CDQE",		TEXT_SEXT32, .dst = I, .src = I },
+	{ "CMOV32rr",		TEXT_SELECT, .src = 2, .src2 = 1 },
+	{ "CMOV64rr",		TEXT_SELECT, .src = 2, .src2 = 1 },
+	/* All bits of the result are equal */
+	{ "SBB32rr",		TEXT_MOV_IMM, VALUE(-1), .or_zero = true, .predicates = { SAME_REG(1, 2) } },
+	{ "SBB64rr",		TEXT_MOV_IMM, VALUE(-1), .or_zero = true, .predicates = { SAME_REG(1, 2) } },
+	{ "SAR32ri",		TEXT_MOV_IMM, VALUE(-1), .or_zero = true, .predicates = { IMM(2, 31) } },
+	{ "LOCK_PREFIX",	TEXT_OTHER },
+	/* A rep prefix is not a part of the MCInst */
+	{ "STOSQ",		TEXT_OTHER, .defs = BIT(RCX) },
+	{ "RET64",		TEXT_RETURN },
+	{}
+};
+
+#define T(code, insn_kind, ...)	{ code, { .kind = insn_kind, __VA_ARGS__ } }
+#define IMMS(a, b)		.imm = a, .imm2 = b
+#define SRC(reg)		.src = reg, .src2 = reg
+
+/* Each pattern, and what must not match it */
+static const struct mc_test x86_tests[] = {
+	T("b8 ea ff ff ff",	  TEXT_MOV_IMM, .is32 = true, IMMS(0xffffffea, 0xffffffea)), /* mov $-22, %eax */
+	T("48 c7 c3 ea ff ff ff", TEXT_MOV_IMM, .dst = RBX, IMMS(-22, -22)),	/* mov $-22, %rbx */
+	T("83 c8 ff",		  TEXT_MOV_IMM, .is32 = true, IMMS(0xffffffff, 0xffffffff)), /* or $-1, %eax */
+	T("48 83 c8 ff",	  TEXT_MOV_IMM, IMMS(-1, -1)),			/* or $-1, %rax */
+	T("83 c8 f0",		  TEXT_OTHER, .defs = BIT(RAX)),		/* or $-16, %eax */
+	T("48 83 c8 f0",	  TEXT_OTHER, .defs = BIT(RAX)),		/* or $-16, %rax */
+	T("19 c0",		  TEXT_MOV_IMM, .is32 = true, IMMS(0xffffffff, 0)),	/* sbb %eax, %eax */
+	T("48 19 c0",		  TEXT_MOV_IMM, IMMS(-1, 0)),			/* sbb %rax, %rax */
+	T("19 d8",		  TEXT_OTHER, .defs = BIT(RAX)),		/* sbb %ebx, %eax */
+	T("48 19 d8",		  TEXT_OTHER, .defs = BIT(RAX)),		/* sbb %rbx, %rax */
+	T("c1 f8 1f",		  TEXT_MOV_IMM, .is32 = true, IMMS(0xffffffff, 0)),	/* sar $31, %eax */
+	T("c1 f8 1e",		  TEXT_OTHER, .defs = BIT(RAX)),		/* sar $30, %eax */
+	T("89 d8",		  TEXT_MOV, .is32 = true, SRC(RBX)),		/* mov %ebx, %eax */
+	T("4c 89 e0",		  TEXT_MOV, SRC(12)),				/* mov %r12, %rax */
+	T("48 63 c3",		  TEXT_SEXT32, SRC(RBX)),			/* movslq %ebx, %rax */
+	T("48 98",		  TEXT_SEXT32, SRC(RAX)),			/* cltq */
+	T("0f 44 c3",		  TEXT_SELECT, .is32 = true, .src = RBX, .src2 = RAX),	/* cmove %ebx, %eax */
+	T("48 0f 44 c3",	  TEXT_SELECT, .src = RBX, .src2 = RAX),	/* cmove %rbx, %rax */
+	T("f0",			  TEXT_OTHER),					/* lock */
+	T("f3 48 ab",		  TEXT_OTHER, .defs = BIT(RCX) | BIT(RDI)),	/* rep stosq */
+	/* hasUnmodeledSideEffects() */
+	T("f3 48 a5",		  TEXT_OTHER, .defs = TEXT_ALL_REGS),		/* rep movsq */
+	T("0f 05",		  TEXT_OTHER, .defs = TEXT_ALL_REGS),		/* syscall */
+	/* A write of these which is missed would change the errors of a function in some kernel */
+	T("31 d8",		  TEXT_OTHER, .defs = BIT(RAX)),		/* xor %ebx, %eax */
+	T("8b 03",		  TEXT_OTHER, .defs = BIT(RAX)),		/* mov (%rbx), %eax */
+	T("48 8b 03",		  TEXT_OTHER, .defs = BIT(RAX)),		/* mov (%rbx), %rax */
+	T("8d 04 1b",		  TEXT_OTHER, .defs = BIT(RAX)),		/* lea (%rbx,%rbx), %eax */
+	T("03 03",		  TEXT_OTHER, .defs = BIT(RAX)),		/* add (%rbx), %eax */
+	T("83 c0 10",		  TEXT_OTHER, .defs = BIT(RAX)),		/* add $16, %eax */
+	T("48 83 c0 10",	  TEXT_OTHER, .defs = BIT(RAX)),		/* add $16, %rax */
+	T("05 00 01 00 00",	  TEXT_OTHER, .defs = BIT(RAX)),		/* add $256, %eax */
+	T("81 c3 00 01 00 00",	  TEXT_OTHER, .defs = BIT(RBX)),		/* add $256, %ebx */
+	T("48 81 c3 00 01 00 00", TEXT_OTHER, .defs = BIT(RBX)),		/* add $256, %rbx */
+	T("29 d8",		  TEXT_OTHER, .defs = BIT(RAX)),		/* sub %ebx, %eax */
+	T("21 d8",		  TEXT_OTHER, .defs = BIT(RAX)),		/* and %ebx, %eax */
+	T("25 00 01 00 00",	  TEXT_OTHER, .defs = BIT(RAX)),		/* and $256, %eax */
+	T("81 e3 00 01 00 00",	  TEXT_OTHER, .defs = BIT(RBX)),		/* and $256, %ebx */
+	T("48 81 e3 00 01 00 00", TEXT_OTHER, .defs = BIT(RBX)),		/* and $256, %rbx */
+	T("09 d8",		  TEXT_OTHER, .defs = BIT(RAX)),		/* or %ebx, %eax */
+	T("48 63 03",		  TEXT_OTHER, .defs = BIT(RAX)),		/* movslq (%rbx), %rax */
+	T("48 c1 e8 02",	  TEXT_OTHER, .defs = BIT(RAX)),		/* shr $2, %rax */
+	T("48 c1 f8 3f",	  TEXT_OTHER, .defs = BIT(RAX)),		/* sar $63, %rax */
+	T("0f 44 0b",		  TEXT_OTHER, .defs = BIT(RCX)),		/* cmove (%rbx), %ecx */
+	T("48 0f 44 0b",	  TEXT_OTHER, .defs = BIT(RCX)),		/* cmove (%rbx), %rcx */
+	T("83 d8 00",		  TEXT_OTHER, .defs = BIT(RAX)),		/* sbb $0, %eax */
+	T("83 d0 00",		  TEXT_OTHER, .defs = BIT(RAX)),		/* adc $0, %eax */
+	T("0f bd c3",		  TEXT_OTHER, .defs = BIT(RAX)),		/* bsr %ebx, %eax */
+	T("48 0f bd c3",	  TEXT_OTHER, .defs = BIT(RAX)),		/* bsr %rbx, %rax */
+	T("80 e3 01",		  TEXT_OTHER, .defs = BIT(RBX)),		/* and $1, %bl */
+	T("48 0f c1 13",	  TEXT_OTHER, .defs = BIT(RDX)),		/* xadd %rdx, (%rbx) */
+	/* The control flow */
+	T("eb 10",		  TEXT_BRANCH, .imm = MC_TEST_ADDR + 0x12),	/* jmp */
+	T("ff e0",		  TEXT_BRANCH),					/* jmp *%rax */
+	T("0f 84 00 01 00 00",	  TEXT_COND_BRANCH, .imm = MC_TEST_ADDR + 0x106), /* je */
+	T("e8 00 01 00 00",	  TEXT_CALL, .imm = MC_TEST_ADDR + 0x105),	/* call */
+	T("c3",			  TEXT_RETURN),					/* ret */
+	T("48 cf",		  TEXT_OTHER, .defs = TEXT_ALL_REGS),		/* iretq */
+	{}
+};
+
+const struct mc_arch mc_arch = {
+	.arch = {
+		.retval = RAX,
+		.caller_saved = BIT(RAX) | BIT(RCX) | BIT(RDX) | BIT(RSI) | BIT(RDI) |
+				BIT(R8) | BIT(R9) | BIT(R10) | BIT(R11),
+		.return_thunk = "__x86_return_thunk",
+	},
+	.machine = EM_X86_64,
+	.triple = "x86_64-unknown-linux-gnu",
+	.features = "",
+	.regs = "RAX RCX RDX RBX RSP RBP RSI RDI R8 R9 R10 R11 R12 R13 R14 R15",
+	.regs32 = "EAX ECX EDX EBX ESP EBP ESI EDI R8D R9D R10D R11D R12D R13D R14D R15D",
+	.patterns = x86_patterns,
+	.tests = x86_tests,
+};
-- 
2.55.0

