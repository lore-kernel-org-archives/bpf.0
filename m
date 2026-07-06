Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50B63B38BF
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 17:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783358371; cv=none; b=I1wxYkziU6G9ZhwECi4a90li0XbTf45gCN3gn8fPtj5OISql8UjIXG+OPm6iHuiyHwx4MmNyKz09hqHnxed8N48OgHqy7ZiAQXTyGH/u9YVaoPegz03ojRjt7AKZHsIV0+c7hQW9wwbzpPfQKplaz16WLtY8i+X434NTJ9fujHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783358371; c=relaxed/simple;
	bh=FMAxq7ofay6cEJidT7K3NIrWCEl/ch/yLiQP3c0HJek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nlu9pLMrddkzyYwd4cmq2L5H2aIwxIBUcVQWTcPTnjGsNnwWN1FOSqP9qh5mtwNd+tLIQ7+szKzVTqhTIA6vnJE4K9xjAEknhJRkxUnjGmFqdu9SN6svJAOk5ztHKb0fmq6wYkvuU71q3q0DWyNpIzy9m5cd1s5Q/a+DVBiVQOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sn54Qv5k; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sn54Qv5k"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7e9f69ee6f4so2876750a34.2
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2026 10:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783358369; x=1783963169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KUHL7XPZqgp5/anUPRj+nd5nWm4qXmUT0QocaLjcs1A=;
        b=Sn54Qv5kpHadtJV7bMqI5/vDI//2oJFTOUiyI+vnUT2GZvPclHLvGBM69VDGn9dqSX
         +iGlLxwICyx6DkZfrVFOiIDad0MLfE+2O5AJB7xswp9h6Y3V3fQmviKZMXiBREYH0Cpu
         Xj4e4fO1cEEC4DMiZCZCb0PhlZS4AIGlVB+SCuFZPiy6iqvuEK2//TYz5sdqYpP8ZFwD
         5AJJU4NK0+vE/i2g6VJb4MHJLshKlfkghRxZAxYzypetE/0gbuM6iYyOOHfH5MKRm/jt
         1LVMKkVFmzDtH2QsBiKvIPm+J5H/vkcoYpThWBsEDLujQIKkJHQlH/15z5temezZTw4E
         Dctg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783358369; x=1783963169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KUHL7XPZqgp5/anUPRj+nd5nWm4qXmUT0QocaLjcs1A=;
        b=r1bVGi0Ra/IrTyVLm6BzJ5jIZoGo8iOslAwI5wNXYiXLkoZOpWaoyops7nWet0i3G9
         X4hcVdMlCMkqkL3HTy5KWyOckUwLB5mkLsWzdxJsLPsvpRgS2S+d0hnkqYxfXeZtue3P
         +5dlWXIMsC2zb45H1EdQ3h5nvS0vbYA4OM0J+2G+v6wEPvEvFAPrVBWlkOq7SoYLQxMO
         MvZV1PCT8FXdtxjr5Ul/NhrDBMwxCIvU6Rm6ALvHYlZVU+UDAcswjbWY8BtMpAmrkmXs
         M9CEww9are3w/8BsrmYKlHgLC0oCDl/8J+PzEyLs8oDzTtFAIX6r5zU/nmF4LIk7zutZ
         IkWA==
X-Gm-Message-State: AOJu0Yy6CbEEi8dEkaxhU6CYOXUmVsUKX6h9KK6hZIH1vG0C+XQ87ee0
	e1tyERzUncRH9Sb/DdFYg+Ok168piw958FJIqaMMSeI2AciZ1McRdJkAua1xdg==
X-Gm-Gg: AfdE7clWmSM3pnHlGhfl6NLAutWlSekfDehmoVxmQTs3NxJKIZanT/cJZ/dAWkXEbOU
	ABzOfCv5Q17R2XSYoixnFKEdYybfpMl2DSEJlHJ3PYJUErOobyQtt6C3ETS06XsekoJkekkjIbS
	iOQYkRwe4ZhvSXtYewvVp5DXrqhhRH7vdoC+KkPaqogZpaeY5q6inLsfKUSKQDYQ5HGdyaO2xwt
	1wq2J7Szzi5Rf1gcJJi5hAWr0I82+0GECeCFdnV3ZmsBOniJ0LiN7nk5Q+6Vyy8fumnDDXWvLUb
	19o6v9/qyL1gfe6I9hydWjpzXEMcqKG6aT1EiXTMUizbjzXUB6ttxpNANImfD4uyIQCNYWSffrU
	QuWBmkIUHHifYhv/bBnBqZED0uKvaJgDUTpoqK+gBtR+y/zLiJvOr03cwh/fDeDY4XlC7iy8WWi
	q4Hko=
X-Received: by 2002:a05:6830:6414:b0:7df:5fc:3fd5 with SMTP id 46e09a7af769-7ebb2176e5cmr889606a34.1.1783358368696;
        Mon, 06 Jul 2026 10:19:28 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:43::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7eb542936e6sm11859799a34.5.2026.07.06.10.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 10:19:28 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	shakeel.butt@linux.dev,
	roman.gushchin@linux.dev,
	kuniyu@google.com,
	kerneljasonxing@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 03/15] bpf: Add bpf_struct_ops accessor helpers
Date: Mon,  6 Jul 2026 10:19:05 -0700
Message-ID: <20260706171918.317102-4-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260706171918.317102-1-ameryhung@gmail.com>
References: <20260706171918.317102-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Martin KaFai Lau <martin.lau@kernel.org>

Add the helper functions bpf_struct_ops_map_kdata() and
bpf_struct_ops_map_cfi_stubs() in bpf_struct_ops.c. They will be called
from cgroup.c in the upcoming patch to create a struct_ops to cgroup
attachment link.

