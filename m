Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792764647;
	b=duYP7BeStAIAsJ9DGaipSKIUFn4UWznVTsA8wPQpmHlsUxJ5TGxRf/QHsdBA/UfOXpJU
	 Yxzbid3WWKPKZFOeqfxTQSBuuuTF2Eg0lSTdN32emykFcT0cB8g8SIXnnhU6hMahpvQ/P
	 sPEzP2DJ3KXRT6GFQJELlORfffloWaeO4OH1zEODAUhJ1QCV9OdOhiDxBaF9GYtt1rh1I
	 pkXpRCJDj1Wfon8czHMcwGKwybi6IUS6GlAjg6veMBzjXC1ZHmPm38noGlYwbTP+9R3or
	 SbePcHyna8CdPSt7bQliS8i0cCTmp1AmTyLiKzyTA/x6PX5RKA6baHlGIVeVngc8fRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792764647;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=uNl8wSw6xRSBiw4CqMrGhIATp2KVsnq9KVFjiGarVAU=;
	b=IbERIZnzWbqd/LkaYLWD8XMrpgzWthvtovf9yZpbnUMYkOcTju310mRjuTRuiNV5NWtH
	 V4ZnROGnWx2Nm/OML5+YSuhAJNvcUVKezT6HRpmwPlg8lFtI+sySBUpXN0Lht5hFiJBqs
	 FRNH2wv6z/Sv0o1EFg/lue7roph0IeYIWu6VPBZsxBHRQttUlz9LougrX4tPysiXWRjR5
	 ZZ7i0YBgZ58ZhylzgTm38YSnQW/tlqmeU9ScAW0zFpE9obNnnSFyz7R0g1kVPGt7Jaukz
	 cDwMtJXAyzczD/DIhanuWkVvMdQbaFcgHAzqRoGYSkC5L3bNxlQZjFc5++BnQ/HG5fA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="tHiZOh/c";
	arc=none smtp.remote-ip=209.85.208.180
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD63606A320
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 14:10:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCD63606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=tHiZOh/c
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3ab3dd9681fso6930871fa.1
        for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 07:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792764645; x=1793369445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uNl8wSw6xRSBiw4CqMrGhIATp2KVsnq9KVFjiGarVAU=;
        b=tHiZOh/c7mef2IayvxrowZs+i+TrqJvL7rj1upVZn/K2XQ2yXJRGK+CwWu5OoPRlM7
         rH8ORvnyH61tSK7A3vgbRNx0NZ9j7dAFh5Dums+6Sc30F+9r7ugV32Fvw5qH46hhvWSt
         UaroYV1/WUpGoVdYrYt/vOZo8CSPayQcG/YMeiFp6tCyU8gKYJZoMeTcKwuqdLaxl3ZU
         oNJqLyDwu3piEXuHkIsaRlPPFhaCU9ZgrYu2XnOZSUml0N3tMUfWH+J3uaQ/vrtoJEOV
         U7pxt+LRbHi2Ib3ZCCpD3sTih8p5sbrPEIrKcqZLhtFfbqaeLBUkBSzZxT6/ZgolEACI
         rzKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792764645; x=1793369445;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uNl8wSw6xRSBiw4CqMrGhIATp2KVsnq9KVFjiGarVAU=;
        b=QlipNbelbBirZNQb5XmE4EQCG7b0SvUW3nMLX7m4VHKtftn9iasd8Na1YkqQAf6mu4
         syLI58ehK9hyVPiDmdlswPWODPi4Zn5QMJIUzEkTyt9yjk1RqGLDVIsYtq3d6CrRbJRd
         ydTzJ20r0BQC4sKZykFV12nmGtoGvqyMosKs/tKfH2gKI/lMnCSyj9z9DW05hIEe3PeN
         vGXYtiBnwkj5FQiqd0TZECGXH9HFIlpMn9p0e2vEMz7imRM5TlFqeFPx9nUfe6Kho8Cy
         3ljtphajvJ0S3NJGMkbJdtnAsDRmWQZc6x9BZH2elNbXxkL79FnZobce/rtyJfjFJvPh
         rB6A==
