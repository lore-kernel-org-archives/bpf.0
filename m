Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E9841D4FA
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 18:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783361859; cv=none; b=DUS8no0jovmRzdjjMbM/D7u96v3UnRzmdyf7P+iEZlVX1tZdsal++zANHRNHjXniYYK2wniOIFQp+tu7/8YaCl1If7cguW/b5fFjnqczbkyxuX7WD31B8BHpzolTWlxqJHCYsyg5kG3v5PV0wPwPtXSKUrWOO3+6Eg9tv7pW39s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783361859; c=relaxed/simple;
	bh=zqMU17yvDpAY3NsU5u5OvcAVcznTCf32fNVhXeKhOAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GgDuXMjFwTTu1b6LQ/Wv483MzjGAJSuBohgyyTtSA/S4Kv6Tf3Nd9WFmQ2HovQGRSV6DxtTTUPAsXRZYFT22PsUnyNx7Y3KMaCDySITdJ12xdT5ESJ0T5SChvekkafU/qF2nvOhv0kFOqhgw68Z71fYOAghX4asXHhthkC5G1/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=qM/D7DGI; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="qM/D7DGI"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-845e363246aso3734557b3a.1
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2026 11:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1783361858; x=1783966658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S4A2vYRlXvI7gNWhu7CGHfWu/zfxDh25nTATnjyFElk=;
        b=qM/D7DGIFRR7frDGl8DARj3TD5TXywc1jLcMRY76bKzjVniW6VWpr/omNBDtscZvVO
         t5svx2HKZiBXO2iN+az0gTJnZ8Ifm+Eve9aouQo//qfFZT7xTSQAIw839E2rX5lLdMns
         MVMtrxN/gJJf4cRTfyikhCEF1XuRTCT6LHEt7gbOWXad1zqPzxVnm+b92A3l9/NKD/9B
         s3evPTIO1NX7PCpDEFjEfADrePCG9/UXqHWcbpSymUF7yIqm71jOB8I0kEj17t3eXhP0
         JIeTj7e4e3lch/dUU8hEiALIaebt+YRV2Br3Or1XwqK/SNhia3v5mGgchzML/XKnVCiX
         Pz6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783361858; x=1783966658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S4A2vYRlXvI7gNWhu7CGHfWu/zfxDh25nTATnjyFElk=;
        b=hrkdSBx4f5x+rxmgUs+Y1RstLELY8HASUAJihT5VmyTF0zpiAA11TvE4lm0CuH1KM3
         ai9jbZID4NgZq4DbTHnCkIjacDz8adMK+jCIv3RF3VnvRnPHDmGHuhyYjnsUSlnTkK/Z
         E1tVJfIs77bTXyFtrUe7Bve2ODQ0qt7soyt0nzT1N+mU5zDKu72tcZiwCKUJ8tqZgk2z
         bGqoI4AC17uKm/fVaUQ0ma8euDP4vH2LY81YSP870Oky4Gt+/RQGUNAx9ZDzcbVDefRP
         xNHw7tIVKPMOjFCczvypYhNDCa+PYAk4V/ohWbPsiDZx8DeYNOps7AIiDsv6HhpiwmnN
         9jIw==
X-Gm-Message-State: AOJu0Yw80m6ZOCCyL4waWZroLGl+PyY4Rt6uu5NaON9LkGlC4qw+Mg+P
	LoAkp5RDWtQuMRvxah6/hFRE4e/mXTFSbiirwraBQ++uOvmji6qJwAj+rMEoplVbHiIkKXWOh5K
	M7RVMJAE=
X-Gm-Gg: AfdE7cl5Jzbma6Sl5hBiDAj7adzqjQaDg8zQVMiDRsUKLArL0hvH2v/O3Px4h6bvC1N
	gnhmLTfJjFnmQgrUZdn2Yq4DVhtWBfLWAwd8b7HSQE5Gg7AUsS0tB0FSXowGUqoQ/MM+sjmBYM4
	BeKbYvS9//6mukoxU1lnM5+WERajBPorEYHmedg9HSv0YfX6b8VttUg5sGQEvCVmJxUyjSZ50yt
	v4hzN63I7cf3Zh4tHKs/YZ8FnUFgaksDbdCm4vSWdoVxqHa+mJvhQAx8cV1YRuIF33c0E0Bqz43
	fMYFbqwC54u9Nd4oDGN0LghlvGioCIEU1RU2tzZGI949Y8Ua093p3lFHKfr940d3rXrW5z0NeNW
	nscoBKWTJJNNFpZYPo3p/8Y31ry0BH/M+SuOoeQP3Qf06DbO5YKAFv9j2iABaHntXHenmfZ432V
	tkMX4maVBtWskKkgtSpFVI89BwxKSylL2ekg7lXpduNOlpgs85Kuda1ONBug==
