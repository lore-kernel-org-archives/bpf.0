Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9212A2580F2
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 01:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774918843; cv=none; b=B1DwHKNekVCPD06AZiklLDeEaNRv+YVZ1X1kH9kdgD0b6udjiVX2flN6lPd893CJ9a5dleqyheljyASP8MuCd9eZXG4J5M+NofHaJQpvNkyZ4u+ROTEP0uEmPdSi+qBTntsxCl0AWoD5C4qPEo2sahiD6fSmiaEJkxiMqrDCD5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774918843; c=relaxed/simple;
	bh=uUYSIIVZZjCe7wBbUWJR+CWNZzMMHS6FoWwreA4Lw24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lHAZFHbUChPeeN76aO8v6lbJcGRPYXfFWWwr8Gw6iuAjCFNfFUKsEOcME0AU7EPFL5sm1jZgclvMviLZmcWb9rpFdX+a6GptQE6wqGMw5pUmQwwJSD6c/gq7n9mg62iy5ABm4ukwTS9gsh5KhUBfiXyHKPjhVYOlfdEwcbUFv7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mHkCbQC/; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mHkCbQC/"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ab39b111b9so21711535ad.1
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 18:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774918841; x=1775523641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U8+WqbHQzWizkYopyM3o18Bxp+RLsjjdroD91or8oKk=;
        b=mHkCbQC/6UFoj5+HUs0jYWiwo/Gr8sjXGrE/fYJh7+FKkjQXk+pxNCIF/0sYuvzNTI
         ngMQzaOFkH7bjn3wFuxdmYd6K5mTlF2gfug5h3Mba12xHlvxfvIuwLp67BwE4e2Zw6sG
         g5GdQd3lR2QM4xQpx+2q/LT/16qG+MZbdIuaxd//a5fqhK3BZ6wMSIwAtKQlvSoTc+d1
         ibSuKEWXfBuJsTJXdYy2P0sm/3BXiQwqaK40Chv+f6mPVdZiBb/I90m3yWA015bpyRg3
         7ISlnzO2Wo397fO+rxmmUrt18MMVsRoeraqv+cpJcgLL67MQskhIMry1eX4ZJayj4Mo6
         gpfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774918841; x=1775523641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U8+WqbHQzWizkYopyM3o18Bxp+RLsjjdroD91or8oKk=;
        b=Vr6wNQGnY+6xaB3VD/wq1bkz9cjIemD/m19vquVSEztrk5zxSIiTcJIP07gOMipPJ9
         Cbh+vZWxfuI48whAjCizsBPI9PeVIe3khvLKqPqdE4HPayEeil9XLHhijg/VqCaX9CiZ
         NQo4yWLNFvej0HS9R/BtAIrw2n5dvh0cWrG7IwG8s9rWoXz6vXBuLGfgBLQpb+4W2Gov
         eDTC1qNQXpvDWUkK6Y5TTak9LCEROgDNU3B63OJB+kW5PeULPlIs6wcdvvE/8yNTp5FP
         2RGWOtIhQdDjZOaBFLQHI9gbIB/SRVFlHSxLQg8/HrRnP9dnf8kxrTJo/5r07MmunMMr
         iVXg==
X-Gm-Message-State: AOJu0YzJ9hlh6QyW7lsc9TAkRsMOhFl948Bd8M/Ml5+DBilmV5lkcIpZ
	pmZzowYWQpGj5DOcKN9lYk8DlWRlifjf3dkmyMRBGcPwQxxBXWGWRn6G0nHUYg==
X-Gm-Gg: ATEYQzw0TksBjRTo766eoqmG1pixH150UkYIiCMcc/dY2q9L/eRCkSMm2CAh7Owj3tK
	AjDYygcf3UlKpBjtfCSLfdD5tbnQtrh7VN/vkKSl1f+VUSobe1+CT9zQkK/B75Jiq/Wec0NQcpW
	WgxpAjLzV/aObx+B8EEi4MYErdH1DKLSGsUDCf2QJLWdiubV8NJGQYY5/d3MtLnPsnNDl2qafSI
	FnVYlHhPlCMsvVlExlt/Ak1dGscnunR6L86m0OcQIbkr/H1b5OXgqbmUKscE7ae8M/tS4bbPk4y
	pSY6ancnIeFHD1tNAdfY5W4VF9HslyIFQfS3qDs6QMOV75Ajimt6sBrCMmPpS9jHzQl0Bi7/NoK
	jmyAKRnLLnEJQ9OyL6y/yuxlbpJdkxB6pqwcOO2KiI+zva33ItbZhPitFg0wE4FpDoWINlNI5IZ
	2EQRZLNB58goGbG9nMAdJQfk+g3lcB9ijaBZQRpTEP0/RFpRw3
