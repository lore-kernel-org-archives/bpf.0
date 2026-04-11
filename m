Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8699A2D2488;
	Sat, 11 Apr 2026 16:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775925445; cv=none; b=dG7JaedbUKg9DDqQbu2JL58DIqdmjuKeaC5dPMgxi91naMGZK85RkNl42c2JPrxUMwvDm/nzMK9bmeoWdExJfoIdVRlUkgZlglqRcZa7S6llldaGXRIPF8ROt1ph71iBeGPAk3OSYHEKGJt4CuZB9gHzmByjBuOONIub1aQda1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775925445; c=relaxed/simple;
	bh=X6KfuU1xGAMoYDth3ML5cPjtN20UZbGau8wgaqzEGH4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=TZtJ2xdwo8rX68ugEeBJ30zX5arxNZKuVfDf98sxauSGP7BEK6A83hPwdTavwGLQNWga94Aot5cZoXcSj6c3urqAw5EW6ftiSQ5eISnqArfj5lW9DRMWHHVD2dQ4VKNyUIeYiqMBoDrXwtbKgmK3fLfjSuhgKhPcmsjKYfIeLd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=gzz5Cm8J; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="gzz5Cm8J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id; bh=imhm8Gy5iuzPJ6w
	NyZl4KRJwqw5GT9O+YMrp7L7s8ig=; b=gzz5Cm8JqyFFf7Lgfkn83C2pErHkNCn
	0uHkOgVL4sQ8EqCuuPhzV09f8YcBge9FqEhY9jCywkTOmnBpzJu0kKLLTkWR1rYT
	Y3jxgkBKfoSmKFaN6dtdVKtg5lHXRte7QkiLb0tpBRINM+ka/zwFPnBgz9pEXsNX
	XeN0RviRMyjo=
Received: from yang-Virtual-Machine.mshome.net (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wAn3n9ueNppX_iUEg--.31671S4;
	Sun, 12 Apr 2026 00:36:02 +0800 (CST)
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
	jiayuan.chen@linux.dev,
	leon.hwang@linux.dev,
	menglong.dong@linux.dev
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Feng Yang <yangfeng@kylinos.cn>
Subject: [PATCH v3 bpf-next 2/2] selftests/bpf: Add selftests for verifying return values of fmod_ret.
Date: Sun, 12 Apr 2026 00:35:56 +0800
Message-Id: <20260411163556.8567-3-yangfeng59949@163.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260411163556.8567-1-yangfeng59949@163.com>
References: <20260411163556.8567-1-yangfeng59949@163.com>
X-CM-TRANSID:_____wAn3n9ueNppX_iUEg--.31671S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxXF13AFy8uFy5tw4kZryfCrg_yoWrXFy5pF
	4v9r9ruF4vyw13GFn7uF43AFyfXanrZa1UZFWIvwn3ZF18Jw1DJr4kGa45Xw1rGFZ8Cw4Y
	yrsxXws3C3WUAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jhManUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/xtbC8RJLw2naeHLu1wAA3r
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

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
 .../bpf/progs/verifier_fmod_ret_return.c      | 59 +++++++++++++++++++
 2 files changed, 61 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_fmod_ret_return.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index a96b25ebff23..5a8d14e3980e 100644
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
@@ -185,6 +186,7 @@ void test_verifier_direct_stack_access_wraparound(void) { RUN(verifier_direct_st
 void test_verifier_div0(void)                 { RUN(verifier_div0); }
 void test_verifier_div_mod_bounds(void)       { RUN(verifier_div_mod_bounds); }
 void test_verifier_div_overflow(void)         { RUN(verifier_div_overflow); }
+void test_verifier_fmod_ret_return(void)      { RUN(verifier_fmod_ret_return); }
 void test_verifier_global_subprogs(void)      { RUN(verifier_global_subprogs); }
 void test_verifier_global_ptr_args(void)      { RUN(verifier_global_ptr_args); }
 void test_verifier_gotol(void)                { RUN(verifier_gotol); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_fmod_ret_return.c b/tools/testing/selftests/bpf/progs/verifier_fmod_ret_return.c
new file mode 100644
index 000000000000..2c7daeaf0b69
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_fmod_ret_return.c
@@ -0,0 +1,59 @@
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
+__success
+int BPF_PROG(fmod_ret_sys_open_1)
+{
+	return 0;
+}
+
+SEC("fmod_ret/" SYS_PREFIX "sys_open")
+__failure __log_level(2)
+__msg("At program exit the register R0 has smin=1 smax=1 should have been in [-4095, 0]")
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

