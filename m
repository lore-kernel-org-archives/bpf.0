Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFC3366557;
	Wed,  1 Jul 2026 06:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782887158; cv=none; b=m+pRrx4x9Mb6Mw+r6M0SXng3XkPCBXcfJ+OvzOQcuR6lN1tD3+hn6BT75bhvJgsIVfRgIX9pplejRkzdkvfgaX85c8c0i3LM9Rm1e6UC6q5b5XQo7+u1zw9cXdJ5aZWbuRw/oQGEejk/hP4ysqp+0nCLUBvoBen77G1BNylffYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782887158; c=relaxed/simple;
	bh=rRJBOszUF5zgA2bNlAYXiVQ6ipIJ/YyIR3IkKevTY1Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BZow4i5PCJ4mhkatrBl/Du4MRJWgfjSZDmhB+PxrcEtqY7rBQ4oZsJ2+CmQS6xchhkPRCwe80TJjUwN65fMNtjqLztISOSjSJ0NPJDbnGuS6oM8vPwep9yNGLLC5bRPqn2flE8FRmh/tan+HI/56gxYV0o+Eafmk1W558fKgrcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: b3549cba751511f1aa26b74ffac11d73-20260701
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:7595b04d-229d-4a7d-98c8-a101f6698cbc,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:e7bac3a,CLOUDID:24dc7bd71a7aad85b93927ad318a7249,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|123|850|865|898,TC:nil,Content:0|15|
	50,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,
	OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b3549cba751511f1aa26b74ffac11d73-20260701
X-User: luoliang@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <luoliang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1126178601; Wed, 01 Jul 2026 14:25:48 +0800
From: luoliang@kylinos.cn
To: Quentin Monnet <qmo@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liang Luo <luoliang@kylinos.cn>
Subject: [PATCH] bpftool: use btf_vlen()/btf_kind()/btf_kflag() helpers consistently
Date: Wed,  1 Jul 2026 14:25:41 +0800
Message-Id: <20260701062541.704792-1-luoliang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: luoliang <luoliang@kylinos.cn>

The btf_vlen(), btf_kind() and btf_kflag() inline helpers defined in
tools/lib/bpf/btf.h are thin wrappers around the BTF_INFO_VLEN(),
BTF_INFO_KIND() and BTF_INFO_KFLAG() UAPI macros - each one simply
returns the corresponding macro applied to t->info.

bpftool already uses these helpers in most places, but 13 call sites
in btf.c and btf_dumper.c still open-code the raw macros. Use the
helpers consistently, matching the rest of bpftool as well as libbpf.

No functional change.

