Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A842A211466
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 12:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790945283; cv=none; b=kgBf1Hr5UQa9EW80wACTRY5DDcTWGYh+w1maDKbugVKublExjuzcFI3Q8++kE5J0Q60YCZsnc0c1qUaH0gOfXVEUxxoWSwqO2/SrwAH58Svr/ru7+Am4jks73AyB0jXH0yeyUUq5+G4f2zP1Gv4tp5q+aQX/EwW4z8JEHqpcDSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790945283; c=relaxed/simple;
	bh=aWTyrP30ysibfvVEdm/t+U+Z9kKYAl3hk7QVwJrAYq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GyCXiI249R6u8AY3PH0Jeb+d1kvJZlwz9s9rBa7pi5QvHYcQSjeTBjICO/WCO+yCzE7TiBllORLXPeGuWSA198TzWFk6O3mP8xhOiWyhsKKGQYEpvIdpnkO6pVYT2j1j8Gjg4QgafWTNyfFobodrIIPzDVZ6vKWOeyXGmKPomLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LnnQbYNw; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnnQbYNw"
Received: by mail-pz2-f42.google.com with SMTP id d2e1a72fcca58-86e6d007703so3745851b3a.0
        for <bpf@vger.kernel.org>; Fri, 02 Oct 2026 05:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790945281; x=1791550081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9ejhsm2dAXrreFVX275shhSG7w5tIUjEJXt0C6YXz4A=;
        b=LnnQbYNwHufMpfvrDIz9hFo9/dIMvdetXSRySx7IPXEOWjqgtq/wZujjnAkaeEaDIB
         gBFY8YiHEoGPBum2/EQjegKdIfhmM6qdqQJg19TVMgDDqVLkakGFLGpPWyDNuv8YXW/0
         jticD6/PnGpMLd/VrrdEtMZapA/zaPgNho7QV8MNi1l0p28oHr8ngm7Cgkj4tT+q4Hnv
         6/Dbcw1kpb1+3E2Vo1p5jYcWPXxudmxhMl5pjfOp+SqexUtJAOnp5EkqPro/02G0pSRc
         uVOzNaZl2k3GZq1w6QqOPbEvFMevk5CRlQ/e805/amDISatQXvMSU/IuXhH4W+XxvJWS
         fnQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790945281; x=1791550081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9ejhsm2dAXrreFVX275shhSG7w5tIUjEJXt0C6YXz4A=;
        b=gbnSPZfYpbfhNx7sKklpNR2/yoVGP1YKL9YSSCxNSjX0ftZgdz8bODDL4qDpv8tQ1W
         rAiHbuVn86fXsaWLMLjssOfPg6OooP5fk38OJgUE9zX8S3CRlbLLpoK+4V/DB903qf8v
         0HgLhVV5laIGEZrozTKffT7o5oq0ua9OETi6diGFhwWVTfn9NITIyIdZn61C3w5HGdOM
         dLGKAJHaY/Nzj+882k1lwcbj7kKJIrXjlnHMWT6kDDb7rfEWB3chZZFC5VWLg/tqCy/6
         2w3hwm1yofntr6LhZselQhKZqazlAUKbjh+8EHZNUNKZa9jF9Fgq9p80h52+KrDU99CL
         I7Sw==
X-Gm-Message-State: AFuF++kchB3HAzwG8GGePrLQT5HZ0QSmSqGrm/pYIVyf6NU6N+RQWFLO
	K/LIVP7hZ7BGc6geBrDDpHcZQwnzte9tR7fDpKqLHVwI/hG7KZxFGm/ebPgGoQfuls8=
X-Gm-Gg: AYBFou3HGuSi5W/NlM21t5QbnQqHjy9+ZptbsmxowibjSXdu3dHZ/0CjT/2zv766yNM
	MZ/gL3RGfXrGWkW7LL5HoNcbsanf4JxooydIKnuGxV9syGzMyFRzW/aL948Pn4x3O3Wg/EHNPFN
	PDah/WMLgnfp60DtfuH0w0oxWM+uKaDC5vECO+Zw1jy79DL6rMtaNfXMnLZmEq+H9k3MyGBCCBo
	1GKFhl0DXtnk4Q5qNInzo49Np8zCx9qt/coTUCDD6sF00mFU1sYhJH2ayaJ+0DVhRb8U/KsgL0J
	Ag7s+Sxq3+eIweXoyMUqhyDQsryK/EA+oc7FspeOLKhVNSz5fXLp4SIZ7kPOnhdHSKxM6vHaMXk
	e12l7W2YcQIbAbcZSeDipU7aC/rkbMy7+SHMeJKpg+//+yGC3iS+tW9l0t/S3/uyqjqFU3e1hLE
	23bFTRUrBE3xkc7u53JTF6YGc/2yRnFl0TMujf5ltXM59VxsK0iRjXLGb6UH9uUUsVrbWwMm89J
	PlfvA26q6Ojq3TwP4Yd1w9xRtuYVfZMaLM8cIBsb28CYsKv5ooiqH+s6cPz5hhKKR6lO5r5Hjpe
	7h2Ucdsz38IJxb5XQMhHXBCJeRsfmfVy3yTpQYk5WIGeAQdEanU4WNwrQpL0DsSXhrU=
