Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DFA2EA151
	for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 03:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781754004; cv=none; b=H29wUKccPbuLA3+CxPsKe3RctIRtTW4ejDvGgcMpqas5klmWZPRkqSt3rlKvfYswh/5m1u5LuuZfV3hKkXilm5QcFYHnXbfAXB8lDOKujQ5tOQ2TJsrG7y9jqCqcLj/pTHF/ljonVdPmKd6Ai5kr2uPw20km+IyTXj8cC9B6sZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781754004; c=relaxed/simple;
	bh=u0BHccFFok4W4K1qDbFRTw5PIdV34AfWS/g7edMPN4g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PcjRBacnM/8p8Z5ceYqVewaGTxrSX2DEh9fTWwAWewml6uFDvXwzqRopNCJpmLBwZ8GDZRSZiamMKdQJkl5T9FaRY7xcrx76/7J4JGYXLSUWnYCQylPMpvSCs505YPJNPjg5UXiSvhAoANk7i5J1IXG9q1pBY3uwk9cTHLI18gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PzqAvyVv; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PzqAvyVv"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781753991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2ZJcV8qkE/533ZNLQ7MwZZ6HE6w38xEeqB7Q6PXDQMU=;
	b=PzqAvyVvflt9XZhitNyiEXKOGl/qgok3prFKz/mNMEDJpjos0CERegjwwmzjOTBnKhY0gl
	UpulZi6nCtN5exM+d2ypB13WEZbUxrBewY8PHSrtkMb44TIkoa3YbvsiOg5JMOUgZmJR/3
	Tmn2jlbhhAofTCXei4G6rZNFaUIWoEw=
From: George Guo <dongtai.guo@linux.dev>
To: chenhuacai@kernel.org,
	yangtiezhu@loongson.cn,
	hengqi.chen@gmail.com
Cc: kernel@xen0n.name,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	shuah@kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	George Guo <guodongtai@kylinos.cn>
Subject: [PATCH 5/5] selftests/bpf: Enable struct_ops private stack test for LoongArch
Date: Thu, 18 Jun 2026 11:38:09 +0800
Message-Id: <20260618033809.98253-6-dongtai.guo@linux.dev>
In-Reply-To: <20260618033809.98253-1-dongtai.guo@linux.dev>
References: <20260618033809.98253-1-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: George Guo <guodongtai@kylinos.cn>

LoongArch now supports BPF private stacks via
bpf_jit_supports_private_stack(), so let the struct_ops private stack
runtime test (private_stack / private_stack_fail / private_stack_recur)
run there instead of being skipped.

Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/struct_ops_private_stack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/struct_ops_private_stack.c b/tools/testing/selftests/bpf/prog_tests/struct_ops_private_stack.c
index 98db9bafa44b..fcc86f1dfd15 100644
--- a/tools/testing/selftests/bpf/prog_tests/struct_ops_private_stack.c
+++ b/tools/testing/selftests/bpf/prog_tests/struct_ops_private_stack.c
@@ -5,7 +5,7 @@
 #include "struct_ops_private_stack_fail.skel.h"
 #include "struct_ops_private_stack_recur.skel.h"
 
-#if defined(__x86_64__) || defined(__aarch64__) || defined(__powerpc64__)
+#if defined(__x86_64__) || defined(__aarch64__) || defined(__powerpc64__) || defined(__loongarch__)
 static void test_private_stack(void)
 {
 	struct struct_ops_private_stack *skel;
-- 
2.25.1

