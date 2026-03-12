Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C755938B138
	for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 10:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773312151; cv=none; b=jsBBKk2nn63npxhV7PCEbnYpEz1JqtCo222+9E//inMjqCf6cBYlhUWv+6qdPU7Q4Aamc1dFO4GFGGrjRWe6gosAURykoSEIg1MUtrFkBJQIJkPJTqq1/RTLtFwA9aNSZTBLvJ+B7bAUv3kHdp2lcMDuIXiTBxA5w1/s0kKCrDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773312151; c=relaxed/simple;
	bh=d+CeAbFtZhkUiTaNfrdWTguX5PcTdUnSvhkWZ6mqxk8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f71qnTKaP5aErouTVzT39rK1dVM15rhRXLLP1f2Ub5XXGMngj+4A+KzrlNghhKL6VD8Uu7d6ipNekTwjo+SrAqZNs40T0fZeacSrKQx3T16Q+yEXovJeSbWmqF89KYOlD4RGDi+f9rabBcewmG3PR3ONzcIu/2cmU/SYULGiwGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hWRfP8Au; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hWRfP8Au"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-4670676ba03so338342b6e.1
        for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 03:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773312149; x=1773916949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IvHmu8LUPGH1YebICVeQW+9lyevvMk2VGqIaR+2zRcM=;
        b=hWRfP8AuIQzFZlY1GHBo/oEw+2w1HkWJJfIy154FwG31U9MheYayQJUKyCK4HRBlM1
         sfJMdG2tDb1KaDiHeGBeAs6d0hfZM8CSpxLzvys2QpRf0rqkFJWzobIfNU1VlAVg8YyA
         yLLTBlc1ENxwzgxY7Ii6ikgxz6gQJRTJ6Exp06gNDrC8faKJOoQTrYqlKTIEyy1jovq6
         eYKzhPxkEFWw8y+3M8miM5HpsoAB/isUwYd2Ntux479gYzTnqC64YVzJ4qU61DdCSbkw
         pxcNiNcGLoyO2xvXKChtgGTUWcmRc7oClaodCi3BgyqUIb85okFzLE4lb+vaBdiuozZo
         llLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773312149; x=1773916949;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IvHmu8LUPGH1YebICVeQW+9lyevvMk2VGqIaR+2zRcM=;
        b=X0aaLEISbWY+55GqB85tYcTqwYW/zEcFYHcJSUQvO6YooUPSMwZbcl7GwmVWSBhX36
         F2lVV1fjaFgspG60WGmGuXa/qk80W8h2IENWTogLT4YaIIRYrcgOkiDBeDuZDcQT1xxq
         UtiC1eg33kEeGEn+d85rb9MDOJJ13pwyD2UN7otct3Q0Rybwzt0JrjD58YvNm8YFbYBp
         NoAWegcq7667awwWHRQDQPEMlEJGLp5tyKWtWBlDt3MmBVIOpE/sOrSh489mJoPm7HZc
         7161EJknTuFd1c7HnnAmm8ZK3FPLvVEQ2wLG5DHe9GFC4Qltd9qa7+aC+JwgcrH5M2cO
         6yeA==
X-Gm-Message-State: AOJu0YwZKpXDYA7KdijOFmsP0DdpNH+vXk/uEH8/YmAKxTBJLOtwtn85
	ACtZRxW/ZWsBnZrpMMhHYya7tWsJanxMQecMaWkBsACSyY7pURn4JV+xBkyegMsYx1xC8g==
X-Gm-Gg: ATEYQzyn/aN3jXt3I5yXI43Yy0iHpU1uiJW8LbU6HEFQssIBSxjQkcu4doD/D42I98k
	iI2v+Kc4zWdQpZuLUoF4KEJg7FgyP7723bPRs6+KL/TzZoLRNbYV3oezhnt0ct1ZTK+P3Mx9keG
	CVt4jBs9EXRIm+G9joNsHIg8E3r3/NW93fP69yZ29kCGFAnceOQ0QaFuYedG4AhCR6cPV9dcBNq
	Kgep+al1C9kRwxUgZJ3wRLTjnTT6gIjb8nfsNe+fjd77HoHOZMOuZQLQ+PmA9ncf9fNXZJoqbXq
	Gc1t67TKdmvOgwloBVB82aL6WRVs8bAy8IJWtuqoKDujQ6OnW3Gw7tEHaQvxZe/0/PWhhDOr+Vg
	95FEZ2XYxJCrOKTmesBKp9SMmxnUkErzj11r+nnp6CPi2rrRuk4ppssIb9ze/6KgaP3hxeJOqnN
	Mbq4PzYObPN5UzSuz/fuqLlb68ZU5lTTEb6M+6+4vpDzqoLyAhBpkakYqYmOlWpxdF/X3F9d+7w
	c+2FPcpy8iZT55ElUkk/c8=
X-Received: by 2002:a05:6808:c3ed:b0:467:2509:c207 with SMTP id 5614622812f47-4673342c547mr3107070b6e.17.1773312148621;
        Thu, 12 Mar 2026 03:42:28 -0700 (PDT)
Received: from localhost.localdomain (108-214-96-168.lightspeed.sntcca.sbcglobal.net. [108.214.96.168])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-46743aca62fsm1280665b6e.2.2026.03.12.03.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 03:42:28 -0700 (PDT)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	andrii@kernel.org,
	shuah@kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	martin.lau@linux.dev,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH] selftests/bpf: modify_return: isolate fmod_ret hooks by pid
Date: Thu, 12 Mar 2026 18:42:19 +0800
Message-ID: <20260312104219.1208802-1-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