X-Gm-Message-State: AFq9FYJP40XQmNRCPXncWUUdcJVdklQ3tJ35183Z38DV+KD53jt+tI0U
	oF0VCCM6aYi66YT+Pzcf2IAFUXq/qObHk9Yc464+Wec+RRTstDFlg4sSuchG9AmmXg0zRQ==
X-Gm-Gg: AYBFou1EUMBB4NeTfeeXT16lChniurS5JPAQH5x7KUf/9643GrcA7jY8upP1MpHmRS9
	cyIHBYHM9Wck8pmqo5nLL2bj3lnt/rTX8QyzpsPjbvqbsQKamcfqSANLwklutPKb5lMP6dV8/mF
	LN1N6GDDGRH0D85GKGhuoTv+7H90xGbUo2+ZkMGMBvY9jDFL++lvyTlW08DnKP+uIz6Ew+9k2fP
	COTwjh8CokgQuFLYlmWZoCPhd+oaT6NzgChdl2fU1Gjk4JMD6FGlDmUl3SorbqAQzhpBDPWNjZN
	ggWkHvqubCapp5H5RgNbPJSzeTlW2TicDgI96R12/f1rx04zPJW3m0a8UeDTIjVQwxeeGsE2m1J
	FaT0NGULAVWLGaJPnQIxiofbodoROI7dAg+vSmg0DVkc29o+1PjWkqtRqPCZLtYWr32l4hTj2Jm
	fjgEpPPhtxVLi5PSckd9KRLA0TgQ5NbSlx8/zB68ypYCLQbz/nT8yXXHh0MzeHXUmtadETaZE7V
	q5g86eR8fRfYb+jPq0wD+2WUAE103MDY/yKBIO5mH5PsKzGxBJfgQ==
X-Received: by 2002:a05:651c:31d0:b0:3a9:c840:10ee with SMTP id 38308e7fff4ca-3ac6634fc25mr5902201fa.5.1792764644646;
        Fri, 23 Oct 2026 07:10:44 -0700 (PDT)
Received: from localhost ([196.240.54.42])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ac65d29391sm4676361fa.31.2026.10.23.07.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 07:10:43 -0700 (PDT)
From: Eduard Zateev <hackerowskiy@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapis.com,
	ihor.solodrai@linux.dev,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	Eduard Zateev <hackerowskiy@gmail.com>
Subject: [PATCH] libbpf: fix symbol resolution without .symtab
Date: Fri, 23 Oct 2026 16:10:40 +0200
Message-ID: <20261023141040.249597-1-hackerowskiy@gmail.com>
X-Mailer: git-send-email 2.55.0
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

When a binary has .dynsym but no .symtab, elf_sym_iter_new() returns -ENOENT for the optional table. Keep checking the other table and clear that error; otherwise successful dynamic-symbol lookups are reported as failures.

Add a regression selftest for a stripped shared object and verify that unresolved symbols still fail.

Link: https://github.com/libbpf/libbpf/issues/953
Signed-off-by: Eduard Zateev <hackerowskiy@gmail.com>
---
 tools/lib/bpf/elf.c                           |  5 ++-
 tools/testing/selftests/bpf/Makefile          |  7 +++-
 .../bpf/prog_tests/uprobe_multi_test.c        | 37 +++++++++++++++++++
 .../selftests/bpf/uprobe_multi_stripped.c     |  7 ++++
 4 files changed, 54 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/uprobe_multi_stripped.c

