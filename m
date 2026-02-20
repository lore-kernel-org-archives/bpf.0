Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720DD30BB89
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 22:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771626397; cv=none; b=HD0XRdNUFCJDE9EjsuHX40WvzX/j/VFDCmJNgY/d30tTqNkTck6e/dWdTJ8W+pZ3BEm7eTaXfRTAlzrKJBbmfqyeBwIOzeE9P0c0VVt23lOusjGmXpm+N1Luxyc2tPB8XrddzfkCR/7RwVikm4iBSNG56/o0HHRfskD4IaelcrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771626397; c=relaxed/simple;
	bh=M+dUUNDfpAIzgLSnvfWveVIwWVTjzjuQu5215zF1QPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dyGC7+7EaLmb8j02SVeck72A1zzwZ46QimVWcXCiSdBqQbZ8L7nux/hSq4jVAX0byqYFIKEFfg2qDB4XSldJYT3a+b664umLlliqrR4auNTXGeXthYwJAbeyw0Zz3KtKu2WXVJLhOl2cYq+0ey98UtVUwkZ+3Z9MRTtMRzzfc0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WdBfniiL; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WdBfniiL"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771626394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Isk3MgJEdESYLCNKsJ/YFa6h9vV90ljBAfMCZ/hOcpY=;
	b=WdBfniiLtbB0LUKXPV+DKOenOmJtofKknbZSCUSiPADdErx81IuGX3nU8O7u40DO3MnvKY
	21CKHeupEizvRjtRrez81oxa5C4EICxTA3nOn0QzfgZe4JvafE/2VwWnpMnlYjtfgd3RkI
	65rjfHyPZZrZDlaKqsopsFF/emygeZw=
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
Subject: [PATCH bpf v3 03/15] selftests/bpf: Add DENYLIST.asan
Date: Fri, 20 Feb 2026 14:25:52 -0800
Message-ID: <20260220222604.1155148-4-ihor.solodrai@linux.dev>
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

Add a denylist file for tests that should be skipped when built with
userspace ASAN:

    $ make ... SAN_CFLAGS="-fsanitize=address -fno-omit-frame-pointer"

Skip the following tests:

- *arena*: userspace ASAN does not understand BPF arena maps and gets
  confused particularly when map_extra is non-zero
  - non-zero map_extra leads to mmap with MAP_FIXED, and ASAN treats
    this as an unknown memory region
- task_local_data: ASAN complains about "incorrect" aligned_alloc()
  usage, but it's intentional in the test
- uprobe_multi_test: very slow with ASAN enabled

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/testing/selftests/bpf/DENYLIST.asan | 3 +++
 1 file changed, 3 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/DENYLIST.asan

diff --git a/tools/testing/selftests/bpf/DENYLIST.asan b/tools/testing/selftests/bpf/DENYLIST.asan
new file mode 100644
index 000000000000..d7fe372a2293
--- /dev/null
+++ b/tools/testing/selftests/bpf/DENYLIST.asan
@@ -0,0 +1,3 @@
+*arena*
+task_local_data
+uprobe_multi_test
-- 
2.53.0

