Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688553D5677
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 15:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775661036; cv=none; b=QlaCjvFZWUDtLpKZssK/WV4NKorIEzXbQwW44Iy2dmr2Wpmmp8iNyeV+h3YJ0Fd4xmESLi2hvMILqmVWpsV+iBceVsxChkl4HgVfJBhNjnOHxDg5FlNZlw3zBb3tuBGHmJyd1JtqfnLSUECFtRujru6yic/nJUqEfOQWOBGa38A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775661036; c=relaxed/simple;
	bh=2Eq4GFIXSilEF3DkRisDV63ZoLnWditdls0czagypA0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cO/LSt1Ar3z67+EMMZCz+ibkluWlLKBMYhSKJ0O8UOO1ztAmWbzsQ4ghNlEjhmOoveeYQe7jIqnJV1K89t2Vh/n6DKu4BcfybHkmBu7OcWJeGVCpMho35DEDrgbuuRMFOKigBo/Fx3ii+U4DZij0vTZnuXtSEjYJKxkfqvP5SrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p1UZd7lZ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p1UZd7lZ"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso54285815e9.3
        for <bpf@vger.kernel.org>; Wed, 08 Apr 2026 08:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775661034; x=1776265834; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lefUmo2vJL/qcPhaL+kxQjWpdKWsN/t8Kle49c+JKh8=;
        b=p1UZd7lZHYBhrx0Lz4XFF9flEZxLlqbhVFyRJEqcun6rwqbEQA9xfTcWnZ7UYfrDGY
         yUPWZcvk4SRdIZdgvcBtF4wur/9mONgyta8TeGB6zXNHix9gHPhPcQTdfK7dPrezIlNb
         IFfs+u4Qgi/Xw8DQxs8pUkNQddWhjYNe9xoZcDOvBwSz/bA/LncULmxfy5maL+/FKidH
         R00jKXtjXdy0k98q2O7YRLEGs11H+L+qAiL7M/GvUpa157W1qIKSQ4Q7lAn4QzVhiTZU
         9VWXhrh571PWqQ7T+7P2eIYTEHIm8GNT/ct6hzrYAuSPemtRTwozp59qxmIfFIQl/UAq
         PBKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775661034; x=1776265834;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lefUmo2vJL/qcPhaL+kxQjWpdKWsN/t8Kle49c+JKh8=;
        b=UnXzzSy8uVwGPVdXVIZuUv7uq9AD2vmEgfrWjUORuClVaz0uxeCsbp/yV7ruBjf5ZV
         gsHxtSEm7NuZFm/VBtbjfv4C1uGelHVF013Uje2M+IHWi4R6uo1J9Vvr2pkIXoQk/gnv
         A2Mo/haI5JpCHDPUNLqgnL0qcn1HFMgcnWTrKa8iulG39SIC3/ew10nWDtBbliQhzI+a
         9de+FjMQQjx5Tn6ClRho9VySh39wBGRqydS6TA/Mk5UPXh4tXUrFV4kBoFGcnnzGL/OJ
         8lt8JGx3nxMmeUHVAEym9p0L4sOhIt6FQpC4ZwMuNhVeQJ5LDpfovYh6mmjoDfo5BsxQ
         n5QQ==
X-Gm-Message-State: AOJu0Yz21JGooCadDkwEEH5J4UQLlAdMG9FrVC8bYtZpod/cT/7AVkSS
	3eV3mPk+J9gzpouk+rGBj3kS2C4lwOUs5rjhTHa3q02oifiiXlPs0tlW
X-Gm-Gg: AeBDieuoysXim+QbpmrcI3baukP0l+xGbVY293gKJn0CQaqFilffPQe1V2d3OUr6nEd
	El6UFqR7gfc1aCexAnJL3egym7LDVoElHxo4NKMzlQRB7ANv7voakubpKwtI/H9fanNfaukb1ju
	cF/dyleyCB4r0HEjzkzUSV+dg4Jv1WeEBYK5CgWFVfUfiU5C1oa/bLaes7aYyqCdC2z8nnsTOB6
	MrJpz8jxX1M7k8MyFLYjEX0SgWo0NgAqVDH591wFVhBux9ZNkIh4JuZN7pRUgJhqMaONHWClzuU
	XRweQD7lTTNQ+tY4GxsUY07rhK+yRtjuV+D3D7doQd/Q5r8dujOSNlADEtjjUIkuT2P8c3tZLMr
	Kx40nfP7NW0bkrC2492kKY0OjVrTV7JVREYrN9pp57eFvqTE9xRj35eZ5NS4FFsfPNIhXH4Gloj
	IzYUpjtASXtubHaA==
X-Received: by 2002:a05:600c:1987:b0:488:9661:2570 with SMTP id 5b1f17b1804b1-488ccf5912cmr1528805e9.8.1775661033354;
        Wed, 08 Apr 2026 08:10:33 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:72::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488b0c53a27sm246284365e9.7.2026.04.08.08.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 08:10:32 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 08 Apr 2026 08:10:06 -0700
