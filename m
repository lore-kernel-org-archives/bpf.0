Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF4E36AB4C
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 19:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771873712; cv=none; b=Wn81Pd1c8GsVitU3PaDGFyHDZeDktbJvSas0nT0lce6h8UxHNWSDWySiyjgMNgnt3eeyftahEVYOGNzOuZxS4TpK63inHmRBuK+pU6rU0AnPKhBSPnxko21VyasScD702R3OrhvdS1zr79S9JoVKejZIdJ/M1N+wI1ImfH5uh6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771873712; c=relaxed/simple;
	bh=ObsMtcRRjv9Zj6rFWk3J31bqxVbLTticfINT6Fj0dx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JJcFKKNd0OdhilUOkvXqYtZSa1pG3PNXu6iSJsFevNUZdu46bbX66yuqXrslw1EvK0Iy7jl9RZoFwqdaBBHeHrFUbqZayrz6Am18B6v+PsGrIeo32mGnXsVJNmUEHgrwOmnwECZPnng3BrSfZRYp55XoHoDNL5dL8MrAw5a/2No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Kq3kyoTQ; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Kq3kyoTQ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771873709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pa0F2SW5cYTzCEHbVS+ffKXWQRWV1EBeihritj2o+XI=;
	b=Kq3kyoTQH3gUGC+7Ix4AHbCQ3ToSdgRpv2lZdVUY4/Eq19PZ/ijsQMWTzNdEvjzBrACVvE
	jZhy9FBQMKSFSbWiXr4DEVF4VzCzVksQ60Lg+LyCf0IVL2oNeOYnj3P4b85HgMSWk7mJHU
	oSof+QbBCG8DerzrPLvwUplsoUkbuzo=
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
Subject: [PATCH bpf v4 11/20] selftests/bpf: Fix cleanup in check_fd_array_cnt__fd_array_too_big()
Date: Mon, 23 Feb 2026 11:07:27 -0800
Message-ID: <20260223190736.649171-12-ihor.solodrai@linux.dev>
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

The Close() macro uses the passed in expression three times, which
leads to repeated execution in case it has side effects. That is,
Close(i--) would decrement i three times.

ASAN caught a stack-buffer-undeflow error at a point where this was
overlooked. Fix it.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
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

