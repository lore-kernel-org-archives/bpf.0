Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.220.155.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795475468;
	b=rFVgYg1CV/rSYUS784Dk/Fm3KgX9iuw0MdRPl1UOjGCM3V4A8WisJntFwT1575WPlW5I
	 VmNCpR68KjSkDRXQxHWJxi4bEAf5aH9hquYxvlcmvwfpztaqZihoui/3lsCCRXZmfnn7t
	 8KhOrdIoVJTFckTwJHabVVskXEPUKAehChlcQ3ecjR4yitjxeHs4Y741Od46ELMR/cY2b
	 ZmpYwb6Ummq0YOjNaQuj5pWUXhoADXt5+Ydyjump9FO1R41nZekfOudPkOBzIw5Q3CFE0
	 kq2RNmkXSh8jUcgOMJr37zQSYfcWupGFk0Re1uqULdvTE8dX1aw1gAzIK9qSFUKJRkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795475468;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=tbU/nsbnC0mhIk5F7AqUaDK4620RkuT09HFBRG0dWGQ=;
	b=Wl5qDFCvEwsa3A8OTZBvnIn0Q+s/PSv7BkBV9L6+d0v2PsxWo9oQKnzFyC9jew7c8NRf
	 wUHu2kI46klZEiBk3ZlCE5ZM4vFv45HR1U8WoEBuctaZvSIODuO3uJpdjmkRj3E6nQIf3
	 HIQ5hnf4dpivqDrNiMt0I7M3HaraXLRKOxdeF/HMC4rT6a5DaRlxVEDWwNLMu1VTipcT2
	 g/ZxOz8hT2hkJIHatLds1ooYGZ3zo/YhEaahIE7k6hHMK6j3DBb4giv/yL3+rlY6iWKDH
	 kyaRN4dTRnrsk4dHsKjcwiaT4AARpODGLyacxg6CB1GU49Hd0byYza/YGkawXMTgKBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.dev;
	spf=fail smtp.mailfrom=linux.dev;
	arc=none smtp.remote-ip=66.220.155.179
Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A934B606A6A3
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 23:11:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A934B606A6A3
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm50310.atn0.facebook.com (Postfix, from userid 128203)
	id 4A30E5988C100; Mon, 23 Nov 2026 15:10:58 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next 2/2] kbuild, bpf: Remove pahole version checks below v1.24
Date: Mon, 23 Nov 2026 15:10:58 -0800
Message-ID: <20261123231058.2538362-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.1
In-Reply-To: <20261123231053.2538168-1-yonghong.song@linux.dev>
References: <20261123231053.2538168-1-yonghong.song@linux.dev>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The previous patch makes CONFIG_DEBUG_INFO_BTF require pahole v1.24, so
the Kconfig checks for an older pahole always pass with
CONFIG_DEBUG_INFO_BTF.

Remove CONFIG_PAHOLE_HAS_LANG_EXCLUDE (pahole v1.24), which is always
set with CONFIG_DEBUG_INFO_BTF. Drop it from the dependency of
CONFIG_RUST on !CONFIG_DEBUG_INFO_BTF, and always pass
--lang_exclude=3Drust in scripts/Makefile.btf, which is only included
with CONFIG_DEBUG_INFO_BTF.

CONFIG_PAHOLE_HAS_BTF_TAG (pahole v1.23) is still needed, since
btf_type_tag is only used with clang, but it no longer needs the pahole
version. Every user of it also checks CONFIG_DEBUG_INFO_BTF, so make it
depend on CONFIG_CC_IS_CLANG only.

The pahole flags and the resulting config are unchanged, except that
CONFIG_PAHOLE_HAS_LANG_EXCLUDE is gone.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 init/Kconfig         |  2 +-
 lib/Kconfig.debug    | 12 +-----------
 scripts/Makefile.btf |  2 +-
 3 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index c8a7cfa60a6e..ca7f20462d0c 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2065,7 +2065,7 @@ config RUST
 	depends on !MODVERSIONS || GENDWARFKSYMS
 	depends on !GCC_PLUGIN_RANDSTRUCT
 	depends on !RANDSTRUCT
-	depends on !DEBUG_INFO_BTF || (PAHOLE_HAS_LANG_EXCLUDE && !LTO)
+	depends on !DEBUG_INFO_BTF || !LTO
 	depends on !CFI || HAVE_CFI_ICALL_NORMALIZE_INTEGERS_RUSTC
 	select CFI_ICALL_NORMALIZE_INTEGERS if CFI
 	depends on !KASAN || CC_IS_CLANG
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 9479034afe5a..c6123d52576e 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -409,22 +409,12 @@ config DEBUG_INFO_BTF
 	  DWARF type info into equivalent deduplicated BTF type info.
=20
 config PAHOLE_HAS_BTF_TAG
-	def_bool PAHOLE_VERSION >=3D 123
-	depends on CC_IS_CLANG
+	def_bool CC_IS_CLANG
 	help
 	  Decide whether pahole emits btf_tag attributes (btf_type_tag and
 	  btf_decl_tag) or not. Currently only clang compiler implements
 	  these attributes, so make the config depend on CC_IS_CLANG.
=20
-config PAHOLE_HAS_LANG_EXCLUDE
-	def_bool PAHOLE_VERSION >=3D 124
-	help
-	  Support for the --lang_exclude flag which makes pahole exclude
-	  compilation units from the supplied language. Used in Kbuild to
-	  omit Rust CUs which are not supported in version 1.24 of pahole,
-	  otherwise it would emit malformed kernel and module binaries when
-	  using DEBUG_INFO_BTF_MODULES.
-
 config PAHOLE_HAS_INLINE
 	def_bool PAHOLE_VERSION >=3D 132
 	help
diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
index 02ff1702e1e8..8cd8c88d4580 100644
--- a/scripts/Makefile.btf
+++ b/scripts/Makefile.btf
@@ -20,7 +20,7 @@ pahole-flags-$(call test-ge, $(pahole-ver), 131) +=3D -=
-btf_features=3Dlayout
=20
 endif
=20
-pahole-flags-$(CONFIG_PAHOLE_HAS_LANG_EXCLUDE)		+=3D --lang_exclude=3Dru=
st
+pahole-flags-y						+=3D --lang_exclude=3Drust
=20
 btf-inline :=3D $(CONFIG_DEBUG_INFO_BTF_INLINE)
 ifneq ($(btf-inline),)
--=20
2.53.1-Meta

