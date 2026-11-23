Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795446983;
	b=dZF3OTfr0MnGv+C46IardAGwtQvJMk0heci+n+s+Yel+HGHlKNN6XVu5RENEcOfk1zLw
	 HLKPFzU56uCb0jpGEMGHEDd8/Yd2fNmwTGF48qDqicd7y2Div0ExX6uasom1hNg/HJhs+
	 qkdua1IHuQzsBSEXmRO/ZCWbwgA6Q46MQRS3RT4xIAhuhb4C1IuFZJWkkxOP/UVkxUPSJ
	 gBfei7u7e2IbXhbax6SWe7xXeVhcr/lqDtzz3c0oWONj/PxhlEksCCa/S6iqrAgNkkK7Q
	 dhQOL9PlB2XtauiyxkAZdW8XQVQs0qg4a4LlXyj+zFIolEVtivTkjylPUM3W5Km4Elg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795446983;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=e7Gvti5fT793gkYeO3yJuCL/jO9Wj5wjqrC/pLkeFUU=;
	b=dMN1H2M3Lp5fKLnVNIVlCCAPkKpAWn3GF43GHuovQFBWL2dClgy34gKSTzSMxd97cpje
	 /otoZAA07LlzfJpmVO3KOX+wNEvoQO2mSv+rDpLFW50ZCz/1tOu2jaHwfYhNrCQ5bxmg8
	 FranVfY5rFkiyf4+zGUqfgGTNsngx5KiwG361P1RNzWxquyvuLEKyp9czkukM1gLK7667
	 il3zyfF/9rHw/3vw7ViTXyqb9ucV6YeMj4CrUHsYrJ2rZeIuIjOtDjC3x5rJ+esLO7zjU
	 PTl4mX9Qd9FBWE5zb52t+1X+2Q7kTWI9goqAe3zVyAVFzCn8Re6VMKVahyS+63OS2Kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LLm0FVnR;
	arc=none smtp.remote-ip=209.85.160.47
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA04A606A31A
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 15:16:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA04A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LLm0FVnR
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-48ed0b68895so2196009fac.1
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 07:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795446982; x=1796051782; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e7Gvti5fT793gkYeO3yJuCL/jO9Wj5wjqrC/pLkeFUU=;
        b=LLm0FVnRIg7VyN3aUTE5wvJ0ImXNhiZS5nUPQ/X1yw8UreTC5XegiNiMc1Yho1ZXK7
         yM/6b8Dt/6qS382RrRzKjZEZ7I7s5VCSxf65KRbA1pvkqqbJ3X4Zb6Q7i0srXpzhZmy9
         kf2iRNJGPQbEbsG8J3upMCAT++voBHnKeIvaJ9PLEPfUAUgv8pjARzOPlwuIcGtVqAdg
         3vJciLh3+ETpIDvcTcNNCfbxPsvHrLkGeC0Ya7C1oyefJFHnb3VoSV/H4R1dqswaE6ph
         UB7vheHtJPfgwiDyk3p+uJ5LHzMicD7vGySvMlzwLeij5FAvmbfD2vFLPgylKwYn3GOR
         I9bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795446982; x=1796051782;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e7Gvti5fT793gkYeO3yJuCL/jO9Wj5wjqrC/pLkeFUU=;
        b=e+XLiLpPDBWHkDxEpfYAqjbQnsl4sTaFti7zEQ+D1wTdn86cVfD1IpKr2bbH3beBlg
         WnyKBxnxVXFlbNmr+fBvOYUhb7lESTh8bB1Xo7h+b2AWZV7PqvJussVsjwFYrYWNS0al
         GQF/cb6xXfa3hk3qOcJLWfpbLuFZdC5i98MuVc9jBaBLYlMzvtX+o7eFcIECvbd7xKqi
         RuprLeTiMz/exLYbjmpIstOSg4pKslHFrfmYMtB/JY7nbkcecrMxX2o2S7XgcV8P8ddU
         mkwSt/yWRQI/vfAo+Gae5xuyajqEeO7W2O/xQ4ou7o8OFHCqO57xNMCbIKKnudVjQwHB
         nsZw==
