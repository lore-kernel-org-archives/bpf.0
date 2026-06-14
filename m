Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B62D29992A
	for <bpf@vger.kernel.org>; Sun, 14 Jun 2026 05:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781415606; cv=none; b=YZBMfT3Sae0LgDU/KVfoPcTEKQk4N3cQ8VzzcDAAiE7CN4GvXCOBuwnCv174yPPm4p5g9wIAxwvoBIsnDvN+r/qadUCHj5WnF2wFlAQ2KuzdHdi+TlI9HYtcvSP5oH9WiKkE3LExpaNmqX3Bwgcrn3AJHRZbYfNA8DKGP7K710o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781415606; c=relaxed/simple;
	bh=xYkuCVHdPfVL4LS6phd9e7uDx30DaXSEX00b1pg95YA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=muYfsgj6R6awbXXtZJkePZXMzZMoRofE8Mj5zjEuwdKualLrn/3PQkAhcOrw0CgdoqAke8gKvVj75C9PgwTp0BQuF8O+pjw1GdOeRnQZg19lu63gsG6tIuCV1XrKruE7D4yqKSoiMqyFJ3YOUHJpb1ANBa1+08gQBueckinkbcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GYEDKfGk; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYEDKfGk"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-84237c55ef9so1441330b3a.0
        for <bpf@vger.kernel.org>; Sat, 13 Jun 2026 22:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781415605; x=1782020405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bkS4IMnvlVTyKrBWl0mp/SrLhH39RLp4sUhYtNuaaOU=;
        b=GYEDKfGkuIvDL1YfKrzWajDus78mFJMl1Zp0sryRAw3U1WApB49cvZmqyDmOlgp5vr
         pInFh9rTk0z9cEWFzc1Yr3d8zveQc42LmQvqfeUL9pBhVjOhND4xzj26rWzj+Qx1WIZa
         0vsWTFqtQjNIRRlh22WnGtNWQQOrXxEHhXK4HukNU5pxClci7ZVH+tEObvT92oCSGscq
         qVCe6n8jtTXzPGLluJJ1tgCZRvMHdTNBk2cKLpyGkZvvZxw7UIACgNKCCrl9CREOlIS+
         SD6p2cZpR0DMamIhvOvnfRUDei33dQihOJsCHBR/RCOuuJIfTw8uEcIFBvGPgNXr+jZW
         eQeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781415605; x=1782020405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bkS4IMnvlVTyKrBWl0mp/SrLhH39RLp4sUhYtNuaaOU=;
        b=IXXNTGi1T+8xZEM9R7Cxl8YF8m6Ki2d77pLAdRzppxg3zRxwSR4myIbt5Di40IWGUc
         dWmiFhgigO6K1tzp6eIrqUsA9S5Qumj8R78uddb5zXzqeQ5IYBwdfxG8eYu6IW2jzF+I
         enHDQdtOPyUs/7NgF6NkA12GouwjzptNKYq/lPqLY0xl52OOfLp5aZNaXlVHbWZNalbl
         aoKy1wB2YNVjHZmEx+XxHFW+cmQgfTBNtvXp/oAzw9zwARVSEtZZCtwL0Uixle9Vg3N5
         20SZ6sookEKr5yA/Vb3jRdTXPY62OcKpcEsrfzJiu2mJlzg5ah8MjdyffpNa5vTCn+Wa
         HjoA==
X-Forwarded-Encrypted: i=1; AFNElJ9UTUDUxQcTXybDUDG8G5kNJRo9udAJa6rZgdnT0S3o+xtwWfoeddVs1CVCCeVaVuaf748=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyQ+eG7Z4xxP7AKRhaBI+bw1mwq/d6rpxHJJKGGJGpS4Pl9Lru
	M0pLNUKak/pyWJ2g8MEA840WHRBa6SS23Ze9XbzvUiK/jtsMZOpaVsXi
X-Gm-Gg: Acq92OExJkI12N6ZYLOKS5Ddx/yTjVz+eVlNO42lLnbvxnmbiCFr3cI4SOiC+LR2nOY
	xBneJIcDD8k0I31gvmax1vx3Ucs55UXpRFXXC34ZfBboWO3IfC5DeRUqtO+Gq8p8LB4rUF1aEwt
	2oeB9VHyd88Si+08ZTIbRjaA++TFnhoRno5kirQwVa/E7udeXQry7Ent1NR6XtPnUexbcFg0tMg
	2tfX/DpdgU6YC1cw1iDjLRRUIWdxSz06Dv8K0GjTgxFBpoOC+2/8+dVjkZsmfglGw3uG3l02OMg
	co2lYobgkheLhjSF36DNkBNajC/EzouP8VweDcu3Uw8dZ8PYDZGPLbf/SNs6sYWWL81hqGOKYf1
	a+c3nRp+GPEsQBHm57DyQ6XfgHxXjVgte0tRxngn+ObOtJWmQoYIM/pPeBuSqrm/S/8IabRkVaa
	cIzW9kekhYnrc9ZaZMcSVeobgwcvkxEEjngggVTns1dNi2HMnyoU2HU+2YX5/rqyIxpUGQWjNVJ
	/rv+/bkNBhqwLoB
