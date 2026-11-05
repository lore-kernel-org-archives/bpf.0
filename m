Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.28
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793901599;
	b=ezxpGTB+ovRSbD10uLECkWGd3SPVOuOKkarq91sTCCu+wEbcP+mFX0qFans5yoSWDESY
	 RTniUF8OTzhTf+rDw0sS5BHvbefJ0Wo2Fb7MuoYveB4yynpTyN4VphnytehMa6kPkXKoc
	 FeAAkX9I0Tn7PZ6vhQNseam2JZCHf2ISaas0oofxWQ5gx59PQXSdX1xB/6U9EyGFFAPjy
	 TqXHM8sHnYwQAHyE8Wj+yPhN5EqB+jpPY9i23l7AivYINLfFHG7LyWl+R98m0A0uncxj8
	 TaiwLuHMuX2AVONTxE3Z5PC6FglGZ+U3QgIP6ThfE7zwW49SoBt9gO6MpV8HaIO2TtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793901599;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6IWKhOcJ311Kl0oND0XT8dSKjHhVGcBEPTXBtqpj3RM=;
	b=sQfTiqGPnv5H1h7AhaQ1Ua8viJ32dQq66CsBZSu2/rSJPSj4BKpgxREDU2wnpRc1KKIl
	 BI9vRu03PtY0AvNfESng/po65YGUX0+TaUk69NBvRDrG3R/cBZHKDtKUqtJnjuuAL0XNb
	 GrNgW97CZzknH4Fhwi6MQmXleb6iTaxjiFe1JZ8zpZ0Q0sYeCfg0BIJ4C++VO8SwKxzGw
	 CGBNyCC+ZlclvMf9ylVkWzYZIr3rwjhto76zEXGrGoNIydW/DttV9XddlEAx0DYU73shG
	 rWHQ6dxGuMvdiu+zF5Iip8xso8VYko+KWmXW+2K72ef5zh3fBj8hDB1QRCAJb6Zf6wQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="m8/wVlx3";
	arc=none smtp.remote-ip=95.215.58.28
Received: from mta1.migadu.com (out-28.mta1.migadu.com [95.215.58.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F56606D81D
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 17:59:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7F56606D81D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=m8/wVlx3
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=JmT2mjkVFUXv2G8S6Uk2iklxHtc7hqdjBKkXLTgtmo8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793901597; v=1; x=1794506397;
 b=m8/wVlx3b4l9alEsIb28KPoj25itIulcHtpphLZ0zj1qhb/3UkNMLf3Hw1n9ZEIMf054FxSa
 hLqaBVYullWkT0eLLS2fJY+w3zoJZdvk9dldtIFkKiwDmMT0fEyYVAuamjPDcphagAQklQ6/Lhz
 ISOqGi/IrGIN7ePVQUm2UkFU=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 8b24ecac5d5d89bc;
	Thu, 05 Nov 2026 17:59:57 +0000
X-Mizu-Trace-ID: 8b24ecac5d5d89bc
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
Subject: [PATCH bpf-next v4 06/17] libbpf: Let decl tags override how btf_dump renders type tags
Date: Thu,  5 Nov 2026 10:58:34 -0700
Message-ID: <20261105175845.30357-7-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105175845.30357-1-ihor.solodrai@linux.dev>
References: <20261105175845.30357-1-ihor.solodrai@linux.dev>
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

A tool that dumps C from kernel BTF may need a type tag printed
differently than btf_dump prints it by default, for example as a macro
that the generated header defines. The tool can't change the tag
itself: kernel BTF must keep the encoding the kernel expects, and if
the dumped BTF is the base of a split, a type in the base can't refer
to a type added to the split.

A decl tag annotates another type by referencing it, so a split can
attach one to a type tag of its base.

Let such decl tags override the rendering of the type tag: when a type
tag has decl tags with component_idx -1, print them in its place, the
same way as decl tags on declarations. The tool that builds the dumped
BTF then decides how each type tag is rendered.

The kernel rejects decl tags on type tags, so kernel BTF cannot have
any, and its C dumps are unchanged.

Document this in btf.rst.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 Documentation/bpf/btf.rst | 10 ++++++++++
 tools/lib/bpf/btf_dump.c  | 12 ++++++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
index 29de1222c3e7..ea0d699749af 100644
--- a/Documentation/bpf/btf.rst
+++ b/Documentation/bpf/btf.rst
@@ -511,6 +511,9 @@ representing the attribute-list of the attribute specifier. For
 example, for an ``__attribute__((aligned(4)))`` the string's contents
 is ``aligned(4)``.
 
+``btf_dump`` also accepts decl tags that reference a ``type_tag``, as
+described under ``BTF_KIND_TYPE_TAG``.
+
 2.2.18 BTF_KIND_TYPE_TAG
 ~~~~~~~~~~~~~~~~~~~~~~~~
 
@@ -542,6 +545,13 @@ If ``info.kind_flag`` is 1, then the type tag represents an arbitrary
 __attribute__, and the ``name_off`` encodes a string representing the
 attribute-list of the attribute specifier.
 
+``btf_dump`` prints decl tags that reference a type tag, with
+``btf_decl_tag.component_idx`` of ``-1``, in place of that type tag. They
+are printed the same way as decl tags on declarations. This lets a split
+BTF built for a C dump change how the type tags of its base BTF are
+printed, without modifying the base. The kernel rejects decl tags that
+reference type tags.
+
 2.2.19 BTF_KIND_ENUM64
 ~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index ad43bbd3b442..c12c3c248407 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -1033,10 +1033,11 @@ static void btf_dump_emit_decl_tag(struct btf_dump *d, const struct btf_type *t)
  * tags of one type form a run that binary search finds the start of, in a
  * fixed order so that the same BTF always renders the same C.
  */
-static void btf_dump_emit_decl_tags(struct btf_dump *d, __u32 id, int comp_idx)
+static int btf_dump_emit_decl_tags(struct btf_dump *d, __u32 id, int comp_idx)
 {
 	size_t i, lo = 0, hi = d->decl_tag_cnt, mid;
 	const struct btf_type *t;
+	int cnt = 0;
 
 	/* lower bound on target_id */
 	while (lo < hi) {
@@ -1051,9 +1052,13 @@ static void btf_dump_emit_decl_tags(struct btf_dump *d, __u32 id, int comp_idx)
 	for (i = lo; i < d->decl_tag_cnt && d->decl_tags[i].target_id == id; i++) {
 		t = btf__type_by_id(d->btf, d->decl_tags[i].tag_id);
 
-		if (btf_decl_tag(t)->component_idx == comp_idx)
+		if (btf_decl_tag(t)->component_idx == comp_idx) {
 			btf_dump_emit_decl_tag(d, t);
+			cnt++;
+		}
 	}
+
+	return cnt;
 }
 
 static void btf_dump_emit_struct_def(struct btf_dump *d,
@@ -1592,6 +1597,9 @@ static void btf_dump_emit_type_chain(struct btf_dump *d,
 			break;
 		case BTF_KIND_TYPE_TAG:
 			btf_dump_emit_mods(d, decls);
+			/* decl tags override the type tag, see btf.rst */
+			if (btf_dump_emit_decl_tags(d, id, -1))
+				break;
 			name = btf_name_of(d, t->name_off);
 			if (btf_kflag(t))
 				btf_dump_printf(d, " __attribute__((%s))", name);
-- 
2.56.0

