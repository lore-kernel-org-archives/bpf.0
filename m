Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6260B29ACDB
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 17:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774546797; cv=none; b=lHfMtOG8/ShWmVQcWUzh0LHPlWXaAmGvXgXF2bAVOkCN3OItAbs6SLbE/sr5QLEa9X7csAA/DUTeodTJqJm8bWgry71aFUTOyCkCCCmQKVU7VLCV/l+4QUQe4F+3s8PME4YM4NbWAlo7+fyZWE/++nHyQ/fcSaRQGwBAlfr4TIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774546797; c=relaxed/simple;
	bh=suKZQSnYKLNAGF05Cpu+HRhGY84Z7qkBpgc6bca+vbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dp6Vynu6k91PuPKdNKxx2ICmGaQ4sSijUNQ1Rrp3mmn53FRzXkuCc3ogWBF6WN4NTVI/X2MWqyrseJnP2Jas6cGWaLLPGnISBQ8uV+lCAZlP4vNKmlihHLpma6gE2YwjubqFIsn8ayi48u6tZFrFcQgF8OSxN3461YFZwv8EmQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bzJ+Mdc6; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bzJ+Mdc6"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2b6b0500e06so1705360eec.1
        for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 10:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774546794; x=1775151594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yYsKnVhHDlnsNdQHCxP48bUpmVp4KHyjK/oLPwRaldw=;
        b=bzJ+Mdc6EbKSJqaKTtXE8CGVIjcZRcjAoOUmZpNhgnnpwKVPSmGpsOWJayauePWrz9
         MQjYf2plma80gFHm/x6VzeqyWVZ1l0A5H0gqklanzraUsZLUYmgELSyn0breoUPPPD10
         LkerRESrEXoNw7I4UILxeiSB2w6AGgBwxGRHtj5B2tS+l6ARDD5sheTIsnwoq0epqN97
         EvYpmc9bjNct5vJRzO39tDmMyfOdTsci9OIw6y0q6Ma6YvnFsfwqJHromxvD/wqLGBow
         XNAv6oLDIVhtVW/WMK4zGnNdPykD2JXDCIdEyDEYi3dza0RkFaLrxbUFPp8cOo0uBsmD
         +iiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774546794; x=1775151594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yYsKnVhHDlnsNdQHCxP48bUpmVp4KHyjK/oLPwRaldw=;
        b=B1XIlpBySY9Bl7vAlB430ioMmaZSnVXHrgn8pXdH19iqpumZdh5eqX0beDURXqXb5A
         ttOrWGd6YwnqCKOymmw8JHP+72to4XrzeWFeAP7W1cFaoa/DHWh148OJk8KMR+Cl6Tm9
         /mujCcE+Dy2ziimH2xWLgHcAvzrgAeNYzK9fqVE5dQw6alr5/8A94+t7t3Kuf67P06HB
         wuTIRayrCegflId/Vch5i0xogYS7lqROrjqaf9TSpF9THKxatKAaehXwSz1LxSK2lhDv
         sakrBLWY5Vxk0nAFFkCtF4bCKHsVp5GZPMBpP9tOlKiIjNkXQFrRosS+rRihQMu1Eiqg
         5rqA==
X-Gm-Message-State: AOJu0YxFvOONkaUih0I2QTC+DfqEByZ1xDm2krvXs9Lt/wCunOtHYUTF
	NiMjUy5bpwiYdYkuJoEUiTr99OhJ6QJAgHAXEnIA+MNTcBzyCU65wLag2NNMkK+H
X-Gm-Gg: ATEYQzxm62YV5QyNMiKqtQ9jyioYqQ68lmFqZc5+GGQVe93QWc2r0T3uJrxQ3caHrKX
	krpAFuxX94jxwRgAUyWxp1DnX23WTn93tRpSjVM0I9ZC/6v27EK54x7YoBWU15akWdR1zihlS4S
	YTY71kd1WCQ7MPAmKM56orGGI3r35YlT93+SuKmrnaIWDWr0WpC47aI1SdjGmsHWiK6xuFacvBM
	ojfunqrLlVGqs3mxknV/f1xLCRle0qUaQAO62mWmDa3eUDvnD7Dofa68mZfp6pRzzrUhBJDf4pD
	VyhDVsz6PRNaMDaul0YIEsab7kuurA3+nKKKPqob2nUlO64rC0nBuXvkGIxBIIfMZ58uO3oWHpW
	OyGNlGyBOM2eiRiPeHf4RAv7Vd6qYUu+NAFv4G4c9PUvz1JIWaL6G5nBo9cFNTWwEqrrMhIdEpC
	nOiFDRy/ZAIr8KcMrH6ksFvbq9/aHPQxrny221EO+Z16WeeqOwsNZDgd97BCjQYLO79Calo/sh1
	BwJZmk=
X-Received: by 2002:a05:7301:4194:b0:2c1:1dea:c443 with SMTP id 5a478bee46e88-2c15d3a3232mr4267080eec.19.1774546794225;
        Thu, 26 Mar 2026 10:39:54 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::1:634a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c16ec47293sm3075711eec.9.2026.03.26.10.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 10:39:53 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	cupertino.miranda@oracle.com
Subject: [PATCH 4/4] selftests/bpf: inline TEST_TAG constants in test_loader.c
Date: Thu, 26 Mar 2026 10:39:36 -0700
Message-ID: <20260326-selftests-global-tags-ordering-v1-4-5dd2ced5d9ad@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326-selftests-global-tags-ordering-v1-0-5dd2ced5d9ad@gmail.com>
References: <20260326-selftests-global-tags-ordering-v1-0-5dd2ced5d9ad@gmail.com>
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

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/test_loader.c | 84 +++++++++++--------------------
 1 file changed, 28 insertions(+), 56 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index 2779f0ecf0ada9985a5b1dfbc049c0d0ed824a76..6a2211f21fe13b37e0dacb62f404b8aedc5bcd58 100644
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
