Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2008936073E
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 16:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769531666; cv=none; b=bS+Kla59N6lSnpeHkZA7bPirJ9bSBV7ck5atCz+drHZxFSvLnz9A/3e3RaDMlWrYQ/6X44UtjQhbMhNna3NO27b4FeLMCSbmjm6OBar4LFkChs2Gzcq1EKlGp9ag4zTUYcTlN3SbtSstN0sDtR/FoLfOOBNIn4oY6DMQ+QCT2Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769531666; c=relaxed/simple;
	bh=W0Cbpf0C4qMtUBveQ/36bOrYZCTa24nxvp5lxfIYjQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nCNONHmoBcozBzocQzK2Vs+CAVk8UkheuLPa1lXHlvNlGOP9YiYOudgGJdE6aBvmbSc5OvGXZeccpQYj/bKiQQIQnrihXkGciUpwYgZa/QfLV8xvFyim7PA+7u6hE5ZV3PKdFhRIP+6DYbh7JD48ha+QSXgbGk8nrvg2EQPnvh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Eorp8ZaS; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Eorp8ZaS"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769531663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=74wISzY+I2QQWizqfpjLw+tcNfcYrDh+eakCr6Jmco0=;
	b=Eorp8ZaSdCSRoAjQbof+94IZ9zp2MDPOWzukFJnbQY3XvfAAIncEUZxp0wMjL2iTdd6B4i
	m4eFdbLoscvu/8JefPTCCxGIj6x4aqiz3bEUC4TkyAHAURVF3KenJisoONoBn3pTFfileU
	YF5lcs50xT0TkGlGl11qSkGmkto2nNo=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next 2/2] bpf/selftests: Enable fsession and get_func_ tests on arm64*
Date: Wed, 28 Jan 2026 00:33:44 +0800
Message-ID: <20260127163344.92819-3-leon.hwang@linux.dev>
In-Reply-To: <20260127163344.92819-1-leon.hwang@linux.dev>
References: <20260127163344.92819-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Allow fsession, get_func_args, and get_func_ip selftests to run on arm64.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 tools/testing/selftests/bpf/prog_tests/fsession_test.c | 2 +-
 tools/testing/selftests/bpf/progs/get_func_args_test.c | 2 +-
 tools/testing/selftests/bpf/progs/get_func_ip_test.c   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/fsession_test.c b/tools/testing/selftests/bpf/prog_tests/fsession_test.c
index 0c4b428e1cee..d0cc6b1e29bf 100644
--- a/tools/testing/selftests/bpf/prog_tests/fsession_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/fsession_test.c
@@ -111,7 +111,7 @@ static void test_fsession_cookie(void)
 
 void test_fsession_test(void)
 {
-#if !defined(__x86_64__)
+#if !defined(__x86_64__) && !defined(__aarch64__)
 	test__skip();
 	return;
 #endif
diff --git a/tools/testing/selftests/bpf/progs/get_func_args_test.c b/tools/testing/selftests/bpf/progs/get_func_args_test.c
index 0a3236a7a109..180ba5098ca1 100644
--- a/tools/testing/selftests/bpf/progs/get_func_args_test.c
+++ b/tools/testing/selftests/bpf/progs/get_func_args_test.c
@@ -167,7 +167,7 @@ int BPF_PROG(tp_test2)
 }
 
 __u64 test7_result = 0;
-#ifdef __TARGET_ARCH_x86
+#if defined(bpf_target_x86) || defined(bpf_target_arm64)
 SEC("fsession/bpf_fentry_test1")
 int BPF_PROG(test7)
 {
diff --git a/tools/testing/selftests/bpf/progs/get_func_ip_test.c b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
index 65f7e1f182bf..43ff836a8ed8 100644
--- a/tools/testing/selftests/bpf/progs/get_func_ip_test.c
+++ b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
@@ -106,7 +106,7 @@ int BPF_URETPROBE(test8, int ret)
 
 __u64 test9_entry_result = 0;
 __u64 test9_exit_result = 0;
-#ifdef __TARGET_ARCH_x86
+#if defined(bpf_target_x86) || defined(bpf_target_arm64)
 SEC("fsession/bpf_fentry_test1")
 int BPF_PROG(test9, int a)
 {
-- 
2.52.0

