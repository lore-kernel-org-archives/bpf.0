Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792478149;
	b=iI/TW8rket1XLm52KD8DpW6LfWzd7fy9GsM2bLoWEeW5fOInT7OG+PRigaQnxJ6eFoPd
	 xD00Z5HLLsMAiHNZ0sFfxJFwhlf89lRO/61DLk5+IaO0dcM4aV+Gx68javpLr40i1Woss
	 jYhIAR8Kot1Tklwwj3u6CFt5R1IZZJ9RQdMkaEidBPQ5MQ/leXokV5pprZg5DISGFrDfv
	 ZeMjn4U4dTDomp8mq5PdODKulu7Rz7YAa0JNUqF47RRaRypYt6crmg4OT6owQM9O+WG7u
	 s2oxSJ13/FXk0J3koz/Qqvvm5NjxgS82MX2oxwuttPZHzbE5kqyM6z37nIfYhiGgaPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792478149;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=6V94UZGcvxRhySlpmKr6KDy7Ay7ek5MflZMdTT+83LI=;
	b=4qKE2Nr+q+JLZKGs7cVJ636Pi0hMbNxaKEuuIHzQCuS8gplW28jFwkrnYckIPIInQY1g
	 W2Ool/kkUGDvezf6m+eD2UOqMgXFz4NC+nXbDVP+Oc016Y3qkqCa7yizLdQa5ctQxqDiJ
	 r1tUfocKPeGPcNS0tnJF4np8zFJUZp4Y4SnwrXdrRH9MzEKLgVqnU2zllhf4Iu+wbuBcy
	 GUsovzyBqXwgyxQ03udxSE82uoAn3XqSEf1+DD0CzdOD52d4Soj9s1k/gf+pjf7HnMq87
	 7CZ2sf0q48uDcOkk2S6adop1/GLmdvVnGslD87SzVMgGxpdkqUCO0Z7vSa86V9Ztzyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=M8ZfGt7X;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B185606A319
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 06:35:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B185606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=M8ZfGt7X
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-35cd4e8bdbdso6994000eec.1
        for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 23:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1792478148; x=1793082948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6V94UZGcvxRhySlpmKr6KDy7Ay7ek5MflZMdTT+83LI=;
        b=M8ZfGt7XzBgHjfaJjwg7A7651d8XtZPHnbuPrdDQ6Vpc5oBpPkXXp23KwHIgNS7RtU
         I2l9pBYtEZuVii0szh0QhGBiNZmuKS43BFUbbbqZmU2DRZ6e5ZKqXYa4Goomn0FB8OBm
         4otDrAqAG2L3Hoz+heERyfgwI87tPJUox9ov1MzUeSLrtizkr8G0Qx/YEuA3hj9OR7tl
         +gqbDy+2clEWkRC/n+0PhqLqabsBv6rf07W7dx4/WOEXIpJJ/F6+60+iKV/nYQ6jjh8e
         wjJITOAN2ENDXLeH1nTin9dr5z7T3L4Msla802QCOPayXaxjlsSF1+Vo/V+MLaYCMjcN
         oUEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792478148; x=1793082948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6V94UZGcvxRhySlpmKr6KDy7Ay7ek5MflZMdTT+83LI=;
        b=Onp2tC131bRUYx5Zlw9/2uxSCOARc49kzv4GiXGahrariHY2fXSxJ8XnO6zMRVbj4v
         Dn/5MUsVt83v5rkWD0uYQd0icKdURlL6j7o61I75e922Cvk4Q6RNgAvJLJ4hl2gnHRbh
         lOaspUaQrka/zb8q5PgV2kqTORTwgTx1J58Gupw03mUWI+7CWVyc+SEVHc2Ag8hr17/R
         KAgS/4hNp4SQTsAO6zTPAHeSCUBmTY/i17b3fgBDoQrkBBUsO7tni0TsP64zu/tax6HC
         wakE7yca4pA8s9/ABeDaPywpkYnXootevkZzLIMwBowbbbilp3q94/Zthb+oxoUpOMq3
         7htw==
