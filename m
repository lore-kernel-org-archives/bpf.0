Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793148305;
	b=hWjOhYFwwdzfIVDlcUxx/pFt6VjaZM2NJdnZuRRYYQSvIC4pYGPdUVn1PpqnUPC2TeZe
	 7P9cfvLUUlH7tg++iO7kqocMVtUWlARZyTsIcoiuwqZukfaHEY3y68PeN7Cw2pl6wV0zT
	 medz1S/1hsUqLnXJ9CpBWQhYK2aPSQgizX0/Ez9xKEdJURd/9/0Gc6GprFLEw80qLpWzK
	 f+ib15nTWVzEtp9rl9uox7rTb1DrXd+veN0gll8OBlZ2eYFF+UQSN1beRA19H7qF3qg8Y
	 s93pIhrAPcn8wSCjfvDo7ifO2iCi1u6mJaNzZinKO3h+ZL/zFmqEh7z89Zc/do3Kubw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793148305;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=D1zYdsYxPV/Xlvt+zXnCezQxK5Ql3hqe8wSoGYqi0lE=;
	b=jLemAgf+iDRB1CabDVNrBp6uYEGj68B8ZVEF6N1q3XE4ckYA+Ng+uN3Lz68HPs4kidS2
	 Tf1aWjdMFi74MZMQqIRxkC7C5vzO5wrzmLrZY1qytOxeeGWRr1hdZIr7WlX/9bCG/LmM5
	 f2vZTX/E4ruc7revgMJHTt0YyKS72AnhE15/8J71R5r9HSgEWYm/4A3gob7QXcmJT4fU0
	 IZYu0asWRnW1M8WIT8BqMZdIXgA1EJpY5ekiv1vBGSgiKwnDM1GapaGpVNcsxdK9d0nH/
	 3wCEFLWS2TVGI75JadMR8PwV4kGsqVrCj5j1clG5+mP3d3Upknf3FAD+nCdyafjczUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d9vnQTyC;
	arc=none smtp.remote-ip=74.125.225.139
Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6466B606A325
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 00:45:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6466B606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d9vnQTyC
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-4a5f76661b5so1561665e9.0
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 17:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793148304; x=1793753104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D1zYdsYxPV/Xlvt+zXnCezQxK5Ql3hqe8wSoGYqi0lE=;
        b=d9vnQTyC8bS6sXe620g23Tw6uIfEu2at5UfzVVjva4ffoL+OYcR0iP8sRoLGSFVCjM
         71V8USmwTECeNZDyth0oNl3ueekUCHX/TFRlCwSx4EjkV3dIJ7XvwDVTSiRDjTKJaXu9
         C3Pp6GYSJMNp/UcFJUV+pLoXVoq2ZeVk/K2ij5cr6ozzqS/pqY54FlJox62s2eS16n76
         K/VevmFIwrsIt6aexdqMSNmZ95WG/02iDgace+9I3YuipS2xeDOlkLpQvvhMQeiMXRme
         ddVJ1gcXyg9FI/sMzNijQ3siO6SXKvVcfgqwfx1F44MjGNjQIBx4lhOw4Kg243T9oRnU
         K/DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793148304; x=1793753104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=D1zYdsYxPV/Xlvt+zXnCezQxK5Ql3hqe8wSoGYqi0lE=;
        b=JrIY3hlKfbQc0h6mD0pGiYrKGo/+y224yduwjKlTOdEpqbKiqayaKFBf8dIJhufO2X
         zxDAmu0JtZYV/aAbuQPSfhtSXbcFvZF+Hs7liGm4fv3xD53m8HfyM8PviGo1seLgiYts
         HhkaSEnPQ3xgzA38qzf9KHLJdI+qysSjjPJakW9OnPtnTje2YwWd5n6uddhPqbv3nm5t
         mASvtLUvDEVEhj/Mb7RhUtEpQfeglshK8wpVj+foloIuspcxj/bEsnwonZQ0tgsVUFRp
         BAYPBj4OfW0QzwmRZ3ZBaBtrBN7H7goNbHDr3JNPQRJW2Mgu1iPpvNLZVkmMbNHnD4+1
         tY+Q==
