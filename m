Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA0B29AAEA;
	Fri, 10 Apr 2026 06:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775801526; cv=none; b=adV/rm9IkCzvD/A6mMIXVDQDSlns0OoejkaXTGeVd+o/o+KwVxYreIYByma3Vtc6f294lkN2vnOSTqvNupPs+ysPvpjr3kRFyS6uI4r0QB2D874I8JSXkwQRLE8ap2CJefPkPXX7FV1leJf86Fv7g63blTcrOWaFzMfAe5rmZFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775801526; c=relaxed/simple;
	bh=rivNMzxXrs9lHPPIuhozjHmdmlyJEjRXgGypuqw7qR8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lxDDXOUe7KvJ6D3eKSg7w5wsbHBeo4WTbxaAE6MsWUG0juB4vRh5zFmuhdJan5GTXWy45MoR61nMYBmG2DVeuncZf600zjDRrPw8//d5ZPmNfSGliZ9Q8lT9SJwSYJwzM2/hsyzKAQWkuJvCMQpctxL7aodr5+N7cwrxoscAXdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=KzbwIPjw; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="KzbwIPjw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=If
	FPalp3WHxpMdpiLbcJeroljTSghFPD7+9njMmArlo=; b=KzbwIPjwzVCrm+m2f6
	6ncm8Ks52+w8avLBzTq3uyAusVp9Prr4OGmIb68nnebu5198ZFcnmzXc5ZlrV0tK
	1nL0z2CzxPgywRgcLovV0/lF36nzF/PyP+6dh4spTXVbIjEggU6NsMwSIz259HNl
	XSvIAF47oeZg+kWs7DDtDUUDg=
Received: from localhost.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgDn739elNhpd0HuZg--.6807S4;
	Fri, 10 Apr 2026 14:10:41 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	mattbobrowski@google.com,
	jiayuan.chen@linux.dev
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 bpf-next 2/2] selftests/bpf: Add selftests for verifying return values of fmod_ret.
Date: Fri, 10 Apr 2026 14:10:37 +0800
Message-Id: <20260410061037.149532-3-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260410061037.149532-1-yangfeng59949@163.com>
References: <20260410061037.149532-1-yangfeng59949@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgDn739elNhpd0HuZg--.6807S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxXF13AFy8uFy5tw4kZryfCrg_yoWrWF47pF
	4kur9ruF1vywnxGFn7uF43AFyfX3Z7Zw45ZFWIvwnrZF18Jr1DJr4kGa45Xw1rGFZ8Cw4Y
	yrsxtws3C3WUCaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jopB-UUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/xtbC8gHNRmnYlGF3rgAA3l

From: Feng Yang <yangfeng@kylinos.cn>

Add selftests for verifying return values of fmod_ret.
test_progs -t verifier_fmod_ret_return
569/1   verifier_fmod_ret_return/fmod_task_alloc_1:OK
569/2   verifier_fmod_ret_return/fmod_task_alloc_2:OK
569/3   verifier_fmod_ret_return/fmod_ret_sys_open_1:OK
569/4   verifier_fmod_ret_return/fmod_ret_sys_open_2:OK
569/5   verifier_fmod_ret_return/fmod_ret_sys_open_3:OK
569/6   verifier_fmod_ret_return/fmod_page_pool_alloc_netmems_1:OK
569/7   verifier_fmod_ret_return/fmod_page_pool_alloc_netmems_2:OK
569     verifier_fmod_ret_return:OK
Summary: 1/7 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
---
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../bpf/progs/verifier_fmod_ret_return.c      | 60 +++++++++++++++++++
 2 files changed, 62 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_fmod_ret_return.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 169cf7fbf40f..6e67f69d88fa 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -37,6 +37,7 @@
 #include "verifier_div0.skel.h"
 #include "verifier_div_mod_bounds.skel.h"
 #include "verifier_div_overflow.skel.h"
+#include "verifier_fmod_ret_return.skel.h"
 #include "verifier_global_subprogs.skel.h"
 #include "verifier_global_ptr_args.skel.h"
 #include "verifier_gotol.skel.h"
@@ -184,6 +185,7 @@ void test_verifier_direct_stack_access_wraparound(void) { RUN(verifier_direct_st
 void test_verifier_div0(void)                 { RUN(verifier_div0); }
 void test_verifier_div_mod_bounds(void)       { RUN(verifier_div_mod_bounds); }
 void test_verifier_div_overflow(void)         { RUN(verifier_div_overflow); }
+void test_verifier_fmod_ret_return(void)      { RUN(verifier_fmod_ret_return); }
 void test_verifier_global_subprogs(void)      { RUN(verifier_global_subprogs); }
 void test_verifier_global_ptr_args(void)      { RUN(verifier_global_ptr_args); }
 void test_verifier_gotol(void)                { RUN(verifier_gotol); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_fmod_ret_return.c b/tools/testing/selftests/bpf/progs/verifier_fmod_ret_return.c
new file mode 100644
index 000000000000..11d303b01c80
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_fmod_ret_return.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+
+SEC("fmod_ret/security_task_alloc")
+__success
+int BPF_PROG(fmod_task_alloc_1)
+{
+	return -1;
+}
+
+SEC("fmod_ret/security_task_alloc")
+__failure __log_level(2)
+__msg("At program exit the register R0 has smin=1 smax=1 should have been in [-4095, 0]")
+int BPF_PROG(fmod_task_alloc_2)
+{
+	return 1;
+}
+
+SEC("fmod_ret/" SYS_PREFIX "sys_open")
+__failure __log_level(2)
+__msg("At program exit the register R0 has smin=0 smax=0 should have been in [-4095, -1]")
+int BPF_PROG(fmod_ret_sys_open_1)
+{
+	return 0;
+}
+
+SEC("fmod_ret/" SYS_PREFIX "sys_open")
+__failure __log_level(2)
+__msg("At program exit the register R0 has smin=1 smax=1 should have been in [-4095, -1]")
+int BPF_PROG(fmod_ret_sys_open_2)
+{
+	return 1;
+}
+
+SEC("fmod_ret/" SYS_PREFIX "sys_open")
+__success
+int BPF_PROG(fmod_ret_sys_open_3)
+{
+	return -1;
+}
+
+SEC("fmod_ret/page_pool_alloc_netmems")
+__failure __log_level(2)
+__msg("At program exit the register R0 has smin=1 smax=1 should have been in [0, 0]")
+int BPF_PROG(fmod_page_pool_alloc_netmems_1)
+{
+	return 1;
+}
+
+SEC("fmod_ret/page_pool_alloc_netmems")
+__success
+int BPF_PROG(fmod_page_pool_alloc_netmems_2)
+{
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.43.0

