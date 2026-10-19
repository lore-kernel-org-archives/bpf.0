Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC528363096
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 02:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792376901; cv=none; b=ulu47bOaOeqFFOuHaK4CFzN57vYFz048RuoabLRGcRwJ9OBnqJcIsn9IDC8bYgT9vZE5GPzIGI1lua0DzpoAP7C7buQJEeNcIYFKlFo7TNm1oH1p9A+ayxqFOOcHYNfsxdQLHzCK78kWHaHX/cvYR6UH3nhjhsgjUwq+mCUvjus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792376901; c=relaxed/simple;
	bh=T7a0p321nQEGuK32vR6T1QWkp8Gh7KNGzoRi0H8DVwY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bk8MM8nLKgSSX9VEbz3z+xyfJNpBuXhw3VDO3cNU7XyTmKXgamAI4aI99oSc9POpBp5ki8uMaGK5NA2knF1a1HcpPGiBBqWUMi2q58FfcwLZyU+lDKgwyIDQCJ1r9hTFHkho4Jz5TfazN6T6ChHsGI6HOTnw+ZrX2PdI6lwl+4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JRantFgO; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JRantFgO"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-354ba08cfd1so2823218eec.1
        for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 19:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792376899; x=1792981699; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/IUqdtcaC6jELFgjYkWg+BxgHeoIyyjojokzDsuicfw=;
        b=JRantFgOCt1ioCvEGj1k7BDOESpx7GhYVx4TPpI6CnpAp4KblXTI09wz/8kh8AjWom
         VdPJ0ZT6ywurEcp30zqNOO9kyimg+Jd69gu3myd3efXwmYMGgjxar1ceYP6o3db40SmU
         4Z2+irxZ0qP8lHSzKPgpKc8dunTh4rLNvpzDIxiCYHOeftXUlZf4TZIA0UDdK7REv70J
         wvmybilk6c5zX41S58OOgfJT8NToJp5+AaT4ybEWl556IposzPMvkYpqj6a/GEgVDkXc
         firHWFAsCuhSQi5TwyswhvFHOGXTGM0OkcjQr54Eb+Pvu1KJg7K7ctxTinmsBvfKuXZf
         tplg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792376899; x=1792981699;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/IUqdtcaC6jELFgjYkWg+BxgHeoIyyjojokzDsuicfw=;
        b=0eYeFzAoOCibBRQhVx8QbuXlGK0C0FSv95PmXCc4bmFBVfyzhOhnmF0B9iOPHZ4D3O
         BFqfosMeH9G7kNp4K5kr6AYnrsrW+mk+ypgbXQ73buhfWxD//nwlqpNHSLpHa9krXvsO
         bD9PQzy6Y8rbnhe0pIb4WX7Uao+MY7L8TibjISyTybXUZKr3TETZlqLeU76xQmF9aJF9
         eBMJdh5zEEI2pQ23Rb1kVZUJvM2Wk3NT494bq2mHFFklj+efKDdr2NO2q28+s/6TD7tz
         ug+dIA9QOdoxCYvNVbk2m1ddhWPdScWUHIRcbKgBDBM35iAj8vdhKIN0VvoprnBvLbY5
         k6EA==
X-Gm-Message-State: AFq9FYJaB2bK4qvF+GgwXfUliMef90eFSBByGhFqcBm+a8nqeqIlDs3U
	UZWOPkOifA/VMtyAXHo6NuhyJa1skeKwUkc25YcZXbFv6oTsBVRBfu6n
X-Gm-Gg: AYBFou24VcqSht9XmcWM1Shd1rmKRqXqNWQMsXQR69EMl0/4AgkLjpnabBXAn62Pp48
	m2NnSoneHEfDPI8L52WZOKz/+5y6gIPQeNXT1E46PKZbN41QJ/3iJZVHoCiz8w67lM1i5MhbD9v
	fmqt/yGYehYCQVyHMvhfqr4/mm+9iod/atYK3K18u3ynNK9febYQqiIiK6tYLSLVBtdci7eux3c
	o6/ilYGR+BfSU44hy2Y/Y3EUHaZNx76Z3xVTwdUzlXFfJ9weB+5+tkRgBhQVA1CzSsLZuidusWU
	pRS+Ui6Mv8X2EWflBmtAGGBtzRFVn/mmAh1t0KJUGPbqptXf3oFWpNq/gAfMdSCO5cUeOpngnGh
	0L2aYy3cP6I2C/IrfN/ciziHqz/AzU4cv9+DnXfAlv0ch9kWJWflnjznyDLOjANU/UATx52zP4U
	ZgCvKoNNMUDa3SuvDHN+V9OZlnaBkSQncIF6TtmcovlVXC/gYFdzHzcz9kd9yK0J00fyc=
X-Received: by 2002:a05:7023:d05:b0:16e:c820:b20d with SMTP id a92af1059eb24-1850cda6d0amr13513264c88.5.1792376898801;
        Sun, 18 Oct 2026 19:28:18 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1830f213ba7sm28341876c88.0.2026.10.18.19.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 19:28:18 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Mon, 19 Oct 2026 10:27:57 +0800
Subject: [PATCH bpf-next v5 3/4] selftests/bpf: Test freeing a struct_ops
 map under a running prog
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-selftests-bpf-struct-ops-assoc-timer-v5-3-77b2e181e5cc@gmail.com>
References: <20261019-selftests-bpf-struct-ops-assoc-timer-v5-0-77b2e181e5cc@gmail.com>
In-Reply-To: <20261019-selftests-bpf-struct-ops-assoc-timer-v5-0-77b2e181e5cc@gmail.com>
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
steps of st_ops_assoc_in_timer_no_uref with it through a helper, which
stops when associating or running syscall_prog fails instead of waiting
for a timer that never starts.

st_ops_assoc_in_timer_free run in a loop on kernels of the same bpf-next
commit with KASAN enabled, x86_64 VM with 32 vCPUs, without and with
the previous fix:

              without the fix           with the fix
  outcome     Oops (int3) on run 1      100 of 100 passed, median 0.27 s

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
 .../bpf/prog_tests/test_struct_ops_assoc.c         | 37 ++++++++++++++++++----
 .../bpf/progs/struct_ops_assoc_in_timer.c          | 16 ++++++++++
 2 files changed, 47 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c
index 461ded7223515..6c85d368bf167 100644
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
@@ -148,7 +149,8 @@ static void test_st_ops_assoc_in_timer_no_uref(void)
 
 	err = bpf_program__assoc_struct_ops(skel->progs.syscall_prog,
 					    skel->maps.st_ops_map, NULL);
-	ASSERT_OK(err, "bpf_program__assoc_struct_ops");
+	if (!ASSERT_OK(err, "bpf_program__assoc_struct_ops"))
+		goto out;
 
 	link = bpf_map__attach_struct_ops(skel->maps.st_ops_map);
 	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops"))
@@ -157,12 +159,18 @@ static void test_st_ops_assoc_in_timer_no_uref(void)
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
-	ASSERT_OK(err, "bpf_prog_test_run_opts");
+	if (!ASSERT_OK(err, "bpf_prog_test_run_opts")) {
+		bpf_link__destroy(link);
+		goto out;
+	}
 
 	/* Detach and close struct_ops map to cause it to be freed */
 	bpf_link__destroy(link);
@@ -178,6 +186,21 @@ static void test_st_ops_assoc_in_timer_no_uref(void)
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
@@ -188,4 +211,6 @@ void test_struct_ops_assoc(void)
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

