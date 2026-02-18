Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3513827C84E
	for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 00:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771374689; cv=none; b=HqNTAKSH5o3eEa/pFSPajmpZVxjpgNum8Jw9XYH532ZYpSY2+nMDuiC3hwlJ2OsYj6DMukebKKEESamH7YxjrzYP+tAiieA2pio3YzHuQ8n7KQxIWTSP12xmIDhegp6JV3j0w/KASEVVVpt/3OiFZnTZaPxytxKOIboMgbwDFu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771374689; c=relaxed/simple;
	bh=ObsMtcRRjv9Zj6rFWk3J31bqxVbLTticfINT6Fj0dx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FUrGICdsoiQuPa4ehhp9pzhEitfwKYG2ZNTBDq2Qm6bEwgDotMsFpx3Cbn3AThqblO0nB7nVhaQt9pyCz8O2lagGfxo22HTIFHSmPe9aV7B3P4TGrUtQdXPWorhaC/LlOw3fD5lXgPOFKL2DviumyLiSlnZFMezovdYM56vCWa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=g7gjABUD; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="g7gjABUD"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771374686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pa0F2SW5cYTzCEHbVS+ffKXWQRWV1EBeihritj2o+XI=;
	b=g7gjABUDFi3MRFDOdM4ZYmqvKXiegxQMKYsgufLPuIwSwMYePiFIomy32NneoGz4Cpp7eo
	amtW+vTP4PW6bFFCeB9oJM0jFdZEoH4z9Nn2AJ2jAJhprcxl89iWN48QgTcNRjNPSF73+B
	BMEQdQycHBlN7Hrc9ooDukdsNbYCDwo=
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
Subject: [PATCH bpf v2 06/15] selftests/bpf: Fix cleanup in check_fd_array_cnt__fd_array_too_big()
Date: Tue, 17 Feb 2026 16:30:32 -0800
Message-ID: <20260218003041.1156774-7-ihor.solodrai@linux.dev>
In-Reply-To: <20260218003041.1156774-1-ihor.solodrai@linux.dev>
References: <20260218003041.1156774-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The Close() macro uses the passed in expression three times, which
leads to repeated execution in case it has side effects. That is,
Close(i--) would decrement i three times.

ASAN caught a stack-buffer-undeflow error at a point where this was
overlooked. Fix it.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/testing/selftests/bpf/prog_tests/fd_array.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/fd_array.c b/tools/testing/selftests/bpf/prog_tests/fd_array.c
index c534b4d5f9da..3078d8264deb 100644
--- a/tools/testing/selftests/bpf/prog_tests/fd_array.c
+++ b/tools/testing/selftests/bpf/prog_tests/fd_array.c
@@ -412,8 +412,8 @@ static void check_fd_array_cnt__fd_array_too_big(void)
 	ASSERT_EQ(prog_fd, -E2BIG, "prog should have been rejected with -E2BIG");
 
 cleanup_fds:
-	while (i > 0)
-		Close(extra_fds[--i]);
+	while (i-- > 0)
+		Close(extra_fds[i]);
 }
 
 void test_fd_array_cnt(void)
-- 
2.53.0

