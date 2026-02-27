Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com [209.85.167.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC8D3559C0
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 22:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772232495; cv=none; b=Qd6oqtjSyy9l9pgv3brr8D3zf8p6zwptuap2mER/J+McbW7yfIDjMd5wj7VQIhsyq7hvRA27M4pQZtwNEn/zEnGoMFy+lULPKFXZdZOrpHq6fTqdPxDaB+f0tGOusosAGYgZMnyXq8lJ1F8L6/eJySnjLsk0qHWOvFsuJlj4fPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772232495; c=relaxed/simple;
	bh=a+be0eLP3MDOlXZK3XW4ugvjalzq/FrnJMai2A+FuSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QRW1mieyyZQaIEJju9zpnDns4vXTppVF+89ySMWuJ4vLOyodLQ/E421o6tLyfj21m8QSsIjixwkp8kOYcCQhxRbJGEJHCG3D+LZK7GPjk0ZHAP04vtkCYP7f/DC8AZZlPawTE4L5FVBywnRXwQup/1ZyAbDXFR2Iiv+wVysEH98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OueZkdrX; arc=none smtp.client-ip=209.85.167.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OueZkdrX"
Received: by mail-oi1-f195.google.com with SMTP id 5614622812f47-4638e238094so1634623b6e.3
        for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 14:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772232492; x=1772837292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QPb2JEK9NVnFGMGPf4w8+t9Svla8cNfgN2zXAGU9dVs=;
        b=OueZkdrXZOFrakVA27I1vNHPEgCeyd3wi8replOp9w+1FCRtTsws4arUsBJil02H7g
         wM8ezvjascOC/HzYAGT8cHGzErDQaBg4xaIeATsI5xZPjk0WD4ZEa8iVCnN0Hdhu664t
         ZruQ44IjN1gqBdcsJ/ejvfkY8ft4i3E/BD9eL2eD27OJAaGyLSN2c5uOnnwAwq4ajWhe
         /d8NNZgTyXYXThCEXlrjrrq8yu8Q4p4/4lCWE/VLJEQOVSTbz07M1qglbFNa9y78ekdN
         TajQV/HOwr+TsRS5YDrPc5cvKag2t6Q3zzCqE4dkDvg+0XSjdSFfUH9B5uvYoRxlFavp
         JFHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772232492; x=1772837292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QPb2JEK9NVnFGMGPf4w8+t9Svla8cNfgN2zXAGU9dVs=;
        b=gqhtMZchBu6QMlmO3OGtxT6UB2adnQh1R3kJucsQqO5MWAvydGzgSjC+ARSM7nBR93
         L++k8Y8JdnSWWkNgUlCulhrlUJQ3xUUti/25bj06Dg59cHsa2/z62RKk2byAy9aofAgj
         I0v7SpRjTASIr9Xf96dgAbOvCWiSir2PGrvzYrKmMVX+QYtvE0YI/+7/Sds9th5zLSVP
         hEprebDjrRML/mSuyd2sseKIKkNN5stj7HyrhB9zbQbcEQ64/RPctq9VT1AeXhZUfcK8
         W783BvP1HhHpD03uyopHjAvsIXQAJ9YJBGDtB4H0+kxJY/17gRQDpaDbsKZQyyj2wFBB
         soGA==
X-Gm-Message-State: AOJu0Yz0Y7eE9Fu10/euc2U633Agz+IJEcTTdhK4j7nWDW6kutQWlWrQ
	ERTPSV/odeRbAT47iMkA1OVEkcxWlLAvET0Sx+UBNaGhNmn+wL60LGs8o7wFT1A0+fI=
X-Gm-Gg: ATEYQzxfkn9FAwIRWqdnEUCBYpIoLQZWSyS4/wnx6zZIqZq9Sq9+R0ViQti7FT9y3ue
	aQ96p21kMsoFkkmLbo+W68Jngp/nR9kZ6S5l5YBNZFdi+abD/MgZ00rpQL7gBMg2Cr2xh876efB
	74A17DYBpFt3fBQU8ZCrTi6NBKaoTgB6hun+oXUw2Ejo0NDS9M6zkci8dNPK6NLcILc/HvgAZSY
	uZRO0YrykPJHMY8lOsFfVNaPS9AUDdsn4npsX69UE/+1zzak8PWkVPTY6eDB+AsBPNfsB7Hqb75
	tdBQMIy39xHTgPAr5VrjvbXEv1RCmdvwXdrFq3ZxNBCNQ6dB54V9bQTiheKPf1rb4KYjHicJWLC
	Xwr5OA1NPQBzWZ1MlMq9XyJX5Nz2Pko99FEe3dOoLgPnGuLRWh6tIlmBTzrGuP7gkZW2guauvBZ
	6pq2/4qMkv34NzLZZMmKzUlfQP1/MAGVcwj6wbHz8hWI3F4oI3SZ34Z9o=
X-Received: by 2002:a05:6808:c18e:b0:44f:e912:eaa3 with SMTP id 5614622812f47-464beb482edmr2826420b6e.32.1772232492543;
        Fri, 27 Feb 2026 14:48:12 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:54::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4160d211b82sm5378085fac.13.2026.02.27.14.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 14:48:11 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v3 2/5] bpf: Lose const-ness of map in map_check_btf()
