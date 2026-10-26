Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792983593;
	b=ga91suPdNpk5LDn25Zu0wiceItfCn/MDckjnXAPkhCChMSmmE9yhWVYEIK9W6YL83Eq1
	 E+7jKp1BTA7zt3JF5aqswerAXDcD7Aemhkem69hgtbVGmci/v7Nws0OTi4reAjZfR/Dpf
	 +SgsCkdrMOSQ2L+w/kNFrWnabjGm9p3t//R73avzzOqsakSWRyovX7HZrX5QwLlnZnzvq
	 zBplg3nRnC6NEmKD4QnTvtrk2ivYL05m3y2x2/0XIvWlEcCPfwqW9kZ0JJIxiAw5poI/K
	 JTqCwfK51zwoYAJXoGUPuI4Sshk+GYAWr92YZBDWT14sf8HHDlELckX8M+xcTTFWXow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792983593;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gY2M4rmGZhMmNpZv7+DLkgBs4khIBBMg0iVQdOwfl6U=;
	b=1VJhzyng6aYXlZToSIkRvOxa2wQlbUuK1TVR4U3qJK1arqOnBQA2FyNDU3kg9ss8/ZOL
	 8RScTvbx+kFr1OGfNUe2aiUEoWL/hEje18/2Y7rB7GeblIl6NYr3iFtQ6OjFrsvPboJvH
	 6LGV1MkqGz8mbK0ccrtF7bAe/rV82i8wj+k5K6o0MN2TfCu1LWd/mOzF8cmhWq6ejljH1
	 P62OV2x+UtSA5Zx2SUyYTGn1GRlZicII2nHAtA8wLRUOeLlVvgYviLpSPwWgsQgx82ukd
	 sxFwYIWjD1xdwUoAWflyW6Kl3YZxSSIjG+NkH6HXuG2p2H7rASbxFAPEfSB5qocNsXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dk46IrPa;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8223606A31E
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 02:59:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8223606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dk46IrPa
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3adf5f6833cso646173a91.0
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 19:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792983592; x=1793588392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gY2M4rmGZhMmNpZv7+DLkgBs4khIBBMg0iVQdOwfl6U=;
        b=dk46IrPaJn49TMX9G0xghv7Fn3fDKBe+GAhC38egMfypfrfdP9vfrlIfQot1ArUSKc
         GN5w1lZOqN873Z2vX3vgzv4+/K1or/cSUmI9XIGSHP0BbSVsOom6Tszwh0fSLIPFahfd
         +an14s6YjTKLdu1dSlzA9nJEchFTGh9j7gsxgTDWfXyVrJMtmzZLZP+/CzwtLOEUSp5y
         RJz8hXng0YQT7CDUTjjMPNgWHzCPoYv94TgpC4kt6TbpUZQna1yKaHlbIS9b5/xScmx0
         E/62LsbJUpJSozXLP3WxkEGcag59yEUiYM67NPVca6StoD/wzIQ6X2bnddq3mIFYAax6
         ZlOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792983592; x=1793588392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gY2M4rmGZhMmNpZv7+DLkgBs4khIBBMg0iVQdOwfl6U=;
        b=bDp7qcN4MfDtwhcGmHehg7coNZGPzrYivXEgDgkS6XVuxy3od6smMR+jyQo7FTnYav
         gw2vKCA8fWQRBp2m+HkG86civOKFADX85HOz6u3HZNlUmwsnC3OwYEZhmVhz6ABaHEUh
         mW8HF+nNdA8OMiE9E+CgLwQxpSInNlBkEXyzDA/6uAAaxZA1t+P8pYfF2ZmdhZ+6paD8
         fRay9NwrF5YmvIqSF46RvQzVw5UepSjjj4BZdurai96Js84b7JgEmZ2lotHB0TZ3MSsM
         hJzaQnuPt/2oqY8TniZNF0wVJXyODklWF6VTe6VLlLUnuf295vN9KkM6XYBFRQXd7KNx
         lfXw==
X-Gm-Message-State: AFq9FYJM9lT5c6t3MsFPhOsoNCBu7j3l08YeeNN85WixI4juROXbczTE
	4oqlQWITsK8hK2+uOYYBjZ5OZ33xBNjBerDp+6/vMd2DW8QL7S01sMh61uEWDQ==
