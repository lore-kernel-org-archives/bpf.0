Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793786394;
	b=P2Exd9vDUZ1/GJHeQPJEP2BJMqVROV/ej9Y46dAli3NIQgbRcZCW/GdldO2Th9h14oPr
	 HX6STC4rfj2v7O5YnHoRCzfFkg2CGqX2w4XLPTm68MF629YZNAdf8jGXvSvermVNuqV7E
	 D9ajv+iPIpBDlY0E5P4FNI4yG7gXNeA2gMg7Jt/WODm9Kofb7u04SB1NfHfXh6kPix1cW
	 cyPr+uHSO9KtYZe1shbYy+2k8DHtdFsb/LbUSqoLCNQtTwYJTMbORrspMKTzsYJrdBU6J
	 WRecroe8BpK/BQe6cdbuT48J0cCGaDthXUGN7Mg5KmP/aJ2d9c81srlh8CnaWZAvE7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793786394;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=y4W1eE8E1/91FCr6e2Z/bZGYHOBtRy+Y9cuTbiFyZt4=;
	b=yKx8f12BBHKE3gf13eCVzxRZlvAPf+gNTlCO1De6w6y2sumBxLeQtdAHEcn3XIyGUZ2m
	 PBqCj72iVTq4h8UmpT6PEfvEzvpxZRHJP30h2kf5loxTJIEOHsMIPYQSfL8a5AWEEW8uI
	 oOoN1UUgIc34Pq3K+gk6gPxSE78l+ljSg3uYD5fmc9VlvGrYD9OWJokBcjzgKhV/M7ZR/
	 lQzvBGh1V5uDwkZnirDhmdyKqxsHyS0B1Qj9u5FW1BlkWS2lwOf1WzQb1PE78nWZO5a7I
	 JXQ5Ij5t/WuG+7Wio2hyl0KiGoUHVVRCdKswc0cwDGwrkODzniEuTliOZj1YpNrldmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=oTuG6hva;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6C5606A326
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 09:59:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C6C5606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=oTuG6hva
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 57B0AC8F46C;
	Wed,  4 Nov 2026 10:00:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 57CC760770;
	Wed,  4 Nov 2026 09:59:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3D1C8103291CE;
	Wed,  4 Nov 2026 10:59:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793786388; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=y4W1eE8E1/91FCr6e2Z/bZGYHOBtRy+Y9cuTbiFyZt4=;
	b=oTuG6hva+dMWSHf42Vh9nNdVHHDPqd/uQJarO+o6MJbQe7Y4hdi10We0KJ8Cz0dt9YblEl
	BHbPitgMJ3mdZafKt4RYrZnobKnGm3O7GfHMaF7isrrsudiwjfZc/uDMMYvhC1gmhiNegT
	8glTxmSqzTtIndmQogvkAXJMiLx0QYQ1Dp+QWnK51gNtPKSctMHtAdaTu1QeQrKFs3+33G
	QW2WpcegVaua5FJnJIgQiWEwd6YAeH8Tzfz0we3X77GpUpD0gfLHLTCFfujfiCZnL08JCU
	hUf0xz9rVdHQBHptwnKfyzbnFsTbtqS3crdy7Iefj1x6tVFIR4wbEuqMRVqBLg==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Wed, 04 Nov 2026 10:59:33 +0100
Subject: [PATCH bpf-next v2] selftests/bpf: port test_ftrace.sh to
 test_progs
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261104-ftrace_in_test_progs-v2-1-45363230d228@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22OzQqDMBCEX6XsuSlJxAo99T2KSNxsdEubSJKKR
 Xz3+nPtcZj5ZmaGRJEpwe00Q6SREwe/Cn0+AfbGdyTYrhq01FcldSVcjgapYd9kSrkZYuiSsKW
 rpNFFIQ3Cig6RHE977QPawQlPU4b6cNKnfRLmrXXL9pxyiN/9wah24hgr5P+xUQkpjCklltYqR
 Ly3IeQX+wuGN9TLsvwASOD9mtYAAAA=
X-Change-ID: 20261027-ftrace_in_test_progs-d5f70a2330ac
To: ebpf@linuxfoundation.org, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

