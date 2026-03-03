Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FB339768E
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 19:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772566809; cv=none; b=IvL2EroN6r8YLzwNsgCyjkR1uJ8MoKte84J4DUNRkVbSsBNYXVQxCV/EdUNUJNvJ3AC7ysGHpl9hum773rpjJ2RYh/wSf/EWZfjT3xP0cRZXjTwslhxYfOlRfiT3jX2E0x1+c4SfeL4JX+WgWzlFAEoglttneGt0sTsC8E7Gfnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772566809; c=relaxed/simple;
	bh=fDpVRN6xhrw2K6gNgHHSFsJapMwBoOR36TJb/fTtJwE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DWDEsIN1cZJf4lsn10+D3J4YN3xePfZLbXeUDaIGVNjACw0ByayAC5fOarHs2gs3S+tDhgyNmPkyxRalmEbm0WkFrrEz2BdxBuPY5j4jwuAVoN6cf+61ZMCv8nUFJJC/JXZw7OQyo+aHjKY7jz8AzXtQmviWhC9GbPR8WxNa3z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m1WuDoyT; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m1WuDoyT"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772566804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KPDS7a+80jQfdSHXe79S4KVz5DqvV7Sx3VnEtyXyCAo=;
	b=m1WuDoyTKmha5VVIdxh+VR6qtf0MM7+WwORw4Ln2hnpwqCgkLXTKCGYuFeNHTgoP/NqFLn
	f6Zaq34/6oPbc13ywVtQQey2WwLPdS3YJnmHARIsiAHRFeA5Ucr5nb5jkPyTppdQ1Ca4J3
	qLnNDq62QBJiUhizoykGR/4pHUj2yQc=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: Vitaly Chikunov <vt@altlinux.org>,
	bpf@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf v2] resolve_btfids: Fix linker flags detection
Date: Tue,  3 Mar 2026 11:39:54 -0800
Message-ID: <20260303193954.1879948-1-ihor.solodrai@linux.dev>
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

Remove ZSTD_LIBS variable, and instead set LIBELF_LIBS depending on
whether the build is static or not. Use $(HOSTPKG_CONFIG) as primary
source of the flags list.

Also add a default value for HOSTPKG_CONFIG in case it's not built via
the toplevel Makefile.

[1] https://lore.kernel.org/bpf/4ff82800-2daa-4b9f-95a9-6f512859ee70@linux.dev/

Reported-by: BPF CI Bot (Claude Opus 4.6) <bot+bpf-ci@kernel.org>
Reported-by: Vitaly Chikunov <vt@altlinux.org>
Closes: https://lore.kernel.org/bpf/aaWqMcK-2AQw5dx8@altlinux.org/
Fixes: 4021848a903e ("selftests/bpf: Pass through build flags to bpftool and resolve_btfids")
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>

---

v1: https://lore.kernel.org/bpf/20260302231058.916946-1-ihor.solodrai@linux.dev/

---
 tools/bpf/resolve_btfids/Makefile | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
index ef083602b73a..7672208f65e4 100644
--- a/tools/bpf/resolve_btfids/Makefile
+++ b/tools/bpf/resolve_btfids/Makefile
@@ -23,6 +23,7 @@ RM      ?= rm
 HOSTCC  ?= gcc
 HOSTLD  ?= ld
 HOSTAR  ?= ar
+HOSTPKG_CONFIG ?= pkg-config
 CROSS_COMPILE =
 
 OUTPUT ?= $(srctree)/tools/bpf/resolve_btfids/
@@ -63,10 +64,14 @@ $(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(LIBBPF_OU
 		    $(abspath $@) install_headers
 
 LIBELF_FLAGS := $(shell $(HOSTPKG_CONFIG) libelf --cflags 2>/dev/null)
+
+ifneq ($(filter -static,$(EXTRA_LDFLAGS)),)
+LIBELF_LIBS  := $(shell $(HOSTPKG_CONFIG) libelf --libs --static 2>/dev/null || echo -lelf -lzstd)
+else
 LIBELF_LIBS  := $(shell $(HOSTPKG_CONFIG) libelf --libs 2>/dev/null || echo -lelf)
+endif
 
 ZLIB_LIBS  := $(shell $(HOSTPKG_CONFIG) zlib --libs 2>/dev/null || echo -lz)
-ZSTD_LIBS  := $(shell $(HOSTPKG_CONFIG) libzstd --libs 2>/dev/null || echo -lzstd)
 
 HOSTCFLAGS_resolve_btfids += -g \
           -I$(srctree)/tools/include \
@@ -76,7 +81,7 @@ HOSTCFLAGS_resolve_btfids += -g \
           $(LIBELF_FLAGS) \
           -Wall -Werror
 
-LIBS = $(LIBELF_LIBS) $(ZLIB_LIBS) $(ZSTD_LIBS)
+LIBS = $(LIBELF_LIBS) $(ZLIB_LIBS)
 
 export srctree OUTPUT HOSTCFLAGS_resolve_btfids Q HOSTCC HOSTLD HOSTAR
 include $(srctree)/tools/build/Makefile.include
-- 
2.53.0

