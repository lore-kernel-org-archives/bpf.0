Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A38C8632B
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 01:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772675271; cv=none; b=nxB1QcgNIBy8nBXXSFAwCtl+AIsBu5mf+hEq7eiEuLKZG6Q2xaSqLjmWSPGzMIgER5ydYulssjMafhHGrUFlgeRWUcUkNM3mevNfG2611uoG4j4Lw5MRJMj4/+B36FP0fNEmKdFkyQ2gQ9PvmDcsfwB1zFoISJLpurdaN5Tq8ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772675271; c=relaxed/simple;
	bh=oXzvPnYTqJ/VdaGlUO4Ss9kFiI5jeYEGS4Ci00IFfCc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tn6EsoEp7OLFLKs7en2p6Ok96CpevHLcBUNDsuBJ83oT5siz8G1MEna5kNorpsLnG84mDYCTp+eW2KmNK6TcdPz7x6wCem7/asp9MtTyIyjR+/yaWLWbhLGwT4NvGGuCaWRixbdC+0c2fpakgxryBm+T/6ZKBcsBZNZY0x5d/5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pWYWFiyk; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pWYWFiyk"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772675267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=l2pXca8ytjqqZIXpp8jxmyNDWO6b9AWoUWW2hg/Yqjc=;
	b=pWYWFiykZiT/N4Gn1VPScpHzpf9wmjxL5diRO+0GfzfmpZOxoADQo0Ni5vX/jYoNFLTqvW
	Gt7XDZVdQCno8vO4jeXcmo1hi4LFwguf4R57YiyNu1JWWg6EMsN2RkwHRE3BAlc+x/96a9
	xiNKbUD73LkDjlns42Ku0F/lnUoQCm0=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: Paul Chaignon <paul.chaignon@gmail.com>,
	Vitaly Chikunov <vt@altlinux.org>,
	bpf@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf v3] resolve_btfids: Fix linker flags detection
Date: Wed,  4 Mar 2026 17:47:30 -0800
Message-ID: <20260305014730.3123382-1-ihor.solodrai@linux.dev>
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
the toplevel Makefile. Pass it from selftests/bpf too.

[1] https://lore.kernel.org/bpf/4ff82800-2daa-4b9f-95a9-6f512859ee70@linux.dev/

Reported-by: BPF CI Bot (Claude Opus 4.6) <bot+bpf-ci@kernel.org>
Reported-by: Vitaly Chikunov <vt@altlinux.org>
Closes: https://lore.kernel.org/bpf/aaWqMcK-2AQw5dx8@altlinux.org/
Fixes: 4021848a903e ("selftests/bpf: Pass through build flags to bpftool and resolve_btfids")
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---

v2->v3: Pass HOSTPKG_CONFIG from selftests/bpf/Makefile (Paul)
v2: https://lore.kernel.org/bpf/20260303193954.1879948-1-ihor.solodrai@linux.dev/

v1->v2: Use different LDFLAGS depending on -static (Vitaly)
v1: https://lore.kernel.org/bpf/20260302231058.916946-1-ihor.solodrai@linux.dev/

---
 tools/bpf/resolve_btfids/Makefile    | 9 +++++++--
 tools/testing/selftests/bpf/Makefile | 1 +
 2 files changed, 8 insertions(+), 2 deletions(-)

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
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 72a9ba41f95e..d5acbeba0383 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -409,6 +409,7 @@ $(RESOLVE_BTFIDS): $(HOST_BPFOBJ) | $(HOST_BUILD_DIR)/resolve_btfids	\
 		CC="$(HOSTCC)" LD="$(HOSTLD)" AR="$(HOSTAR)" \
 		LIBBPF_INCLUDE=$(HOST_INCLUDE_DIR) \
 		EXTRA_LDFLAGS='$(SAN_LDFLAGS) $(EXTRA_LDFLAGS)' \
+		HOSTPKG_CONFIG=$(PKG_CONFIG) \
 		OUTPUT=$(HOST_BUILD_DIR)/resolve_btfids/ BPFOBJ=$(HOST_BPFOBJ)
 
 # Get Clang's default includes on this system, as opposed to those seen by
-- 
2.53.0

