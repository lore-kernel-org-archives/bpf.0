Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF13484222
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 20:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791576642; cv=none; b=lM0A6u46xqdE8AFlb2ap8kzi311DtxVfCiZLVQ2uqlLF0dUBGlm6Gak4INX6BR+JzwIITD3p+ITPvHTjkZ0784tCJVWz4XSrNw0fAa0dclGZk9pPwk477kw6FvMWllwW/2LqHplra+bHQ3RI5OmyHKNuHdNgQdUXneQQ9fzx1fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791576642; c=relaxed/simple;
	bh=6uwUDgUGBBegNNw8gBHz6CI975iD/iZ8aoY/QjONSyw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a8bhx79SYh1w3L0WrJ8aa1mBj2IqKTlr+rXjRQpVsdttjeKBS9nljAx7bMrMMQYb57ztIzV7x58ZBKNQjtrNqOFtkmW+SE3q6mkMOhxoXhnyZYONVq1Mju4g5hR5mhjmmE+ZYu43Vps1Vwss3brwePE11qO6Y7md1ilbjmCitNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alanderk.com; spf=pass smtp.mailfrom=alanderk.com; dkim=pass (2048-bit key) header.d=alanderk.com header.i=@alanderk.com header.b=rNxZqfA8; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alanderk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alanderk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alanderk.com header.i=@alanderk.com header.b="rNxZqfA8"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a0213948d3so1215545e9.2
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 13:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=alanderk.com; s=googol; t=1791576638; x=1792181438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EJ+o+4jIxwTH4R8juVBWrHTXbo8gUGBaH8eDaOzMlw0=;
        b=rNxZqfA81EEg4Gxy5IQxSzbbRfKrRQXu3QhgfJwNtm9vC8KHcwxUz9XHxh6J9Vilmp
         i/giZgW05avEKe6q1X+imoohYI5gj+lIXMW0TPjnoluMXqMl8KpZBZ8IS3NuG6EuAozT
         C++sb/Mi9R5FEMZJda07Vi6C1gMF7HyJICpKLFYJywxmANUhd/hA/Kr3Ra2Pz5QNODIa
         jXnntJ09Gx8+iHyhBbx/ZjDBbHo+0J7AyCutp0XYx8IfCkPF/Tp7RTY9RZMkdfYB52vw
         zrNsIaUmduwFWICwVjJc+mbb1GmO5d95C2NY7hs93hD/8dzu9Rb7yukOXUHwCDt75Uzm
         Zd+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791576638; x=1792181438;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EJ+o+4jIxwTH4R8juVBWrHTXbo8gUGBaH8eDaOzMlw0=;
        b=IZhdPWNCm7ZT7e09fUqLuoi/K0daWilCWlK8b49cYRzPLsW/hDLw4c6pwO3iMBGwEu
         t/bJm+K6ZKZ0vo+b6xPLgVNeBDU+/z/kT8iF3w25+SFZ379qTKBV6P5+rE7KdXobScCc
         CX8ULjlWWHCwKaiJMDBQMYYg1xLKDuLPpjX9bORDO+iWWCn7TfJ/DDuyhunhNduMoi8M
         FD3A1UGOIJInEyjmQD0paY8F+jTAXZZb4KanORLpxMUJUbVMD1av5rgu28oe3br25GcV
         /HqJSDNfQg6H0F73qVjyyQlMnZLNktiMkM/HE4e/z4p4FnazvPqsUY+7GXc7qBEYXwJ8
         T8hQ==
X-Forwarded-Encrypted: i=1; AKwUvBz7/vXBsc76pdp5aDPciim4Ba0/QCE8J4jNHr1YLSOHoO/tkJl1kIMPJ4zaHjZF4XOxHqg=@vger.kernel.org
X-Gm-Message-State: AFuF++k4qFZPhlz5/APC9aeNGWNxAGzAJabgjx1n6cI9NW3x16fqX5rB
	ayjjXQb8KrCIv5o5UkMiNDEtwdGe50dNDyfZDbrYKLsOXBquNA20CNiORuB9HvBhhq0=
X-Gm-Gg: AYBFou1mg6rifHcfZ5WWmqI7wped8e7Kt8+Y7HoZ//oWwGp4G2VG1Q6hSR9y7ivYeXo
	xb3HQFWBrDgRgiBbMsrveAKXESV4F+rtwaz7NVm+KhNxYbjMbkP79JRSF6SZfEgUngMScAtpA80
	OnujkgI96+mGXLSeL3BYlZRVkzQgjPRrMYY7/sbweyX82+MVTP9ARNG9xGr+SrWgUZy9A4STty4
	1GPejOhzSJikpgSI+G5C2SmrOUQavmDh6b02gNVDutY6E1GEUtdXL9xUDS6PgzLj0II81rXQFpv
	HgUXv0rwYyMWwKkH5GbkbIJRtDlgpl5bjQNX+u2Hw4EKXZzR46sX+c8UUj3rpXYOQX4uSz2baO3
	ZGvYzNVbbSk6Ub+J7lJZqGUfSJVTT6jySiZCytx5nyuXUcu/+Ekhj+M0+u86CI2031Ri8aKdIFU
	qDBgJvipzkjKaGT4wFJPAnRFYp8nN+2m82iDZ/gWaJH2VPu22sYtSD1h2E77IL7K4Z2AzoBEfts
	zfCeEdNMOTx2DrbH+Y/Z/r8l3gUtWo9sQ==
