Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FE9371D04
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 14:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473273; cv=none; b=bRbMd0BCQIIZYyvHenAH79A6mrcl8h+qJETnPVIKdzvUdy2vLhEo71+gLSlQhLw8DE5BktYaGj7YV5uVNMKg6pK0vpCjl3JdCOSE61/SE5bj+uosqsv2mgvBkYnfIs2VLU7aWgyaAzjG2MfhPh/3mef5YflOmblrKpKByHmlYXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473273; c=relaxed/simple;
	bh=M6OJfT3qSdP4lnrHz8anqee8kUQRnD0Hidbc1/0+8Oc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ftcQjTatDYPqaY6wNvFsTMIA6+87nDUQf+XufOJ/JwApC+dx4UG6/nrD/Ua05FkRfrKW0UaGc0ZdxSmXmqBB4A+37MR+YtDaeFeNV45v/TGnZyE1YRnZ7imGnfMCh6NnUlIYB71mu+QARS3AYPja2NY6c2uB98QggZ6M0FzF0ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PExDjz5I; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PExDjz5I"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-676a89de629so14244555a12.1
        for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 07:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1777473270; x=1778078070; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gvXdowVtyuI/sQdPSdYXchM5M1PBQ4p+rahyvFeZ5AI=;
        b=PExDjz5IHWMKwN14HhuO45VRpI1RnQ+Vd9jHPUQX8B2pR9w+x4UY4XyJpbF4kV4ah/
         /97s82JCoEpd2zaDtdOZ60bf0+oLEUuJAycThE4S4F5ePQYTXcVXWwqYolDVidPLKw/K
         LEhgoR/xLvJH6W2uSY4Jzvd+pjM+aTty1vOQ05VCESn3Su/RNVW+C1vLGl2NccHLOX07
         du1APwr2Rsy71Zql60M3myRSIXsotVYR7+PMZh5QxVZt+LtmqtZsnHfZh3HkPuixQ5eB
         bwS7z11GoU292J5sKUw5QyCDdlC1AZzdiU9VZkYLdqbRsN6riEEnmmM4gK4Spwj0Xffl
         frVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777473270; x=1778078070;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gvXdowVtyuI/sQdPSdYXchM5M1PBQ4p+rahyvFeZ5AI=;
        b=LyFii9+jrYg747gTrr0LWncH7MECO2yMo/X4R0qU/0/3QOzFHg4cpt5fJbtuQ9ARZc
         e9hwe/NvrFs3ytYByi22IpFa/hoCE7ClAWFQIDE2PufH/DHoFWkR8RjfdgiamLOcqkxf
         09e0RJ98igyRaXOqMHJyyHRA33uzLHX/fYed9wTFW43skO9lYuKFraEOrFzveXxARGf8
         Gz4UK0IuxwJev48F6GxvYtCCp7cxtRUizda6LomNcRfokJjNiL5wXYUsYLjb+vrSvoug
         bFPUWHwXtBWeeCfwfIo5yY9cmscyNkc+asSA1jg6L8/RrvBk01RwvjawBUt4KP+d9IrH
         kiWQ==
X-Gm-Message-State: AOJu0Yy6g7yV4+ryCU3cTKhu8RrMMtZjK8z3BXeoj2w+Mvr9DgtBbXS/
	XU0cwQBCNDvQc8U6nO2C0IFSU0Zld2tfZSwpLloLBuaZWJGS+hr02a3oeuZhF78jBhY=
