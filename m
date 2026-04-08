Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4975B3D5666
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 15:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775661049; cv=none; b=aJBl9Ms94vE0QmAIcsYkbBLdL2CltvvBznjU689kCFgB9pRkHlZM6stOLtPTkBpfcuzt1E/zMLtVic65wuyQPZaLB3R0YXQekjp8grIsa+wS6TgBCxOmzWafnl7b+PoU5WkNNlk0Hrbs9qf9bStYCKlWn2hikfHwPGJFcCjt/3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775661049; c=relaxed/simple;
	bh=SPIrdCaJryCy0xmLCDDtOlDU/xkvzcpdEYm9GOS6jnI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LLiaDn10vkvoVW9rZxSUFRPxAbomeWcftoJjVQ7n7Iu5NeSpLk6oSENsRNGQfUhp86v8Zgj8CLk2+VEfiaF9g0N00+YRZPjI+z7NIXR0AIuEP8+yEJB0vCJitUSMp6Go5PIvC5O7T9hS+3VCM3B4HVr/yh2+VjEw8EgJNor/p8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cEJtbjwU; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEJtbjwU"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso44222315e9.3
        for <bpf@vger.kernel.org>; Wed, 08 Apr 2026 08:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775661047; x=1776265847; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oR46rAhAnj8wIytN3gbgm1MQ5zT/yD4AJQgbblfOUEY=;
        b=cEJtbjwU4vdsZv6XDdbXZI7dOeoahzK0ihk/CGvdRZDwo/j+M1LYjRr07UDxFN53TS
         M5L1yMbHLLgI5f6M36hA8mQs87dZWJoxFak/ZntxUSFAiGEHQw9sLu86/9zTvwz6H1HX
         jbDgSpZI/0u+9h8v+hLdN2P6xLTltiXGzLTWz9DdDz7A+KiB0xxx1iw4OSRPPcTJ3Yk3
         Mtlkz3wbzxGmxOF+/v8xv8fZiKAxp0+pqi4c94dJHLwFIJ3YtcrWd4lVhFlIEJBUTigq
         vOyZzVkzNoAMzc2L8mBJhCHjiW1n6GQmSGfIj0zRQJm7mhwdXHNzlevFsmicMd83pZ72
         Di6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775661047; x=1776265847;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oR46rAhAnj8wIytN3gbgm1MQ5zT/yD4AJQgbblfOUEY=;
        b=HYxUrLIgsoMgqnXnp2fNncNMnNLxqg0PMbu+gD/n/diZRmwOebFKPsJ+UcpPb5W8gf
         j9A7yCAK3FOS2iKILP1MD7GV4mVBK083kYq7CLUr7kytAsJj/tKvgN+ROqRuqWVH9qZO
         cAnb7939fkn/JrUEfudp4gTVC0HDz00AoKSz2v7rAAE9mdS6fDMGtgbI/rh4/eaYJJF/
         QLQy+ZojeY8s97DMQT5PS77PlOsVCvocZod6o2jlcKKl30t2RAHMx/Wy78pBRbtzk/KY
         roDCVT72dc1VzKLGV9UKb++ppaumiVeYYZS/6fe/FDDoad5gPMHsXXpB6g4ece6bxzrS
         m99g==
X-Gm-Message-State: AOJu0YyQsiUqF2FgAHGgIrh7ZvR+L2a2gWmsX99KFu/Xv7UPhuA9uo4J
	/+oPhwYZgjUAMYD7Pt9TvwCYga4cfehD4x5UVgEtBSAS0MQSa0ZxBZFR
X-Gm-Gg: AeBDieuzKKPFhxe1Ji+UGJJ3KetC835atsFB04fffxMl9QbVtt4tFOUSKJMIfDSJ0tr
	mJkO8XdAQx4rv3ja6cNgfzpNE0QAQCjUrUpSMq/EWd7ACAvobJl4g56HBWC3d+y3JPVM9udmVNz
	YAGvFU00A4ao7zIgf4hvJqCFmSi6NInrQlXR+5+4jBOdA/oO1PkQXsBe4Lt+FxQ/padWFLSsLaq
	PwoYlVSdMz2kHVmOxOeWfAKpa0ifJF8+7zEOrw1F3o7Dzw0R7ZyXHBB7aLfhUH9Fl4OMCDzwQLP
	v1h7l26TmxZsiYq6sUHp5mKdhQtathu3KyJyGKLeFtCVIfhlNmHqzfvtt/sXwwLor90JD/m5kln
	qZ02v415v+6BFHwIjjImODZm7ehrfc5CtPwFtQu4vh2/my1UMyWwhHCQrffFjPk+pni4XC9F0WS
	At1NWsF2FNUQ0gIw==
X-Received: by 2002:a05:600c:a306:b0:488:c014:34da with SMTP id 5b1f17b1804b1-488c01436b4mr66329005e9.26.1775661046561;
        Wed, 08 Apr 2026 08:10:46 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:47::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e80a616sm1202704565e9.2.2026.04.08.08.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 08:10:45 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 08 Apr 2026 08:10:13 -0700
Subject: [PATCH RFC bpf-next v2 08/18] bpf: Implement iterator APIs for
 resizable hashtab
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-rhash-v2-8-3b3675da1f6e@meta.com>
References: <20260408-rhash-v2-0-3b3675da1f6e@meta.com>
In-Reply-To: <20260408-rhash-v2-0-3b3675da1f6e@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, herbert@gondor.apana.org.au
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775661029; l=4428;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=s+V2B1bE7q5i1g1HZnov6A1xHlyzuXjBgnNBI1AvTV8=;
 b=MJ0mXEEpu2Pk6pkA+vX18yZsasYvqcgzn5TXzFQSCBM8zYwQm69k5cYlFJmnIYSk8wFAXEgRU
 wcL1BXPeXVOB5+F/CtNlpFnI1LQNH8o3uNthQ27hi+pMf9eWbZ80fpc
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Wire up seq_file BPF iterator for BPF_MAP_TYPE_RHASH so that
bpf_iter and bpftool map dump work with resizable hash maps.

