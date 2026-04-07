Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com [209.85.210.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36F133B955
	for <bpf@vger.kernel.org>; Tue,  7 Apr 2026 14:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775573771; cv=none; b=pVbmTvgEU6PatxpYzVF8AaDWi7JfjHHmnsxLUngmoaEidRB1D1ruI73i9BEUULrHvjAV2fM9rQ7NwH+gjRaPdIlHhabLjKLjigcxenvPox3/njAWLq0YsGBbvWUDzXXEwmbOE7gxK5i9Xrm0YMWpSuFZF76c8XQC5K59U9WNjk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775573771; c=relaxed/simple;
	bh=qCYfOmSCaPmOErrgA4qePK+1U+dGuHhl1pu4V7M3w90=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sTAtIp5l0HvIvaUTXuvFh5GSWHlzgaYqk4vU5l1oBEXsNXWIn5fKDmmKEo1NReZQG/ZDLpVQBqBQ4JFvCCuLJwOzGF+xxrcbtb7WCeTJMmYhIqmVdP4q4H0njLCAo1LeO8veYaYMErpTE4+iQhfNlifO17f0RQJ9TFLL5k85U4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oluHb/er; arc=none smtp.client-ip=209.85.210.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oluHb/er"
Received: by mail-ot1-f66.google.com with SMTP id 46e09a7af769-7d1872504cbso4824913a34.0
        for <bpf@vger.kernel.org>; Tue, 07 Apr 2026 07:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775573768; x=1776178568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c3ncy1k7bShaBlNIuL45mxkdLauBJXx36ogaP05C2zk=;
        b=oluHb/erq+ClsQJhtOf9iDRAhBzZlPB57gg5b3FfgfXPvBcN1EhEY6lZtSLoxifChD
         c3Cyl5p1TbhrcTCTSMFqCn1IQwBmwRgd38T/MqjVaa+a3P9Wag8ELQSaTv3Wneoj+ymS
         5BpqWkGQyw7I/ozf43yikEWl0KGAwRDBBwOoYx4VyqDsMO1wCMv4dpCQwvg1NNAWksO8
         Kia6K9pOl5M15CwsoEGUcFoNwk6xOKghyNypWzF2S8rYE03ma+32ymqsHqszihHZNQI5
         I3Z0/T7ntxuH2bd+fesJPkMLBHtLMUjb7vTWNTV1IpdWfDoq85G+N1J7Hr5FetZVphe4
         2BAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775573768; x=1776178568;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c3ncy1k7bShaBlNIuL45mxkdLauBJXx36ogaP05C2zk=;
        b=DJRadrGvIVA2ymvNEBu4YqpX/ty6HgQdU/grZw9YA1Axp6G6DdP4G3vSPmglIXza1h
         tPKVZXNbes4AgyX2KyWQeZHYy9ItZLoc51UaKis+4IfU4K9qCilcW+WwSeO+FI5es8J8
         MNv1bmSBIOX3LSnAhYQrpBTG8OazdZKYqYWySpiog1Z6VrUIFlCCPpd1AfdDSZ+ReZSj
         wMgmAKXfHs0ILZSjoHpRGqMZx0hTUYWHvxJK38vMT9cwnLqmv+JH0ui1ZQr/oGIyO087
         hxpjxdK1EmMtnQ9uWCJYGYoSfEab6cdRRUQuexhowBBPYyt4kofqgjjWaXGPG7M9BZkz
         ICSA==
X-Gm-Message-State: AOJu0YyqoX7PCQ1636vxnsnhwhPf87e04253YJu7THJmS7AGX794+EB3
	sup9ofb4hO38P9jntAQ6O4znEHy9LtqH1Yi5dkY0Ee3HGYojOKqDzo6qTNHJ8IojB+0=
X-Gm-Gg: AeBDiesBlM6KVOa2tb5h+Tc1VEArUbh/g4ERxiBxTHElTq1CfTNQoOECm3zU0l7DKFU
	cd0vAomdvd29QCjCEjzk3Zagfw6spEWh9SYKFdiPq4BCr6Vi9HB6pW14Mgyr+r6DEAqEU8UIjFS
	E1662Lp4TGVuOP9LgZ8wfsJl8Lddhy959rxJvk7hvU/VBwY3WfHq+0MVb9wx0JK6auH+foOotVx
	s1qZXY4fOCht03mWsgW51DB+aam6GB5rAHv38vL+EimCM8otv5L+zT3blXb8aJpqVPAzMTGphDb
	yR+TJS/QQGwfQ3b/bGIWCYKzzSVNkVI1i8rkGU/PvdGi6MC1LLI5tqW6RGYNqQuiZR1i2mSaL5u
	mmxZq26ltSNYMBJRm+OT5ski7Hc4J1tZ4uowNVXEd7EgBsla1HIJCD2fM/eWD+n6nJPzbMcoom8
	tOH3OK+6bRqCXFkEtxG8Tsc+9/hEnHcBtFtMJg701Lj1qL
X-Received: by 2002:a05:6830:33ed:b0:7db:f3e9:c26d with SMTP id 46e09a7af769-7dbf3e9c4b8mr1852218a34.5.1775573768273;
        Tue, 07 Apr 2026 07:56:08 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:49::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dba72febcdsm12987992a34.18.2026.04.07.07.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 07:56:07 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1] selftests/bpf: Allow prog name matching for tests with __description
