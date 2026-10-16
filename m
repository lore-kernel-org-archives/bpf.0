Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C37325A645
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 02:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792119567; cv=none; b=Hbv7j72+4hSKWMj/N5Kz+ANGxni/UnmgFc9ySAcxGP0zTxdQiTJ06rfn00cTEoBWfrYMCiNE1bKQyG9j76pVp3gp0CZ8Tabhv7/bOM5rujKyyu03xlaiyFEvI4AMNF9eBwRMvhXgrGmOfx6fp4wpL2whK2QMiC0mTG8ZH5rInqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792119567; c=relaxed/simple;
	bh=g7kdzc5hvtrudWPq+5TfB02+rMhErWeMHNWfdpncx6w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tvrM65xbgBsWbqoXsn9I7/gxxmN3np1w8xYb3F1nQ2G25PhG2Du0QxRFqn5qiHVxhhG7WiM+KEt9HJVeo7p6775Kc4DTMLjyS+Zo+astLZqq5qSkOPWjVcq1N9H6zxxytpM8+y96A/3PMSM44qH0FwbAJEQJ4TgrOBRwotRRJrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RfnXvYwr; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfnXvYwr"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-35d7fa491deso592652eec.1
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 19:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792119565; x=1792724365; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=msBkAWQzlQoQqAGoMJZykacdeNuYYmXdlWmpFGzS2Ao=;
        b=RfnXvYwrj/otsYbP0YcRIsUhEwECfYZ2apGUlRXJ1ZvNjwRV7QWa2NWvjjX0h/bE0n
         bmMhcMjLKmIqMiSNLxff9gVJgrCP9BuKz3tgeoxktkZUKH3GiQ9X1AogEFkpZHxOpvOa
         sotQql9pVIlQtD4zrBg0Q46Dcy01ErIBytcgjV3Lm5R+c3ustNiX4O5Dl5aWDDl41Ea0
         ls2Yqs1M/zMu6v4X9sN0PpDlEz6Mg8Agf3+7mcJxDuN4ZrMMzNgB2ZDWQebhfXSSXRAd
         X38dTw9INrg3WPwoKGIUy1n02gSYgQzkCW+t2O8Zi+KKFByQD3MMg4vw4X//vupAQC7n
         HHSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792119565; x=1792724365;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=msBkAWQzlQoQqAGoMJZykacdeNuYYmXdlWmpFGzS2Ao=;
        b=MbAqqsnFj4lBjYd3j7yRohtWQr1GGGkQLz5ljuNUIs/Am6Ual4GD49L/w0qrzxZTuQ
         u8MpUZNEb3Nlmm/CmMKspO882XrRwfS5dC7f+PjcxotcBK3iH0GZ0uNI3DDTO6WsUp2q
         3TVMim1brsofxBpoK1IqL7QZvItmM82bnvUlFuKE8FQynUzCdSvNZW0rn+h+0zc8pvJf
         djkj+xwKE+PEOnLY+z1lYc4RAvZk+CepLJClUAosMLOQM7AlpU+iLLhsfebLHXURgmEz
         uCUggBq3RTKzuWnWbWzY1yvHhT902MAm5XLflS0zv6Dcs/DA3syCj2r723COqVNH4lxN
         yAxg==
X-Gm-Message-State: AFq9FYI3quHGf3bqCU35uXPglvDEviLrGC5lOpgAunEXlz+lJRZFajsP
	6rpvHBLrwPXUh1gZNwdvbCMkehPn1hXzREgLpCXpsIZaBwWcvq5GHx+a
X-Gm-Gg: AYBFou0dkEUu09cxc0gJUoakSUVndYrtTUjExTnww8I2m64sbC7lSV9Z12rG2QoFwnB
	aDi9eGHeh2Mp22h7Y55R9DTdMG5SBddat9djicw5RjXz6fwyjt0EoYAXFjXGYz3833nshctIMoA
	ixf1VKr82RA5Bye+MANri83dNS1QshRRvaSRsBaA0ZYhgF/vqu01LvSXDGgowIL9Mh1wK5pdkPv
	Up6xEwtnO0b8WS3B/ONoOYNR9dHd+8myxSMB06uzSOZcd08+6EIO4zDNhM/FJtH5WWhIbQzQPwF
	GGhbp8p5p0XlsKX18+h1jsZuFQcq4skEfFiqqAtWALVGW2qnTaDXOeGZ2CzP+Pmog3RDWm9jFbr
	NE2ik7eWbvVE7BuCAlGX/F6i/CNtwv06BmQpU85f9dr/MgOSsDrNw+sJhlgA2Wntv862kEV2JYT
	4E790xqwBvUNqVWhTKjJsyXxsy+gg+pXZbBZCRC52GbJGVHWky8oQ7N9370VoEg06obQ==
X-Received: by 2002:a05:693c:42d2:b0:34b:3f7d:6105 with SMTP id 5a478bee46e88-3602e3a6861mr2137401eec.14.1792119565274;
        Thu, 15 Oct 2026 19:59:25 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3607ee0cab0sm2481261eec.3.2026.10.15.19.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 19:59:24 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Fri, 16 Oct 2026 10:59:07 +0800
Subject: [PATCH bpf-next v4 3/4] selftests/bpf: Test freeing a struct_ops
 map under a running prog
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-selftests-bpf-struct-ops-assoc-timer-v4-3-9ad31c21220c@gmail.com>
References: <20261016-selftests-bpf-struct-ops-assoc-timer-v4-0-9ad31c21220c@gmail.com>
In-Reply-To: <20261016-selftests-bpf-struct-ops-assoc-timer-v4-0-9ad31c21220c@gmail.com>
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
stops when running syscall_prog fails instead of waiting for a timer
that never starts.

st_ops_assoc_in_timer_free run in a loop on kernels of the same bpf-next
commit with KASAN enabled, x86_64 VM with 32 vCPUs, without and with
the previous fix:

              without the fix           with the fix
  outcome     Oops (int3) on run 1      100 of 100 passed, median 0.27 s

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
 .../bpf/prog_tests/test_struct_ops_assoc.c         | 34 ++++++++++++++++++----
 .../bpf/progs/struct_ops_assoc_in_timer.c          | 16 ++++++++++
 2 files changed, 45 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c
index 461ded7223515..9d56e8cb5675a 100644
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
@@ -157,12 +158,18 @@ static void test_st_ops_assoc_in_timer_no_uref(void)
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
@@ -178,6 +185,21 @@ static void test_st_ops_assoc_in_timer_no_uref(void)
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
@@ -188,4 +210,6 @@ void test_struct_ops_assoc(void)
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