X-Gm-Gg: AYBFou2yRM5MsHKn2Jm+7LNGqPPvbkXh3IhFnO5tqOHRGJ/Jt37yeyTNBZTwKcOR8HU
	Os8Ptk/ahQhpaWDolrDGrR+ltx/f44Ccx/qMfwwi0BL16ChKrDSj5VJP08/jdV+f0CsZa+5CurF
	OWubp2CgA1321zAo+d6jnIYd3AeCEwpKOWBZGJUC+lAfBLjxaNXQ7hD5n3y/ZaDsm/i5f++MwEk
	5Qrna8O037gq+wSf7DNREL3e2fbSOgrbM5g636J6E9p9Czwf4LUtE/8TnUXoNrzhwDmu2AQ9o4w
	UuR45XKKxx2HwPfBtzjtcwRz3l5ttR7VTC0ZoyefBV9lsA/TG/TYM79KwdPT+iVlhYbaOhLYneO
	jgpLwDn2n86qamYhGB9RHWA/dELbOBVMvKbRsNlhkNCVb/EZx8QMwtuWXHpmKabfHnLjny2DPed
	su3jbpunMFSiXp/hGDQn5O4uAUbTzqwzJ8Kx8Z7eM/IkKaiTeiqRL7TJt0BLHNzoTJ3WBwMGvyF
	5nPGFzdwy/VrrQ8R7pkSPc8rGWFALNeqJZdSmns0z/jTUIjW7WND+egpAC9wRXPEAE3ih0ex0CC
	K3Dj1TBPvvLJTork9b7SOIcQ/WdeS21rDN6b85ZDUS6PyWdZE2DeKMT8wHDRBrvSZhlB5KHu2gy
	9Z/Hakt1BX6HVTczp5OdMpDi4
X-Received: by 2002:a17:90b:4a4f:b0:3ad:4a8b:c6fd with SMTP id 98e67ed59e1d1-3adeabe5366mr4233148a91.28.1792983591818;
        Sun, 25 Oct 2026 19:59:51 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebb27a1bsm6385448a91.15.2026.10.25.19.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 19:59:51 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 01/81] selftests/bpf: Remove tests for global data in arena
Date: Mon, 26 Oct 2026 02:58:22 +0000
Message-ID: <20261026025943.404450-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
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

The .arena.data section and the BPF_F_ARENA_SCALAR flag let a prog in Rust
keep its global data in arena. The subsequent patches remove the two,
because the compiler can do this work. First remove the tests for
.arena.data.

One of the tests is a prog in Rust. It has no replacement, because LLVM
does not put the globals of Rust in arena at this time. No other selftest
is in Rust. Thus also remove the makefile rules that build Rust.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/Makefile          |  12 +-
 .../testing/selftests/bpf/Makefile.buildvars  |  25 --
 tools/testing/selftests/bpf/Makefile.skel     |  18 +-
 .../selftests/bpf/prog_tests/data_in_arena.c  | 216 ------------------
 .../selftests/bpf/progs/data_in_arena.c       | 112 ---------
 .../selftests/bpf/progs/data_in_arena_decl.c  |  37 ---
 .../bpf/progs/data_in_arena_extern.c          |  20 --
 .../selftests/bpf/progs/data_in_arena_fail.c  |  20 --
 .../selftests/bpf/progs/data_in_arena_nomap.c |  20 --
 .../selftests/bpf/progs/data_in_arena_rust.rs |  73 ------
 10 files changed, 2 insertions(+), 551 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/prog_tests/data_in_arena.c
 delete mode 100644 tools/testing/selftests/bpf/progs/data_in_arena.c
 delete mode 100644 tools/testing/selftests/bpf/progs/data_in_arena_decl.c
 delete mode 100644 tools/testing/selftests/bpf/progs/data_in_arena_extern.c
 delete mode 100644 tools/testing/selftests/bpf/progs/data_in_arena_fail.c
 delete mode 100644 tools/testing/selftests/bpf/progs/data_in_arena_nomap.c
 delete mode 100644 tools/testing/selftests/bpf/progs/data_in_arena_rust.rs

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 1e4af62e8312..c99e0f623e10 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -423,16 +423,6 @@ $(LIBARENA_ASAN_SKEL): $(INCLUDE_DIR)/vmlinux.h $(BPFOBJ) $(LIBARENA_BPF_DEPS)
 	+$(MAKE) -C libarena libarena_asan.skel.h $(LIBARENA_MAKE_ARGS)
 endif
 
