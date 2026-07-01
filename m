Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12120395D8E
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 18:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782931962; cv=none; b=BjHiqZsoqqRanSPJHZbqhWtRHXuLuMkHgPe9ozZn48HMWoOK/lgFtiIekR5JMra4V5aw6i/R5KNZ/wd1OL5pB52wOVe0v7jRxTY5bVrFkRsB1JTmkFxGIzg48cNX/jUU0GAWpto6lo9wOEX7LwV0DY0vaplkXMFTYpa3I2GRFoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782931962; c=relaxed/simple;
	bh=zqMU17yvDpAY3NsU5u5OvcAVcznTCf32fNVhXeKhOAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JSp9N/AqYssKyexvlQbUnbUMO4QwWxYRWgiS+csCJ5+16Zj/Va/yXnG3eaF4NbRjv85mPIbHR364j2PW4RdSW122FMmO3ZaI2WNg6i+D+3Z4Mn6nJ3MmVWVU0jXG8EJhtTAX40wB6Z6HVIHqKfae/i61LGNbewzswXQHldEf2bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=V5nwHlxU; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="V5nwHlxU"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-92e5b048375so48796985a.1
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2026 11:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1782931960; x=1783536760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S4A2vYRlXvI7gNWhu7CGHfWu/zfxDh25nTATnjyFElk=;
        b=V5nwHlxUKFwuOdON4IBxE4fM4kdpbe+dF6QGRcAN88VwbvNEVW1n5+XkQinXScaTg8
         qigiriFvZ3VXP4NBXtfStDaiByzYv1Cn08OcT9dHs+8BsQpDyZQEOPE3sxe4osLA+2av
         tI7GZCEecssyRU6vJvBE3WdCQKvHrWLjnvwXQie+PVVm08oPV+QkhVPzLH52EzEff7qb
         aF02FBifgK6JCvIW/AQREtFpfdsnz1eURVvOA0AJFQoIvlHVytw/gLXgfc+WJmCsN2g1
         Kx/+CdA//qPV8d5Bwedy1PlWuNtOWs5hmKrbzOHkaEBaYOLSw+ZDcAvu4zDBXYcrtiGy
         NzKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782931960; x=1783536760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S4A2vYRlXvI7gNWhu7CGHfWu/zfxDh25nTATnjyFElk=;
        b=rn5nDxtdoT7vC+l7uozbPR2/ITnTjle0G8Wkq3xHKS643hYuTzPlgXwHMAd4RKK3R4
         /xc6KO+v/CqRpbTRUs6Em0aR9qbCdLj8IpFbfRUNLdSSBkrjyNwCKpW6GEDQZzpR1QlE
         vyhHw3+aWYB2fnH14PkA30pCUU1BB75MPTDhFf9btqABHPXulheTDcjBTR3qrnSfu3C+
         qz4J7jNKuBHFuR/S56ji7PxlT11eyeIV8S9C9EHasSFP27hpK86kMnRr2Q+q2nN4VhxI
         qplCg2k2aEp1PnjlACCbDfsYWcHojay9p5QiM8hvqTtVGmNI2uwW6mQ6V15M1QRunJ/k
         RjKQ==
X-Gm-Message-State: AOJu0Yx0NnX+tei9mMJ2ikn8woqWNsGQlDdX6mLxIhQsgHd1I7hk605h
	BhEoHXbwKu9L62ypFCxBqYQ1u/yS3GyRgClWKFxdGWA8CsVGpQbzD7ARIykaMlLEOGN22V1cBoW
	eFOGT5Hg=
X-Gm-Gg: AfdE7clI40MxtZN9YV5XvTYRfgbIyrAQJhQWvr0ZEEa293OBhXBHh0kjgUuOGy7F99V
	Cxwux3Yc+LgplurROQ+1ZVwPVBp4MdS1hN818TGKEiItQ0W/52TGOrqFWFsSM3PydG3+s6N/2yV
	IL0a9zABVkNXVl99zAyBihHa6/5dhROijXcjKzHTXUcRwv3KUmUkTbgW4SAXkz8kaNTf7EsdSHl
	C6Hejd412dthTwxKj6B+FQypUxFNF5EA0gsqfYqd0tlliL6wKXnTxmmQ/AfugxSzufKcb+ZulaD
	RWmgMPWs1g3FnkviNINPp+nN7TAsT4ZElTzzgBvYS69Atx2QFOxI4RlbYQUtp7qoEi19fIiFZPD
	WpIcrC3kyjC/at+5zkmNo7oGg1gbEgxV6OgeoRCvXgYR6gox5VkVR7hP4Y8GFKL6Cfml59LrLj0
	68aFSxv6yzh7EM4dezh5nNBgjCjNal9ZY7QfAYKQ==
X-Received: by 2002:a05:620a:3186:b0:92e:4e45:dea2 with SMTP id af79cd13be357-92e781d4183mr432900185a.6.1782931960007;
        Wed, 01 Jul 2026 11:52:40 -0700 (PDT)
Received: from krios.home.ca.int.haoyugu.com ([198.58.242.173])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e801949d9sm12876685a.36.2026.07.01.11.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 11:52:39 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 2/5] selftests/bpf: libarena: Clean up allocation state before buddy tests
Date: Wed,  1 Jul 2026 14:52:32 -0400
Message-ID: <20260701185235.4516-3-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701185235.4516-1-emil@etsalapatis.com>
References: <20260701185235.4516-1-emil@etsalapatis.com>
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

