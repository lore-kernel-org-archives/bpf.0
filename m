Received: from mail-10699.protonmail.ch (mail-10699.protonmail.ch [79.135.106.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9686E17A305
	for <bpf@vger.kernel.org>; Fri,  1 May 2026 22:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777675533; cv=none; b=Pwe//ZijU4OeFVzYCu/yuDYZ7lqN2aGlfJceslbDYuKZvOCmMbXQIG809r2yXMjPR6dMlvnv474kbXGqk+kdJGbU98DaHXBq1eL9Vt2MslHvWZ7WIN27UA2a/d9dQGFNFFKFKraE/U1upeITQQxSMuUZGnnzgIc4+bkFJLniEko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777675533; c=relaxed/simple;
	bh=mvvNA7BPw2FVxHrp11dnpb+Q9dHO3q6UOp1aUJP2mdM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sv6xl/R5Vy8I1ymprcUs8hoy7tZXzeygWRa9rEnYO8bcr+Mbc+mSCnjnuZQtXKVPtu2ZF6QXQlK7ZnFjKI+cgVCe2cxSQtTF7GrWz/TnS5pwGpHAl+GQFjBjARf0+S93/9XW4JRubnDXxt3PPXmZVBOCyBteb/kmZkfcf3fs9T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=TkBJq17a; arc=none smtp.client-ip=79.135.106.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="TkBJq17a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1777675522; x=1777934722;
	bh=vuNBf/WLdrpmH3kUQCdc7Ki5TQa7IWEpnw0PfjIRJe8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=TkBJq17aRjJ8JE0XfAjbtnCVFYmHEbgX2BTJObpq1nsZnXfTx3hXzYEvOxq/5OWKq
	 St2Fq63rLiAB6AQr6EaK16enx0goNC8X6B417PYisV8AVOEcu0qvE0rcLjFSAitjUu
	 lchWpozCPaNEMoDxPOZkLJdqdcWOyXPAhi2LXTTRjV+PE/w3k8NPR2/e2qwigkxRSC
	 SGAVSl1GUAJZ5fIvPPwSHXABIkIvsJkEjzJuMGAc3MgtaCDALs+a8DgyIoggIaJDZu
	 upS/TapWHRLnvw1s91S5mL0cS89syZhLdXaG9rQUgJIjgSt8o0RsTbil1+9QQ/Rtia
	 5feuTSquRbWZw==
Date: Fri, 01 May 2026 22:45:17 +0000
To: bpf@vger.kernel.org
From: hadrien Patte <hadrien.patte@protonmail.com>
Cc: qmo@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, linux-kernel@vger.kernel.org, Hadrien Patte <hadrien.patte@protonmail.com>
Subject: [PATCH bpf-next v2] bpftool: Resolve libcrypto link flags via pkg-config
Message-ID: <20260501224346.12765-1-hadrien.patte@protonmail.com>
In-Reply-To: <20260501175829.9833-1-hadrien.patte@protonmail.com>
References: <20260501175829.9833-1-hadrien.patte@protonmail.com>
Feedback-ID: 2516487:user:proton
X-Pm-Message-ID: 5cedde146a368aabbcbfba469f0a2f86d767550c
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From: Hadrien Patte <hadrien.patte@protonmail.com>

When building bpftool with EXTRA_LDFLAGS=3D-static on Ubuntu 26.04
(OpenSSL 3.5.5), the link fails because libcrypto.a references
libjitterentropy symbols, which are not on the link line:

  LINK     bpftool
  /usr/bin/ld: libcrypto.a(libdefault-lib-seed_src_jitter.o):
    in function `ossl_prov_acquire_entropy_from_jitter':
    (.text+0x11c): undefined reference to `jent_entropy_collector_alloc'
    (.text+0x130): undefined reference to `jent_read_entropy'
    (.text+0x13c): undefined reference to `jent_entropy_collector_free'
  /usr/bin/ld: libcrypto.a(libdefault-lib-seed_src_jitter.o):
    in function `jitter_instantiate':
    (.text+0x61c): undefined reference to `jent_entropy_init_ex'
  collect2: error: ld returned 1 exit status

The set of transitive dependencies pulled in by libcrypto.a varies
across distributions and OpenSSL builds (cf. commit 08a749184322
("bpftool: Fix dependencies for static build"), which addressed a
similar libz ordering issue), so hard-coding them in the Makefile is
fragile.

Resolve libcrypto's link flags via pkg-config, which knows about
these transitive deps. Pass --static when the user requested a static
build via EXTRA_LDFLAGS=3D-static so pkg-config emits the static link
line (e.g. "-lcrypto -l:libjitterentropy.a -lz -lzstd -ldl -pthread"
on Ubuntu 26.04).

Resolve libcrypto separately for the target binary (built with
$(CC)) and the bootstrap host tool (built with $(HOSTCC)), using
$(PKG_CONFIG) and $(HOSTPKG_CONFIG) respectively, so cross-compile
setups pick up the correct architecture-specific dependencies. This
follows the pattern already established in
tools/bpf/resolve_btfids/Makefile.

pkg-config remains optional: if the tool is not available, fall back
to plain -lcrypto, mirroring the up-front probe pattern used by
libbpf's standalone Makefile. This preserves the previous build
behavior for environments where pkg-config is not installed.

Signed-off-by: Hadrien Patte <hadrien.patte@protonmail.com>
---

Notes:
    Changes since v1:
     - Probe for pkg-config availability up front and fall back to plain -l=
crypto
       when it isn't installed, mirroring the optional pkg-config pattern i=
n
       libbpf/src/Makefile. This preserves the previous build behavior for
       environments without pkg-config.
     - Use $(PKG_CONFIG) and $(HOSTPKG_CONFIG) (with $(CROSS_COMPILE)pkg-co=
nfig
       defaults) instead of invoking pkg-config directly, so cross-compile =
builds
       query the correct sysroot.
     - Resolve libcrypto separately for the target (CRYPTO_LIBS, used by LI=
BS) and
       the bootstrap host tool (CRYPTO_LIBS_BOOTSTRAP, used by LIBS_BOOTSTR=
AP);
       the bootstrap binary is built with $(HOSTCC) and may need different =
deps
       than the target binary in cross-compile setups.
     - Use $(filter -static,...) instead of $(findstring -static,...) so fl=
ags
       like -static-libasan or library paths containing 'static' don't caus=
e
       false positives.
     - Link to v1: https://lore.kernel.org/bpf/20260501175829.9833-1-hadrie=
n.patte@protonmail.com/

 tools/bpf/bpftool/Makefile | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index 0febf60e1b64..455508d4f654 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -103,7 +103,35 @@ SKIP_LLVM ?=3D
 SKIP_LIBBFD ?=3D
 SKIP_CRYPTO ?=3D
 ifneq ($(SKIP_CRYPTO),1)
-  CRYPTO_LIBS :=3D -lcrypto
+  PKG_CONFIG ?=3D $(CROSS_COMPILE)pkg-config
+  HOSTPKG_CONFIG ?=3D pkg-config
+
+  ifeq ($(shell command -v $(PKG_CONFIG) 2>/dev/null),)
+    NO_PKG_CONFIG :=3D 1
+  endif
+  ifeq ($(shell command -v $(HOSTPKG_CONFIG) 2>/dev/null),)
+    NO_HOSTPKG_CONFIG :=3D 1
+  endif
+
+  # Resolve libcrypto link flags via pkg-config when available, so transit=
ive
+  # dependencies (e.g. libjitterentropy on distros where libcrypto.a
+  # references it) are included for static builds. Pass --static when the
+  # user requested a static build via EXTRA_LDFLAGS=3D-static.
+  ifneq ($(filter -static,$(EXTRA_LDFLAGS)),)
+    PKG_CONFIG_LIBCRYPTO :=3D --libs --static libcrypto
+  else
+    PKG_CONFIG_LIBCRYPTO :=3D --libs libcrypto
+  endif
+
+  ifndef NO_PKG_CONFIG
+    CRYPTO_LIBS :=3D $(shell $(PKG_CONFIG) $(PKG_CONFIG_LIBCRYPTO) 2>/dev/=
null)
+  endif
+  CRYPTO_LIBS :=3D $(if $(CRYPTO_LIBS),$(CRYPTO_LIBS),-lcrypto)
+
+  ifndef NO_HOSTPKG_CONFIG
+    CRYPTO_LIBS_BOOTSTRAP :=3D $(shell $(HOSTPKG_CONFIG) $(PKG_CONFIG_LIBC=
RYPTO) 2>/dev/null)
+  endif
+  CRYPTO_LIBS_BOOTSTRAP :=3D $(if $(CRYPTO_LIBS_BOOTSTRAP),$(CRYPTO_LIBS_B=
OOTSTRAP),-lcrypto)
 endif
=20
 FEATURE_TESTS :=3D clang-bpf-co-re
@@ -140,7 +168,7 @@ endif
 endif
=20
 LIBS =3D $(LIBBPF) -lelf $(CRYPTO_LIBS) -lz
-LIBS_BOOTSTRAP =3D $(LIBBPF_BOOTSTRAP) -lelf $(CRYPTO_LIBS) -lz
+LIBS_BOOTSTRAP =3D $(LIBBPF_BOOTSTRAP) -lelf $(CRYPTO_LIBS_BOOTSTRAP) -lz
=20
 ifeq ($(feature-libelf-zstd),1)
 LIBS +=3D -lzstd
--=20
2.54.0