X-Gm-Gg: AeBDieuo+LJTWRM3neqoAr7Z71FmsfddtvxNr12t6vyBrKOlW7iWKtKYXwWWqcV/U4e
	YZPj/9VxU4z4ihkluwjdC/3caKFlxLL1TyR1i8BzHILpZ35DrswP4yNeMCD5OmvS9NOBrwPShCb
	lS2zCajHncFAWGx0nlSoAgndi1+WthJfRMwxTUoAIB43HaXXtEbR1KLl9Uf8MtHLURQ6ngWb1hT
	ff1jRAX59LmDhLK0lJCd8YqrD+9ZQRX7K8YWEZbKZQejgw0svfVLuWGpRh6v0wtOZbHSC3Ug2kJ
	N6NvUZctS2H32HQnh7YDYt4/FGXtgpXHUZ/UQpF0Lg32Wf7dCvMvdPikoITXDOQJYfI9OmNtAek
	ap/iBbyYB9FouQh6M2PbE6zdeJLArggNM4eTYZUN8z3pYdhwCd7cfwKW4iDSauahBY7xTQRlPBM
	haIgYfecOT7nsW0ncSD5e1CwIf
X-Received: by 2002:a17:907:9701:b0:bad:255d:b5bc with SMTP id a640c23a62f3a-bb93f043414mr278783066b.39.1777473269401;
        Wed, 29 Apr 2026 07:34:29 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:105d:ce28:aaff:fe86:149c])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-573b6bbace7sm1224753e0c.5.2026.04.29.07.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 07:34:27 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Wed, 29 Apr 2026 11:33:49 -0300
Subject: [PATCH bpf-next v9 07/11] selftests/bpf: Skip tests whose objects
 were not built
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260429-selftests-bpf_misconfig-v9-7-c311f06b4791@suse.com>
References: <20260429-selftests-bpf_misconfig-v9-0-c311f06b4791@suse.com>
In-Reply-To: <20260429-selftests-bpf_misconfig-v9-0-c311f06b4791@suse.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 Alan Maguire <alan.maguire@oracle.com>, 
 "Ricardo B. Marliere" <rbm@suse.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1777473237; l=5462;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=M6OJfT3qSdP4lnrHz8anqee8kUQRnD0Hidbc1/0+8Oc=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QJNnE97hOQ+N95HrIA2/vHwDFhUMZUH7iK6o7CJ+zYWQVnNg6dyS1G3xNuzwfOMM+lTuduNkLV6
 M3PODM02/lwI=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g

When both run_test and run_serial_test are NULL (because the corresponding
.test.o was not compiled), mark the test as not built instead of fatally
aborting.

Report these tests as "SKIP (not built)" in per-test output and include
them in the skip count so they remain visible in CI results and JSON
output. The summary line shows the not-built count when nonzero:

  Summary: 50/55 PASSED, 5 SKIPPED (3 not built), 0 FAILED

Tests filtered out by -t/-n remain invisible as before; only genuinely
unbuilt tests are surfaced.

Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
 tools/testing/selftests/bpf/test_progs.c | 53 +++++++++++++++++++++++++++-----
 tools/testing/selftests/bpf/test_progs.h |  1 +
 2 files changed, 46 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index cc14b13e23fe..7ba82974ee78 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -165,6 +165,8 @@ struct prog_test_def {
 	void (*run_test)(void);
 	void (*run_serial_test)(void);
 	bool should_run;
+	bool not_built;
+	bool selected;
 	bool need_cgroup_cleanup;
 	bool should_tmon;
 };
