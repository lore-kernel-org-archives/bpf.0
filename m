Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC8B382392;
	Thu, 21 May 2026 03:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779333869; cv=none; b=I4SGQOEC4Za/fEgdDU++46WbRHexLgO0E8gGCFWbr8B9BQUzMesYlL+bPeMsUYYbt0NoJxSmIApIaGVeEYcMqggGSa2cA4tE2/SKPerNz0igtBvcl5sy0e+ogB47VzEocFxXpMEWWjUDjxzQEXusPRcwgDMdcopPXA5xv7IUk10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779333869; c=relaxed/simple;
	bh=QF0VQigiS9C8x3qp/3dv7AfSItMP6oTWZARJW1nciTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UyvJjzSG2e5NgIsi6wZ4PnkxxDnDtaKcVH5mmZNw6S/Fi/cqRo2HwN7HDjYM1JPSCyPD8fSBBNjjnzBdPmEyvgmFmCe1GBP/HZTVGGTlqtQ8xg5mPmKcFIOMIuZx/tCEx+E8hK9BErlLov6yJbNLfEDnSFKmrCsI9lXZO9Ku/fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QbmasXAN; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QbmasXAN"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779333865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+BjQ1+jDF+nnJfG5AqBJZDyfiRu75uMNz4SpIOWGGKo=;
	b=QbmasXANKZfP06EIaUAJG9KzxtXEnieFSZCWEw2jcu6As5oo+VnFdKSq2AWeWmUCf9RM/n
	mLLDYK6UQncQyoe+aPOoc0MIxtyC+huWp2OdUtPJ1D7167bLX/8sMfqw2GXQWo9ecS29gZ
	yF8FuqsEo2mlPM4AGfIDyqCybG7Etlc=
From: Kaitao Cheng <kaitao.cheng@linux.dev>
To: ast@kernel.org,
	corbet@lwn.net,
	martin.lau@linux.dev,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	chengkaitao@kylinos.cn,
	skhan@linuxfoundation.org,
	memxor@gmail.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	vmalik@redhat.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v11 3/8] bpf: allow non-owning list-node args via __nonown_allowed
Date: Thu, 21 May 2026 11:23:01 +0800
Message-ID: <20260521032306.97118-4-kaitao.cheng@linux.dev>
In-Reply-To: <20260521032306.97118-1-kaitao.cheng@linux.dev>
References: <20260521032306.97118-1-kaitao.cheng@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Kaitao Cheng <chengkaitao@kylinos.cn>

KF_ARG_PTR_TO_LIST_NODE normally requires an owning reference
(PTR_TO_BTF_ID | MEM_ALLOC with ref_obj_id). Introduce  the
__nonown_allowed annotation on selected list-node arguments so
non-owning references with ref_obj_id==0 are accepted as well.

This patch only adds the generic verifier support and documents the
annotation. Later patches in the series will apply it to bpf_list_add
/del(), and bpf_list_is_first/last(), allowing bpf_list_front/back()
results to be used as the insertion point, deletion target, or query
target for those kfuncs.

Verifier keeps existing owning-ref checks by default; only arguments
annotated with __nonown_allowed bypass MEM_ALLOC/ref_obj_id checks
and then follow the same list-node validation path.

Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
---
 Documentation/bpf/kfuncs.rst | 22 ++++++++++++++++++++--
 kernel/bpf/verifier.c        | 13 +++++++++++++
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index 75e6c078e0e7..3a9db1108b95 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -207,8 +207,26 @@ Here, the buffer may be NULL. If the buffer is not NULL, it must be at least
 buffer__szk bytes in size. The kfunc is responsible for checking if the buffer
 is NULL before using it.
 
-2.3.5 __str Annotation
-----------------------------
+2.3.5 __nonown_allowed Annotation
+---------------------------------
+
+This annotation is used to indicate that the parameter may be a non-owning reference.
+
+An example is given below::
+
+        __bpf_kfunc int bpf_list_add(..., struct bpf_list_node
+                                     *prev__nonown_allowed, ...)
+        {
+                ...
+        }
+
+For the ``prev__nonown_allowed`` parameter (resolved as ``KF_ARG_PTR_TO_LIST_NODE``),
+suffix ``__nonown_allowed`` retains the usual owning-pointer rules and also
+permits a non-owning reference with no ref_obj_id (e.g. the return value of
+bpf_list_front() / bpf_list_back()).
+
+2.3.6 __str Annotation
+----------------------
 This annotation is used to indicate that the argument is a constant string.
 
 An example is given below::
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8dd79b735a69..f3cf8d85bea0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10714,6 +10714,11 @@ static bool is_kfunc_arg_nullable(const struct btf *btf, const struct btf_param
 	return btf_param_match_suffix(btf, arg, "__nullable");
 }
 
+static bool is_kfunc_arg_nonown_allowed(const struct btf *btf, const struct btf_param *arg)
+{
+	return btf_param_match_suffix(btf, arg, "__nonown_allowed");
+}
+
 static bool is_kfunc_arg_const_str(const struct btf *btf, const struct btf_param *arg)
 {
 	return btf_param_match_suffix(btf, arg, "__str");
@@ -12244,6 +12249,13 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				return ret;
 			break;
 		case KF_ARG_PTR_TO_LIST_NODE:
+			if (is_kfunc_arg_nonown_allowed(btf, &args[i]) &&
+			    type_is_non_owning_ref(reg->type) && !reg->ref_obj_id) {
+				/* Allow bpf_list_front/back return value for
+				 * __nonown_allowed list-node arguments.
+				 */
+				goto check_ok;
+			}
 			if (reg->type != (PTR_TO_BTF_ID | MEM_ALLOC)) {
 				verbose(env, "%s expected pointer to allocated object\n",
 					reg_arg_name(env, argno));
@@ -12253,6 +12265,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				verbose(env, "allocated object must be referenced\n");
 				return -EINVAL;
 			}
+check_ok:
 			ret = process_kf_arg_ptr_to_list_node(env, reg, argno, meta);
 			if (ret < 0)
 				return ret;
-- 
2.50.1 (Apple Git-155)

