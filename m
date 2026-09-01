Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A0437B000
	for <bpf@vger.kernel.org>; Tue,  1 Sep 2026 14:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788272415; cv=none; b=FIePkrnlpRTdTPBmxB/fNCznLFS09vS1PLicGifc/6dXK3fdvjkT3Apj+pJKnQ2OqLUDkcWOSNZeijkjfCkvFr/L72KTm6ziDqX384DocYhcXWHfcxZ4u+OS07ycFvAglgKNELLRNaNxjkMsE6S1xxumxoRnqfHjOqRtxS4RR04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788272415; c=relaxed/simple;
	bh=G9sBp1mVgaUE/l5rjm6ABkGFFWw70IL3CtMbcHYdHzo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aPHI5SQjbhGYVYU6XNIoJJjIXBTBcjlzxrk7K7pFkiyinXvzT8L1dDUtcGCc+tbBMBlUGQpPTm+O9OkiJ+1uLRxCm6NlDHpTiOJDy9zU538Bg25rMJpmAxLroyIDhsbxxPFJBtvda2o6iioJvAbtt2b5U5KAdAb5xDKMCvMWET4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rPgflv2i; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rPgflv2i"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3969e82ff8fso5088473a91.0
        for <bpf@vger.kernel.org>; Tue, 01 Sep 2026 07:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788272413; x=1788877213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fsOksJSp0HAMqHBUB3OXoIzMa/zTjlvvkjoIYMW4xXE=;
        b=rPgflv2iqBzzzQ8UwQy2mW48K2pFnOuDusH+ZYulL47IjeX2YvvkjL1WQb9BF60rP9
         G8SQU2J2XpWCqTB3FP6Aq3URyGWNwE6v0UGRIlqS0XytpBKmZtU09G31QS4f7ud4n0Lz
         /u00wNhE2ZC5tw1UQesJ1LaROqRQZD0pz+1MNxPM96BfycvTPTQVPNhJ+cEA0DwAm2Ys
         Y/nvRKRzo1LKonGeWmgoAuerebW/9rPzA+fLIt44s1uSol1ZF66icIfdLDc2dwt1Rnbb
         fErfCB/t+RjMFishnL3uCjIwVYFR01gLNFyebNLpImzbno7JcMeLCb2Mwaw/o46cchml
         U2sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788272413; x=1788877213;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fsOksJSp0HAMqHBUB3OXoIzMa/zTjlvvkjoIYMW4xXE=;
        b=Ccp8TAk+1Qic9nEtE4G3Vmr7QHoo3tPpF3Fkizjmneux5fHaa9EfKX533pJ276Xi+C
         VKhahjUAekjgvnta7h3uWScL+NlZBOAtY7ofjke6/MIqM1XoYEBAAD5YUiFXCB0PzlNR
         mtno0zpuuHe2cPtM3oLN/GOXxWDjESubt3WLTuj2PYd9Pvt4tRDyo2nImJ1ujH4K2+jt
         N/mXQC8Ns+BU4PvoQ3mbFubdT9SbT7nz5b3nb6r15fbsRF8GeAl1oV5G2FQ0FCVFmYQK
         g0HIeaJPBtO3nVXFtCkSgnXRlUvqvTBC1dA/D4kpkmjsxdrpyB+TjdpKF6+Cmv6C4gfe
         bf9g==
X-Forwarded-Encrypted: i=1; AKwUvBwWXmQPNccWF3Ov2VRexjahJzcYm7+XkRCEP82EsKfJ5Tz8eKm6dxCajIAVm2m/hqmo2ac=@vger.kernel.org
X-Gm-Message-State: AFuF++nqhM01HATiRermhnsSCX+wKjfe6Wlwn3hQtPS3rbz2zNHYWHkM
	g8SP7uKuGZ/8M8MVcqT1zZocyo93cb5Gsd/aCoqjy0ZX8j7NlyciEAkN