X-Forwarded-Encrypted: i=1; AKwUvBw1m51aOFk/uHqn10OEoscAAke003duin7dLd8feCl7ovYm7X3Os4fREDtIZZAS+bdFP9E=@vger.kernel.org
X-Gm-Message-State: AFq9FYIW4MhwgskZ3wbGl/XoyOknM7gXWmYUW5rRSJkseR3ozqnjSjUi
	AO6nyqOgmSUjqsuTaXk1FczIB5Iipi+0LLqGHXHKyaf8MA/QAObnDKtJpF21uh17+FlB
X-Gm-Gg: AYBFou1BDh2ouCR/dzeCI1UsFyWa0SABPiLUH3gOLPQhj9TA87BfNPhREbaS+cW3uGq
	0EN/6MuCWJ27rFQfhQYHKCxOmb0/3OQcerlO7juk44aYpepj9+rzJZ0+It8qAHnx/P4fhB17kgZ
	dHU4feXQVDtH5c3XKg1Vzill2BkzZh3BxD/qHtDD7el9xiqwlP+xVsAXJTeTEdA8ytglF1hZXPO
	DDCCw9mwdQGHGV23a4+Q3x40zuHSd8Ll6gvTEciGmq56sUycoYkE+Mk8PgKBkFZaBpNefAmDe8n
	i7MrFmrgIuVG8QL5a9Itje30n+rpWcaOvvY/ABz0LWERkACyffdgNDmIP4RSLsgIVls7PPX6Y8g
	iEiKoNIyxb8bGBvcceOzku2+HnSNglJ4esCkcgjr1FmI8Fzgjiin3lEXAmkHEb81V03Sh2Y98hH
	6jibO32PsPD2c5K1CSm7DD6Exdp7E5Tw0YLkZxLAO63jOPztagDSYGM7I1AksXplsfD+gYWZkg
X-Received: by 2002:a05:7301:2f2e:b0:35b:b3fa:40f7 with SMTP id 5a478bee46e88-361a33234d1mr13222406eec.38.1792478148023;
        Mon, 19 Oct 2026 23:35:48 -0700 (PDT)
Received: from Roxy.sysu.edu.cn ([203.175.14.54])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36632d8b273sm2618192eec.15.2026.10.19.23.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 23:35:47 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: ameryhung@gmail.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	llvm@lists.linux.dev
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	john.fastabend@gmail.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	nathan@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com,
	zhilinz@nebusec.ai,
	menglong8.dong@gmail.com,
	bestswngs@gmail.com,
	mattbobrowski@google.com,
	vega@nebusec.ai,
	sashiko-bot@kernel.org
Subject: [PATCH bpf v2 1/1] bpf: reject raw iteration over managed map fields
Date: Tue, 20 Oct 2026 14:35:24 +0800
Message-ID: <96a6b5dcf721e49c049662cc269d8ac8c389b6af.1792217106.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1792217106.git.zhilinz@nebusec.ai>
References: <cover.1792217106.git.zhilinz@nebusec.ai>
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

BPF map iterators expose values as writable PTR_TO_BUF memory. Attach-time
validation bounds maximum access by value_size, but does not account for
BTF-managed fields in map values. Direct buffer accesses can therefore read
or overwrite fields such as __kptr without the verifier's ownership checks.

For bpf_map_elem and bpf_sk_storage_map iterators, limit value access to
the prefix before the first managed field. Since max_rdwr_access is an
exclusive end offset and record fields are sorted, accesses ending at the
first managed field remain available while accesses reaching it are denied.

Revalidate the replacement program against the map associated with an
iterator link before bpf_link_update() swaps programs. Add selftests for
allowed prefix access, rejected managed-field reads and writes, and link
updates that introduce managed-field access.

Fixes: 9db44fdd8105 ("bpf: Support kptrs in local storage maps")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Link: https://lore.kernel.org/all/1fa798d444efac579e91ee0716e228902a8f9afe.1791980149.git.zhilinz@nebusec.ai/
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/cover.1791980149.git.zhilinz@nebusec.ai?part=1
Suggested-by: Amery Hung <ameryhung@gmail.com>
Assisted-by: LLM
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
---
changes in v2:
- Cover bpf_map_elem in addition to bpf_sk_storage_map iterators.
- Allow access to ordinary value fields before the first managed field.
- Revalidate replacement programs against the attached map on
  bpf_link_update().
- Add selftests for allowed prefix access, rejected kptr reads/writes, and
  replacement-program validation for both iterator targets.