Date: Tue,  7 Apr 2026 16:56:06 +0200
Message-ID: <20260407145606.3991770-1-memxor@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8135; h=from:subject; bh=PLBI+crqHMKmm2tQKodBD9tCC7QaVvPKQ/eLGbNUJvA=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIfOqFJcTc9TqSvb9385vTd/1ZZOxU9aiEOsbSW9tTZmOiFRv tQzpKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwETa9jL8j3/p9kOxZN/2I8wPt6+fM3 Pf0XQzZ+Nih8b1FxaXZUhNUGJkeOBvfse8ns1my0+3G9cKBXoFdqscZTuatUY3Y03+Nd2lnAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

For tests that carry a __description tag, allow matching on both the
description string and program name for convenience. Before this commit,
the description string must be spelt out to filter the tests.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h |  4 +-
 tools/testing/selftests/bpf/test_loader.c    | 46 ++++++++++++++++----
 tools/testing/selftests/bpf/test_progs.c     | 45 +++++++++++++++----
 tools/testing/selftests/bpf/test_progs.h     |  1 +
 4 files changed, 76 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index 0904fe14ad1d..4b313374c5f1 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -103,8 +103,8 @@
  *                   - TEST_DATA_LEN
  * __retval_unpriv   Same, but load program in unprivileged mode.
  *
