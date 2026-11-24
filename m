Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.220.155.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795488410;
	b=mDgnyZ1lmo6X25jQDXSvzDEsRHR9uGulghAzpneZtiT4zrz+k0kbe5hvh+kvNZfjZWXh
	 adum4tzO2SpaCQvw/W+Z0jMz7ToBJrbNiMbGVB5scwRfZFdpnso/FJVZ1bA2w7qj0nX5b
	 vC0Vnrw3kmPoNzCjahUs5P75eX7oXzW9ObuWyAazRHXo+gmVq4VVVNH6CbSfbNHFOiLxI
	 r4clvGdM4ukVEBLF47iQi11US6BjXJm20ExY8gbhKo2g1u7ZVbyU++IoSqIMPBOYMrGZb
	 O1U92dLlHNvIbyUEf4TV+TBehEF76se1gAWdvMjSqr9yz9BHj4zbZrVmJBllWJp5wdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795488410;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ARErnA0JvN0xgM7JabWK+2zf/VLQftOCcE/zdFs4d64=;
	b=1HKBDNx7CfWsh9V4loagWlFGI3YBFe4mc4+wEy46SRXX1e0LOEQpvCkgvKR4iPXjmuu1
	 UpJeN0CkY5SY+ndx1YqUAUvRcIWe6x7r/rOF6x/Dbitz+4DnYZuw+HjaJTlIAB89lH2ef
	 pzZg+qv0TD+jIVoLiga440/BC+YS0tlmMCKVZAC3ZwovxvV2yTIRKnX/dQOPfwUAdxlC9
	 SwUdPQ9ZKWhttETSuo2NHF1T6FGe2gAzAvf/sYEOr3ZnnfaSNLt1OCYDps2oFBAbagngk
	 /F1PfXKrj2MVY98/r9dvyo4dfahHMwgA5dAb86ZqCFr2jiIITuy3JaxdP3hYnRz/SDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.dev;
	spf=fail smtp.mailfrom=linux.dev;
	arc=none smtp.remote-ip=66.220.155.178
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54288606A31E
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 02:46:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54288606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm50310.atn0.facebook.com (Postfix, from userid 128203)
	id 5B07159991A54; Mon, 23 Nov 2026 18:46:39 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com,
	Alan Maguire <almagui@kernel.org>
Subject: [PATCH bpf-next v2 2/2] kbuild, bpf: Remove CONFIG_PAHOLE_HAS_LANG_EXCLUDE
Date: Mon, 23 Nov 2026 18:46:39 -0800
Message-ID: <20261124024639.3872475-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.1
In-Reply-To: <20261124024629.3871056-1-yonghong.song@linux.dev>
References: <20261124024629.3871056-1-yonghong.song@linux.dev>
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
CONFIG_PAHOLE_HAS_LANG_EXCLUDE (pahole v1.24) is always set with
CONFIG_DEBUG_INFO_BTF.

Remove it. CONFIG_RUST now depends on !CONFIG_DEBUG_INFO_BTF ||
!CONFIG_LTO, and scripts/Makefile.btf, which is only included with
CONFIG_DEBUG_INFO_BTF, always passes --lang_exclude=3Drust.

The pahole flags and the resulting config are unchanged, except that
CONFIG_PAHOLE_HAS_LANG_EXCLUDE is gone.

Acked-by: Alan Maguire <almagui@kernel.org>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 init/Kconfig         | 2 +-
 lib/Kconfig.debug    | 9 ---------
 scripts/Makefile.btf | 2 +-
 3 files changed, 2 insertions(+), 11 deletions(-)

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
index 9479034afe5a..1d35a99d6cb5 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -416,15 +416,6 @@ config PAHOLE_HAS_BTF_TAG
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