Date: Fri, 27 Feb 2026 14:48:02 -0800
Message-ID: <20260227224806.646888-3-memxor@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260227224806.646888-1-memxor@gmail.com>
References: <20260227224806.646888-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8002; h=from:subject; bh=a+be0eLP3MDOlXZK3XW4ugvjalzq/FrnJMai2A+FuSs=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBpoh0rIHiA1Cwo9LhTnfv/UQPGbqczIcJUW/jJDyis Cm4uASiJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaaIdKwAKCRBM4MiGSL8Rygb7D/ 49tAXct1P8cTkINYvdTtULSnbtkSgierLaXH3W1uYWP8bmcACf9UcixYZjo9GiNEzba1Yu8VvLk2K9 GjUVlP0kCpB97jXmDmsqsXXbe3xW1/Kgw++PCj/gDjGBgsd8mTtg+gBP/JsPxH8wbbyKZ8w1zyuGJE pQBvuaXCcCbSciRcffXM2U6dgXYZqxIZJ7MZL5b9PsDx311HzRJIPipaG9rCZYffujBqRzbqecFwqu 1NCOJqC99p62ZMv49faow5Yj/j5vLNhyGyxwcpVnZ/eq8mtR4aptoD+bfu0/rih7lLFpqJhtO9Eg8h S1mfEskl0qRhNrZRIkdgY20/quNzKQ8g72//KetWnqNemAn8jRPXaUeybIJ7+xslCJTw4mQwrXNGXa CeAdaO86W4dxMPdLt3fUbwfB+beCVEDbFUGfhg/ROkW8Ksaif8f+ATZEPhA++JyKezj7CObEH75u09 rhdFMhZJ30aTapavAiy+NYhVtHIR446/US7p7AgqnX8DNWwWUkuw/I6um2mzF7eyukipWOCcelgNd7 BurTzpHfbKa6VJeYbx47Q/mk7A7R6dCDuDy6n5DMGSuGJ/w6n4FYyx1udJqGFdEttmai2ECVDJqzfp 7WxXYPFuSwk6NzzNwLyOq1wbkshk0CG0qWqO6TfSjAXYlOjSuH9/fJesl08w==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

