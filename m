Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2013837F011
	for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 14:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785162606; cv=none; b=iUWpNm8GmypR0awP2MtMudXH22nRSybPRBq1EgcUYXuRrH0zaFf2hWwfspwkjZsb/OXXGryf0of9fPSGtnYCv/XAfE0jq3xl00ftuQjCepnp51TbY5GjuYlKorEK+sIBsj4C23Lfg0+iGEyA7+CZb9j4BVccDMh9eVqDnqyPHK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785162606; c=relaxed/simple;
	bh=vJRnn3b8SXIVIIEB5qCqSFb0fZdA2tscoj7YqldYjlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E/7HnzyQYQxdHhPUYjsNTF64MAEB3K756USaCJswFQkN/M4aWjA5JbXEWdUAonUmK2SMJYo/O94AITgcSfjuk5Rg9008IZ7/YgI4JPMF3EG+yyEl+EPQvlmnMDI7XnHZSZzSFg8r7szcU5NNGwxyBj3g2oBKVYg9WvjAAOZ9cow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dTaBFvVG; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dTaBFvVG"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785162599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ekHwziOYa71/KxCLz9kxR3k6w8ssyZhYpJA+Kg/5PDU=;
	b=dTaBFvVGQzpRGOhAX1UlQkR4jYGmf72gDgG0gnQz5cFhTan5QM7OtC1MhQ1ULf6Hx14P7R
	p7NFM72XmVDw7eQyfVJXgUr1Kjtwx5ek2oJZrEpM8dZHBbChvOpWEJc7OZaiKdWxDimhIM
	VpbwVDEXWnEX/Ft5/++x/o0aftouYho=
From: Leon Hwang <leon.hwang@linux.dev>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 2/2] selftests/bpf: Enable tracing_multi tests on arm64
Date: Mon, 27 Jul 2026 22:28:44 +0800
Message-ID: <20260727142844.21212-3-leon.hwang@linux.dev>
In-Reply-To: <20260727142844.21212-1-leon.hwang@linux.dev>
References: <20260727142844.21212-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

arm64 now supports dynamic ftrace direct calls backed by a single
ftrace_ops, which enables BPF tracing multi links.

Define ARCH_SUPPORTS_TRACING_MULTI_LINK for x86-64 and arm64, and use the
shared capability to gate the tracing_multi functional, rollback,
and attach benchmark tests.

This allows the tests to run on arm64 while continuing to skip
architectures without tracing multi link support. It also prevents the
rollback test from treating an unsupported-link error as its expected
attachment failure.

Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 tools/testing/selftests/bpf/prog_tests/tracing_multi.c | 9 +++++++--
 tools/testing/selftests/bpf/test_progs.h               | 6 ++++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
index f02ffc7f41d7..5aa48e090340 100644
--- a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
@@ -612,7 +612,7 @@ void serial_test_tracing_multi_bench_attach(void)
 	struct btf *btf;
 	int err;
 
-#ifndef __x86_64__
+#if !ARCH_SUPPORTS_TRACING_MULTI_LINK
 	test__skip();
 	return;
 #endif
@@ -923,6 +923,11 @@ static void test_rollback_unlink(void)
 
 void serial_test_tracing_multi_attach_rollback(void)
 {
+#if !ARCH_SUPPORTS_TRACING_MULTI_LINK
+	test__skip();
+	return;
+#endif
+
 	if (test__start_subtest("put"))
 		test_rollback_put();
 	if (test__start_subtest("unlink"))
@@ -931,7 +936,7 @@ void serial_test_tracing_multi_attach_rollback(void)
 
 void test_tracing_multi_test(void)
 {
-#ifndef __x86_64__
+#if !ARCH_SUPPORTS_TRACING_MULTI_LINK
 	test__skip();
 	return;
 #endif
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index 2cf950afcd85..b1498e84773c 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -567,4 +567,10 @@ void validate_msgs(const char *log_buf, struct expected_msgs *msgs,
 void free_msgs(struct expected_msgs *msgs);
 void verify_test_stderr(struct bpf_object *obj, struct bpf_program *prog);
 
+#if defined(__x86_64__) || defined(__aarch64__)
+#define ARCH_SUPPORTS_TRACING_MULTI_LINK 1
+#else
+#define ARCH_SUPPORTS_TRACING_MULTI_LINK 0
+#endif
+
 #endif /* __TEST_PROGS_H */
-- 
2.55.0

