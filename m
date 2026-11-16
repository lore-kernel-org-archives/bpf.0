Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794842835;
	b=B9o7cgV1oi3vl1+WdKT9D2rYhk1GOFvJNAzhbmpJcj3IIE3vihNOvLQqF32tznpPAjXc
	 CPhKUNlnropQRFo/smd6ZKptbalVHuVfc2oDuuTO3G2VoCEvL0vHZSJ3HdbTT5oqSQF+c
	 4F7q1jR/vcSPoUS4q5uGQhrRxi5lNOVKhxplpnK4RyRwJe73d1ocwRlP3RZdN4GsdR8jy
	 AQYQCejddhDj+SFQFIbdpJG+KiIwXh7t3jViDjdTABhMIm9XOQXpRHjRZ44C90GvwXjkv
	 w/ykd+kEkmh1HhFwbe2BBfFEW6nRS3tRynov1pUYo6vut5sXKr7zZ0L79gsYr0B4CvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794842835;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DWt47BTn1sVaDfSYdiMfRiImAu8Opf3TzJVb3DVQgBE=;
	b=RDVBbFXoVvdMqhtgeJwfBzVRPQqDJ9IMmjdSSOVTClrqQY7DbU5NixjKDzGeGczq1eBz
	 xSyVn8A5atjkGKCnfWE9PGnDnkSvnAV0e6ayNpmU/f2CEBaJWpM70WT0TlOPCjzoDfxiu
	 yucHkHbqjtow5XoBm+0FfbCCXbrH0sVDn1CQRCIsLO9Lz8kF9aWI8CO0rz9tYGD5QR0bg
	 CjaUTGQnMZ+qDki7MYeNK3XgAWBQafe6B3WTTF06apEDo0jkzisMfnq3/xQyzykDFWHhN
	 2i8cRjWUf1Ssg5Rlq/Fr5JQ1xjvmz4wVCQSAumkYrmPwNJt50SWyMlXBlg6vJRrUb4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="a7lwY/66";
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284B4606A881
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 15:27:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 284B4606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a7lwY/66
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3b0a519049aso3682061a91.1
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 07:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794842834; x=1795447634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DWt47BTn1sVaDfSYdiMfRiImAu8Opf3TzJVb3DVQgBE=;
        b=a7lwY/66EvDigvzm94lpJ4WWne7Rsyti0wohHPtWyT2AMCiP5jl8gNokSJ3147x2HQ
         ml0QDNgvn693TL2jh+nM7XU566547bCz8R32HA/p75C5N/S9uwJOAcWlNPUzrPE169vY
         D8ule6b2Bfhdl8z1cL0Wy+efk96mjX3fE1i2d4HFwOE3Zt/u0m6PAGdT7FbdP1qbYJKT
         FrnHqBeERDYOkLjHm8WRuiklKE14CM3f512i3X2tqakm4K7Uq6W/ef86cSNvL6AFaLUf
         98IwzMrJ5THs5xn3BSxSv7PsZ5BEk4aGsSRlqBdZtgVIqJBZxrWEkm9c1DLs8JDw5xHF
         0cyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794842834; x=1795447634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DWt47BTn1sVaDfSYdiMfRiImAu8Opf3TzJVb3DVQgBE=;
        b=0Kh0QIAuDGQa9SucXeeKEynP17asDf3tRnGnv2YGVgSWQjV6gQRc1UZCtLlPeJPxEO
         R37LDfsxhniSz92KOvLMsMVpgzcjPXzOSoG0S+VP7Ja6B042nJE0Vc3Am57BSEgHLllr
         /JynbUCiXFgWVO46GNmwxiHVbUFpJ6CyCzpr88tno+MXOgaV4UFQYPVZttcQsbVWTNYf
         pFJxD+5MsDV6/TG1l+mnlcS3Z0JGCt/777kQbpTCKwCg+msI0fwrZOAhPOUWaWbAsPoM
         QByr7gKcc+jbmckrd7YBs1axPOY/SGBi+UuOSOpG9JFCfNPuiFx70rfF+nfDzubNkZ3h
         UHMg==