BPF hash map may now use the map_check_btf() callback to decide whether
to set a dtor on its bpf_mem_alloc or not. Unlike C++ where members can
opt out of const-ness using mutable, we must lose the const qualifier on
the callback such that we can avoid the ugly cast. Make the change and
adjust all existing users, and lose the comment in hashtab.c.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h               | 4 ++--
 include/linux/bpf_local_storage.h | 2 +-
 kernel/bpf/arena.c                | 2 +-
 kernel/bpf/arraymap.c             | 2 +-
 kernel/bpf/bloom_filter.c         | 2 +-
 kernel/bpf/bpf_insn_array.c       | 2 +-
 kernel/bpf/bpf_local_storage.c    | 2 +-
 kernel/bpf/hashtab.c              | 9 ++++-----
 kernel/bpf/local_storage.c        | 2 +-
 kernel/bpf/lpm_trie.c             | 2 +-
 kernel/bpf/syscall.c              | 2 +-
 11 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index b78b53198a2e..05b34a6355b0 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -124,7 +124,7 @@ struct bpf_map_ops {
 	u32 (*map_fd_sys_lookup_elem)(void *ptr);
 	void (*map_seq_show_elem)(struct bpf_map *map, void *key,
 				  struct seq_file *m);
-	int (*map_check_btf)(const struct bpf_map *map,
+	int (*map_check_btf)(struct bpf_map *map,
 			     const struct btf *btf,
 			     const struct btf_type *key_type,
 			     const struct btf_type *value_type);
@@ -656,7 +656,7 @@ static inline bool bpf_map_support_seq_show(const struct bpf_map *map)
 		map->ops->map_seq_show_elem;
 }
 
-int map_check_no_btf(const struct bpf_map *map,
+int map_check_no_btf(struct bpf_map *map,
 		     const struct btf *btf,
 		     const struct btf_type *key_type,
 		     const struct btf_type *value_type);
diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index 85efa9772530..8157e8da61d4 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -176,7 +176,7 @@ u32 bpf_local_storage_destroy(struct bpf_local_storage *local_storage);
 void bpf_local_storage_map_free(struct bpf_map *map,
 				struct bpf_local_storage_cache *cache);
 
-int bpf_local_storage_map_check_btf(const struct bpf_map *map,
+int bpf_local_storage_map_check_btf(struct bpf_map *map,
 				    const struct btf *btf,
 				    const struct btf_type *key_type,
 				    const struct btf_type *value_type);
diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 144f30e740e8..f355cf1c1a16 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -303,7 +303,7 @@ static long arena_map_update_elem(struct bpf_map *map, void *key,
 	return -EOPNOTSUPP;
 }
 
-static int arena_map_check_btf(const struct bpf_map *map, const struct btf *btf,
+static int arena_map_check_btf(struct bpf_map *map, const struct btf *btf,
 			       const struct btf_type *key_type, const struct btf_type *value_type)
 {
 	return 0;
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 26763df6134a..33de68c95ad8 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -548,7 +548,7 @@ static void percpu_array_map_seq_show_elem(struct bpf_map *map, void *key,
 	rcu_read_unlock();
 }
 
-static int array_map_check_btf(const struct bpf_map *map,
+static int array_map_check_btf(struct bpf_map *map,
 			       const struct btf *btf,
 			       const struct btf_type *key_type,
 			       const struct btf_type *value_type)
diff --git a/kernel/bpf/bloom_filter.c b/kernel/bpf/bloom_filter.c
index 35e1ddca74d2..b73336c976b7 100644
--- a/kernel/bpf/bloom_filter.c
+++ b/kernel/bpf/bloom_filter.c
@@ -180,7 +180,7 @@ static long bloom_map_update_elem(struct bpf_map *map, void *key,
 	return -EINVAL;
 }
 
-static int bloom_map_check_btf(const struct bpf_map *map,
+static int bloom_map_check_btf(struct bpf_map *map,
 			       const struct btf *btf,
 			       const struct btf_type *key_type,
 			       const struct btf_type *value_type)
diff --git a/kernel/bpf/bpf_insn_array.c b/kernel/bpf/bpf_insn_array.c
index c0286f25ca3c..a2f84afe6f7c 100644
--- a/kernel/bpf/bpf_insn_array.c
+++ b/kernel/bpf/bpf_insn_array.c
@@ -98,7 +98,7 @@ static long insn_array_delete_elem(struct bpf_map *map, void *key)
 	return -EINVAL;
 }
 
-static int insn_array_check_btf(const struct bpf_map *map,
+static int insn_array_check_btf(struct bpf_map *map,
 			      const struct btf *btf,
 			      const struct btf_type *key_type,
 			      const struct btf_type *value_type)
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index b28f07d3a0db..2bf5ca5ae0df 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -797,7 +797,7 @@ int bpf_local_storage_map_alloc_check(union bpf_attr *attr)
 	return 0;
 }
 
-int bpf_local_storage_map_check_btf(const struct bpf_map *map,
+int bpf_local_storage_map_check_btf(struct bpf_map *map,
 				    const struct btf *btf,
 				    const struct btf_type *key_type,
 				    const struct btf_type *value_type)
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 582f0192b7e1..bc6bc8bb871d 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -496,10 +496,10 @@ static void htab_dtor_ctx_free(void *ctx)
 	kfree(ctx);
 }
 
-static int htab_set_dtor(const struct bpf_htab *htab, void (*dtor)(void *, void *))
+static int htab_set_dtor(struct bpf_htab *htab, void (*dtor)(void *, void *))
 {
 	u32 key_size = htab->map.key_size;
-	const struct bpf_mem_alloc *ma;
+	struct bpf_mem_alloc *ma;
 	struct htab_btf_record *hrec;
 	int err;
 
@@ -518,12 +518,11 @@ static int htab_set_dtor(const struct bpf_htab *htab, void (*dtor)(void *, void
 		return err;
 	}
 	ma = htab_is_percpu(htab) ? &htab->pcpu_ma : &htab->ma;
-	/* Kinda sad, but cast away const-ness since we change ma->dtor. */
-	bpf_mem_alloc_set_dtor((struct bpf_mem_alloc *)ma, dtor, htab_dtor_ctx_free, hrec);
+	bpf_mem_alloc_set_dtor(ma, dtor, htab_dtor_ctx_free, hrec);
 	return 0;
 }
 
-static int htab_map_check_btf(const struct bpf_map *map, const struct btf *btf,
+static int htab_map_check_btf(struct bpf_map *map, const struct btf *btf,
 			      const struct btf_type *key_type, const struct btf_type *value_type)
 {
 	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index 1ccbf28b2ad9..8fca0c64f7b1 100644
--- a/kernel/bpf/local_storage.c
+++ b/kernel/bpf/local_storage.c
@@ -364,7 +364,7 @@ static long cgroup_storage_delete_elem(struct bpf_map *map, void *key)
 	return -EINVAL;
 }
 
-static int cgroup_storage_check_btf(const struct bpf_map *map,
+static int cgroup_storage_check_btf(struct bpf_map *map,
 				    const struct btf *btf,
 				    const struct btf_type *key_type,
 				    const struct btf_type *value_type)
diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
index 1adeb4d3b8cf..0f57608b385d 100644
--- a/kernel/bpf/lpm_trie.c
+++ b/kernel/bpf/lpm_trie.c
@@ -751,7 +751,7 @@ static int trie_get_next_key(struct bpf_map *map, void *_key, void *_next_key)
 	return err;
 }
 
-static int trie_check_btf(const struct bpf_map *map,
+static int trie_check_btf(struct bpf_map *map,
 			  const struct btf *btf,
 			  const struct btf_type *key_type,
 			  const struct btf_type *value_type)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 0378e83b4099..274039e36465 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1234,7 +1234,7 @@ int bpf_obj_name_cpy(char *dst, const char *src, unsigned int size)
 }
 EXPORT_SYMBOL_GPL(bpf_obj_name_cpy);
 
-int map_check_no_btf(const struct bpf_map *map,
+int map_check_no_btf(struct bpf_map *map,
 		     const struct btf *btf,
 		     const struct btf_type *key_type,
 		     const struct btf_type *value_type)
-- 
2.47.3

