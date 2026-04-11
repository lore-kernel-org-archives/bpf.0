Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F8332F764
	for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 07:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775892844; cv=none; b=E8nNhsdMCG7t6TLg5nU7mkqO+KnuFZP0B9hjXRvUYzY8DGiQo2LRqYrtMHS4vGNFUlU6B6XzqXHz/7yQfzkTjL07B8ByoJMrlzQ7n1jk3S8h4vj5TBk34KWnE2sNyVUVz9IPDxWkyhmx8NyYIP+F6FP2yUKl1YVdGxzaTI8TTB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775892844; c=relaxed/simple;
	bh=eXkmIL68TyMlRjBwwBtWHw8ujRXq00waKzquN/UcQeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=llukHbyqn1UZp6BttIdNY1LFcbrcVE4iYwG35A7BqhtaqeyGJH1npiILH1695hi6oaf7vXTO7y3VjkzaemWw3GaDcrR5alo58NIJhy0sEKPN4xMYmxJ782ZgOBqIiw+Ee7VJ0AmNq26TUoMdQCzNDNLA1/h3js1shMH/P80OJ1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=clQz9VZU; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clQz9VZU"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82d0b68837aso1625455b3a.2
        for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 00:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775892843; x=1776497643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9PKbum+gZdxLwoSsnXmKw6YrW/lukmbkQosv4767YS4=;
        b=clQz9VZUvaGfifFndvHjizqTbpNMtZBFxVRAwKsoRah/U+5od5VxwTNRf4azkc28Wy
         fv55Mq348XzMy11oZPqA+Vw87R+BztQWxH2HKoTTVxkClaPI/7BmMp+zHqeOkvgghZGV
         SUei1ccyyAXHiOP9gHBbwFacgJ8smrJZvG1ciR/Dkq6P5FDYEzLVAzxvzbdT6Gou1RKI
         dGpYRNcT7e+LDTdqTORBZzn+8Ex/RnjuUx9YIne6RsxkQ0lXQs24rRduLoSGu37ifUT6
         0wz/HGiJkxEmAIsz0HiQV+j6JQR5stnqQvJGj0ZpiJt1WJ+nzkIZ7L7JulB6tPHi7Fj6
         FCLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775892843; x=1776497643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9PKbum+gZdxLwoSsnXmKw6YrW/lukmbkQosv4767YS4=;
        b=NspQcJAKeqk3fFCMA2CS9M5fE1VuI5pAEhzog45KqRI1xefUoJCqqSmnXyESmWb7WE
         yTLc+bZ34or/RrO9Jwx68fazxrr1mSN9fQUk//MxdBqBT67Y2LszBllYTIGrt0EObSCP
         R6p1z+NgW5qEuzgSdHREQsY5DCfcNW/BeXxcYbWv0FDqXq7B3PIiVwmhd8OYsWA4Gb7j
         pet76SR72ENV7zUX3Qaezw5q7oECkO8Sc9RyjXCU+hs7fnmhRA1YifwMrwHXrCjQuzgD
         xRhbd2oJDlGc4+7Kf+j8H5q3NdAK8UH2Cytl2L5G4u6qI5TW9VzTYfm1Ipo1MSdbM7JN
         t5+w==
X-Gm-Message-State: AOJu0YzSR7jclH4EC7stXrsvRovuhQt/D5Pv0wPAuIDb7VlDzhq+Mz1r
	OsNEvTPEZhd8fDQ2vhWh0tjZA82GvOAwpEHq1LbMgKzIPlHOxJ/jf6PyB8bhig==
X-Gm-Gg: AeBDiesWNuOTQnrJFGGkI/3x0N1T8unuOfw7hi/JA1NgtcJWgbHAvQmms//ukUqfzCl
	ilvsjkBHchkM2+YEwe9oFFqs17PAVbSrPzKdDk0o3sabGIH7cV+DhfOIlFHpSol7SxGmOrgfPZ3
	3GfBQHICuADAhHLe8l41KUzAdJGLdhYLQMMP0x22uOiIVK9DSr0K3Enesvj+ADzJNqBLhsBCPE2
	Kcw4FeQkMroidkk7qbsEpgs2k67M4IISgIxT2EOjdMA+J7HtRKbWaWGAVAZKMsKpPlkjNwXh0Ai
	OIdTy0wBOvYs9Mnokgfp0Yorl4D5EC5Zjk2qc8sSccDRZ2gqByA3xFShD8H/9uKyBs9Kruy8O2r
	wGZNqed26TONCZvQcFVB+qrUTpyCA6eyihH+JsiQ5dX11Kx1HBTklxspX09mGFffC8GTM7iKxti
	L4n4zAXpDJrD7m7Y+wvg99T9TWwM0UR2TBH7pl99YN9LV4KEs+MXYZy50i8iT67RnEvwjG8+bAa
	sgy3A==