Subject: [PATCH RFC bpf-next v2 01/18] bpf: Register rhash map
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-rhash-v2-1-3b3675da1f6e@meta.com>
References: <20260408-rhash-v2-0-3b3675da1f6e@meta.com>
In-Reply-To: <20260408-rhash-v2-0-3b3675da1f6e@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, herbert@gondor.apana.org.au
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775661028; l=3391;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=7KX1pkv+Roi1e00mdOeq5TSV9ySFGkTANoS85YSjGe8=;
 b=xj5fMLSVV8zVygon8bJ9NL5wMtJIe/rxfCbq7Lk/YegKuhZIKeSDW5P6x4+qvdqFkDqtiXDOl
 HnlUllZGDQhA/ssgo1TJcNOWKWLYZnS3Oljj37NJYkO5tc8m/MyjrvP
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Add resizable hash map into enums where it is needed.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 include/uapi/linux/bpf.h       | 1 +
 kernel/bpf/map_iter.c          | 3 ++-
 kernel/bpf/syscall.c           | 3 +++
 kernel/bpf/verifier.c          | 1 +
 tools/include/uapi/linux/bpf.h | 1 +
 5 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 552bc5d9afbd..822582c04f22 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1046,6 +1046,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_CGRP_STORAGE,
 	BPF_MAP_TYPE_ARENA,
 	BPF_MAP_TYPE_INSN_ARRAY,
+	BPF_MAP_TYPE_RHASH,
 	__MAX_BPF_MAP_TYPE
 };
 
diff --git a/kernel/bpf/map_iter.c b/kernel/bpf/map_iter.c
index 261a03ea73d3..4a2aafbe28b4 100644
--- a/kernel/bpf/map_iter.c
+++ b/kernel/bpf/map_iter.c
@@ -119,7 +119,8 @@ static int bpf_iter_attach_map(struct bpf_prog *prog,
 		is_percpu = true;
 	else if (map->map_type != BPF_MAP_TYPE_HASH &&
 		 map->map_type != BPF_MAP_TYPE_LRU_HASH &&
-		 map->map_type != BPF_MAP_TYPE_ARRAY)
+		 map->map_type != BPF_MAP_TYPE_ARRAY &&
+		 map->map_type != BPF_MAP_TYPE_RHASH)
 		goto put_map;
 
 	key_acc_size = prog->aux->max_rdonly_access;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 51ade3cde8bb..0a5ec417638d 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1287,6 +1287,7 @@ static int map_check_btf(struct bpf_map *map, struct bpf_token *token,
 			case BPF_SPIN_LOCK:
 			case BPF_RES_SPIN_LOCK:
 				if (map->map_type != BPF_MAP_TYPE_HASH &&
+				    map->map_type != BPF_MAP_TYPE_RHASH &&
 				    map->map_type != BPF_MAP_TYPE_ARRAY &&
 				    map->map_type != BPF_MAP_TYPE_CGROUP_STORAGE &&
 				    map->map_type != BPF_MAP_TYPE_SK_STORAGE &&
@@ -1464,6 +1465,7 @@ static int map_create(union bpf_attr *attr, bpfptr_t uattr)
 	case BPF_MAP_TYPE_CGROUP_ARRAY:
 	case BPF_MAP_TYPE_ARRAY_OF_MAPS:
 	case BPF_MAP_TYPE_HASH:
+	case BPF_MAP_TYPE_RHASH:
 	case BPF_MAP_TYPE_PERCPU_HASH:
 	case BPF_MAP_TYPE_HASH_OF_MAPS:
 	case BPF_MAP_TYPE_RINGBUF:
@@ -2199,6 +2201,7 @@ static int map_lookup_and_delete_elem(union bpf_attr *attr)
 		   map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
 		   map->map_type == BPF_MAP_TYPE_LRU_HASH ||
 		   map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH ||
+		   map->map_type == BPF_MAP_TYPE_RHASH ||
 		   map->map_type == BPF_MAP_TYPE_STACK_TRACE) {
 		if (!bpf_map_is_offloaded(map)) {
 			bpf_disable_instrumentation();
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8c1cf2eb6cbb..53523ab953c2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21816,6 +21816,7 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 	if (prog->sleepable)
 		switch (map->map_type) {
 		case BPF_MAP_TYPE_HASH:
+		case BPF_MAP_TYPE_RHASH:
 		case BPF_MAP_TYPE_LRU_HASH:
 		case BPF_MAP_TYPE_ARRAY:
 		case BPF_MAP_TYPE_PERCPU_HASH:
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 677be9a47347..9d7df174770a 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1046,6 +1046,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_CGRP_STORAGE,
 	BPF_MAP_TYPE_ARENA,
 	BPF_MAP_TYPE_INSN_ARRAY,
+	BPF_MAP_TYPE_RHASH,
 	__MAX_BPF_MAP_TYPE
 };
 

-- 
2.52.0

