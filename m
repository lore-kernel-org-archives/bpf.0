Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C683F9F2F
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 05:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788498621; cv=none; b=RULjtNamkfw3g+B8mZKC11Laqs3MpQQG/un8IglFQx+tS109Zhyn2CxiAQVocV9T8z7RDcSsb4aYCk1JkvTSLHPvbygLAKWEZ+fkEhgPIuVOZSGQ9qfXmtachl8ilgzNCJJRajE8a6LCLwqXPFUAPYko4ExjLpnY8LUJWPUIPcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788498621; c=relaxed/simple;
	bh=5D5WSHOA5xjxq7zzW8ZjqP9GEgHQgR+QOIjHwSNa0ao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pKPjRtVJCIPfX+Al/We4I+nU0QBAo2mJ9VpY5MiITUdxbF+gHXX6DG85RpjzUGMo+aHpU5lZ5zXHOrsTQ+cGZubS1uCtPsQRV8wo1PfTGe6Us+LpkOXbui3oegeQVJ81oAs5whpLJggnwK8G3JjmX92padTqdm8rrdQsqjqQzWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id EABEC2881316B6; Thu,  3 Sep 2026 22:10:07 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next 02/12] bpf: Index global function arguments by argument slot
Date: Thu,  3 Sep 2026 22:10:07 -0700
Message-ID: <20260904051007.3977886-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904050957.3976119-1-yonghong.song@linux.dev>
References: <20260904050957.3976119-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

btf_prepare_func_args() indexes sub->args[] by BTF parameter, so a
parameter can only ever stand for a single argument register. Give the
loop a second index: 'i' keeps walking the BTF parameters while
'slots_used' walks the argument slots, and sub->arg_cnt becomes the
number of slots, so that a later patch can give a parameter two of them.

No functional change: every parameter still takes exactly one slot.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/btf.c | 40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 9c2cab08bb79..22828b489b77 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8015,7 +8015,7 @@ int btf_prepare_func_args(struct bpf_verifier_env *=
env, int subprog)
 	const struct btf_param *args;
 	const struct btf_type *t, *ref_t, *fn_t;
 	int err;
-	u32 i, nargs, btf_id;
+	u32 i, slots_used, nargs, btf_id;
 	const char *tname;
=20
 	if (sub->args_cached)
@@ -8100,8 +8100,9 @@ int btf_prepare_func_args(struct bpf_verifier_env *=
env, int subprog)
 	/* Convert BTF function arguments into verifier types.
 	 * Only PTR_TO_CTX and SCALAR are supported atm.
 	 */
-	for (i =3D 0; i < nargs; i++) {
+	for (i =3D 0, slots_used =3D 0; i < nargs; i++) {
 		u32 tags =3D 0;
+
 		err =3D btf_scan_decl_tags(env, btf, fn_t, i, is_global, &tags);
 		if (err)
 			return err;
@@ -8123,7 +8124,7 @@ int btf_prepare_func_args(struct bpf_verifier_env *=
env, int subprog)
 			    btf_validate_prog_ctx_type(log, btf, t, i, prog_type,
 						       prog->expected_attach_type))
 				return -EINVAL;
-			sub->args[i].arg_type =3D ARG_PTR_TO_CTX;
+			sub->args[slots_used++].arg_type =3D ARG_PTR_TO_CTX;
 			continue;
 		}
 		if (btf_is_dynptr_ptr(btf, t)) {
@@ -8131,7 +8132,7 @@ int btf_prepare_func_args(struct bpf_verifier_env *=
env, int subprog)
 				bpf_log(log, "arg#%d has invalid combination of tags\n", i);
 				return -EINVAL;
 			}
