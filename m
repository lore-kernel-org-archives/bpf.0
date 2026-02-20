Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262CA318BB9
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 22:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771626435; cv=none; b=mP+XRa4loB2WLxIk2R3UKDxZzNEc9U+r3xXxeI/b5o/slb6fMsB6TeaInTBMC6CesHwHsgf9loXFSpZNFfAGLwirJZsIVVFEo9FEjpFny1X0TSqkdbU0XhHSGs6a9kHFClCKRTRwU5i+sEs4+KUdocWIIPsfjvahtae4iH2ZSgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771626435; c=relaxed/simple;
	bh=F507KJnt0cfsRWcBt07lX4d3T/PJBj5gpi8nnls1cvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M+uLCV9Z/29gDqzAqv2pKBi2cOJJMZCOwKeptmYgKOvhZfxoK6ow8QSoB/Zy2Zqa70EmxE7gxV48WmhRK8kMEtfcArRU/VggNhHJSiaDK16B7FtLeXPcfsXeppzxfZ2ntkZQEtyoUlV0iDIX1Ffl33XN01I0faluQCGQhFQY9LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Zugf9RfV; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Zugf9RfV"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771626432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7T2c884JxDOHk+hOTC7Yy3V6Bc8Njk3/JiOom3LZFy0=;
	b=Zugf9RfV2GjASVI4Olv+2nCnObj565hKibhoF/WKlPDWVZJ8m8gA7jhGCWdjSWrh7VqvX6
	YtSc21s5u/jDWmrPj+PKJGygeXeVQMc0NXldin/GEgJ+pDwj8n0a37in4r+2s6vwhIPYWe
	sbczvOVNawoZOg0f5ZUtRlz1Zh19coM=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Jiri Olsa <olsajiri@gmail.com>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: Amery Hung <ameryhung@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf v3 15/15] selftests/bpf: Don't override SIGSEGV handler with ASAN
Date: Fri, 20 Feb 2026 14:26:04 -0800
Message-ID: <20260220222604.1155148-16-ihor.solodrai@linux.dev>
In-Reply-To: <20260220222604.1155148-1-ihor.solodrai@linux.dev>
References: <20260220222604.1155148-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

test_progs has custom SIGSEGV handler, which interferes with the
address sanitizer [1]. Add an #ifndef to avoid this.

Additionally, declare an __asan_on_error() to dump the test logs in
the same way it happens in the custom SIGSEGV handler.

[1] https://lore.kernel.org/bpf/73d832948b01dbc0ebc60d85574bdf8537f3a810.camel@gmail.com/

Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/testing/selftests/bpf/test_progs.c | 36 +++++++++++++++++-------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index d1418ec1f351..0929f4a7bda4 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -1261,14 +1261,8 @@ int get_bpf_max_tramp_links(void)
 	return ret;
 }
 
-#define MAX_BACKTRACE_SZ 128
-void crash_handler(int signum)
+static void dump_crash_log(void)
 {
-	void *bt[MAX_BACKTRACE_SZ];
-	size_t sz;
-
-	sz = backtrace(bt, ARRAY_SIZE(bt));
-
 	fflush(stdout);
 	stdout = env.stdout_saved;
 	stderr = env.stderr_saved;
@@ -1277,12 +1271,32 @@ void crash_handler(int signum)
 		env.test_state->error_cnt++;
 		dump_test_log(env.test, env.test_state, true, false, NULL);
 	}
+}
+
+#define MAX_BACKTRACE_SZ 128
+
+void crash_handler(int signum)
+{
+	void *bt[MAX_BACKTRACE_SZ];
+	size_t sz;
+
+	sz = backtrace(bt, ARRAY_SIZE(bt));
+
+	dump_crash_log();
+
 	if (env.worker_id != -1)
 		fprintf(stderr, "[%d]: ", env.worker_id);
 	fprintf(stderr, "Caught signal #%d!\nStack trace:\n", signum);
 	backtrace_symbols_fd(bt, sz, STDERR_FILENO);
 }
 
+#ifdef __SANITIZE_ADDRESS__
+void __asan_on_error(void)
+{
+	dump_crash_log();
+}
+#endif
+
 void hexdump(const char *prefix, const void *buf, size_t len)
 {
 	for (int i = 0; i < len; i++) {
@@ -1944,13 +1958,15 @@ int main(int argc, char **argv)
 		.parser = parse_arg,
 		.doc = argp_program_doc,
 	};
+	int err, i;
+
+#ifndef __SANITIZE_ADDRESS__
 	struct sigaction sigact = {
 		.sa_handler = crash_handler,
 		.sa_flags = SA_RESETHAND,
-		};
-	int err, i;
-
+	};
 	sigaction(SIGSEGV, &sigact, NULL);
+#endif
 
 	env.stdout_saved = stdout;
 	env.stderr_saved = stderr;
-- 
2.53.0

