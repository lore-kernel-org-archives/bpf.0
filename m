Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FC84C043E
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 11:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780659705; cv=none; b=Q9j/iHGtbA6t9qboL4iBcuqT5/wa7AxlgJXU69RBxeuIaTBXah/bJ3w6ppUyxWeR7CU24sHtAogu8TT5ukpJRGDmkfp3/XlV6FMzzA95xz2PtgcTg2sBHf8/D12emQn0Pw0HKHcvlLwhlzdxdPUpLy/xSc3rXqM4qeuuaW08EL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780659705; c=relaxed/simple;
	bh=wueijMAq8YJNXENySpqsDZzIfCzjvQmNYdlJzBVhah4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aR9zCeCOm0MkSrpqK749KFbdlB25Hw0J5y8HrUGygqDEQcDYHVFSSvWZ9IQWv7kgCB6aotMnv7WTQp8q3VAvppc343q/6X4fCV4F7+gsaFys1cvdvblfhvTLHZUQ5z0lhG0lPxUgtnUFTW89Rg6iZuTnivvT+cWtu4Nx8M6lX6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VuV0/RyY; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VuV0/RyY"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-45eedc94d37so959538f8f.3
        for <bpf@vger.kernel.org>; Fri, 05 Jun 2026 04:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780659701; x=1781264501; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fCNimO14PWX7erZ6yCEqTSuGaJlwXR7jxkPoyUXSqOM=;
        b=VuV0/RyYhd7HEVNfPVqjTWrmTV1bXT7zEGeQX5TYUMfdNf7GcORaKv2ovhvZ2hAhkI
         wTwHIoPvqe3yChqGh85zfVAMOSyywHAzKgRzTB3BYv4IdXY6rngV7F7pHdsD53jfRCTB
         X+0Lwixq6xCwJlUqcudYTrD1GkoRjAIOP68dh5m9mqa6Xyest/3j2VyI70R/IJoV7rch
         wbVg3uy5TPNgZ62V+GTRJdPZDyyqHD49Ea2lDpQUWk9CJfYN+Vyat0Tg70cNXNovHKFq
         jOZ5CV69TQXfddLeqMWVBBJe5aKORjrmuaZxKcnXBkBiiYWsKHya0tNQ8ZAclzlkmswq
         k+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780659701; x=1781264501;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fCNimO14PWX7erZ6yCEqTSuGaJlwXR7jxkPoyUXSqOM=;
        b=CUmQXgz2Kf6nXaZiO6BAoJQ7jOrutml3wjW0leDPqThJAREhxVaCKMFaXR8jZqe7U9
         mCD0/k2NBdBe1xVwtzJXlF5AS+XfXQqm1+iEfUn5DdPXas0GZisE05OGfxZC+UxWRw/T
         yM8VVXzaWWvtBHIplWFr+e/CBPaxqYjg6w7pSWUlgnZ56fVqeYOEMIT6X0+s9ek8/cNW
         jjG1e9aeOERN6HIXmcZhl0SCEM2FRdtKtQv7LLPJ83pcFDDro5kdgVG8tWETYcUuXhlu
         pRi80FZt+ibub0NX2DfFy29+DZy9s3VXCuiNHwfC+sHGxA4WIWuefkbvplHX6FHlogQx
         M2lw==
X-Gm-Message-State: AOJu0YzL01MwrU9PuMOik2cceGbj2wnHU2Kbqx48D60TyVt/32MdXMOS
	ysV/WtDumaBJEi9bvzKqGqEP55+uQHq3wjsp59rCbvDGBsEsgJUdXktF
X-Gm-Gg: Acq92OHMLhsHnobkKRu84b8/NL5RzmTc5HbE5ZMlytT7ix8tzyE0t8a1J9X6r/rmY/j
	4s6+NXbn1nZK+meOJWQiOSzbTEYBqODsmdimLjTyErDq4QyCbX3Fa9/Zh6P+FK+NJMT5D4FLQ78
	4cmApR6KGT6+08L1EafohBg3OB+p0EyB6ftJFiBpSsO8ofx525Uu5oGFXJjdtiOrexTTMStvE6I
	8CdRDb0ymxNDmWqEhAsHGNhNLK+4IqTPZakvClWnva/CY3hHj0Kf4A6T8O3Lt2lQu5fS1FOCZLo
	+SMUwi0cNrwUsCQNoi1i9OPYAsKnDOjZP27NrxrxJm5/uxKASTtLACOHFhdsOowZgVZAiacYux4
	vg9Je2r5Z7n7vA/5hWkpQq2nGwiA8Qm7DMultu9Gu3EFAshYjHAFuSWepxiKbrk6FNireggiBiA
	G+Y/eimmWb29rS9f0FWOwQ0LA=
X-Received: by 2002:a05:6000:469a:b0:460:3233:beec with SMTP id ffacd0b85a97d-4603233c021mr2969563f8f.40.1780659700697;
        Fri, 05 Jun 2026 04:41:40 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:9::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2ed944sm25205053f8f.13.2026.06.05.04.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 04:41:40 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Fri, 05 Jun 2026 04:41:24 -0700
Subject: [PATCH bpf-next v7 07/12] bpf: Optimize word-sized keys for
 resizable hashtable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-rhash-v7-7-5b8e05f8630d@meta.com>
