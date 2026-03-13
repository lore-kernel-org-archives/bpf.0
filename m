Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29D1364058
	for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 03:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773373553; cv=none; b=X0K4SoBoHq3tAWmZpoXpCM/YFqiaRKhEZup63yHih9aWPwc6ZtSwZmXeydFiq4AZzSv3GBnDSVHeLawlXSsXKooEENxh9pwYFDtpOaGLmkbSoShgRsTYdc2oHDL4sKl1umJm+BZo7K1fu8C3sN5g5sHsfxTlIuX8TG7rrbSxpvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773373553; c=relaxed/simple;
	bh=jphlk6Wj+UkJ81XaEDeMJBkuYruhl/JogH1+TkUDXFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IdKv3ENjW+PnAuf4rc4ygqQki9rLJvIKCadwdFaTVJnx4rOctALtQO7zUKiX0qkzg1BdF9oqdyUsUOZUNFdFUf9zsugpKUCM+DpPaxyyAuuuWPmqjBpjl+lBaQgLM1tLZTVB7783+tdE5bCO7vuuyE02+Mh/j8EKOGLIUZgSdKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l+dUIwhy; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+dUIwhy"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2bdd40d3c61so1615789eec.1
        for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 20:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773373551; x=1773978351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QfuNVGLPrYe0cNk/DRUBsR0PvweqtpMYTG7g9a6Yn3c=;
        b=l+dUIwhyGvVQc3HkxBrx+Pd/6cWNGncldGO96lRn4huLguqyntLeXyAQJcBUK+8wZB
         vbrkLWkENbY+njsxRY6y9zedGKJWHpNO4Eph7DiSpkey3rHejImYHcptTwuAHWdctPs+
         re4IZ8c1pht1Yqyrq+nFCIkhHGXH2/fxcnvQBdJUlHvwtfpb2v8Afc1NyvePJQ/KxcMN
         S74q3fbLsLVRKTc4D8xmorEWfj7aXdWZHmtZy0ri5X3Ywxg1duoWmcgwwx48+S5x+hBK
         OINTIdwI8gTZB7IAB75IDRnC81MS9S6Iw+QhbYw4q4AAQ9b8p8PD76ae9V8LkcsZ50eL
         HpUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773373551; x=1773978351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QfuNVGLPrYe0cNk/DRUBsR0PvweqtpMYTG7g9a6Yn3c=;
        b=BmJbtMcWu6i+uPmbBPK7/nLQb7RMWAslu18Dev0JXLSfFvKbs4Ap3IeNf3seOvwNMs
         APwmfW6/KPG4TYc4259cfyeqCaPHJGGljqMzwaGQZG/pZKLnn6CysLQAZeeHaERSKx7Y
         nkH6CYzAIGi2kSfdsBZAegZuvMib8/+6kAm49sDe78ID1Ezn/2w5OwEhWD/Gv5kcwa7A
         CLaxORSSSEVWLpiXeQMjQ6FDcAV36m39Qpgosh0jWsGt6ze9Br7kcA+IoBc3ZRFWIzqc
         XLTdkxvi//fJzafdZNLFliWSAYz9F1gv3C6Z+Bz3MCWID9o2bNuYHaPzjRfrohj2rBlb
         B5fA==
X-Gm-Message-State: AOJu0Yymc/a30qWjUXbq/Opi2CU7ahjxjI+bRO0MZdPGD+ieehxb1xbf
	6mqaTLFjFkTFcLsTlLIXvlozVmgXFYskQTzyeSAH16emA8adpvbvHBWEwxoyhAl2BUSDcA==
X-Gm-Gg: ATEYQzzLbgCU9u7ygp0HdCGE65x5MA/McL46lmos1Y6FvCP4zrjiT/0aacO1roAsDFd
	TbtBRKKTKovGkCGxttto3Z5I/WQ2fwk93Myh5L1HdFBzYV74bCKZKXMUDKvG640M9nWWCtnng6S
	xyjRW2+Xu8CdsMtLvKy8rCH5ZUA5bFtBhhc4h2uvzxglEmIWR5csoh1z/kO/CB4BeEH+aTRzbWN
	n/XEWNJxMEOmd2cAcAfMpWkM7UBhgSOsz81yjQi3KyapcCYN2eeVcGowqLM9K2wl3Dbw+Xt7QHB
	FSZ1j5IzaeDSBa2wRPRkh7IslaoNMUuM1ZeBBIJ2NJgYULaYqfIucfAoyOeX8/w39+Oo8SKVBIH
	MZ9nIU1Ek7vAdVjTtdScWY+aQidIVz2WDx0/SXX4A8j1dhJzwgrxH36GmrxIc/tIwiC9VjM3BGI
	56r9kD0l3+AqB3UBKcCFHLxceMGo6rVhL31LRhP1BcnRM6JKpfN6hyxKJc8WXDFeuukV6gWuifj
	Uy0IEJP1gaTMlwaE55c40X4YuM=
