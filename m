Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE782BE043
	for <bpf@vger.kernel.org>; Thu, 29 Jan 2026 15:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769701894; cv=none; b=CyodLL21Wp/d+QdK8KIiC6ZYqaNmBpWeS88zBb6o24Ll6s6BCzYwEXgORg+LsOFed1HZ6DBiuP3rjC3iTRXdFxLynYTOhPFFDEU2rh53fD6TmN0V5pxHEFSZobdEDqCL+kgBJXxlWIR52LAh1ubhPt9qOS/Cba3aaz1VU4TiZeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769701894; c=relaxed/simple;
	bh=ABCasHTsALKcdN7oFkKdxhTLVHcfREqJKKSMGfcwlGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GXOSNcRT4PuhrlXLgjf+84wDpK6I+a0nK2tJtTD524TeWykYdnO70xETz+uSzlU/TBJObk9q8JqHWFBxvbga2mx15hMAJlvlQ39D1EXPNH8wb5kWipa+4X6q2TDJe4rWChg5Z7o/g141IAB2R3IJ5ua0iL/W4HGu87WMuhz3EW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Jg+RgFu3; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Jg+RgFu3"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769701889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UsgKjphUXvRPEydfwuOJKsLCOnCuQnH8s33K54ne5cQ=;
	b=Jg+RgFu3Tk22UtFb2WkFeSavtg/YuMaVdG/oKHvrWJmscr0ZN5hAK84SirZQkzncAQtWrn
	vD4ngzBWSa3iMFlcBRCm1EMX6BJRkK1OWXFl+D/kMwYI4k7vfvp59Jtk5W3un0O1pUnGcO
	gdTqgXbpruynjlUAlo7MENVu5PLipHQ=
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
Subject: [PATCH bpf-next v4 1/3] bpf: Add bpf_jit_supports_fsession()
Date: Thu, 29 Jan 2026 23:49:51 +0800
Message-ID: <20260129154953.66915-2-leon.hwang@linux.dev>
In-Reply-To: <20260129154953.66915-1-leon.hwang@linux.dev>
References: <20260129154953.66915-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The added fsession does not prevent running on those architectures, that
haven't added fsession support.

For example, try to run fsession tests on arm64:

test_fsession_basic:PASS:fsession_test__open_and_load 0 nsec
test_fsession_basic:PASS:fsession_attach 0 nsec
check_result:FAIL:test_run_opts err unexpected error: -14 (errno 14)

In order to prevent such errors, add bpf_jit_supports_fsession() to guard
those architectures.

Fixes: 2d419c44658f ("bpf: add fsession support")
Acked-by: Puranjay Mohan <puranjay@kernel.org>
Tested-by: Puranjay Mohan <puranjay@kernel.org>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 arch/x86/net/bpf_jit_comp.c                   |  5 +++
 include/linux/filter.h                        |  1 +
 kernel/bpf/core.c                             |  5 +++
 kernel/bpf/verifier.c                         |  5 +++
 .../selftests/bpf/prog_tests/fsession_test.c  | 32 ++++++++++++++-----
 5 files changed, 40 insertions(+), 8 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 5a075e06cf45..070ba80e39d7 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -4112,3 +4112,8 @@ bool bpf_jit_supports_timed_may_goto(void)
 {
 	return true;
 }
+
+bool bpf_jit_supports_fsession(void)
+{
+	return true;
+}
diff --git a/include/linux/filter.h b/include/linux/filter.h
index fd54fed8f95f..4e1cb4f91f49 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1167,6 +1167,7 @@ bool bpf_jit_supports_arena(void);
 bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena);
 bool bpf_jit_supports_private_stack(void);
 bool bpf_jit_supports_timed_may_goto(void);
+bool bpf_jit_supports_fsession(void);
 u64 bpf_arch_uaddress_limit(void);
 void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp), void *cookie);
 u64 arch_bpf_timed_may_goto(void);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index e0b8a8a5aaa9..3b1eb632bf7c 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3142,6 +3142,11 @@ bool __weak bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena)
 	return false;
 }
 
+bool __weak bpf_jit_supports_fsession(void)
+{
+	return false;
+}
+
 u64 __weak bpf_arch_uaddress_limit(void)
 {
 #if defined(CONFIG_64BIT) && defined(CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e7ff8394e0da..3f6ac0095ca6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -24874,6 +24874,11 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
 	case BPF_TRACE_FSESSION:
+		if (prog->expected_attach_type == BPF_TRACE_FSESSION &&
+		    !bpf_jit_supports_fsession()) {
+			bpf_log(log, "JIT does not support fsession\n");
+			return -EOPNOTSUPP;
+		}
 		if (!btf_type_is_func(t)) {
 			bpf_log(log, "attach_btf_id %u is not a function\n",
 				btf_id);
diff --git a/tools/testing/selftests/bpf/prog_tests/fsession_test.c b/tools/testing/selftests/bpf/prog_tests/fsession_test.c
index 0c4b428e1cee..a299aeb8cc2e 100644
--- a/tools/testing/selftests/bpf/prog_tests/fsession_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/fsession_test.c
@@ -29,8 +29,16 @@ static void test_fsession_basic(void)
 	struct fsession_test *skel = NULL;
 	int err;
 
-	skel = fsession_test__open_and_load();
-	if (!ASSERT_OK_PTR(skel, "fsession_test__open_and_load"))
+	skel = fsession_test__open();
+	if (!ASSERT_OK_PTR(skel, "fsession_test__open"))
+		return;
+
+	err = fsession_test__load(skel);
+	if (err == -EOPNOTSUPP) {
+		test__skip();
+		goto cleanup;
+	}
+	if (!ASSERT_OK(err, "fsession_test__load"))
 		goto cleanup;
 
 	err = fsession_test__attach(skel);
@@ -47,8 +55,16 @@ static void test_fsession_reattach(void)
 	struct fsession_test *skel = NULL;
 	int err;
 
-	skel = fsession_test__open_and_load();
-	if (!ASSERT_OK_PTR(skel, "fsession_test__open_and_load"))
+	skel = fsession_test__open();
+	if (!ASSERT_OK_PTR(skel, "fsession_test__open"))
+		return;
+
+	err = fsession_test__load(skel);
+	if (err == -EOPNOTSUPP) {
+		test__skip();
+		goto cleanup;
+	}
+	if (!ASSERT_OK(err, "fsession_test__load"))
 		goto cleanup;
 
 	/* first attach */
@@ -94,6 +110,10 @@ static void test_fsession_cookie(void)
 	bpf_program__set_autoload(skel->progs.test6, false);
 
 	err = fsession_test__load(skel);
+	if (err == -EOPNOTSUPP) {
+		test__skip();
+		goto cleanup;
+	}
 	if (!ASSERT_OK(err, "fsession_test__load"))
 		goto cleanup;
 
@@ -111,10 +131,6 @@ static void test_fsession_cookie(void)
 
 void test_fsession_test(void)
 {
-#if !defined(__x86_64__)
-	test__skip();
-	return;
-#endif
 	if (test__start_subtest("fsession_test"))
 		test_fsession_basic();
 	if (test__start_subtest("fsession_reattach"))
-- 
2.52.0

