Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AE723A98D
	for <bpf@vger.kernel.org>; Sun,  8 Feb 2026 16:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770568456; cv=none; b=VrU1O4cwb6tun3r950bEpdFi3z2rNCeXcmKluE61pPyPfgTtvH64R4vAl2cFUF+IRqS2YMNVgQnwOYnufiquwrxWkvGMopuT7kIUOVkJinnTOJNySE/Dbfs7JW4uH71m5D7/WiiBB1XGlF4TZNPHviK6Ywz8tKz7wXMkm65MSC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770568456; c=relaxed/simple;
	bh=IOEZGXV+uj67w6mn6SiwqOpGB3wWjRWff6sDhR4YQnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UmZq29oH0vlxJfQEC49bqQ056pjeX9HWdD1ZJgWQ31avkOnY/MTKzTep5UskdToxSwmQHkPRr7U7DjGzj8qEKDAw1rwFTwib5UeyZw7QUUt1bLzpt5qN3EZi0txdYqyakH2YS362kwx5DKGzkr/8/f7OY29Q9Cy38/z2mfqy/CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZ70ZuyM; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZ70ZuyM"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a95de4b5cbso16432375ad.1
        for <bpf@vger.kernel.org>; Sun, 08 Feb 2026 08:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770568455; x=1771173255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xrSYvQ77Jpo5ax2oz42VqvBquSYuMO57lB+3HBZbqBo=;
        b=bZ70ZuyMv4ZbT3HMTEJF9ETVLo+FDtBf4htlZ3kDd7Hh011Q0tGj8LmP3WxwoYwfZM
         HAKW/7gmC24IRh15wcKRM67qaZPu3M8QfbskjaaDA3LiD9wdqC8xcL8U+KhOPHxhttlk
         Pe8oGqmTgc8+/uMDMYEvEQvwQ2GmVfGFtQJg+rm3ds1FitaLqw/oJxMNepbx+glidSYK
         O99uBk2FOMQSMPhaq8d+c8f9HMSPwTJbwyBsJWtDclGwDA9MGkPp7DQKJNCFHGcBdE+0
         aarrZ6Ej9P4qMAKxJMxY44zkcFgs2xeH3aE9ftFWbKHsGxOxaC5galb6DdjTTBGru54z
         fGlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770568455; x=1771173255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xrSYvQ77Jpo5ax2oz42VqvBquSYuMO57lB+3HBZbqBo=;
        b=a8B0GYc52+pJHTtHHqLSmSPTjdPdvuPqypNvkwEgnCWOC2Qawt3cid8SHHKlPZhKJk
         cr7UrYfiq/8yXPTTOwJIfgyGSDYjiducI6ONxQP7SsQP3OvvsIzbEooLFA5cqwF7y/i/
         JbtmKgn3lHWzgLf/h9TLwMARHqYy4DxZ7xyfJHjmjrFFLDILTnHfpJ0b6RJNMsOW2kgv
         zpqXgVpKKbL0aYKJsIe40A0TontD5ERFr94L9VlXvMafXrlExnCFXtUVjXwN5vNR12TD
         m8C81x+eUHGR8xl6JxLGiv44YVhFtLj7uFstdTPgnxx4XII3F4ynZo2eY1wtkPk9MKo0
         vo7w==
X-Gm-Message-State: AOJu0Yzgyrvni2cm89I+7VQrMCMa3U1wXX6W4nxZhnSQglf2UNcOoEqk
	agRAAQNGt17aTRzCWBZiBmvHEIMcY67GbgJNxtXeoQT0CorpialdSIRJG1NWrA==
X-Gm-Gg: AZuq6aK2pobcDCjeZxRVhNd55wdCUJsyRmpiR+GXruTrMLmAbIqzCfHR+tCtqxzjHPy
	4OqO2KTIxGjUq/I+HuIFQ3RVTGPIPo1/SmyyqDfuGYAhwLuiBqRH0n14My5mclmOSuhhtAjXQeG
	PqOoTfTl3oVPE3RQcm/mbcdhdgXjIjHBt87K5LXCL5ea3ishx5kaldZFU80UZGscWMC+Bt3wrjN
	pxGp3gq0GZEV6FNgbE8k/shbTdfoMHDDTy5RugOhjo4wn8vZd5V96qac5fQwF8tiXsv+/UE52/u
	86bfepHBgYMU8008BT2qrBKQ86hk44IATj60GzGQFLaXyZWuGhJAg1+xxgU0asYeghsniVnaOWC
	7SKVxb/1KwmNxwGXLVeet3uoxR5yAUbiUEk9QiYFR2k5oCJc32z3G1HMkADA+RGGpVKOMfDcQvK
	spzmd/29QqRG4yujuWidk46S6V2DLcsRoHvN9Vd3I0tPZWzLX94DpZ/2/VaS8xUtm3czInQF+iI
	QDtXKxrca/u5+unparSg/JhpaxL3qQ0b6omvIIZf01YuYPZLg==