-# #![no_std] looks for compiler_builtins too. Nothing of it is used.
-ifneq ($(RUST_CORE),)
-$(RUST_CORE): $(RUST_CORE_SRC)
-	$(call msg,RUSTC,,$@)
-	$(Q)mkdir -p $(@D)
-	+$(Q)$(RUSTC_BPF) -A warnings --edition 2024 --crate-name core --out-dir $(@D) $<
-	+$(Q)echo '#![feature(compiler_builtins)] #![compiler_builtins] #![no_std]' | \
-		$(RUSTC_BPF) -A warnings --crate-name compiler_builtins --out-dir $(@D) -
-endif
-
 # Generated test list headers
 
 define gen_tests_hdr
@@ -468,7 +458,7 @@ RUNNER_PREREQS := $(INCLUDE_DIR)/vmlinux.h $(BPFOBJ) $(BPFTOOL)		\
 		  $(VERIFY_SIG_HDR) $(PRIVATE_KEY) $(VERIFICATION_CERT)	\
 		  $(LIBARENA_SKEL) $(LIBARENA_ASAN_SKEL)		\
 		  prog_tests/tests.h map_tests/tests.h			\
-		  $(RUNNER_OBJS) $(RUST_CORE)
+		  $(RUNNER_OBJS)
 
 # Runtime fixtures for each test_progs flavor.
 RUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read				\
diff --git a/tools/testing/selftests/bpf/Makefile.buildvars b/tools/testing/selftests/bpf/Makefile.buildvars
index ff3476bc40a4..d2a0c0031b87 100644
--- a/tools/testing/selftests/bpf/Makefile.buildvars
+++ b/tools/testing/selftests/bpf/Makefile.buildvars
@@ -109,31 +109,6 @@ HOST_INCLUDE_DIR	:= $(INCLUDE_DIR)
 endif
 RESOLVE_BTFIDS := $(HOST_BUILD_DIR)/resolve_btfids/resolve_btfids
 
-# Programs in Rust are built by upstream rustc. It has no prebuilt core for
-# the bpf target, so it has to come with the source of core:
-#   rustup component add rust-src
-# core is built as edition 2024, which it is since rustc 1.87.
-# rustc emits LLVM bitcode and clang makes the object of it, so clang has to be
-# 23 or newer and not older than LLVM of rustc.
-# Otherwise RUST_CORE is empty and the tests are skipped.
-RUSTC ?= rustc
-RUST_CORE_SRC := $(wildcard $(shell $(RUSTC) --print sysroot 2>/dev/null)$\
-			    /lib/rustlib/src/rust/library/core/src/lib.rs)
-ifneq ($(RUST_CORE_SRC),)
-ifeq ($(shell { clang=$$(echo __clang_major__ | $(CLANG) -E -P -x c -) &&		\
-		llvm=$$($(srctree)/scripts/rustc-llvm-version.sh $(RUSTC)) &&		\
-		[ $$($(srctree)/scripts/rustc-version.sh $(RUSTC)) -ge 108700 ] &&	\
-		[ $$clang -ge 23 ] && [ $$clang -ge $$((llvm / 10000)) ]; }		\
-		2>/dev/null && echo y),y)
-RUST_CORE := $(BUILD_DIR)/rust/libcore.rlib
-endif
-endif
-# RUSTC_BOOTSTRAP=1 is to build core with a stable rustc, like the kernel does.
-# panic=abort is a stop gap until panic=unwind is supported.
-RUSTC_BPF = RUSTC_BOOTSTRAP=1 $(RUSTC) -O -C panic=abort --crate-type rlib	\
-	    --target $(if $(IS_LITTLE_ENDIAN),bpfel,bpfeb)-unknown-none		\
-	    -L $(dir $(RUST_CORE))
-
 DEFAULT_BPFTOOL := $(HOST_SCRATCH_DIR)/sbin/bpftool
 ifneq ($(CROSS_COMPILE),)
 CROSS_BPFTOOL := $(SCRATCH_DIR)/sbin/bpftool