modify_return's fmod_ret programs can override bpf_modify_return_test()'s
return value, which conflicts with get_func_ip_test when selftests run in
parallel.

Store current tgid in BSS and make modify_return hooks act only for that
tgid. For other tasks, fentry/fexit become no-ops and fmod_ret returns the
original ret.

Drop the serial-only restriction and remove the TODO comment.

Tested:
  sudo ./test_progs -t modify_return
  sudo ./test_progs -t get_func_ip_test
  sudo ./test_progs -j$(nproc) -t modify_return
  sudo ./test_progs -j$(nproc) -t get_func_ip_test

Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 .../selftests/bpf/prog_tests/modify_return.c  |  8 ++++---
 .../selftests/bpf/progs/modify_return.c       | 23 +++++++++++++++++++
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/modify_return.c b/tools/testing/selftests/bpf/prog_tests/modify_return.c
index a70c99c2f8c8..4661d77ebdfc 100644
--- a/tools/testing/selftests/bpf/prog_tests/modify_return.c
+++ b/tools/testing/selftests/bpf/prog_tests/modify_return.c
@@ -5,6 +5,7 @@
  */
 
 #include <test_progs.h>
+#include <unistd.h>
 #include "modify_return.skel.h"
 
 #define LOWER(x) ((x) & 0xffff)
@@ -23,11 +24,13 @@ static void run_test(__u32 input_retval, __u16 want_side_effect, __s16 want_ret)
 	if (!ASSERT_OK_PTR(skel, "skel_load"))
 		goto cleanup;
 
+	skel->bss->input_retval = input_retval;
+	skel->bss->test_pid = getpid();
+
 	err = modify_return__attach(skel);
 	if (!ASSERT_OK(err, "modify_return__attach failed"))
 		goto cleanup;
 
-	skel->bss->input_retval = input_retval;
 	prog_fd = bpf_program__fd(skel->progs.fmod_ret_test);
 	err = bpf_prog_test_run_opts(prog_fd, &topts);
 	ASSERT_OK(err, "test_run");
@@ -49,8 +52,7 @@ static void run_test(__u32 input_retval, __u16 want_side_effect, __s16 want_ret)
 	modify_return__destroy(skel);
 }
 
-/* TODO: conflict with get_func_ip_test */
-void serial_test_modify_return(void)
+void test_modify_return(void)
 {
 	run_test(0 /* input_retval */,
 		 2 /* want_side_effect */,
diff --git a/tools/testing/selftests/bpf/progs/modify_return.c b/tools/testing/selftests/bpf/progs/modify_return.c
index 3376d4849f58..5ff18ddb3050 100644
--- a/tools/testing/selftests/bpf/progs/modify_return.c
+++ b/tools/testing/selftests/bpf/progs/modify_return.c
@@ -7,16 +7,29 @@
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
+#include <stdbool.h>
 
 char _license[] SEC("license") = "GPL";
 
 static int sequence = 0;
 __s32 input_retval = 0;
+__u32 test_pid = 0;
+
+static __always_inline bool match_pid(void)
+{
+	__u64 pid_tgid = bpf_get_current_pid_tgid();
+
+	if (!test_pid)
+		return false;
+	return (__u32)(pid_tgid >> 32) == test_pid;
+}
 
 __u64 fentry_result = 0;
 SEC("fentry/bpf_modify_return_test")
 int BPF_PROG(fentry_test, int a, __u64 b)
 {
+	if (!match_pid())
+		return 0;
 	sequence++;
 	fentry_result = (sequence == 1);
 	return 0;
@@ -26,6 +39,8 @@ __u64 fmod_ret_result = 0;
 SEC("fmod_ret/bpf_modify_return_test")
 int BPF_PROG(fmod_ret_test, int a, int *b, int ret)
 {
+	if (!match_pid())
+		return ret;
 	sequence++;
 	/* This is the first fmod_ret program, the ret passed should be 0 */
 	fmod_ret_result = (sequence == 2 && ret == 0);
@@ -36,6 +51,8 @@ __u64 fexit_result = 0;
 SEC("fexit/bpf_modify_return_test")
 int BPF_PROG(fexit_test, int a, __u64 b, int ret)
 {
+	if (!match_pid())
+		return 0;
 	sequence++;
 	/* If the input_reval is non-zero a successful modification should have
 	 * occurred.
@@ -55,6 +72,8 @@ SEC("fentry/bpf_modify_return_test2")
 int BPF_PROG(fentry_test2, int a, int *b, short c, int d, void *e, char f,
 	     int g)
 {
+	if (!match_pid())
+		return 0;
 	sequence2++;
 	fentry_result2 = (sequence2 == 1);
 	return 0;
@@ -65,6 +84,8 @@ SEC("fmod_ret/bpf_modify_return_test2")
 int BPF_PROG(fmod_ret_test2, int a, int *b, short c, int d, void *e, char f,
 	     int g, int ret)
 {
+	if (!match_pid())
+		return ret;
 	sequence2++;
 	/* This is the first fmod_ret program, the ret passed should be 0 */
 	fmod_ret_result2 = (sequence2 == 2 && ret == 0);
@@ -76,6 +97,8 @@ SEC("fexit/bpf_modify_return_test2")
 int BPF_PROG(fexit_test2, int a, int *b, short c, int d, void *e, char f,
 	     int g, int ret)
 {
+	if (!match_pid())
+		return 0;
 	sequence2++;
 	/* If the input_reval is non-zero a successful modification should have
 	 * occurred.

base-commit: 80234b5ab240f52fa45d201e899e207b9265ef91
-- 
2.43.0