X-Received: by 2002:a17:902:d510:b0:2aa:dcc0:36d with SMTP id d9443c01a7336-2aadcc00551mr23988965ad.29.1770568454924;
        Sun, 08 Feb 2026 08:34:14 -0800 (PST)
Received: from localhost.localdomain ([2601:600:837f:c6b0:18cf:ab6c:cac0:3007])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a951c7a342sm79889445ad.26.2026.02.08.08.34.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 08 Feb 2026 08:34:14 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	puranjay@kernel.org
Subject: [PATCH bpf-next 2/2] selftests/bpf: jne/jeq fork test
Date: Sun,  8 Feb 2026 08:34:05 -0800
Message-ID: <20260208163406.14974-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260208163406.14974-1-alexei.starovoitov@gmail.com>
References: <20260208163406.14974-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../bpf/progs/verifier_jeq_jne_fork.c         | 204 ++++++++++++++++++
 2 files changed, 206 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_jeq_jne_fork.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 302286a80154..25f4a095938d 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -47,6 +47,7 @@
 #include "verifier_int_ptr.skel.h"
 #include "verifier_iterating_callbacks.skel.h"
 #include "verifier_jeq_infer_not_null.skel.h"
+#include "verifier_jeq_jne_fork.skel.h"
 #include "verifier_jit_convergence.skel.h"
 #include "verifier_ld_ind.skel.h"
 #include "verifier_ldsx.skel.h"