X-Received: by 2002:a17:902:fc4e:b0:2ad:9b86:ddc2 with SMTP id d9443c01a7336-2b0cdc4361bmr153106665ad.22.1774918840589;
        Mon, 30 Mar 2026 18:00:40 -0700 (PDT)
Received: from honey-badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427a27f2sm125226405ad.67.2026.03.30.18.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 18:00:40 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>
Subject: [PATCH bpf-next v2 2/4] selftests/bpf: make str_has_pfx return pointer past the prefix
Date: Mon, 30 Mar 2026 17:59:25 -0700
Message-ID: <20260330-selftests-global-tags-ordering-v2-2-c0ac61e81098@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330-selftests-global-tags-ordering-v2-0-c0ac61e81098@gmail.com>
References: <20260330-selftests-global-tags-ordering-v2-0-c0ac61e81098@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Change str_has_pfx() to return a pointer to the first character after
the prefix, thus eliminating the repetitive (s + sizeof(PFX) - 1)
patterns.

Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/test_loader.c | 51 ++++++++++++++-----------------
 1 file changed, 23 insertions(+), 28 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index 338c035c36884c02ac57cd17110122c10b4858e4..50ca1b6ec8150efe2cb280667af9ac4972c28657 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -11,8 +11,12 @@
 #include "cap_helpers.h"
 #include "jit_disasm_helpers.h"
 
-#define str_has_pfx(str, pfx) \
-	(strncmp(str, pfx, __builtin_constant_p(pfx) ? sizeof(pfx) - 1 : strlen(pfx)) == 0)
+static inline const char *str_has_pfx(const char *str, const char *pfx)
+{
+	size_t len = strlen(pfx);
+
+	return strncmp(str, pfx, len) == 0 ? str + len : NULL;
+}
 
 #define TEST_LOADER_LOG_BUF_SZ 2097152
 