X-Received: by 2002:a05:6a20:e188:b0:3dd:a006:ed96 with SMTP id adf61e73a8af0-3e0bd15082fmr2720136637.44.1790945280677;
        Fri, 02 Oct 2026 05:48:00 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-88b069b47b1sm884830b3a.0.2026.10.02.05.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 05:48:00 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 15/15] selftests/bpf: Add test for global data of a program in Rust
Date: Fri,  2 Oct 2026 12:47:14 +0000
Message-ID: <20261002124714.180012-16-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002124714.180012-1-alexei.starovoitov@gmail.com>
References: <20261002124714.180012-1-alexei.starovoitov@gmail.com>
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

The subtest is skipped when:
- there is no rustc or it is older than 1.87. core is built as edition
  2024, which it is since then.
- rustc comes without the source of core (rustup component add rust-src).
- clang is older than 23 or older than LLVM of rustc. It can't read
  the bitcode then.

There are no kfuncs in the program. rustc doesn't emit debug info for
extern functions, so there would be no BTF for them.

panic=abort is a stop gap. Nothing in the program panics, so the panic
handler is not loaded. The series from Yonghong are about to add support
for panic=unwind.

Tested with rustc 1.95.0-nightly (LLVM 22.1) and clang 24.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/Makefile          | 12 +++-
 .../testing/selftests/bpf/Makefile.buildvars  | 25 +++++++
 tools/testing/selftests/bpf/Makefile.skel     | 15 ++++
 .../selftests/bpf/prog_tests/data_in_arena.c  | 25 +++++++
 .../selftests/bpf/progs/data_in_arena_rust.rs | 70 +++++++++++++++++++
 5 files changed, 146 insertions(+), 1 deletion(-)
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
index d2a0c0031b87..ff3476bc40a4 100644
--- a/tools/testing/selftests/bpf/Makefile.buildvars
+++ b/tools/testing/selftests/bpf/Makefile.buildvars
@@ -109,6 +109,31 @@ HOST_INCLUDE_DIR	:= $(INCLUDE_DIR)
 endif
 RESOLVE_BTFIDS := $(HOST_BUILD_DIR)/resolve_btfids/resolve_btfids
 
+# Programs in Rust are built by upstream rustc. It has no prebuilt core for
+# the bpf target, so it has to come with the source of core:
+#   rustup component add rust-src
+# core is built as edition 2024, which it is since rustc 1.87.
+# rustc emits LLVM bitcode and clang makes the object of it, so clang has to be
+# 23 or newer and not older than LLVM of rustc.
+# Otherwise RUST_CORE is empty and the tests are skipped.
+RUSTC ?= rustc
+RUST_CORE_SRC := $(wildcard $(shell $(RUSTC) --print sysroot 2>/dev/null)$\
+			    /lib/rustlib/src/rust/library/core/src/lib.rs)
+ifneq ($(RUST_CORE_SRC),)
+ifeq ($(shell { clang=$$(echo __clang_major__ | $(CLANG) -E -P -x c -) &&		\
+		llvm=$$($(srctree)/scripts/rustc-llvm-version.sh $(RUSTC)) &&		\
+		[ $$($(srctree)/scripts/rustc-version.sh $(RUSTC)) -ge 108700 ] &&	\
+		[ $$clang -ge 23 ] && [ $$clang -ge $$((llvm / 10000)) ]; }		\
+		2>/dev/null && echo y),y)
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
index 765666a64b89..06e297a17156 100644
--- a/tools/testing/selftests/bpf/Makefile.skel
+++ b/tools/testing/selftests/bpf/Makefile.skel
@@ -138,4 +138,19 @@ $(LINKED_SKELS_H): $(RDIR)/%.skel.h: $$(addprefix $(RDIR)/,$$($$*.skel.h-deps))
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
+	+$(Q)$(RUSTC_BPF) --edition 2021 -C debuginfo=2 --emit=llvm-bc			\
+		$(patsubst -mcpu=%,-C target-cpu=%,$(filter -mcpu=%,$(BPF_CC_FLAGS)))	\
+		-o $(dir $(RUST_CORE))$(BINARY)-$*.bc $< &&				\
+	$(BPF_CC) $(BPF_CC_FLAGS) -c $(dir $(RUST_CORE))$(BINARY)-$*.bc -o $@ $(call skip_on_fail,BPF)
+endif
+endif
+
 endif # BPF_CC
diff --git a/tools/testing/selftests/bpf/prog_tests/data_in_arena.c b/tools/testing/selftests/bpf/prog_tests/data_in_arena.c
index 86dc6798bbde..cb1023507c01 100644
--- a/tools/testing/selftests/bpf/prog_tests/data_in_arena.c
+++ b/tools/testing/selftests/bpf/prog_tests/data_in_arena.c
@@ -167,6 +167,29 @@ static void test_not_my_arena(bool pin)
 	data_in_arena__destroy(skel);
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
@@ -188,4 +211,6 @@ void test_data_in_arena(void)
 		test_not_my_arena(true);
 	if (test__start_subtest("reused_arena"))
 		test_not_my_arena(false);
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