X-Gm-Message-State: APuU4Z+EDYFXZj5vLcG3rV1DdIDqwE/SSBjgCRO7VDh9k+8QUaXv5DHE
	tYT+A6wSjgFiz9cH0WKGHnyAQQXNzQb6Rb4EyC+gSGdNQfT8MNY+hXwIF6aR0YKeQkQ=
X-Gm-Gg: AZFdTZfkN/7LDiI5Hg/I3l+CdiSfm8eCv1iuwcmgevUqYgE06f3zpzCK9UjGxEgPyBP
	jXJo1vZjGDJWGIoYKgxg+glx2iQoOtOqeM643B/0+BpvJaBeI3OO5L9Rn0hAQRGy4HyvIPcR8Y0
	jlgt/ORvnPYmO039NcCS9OaXSwwfavGXwbFODUvP3b7KrdYH+Cmk9yCjxCUbuNz7rYTVR3mxwBq
	+z+RPa8FqKrAuGjo6IhKd6KmBqHt2C3oE2t8psayky1otRu+d8Nkso6kPdem19jJXKmZtxoB4H8
	q8CHJdQq6JHelZcOsD0aO+Mxvy14bTWTdziS9vRayhrP2n4rZ5BSvkMEACUtQm6ULSU12IeRqnI
	/RaKYjsewzlOfv38L+k10uRL6bzUD11VPtsn+NNE+ZhKjogZreFpSviXvpcZJzU2jDV1kdCog+L
	ouXr81datZifjldstofgIvuNx6tTcWoAfeQuF6PyGhKPNkAeQ2+MGYH/jqtqhkt/c+wAtpzIVqK
	zyEhabSkzJDi9DjRaed5CKuSBZj3ED2k7zCjrfnrM85HP/aTJEH7rGNyRq7SAkUhV63I36HAfnM
	0xs6
X-Received: by 2002:a05:6808:c123:b0:4ea:b0ab:b753 with SMTP id 5614622812f47-57a0b44b2ffmr11799153b6e.50.1795446981694;
        Mon, 23 Nov 2026 07:16:21 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:8::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57a3485e3ecsm8685863b6e.9.2026.11.23.07.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 07:16:21 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Mon, 23 Nov 2026 07:15:50 -0800
Subject: [PATCH bpf-next v2 10/13] bpf: Allow BPF_F_INLINE_VALUE for local
 storage maps
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-sls_f1-v2-10-76474de9b052@meta.com>
References: <20261123-sls_f1-v2-0-76474de9b052@meta.com>
In-Reply-To: <20261123-sls_f1-v2-0-76474de9b052@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795446955; l=4649;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=PgCSXxyeh0oU0dmKhIOmBKqBpwuDIlpW7iB2JIdWDzY=;
 b=KZxjOpA8IaHacO5KKjWILQQu7JQOtvNbeTBJlTAdm62FfCsR4VOpF5o0NA1ckAJJ2mf2YsBS6
 SAMAG475s8bCw7HCNt+eNHSJ4Jfa+MXqrOnTtPXqPqU5Da2ROc9FZtb
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

A lookup of a local storage map reads the selem that holds the value.
When the owner is cold, this read can miss on each packet. Let sk, task,
inode and cgroup storage maps keep their values in the storage object
instead, so that a lookup has one dependent load less.

Map create fails with -E2BIG if the value never fits in the inline area,
with -ENOSPC if the area has no room now or the owner type has 16 inline
maps, with -EINVAL with BPF_F_CLONE or special fields, and with
-EOPNOTSUPP on 32-bit. Documentation/bpf/map_sk_storage.rst gives the
rules and costs.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 include/linux/bpf_local_storage.h |  3 ---
 include/uapi/linux/bpf.h          |  7 +++++++
 kernel/bpf/bpf_local_storage.c    | 19 ++++++++++++++++++-
 tools/include/uapi/linux/bpf.h    |  7 +++++++
 4 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index d482ff6a1448..4d9ae3a11b94 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -172,9 +172,6 @@ bpf_local_storage_unpin_owner(struct bpf_local_storage *local_storage)
  */
 #define BPF_LOCAL_STORAGE_INLINE_MAPS	16
 
