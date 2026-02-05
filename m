Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3964732BF44
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 20:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770323229; cv=none; b=oq2MsKyhoLP9HrLpWZb/Aduqypk1Xrg78ByP8E+242k/axABvilGYj+p3rkKR6erhPIFxr3ulbtcLWji1XfolTNYobqV3rVZ4AL47Cyv3yzP6YV90KXenevvLz0D+kteuwPADYFc/AsEBum41NJ81oQKGqj0sHqjW11COAxG4DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770323229; c=relaxed/simple;
	bh=QvwO5Qz9473Pzn5ncRC+kQjsEd+/tGG7p01MZ/ZDL+8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TE/9QoOZfjXCUl65ociZNstEYJ4xpODpBF4sTV2LBNLl0+IOgJDEpAeXf7Bibq4UmoyXsNhjaLpWlvbaVaK4VAZrrzpFzQBtEthkwsVMoyvkzHy1TQgXp4BZTScA2U8aK/UIQLbSpdhc+v5GXXItpjWeoZZ6Jfx65Axv3MK0Kck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uu9B/pbQ; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uu9B/pbQ"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-432d2c7dd52so1449743f8f.2
        for <bpf@vger.kernel.org>; Thu, 05 Feb 2026 12:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770323227; x=1770928027; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IbCS80vbpi4VJz+R5xhEf6qArEkDtDLHB51GN39k0vg=;
        b=Uu9B/pbQGXOw8LfEPl2wxWGGITijL8F87RgjNNyCc8/aES7sKQpWpgNj0kc1j9EXxB
         4ys1lh7OWkHIV/FN+C9oL7wHHWMMb60f4WEs9lCcrMdA28A+tC3He1/4a/Qu3J3nYCLn
         lzgwsDFCx6ix7SF/kW+2VUBGXC1CVxSlWEiS5gMI8/p4Ud9eyJTI4xMmkf6JktkbY522
         nLXioN4687qcxK2Hjy1l7+7k17aWGbCkZ427sU3cdZovhjE4s+XYczSG0EZZ1FvYc/EK
         aKWYD+GYQVX/Xwza1v0sqlcycT4GnUkCvQGNiGNwG3Dlu7eN4ZnbZls91wxqu8kYov8F
         uQRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770323227; x=1770928027;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IbCS80vbpi4VJz+R5xhEf6qArEkDtDLHB51GN39k0vg=;
        b=ItnWxh92KHJVt6HukltHLsnEUGta5LUwc/trNPThEzsIkdsREgGKmhzN082ea/PTlG
         415oT2szTRoduJ0DX9hArxQXqVQjQC2sLCzolKCcakY/wqeHpFs3bB33xIDE2YI9JWKQ
         kOi5yEuF4YZkWGEwA1CbcuoxRiRLjGYrrsSCJbpqqEGh3zEMPM3u3HpS2LhV86Hu2V9f
         ZOA/LrdmkNbloawzdRXmB6NCAgFUfXRmxZ8wxAy5tHCyXBAwixUTHcPKgPk7nj+jrri9
         kqFWBHmakrNuo/qxcjQCWojenuOUy5WAQgmvKBP/t/j8Qb6AXfbU18mCg35iiZ3Ns/Wr
         CNPg==
X-Gm-Message-State: AOJu0YzAs50aEgUHqtJVK+BTMNDjA712hwy+TxqDq3dWevIhKmTT4GsC
	kOQMmyrSk7EI1MTiAtpqdAnC2GAuDWUgo7lxuC1Ql0AKDs66eQEtFFQM
X-Gm-Gg: AZuq6aK0OoLwvFsCf2tOHlNuiiPZ8Ksl7ZpD7HkTxFAieBRD41TJT9eKGj80qiwdjVA
	t/rvCcYlYp/kqZU0xDtvRVmW8DPreGTLe1nb1JF34Xg7mu+Av686/Sl2jXiKqveHuGV+vGfl30z
	eOdZfd0ewgZjEPnAQOeh4in7Lkgn00auQQ80MUuQ2XNLo2oCYWI0CQVEMwHMY9NyzDhmnbnvHpO
	47AwSx+U05XNRQ8LkoQJaOSLZ0iysadDT7tXvKpOikzjvsIg6EAonb4a5WKYKVOU7OkcmaS3kN6
	x35e7RwafVFnKwMNVrPyL0P574YddMDSUMn+NRaO/ZADIvoWmJszeaxwcrDs4dGs8HhY3Uqbmn4
	DKs8pyAoGm3Adc4fzhAIOyKWPRKCEJ5bWBav/z6ie0lvML+WFx5zfulqMlaiYwHgxr82Hif4=
X-Received: by 2002:a05:6000:1a8c:b0:430:fd0f:2910 with SMTP id ffacd0b85a97d-43629345a06mr884828f8f.26.1770323227424;
        Thu, 05 Feb 2026 12:27:07 -0800 (PST)
