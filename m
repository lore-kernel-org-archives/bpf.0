Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6C938AC8A
	for <bpf@vger.kernel.org>; Sat, 12 Sep 2026 19:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789242742; cv=none; b=ni2uIuQW3ik333dc+icUAtmGkwPcU4aNkbqd4uWrZQXGixwDESLsmweyelS33aklA9vfUXvrItg751KqSv8ElITIN/uU3gMM//cvVEpsROxFW7Zz3mi97aTWpwJjo5JE4PnWXxjQfJ9qXQzygkLWLpiO+Pp9C3C7YXBb9qy1yPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789242742; c=relaxed/simple;
	bh=fQSdStJUuUeE622GrUiip5Cz3dEvlXab3k95QY+Kwc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LTRa5h91oOmpZ2QIHjmOKAGTm6FOwLfq/nFay2N9BDlBNkDabT57xppRAofg8Kri7gyzrt2hiEzPBQSfacHIiFUwoD5MtqZR06CLG4s2MaBxbs7AcAQtx7A0svWThkfligreKb9FyV01+3q7xw4KynC62xUAJXQ2ixd8TX9l5r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id D3E512A58A0CC2; Sat, 12 Sep 2026 12:52:16 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v4 04/15] bpf: Index global function arguments by argument slot
Date: Sat, 12 Sep 2026 12:52:16 -0700
Message-ID: <20260912195216.987189-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912195156.980886-1-yonghong.song@linux.dev>
References: <20260912195156.980886-1-yonghong.song@linux.dev>
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
'slots_used' walks the argument slots, and sub->arg_slot_cnt becomes the
number of slots, so that a later patch can give a parameter two of them.

No functional change: every parameter still takes exactly one slot.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/btf.c | 40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 9b0bd3898882..cdbae53bb94d 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8037,7 +8037,7 @@ int btf_prepare_func_args(struct bpf_verifier_env *=
env, int subprog)
 	const struct btf_param *args;
 	const struct btf_type *t, *ref_t, *fn_t;
 	int err;
-	u32 i, nargs, btf_id;
+	u32 i, slots_used, nargs, btf_id;
 	const char *tname;
=20
 	if (sub->args_cached)
@@ -8122,8 +8122,9 @@ int btf_prepare_func_args(struct bpf_verifier_env *=
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
@@ -8145,7 +8146,7 @@ int btf_prepare_func_args(struct bpf_verifier_env *=
env, int subprog)
 			    btf_validate_prog_ctx_type(log, btf, t, i, prog_type,
 						       prog->expected_attach_type))
 				return -EINVAL;
-			sub->args[i].arg_type =3D ARG_PTR_TO_CTX;
+			sub->args[slots_used++].arg_type =3D ARG_PTR_TO_CTX;
 			continue;
 		}
 		if (btf_is_dynptr_ptr(btf, t)) {
@@ -8153,7 +8154,7 @@ int btf_prepare_func_args(struct bpf_verifier_env *=
env, int subprog)
 				bpf_log(log, "arg#%d has invalid combination of tags\n", i);
 				return -EINVAL;
 			}
-			sub->args[i].arg_type =3D ARG_PTR_TO_DYNPTR;
+			sub->args[slots_used++].arg_type =3D ARG_PTR_TO_DYNPTR;
 			continue;
 		}
 		if (tags & ARG_TAG_TRUSTED) {
@@ -8168,10 +8169,11 @@ int btf_prepare_func_args(struct bpf_verifier_env=
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
@@ -8185,8 +8187,10 @@ int btf_prepare_func_args(struct bpf_verifier_env =
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
@@ -8202,8 +8206,9 @@ int btf_prepare_func_args(struct bpf_verifier_env *=
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
@@ -8211,7 +8216,7 @@ int btf_prepare_func_args(struct bpf_verifier_env *=
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
@@ -8231,10 +8236,11 @@ int btf_prepare_func_args(struct bpf_verifier_env=
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
@@ -8244,7 +8250,7 @@ int btf_prepare_func_args(struct bpf_verifier_env *=
env, int subprog)
 			return -EINVAL;
 		}
 		if (btf_type_is_int(t) || btf_is_any_enum(t)) {
-			sub->args[i].arg_type =3D ARG_SCALAR;
+			sub->args[slots_used++].arg_type =3D ARG_SCALAR;
 			continue;
 		}
 		if (!is_global)
@@ -8254,6 +8260,8 @@ int btf_prepare_func_args(struct bpf_verifier_env *=
env, int subprog)
 		return -EINVAL;
 	}
=20
+	sub->arg_slot_cnt =3D slots_used;
+
 	sub->args_cached =3D true;
=20
 	return 0;
--=20
2.53.0-Meta