X-Received: by 2002:a05:6a00:9287:b0:842:7436:657a with SMTP id d2e1a72fcca58-8434ce832d7mr10346527b3a.32.1781415604612;
        Sat, 13 Jun 2026 22:40:04 -0700 (PDT)
Received: from nugod-NUC15CRHU5.tail9f095a.ts.net ([218.237.104.87])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434acffd04sm6387078b3a.26.2026.06.13.22.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 22:40:04 -0700 (PDT)
From: HyeongJun An <sammiee5311@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	HyeongJun An <sammiee5311@gmail.com>
Subject: [PATCH bpf 2/2] selftests/bpf: Test linker rejects out-of-range relocation offset
Date: Sun, 14 Jun 2026 14:39:27 +0900
Message-ID: <20260614053927.160566-3-sammiee5311@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260614053927.160566-1-sammiee5311@gmail.com>
References: <20260614053927.160566-1-sammiee5311@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add regression coverage for libbpf static linker relocation offset checks.

Build a minimal ET_REL/EM_BPF object in memory with a 16-byte executable
section and one relocation against that section. Check that a valid
relocation offset is accepted and an offset outside the relocated section
is rejected with -EINVAL.

Assisted-by: Codex:gpt-5
Signed-off-by: HyeongJun An <sammiee5311@gmail.com>
---
 .../selftests/bpf/prog_tests/libbpf_linker.c  | 212 ++++++++++++++++++
 1 file changed, 212 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/libbpf_linker.c