Received: from localhost ([2620:10d:c092:500::6:1325])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4362972fa41sm630573f8f.23.2026.02.05.12.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 12:27:07 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Thu, 05 Feb 2026 20:24:31 +0000
Subject: [PATCH RFC bpf-next 01/12] bpf: Register rhash map
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-rhash-v1-1-30dd6d63c462@meta.com>
References: <20260205-rhash-v1-0-30dd6d63c462@meta.com>
In-Reply-To: <20260205-rhash-v1-0-30dd6d63c462@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, ameryhung@gmail.com, memxor@gmail.com, 
 puranjay@kernel.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770323223; l=4361;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=Y0LQstCFVrmLNbDlOBh2YAFeXK/MGQujPUzkyl9U27I=;
 b=TrJ9tuBQRJHJpt9PcpZ9KGd2ZT4a5KJJrgwpOsVzCcrPImOWmfTTFf5WCVJTtzEc6UYfanMy1
 j30rOjHRX9PDxby66h9vpri1iU06EKI0y50hNxSKbKJIiE5B94wrU95
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=TFoLStOoH/++W4HJHRgNr8zj8vPFB1W+/QECPcQygzo=

From: Mykyta Yatsenko <yatsenko@meta.com>

Add resizable hash map into enums where it is needed.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 include/linux/bpf_types.h      | 1 +
 include/uapi/linux/bpf.h       | 1 +
 kernel/bpf/map_iter.c          | 3 ++-
 kernel/bpf/syscall.c           | 3 +++
 kernel/bpf/verifier.c          | 1 +
 tools/include/uapi/linux/bpf.h | 1 +
 6 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
index b13de31e163f84ca81967e0ee91b290ad4082917..56e4c3f983d34a7efc6d0f3fecf2ae001dfac059 100644
--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -134,6 +134,7 @@ BPF_MAP_TYPE(BPF_MAP_TYPE_BLOOM_FILTER, bloom_filter_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_USER_RINGBUF, user_ringbuf_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_ARENA, arena_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_INSN_ARRAY, insn_array_map_ops)
+BPF_MAP_TYPE(BPF_MAP_TYPE_RHASH, rhtab_map_ops)
 
 BPF_LINK_TYPE(BPF_LINK_TYPE_RAW_TRACEPOINT, raw_tracepoint)
 BPF_LINK_TYPE(BPF_LINK_TYPE_TRACING, tracing)
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index c8d400b7680a81236f1b352b38fef4bdc099cfb5..8910270fa9bcdc68f4b5636e4992850a9eb98542 100644
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
index 261a03ea73d3497e9b56a4e587b651aaa55aa32d..4a2aafbe28b4affeb7e12560396262da9f732051 100644
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
index 5f59dd47a5b1c3b80652dabd64ad7853ac1db083..40c58957ac5bf36b2e6c6d765329fcfb5b4f6d3d 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1286,6 +1286,7 @@ static int map_check_btf(struct bpf_map *map, struct bpf_token *token,
 			case BPF_SPIN_LOCK:
 			case BPF_RES_SPIN_LOCK:
 				if (map->map_type != BPF_MAP_TYPE_HASH &&
+				    map->map_type != BPF_MAP_TYPE_RHASH &&
 				    map->map_type != BPF_MAP_TYPE_ARRAY &&
 				    map->map_type != BPF_MAP_TYPE_CGROUP_STORAGE &&
 				    map->map_type != BPF_MAP_TYPE_SK_STORAGE &&
@@ -1463,6 +1464,7 @@ static int map_create(union bpf_attr *attr, bpfptr_t uattr)
 	case BPF_MAP_TYPE_CGROUP_ARRAY:
 	case BPF_MAP_TYPE_ARRAY_OF_MAPS:
 	case BPF_MAP_TYPE_HASH:
+	case BPF_MAP_TYPE_RHASH:
 	case BPF_MAP_TYPE_PERCPU_HASH:
 	case BPF_MAP_TYPE_HASH_OF_MAPS:
 	case BPF_MAP_TYPE_RINGBUF:
@@ -2198,6 +2200,7 @@ static int map_lookup_and_delete_elem(union bpf_attr *attr)
 		   map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
 		   map->map_type == BPF_MAP_TYPE_LRU_HASH ||
 		   map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH ||
+		   map->map_type == BPF_MAP_TYPE_RHASH ||
 		   map->map_type == BPF_MAP_TYPE_STACK_TRACE) {
 		if (!bpf_map_is_offloaded(map)) {
 			bpf_disable_instrumentation();
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index edf5342b982f676567579ed6349ccd5391eee7c8..0803dca3d93f9e912824aa89951cb5b65e961af9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21558,6 +21558,7 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 	if (prog->sleepable)
 		switch (map->map_type) {
 		case BPF_MAP_TYPE_HASH:
+		case BPF_MAP_TYPE_RHASH:
 		case BPF_MAP_TYPE_LRU_HASH:
 		case BPF_MAP_TYPE_ARRAY:
 		case BPF_MAP_TYPE_PERCPU_HASH:
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 5e38b4887de6ae59fe0a62511757be2d1019eded..7e158396ca42f295b7c7358d74e860564ceaf2bb 100644
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
2.53.0