X-Gm-Gg: AYBFou2WH5wVoczuFzi+jGhDx+ZSOPrB19dAYjf50KpyXXSplNL35OzYkvInExkPHPq
	m85X2nDFFpJZcaaso+gY+L3HH/vqv7j+/GMXkfaSqa/kXAF8jipQYL4nJZQR7cHUZxTm8PAmP8G
	nvInh7uIwaSCjNAZIR3lcUqUT5vVf6AcytYjRazT8bcVO0SEAydvBNVV+S/TadU11hvfkT/nXzF
	Q8W/luIDtyVJw7Nlc/R+0jF33bMJdKEAdsmJYUfhPXWJRkMJ2iY3uu3Lq5kZw99IWkdIOlu/z1B
	BEXCiMlFhzuRWqnrphMJICRGH22j9ub460xzNbm6Xrx3vsM9HLmmxCW2fVZJ7gECIVmpOHbJHEA
	akjUossgHcwAWHAf00CmVOSI5ISaBt25XnB0GrATuh5jAxWJ4Z9FoUXF6oApjWZuqq39hL66rwI
	jevyBxhdQz9s+hxHHTuwS4eQBvOj4TqRb93XUqtMitVAC5D2EBglbmudsY04M1zv6LSHAU/qf8D
	Yw0uDLvHn5EzVlusBNA1GPEJJS/
X-Received: by 2002:a17:90b:4a8a:b0:399:e97:8d5a with SMTP id 98e67ed59e1d1-3990e97a0a4mr8920746a91.25.1788272412762;
        Tue, 01 Sep 2026 07:20:12 -0700 (PDT)
Received: from archlinux ([205.254.163.54])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32874498f9esm35589779eec.20.2026.09.01.07.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 07:20:12 -0700 (PDT)
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
To: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	shuah@kernel.org
Cc: emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	jolsa@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	zhoufeng.zf@bytedance.com,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Suchit Karunakaran <suchitkarunakaran@gmail.com>
Subject: [PATCH] selftests/bpf: Fix map_lookup_percpu_elem on sparse CPU IDs
Date: Tue,  1 Sep 2026 19:49:54 +0530
Message-ID: <20260901141954.29449-1-suchitkarunakaran@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

libbpf_num_possible_cpus() returns the number of possible CPUs, which is
appropriate for sizing packed per-CPU map value buffers. It is not the
upper bound for logical CPU IDs.

For a possible CPU mask such as 0,2-3, the test loops over CPU IDs 0
through 2. This incorrectly visits CPU 1 and misses CPU 3. It also
initializes packed per-CPU slots using their slot indexes rather than
the corresponding logical CPU IDs.

Parse the possible CPU mask and keep the packed slot count separate
from the logical CPU ID range. Populate each dense per-CPU slot with
its logical CPU ID, calculate the corresponding expected sum, and make
the BPF program iterate over the full CPU ID range.

Fixes: 7aa424e02a04bba5ecc84afe9b58b16e9e0b34f8 ("selftests/bpf: Fix some bugs in map_lookup_percpu_elem testcase")

Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
---
 .../bpf/prog_tests/map_lookup_percpu_elem.c   | 34 ++++++++++++++-----
 .../bpf/progs/test_map_lookup_percpu_elem.c   |  8 ++---
 2 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/map_lookup_percpu_elem.c b/tools/testing/selftests/bpf/prog_tests/map_lookup_percpu_elem.c
index bfb1bf3fd427..849f33259c00 100644
--- a/tools/testing/selftests/bpf/prog_tests/map_lookup_percpu_elem.c
+++ b/tools/testing/selftests/bpf/prog_tests/map_lookup_percpu_elem.c
@@ -2,29 +2,45 @@
 /* Copyright (c) 2022 Bytedance */
 
 #include <test_progs.h>
