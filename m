Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FB7312836
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 19:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771873693; cv=none; b=V2ADSma/6w+vV+1tFzcUil+ZcMAWIB9HRXhkDspysX5w6AWZzCHoxV+BC1LzJyUK33hTWl/fvWoAvpz2epHtxzSBfTWBBVSV/LK6/mNkiawbJUNWT1aYu57uNSxNLZgC1Rp6O2E4T8qOeRjk8K3DKGU5r+CR0oaVsBP+z7w5Ejc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771873693; c=relaxed/simple;
	bh=f/Bx+ZsJ1fAcffz9ruvdWWPF/FpD+naaO17ejS4QjGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j0VNoEJ/aUwzuLeseJrVLFvDvxzhhllkPKr6Mx1HNuMz9UrejYSVfqrHTc5mhHSQBAfDMWvePiyiYo4U1eM4YHNBNQjFRaX4iSsSv4PQtbTESv39uv3yZ/kdAM0AW3QMFIEuvlmycu6oKzBpBH2bXIwwMTEcXGfl1JK1USwXMLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=erT0RY1L; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="erT0RY1L"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771873690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BXpYJcNqc32baJ6rjSBeAUDkFNtFLG2PdKUrKRzmF18=;
	b=erT0RY1LUBryn8aaSuVe2RiVqcdaRnov7agbWH3T7olHN51i8ly9TRBUzNL0XBblt86+Cx
	01uJyM74Ld1HCF+ekxiwudH06AAYrJbRqG+5E4kTR/XWSkSIPDXSfAzlj+BWcirRmnEIXK
	YKIb+wZz74VQ5jBZW54gEquk2UXafBc=
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
Subject: [PATCH bpf v4 05/20] selftests/bpf: Use memcpy() for bounded non-NULL-terminated copies
Date: Mon, 23 Feb 2026 11:07:21 -0800
Message-ID: <20260223190736.649171-6-ihor.solodrai@linux.dev>
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

