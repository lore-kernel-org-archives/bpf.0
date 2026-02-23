Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA7536AB44
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 19:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771873718; cv=none; b=A09g9lrYRADSS1o9soEYWTIAfgQ75GrZ1wzn3hNSAtYuSSOmIBhshn7QTXqegEAbtP+XU2gzQQRFUOG4xCpgpNQh7V/vYFzwsffetvl2NWYxhz4LbTnEuLBM/WjPoYfsp9gmrAU4W+HFQgjgf/MXFMb7IY1hI98OVX4wc13ua7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771873718; c=relaxed/simple;
	bh=MzkexYF0KXI6/3f5A4mloKiVVpwcWcpdxEdjkRZ1j64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DluIRZWLE/m4bjtzkV82kTdr9QWqn7gpto/En7QzX5cJfS22gmVyyzzDhkaNDYbmuGmVu+qaV6Z5yt14LeXdOCqr3Q9hsI9Blrjy1eVCl8xQre4VMoJUvSM5gqoekijRi9XlaxOyxETVfIF0YxW7W08af7JrfQ3uLk5ppnLhzHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cb+2j3tF; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cb+2j3tF"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771873715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t09EQpvSYD39X1EIK3P1BpaFzBMy5xyjK9v+7bVPEt8=;
	b=cb+2j3tFqwcfnwKWazG6diYCBn1LptyM5kJrZdwOsfHIgrmoNhxHIhASwHUureq4gfiBeK
	Ge5tdxll2dL5A/egJIUkcvphxaOMuQl8dlXb3eSan6V5xJfmg0LWmCr2TSMmLlY5dSL1Dl
	stEH8TBowQBKAAhJyIODrnvKa0UX2rs=
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
Subject: [PATCH bpf v4 13/20] selftests/bpf: Fix use-after-free in xdp_metadata test
Date: Mon, 23 Feb 2026 11:07:29 -0800
Message-ID: <20260223190736.649171-14-ihor.solodrai@linux.dev>
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

ASAN reported a use-after-free in close_xsk().

The xsk->socket internally references xsk->umem via socket->ctx->umem,
so the socket must be deleted before the umem. Fix the order of
operations in close_xsk().

Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
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

