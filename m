Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B429435CB73
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 07:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770274939; cv=none; b=THT9uXZ+J8CV9nGnnGmf9lJ11y7CZ6p6fQ3J4i5jAulJBiq0GneHZYvVSXKoGBkDvFdLYirYOkvLVQW6pi3tdCBPxCvQpA/MeCeNEc9avTQoK+NqR4zliTf4V5spK8f5QtwVCr6cHMcVN7X+2g0BaTmTEHhAbW0zKrON1/rBtNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770274939; c=relaxed/simple;
	bh=CBqTvdITmV4N+zgSeN68ivxwV9Bq9KzptzQRZ9/vtco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CiB8L0AH7oydQhkQxoUhs+mmEid85ItzZNm8rgl+JUM4oFiqFTRENJZ5100VhLtR+RtMJaDrWKZnh7dnxOa3is9hmdZA+zKyiPngYQ91bBC++RTwKuOAL8Vg7SkdJfK4uPg5r+gpHhKf01Jv6kt4baUV9gtrsLaYpv1uAUFjtc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EhMBugTj; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EhMBugTj"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-354a2a7d90fso196828a91.2
        for <bpf@vger.kernel.org>; Wed, 04 Feb 2026 23:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770274939; x=1770879739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9PjMDge0fA0s+oiOs2HnEWzWgjzoILNnSL9xL9THcxk=;
        b=EhMBugTjQ6v0FBX8xqQKxWBeLypAswK+lA7BnpCvT7zgeavEfNvUrCkzQ0pJCHr/Cc
         4BsAob9J9Mqms+uKHEdKgc1F1D05LHzkfK6oVr8/VZkrpb6NDY0LvxwN78ykGbA+P4/3
         C55LwJSfQ9KkN4zSNVWvZvov390LnnUlJLGmRqgCf4TguY+h/T1DbY0wLeXqgW4ao6aP
         esjpx3+F4GyojxNx1FS5F5dtSa93s1xJsU9ytoonlFgzqai6hh/mGCdZxm8QfOnhtTH6
         l+lrSDhUAu3eIixKK46NtaONsY5FWgbJNmu4llcZXihB31l/MUC71ApOUxQqfZ6dBEdx
         7Ocw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770274939; x=1770879739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9PjMDge0fA0s+oiOs2HnEWzWgjzoILNnSL9xL9THcxk=;
        b=GPrHJMliAm98o2jHhF7EAjZrpRGUdaPWSWJUjvifuMaq6ZJsCXohS2aZL21VuRvQJZ
         bTzNDtNqFLUg9SXoJ4sgr25UpJr0dNhirgu/X9kswR7W7ItAY8DvT8CKs9h8kBcLyBk5
         27HtcA9JWuqdGfyC1ifM9jEcPx39HLGNekLNqQuqgbomEfWeGsF82iKLHQpOZRpxmvAc
         b+fVdQBzTt1G7v4504Kelu4p/uaLIGWOiSjD63If1OhgykJ+vouqxGePev0mMgS7YcB5
         DAMWyS2U8AQAfFFVFg9+x1T91LMTgcHb1uXGL3+GoeOmXR8LE7H+WMCFKKzPtSXU7W0a
         5xHw==
X-Gm-Message-State: AOJu0YwLJZafStgWUtQJ9ijG6+HrRpIbI/W4HdbaO1qPNUdsVNFVPpwb
	tj/nOhdIvkg/d21w3TwjovPXO97zfBCfelepkpAEapiytt7n4PEjBDxFk+eacA==
X-Gm-Gg: AZuq6aLIifnZAKv0I+6bb35POfsD3le3RkEcs4rqezjbQvAsp2vfVSu5bJ7k7a5wXUF
	VlqZVZowEm9drVSAYMjSekwJYucghEdQp9XeBNYUltzqLlnE82eY47F4nhZRx5+Fk9RiIMbKWku
	hE+sE7vZJT9aejrHBQPb4EVd6N4kJ/f//amIXvOICDwIrNXIH0OGaFtgRyp4W9jSEU+mh3M96CE
	c4khrB8Z0X58Sb+D7bTh33TtC/vY681JpMx4LcVzs5ESE8AdwOgdmkSoTQEGs5lCz+dcnbMkBbj
	vwv5/SgfgDxSBW749y1G7GBue5OA9NbuAbgjcWbfBvXxoI3KikwajK4uHEUp4JZTLsJlsEPvQP1
	zG8yJrTfytgSRP9yJZMF/UhVzUhjFGN408ganSik6860gTyHrNOMGDOh1O8ZfKGyO/jCQtWfGsq
	FrK2dpGnXnvOdk
X-Received: by 2002:a17:90a:d88e:b0:341:8c8b:b8e6 with SMTP id 98e67ed59e1d1-354870f9882mr5829363a91.16.1770274938913;
        Wed, 04 Feb 2026 23:02:18 -0800 (PST)
