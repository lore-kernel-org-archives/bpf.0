Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA693DB620
	for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 16:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777309195; cv=none; b=UzRQlqKwCKP9v+2gJSmU62kOmfMObMTH7W2ngEIRFjVJQGKZoEQjUw4PddVk28CETFDtMP+ZABD9l4kf3SpRH/AexTJS3I1cC/9eHh7V3LXLIF85zln3usOTPtzOxiXiuWK8V2nsSY4YY+WYSZXe0+660QvEg6EtJ62yDWyBKCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777309195; c=relaxed/simple;
	bh=3/dhJ8s/gTLp5FfI4tzFmnbnLZHdbFW3dNsyriiTHY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IBBXeMg8v+j1483VPBQ5qjECtCpghwHvo/lUeTdklAqBcYnp5+N5AYW1y1KrNJue1YLMh4EhyrIMClOENtf9fs2pSla3KmlMjv55iumBez2KdKT/kem2XM6evvP9N4Ip/OTP7eaV8DWSM2sMgQeTScZ7aQ+mQKQC6UsWGNpRQ5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ugsZeunf; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ugsZeunf"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777309191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l40L11oPsTEKSxgVhQkbOKoDGaw16jzWQ7998spksOs=;
	b=ugsZeunfRcjM5dEFHrzb6qVR/jNpprj1fTtKN5JZXkTxbcqK6psEfn0qNboXh21AKaWGJN
	JIpJTNJLCgf6/dx3BgWWT2khdXwpayc5dN5TR4dueYSC30jXR3ufmHq8/zVR4dBJc8ibdw
	akd2XK38mCL3FvmFxmOeNj3iQ3dHmz4=
From: Kaitao cheng <kaitao.cheng@linux.dev>
To: martin.lau@linux.dev,
	ast@kernel.org,
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
	linux-kselftest@vger.kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v10 7/8] bpf: allow non-owning list-node args via __nonown_allowed
Date: Tue, 28 Apr 2026 00:59:05 +0800
Message-ID: <20260427165906.84420-8-kaitao.cheng@linux.dev>
In-Reply-To: <20260427165906.84420-1-kaitao.cheng@linux.dev>
References: <20260427165906.84420-1-kaitao.cheng@linux.dev>
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
(PTR_TO_BTF_ID | MEM_ALLOC with ref_obj_id). Introduce and use
the __nonown_allowed annotation on selected list-node arguments
so non-owning references with ref_obj_id==0 are accepted as well.

This enables passing bpf_list_front() / bpf_list_back() results to:

bpf_list_add() as insertion point (prev)
bpf_list_del() as deletion target (node)
bpf_list_is_first/last() as query target (node)

Verifier keeps existing owning-ref checks by default; only arguments
annotated with __nonown_allowed bypass MEM_ALLOC/ref_obj_id checks
and then follow the same list-node validation path.

Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
---
 Documentation/bpf/kfuncs.rst | 22 ++++++++++++++++++++--
 kernel/bpf/helpers.c         | 20 +++++++++++---------
 kernel/bpf/verifier.c        | 13 +++++++++++++
 3 files changed, 44 insertions(+), 11 deletions(-)

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
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index dfd465badd9d..f2f8705f0e9a 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2571,10 +2571,10 @@ __bpf_kfunc int bpf_list_push_back_impl(struct bpf_list_head *head,
 }
 
 __bpf_kfunc int bpf_list_add(struct bpf_list_head *head, struct bpf_list_node *new,
-			     struct bpf_list_node *prev, struct btf_struct_meta *meta,
-			     u64 off)
+			     struct bpf_list_node *prev__nonown_allowed,
+			     struct btf_struct_meta *meta, u64 off)
 {
-	struct bpf_list_node_kern *n = (void *)new, *p = (void *)prev;
+	struct bpf_list_node_kern *n = (void *)new, *p = (void *)prev__nonown_allowed;
 	struct list_head *prev_ptr = &p->list_head;
 
 	return __bpf_list_add(n, head, &prev_ptr, meta ? meta->record : NULL, off);
@@ -2620,9 +2620,9 @@ __bpf_kfunc struct bpf_list_node *bpf_list_pop_back(struct bpf_list_head *head)
 }
 
 __bpf_kfunc struct bpf_list_node *bpf_list_del(struct bpf_list_head *head,
-					       struct bpf_list_node *node)
+				struct bpf_list_node *node__nonown_allowed)
 {
-	struct bpf_list_node_kern *kn = (void *)node;
+	struct bpf_list_node_kern *kn = (void *)node__nonown_allowed;
 
 	/* verifier guarantees node is a list node rather than list head */
 	return __bpf_list_del(head, &kn->list_head);
@@ -2648,10 +2648,11 @@ __bpf_kfunc struct bpf_list_node *bpf_list_back(struct bpf_list_head *head)
 	return (struct bpf_list_node *)h->prev;
 }
 
-__bpf_kfunc bool bpf_list_is_first(struct bpf_list_head *head, struct bpf_list_node *node)
+__bpf_kfunc bool bpf_list_is_first(struct bpf_list_head *head,
+				   struct bpf_list_node *node__nonown_allowed)
 {
 	struct list_head *h = (struct list_head *)head;
-	struct bpf_list_node_kern *kn = (struct bpf_list_node_kern *)node;
+	struct bpf_list_node_kern *kn = (struct bpf_list_node_kern *)node__nonown_allowed;
 
 	if (READ_ONCE(kn->owner) != head)
 		return false;
@@ -2659,10 +2660,11 @@ __bpf_kfunc bool bpf_list_is_first(struct bpf_list_head *head, struct bpf_list_n
 	return list_is_first(&kn->list_head, h);
 }
 
-__bpf_kfunc bool bpf_list_is_last(struct bpf_list_head *head, struct bpf_list_node *node)
+__bpf_kfunc bool bpf_list_is_last(struct bpf_list_head *head,
+				  struct bpf_list_node *node__nonown_allowed)
 {
 	struct list_head *h = (struct list_head *)head;
-	struct bpf_list_node_kern *kn = (struct bpf_list_node_kern *)node;
+	struct bpf_list_node_kern *kn = (struct bpf_list_node_kern *)node__nonown_allowed;
 
 	if (READ_ONCE(kn->owner) != head)
 		return false;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ca33f35bc3eb..08ab337866bf 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10502,6 +10502,11 @@ static bool is_kfunc_arg_nullable(const struct btf *btf, const struct btf_param
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
@@ -12017,6 +12022,13 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
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
@@ -12026,6 +12038,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				verbose(env, "allocated object must be referenced\n");
 				return -EINVAL;
 			}
+check_ok:
 			ret = process_kf_arg_ptr_to_list_node(env, reg, argno, meta);
 			if (ret < 0)
 				return ret;
-- 
2.50.1 (Apple Git-155)