- * __description     Text to be used instead of a program name for display
- *                   and filtering purposes.
+ * __description     Text to be used for display and as an additional filter
+ *                   alias, while the original program name stays matchable.
  *
  * __log_level       Log level to use for the program, numeric value expected.
  *
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index 338c035c3688..96ed70e01fe5 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -69,6 +69,7 @@ enum load_mode {

 struct test_subspec {
 	char *name;
+	char *description;
 	bool expect_failure;
 	struct expected_msgs expect_msgs;
 	struct expected_msgs expect_xlated;
@@ -142,9 +143,13 @@ static void free_test_spec(struct test_spec *spec)
 	free_msgs(&spec->priv.stdout);

 	free(spec->priv.name);
+	free(spec->priv.description);
 	free(spec->unpriv.name);
+	free(spec->unpriv.description);
 	spec->priv.name = NULL;
+	spec->priv.description = NULL;
 	spec->unpriv.name = NULL;
+	spec->unpriv.description = NULL;
 }

 /* Compiles regular expression matching pattern.
@@ -659,33 +664,56 @@ static int parse_test_spec(struct test_loader *tester,
 	if (spec->mode_mask == 0)
 		spec->mode_mask = PRIV;

-	if (!description)
-		description = spec->prog_name;
-
 	if (spec->mode_mask & PRIV) {
-		spec->priv.name = strdup(description);
+		spec->priv.name = strdup(spec->prog_name);
 		if (!spec->priv.name) {
 			PRINT_FAIL("failed to allocate memory for priv.name\n");
 			err = -ENOMEM;
 			goto cleanup;
 		}
+
+		if (description) {
+			spec->priv.description = strdup(description);
+			if (!spec->priv.description) {
+				PRINT_FAIL("failed to allocate memory for priv.description\n");
+				err = -ENOMEM;
+				goto cleanup;
+			}
+		}
 	}

 	if (spec->mode_mask & UNPRIV) {
-		int descr_len = strlen(description);
+		int name_len = strlen(spec->prog_name);
 		const char *suffix = " @unpriv";
+		int suffix_len = strlen(suffix);
 		char *name;

-		name = malloc(descr_len + strlen(suffix) + 1);
+		name = malloc(name_len + suffix_len + 1);
 		if (!name) {
 			PRINT_FAIL("failed to allocate memory for unpriv.name\n");
 			err = -ENOMEM;
 			goto cleanup;
 		}

-		strcpy(name, description);
-		strcpy(&name[descr_len], suffix);
+		strcpy(name, spec->prog_name);
+		strcpy(&name[name_len], suffix);
 		spec->unpriv.name = name;
+
+		if (description) {
+			int descr_len = strlen(description);
+			char *descr;
+
+			descr = malloc(descr_len + suffix_len + 1);
+			if (!descr) {
+				PRINT_FAIL("failed to allocate memory for unpriv.description\n");
+				err = -ENOMEM;
+				goto cleanup;
+			}
+
+			strcpy(descr, description);
+			strcpy(&descr[descr_len], suffix);
+			spec->unpriv.description = descr;
+		}
 	}

 	if (spec->mode_mask & (PRIV | UNPRIV)) {
@@ -1148,7 +1176,7 @@ void run_subtest(struct test_loader *tester,
 	int links_cnt = 0;
 	bool should_load;

-	if (!test__start_subtest(subspec->name))
+	if (!test__start_subtest_with_desc(subspec->name, subspec->description))
 		return;

 	if ((get_current_arch() & spec->arch_mask) == 0) {
diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 0929f4a7bda4..7fe16b5131b1 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -308,16 +308,34 @@ static bool match_subtest(struct test_filter_set *filter,
 	return false;
 }

+static bool match_subtest_desc(struct test_filter_set *filter,
+			       const char *test_name,
+			       const char *subtest_name,
+			       const char *subtest_desc)
+{
+	if (match_subtest(filter, test_name, subtest_name))
+		return true;
+
+	if (!subtest_desc || !subtest_desc[0] ||
+	    strcmp(subtest_name, subtest_desc) == 0)
+		return false;
+
+	return match_subtest(filter, test_name, subtest_desc);
+}
+
 static bool should_run_subtest(struct test_selector *sel,
 			       struct test_selector *subtest_sel,
 			       int subtest_num,
 			       const char *test_name,
-			       const char *subtest_name)
+			       const char *subtest_name,
+			       const char *subtest_desc)
 {
-	if (match_subtest(&sel->blacklist, test_name, subtest_name))
+	if (match_subtest_desc(&sel->blacklist, test_name,
+			       subtest_name, subtest_desc))
 		return false;

-	if (match_subtest(&sel->whitelist, test_name, subtest_name))
+	if (match_subtest_desc(&sel->whitelist, test_name,
+			       subtest_name, subtest_desc))
 		return true;

 	if (!sel->whitelist.cnt && !subtest_sel->num_set)
@@ -544,11 +562,12 @@ void test__end_subtest(void)
 	env.subtest_state = NULL;
 }

-bool test__start_subtest(const char *subtest_name)
+bool test__start_subtest_with_desc(const char *subtest_name, const char *subtest_desc)
 {
 	struct prog_test_def *test = env.test;
 	struct test_state *state = env.test_state;
 	struct subtest_state *subtest_state;
+	const char *subtest_display_name;
 	size_t sub_state_size = sizeof(*subtest_state);

 	if (env.subtest_state)
@@ -574,7 +593,9 @@ bool test__start_subtest(const char *subtest_name)
 		return false;
 	}

-	subtest_state->name = strdup(subtest_name);
+	subtest_display_name = subtest_desc ? subtest_desc : subtest_name;
+
+	subtest_state->name = strdup(subtest_display_name);
 	if (!subtest_state->name) {
 		fprintf(env.stderr_saved,
 			"Subtest #%d: failed to copy subtest name!\n",
@@ -586,14 +607,15 @@ bool test__start_subtest(const char *subtest_name)
 				&env.subtest_selector,
 				state->subtest_num,
 				test->test_name,
-				subtest_name)) {
+				subtest_name,
+				subtest_desc)) {
 		subtest_state->filtered = true;
 		return false;
 	}

-	subtest_state->should_tmon = match_subtest(&env.tmon_selector.whitelist,
-						   test->test_name,
-						   subtest_name);
+	subtest_state->should_tmon = match_subtest_desc(&env.tmon_selector.whitelist,
+							test->test_name, subtest_name,
+							subtest_desc);

 	env.subtest_state = subtest_state;
 	stdio_hijack_init(&subtest_state->log_buf, &subtest_state->log_cnt);
@@ -602,6 +624,11 @@ bool test__start_subtest(const char *subtest_name)
 	return true;
 }

+bool test__start_subtest(const char *subtest_name)
+{
+	return test__start_subtest_with_desc(subtest_name, NULL);
+}
+
 void test__force_log(void)
 {
 	env.test_state->force_log = true;
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index eebfc18cdcd2..1a44467f4310 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -181,6 +181,7 @@ struct msg {
 extern struct test_env env;

 void test__force_log(void);
+bool test__start_subtest_with_desc(const char *name, const char *description);
 bool test__start_subtest(const char *name);
 void test__end_subtest(void);
 void test__skip(void);
--
2.52.0