Received: from localhost ([2a03:2880:ff:4e::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-354871158f6sm2552991a91.0.2026.02.04.23.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 23:02:18 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@kernel.org,
	kpsingh@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	haoluo@google.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v6 08/17] bpf: Remove unused percpu counter from bpf_local_storage_map_free
Date: Wed,  4 Feb 2026 23:01:57 -0800
Message-ID: <20260205070208.186382-9-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260205070208.186382-1-ameryhung@gmail.com>
References: <20260205070208.186382-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Percpu locks have been removed from cgroup and task local storage. Now
that all local storage no longer use percpu variables as locks preventing
recursion, there is no need to pass them to bpf_local_storage_map_free().
Remove the argument from the function.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf_local_storage.h | 3 +--
 kernel/bpf/bpf_cgrp_storage.c     | 2 +-
 kernel/bpf/bpf_inode_storage.c    | 2 +-
 kernel/bpf/bpf_local_storage.c    | 7 +------
 kernel/bpf/bpf_task_storage.c     | 2 +-
 net/core/bpf_sk_storage.c         | 2 +-
 6 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index fa50b7afee18..fba3354988d3 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -166,8 +166,7 @@ bpf_local_storage_lookup(struct bpf_local_storage *local_storage,
 void bpf_local_storage_destroy(struct bpf_local_storage *local_storage);
 
 void bpf_local_storage_map_free(struct bpf_map *map,
-				struct bpf_local_storage_cache *cache,
-				int __percpu *busy_counter);
+				struct bpf_local_storage_cache *cache);
 
 int bpf_local_storage_map_check_btf(const struct bpf_map *map,
 				    const struct btf *btf,
diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_storage.c
index 4d84611d8222..853183eead2c 100644
--- a/kernel/bpf/bpf_cgrp_storage.c
+++ b/kernel/bpf/bpf_cgrp_storage.c
@@ -119,7 +119,7 @@ static struct bpf_map *cgroup_storage_map_alloc(union bpf_attr *attr)
 
 static void cgroup_storage_map_free(struct bpf_map *map)
 {
-	bpf_local_storage_map_free(map, &cgroup_cache, NULL);
+	bpf_local_storage_map_free(map, &cgroup_cache);
 }
 
 /* *gfp_flags* is a hidden argument provided by the verifier */
diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
index cedc99184dad..470f4b02c79e 100644
--- a/kernel/bpf/bpf_inode_storage.c
+++ b/kernel/bpf/bpf_inode_storage.c
@@ -184,7 +184,7 @@ static struct bpf_map *inode_storage_map_alloc(union bpf_attr *attr)
 
 static void inode_storage_map_free(struct bpf_map *map)
 {
-	bpf_local_storage_map_free(map, &inode_cache, NULL);
+	bpf_local_storage_map_free(map, &inode_cache);
 }
 
 const struct bpf_map_ops inode_storage_map_ops = {
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index b33ef5fb5b49..3735f79a7b55 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -808,8 +808,7 @@ bpf_local_storage_map_alloc(union bpf_attr *attr,
 }
 
 void bpf_local_storage_map_free(struct bpf_map *map,
-				struct bpf_local_storage_cache *cache,
-				int __percpu *busy_counter)
+				struct bpf_local_storage_cache *cache)
 {
 	struct bpf_local_storage_map_bucket *b;
 	struct bpf_local_storage_elem *selem;
@@ -842,11 +841,7 @@ void bpf_local_storage_map_free(struct bpf_map *map,
 		while ((selem = hlist_entry_safe(
 				rcu_dereference_raw(hlist_first_rcu(&b->list)),
 				struct bpf_local_storage_elem, map_node))) {
-			if (busy_counter)
-				this_cpu_inc(*busy_counter);
 			bpf_selem_unlink(selem, true);
-			if (busy_counter)
-				this_cpu_dec(*busy_counter);
 			cond_resched_rcu();
 		}
 		rcu_read_unlock();
diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
index dd858226ada2..4d53aebe6784 100644
--- a/kernel/bpf/bpf_task_storage.c
+++ b/kernel/bpf/bpf_task_storage.c
@@ -217,7 +217,7 @@ static struct bpf_map *task_storage_map_alloc(union bpf_attr *attr)
 
 static void task_storage_map_free(struct bpf_map *map)
 {
-	bpf_local_storage_map_free(map, &task_cache, NULL);
+	bpf_local_storage_map_free(map, &task_cache);
 }
 
 BTF_ID_LIST_GLOBAL_SINGLE(bpf_local_storage_map_btf_id, struct, bpf_local_storage_map)
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index d7b5c4551997..d2164165a994 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -60,7 +60,7 @@ void bpf_sk_storage_free(struct sock *sk)
 
 static void bpf_sk_storage_map_free(struct bpf_map *map)
 {
-	bpf_local_storage_map_free(map, &sk_cache, NULL);
+	bpf_local_storage_map_free(map, &sk_cache);
 }
 
 static struct bpf_map *bpf_sk_storage_map_alloc(union bpf_attr *attr)
-- 
2.47.3

