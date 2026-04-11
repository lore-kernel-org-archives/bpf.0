Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BF92BE642
	for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 07:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775892847; cv=none; b=P/rtlCJ9TvO7mFpXbOIMyNZ+3EzaUIrSvuc+VD+SiMiBPXV8s6vVdkAHgQPTKF8zrmGCSQB3OKjbtpUwh4N0uQB4DAxwniXaI/kxl96DzhCG3uVfqBM1tkEIMINCISDP2PgkE0QjHO37a16IXNxWkypoZpq8VFSx+9AyOtdENgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775892847; c=relaxed/simple;
	bh=8AVYqLFvnN+iiQCJtk3RXcZ+RmYgHTLV2LflaP4JS5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qAlb6VThKbJXy8tMocHCDxf7N/0tF932PTzIYSvm2nAjp4ctLCTmJPWXaLLWPbWWsZz8/2RSObsjjADdTQSNs/6WZFbY9qA3R3JPVtOnVGneqVz5mhqlnwlw3pzeeoRYY+0gwafgzQHbtkTGD3ZLvWFRr8jBaonMZ02H8pTuI2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bLdfjraT; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bLdfjraT"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-82ce2e2880cso1858467b3a.0
        for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 00:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775892845; x=1776497645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dMOlbAx30yeY+9LSJ+eWrVrGa4tOd4ni7gUJf3aDPDA=;
        b=bLdfjraT1ukCJJQ82J2voST3XFZBW2OrsDOQAtAh/9UJVieGgptovOPLDBYI3NI+0+
         Va1SEjYBMT+pTHrM8TNST18dfGxuSHdTzJ1WHmqDY6Slxqmeu7oA//DEYFSRB16toNgL
         0prOWuinnTaioBXZy0JJVR+SE2vkYP2yxSxgq0r+ZAChSnX/H82NaNxpe/OBEbFXRSQj
         fw3cqQGB3tgvSKge1NmaHhJkk+xUuGQwK71oYzSbcJZS7vHP2yK2OqlAahlfBuJVQ4Ly
         LdOGqXg6A1L9Lw7yaw6we2v4uUKjgfPJYqUzyYmY/75+hsVBe5L4ksKYDa3ut8c3o4S+
         bzWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775892845; x=1776497645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dMOlbAx30yeY+9LSJ+eWrVrGa4tOd4ni7gUJf3aDPDA=;
        b=NXaWEjVmrKSA2MYUWbHWJ4w6CRf4oNEqT/45+V0uqZJFp0j3i8Rs86UXs4Cbvn6bw8
         pRMibokfMpyaUjCeWqMqmYoaV83aSPRIdhBf4BrCHTNDds/PA2y5Bz7E5dfI05FvaSra
         MkA2V1g0Qh3tXYXhGS7uMz4KRxxwIuUECtIwMU1tAhvDzkIg1VtdWZVocIxdQF8WkJCV
         10XRed2cSLgK5zGr3TkDYtgcpU9ykObTx1qlvhSQ0Ejz5aAwedOY1O2jt75Xz71oLbpj
         qkddLPKUscPHF57uqCRYSeNPBS6R7/FoRpf718Q0683jy8kOWH3sbuKH+mFAecmnb95z
         BRow==
X-Gm-Message-State: AOJu0YwmIGephZsUqQJVOKWJZIvB691DsOG7acYwe171jeu7oiGnSLti
	RQ48ohZKTDJoo8m+PckC3kNi0/TedxI3cGn04j1+kL4zuOZQxa6k2vpTekF+EA==
