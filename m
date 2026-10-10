Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B67282F20
	for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 00:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791593556; cv=none; b=qZ40OtaUfsL48oKEYRaydQf2xaRKfAqGyCnx7JriRl2xn9CupRQQ0EWTDuxyLlMf+nEknxvjcrQN1FYe7YSYXLANTCBCitqNcfdafRopqvaeOgWZ5o3KykYhKbc94qBv3hn8cr6egqI7AajiNmPeTL+66B2rXESeDKvfUyzzo2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791593556; c=relaxed/simple;
	bh=Jsp6LgbTK4cfWWmLeUTZqtKixJIB0Y9Ie/1lUZvCJv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WZMzYbQQsIIFhZDV8dDl12GO1RG9GlRXV4gEX/V+rpN7gLxzoKvVIt6AV/FODnBbbb9lpetwj9JGDEBgGf0haRrvnQeJi5ONcUbi+FE/aHR7hrL1SPjYnnNkpBtTmjlQnIIDDv3JqauHpsEC6kjVFtNe2FBayDhpYAIri9tUWzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alanderk.com; spf=pass smtp.mailfrom=alanderk.com; dkim=pass (2048-bit key) header.d=alanderk.com header.i=@alanderk.com header.b=q+WFkCR9; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alanderk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alanderk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alanderk.com header.i=@alanderk.com header.b="q+WFkCR9"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3ab450c0873so216445a91.3
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 17:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=alanderk.com; s=googol; t=1791593554; x=1792198354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=azgHsYvqsrDkaxXDY0hb9Qx2rxZr9Q0YSKH5ea/vOcw=;
        b=q+WFkCR9Q0N3SfJ53hzM7L+p3nfAcMOQPyfhfsk60XS60HzxgTOS6MHnPOTSvSA4T+
         ot3wHcMyQ9PQdDhu4y7jnoGGObzqmL6UNeFvPA48n8Gvh0Lk71usvpqdJAy5foOsBkV2
         c4occv7lwExxyM5fAgmLK9JA0RIKzZujwhGBOBRSv/f33k+hRHoZdjBS0p/Re7Cljgc4
         Go38huxnrFMtBu93hJAENaxQvORRbBfjEK3qekPwYNAglfgEw/FsEgZ2ifYmeA9u8Ues
         KAlj8yI1xLWnf6esUmLlFnEgdqHgW/a6dcF217DbuCa+6JqUadL41hmd35OjWOUiZcmV
         vNLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791593554; x=1792198354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=azgHsYvqsrDkaxXDY0hb9Qx2rxZr9Q0YSKH5ea/vOcw=;
        b=g2GZfmoA9fgJ16OmlZeklm5CctVbJ6xiRfycXLqMdE+CIVmYQPCcxfiYNMPF6KPSt6
         RTnsUBN0R/Xg8z3AOFHNA7McZ2SRdmCbRc70AvC9/lmdFu845mn+SqNsvSAOSKe5JtxL
         Y8l7gGIFA/lQCLdGjY3aN3rqtQ36KK2b4aQ8sCLmiLPuKp2YQgKWOnraCTUTqaa8nsu2
         c3yx94gDp8YH9ukpM4I8OlehXA+AhlTVumKtTDXoJjNXyL870FSbGz7lfz1iBfLUmJSv
         w8H05Ey86s2zLXMZYxNszQs5nvrLHvkaAVnczZEfQrc7Pq9pBlR9El9QqSYsFP1xGFya
         v4tg==
X-Forwarded-Encrypted: i=1; AKwUvBw2f5rorm8WBTKLfOTtL7Y0gBTiNg04t0x7KfdV8zqx+rziQ/m+IGVh5z2rX/zavtkjvfA=@vger.kernel.org
X-Gm-Message-State: AFq9FYICgGn1L8t1u4KbtDPhSY9ZbjSU+aNdus7wfgtTAQNi1fnc8+A0
	Vj5IDTvKzxQASn5OLHBtDTGzVIl4SKQVfhrKS9bXC0oQ+w6l0/8UhrSHFOBB6q75uNxR8DWYFRm
	wNFDj/49/RIf/
X-Gm-Gg: AYBFou3IlnluVs6FUTANdBwrqFQ5BWnKnDjKAGtOEI1pUcXgsKTSCtKIwY2X7wqp904
	9SwPSFmQZbknuzjAAj2GIIQnZZdlG4+k1ikg06N0vnsuYpu4kT8TQ3w57iZKkprU7LsDaZydopz
	Ow1LMy7XefApjUZG7iWjrKtDmFQnPQ0w3mp5YZXNKVTMm/oiVn+zup9sycw5xgEyxT9YUGh5nnE
	BvYNjLIEj2N/obd8mtBaxlHioyp6tA2zFiRJ6+PZgN+LzGNkAtIZel34r+AD2w0xqTy66EINjVr
	/thwbL8heYrrYxPbeIs2leJfs7MuOGEjsi8Cy3QROBAO+iVfqAyX1VXBBGq/KZkAyId8tFa7n2n
	KTQ21tXI8e7R2VUV9g/+AZgxGnQP/ZrT3QZ4heKUDmpvPxlXJDrFY8J1ij8kabF7S3M8L+I+Zph
	BZSECy89nAx+y4G+8E6dU02+ErAB6ZQb+4cQvuPZB0omR420K0UvHD4aQwKgbNLWHwnc857X2CS
	5EwLyn0MgCCfqBROl/gsRuHaTvtdDIRrA==
X-Received: by 2002:a17:90a:e7ca:b0:3a4:f75d:d194 with SMTP id 98e67ed59e1d1-3ab3a8ce801mr3278439a91.36.1791593554040;
        Fri, 09 Oct 2026 17:52:34 -0700 (PDT)
Received: from macmini4.tapir-palermo.ts.net ([138.199.43.94])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab50ce9d98sm4078226a91.9.2026.10.09.17.52.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 09 Oct 2026 17:52:33 -0700 (PDT)
From: Alan Derk <linux@alanderk.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>
Cc: dwarves@vger.kernel.org,
	bpf@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: [PATCH dwarves v2 1/2] dwarf_loader: Take the merged CU language from a CU that is kept
Date: Sat, 10 Oct 2026 00:52:26 +0000
Message-ID: <20261010005227.976-2-linux@alanderk.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261010005227.976-1-linux@alanderk.com>
References: <20261010005227.976-1-linux@alanderk.com>
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
-- 
2.55.0