X-Gm-Message-State: AFq9FYL+G1IgQZq2a7Tgbk2/i1JLFwAIOtORP4o5cHpStJyiUlswkV69
	qUoWW6kvaYLr0VEe4ymTrubm6WJz8x25djZ8Z15yaAyfPvblUkNEnewAxYOUjobj
X-Gm-Gg: AYBFou3LKNWIfyQAL7Wisi/qD4ZhAtk9JAXh7pDpEyYtWggz7trwRhYh2yrPp46bqF9
	INhLvHkPnlaScAUaASwNXA8mt1Wci8hZeoXNkZd5+MuannEa/w/S8lle4/2cs2xqaQ0ankQAD1+
	4d3Qic+Cb5SmJ8gKXKK2Hbpf7CyqNLllnGMRDWlMZKIEhGLAyksccUtAZ6jZV8KiUkgQGQRVtKv
	0a5YbBr9DY/dP2ta055zwSXOW+2r1iIQwBxfC576h2fkdjgWQHFp+2HiCcVEi1kv2vbdQb+ZUQ2
	nQiuMmwhKvcj7moDA2wk8JP1n7NI5jMfAaINyA/Xn9CanuCrob60tcbnZ9eMqKVAohzTkksPHQF
	+fvtkP1wxkZxZkwErke1/Vqa7Ffw4jxmZYagqEF++eDdp6JBdOalXG5n+/YWFzq23O9emcF37Xg
	Uv3bEH5eZFfZfSCUvMIlnVtf+h5co7kjfkQiHF01JunohMOH6jlwPDR1pQ5S6+TA7OhaciFdPy1
	n6KrN4Q6l2XWe3h4n7TFcGnQ5qpb4ExUTAG+/NZae9CPVSGvJcLZ78u3TKz5PrwkPiDufPgdf4v
	zc+M/eQAOfS3g58mtbUJsCHMiYmXie/WDvLGoGs+9icddXJ8id6vkgXf0Tmnfyf9Xnwn1S/6s3c
	zZ9q9hcAYnblG7ZMoy65qq7UdHv3TT39iIwyZOS/texA/mcrpAwxjtiDrpaucujXg56/H
X-Received: by 2002:a05:600c:3b11:b0:4a3:5991:718 with SMTP id 5b1f17b1804b1-4a966c4178emr13913785e9.16.1793148303639;
        Tue, 27 Oct 2026 17:45:03 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a9783b7e87sm7281195e9.6.2026.10.27.17.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 17:45:02 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next v1 09/11] bpf: Let the comparator of bpf_rbtree_add unwind
Date: Wed, 28 Oct 2026 01:44:46 +0100
Message-ID: <d81d996f09e0fd0b07816dcd0541f39c0f451a23.1793147364.git.memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793147364.git.memxor@gmail.com>
References: <cover.1793147364.git.memxor@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7197; i=memxor@gmail.com; h=from:subject:message-id; bh=j5K96OqjRssqkYba5mQWAqN/wTrco+lJL2ZKEWHPmDQ=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIeuh44tdHw9/vFa08KFulVPcxSlFB7tqlMzCT6dJPErXn TTv/It5HaUsDGJcDLJiiiwl//cxGZ+o/B1ou4wbZg4rE8gQBi5OAZhI+ASG/1UqVqe4QtVYFaVF HLazrI16sPKi3+xz9nJZWg5njvxfs5qR4flHoTtCv//nFfw6OY1FcVmmBc+TKA1rR/ZN8eu3t79 pYAcA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

