Received: from mail-oo2-f8.google.com (mail-oo2-f8.google.com [74.125.231.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9041447811
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 03:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792380286; cv=none; b=f7Z0QMRVSj3Aasf1TjlMFEmLu79NDrIGrc+8joRdzUdVQ4yLImJcNJTvZDAGWv4oknRM1lRtpgNUTsoNPL1m3rsSqfg53qpFxIFY77RASHJxI8gc5yAHZpf/NnBY1tCt00JVxrgFKD2ArjJABJO5ZN4F32wWKVI+PbkJf6xdaXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792380286; c=relaxed/simple;
	bh=0QlVLxG7VGXXIGlqNeeuex6yzlL/165avtau86Co90M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gN9lhyet10RZQ+oi7veVGIfNEKCc2/cVxcs5lm8/k3EWaTS3n7dXIaQFlUJKHPyXat0NeeCdzIypxrsVJVULG858qdZm3G4dLZ//KBo/qftVjhok3dxkGb/CUWTuTaUY+focLs6Z5+7g40Bo0pOg+CtcOyTQ0O3QEsqqgbg12vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UI71nA2n; arc=none smtp.client-ip=74.125.231.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UI71nA2n"
Received: by mail-oo2-f8.google.com with SMTP id 46e09a7af769-843c8bbfbc4so816739a34.1
        for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 20:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792380283; x=1792985083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5JNJiZ/4PPAKsQPee7m171aiI+ghGpdz6y2XFAg9x0A=;
        b=UI71nA2nURHoY2OBM0AYtyKZ0Bd+44Wa0oNbKQEajEhzP39pdvGYS1lgmyd3m3wp4V
         CZcDN2uW1T61o3Je6612VsyzoVldZ3FtMh1AhQCeWa0fQ0Ar2X7uW0KciyNZlzC30CSZ
         e8O2oMZkK4HHgS8tgv57sfMs7sG9WW50CQa4/mJF/Lnmf3JYTLvy71mRJsx1Xkyk89ZX
         x7LgFRcvOTwF8De5jmMO9DLVdrcIEXjgxCuyWHG+AJWdToktT+oUvY1d2iB50Ey/eB6m
         LrK/qObiMgQNLWKFgjeUavl9zMIsqWj5rS92KQhH5K/ofuhS77G0hMrZ6FN6uJ+v/xg7
         DeXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792380283; x=1792985083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5JNJiZ/4PPAKsQPee7m171aiI+ghGpdz6y2XFAg9x0A=;
        b=QHtVdi8pI7YnnQWUokeyFazxwLuFAIHdYC+Hqizc/QGC2U3urHLyjcEucQzyXuPVW7
         BP3VIJHj8dYI12RRqG7vg21KZlHf9Tyesdp99PVxxjFmID1xxbYrS2FNv+a6HdEj1umV
         12MavTKCRfWMG/u3L3MYAsbF6Q98zvFyXxTC1+b3bs4TVpthCB0P/SYS29lb7ubc9H5V
         R64y8fULZ8+QztL0iS8IhqumzPoP02CH+tuv6A21DNWRCisC4JrF4hQzAwWBdpORgHmv
         xVLKpPzpLuA3XJSg8C6FxZc16Gv70AUHp9P+fENnqPhMGO8F4j1m9Um6ID6wQ0rqJzZh
         qnHw==
X-Gm-Message-State: AFq9FYK25ZH6M/2E6YaIFcXrlu0lSFODe+g3MjPQYegvMaI/fJCTI5HN
	ozdKjfeSNAK6iHgvrDK4QZylhP40tKTtZkslDQnQrLoAAfqVVJ9IrDmy3wyWG/eJKYY=
X-Gm-Gg: AYBFou2/WkfWYlXhggtRzTznHkUIoJ8Y5Tmtex93YpyzkmBs6O29kE2lFTnsfWNZA5k
	Vfap2Jjuh3zessJTDVlNO05Zk+Oy5NYBvNnXv3AMjnJOB1XiEMWePk5bLN5G7rmdXRY9JXL6wwH
	qTWReB6IixKPvizNi9tick3OiQa74ZvqXP7+/aGdmpLVNSwhycQdOxyS2vlIPfKYzjXhCLk9Mp+
	QV4b8pkxvQcySNaOEDYujwvOpDtip3S162pF2SuawmqEM81AmPYoywo8bEiGMSA3lqb0xJSLSvm
	/2kKpW0ORPWVH0dXvYhizpU/xXmqsveWUcXXM2jjEyN4rZN9K50DR/dMdQ+84mSnLXXuZsVFXyj
	P2AUwfJHMYWUbiMVggTsFc+7E779OpHnVQSzFr6Vlt59Q9EVWRrVjb9lK2sg/pwMbBs+RzVbLeJ
	6MsahnzCnbFZVPY1YlQqIm73Jp0hRcMD/MnbbhCdz55oJXWKefYsuvJWTWJ9MS9UvapFu4matc1
	mS9IxP8ATGQwqoT/Nb3NbuFrmII8Bl37PirOj8vL3xZhS5r0cHwFztLq7DHQQ0LLufRXw3tbArM
	rtyvfA==
X-Received: by 2002:a05:6808:1712:b0:537:428b:e84 with SMTP id 5614622812f47-53cd841b276mr5309836b6e.55.1792380283481;
        Sun, 18 Oct 2026 20:24:43 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:59::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5388d8ab165sm6050259b6e.11.2026.10.18.20.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 20:24:42 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 10/16] selftests/bpf: Move the no-arena tests out of objects with an arena map
Date: Mon, 19 Oct 2026 05:23:50 +0200
Message-ID: <20261019032401.2302823-11-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019032401.2302823-1-memxor@gmail.com>
References: <20261019032401.2302823-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4389; h=from:subject; bh=0QlVLxG7VGXXIGlqNeeuex6yzlL/165avtau86Co90M=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIetqr17sjBm3cn20bd5MvR2TXKi3ZsZiSf7mX6WRD1XFRJTV +Jk7SlkYxLgYZMUUWUr+72MyPlH5O9B2GTfMHFYmkCEMXJwCMBEOa4bfbPeWLODR+tcTGBldqiXxpm rv3L7235c2Zd5LVLpyh2+JPyPDiemCD6xeLl37VEipjePbpD+rGjIui/7Ii475xdHvqX6NFQA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Two programs expect to fail for want of an arena while living next to
an arena map: the kfunc argument case in arena_kfunc.c and the scalar
access case in verifier_arena_scalar.c. Once libbpf binds the arena of
an object to every program in it, they would load. Move them to an
object without an arena map ahead of that change, where the kernel
checks still apply, so that the tests pass at every step.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../testing/selftests/bpf/progs/arena_kfunc.c | 10 -----
 .../selftests/bpf/progs/arena_noarena.c       | 39 +++++++++++++++++++
 .../bpf/progs/verifier_arena_scalar.c         | 13 -------
 4 files changed, 41 insertions(+), 23 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/arena_noarena.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index c69c0f7e9cc8..6df440d82675 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -3,6 +3,7 @@
 #include <test_progs.h>
 
 #include "arena_kfunc.skel.h"
+#include "arena_noarena.skel.h"
 #include "arena_kfunc_jit.skel.h"
 #include "cap_helpers.h"
 #include "cb_refs.skel.h"
@@ -193,6 +194,7 @@ static void run_tests_aux(const char *skel_name,
 } while (0)
 
 void test_arena_kfunc(void)                   { RUN_TESTS(arena_kfunc); }
+void test_arena_noarena(void)                 { RUN_TESTS(arena_noarena); }
 
 void test_arena_kfunc_jit(void)               { RUN_TESTS(arena_kfunc_jit); }
 
diff --git a/tools/testing/selftests/bpf/progs/arena_kfunc.c b/tools/testing/selftests/bpf/progs/arena_kfunc.c
index 96f7aacf4d9f..a049d6371d09 100644
--- a/tools/testing/selftests/bpf/progs/arena_kfunc.c
+++ b/tools/testing/selftests/bpf/progs/arena_kfunc.c
@@ -192,16 +192,6 @@ int arena_arg_unpopulated(void *ctx)
 	return 0;
 }
 
