Received: from mail-pj2-f38.google.com (mail-pj2-f38.google.com [74.125.227.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0AE40F74B
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 19:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790796735; cv=none; b=ltfTRALWNvJf8/aMxTnSGfezufQtwon1uTz8osRjdoy36li8k4szKY4QWg6Q8Q3BOnal1E9QAIZZJfvS6R/jB0RIgU9eVhYfXE8zMhX8E/JiquvOLIZkd5wHkQSDY5KC0itXOVzKKooaHFoYxEzAhfNN+dP0hkz5PRinoMF2z8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790796735; c=relaxed/simple;
	bh=+SG+Y1bZwIggThun1cMHFPi37HCbLitkwkA648v3E5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UEgTcOtfmuCuyjSynoWJM9oYYDZ+joLZYoTNLeNDwtIG/EwdVlKmhMhJnavsvjzgwjENWi0nYA/f1xULoDMlPaQTWsOXmsYQgVrr3/XjZm3H7l+/XXzNTGa8cinDdEF00zzrE2KmLa7G/dOIP6RNZtr2Ui0sCy471sstZn/xdyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XGUZbRKo; arc=none smtp.client-ip=74.125.227.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGUZbRKo"
Received: by mail-pj2-f38.google.com with SMTP id 98e67ed59e1d1-3a4b4770191so1033495a91.2
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 12:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790796733; x=1791401533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l7gYAyF6FowKJE/JAc8J8VQUea6opF9jps42Z6iHPoM=;
        b=XGUZbRKodomzWFB4PZOX8v2l85KlQprO2VlNi1+bbk9Y3C1AQrOFDaGe3ZhGUJAU8s
         RRUDlXkpB70sKMH2TyKI+rKy8AxzzdeR0SJDmRZxViP2vfwsufEm6Yp67adArELKwAR9
         3ltRQCjYu88m0zIGiJERQvAP+V60kHS/SQ5TfHxtqetKWc+XTvEGPgm8GWiyyBlHFsyT
         Y55CU6lcnUOptVh+3wqBnntIXMv076K/GlvpCVqnGO+kQRhh0MT1z6NjCw2yAhUYq4Kb
         aCXAHaTb0puUYVuErGbG7DM0f8UlnaiFiXuQZcNuo51q01PZiK6+KyIrVj8MZPRVGb3v
         zGvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790796733; x=1791401533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=l7gYAyF6FowKJE/JAc8J8VQUea6opF9jps42Z6iHPoM=;
        b=RGyhtrbnL/xs5ZUjTyvqB+9tC2WRIfgyDRgxpxOrjFJolxNxOupwT5SS6R94gtRpxe
         67xVCXCCDxUrlKQOGvZWtXOOfDthwcMhWIrCRTlrzKiAfl/Ma0oVq1/X1Xi648zJb8k2
         ev1CvBdElMwvbt6D+787K9gQ4IiNDS7kZvfOL8n9wT2El61cBFMJoWOt1kidCuvKbQxn
         M2II1eesqmYupHNiHj5O1lUWaqrd+NDzQZvrqj6mf1v/1Ooxqd3j9HFslCLMZMbmtV5U
         4G0l7y8qQqQYQCGaFCMSiV3hW0ZwYan3pcWTdXyFrHWJ0b6MoNbDdTkz2YGRgHMtOIJU
         HINQ==
X-Gm-Message-State: AFq9FYIrwrmse+sIx2FtNYAEaE6P0Z/5fiOMN+YTW/z+Z6bFp8T0b/W+
	w/IDTvQ0nvG7z9813DHkZLP/uzpGJm4INJoupklqL7FAwRzSaKmneo84fDuJlrEh
X-Gm-Gg: AYBFou0Cz5KM3eTVPNCLkCMYodyCJ30+IPFVwhABXCurI98fhHHuP1+j8WTwOzJcXmr
	8tVgIRb9Vy4YV9Z5bQ1qDA4Cf31m89AKxah9D9+K0WlH9J7hQrAA3WdPoOubdUucBq6FzdHZBKw
	FW7ZgzrdwBEduWeZPsvj2aEbLW60EMlNYxr4Gm3PyeIobXUkdGL6p/AS6WEJOw6dh4zL++VE+Sv
	ItNlYf+TO2w4BWXE8dTvn5/ITWT1RBjpc8SwzJvwc8mpZG3AWxxl6sGySKrLxcTH+Bju+rxJZ1p
	w8o+OcMH2TzzCAGKFzTe0bd4+dWcBbbhY+DEIttid0zTBB8t2DF3bLkAKYbtG/ZvDwYTK8gpeth
	4IgI9MnHl2wecie9aP1DWYVKHGIl+SKoo8mH5oEkDkxs8FQ7tueSab8XbW7tnsFRPC8O04vaxSx
	jStxqQBzRk9JKuTxonTirSGhGXTGn0C2irHRs2zjr+zYTQD7Z+ts7r/KWmTtjyUC9Q5F4Mdwd18
	WmGo5DiMdDPG5fxjkU2HbLGIiCh79xeiYtnFXcrC0URCwr7pK6um77lIFDkov0rhjcfc7gFHJAH
	ALzwNVLgKfhO9dxxegyV5oObbLo8PPUYGHxVYEk2soU=
X-Received: by 2002:a17:90b:3911:b0:3a2:a185:aad6 with SMTP id 98e67ed59e1d1-3a4d14fb40bmr2027271a91.23.1790796732706;
        Wed, 30 Sep 2026 12:32:12 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4f446867asm770226a91.12.2026.09.30.12.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 12:32:12 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 14/14] selftests/bpf: Add test for global data of a program in Rust
Date: Wed, 30 Sep 2026 19:31:27 +0000
Message-ID: <20260930193127.2181684-15-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930193127.2181684-1-alexei.starovoitov@gmail.com>
References: <20260930193127.2181684-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

data_in_arena_rust.rs shows why libbpf keeps .data, .bss and .rodata of
a program in Rust in arena. A reference in Rust is an address that can
be stored in data. The list in the test has a node in each of the three
sections. IN_BSS.next is stored by the program, IN_DATA.next is
a relocation in .data against .rodata. sum() follows them and reads all
nodes with the same insns:

  5: w0 = *(u32 *)(r1 + 0x8)
  8: r1 = *(u64 *)(r1 + 0x0)

The same program without .arena.data section, when the sections are
array maps:

  libbpf: elf: skipping relo section(9) .rel.data for section(8) .data
  ...
  16: (79) r1 = *(u64 *)(r1 +0)         ; frame1: R1=scalar()
  ...
  13: (61) r0 = *(u32 *)(r1 +8)
  R1 invalid mem access 'scalar'

The program is built by upstream rustc for its bpfel-unknown-none
target. Nothing is done to the output: rustc emits LLVM bitcode and
clang makes the object of it for the cpu version of the test_progs
flavor. rustc has no prebuilt core for the target, so core is built from
the source that comes with rustc, like the kernel does it. That takes
5 seconds.

The subtest is skipped when there is no rustc, no source of core
(rustup component add rust-src) or when clang is older than 23.

There are no kfuncs in the program. rustc doesn't emit debug info for
extern functions, so there would be no BTF for them.

panic=abort is a stop gap. Nothing in the program panics, so the panic
handler is not loaded. The series from Yonghong are about to add support
for panic=unwind.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/Makefile          | 12 +++-
 .../testing/selftests/bpf/Makefile.buildvars  | 19 +++++
 tools/testing/selftests/bpf/Makefile.skel     | 14 ++++
 .../selftests/bpf/prog_tests/data_in_arena.c  | 25 +++++++
 .../selftests/bpf/progs/data_in_arena_rust.rs | 70 +++++++++++++++++++
 5 files changed, 139 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/data_in_arena_rust.rs

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index afa589a27b15..a22be7efd1fa 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -422,6 +422,16 @@ $(LIBARENA_ASAN_SKEL): $(INCLUDE_DIR)/vmlinux.h $(BPFOBJ) $(LIBARENA_BPF_DEPS)
 	+$(MAKE) -C libarena libarena_asan.skel.h $(LIBARENA_MAKE_ARGS)
 endif
 
+# #![no_std] looks for compiler_builtins too. Nothing of it is used.
+ifneq ($(RUST_CORE),)
+$(RUST_CORE): $(RUST_CORE_SRC)
+	$(call msg,RUSTC,,$@)
+	$(Q)mkdir -p $(@D)
+	+$(Q)$(RUSTC_BPF) -A warnings --edition 2024 --crate-name core --out-dir $(@D) $<
+	+$(Q)echo '#![feature(compiler_builtins)] #![compiler_builtins] #![no_std]' | \
+		$(RUSTC_BPF) -A warnings --crate-name compiler_builtins --out-dir $(@D) -
+endif
+
 # Generated test list headers
 
 define gen_tests_hdr
@@ -457,7 +467,7 @@ RUNNER_PREREQS := $(INCLUDE_DIR)/vmlinux.h $(BPFOBJ) $(BPFTOOL)		\
 		  $(VERIFY_SIG_HDR) $(PRIVATE_KEY) $(VERIFICATION_CERT)	\
 		  $(LIBARENA_SKEL) $(LIBARENA_ASAN_SKEL)		\
 		  prog_tests/tests.h map_tests/tests.h			\
-		  $(RUNNER_OBJS)
+		  $(RUNNER_OBJS) $(RUST_CORE)
 
 # Runtime fixtures for each test_progs flavor.
 RUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read				\
diff --git a/tools/testing/selftests/bpf/Makefile.buildvars b/tools/testing/selftests/bpf/Makefile.buildvars
index d2a0c0031b87..c1a255d4287e 100644
--- a/tools/testing/selftests/bpf/Makefile.buildvars
+++ b/tools/testing/selftests/bpf/Makefile.buildvars
@@ -109,6 +109,25 @@ HOST_INCLUDE_DIR	:= $(INCLUDE_DIR)
 endif
 RESOLVE_BTFIDS := $(HOST_BUILD_DIR)/resolve_btfids/resolve_btfids
 
+# Programs in Rust are built by upstream rustc. It has no prebuilt core for
+# the bpf target, so it has to come with the source of core:
+#   rustup component add rust-src
+# rustc emits LLVM bitcode, clang 23 or newer makes the object of it.
+# Without any of them RUST_CORE is empty and the tests are skipped.
+RUSTC ?= rustc
+RUST_CORE_SRC := $(wildcard $(shell $(RUSTC) --print sysroot 2>/dev/null)$\
+			    /lib/rustlib/src/rust/library/core/src/lib.rs)
+ifneq ($(RUST_CORE_SRC),)
+ifeq ($(shell [ 0$(shell echo __clang_major__ | $(CLANG) -E -P -x c - 2>/dev/null) -ge 23 ] && echo y),y)
+RUST_CORE := $(BUILD_DIR)/rust/libcore.rlib
+endif
+endif
+# RUSTC_BOOTSTRAP=1 is to build core with a stable rustc, like the kernel does.
+# panic=abort is a stop gap until panic=unwind is supported.
+RUSTC_BPF = RUSTC_BOOTSTRAP=1 $(RUSTC) -O -C panic=abort --crate-type rlib	\
+	    --target $(if $(IS_LITTLE_ENDIAN),bpfel,bpfeb)-unknown-none		\
+	    -L $(dir $(RUST_CORE))
+
 DEFAULT_BPFTOOL := $(HOST_SCRATCH_DIR)/sbin/bpftool
 ifneq ($(CROSS_COMPILE),)
 CROSS_BPFTOOL := $(SCRATCH_DIR)/sbin/bpftool
diff --git a/tools/testing/selftests/bpf/Makefile.skel b/tools/testing/selftests/bpf/Makefile.skel
index d9ddd1d86f89..df6bbf644a43 100644
--- a/tools/testing/selftests/bpf/Makefile.skel
+++ b/tools/testing/selftests/bpf/Makefile.skel
@@ -138,4 +138,18 @@ $(LINKED_SKELS_H): $(RDIR)/%.skel.h: $$(addprefix $(RDIR)/,$$($$*.skel.h-deps))
 		   $(BPFTOOL) $(GEN_SKEL) | $(RDIR)
 	$(Q)$(cmd_bpf_link_skel)
 
+# Programs in Rust, see Makefile.buildvars. No skeletons: the objects may be absent.
+ifneq ($(RUST_CORE),)
+ifeq ($(BPF_CC),$(CLANG))
+RUST_OBJS := $(patsubst progs/%.rs,$(RDIR)/%.bpf.o,$(wildcard progs/*.rs))
+BPF_OBJS += $(RUST_OBJS)
+
+$(RUST_OBJS): $(RDIR)/%.bpf.o: progs/%.rs $(RUST_CORE) | $(RDIR)
+	$(call msg,RUSTC,$(BINARY),$@)
+	+$(Q)$(RUSTC_BPF) --edition 2021 -C debuginfo=2 --emit=llvm-bc -o -	\
+		$(patsubst -mcpu=%,-C target-cpu=%,$(filter -mcpu=%,$(BPF_CC_FLAGS))) $< | \
+		$(BPF_CC) $(BPF_CC_FLAGS) -x ir -c - -o $@
+endif
+endif
+
 endif # BPF_CC
diff --git a/tools/testing/selftests/bpf/prog_tests/data_in_arena.c b/tools/testing/selftests/bpf/prog_tests/data_in_arena.c
index bccfb0110b94..d8bc489820b1 100644
--- a/tools/testing/selftests/bpf/prog_tests/data_in_arena.c
+++ b/tools/testing/selftests/bpf/prog_tests/data_in_arena.c
@@ -128,6 +128,29 @@ static void test_ptr_to_extern(void)
 		bpf_object__close(obj);
 }
 
+/* The object is there if rustc and clang can build it, see Makefile.buildvars */
+static void test_rust(void)
+{
+	const char *file = "./data_in_arena_rust.bpf.o";
+	struct bpf_object *obj;
+
+	if (access(file, R_OK)) {
+		test__skip();
+		return;
+	}
+	obj = bpf_object__open_file(file, NULL);
+	if (!ASSERT_OK_PTR(obj, "open"))
+		return;
+	if (!ASSERT_OK(bpf_object__load(obj), "load"))
+		goto out;
+	/* libbpf goes on without BTF when the kernel doesn't take it */
+	ASSERT_GE(bpf_object__btf_fd(obj), 0, "btf_fd");
+	ASSERT_EQ(run_prog(bpf_object__find_program_by_name(obj, "list_in_data")),
+		  100 + 20 + 3, "retval");
+out:
+	bpf_object__close(obj);
+}
+
 void test_data_in_arena(void)
 {
 #if !defined(__x86_64__) && !defined(__aarch64__)
@@ -143,4 +166,6 @@ void test_data_in_arena(void)
 		test_ptr_to_map();
 	if (test__start_subtest("ptr_to_extern"))
 		test_ptr_to_extern();
+	if (test__start_subtest("rust"))
+		test_rust();
 }
diff --git a/tools/testing/selftests/bpf/progs/data_in_arena_rust.rs b/tools/testing/selftests/bpf/progs/data_in_arena_rust.rs
new file mode 100644
index 000000000000..b69128487a0f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/data_in_arena_rust.rs
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Why .data, .bss and .rodata of a program in Rust are in arena.
+//
+// A reference in Rust is an address. It doesn't say what it points to and it
+// can be stored in data. The list below has a node in each of the sections.
+// The nodes are linked by references that are in the data:
+//   IN_BSS.next is stored by the program,
+//   IN_DATA.next is a relocation in .data against .rodata.
+// sum() loads the references back and reads the three nodes with the same insn.
+//
+// When the sections are array maps libbpf skips the relocation in .data, and
+// what sum() loads from a node is a number that can't be dereferenced:
+//   R1 invalid mem access 'scalar'
+// In arena the address of a node is a number to begin with.
+
+#![no_std]
+#![no_main]
+
+// Tell libbpf to keep .data, .bss and .rodata in arena.
+#[used]
+#[link_section = ".arena.data"]
+static DATA_IN_ARENA: u8 = 0;
+
+#[used]
+#[link_section = "license"]
+static LICENSE: [u8; 4] = *b"GPL\0";
+
+// panic=abort is a stop gap until panic=unwind is supported.
+// Nothing here panics, so the handler is not a part of the program.
+#[panic_handler]
+fn panic(_info: &core::panic::PanicInfo) -> ! {
+    loop {}
+}
+
+pub struct Node {
+    val: u32,
+    next: Option<&'static Node>,
+}
+
+// no_mangle makes them visible outside, so LLVM can't fold the list into a constant.
+#[no_mangle]
+static IN_RODATA: Node = Node { val: 3, next: None };
+#[no_mangle]
+static mut IN_DATA: Node = Node { val: 20, next: Some(&IN_RODATA) };
+#[no_mangle]
+static mut IN_BSS: Node = Node { val: 0, next: None };
+
+#[inline(never)]
+fn sum(mut node: Option<&Node>) -> u32 {
+    let mut sum = 0;
+    // The verifier wants a bound.
+    for _ in 0..8 {
+        let Some(n) = node else { break };
+        sum += n.val;
+        node = n.next;
+    }
+    sum
+}
+
+#[no_mangle]
+#[link_section = "syscall"]
+pub extern "C" fn list_in_data(_ctx: *mut u8) -> u32 {
+    unsafe {
+        let head = &mut *&raw mut IN_BSS;
+        head.val = 100;
+        head.next = Some(&*&raw const IN_DATA);
+        sum(Some(head))
+    }
+}
-- 
2.55.0

