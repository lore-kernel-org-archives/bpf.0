Received: from mta1.migadu.com (out-113.mta1.migadu.com [95.215.58.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883E7329E5D
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 23:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790725590; cv=none; b=ST4fQNTXGMcBsYjUQPsRLteQ7exBY0e/n154LxhiyNqd44XDwj+StIjQ4+Jd7OKSo2tNHw5AAvLYgndQWSZwBeu/VXjbO6VnJFWG/SbB2jT5sNaxi6lMFaXJahGkj+FyOE7zDMe+LJmUOmNwIluJMU2KYm4qA3kP3iJEnLazZts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790725590; c=relaxed/simple;
	bh=gIkQ5QB2DvSzE68ThJLLqqPMrvwsbzSqUfYDBl13t24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FCuysc62IJcDo/gMyqPBAQSzutdH9J0F7owS2y6gFj3sRPgBPVM+rtXqekgw3ParBRyJXmCNpsdyVtDZVkq6AO/qptTEOtCBT+k9SvQ/0nzxdZC6etS0JLIG6qKD9cjQ6U8O8y6jxjYrpTEp+iHorHQIWmM516P0aSbZP+xOc2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZHZjY1E+; arc=none smtp.client-ip=95.215.58.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZHZjY1E+"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=gIkQ5QB2DvSzE68ThJLLqqPMrvwsbzSqUfYDBl13t24=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790725586; v=1; x=1791330386;
 b=ZHZjY1E+SuNbg3Zr1OoQaUv3J3VifLW76qtua+cVy+szc89woKhQlyNsKQIsVpdyKRigl2NJ
 NI//5KlXFjpVrmfsO++lVPIfWcTvHBEHpsAXoJDLhM+RCE21IRweKwidS5vWBnrDFpzLsjUr6Vi
 CFevyCnu7vAEIbRCeBdNcZck=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b8b1283a1ed25e6d;
	Tue, 29 Sep 2026 23:46:26 +0000
X-Mizu-Trace-ID: b8b1283a1ed25e6d
X-Migadu-Flow: FLOW_OUT
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org,
	Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next v2 1/5] libbpf: Walk types in btf_dump_resize(), not in mark_referenced()
Date: Tue, 29 Sep 2026 16:46:04 -0700
Message-ID: <20260929234608.48503-2-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260929234608.48503-1-ihor.solodrai@linux.dev>
References: <20260929234608.48503-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btf_dump_mark_referenced() both walks every type added since the last
resize and decides what each one references. Move the walk out to
btf_dump_resize() and hand the function one type at a time, so a second
per-type job can share the same pass instead of adding another one.

No functional change.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/lib/bpf/btf_dump.c | 122 +++++++++++++++++++--------------------
 1 file changed, 60 insertions(+), 62 deletions(-)

diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index fa995c02a170..e0293e6d3492 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -143,7 +143,7 @@ static void btf_dump_printf(const struct btf_dump *d, const char *fmt, ...)
 	va_end(args);
 }
 
