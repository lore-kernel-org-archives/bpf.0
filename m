Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905EC1F4634
	for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 01:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770858889; cv=none; b=n5T0cY3WAR73coqkKnQCX4ud7Y2fWe9pAzDx1QKbZgKtvEQ+3kput1J+FHnp5KwUiwbJRDIcseg1VE74GTWzPmmBgNawOL8t757c6IdgC0UO/sd0ePNOHP8bjqKXxdY0qCVTw270MoUUxomRrplh5np3NsRhLrjLVDtl7jlmX7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770858889; c=relaxed/simple;
	bh=yM1ccGWJitx0+WTiHAo7F0fQXHUFWHzBwuaDPI2/4Uc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N/LzNY/2zmnKMd59LqThFY9qs/YYFNWMayiwWHIg21VK1BS4zdnAGmymz89KEBueUHRDRHk85RP54u7Vv+0I4M49YN1SBod+6Vz0sR1kNh34n6JgHY9nRt9AA3mtbp+KOzdz3p/ZyWLB3h5gWn7s/TkKSSP82tFBxqAGZ9lXOFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vaGWQ4DE; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vaGWQ4DE"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770858886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DjCyTymnNRA4SVevlIpD5/RjOO+nGAgUAHsQw7CcXlU=;
	b=vaGWQ4DExg+LUePrT8qQxbh97itOtPlQIEK/mZ7vexfo+q7x/Zz454twvGLr/+jFKzGdx7
	j7RnHemQr0mWxCuApGG5f5bqqxTT4ie9jiNMi7U6J19k/Jo8q1EE/KOVoH2sW+CtXB8CYq
	Rdarec4AucK9xqXi7Rgo/LQDgFoZWrw=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 12/14] selftests/bpf: Fix array bounds warning in jit_disasm_helpers
Date: Wed, 11 Feb 2026 17:13:54 -0800
Message-ID: <20260212011356.3266753-13-ihor.solodrai@linux.dev>
In-Reply-To: <20260212011356.3266753-1-ihor.solodrai@linux.dev>
References: <20260212011356.3266753-1-ihor.solodrai@linux.dev>
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

