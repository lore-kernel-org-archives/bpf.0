Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4698930F547;
	Fri, 20 Feb 2026 22:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771626392; cv=none; b=r6Kfuqy4vJ5KFggz/79a17v41qJ5jl7bBnVxmOq608CKG+B9bL+mDwk6evAYKVVt+HNiWR0HqTskiMAnzuU61/AYZnziAouaHU9ouY2tEzMDuX9SZA5nEQutr6NXR+fMt9TnTK++x4vUhIboOc8XduAi0PYb/hwNtZyjtJJcsYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771626392; c=relaxed/simple;
	bh=HICa71eTyoGa2gtWWBPBm61GreXnEJiLwdqfTHeS+2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JOeN97g04paAFqLekpDmpN5x0Pht/HfR/d2kngtUc/7k7dFhg0p0f6rmKryN+UMgUeLjFKPdO4JJngKcAdxbjKVYvuA36Cghmt+CFSrsiAevIYrYLWZej6yi/xcVvDXMzExtLR9PeBYIsITTLLk1w9I1l66fR8TGKc/Z0VfZItU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=u+5f4V3l; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="u+5f4V3l"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771626388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zSgXN6cPXd9AY0ySct74Vg374gm0gtf3x3gbJSUR/r4=;
	b=u+5f4V3l2LpOdAdW7Hr6Y+P92qI6tyMODabAh9HNfCrNI45FOLhEaeg+E244JJ5NSydTYa
	NSON+1AetSchhvdL3PeDIYNCJtik+K9MII2qmZkeUmU8lGZZV/EcIeX0Ga0GOIAripFwBf
	ztb6ez5I+7pN10TX0Ws059zytmvnJb0=
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
Subject: [PATCH bpf v3 01/15] selftests/bpf: Pass through build flags to bpftool and resolve_btfids
Date: Fri, 20 Feb 2026 14:25:50 -0800
Message-ID: <20260220222604.1155148-2-ihor.solodrai@linux.dev>
In-Reply-To: <20260220222604.1155148-1-ihor.solodrai@linux.dev>
References: <20260220222604.1155148-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

EXTRA_* and SAN_* build flags were not correctly propagated to bpftool
and resolve_btids when building selftests/bpf. This led to various
build errors on attempt to build with SAN_CFLAGS="-fsanitize=address",
for example.

Fix the makefiles to address this:
  - Pass SAN_CFLAGS/SAN_LDFLAGS to bpftool and resolve_btfids build
  - Propagate EXTRA_LDFLAGS to resolve_btfids link command
  - Use pkg-config to detect zlib and zstd for resolve_btfids, similar
    libelf handling

