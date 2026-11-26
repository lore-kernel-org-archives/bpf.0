Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.88
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795672460;
	b=m/G5InQ5kH5PxJLtGjNsjGt9NlD00XLXtTEAUxcND3Nk2J1SSDhwVALohD/AWL4eIPAP
	 h4AQ90oGZ/onyXF5UTbfg+L2Xhux+bfOPNxj+dfwQGUitn8JyoU+fgHuxfWCy5CpsfyYG
	 xgpllpa1Sy2JsMzgSP7YCzoqJfyX5Gh1i2EDUOmivd0UflHeqW4UqufaXoTEUVnfSYed8
	 OEnfwxrdaMZ+0G3XIptftmzceYRziWxKuEIA7minnm1tvUHyqwD2FuaNjZ5zT0uRjIQ1F
	 9WE5QQO9SXek08SeD770EpcMOY8Vgyv5A488I/SEXmLsRIigsSXWMe7Sw8O8Iql8k5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795672460;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6sqiVTrDEe2NBuw3nlAAoo2cHvqlzBtrt28T5zPPIyU=;
	b=kWf1gw5fDWyPHy61fwjuAXX0YFRLDmdYPej2wW/GnAenC2LcICYCjMkWwQp36OhX/jT2
	 B2fmLYOZC6d43h8pTsQ7uC7PDjtoXVYHgPUziUAaDkZP10foVkq3MwMIpPJKiE/lvoiht
	 5quHKW04YSi4imvDCEsf/7mK+d9GxRtWkBh9Q1vOS/odqqg1OITn3LVUSBFJxyLbdXjne
	 eb8vu7Flb9GjK/17AvNJILCxlR3y5PWUopYIE7zCyNrchk64Zz9Hu1yiu3uao5hJlO+p9
	 RJkRpR+LKv0aih5Qs7YfF3tqRXYSQMd1XWYnLZ6FnBtORIXN/h5tlT58IDF717cWPSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=m9HX0h2S;
	arc=none smtp.remote-ip=95.215.58.88
Received: from mta1.migadu.com (out-88.mta1.migadu.com [95.215.58.88])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6B9606A326
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 05:54:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE6B9606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=m9HX0h2S
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=48jh6X0S0d/3YzMepgD+fBr+qcdyyP0trXSd2pnvpUM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795672457; v=1; x=1796277257;
 b=m9HX0h2SfK2mGszpXzDcz1LbtCXh9UiltXV301pmtOqaBIBZnBFOngjFtQhKvjX/ZkTqCgHM
 LEILn7hXtLwTYtLUjyVOufsYYt9S+oxy2aXBWvX7ZbEnrvCBZqonEd5PXWLOf1S2a4jWy9yq2RR
 bYlolNI74K3bSQkn1rihzx1k=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d7a20327b4be166a;
	Thu, 26 Nov 2026 05:54:17 +0000
X-Mizu-Trace-ID: d7a20327b4be166a
X-Migadu-Flow: FLOW_OUT
From: George Guo <dongtai.guo@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: bpf@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	George Guo <guodongtai@kylinos.cn>
Subject: [PATCH bpf-next v1 3/5] selftests/bpf: Enable struct_ops private stack tests for LoongArch
Date: Thu, 26 Nov 2026 14:53:52 +0900
Message-ID: <20261126055355.9967-4-dongtai.guo@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126055355.9967-1-dongtai.guo@linux.dev>
References: <20261126055355.9967-1-dongtai.guo@linux.dev>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: George Guo <guodongtai@kylinos.cn>

As the LoongArch JIT supports private stack, enable the struct_ops
private stack tests for LoongArch.

With this patch:
  $ sudo ./test_progs -t struct_ops_private_stack | tail -1
  Summary: 1/4 PASSED, 0 SKIPPED, 0/0 FAILED

Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 .../selftests/bpf/prog_tests/struct_ops_private_stack.c        | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/struct_ops_private_stack.c b/tools/testing/selftests/bpf/prog_tests/struct_ops_private_stack.c
index 103179ff8733..730d5741591c 100644
--- a/tools/testing/selftests/bpf/prog_tests/struct_ops_private_stack.c
+++ b/tools/testing/selftests/bpf/prog_tests/struct_ops_private_stack.c
@@ -7,7 +7,8 @@
 #include "struct_ops_private_stack_large.skel.h"
 
 #if defined(__x86_64__) || defined(__aarch64__) || defined(__powerpc64__) || \
-	(defined(__riscv) && __riscv_xlen == 64)
+	(defined(__riscv) && __riscv_xlen == 64) || \
+	(defined(__loongarch__) && __loongarch_grlen == 64)
 static void test_private_stack(void)
 {
 	struct struct_ops_private_stack *skel;
-- 
2.53.0