Use rhashtable_walk_enter_from() with a saved last_key to resume
iteration across read() calls without linear skip from the
beginning on each seq_start.

Also implement rhtab_map_seq_show_elem() for bpftool map dump
in non-iterator mode.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/hashtab.c | 98 +++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 94 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index a79d434dc626..492c6a9154b6 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -3008,6 +3008,19 @@ static int rhtab_map_get_next_key(struct bpf_map *map, void *key, void *next_key
 
 static void rhtab_map_seq_show_elem(struct bpf_map *map, void *key, struct seq_file *m)
 {
+	void *value;
+
+	/* Guarantee that hashtab value is not freed */
+	guard(rcu)();
+
+	value = rhtab_map_lookup_elem(map, key);
+	if (!value)
+		return;
+
+	btf_type_seq_show(map->btf, map->btf_key_type_id, key, m);
+	seq_puts(m, ": ");
+	btf_type_seq_show(map->btf, map->btf_value_type_id, value, m);
+	seq_putc(m, '\n');
 }
 
 static long bpf_each_rhash_elem(struct bpf_map *map, bpf_callback_t callback_fn,
@@ -3201,36 +3214,113 @@ struct bpf_iter_seq_rhash_map_info {
 	struct bpf_map *map;
 	struct bpf_rhtab *rhtab;
 	struct rhashtable_iter iter;
-	u32 skip_elems;
+	void *last_key;
 	bool iter_active;
 };
 
 static void *bpf_rhash_map_seq_start(struct seq_file *seq, loff_t *pos)
 {
-	return NULL;
+	struct bpf_iter_seq_rhash_map_info *info = seq->private;
+	struct rhtab_elem *elem;
+	void *key = *pos > 0 ? info->last_key : NULL;
+
+	scoped_guard(rcu) {
+		rhashtable_walk_enter_from(&info->rhtab->ht, &info->iter,
+					   key, info->rhtab->params);
+		rhashtable_walk_start(&info->iter);
+	}
+	info->iter_active = true;
+
+	elem = rhtab_iter_next(&info->iter);
+	if (!elem)
+		return NULL;
+	/*
+	 * if *pos is not 0, previously iteration failed on this elem,
+	 * so we are restarting it. That's why no need to increment *pos.
+	 */
+	if (*pos == 0)
+		++*pos;
+	return elem;
 }
 
 static void *bpf_rhash_map_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
-	return NULL;
+	struct bpf_iter_seq_rhash_map_info *info = seq->private;
+	struct rhtab_elem *elem = v;
+
+	/* Save current key for O(1) resume in next seq_start */
+	memcpy(info->last_key, elem->data, info->map->key_size);
+
+	++*pos;
+
+	return rhtab_iter_next(&info->iter);
+}
+
+static int __bpf_rhash_map_seq_show(struct seq_file *seq,
+				    struct rhtab_elem *elem)
+{
+	struct bpf_iter_seq_rhash_map_info *info = seq->private;
+	struct bpf_iter__bpf_map_elem ctx = {};
+	struct bpf_iter_meta meta;
+	struct bpf_prog *prog;
+	int ret = 0;
+
+	meta.seq = seq;
+	prog = bpf_iter_get_info(&meta, elem == NULL);
+	if (prog) {
+		ctx.meta = &meta;
+		ctx.map = info->map;
+		if (elem) {
+			ctx.key = elem->data;
+			ctx.value = rhtab_elem_value(elem, info->map->key_size);
+		}
+		ret = bpf_iter_run_prog(prog, &ctx);
+	}
+
+	return ret;
 }
 
 static int bpf_rhash_map_seq_show(struct seq_file *seq, void *v)
 {
-	return 0;
+	return __bpf_rhash_map_seq_show(seq, v);
 }
 
 static void bpf_rhash_map_seq_stop(struct seq_file *seq, void *v)
 {
+	struct bpf_iter_seq_rhash_map_info *info = seq->private;
+
+	if (!v)
+		(void)__bpf_rhash_map_seq_show(seq, NULL);
+
+	if (info->iter_active) {
+		rhashtable_walk_stop(&info->iter);
+		rhashtable_walk_exit(&info->iter);
+		info->iter_active = false;
+	}
 }
 
 static int bpf_iter_init_rhash_map(void *priv_data, struct bpf_iter_aux_info *aux)
 {
+	struct bpf_iter_seq_rhash_map_info *info = priv_data;
+	struct bpf_map *map = aux->map;
+
+	info->last_key = kmalloc(map->key_size, GFP_USER);
+	if (!info->last_key)
+		return -ENOMEM;
+
+	bpf_map_inc_with_uref(map);
+	info->map = map;
+	info->rhtab = container_of(map, struct bpf_rhtab, map);
+	info->iter_active = false;
 	return 0;
 }
 
 static void bpf_iter_fini_rhash_map(void *priv_data)
 {
+	struct bpf_iter_seq_rhash_map_info *info = priv_data;
+
+	kfree(info->last_key);
+	bpf_map_put_with_uref(info->map);
 }
 
 static const struct seq_operations bpf_rhash_map_seq_ops = {

-- 
2.52.0