X-Received: by 2002:a05:6a00:3987:b0:829:7b0f:c9de with SMTP id d2e1a72fcca58-82f0c3004d6mr6626997b3a.35.1775892842772;
        Sat, 11 Apr 2026 00:34:02 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c30f5c3sm4965388b3a.3.2026.04.11.00.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 00:34:02 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	cupertino.miranda@oracle.com,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Puranjay Mohan <puranjay@kernel.org>
Subject: [PATCH bpf-next v2 2/4] selftests/bpf: make str_has_pfx return pointer past the prefix
Date: Sat, 11 Apr 2026 00:33:45 -0700
Message-ID: <20260410-selftests-global-tags-ordering-v2-2-c566ec9781bf@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410-selftests-global-tags-ordering-v2-0-c566ec9781bf@gmail.com>
References: <20260410-selftests-global-tags-ordering-v2-0-c566ec9781bf@gmail.com>
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
Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
Reviewed-by: Puranjay Mohan <puranjay@kernel.org>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/test_loader.c | 51 ++++++++++++++-----------------
 1 file changed, 23 insertions(+), 28 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index 96ed70e01fe5..fa6147607c4d 100644
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
 
@@ -166,21 +170,21 @@ static void free_test_spec(struct test_spec *spec)
 static int compile_regex(const char *pattern, regex_t *regex)
 {
 	char err_buf[256], buf[256] = {}, *ptr, *buf_end;
-	const char *original_pattern = pattern;
+	const char *original_pattern = pattern, *next;
 	bool in_regex = false;
 	int err;
 
 	buf_end = buf + sizeof(buf);
 	ptr = buf;
 	while (*pattern && ptr < buf_end - 2) {
-		if (!in_regex && str_has_pfx(pattern, "{{")) {
+		if (!in_regex && (next = str_has_pfx(pattern, "{{"))) {
 			in_regex = true;
-			pattern += 2;
+			pattern = next;
 			continue;
 		}
-		if (in_regex && str_has_pfx(pattern, "}}")) {
+		if (in_regex && (next = str_has_pfx(pattern, "}}"))) {
 			in_regex = false;
-			pattern += 2;
+			pattern = next;
 			continue;
 		}
 		if (in_regex) {
@@ -457,8 +461,8 @@ static int parse_test_spec(struct test_loader *tester,
 			continue;
 
 		s = btf__str_by_offset(btf, t->name_off);
-		if (str_has_pfx(s, TEST_TAG_DESCRIPTION_PFX)) {
-			description = s + sizeof(TEST_TAG_DESCRIPTION_PFX) - 1;
+		if ((val = str_has_pfx(s, TEST_TAG_DESCRIPTION_PFX))) {
+			description = val;
 		} else if (strcmp(s, TEST_TAG_EXPECT_FAILURE) == 0) {
 			spec->priv.expect_failure = true;
 			spec->mode_mask |= PRIV;
@@ -535,29 +539,24 @@ static int parse_test_spec(struct test_loader *tester,
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
@@ -582,8 +581,7 @@ static int parse_test_spec(struct test_loader *tester,
 					goto cleanup;
 				update_flags(&spec->prog_flags, flags, clear);
 			}
-		} else if (str_has_pfx(s, TEST_TAG_ARCH)) {
-			val = s + sizeof(TEST_TAG_ARCH) - 1;
+		} else if ((val = str_has_pfx(s, TEST_TAG_ARCH))) {
 			if (strcmp(val, "X86_64") == 0) {
 				arch = ARCH_X86_64;
 			} else if (strcmp(val, "ARM64") == 0) {
@@ -601,16 +599,14 @@ static int parse_test_spec(struct test_loader *tester,
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
@@ -640,12 +636,11 @@ static int parse_test_spec(struct test_loader *tester,
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