X-Received: by 2002:a05:6a00:300c:b0:847:926c:5837 with SMTP id d2e1a72fcca58-84826b8d20cmr1644255b3a.11.1783361857693;
        Mon, 06 Jul 2026 11:17:37 -0700 (PDT)
Received: from krios.ht.home (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6d498dcsm4192997b3a.30.2026.07.06.11.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 11:17:37 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	mattbobrowski@google.com,
	song@kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>
Subject: [PATCH RESEND bpf-next v3 3/6] selftests/bpf: libarena: Clean up allocation state before buddy tests
Date: Mon,  6 Jul 2026 14:17:27 -0400
Message-ID: <20260706181730.21731-4-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706181730.21731-1-emil@etsalapatis.com>
References: <20260706181730.21731-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Summary: The buddy allocator requires the global BPF buddy allocator
to not be already initialized. However, the test currently merely resets
the allocator before the buddy tests instead of destroying it, and the
test worked because the buddy test happened to run first. Properly
destroy the allocator instead of resetting it.

Fixes: b1487dc1b181 ("selftests/bpf: Add selftests for libarena buddy allocator")
Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 tools/testing/selftests/bpf/libarena/src/common.bpf.c  | 6 ++++++
 tools/testing/selftests/bpf/prog_tests/libarena.c      | 8 ++++++--
 tools/testing/selftests/bpf/prog_tests/libarena_asan.c | 8 ++++++--
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/libarena/src/common.bpf.c b/tools/testing/selftests/bpf/libarena/src/common.bpf.c
index 1b4bb19b3c52..569f0f64d518 100644
--- a/tools/testing/selftests/bpf/libarena/src/common.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/src/common.bpf.c
@@ -37,6 +37,12 @@ __weak int arena_buddy_reset(void)
 	return buddy_init(&buddy);
 }
 
+SEC("syscall")
+__weak int arena_buddy_destroy(void)
+{
+	return buddy_destroy(&buddy);
+}
+
 __weak void __arena *arena_malloc(size_t size)
 {
 	return buddy_alloc(&buddy, size);
diff --git a/tools/testing/selftests/bpf/prog_tests/libarena.c b/tools/testing/selftests/bpf/prog_tests/libarena.c
index 61ea68dce410..ba5a5a50f7c0 100644
--- a/tools/testing/selftests/bpf/prog_tests/libarena.c
+++ b/tools/testing/selftests/bpf/prog_tests/libarena.c
@@ -15,7 +15,12 @@ static void run_libarena_test(struct libarena *skel, struct bpf_program *prog,
 {
 	int ret;
 
-	if (!strstr(name, "test_buddy")) {
+	if (strstr(name, "test_buddy")) {
+		/* Buddy tests initialize the allocator directly. */
+		ret = libarena_run_prog(bpf_program__fd(skel->progs.arena_buddy_destroy));
+		if (!ASSERT_OK(ret, "arena_buddy_destroy"))
+			return;
+	} else {
 		ret = libarena_run_prog(bpf_program__fd(skel->progs.arena_buddy_reset));
 		if (!ASSERT_OK(ret, "arena_buddy_reset"))
 			return;
@@ -24,7 +29,6 @@ static void run_libarena_test(struct libarena *skel, struct bpf_program *prog,
 	ret = libarena_run_prog(bpf_program__fd(prog));
 
 	ASSERT_OK(ret, name);
-
 }
 
 static void *run_libarena_parallel_prog(void *arg)
diff --git a/tools/testing/selftests/bpf/prog_tests/libarena_asan.c b/tools/testing/selftests/bpf/prog_tests/libarena_asan.c
index d59d9dd12ef2..f897405f701d 100644
--- a/tools/testing/selftests/bpf/prog_tests/libarena_asan.c
+++ b/tools/testing/selftests/bpf/prog_tests/libarena_asan.c
@@ -17,7 +17,12 @@ static void run_libarena_asan_test(struct libarena_asan *skel,
 {
 	int ret;
 
-	if (!strstr(name, "test_buddy")) {
+	if (strstr(name, "test_buddy")) {
+		/* Buddy tests initialize the allocator directly. */
+		ret = libarena_run_prog(bpf_program__fd(skel->progs.arena_buddy_destroy));
+		if (!ASSERT_OK(ret, "arena_buddy_destroy"))
+			return;
+	} else {
 		ret = libarena_run_prog(bpf_program__fd(skel->progs.arena_buddy_reset));
 		if (!ASSERT_OK(ret, "arena_buddy_reset"))
 			return;
@@ -90,4 +95,3 @@ void test_libarena_asan(void)
 
 	return;
 }
-
-- 
2.54.0

