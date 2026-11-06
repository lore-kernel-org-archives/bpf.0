Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793995062;
	b=a4S4xpZuP+b9Q8QxK3jrB5PEbw3N1IkdgzTzlF42cuGtO1JEYVdDWqu+fsk1qhheAXhQ
	 T9CK+MEe/q7NWVJQGh9oDTFGQH+ttdyY3Y8YVko9pH4IHI9gbFkTLABfaVeZ9xQFQ0Ng0
	 QoqmmyamOeO6sZReuK7zywcYhDj4t7HUsMiDtDSyuSI/+sl0OPtM77PmMweG1vTOeLcPp
	 hWxPHFaU2Of8edktkSrVmP1FKOASr/7z0bd/VEHpYHaLypj5OTmxMdcJhyk0rxOd3AE0G
	 qjG5lmO4SQXLIexhfy3Xx88Nyoy4He84UMe1NtwoejDqE6nLriuEu68nZkn5qT0s+0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793995062;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KWnNUPb6bEp72fmGwbJyL0sLEVfPbhwGjaRgMYtWXv0=;
	b=mG8O+LkC4+roE9sPhybkauidrf2wJZXAxqYOn/7st87IDXLNnHEfr/y2V+2P4mUvP7OL
	 mYDnG5FpBi3x70cTx4RN9L/vOqqy3teuBsfsTaDDhNjG6NCKIM2zhntNnS+F3zSixX6+c
	 m8VmwRxH9GvkKAjLFd3YdcawPWLA6OUzzcCaSaDUKJEMofMvDBLMS50cY9IYQQ+dSLpZU
	 hcY3YQxR8+E3RtGoq0mMA08hDAf8ispB2L638wYuvrFTNpg0Z3u+VNNXSCAulzI/GsJUV
	 GA8AQF8Vp55V3ZAxl58bWJAzBNT7SrXKb1IlWqp62YFi46nwACXL/hYKOL9THbGyEEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=hrKu5vSn;
	arc=none smtp.remote-ip=91.218.175.158
Received: from mta0.migadu.com (out-158.mta0.migadu.com [91.218.175.158])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC55F606A330
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 19:57:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC55F606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=hrKu5vSn
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=IL+c6glJ395w5+qEWtHJDTuyg1jMQ8ZP/husk8rWqQI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793995059; v=1; x=1794599859;
 b=hrKu5vSncTemWt1PMyl+Jllt/AMNkiTcHrP61jxZjiW5vHQlkR5S4HKdCObIPUK0iU7y6d1T
 nmQHpF+wZB+smRlP7gbyJ3phnshVdOuXlxYWX/csXnhq7BQ8V9Y2s6p9I2zxkBfhBXoasA/TKAp
 +qHczXG+YGt4dsL9JuYyno5A=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id cb0fe7a4ac999ecd;
	Fri, 06 Nov 2026 19:57:39 +0000
X-Mizu-Trace-ID: cb0fe7a4ac999ecd
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
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH bpf-next v1 2/3] libbpf: Drop btf_dump details from the BTF docs
Date: Fri,  6 Nov 2026 12:57:29 -0700
Message-ID: <20261106195730.2623973-2-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106195730.2623973-1-ihor.solodrai@linux.dev>
References: <20261106195730.2623973-1-ihor.solodrai@linux.dev>
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

