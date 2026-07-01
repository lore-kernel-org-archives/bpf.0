Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD79639A7E7
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 22:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782946241; cv=none; b=Tvfp7TE/Dx9XuGgKEWLQ8ZLLC592YOA9wKGZ6xKUGymYfgIfyTuSEZPOnaJta240jqTMkamp82PepOmWTZp0JY05a6KvMYTujkTBa2Zh1NmPUBBcgvUKRly+kyBhxDFd/JKSFyFUITIUNwPUGlEDqRQhw8zcW2q4Hy/d9MBymog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782946241; c=relaxed/simple;
	bh=zqMU17yvDpAY3NsU5u5OvcAVcznTCf32fNVhXeKhOAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rWmDcjdQHHzaWyFJrTOi/cS6jCTGt9/UK9yYi4kvzCMesjH6blNmb7O8eyz4G3x5AYT83k1iGpmCz9sThXvgi8NrP6upIWfTBcSc7AIwgLGhNu5rrbYhCRiK12hbJedIl2BI4cLgym+aSAAbVsT5Ojjl+bcqAsJSrLtxGCJPRAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=gQ6do6sM; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="gQ6do6sM"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8eff5ce3b95so10763706d6.3
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2026 15:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1782946239; x=1783551039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S4A2vYRlXvI7gNWhu7CGHfWu/zfxDh25nTATnjyFElk=;
        b=gQ6do6sMDtlY7nHZCVT4EwDDKnLaX75Itqv5BYyXaqkQJ+Ne7GcT4U1fCMXmtSTSoU
         91QH7SbTYFz5wsdcF5Y/n5zZcduVNMl9V5vhqdoY9HzXGu/tK6COnP8ZDh5x+mD7LCRi
         Wf8xygoFuYLd+qTHXLXn5FrPpUZew+97z5+ORHHxgQCmdZqpToZu+ueH+DEmevm3ya+8
         DrvsChDkmS9RsAz3ZcsT6Rz8uIYLSdVONDUaGw44T3a/IMru/Zwvr6rrw+Qtj2DJk4bQ
         TOFf29Obow1hZkwbxei+pEp3AVTurjrlGNHg+XFQ+ihZ9vuFhhaWZGTpyB0J3ccTSCLT
         CKYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782946239; x=1783551039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=S4A2vYRlXvI7gNWhu7CGHfWu/zfxDh25nTATnjyFElk=;
        b=XbVAksTZF1PhiuQI0KEKouRyvq27yuZ19F7vxIpHOphSQZ56QAsOv1MMAyOF2HnRah
         wK1C1ukxrhfvlttzSyV527T07fatSw8Dy5dUguyJ7SrLdw0t+dhipzhWsH/Jq0msls+S
         kBthtXu15mXFx8IlRIfw2FkXHGhR1IHdq3eLZTa/Bfzkfi997zAurpdxryaJiwIPtBVZ
         VF/PX12vwe1WetOycEaNa8fhXreBLM8wVArFA2WlDVnwo0vT4NQQNAK8OHCqau2ybjly
         R8ilFMggsr7xn//cUWmn8f6NecR/CTcpPsTT3SH9RXLYYdrX9LQ23kxg0UCW+sE7iOlN
         Ymiw==
X-Gm-Message-State: AOJu0YxEDj7R4zw2X91EvhR5PhlSdW8pW+9N9W/OQVFQ9jYn2cOLzQ1O
	ERwO2QGzVMgkDNjLApv9azhE0Yi3Jx0fN7HWrhm0bU/diU1s6mxIFexv0MlXQt6wP04IuiGyL1X
	uEZRHcL8=
X-Gm-Gg: AfdE7cnhkLJLKmiWpYudxYZO6Yzc0d0/2q7OBW83RhY9i0jUI0OaKskXXjwPPanqtfi
	gpa5hC/gJtJ9PcBoJP+WNOb0OqlHJhe40ldcu+iDuJuu9/OVUZCc8CjqSHJQJoD3cJ1TPkJFrBP
	Yu9q4GZNXWjUdReBbiTLi+t5HPavuIeTrMP8COjCFWvvFeI5G8aN+W0hdnjc87FiZednJNvLNJZ
	qsIcys+R55ty20UpHpM23UWAy4GUaojniFwbR4ejb58SddlUXuEph2XR1qT4ki9RRl23MB6njk+
	3VKu0BQcsp6qYWxRUgdBS1KFClNaH/9Aw5XKS21mK9XfrUmIzOXrhmqPMNeAe1CjoqcdFXXrikU
	kjf8SGaSgvzNRm8jWlnyqfjIkVKQiNf47I8nTJlAbD3SOeKyogXvb2fzT26J7VBqBFiScgzjL4d
	yHgw8jMUyBhhEq2u9JV5NvZ6eFTbYHJe2HEyq/9JUTVwkLAn3W
X-Received: by 2002:a05:6214:1d2f:b0:8ef:9806:ddaa with SMTP id 6a1803df08f44-8f424cb88d0mr44233616d6.49.1782946238695;
        Wed, 01 Jul 2026 15:50:38 -0700 (PDT)
Received: from krios.home.ca.int.haoyugu.com ([198.58.242.173])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f4724bad04sm12064736d6.44.2026.07.01.15.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 15:50:38 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 2/5] selftests/bpf: libarena: Clean up allocation state before buddy tests
Date: Wed,  1 Jul 2026 18:50:31 -0400
Message-ID: <20260701225034.12628-3-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701225034.12628-1-emil@etsalapatis.com>
References: <20260701225034.12628-1-emil@etsalapatis.com>
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