@@ -161,21 +165,21 @@ static void free_test_spec(struct test_spec *spec)
 static int compile_regex(const char *pattern, regex_t *regex)
 {
 	char err_buf[256], buf[256] = {}, *ptr, *buf_end;
-	const char *original_pattern = pattern;
+	const char *original_pattern = pattern, *m;
 	bool in_regex = false;
 	int err;
 
 	buf_end = buf + sizeof(buf);
 	ptr = buf;
 	while (*pattern && ptr < buf_end - 2) {
-		if (!in_regex && str_has_pfx(pattern, "{{")) {
+		if (!in_regex && (m = str_has_pfx(pattern, "{{"))) {
 			in_regex = true;
-			pattern += 2;
+			pattern = m;
 			continue;
 		}
-		if (in_regex && str_has_pfx(pattern, "}}")) {
+		if (in_regex && (m = str_has_pfx(pattern, "}}"))) {
 			in_regex = false;
-			pattern += 2;
+			pattern = m;
 			continue;
 		}
 		if (in_regex) {
@@ -452,8 +456,8 @@ static int parse_test_spec(struct test_loader *tester,
 			continue;
 
 		s = btf__str_by_offset(btf, t->name_off);
-		if (str_has_pfx(s, TEST_TAG_DESCRIPTION_PFX)) {
-			description = s + sizeof(TEST_TAG_DESCRIPTION_PFX) - 1;
+		if ((val = str_has_pfx(s, TEST_TAG_DESCRIPTION_PFX))) {
+			description = val;
 		} else if (strcmp(s, TEST_TAG_EXPECT_FAILURE) == 0) {
 			spec->priv.expect_failure = true;
 			spec->mode_mask |= PRIV;
@@ -530,29 +534,24 @@ static int parse_test_spec(struct test_loader *tester,
 			if (err)
 				goto cleanup;
 			spec->mode_mask |= UNPRIV;
-		} else if (str_has_pfx(s, TEST_TAG_RETVAL_PFX)) {
-			val = s + sizeof(TEST_TAG_RETVAL_PFX) - 1;
+		} else if ((val = str_has_pfx(s, TEST_TAG_RETVAL_PFX))) {
 			err = parse_retval(val, &spec->priv.retval, "__retval");
 			if (err)
 				goto cleanup;
 			spec->priv.execute = true;
 			spec->mode_mask |= PRIV;
-		} else if (str_has_pfx(s, TEST_TAG_RETVAL_PFX_UNPRIV)) {
-			val = s + sizeof(TEST_TAG_RETVAL_PFX_UNPRIV) - 1;
+		} else if ((val = str_has_pfx(s, TEST_TAG_RETVAL_PFX_UNPRIV))) {
 			err = parse_retval(val, &spec->unpriv.retval, "__retval_unpriv");
 			if (err)
 				goto cleanup;
 			spec->mode_mask |= UNPRIV;
 			spec->unpriv.execute = true;
 			has_unpriv_retval = true;
-		} else if (str_has_pfx(s, TEST_TAG_LOG_LEVEL_PFX)) {
-			val = s + sizeof(TEST_TAG_LOG_LEVEL_PFX) - 1;
+		} else if ((val = str_has_pfx(s, TEST_TAG_LOG_LEVEL_PFX))) {
 			err = parse_int(val, &spec->log_level, "test log level");
 			if (err)
 				goto cleanup;
-		} else if (str_has_pfx(s, TEST_TAG_PROG_FLAGS_PFX)) {
-			val = s + sizeof(TEST_TAG_PROG_FLAGS_PFX) - 1;
-
+		} else if ((val = str_has_pfx(s, TEST_TAG_PROG_FLAGS_PFX))) {
 			clear = val[0] == '!';
 			if (clear)
 				val++;
@@ -577,8 +576,7 @@ static int parse_test_spec(struct test_loader *tester,
 					goto cleanup;
 				update_flags(&spec->prog_flags, flags, clear);
 			}
-		} else if (str_has_pfx(s, TEST_TAG_ARCH)) {
-			val = s + sizeof(TEST_TAG_ARCH) - 1;
+		} else if ((val = str_has_pfx(s, TEST_TAG_ARCH))) {
 			if (strcmp(val, "X86_64") == 0) {
 				arch = ARCH_X86_64;
 			} else if (strcmp(val, "ARM64") == 0) {
@@ -596,16 +594,14 @@ static int parse_test_spec(struct test_loader *tester,
 			collect_jit = get_current_arch() == arch;
 			unpriv_jit_on_next_line = true;
 			jit_on_next_line = true;
-		} else if (str_has_pfx(s, TEST_BTF_PATH)) {
-			spec->btf_custom_path = s + sizeof(TEST_BTF_PATH) - 1;
-		} else if (str_has_pfx(s, TEST_TAG_CAPS_UNPRIV)) {
-			val = s + sizeof(TEST_TAG_CAPS_UNPRIV) - 1;
+		} else if ((val = str_has_pfx(s, TEST_BTF_PATH))) {
+			spec->btf_custom_path = val;
+		} else if ((val = str_has_pfx(s, TEST_TAG_CAPS_UNPRIV))) {
 			err = parse_caps(val, &spec->unpriv.caps, "test caps");
 			if (err)
 				goto cleanup;
 			spec->mode_mask |= UNPRIV;
-		} else if (str_has_pfx(s, TEST_TAG_LOAD_MODE_PFX)) {
-			val = s + sizeof(TEST_TAG_LOAD_MODE_PFX) - 1;
+		} else if ((val = str_has_pfx(s, TEST_TAG_LOAD_MODE_PFX))) {
 			if (strcmp(val, "jited") == 0) {
 				load_mask = JITED;
 			} else if (strcmp(val, "no_jited") == 0) {
@@ -635,12 +631,11 @@ static int parse_test_spec(struct test_loader *tester,
 					      &spec->unpriv.stdout);
 			if (err)
 				goto cleanup;
-		} else if (str_has_pfx(s, TEST_TAG_LINEAR_SIZE)) {
+		} else if ((val = str_has_pfx(s, TEST_TAG_LINEAR_SIZE))) {
 			switch (bpf_program__type(prog)) {
 			case BPF_PROG_TYPE_SCHED_ACT:
 			case BPF_PROG_TYPE_SCHED_CLS:
 			case BPF_PROG_TYPE_CGROUP_SKB:
-				val = s + sizeof(TEST_TAG_LINEAR_SIZE) - 1;
 				err = parse_int(val, &spec->linear_sz, "test linear size");
 				if (err)
 					goto cleanup;

-- 
2.53.0
