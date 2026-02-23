Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A78376BF8
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 19:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771873904; cv=none; b=gaERgquRxplcnE1J0zlTd2uqfgyZAtmXz+00mI0/qml17ng/rwRdixPZeL41PDUQIS9QGPz3e1PDbXRApqaS3UqZ/+tnGsUm81DT/qdbZxjKtpibcpf2TYlKwsOeS1xoWHX0JO09tssptByohA0oydZX2Bh5TlzM+TnWi2Db2Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771873904; c=relaxed/simple;
	bh=hc/E7kagcHNUw8RSngTBUY+g9wwjMUBbC6BQ3A5MxSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hjgTBtHxe6gvjRIfeKjqgV9j0nz+WxXfLh9M2y099IiSrr4nsqTX3MzoOW9D+p6ncPzn3yUzl8A1ywhCIT6SUHx/LCu71z/L71iRnlnbrZ0XDpGQEe/veF7rdj+0IVKzezMfrBsIq0Bfl7x0olaT9I1a6Ph/y3YHCzODTAWcWHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=B04OIfak; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B04OIfak"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771873900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L5oYDJzQrEcliwwUyjc1S8sIbaaCTZLdOuGhm0bSThw=;
	b=B04OIfak6eNnu8PFXzHnseq2QLOrd9lZdGvDjkDGKMwK2rVJPufXD65zgl67+h8voAJ55S
	QKycLv11FtW3+/rT6ghT1BylaqKKUrbMZMuKLZ2BWNz3eOSaEtxNlnBUGry9dUsCUhl1bG
	1Hhe0xfNr89gmy6wzru1/GMJPUW+ePY=
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
Subject: [PATCH bpf v4 20/20] selftests/bpf: Don't override SIGSEGV handler with ASAN
Date: Mon, 23 Feb 2026 11:11:18 -0800
Message-ID: <20260223191118.655185-3-ihor.solodrai@linux.dev>
In-Reply-To: <20260223191118.655185-1-ihor.solodrai@linux.dev>
References: <20260223190736.649171-1-ihor.solodrai@linux.dev>
 <20260223191118.655185-1-ihor.solodrai@linux.dev>
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
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
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

