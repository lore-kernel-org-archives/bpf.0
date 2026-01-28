Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C03376BF4
	for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 21:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769634816; cv=none; b=mh/NTAG2XFKOtDdRlWREVVxaMklmp4JCvR8OodxhxAUNP4DlGY+QSarn8WHoRCA7RHYDUrkYsXbZyST+jNTPoUUw9OE6OZv/Z2DSGXOb/raPCfu/4oY7IB639pmDf6DhSvzAnymAYdDmAFQzhWD/xB8FJiQJI5g86c97XFST/9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769634816; c=relaxed/simple;
	bh=omyJA/X0hukrCtWLO0gbE+mnwxPOrKZJySt0vFLDzhk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mk+cFx8cmGCAN6QNIHMXKuljHACN70huu2uUYQnaO6zohrPCcBnTf9W2WIVAIunmJTBBlcSumxBGCXqh6KXpAYn7T4vep/pmtMFTWY8hJo7cJum4Ivu6SXN+OzWN1ezhSPTKBtYmL0UUBy2XJtFzL2C5xZlvnG3ujPnAYLnNY8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ib07XMMU; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ib07XMMU"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769634801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+CTZx/fwuOKwQtkXMeKUcQhxF2Ug1WzlL3oGDQXAWRc=;
	b=ib07XMMUzv3/3S9O9LiO0IL7KxUlJYdQJfP6YE7hqEdfQXHXt53KgODo8wVyXowKIf+m77
	PGX1m2Bx9UoajAP/TywQyQQK0TQ6HByD6sJydn+C86bC5zpIR/xIPDmqMmzDPJGbFB0mSD
	fp496MwFZRAugzmUkHN3g8Xpl9z6G38=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Quentin Monnet <qmo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH] bpftool: Fix dependencies for static build
Date: Wed, 28 Jan 2026 13:12:55 -0800
Message-ID: <20260128211255.376933-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When building selftests/bpf with EXTRA_LDFLAGS=-static the follwoing
error happens:

  LINK    /ws/linux/tools/testing/selftests/bpf/tools/build/bpftool/bootstrap/bpftool
/usr/bin/x86_64-linux-gnu-ld.bfd: /usr/lib/gcc/x86_64-linux-gnu/15/../../../x86_64-linux-gnu/libcrypto.a(libcrypto-lib-dso_dlfcn.o): in function `dlfcn_globallookup':
   [...]
/usr/bin/x86_64-linux-gnu-ld.bfd: /usr/lib/gcc/x86_64-linux-gnu/15/../../../x86_64-linux-gnu/libcrypto.a(libcrypto-lib-c_zlib.o): in function `zlib_oneshot_expand_block':
(.text+0xc64): undefined reference to `uncompress'
/usr/bin/x86_64-linux-gnu-ld.bfd: /usr/lib/gcc/x86_64-linux-gnu/15/../../../x86_64-linux-gnu/libcrypto.a(libcrypto-lib-c_zlib.o): in function `zlib_oneshot_compress_block':
(.text+0xce4): undefined reference to `compress'
collect2: error: ld returned 1 exit status
make[1]: *** [Makefile:252: /ws/linux/tools/testing/selftests/bpf/tools/build/bpftool/bootstrap/bpftool] Error 1
make: *** [Makefile:327: /ws/linux/tools/testing/selftests/bpf/tools/sbin/bpftool] Error 2
make: *** Waiting for unfinished jobs....

This is caused by wrong order of dependencies in the Makefile. Fix it.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/bpf/bpftool/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index 5442073a2e42..519ea5cb8ab1 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -130,8 +130,8 @@ include $(FEATURES_DUMP)
 endif
 endif
 
-LIBS = $(LIBBPF) -lelf -lz -lcrypto
-LIBS_BOOTSTRAP = $(LIBBPF_BOOTSTRAP) -lelf -lz -lcrypto
+LIBS = $(LIBBPF) -lelf -lcrypto -lz
+LIBS_BOOTSTRAP = $(LIBBPF_BOOTSTRAP) -lelf -lcrypto -lz
 
 ifeq ($(feature-libelf-zstd),1)
 LIBS += -lzstd
-- 
2.52.0