Commit ff205766dbbe ("ftrace: Fix function_graph tracer interaction with
BPF trampoline") made sure that trampolines generated for tracing
programs did not collide with the function graph when we are returning
from the hooked function. The series bringing this commit also came with
a new test ensuring that the kernel does not crash when executing BPF
programs handled by trampolines while the function graph trace is
enabled, but this test is a standalone shell script, hence not executed
in CI.

Convert the script to the test_progs runner so it can be executed
automatically by the CI infrastructure. There are two main options to
port this test:
  - just enable ftrace during some existing trampoline-related tests
    (eg: fentry/fexit tests)
  - create a dedicated, minimal test with function graph

The new test adopts the latter approach, with a smaller scope to keep
execution time reasonable, while reusing an existing
fentry/fexit/fmod_ret test. Despite the few asserts in the new test, the
actual goal is to make sure that the kernel does not crash because of
some incorrect stack frame skipping when both the function graph and
tracing programs are running.

ftrace is configured through a dedicated ftrace instance which is
dropped at the end of the test.

With the new test integrated into test_progs, drop test_ftrace.sh.

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
Hello,
this is v2 of a small series aiming to port the test_ftrace.sh script
(testing that trampolines and function graph behave correctly when both
are enabled) into the test_progs framework. The test is heavily
simplified following Alexei's review and suggestions.
---
Changes in v2:
- use a ftrace instance rather than global ftrace
- drop fgraph filters
- drop custom ftrace helpers in favor of direct manipulation in test
- drop custom bpf prog, reuse test_modify_return directly
- move test in existing test file (modify_return.c)
- make the test parallel (drop serial_)
- Link to v1: https://patch.msgid.link/20261030-ftrace_in_test_progs-v1-0-aa50c5dd1ccc@bootlin.com

To: Andrii Nakryiko <andrii@kernel.org>
To: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
To: Song Liu <song@kernel.org>
To: Yonghong Song <yonghong.song@linux.dev>
To: Jiri Olsa <jolsa@kernel.org>
To: Emil Tsalapatis <emil@etsalapatis.com>
To: Shuah Khan <shuah@kernel.org>
Cc: ebpf@linuxfoundation.org
Cc: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: linux-kernel@vger.kernel.org
Cc: bpf@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
---
 .../selftests/bpf/prog_tests/modify_return.c       | 32 ++++++++++++++++
 tools/testing/selftests/bpf/test_ftrace.sh         | 44 ----------------------
 2 files changed, 32 insertions(+), 44 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/modify_return.c b/tools/testing/selftests/bpf/prog_tests/modify_return.c
index 4661d77ebdfc..15681b49f86f 100644
--- a/tools/testing/selftests/bpf/prog_tests/modify_return.c
+++ b/tools/testing/selftests/bpf/prog_tests/modify_return.c
@@ -11,6 +11,10 @@
 #define LOWER(x) ((x) & 0xffff)
 #define UPPER(x) ((x) >> 16)
 
+#define MAX_INSTANCE_PATH_LEN	128
+#define TRACEFS_DEFAULT		"/sys/kernel/tracing"
+#define TRACEFS_IN_DEBUGFS	"/sys/kernel/debug/tracing"
+#define TRACE_FTRACE_DEFAULT	TRACEFS_DEFAULT "/trace"
 
 static void run_test(__u32 input_retval, __u16 want_side_effect, __s16 want_ret)
 {
@@ -61,3 +65,31 @@ void test_modify_return(void)
 		 0 /* want_side_effect */,
 		 -EINVAL * 2 /* want_ret */);
 }
+
+void test_modify_return_graph(void)
+{
+	char instance[MAX_INSTANCE_PATH_LEN];
+	char *ftrace_dir;
+	int ret;
+
+	ftrace_dir = access(TRACE_FTRACE_DEFAULT, F_OK) ? TRACEFS_IN_DEBUGFS :
+							  TRACEFS_DEFAULT;
+
+	ret = snprintf(instance, MAX_INSTANCE_PATH_LEN,
+		       "%s/instances/bpf-XXXXXX", ftrace_dir);
+	if (ret < 0)
+		return;
+
+	if (!ASSERT_OK_PTR(mkdtemp(instance), "mkdtemp"))
+		return;
+
+	SYS(out, "echo 'bpf_modify_return_test*' > %s/set_ftrace_filter",
+	    instance);
+	SYS(out, "echo function_graph > %s/current_tracer", instance);
+
+	test_modify_return();
+
+	SYS(out, "grep -q bpf_modify_return_test2 %s/trace", instance);
+out:
+	ASSERT_OK(rmdir(instance), "rmdir");
+}
diff --git a/tools/testing/selftests/bpf/test_ftrace.sh b/tools/testing/selftests/bpf/test_ftrace.sh
deleted file mode 100755
index f5109eb0e951..000000000000
--- a/tools/testing/selftests/bpf/test_ftrace.sh
+++ /dev/null
@@ -1,44 +0,0 @@
-#!/bin/bash
-
-if [[ -e /sys/kernel/tracing/trace ]]; then
-    TR=/sys/kernel/tracing/
-else
-    TR=/sys/kernel/debug/tracing/
-fi
-
-clear_trace() { # reset trace output
-    echo > $TR/trace
-}
-
-disable_tracing() { # stop trace recording
-    echo 0 > $TR/tracing_on
-}
-
-enable_tracing() { # start trace recording
-    echo 1 > $TR/tracing_on
-}
-
-reset_tracer() { # reset the current tracer
-    echo nop > $TR/current_tracer
-}
-
-disable_tracing
-clear_trace
-
-echo "" > $TR/set_ftrace_filter
-echo '*printk* *console* *wake* *serial* *lock*' > $TR/set_ftrace_notrace
-
-echo "bpf_prog_test*" > $TR/set_graph_function
-echo "" > $TR/set_graph_notrace
-
-echo function_graph > $TR/current_tracer
-
-enable_tracing
-./test_progs -t fentry
-./test_progs -t fexit
-disable_tracing
-clear_trace
-
-reset_tracer
-
-exit 0

---
base-commit: b0e67f50519538b1b4c6364edc7811f482703f75
change-id: 20261027-ftrace_in_test_progs-d5f70a2330ac

Best regards,
--  
Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>

