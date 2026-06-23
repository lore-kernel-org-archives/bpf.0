Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F68338E5DF
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 17:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782237014; cv=none; b=Rf9ZphmPK1auRc41cXIU79GO1wwDldoRw0dIJGR/ojsqd5Soj3hKBmNy1XHlEG8Pw+F+QBwepWzIpHOlBZB+ExqbchYqKQZ80YaNiEk9emM0xh8eXFl/U0+YgPY4CyZL4z+2FX7cgr9nwMOWKmHhSSLC4zMRT1hOMSTQO6skxRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782237014; c=relaxed/simple;
	bh=gmLEo8Qxva12wQh7T7WKvyYkCRo+UtZhxyO4uYoxDck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dk7MX2tBaJyvZQI7zj+v/1w7cDK1yDlx2Nm03a6FklNE/X18K0LIK25fsJ44CWJh9nZ83Ct1oVH2hTq7++j8im5g9fgL1DeTN584NdpOnGnrAbXxXZP0HpmcwST1rO2pk5fJMTfKi06zAlMxrpJ9Xruhu4xlLyFxrQl1b7ymcoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f23z+ISI; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f23z+ISI"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6a1160a2c42so120738eaf.0
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 10:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782237012; x=1782841812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TDpmIhKnKapld7EYbwQsM9K3Ane5eLzTjrBFUjiMOE8=;
        b=f23z+ISIBPgzqr7YlgKvwRRKA1HhvxzYQ04M4zFA95nNSB+PiTobo22qeCujsYaZq2
         EFpx82BWwjvvtQUD/DnqpoK2/dvmzvJhVUEantSsLHW+Tcgw3zWmlzhgzg0Bio6cI8BQ
         lnF7FHtCtqkcbUiXAnIbwP7GuY4o2Q1PXVwanxZFalKgWr/cTrfzOd7/oYLqc04jAhLw
         DRQoyszSNEGVyhmlF4hgcc16xNDzC13r+wbwmbTW1YbDTSNevNs7Q08V9F3csSeUjiJD
         VOlvNAl50jGw0ALqubK2y1Is7a3rc5ZM0K6TvojU3XfgoCxKGQOedFtoCfMkr5UM4X4j
         mJHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782237012; x=1782841812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TDpmIhKnKapld7EYbwQsM9K3Ane5eLzTjrBFUjiMOE8=;
        b=edWoeZHSylOAVnySQ6i5L2NOOSi/Lg6xW567MYHQCSL/NCS+4m1qqr6LjwqGH7vAAQ
         /kYO7lEReeuV+sDtrRSejWWKSLafP+mncDryCZPe38JPGT2MSnYAnXYnxMQCg+uTCOWx
         LkJtVPk8iVNvXjl89+RALlQDY4wb9NUycu2eHDi67Wg6Sp0i8POKFMyuZycqrQLvIoIG
         /aseeLgt00dqT8ZgFNRF/ypYAoUD7O2Yz5zwIhhNOc/IdLBGknI0hNPuUpd359ecI/bd
         sjpztXWBlu3VaY6HnemVK/TGE8+ULnMQjgKkxQWCRFcaP6NvnJazZGyhTkFPeKnko1/y
         sm6g==
X-Gm-Message-State: AOJu0Yx/BW85ZD4ISQYPBl+kkjP+RThtw0f/FLDxErkuU6y9YWD7G8pU
	YgxQ0/0DURo1ZZg3K8L9Po4063tDMFdzziKWSsD2uwkB7GMj47FqRsHTcAWPYA==
X-Gm-Gg: AfdE7cl7TSIPX76fYmffXeg7pdfRYH9LMOg2Wm2ro2gslnQebZ5NIAw/4BcfWudZ9KC
	fPOgqeeE/TZort4T0Q7PKAbYSwONLNCoEii32BKcj4d58uHAafrZnpbQGtpoM52Y64byXtw9k84
	LVx6/to/w12PAKRUbRrCLKd5ZUUimUbuDhZkEVsP6BG/jMfj20bioVeppMkehf5k3ahNgdQnFlV
	HpWEuokpUE/7VEZF1Mv31WICewyz5j2TYec6bv7q78iVwjyf5PBBkVCqZ43lUeQh+r8NqURIDhB
	P2dmbdPj9Y9yqsdG1snME4gzvbFVnKY0AivX0tlIKJpeAygSZHb4KCWNMHOVXXp7jB8xzo2OlVQ
	R+gLSNNHlfQtkv97bPFfTt/L/ni7kneIYFupafHWkwNbbBBd1TuBDMEbvKeGOxf9Vp8QrwLNZRt
	9rZsQ=
X-Received: by 2002:a05:6820:c453:10b0:6a1:19ad:7a0e with SMTP id 006d021491bc7-6a119ad7b61mr1256261eaf.17.1782237012515;
        Tue, 23 Jun 2026 10:50:12 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:73::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a0e9f2a4e9sm7350572eaf.2.2026.06.23.10.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 10:50:12 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 03/15] bpf: Add bpf_struct_ops accessor helpers
Date: Tue, 23 Jun 2026 10:49:51 -0700
Message-ID: <20260623175006.3136053-4-ameryhung@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260623175006.3136053-1-ameryhung@gmail.com>
References: <20260623175006.3136053-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Martin KaFai Lau <martin.lau@kernel.org>

Add the helper functions bpf_struct_ops_map_kdata(),
bpf_struct_ops_kdata_map_id(), and bpf_struct_ops_map_cfi_stubs()
in bpf_struct_ops.c. They will be called from cgroup.c in the upcoming
patch to create a struct_ops to cgroup attachment link.

bpf_struct_ops_valid_to_reg() is also exposed for the upcoming caller
in cgroup.c.

The link update validation is also refactored into a new function
bpf_struct_ops_link_update_check() such that it can be reused by the caller
in cgroup.c in the upcoming patch.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf.h         | 28 +++++++++++++++++
 kernel/bpf/bpf_struct_ops.c | 63 ++++++++++++++++++++++++++++---------
 2 files changed, 77 insertions(+), 14 deletions(-)

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
index c422ce41873e..1ca44584ed17 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -1236,7 +1236,33 @@ int bpf_struct_ops_for_each_prog(const void *kdata,
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
+u32 bpf_struct_ops_kdata_map_id(void *kdata)
+{
+	struct bpf_struct_ops_value *kvalue =
+		container_of(kdata, struct bpf_struct_ops_value, data);
+	struct bpf_struct_ops_map *st_map =
+		container_of(kvalue, struct bpf_struct_ops_map, kvalue);
+
+	return st_map->map.id;
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
 
@@ -1289,6 +1315,26 @@ static int bpf_struct_ops_map_link_fill_link_info(const struct bpf_link *link,
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
@@ -1307,23 +1353,12 @@ static int bpf_struct_ops_map_link_update(struct bpf_link *link, struct bpf_map
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
2.53.0-Meta

