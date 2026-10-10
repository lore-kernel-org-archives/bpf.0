Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175A735F164
	for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 06:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791612818; cv=none; b=laudgekoOopgqVFrS1dfs9DvHKTr7HuLwI77Rf96Zfp1Brui2wpig/UcAZktTNBZDVrmzHP6IAHQfw6JeJBcx9ftwULvo9Q2GPmjDkSDlm9Cb7gSJpv2TF+GpNOtjGODs+kvX1y8640ZJ9Tm8c49v/qAummaz5g6jcGGxdrgFFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791612818; c=relaxed/simple;
	bh=CBVVbba9JSVxH7I0fBHKW3Br+OzcRDd9o2i8sDezTbc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BLpHDsQYcUCoIDPqNxVskRhP+L8JkOYZ5JiTgbJ4eu9adgRVd/UC9X8960O+VYBBaOIe1B358ElamhcpWDwAMklF3/LC+8JV+aRlnmy4ZF6czWwMnjf/bIkGgSMwX5KdIR2sj6TTAnWgKGrRxyzUGvfoyaZWI2Z3iwytvtefOJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d7prY1HH; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7prY1HH"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-15756f82e8aso2711931c88.1
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 23:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791612815; x=1792217615; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BkPHx0G9BL5K7a6JzBYpMQajuN4UbOqdeG//C9D+a8k=;
        b=d7prY1HHEZ+lAKwASa6gaK0tuzBkkxOEBUPmpyv/3A+y4gbaPfAfkWooY4Sqj2Fiii
         W5hdkJ2+uRvoD6IdCbgFglvjC9/khOdhBBrKWSPxEpoI9cUtfs2i4OHCy/oXk3dVf9Ns
         tkc5OwV4y4YT/8tzEzXk4g/QXzyAY309aQAIc6mWvibexxi0/N9yASw+bczdyUoUNECi
         r3fsVFQcsmd6A6rguDcRreTnMWYRHiuZdYjYvDYxZjTI9zZ7bVsE3foTPFqezEOesHor
         7K3TheQlEKefy1dMHMVYJlgCdygHXsD6lfd6FfOliBmEDgVWMyKtJjEwhom09Pmkw5F2
         PL9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791612815; x=1792217615;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BkPHx0G9BL5K7a6JzBYpMQajuN4UbOqdeG//C9D+a8k=;
        b=GJyDaRwS1nbnVitZXJRInCBFSTyxL3sqhf6gffgoJ5Zu8Ik0IIV2/I7HEayB3saQBA
         BOef0F01CcE4SLTf7fXjLitVNF1qHWjFKBcr5JU8v2l6PnXQuYY2yatLy5B4Zll5DxxZ
         xsYNr/qlUh7DAcsIA+qA/tn7EWql3JnLAiZGF2w/lKtLd3ZKXLp/3Gl5jCaAOF2kZWaB
         w4k1ZXPWUI04giPBr9RBZFmU/bc2lyJIrrZkxqiKI9iyg9feb1qbc/CWr2l8qUDBMSPT
         y66Y8PEIMrB1XpxAsplyhwB4Bbiq5EQSWodhUZpPXIEpnUb+Ma3VQRmTFMY1uWYOdRXu
         ukBA==
X-Gm-Message-State: AFq9FYLapyvu392Lm0Ox8guYLNV6iN42F+/HXjGsFEu2VtLdsU5SQ0lP
	KlhsSTOhvNixnKNzR24cEfopWwlki2O8iKQ0Ya4p/gjL3kmZCN8yyLti
X-Gm-Gg: AYBFou3CgWU3JvUWKjVdKiNkhDmmRJOd2eX3uT99EW0jrCUmZLFvgT9S4oeODMUsSnn
	/JC1BtnfykDoR8xXyHL3fxTZkRgUO7ct58aNEMY4as7vpuFpNnINGsC+5xcgsl+RjBNrcnw85FN
	VStG7b33XW5JB2Hm2OtPSVqAT5hiB+2kc32CLy3bzurZo9mdsnLjIEJeYHphrfr3O2ekjI62Vp1
	e//yazOVxQzw7Qgf9lOu/Z9hUFb4qxLmq6AlrVYthBXM8C5V+0G8GSrkEXxuPbfXsmCE6BmSESy
	n58TEuQcDFXoIyvz+bc75vT309CWI8KNdOU7tj4EM2Ab7TtR2ArGFij3jC4vrMHCYvkY9H4Rzio
	YRpNVspkkE/iuOT4m860RcRl008boYwQXZAwHJQFJZ618Qg5sPsk9zdiNuDP6BF2z64AQsjbM2k
	2yaReV/Cse0Efe6hSNEg5y1bzPJEjBAQGckjvJKQVQySvJQOywSQqdmaPCK79+YU6qg0w=
X-Received: by 2002:a05:701b:2401:b0:14e:61bb:ec3d with SMTP id a92af1059eb24-16a5d63d0a2mr5200636c88.16.1791612815097;
        Fri, 09 Oct 2026 23:13:35 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a5866477sm10558036c88.22.2026.10.09.23.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 23:13:34 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Sat, 10 Oct 2026 14:13:19 +0800
Subject: [PATCH bpf-next v2 2/3] selftests/bpf: Test freeing a struct_ops
 map under a running prog
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261010-selftests-bpf-struct-ops-assoc-timer-v2-2-d7a43896dbf1@gmail.com>
References: <20261010-selftests-bpf-struct-ops-assoc-timer-v2-0-d7a43896dbf1@gmail.com>
In-Reply-To: <20261010-selftests-bpf-struct-ops-assoc-timer-v2-0-d7a43896dbf1@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, 
 Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Qiliang Yuan <odys.yuan@gmail.com>
