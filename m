Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607B73B777F
	for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 08:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781772999; cv=none; b=ll8hRmnPuL7Qf61+BRFIjv+sI0Hjc0+0h+yhjUPtunQ5uuWYJHZjFaLAox55kyhmU/AdDjlJxxPVgRpMkj8OHBqPu4i2VjQNPujd35peVyHtnjzqo/YFO1d7E9t8/cWnZRVe4uNvfdAN/9B6k691mugR5HeHiyAbHeViE8YIE94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781772999; c=relaxed/simple;
	bh=nqOn2AcXE7EzCnJf1AYXD4vArmSIey8wi+6JYbSmMko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cWHlMHjLVICLlRUgqD+KgABKvhz+0jo75YajBN4+KSk90IoPbUqCELxpGoQe3bHwFd4NkxxOvStyTCqmX65l2DBywQaUBSThooH6E1uF0XHFvNeQHozhf5IgbiZPB12W/KMiUrEzQWeRLCaOsypNIsSykQKe5jQVFHsDq/pWRJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=BuTyaK5v; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="BuTyaK5v"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-36d98b68d68so366037a91.2
        for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 01:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1781772998; x=1782377798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jffnNalF3mh/5UuzUyVpuHfdPIHNXVUjKiVqnZsJSgE=;
        b=BuTyaK5vFe0St0T42uSmqbadvdfVhh2UdWe9GUsT5qMFYwjfFVkC3SRnUQPcufbJRL
         nkfjzwdFyvrwkvYadcP6I6U4w61A1YOTB40fNideoSuRpEyErQMltLLBXgUg0Cdiy56n
         ei8WKeQ0TktkZPfSF8xTgQEvNeaYBtDoR2d1j3eEl6DRZb/uOHXNRZZlb0t2ptiA69a3
         xUXDGTmDYf5pdNwcOyvvDV8qCaNkU9GfeZMGGqFiLtYjrdFHPOWC3+xfASHZfRX2Eoae
         FG70P+nrLf+djDPCf2cGr0bEZXyNvAdTXR2O+FtPByC95YsRolzOoTPsa7f7yx2ixKoi
         84lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781772998; x=1782377798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jffnNalF3mh/5UuzUyVpuHfdPIHNXVUjKiVqnZsJSgE=;
        b=cKnLGxAQtU45eg83hzW1X99+KWEss+gO248WJIOCMklavC55gK7GJNdMqZSUL3JjOz
         f58ISJv55hBblHCbvN0Jl38OOPYBevGGCdNbmtd9zhwBzKc+5hkWWo/0p2+EqF74UzTr
         i0Mb4K54Xf7pacOV6XCenzZQ+1NDU3ZjYc/U8QpDthoCnCPn60zYDX58BHAMv4PERdpI
         uCxLzxNS3srUFioSYt4Vi703VJ5P3PCbmkubDnQJ+LwmBDtEpkm4TP9JF+vcK67men68
         1BCWfTzxDmc3hK+xIqB3E3HPDZV1S/elP5USc40ub3XWuNh8JXBT3Gtn2JhnTtJz/EBX
         dnwQ==
X-Gm-Message-State: AOJu0YyGOjuezI46gFW0JpZB7Mxg1d7SXUXlY0UmyHO0YyjGwep8PRzV
	FCjIJoL4xvzuKF2DONmi0lf6xXi9GFT2P6ZhvZXmmqu8gmPBNT+NvXK9uAFTZyeOsH3FR+/DHUH
	rqXHufLZtLw==
X-Gm-Gg: AfdE7cnC46IHouuvBc44vIiPYNVHu3wyIghft11jFadG8rLTR/Fexd+ogfs47Q/aRfX
	BXLWdQfH3P1ytWkMAilcDo5uvvt3k7nCWcodGzlfijf9VGOTYw5BE0H7YX+AhBKXPiwoSBSsOos
	GwpQVXZdqA6nLWgxAE/1MANigME9FBR1sNSM5gz7ohqZWpo1NZAbDJhGpiN7xR7mrukaS/igVOD
	G86xu8zPqpMPjHYtmtbv+i7ZsFyzBt9c3fW80GkTBvkBGKA/O+lsqhLQoyr27rXqpTV9wDDtnNY
	LMU6335Nw2t8mm8aNfdtaPlRIT/SGZ4YgF2bi+RvSk+hgJJ8FejAq2/oD+ksC6rNbOAXVP+pPXc
	72+c4DoaVh/lwt7xlew4Zh74Dq2mYppEtL5kjBx3AH+0nTnzX9ncM2M9jhkM2imbbny8lMBRs4B
	f1RAXs/uh/HLpPxMqEYbPPw3hm7ixUdj6uzrzTycI=
X-Received: by 2002:a17:90b:1cd0:b0:36d:ee3b:fcae with SMTP id 98e67ed59e1d1-37ce4512df2mr2543064a91.6.1781772997713;
        Thu, 18 Jun 2026 01:56:37 -0700 (PDT)
Received: from krios (S0106d8b37028eeb5.vc.shawcable.net. [24.84.91.85])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c88c6c2b2easm2524404a12.27.2026.06.18.01.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 01:56:37 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	mattbobrowski@google.com,
	song@kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next 3/5] selftests/bpf: libarena: Clean up allocation state before buddy tests
Date: Thu, 18 Jun 2026 04:56:24 -0400
Message-ID: <20260618085626.19633-4-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260618085626.19633-1-emil@etsalapatis.com>
References: <20260618085626.19633-1-emil@etsalapatis.com>
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

