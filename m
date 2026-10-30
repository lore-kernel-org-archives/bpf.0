Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.249
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793403264;
	b=oBDTwPgw2feY//sXktPW9kQes2zkE56PE/hcNMshSc4KMaGBUasy8tkAG/oxLFYatXzV
	 5EkampTpHZw3eWnS1XZS1vaCo4GehmCopYQOpclkhLbPJJhUIQx+M0/y1ey2B4VO3X7De
	 WbuBDOL3Y0cBdXHmv+jIFWjElEAVgz13T0ADHUrSQ9Dlf8f69V6uJwC/RNEwdl7UNjEWn
	 pENI8f7p/xIRKkcoED2W2tVKBBggh8L76MRAUFPScjn/7ffBmNpxJHDlSQetIdgmAVB+7
	 qtNkz3nwZDSyfi1MqNF8ZX4bLeyPZXHSTL3ist1zCyyYw+Bs8nI+eSD6V2JHUTy99oA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793403264;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XXqymegywkUlwgp31Rc2ThtMNA1h6nw56I6NCpSwczE=;
	b=gptBEsR9ZhiTEMpiRZKOn9W1Mo+HT8uYxB9eVe4m/lx7y4R39nL1lbblnBCWrekdJRKR
	 CpkwoGNwL0MxtuU+Z31XZ9+G1rsPbXmM4KkKNLYZUrYOP3thwCIAzX6iBUFzEyvhFFwNq
	 Fvl5wVYEuzSkiHIvW8wJPHs64J5adnRsv4GpO6llAOJbzO3BJYuuxwDxMMKx3v+WnCGlh
	 YO5iu3g/Ttyz6+DkP7Jav/YrCyWNHOugssvVHQnb3hYep4gISJtI4smNthnO9vQWqa4+8
	 y3jHThtfPwm1DQwQHqnNzZLDkgTYd4xdgQDx0UH1zAyK5EP9yz4HnsCRMGDNiHIF1iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="GiKI/fk2";
	arc=none smtp.remote-ip=91.218.175.249
Received: from mta0.migadu.com (out-249.mta0.migadu.com [91.218.175.249])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FD0606A323
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 23:34:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6FD0606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=GiKI/fk2
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=hXecRXRQYoAkR0AIE1FGJ846IEqJ5Hg+GwKVVww8/Ok=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793403261; v=1; x=1794008061;
 b=GiKI/fk2XWgKkfddchlFDCokUDosZANTQdOvSS98swEEtKeInX8lMGwq8gzBMccHfMGwET1/
 UwVtmyY/HqUiAGit8T/eWGTViNhCCSPflZdnYfCcHNKd5klyFVxcdi3aJOC+ltqPy9zA4kD+hDI
 jETp14h5HAti59PxYhgAMZlU=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 913c1005243b671d;
	Fri, 30 Oct 2026 23:34:21 +0000
X-Mizu-Trace-ID: 913c1005243b671d
X-Migadu-Flow: FLOW_OUT
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Quentin Monnet <qmo@kernel.org>
Cc: bpf@vger.kernel.org,
	Alan Maguire <alan.maguire@oracle.com>,
	Cupertino Miranda <cupertino.miranda@oracle.com>,
	David Faust <david.faust@oss.qualcomm.com>,
	Ian Rogers <irogers@google.com>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	Vineet Gupta <vineet.gupta@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH bpf-next v3 03/13] docs, libbpf: Document complete BTF annotation strings
Date: Fri, 30 Oct 2026 16:33:45 -0700
Message-ID: <20261030233355.1836749-4-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030233355.1836749-1-ihor.solodrai@linux.dev>
References: <20261030233355.1836749-1-ihor.solodrai@linux.dev>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btf_dump now prints kflagged tag strings without adding an attribute
wrapper. The BTF documentation still describes attribute-list strings.