When the comparator unwinds the node is not in the tree, and the caller
has let go of it: the kfunc releases the node whichever way it returns.
The pad drops it, as the error path for a node that is already in a tree
does, and leaves. The lock on the root is the caller's, and its pad is
checked for it like any exit. Both spellings of the kfunc get it, each
with its own copy of the body: the pad leaves from the frame that the BPF
code called, and bpf_rbtree_add_impl() calling bpf_rbtree_add() is a tail
jump on x86-64 but a call with a frame of its own on arm64, where the pad
would rewrite a return address into that frame and the exception would come
back as a return of 0.

The kfunc returns long in both spellings: the pad leaves with the r0 of
the comparator, and an int would cut it to 32 bits. The change shows in
BTF, and libbpf takes integers of any width as compatible, so a
declaration that says int keeps loading.

On the revisit of the call after the comparator unwound, the node is not
in the tree: the kfunc dropped it. So the verifier releases the reference,
and every register that held the node is gone with it, rather than turning
it into a non-owning reference to a node in the tree. The comparator was
handed the node too, as a non-owning reference, and may have unwound with
it in r0, so every non-owning reference goes, as it does at an unlock.
With that the verifier lets the comparator of bpf_rbtree_add() unwind, in
both spellings.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/helpers.c  | 50 +++++++++++++++++++++++++++++--------------
 kernel/bpf/verifier.c | 20 ++++++++++++++---
 2 files changed, 51 insertions(+), 19 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 648abe1ba63a..f8708b7181d7 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2011-2014 PLUMgrid, http://plumgrid.com
  */
 #include <linux/bpf.h>
+#include <linux/bpf_unwind.h>
 #include <linux/btf.h>
 #include <linux/bpf-cgroup.h>
 #include <linux/cgroup.h>
@@ -2761,17 +2762,20 @@ __bpf_kfunc struct bpf_rb_node *bpf_rbtree_remove(struct bpf_rb_root *root,
 	return (struct bpf_rb_node *)n;
 }
 
-/* Need to copy rbtree_add_cached's logic here because our 'less' is a BPF
- * program
+/*
+ * Need to copy rbtree_add_cached's logic here because our 'less' is a BPF
+ * program. The pad leaves from the frame that the BPF code called, so the body
+ * is inlined into both spellings of the kfunc.
  */
-static int __bpf_rbtree_add(struct bpf_rb_root *root,
-			    struct bpf_rb_node_kern *node,
-			    void *less, struct btf_record *rec, u64 off)
+static __always_inline long __bpf_rbtree_add(struct bpf_rb_root *root,
+					     struct bpf_rb_node_kern *node,
+					     void *less, struct btf_record *rec, u64 off)
 {
 	struct rb_node **link = &((struct rb_root_cached *)root)->rb_root.rb_node;
 	struct rb_node *parent = NULL, *n = &node->rb_node;
 	bpf_callback_t cb = (bpf_callback_t)less;
 	bool leftmost = true;
+	u64 r0;
 
 	/* node->owner != NULL implies !RB_EMPTY_NODE(n), no need to separately
 	 * check the latter
@@ -2784,7 +2788,8 @@ static int __bpf_rbtree_add(struct bpf_rb_root *root,
 
 	while (*link) {
 		parent = *link;
-		if (cb((uintptr_t)node, (uintptr_t)parent, 0, 0, 0)) {
+		bpf_call_cb(cb, node, parent, 0, 0, 0, r0, unwound);
+		if (r0) {
 			link = &parent->rb_left;
 		} else {
 			link = &parent->rb_right;
@@ -2796,6 +2801,15 @@ static int __bpf_rbtree_add(struct bpf_rb_root *root,
 	rb_insert_color_cached(n, (struct rb_root_cached *)root, leftmost);
 	WRITE_ONCE(node->owner, root);
 	return 0;
+
+unwound:
+	/*
+	 * The comparator left with unwind_exit. The node is not in the tree, and
+	 * the caller has let go of it: drop it, as the error path above does.
+	 */
+	__bpf_obj_drop_impl((void *)n - off, rec, false);
+	bpf_unwind_leave();
+	return r0;
 }
 
 /**
@@ -2809,24 +2823,28 @@ static int __bpf_rbtree_add(struct bpf_rb_root *root,
  * Insert @node into @root using @less. The verifier rewrites @meta and @off;
  * BPF programs do not set them.
  *
- * Return: 0 on success, or %-EINVAL if @node is already linked in a tree.
+ * Return: 0 on success, or %-EINVAL if @node is already linked in a tree. When
+ * @less unwinds, what it unwound with, to the pad after the call.
  */