diff --git a/tools/testing/selftests/bpf/prog_tests/libbpf_linker.c b/tools/testing/selftests/bpf/prog_tests/libbpf_linker.c
new file mode 100644
index 000000000000..e7bec2434349
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/libbpf_linker.c
@@ -0,0 +1,212 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <elf.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <unistd.h>
+
+#include <bpf/libbpf.h>
+#include <linux/bpf.h>
+#include <test_progs.h>
+
+enum {
+	SEC_NULL,
+	SEC_TEXT,
+	SEC_REL_TEXT,
+	SEC_SYMTAB,
+	SEC_STRTAB,
+	SEC_SHSTRTAB,
+	SEC_CNT,
+};
+
+enum {
+	SHSTR_TEXT = 1,
+	SHSTR_REL_TEXT = SHSTR_TEXT + sizeof(".text"),
+	SHSTR_SYMTAB = SHSTR_REL_TEXT + sizeof(".rel.text"),
+	SHSTR_STRTAB = SHSTR_SYMTAB + sizeof(".symtab"),
+	SHSTR_SHSTRTAB = SHSTR_STRTAB + sizeof(".strtab"),
+};
+
+struct test_elf {
+	void *buf;
+	size_t sz;
+};
+
+static size_t elf_round_up(size_t value, size_t align)
+{
+	return (value + align - 1) / align * align;
+}
+
+/*
+ * Build a minimal ET_REL object in memory. A normal .bpf.c source cannot
+ * produce a relocation whose offset points past the relocated section, so the
+ * test constructs the ELF directly and feeds it to bpf_linker__add_buf().
+ */
+static struct test_elf make_relo_obj(size_t relo_off)
+{
+	static const char shstrtab[] = "\0.text\0.rel.text\0.symtab\0.strtab\0.shstrtab";
+	static const char strtab[] = "\0";
+	struct bpf_insn insns[] = {
+		{
+			.code = BPF_ALU64 | BPF_MOV | BPF_K,
+			.dst_reg = BPF_REG_0,
+			.imm = 0,
+		},
+		{
+			.code = BPF_JMP | BPF_EXIT,
+		},
+	};
+	size_t off, text_off, rel_off, symtab_off, strtab_off, shstrtab_off, shdr_off;
+	struct test_elf obj = {};
+	Elf64_Shdr *shdr;
+	Elf64_Ehdr *ehdr;
+	Elf64_Sym *sym;
+	Elf64_Rel *rel;
+
+	off = sizeof(*ehdr);
+	text_off = elf_round_up(off, 8);
+	off = text_off + sizeof(insns);
+	rel_off = elf_round_up(off, 8);
+	off = rel_off + sizeof(*rel);
+	symtab_off = elf_round_up(off, 8);
+	off = symtab_off + 2 * sizeof(*sym);
+	strtab_off = off;
+	off = strtab_off + sizeof(strtab);
+	shstrtab_off = off;
+	off = shstrtab_off + sizeof(shstrtab);
+	shdr_off = elf_round_up(off, 8);
+	off = shdr_off + SEC_CNT * sizeof(*shdr);
+
+	obj.buf = calloc(1, off);
+	if (!obj.buf)
+		return obj;
+	obj.sz = off;
+
+	ehdr = obj.buf;
+	memcpy(ehdr->e_ident, ELFMAG, SELFMAG);
+	ehdr->e_ident[EI_CLASS] = ELFCLASS64;
+	ehdr->e_ident[EI_DATA] = ELFDATA2LSB;
+	ehdr->e_ident[EI_VERSION] = EV_CURRENT;
+	ehdr->e_type = ET_REL;
+	ehdr->e_machine = EM_BPF;
+	ehdr->e_version = EV_CURRENT;
+	ehdr->e_ehsize = sizeof(*ehdr);
+	ehdr->e_shoff = shdr_off;
+	ehdr->e_shentsize = sizeof(*shdr);
+	ehdr->e_shnum = SEC_CNT;
+	ehdr->e_shstrndx = SEC_SHSTRTAB;
+
+	memcpy(obj.buf + text_off, insns, sizeof(insns));
+
+	rel = obj.buf + rel_off;
+	rel->r_offset = relo_off;
+	rel->r_info = ELF64_R_INFO(1, R_BPF_64_64);
+
+	sym = obj.buf + symtab_off;
+	sym[1].st_info = ELF64_ST_INFO(STB_LOCAL, STT_SECTION);
+	sym[1].st_shndx = SEC_TEXT;
+
+	memcpy(obj.buf + strtab_off, strtab, sizeof(strtab));
+	memcpy(obj.buf + shstrtab_off, shstrtab, sizeof(shstrtab));
+
+	shdr = obj.buf + shdr_off;
+	shdr[SEC_TEXT] = (Elf64_Shdr) {
+		.sh_name = SHSTR_TEXT,
+		.sh_type = SHT_PROGBITS,
+		.sh_flags = SHF_ALLOC | SHF_EXECINSTR,
+		.sh_offset = text_off,
+		.sh_size = sizeof(insns),
+		.sh_addralign = 8,
+		.sh_entsize = sizeof(struct bpf_insn),
+	};
+	shdr[SEC_REL_TEXT] = (Elf64_Shdr) {
+		.sh_name = SHSTR_REL_TEXT,
+		.sh_type = SHT_REL,
+		.sh_offset = rel_off,
+		.sh_size = sizeof(*rel),
+		.sh_link = SEC_SYMTAB,
+		.sh_info = SEC_TEXT,
+		.sh_addralign = 8,
+		.sh_entsize = sizeof(*rel),
+	};
+	shdr[SEC_SYMTAB] = (Elf64_Shdr) {
+		.sh_name = SHSTR_SYMTAB,
+		.sh_type = SHT_SYMTAB,
+		.sh_offset = symtab_off,
+		.sh_size = 2 * sizeof(*sym),
+		.sh_link = SEC_STRTAB,
+		.sh_info = 2,
+		.sh_addralign = 8,
+		.sh_entsize = sizeof(*sym),
+	};
+	shdr[SEC_STRTAB] = (Elf64_Shdr) {
+		.sh_name = SHSTR_STRTAB,
+		.sh_type = SHT_STRTAB,
+		.sh_offset = strtab_off,
+		.sh_size = sizeof(strtab),
+		.sh_addralign = 1,
+	};
+	shdr[SEC_SHSTRTAB] = (Elf64_Shdr) {
+		.sh_name = SHSTR_SHSTRTAB,
+		.sh_type = SHT_STRTAB,
+		.sh_offset = shstrtab_off,
+		.sh_size = sizeof(shstrtab),
+		.sh_addralign = 1,
+	};
+
+	return obj;
+}
+
+static int link_relo_obj(size_t relo_off)
+{
+	char path[] = "/tmp/libbpf_linker_relo_XXXXXX";
+	struct test_elf obj = {};
+	struct bpf_linker *linker;
+	int err, fd;
+
+	fd = mkstemp(path);
+	if (!ASSERT_OK_FD(fd, "mkstemp"))
+		return -errno;
+	close(fd);
+
+	linker = bpf_linker__new(path, NULL);
+	if (!ASSERT_OK_PTR(linker, "linker_new")) {
+		err = libbpf_get_error(linker);
+		goto out_unlink;
+	}
+
+	obj = make_relo_obj(relo_off);
+	if (!ASSERT_OK_PTR(obj.buf, "make_relo_obj")) {
+		err = -ENOMEM;
+		goto out_free_linker;
+	}
+
+	err = bpf_linker__add_buf(linker, obj.buf, obj.sz, NULL);
+	if (!err)
+		err = bpf_linker__finalize(linker);
+
+	free(obj.buf);
+out_free_linker:
+	bpf_linker__free(linker);
+out_unlink:
+	unlink(path);
+	return err;
+}
+
+static void test_valid_relo_offset(void)
+{
+	ASSERT_OK(link_relo_obj(0), "valid_relo_offset");
+}
+
+static void test_invalid_relo_offset(void)
+{
+	ASSERT_EQ(link_relo_obj(0x1000), -EINVAL, "invalid_relo_offset");
+}
+
+void test_libbpf_linker(void)
+{
+	if (test__start_subtest("valid_relo_offset"))
+		test_valid_relo_offset();
+	if (test__start_subtest("invalid_relo_offset"))
+		test_invalid_relo_offset();
+}
-- 
2.43.0

