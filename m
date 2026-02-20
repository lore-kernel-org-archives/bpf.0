Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F56366062
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 18:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771611645; cv=none; b=KLorPZlhQD97DUSzJIOH3bo5JAb7ePHzhHMiDewZz8U+gIXDvSgaQVPuNJsSI9LpsPb9fNt+pLoYI6xNY5KylzF3psVue3Vq/8gSmhWlrA8QG+ldOKsEKqk9abWoZKE4mVz/JP4tbjw9M96rHsUtkFyNEdwTKoW1q0duBi/+3ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771611645; c=relaxed/simple;
	bh=f/Bx+ZsJ1fAcffz9ruvdWWPF/FpD+naaO17ejS4QjGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kOJv4zYHhi+N0i7R+h+Qwq05R0mqVT25T8vwBZdbAybNpQCy5dPBByKsOpUXpho+7YWhMixHMvuJavDGgaxiRpYCIO0ZSpSkLwUCuEZHYg0uZexMdogxNCFy4pmsG1Tg+XO+zug4oPbWArXLQ4ZP12ql+eaWAZlA7FaGNu37Fjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CmbFZrOw; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CmbFZrOw"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771611641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BXpYJcNqc32baJ6rjSBeAUDkFNtFLG2PdKUrKRzmF18=;
	b=CmbFZrOwX2sunt5l/tbvTFF0PDGGP6VX/DP9Tp6beQb612x1lAQjNaFZ8Fz5mRbvoBUbPy
	GTSvFs9KVcKSwwmp25V+jFgH88MKU3ynLNKOjcZ5M6XKnOGjACgDKP7jXFyugHTyHIE8kn
	6QCX9xCUynAxh4eOS2yRLMTQu1AmvWw=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf v1 7/7] selftests/bpf: Use memcpy() for bounded non-NULL-terminated copies
Date: Fri, 20 Feb 2026 10:20:11 -0800
Message-ID: <20260220182011.802116-8-ihor.solodrai@linux.dev>
In-Reply-To: <20260220182011.802116-1-ihor.solodrai@linux.dev>
References: <20260220182011.802116-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace strncpy() with memcpy() in cases where the source is
non-NULL-terminated and the copy length is known.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c | 6 ++++--
 tools/testing/selftests/bpf/test_verifier.c          | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c b/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c
index dd75ccb03770..469e92869523 100644
--- a/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c
+++ b/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c
@@ -308,8 +308,10 @@ static int find_field_offset(struct btf *btf, char *pattern, regmatch_t *matches
 		return -1;
 	}
 
-	strncpy(type_str, type, type_sz);
-	strncpy(field_str, field, field_sz);
+	memcpy(type_str, type, type_sz);
+	type_str[type_sz] = '\0';
+	memcpy(field_str, field, field_sz);
+	field_str[field_sz] = '\0';
 	btf_id = btf__find_by_name(btf, type_str);
 	if (btf_id < 0) {
 		PRINT_FAIL("No BTF info for type %s\n", type_str);
diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index 27db34ecf3f5..a8ae03c57bba 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -1320,7 +1320,7 @@ static bool cmp_str_seq(const char *log, const char *exp)
 			printf("FAIL\nTestcase bug\n");
 			return false;
 		}
-		strncpy(needle, exp, len);
+		memcpy(needle, exp, len);
 		needle[len] = 0;
 		q = strstr(log, needle);
 		if (!q) {
-- 
2.53.0