X-Gm-Message-State: APuU4Z9xkg4dQRjrKU7nr9P749/mA2x8ufhLNOb6ZpaaJ32g/kTSrZ3J
	rY5brPeSTccLNSgf7usojfWPgOXEEj66KCYKHHbIslskkb2tSyCxXO46VtgK4Q==
X-Gm-Gg: AZFdTZclqJrYLaP3PPwFn0VVUYR24ruS5iGmegzbtmOXS2f10mv6Q4iISsucg3KNYl+
	gb9vEp2Ni4euEFbJ3hMRxsUIsaj+4cDzXVekbCvQzCUtyBmDSewwiSrT63IfpuUqcOp1f+B6Uxl
	0jxmS9njfIbXslirYctdjNqSdPjtkw3sw25QD3hSuw7b1pRECg/0Vw7LDIK4+WA7a5BUJOoe6Ca
	tiO6CIOEy6dwSFXnhCuUXS5mSHMGKb3yC+CQLnGfiXlmeWo6XHiDFCgDQY5PqMsAQQfBFprzSwm
	D+ROzEhiZrfjerUeLfGArJiIPfjRgWqtGM2hsXQ0GyUKOSG+BcePU47tDWOBQoIHbMuNMChRQI/
	LgThbpvxb9K6onXhKHb5Fr01k5dsfyOmOfnhrO4Ubs0iBP0Fbhiz33vvB3t3Q+fqxpuexVs0Gv4
	ctPO+B3VVSFpzNmvWKs288qgaWkEM3ncnOxBBWEWPXAeoxnflHcUEnST1aUGT0+kGWmtkMe5823
	VCjt1cxlopNh4rbQTCtad75lZ+0+qzZP66Rtm6k3Oo9zdNCTC3vWs24qnhCLoPmXqraBKNKN+zu
	Ugs/9hkOy+7fVgYRD9clWwczgGVDO5J/IbVs1u1m6m6TNr8vurkkSh6J68QtJDZtlddAkmdlwW7
	IxMvjs74VJVF1Pe6rwQKSu8UmAzSdUbM0gzYUR7fXwIWAzk9ZDBIFhB/S5s4Ojm8redfxd1yVYQ
	==
X-Received: by 2002:a17:90b:4b92:b0:3ac:97bc:4c7b with SMTP id 98e67ed59e1d1-3b1b0b57de5mr10844975a91.14.1794842834152;
        Mon, 16 Nov 2026 07:27:14 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b3eaf732sm8726410a91.3.2026.11.16.07.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 07:27:13 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 07/21] bpf: Remove the limits on maps, BTFs and fd_array of a program
Date: Mon, 16 Nov 2026 15:26:12 +0000
Message-ID: <20261116152626.4032587-8-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261116152626.4032587-1-alexei.starovoitov@gmail.com>
References: <20261116152626.4032587-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

A program can use 64 maps, 64 BTF objects and 4096 entries of fd_array.
Each jump table and each .data.X section is a map. Nothing needs these
numbers at run time.

Add two small tools:

  bpf_table_next()   a table that doubles
  bpf_index          key -> number of an entry, a hash table

  ld_imm64 map --> used_index[address of map] --> used_maps[i]

The program takes the tables from the verifier, there is no copy. The
table of fd_array grows with the entries that are read. Unprivileged
programs have 4096 insns, they keep 4096 entries.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h                  |  39 +++++-
 kernel/bpf/cfg.c                              |  39 ++++++
 kernel/bpf/core.c                             |   4 +-
 kernel/bpf/syscall.c                          |   6 +-
 kernel/bpf/verifier.c                         | 119 ++++++------------
 .../selftests/bpf/prog_tests/fd_array.c       |  36 ++++--
 6 files changed, 137 insertions(+), 106 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 2f15b43074d1..4d91f665109d 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -742,6 +742,33 @@ struct bpf_iarray {
 	u32 items[];
 };
 
