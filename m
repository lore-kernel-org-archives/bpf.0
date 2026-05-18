Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89ADC2BEFE8
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 14:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779116208; cv=none; b=ftXNlQI6ax22nH0jQxjtYkbl6KNx6E9UmDNjV2bgH6VUCWg7QJyQ4+cC9Wy48vwpIrx+PVBo4PeV5FLJucPQk1lYTp5Cluf9orG0CtARNG1cVBZ/Ygxof7Di7XaTAt2A+tUS9gqGDrmvNEhmHZ7Z3Zkt8ryb5oBcKXe3EmkghK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779116208; c=relaxed/simple;
	bh=GXs/KXHx/biQ2Ip988P1+V15pfIjsDzmesKmjpqYRzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=un88wSxe9eXCg4P5JaCVfDWEf0Mu+SkenHvSi+DEVI56jK5lSTgzprCkOg88LZgGl/lfwI3hoc20OB9kLSWv4OeaDpMEX8vaoMKll+FMq5pebjboU4iY6SIu2MVk2agL8TypBhU+Rx1gVSiWyApoRl2HUwWcNKvxxomdax247qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BNPyEbeB; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BNPyEbeB"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779116203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bERCOBouP45WRdBJGQNPQaxTPk4LlRukZpEH/2D3fus=;
	b=BNPyEbeByasyGqHsJgOR1yS2SAqKvsLJaPe99p7mK5862kWPA6WcvOJ0YhNg5TPVNmeHDB
	JH4DY3PZNbm21r51zQ5qmVAVM/iF8Q6B51cAs428XiISWDeFWQ5Ge9Ulb9nmFTi3yC4msM
	n8EzgHHGt9IUA6rXO9pLK/XYLiGhjVs=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next 4/5] selftests/bpf: Use -1 as token_fd in map create failure test
Date: Mon, 18 May 2026 22:54:45 +0800
Message-ID: <20260518145446.6794-5-leon.hwang@linux.dev>
In-Reply-To: <20260518145446.6794-1-leon.hwang@linux.dev>
References: <20260518145446.6794-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Because 0xFF can be an open BPF token fd in the test runner that will fail
test_invalid_token_fd(), change token_fd from 0xFF to -1 to avoid such
test failure.

Fixes: f675483cac1d ("selftests/bpf: Add tests to verify map create failure log")
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 tools/testing/selftests/bpf/prog_tests/map_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/map_init.c b/tools/testing/selftests/bpf/prog_tests/map_init.c
index 5c61c8e37306..b0b902d5783d 100644
--- a/tools/testing/selftests/bpf/prog_tests/map_init.c
+++ b/tools/testing/selftests/bpf/prog_tests/map_init.c
@@ -306,7 +306,7 @@ static void test_invalid_token_fd(void)
 	const char *msg = "Invalid map_token_fd.\n";
 	LIBBPF_OPTS(bpf_map_create_opts, opts,
 		    .map_flags = BPF_F_TOKEN_FD,
-		    .token_fd = 0xFF,
+		    .token_fd = -1,
 	);
 
 	test_map_create_array(&opts, msg);
-- 
2.54.0

