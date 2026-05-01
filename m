Received: from mail-24426.protonmail.ch (mail-24426.protonmail.ch [109.224.244.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C66327C1D
	for <bpf@vger.kernel.org>; Fri,  1 May 2026 17:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777658342; cv=none; b=m77XrbjVN3XRB30Zx/xBltTmhGL6ewUCnZTHsb8mmcN0trgppGTIT3HcoGRUrbAHD9337YhlXsGAid5TIBhjXzzBkdWwpPkXqa1D0u/AI6rfvCfdCtL2xNTiZqsHCwIEaEbDwV61nU24F7V+QV73PDBTFVCn+D0u20qScIY96LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777658342; c=relaxed/simple;
	bh=rhqMFZvmeOvxnriBYHGR+ySCTl4MDpJ+hzg0JAQ5qC0=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Uyq3fxd55Z0Ub77tQnP5kglk7Sm9bZbTe6kPeOA9XMl3luuoFX+e79NomvTEalx6vG1X+VXzVFoXLGBrX3digYEvRhhXlTFLE+oVVsbP2bG4Mhb6lqFthfMkPHuBkuTZ+L0mAv81d3P0CP925A+/JWmWFDp0fvalUDJVwPvZtsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=nxGCBiuH; arc=none smtp.client-ip=109.224.244.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="nxGCBiuH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1777658331; x=1777917531;
	bh=0KsiO/GfIkeRExHRdfMoo8/90PdCZw6HZW464yEwajs=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=nxGCBiuHz+MzcERazudYfA9RIeoL0PCGK/us4eRY3t5zsUG9WV91hVQYaxQ6lo7py
	 MXg/66ri4NBfXSO8YmRmtZZXr+esMO0NfmCfxzxqOniXPdkq+iNG0wJcD+LS3YKiFp
	 Yq/LnWgQGYCYA+CKRPYGrIXNZUrDiKp7M/VxRQqoLUE3IePUrrI0dNIOJMx6idZc4p
	 6ZTdvp3hg7QXCS4Y/rJwjplRp3YBeQdOWX2gUpe7k5nTktsHhne8Omqj1UyL8Tg/Hz
	 xQ/K+LnrufTP+pb28dAIA1feoqtbSuX220hk3ixPm2haFIAlL40Bk5YTbUSokrNwK0
	 zg+UScdmzIYWw==
Date: Fri, 01 May 2026 17:58:44 +0000
To: bpf@vger.kernel.org
From: hadrien Patte <hadrien.patte@protonmail.com>
Cc: qmo@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, linux-kernel@vger.kernel.org, Hadrien Patte <hadrien.patte@protonmail.com>
Subject: [PATCH bpf-next] bpftool: Resolve libcrypto link flags via pkg-config
Message-ID: <20260501175829.9833-1-hadrien.patte@protonmail.com>
Feedback-ID: 2516487:user:proton
X-Pm-Message-ID: 7b816e66bd4118b2e522f01e1632e30ae6710b96
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
on Ubuntu 26.04). Fall back to -lcrypto if pkg-config or
libcrypto.pc is unavailable, preserving the previous behavior on
minimal build environments.

Signed-off-by: Hadrien Patte <hadrien.patte@protonmail.com>
---
 tools/bpf/bpftool/Makefile | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index 0febf60e1b64..d9ab860a6cce 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -103,7 +103,17 @@ SKIP_LLVM ?=3D
 SKIP_LIBBFD ?=3D
 SKIP_CRYPTO ?=3D
 ifneq ($(SKIP_CRYPTO),1)
-  CRYPTO_LIBS :=3D -lcrypto
+  # Resolve libcrypto link flags via pkg-config so transitive dependencies
+  # (e.g. libjitterentropy on distros where libcrypto.a references it) are
+  # included for static builds. Pass --static when the user requested a
+  # static build via EXTRA_LDFLAGS=3D-static. Fall back to -lcrypto if
+  # pkg-config or libcrypto.pc is unavailable.
+  ifneq ($(findstring -static,$(EXTRA_LDFLAGS)),)
+    CRYPTO_LIBS :=3D $(shell pkg-config --libs --static libcrypto 2>/dev/n=
ull)
+  else
+    CRYPTO_LIBS :=3D $(shell pkg-config --libs libcrypto 2>/dev/null)
+  endif
+  CRYPTO_LIBS :=3D $(if $(CRYPTO_LIBS),$(CRYPTO_LIBS),-lcrypto)
 endif
=20
 FEATURE_TESTS :=3D clang-bpf-co-re
--=20
2.54.0