-			sub->args[i].arg_type =3D ARG_PTR_TO_DYNPTR;
+			sub->args[slots_used++].arg_type =3D ARG_PTR_TO_DYNPTR;
 			continue;
 		}
 		if (tags & ARG_TAG_TRUSTED) {
@@ -8146,10 +8147,11 @@ int btf_prepare_func_args(struct bpf_verifier_env=
 *env, int subprog)
 			if (kern_type_id < 0)
 				return kern_type_id;
=20
-			sub->args[i].arg_type =3D ARG_PTR_TO_BTF_ID | PTR_TRUSTED;
+			sub->args[slots_used].arg_type =3D ARG_PTR_TO_BTF_ID | PTR_TRUSTED;
 			if (tags & ARG_TAG_NULLABLE)
-				sub->args[i].arg_type |=3D PTR_MAYBE_NULL;
-			sub->args[i].btf_id =3D kern_type_id;
+				sub->args[slots_used].arg_type |=3D PTR_MAYBE_NULL;
+			sub->args[slots_used].btf_id =3D kern_type_id;
+			slots_used++;
 			continue;
 		}
 		if (tags & ARG_TAG_UNTRUSTED) {
@@ -8163,8 +8165,10 @@ int btf_prepare_func_args(struct bpf_verifier_env =
*env, int subprog)
=20
 			ref_t =3D btf_type_skip_modifiers(btf, t->type, NULL);
 			if (btf_type_is_void(ref_t) || btf_type_is_primitive(ref_t)) {
-				sub->args[i].arg_type =3D ARG_PTR_TO_MEM | MEM_RDONLY | PTR_UNTRUSTE=
D;
-				sub->args[i].mem_size =3D 0;
+				sub->args[slots_used].arg_type =3D ARG_PTR_TO_MEM | MEM_RDONLY |
+								 PTR_UNTRUSTED;
+				sub->args[slots_used].mem_size =3D 0;
+				slots_used++;
 				continue;
 			}
=20
@@ -8180,8 +8184,9 @@ int btf_prepare_func_args(struct bpf_verifier_env *=
env, int subprog)
 					i, btf_type_str(ref_t), tname);
 				return -EINVAL;
 			}
-			sub->args[i].arg_type =3D ARG_PTR_TO_BTF_ID | PTR_UNTRUSTED;
-			sub->args[i].btf_id =3D kern_type_id;
+			sub->args[slots_used].arg_type =3D ARG_PTR_TO_BTF_ID | PTR_UNTRUSTED;
+			sub->args[slots_used].btf_id =3D kern_type_id;
+			slots_used++;
 			continue;
 		}
 		if (tags & ARG_TAG_ARENA) {
@@ -8189,7 +8194,7 @@ int btf_prepare_func_args(struct bpf_verifier_env *=
env, int subprog)
 				bpf_log(log, "arg#%d arena cannot be combined with any other tags\n"=
, i);
 				return -EINVAL;
 			}
-			sub->args[i].arg_type =3D ARG_PTR_TO_ARENA;
+			sub->args[slots_used++].arg_type =3D ARG_PTR_TO_ARENA;
 			continue;
 		}
 		if (is_global) { /* generic user data pointer */
@@ -8209,10 +8214,11 @@ int btf_prepare_func_args(struct bpf_verifier_env=
 *env, int subprog)
 				return -EINVAL;
 			}
=20
-			sub->args[i].arg_type =3D ARG_PTR_TO_MEM | PTR_MAYBE_NULL;
+			sub->args[slots_used].arg_type =3D ARG_PTR_TO_MEM | PTR_MAYBE_NULL;
 			if (tags & ARG_TAG_NONNULL)
-				sub->args[i].arg_type &=3D ~PTR_MAYBE_NULL;
-			sub->args[i].mem_size =3D mem_size;
+				sub->args[slots_used].arg_type &=3D ~PTR_MAYBE_NULL;
+			sub->args[slots_used].mem_size =3D mem_size;
+			slots_used++;
 			continue;
 		}
=20
@@ -8222,7 +8228,7 @@ int btf_prepare_func_args(struct bpf_verifier_env *=
env, int subprog)
 			return -EINVAL;
 		}
 		if (btf_type_is_int(t) || btf_is_any_enum(t)) {
-			sub->args[i].arg_type =3D ARG_ANYTHING;
+			sub->args[slots_used++].arg_type =3D ARG_ANYTHING;
 			continue;
 		}
 		if (!is_global)
@@ -8232,6 +8238,8 @@ int btf_prepare_func_args(struct bpf_verifier_env *=
env, int subprog)
 		return -EINVAL;
 	}
=20
+	sub->arg_cnt =3D slots_used;
+
 	sub->args_cached =3D true;
=20
 	return 0;
--=20
2.53.0-Meta