Signed-off-by: Liang Luo <luoliang@kylinos.cn>
---
 tools/bpf/bpftool/btf.c        | 12 ++++++------
 tools/bpf/bpftool/btf_dumper.c | 14 +++++++-------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index 6ef908adf3a4..24e4cb600b3f 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -179,7 +179,7 @@ static int dump_btf_type(const struct btf *btf, __u32 id,
 	case BTF_KIND_STRUCT:
 	case BTF_KIND_UNION: {
 		const struct btf_member *m = (const void *)(t + 1);
-		__u32 i, vlen = BTF_INFO_VLEN(t->info);
+		__u32 i, vlen = btf_vlen(t);
 
 		if (json_output) {
 			jsonw_uint_field(w, "size", t->size);
@@ -193,7 +193,7 @@ static int dump_btf_type(const struct btf *btf, __u32 id,
 			const char *name = btf_str(btf, m->name_off);
 			__u32 bit_off, bit_sz;
 
-			if (BTF_INFO_KFLAG(t->info)) {
+			if (btf_kflag(t)) {
 				bit_off = BTF_MEMBER_BIT_OFFSET(m->offset);
 				bit_sz = BTF_MEMBER_BITFIELD_SIZE(m->offset);
 			} else {
@@ -224,7 +224,7 @@ static int dump_btf_type(const struct btf *btf, __u32 id,
 	}
 	case BTF_KIND_ENUM: {
 		const struct btf_enum *v = (const void *)(t + 1);
-		__u32 i, vlen = BTF_INFO_VLEN(t->info);
+		__u32 i, vlen = btf_vlen(t);
 		const char *encoding;
 
 		encoding = btf_kflag(t) ? "SIGNED" : "UNSIGNED";
@@ -300,7 +300,7 @@ static int dump_btf_type(const struct btf *btf, __u32 id,
 		break;
 	}
 	case BTF_KIND_FWD: {
-		const char *fwd_kind = BTF_INFO_KFLAG(t->info) ? "union"
+		const char *fwd_kind = btf_kflag(t) ? "union"
 							       : "struct";
 
 		if (json_output)
@@ -322,7 +322,7 @@ static int dump_btf_type(const struct btf *btf, __u32 id,
 	}
 	case BTF_KIND_FUNC_PROTO: {
 		const struct btf_param *p = (const void *)(t + 1);
-		__u32 i, vlen = BTF_INFO_VLEN(t->info);
+		__u32 i, vlen = btf_vlen(t);
 
 		if (json_output) {
 			jsonw_uint_field(w, "ret_type_id", t->type);
@@ -365,7 +365,7 @@ static int dump_btf_type(const struct btf *btf, __u32 id,
 	case BTF_KIND_DATASEC: {
 		const struct btf_var_secinfo *v = (const void *)(t + 1);
 		const struct btf_type *vt;
-		__u32 i, vlen = BTF_INFO_VLEN(t->info);
+		__u32 i, vlen = btf_vlen(t);
 
 		if (json_output) {
 			jsonw_uint_field(w, "size", t->size);
diff --git a/tools/bpf/bpftool/btf_dumper.c b/tools/bpf/bpftool/btf_dumper.c
index 9dc8425b1789..e4075824343f 100644
--- a/tools/bpf/bpftool/btf_dumper.c
+++ b/tools/bpf/bpftool/btf_dumper.c
@@ -476,8 +476,8 @@ static int btf_dumper_struct(const struct btf_dumper *d, __u32 type_id,
 	if (!t)
 		return -EINVAL;
 
-	kind_flag = BTF_INFO_KFLAG(t->info);
-	vlen = BTF_INFO_VLEN(t->info);
+	kind_flag = btf_kflag(t);
+	vlen = btf_vlen(t);
 	jsonw_start_object(d->jw);
 	m = (struct btf_member *)(t + 1);
 
@@ -535,7 +535,7 @@ static int btf_dumper_datasec(const struct btf_dumper *d, __u32 type_id,
 	if (!t)
 		return -EINVAL;
 
-	vlen = BTF_INFO_VLEN(t->info);
+	vlen = btf_vlen(t);
 	vsi = (struct btf_var_secinfo *)(t + 1);
 
 	jsonw_start_object(d->jw);
@@ -557,7 +557,7 @@ static int btf_dumper_do_type(const struct btf_dumper *d, __u32 type_id,
 {
 	const struct btf_type *t = btf__type_by_id(d->btf, type_id);
 
-	switch (BTF_INFO_KIND(t->info)) {
+	switch (btf_kind(t)) {
 	case BTF_KIND_INT:
 		return btf_dumper_int(t, bit_offset, data, d->jw,
 				     d->is_plain_text);
@@ -631,7 +631,7 @@ static int __btf_dumper_type_only(const struct btf *btf, __u32 type_id,
 
 	t = btf__type_by_id(btf, type_id);
 
-	switch (BTF_INFO_KIND(t->info)) {
+	switch (btf_kind(t)) {
 	case BTF_KIND_INT:
 	case BTF_KIND_TYPEDEF:
 	case BTF_KIND_FLOAT:
@@ -661,7 +661,7 @@ static int __btf_dumper_type_only(const struct btf *btf, __u32 type_id,
 		break;
 	case BTF_KIND_FWD:
 		BTF_PRINT_ARG("%s %s ",
-			      BTF_INFO_KFLAG(t->info) ? "union" : "struct",
+			      btf_kflag(t) ? "union" : "struct",
 			      btf__name_by_offset(btf, t->name_off));
 		break;
 	case BTF_KIND_VOLATILE:
@@ -718,7 +718,7 @@ static int btf_dump_func(const struct btf *btf, char *func_sig,
 		BTF_PRINT_ARG("%s(", btf__name_by_offset(btf, func->name_off));
 	else
 		BTF_PRINT_ARG("(");
-	vlen = BTF_INFO_VLEN(func_proto->info);
+	vlen = btf_vlen(func_proto);
 	for (i = 0; i < vlen; i++) {
 		struct btf_param *arg = &((struct btf_param *)(func_proto + 1))[i];
 
-- 
2.43.0

