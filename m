Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E88E3128CF
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 22:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771626426; cv=none; b=qoNgvspWqS/DWioTodsTZPNtMe2ddJUY3Vwe1ZGws1vqiqpXxnqlElJM2xJ4QpUfVB+NHV5/HX4Mt2gIM2CL11BjtAumwyovDOx4YLaArZ+McVzpBs6SBlcG/9AOmv6RglX6x8fUQD9xV6l4IhjLSCWXo9t24Kwu2cuJdHELEYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771626426; c=relaxed/simple;
	bh=nkZ7EIP6LGyWvfc3u9kgQem5wfwCiKQ9vXWuzdwQiws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bLFU+QLK9qihNYAH8eT56lK15xbx/mkUGkowE/akunaK78xkG8U9jBH+Re1ZuPKjf4JDmcivslNZVCRSWe2HAFNrmiT6+JrtMEYo/NCW83ztrTgMjLyKe70wRj6NyfklG4w7mpIeqGxyH7ZgW9OR0kmNt4aigpyHytg/3kitZgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Zy8r8Fr/; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Zy8r8Fr/"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771626422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TNjpWtD8/OLKVZY+IfnvHA3Q+we+RTPqutZ3CXBQMnM=;
	b=Zy8r8Fr/OheLcEexl8oMSib2Ps19aLxcXXYvonER6PcIjQM5pnngzGqiLqYGWxR/f7ocZU
	pmRPfymoPR5+/JQTwa+bwTgT7pW4y7v1MZU79s2lR0qQmzRZc+cFSLoG7k5dldu1UeSCQO
	sraSP58KreE9Fs7hb7haX9mYW67AI/w=
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
Subject: [PATCH bpf v3 12/15] selftests/bpf: Fix array bounds warning in jit_disasm_helpers
Date: Fri, 20 Feb 2026 14:26:01 -0800
Message-ID: <20260220222604.1155148-13-ihor.solodrai@linux.dev>
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