diff --git a/tools/lib/bpf/elf.c b/tools/lib/bpf/elf.c
index 700c3911a..76baaf778 100644
--- a/tools/lib/bpf/elf.c
+++ b/tools/lib/bpf/elf.c
@@ -438,8 +438,11 @@ int elf_resolve_syms_offsets(const char *binary_path, int cnt,
 		struct elf_sym *sym;
 
 		err = elf_sym_iter_new(&iter, elf_fd.elf, binary_path, sh_types[i], st_type);
-		if (err == -ENOENT)
+		if (err == -ENOENT) {
+			/* A missing symbol table is OK; check the other one. */
+			err = 0;
 			continue;
+		}
 		if (err)
 			goto out;
 
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 1e4af62e8..4125133d4 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -61,7 +61,8 @@ TEST_GEN_PROGS_EXTENDED = \
 	xdp_synproxy \
 	xskxceiver
 
-TEST_GEN_FILES += $(TEST_KMODS) liburandom_read.so urandom_read sign-file uprobe_multi
+TEST_GEN_FILES += $(TEST_KMODS) liburandom_read.so urandom_read sign-file uprobe_multi \
+	uprobe_multi_stripped.so
 
 ifneq ($(V),1)
 submake_extras := feature_display=0
@@ -666,6 +667,10 @@ $(OUTPUT)/uprobe_multi: uprobe_multi.c uprobe_multi.ld
 	$(Q)$(CC) $(CFLAGS) -Wl,-T,uprobe_multi.ld -O0 $(LDFLAGS) 	\
 		$(filter-out %.ld,$^) $(LDLIBS) -o $@
 
+$(OUTPUT)/uprobe_multi_stripped.so: uprobe_multi_stripped.c
+	$(call msg,BINARY,,$@)
+	$(Q)$(CC) $(CFLAGS) -fPIC -shared -Wl,-s $(LDFLAGS) $< -o $@
+
 EXTRA_CLEAN := $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)			\
 	prog_tests/tests.h map_tests/tests.h verifier/tests.h		\
 	feature bpftool $(TEST_KMOD_TARGETS)				\
diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
index f0baf5738..340e3b55c 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
@@ -374,6 +374,41 @@ static void test_attach_api_syms(void)
 	test_attach_api("/proc/self/exe", NULL, &opts);
 }
 
+static void test_attach_api_syms_stripped(void)
+{
+	LIBBPF_OPTS(bpf_uprobe_multi_opts, opts);
+	const char *syms[] = { "uprobe_multi_stripped_func" };
+	struct uprobe_multi *skel = NULL;
+	struct bpf_link *link = NULL;
+
+	opts.syms = syms;
+	opts.cnt = ARRAY_SIZE(syms);
+
+	skel = uprobe_multi__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "uprobe_multi__open_and_load"))
+		return;
+
+	link = bpf_program__attach_uprobe_multi(skel->progs.uprobe, -1,
+						"./uprobe_multi_stripped.so", NULL, &opts);
+	if (!ASSERT_OK_PTR(link, "attach_uprobe_multi_stripped")) {
+		link = NULL;
+		goto cleanup;
+	}
+	bpf_link__destroy(link);
+	link = NULL;
+
+	/* A missing symbol must still be reported as an error. */
+	syms[0] = "uprobe_multi_missing_func";
+	link = bpf_program__attach_uprobe_multi(skel->progs.uprobe, -1,
+						"./uprobe_multi_stripped.so", NULL, &opts);
+	if (!ASSERT_ERR_PTR(link, "attach_uprobe_multi_missing_symbol"))
+		bpf_link__destroy(link);
+	link = NULL;
+
+cleanup:
+	uprobe_multi__destroy(skel);
+}
+
 static void test_attach_api_fails(void)
 {
 	LIBBPF_OPTS(bpf_link_create_opts, opts);
@@ -1442,6 +1477,8 @@ void test_uprobe_multi_test(void)
 		test_attach_api_pattern();
 	if (test__start_subtest("attach_api_syms"))
 		test_attach_api_syms();
+	if (test__start_subtest("attach_api_syms_stripped"))
+		test_attach_api_syms_stripped();
 	if (test__start_subtest("link_api"))
 		test_link_api();
 	if (test__start_subtest("link_api_path_fd"))
diff --git a/tools/testing/selftests/bpf/uprobe_multi_stripped.c b/tools/testing/selftests/bpf/uprobe_multi_stripped.c
new file mode 100644
index 000000000..9bdf7fb9b
--- /dev/null
+++ b/tools/testing/selftests/bpf/uprobe_multi_stripped.c
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
+
+__attribute__((noinline, visibility("default")))
+int uprobe_multi_stripped_func(void)
+{
+	return 42;
+}
-- 
2.55.0

