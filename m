Received: from mail-oa2-f0.google.com (mail-oa2-f0.google.com [74.125.231.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0C6396D09
	for <bpf@vger.kernel.org>; Sun,  9 Aug 2026 08:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786265527; cv=none; b=gA0mHzDDHAJUbRuh5BLHSl0cW+FckUr6Yubk1SpcN7Z+2dE0rYvuJ6U/WqkqJw5/YaKZkSu5/ccDS7dPmHJATjTtaKcabQ61MikBvLItPI9UkIii69sqgzM1YS5gaSXTihwzFMRs8XIDgfNoHJAnaxqzWoYDNjtAuw1Vfxuu3Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786265527; c=relaxed/simple;
	bh=MLVruUOFZwQaJHIh9Cvxxf3C3T/yRq3ZCjPbzDr2ia0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c5Cv+cv268/vvIxr/G672mLgLlI+NzUCdRPWm4C0lylvlklc3KGuuZJzTrvQ9DlijB+xPPyUSzfAHqgmFSrg6iMnorQsjya249EeGAljTVc3J4uQyNkIa6RC9WLSOpkZnZUZ76q+Rlw+BXxJqQiVqmI6uYwY0EWsXYkXuW4DasE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PEs/HXiB; arc=none smtp.client-ip=74.125.231.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PEs/HXiB"
Received: by mail-oa2-f0.google.com with SMTP id 586e51a60fabf-4483c9986ceso571211fac.0
        for <bpf@vger.kernel.org>; Sun, 09 Aug 2026 01:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786265522; x=1786870322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yr6jWPfArptDksI+VWQUrGurbn19ew+I34PMw8+4Jnw=;
        b=PEs/HXiBqTxHv+rCJ8xQ6Aoqdg8xyWoEmo7bHE+g9IAFX+JgIf4wWGMwLiN23M5e0e
         xLNJfEqB1D4EjhTaAbXL/GgR4I/GANsVLGXmari6crewveHMzqxfjgMpxsnzXGnLiUnb
         dcBiCoKVcGHAa/vOplp57v4rT84KP7oDVEhNslcsmZeTdK51dCtsdrmixhIvn84hFHFE
         jrn5mrqlPwI5DD3aLZA0LnypKp5Jtfbqq9voTYr+1m3Z3C+1iZcvlLvt3akbbbyfWtoq
         2lmkVjeWMyYlxKOpVbSEqPobPnC5iI8JS60rqAETVhBK1Vse7jfHIWkV7W8v3wmTS5eG
         O2ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786265522; x=1786870322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yr6jWPfArptDksI+VWQUrGurbn19ew+I34PMw8+4Jnw=;
        b=q/1N7cXCwMU0ZqvQgKFMz/jb4jF6oCPKMfBgPS+Wg/cIMbPxffbSA123sLRgUMDiHc
         xuPTUnT4xswSGG8y/7TU4lRHGIQjDG/nnmlGc98S9HTc4AsAUENdak72L2psA8kuzE5m
         egEwEFrL95Qq8o2SMy7//BL9vobZl6T9/J2v7421PIOeBfyqNNIb/tFr+cnI8yZST9+X
         SjdvnL82WZw2fwgMNN4abp7kk5L9U2mh1WjgI5KVaEvSWKtsAUMxHV8+NDku7xSaDhzO
         AeAvD+YIdiJcEf0aUkxx2Awcf9jEI1B8uIzAF+Udje2bn/c4HX/k1xFBDM7Q7eXysxlT
         RNhQ==
X-Gm-Message-State: AOJu0Yxti4RY7SLIEIOetPNwcpd7vNqQMY26yojTNh7rhZxZQUga0kYs
	q3/EPtetwWH2wR3PMBR91aEESLejBB9g2O8Gg4la5OmUD3mxq6wy88tWrMe6swgq49k=
X-Gm-Gg: AR+sD11/x1RswUQr1DNyydK+lYwnRY0iSBjNM/RHk9R81UrDxI6jbHb29hM3i+tm65K
	pJU9drY8AFMne7yASV5MTn5+ZsNHklS7Na6/MT4vuPWCii4E8Km8dXDbRUAmf3Ifup15IwIQAwW
	/NTkNCXT5xj33Tg3s2VDngUuBKxPtpJRfpVzeUxmFFyF0nZWvNoDkmjwQMY5GdNpAZ0edEoGGsQ
	I+c2o5U1d1cPtIWnX6UeEkmcAB5+iTnxs1MTHeJ1Fk9FKuIkEahbJqPvw/23mB8ZIxme2XkuISy
	zvqfFW/QLtxX9uYHVhWSCYhb3J4HpS6PHGOmudTh3SMNho3+KNVwqmrG0UYxt2iDVLOuoRFNpfi
	Ft3BBhfEz6i0FBKccs6jC7+ALW7r1DWnU9iNuZFaf5cc7HEEbfK17afCCTxPSyGbc4kkDp7xZRn
	cumIGXuXU+z1ECccY5yNgjm61Rs3htJndIajoDpzLwdU2njkR2+dOp/b5z0B8k1wJPIO6xYG5ih
	95IP8theus7NJaRgMH7PjOXWtwzyNHek9khDCkfNio5i3cJSDxStlgtDv5wkkXAPExjtOs=
X-Received: by 2002:a4a:ec46:0:b0:6ae:4403:1c13 with SMTP id 006d021491bc7-6b04511bae6mr5376654eaf.18.1786265521837;
        Sun, 09 Aug 2026 01:52:01 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:43::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f35b563887sm5056368a34.3.2026.08.09.01.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 01:52:00 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 1/2] resolve_btfids: Emit arena attributes from kfunc parameter suffixes
Date: Sun,  9 Aug 2026 10:51:53 +0200
Message-ID: <20260809085155.3305519-2-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260809085155.3305519-1-memxor@gmail.com>
References: <20260809085155.3305519-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4921; h=from:subject; bh=MLVruUOFZwQaJHIh9Cvxxf3C3T/yRq3ZCjPbzDr2ia0=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIavCfrZsqpXxh6UfrlY43nHueTPHWLlP1W2K8v/pvgFJ8vIr f5V2lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCLenxkZVsc3zlj47dujV3wH1I7me6 hfO5U3oYo59zp700uVYpUOeYb/mQvjM2rmdK7R2S2/9GNNcvKh9Isuz0y2L//yPoFFnPEtKwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Kfunc declarations can identify arena arguments through parameter name
suffixes without repeating KF_ARENA_ARG flags in their BTF ID sets.
resolve_btfids currently misses those arguments when synthesizing the
address_space(1) attributes used by generated vmlinux.h files.

Teach the arena prototype rewrite to recognize __arena and
__arena__nullable directly on each parameter. Keep KF_ARENA_ARG1 and
KF_ARENA_ARG2 handling for explicitly flagged kfuncs, while allowing
suffixes on any argument without synthesizing kfunc flags.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/bpf/resolve_btfids/main.c | 62 ++++++++++++++++++++++++++++-----
 1 file changed, 54 insertions(+), 8 deletions(-)

diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index d2e4176339da..3c88ea192f7b 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -65,7 +65,8 @@
  *
  *   - emits a "bpf_kfunc" decl tag, and "bpf_fastcall" when KF_FASTCALL is set;
  *   - wraps the return value and/or arguments flagged KF_ARENA_RET,
- *     KF_ARENA_ARG1 or KF_ARENA_ARG2 with the "address_space(1)" type attribute;
+ *     KF_ARENA_ARG1 or KF_ARENA_ARG2, or identified by an arena parameter
+ *     suffix, with the "address_space(1)" type attribute;
  *   - rewrites the prototype of KF_IMPLICIT_ARGS kfuncs.
  *
  * These kfunc annotations were historically produced by pahole.
@@ -182,6 +183,8 @@ struct object {
 #define KF_IMPLICIT_ARGS (1 << 16)
 #define KF_IMPL_SUFFIX "_impl"
 #define TYPE_ATTR_ARENA "address_space(1)"
+#define PARAM_SUFFIX_ARENA "__arena"
+#define PARAM_SUFFIX_ARENA_NULLABLE "__arena__nullable"
 
 struct kfunc {
 	struct rb_node rb_node;
@@ -1067,6 +1070,22 @@ static int collect_decl_tags(struct btf2btf_context *ctx)
 	return 0;
 }
 
+static bool param_name_has_suffix(const char *name, const char *suffix)
+{
+	size_t name_len = strlen(name);
+	size_t suffix_len = strlen(suffix);
+
+	return name_len >= suffix_len && !strcmp(name + name_len - suffix_len, suffix);
+}
+
+static bool is_arena_param(const struct btf *btf, const struct btf_param *param)
+{
+	const char *name = btf__name_by_offset(btf, param->name_off);
+
+	return param_name_has_suffix(name, PARAM_SUFFIX_ARENA) ||
+	       param_name_has_suffix(name, PARAM_SUFFIX_ARENA_NULLABLE);
+}
+
 static int collect_kfuncs(struct object *obj, struct btf2btf_context *ctx)
 {
 	Elf_Data *idlist = obj->efile.idlist;
@@ -1299,8 +1318,12 @@ static int process_kfunc_with_implicit_args(struct btf2btf_context *ctx, struct
 	return 0;
 }
 
-static bool is_arena_arg(struct kfunc *kfunc, u32 idx)
+static bool is_arena_arg(const struct btf *btf, const struct kfunc *kfunc,
+			 const struct btf_param *param, u32 idx)
 {
+	if (is_arena_param(btf, param))
+		return true;
+
 	switch (idx) {
 	case 0:
 		return kfunc->flags & KF_ARENA_ARG1;
@@ -1311,6 +1334,30 @@ static bool is_arena_arg(struct kfunc *kfunc, u32 idx)
 	}
 }
 
+static bool kfunc_has_arena_arg(const struct btf *btf, const struct kfunc *kfunc)
+{
+	const struct btf_type *func, *proto;
+	const struct btf_param *params;
+	u32 nr_params;
+
+	func = btf__type_by_id(btf, kfunc->btf_id);
+	if (!func || !btf_is_func(func))
+		return false;
+
+	proto = btf__type_by_id(btf, func->type);
+	if (!proto || !btf_is_func_proto(proto))
+		return false;
+
+	params = btf_params(proto);
+	nr_params = btf_vlen(proto);
+	for (u32 i = 0; i < nr_params; i++) {
+		if (is_arena_arg(btf, kfunc, &params[i], i))
+			return true;
+	}
+
+	return false;
+}
+
 static s32 arena_tag_ptr(struct btf *btf, u32 ptr_id, struct kfunc *kfunc)
 {
 	const struct btf_type *ptr = btf__type_by_id(btf, ptr_id);
@@ -1383,11 +1430,10 @@ static s32 add_arena_tagged_proto(struct btf *btf, struct kfunc *kfunc)
 	}
 
 	for (i = 0; i < nr_params; i++) {
-		if (!is_arena_arg(kfunc, i))
-			continue;
-
 		t = btf__type_by_id(btf, new_proto_id);
 		params = btf_params(t);
+		if (!is_arena_arg(btf, kfunc, &params[i], i))
+			continue;
 
 		id = arena_tag_ptr(btf, params[i].type, kfunc);
 		if (id < 0)
@@ -1403,7 +1449,7 @@ static s32 add_arena_tagged_proto(struct btf *btf, struct kfunc *kfunc)
 	return new_proto_id;
 }
 
-static int process_kfunc_with_arena_flags(struct btf2btf_context *ctx,
+static int process_kfunc_with_arena_attrs(struct btf2btf_context *ctx,
 					  struct kfunc *kfunc)
 {
 	struct btf_type *t;
@@ -1463,8 +1509,8 @@ static int btf2btf(struct object *obj)
 				goto out;
 		}
 
-		if (kfunc->flags & (KF_ARENA_RET | KF_ARENA_ARG1 | KF_ARENA_ARG2)) {
-			err = process_kfunc_with_arena_flags(&ctx, kfunc);
+		if ((kfunc->flags & KF_ARENA_RET) || kfunc_has_arena_arg(ctx.btf, kfunc)) {
+			err = process_kfunc_with_arena_attrs(&ctx, kfunc);
 			if (err)
 				goto out;
 		}
-- 
2.53.0-Meta

