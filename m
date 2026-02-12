Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA4E223DC6
	for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 01:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770858878; cv=none; b=EYuYOnx9LqgEL9e7dir6rg6UtODE5MCCD8M88QqjbD80flfdmBLLk5cDYdZs7OQxFgR5kVN6PLVF49nmsYWOZGVER2mb8FLLLJ1cwY1nKJqW0+HtlLae2aUl//J0lLaW7p7xL/Olxy9dZ9szPPwDzhQC6WIG2C+rYwJIloN6P/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770858878; c=relaxed/simple;
	bh=g7k6s+Jhg2seZSYi0ABnHIK0XOugLdtOMln5ROgXUQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qfozf5R4HSoSHaZKb+W/GNpXe4fK/NwW8ci/dPsamiLdHGkhAhL5TFW1i2eFWhGPQKYzXbt5bOM92MTF4cPVfJ222gA3F6wYfLWLEa9t7xx5K6i8P3+rHKf17R4wg5f4YmE27kiNIHONf6zJ+alZjyB0k4t2c97a0xyXmQcpyvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=g8hhpCQi; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="g8hhpCQi"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770858870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l9qBLiY/Zeub/nKSwb5e2A5gOFzgjSOE8+Pl+IoBz1c=;
	b=g8hhpCQid7kAYX0pocTwwuAtT4gv+g4FI37OQAl50czuaoyVTt9cm3rIfguFcNfNZ+ufl4
	CQd1aYu0mN/Ot293OZ5jOy+j69kYOqICch+i0NNV5pYjesUhOvKa4HBH4F+PmUi58GFtBv
	hTg79QaryoFKMPiTJmwZdAHU67sQfzc=
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
Subject: [PATCH bpf-next v1 06/14] selftests/bpf: Fix cleanup in check_fd_array_cnt__fd_array_too_big()
Date: Wed, 11 Feb 2026 17:13:48 -0800
Message-ID: <20260212011356.3266753-7-ihor.solodrai@linux.dev>
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

The Close() macro uses the passed in expression three times, which
leads to repeated execution in case it has side effects. That is,
Close(i--) would decrement i three times.

ASAN caught a stack-buffer-undeflow error at a point where this was
overlooked. Fix it.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/testing/selftests/bpf/prog_tests/fd_array.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/fd_array.c b/tools/testing/selftests/bpf/prog_tests/fd_array.c
index c534b4d5f9da..3078d8264deb 100644
--- a/tools/testing/selftests/bpf/prog_tests/fd_array.c
+++ b/tools/testing/selftests/bpf/prog_tests/fd_array.c
@@ -412,8 +412,8 @@ static void check_fd_array_cnt__fd_array_too_big(void)
 	ASSERT_EQ(prog_fd, -E2BIG, "prog should have been rejected with -E2BIG");
 
 cleanup_fds:
-	while (i > 0)
-		Close(extra_fds[--i]);
+	while (i-- > 0)
+		Close(extra_fds[i]);
 }
 
 void test_fd_array_cnt(void)
-- 
2.53.0