-__bpf_kfunc int bpf_rbtree_add(struct bpf_rb_root *root,
-			       struct bpf_rb_node *node,
-			       bool (less)(struct bpf_rb_node *a, const struct bpf_rb_node *b),
-			       struct btf_struct_meta *meta,
-			       u64 off)
+__bpf_kfunc long bpf_rbtree_add(struct bpf_rb_root *root,
+				struct bpf_rb_node *node,
+				bool (less)(struct bpf_rb_node *a, const struct bpf_rb_node *b),
+				struct btf_struct_meta *meta,
+				u64 off)
 {
 	struct bpf_rb_node_kern *n = (void *)node;
 
 	return __bpf_rbtree_add(root, n, (void *)less, meta ? meta->record : NULL, off);
 }
 
-__bpf_kfunc int bpf_rbtree_add_impl(struct bpf_rb_root *root, struct bpf_rb_node *node,
-				    bool (less)(struct bpf_rb_node *a, const struct bpf_rb_node *b),
-				    void *meta__ign, u64 off)
+__bpf_kfunc long bpf_rbtree_add_impl(struct bpf_rb_root *root, struct bpf_rb_node *node,
+				     bool (less)(struct bpf_rb_node *a, const struct bpf_rb_node *b),
+				     void *meta__ign, u64 off)
 {
-	return bpf_rbtree_add(root, node, less, meta__ign, off);
+	struct btf_struct_meta *meta = meta__ign;
+	struct bpf_rb_node_kern *n = (void *)node;
+
+	return __bpf_rbtree_add(root, n, (void *)less, meta ? meta->record : NULL, off);
 }
 
 __bpf_kfunc struct bpf_rb_node *bpf_rbtree_first(struct bpf_rb_root *root)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fd63ff36eb90..50c3d44c37e1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11416,10 +11416,10 @@ static bool helper_has_cb_pad(enum bpf_func_id func_id)
 	}
 }
 
-/* The kfunc calls its callback with a pad. None yet. */
+/* The kfunc calls its callback with a pad */
 static bool kfunc_has_cb_pad(u32 btf_id)
 {
-	return false;
+	return is_bpf_rbtree_add_kfunc(btf_id);
 }
 
 static bool insn_has_cb_pad(struct bpf_insn *insn)
@@ -15738,7 +15738,21 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		id = regs[BPF_REG_2].id;
 		insn_aux->insert_off = regs[BPF_REG_2].var_off.value;
 		insn_aux->kptr_struct_meta = btf_find_struct_meta(meta.arg_btf, meta.arg_btf_id);
-		ref_convert_owning_non_owning(env, id);
+		/*
+		 * The comparator unwound: the node never went in, and the
+		 * kfunc dropped it on its way to the pad. The comparator was
+		 * handed the node too, and may have unwound with it in r0, so
+		 * every non-owning reference goes. Otherwise the node is in
+		 * the tree now.
+		 */
+		if (env->cur_state->unwound) {
+			invalidate_non_owning_refs(env);
+			err = release_reference(env, id);
+			if (err)
+				return err;
+		} else {
+			ref_convert_owning_non_owning(env, id);
+		}
 	}
 
 	if (meta.func_id == special_kfunc_list[KF_bpf_throw]) {
-- 
2.53.0