Also check for ASAN flag in selftests/bpf/Makefile for convenience.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/bpf/resolve_btfids/Makefile    |  7 +++++--
 tools/testing/selftests/bpf/Makefile | 13 +++++++++----
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
index 1733a6e93a07..ef083602b73a 100644
--- a/tools/bpf/resolve_btfids/Makefile
+++ b/tools/bpf/resolve_btfids/Makefile
@@ -65,6 +65,9 @@ $(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(LIBBPF_OU
 LIBELF_FLAGS := $(shell $(HOSTPKG_CONFIG) libelf --cflags 2>/dev/null)
 LIBELF_LIBS  := $(shell $(HOSTPKG_CONFIG) libelf --libs 2>/dev/null || echo -lelf)
 
+ZLIB_LIBS  := $(shell $(HOSTPKG_CONFIG) zlib --libs 2>/dev/null || echo -lz)
+ZSTD_LIBS  := $(shell $(HOSTPKG_CONFIG) libzstd --libs 2>/dev/null || echo -lzstd)
+
 HOSTCFLAGS_resolve_btfids += -g \
           -I$(srctree)/tools/include \
           -I$(srctree)/tools/include/uapi \
@@ -73,7 +76,7 @@ HOSTCFLAGS_resolve_btfids += -g \
           $(LIBELF_FLAGS) \
           -Wall -Werror
 
-LIBS = $(LIBELF_LIBS) -lz
+LIBS = $(LIBELF_LIBS) $(ZLIB_LIBS) $(ZSTD_LIBS)
 
 export srctree OUTPUT HOSTCFLAGS_resolve_btfids Q HOSTCC HOSTLD HOSTAR
 include $(srctree)/tools/build/Makefile.include
@@ -83,7 +86,7 @@ $(BINARY_IN): fixdep FORCE prepare | $(OUTPUT)
 
 $(BINARY): $(BPFOBJ) $(SUBCMDOBJ) $(BINARY_IN)
 	$(call msg,LINK,$@)
-	$(Q)$(HOSTCC) $(BINARY_IN) $(KBUILD_HOSTLDFLAGS) -o $@ $(BPFOBJ) $(SUBCMDOBJ) $(LIBS)
+	$(Q)$(HOSTCC) $(BINARY_IN) $(KBUILD_HOSTLDFLAGS) $(EXTRA_LDFLAGS) -o $@ $(BPFOBJ) $(SUBCMDOBJ) $(LIBS)
 
 clean_objects := $(wildcard $(OUTPUT)/*.o                \
                             $(OUTPUT)/.*.o.cmd           \
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 6776158f1f3e..72a9ba41f95e 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -27,7 +27,11 @@ ifneq ($(wildcard $(GENHDR)),)
 endif
 
 BPF_GCC		?= $(shell command -v bpf-gcc;)
+ifdef ASAN
+SAN_CFLAGS 	?= -fsanitize=address -fno-omit-frame-pointer
+else
 SAN_CFLAGS	?=
+endif
 SAN_LDFLAGS	?= $(SAN_CFLAGS)
 RELEASE		?=
 OPT_FLAGS	?= $(if $(RELEASE),-O2,-O0)
@@ -326,8 +330,8 @@ $(DEFAULT_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(BPFTOOLDIR)/Makefile)    \
 		    $(HOST_BPFOBJ) | $(HOST_BUILD_DIR)/bpftool
 	$(Q)$(MAKE) $(submake_extras)  -C $(BPFTOOLDIR)			       \
 		    ARCH= CROSS_COMPILE= CC="$(HOSTCC)" LD="$(HOSTLD)" 	       \
-		    EXTRA_CFLAGS='-g $(OPT_FLAGS) $(EXTRA_CFLAGS)'	       \
-		    EXTRA_LDFLAGS='$(EXTRA_LDFLAGS)'			       \
+		    EXTRA_CFLAGS='-g $(OPT_FLAGS) $(SAN_CFLAGS) $(EXTRA_CFLAGS)'	       \
+		    EXTRA_LDFLAGS='$(SAN_LDFLAGS) $(EXTRA_LDFLAGS)'			       \
 		    OUTPUT=$(HOST_BUILD_DIR)/bpftool/			       \
 		    LIBBPF_OUTPUT=$(HOST_BUILD_DIR)/libbpf/		       \
 		    LIBBPF_DESTDIR=$(HOST_SCRATCH_DIR)/			       \
@@ -338,8 +342,8 @@ $(CROSS_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(BPFTOOLDIR)/Makefile)	\
 		    $(BPFOBJ) | $(BUILD_DIR)/bpftool
 	$(Q)$(MAKE) $(submake_extras)  -C $(BPFTOOLDIR)				\
 		    ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE)			\
-		    EXTRA_CFLAGS='-g $(OPT_FLAGS) $(EXTRA_CFLAGS)'		\
-		    EXTRA_LDFLAGS='$(EXTRA_LDFLAGS)'				\
+		    EXTRA_CFLAGS='-g $(OPT_FLAGS) $(SAN_CFLAGS) $(EXTRA_CFLAGS)'	       \
+		    EXTRA_LDFLAGS='$(SAN_LDFLAGS) $(EXTRA_LDFLAGS)'			       \
 		    OUTPUT=$(BUILD_DIR)/bpftool/				\
 		    LIBBPF_OUTPUT=$(BUILD_DIR)/libbpf/				\
 		    LIBBPF_DESTDIR=$(SCRATCH_DIR)/				\
@@ -404,6 +408,7 @@ $(RESOLVE_BTFIDS): $(HOST_BPFOBJ) | $(HOST_BUILD_DIR)/resolve_btfids	\
 	$(Q)$(MAKE) $(submake_extras) -C $(TOOLSDIR)/bpf/resolve_btfids	\
 		CC="$(HOSTCC)" LD="$(HOSTLD)" AR="$(HOSTAR)" \
 		LIBBPF_INCLUDE=$(HOST_INCLUDE_DIR) \
+		EXTRA_LDFLAGS='$(SAN_LDFLAGS) $(EXTRA_LDFLAGS)' \
 		OUTPUT=$(HOST_BUILD_DIR)/resolve_btfids/ BPFOBJ=$(HOST_BPFOBJ)
 
 # Get Clang's default includes on this system, as opposed to those seen by
-- 
2.53.0

