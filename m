Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949F236AB75
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 19:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771873731; cv=none; b=LmqrZjYWvsVd8T3ucm/5M0gHVlR4jNmTiO2bkc4PTawSJqcmyZu5CVVr5rd2db3/oL+UYYFwWYkv4bD6wg7D2F5dqJGP7DLqSlmqVbgEzj5cJYtix4w7VFOgFOlzwd/zBVKhhRAbKahv0BcjNnWpKs9ElUbQaMCum6P0Pbmds94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771873731; c=relaxed/simple;
	bh=nkZ7EIP6LGyWvfc3u9kgQem5wfwCiKQ9vXWuzdwQiws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XLVUaLcY2OdqkBoaRmXNG27L1Nnwl4JNmCj6WwctJlEsDcQvsLO3TuaqCCSHnR7rTfhz+wzwfUAG0PNqy2iCApV6ZTtambi7NSL7f3PdNwX00gIZKmSHI/2a7Cvfq6zA49FWEHWbXJFbpFa7AgFA1ULR8X9EcUMiJQjUuznm2mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KHNniA1K; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KHNniA1K"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771873727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TNjpWtD8/OLKVZY+IfnvHA3Q+we+RTPqutZ3CXBQMnM=;
	b=KHNniA1KwgUAf/yEaLNrnQYJ/oc+D6eDR/RfEHZ1pcuwuBamNXy0ZPB+qwcjAXfQGRV20F
	A8WbyXKPWMq/RgRiUyCBYz5rZgTENIzNQafQgnPQWh8RkjjavX7A7RBLr4gZGLSlqycvSq
	Vi9RZvIs44ZO2lj7QHsWTqe9VjIUYiY=
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
Subject: [PATCH bpf v4 17/20] selftests/bpf: Fix array bounds warning in jit_disasm_helpers
Date: Mon, 23 Feb 2026 11:07:33 -0800
Message-ID: <20260223190736.649171-18-ihor.solodrai@linux.dev>
In-Reply-To: <20260223190736.649171-1-ihor.solodrai@linux.dev>
References: <20260223190736.649171-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Compiler cannot infer upper bound for labels.cnt and warns about
potential buffer overflow in snprintf. Add an explicit bounds
check (... && i < MAX_LOCAL_LABELS) in the loop condition to fix the
warning.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 .../testing/selftests/bpf/jit_disasm_helpers.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/jit_disasm_helpers.c b/tools/testing/selftests/bpf/jit_disasm_helpers.c
index febd6b12e372..364c557c5115 100644
--- a/tools/testing/selftests/bpf/jit_disasm_helpers.c
+++ b/tools/testing/selftests/bpf/jit_disasm_helpers.c
@@ -122,15 +122,15 @@ static int disasm_one_func(FILE *text_out, uint8_t *image, __u32 len)
 		pc += cnt;
 	}
 	qsort(labels.pcs, labels.cnt, sizeof(*labels.pcs), cmp_u32);
-	for (i = 0; i < labels.cnt; ++i)
-		/* gcc is unable to infer upper bound for labels.cnt and assumes
-		 * it to be U32_MAX. U32_MAX takes 10 decimal digits.
-		 * snprintf below prints into labels.names[*],
-		 * which has space only for two digits and a letter.
-		 * To avoid truncation warning use (i % MAX_LOCAL_LABELS),
-		 * which informs gcc about printed value upper bound.
-		 */
-		snprintf(labels.names[i], sizeof(labels.names[i]), "L%d", i % MAX_LOCAL_LABELS);
+	/* gcc is unable to infer upper bound for labels.cnt and
+	 * assumes it to be U32_MAX. U32_MAX takes 10 decimal digits.
+	 * snprintf below prints into labels.names[*], which has space
+	 * only for two digits and a letter.  To avoid truncation
+	 * warning use (i < MAX_LOCAL_LABELS), which informs gcc about
+	 * printed value upper bound.
+	 */
+	for (i = 0; i < labels.cnt && i < MAX_LOCAL_LABELS; ++i)
+		snprintf(labels.names[i], sizeof(labels.names[i]), "L%d", i);
 
 	/* now print with labels */
 	labels.print_phase = true;
-- 
2.53.0