-static int btf_dump_mark_referenced(struct btf_dump *d);
+static int btf_dump_mark_referenced(struct btf_dump *d, const struct btf_type *t);
 static int btf_dump_resize(struct btf_dump *d);
 
 struct btf_dump *btf_dump__new(const struct btf *btf,
@@ -195,6 +195,8 @@ struct btf_dump *btf_dump__new(const struct btf *btf,
 static int btf_dump_resize(struct btf_dump *d)
 {
 	int err, last_id = btf__type_cnt(d->btf) - 1;
+	const struct btf_type *t;
+	__u32 i;
 
 	if (last_id <= d->last_id)
 		return 0;
@@ -212,10 +214,13 @@ static int btf_dump_resize(struct btf_dump *d)
 		d->type_states[0].emit_state = EMITTED;
 	}
 
-	/* eagerly determine referenced types for anon enums */
-	err = btf_dump_mark_referenced(d);
-	if (err)
-		return err;
+	for (i = d->last_id + 1; i <= last_id; i++) {
+		t = btf__type_by_id(d->btf, i);
+
+		err = btf_dump_mark_referenced(d, t);
+		if (err)
+			return err;
+	}
 
 	d->last_id = last_id;
 	return 0;
@@ -312,71 +317,64 @@ int btf_dump__dump_type(struct btf_dump *d, __u32 id)
  * top-level anonymous enum won't be referenced by anything, while embedded
  * one will.
  */
-static int btf_dump_mark_referenced(struct btf_dump *d)
+static int btf_dump_mark_referenced(struct btf_dump *d, const struct btf_type *t)
 {
-	int i, j, n = btf__type_cnt(d->btf);
-	const struct btf_type *t;
-	__u32 vlen;
+	__u32 j, vlen = btf_vlen(t);
 
-	for (i = d->last_id + 1; i < n; i++) {
-		t = btf__type_by_id(d->btf, i);
-		vlen = btf_vlen(t);
-
-		switch (btf_kind(t)) {
-		case BTF_KIND_INT:
-		case BTF_KIND_ENUM:
-		case BTF_KIND_ENUM64:
-		case BTF_KIND_FWD:
-		case BTF_KIND_FLOAT:
-		case BTF_KIND_LOC_PARAM:
-		case BTF_KIND_LOC_PROTO:
-		case BTF_KIND_LOCSEC:
-			break;
+	switch (btf_kind(t)) {
+	case BTF_KIND_INT:
+	case BTF_KIND_ENUM:
+	case BTF_KIND_ENUM64:
+	case BTF_KIND_FWD:
+	case BTF_KIND_FLOAT:
+	case BTF_KIND_LOC_PARAM:
+	case BTF_KIND_LOC_PROTO:
+	case BTF_KIND_LOCSEC:
+		break;
 
-		case BTF_KIND_VOLATILE:
-		case BTF_KIND_CONST:
-		case BTF_KIND_RESTRICT:
-		case BTF_KIND_PTR:
-		case BTF_KIND_TYPEDEF:
-		case BTF_KIND_FUNC:
-		case BTF_KIND_VAR:
-		case BTF_KIND_DECL_TAG:
-		case BTF_KIND_TYPE_TAG:
-			d->type_states[t->type].referenced = 1;
-			break;
+	case BTF_KIND_VOLATILE:
+	case BTF_KIND_CONST:
+	case BTF_KIND_RESTRICT:
+	case BTF_KIND_PTR:
+	case BTF_KIND_TYPEDEF:
+	case BTF_KIND_FUNC:
+	case BTF_KIND_VAR:
+	case BTF_KIND_DECL_TAG:
+	case BTF_KIND_TYPE_TAG:
+		d->type_states[t->type].referenced = 1;
+		break;
 
-		case BTF_KIND_ARRAY: {
-			const struct btf_array *a = btf_array(t);
+	case BTF_KIND_ARRAY: {
+		const struct btf_array *a = btf_array(t);
 
-			d->type_states[a->index_type].referenced = 1;
-			d->type_states[a->type].referenced = 1;
-			break;
-		}
-		case BTF_KIND_STRUCT:
-		case BTF_KIND_UNION: {
-			const struct btf_member *m = btf_members(t);
+		d->type_states[a->index_type].referenced = 1;
+		d->type_states[a->type].referenced = 1;
+		break;
+	}
+	case BTF_KIND_STRUCT:
+	case BTF_KIND_UNION: {
+		const struct btf_member *m = btf_members(t);
 
-			for (j = 0; j < vlen; j++, m++)
-				d->type_states[m->type].referenced = 1;
-			break;
-		}
-		case BTF_KIND_FUNC_PROTO: {
-			const struct btf_param *p = btf_params(t);
+		for (j = 0; j < vlen; j++, m++)
+			d->type_states[m->type].referenced = 1;
+		break;
+	}
+	case BTF_KIND_FUNC_PROTO: {
+		const struct btf_param *p = btf_params(t);
 
-			for (j = 0; j < vlen; j++, p++)
-				d->type_states[p->type].referenced = 1;
-			break;
-		}
-		case BTF_KIND_DATASEC: {
-			const struct btf_var_secinfo *v = btf_var_secinfos(t);
+		for (j = 0; j < vlen; j++, p++)
+			d->type_states[p->type].referenced = 1;
+		break;
+	}
+	case BTF_KIND_DATASEC: {
+		const struct btf_var_secinfo *v = btf_var_secinfos(t);
 
-			for (j = 0; j < vlen; j++, v++)
-				d->type_states[v->type].referenced = 1;
-			break;
-		}
-		default:
-			return -EINVAL;
-		}
+		for (j = 0; j < vlen; j++, v++)
+			d->type_states[v->type].referenced = 1;
+		break;
+	}
+	default:
+		return -EINVAL;
 	}
 	return 0;
 }
-- 
2.50.1

