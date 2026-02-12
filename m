Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9D21F4C8C
	for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 01:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770858879; cv=none; b=hvqOYCCImPn0xaKeV7JGdzQIqG9dmYdTJRp8xNZbcLU1h0b8Q0BBgNJgyO3DHz91AAvk67LbIUMiOxaMz5GW6vQjrv1XHGqPxn6d3fVPMJjjXY8I4IJEd0Qd9ogFf+et9NgakD2n2mV/JaX+9roq3Trc+Xn8hiFKJqwC6nBRFjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770858879; c=relaxed/simple;
	bh=x1r6pzCR0rw1FH9puuDkSVlUfccZ97XRCiSDfLsmQt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l4FgTOf8noJC9HulWVQgEHXaQUS/OB4TXPrZvmcgRt+gGgHYkZYr4Hk4mF44vb9X2X/giCIF1/fiu9vR7KkBeH6gUHizUvaIqAU9sNPdkhvFNe3E5B1G/p/yBt6cz6rtB9xEoRlMSpI6MXV5i/mwX8RQfFvQpUjanK7jMp9ZVIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Dl8jvShe; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Dl8jvShe"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770858876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ge5cfkJMe63xIQAN8z0KA4mODNMCGr4RrUgbIpsdlg0=;
	b=Dl8jvShewm+x7YZDvjiQbWJQKWD1b600aWA8uhsijvr+EiNkEvxo1gX6MitzjZlfDSIuqg
	LDUToLI2vfydV3HT8wffyi0qYbaVeuTcWyHED2lR5tMhBKLCoUEHvS1ZqMf5Z+RR+rJ5QN
	EGpf6mr8whMKktJfeJ4Ypm+fpfFOKo0=
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
Subject: [PATCH bpf-next v1 08/14] selftests/bpf: Fix use-after-free in xdp_metadata test
Date: Wed, 11 Feb 2026 17:13:50 -0800
Message-ID: <20260212011356.3266753-9-ihor.solodrai@linux.dev>
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

ASAN reported a use-after-free in close_xsk().

The xsk->socket internally references xsk->umem via socket->ctx->umem,
so the socket must be deleted before the umem. Fix the order of
operations in close_xsk().

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/testing/selftests/bpf/prog_tests/xdp_metadata.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
index 19f92affc2da..5c31054ad4a4 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
@@ -126,10 +126,10 @@ static int open_xsk(int ifindex, struct xsk *xsk)
 
 static void close_xsk(struct xsk *xsk)
 {
-	if (xsk->umem)
-		xsk_umem__delete(xsk->umem);
 	if (xsk->socket)
 		xsk_socket__delete(xsk->socket);
+	if (xsk->umem)
+		xsk_umem__delete(xsk->umem);
 	munmap(xsk->umem_area, UMEM_SIZE);
 }
 
-- 
2.53.0