References: <20260605-rhash-v7-0-5b8e05f8630d@meta.com>
In-Reply-To: <20260605-rhash-v7-0-5b8e05f8630d@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, herbert@gondor.apana.org.au
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780659688; l=3843;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=vn+VKE6JVG8w8/+gt+HnBYO37PkcKpeX+HYaop17mF8=;
 b=vos+ZiPNuarkbogWGo68rr5KYxrHZFe5jchJKwqk+biw/uwUlHDui/+BQY5iA9IOyM1viwIOB
 2DY5y5qbf4bAFF6WUiKdhXUyvwzmonH4Kqip31QvyIc4tVV/ErMKY7G
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Specialize the lookup/update/delete paths for keys whose size matches
sizeof(long) (4 bytes on 32-bit, 8 bytes on 64-bit). A static-const
rhashtable_params lets the compiler inline a custom XOR-fold hashfn and
a single-word equality cmpfn, eliminating the indirect jhash dispatch.
The same hashfn and cmpfn are installed into rhashtable's stored params
at rhashtable_init time, so the rehash worker, slow-path inserts, and
rhashtable_next_key() all agree with the inlined fast paths.

The seq_file BPF iterator uses rhashtable_walk_* and is unaffected.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/hashtab.c | 47 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 7b9408b8320c..b4366cad3cfa 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -2763,6 +2763,31 @@ static inline void *rhtab_elem_value(struct rhtab_elem *l, u32 key_size)
 	return l->data + round_up(key_size, 8);
 }
 
+/* Specialize hash function and objcmp for long sized key */
+static __always_inline int rhtab_key_cmp_long(struct rhashtable_compare_arg *arg,
+					      const void *ptr)
+{
+	const unsigned long key1 = *(const unsigned long *)arg->key;
+	const struct rhtab_elem *key2 = ptr;
+
+	return key1 != *(const unsigned long *)key2->data;
+}
+
+static __always_inline u32 rhtab_hashfn_long(const void *data, u32 len, u32 seed)
+{
+	u64 k = *(const unsigned long *)data;
+
+	return (u32)(k ^ (k >> 32)) ^ seed;
+}
+
+static const struct rhashtable_params rhtab_params_long = {
+	.head_offset = offsetof(struct rhtab_elem, node),
+	.key_offset  = offsetof(struct rhtab_elem, data),
+	.key_len     = sizeof(long),
+	.hashfn      = rhtab_hashfn_long,
+	.obj_cmpfn   = rhtab_key_cmp_long,
+};
+
 static struct bpf_map *rhtab_map_alloc(union bpf_attr *attr)
 {
 	struct rhashtable_params params;
@@ -2788,6 +2813,11 @@ static struct bpf_map *rhtab_map_alloc(union bpf_attr *attr)
 	params.nelem_hint = (u32)attr->map_extra;
 	params.automatic_shrinking = true;
 
+	if (rhtab->map.key_size == sizeof(long)) {
+		params.hashfn = rhtab_hashfn_long;
+		params.obj_cmpfn = rhtab_key_cmp_long;
+	}
+
 	err = rhashtable_init(&rhtab->ht, &params);
 	if (err)
 		goto free_rhtab;
@@ -2878,6 +2908,9 @@ static void *rhtab_lookup_elem(struct bpf_map *map, void *key)
 	/* Hold RCU lock in case sleepable program calls via gen_lookup */
 	guard(rcu)();
 
+	if (map->key_size == sizeof(long))
+		return rhashtable_lookup_likely(&rhtab->ht, key, rhtab_params_long);
+
 	return rhashtable_lookup_likely(&rhtab->ht, key, rhtab_params);
 }
 
@@ -2912,7 +2945,12 @@ static int rhtab_delete_elem(struct bpf_rhtab *rhtab, struct rhtab_elem *elem, v
 	 * raw tracepoints, which we don't have in rhashtable.
 	 */
 	bpf_disable_instrumentation();
-	err = rhashtable_remove_fast(&rhtab->ht, &elem->node, rhtab_params);
+
+	if (rhtab->map.key_size == sizeof(long))
+		err = rhashtable_remove_fast(&rhtab->ht, &elem->node, rhtab_params_long);
+	else
+		err = rhashtable_remove_fast(&rhtab->ht, &elem->node, rhtab_params);
+
 	bpf_enable_instrumentation();
 
 	if (err)
@@ -3030,7 +3068,12 @@ static long rhtab_map_update_elem(struct bpf_map *map, void *key, void *value, u
 
 	/* Prevent deadlock for NMI programs attempting to take bucket lock */
 	bpf_disable_instrumentation();
-	tmp = rhashtable_lookup_get_insert_fast(&rhtab->ht, &elem->node, rhtab_params);
+
+	if (map->key_size == sizeof(long))
+		tmp = rhashtable_lookup_get_insert_fast(&rhtab->ht, &elem->node, rhtab_params_long);
+	else
+		tmp = rhashtable_lookup_get_insert_fast(&rhtab->ht, &elem->node, rhtab_params);
+
 	bpf_enable_instrumentation();
 
 	if (tmp) {

-- 
2.53.0-Meta

