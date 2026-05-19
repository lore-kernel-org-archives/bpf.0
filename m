Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B3B32B116
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 16:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779208613; cv=none; b=jn+l4gaiFdJd4RE1CR9lOdznIyV7wL8Ah1NHU6JNZ9OP0JiZv7H8mckq4C8+Kt9mq0gx7gzDi5GQUdft6rvuy4KxLdsdjg6eJEWUX5g4bgz9xchOSW2t8MJvkQ7ttIf09PUXLelVhYwBv4KAs/y7Y29reOiWqCum1X7wl3YD+1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779208613; c=relaxed/simple;
	bh=+HSijAYYTRN03TZVbuMjRFQdZTWxSPmSt4JdLb9afK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bCARL3PK/UKhwO4xbqFPPkot7l4iCaLQIe7z82pbHOAemaBtLmPeiisGi3j8c2KQQkXy2FowE2whnAjwA8/+pYNSwgjxY8bqjszbz/iOryppk0DraMxIlBR4C3bTXV6xTtmDcG4SVoZQ/dvqkysJr6wJCajMJ6kdgAcsKjwVFe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=InvnPWNH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="InvnPWNH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B5F9C2BCB3;
	Tue, 19 May 2026 16:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779208613;
	bh=+HSijAYYTRN03TZVbuMjRFQdZTWxSPmSt4JdLb9afK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=InvnPWNHt+PSPEssPOQ7q8MfO7lP5tDdFJJkA3mhjBJXhoy3F04A4sRKfgwuOJQCQ
	 TDHHaT+Z5oyR8BaZUtaEnqM2DtgiKTl3Xj6G6pdaqnh7S1jjjrutfxQfBj5VU16B9r
	 bk974X+5XnkJ2jidQ3u5xWJK7blvvku/loFNXcUsxrefsKYTyEtsfK3u7nUcHJgbMo
	 j6CVoExjfcFO+elrGp4Bx+QBi0nEmxlnCdfTOClQ5RxzBuF8qrC/Rschp9cSxVr7j2
	 dT3ToDd4HXZpcbnTqG88qNU7Q90UQQFLvKZWYHS6260CZX2QnvfILcFSzmKtDrgJEj
	 hfMwSSoBlck3A==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
	Fei Chen <feichen@meta.com>,
	Taruna Agrawal <taragrawal@meta.com>,
	Nikhil Dixit Limaye <ndixit@meta.com>,
	"Nikita V. Shirokov" <tehnerd@tehnerd.com>,
	kernel-team@meta.com
Subject: [PATCH bpf-next 3/4] selftests/bpf: Cap batch-timing calibration at BPF may_goto loop limit
Date: Tue, 19 May 2026 09:36:31 -0700
Message-ID: <20260519163632.2220753-4-puranjay@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260519163632.2220753-1-puranjay@kernel.org>
References: <20260519163632.2220753-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BENCH_BPF_LOOP uses the may_goto instruction (via can_loop) to bound
its iteration loop.  The kernel enforces a maximum of BPF_MAX_LOOPS
(8,388,608) iterations per may_goto instruction.

CALIBRATE_MAX_BATCH was set to 10,000,000, exceeding this limit.  If
calibration computed a batch_iters above 8M, the BPF loop would exit
early when can_loop becomes false.  The timing sample would cover fewer
iterations than batch_iters, causing the per-op calculation to
underestimate the true cost.  Validation would also fail since map
counters would not reach the expected batch_iters + 1.

No current benchmark triggers this (the fastest, bpf-nop at ~1.8 ns/op,
calibrates to ~5.5M), but future sub-1.25 ns/op benchmarks would.

Lower the cap to 8,000,000 to stay within the may_goto limit.

Fixes: 08158c111d7d ("selftests/bpf: Add BPF batch-timing library")
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 tools/testing/selftests/bpf/benchs/bench_bpf_timing.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/benchs/bench_bpf_timing.c b/tools/testing/selftests/bpf/benchs/bench_bpf_timing.c
index 75a39da69655..081e2e860cb4 100644
--- a/tools/testing/selftests/bpf/benchs/bench_bpf_timing.c
+++ b/tools/testing/selftests/bpf/benchs/bench_bpf_timing.c
@@ -166,7 +166,7 @@ void bpf_bench_timing_report(struct bpf_bench_timing *t, const char *name, const
 
 #define CALIBRATE_SEED_BATCH	100
 #define CALIBRATE_MIN_BATCH	100
-#define CALIBRATE_MAX_BATCH	10000000
+#define CALIBRATE_MAX_BATCH	8000000
 #define CALIBRATE_TARGET_MS	10
 #define CALIBRATE_RUNS		5
 #define PROPORTIONALITY_TOL	0.05	/* 5% */
-- 
2.53.0-Meta