-SEC("syscall")
-__arch_x86_64
-__arch_arm64
-__failure __msg("arena pointer requires a program with an associated arena")
-int arena_arg_no_arena(void *ctx)
-{
-	bpf_kfunc_arena_arg_test((u64 *)1);
-	return 0;
-}
-
 SEC("syscall")
 __arch_x86_64
 __arch_arm64
diff --git a/tools/testing/selftests/bpf/progs/arena_noarena.c b/tools/testing/selftests/bpf/progs/arena_noarena.c
new file mode 100644
index 000000000000..edbd40cd5be8
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/arena_noarena.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "../test_kmods/bpf_testmod_kfunc.h"
+
+/*
+ * Programs without an arena. They cannot share an object with an arena map,
+ * libbpf binds the arena of an object to every program in it.
+ */
+
+SEC("syscall")
+__arch_x86_64
+__arch_arm64
+__failure __msg("arena pointer requires a program with an associated arena")
+int arena_arg_no_arena(void *ctx)
+{
+	bpf_kfunc_arena_arg_test((u64 *)1);
+	return 0;
+}
+
+SEC("syscall")
+__flag(BPF_F_ARENA_SCALAR)
+__arch_x86_64
+__arch_arm64
+__description("arena_scalar: no arena, no access through a number")
+__failure __msg("R6 invalid mem access 'scalar'")
+__naked void no_arena(void)
+{
+	asm volatile ("					\
+	r6 = 0x100000000000 ll;				\
+	r0 = *(u64 *)(r6 + 0);				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_scalar.c b/tools/testing/selftests/bpf/progs/verifier_arena_scalar.c
index ecfc6873ffa9..6f0efd9202ca 100644
--- a/tools/testing/selftests/bpf/progs/verifier_arena_scalar.c
+++ b/tools/testing/selftests/bpf/progs/verifier_arena_scalar.c
@@ -991,19 +991,6 @@ __naked void no_flag(void)
 	: __clobber_all);
 }
 
-SEC("syscall")
-__arena_scalar
-__description("arena_scalar: no arena, no access through a number")
-__failure __msg("R6 invalid mem access 'scalar'")
-__naked void no_arena(void)
-{
-	asm volatile ("					\
-	r6 = 0x100000000000 ll;				\
-	r0 = *(u64 *)(r6 + 0);				\
-	exit;						\
-"	::: __clobber_all);
-}
-
 SEC("syscall")
 __arena_scalar
 __description("arena_scalar: pointer that is NULL is an address in arena")
-- 
2.53.0-Meta