@@ -191,6 +192,7 @@ void test_verifier_helper_value_access(void)  { RUN(verifier_helper_value_access
 void test_verifier_int_ptr(void)              { RUN(verifier_int_ptr); }
 void test_verifier_iterating_callbacks(void)  { RUN(verifier_iterating_callbacks); }
 void test_verifier_jeq_infer_not_null(void)   { RUN(verifier_jeq_infer_not_null); }
+void test_verifier_jeq_jne_fork(void)         { RUN(verifier_jeq_jne_fork); }
 void test_verifier_jit_convergence(void)      { RUN(verifier_jit_convergence); }
 void test_verifier_load_acquire(void)         { RUN(verifier_load_acquire); }
 void test_verifier_ld_ind(void)               { RUN(verifier_ld_ind); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_jeq_jne_fork.c b/tools/testing/selftests/bpf/progs/verifier_jeq_jne_fork.c
new file mode 100644
index 000000000000..bde661e0ce2a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_jeq_jne_fork.c
@@ -0,0 +1,204 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Tests for JEQ/JNE not-equal branch forking.
+ *
+ * When the verifier processes JEQ/JNE with a known constant, it forks
+ * the not-equal branch into two sub-states:
+ *   fork1: dst > const  (unsigned, via JGT refinement)
+ *   fork2: dst < const  (unsigned, via JLT refinement)
+ * This gives tighter range tracking than the original JNE edge-trim,
+ * which only adjusts bounds when the constant is at the range boundary.
+ */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+/* JNE with BPF_K: both forks land on the jump target and are popped
+ * from the verifier stack, so both appear in the "from X to Y:" log.
+ *
+ * r0 in [0, 7], JNE r0, 3:
+ *   fork2 (popped first, JLT): r0 in [0, 2]
+ *   fork1 (popped second, JGT): r0 in [4, 7]
+ */
+SEC("socket")
+__description("jne_k: neq branch forked into r0 > 3 and r0 < 3")
+__success __log_level(2)
+__msg("R0=scalar(smin=smin32=0,smax=umax=smax32=umax32=2")
+__msg("R0=scalar(smin=umin=smin32=umin32=4,smax=umax=smax32=umax32=7")
+__retval(0)
+__naked void jne_k_neq_fork(void)
+{
+	asm volatile (
+	"call %[bpf_ktime_get_ns];"
+	"r0 &= 7;"
+	"if r0 != 3 goto l_neq_%=;"
+	"r0 = 0;"
+	"exit;"
+	"l_neq_%=:"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+/* JEQ with BPF_K: fork1 is the continuation (not popped) and fork2
+ * is popped.  We verify fork2's bounds in the log.
+ *
+ * r0 in [0, 7], JEQ r0, 3:
+ *   fork1 (continuation, JGT): r0 in [4, 7]
+ *   fork2 (popped, JLT):       r0 in [0, 2]
+ */
+SEC("socket")
+__description("jeq_k: neq branch forked, fork2 has r0 < 3")
+__success __log_level(2)
+__msg("R0=scalar(smin=smin32=0,smax=umax=smax32=umax32=2")
+__retval(0)
+__naked void jeq_k_neq_fork(void)
+{
+	asm volatile (
+	"call %[bpf_ktime_get_ns];"
+	"r0 &= 7;"
+	"if r0 == 3 goto l_eq_%=;"
+	"r0 = 0;"
+	"exit;"
+	"l_eq_%=:"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+/* JEQ with BPF_X: register source containing a known constant.
+ *
+ * r0 in [0, 7], r1 = 3, JEQ r0, r1:
+ *   fork2 (popped, JLT): r0 in [0, 2]
+ */
+SEC("socket")
+__description("jeq_x: neq branch forked with register source")
+__success __log_level(2)
+__msg("R0=scalar(smin=smin32=0,smax=umax=smax32=umax32=2")
+__retval(0)
+__naked void jeq_x_neq_fork(void)
+{
+	asm volatile (
+	"call %[bpf_ktime_get_ns];"
+	"r0 &= 7;"
+	"r1 = 3;"
+	"if r0 == r1 goto l_eq_%=;"
+	"r0 = 0;"
+	"exit;"
+	"l_eq_%=:"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+/* JMP32 JEQ with BPF_K: 32-bit comparison variant.
+ * Fork uses u32_min/u32_max for the feasibility check.
+ *
+ * w0 in [0, 7], JEQ32 w0, 3:
+ *   fork2 (popped, JLT32): w0 in [0, 2]
+ */
+SEC("socket")
+__description("jeq32_k: 32-bit neq branch forked")
+__success __log_level(2)
+__msg("R0=scalar(smin=smin32=0,smax=umax=smax32=umax32=2")
+__retval(0)
+__naked void jeq32_k_neq_fork(void)
+{
+	asm volatile (
+	"call %[bpf_ktime_get_ns];"
+	"w0 &= 7;"
+	"if w0 == 3 goto l_eq_%=;"
+	"r0 = 0;"
+	"exit;"
+	"l_eq_%=:"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+/* JNE with larger range and different constant.
+ * r0 in [0, 255], JNE r0, 100:
+ *   fork2 (JLT): r0 in [0, 99]
+ *   fork1 (JGT): r0 in [101, 255]
+ */
+SEC("socket")
+__description("jne_k: neq branch forked with wider range")
+__success __log_level(2)
+__msg("R0=scalar(smin=smin32=0,smax=umax=smax32=umax32=99")
+__msg("R0=scalar(smin=umin=smin32=umin32=101,smax=umax=smax32=umax32=255")
+__retval(0)
+__naked void jne_k_neq_fork_wide(void)
+{
+	asm volatile (
+	"call %[bpf_ktime_get_ns];"
+	"r0 &= 0xff;"
+	"if r0 != 100 goto l_neq_%=;"
+	"r0 = 0;"
+	"exit;"
+	"l_neq_%=:"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+/* Const at umin boundary — no fork expected.
+ * r0 in [0, 7], JEQ r0, 0:
+ *   Fork condition: umin(0) < 0 is false for unsigned → no fork.
+ *   Edge-trim gives not-equal branch r0 in [1, 7].
+ */
+SEC("socket")
+__description("jeq_k: const at umin, no fork needed")
+__success
+__retval(0)
+__naked void jeq_k_no_fork_umin(void)
+{
+	asm volatile (
+	"call %[bpf_ktime_get_ns];"
+	"r0 &= 7;"
+	"if r0 == 0 goto l_eq_%=;"
+	"r0 = 0;"
+	"exit;"
+	"l_eq_%=:"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+/* Const at umax boundary — no fork expected.
+ * r0 in [0, 7], JEQ r0, 7:
+ *   Fork condition: umax(7) > 7 is false → no fork.
+ *   Edge-trim gives not-equal branch r0 in [0, 6].
+ */
+SEC("socket")
+__description("jeq_k: const at umax, no fork needed")
+__success
+__retval(0)
+__naked void jeq_k_no_fork_umax(void)
+{
+	asm volatile (
+	"call %[bpf_ktime_get_ns];"
+	"r0 &= 7;"
+	"if r0 == 7 goto l_eq_%=;"
+	"r0 = 0;"
+	"exit;"
+	"l_eq_%=:"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.47.3

