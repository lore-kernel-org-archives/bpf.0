Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com [209.85.167.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72BE299943
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 05:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772169643; cv=none; b=n2bZWgMQbrfqnX6mbpPOlbmmLtyHgH+NKntSpVkRb0ef8ohMRWrL9SEaxo4GkJkNsWovBKU4to99avzk9qEhF5d88FCOglwamCDdqPLsebkmJC8OTZKk+SWtkMtCVhNPOL0QfCzO1UAknXbyiWhLwDEi1vMRtRjU1vjUNkkKYa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772169643; c=relaxed/simple;
	bh=a+be0eLP3MDOlXZK3XW4ugvjalzq/FrnJMai2A+FuSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B9VCAFQbnC/kzDnfAkwirz+vceRnRYs+GreQoS3YLU68ZJMRMTumCv2SuK90gnxzBvTNm5Yfr7/ZjMM0TWQUDnY6JaKOHrqjGNBLv13FuRD+1klZP46l/V5LndaiU88xQzP8d04hxwG+WYR80ZfbLHDK7lzSUydrS1zsKJ4RTkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IbhvrB1R; arc=none smtp.client-ip=209.85.167.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IbhvrB1R"
Received: by mail-oi1-f194.google.com with SMTP id 5614622812f47-4648447e29bso708542b6e.0
        for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 21:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772169640; x=1772774440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QPb2JEK9NVnFGMGPf4w8+t9Svla8cNfgN2zXAGU9dVs=;
        b=IbhvrB1R9KH+qBJZ7PJjkHostc0rJRq9ELjaX3djbB0XSDrR10RuleWmOUGsrC3snQ
         BIes8Pd6rI722DsDXbnbewHfbtFYI8Y1WKFXkB57E4Wi9/RhXn5eL2fe8o/dkw8VAZCx
         ScCya90MtC5p0KWkiy+/N5pGoXrXTGkprjCmEj/GtKxKKplKwJ4Eo2S3pFLGmYTEsks/
         J2ByY5ffduhJY9NfI7wxMAmMhNMgmo2G3bqQxDmU769NVTiGxRi4i3cE4yZvGawvumBZ
         fnWl5Dw+WW4JtPHwtyjuIeq36ld8z5FLmArML0zrhMJ9j+LA2EYZYJrCsoWUBQvOXwSj
         Gu+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772169640; x=1772774440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QPb2JEK9NVnFGMGPf4w8+t9Svla8cNfgN2zXAGU9dVs=;
        b=YY3cbHB/EfVJtRQDYhAxrDZfbK6PRotQFDqwGpQTIWZpnEB+D8e+2rqFvgGgYS57qg
         OwklYkcB5+nwxxGWJFSIOIlpiHZ+xIk0lqgtddQqtX82N0uXvrG1tu5WPeB4SEJ2Ni9d
         85O1suMVlKc2cuNXKEq8OzgUz2lrJelDjZhs3zqq/xLAip1Xq/lPVqV+ccS7JW36d7H1
         +cjcpwhLlgJm4w7WxFsGhheO1q5xW20egLCSuniwA9d+5T2BkpJQfxiKTpve7S9pVPD9
         ucThrNHz4LqDj7l0Yvfd6UbUZVFGyhDUtKH8Cnqsv2mQiUIO7ZCUN/Qe4MbMR6W5L64z
         XeeA==
X-Gm-Message-State: AOJu0YybUF5fyZrCTbFNFdiAZJqzgKjqYHYEaBPaJlqDywNz2/iFwvV2
	fWHI2gdhCIhCZ7IaIqf+YF9wntkibSyh4opa+C3DTpgWZ2aSnM2lPQrsfki/1+rrYUg=
X-Gm-Gg: ATEYQzzNwwA51fr9T74xGKY6OUe+UaZWNh3qRgUQYxFrVVzgs0Dqcp8Y/PoGwHNZPgg
	1hoiQHrwNn8XUN1D1gOM4PKZQqNJbi18y3ee6IbP1LYTG3GrVYmNMsAwv9et1o8jzt01anLlDmS
	Z2/60R25IVtEdFBnbbyLMIV19rd5m4TNz2BsWS6yucYf26mRn1q+nRGwhn/4dwDDixrgcDIm1jn
	3jWlSqdVO8bU2t+d/pcMyhrK6e6GdmO5WtldpLpVBWwuxh0M5A25GJ4g4ByheGt7CcIovMbIfjC
	MK/fD9ZsdP3Uz4NexpUV5W9bHauv0U1G393hiEbAC7fXm4byO439fAiAJAcIqlEDEA0484EDnKI
	Zak9VpalzFccPVq7O3bK/W9mu5GIkhx8VOzQEapMjHoqKXgcAzHJa76oLnS8R4EnCIa3gHZPdHm
	QlNWMvx4jXs/kLa0PlU0aHDD9vAzIlldZoBaZF6jZ+OOsY
X-Received: by 2002:a05:6820:4989:b0:663:12b4:9c81 with SMTP id 006d021491bc7-679faf94d16mr916472eaf.75.1772169640277;
        Thu, 26 Feb 2026 21:20:40 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:47::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4160cf239e0sm3974052fac.1.2026.02.26.21.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 21:20:38 -0800 (PST)
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
Subject: [PATCH bpf v2 2/5] bpf: Lose const-ness of map in map_check_btf()
Date: Thu, 26 Feb 2026 21:20:28 -0800
Message-ID: <20260227052031.3988575-3-memxor@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260227052031.3988575-1-memxor@gmail.com>
References: <20260227052031.3988575-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8002; h=from:subject; bh=a+be0eLP3MDOlXZK3XW4ugvjalzq/FrnJMai2A+FuSs=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBpoSmOIHiA1Cwo9LhTnfv/UQPGbqczIcJUW/jJDyis Cm4uASiJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaaEpjgAKCRBM4MiGSL8RymmBD/ 9YPn+R/JjMajcUyaUs7/vUXDhm9xi1EwR1rEJwpuwagLoh4oBXGS9n/s+wgi7MunvO/1l8PNzD/ETj h3VF4A+ZT1pZ7nTVTLaAct3YYprkPTBcRDNxSQMQE37mpybyYt53nWVLiBEp6SFJUJ4kScBACdGK8w 8wWafw/d5ZvlTW4z58PawIm6E/sSJKidqIJnOfQDmqI1EKWgPQiUcsnijwUa47eyUbRXa0Ffq3xFXe 6RZFwj9RYDTkB4RXMeHgjWwtcUrDnNXJGFgyQJH7ytBZA5RPnvonbWp1WBeqgXBwnRgdwEQ+LFU6QK FFXQ7osdfuLm/0vSltXkW9lgrzRRZjdvsdOrZcMFYnmFRYkwgL1w4vV6gorFu/kaFoFVxG1O9Wa2zV AqYh8U1iaiKqqXA0fxmFOUVQC9ImjEuRUanwQru8Z5Rs8QYhOI9ih9dwfdMapwhi3WuIrxZwH/MVVn 2foyH7PLDwzQv6FVU9ZMdsVN7ZWXeOWAGHC3eTKkwQI6g3BJMj3AGOC8bMaspJQeDKebhT05BWWqEi fTNGGROhW8dvoL2gmGtMzU6klkzUlTfJ5FE4VAQvDb+nS8ZEeWyg/My0/6r7zYnqOcCMyf1PTVYQp0 UZavMGC+D2fyr6nOj/+hFTGtAlVEY4OmjnMEmt+lApxAidRdIaBvLgWs5W4A==
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