X-Received: by 2002:a05:7300:2389:b0:2b7:24ad:5c54 with SMTP id 5a478bee46e88-2bea5400f2dmr811212eec.9.1773373550759;
        Thu, 12 Mar 2026 20:45:50 -0700 (PDT)
Received: from localhost.localdomain (108-214-96-168.lightspeed.sntcca.sbcglobal.net. [108.214.96.168])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2beab3a0c34sm904347eec.7.2026.03.12.20.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 20:45:50 -0700 (PDT)
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
Subject: [PATCH v2] selftests/bpf: modify_return: isolate fmod_ret hooks by pid
Date: Fri, 13 Mar 2026 11:45:40 +0800
Message-ID: <20260313034540.255805-1-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260312104219.1208802-1-sun.jian.kdev@gmail.com>
References: <20260312104219.1208802-1-sun.jian.kdev@gmail.com>
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

v2:
- inline pid checks per suggestion from Jiri Olsa <jolsa@kernel.org>

 .../selftests/bpf/prog_tests/modify_return.c        |  8 +++++---
 tools/testing/selftests/bpf/progs/modify_return.c   | 13 +++++++++++++
 2 files changed, 18 insertions(+), 3 deletions(-)

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
index 3376d4849f58..68fabd2efe8d 100644
--- a/tools/testing/selftests/bpf/progs/modify_return.c
+++ b/tools/testing/selftests/bpf/progs/modify_return.c
@@ -12,11 +12,14 @@ char _license[] SEC("license") = "GPL";
 
 static int sequence = 0;
 __s32 input_retval = 0;
+__u32 test_pid = 0;
 
 __u64 fentry_result = 0;
 SEC("fentry/bpf_modify_return_test")
 int BPF_PROG(fentry_test, int a, __u64 b)
 {
+	if (bpf_get_current_pid_tgid() >> 32 != test_pid)
+		return 0;
 	sequence++;
 	fentry_result = (sequence == 1);
 	return 0;
@@ -26,6 +29,8 @@ __u64 fmod_ret_result = 0;
 SEC("fmod_ret/bpf_modify_return_test")
 int BPF_PROG(fmod_ret_test, int a, int *b, int ret)
 {
+	if (bpf_get_current_pid_tgid() >> 32 != test_pid)
+		return ret;
 	sequence++;
 	/* This is the first fmod_ret program, the ret passed should be 0 */
 	fmod_ret_result = (sequence == 2 && ret == 0);
@@ -36,6 +41,8 @@ __u64 fexit_result = 0;
 SEC("fexit/bpf_modify_return_test")
 int BPF_PROG(fexit_test, int a, __u64 b, int ret)
 {
+	if (bpf_get_current_pid_tgid() >> 32 != test_pid)
+		return 0;
 	sequence++;
 	/* If the input_reval is non-zero a successful modification should have
 	 * occurred.
@@ -55,6 +62,8 @@ SEC("fentry/bpf_modify_return_test2")
 int BPF_PROG(fentry_test2, int a, int *b, short c, int d, void *e, char f,
 	     int g)
 {
+	if (bpf_get_current_pid_tgid() >> 32 != test_pid)
+		return 0;
 	sequence2++;
 	fentry_result2 = (sequence2 == 1);
 	return 0;
@@ -65,6 +74,8 @@ SEC("fmod_ret/bpf_modify_return_test2")
 int BPF_PROG(fmod_ret_test2, int a, int *b, short c, int d, void *e, char f,
 	     int g, int ret)
 {
+	if (bpf_get_current_pid_tgid() >> 32 != test_pid)
+		return ret;
 	sequence2++;
 	/* This is the first fmod_ret program, the ret passed should be 0 */
 	fmod_ret_result2 = (sequence2 == 2 && ret == 0);
@@ -76,6 +87,8 @@ SEC("fexit/bpf_modify_return_test2")
 int BPF_PROG(fexit_test2, int a, int *b, short c, int d, void *e, char f,
 	     int g, int ret)
 {
+	if (bpf_get_current_pid_tgid() >> 32 != test_pid)
+		return 0;
 	sequence2++;
 	/* If the input_reval is non-zero a successful modification should have
 	 * occurred.

base-commit: 80234b5ab240f52fa45d201e899e207b9265ef91
-- 
2.43.0