X-Received: by 2002:a05:600c:4e01:b0:49f:ce78:3567 with SMTP id 5b1f17b1804b1-4a18e4afc3amr55785525e9.24.1791576637412;
        Fri, 09 Oct 2026 13:10:37 -0700 (PDT)
Received: from macmini4.tapir-palermo.ts.net ([138.199.43.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18be8c5e7sm110980415e9.4.2026.10.09.13.10.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 09 Oct 2026 13:10:37 -0700 (PDT)
From: Alan Derk <linux@alanderk.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>
Cc: dwarves@vger.kernel.org,
	bpf@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: [PATCH dwarves] dwarf_loader: Take the merged CU language from a CU that is kept
Date: Fri,  9 Oct 2026 20:10:32 +0000
Message-ID: <20261009201032.40105-1-linux@alanderk.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the CUs of an object are merged, as for clang LTO objects, the
merged CU takes the language of the first CU. Since commit
b98565e7b17ec24d ("dwarf_loader: Honour --lang_exclude when merging LTO
built CUs") the DIEs of excluded CUs are skipped while merging, but
pahole_stealer() then applies the same filter to the merged CU. If the
first CU is in an excluded language, the whole merged CU is dropped,
including the CUs that were kept, and with -J pahole writes no BTF and
still exits 0.

Kernel modules mixing Rust and C hit this in clang LTO builds with
CONFIG_DEBUG_INFO_BTF_MODULES: kbuild passes --lang_exclude=rust, and
the Rust CU comes first in the linked module even when the Rust object
is listed last, as the C objects are bitcode compiled at link time.
scripts/gen-btf.sh then fails, here for a Rust sample module:

  FAILED: load BTF from samples/rust/rust_minimal.ko.BTF.1: No such file or directory

This is what is left of the problem behind kernel commit 5daa0c35a1f0
("rust: Disallow BTF generation with Rust + LTO"), which keeps RUST off
when LTO and BTF are both on. With pahole 1.32 a ThinLTO vmlinux with
Rust built in gets clean BTF, but its Rust modules fail as above, so
that restriction can't be relaxed yet. Distributions with LTO kernels,
such as CachyOS's default kernel, keep BTF for sched_ext and BPF tools
and go without Rust; out-of-tree modules that build their own Rust
objects there hit this today.

Take the merged CU's language from the first CU the filter keeps, and
its producer too, as producer_clang also steers how the merged DIEs are
processed. Run the filter before checking for DIEs, as the unmerged
path does, so that a first CU without DIEs, such as an assembler CU,
still counts and the output without --lang_exclude does not change. If
every CU is filtered out, the merged CU keeps the first CU's language
and is dropped as before.

Before, with a C++ object linked before a C one:

  $ pahole -V --btf_features=force_cu_merging --lang_exclude=c++14 merged.o
  Filtering CU first.cpp written in c++14.
  Filtering CU  written in c++14.

After:

  $ pahole -V --btf_features=force_cu_merging --lang_exclude=c++14 merged.o
  Filtering CU first.cpp written in c++14.
  struct c_only {
  	int                        b;                    /*     0     4 */
  ...

Add tests/lang_exclude_merged_cu.sh for this.

Tested with clang 21 builds of 7.2.9 with RUST enabled: x86_64 with
ThinLTO (DWARF 4 and 5), full LTO and distributed ThinLTO, and arm64
and riscv64 with ThinLTO. The Rust sample modules get BTF and load with
MODULE_ALLOW_BTF_MISMATCH=n, and the BTF of vmlinux and of the C
modules does not change.

Fixes: b98565e7b17ec24d ("dwarf_loader: Honour --lang_exclude when merging LTO built CUs")
Assisted-by: LLM
Signed-off-by: Alan Derk <linux@alanderk.com>
---
As far as I know this is the last thing keeping RUST off when LTO and
BTF are both on. Once it is in a pahole release, I'd like to propose
relaxing the kernel's dependency to something like:

  depends on !DEBUG_INFO_BTF || (PAHOLE_HAS_LANG_EXCLUDE && (!LTO || PAHOLE_VERSION >= 133))

assuming the fix lands in 1.33. The tests above ran with "&& !LTO"
dropped from that line, hence the Cc to rust-for-linux.

Part of the dwarf_loader.c diff is re-indentation; git show -w is easier
to read.

 dwarf_loader.c                  | 34 +++++++++++------
 tests/lang_exclude_merged_cu.sh | 67 +++++++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+), 12 deletions(-)
 create mode 100755 tests/lang_exclude_merged_cu.sh

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 01049e9..fbed36e 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -5329,6 +5329,7 @@ static int cus__merge_and_process_cu(struct cus *cus, struct conf_load *conf,
 	struct dwarf_cu *dcu = NULL;
 	Dwarf_Off off = 0, noff;
 	struct cu *cu = NULL;
+	bool kept_cu = false;
 	size_t cuhl;
 
 	while (dwarf_nextcu(dw, off, &noff, &cuhl, NULL, &pointer_size,
@@ -5441,23 +5442,32 @@ static int cus__merge_and_process_cu(struct cus *cus, struct conf_load *conf,
 			cus__add(cus, cu);
 		}
 
-		Dwarf_Die child;
-		if (dwarf_child(cu_die, &child) == 0) {
-			bool filtered = false;
+		bool filtered = false;
 
-			if (conf->early_cu_filter) {
-				struct cu unmerged_cu = {
-					.name	  = attr_string(cu_die, DW_AT_name, conf),
-					.language = attr_numeric(cu_die, DW_AT_language),
-				};
+		if (conf->early_cu_filter) {
+			struct cu unmerged_cu = {
+				.name	  = attr_string(cu_die, DW_AT_name, conf),
+				.language = attr_numeric(cu_die, DW_AT_language),
+			};
 
-				filtered = conf->early_cu_filter(&unmerged_cu) == NULL;
-			}
+			filtered = conf->early_cu_filter(&unmerged_cu) == NULL;
+		}
 
-			if (!filtered && die__process_unit(&child, cu, conf, 0) != 0)
-				goto out_abort;
+		/*
+		 * pahole filters the merged CU by language again, so it must
+		 * not keep the language of a CU filtered out here.
+		 */
+		if (!filtered && !kept_cu) {
+			cu->language = attr_numeric(cu_die, DW_AT_language);
+			cu->producer_clang = attr_producer_clang(cu_die);
+			kept_cu = true;
 		}
 
+		Dwarf_Die child;
+		if (!filtered && dwarf_child(cu_die, &child) == 0 &&
+		    die__process_unit(&child, cu, conf, 0) != 0)
+			goto out_abort;
+
 		off = noff;
 	}
 
diff --git a/tests/lang_exclude_merged_cu.sh b/tests/lang_exclude_merged_cu.sh
new file mode 100755
index 0000000..507c6ac
--- /dev/null
+++ b/tests/lang_exclude_merged_cu.sh
@@ -0,0 +1,67 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Test --lang_exclude when CUs are merged, as for LTO objects: excluding the
+# language of the first CU must not drop the CUs that follow it.
+
+. "$(dirname "$0")/test_lib.sh"
+outdir=$(make_tmpdir)
+
+trap cleanup EXIT
+
+title_log "Language filtering of merged CUs."
+
+CC=${CC:-gcc}
+CXX=${CXX:-g++}
+LD=${LD:-ld}
+for tool in "$CC" "$CXX" "$LD"; do
+	if ! command -v "${tool%% *}" > /dev/null 2>&1; then
+		info_log "skip: $tool not available"
+		test_skip
+	fi
+done
+
+cat > "$outdir/first.cpp" << 'EOF'
+struct cpp_only {
+	int	a;
+};
+
+struct cpp_only cpp_var;
+EOF
+
+cat > "$outdir/second.c" << 'EOF'
+struct c_only {
+	int	b;
+};
+
+struct c_only c_var;
+EOF
+
+obj="$outdir/merged.o"
+
+if ! $CXX -g -c -o "$outdir/first.o" "$outdir/first.cpp" 2>/dev/null ||
+   ! $CC -g -c -o "$outdir/second.o" "$outdir/second.c" 2>/dev/null ||
+   ! $LD -r -o "$obj" "$outdir/first.o" "$outdir/second.o" 2>/dev/null; then
+	error_log "FAIL: compilation failed"
+	test_fail
+fi
+
+output=$(pahole --btf_features=force_cu_merging -F dwarf "$obj" 2>/dev/null)
+if ! echo "$output" | grep -q "struct cpp_only" ||
+   ! echo "$output" | grep -q "struct c_only"; then
+	error_log "FAIL: merged CU lacks types without --lang_exclude"
+	test_fail
+fi
+
+output=$(pahole --btf_features=force_cu_merging -F dwarf \
+	--lang_exclude=c++,c++03,c++11,c++14 "$obj" 2>/dev/null)
+if echo "$output" | grep -q "struct cpp_only"; then
+	error_log "FAIL: --lang_exclude=c++ kept the C++ CU"
+	test_fail
+fi
+if ! echo "$output" | grep -q "struct c_only"; then
+	error_log "FAIL: --lang_exclude=c++ dropped the C CU merged after it"
+	test_fail
+fi
+
+test_pass

base-commit: 1e342ac44979748bcf5bb37f84ea055e7f4d7184
-- 
2.55.0

