Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1A737A481
	for <bpf@vger.kernel.org>; Sun, 29 Mar 2026 14:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774793166; cv=none; b=RdIfNtAWEkN245CnP5UmdMw5RlhAnE369IkbL5c+taHbG101nvQ0b07i4TGIl6geFQ0g5ff0Cx4LBVeKqkgrv0IqRJ5ObUxaI7m5NMjizy+/F+1t3qy3dZvPNV8fUPGQgFZ0EBbELQnv2ypLHYdpQEmEGDh5lRKgGNa2Yc2yVFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774793166; c=relaxed/simple;
	bh=tPdGTAhKk9uUuJbJVbIiih1qpIQRVY60ISz1bsCYIG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q8DGUCsfdT6Yze34Ms4AUmp5avjzhQ5ymsT2mTmT+ZA4hutm1GLWo/RMz64dEStGJoqCv2X5VtcQIq4YRVged5rAVUXah12KsnPUDGQyfHYkZGHBKyJ95kVt9VoHVJu20yPypARobEAVkPQI64rHPUkGySGweNNFSZdIihmFY0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kv8As0F1; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kv8As0F1"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35da1af3e10so441696a91.3
        for <bpf@vger.kernel.org>; Sun, 29 Mar 2026 07:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774793164; x=1775397964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IsS0LRWkeTNfaLxRCLgnZWxO5ozeSApl7pBPb8LQn1A=;
        b=kv8As0F1GUJD4wS+pDMuBkgYUIsxCymnFkkshp2uUFxyVoaD4n5MjSIY2lI4PpUvBq
         hHiUdQnlo2do0TWNsXCCe3a/7ySP/w+vPUYBmtJydUKeuPmsKHNoD5xA/8cKd0whkTxN
         nMEnEcaEARUAoOlzibec9Cwn39VsD/iKqTvVt0xn6/MMZJivjs5JjkpFkhon0yooxHxn
         MozslC7Gg6q2lKt79KPM1RhgHRrOdnpXuL3+9spACD0YRqULBPggshPS0MUynZqosyY5
         FSXIgp2iWDPFoRgwm+gG7L3uk3zodtlyvOB5IPDmpaPxTxf+av1m5grXDfMysJ3qxmsm
         36+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774793164; x=1775397964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IsS0LRWkeTNfaLxRCLgnZWxO5ozeSApl7pBPb8LQn1A=;
        b=k3mMZOeGNDcv+R21CsQsF3z4apGqtkB8VBb6gQPyMpax928JvdFiUBfyv0w1hjxcWs
         EC4AO/KNAvSe7tpSISfLvAosEhvz1wLs9afEa14JOCapb7chcRd+gSOZBxH+TjMfeR7V
         Q6/viwWlINSrHSN/mFyv2LP5wzbQz5mlLEMPj0myFkw4wqyaxD0mTiSMxajP76v/PtcG
         lk+Vb7CJIyE2PRKJQ2C9WPKaMZqTivKBezMtZax90KpZ3/AhOf/si+Q1BPrakTwo93ly
         3+AE59ztddPw6ySP95zHxYet8OncPbs7Q4kKFK1O4yEr7LHIAr7edNG8aaNqFLs2C0H+
         59QQ==
X-Gm-Message-State: AOJu0YwPQ5SzMHSN/mnjE1y/tgK2LfFfYxdx0iAQ6sO8gmNBbSz2heUg
	L+XHkcat+nPmIjKbQu3jzk0SnOGlBRwkdcuJvl8QwyFWpiQeBw9NVr88
X-Gm-Gg: ATEYQzzaYNzfOd9yelFLm7Qj+9/RqHTx/NLHCc7WGNI91G887/66fKgJIrfLh3lldCd
	p7gGX9o8MbgsSFs+c6syYcOB7s3k9mSenspnAlJF2Tvx04Zp3EosPVoWbURVStXTx5UKgWKZz/K
	3SzSIBKQ0vaRYFrDCzIX94/rJhs0fkUpz7zb/GQJdvdsQbVrjie2VcYeAb6fcpUUORKyEC2CgiE
	0UpCF7sQX8Sk26RAp7GlQMXR9UbhL6DdVZBFrmFSaAOpEyfPCQNxXZK3HSzVbbLlwU+2fsP3QFN
	PL3sy94xro3oLrV83Kb7A1VbaKSnGp+psG7EtW0L3T2xhjZpSkKfmu5Qqc3XyJPUb+pPCRJZ9DV
	5xP/19Cyujr+4z7NcqWPo3ynF6DUVhLExtjngNIpuNy5r8G6/ZYOauVOdhItBCQmgUbTOig+G9A
	qDd99p3XuwlWqilTFGU6NVtc5MdBBIdrAi1sN4nxQmcqDy/z9vS2CM7g==
X-Received: by 2002:a17:90b:558d:b0:35b:9720:98d0 with SMTP id 98e67ed59e1d1-35c2ffa8265mr8695085a91.5.1774793164035;
        Sun, 29 Mar 2026 07:06:04 -0700 (PDT)
