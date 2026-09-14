Received: from mail-wm2-f4.google.com (mail-wm2-f4.google.com [74.125.225.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F9649EC54
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 22:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789424736; cv=none; b=H0sYTbjsvtXl22+6LajOcitzfpqWciRrsA8mT+lscA16pbSrxTXFmaPlUcIZ7L98Q8tlFjA5fpJO/D+e5XNZrpmeOjb475jbRWkKdtDS/L+bpzJw8dHugHIn2mMDi+8Hh7X26zZFX44h3jww1gx+vwnBm3/HTahYVD0zZ5Xhg9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789424736; c=relaxed/simple;
	bh=+ZH7O+QE/HlNHOonGe5p6B4Fi7Mu1PCMZ5D+0U8Uq+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pSHCM/wCKpjdaWXxtCIdMO7wvb4U6JIb/fpyue7sNj9n6urZqWInQmGOT4ZS9542A4X/aCzYZYj1yx6FCkuPr7/Mp+O0wN5bMg3CpFZYu8Zq9b2L1sfvQLlWOdTXW+UJaXSuO39rzrVbqrKP8YO3lM6bPmS0NONN4Zp5zJx5IOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=csrD/FAK; arc=none smtp.client-ip=74.125.225.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="csrD/FAK"
Received: by mail-wm2-f4.google.com with SMTP id 5b1f17b1804b1-49cd71f9909so7216865e9.1
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 15:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789424733; x=1790029533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LIGVSHnsAmrBlhFS/lZWLnpKuKkhloy99KRJsXWm6Dg=;
        b=csrD/FAKyNoydvziDRfp35LpEEZz2Oo5Br1Nv05uUZ1Hli8tuGRrY7mYh+t3SE/rzC
         sw5MMVcZkmSQMiZSQ0gXClMxYYblGZGn13e7v4F2RWKUbN82T5GaSztCxLdXNz9OA24f
         xpP+UG3IoVYnzYb7h6/bDpocL2W58Lul20F6FaM6FzTNVBFjspnB462Xw3Ehud0mNNbw
         PF5PeG+xr1ryo7COtFAqMxq/DFP3A4E13kM+HUiG8P1s+YJ7PrJBKKQZUD+xyI13vcMt
         te/NGic+OFJ//DbDoY3PpIV5OlCQqlKS8nb4weSh9vBDBiTT39rAgwW+2W95hoFQWUpb
         bIsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789424733; x=1790029533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LIGVSHnsAmrBlhFS/lZWLnpKuKkhloy99KRJsXWm6Dg=;
        b=wRFUVg8mduT1M0ZJPrqNmqYhmYNH9P32xI6TSydrr+BOMWTArjwpeSUm09LwP2oRKt
         dAYc/+TfMg8wqswbbcgeLts8EsICB7C3Q2UN5s6t/GCfSjOWUjEQkga6yV00ie/Vg8J3
         vO50BlBEOzxw1uatUUxM55Je9hplM1mGy//90eP5988y0Txo8ew9cGPKNa3tQ0CM0Fnq
         fUN8NZsKiF+CMOHVMdV4PWHTCFnXltgX/gnmmgt40i80EG5DTM+BcHNyyp4u3iRrGz/f
         y+RGL4gvp5xTH/2/2q49zQHsQqoeOHMEqvEo4nZ8jnFrkLGW0TNSVuE6EnBmCBq1VUGY
         Tpbg==
X-Gm-Message-State: AFuF++nlwUmN0A72WeA+L8VLZ6J/dgsl5zZBwqdZrHmy1NW4s/9SAKHO
	+R5OqPbjFRb8tiboWpRMptYIfOwBuy5Z2XweNmGoEEM7OR4svinxYI6JjvcaKU9d8SI=
X-Gm-Gg: AYBFou1S7OvvjlxO0DvF5eaIoSG760AS/j3nDgf+t/PbYeJ0XhRkJiuFCue9OCdtCwJ
	Jy6yPq+Q34CcAtyWQUVestAzEWQm0TYM1VhUAJv5A0WRip557OnoeeR8sZzfeCFGRsdbwQWeZvN
	ZlVx745hKiG3p2DvWiDeazfvSqrJU/THiPaH2tVYae/Gb5sKr6cid0jZx3oo/PO4IYSsCAbvx+R
	XIM3qr2Wh8HAjpAFwVniinxjMsi3Pm5KuBP2L3D/vQCsQEMhDq2/5pJyWHOX7UkZRy6HZ4J3Dx/
	MTOogriLK5Jgh6B9dHbTviLM7eDY4fnF+uFTNVUcg6hWgZhTwgTGB2vA1Pzr7UMXVs2Qwcz9UFd
	a/91tBvLf2ALrhrm8CIr6k9OI5WR+uv+iQNvWeA1+n3Bf64y2veDqb1WZFUh6mESt4sSBSrVFlL
	qTpRz0JCWeFpVG1NoeAVfN9Cz0EjM8Arq5Pv1Jgten/cNDzls2nsDoveCSYejx+tyuKR+IEoaZs
	TgrEF6+FQ5rQufcOzLs58zJ6FIQSvjqZO70p/ohluz0T4nGAz30Kd8StzSnQzaTwIPnFKLKMLHr
	tsfToH6k4S/vpMIkDbUx3DV2z3Tt0quyTk4/Gw==
X-Received: by 2002:a05:600c:3e17:b0:49d:726:cc9f with SMTP id 5b1f17b1804b1-49e7a65e422mr113214335e9.5.1789424733289;
        Mon, 14 Sep 2026 15:25:33 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e7ef2e117sm10271375e9.1.2026.09.14.15.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 15:25:32 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Nicholas Carlini <npc@anthropic.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v4 11/11] selftests/bpf: Add truncated CO-RE ldimm64 test
Date: Tue, 15 Sep 2026 00:25:08 +0200
Message-ID: <20260914222514.1635018-12-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914222514.1635018-1-memxor@gmail.com>
References: <20260914222514.1635018-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4600; i=memxor@gmail.com; h=from:subject; bh=+ZH7O+QE/HlNHOonGe5p6B4Fi7Mu1PCMZ5D+0U8Uq+s=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtFiUGH2kL9Qyl5r67EnPM8vqD3eqqSyKL8524FXBOEg zgUfhd0lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCJV7xj+R+zf5yfwrfbAOt4L gfOM+w9vf7dj0q2bU5kNttt1pWuXfGD4ycj8ZMH6v16Bp25XXJ61KPPizTXX3Nl8P2wXWuucmLF FlhUA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Exercise CO-RE relocation of an ldimm64 instruction whose second slot is
missing. Build a valid BPF object with a compiler-emitted relocation, then
truncate the program symbol to retain only the first instruction slot.

Without bounds validation, libbpf reads or writes beyond the exact-sized
instruction allocation, depending on whether the relocation resolves.
Exercise both paths and require bpf_object__prepare() to reject the
malformed object with a precise diagnostic.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../prog_tests/core_reloc_truncated_ldimm64.c | 82 +++++++++++++++++++
 .../bpf/progs/core_reloc_truncated_ldimm64.c  | 27 ++++++
 2 files changed, 109 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/core_reloc_truncated_ldimm64.c
 create mode 100644 tools/testing/selftests/bpf/progs/core_reloc_truncated_ldimm64.c

diff --git a/tools/testing/selftests/bpf/prog_tests/core_reloc_truncated_ldimm64.c b/tools/testing/selftests/bpf/prog_tests/core_reloc_truncated_ldimm64.c
new file mode 100644
index 000000000000..b70c8874241d
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/core_reloc_truncated_ldimm64.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <elf.h>
+#include <test_progs.h>
+
+#include "core_reloc_truncated_ldimm64.skel.h"
+
+static bool truncate_ldimm64_prog(void *elf_data, size_t elf_sz, const char *prog_name)
+{
+	Elf64_Ehdr *ehdr = elf_data;
+	Elf64_Shdr *shdrs;
+	Elf64_Sym *syms;
+	const char *strs;
+	size_t i, j;
+
+	if (elf_sz < sizeof(*ehdr) || ehdr->e_shoff > elf_sz ||
+	    ehdr->e_shnum > (elf_sz - ehdr->e_shoff) / sizeof(*shdrs))
+		return false;
+
+	shdrs = elf_data + ehdr->e_shoff;
+	for (i = 0; i < ehdr->e_shnum; i++) {
+		if (shdrs[i].sh_type != SHT_SYMTAB)
+			continue;
+		syms = elf_data + shdrs[i].sh_offset;
+		strs = elf_data + shdrs[shdrs[i].sh_link].sh_offset;
+		for (j = 0; j < shdrs[i].sh_size / sizeof(*syms); j++) {
+			if (ELF64_ST_TYPE(syms[j].st_info) == STT_FUNC &&
+			    !strcmp(strs + syms[j].st_name, prog_name)) {
+				syms[j].st_size = sizeof(struct bpf_insn);
+				return true;
+			}
+		}
+	}
+
+	return false;
+}
+
+static void run_test(const char *prog_name)
+{
+	const void *elf_bytes;
+	size_t elf_sz;
+	struct bpf_object *obj = NULL;
+	void *elf_data = NULL;
+	char *log = NULL;
+	int err;
+
+	elf_bytes = core_reloc_truncated_ldimm64__elf_bytes(&elf_sz);
+	if (!ASSERT_OK_PTR(elf_bytes, "elf_bytes"))
+		return;
+
+	elf_data = malloc(elf_sz);
+	if (!ASSERT_OK_PTR(elf_data, "elf_data"))
+		return;
+	memcpy(elf_data, elf_bytes, elf_sz);
+	if (!ASSERT_TRUE(truncate_ldimm64_prog(elf_data, elf_sz, prog_name), "truncate_prog"))
+		goto cleanup;
+
+	obj = bpf_object__open_mem(elf_data, elf_sz, NULL);
+	if (!ASSERT_OK_PTR(obj, "obj_open"))
+		goto cleanup;
+
+	if (start_libbpf_log_capture())
+		goto cleanup;
+	err = bpf_object__prepare(obj);
+	log = stop_libbpf_log_capture();
+	ASSERT_EQ(err, -EINVAL, "obj_prepare");
+	ASSERT_HAS_SUBSTR(log, "insn #0 (LDIMM64) is truncated", "libbpf_log");
+
+cleanup:
+	free(log);
+	bpf_object__close(obj);
+	free(elf_data);
+}
+
+void test_core_reloc_truncated_ldimm64(void)
+{
+	if (test__start_subtest("resolved"))
+		run_test("core_reloc_truncated_ldimm64_resolved");
+	if (test__start_subtest("poison"))
+		run_test("core_reloc_truncated_ldimm64_poison");
+}
diff --git a/tools/testing/selftests/bpf/progs/core_reloc_truncated_ldimm64.c b/tools/testing/selftests/bpf/progs/core_reloc_truncated_ldimm64.c
new file mode 100644
index 000000000000..d8d9a3650fe0
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/core_reloc_truncated_ldimm64.c
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
+
+enum core_reloc_truncated_ldimm64 {
+	CORE_RELOC_TRUNCATED_LDIMM64_VALUE,
+};
+
+SEC("raw_tracepoint/sys_enter")
+int core_reloc_truncated_ldimm64_resolved(void *ctx)
+{
+	return bpf_core_enum_value_exists(enum core_reloc_truncated_ldimm64,
+					  CORE_RELOC_TRUNCATED_LDIMM64_VALUE);
+}
+
+SEC("raw_tracepoint/sys_exit")
+int core_reloc_truncated_ldimm64_poison(void *ctx)
+{
+	return bpf_core_enum_value(enum core_reloc_truncated_ldimm64,
+				   CORE_RELOC_TRUNCATED_LDIMM64_VALUE);
+}
+
+char LICENSE[] SEC("license") = "GPL";
-- 
2.53.0

