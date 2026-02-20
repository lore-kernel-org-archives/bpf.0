Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EFF366556
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 18:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771611641; cv=none; b=o1anRAk7cYNZwzSxAQkK3GlWmtzZpUVmeujxxVNP308zMoy8TowRDW4oEabc1JiUGlZ9SEpSXoZbsWwfmiuRzR2m67PnplYJlm5GfrGeM9RQs/jwGK/HfpUFqYE2LGnYvaTtR7NZHAlYHHcqVgE0ZENFJKij9qMspNp7iVxoLmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771611641; c=relaxed/simple;
	bh=B70Dg1KnWId+84nKzdvSCzbx9v8OOTz5PhxPUSIWwmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IW0eGF/wPhcUqdq4d4qmbhQaxaDTRJH/oEXCndrV5EEahSKZNce7xEFGFsnx+6I7YIwsUWJlagvWtkItUx+UP+ZE4+/8b3kh9FkkiaX3y5K0PQ2h9cufSiF/iZ3OWqydnzarCWTqkRkXAIOJPpNQZUudf/qFATmwpkC8+hD5a2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G8VI7y3h; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G8VI7y3h"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771611636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RaXcc3pAAHmc8PSgdViMdDRL6D0Fzy3EW/WYrcZC0ac=;
	b=G8VI7y3hAwkBLiZZYr4HkjydRWseGSN9qmA3N/uBhIeWhpK0y6C0dpebiZCZMIKu7Z0Tm/
	aTcVSMVIXMYNaKN2JJ/6N+dnCCbqOmbWLJwbX3xwwWQyF4LIGtGzKZQZ5cvTmmw6xFDdLC
	1XX/YcSiuLmlSSDr64oWzEyzThC4X+Q=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf v1 5/7] selftests/bpf: Use strscpy_cat() in the test_loader
Date: Fri, 20 Feb 2026 10:20:09 -0800
Message-ID: <20260220182011.802116-6-ihor.solodrai@linux.dev>
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

Replace a pair of strcpy() calls that construct the unpriv test name
with a single strscpy_cat() call. This simplifies the code and adds
bounds checking.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/testing/selftests/bpf/test_loader.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index 338c035c3688..af4319566fea 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -673,18 +673,18 @@ static int parse_test_spec(struct test_loader *tester,
 
 	if (spec->mode_mask & UNPRIV) {
 		int descr_len = strlen(description);
-		const char *suffix = " @unpriv";
+		static const char suffix[] = " @unpriv";
+		int name_len = descr_len + sizeof(suffix) + 1;
 		char *name;
 
-		name = malloc(descr_len + strlen(suffix) + 1);
+		name = malloc(name_len);
 		if (!name) {
 			PRINT_FAIL("failed to allocate memory for unpriv.name\n");
 			err = -ENOMEM;
 			goto cleanup;
 		}
 
-		strcpy(name, description);
-		strcpy(&name[descr_len], suffix);
+		strscpy_cat(name, name_len, description, suffix);
 		spec->unpriv.name = name;
 	}
 
-- 
2.53.0