+/*
+ * Make room for entry 'cnt' of a table that has 'cnt' entries, return the new entry.
+ * The table doubles: 1, 2, 4, 8, ... It is not a stack: 'cnt' never goes down.
+ */
+#define bpf_table_next(tab, cnt)							\
+	({										\
+		typeof(tab) __tab = (tab);						\
+		size_t __cap = 2 * (size_t)(cnt) ?: 1;					\
+		if (!((cnt) & ((cnt) - 1)))						\
+			__tab = kvrealloc(__tab, array_size(__cap, sizeof(*__tab)),	\
+					  BPF_VERIFIER_GFP);				\
+		__tab ? &((tab) = __tab)[cnt] : NULL;					\
+	})
+
+/* key -> number of an entry of a table */
+struct bpf_index {
+	struct bpf_index_slot {
+		u64 key;
+		u32 next_val;	/* value + 1, 0 if the slot is free */
+	} *slots;
+	u32 cnt;
+	u8 bits;
+};
+
+int bpf_index_find(const struct bpf_index *index, u64 key);
+int bpf_index_add(struct bpf_index *index, u64 key, u32 val);
+
 #define iarray_for_each(item, arr)						\
 	for (int ___idx = 0;							\
 	     ___idx < (arr)->cnt && ({ item = (arr)->items[___idx]; 1; });	\
@@ -970,9 +997,6 @@ struct bpf_insn_aux_data {
 	struct bpf_loop *loop;
 };
 
-#define MAX_USED_MAPS 64 /* max number of maps accessed by one eBPF program */
-#define MAX_USED_BTFS 64 /* max number of BTFs accessed by one BPF program */
-
 /*
  * Longest line the verifier log can carry: tmp_str_buf, see
  * TMP_STR_BUF_LEN, plus its prefix.
@@ -1259,9 +1283,12 @@ struct bpf_verifier_env {
 	u32 *walk_insns;		/* the insns that were looked at in each of them */
 	u32 max_arena_stack_depth;	/* of all call chains */
 	struct bpf_verifier_state *cur_state; /* current verifier state */
-	struct bpf_map *used_maps[MAX_USED_MAPS]; /* array of map's used by eBPF program */
-	struct btf_mod_pair used_btfs[MAX_USED_BTFS]; /* array of BTF's used by BPF program */
-	struct bpf_map *insn_array_maps[MAX_USED_MAPS]; /* array of INSN_ARRAY map's to be relocated */
+	struct bpf_map **used_maps;	/* array of map's used by eBPF program */
+	struct btf_mod_pair *used_btfs;	/* array of BTF's used by BPF program */
+	struct bpf_index used_index;	/* address of a map or BTF -> entry of these two */
+	struct bpf_map **insn_array_maps; /* array of INSN_ARRAY map's to be relocated */
+	u32 max_key_size;		/* of all used maps and their inner maps */
+	u32 max_value_size;
 	u32 used_map_cnt;		/* number of used maps */
 	u32 used_btf_cnt;		/* number of used BTF objects */
 	u32 insn_array_map_cnt;		/* number of used maps of type BPF_MAP_TYPE_INSN_ARRAY */
diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
index 40aafceb139e..c16b4a283dbc 100644
--- a/kernel/bpf/cfg.c
+++ b/kernel/bpf/cfg.c
@@ -3,6 +3,7 @@
 #include <linux/bpf.h>
 #include <linux/bpf_verifier.h>
 #include <linux/filter.h>
+#include <linux/hash.h>
 #include <linux/sort.h>
 
 #include "diagnostics.h"
@@ -199,6 +200,44 @@ struct bpf_iarray *bpf_iarray_realloc(struct bpf_iarray *old, size_t n_elem)
 	return new;
 }
 