@@ -372,6 +374,8 @@ static void print_test_result(const struct prog_test_def *test, const struct tes
 	fprintf(env.stdout_saved, "#%-*d %s:", TEST_NUM_WIDTH, test->test_num, test->test_name);
 	if (test_state->error_cnt)
 		fprintf(env.stdout_saved, "FAIL");
+	else if (test->not_built)
+		fprintf(env.stdout_saved, "SKIP (not built)");
 	else if (!skipped_cnt)
 		fprintf(env.stdout_saved, "OK");
 	else if (skipped_cnt == subtests_cnt || !subtests_cnt)
@@ -1641,6 +1645,7 @@ static void calculate_summary_and_print_errors(struct test_env *env)
 	json_writer_t *w = NULL;
 
 	for (i = 0; i < prog_test_cnt; i++) {
+		struct prog_test_def *test = &prog_test_defs[i];
 		struct test_state *state = &test_states[i];
 
 		if (!state->tested)
@@ -1651,7 +1656,7 @@ static void calculate_summary_and_print_errors(struct test_env *env)
 
 		if (state->error_cnt)
 			fail_cnt++;
-		else
+		else if (!test->not_built)
 			succ_cnt++;
 	}
 
@@ -1700,8 +1705,13 @@ static void calculate_summary_and_print_errors(struct test_env *env)
 	if (env->json)
 		fclose(env->json);
 
-	printf("Summary: %d/%d PASSED, %d SKIPPED, %d FAILED\n",
-	       succ_cnt, sub_succ_cnt, skip_cnt, fail_cnt);
+	if (env->not_built_cnt)
+		printf("Summary: %d/%d PASSED, %d SKIPPED (%d not built), %d FAILED\n",
+		       succ_cnt, sub_succ_cnt, skip_cnt, env->not_built_cnt,
+		       fail_cnt);
+	else
+		printf("Summary: %d/%d PASSED, %d SKIPPED, %d FAILED\n",
+		       succ_cnt, sub_succ_cnt, skip_cnt, fail_cnt);
 
 	env->succ_cnt = succ_cnt;
 	env->sub_succ_cnt = sub_succ_cnt;
@@ -1772,6 +1782,19 @@ static void server_main(void)
 		run_one_test(i);
 	}
 
+	/* mark not-built tests as skipped */
+	for (int i = 0; i < prog_test_cnt; i++) {
+		struct prog_test_def *test = &prog_test_defs[i];
+		struct test_state *state = &test_states[i];
+
+		if (test->not_built && test->selected) {
+			state->tested = true;
+			state->skip_cnt = 1;
+			env.not_built_cnt++;
+			print_test_result(test, state);
+		}
+	}
+
 	/* generate summary */
 	fflush(stderr);
 	fflush(stdout);
@@ -2046,15 +2069,20 @@ int main(int argc, char **argv)
 		struct prog_test_def *test = &prog_test_defs[i];
 
 		test->test_num = i + 1;
-		test->should_run = should_run(&env.test_selector,
-					      test->test_num, test->test_name);
+		test->selected = should_run(&env.test_selector,
+					    test->test_num, test->test_name);
+		test->should_run = test->selected;
 
-		if ((test->run_test == NULL && test->run_serial_test == NULL) ||
-		    (test->run_test != NULL && test->run_serial_test != NULL)) {
+		if (test->run_test && test->run_serial_test) {
 			fprintf(stderr, "Test %d:%s must have either test_%s() or serial_test_%sl() defined.\n",
 				test->test_num, test->test_name, test->test_name, test->test_name);
 			exit(EXIT_ERR_SETUP_INFRA);
 		}
+		if (!test->run_test && !test->run_serial_test) {
+			test->not_built = true;
+			test->should_run = false;
+			continue;
+		}
 		if (test->should_run)
 			test->should_tmon = should_tmon(&env.tmon_selector, test->test_name);
 	}
@@ -2106,9 +2134,18 @@ int main(int argc, char **argv)
 
 	for (i = 0; i < prog_test_cnt; i++) {
 		struct prog_test_def *test = &prog_test_defs[i];
+		struct test_state *state = &test_states[i];
 
-		if (!test->should_run)
+		if (!test->should_run) {
+			if (test->not_built && test->selected &&
+			    !env.get_test_cnt && !env.list_test_names) {
+				state->tested = true;
+				state->skip_cnt = 1;
+				env.not_built_cnt++;
+				print_test_result(test, state);
+			}
 			continue;
+		}
 
 		if (env.get_test_cnt) {
 			env.succ_cnt++;
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index 37955a8ad385..2cf950afcd85 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -125,6 +125,7 @@ struct test_env {
 	int sub_succ_cnt; /* successful sub-tests */
 	int fail_cnt; /* total failed tests + sub-tests */
 	int skip_cnt; /* skipped tests */
+	int not_built_cnt; /* tests not built */
 
 	int saved_netns_fd;
 	int workers; /* number of worker process */

-- 
2.54.0

