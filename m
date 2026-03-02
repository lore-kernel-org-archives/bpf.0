Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94793909A9
	for <bpf@vger.kernel.org>; Mon,  2 Mar 2026 23:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772493076; cv=none; b=L9+pIAap0cyJPR6U8FSxYh+6zO/bGSV2DvVlrnSfvkqY5A8xjG6/VhIUew6+Hnc3T9/UtJWy48F2aV9rfd/+P2WZqih7kW4a1E+24/H3L8Fq3sVYuW7A2MY//2Xn2Cc3MgMuR2uBnKGWJjKtzPnKJt4ts8HUOQcIGv7774s6KRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772493076; c=relaxed/simple;
	bh=xoEVebyAMBRsiJQBuK3pLOgTcLSzczaVqVR6qSXBNxw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B2/E3AmELvC+i1CcTwUa41+bUAAIQcJWClybo+fBwBGoO40KMrhxXIjaNhZ0KYUmqUVPdk5Y7cNlZiTDO75ozfUrLWDYxWgjsKQhNaWIYOLo6d3Z1SU3aPJUyULnD4/3cDNWT6eiOvmt7JbkWBRiKWlBTVDajyU+1cLdU2A4H9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m2r9Cblt; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m2r9Cblt"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772493072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eZOrHEw+rqxeBZXJhNIYbNLO7A+z0viePGogPCMH9ZE=;
	b=m2r9CbltQpT9PBKVHtd1LpI+bj3shgkbAzS9mexb6Byrfx2xj9VlLDsQ0bYI8LfZqe8yzF
	dx+Vsdl1ctd8JCYoCfKKlKGwhXourq/h7G6FKNeI0OdCFTpWAcBPV3wTxOtxLIP/0t5Khk
	NUg57yggaZq7VosU8UZENTlO60Bsfbc=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: Vitaly Chikunov <vt@altlinux.org>,
	bpf@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf v1] resolve_btfids: Drop -lzstd fallback if libzstd not found
Date: Mon,  2 Mar 2026 15:10:58 -0800
Message-ID: <20260302231058.916946-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The "|| echo -lzstd" default makes zstd an unconditional link
dependency of resolve_btfids. On systems where libzstd-dev is not
installed and pkg-config fails, the linker fails:

  ld: cannot find -lzstd: No such file or directory

libzstd is a transitive dependency of libelf, so the -lzstd flag is
strictly necessary only for static builds [1].

Drop the -lzstd fallback to enable builds on systems without
libzstd-dev installed.

Reported-by: BPF CI Bot (Claude Opus 4.6) <bot+bpf-ci@kernel.org>
Reported-by: Vitaly Chikunov <vt@altlinux.org>
Closes: https://lore.kernel.org/bpf/aaWqMcK-2AQw5dx8@altlinux.org/
Fixes: 4021848a903e ("selftests/bpf: Pass through build flags to bpftool and resolve_btfids")
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/bpf/resolve_btfids/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
index ef083602b73a..5df897c881d3 100644
--- a/tools/bpf/resolve_btfids/Makefile
+++ b/tools/bpf/resolve_btfids/Makefile
@@ -66,7 +66,7 @@ LIBELF_FLAGS := $(shell $(HOSTPKG_CONFIG) libelf --cflags 2>/dev/null)
 LIBELF_LIBS  := $(shell $(HOSTPKG_CONFIG) libelf --libs 2>/dev/null || echo -lelf)
 
 ZLIB_LIBS  := $(shell $(HOSTPKG_CONFIG) zlib --libs 2>/dev/null || echo -lz)
-ZSTD_LIBS  := $(shell $(HOSTPKG_CONFIG) libzstd --libs 2>/dev/null || echo -lzstd)
+ZSTD_LIBS  := $(shell $(HOSTPKG_CONFIG) libzstd --libs 2>/dev/null)
 
 HOSTCFLAGS_resolve_btfids += -g \
           -I$(srctree)/tools/include \
-- 
2.53.0