Update the BTF reference, kfunc documentation and libbpf API comments
to match this format.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 Documentation/bpf/btf.rst    | 14 ++++++++------
 Documentation/bpf/kfuncs.rst |  3 ++-
 tools/lib/bpf/btf.c          |  6 ++++--
 3 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
index 29de1222c3e7..98c1f0440f8b 100644
--- a/Documentation/bpf/btf.rst
+++ b/Documentation/bpf/btf.rst
@@ -506,10 +506,11 @@ If ``info.kind_flag`` is 0, then this is a normal decl tag, and the
 ``name_off`` encodes btf_decl_tag attribute string.
 
 If ``info.kind_flag`` is 1, then the decl tag represents an arbitrary
-__attribute__. In this case, ``name_off`` encodes a string
-representing the attribute-list of the attribute specifier. For
-example, for an ``__attribute__((aligned(4)))`` the string's contents
-is ``aligned(4)``.
+annotation. ``name_off`` encodes the complete annotation string, which
+``btf_dump`` prints unchanged at the declaration. For example, an attribute
+specifier is encoded as ``__attribute__((aligned(4)))``, including the
+wrapper. A macro such as ``__bpf_relocatable`` can be encoded as that
+identifier, leaving its definition to the generated header or its user.
 
 2.2.18 BTF_KIND_TYPE_TAG
 ~~~~~~~~~~~~~~~~~~~~~~~~
@@ -539,8 +540,9 @@ normal type tag, and the ``name_off`` encodes btf_type_tag attribute
 string.
 
 If ``info.kind_flag`` is 1, then the type tag represents an arbitrary
-__attribute__, and the ``name_off`` encodes a string representing the
-attribute-list of the attribute specifier.
+annotation. As with decl tags, ``name_off`` encodes the complete annotation
+string, which ``btf_dump`` prints unchanged. An attribute specifier must
+include its wrapper, for example ``__attribute__((address_space(1)))``.
 
 2.2.19 BTF_KIND_ENUM64
 ~~~~~~~~~~~~~~~~~~~~~~
diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index 73578a4c3b1f..d04da2fe7dad 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -560,7 +560,8 @@ At kernel build time the ``resolve_btfids`` tool finds all kfuncs declared with
 For each kfunc it emits a ``bpf_kfunc`` BTF decl tag, a ``bpf_fastcall`` decl
 tag when the kfunc is flagged ``KF_FASTCALL``, and the ``address_space(1)`` type
 attribute on the return value and/or arguments that use arena pointers (see
-sections 2.3.8 and 2.8).
+sections 2.3.8 and 2.8). The type tag stores the complete
+``__attribute__((address_space(1)))`` specifier with ``kind_flag`` set.
 
 2.7  Specifying no-cast aliases with ___init
 --------------------------------------------
diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 47a04be0a55a..fd4f409d7847 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -3063,7 +3063,8 @@ int btf__add_type_tag(struct btf *btf, const char *value, int ref_type_id)
  * Append new BTF_KIND_TYPE_TAG type with:
  *   - *value*, non-empty/non-NULL tag value;
  *   - *ref_type_id* - referenced type ID, it might not exist yet;
- * Set info->kflag to 1, indicating this tag is an __attribute__
+ * The kind flag is set; btf_dump prints *value* unchanged.
+ * Attribute specifiers must include the __attribute__((...)) wrapper.
  * Returns:
  *   - >0, type ID of newly added BTF type;
  *   - <0, on error.
@@ -3398,7 +3399,8 @@ int btf__add_decl_tag(struct btf *btf, const char *value, int ref_type_id,
  *   - *ref_type_id* - referenced type ID, it might not exist yet;
  *   - *component_idx* - -1 for tagging reference type, otherwise struct/union
  *     member or function argument index;
- * Set info->kflag to 1, indicating this tag is an __attribute__
+ * The kind flag is set; btf_dump prints *value* unchanged.
+ * Attribute specifiers must include the __attribute__((...)) wrapper.
  * Returns:
  *   - >0, type ID of newly added BTF type;
  *   - <0, on error.
-- 
2.56.0