- Address the Sashiko link-update finding and Amery Hung's review comments.
- v1 Link: https://lore.kernel.org/all/1fa798d444efac579e91ee0716e228902a8f9afe.1791980149.git.zhilinz@nebusec.ai/

 include/linux/bpf.h                           |   3 +
 kernel/bpf/bpf_iter.c                         |   9 +
 kernel/bpf/map_iter.c                         |  56 ++++--
 net/core/bpf_sk_storage.c                     |  34 +++-
 .../selftests/bpf/prog_tests/bpf_iter.c       | 187 ++++++++++++++++++
 .../bpf/progs/bpf_iter_bpf_sk_storage_map.c   | 113 +++++++++++
 6 files changed, 377 insertions(+), 25 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 0ecb9418dfbd6..b6864779096df 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3007,6 +3007,8 @@ struct bpf_iter_aux_info {
 typedef int (*bpf_iter_attach_target_t)(struct bpf_prog *prog,
 					union bpf_iter_link_info *linfo,
 					struct bpf_iter_aux_info *aux);
+typedef int (*bpf_iter_validate_prog_t)(struct bpf_prog *prog,
+					const struct bpf_iter_aux_info *aux);
 typedef void (*bpf_iter_detach_target_t)(struct bpf_iter_aux_info *aux);
 typedef void (*bpf_iter_show_fdinfo_t) (const struct bpf_iter_aux_info *aux,
 					struct seq_file *seq);
@@ -3024,6 +3026,7 @@ enum bpf_iter_feature {
 struct bpf_iter_reg {
 	const char *target;
 	bpf_iter_attach_target_t attach_target;
+	bpf_iter_validate_prog_t validate_prog;
 	bpf_iter_detach_target_t detach_target;
 	bpf_iter_show_fdinfo_t show_fdinfo;
 	bpf_iter_fill_link_info_t fill_link_info;
diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index b40eb404adab9..765148de64d65 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -409,6 +409,8 @@ static int bpf_iter_link_replace(struct bpf_link *link,
 				 struct bpf_prog *new_prog,
 				 struct bpf_prog *old_prog)
 {
+	struct bpf_iter_link *iter_link =
+		container_of(link, struct bpf_iter_link, link);
 	int ret = 0;
 
 	mutex_lock(&link_mutex);
@@ -424,6 +426,13 @@ static int bpf_iter_link_replace(struct bpf_link *link,
 		goto out_unlock;
 	}
 
+	if (iter_link->tinfo->reg_info->validate_prog) {
+		ret = iter_link->tinfo->reg_info->validate_prog(new_prog,
+								 &iter_link->aux);
+		if (ret)
+			goto out_unlock;
+	}
+
 	old_prog = xchg(&link->prog, new_prog);
 	bpf_prog_put(old_prog);
 
diff --git a/kernel/bpf/map_iter.c b/kernel/bpf/map_iter.c
index c19b360bad9ea..04cf255587aa8 100644
--- a/kernel/bpf/map_iter.c
+++ b/kernel/bpf/map_iter.c
@@ -97,25 +97,15 @@ static struct bpf_iter_reg bpf_map_reg_info = {
 	.seq_info		= &bpf_map_seq_info,
 };
 
-static int bpf_iter_attach_map(struct bpf_prog *prog,
-			       union bpf_iter_link_info *linfo,
-			       struct bpf_iter_aux_info *aux)
+static int bpf_iter_map_elem_check_prog(struct bpf_prog *prog,
+					struct bpf_map *map)
 {
 	u32 key_acc_size, value_acc_size, key_size, value_size;
-	struct bpf_map *map;
 	bool is_percpu = false;
 	int err = -EINVAL;
 
-	if (!linfo->map.map_fd)
-		return -EBADF;
-
-	map = bpf_map_get_with_uref(linfo->map.map_fd);
-	if (IS_ERR(map))
-		return PTR_ERR(map);
-	if (map->excl_prog_sha) {
-		err = -EPERM;
-		goto put_map;
-	}
+	if (map->excl_prog_sha)
+		return -EPERM;
 
 	if (map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
 	    map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH ||
@@ -125,7 +115,7 @@ static int bpf_iter_attach_map(struct bpf_prog *prog,
 		 map->map_type != BPF_MAP_TYPE_LRU_HASH &&
 		 map->map_type != BPF_MAP_TYPE_ARRAY &&
 		 map->map_type != BPF_MAP_TYPE_RHASH)
-		goto put_map;
+		return err;
 
 	key_acc_size = prog->aux->max_rdonly_access;
 	value_acc_size = prog->aux->max_rdwr_access;
@@ -135,10 +125,39 @@ static int bpf_iter_attach_map(struct bpf_prog *prog,
 	else
 		value_size = round_up(map->value_size, 8) * num_possible_cpus();
 
-	if (key_acc_size > key_size || value_acc_size > value_size) {
-		err = -EACCES;
+	if (key_acc_size > key_size || value_acc_size > value_size)
+		return -EACCES;
+
+	/* Fields are sorted by offset; max_rdwr_access is an exclusive end. */
+	if (map->record && value_acc_size > map->record->fields[0].offset)
+		return -EACCES;
+
+	return 0;
+}
+
+static int bpf_iter_map_elem_validate_prog(struct bpf_prog *prog,
+					   const struct bpf_iter_aux_info *aux)
+{
+	return bpf_iter_map_elem_check_prog(prog, aux->map);
+}
+
+static int bpf_iter_attach_map(struct bpf_prog *prog,
+			       union bpf_iter_link_info *linfo,
+			       struct bpf_iter_aux_info *aux)
+{
+	struct bpf_map *map;
+	int err;
+
+	if (!linfo->map.map_fd)
+		return -EBADF;
+
+	map = bpf_map_get_with_uref(linfo->map.map_fd);
+	if (IS_ERR(map))
+		return PTR_ERR(map);
+
+	err = bpf_iter_map_elem_check_prog(prog, map);
+	if (err)
 		goto put_map;
-	}
 
 	aux->map = map;
 	return 0;
@@ -172,6 +191,7 @@ DEFINE_BPF_ITER_FUNC(bpf_map_elem, struct bpf_iter_meta *meta,
 static const struct bpf_iter_reg bpf_map_elem_reg_info = {
 	.target			= "bpf_map_elem",
 	.attach_target		= bpf_iter_attach_map,
+	.validate_prog		= bpf_iter_map_elem_validate_prog,
 	.detach_target		= bpf_iter_detach_map,
 	.show_fdinfo		= bpf_iter_map_show_fdinfo,
 	.fill_link_info		= bpf_iter_map_fill_link_info,
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index 1d295a8769fad..ffbcfab9a71c3 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -846,12 +846,35 @@ static void bpf_iter_fini_sk_storage_map(void *priv_data)
 	bpf_map_put_with_uref(seq_info->map);
 }
 
+static int bpf_iter_sk_storage_map_check_prog(struct bpf_prog *prog,
+					      struct bpf_map *map)
+{
+	if (map->map_type != BPF_MAP_TYPE_SK_STORAGE)
+		return -EINVAL;
+
+	if (prog->aux->max_rdwr_access > map->value_size)
+		return -EACCES;
+
+	/* Fields are sorted by offset; max_rdwr_access is an exclusive end. */
+	if (map->record &&
+	    prog->aux->max_rdwr_access > map->record->fields[0].offset)
+		return -EACCES;
+
+	return 0;
+}
+
+static int bpf_iter_sk_storage_map_validate_prog(struct bpf_prog *prog,
+						 const struct bpf_iter_aux_info *aux)
+{
+	return bpf_iter_sk_storage_map_check_prog(prog, aux->map);
+}
+
 static int bpf_iter_attach_map(struct bpf_prog *prog,
 			       union bpf_iter_link_info *linfo,
 			       struct bpf_iter_aux_info *aux)
 {
 	struct bpf_map *map;
-	int err = -EINVAL;
+	int err;
 
 	if (!linfo->map.map_fd)
 		return -EBADF;
@@ -860,13 +883,9 @@ static int bpf_iter_attach_map(struct bpf_prog *prog,
 	if (IS_ERR(map))
 		return PTR_ERR(map);
 
-	if (map->map_type != BPF_MAP_TYPE_SK_STORAGE)
-		goto put_map;
-
-	if (prog->aux->max_rdwr_access > map->value_size) {
-		err = -EACCES;
+	err = bpf_iter_sk_storage_map_check_prog(prog, map);
+	if (err)
 		goto put_map;
-	}
 
 	aux->map = map;
 	return 0;
@@ -898,6 +917,7 @@ static const struct bpf_iter_seq_info iter_seq_info = {
 static struct bpf_iter_reg bpf_sk_storage_map_reg_info = {
 	.target			= "bpf_sk_storage_map",
 	.attach_target		= bpf_iter_attach_map,
+	.validate_prog		= bpf_iter_sk_storage_map_validate_prog,
 	.detach_target		= bpf_iter_detach_map,
 	.show_fdinfo		= bpf_iter_map_show_fdinfo,
 	.fill_link_info		= bpf_iter_map_fill_link_info,
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
index c69080ca14f5a..ef12fd0a2ac1c 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
@@ -1400,6 +1400,191 @@ static void test_bpf_sk_storage_map(void)
 	bpf_iter_bpf_sk_storage_map__destroy(skel);
 }
 
+struct managed_value {
+	__u64 prefix;
+	__u64 ptr;
+};
+
+static struct bpf_link *attach_managed_map_iter(struct bpf_program *prog,
+						int map_fd)
+{
+	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
+	union bpf_iter_link_info linfo = {};
+
+	linfo.map.map_fd = map_fd;
+	opts.link_info = &linfo;
+	opts.link_info_len = sizeof(linfo);
+	return bpf_program__attach_iter(prog, &opts);
+}
+
+static int read_managed_map_iter(struct bpf_link *link)
+{
+	char buf[64];
+	int iter_fd, len, err = 0;
+
+	iter_fd = bpf_iter_create(bpf_link__fd(link));
+	if (iter_fd < 0)
+		return -errno;
+
+	while ((len = read(iter_fd, buf, sizeof(buf))) > 0)
+		;
+	if (len < 0)
+		err = -errno;
+	close(iter_fd);
+	return err;
+}
+
+static void test_managed_map_elem_iter(struct bpf_iter_bpf_sk_storage_map *skel)
+{
+	struct managed_value value = { .prefix = 10 };
+	__u32 key = 1;
+	int map_fd, err;
+	struct bpf_link *link;
+
+	map_fd = bpf_map__fd(skel->maps.managed_hash_map);
+	err = bpf_map_update_elem(map_fd, &key, &value, BPF_ANY);
+	if (!ASSERT_OK(err, "hash_map_update"))
+		return;
+
+	link = attach_managed_map_iter(skel->progs.map_iter_prefix, map_fd);
+	if (!ASSERT_OK_PTR(link, "hash_prefix_attach"))
+		return;
+	err = read_managed_map_iter(link);
+	bpf_link__destroy(link);
+	if (!ASSERT_OK(err, "hash_prefix_iter"))
+		return;
+
+	err = bpf_map_lookup_elem(map_fd, &key, &value);
+	if (!ASSERT_OK(err, "hash_prefix_lookup") ||
+	    !ASSERT_EQ(value.prefix, 11, "hash_prefix_value"))
+		return;
+
+	link = attach_managed_map_iter(skel->progs.map_iter_no_access, map_fd);
+	if (!ASSERT_OK_PTR(link, "hash_no_access_attach"))
+		return;
+	err = bpf_link__update_program(link, skel->progs.map_iter_write_kptr);
+	if (!ASSERT_EQ(err, -EACCES, "hash_link_update_kptr"))
+		goto out;
+	err = bpf_link__update_program(link, skel->progs.map_iter_prefix);
+	if (!ASSERT_OK(err, "hash_link_update_prefix"))
+		goto out;
+	err = read_managed_map_iter(link);
+	if (!ASSERT_OK(err, "hash_updated_iter"))
+		goto out;
+	err = bpf_map_lookup_elem(map_fd, &key, &value);
+	if (!ASSERT_OK(err, "hash_updated_lookup") ||
+	    !ASSERT_EQ(value.prefix, 12, "hash_updated_value"))
+		goto out;
+
+	bpf_link__destroy(link);
+	link = attach_managed_map_iter(skel->progs.map_iter_read_kptr, map_fd);
+	err = libbpf_get_error(link);
+	if (!ASSERT_EQ(err, -EACCES, "hash_read_kptr_attach")) {
+		if (!err)
+			bpf_link__destroy(link);
+		return;
+	}
+
+	link = attach_managed_map_iter(skel->progs.map_iter_write_kptr, map_fd);
+	err = libbpf_get_error(link);
+	if (!ASSERT_EQ(err, -EACCES, "hash_write_kptr_attach")) {
+		if (!err)
+			bpf_link__destroy(link);
+	}
+	return;
+
+out:
+	bpf_link__destroy(link);
+}
+
+static void test_managed_sk_storage_iter(struct bpf_iter_bpf_sk_storage_map *skel)
+{
+	struct managed_value value = { .prefix = 20 };
+	int sock_fd, map_fd, err;
+	struct bpf_link *link;
+
+	sock_fd = socket(AF_INET6, SOCK_STREAM, 0);
+	if (!ASSERT_GE(sock_fd, 0, "managed_storage_socket"))
+		return;
+
+	map_fd = bpf_map__fd(skel->maps.managed_sk_storage_map);
+	err = bpf_map_update_elem(map_fd, &sock_fd, &value, BPF_NOEXIST);
+	if (!ASSERT_OK(err, "storage_map_update"))
+		goto out_socket;
+
+	link = attach_managed_map_iter(skel->progs.sk_storage_iter_prefix, map_fd);
+	if (!ASSERT_OK_PTR(link, "storage_prefix_attach"))
+		goto out_socket;
+	err = read_managed_map_iter(link);
+	bpf_link__destroy(link);
+	if (!ASSERT_OK(err, "storage_prefix_iter"))
+		goto out_socket;
+
+	err = bpf_map_lookup_elem(map_fd, &sock_fd, &value);
+	if (!ASSERT_OK(err, "storage_prefix_lookup") ||
+	    !ASSERT_EQ(value.prefix, 21, "storage_prefix_value"))
+		goto out_socket;
+
+	link = attach_managed_map_iter(skel->progs.sk_storage_iter_no_access,
+				       map_fd);
+	if (!ASSERT_OK_PTR(link, "storage_no_access_attach"))
+		goto out_socket;
+	err = bpf_link__update_program(link,
+				       skel->progs.sk_storage_iter_write_kptr);
+	if (!ASSERT_EQ(err, -EACCES, "storage_link_update_kptr"))
+		goto out_link;
+	err = bpf_link__update_program(link,
+				       skel->progs.sk_storage_iter_prefix);
+	if (!ASSERT_OK(err, "storage_link_update_prefix"))
+		goto out_link;
+	err = read_managed_map_iter(link);
+	if (!ASSERT_OK(err, "storage_updated_iter"))
+		goto out_link;
+	err = bpf_map_lookup_elem(map_fd, &sock_fd, &value);
+	if (!ASSERT_OK(err, "storage_updated_lookup") ||
+	    !ASSERT_EQ(value.prefix, 22, "storage_updated_value"))
+		goto out_link;
+
+	bpf_link__destroy(link);
+	link = NULL;
+	link = attach_managed_map_iter(skel->progs.sk_storage_iter_read_kptr,
+				       map_fd);
+	err = libbpf_get_error(link);
+	if (!ASSERT_EQ(err, -EACCES, "storage_read_kptr_attach")) {
+		if (!err)
+			bpf_link__destroy(link);
+		goto out_socket;
+	}
+
+	link = attach_managed_map_iter(skel->progs.sk_storage_iter_write_kptr,
+				       map_fd);
+	err = libbpf_get_error(link);
+	if (!ASSERT_EQ(err, -EACCES, "storage_write_kptr_attach")) {
+		if (!err)
+			bpf_link__destroy(link);
+	}
+	goto out_socket;
+
+out_link:
+	if (link)
+		bpf_link__destroy(link);
+out_socket:
+	close(sock_fd);
+}
+
+static void test_bpf_iter_managed_map_fields(void)
+{
+	struct bpf_iter_bpf_sk_storage_map *skel;
+
+	skel = bpf_iter_bpf_sk_storage_map__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "managed_map_fields_open_and_load"))
+		return;
+
+	test_managed_map_elem_iter(skel);
+	test_managed_sk_storage_iter(skel);
+	bpf_iter_bpf_sk_storage_map__destroy(skel);
+}
+
 static void test_rdonly_buf_out_of_bound(void)
 {
 	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
@@ -1776,6 +1961,8 @@ void test_bpf_iter(void)
 		test_bpf_percpu_array_map();
 	if (test__start_subtest("bpf_sk_storage_map"))
 		test_bpf_sk_storage_map();
+	if (test__start_subtest("managed_map_fields"))
+		test_bpf_iter_managed_map_fields();
 	if (test__start_subtest("bpf_sk_storage_map_iter_fd"))
 		test_bpf_sk_storage_map_iter_fd();
 	if (test__start_subtest("bpf_sk_storage_delete"))
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_bpf_sk_storage_map.c b/tools/testing/selftests/bpf/progs/bpf_iter_bpf_sk_storage_map.c
index eb9642923e1ca..75207dd2c7603 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_bpf_sk_storage_map.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_bpf_sk_storage_map.c
@@ -18,6 +18,35 @@ __u32 val_sum = 0;
 __u32 ipv6_sk_count = 0;
 __u32 to_add_val = 0;
 
+struct local_obj {
+	__u64 value;
+};
+
+/* Force LLVM to emit complete BTF for local_obj. */
+struct local_obj *btf_anchor;
+
+struct managed_value {
+	__u64 prefix;
+	struct local_obj __kptr * ptr;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 1);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, __u32);
+	__type(value, struct managed_value);
+} managed_hash_map SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_SK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, struct managed_value);
+} managed_sk_storage_map SEC(".maps");
+
+__u64 observed_kptr;
+
 SEC("iter/bpf_sk_storage_map")
 int rw_bpf_sk_storage_map(struct bpf_iter__bpf_sk_storage_map *ctx)
 {
@@ -50,3 +79,87 @@ int oob_write_bpf_sk_storage_map(struct bpf_iter__bpf_sk_storage_map *ctx)
 
 	return 0;
 }
+
+SEC("iter/bpf_map_elem")
+int map_iter_no_access(struct bpf_iter__bpf_map_elem *ctx)
+{
+	return 0;
+}
+
+SEC("iter/bpf_map_elem")
+int map_iter_prefix(struct bpf_iter__bpf_map_elem *ctx)
+{
+	struct managed_value *value = ctx->value;
+
+	if (value)
+		value->prefix++;
+	return 0;
+}
+
+SEC("iter/bpf_map_elem")
+int map_iter_read_kptr(struct bpf_iter__bpf_map_elem *ctx)
+{
+	struct managed_value *value = ctx->value;
+	__u64 *ptr;
+
+	if (!value)
+		return 0;
+	ptr = (__u64 *)&value->ptr;
+	observed_kptr = *ptr;
+	return 0;
+}
+
+SEC("iter/bpf_map_elem")
+int map_iter_write_kptr(struct bpf_iter__bpf_map_elem *ctx)
+{
+	struct managed_value *value = ctx->value;
+	__u64 *ptr;
+
+	if (!value)
+		return 0;
+	ptr = (__u64 *)&value->ptr;
+	*ptr = 0x1000;
+	return 0;
+}
+
+SEC("iter/bpf_sk_storage_map")
+int sk_storage_iter_no_access(struct bpf_iter__bpf_sk_storage_map *ctx)
+{
+	return 0;
+}
+
+SEC("iter/bpf_sk_storage_map")
+int sk_storage_iter_prefix(struct bpf_iter__bpf_sk_storage_map *ctx)
+{
+	struct managed_value *value = ctx->value;
+
+	if (ctx->sk && value)
+		value->prefix++;
+	return 0;
+}
+
+SEC("iter/bpf_sk_storage_map")
+int sk_storage_iter_read_kptr(struct bpf_iter__bpf_sk_storage_map *ctx)
+{
+	struct managed_value *value = ctx->value;
+	__u64 *ptr;
+
+	if (!ctx->sk || !value)
+		return 0;
+	ptr = (__u64 *)&value->ptr;
+	observed_kptr = *ptr;
+	return 0;
+}
+
+SEC("iter/bpf_sk_storage_map")
+int sk_storage_iter_write_kptr(struct bpf_iter__bpf_sk_storage_map *ctx)
+{
+	struct managed_value *value = ctx->value;
+	__u64 *ptr;
+
+	if (!ctx->sk || !value)
+		return 0;
+	ptr = (__u64 *)&value->ptr;
+	*ptr = 0x1000;
+	return 0;
+}
-- 
2.55.0

