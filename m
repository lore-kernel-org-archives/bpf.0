Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289DE3016F1
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 01:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774918844; cv=none; b=r3Q52IjDmr+lqWq3tyFHC0w+LEz9xJLRTzosspWVbCmJ8KdRjtaEm3lYGljaJL2QxogrE6Daqwdc0h2ppScp0PqWHXurG+XQWJKQE1l6oarESB79qS/XcuRWWGsfz0n3NORFwBrXUTMjImkgS3jYZidPyYUq72zEzNWzasUzfng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774918844; c=relaxed/simple;
	bh=gqOG2H9tIzjXCbBiXNqszJkk8lgegHfRVYL42rIwta0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tUrcA/klBiXO+BKsD986GV6XdqkdgXebw1/nlkWLNAxXN/WjgoeTVfa+mw2OyvYHnLHrcyjhJxHkkFnXCGh/Ow5F2zjHK8Mujhh6DmBf1zLeruaa9iWR0OvESYeS47vLPNp/eD/RpwLex0MsZONaN9lqmr1pXnC7UbvYF3OuEe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r5UFSGXV; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r5UFSGXV"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2b2469e5117so12575555ad.1
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 18:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774918842; x=1775523642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+0D6AGZNWSqk4ee4mBNXimtW9mQuxwZj3WYAzDfyk6I=;
        b=r5UFSGXVbUm4hQZT4k435WcrA0GURyg73LZ/COmBCtzC10KdrIpSS8v6eHKJmHarLK
         ZgVd92/YNrOGpkOrPpBWmJMfZR5LtwszBm205EIeWjLYW8PCuBExGRslWQEdS8DiVjTs
         Q0i78Etjgk9YfQEdw1/GFAWv17cM42nKaSHTnbiSYQDHfES2+3X17GC3acnb5522Hx1b
         n93hx4ZXY/n1mVeZXEvVLhEhR9Vgp69jUEKIiJbf77xSkAPrs4I7E7bsUgLIJO/sniKa
         NsWXC6/jp7ahdisZ4HEFEp0mel4CA1rua64vHRofcXm5QAqpHL5CWYIouHMnz1/lPOXk
         s7Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774918842; x=1775523642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+0D6AGZNWSqk4ee4mBNXimtW9mQuxwZj3WYAzDfyk6I=;
        b=ZsHC9euSAaVCThQkusiDjiYqWJPMUvG/o1fnXpdiif9eJic+wGTM+Kml9MyK8ysnPy
         h4m3Fpt7SIKZm+R7gNYO1ayLcvrZaKNczgWIYzqq5HyLrqRI/tDi4sLIxFuTGNQobHu4
         e9o89qKIFTFpZLsfx8iuurn4SeTmHz9BnDiQNS1SbnIrAEOZJPch/RH/8PeLuygZ1ysQ
         w1vRU/NICmvClxZyFIOltKspB8sCV4K5jTGwtiRa2c3wrcroCNguSNob6soQaEj3FUOB
         7Niwl84dtKKT2BA8rhrxG34nfgHz4qhyGoqQ3hH2W+KC2FhCA8KIx9qzdKZUnIbE2VO7
         d1ow==
X-Gm-Message-State: AOJu0YyXY2LORg0lHHWkq76fIGgfzJSZCrz1ovMGDcMyXn9xrzgOuPQP
	+QKWRDYDEV1PTtO66gHlh4kJft1IWeAF3/FD3rVOA7CYc788dBU0Ql3S6/vcyw==
X-Gm-Gg: ATEYQzz9iiByMFjZ1aQpC9N7W0Qh39XMaxX/TtwBeEwM+lYLkG2ueCtPp2Z/uZ51wow
	PTgjHDLb4SMfvt74mACwu7Et0N1VjZ0r1pa/NUAqs+90iygLtd/8FnqSagz/p6ok1yYwGWTNhwP
	BBFlc3L9wR4CNLrpeI1NaI0/TZtmhjKan8CEKQPWVUhGaqaWCC2Qy3B+w5w8srlibDifg7ZwUzG
	kvaUXqs/ZXPurtHw8HvX5OOc/C8wX8xjLZ5d+PwALKV9K62Hk06CNIb/JQhUgI6Xarsj9Q0JZEh
	gkMDBHUXtlFo+UUBllJAg9PWmGbw37AqM6ciW9Doo4VjWVq7aWNd11j4qaQLwIcbf3t5VFB3mOH
	dmFvby1GKIWbi7Tqw+0gT09Q202SlJ1RiwsGtqMrkMaliilgemz6iCJSyczB0KtjSqHrR6DfMUg
	aYA2BxZeGunLzL6u+BiFRqD2BA4AG7QnqQMrgNfAAcl1LJxBbJLY5z3kRhP5E=
X-Received: by 2002:a17:903:2291:b0:2ae:5350:3a4e with SMTP id d9443c01a7336-2b25ef4149bmr12441765ad.21.1774918842129;
        Mon, 30 Mar 2026 18:00:42 -0700 (PDT)
Received: from honey-badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427a27f2sm125226405ad.67.2026.03.30.18.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 18:00:41 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 4/4] selftests/bpf: inline TEST_TAG constants in test_loader.c
Date: Mon, 30 Mar 2026 17:59:27 -0700
Message-ID: <20260330-selftests-global-tags-ordering-v2-4-c0ac61e81098@gmail.com>
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

After str_has_pfx() refactoring each TEST_TAG_* / TEST_BTF_PATH
constant is used exactly once. Since constant definitions are not
shared between BPF-side bpf_misc.h and userspace side test_loader.c,
there is no need in the additional redirection layer.

Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/test_loader.c | 84 +++++++++++--------------------
 1 file changed, 28 insertions(+), 56 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index 3f784cc76f8f532b1c110ae3b784cd8ec1ebcf9b..f55410e478ce1f4e0352cb2a0c05a493178ec756 100644
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
@@ -473,49 +445,49 @@ static int parse_test_spec(struct test_loader *tester,
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
@@ -527,7 +499,7 @@ static int parse_test_spec(struct test_loader *tester,
 					goto cleanup;
 				spec->mode_mask |= PRIV;
 			}
-		} else if ((msg = str_has_pfx(s, TEST_TAG_JITED_PFX_UNPRIV))) {
+		} else if ((msg = str_has_pfx(s, "test_jited_unpriv="))) {
 			if (arch_mask == 0) {
 				PRINT_FAIL("__unpriv_jited used before __arch_*");
 				goto cleanup;
@@ -539,36 +511,36 @@ static int parse_test_spec(struct test_loader *tester,
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
@@ -593,7 +565,7 @@ static int parse_test_spec(struct test_loader *tester,
 					goto cleanup;
 				update_flags(&spec->prog_flags, flags, clear);
 			}
-		} else if ((val = str_has_pfx(s, TEST_TAG_ARCH))) {
+		} else if ((val = str_has_pfx(s, "test_arch="))) {
 			if (strcmp(val, "X86_64") == 0) {
 				arch = ARCH_X86_64;
 			} else if (strcmp(val, "ARM64") == 0) {
@@ -611,14 +583,14 @@ static int parse_test_spec(struct test_loader *tester,
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
@@ -628,27 +600,27 @@ static int parse_test_spec(struct test_loader *tester,
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