bpf_struct_ops_valid_to_reg() is also exposed for the upcoming caller
in cgroup.c.

The link update validation is also refactored into a new function
bpf_struct_ops_link_update_check() such that it can be reused by the
caller in cgroup.c in the upcoming patch.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf.h         | 28 ++++++++++++++++++++
 kernel/bpf/bpf_struct_ops.c | 53 +++++++++++++++++++++++++++----------
 2 files changed, 67 insertions(+), 14 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 7ac8873839f4..047ffc029666 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2252,6 +2252,12 @@ u32 bpf_struct_ops_id(const void *kdata);
 int bpf_struct_ops_for_each_prog(const void *kdata,
 				 int (*cb)(struct bpf_prog *prog, void *data),
 				 void *data);
+void *bpf_struct_ops_map_kdata(struct bpf_map *map);
+u32 bpf_struct_ops_kdata_map_id(void *kdata);
+void *bpf_struct_ops_map_cfi_stubs(struct bpf_map *map);
+bool bpf_struct_ops_valid_to_reg(struct bpf_map *map);
+int bpf_struct_ops_link_update_check(struct bpf_map *new_map, struct bpf_map *old_map,
+				     struct bpf_map *expected_old_map);
 
 #ifdef CONFIG_NET
 /* Define it here to avoid the use of forward declaration */
@@ -2316,6 +2322,28 @@ static inline void bpf_map_struct_ops_info_fill(struct bpf_map_info *info, struc
 static inline void bpf_struct_ops_desc_release(struct bpf_struct_ops_desc *st_ops_desc)
 {
 }
+static inline void *bpf_struct_ops_map_kdata(struct bpf_map *map)
+{
+	return NULL;
+}
+static inline u32 bpf_struct_ops_kdata_map_id(void *kdata)
+{
+	return 0;
+}
+static inline void *bpf_struct_ops_map_cfi_stubs(struct bpf_map *map)
+{
+	return NULL;
+}
+static inline bool bpf_struct_ops_valid_to_reg(struct bpf_map *map)
+{
+	return false;
+}
+static inline int bpf_struct_ops_link_update_check(struct bpf_map *new_map,
+						   struct bpf_map *old_map,
+						   struct bpf_map *expected_old_map)
+{
+	return -EOPNOTSUPP;
+}
 
 #endif
 
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index c422ce41873e..3d650a7e9f68 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -1236,7 +1236,23 @@ int bpf_struct_ops_for_each_prog(const void *kdata,
 }
 EXPORT_SYMBOL_GPL(bpf_struct_ops_for_each_prog);
 
-static bool bpf_struct_ops_valid_to_reg(struct bpf_map *map)
+void *bpf_struct_ops_map_kdata(struct bpf_map *map)
+{
+	struct bpf_struct_ops_map *st_map;
+
+	st_map = container_of(map, struct bpf_struct_ops_map, map);
+	return st_map->kvalue.data;
+}
+
+void *bpf_struct_ops_map_cfi_stubs(struct bpf_map *map)
+{
+	struct bpf_struct_ops_map *st_map;
+
+	st_map = container_of(map, struct bpf_struct_ops_map, map);
+	return st_map->st_ops_desc->st_ops->cfi_stubs;
+}
+
+bool bpf_struct_ops_valid_to_reg(struct bpf_map *map)
 {
 	struct bpf_struct_ops_map *st_map = (struct bpf_struct_ops_map *)map;
 
@@ -1289,6 +1305,26 @@ static int bpf_struct_ops_map_link_fill_link_info(const struct bpf_link *link,
 	return 0;
 }
 
+int bpf_struct_ops_link_update_check(struct bpf_map *new_map,
+				     struct bpf_map *old_map,
+				     struct bpf_map *expected_old_map)
+{
+	struct bpf_struct_ops_map *st_map, *old_st_map;
+
+	if (!old_map)
+		return -ENOLINK;
+	if (expected_old_map && old_map != expected_old_map)
+		return -EPERM;
+
+	st_map = container_of(new_map, struct bpf_struct_ops_map, map);
+	old_st_map = container_of(old_map, struct bpf_struct_ops_map, map);
+	/* The new and old struct_ops must be the same type. */
+	if (st_map->st_ops_desc != old_st_map->st_ops_desc)
+		return -EINVAL;
+
+	return 0;
+}
+
 static int bpf_struct_ops_map_link_update(struct bpf_link *link, struct bpf_map *new_map,
 					  struct bpf_map *expected_old_map)
 {
@@ -1307,23 +1343,12 @@ static int bpf_struct_ops_map_link_update(struct bpf_link *link, struct bpf_map
 		return -EOPNOTSUPP;
 
 	mutex_lock(&update_mutex);
-
 	old_map = st_link->map;
-	if (!old_map) {
-		err = -ENOLINK;
-		goto err_out;
-	}
-	if (expected_old_map && old_map != expected_old_map) {
-		err = -EPERM;
+	err = bpf_struct_ops_link_update_check(new_map, old_map, expected_old_map);
+	if (err)
 		goto err_out;
-	}
 
 	old_st_map = container_of(old_map, struct bpf_struct_ops_map, map);
-	/* The new and old struct_ops must be the same type. */
-	if (st_map->st_ops_desc != old_st_map->st_ops_desc) {
-		err = -EINVAL;
-		goto err_out;
-	}
 
 	err = st_map->st_ops_desc->st_ops->update(st_map->kvalue.data, old_st_map->kvalue.data, link);
 	if (err)
-- 
2.52.0