X-Mailer: b4 0.13.0

st_ops_assoc_in_timer_no_uref drops every reference to the struct_ops
map while a timer callback of its prog calls .test_1 through the
association, and checks that the callback ends up with no struct_ops.

The timer first fires 500ms later and .test_1 returns right away, so the
callback hardly ever runs .test_1 while the map is freed, and the test
can't catch a map that is freed under a running .test_1.

Add st_ops_assoc_in_timer_free, which starts the timer right away,
restarts it with no delay until the association is gone, and makes
.test_1 spin in bpf_loop() when the timer callback calls it. Share the
steps of st_ops_assoc_in_timer_no_uref with it through a helper.

st_ops_assoc_in_timer_free run in a loop on kernels of the same bpf-next
commit with KASAN enabled, x86_64 VM with 32 vCPUs, without and with
the previous fix:

              without the fix           with the fix
  outcome     Oops (int3) on run 1      100 of 100 passed, 0.28 s each

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
 .../bpf/prog_tests/test_struct_ops_assoc.c         | 29 +++++++++++++++++++---
 .../bpf/progs/struct_ops_assoc_in_timer.c          | 16 ++++++++++++
 2 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c
index 461ded7223515..987117091c676 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c
@@ -136,7 +136,8 @@ static void test_st_ops_assoc_in_timer(void)
 	struct_ops_assoc_in_timer__destroy(skel);
 }
 
-static void test_st_ops_assoc_in_timer_no_uref(void)
+static void run_st_ops_assoc_in_timer_no_uref(int timer_ns, int wait_map_free,
+					      int spin_loops)
 {
 	struct struct_ops_assoc_in_timer *skel = NULL;
 	struct bpf_link *link;
@@ -157,10 +158,13 @@ static void test_st_ops_assoc_in_timer_no_uref(void)
 	/*
 	 * Run .test_1 by calling kfunc bpf_kfunc_multi_st_ops_test_1_prog_arg() and checks
 	 * the return value. .test_1 will also schedule timer_cb that runs .test_1 again.
-	 * timer_cb will run 500ms after syscall_prog runs, when the user space no longer
-	 * holds a reference to st_ops_map.
+	 * timer_cb will run timer_ns after syscall_prog runs and, with wait_map_free, every
+	 * timer_ns after that until the map is freed. With 500ms, it first runs when the
+	 * user space no longer holds a reference to st_ops_map.
 	 */
-	skel->bss->timer_ns = 500000000;
+	skel->bss->timer_ns = timer_ns;
+	skel->bss->wait_map_free = wait_map_free;
+	skel->bss->spin_loops = spin_loops;
 	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.syscall_prog), NULL);
 	ASSERT_OK(err, "bpf_prog_test_run_opts");
 
@@ -178,6 +182,21 @@ static void test_st_ops_assoc_in_timer_no_uref(void)
 	struct_ops_assoc_in_timer__destroy(skel);
 }
 
+static void test_st_ops_assoc_in_timer_no_uref(void)
+{
+	run_st_ops_assoc_in_timer_no_uref(500000000, 0, 0);
+}
+
+/*
+ * Keep calling .test_1 through the association from the timer callback, and
+ * stay in it for a while each time, while the map is being freed. The map
+ * must not be freed under a running .test_1.
+ */
+static void test_st_ops_assoc_in_timer_free(void)
+{
+	run_st_ops_assoc_in_timer_no_uref(0, 1, 1 << 20);
+}
+
 void test_struct_ops_assoc(void)
 {
 	if (test__start_subtest("st_ops_assoc"))
@@ -188,4 +207,6 @@ void test_struct_ops_assoc(void)
 		test_st_ops_assoc_in_timer();
 	if (test__start_subtest("st_ops_assoc_in_timer_no_uref"))
 		test_st_ops_assoc_in_timer_no_uref();
+	if (test__start_subtest("st_ops_assoc_in_timer_free"))
+		test_st_ops_assoc_in_timer_free();
 }
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_assoc_in_timer.c b/tools/testing/selftests/bpf/progs/struct_ops_assoc_in_timer.c
index 0bed49e9f2170..47a44c8e8b114 100644
--- a/tools/testing/selftests/bpf/progs/struct_ops_assoc_in_timer.c
+++ b/tools/testing/selftests/bpf/progs/struct_ops_assoc_in_timer.c
@@ -25,6 +25,13 @@ int test_err;
 int timer_ns;
 int timer_test_1_ret;
 int timer_cb_run;
+int wait_map_free;
+int spin_loops;
+
+static int spin(u32 i, void *ctx)
+{
+	return 0;
+}
 
 __noinline static int timer_cb(void *map, int *key, struct bpf_timer *timer)
 {
@@ -34,6 +41,12 @@ __noinline static int timer_cb(void *map, int *key, struct bpf_timer *timer)
 	timer_test_1_ret = bpf_kfunc_multi_st_ops_test_1_assoc(&args);
 	recur--;
 
+	/* Try again later until the map is freed */
+	if (wait_map_free && timer_test_1_ret != -1) {
+		bpf_timer_start(timer, timer_ns, 0);
+		return 0;
+	}
+
 	timer_cb_run++;
 
 	return 0;
@@ -53,6 +66,9 @@ int BPF_PROG(test_1, struct st_ops_args *args)
 		bpf_timer_init(timer, &array_map, 1);
 		bpf_timer_set_callback(timer, timer_cb);
 		bpf_timer_start(timer, timer_ns, 0);
+	} else if (spin_loops) {
+		/* Stay in the trampoline while the map may be freed */
+		bpf_loop(spin_loops, spin, NULL, 0);
 	}
 
 	return MAP_MAGIC;

-- 
2.43.0