X-Gm-Gg: AeBDietTJQdeaA7VqE8KnhFWqH0LjxpayFCLhLAfzzMfFxUB38bGiVOoJhvd/iW8BSs
	ZcTX5NSrIKIljFtFwwhuLQoBOzigR3NEFiH7YHU0oMvAqepO0y1BqKCitR8JgckJ3qt4/cA8J1O
	l7tF0msL185+sMStWo7fu00GnN4N1rzQckXfFAL0WN0eHeHgCFFJu3RLm36PY04aC6qkwDc6ZxU
	U7admfSISh/MVnp9AM/FqeMwhIWI2xw10wB3A5Mql0dWP5SS4RjvakRl6uVTp4FuJNlIQdxLoxB
	kHPqD4n2VuksNiHqkcI1Ld6USWWkgRLIdIbSI4whUo8dnt2htdRVYz0LJUaBD7VWw3n9Irj1I1y
	vVnQPpIVa9fw0fZcCF21NfhOCLgmNNJi8oq1pFmK9V8RZasaYAn7I55POsVK2+hm4VlIH8TRcDH
	H5Pn/HRmirf6kxipSRstexG6LniHT783HhU8a84p70c5IaqMwXS9QwjaN8kX250msW+XQ=
X-Received: by 2002:a05:6a00:e1b:b0:82c:20e9:fa53 with SMTP id d2e1a72fcca58-82f0c1d9fc2mr6641580b3a.5.1775892844910;
        Sat, 11 Apr 2026 00:34:04 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c30f5c3sm4965388b3a.3.2026.04.11.00.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 00:34:04 -0700 (PDT)
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
	Puranjay Mohan <puranjay@kernel.org>
Subject: [PATCH bpf-next v2 4/4] selftests/bpf: inline TEST_TAG constants in test_loader.c
Date: Sat, 11 Apr 2026 00:33:47 -0700
Message-ID: <20260410-selftests-global-tags-ordering-v2-4-c566ec9781bf@gmail.com>
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

After str_has_pfx() refactoring each TEST_TAG_* / TEST_BTF_PATH
constant is used exactly once. Since constant definitions are not
shared between BPF-side bpf_misc.h and userspace side test_loader.c,
there is no need in the additional redirection layer.

Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>
Reviewed-by: Puranjay Mohan <puranjay@kernel.org>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/test_loader.c | 84 +++++++++++--------------------
 1 file changed, 28 insertions(+), 56 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index 066898d0c123..c4c34cae6102 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -21,34 +21,6 @@ static inline const char *str_has_pfx(const char *str, const char *pfx)
 
 #define TEST_LOADER_LOG_BUF_SZ 2097152
 
-#define TEST_TAG_EXPECT_FAILURE "test_expect_failure"
-#define TEST_TAG_EXPECT_SUCCESS "test_expect_success"
-#define TEST_TAG_EXPECT_MSG_PFX "test_expect_msg="
-#define TEST_TAG_EXPECT_NOT_MSG_PFX "test_expect_not_msg="
-#define TEST_TAG_EXPECT_XLATED_PFX "test_expect_xlated="
-#define TEST_TAG_EXPECT_FAILURE_UNPRIV "test_expect_failure_unpriv"
-#define TEST_TAG_EXPECT_SUCCESS_UNPRIV "test_expect_success_unpriv"
-#define TEST_TAG_EXPECT_MSG_PFX_UNPRIV "test_expect_msg_unpriv="
-#define TEST_TAG_EXPECT_NOT_MSG_PFX_UNPRIV "test_expect_not_msg_unpriv="
-#define TEST_TAG_EXPECT_XLATED_PFX_UNPRIV "test_expect_xlated_unpriv="
-#define TEST_TAG_LOG_LEVEL_PFX "test_log_level="
-#define TEST_TAG_PROG_FLAGS_PFX "test_prog_flags="
-#define TEST_TAG_DESCRIPTION_PFX "test_description="
-#define TEST_TAG_RETVAL_PFX "test_retval="
-#define TEST_TAG_RETVAL_PFX_UNPRIV "test_retval_unpriv="
-#define TEST_TAG_AUXILIARY "test_auxiliary"
-#define TEST_TAG_AUXILIARY_UNPRIV "test_auxiliary_unpriv"
-#define TEST_BTF_PATH "test_btf_path="
-#define TEST_TAG_ARCH "test_arch="
-#define TEST_TAG_JITED_PFX "test_jited="
-#define TEST_TAG_JITED_PFX_UNPRIV "test_jited_unpriv="
-#define TEST_TAG_CAPS_UNPRIV "test_caps_unpriv="
-#define TEST_TAG_LOAD_MODE_PFX "load_mode="
-#define TEST_TAG_EXPECT_STDERR_PFX "test_expect_stderr="
-#define TEST_TAG_EXPECT_STDERR_PFX_UNPRIV "test_expect_stderr_unpriv="
-#define TEST_TAG_EXPECT_STDOUT_PFX "test_expect_stdout="
-#define TEST_TAG_EXPECT_STDOUT_PFX_UNPRIV "test_expect_stdout_unpriv="
-#define TEST_TAG_LINEAR_SIZE "test_linear_size="
 
 /* Warning: duplicated in bpf_misc.h */
 #define POINTER_VALUE	0xbadcafe
