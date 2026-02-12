Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2552253A0
	for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 01:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770858881; cv=none; b=r2iJe/qzuy4DVpJ7Sdb8F6RqKD+BH4f+YlwHLe1aCoBSeDE3k0RERu0FaduVdDmSOj1pTGB5SQKqxGi7RqGY80eWyHTO2iiO7HIh8auJ11irRsf7ksGMctzjjS0NYhMigwIuDmZ8NRfjTtXPpADbVN44R/2QN71gF1GEjlnMdSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770858881; c=relaxed/simple;
	bh=jA/wOZLGIxGMGiQA63G+DfY+YTj5mgFKAZQ7v2A7GCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WPsrapMRotiG4hvvyauDiOGt7LAKKd59SMZBp5KcETntlP7ZyoAQ1ZI2GIfjOOaUpLNDjFkppGqmF87MWUXMmUTTjvAgo79zCWrBnaJ6Q/FenJujWFxS4pp0mV1sNKqtAAUXt+zFlp9LAiUCkkU5bHFaIVxMhGrwu9YdxbkB4jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ojcLC58s; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ojcLC58s"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770858878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NP0u5wlZZjOVD96p+9s+0wLKqWTwLEZGRkiARzeDYpc=;
	b=ojcLC58sAte5jUz71tvzTg5zXeffxMX2JkX+nP08DNWl0N8q3JiKxknXduKwqnKVcfDUle
	6hT5LLh0iHmG0Nx2QYvBwHdhlpSK7WsjxYpMOb0k1ax4v8uWlNM4wSMIU8xr8Andmstesx
	vOD8ixkH0+aVK1VJpic7lz8wqLZVKvA=
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
Subject: [PATCH bpf-next v1 09/14] selftests/bpf: Fix double thread join in uprobe_multi_test
Date: Wed, 11 Feb 2026 17:13:51 -0800
Message-ID: <20260212011356.3266753-10-ihor.solodrai@linux.dev>
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

ASAN reported a "joining already joined thread" error. The
release_child() may be called multiple times for the same struct
child.

Fix by setting child->thread to 0 after pthread_join.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
index 2ee17ef1dae2..17881e009eee 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
@@ -62,8 +62,10 @@ static void release_child(struct child *child)
 		return;
 	close(child->go[1]);
 	close(child->go[0]);
-	if (child->thread)
+	if (child->thread) {
 		pthread_join(child->thread, NULL);
+		child->thread = 0;
+	}
 	close(child->c2p[0]);
 	close(child->c2p[1]);
 	if (child->pid > 0)
-- 
2.53.0