Received: from localhost.localdomain ([113.218.252.111])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35d950bd630sm4417454a91.16.2026.03.29.07.05.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 29 Mar 2026 07:06:03 -0700 (PDT)
From: Chengkaitao <pilgrimtao@gmail.com>
To: martin.lau@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	chengkaitao@kylinos.cn,
	linux-kselftest@vger.kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v9 7/9] bpf: allow bpf_list_front/back result as the prev argument of bpf_list_add_impl
Date: Sun, 29 Mar 2026 22:05:04 +0800
Message-ID: <20260329140506.9595-8-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260329140506.9595-1-pilgrimtao@gmail.com>
References: <20260329140506.9595-1-pilgrimtao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kaitao Cheng <chengkaitao@kylinos.cn>

KF_ARG_PTR_TO_LIST_NODE normally requires an owning reference
(PTR_TO_BTF_ID | MEM_ALLOC and ref_obj_id). For bpf_list_add_impl's
third argument (prev), allow a non-owning reference with ref_obj_id==0
so that the result of bpf_list_front() or bpf_list_back() can be passed
as the insertion point. When prev is such a non-owning ref, skip the
MEM_ALLOC/ref_obj_id checks and jump to the shared list-node processing.
Owning refs (e.g. from pop + refcount_acquire) still pass the existing
checks and reach the same label.

Add BTF suffix __nonown_allowed (is_kfunc_arg_nonown_allowed) and
document it under kfuncs.rst.

Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
---
 Documentation/bpf/kfuncs.rst | 20 +++++++++++++++++++-
 kernel/bpf/helpers.c         |  4 ++--
 kernel/bpf/verifier.c        | 13 +++++++++++++
 3 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index 75e6c078e0e7..6760c547dd32 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -207,7 +207,25 @@ Here, the buffer may be NULL. If the buffer is not NULL, it must be at least
 buffer__szk bytes in size. The kfunc is responsible for checking if the buffer
 is NULL before using it.
 
-2.3.5 __str Annotation
+2.3.5 __nonown_allowed Annotation
+----------------------------------
+
+This annotation is used to indicate that the parameter may be a non-owning reference.
+
+An example is given below::
+
+        __bpf_kfunc int bpf_list_add_impl(..., struct bpf_list_node
+                                          *prev__nonown_allowed, ...)
+        {
+                ...
+        }
+
+For the ``prev__nonown_allowed`` parameter (resolved as ``KF_ARG_PTR_TO_LIST_NODE``),
+suffix ``__nonown_allowed`` retains the usual owning-pointer rules and also
+permits a non-owning reference with no ref_obj_id (e.g. the return value of
+bpf_list_front() / bpf_list_back()).
+
+2.3.6 __str Annotation
 ----------------------------
 This annotation is used to indicate that the argument is a constant string.
 
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 68c83a009275..743341aae5c0 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2449,10 +2449,10 @@ __bpf_kfunc int bpf_list_push_back_impl(struct bpf_list_head *head,
 
 __bpf_kfunc int bpf_list_add_impl(struct bpf_list_head *head,
 				  struct bpf_list_node *new,
-				  struct bpf_list_node *prev,
+				  struct bpf_list_node *prev__nonown_allowed,
 				  void *meta__ign, u64 off)
 {
-	struct bpf_list_node_kern *n = (void *)new, *p = (void *)prev;
+	struct bpf_list_node_kern *n = (void *)new, *p = (void *)prev__nonown_allowed;
 	struct btf_struct_meta *meta = meta__ign;
 	struct list_head *prev_ptr = &p->list_head;
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 69dcf0105973..514a0aab93b8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12265,6 +12265,11 @@ static bool is_kfunc_arg_nullable(const struct btf *btf, const struct btf_param
 	return btf_param_match_suffix(btf, arg, "__nullable");
 }
 
+static bool is_kfunc_arg_nonown_allowed(const struct btf *btf, const struct btf_param *arg)
+{
+	return btf_param_match_suffix(btf, arg, "__nonown_allowed");
+}
+
 static bool is_kfunc_arg_const_str(const struct btf *btf, const struct btf_param *arg)
 {
 	return btf_param_match_suffix(btf, arg, "__str");
@@ -13736,6 +13741,13 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				return ret;
 			break;
 		case KF_ARG_PTR_TO_LIST_NODE:
+			if (is_kfunc_arg_nonown_allowed(btf, &args[i]) &&
+			    type_is_non_owning_ref(reg->type) && !reg->ref_obj_id) {
+				/* Allow bpf_list_front/back return value as
+				 * list_add_impl's third arg (R3).
+				 */
+				goto check_ok;
+			}
 			if (reg->type != (PTR_TO_BTF_ID | MEM_ALLOC)) {
 				verbose(env, "arg#%d expected pointer to allocated object\n", i);
 				return -EINVAL;
@@ -13744,6 +13756,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				verbose(env, "allocated object must be referenced\n");
 				return -EINVAL;
 			}
+check_ok:
 			ret = process_kf_arg_ptr_to_list_node(env, reg, regno, meta);
 			if (ret < 0)
 				return ret;
-- 
2.50.1 (Apple Git-155)