+#include "bpf/libbpf_internal.h"
 #include "test_map_lookup_percpu_elem.skel.h"
 
 void test_map_lookup_percpu_elem(void)
 {
 	struct test_map_lookup_percpu_elem *skel;
-	__u64 key = 0, sum;
-	int ret, i, nr_cpus = libbpf_num_possible_cpus();
+	bool *possible = NULL;
+	__u64 key = 0, sum = 0;
+	int cpu, nr_cpu_ids, nr_cpus, ret, slot = 0;
 	__u64 *buf;
 
-	buf = malloc(nr_cpus*sizeof(__u64));
-	if (!ASSERT_OK_PTR(buf, "malloc"))
+	ret = parse_cpu_mask_file("/sys/devices/system/cpu/possible", &possible,
+				  &nr_cpu_ids);
+	if (!ASSERT_OK(ret, "parse possible CPU mask"))
 		return;
 
-	for (i = 0; i < nr_cpus; i++)
-		buf[i] = i;
-	sum = (nr_cpus - 1) * nr_cpus / 2;
+	nr_cpus = libbpf_num_possible_cpus();
+	if (!ASSERT_GT(nr_cpus, 0, "libbpf_num_possible_cpus"))
+		goto free_mask;
+
+	buf = malloc(nr_cpus * sizeof(*buf));
+	if (!ASSERT_OK_PTR(buf, "malloc"))
+		goto free_mask;
+
+	for (cpu = 0; cpu < nr_cpu_ids; cpu++) {
+		if (!possible[cpu])
+			continue;
+		buf[slot++] = cpu;
+		sum += cpu;
+	}
+	if (!ASSERT_EQ(slot, nr_cpus, "possible CPU mask weight"))
+		goto exit;
 
 	skel = test_map_lookup_percpu_elem__open();
 	if (!ASSERT_OK_PTR(skel, "test_map_lookup_percpu_elem__open"))
 		goto exit;
 
 	skel->rodata->my_pid = getpid();
-	skel->rodata->nr_cpus = nr_cpus;
+	skel->rodata->nr_cpu_ids = nr_cpu_ids;
 
 	ret = test_map_lookup_percpu_elem__load(skel);
 	if (!ASSERT_OK(ret, "test_map_lookup_percpu_elem__load"))
@@ -55,4 +71,6 @@ void test_map_lookup_percpu_elem(void)
 	test_map_lookup_percpu_elem__destroy(skel);
 exit:
 	free(buf);
+free_mask:
+	free(possible);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_map_lookup_percpu_elem.c b/tools/testing/selftests/bpf/progs/test_map_lookup_percpu_elem.c
index ca827b1092da..d8da0696b97c 100644
--- a/tools/testing/selftests/bpf/progs/test_map_lookup_percpu_elem.c
+++ b/tools/testing/selftests/bpf/progs/test_map_lookup_percpu_elem.c
@@ -7,7 +7,7 @@
 __u64 percpu_array_elem_sum = 0;
 __u64 percpu_hash_elem_sum = 0;
 __u64 percpu_lru_hash_elem_sum = 0;
-const volatile int nr_cpus;
+const volatile int nr_cpu_ids;
 const volatile int my_pid;
 
 struct {
@@ -57,17 +57,17 @@ int sysenter_getuid(const void *ctx)
 
 	map_ctx.map = &percpu_array_map;
 	map_ctx.sum = 0;
-	bpf_loop(nr_cpus, read_percpu_elem_callback, &map_ctx, 0);
+	bpf_loop(nr_cpu_ids, read_percpu_elem_callback, &map_ctx, 0);
 	percpu_array_elem_sum = map_ctx.sum;
 
 	map_ctx.map = &percpu_hash_map;
 	map_ctx.sum = 0;
-	bpf_loop(nr_cpus, read_percpu_elem_callback, &map_ctx, 0);
+	bpf_loop(nr_cpu_ids, read_percpu_elem_callback, &map_ctx, 0);
 	percpu_hash_elem_sum = map_ctx.sum;
 
 	map_ctx.map = &percpu_lru_hash_map;
 	map_ctx.sum = 0;
-	bpf_loop(nr_cpus, read_percpu_elem_callback, &map_ctx, 0);
+	bpf_loop(nr_cpu_ids, read_percpu_elem_callback, &map_ctx, 0);
 	percpu_lru_hash_elem_sum = map_ctx.sum;
 
 	return 0;
-- 
2.55.0

