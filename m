Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF92331EAC
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 06:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784702861; cv=none; b=XyKpMUA7jgeY4fa5W6jnpHytciOqbjI9H/4uDQSCJ9qJ7YcUgANRkoPK6V/KffyFkSKUQAfRz6SalNtHv9QtgyNG7nAW47+xbq6eN8rqACltS//HxlwSZb9Lk3zd9u3Ai9ncKyApRUdsCODmuBf+HoyK6qiDDzYcRW83SSQ/ncw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784702861; c=relaxed/simple;
	bh=/dRMXP0upGD7w44LSPtuCCTI2O+bBE8aJISJGZS1O9s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fu5XwiPIyAajXGUA6v7Bk+GzZpnab2m0IYq6/WSlgAKLQHXljTA6UXusexPfwmzjP5PtHK0z90Qb/JL/piH1L/iREh/skHT30iBH04p1HNMwvq68cRATzRQDXkCiiSI3Lb/1k7yD4WkhKq49nC0RgUTDxgvwTCJ92G/AgoiRdtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IDaOTHW0; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IDaOTHW0"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784702847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BePe57sg2EqYqsu/NEwBrrx6po6RaUBzzafl3RwKjH8=;
	b=IDaOTHW0ScpOrMIEzZbl4AqnKBY7DlfwwBOs4qvK0kS++1jSe5i4bFZBr5QfiezVBy6QHp
	WSFu6jLicxuP5+Uy+4YQzUb33c43ziXFIFQ3kN7XmMtHHfi7ebZZpncSFSp0ZG1WStsNbk
	SW+Vc/uSaGn1qMnhSx+6t2q2blcnUgI=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] selftests/bpf: Report the real error from libarena parallel workers
Date: Wed, 22 Jul 2026 14:47:03 +0800
Message-ID: <20260722064713.357277-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Several CI runs failed in the libarena parallel tests with -4 (-EINTR) [1],
which says nothing about what actually went wrong.

Two workers can fail like this:

  worker 1: gives up, e.g. the rendezvous times out, sets test_abort and
            returns its own error (-ETIMEDOUT)
  worker 2: sees test_abort and returns -EINTR

-EINTR only means "someone else already gave up", so it carries no
information. Which of the two gets reported depends on the order
pthread_join() collects them, because

	err = err ?: (long)thread_ret;

keeps the first non-zero value and drops the rest. When the -EINTR worker
comes first, the error describing the actual failure is lost.

Let any other error win over -EINTR, and log each worker that returned an
error.

It is still unclear whether the timeouts come from CI load or from a
problem in the test itself. Report the error accurately first, so the next
failure can be diagnosed.

[1]:
https://github.com/kernel-patches/bpf/actions/runs/29867905253/job/88764463566
https://github.com/kernel-patches/bpf/actions/runs/29878191901/job/88794845824

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 .../testing/selftests/bpf/prog_tests/libarena.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/libarena.c b/tools/testing/selftests/bpf/prog_tests/libarena.c
index df7e4b8dc394..65743920ff69 100644
--- a/tools/testing/selftests/bpf/prog_tests/libarena.c
+++ b/tools/testing/selftests/bpf/prog_tests/libarena.c
@@ -112,13 +112,28 @@ static int run_libarena_parallel_test_workers(struct libarena *skel,
 
 
 	for (i = 0; i < nthreads; i++) {
+		int worker_err;
+
 		ret = pthread_join(threads[i], &thread_ret);
 		if (!ASSERT_OK(ret, "pthread_join")) {
 			err = err ?: ret;
 			continue;
 		}
 
-		err = err ?: (long)thread_ret;
+		worker_err = (long)thread_ret;
+		if (!worker_err)
+			continue;
+
+		/*
+		 * A worker that bails out because another one already gave up
+		 * reports -EINTR. That is collateral damage, so let any other
+		 * error win: it tells us what actually went wrong.
+		 */
+		if (!err || err == -EINTR)
+			err = worker_err;
+
+		fprintf(stdout, "%.*s__%d returned %d\n", (int)prefixlen, name,
+			i, worker_err);
 	}
 
 	free(threads);
-- 
2.43.0