diff --git a/tools/testing/selftests/bpf/Makefile.skel b/tools/testing/selftests/bpf/Makefile.skel
index 6570c48f92b0..e8699903feef 100644
--- a/tools/testing/selftests/bpf/Makefile.skel
+++ b/tools/testing/selftests/bpf/Makefile.skel
@@ -20,8 +20,7 @@ ifneq ($(BPF_CC),)
 BPF_SRCS := $(notdir $(wildcard progs/*.c))
 BPF_OBJS := $(patsubst %.c,$(RDIR)/%.bpf.o,$(BPF_SRCS))
 
-SKEL_BLACKLIST := btf__% test_pinning_invalid.c test_sk_assign.c	\
-		  data_in_arena_extern.c data_in_arena_nomap.c
+SKEL_BLACKLIST := btf__% test_pinning_invalid.c test_sk_assign.c
 
 LINKED_SKELS := test_static_linked.skel.h linked_funcs.skel.h		\
 		linked_vars.skel.h linked_maps.skel.h linked_arena.skel.h \
@@ -138,21 +137,6 @@ $(LINKED_SKELS_H): $(RDIR)/%.skel.h: $$(addprefix $(RDIR)/,$$($$*.skel.h-deps))
 		   $(BPFTOOL) $(GEN_SKEL) | $(RDIR)
 	$(Q)$(cmd_bpf_link_skel)
 
-# Programs in Rust, see Makefile.buildvars. No skeletons: the objects may be absent.
-ifneq ($(RUST_CORE),)
-ifeq ($(BPF_CC),$(CLANG))
-RUST_OBJS := $(patsubst progs/%.rs,$(RDIR)/%.bpf.o,$(wildcard progs/*.rs))
-BPF_OBJS += $(RUST_OBJS)
-
-$(RUST_OBJS): $(RDIR)/%.bpf.o: progs/%.rs $(RUST_CORE) | $(RDIR)
-	$(call msg,RUSTC,$(BINARY),$@)
-	+$(Q)$(RUSTC_BPF) --edition 2021 -C debuginfo=2 --emit=llvm-bc			\
-		$(patsubst -mcpu=%,-C target-cpu=%,$(filter -mcpu=%,$(BPF_CC_FLAGS)))	\
-		-o $(dir $(RUST_CORE))$(BINARY)-$*.bc $< &&				\
-	$(BPF_CC) $(BPF_CC_FLAGS) -c $(dir $(RUST_CORE))$(BINARY)-$*.bc -o $@ $(call skip_on_fail,BPF)
-endif
-endif
-
 # Programs in C++. No skeletons: gcc doesn't build them.
 ifeq ($(BPF_CC),$(CLANG))
 CXX_OBJS := $(patsubst progs/%.cpp,$(RDIR)/%.bpf.o,$(wildcard progs/*.cpp))
diff --git a/tools/testing/selftests/bpf/prog_tests/data_in_arena.c b/tools/testing/selftests/bpf/prog_tests/data_in_arena.c
deleted file mode 100644
index cb1023507c01..000000000000
--- a/tools/testing/selftests/bpf/prog_tests/data_in_arena.c
+++ /dev/null
@@ -1,216 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include <test_progs.h>
-#include "data_in_arena.skel.h"
-#include "data_in_arena_decl.skel.h"
-#include "data_in_arena_fail.skel.h"
-
-static int run_prog(struct bpf_program *prog)
-{
-	LIBBPF_OPTS(bpf_test_run_opts, topts);
-
-	if (!ASSERT_OK(bpf_prog_test_run_opts(bpf_program__fd(prog), &topts), "test_run"))
-		return -1;
-	return topts.retval;
-}
-
-static void run(struct data_in_arena *skel, int counter)
-{
-	int i;
-
-	ASSERT_EQ(run_prog(skel->progs.use_data), counter + 7 + 1 + 2, "retval");
-	ASSERT_EQ(skel->bss->sum, counter + 7 + 1 + 2, "sum");
-	ASSERT_EQ(skel->data->counter, counter + 1, "counter");
-	ASSERT_EQ(skel->data->pair[1], 5, "pair[1]");
-	for (i = 0; i < 4; i++)
-		ASSERT_EQ(skel->bss->table[i], 10 * (i + 1) + i, "table");
-}
-
-static void test_in_arena(void)
-{
-	struct bpf_map_info info = {};
-	struct data_in_arena *skel;
-	__u32 len = sizeof(info);
-	struct bpf_map *arena;
-	size_t sz;
-
-	skel = data_in_arena__open();
-	if (!ASSERT_OK_PTR(skel, "open"))
-		return;
-
-	arena = bpf_object__find_map_by_name(skel->obj, "arena");
-	if (!ASSERT_OK_PTR(arena, "arena"))
-		goto out;
-	ASSERT_EQ(bpf_map__type(arena), BPF_MAP_TYPE_ARENA, "arena type");
-	ASSERT_EQ(bpf_map__max_entries(arena), 1, "arena pages");
-	ASSERT_OK(bpf_map__set_max_entries(arena, 8), "arena resize");
-	ASSERT_FALSE(bpf_map__autocreate(skel->maps.data), "data autocreate");
-	ASSERT_FALSE(bpf_map__autocreate(skel->maps.bss), "bss autocreate");
-	ASSERT_FALSE(bpf_map__autocreate(skel->maps.rodata), "rodata autocreate");
-	ASSERT_EQ(bpf_map__set_autocreate(skel->maps.data, true), -EOPNOTSUPP, "set_autocreate");
-	ASSERT_EQ(bpf_map__set_value_size(skel->maps.bss, 4096), -EOPNOTSUPP, "set_value_size");
-	ASSERT_EQ(bpf_map__initial_value(skel->maps.data, &sz), skel->data, "initial_value");
-	ASSERT_EQ(sz, sizeof(*skel->data), "initial_value size");
-
-	/* initial values are set the usual way */
-	skel->data->counter = 100;
-
-	if (!ASSERT_OK(data_in_arena__load(skel), "load"))
-		goto out;
-	/* there are no maps behind the sections */
-	ASSERT_ERR(bpf_map_get_info_by_fd(bpf_map__fd(skel->maps.data), &info, &len), "data map");
-	ASSERT_ERR(bpf_map_get_info_by_fd(bpf_map__fd(skel->maps.bss), &info, &len), "bss map");
-	ASSERT_ERR(bpf_map_get_info_by_fd(bpf_map__fd(skel->maps.rodata), &info, &len),
-		   "rodata map");
-	run(skel, 100);
-
-	/* pointers to data next to pointers to functions */
-	ASSERT_EQ(run_prog(skel->progs.use_ops), 42 + 1 + 'e', "use_ops");
-	ASSERT_EQ(skel->data->counter, 102, "counter");
-
-	/* alignment of sections and pointers to data in data */
-	ASSERT_EQ((unsigned long)&skel->bss->aligned64 % 64, 0, "alignment");
-	ASSERT_EQ(run_prog(skel->progs.use_ptrs), 0, "use_ptrs");
-	ASSERT_EQ(skel->data->x, 43, "x");
-	ASSERT_EQ(skel->bss->aligned64.v[7], 7, "aligned64");
-	ASSERT_EQ(skel->data->px, &skel->data->x, "px");
-
-	/* format strings of bpf_printk() and BPF_SNPRINTF() */
-	ASSERT_EQ(run_prog(skel->progs.use_printk), sizeof("43-7"), "use_printk");
-	ASSERT_STREQ(skel->bss->out, "43-7", "out");
-out:
-	data_in_arena__destroy(skel);
-}
-
-/* The object has an arena map and __arena variables */
-static void test_declared_arena(void)
-{
-	struct data_in_arena_decl *skel;
-	struct bpf_map *map;
-	int arenas = 0;
-
-	skel = data_in_arena_decl__open();
-	if (!ASSERT_OK_PTR(skel, "open"))
-		return;
-	bpf_object__for_each_map(map, skel->obj)
-		arenas += bpf_map__type(map) == BPF_MAP_TYPE_ARENA;
-	ASSERT_EQ(arenas, 1, "no second arena");
-	skel->data->counter = 6;
-	if (!ASSERT_OK(data_in_arena_decl__load(skel), "load"))
-		goto out;
-	ASSERT_EQ(run_prog(skel->progs.use_data), 6 + 7 + 11, "retval");
-	ASSERT_EQ(run_prog(skel->progs.use_data), 7 + 7 + 12, "retval");
-	ASSERT_EQ(skel->bss->sum, 7 + 7 + 12, "sum");
-	ASSERT_EQ(skel->data->counter, 8, "counter");
-out:
-	data_in_arena_decl__destroy(skel);
-}
-
-/* A pointer in data that can't be made an address of arena fails the load */
-static void test_ptr_to_map(void)
-{
-	struct data_in_arena_fail *skel;
-
-	skel = data_in_arena_fail__open();
-	if (!ASSERT_OK_PTR(skel, "open"))
-		return;
-	ASSERT_ERR(data_in_arena_fail__load(skel), "load");
-	data_in_arena_fail__destroy(skel);
-}
-
-/* So does a pointer to a variable of the kernel. There is no skeleton: the open fails. */
-static void test_ptr_to_extern(void)
-{
-	struct bpf_object *obj;
-
-	obj = bpf_object__open_file("./data_in_arena_extern.bpf.o", NULL);
-	if (!ASSERT_ERR_PTR(obj, "open"))
-		bpf_object__close(obj);
-}
-
-/* __arena variables and no arena map. There is no skeleton: the open fails. */
-static void test_arena_var_no_map(void)
-{
-	struct bpf_object *obj;
-
-	obj = bpf_object__open_file("./data_in_arena_nomap.bpf.o", NULL);
-	if (!ASSERT_ERR_PTR(obj, "open"))
-		bpf_object__close(obj);
-}
-
-/* The address of an arena that libbpf doesn't create is not known. No pointers in data then. */
-static void test_not_my_arena(bool pin)
-{
-	LIBBPF_OPTS(bpf_map_create_opts, opts, .map_flags = BPF_F_MMAPABLE);
-	struct data_in_arena *skel;
-	struct bpf_map *arena;
-	int fd = -1;
-
-	skel = data_in_arena__open();
-	if (!ASSERT_OK_PTR(skel, "open"))
-		return;
-	arena = bpf_object__find_map_by_name(skel->obj, "arena");
-	if (!ASSERT_OK_PTR(arena, "arena"))
-		goto out;
-	if (pin) {
-		ASSERT_OK(bpf_map__set_pin_path(arena, "/sys/fs/bpf/data_in_arena"), "pin_path");
-	} else {
-		fd = bpf_map_create(BPF_MAP_TYPE_ARENA, "arena", 0, 0, 1, &opts);
-		if (!ASSERT_GE(fd, 0, "map_create"))
-			goto out;
-		ASSERT_OK(bpf_map__reuse_fd(arena, fd), "reuse_fd");
-	}
-	ASSERT_EQ(data_in_arena__load(skel), -ENOTSUP, "load");
-out:
-	if (fd >= 0)
-		close(fd);
-	data_in_arena__destroy(skel);
-}
-
-/* The object is there if rustc and clang can build it, see Makefile.buildvars */
-static void test_rust(void)
-{
-	const char *file = "./data_in_arena_rust.bpf.o";
-	struct bpf_object *obj;
-
-	if (access(file, R_OK)) {
-		test__skip();
-		return;
-	}
-	obj = bpf_object__open_file(file, NULL);
-	if (!ASSERT_OK_PTR(obj, "open"))
-		return;
-	if (!ASSERT_OK(bpf_object__load(obj), "load"))
-		goto out;
-	/* libbpf goes on without BTF when the kernel doesn't take it */
-	ASSERT_GE(bpf_object__btf_fd(obj), 0, "btf_fd");
-	ASSERT_EQ(run_prog(bpf_object__find_program_by_name(obj, "list_in_data")),
-		  100 + 20 + 3, "retval");
-out:
-	bpf_object__close(obj);
-}
-
-void test_data_in_arena(void)
-{
-#if !defined(__x86_64__) && !defined(__aarch64__)
-	/* other JITs don't take BPF_F_ARENA_SCALAR */
-	test__skip();
-	return;
-#endif
-	if (test__start_subtest("arena"))
-		test_in_arena();
-	if (test__start_subtest("declared_arena"))
-		test_declared_arena();
-	if (test__start_subtest("ptr_to_map"))
-		test_ptr_to_map();
-	if (test__start_subtest("ptr_to_extern"))
-		test_ptr_to_extern();
-	if (test__start_subtest("arena_var_no_map"))
-		test_arena_var_no_map();
-	if (test__start_subtest("pinned_arena"))
-		test_not_my_arena(true);
-	if (test__start_subtest("reused_arena"))
-		test_not_my_arena(false);
-	if (test__start_subtest("rust"))
-		test_rust();
-}
diff --git a/tools/testing/selftests/bpf/progs/data_in_arena.c b/tools/testing/selftests/bpf/progs/data_in_arena.c
deleted file mode 100644
index 18f38103c0fc..000000000000
--- a/tools/testing/selftests/bpf/progs/data_in_arena.c
+++ /dev/null
@@ -1,112 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include <linux/bpf.h>
-#include <bpf/bpf_helpers.h>
-
-/* global data of the object is in arena */
-char data_in_arena SEC(".arena.data");
-
-int counter = 5;
-long pair[2] = { 1, 2 };
-int x = 42;
-long sum;
-long table[4];
-struct {
-	long v[8];
-} aligned64 __attribute__((aligned(64)));
-const volatile int ro = 7;
-const volatile long ro_table[4] = { 10, 20, 30, 40 };
-
-/* const strings stay in a map for helpers and kfuncs, a copy of them is in arena */
-const char hello[] SEC(".rodata.str.hello") = "hello";
-
-/* pointers to data that are stored in data */
-int *px = &x;
-const char *str = hello;
-int *const volatile cpx SEC(".data.rel.ro") = &x;
-
-SEC("syscall")
-int use_data(void *ctx)
-{
-	int i;
-
-	for (i = 0; i < 4; i++)
-		table[i] = ro_table[i] + i;
-	sum = counter + ro + pair[0] + pair[1];
-	counter++;
-	__sync_fetch_and_add(&pair[1], 3);
-	return sum;
-}
-
-typedef int (*op_fn)(int);
-
-static __noinline int add1(int v)
-{
-	return v + 1;
-}
-
-/*
- * Pointers to functions and to data in read-only data of a program with callx.
- * Volatile, so that the compiler doesn't replace the pointers with what
- * they point to.
- */
-static const volatile struct {
-	op_fn fn;
-	int *data;
-	const char *name;
-} ops SEC(".data.rel.ro") = { add1, &x, hello };
-
-SEC("syscall")
-int use_ops(void *ctx)
-{
-	/* a program has the arena when its code refers to it */
-	counter++;
-#ifdef __clang__
-	return ops.fn(*ops.data) + ops.name[1];
-#else
-	/* gcc doesn't support indirect calls */
-	return add1(*ops.data) + ops.name[1];
-#endif
-}
-
-SEC("syscall")
-int use_ptrs(void *ctx)
-{
-	unsigned long addr = (unsigned long)&aligned64;
-	char local[4] = "abc";
-
-	/* hide the address from the compiler, it knows that '& 63' is 0 */
-	asm volatile ("" : "+r"(addr));
-	if (addr & 63)
-		return 1;
-	aligned64.v[7] = 7;
-	if (*px != 42)
-		return 2;
-	*px = 43;
-	if (x != 43 || *cpx != 43)
-		return 3;
-	if (str[0] != 'h' || str[4] != 'o' || str[5])
-		return 4;
-	/* the literal is in a map */
-	if (bpf_strncmp(local, sizeof(local), "abc"))
-		return 5;
-	return 0;
-}
-
-char out[16];
-
-/* format strings are in a map */
-SEC("syscall")
-int use_printk(void *ctx)
-{
-	char buf[sizeof(out)];
-	int i, n;
-
-	bpf_printk("counter %d", counter);
-	n = BPF_SNPRINTF(buf, sizeof(buf), "%d-%d", x, ro);
-	for (i = 0; i < sizeof(out); i++)
-		out[i] = buf[i];
-	return n;
-}
-
-char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/data_in_arena_decl.c b/tools/testing/selftests/bpf/progs/data_in_arena_decl.c
deleted file mode 100644
index 01bc4fea8f0c..000000000000
--- a/tools/testing/selftests/bpf/progs/data_in_arena_decl.c
+++ /dev/null
@@ -1,37 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#define BPF_NO_KFUNC_PROTOTYPES
-#include <vmlinux.h>
-#include <bpf/bpf_helpers.h>
-#include "bpf_experimental.h"
-#include <bpf_arena_common.h>
-
-struct {
-	__uint(type, BPF_MAP_TYPE_ARENA);
-	__uint(map_flags, BPF_F_MMAPABLE);
-	__uint(max_entries, 4);
-} arena SEC(".maps");
-
-/* global data of the object is in arena */
-char data_in_arena SEC(".arena.data");
-
-int counter = 5;
-long sum;
-const volatile int ro = 7;
-
-#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
-int __arena avar = 11;
-#else
-int avar = 11;
-#endif
-
-SEC("syscall")
-int use_data(void *ctx)
-{
-	sum = counter + ro + avar;
-	counter++;
-	avar++;
-	return sum;
-}
-
-char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/data_in_arena_extern.c b/tools/testing/selftests/bpf/progs/data_in_arena_extern.c
deleted file mode 100644
index dc1ad5ca3bdd..000000000000
--- a/tools/testing/selftests/bpf/progs/data_in_arena_extern.c
+++ /dev/null
@@ -1,20 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include <linux/bpf.h>
-#include <bpf/bpf_helpers.h>
-
-/* global data of the object is in arena */
-char data_in_arena SEC(".arena.data");
-
-extern const int bpf_prog_active __ksym;
-
-/* the variable of the kernel is not in arena */
-const void *kp = &bpf_prog_active;
-
-SEC("syscall")
-int ptr_to_extern(void *ctx)
-{
-	return *(int *)kp;
-}
-
-char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/data_in_arena_fail.c b/tools/testing/selftests/bpf/progs/data_in_arena_fail.c
deleted file mode 100644
index ad8afe9afc96..000000000000
--- a/tools/testing/selftests/bpf/progs/data_in_arena_fail.c
+++ /dev/null
@@ -1,20 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include <linux/bpf.h>
-#include <bpf/bpf_helpers.h>
-
-/* global data of the object is in arena */
-char data_in_arena SEC(".arena.data");
-
-int x = 42;
-/* the table is read-only data with pointers. It's not in arena. */
-int *const volatile tbl[1] SEC(".data.rel.ro") = { &x };
-int *const volatile *pp = tbl;
-
-SEC("syscall")
-int ptr_to_map(void *ctx)
-{
-	return **pp;
-}
-
-char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/data_in_arena_nomap.c b/tools/testing/selftests/bpf/progs/data_in_arena_nomap.c
deleted file mode 100644
index ccf66321eb36..000000000000
--- a/tools/testing/selftests/bpf/progs/data_in_arena_nomap.c
+++ /dev/null
@@ -1,20 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include <vmlinux.h>
-#include <bpf/bpf_helpers.h>
-#include "bpf_arena_common.h"
-
-/* global data of the object is in arena */
-char data_in_arena SEC(".arena.data");
-
-int counter = 5;
-/* needs an arena map that is declared. The one that libbpf creates won't do. */
-int __arena_global avar = 11;
-
-SEC("syscall")
-int arena_var(void *ctx)
-{
-	return avar + counter;
-}
-
-char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/data_in_arena_rust.rs b/tools/testing/selftests/bpf/progs/data_in_arena_rust.rs
deleted file mode 100644
index 3dd9d4208232..000000000000
--- a/tools/testing/selftests/bpf/progs/data_in_arena_rust.rs
+++ /dev/null
@@ -1,73 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-// Why .data, .bss and .rodata of a program in Rust are in arena.
-//
-// A reference in Rust is an address. It doesn't say what it points to and it
-// can be stored in data. The list below has a node in each of the sections.
-// The nodes are linked by references that are in the data:
-//   IN_BSS.next is stored by the program,
-//   IN_DATA.next is a relocation in .data against .rodata.
-// sum() loads the references back and reads the three nodes with the same insn.
-//
-// When the sections are array maps libbpf skips the relocation in .data, and
-// what sum() loads from a node is a number that can't be dereferenced:
-//   R1 invalid mem access 'scalar'
-// In arena the address of a node is a number to begin with.
-
-#![no_std]
-#![no_main]
-
-// Tell libbpf to keep .data, .bss and .rodata in arena.
-#[used]
-#[link_section = ".arena.data"]
-static DATA_IN_ARENA: u8 = 0;
-
-#[used]
-#[link_section = "license"]
-static LICENSE: [u8; 4] = *b"GPL\0";
-
-// panic=abort is a stop gap until panic=unwind is supported.
-// Nothing here panics, so the handler is not a part of the program.
-#[panic_handler]
-fn panic(_info: &core::panic::PanicInfo) -> ! {
-    loop {}
-}
-
-pub struct Node {
-    val: u32,
-    next: Option<&'static Node>,
-}
-
-// no_mangle makes them visible outside, so LLVM can't fold the list into a constant.
-#[no_mangle]
-static IN_RODATA: Node = Node { val: 3, next: None };
-#[no_mangle]
-static mut IN_DATA: Node = Node {
-    val: 20,
-    next: Some(&IN_RODATA),
-};
-#[no_mangle]
-static mut IN_BSS: Node = Node { val: 0, next: None };
-
-#[inline(never)]
-fn sum(mut node: Option<&Node>) -> u32 {
-    let mut sum = 0;
-    // The verifier wants a bound.
-    for _ in 0..8 {
-        let Some(n) = node else { break };
-        sum += n.val;
-        node = n.next;
-    }
-    sum
-}
-
-#[no_mangle]
-#[link_section = "syscall"]
-pub extern "C" fn list_in_data(_ctx: *mut u8) -> u32 {
-    unsafe {
-        let head = &mut *&raw mut IN_BSS;
-        head.val = 100;
-        head.next = Some(&*&raw const IN_DATA);
-        sum(Some(head))
-    }
-}
-- 
2.55.0

