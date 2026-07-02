Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0A93009F2
	for <bpf@vger.kernel.org>; Thu,  2 Jul 2026 02:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782959102; cv=none; b=IzntcSnrvXwNm3XHiDhN/0b7sEOtwNFchAc9JkuzUAJsUbl0Mtg78hOlx57BCDEd7CFLuCcImMNdJViUGM286EEjlrp3f806fIfF1bCcw2n6Mx35/YSrwm6AMrL3RvwtBybFApnILLrNKzAf7bPgSXn6wUfgpAkPrmptxaCcPQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782959102; c=relaxed/simple;
	bh=u0BHccFFok4W4K1qDbFRTw5PIdV34AfWS/g7edMPN4g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U39z0vlMJeMpAAJZtjmGY0BiUMOQ+2Snd/sVdpFb4ZyFpwMPYaH/IQ3PkXwHu0nhSYeKkFYc095i96E9xGYrn4XWAKqKOgp5ibqXaxFfDGhVMX1NzH+F7cgHxwevJwmOg0wAgKVz9PQhaOQB7g+5wkzm7aCerbRsLlzKTrPDzhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RMQMagj6; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RMQMagj6"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782959099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2ZJcV8qkE/533ZNLQ7MwZZ6HE6w38xEeqB7Q6PXDQMU=;
	b=RMQMagj6uQVCeYKSVqtlZOZbln/2IKrgmxy6/eIoBQgZTIOAYvLobMdSMe7pfQn1RD5mEv
	7YFrRzXR0CHb9tEgy6LjIOEJljQzV6lyxwXvGOSV5pU3G9WCqW2nSKGTRGf66orWEpns1Y
	YlSaTmkfNOxk6Ek4fI9NhKBl7Ke+4xM=
From: George Guo <dongtai.guo@linux.dev>
To: Huacai Chen <chenhuacai@kernel.org>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Hengqi Chen <hengqi.chen@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	George Guo <guodongtai@kylinos.cn>,
	bpf@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 08/11] selftests/bpf: Enable struct_ops private stack test for LoongArch
Date: Thu,  2 Jul 2026 10:23:19 +0800
Message-Id: <20260702022322.51033-9-dongtai.guo@linux.dev>
In-Reply-To: <20260702022322.51033-1-dongtai.guo@linux.dev>
References: <20260702022322.51033-1-dongtai.guo@linux.dev>
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

