Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792658936;
	b=ckchg1lGPu3np8ee3qLkeWzyWFzwzsci3Z6Zo7/6ne5C03brz3iNL5r8fnaoRbpxuygB
	 fBN93XnP1c1Ox61FxXNpFvYC4ojYsTcAAMA/rN9tpzK7EkqitRM2yzM7QAckRoIUlTQLu
	 u+lzJixPWEFvlQDHJLEMEPysb+EwIft43r1c9/bUu+/z51hZLKB1lkETCLJbkGp3u98vg
	 7uZpvqzwKkEvYVBNi08Snre8nVgRI050dAVK39/rXjHUmedakd/4RwmyUxFMvNKiNSdb2
	 613fjeTlQLoh2iHCNhpQIECQUlu33nv2yOj1y+i3PbNKr4rTgLYwJlREPTxhBgsDvGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792658936;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=uLcQwB9RQyvK/WfjSKPSsVJ5A2Co4WxMpfFxo4/WCSY=;
	b=y7A6b1+iSdII8n11jQuG0YxsLo+WaoyzX1kjxyhSM6NYGCOp14j+5vJQI39SE9ARzrbr
	 QckCFBpUftWZesgQbpz01xxvNutV5apNP/1WDBNlSK/P9TGEi2lprxC+Vy5JOz+dg7OtT
	 w2AmSiCYmn3TsX0V5Uvj+HHaBCC1spvFVzLkQzIA6SPgz8BDO7WVzbZPF1IhNFjzQWGIa
	 UsJbz+oVJCLUiq4dGJIDyI5ICzBVRUIcfrYtI/35EV0wHD32biUWy80GZ9FTh5QyPkdkE
	 DVSkID/b7vE3CG/qUkCoa/H5W3t2wkypfdQWQ8a4sUc1i9Q0P+bEYg/VmMHRX8FhYTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=d35drGQJ;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD8B606A321
	for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 08:48:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DD8B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=d35drGQJ
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-35cd4e8bdbdso2826953eec.1
        for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 01:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792658935; x=1793263735; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uLcQwB9RQyvK/WfjSKPSsVJ5A2Co4WxMpfFxo4/WCSY=;
        b=d35drGQJZHpnW2CHtY26G8Ohal4aPyCB4DL4hSQ6eEmfitMWL4UJSvHUcB9Socarjz
         4P5g1BZiBKfnfNGmXNRL32FrY0v5f8Au5HoeZtmRwnQU7xnbbMF4KoFbP2ZWG8M9lnxu
         /O9gJgG10MlR5qOM+4JF5om4JNktL+moQMGqGeNG6SQlRfIjm14ve19uH6WAJPRvsEws
         y8vYy0uCXw38Otc9xoH/3N6pPJMzpCqPNFIuD1Lv4jEdsPlC6c/JtH32bKQI4VuzKhkC
         OKrmYHruxnNCb6jzZucbx2uwwVNCEt0Ai7ErbaRz7W1lIdiwSWdb/3VsEHB7GiDrBbB8
         2Sxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792658935; x=1793263735;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uLcQwB9RQyvK/WfjSKPSsVJ5A2Co4WxMpfFxo4/WCSY=;
        b=IPPpGS9PZ0LnVQpbFEGmm4P8r26ZG7TfVAkbWwaR133kXCWxsR81qKf6KjHFrqMwPm
         /fdAvAS2pzcaBGL6TwnDG/QZcKAGNPAwiAMFK3W5irIr+tyvYUVPLaKwta/Jv8yXpSsB
         mwVaPLmeL53NMO1WdlAIEv1D34irJAWgPEWnoPoJkEtxmkWIAvwrohcgRoZ8uXU7QgCR
         TsE8cR8IOLYaWM4yH6XfGRwFDTv7BXvE72uQn1O1cvbd7Hflk1HfVZBPC48iDAh9qrKQ
         Rq/w+D69lALekjSp1JHk3GdlS2/RYBk7KUa7jJRoGooCqpaLwPYzzoQPUiIvDFVrR107
         IJ+w==
X-Gm-Message-State: AFq9FYLl+CXIwuy9L5n5Hl9zhcHr0ZkrM1aqN9WJB5rsnoDOOKGI83zX
	hEIoURPyyM5nC1kZPKfHWgTXKEZpRTD7DgFoNXlxnzXAw2NYp3drwPft
X-Gm-Gg: AYBFou02peHeRzrYPksVzphXNBvymNYgu0zTJ1/YXC1n3jX/EHyf0LjeuFhXBS3k2nU
	+TQGMw0yffipdaUUjj1bVpenJRt3r2Jxn9fuP3UuGokCb8Svr0vDP4gm8CiH5JALJy8m9u5n4si
	22K26QOqZtgnKJoDjl2ecn/RVVMyoaakhJPMJVH2ju6ahCtdrK4hOdqfDoWFCGXJOkMZ4A9qf/E
	RxLitMLq5hgrx5/twGpucOv9UwOEw5VGLQTXkB52P5qGLzSxDlPXPCQmifGH/p1odVQti/Rz8ED
	6PUHtRoYiQmk6JhMZwLB739WO5K6NLSKgLGxFl56ilvw7PYe4bctNEdq0Q6VPf5jcxX4o3FZYMY
	m+pcXx3onot7u2IYC9aTGcdfbZ6nJfrtH//iPx4GRpEyiw9tJwej08PFhURAKI0AnQJYNnaoY53
	EL4+S7H5s/PctPRYQA4nHsexJ0Y0ga90nk1UKExxWEqBDW/PYVDkA98xrIjCdcQu7fu0FOESujn
	LOgdaFLETWNUVPD9rKv6+HjsELi7TOF1HfU4Q4IjhM68dNxC7QRKCifMbWLXCHSVT2vh2mKTQ==
X-Received: by 2002:a05:7300:fe4a:b0:351:4a80:d94c with SMTP id 5a478bee46e88-3674df578abmr6225113eec.21.1792658935117;
        Thu, 22 Oct 2026 01:48:55 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-367417a2fadsm13962472eec.21.2026.10.22.01.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 01:48:54 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Thu, 22 Oct 2026 16:48:38 +0800
Subject: [PATCH bpf-next v6 3/4] selftests/bpf: Test freeing a struct_ops
 map under a running prog
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-selftests-bpf-struct-ops-assoc-timer-v6-3-2c0f18e82582@gmail.com>
References: <20261022-selftests-bpf-struct-ops-assoc-timer-v6-0-2c0f18e82582@gmail.com>
In-Reply-To: <20261022-selftests-bpf-struct-ops-assoc-timer-v6-0-2c0f18e82582@gmail.com>
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
  outcome     Oops (int3) on run 1      100 of 100 passed, median 0.28 s

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