-/* A later patch adds this flag to the UAPI and allows it */
-#define BPF_F_INLINE_VALUE		BIT(20)
-
 struct bpf_local_storage_cache {
 	spinlock_t idx_lock;
 	u64 idx_usage_counts[BPF_LOCAL_STORAGE_CACHE_SIZE];
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 62de0919db72..9eac0930af95 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1513,6 +1513,13 @@ enum {
 
 /* Enable BPF ringbuf overwrite mode */
 	BPF_F_RB_OVERWRITE	= (1U << 19),
+
+/*
+ * Local storage maps: keep the value in the storage object of the owner.
+ * Readers take no lock, so they can see torn values. 64-bit only. The rules
+ * and errors are in Documentation/bpf/map_sk_storage.rst.
+ */
+	BPF_F_INLINE_VALUE	= (1U << 20),
 };
 
 /* Flags for BPF_PROG_QUERY. */
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 31f62a2be62b..aaeaafe60e6d 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -15,7 +15,8 @@
 #include <linux/rcupdate_trace.h>
 #include <linux/rcupdate_wait.h>
 
-#define BPF_LOCAL_STORAGE_CREATE_FLAG_MASK (BPF_F_NO_PREALLOC | BPF_F_CLONE)
+#define BPF_LOCAL_STORAGE_CREATE_FLAG_MASK \
+	(BPF_F_NO_PREALLOC | BPF_F_CLONE | BPF_F_INLINE_VALUE)
 
 static struct bpf_local_storage_map_bucket *
 select_bucket(struct bpf_local_storage_map *smap,
@@ -1010,15 +1011,27 @@ int bpf_local_storage_map_alloc_check(union bpf_attr *attr)
 {
 	if (attr->map_flags & ~BPF_LOCAL_STORAGE_CREATE_FLAG_MASK ||
 	    !(attr->map_flags & BPF_F_NO_PREALLOC) ||
+	    ((attr->map_flags & BPF_F_CLONE) &&
+	     (attr->map_flags & BPF_F_INLINE_VALUE)) ||
 	    attr->max_entries ||
 	    attr->key_size != sizeof(int) || !attr->value_size ||
 	    /* Enforce BTF for userspace sk dumping */
 	    !attr->btf_key_type_id || !attr->btf_value_type_id)
 		return -EINVAL;
 
+	/* The slot tag needs an 8 byte acquire and release */
+	if (!IS_ENABLED(CONFIG_64BIT) && (attr->map_flags & BPF_F_INLINE_VALUE))
+		return -EOPNOTSUPP;
+
 	if (attr->value_size > BPF_LOCAL_STORAGE_MAX_VALUE_SIZE)
 		return -E2BIG;
 
+	/* Never fits, also in an empty area: -ENOSPC is only for no room now */
+	if ((attr->map_flags & BPF_F_INLINE_VALUE) &&
+	    bpf_local_storage_slot_size(attr->value_size) >
+	    BPF_LOCAL_STORAGE_INLINE_MAX - BPF_LOCAL_STORAGE_INLINE_START)
+		return -E2BIG;
+
 	return 0;
 }
 
@@ -1030,6 +1043,10 @@ int bpf_local_storage_map_check_btf(struct bpf_map *map,
 	if (!btf_type_is_i32(key_type))
 		return -EINVAL;
 
+	/* An inline value is copied in place and is not freed with a delete */
+	if ((map->map_flags & BPF_F_INLINE_VALUE) && !IS_ERR_OR_NULL(map->record))
+		return -EINVAL;
+
 	return 0;
 }
 
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 62de0919db72..9eac0930af95 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1513,6 +1513,13 @@ enum {
 
 /* Enable BPF ringbuf overwrite mode */
 	BPF_F_RB_OVERWRITE	= (1U << 19),
+
+/*
+ * Local storage maps: keep the value in the storage object of the owner.
+ * Readers take no lock, so they can see torn values. 64-bit only. The rules
+ * and errors are in Documentation/bpf/map_sk_storage.rst.
+ */
+	BPF_F_INLINE_VALUE	= (1U << 20),
 };
 
 /* Flags for BPF_PROG_QUERY. */

-- 
2.53.1-Meta