btf.rst describes the BTF format, but commit fbafb695c5d2 ("libbpf: Let
decl tags override how btf_dump renders type tags") and
commit 79dcfd3e36a7 ("libbpf, bpftool, resolve_btfids: Dump kflagged
BTF tags as is") added to it how btf_dump prints kflagged tags and decl
tags on type tags. The comments of btf__add_type_attr() and
btf__add_decl_attr() also prescribe what the string must contain,
though it is arbitrary text that depends on the use case.

Describe kflagged tags only as arbitrary annotations in both places.
Keep a short note on the type tag override in btf_dump.c, whose comment
pointed to btf.rst.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/CAEf4BzYqq-o8SRTWyO=J6gBnSkZa=QYuEiBNuBEVndVsVYcExg@mail.gmail.com/
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 Documentation/bpf/btf.rst | 21 ++++-----------------
 tools/lib/bpf/btf.c       |  6 ++----
 tools/lib/bpf/btf_dump.c  |  2 +-
 3 files changed, 7 insertions(+), 22 deletions(-)

diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
index 99833048de60..b618812390e4 100644
--- a/Documentation/bpf/btf.rst
+++ b/Documentation/bpf/btf.rst
@@ -506,14 +506,9 @@ If ``info.kind_flag`` is 0, then this is a normal decl tag, and the
 ``name_off`` encodes btf_decl_tag attribute string.
 
 If ``info.kind_flag`` is 1, then the decl tag represents an arbitrary
-annotation. ``name_off`` encodes the complete annotation string, which
-``btf_dump`` prints unchanged at the declaration. For example, an attribute
-specifier is encoded as ``__attribute__((aligned(4)))``, including the
-wrapper. A macro can be encoded as its identifier, leaving its definition
-to the generated header or its user.
-
-``btf_dump`` also accepts decl tags that reference a ``type_tag``, as
-described under ``BTF_KIND_TYPE_TAG``.
+annotation. ``name_off`` encodes the complete annotation string. For
+example, an attribute specifier is encoded as
+``__attribute__((aligned(4)))``, including the wrapper.
 
 2.2.18 BTF_KIND_TYPE_TAG
 ~~~~~~~~~~~~~~~~~~~~~~~~
@@ -544,15 +539,7 @@ string.
 
 If ``info.kind_flag`` is 1, then the type tag represents an arbitrary
 annotation. As with decl tags, ``name_off`` encodes the complete annotation
-string, which ``btf_dump`` prints unchanged. An attribute specifier must
-include its wrapper, for example ``__attribute__((address_space(1)))``.
-
-``btf_dump`` prints decl tags that reference a type tag, with
-``btf_decl_tag.component_idx`` of ``-1``, in place of that type tag. They
-are printed the same way as decl tags on declarations. This lets a split
-BTF built for a C dump change how the type tags of its base BTF are
-printed, without modifying the base. The kernel rejects decl tags that
-reference type tags.
+string, for example ``__attribute__((address_space(1)))``.
 
 2.2.19 BTF_KIND_ENUM64
 ~~~~~~~~~~~~~~~~~~~~~~
diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 448ee6acf519..a4bf01403a43 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -3064,8 +3064,7 @@ int btf__add_type_tag(struct btf *btf, const char *value, int ref_type_id)
  * Append new BTF_KIND_TYPE_TAG type with:
  *   - *value*, non-empty/non-NULL tag value;
  *   - *ref_type_id* - referenced type ID, it might not exist yet;
- * The kind flag is set; btf_dump prints *value* unchanged.
- * Attribute specifiers must include the __attribute__((...)) wrapper.
+ * Set info->kflag to 1, indicating this tag is an arbitrary annotation
  * Returns:
  *   - >0, type ID of newly added BTF type;
  *   - <0, on error.
@@ -3400,8 +3399,7 @@ int btf__add_decl_tag(struct btf *btf, const char *value, int ref_type_id,
  *   - *ref_type_id* - referenced type ID, it might not exist yet;
  *   - *component_idx* - -1 for tagging reference type, otherwise struct/union
  *     member or function argument index;
- * The kind flag is set; btf_dump prints *value* unchanged.
- * Attribute specifiers must include the __attribute__((...)) wrapper.
+ * Set info->kflag to 1, indicating this tag is an arbitrary annotation
  * Returns:
  *   - >0, type ID of newly added BTF type;
  *   - <0, on error.
diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index fcd97aa90589..023047214b17 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -1597,7 +1597,7 @@ static void btf_dump_emit_type_chain(struct btf_dump *d,
 			break;
 		case BTF_KIND_TYPE_TAG:
 			btf_dump_emit_mods(d, decls);
-			/* decl tags override the type tag, see btf.rst */
+			/* decl tags on the type tag are printed in its place */
 			if (btf_dump_emit_decl_tags(d, id, -1))
 				break;
 			name = btf_name_of(d, t->name_off);
-- 
2.56.0

