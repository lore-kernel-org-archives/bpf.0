Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22E542314A
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 17:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774546794; cv=none; b=HpR1Vu8HWwcumO0IoShAw/m6gdHDTOybRjHuidw0YGSkO4V8tV30JUY136eQVgQyWgE6TfOwgXSEZozI4ZsW/WqCUZBqUjdDb+emM+0vKkvFDjwprkN6oC09tknts6weayFY+tDuwR+O2A4yi1T07ev47iA51oe55CD7ez12cMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774546794; c=relaxed/simple;
	bh=xVZRYVseSgRfPr2Gvvp0wLrcukaiPmbDAMsmFa8p5zQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pUniSJyTUhDRk7OsO6tDQZ+ph1kyocHT0c+B6ShcFVGXhccCIXtzB+iKuWBVMNLji4sc/oPZMSXIrCLdsIePS3XH6If54lY+5xyzb6ULh92X5Rv7IN7T1K7ZrqyySdJleEIM4TH9HjwrYQrVNh0Wgb1t4mUhKVJAQQtzeKW23Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dh0T+Ot+; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dh0T+Ot+"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2c0fa90d47bso1166156eec.0
        for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 10:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774546792; x=1775151592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YzDkviCvOqGvJqiJHM9WwOT4J/I3tIygy1O6BN8LyWo=;
        b=dh0T+Ot+JlN6BElKYl5ELXY2jMDMfTcK7E+/Bcfv+LmQqVgHre02ljmYH//mdDK2Iy
         T28Q/v8u/ZfUIOnsluik5/b+2e98EXYPljHjfgji2C+rPBvUJ0ypBLgJahEuoCVlc4c5
         oDeFAAun3h4pB4MQJiKqgbcgji9BtHhzchr5nQgNA7nKa9oXB+2rL1XLX3GzxXv2rHzJ
         /sYbSVGDssxZUKIJA4zuwObha3vWxOwK/Qm62gbOncGmBxMPR6g7LihdSFHha+Aaddm3
         Bot8YQ0Vh/bQPis8QpHXYqFKp3hKxK2OhVdwCrooCkc3lohz0Mw2JJs6jevJKS6RI1vw
         VJOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774546792; x=1775151592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YzDkviCvOqGvJqiJHM9WwOT4J/I3tIygy1O6BN8LyWo=;
        b=RGWoDEPxNHl1X6Z/ohIELDvZxbVfcD+qvQQYWfh7w5zBVmxpyqtNxgEIfLv6gKHSqW
         3CE8Ktwbpi3UtIlXN7FAlBw/jlQfuyDjJvnArAmDZ5j00WdzKwJAVFVZ4gVZ12sLZsTO
         JFSbt+0fW9Bzo/gFSriuW6nST2X0ycc395IxcXBou2lfh6hCWVxepHbFq2bOvm+srnO1
         u1XNA7n/Z8Eioabw4X4SV6XHTuzZZzNaVIHNfgM/zFgZ7zOua9vz6ZQrAnEV1R8B3VGm
         Dp8OMxz7B1dszvFc3ScZATEfyFLYh+Og8JmfN559vz4aF29RtLEthDRSjNHhOdZ0qSJ9
         sjtw==
X-Gm-Message-State: AOJu0YzEDM/X0ht0n8ATk7tSUqHZqLjjlwefcQwbXPHQvghNtCGejNiH
	cCfgbkpp1S1hP8yYUE1BWIoj/P6TRdyywiwwtzwuVm/PrGPQDb2/FX0oQxqUXZ9U
X-Gm-Gg: ATEYQzxjiH25g5b3clSqATG9gFO6CQAIT1aAOMKTr6RXP5KxFx8YVvUN5HjV5Wy6Lh8
	IEMSgZTAmB9lxCfH2brdKOdIp5tfkQq5RP66OoD9GmhFVvdjHBf/0UTwUnow4iLnIQ77DWdLve9
	rRO6bUM8bY48FkyyA/1EdUFTw1gMjL0CMOfB37ZLNW5XQnYV9HXjiFY5HVsQAd5i8dBGtjAqodB
	APwY4A3JEIoiqzRTOkyccNfpSm/4jpsDq28Sj905bBvex1GLUt56nBHuGCtxhjQzgEKw6p3Kvbc
	0JLsRPr9R2XgClf9mm7IQDX6JgjQK+nuRcfeOViZb/NIKLXR1jgXsK+Mca/20/Ckpxz9dmxyLYV
	uZELV0JmgWcx9jy+Z/GLiZWfR52A9llU0LnudFrQW9QndPf3RWJ/VXUWLhVzkkl6OCenSgBCXld
	42a4MOr3PJx5+lY0UoN1XK2UA+XBdg1G5BcwC3fbVZTP4lagAr1J/oilxU0JeK8k41KlQjNeLGo
	VXsiEY=
X-Received: by 2002:a05:693c:2c8d:b0:2be:b20a:9b69 with SMTP id 5a478bee46e88-2c17723bdb8mr1446417eec.12.1774546791500;
        Thu, 26 Mar 2026 10:39:51 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::1:634a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c16ec47293sm3075711eec.9.2026.03.26.10.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 10:39:51 -0700 (PDT)
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
Subject: [PATCH 2/4] selftests/bpf: make str_has_pfx return pointer past the prefix
Date: Thu, 26 Mar 2026 10:39:34 -0700
Message-ID: <20260326-selftests-global-tags-ordering-v1-2-5dd2ced5d9ad@gmail.com>
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

Change str_has_pfx() to return a pointer to the first character after
the prefix, thus eliminating the repetitive (s + sizeof(PFX) - 1)
patterns.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/test_loader.c | 41 ++++++++++++++-----------------
 1 file changed, 18 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index 338c035c36884c02ac57cd17110122c10b4858e4..f1eb99f829e112f0e738bfe44e7e61a49120ec85 100644
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