@@ -478,49 +450,49 @@ static int parse_test_spec(struct test_loader *tester,
 		s = skip_decl_tag_pfx(tags[i]);
 		if (!s)
 			continue;
-		if ((val = str_has_pfx(s, TEST_TAG_DESCRIPTION_PFX))) {
+		if ((val = str_has_pfx(s, "test_description="))) {
 			description = val;
-		} else if (strcmp(s, TEST_TAG_EXPECT_FAILURE) == 0) {
+		} else if (strcmp(s, "test_expect_failure") == 0) {
 			spec->priv.expect_failure = true;
 			spec->mode_mask |= PRIV;
-		} else if (strcmp(s, TEST_TAG_EXPECT_SUCCESS) == 0) {
+		} else if (strcmp(s, "test_expect_success") == 0) {
 			spec->priv.expect_failure = false;
 			spec->mode_mask |= PRIV;
-		} else if (strcmp(s, TEST_TAG_EXPECT_FAILURE_UNPRIV) == 0) {
+		} else if (strcmp(s, "test_expect_failure_unpriv") == 0) {
 			spec->unpriv.expect_failure = true;
 			spec->mode_mask |= UNPRIV;
 			has_unpriv_result = true;
-		} else if (strcmp(s, TEST_TAG_EXPECT_SUCCESS_UNPRIV) == 0) {
+		} else if (strcmp(s, "test_expect_success_unpriv") == 0) {
 			spec->unpriv.expect_failure = false;
 			spec->mode_mask |= UNPRIV;
 			has_unpriv_result = true;
-		} else if (strcmp(s, TEST_TAG_AUXILIARY) == 0) {
+		} else if (strcmp(s, "test_auxiliary") == 0) {
 			spec->auxiliary = true;
 			spec->mode_mask |= PRIV;
-		} else if (strcmp(s, TEST_TAG_AUXILIARY_UNPRIV) == 0) {
+		} else if (strcmp(s, "test_auxiliary_unpriv") == 0) {
 			spec->auxiliary = true;
 			spec->mode_mask |= UNPRIV;
-		} else if ((msg = str_has_pfx(s, TEST_TAG_EXPECT_MSG_PFX))) {
+		} else if ((msg = str_has_pfx(s, "test_expect_msg="))) {
 			err = push_msg(msg, false, &spec->priv.expect_msgs);
 			if (err)
 				goto cleanup;
 			spec->mode_mask |= PRIV;
-		} else if ((msg = str_has_pfx(s, TEST_TAG_EXPECT_NOT_MSG_PFX))) {
+		} else if ((msg = str_has_pfx(s, "test_expect_not_msg="))) {
 			err = push_msg(msg, true, &spec->priv.expect_msgs);
 			if (err)
 				goto cleanup;
 			spec->mode_mask |= PRIV;
-		} else if ((msg = str_has_pfx(s, TEST_TAG_EXPECT_MSG_PFX_UNPRIV))) {
+		} else if ((msg = str_has_pfx(s, "test_expect_msg_unpriv="))) {
 			err = push_msg(msg, false, &spec->unpriv.expect_msgs);
 			if (err)
 				goto cleanup;
 			spec->mode_mask |= UNPRIV;
-		} else if ((msg = str_has_pfx(s, TEST_TAG_EXPECT_NOT_MSG_PFX_UNPRIV))) {
+		} else if ((msg = str_has_pfx(s, "test_expect_not_msg_unpriv="))) {
 			err = push_msg(msg, true, &spec->unpriv.expect_msgs);
 			if (err)
 				goto cleanup;
 			spec->mode_mask |= UNPRIV;
-		} else if ((msg = str_has_pfx(s, TEST_TAG_JITED_PFX))) {
+		} else if ((msg = str_has_pfx(s, "test_jited="))) {
 			if (arch_mask == 0) {
 				PRINT_FAIL("__jited used before __arch_*");
 				goto cleanup;
@@ -532,7 +504,7 @@ static int parse_test_spec(struct test_loader *tester,
 					goto cleanup;
 				spec->mode_mask |= PRIV;
 			}
-		} else if ((msg = str_has_pfx(s, TEST_TAG_JITED_PFX_UNPRIV))) {
+		} else if ((msg = str_has_pfx(s, "test_jited_unpriv="))) {
 			if (arch_mask == 0) {
 				PRINT_FAIL("__unpriv_jited used before __arch_*");
 				goto cleanup;
@@ -544,36 +516,36 @@ static int parse_test_spec(struct test_loader *tester,
 					goto cleanup;
 				spec->mode_mask |= UNPRIV;
 			}
-		} else if ((msg = str_has_pfx(s, TEST_TAG_EXPECT_XLATED_PFX))) {
+		} else if ((msg = str_has_pfx(s, "test_expect_xlated="))) {
 			err = push_disasm_msg(msg, &xlated_on_next_line,
 					      &spec->priv.expect_xlated);
 			if (err)
 				goto cleanup;
 			spec->mode_mask |= PRIV;
-		} else if ((msg = str_has_pfx(s, TEST_TAG_EXPECT_XLATED_PFX_UNPRIV))) {
+		} else if ((msg = str_has_pfx(s, "test_expect_xlated_unpriv="))) {
 			err = push_disasm_msg(msg, &unpriv_xlated_on_next_line,
 					      &spec->unpriv.expect_xlated);
 			if (err)
 				goto cleanup;
 			spec->mode_mask |= UNPRIV;
-		} else if ((val = str_has_pfx(s, TEST_TAG_RETVAL_PFX))) {
+		} else if ((val = str_has_pfx(s, "test_retval="))) {
 			err = parse_retval(val, &spec->priv.retval, "__retval");
 			if (err)
 				goto cleanup;
 			spec->priv.execute = true;
 			spec->mode_mask |= PRIV;
-		} else if ((val = str_has_pfx(s, TEST_TAG_RETVAL_PFX_UNPRIV))) {
+		} else if ((val = str_has_pfx(s, "test_retval_unpriv="))) {
 			err = parse_retval(val, &spec->unpriv.retval, "__retval_unpriv");
 			if (err)
 				goto cleanup;
 			spec->mode_mask |= UNPRIV;
 			spec->unpriv.execute = true;
 			has_unpriv_retval = true;
-		} else if ((val = str_has_pfx(s, TEST_TAG_LOG_LEVEL_PFX))) {
+		} else if ((val = str_has_pfx(s, "test_log_level="))) {
 			err = parse_int(val, &spec->log_level, "test log level");
 			if (err)
 				goto cleanup;
-		} else if ((val = str_has_pfx(s, TEST_TAG_PROG_FLAGS_PFX))) {
+		} else if ((val = str_has_pfx(s, "test_prog_flags="))) {
 			clear = val[0] == '!';
 			if (clear)
 				val++;
@@ -598,7 +570,7 @@ static int parse_test_spec(struct test_loader *tester,
 					goto cleanup;
 				update_flags(&spec->prog_flags, flags, clear);
 			}
-		} else if ((val = str_has_pfx(s, TEST_TAG_ARCH))) {
+		} else if ((val = str_has_pfx(s, "test_arch="))) {
 			if (strcmp(val, "X86_64") == 0) {
 				arch = ARCH_X86_64;
 			} else if (strcmp(val, "ARM64") == 0) {
@@ -616,14 +588,14 @@ static int parse_test_spec(struct test_loader *tester,
 			collect_jit = get_current_arch() == arch;
 			unpriv_jit_on_next_line = true;
 			jit_on_next_line = true;
-		} else if ((val = str_has_pfx(s, TEST_BTF_PATH))) {
+		} else if ((val = str_has_pfx(s, "test_btf_path="))) {
 			spec->btf_custom_path = val;
-		} else if ((val = str_has_pfx(s, TEST_TAG_CAPS_UNPRIV))) {
+		} else if ((val = str_has_pfx(s, "test_caps_unpriv="))) {
 			err = parse_caps(val, &spec->unpriv.caps, "test caps");
 			if (err)
 				goto cleanup;
 			spec->mode_mask |= UNPRIV;
-		} else if ((val = str_has_pfx(s, TEST_TAG_LOAD_MODE_PFX))) {
+		} else if ((val = str_has_pfx(s, "load_mode="))) {
 			if (strcmp(val, "jited") == 0) {
 				load_mask = JITED;
 			} else if (strcmp(val, "no_jited") == 0) {
@@ -633,27 +605,27 @@ static int parse_test_spec(struct test_loader *tester,
 				err = -EINVAL;
 				goto cleanup;
 			}
-		} else if ((msg = str_has_pfx(s, TEST_TAG_EXPECT_STDERR_PFX))) {
+		} else if ((msg = str_has_pfx(s, "test_expect_stderr="))) {
 			err = push_disasm_msg(msg, &stderr_on_next_line,
 					      &spec->priv.stderr);
 			if (err)
 				goto cleanup;
-		} else if ((msg = str_has_pfx(s, TEST_TAG_EXPECT_STDERR_PFX_UNPRIV))) {
+		} else if ((msg = str_has_pfx(s, "test_expect_stderr_unpriv="))) {
 			err = push_disasm_msg(msg, &unpriv_stderr_on_next_line,
 					      &spec->unpriv.stderr);
 			if (err)
 				goto cleanup;
-		} else if ((msg = str_has_pfx(s, TEST_TAG_EXPECT_STDOUT_PFX))) {
+		} else if ((msg = str_has_pfx(s, "test_expect_stdout="))) {
 			err = push_disasm_msg(msg, &stdout_on_next_line,
 					      &spec->priv.stdout);
 			if (err)
 				goto cleanup;
-		} else if ((msg = str_has_pfx(s, TEST_TAG_EXPECT_STDOUT_PFX_UNPRIV))) {
+		} else if ((msg = str_has_pfx(s, "test_expect_stdout_unpriv="))) {
 			err = push_disasm_msg(msg, &unpriv_stdout_on_next_line,
 					      &spec->unpriv.stdout);
 			if (err)
 				goto cleanup;
-		} else if ((val = str_has_pfx(s, TEST_TAG_LINEAR_SIZE))) {
+		} else if ((val = str_has_pfx(s, "test_linear_size="))) {
 			switch (bpf_program__type(prog)) {
 			case BPF_PROG_TYPE_SCHED_ACT:
 			case BPF_PROG_TYPE_SCHED_CLS:

-- 
2.53.0