+static struct bpf_index_slot *index_slot(const struct bpf_index *index, u64 key)
+{
+	u32 i = hash_64(key, index->bits);
+
+	while (index->slots[i].next_val && index->slots[i].key != key)
+		i = (i + 1) & (BIT(index->bits) - 1);
+	return &index->slots[i];
+}
+
+/* Returns the value of 'key', -1 if there is none */
+int bpf_index_find(const struct bpf_index *index, u64 key)
+{
+	return index->cnt ? index_slot(index, key)->next_val - 1 : -1;
+}
+
+/* 'key' is new. At most a half of the slots is taken. */
+int bpf_index_add(struct bpf_index *index, u64 key, u32 val)
+{
+	struct bpf_index old = *index;
+	u32 i;
+
+	if (2 * old.cnt >= BIT(old.bits) - 1) {
+		index->slots = kvcalloc(BIT(old.bits + 2), sizeof(*old.slots), BPF_VERIFIER_GFP);
+		if (!index->slots) {
+			index->slots = old.slots;
+			return -ENOMEM;
+		}
+		index->bits += 2;
+		for (i = 0; old.cnt && i < BIT(old.bits); i++)
+			if (old.slots[i].next_val)
+				*index_slot(index, old.slots[i].key) = old.slots[i];
+		kvfree(old.slots);
+	}
+	*index_slot(index, key) = (struct bpf_index_slot){ key, val + 1 };
+	index->cnt++;
+	return 0;
+}
+
 static int copy_insn_array(struct bpf_map *map, u32 start, u32 end, u32 *items)
 {
 	struct bpf_insn_array_value *value;
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 09abfed83109..1b51f1d97efc 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3429,7 +3429,7 @@ void __bpf_free_used_maps(struct bpf_prog_aux *aux,
 static void bpf_free_used_maps(struct bpf_prog_aux *aux)
 {
 	__bpf_free_used_maps(aux, aux->used_maps, aux->used_map_cnt);
-	kfree(aux->used_maps);
+	kvfree(aux->used_maps);
 }
 
 void __bpf_free_used_btfs(struct btf_mod_pair *used_btfs, u32 len)
@@ -3450,7 +3450,7 @@ void __bpf_free_used_btfs(struct btf_mod_pair *used_btfs, u32 len)
 static void bpf_free_used_btfs(struct bpf_prog_aux *aux)
 {
 	__bpf_free_used_btfs(aux->used_btfs, aux->used_btf_cnt);
-	kfree(aux->used_btfs);
+	kvfree(aux->used_btfs);
 }
 
 static void bpf_prog_free_images(struct work_struct *work)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index a1af95dd315b..9b0268d6715d 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -6291,8 +6291,8 @@ static int bpf_prog_bind_map(union bpf_attr *attr)
 			goto out_unlock;
 		}
 
-	used_maps_new = kmalloc_objs(used_maps_new[0],
-				     prog->aux->used_map_cnt + 1);
+	used_maps_new = kvmalloc_objs(used_maps_new[0],
+				      prog->aux->used_map_cnt + 1);
 	if (!used_maps_new) {
 		ret = -ENOMEM;
 		goto out_unlock;
@@ -6310,7 +6310,7 @@ static int bpf_prog_bind_map(union bpf_attr *attr)
 	prog->aux->used_map_cnt++;
 	prog->aux->used_maps = used_maps_new;
 
-	kfree(used_maps_old);
+	kvfree(used_maps_old);
 
 out_unlock:
 	mutex_unlock(&prog->aux->used_maps_mutex);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d64719c85e6f..b316443548ff 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15407,7 +15407,6 @@ bpf_helper_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_insn *ins
 	case ARG_PTR_TO_MAP_KEY:
 	case ARG_PTR_TO_MAP_VALUE: {
 		bool is_key = base_type(at) == ARG_PTR_TO_MAP_KEY;
-		u64 val;
 		int i, map_reg;
 
 		for (i = 0; i < arg; i++) {
@@ -15443,23 +15442,9 @@ bpf_helper_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_insn *ins
 		 */
 		exact_size = false;
 		access_type |= BPF_READ;
-		val = 0;
-		for (i = 0; i < env->used_map_cnt; i++) {
-			struct bpf_map *map = env->used_maps[i];
-			u32 sz = is_key ? map->key_size : map->value_size;
-
-			if (sz > val)
-				val = sz;
-			if (map->inner_map_meta) {
-				sz = is_key ? map->inner_map_meta->key_size
-					    : map->inner_map_meta->value_size;
-				if (sz > val)
-					val = sz;
-			}
-		}
-		if (!val)
+		size = is_key ? env->max_key_size : env->max_value_size;
+		if (!size)
 			return info;
-		size = val;
 		goto out;
 	}
 	case ARG_PTR_TO_MEM:
@@ -22021,26 +22006,21 @@ static int __add_used_btf(struct bpf_verifier_env *env, struct btf *btf)
 {
 	struct btf_mod_pair *btf_mod;
 	int ret = 0;
-	int i;
 
 	/* check whether we recorded this BTF (and maybe module) already */
-	for (i = 0; i < env->used_btf_cnt; i++)
-		if (env->used_btfs[i].btf == btf)
-			goto ret_put;
+	if (bpf_index_find(&env->used_index, (unsigned long)btf) >= 0)
+		goto ret_put;
 
 	if (env->signature) {
 		verbose(env, "signed program cannot bind any BTF\n");
 		ret = -EACCES;
 		goto ret_put;
 	}
-	if (env->used_btf_cnt >= MAX_USED_BTFS) {
-		verbose(env, "The total number of btfs per program has reached the limit of %u\n",
-			MAX_USED_BTFS);
-		ret = -E2BIG;
+	btf_mod = bpf_table_next(env->used_btfs, env->used_btf_cnt);
+	if (!btf_mod) {
+		ret = -ENOMEM;
 		goto ret_put;
 	}
-
-	btf_mod = &env->used_btfs[env->used_btf_cnt];
 	btf_mod->btf = btf;
 	btf_mod->module = NULL;
 
@@ -22053,8 +22033,7 @@ static int __add_used_btf(struct bpf_verifier_env *env, struct btf *btf)
 		}
 	}
 
-	env->used_btf_cnt++;
-	return 0;
+	return bpf_index_add(&env->used_index, (unsigned long)btf, env->used_btf_cnt++);
 
 ret_put:
 	/* Either error or this BTF was already added */
@@ -22347,6 +22326,8 @@ static int claim_used_maps(struct bpf_verifier_env *env)
 
 		if (map->map_type != BPF_MAP_TYPE_INSN_ARRAY)
 			continue;
+		if (!bpf_table_next(env->insn_array_maps, env->insn_array_map_cnt))
+			return -ENOMEM;
 		err = bpf_insn_array_init(map, env->prog);
 		if (err) {
 			verbose(env, "Failed to properly initialize insn array\n");
@@ -22360,12 +22341,13 @@ static int claim_used_maps(struct bpf_verifier_env *env)
 
 static int __add_used_map(struct bpf_verifier_env *env, struct bpf_map *map)
 {
+	struct bpf_map *inner = map->inner_map_meta ?: map;
 	int i, err;
 
 	/* check whether we recorded this map already */
-	for (i = 0; i < env->used_map_cnt; i++)
-		if (env->used_maps[i] == map)
-			return i;
+	i = bpf_index_find(&env->used_index, (unsigned long)map);
+	if (i >= 0)
+		return i;
 
 	if (env->signature &&
 	    env->prog->aux->sig.verdict == BPF_SIG_VERIFIED) {
@@ -22373,16 +22355,17 @@ static int __add_used_map(struct bpf_verifier_env *env, struct bpf_map *map)
 			map->name);
 		return -EACCES;
 	}
-	if (env->used_map_cnt >= MAX_USED_MAPS) {
-		verbose(env, "The total number of maps per program has reached the limit of %u\n",
-			MAX_USED_MAPS);
-		return -E2BIG;
-	}
 
 	err = check_map_prog_compatibility(env, map, env->prog);
 	if (err)
 		return err;
 
+	if (!bpf_table_next(env->used_maps, env->used_map_cnt) ||
+	    bpf_index_add(&env->used_index, (unsigned long)map, env->used_map_cnt))
+		return -ENOMEM;
+	env->max_key_size = max3(env->max_key_size, map->key_size, inner->key_size);
+	env->max_value_size = max3(env->max_value_size, map->value_size, inner->value_size);
+
 	if (bpf_prog_runs_sleepable(env->prog))
 		atomic64_inc(&map->sleepable_refcnt);
 
@@ -23010,12 +22993,14 @@ static void release_maps(struct bpf_verifier_env *env)
 {
 	__bpf_free_used_maps(env->prog->aux, env->used_maps,
 			     env->used_map_cnt);
+	kvfree(env->used_maps);
 }
 
 /* drop refcnt of maps used by the rejected program */
 static void release_btfs(struct bpf_verifier_env *env)
 {
 	__bpf_free_used_btfs(env->used_btfs, env->used_btf_cnt);
+	kvfree(env->used_btfs);
 }
 
 /* convert pseudo BPF_LD_IMM64 into generic BPF_LD_IMM64 */
@@ -24615,39 +24600,31 @@ static int add_fd_from_fd_array(struct bpf_verifier_env *env, u32 idx, int fd)
 	return PTR_ERR(map);
 }
 
-/*
- * A continuous fd_array is resolved into an in-memory cache with one slot
- * per entry. The bound here is deliberately generous and not derived from
- * the per-program object limits: Duplicate entries /are/ permitted, and
- * the number of distinct maps and BTFs a program can bind is enforced when
- * each entry is resolved by __add_used_map() and __add_used_btf().
- */
-#define MAX_FD_ARRAY_CNT 4096
-
+/* A continuous fd_array is resolved into an in-memory cache with one slot per entry. */
 static int process_fd_array_continuous(struct bpf_verifier_env *env,
 				       bpfptr_t fd_array, u32 cnt)
 {
 	int fd, ret;
 	u32 i;
 
-	if (cnt > MAX_FD_ARRAY_CNT) {
-		verbose(env, "fd_array has too many entries (%u, max %u)\n",
-			cnt, MAX_FD_ARRAY_CNT);
+	if (!env->bpf_capable && cnt > BPF_MAXINSNS) {
+		verbose(env, "fd_array has too many entries (%u, max %u)\n", cnt, BPF_MAXINSNS);
 		return -E2BIG;
 	}
 
-	env->fd_array = kvzalloc_objs(*env->fd_array, cnt, BPF_VERIFIER_GFP);
-	if (!env->fd_array)
-		return -ENOMEM;
-	env->fd_array_cnt = cnt;
 	for (i = 0; i < cnt; i++) {
+		if (bpf_must_abort())
+			return -EINTR;
 		if (copy_from_bpfptr_offset(&fd, fd_array,
 					    (size_t)i * sizeof(fd), sizeof(fd)))
 			return -EFAULT;
+		if (!bpf_table_next(env->fd_array, i))
+			return -ENOMEM;
 		ret = add_fd_from_fd_array(env, i, fd);
 		if (ret)
 			return ret;
 	}
+	env->fd_array_cnt = cnt;
 	return 0;
 }
 
@@ -25557,35 +25534,11 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (ret)
 		goto err_release_maps;
 
-	if (env->used_map_cnt) {
-		/* if program passed verifier, update used_maps in bpf_prog_info */
-		env->prog->aux->used_maps = kmalloc_objs(env->used_maps[0],
-							 env->used_map_cnt,
-							 BPF_VERIFIER_GFP);
-
-		if (!env->prog->aux->used_maps) {
-			ret = -ENOMEM;
-			goto err_release_maps;
-		}
-
-		memcpy(env->prog->aux->used_maps, env->used_maps,
-		       sizeof(env->used_maps[0]) * env->used_map_cnt);
-		env->prog->aux->used_map_cnt = env->used_map_cnt;
-	}
-	if (env->used_btf_cnt) {
-		/* if program passed verifier, update used_btfs in bpf_prog_aux */
-		env->prog->aux->used_btfs = kmalloc_objs(env->used_btfs[0],
-							 env->used_btf_cnt,
-							 BPF_VERIFIER_GFP);
-		if (!env->prog->aux->used_btfs) {
-			ret = -ENOMEM;
-			goto err_release_maps;
-		}
-
-		memcpy(env->prog->aux->used_btfs, env->used_btfs,
-		       sizeof(env->used_btfs[0]) * env->used_btf_cnt);
-		env->prog->aux->used_btf_cnt = env->used_btf_cnt;
-	}
+	/* if program passed verifier, it gets the tables */
+	env->prog->aux->used_maps = env->used_maps;
+	env->prog->aux->used_map_cnt = env->used_map_cnt;
+	env->prog->aux->used_btfs = env->used_btfs;
+	env->prog->aux->used_btf_cnt = env->used_btf_cnt;
 	if (env->used_map_cnt || env->used_btf_cnt) {
 		/* program is valid. Convert pseudo bpf_ld_imm64 into generic
 		 * bpf_ld_imm64 instructions
@@ -25642,6 +25595,8 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	vfree(env->insn_aux_data);
 	bpf_patch_list_free(env);
 	kvfree(env->fd_array);
+	kvfree(env->used_index.slots);
+	kvfree(env->insn_array_maps);
 	bpf_free_scev(env);
 	kvfree(env->walk_insns);
 	bpf_flow_free(env);
diff --git a/tools/testing/selftests/bpf/prog_tests/fd_array.c b/tools/testing/selftests/bpf/prog_tests/fd_array.c
index 3078d8264deb..d7459bd92998 100644
--- a/tools/testing/selftests/bpf/prog_tests/fd_array.c
+++ b/tools/testing/selftests/bpf/prog_tests/fd_array.c
@@ -376,6 +376,11 @@ static void check_fd_array_cnt__fd_array_with_trash(void)
 	if (!ASSERT_EQ(prog_fd, -EINVAL, "prog should have been rejected with -EINVAL"))
 		goto cleanup;
 
+	/* trash 3: the table grows with the entries that are read */
+	prog_fd = load_test_prog((int *)8, 1 << 30);
+	if (!ASSERT_EQ(prog_fd, -EFAULT, "prog should have been rejected with -EFAULT"))
+		goto cleanup;
+
 	/* Validate that the prog is ok if trash is removed */
 	Close(extra_fds[2]);
 	extra_fds[2] = new_btf();
@@ -394,22 +399,27 @@ static void check_fd_array_cnt__fd_array_with_trash(void)
 }
 
 /*
- * Test that a program with too big fd_array can't be loaded.
+ * Test that the numbers of maps, BTFs and entries of fd_array are not limited.
  */
-static void check_fd_array_cnt__fd_array_too_big(void)
+static void check_fd_array_cnt__fd_array_big(void)
 {
-	int extra_fds[65];
-	int prog_fd = -1;
-	int i;
-
-	for (i = 0; i < 65; i++) {
-		extra_fds[i] = new_map();
-		if (!ASSERT_GE(extra_fds[i], 0, "new_map"))
+	static int extra_fds[5000];
+	const int objs = 300;
+	__u32 nr_map_ids = 0;
+	int prog_fd, i, j;
+
+	for (i = 0; i < objs; i++) {
+		extra_fds[i] = i % 2 ? new_map() : new_btf();
+		if (!ASSERT_GE(extra_fds[i], 0, "new_obj"))
 			goto cleanup_fds;
 	}
+	for (j = objs; j < ARRAY_SIZE(extra_fds); j++)
+		extra_fds[j] = extra_fds[j % objs];
 
-	prog_fd = load_test_prog(extra_fds, 65);
-	ASSERT_EQ(prog_fd, -E2BIG, "prog should have been rejected with -E2BIG");
+	prog_fd = load_test_prog(extra_fds, ARRAY_SIZE(extra_fds));
+	if (ASSERT_GE(prog_fd, 0, "prog should have been loaded"))
+		check_expected_map_ids(prog_fd, objs / 2 + 1, NULL, &nr_map_ids);
+	Close(prog_fd);
 
 cleanup_fds:
 	while (i-- > 0)
@@ -436,6 +446,6 @@ void test_fd_array_cnt(void)
 	if (test__start_subtest("fd-array-trash-input"))
 		check_fd_array_cnt__fd_array_with_trash();
 
-	if (test__start_subtest("fd-array-2big"))
-		check_fd_array_cnt__fd_array_too_big();
+	if (test__start_subtest("fd-array-big"))
+		check_fd_array_cnt__fd_array_big();
 }
-- 
2.55.0

