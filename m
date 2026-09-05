Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C77372ECD
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 22:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788645692; cv=none; b=jOiovldo4pyDPvnlh/P0YlLMrK6VLy/aIUAQW9NVPGiucsfGhxRnHfBJLeMh/4lcwLBssz/wn+8TO/38FgvTeoGY95slbGyKvmWNrVZZzpcDCrUfe19fQ1llbyEyomez6R0IEQSSpyczKjm4EHp1esyxpRZV3DCPFmb6wdlDlTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788645692; c=relaxed/simple;
	bh=Gt7Zas5jg5c6/Elb4s+eYtSHlsQHdThshxS8+kUzvRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ETbOD3jhj7U3Zt3jgttvuYj73pAoRVFBYEpwjkYcruNi4OVARuycRbwXlNRQL2rjkYhDJ9ZMb58vRA3ZubXxadxGo+33cDQIo6V36q2KZ4TlOGwBEDoc77W2YM2oFPgsn03HC4ZZstm7+sFfuu3OOY/a3CA/Hoqadex1jqQEMrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GJM25i2s; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJM25i2s"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7e6b5737bb2so2950961a34.1
        for <bpf@vger.kernel.org>; Sat, 05 Sep 2026 15:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788645688; x=1789250488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oVZYqsSUSysdPIGLhI6+r4RZDOUHDW1pcu+8RYqVVyU=;
        b=GJM25i2s1lIb7Pe2aA/n1EiLBVfktslseXnKtLCVrs/8wEDBuWuCdo6aLKwJwrC4zB
         BM2UWr+Y9AOb+ElEPymBX+6MLntUW73ZZvXEUZAdwtDoRzXatLlTyAubwW9wr0hUjqRM
         /+wDXptzcP2ZxwnI60BYbFioiehrqRUpLbnF4TazZc6P5DdxFvijFZDl4DeqVjscJU85
         y3uximbztbT938sCMaHPLPe0ZPUtTbYo5VMGSNBk5P7K1XQ1DWmq6BmRWtMWcd00/Nx5
         mQhZyf18D3cgmdMYTkkF7bPz9D3kC6eK2xt+2SzLxTi5jvv3r6EIWwRUKCTzDwOeqVt8
         BvGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788645688; x=1789250488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oVZYqsSUSysdPIGLhI6+r4RZDOUHDW1pcu+8RYqVVyU=;
        b=lbXmV45BQJmfXKyZYY8CWZxOJ7PAn7uL2NDx6JvF1J7RqhLOKEBL50cLCrnGgKWOtt
         dZ8XF4AtmN8fzwC07Hr05z+Ub65r1WLw7Zvordw3D94qP0Fvw+XNXsXOaa0YbcxkNpPm
         2s9KhAlHwIzttrgpZGpRxyUV5ot5jWGO0zgiyZ2FhyGwZ8rryAYkkQY5iqpUZDzozW0i
         8sKBmbABw5IqaUnu+9XF4Dd13fOwuYWPwqyzJOcbvAcJGpN45KASxz0bbt1UiuDURKIo
         mXyriukTrmiMTr8zfwduVBTDcMHZJ0A07N278qtfcPXfKckLACm71UB0fZH3EEeH765k
         hiFA==
X-Gm-Message-State: AFuF++mbsiHT4mibbSAd1P6G77pIKW2MFdklHiM6Cugz8jeAZkfnQ7Sz
	Ty4vCUE1O66UzStPBeW5k67lpWKv4m7fgDLjG1RC7vYLvxFGkm2gW/Sm7QMONQ==
X-Gm-Gg: AYBFou1EA5YrfI1H2NvuprNB7B2j97oUPedKHOSmlvCGX0sMZ+updzED0ndovtpWpm1
	o5dhvZ6jJceVAHH3smjV47H2kvpon3lSxV9cmeDXF5OkDfH4NdwHwR6CXCGeMJWqDRprD3kYfwx
	yovzWmh2tpX3Rzed5jKfqYBfPjvt7JHp7VGyIFW6r0c6BoVq8LL6iCnAof/fumTLy+mZinXNR4c
	PYp/Cono00sPLZuCEDbWUF943AG81vjHVV2zhPP3cv++QBtMC9C7ExLnmFye9kZlUNlXkG6XWmW
	fxIy2gMxHxO9Of7w+YjOr42R6O2dKQOvLgwyFn0PexJcUq2jEMRAdC/K2w68UuFLDKj5xDdgdie
	jBRbqvPte+DJA4XY1Ivggi6znvM1jR/dFAT0HqboXZCeDAT5oH3+jdls4UZ8LXn3evZIb2g5aCw
	iBi0IKMCmw4Vd8uqL8FGQs5mJNOLQwkBxgxxkFp7Cq0QiMtp5Dpg==
X-Received: by 2002:a05:6830:4889:b0:7e9:adef:4fd4 with SMTP id 46e09a7af769-7fa1f519aa8mr10822539a34.11.1788645687114;
        Sat, 05 Sep 2026 15:01:27 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:6::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f9f72d3c8asm7354203a34.21.2026.09.05.15.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 15:01:26 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 05/22] bpf: Rename ambiguous function argument types
Date: Sat,  5 Sep 2026 15:01:00 -0700
Message-ID: <20260905220117.922028-6-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260905220117.922028-1-ameryhung@gmail.com>
References: <20260905220117.922028-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ARG_ANYTHING does not accept just anything: check_func_arg() accepts
an initialized scalar and rejects pointers. Rename it to ARG_SCALAR.

ARG_DONTCARE is the zero-valued terminator for the fixed-size argument
array rather than an argument whose value is ignored. Rename it to
ARG_UNUSED and stop helper argument iteration explicitly when it
is encountered.

Also pass ARG_PTR_TO_MEM when checking a global subprogram memory
argument instead of using the prototype terminator as a placeholder.

No functional change.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 drivers/media/rc/bpf-lirc.c    |  10 +-
 include/linux/bpf.h            |   4 +-
 kernel/bpf/backtrack.c         |   2 +-
 kernel/bpf/bpf_cgrp_storage.c  |   2 +-
 kernel/bpf/bpf_inode_storage.c |   2 +-
 kernel/bpf/bpf_iter.c          |   6 +-
 kernel/bpf/bpf_lsm.c           |   2 +-
 kernel/bpf/bpf_task_storage.c  |   2 +-
 kernel/bpf/btf.c               |   6 +-
 kernel/bpf/cgroup.c            |   6 +-
 kernel/bpf/core.c              |   2 +-
 kernel/bpf/helpers.c           |  46 ++---
 kernel/bpf/ringbuf.c           |  20 +--
 kernel/bpf/stackmap.c          |  14 +-
 kernel/bpf/syscall.c           |   6 +-
 kernel/bpf/task_iter.c         |   4 +-
 kernel/bpf/verifier.c          |  27 ++-
 kernel/trace/bpf_trace.c       |  46 ++---
 net/core/bpf_sk_storage.c      |   6 +-
 net/core/filter.c              | 302 ++++++++++++++++-----------------
 net/core/sock_map.c            |  16 +-
 net/ipv4/bpf_tcp_ca.c          |   2 +-
 22 files changed, 266 insertions(+), 267 deletions(-)

diff --git a/drivers/media/rc/bpf-lirc.c b/drivers/media/rc/bpf-lirc.c
index 2f7564f26445..108edf440c89 100644
--- a/drivers/media/rc/bpf-lirc.c
+++ b/drivers/media/rc/bpf-lirc.c
@@ -52,9 +52,9 @@ static const struct bpf_func_proto rc_keydown_proto = {
 	.gpl_only  = true, /* rc_keydown is EXPORT_SYMBOL_GPL */
 	.ret_type  = RET_INTEGER,
 	.arg1_type = ARG_PTR_TO_CTX,
-	.arg2_type = ARG_ANYTHING,
-	.arg3_type = ARG_ANYTHING,
-	.arg4_type = ARG_ANYTHING,
+	.arg2_type = ARG_SCALAR,
+	.arg3_type = ARG_SCALAR,
+	.arg4_type = ARG_SCALAR,
 };
 
 BPF_CALL_3(bpf_rc_pointer_rel, u32*, sample, s32, rel_x, s32, rel_y)
@@ -75,8 +75,8 @@ static const struct bpf_func_proto rc_pointer_rel_proto = {
 	.gpl_only  = true,
 	.ret_type  = RET_INTEGER,
 	.arg1_type = ARG_PTR_TO_CTX,
-	.arg2_type = ARG_ANYTHING,
-	.arg3_type = ARG_ANYTHING,
+	.arg2_type = ARG_SCALAR,
+	.arg3_type = ARG_SCALAR,
 };
 
 static const struct bpf_func_proto *
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 3a7eb2185c35..1574fe2d8cc0 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -874,7 +874,7 @@ enum bpf_type_flag {
 
 /* function argument constraints */
 enum bpf_arg_type {
-	ARG_DONTCARE = 0,	/* unused argument in helper function */
+	ARG_UNUSED = 0,	/* unused argument; terminates argument iteration */
 
 	/* the following constraints used to prototype
 	 * bpf_map_lookup/update/delete_elem() functions
@@ -893,7 +893,7 @@ enum bpf_arg_type {
 	ARG_MEM_SIZE_OR_ZERO,	/* number of bytes accessed from memory or 0 */
 
 	ARG_PTR_TO_CTX,		/* pointer to context */
-	ARG_ANYTHING,		/* any (initialized) argument is ok */
+	ARG_SCALAR,		/* any (initialized) scalar is ok */
 	ARG_PTR_TO_SPIN_LOCK,	/* pointer to bpf_spin_lock */
 	ARG_PTR_TO_SOCK_COMMON,	/* pointer to sock_common */
 	ARG_PTR_TO_SOCKET,	/* pointer to bpf_sock (fullsock) */
diff --git a/kernel/bpf/backtrack.c b/kernel/bpf/backtrack.c
index 653db80bcc47..c5c9c5f3b078 100644
--- a/kernel/bpf/backtrack.c
+++ b/kernel/bpf/backtrack.c
@@ -634,7 +634,7 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
  * The approach of starting with precise=true for all registers and then
  * backtrack to mark a register as not precise when the verifier detects
  * that program doesn't care about specific value (e.g., when helper
- * takes register as ARG_ANYTHING parameter) is not safe.
+ * takes register as ARG_SCALAR parameter) is not safe.
  *
  * It's ok to walk single parentage chain of the verifier states.
  * It's possible that this backtracking will go all the way till 1st insn.
diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_storage.c
index c76e9b0fabba..095d5c93e4ba 100644
--- a/kernel/bpf/bpf_cgrp_storage.c
+++ b/kernel/bpf/bpf_cgrp_storage.c
@@ -180,7 +180,7 @@ const struct bpf_func_proto bpf_cgrp_storage_get_proto = {
 	.arg2_type	= ARG_PTR_TO_BTF_ID_OR_NULL,
 	.arg2_btf_id	= &bpf_cgroup_btf_id[0],
 	.arg3_type	= ARG_PTR_TO_MAP_VALUE_OR_NULL,
-	.arg4_type	= ARG_ANYTHING,
+	.arg4_type	= ARG_SCALAR,
 };
 
 const struct bpf_func_proto bpf_cgrp_storage_delete_proto = {
diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
index f9e81060c1f4..69e1876650dd 100644
--- a/kernel/bpf/bpf_inode_storage.c
+++ b/kernel/bpf/bpf_inode_storage.c
@@ -220,7 +220,7 @@ const struct bpf_func_proto bpf_inode_storage_get_proto = {
 	.arg2_type	= ARG_PTR_TO_BTF_ID_OR_NULL,
 	.arg2_btf_id	= &bpf_inode_storage_btf_ids[0],
 	.arg3_type	= ARG_PTR_TO_MAP_VALUE_OR_NULL,
-	.arg4_type	= ARG_ANYTHING,
+	.arg4_type	= ARG_SCALAR,
 };
 
 const struct bpf_func_proto bpf_inode_storage_delete_proto = {
diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index 14a5fdfa0421..1068bf8621f0 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -721,7 +721,7 @@ const struct bpf_func_proto bpf_for_each_map_elem_proto = {
 	.arg1_type	= ARG_CONST_MAP_PTR,
 	.arg2_type	= ARG_PTR_TO_FUNC,
 	.arg3_type	= ARG_PTR_TO_STACK_OR_NULL,
-	.arg4_type	= ARG_ANYTHING,
+	.arg4_type	= ARG_SCALAR,
 };
 
 BPF_CALL_4(bpf_loop, u32, nr_loops, void *, callback_fn, void *, callback_ctx,
@@ -754,10 +754,10 @@ const struct bpf_func_proto bpf_loop_proto = {
 	.func		= bpf_loop,
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
-	.arg1_type	= ARG_ANYTHING,
+	.arg1_type	= ARG_SCALAR,
 	.arg2_type	= ARG_PTR_TO_FUNC,
 	.arg3_type	= ARG_PTR_TO_STACK_OR_NULL,
-	.arg4_type	= ARG_ANYTHING,
+	.arg4_type	= ARG_SCALAR,
 };
 
 struct bpf_iter_num_kern {
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 82c5988417a0..9ee39c654dc0 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -163,7 +163,7 @@ static const struct bpf_func_proto bpf_bprm_opts_set_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_BTF_ID,
 	.arg1_btf_id	= &bpf_bprm_opts_set_btf_ids[0],
-	.arg2_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_SCALAR,
 };
 
 BPF_CALL_3(bpf_ima_inode_hash, struct inode *, inode, void *, dst, u32, size)
diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
index 4b342be29eac..e002df9d3a14 100644
--- a/kernel/bpf/bpf_task_storage.c
+++ b/kernel/bpf/bpf_task_storage.c
@@ -243,7 +243,7 @@ const struct bpf_func_proto bpf_task_storage_get_proto = {
 	.arg2_type = ARG_PTR_TO_BTF_ID_OR_NULL,
 	.arg2_btf_id = &btf_tracing_ids[BTF_TRACING_TYPE_TASK],
 	.arg3_type = ARG_PTR_TO_MAP_VALUE_OR_NULL,
-	.arg4_type = ARG_ANYTHING,
+	.arg4_type = ARG_SCALAR,
 };
 
 const struct bpf_func_proto bpf_task_storage_delete_proto = {
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 9c2cab08bb79..0bd26b2ec77d 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8222,7 +8222,7 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
 			return -EINVAL;
 		}
 		if (btf_type_is_int(t) || btf_is_any_enum(t)) {
-			sub->args[i].arg_type = ARG_ANYTHING;
+			sub->args[i].arg_type = ARG_SCALAR;
 			continue;
 		}
 		if (!is_global)
@@ -8747,8 +8747,8 @@ const struct bpf_func_proto bpf_btf_find_by_name_kind_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg2_type	= ARG_MEM_SIZE,
-	.arg3_type	= ARG_ANYTHING,
-	.arg4_type	= ARG_ANYTHING,
+	.arg3_type	= ARG_SCALAR,
+	.arg4_type	= ARG_SCALAR,
 };
 
 BTF_ID_LIST_GLOBAL(btf_tracing_ids, MAX_BTF_TRACING_TYPE)
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 149672c76c49..aa7da999cdb8 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1840,7 +1840,7 @@ const struct bpf_func_proto bpf_get_local_storage_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_PTR_TO_MAP_VALUE,
 	.arg1_type	= ARG_CONST_MAP_PTR,
-	.arg2_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_SCALAR,
 };
 
 BPF_CALL_0(bpf_get_retval)
@@ -1870,7 +1870,7 @@ const struct bpf_func_proto bpf_set_retval_proto = {
 	.func		= bpf_set_retval,
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
-	.arg1_type	= ARG_ANYTHING,
+	.arg1_type	= ARG_SCALAR,
 };
 
 static const struct bpf_func_proto *
@@ -2331,7 +2331,7 @@ static const struct bpf_func_proto bpf_sysctl_get_name_proto = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_PTR_TO_MEM | MEM_WRITE,
 	.arg3_type	= ARG_MEM_SIZE,
-	.arg4_type	= ARG_ANYTHING,
+	.arg4_type	= ARG_SCALAR,
 };
 
 static int copy_sysctl_value(char *dst, size_t dst_len, char *src,
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 5db77d7915df..404dc6db0691 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3208,7 +3208,7 @@ const struct bpf_func_proto bpf_tail_call_proto = {
 	.ret_type	= RET_VOID,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_CONST_MAP_PTR,
-	.arg3_type	= ARG_ANYTHING,
+	.arg3_type	= ARG_SCALAR,
 };
 
 /* Stub for JITs that only support cBPF. eBPF programs are interpreted.
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index b3cc5c8fc875..72bfd8f93ae4 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -71,7 +71,7 @@ const struct bpf_func_proto bpf_map_update_elem_proto = {
 	.arg1_type	= ARG_CONST_MAP_PTR,
 	.arg2_type	= ARG_PTR_TO_MAP_KEY,
 	.arg3_type	= ARG_PTR_TO_MAP_VALUE,
-	.arg4_type	= ARG_ANYTHING,
+	.arg4_type	= ARG_SCALAR,
 };
 
 BPF_CALL_2(bpf_map_delete_elem, struct bpf_map *, map, void *, key)
@@ -101,7 +101,7 @@ const struct bpf_func_proto bpf_map_push_elem_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_CONST_MAP_PTR,
 	.arg2_type	= ARG_PTR_TO_MAP_VALUE,
-	.arg3_type	= ARG_ANYTHING,
+	.arg3_type	= ARG_SCALAR,
 };
 
 BPF_CALL_2(bpf_map_pop_elem, struct bpf_map *, map, void *, value)
@@ -143,7 +143,7 @@ const struct bpf_func_proto bpf_map_lookup_percpu_elem_proto = {
 	.ret_type	= RET_PTR_TO_MAP_VALUE_OR_NULL,
 	.arg1_type	= ARG_CONST_MAP_PTR,
 	.arg2_type	= ARG_PTR_TO_MAP_KEY,
-	.arg3_type	= ARG_ANYTHING,
+	.arg3_type	= ARG_SCALAR,
 };
 
 const struct bpf_func_proto bpf_get_prandom_u32_proto = {
@@ -441,7 +441,7 @@ const struct bpf_func_proto bpf_get_current_ancestor_cgroup_id_proto = {
 	.func		= bpf_get_current_ancestor_cgroup_id,
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
-	.arg1_type	= ARG_ANYTHING,
+	.arg1_type	= ARG_SCALAR,
 };
 #endif /* CONFIG_CGROUPS */
 
@@ -540,7 +540,7 @@ const struct bpf_func_proto bpf_strtol_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg2_type	= ARG_MEM_SIZE,
-	.arg3_type	= ARG_ANYTHING,
+	.arg3_type	= ARG_SCALAR,
 	.arg4_type	= ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_WRITE | MEM_ALIGNED,
 	.arg4_size	= sizeof(s64),
 };
@@ -568,7 +568,7 @@ const struct bpf_func_proto bpf_strtoul_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg2_type	= ARG_MEM_SIZE,
-	.arg3_type	= ARG_ANYTHING,
+	.arg3_type	= ARG_SCALAR,
 	.arg4_type	= ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_WRITE | MEM_ALIGNED,
 	.arg4_size	= sizeof(u64),
 };
@@ -624,8 +624,8 @@ const struct bpf_func_proto bpf_get_ns_current_pid_tgid_proto = {
 	.func		= bpf_get_ns_current_pid_tgid,
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
-	.arg1_type	= ARG_ANYTHING,
-	.arg2_type	= ARG_ANYTHING,
+	.arg1_type	= ARG_SCALAR,
+	.arg2_type	= ARG_SCALAR,
 	.arg3_type      = ARG_PTR_TO_UNINIT_MEM,
 	.arg4_type      = ARG_MEM_SIZE,
 };
@@ -651,7 +651,7 @@ const struct bpf_func_proto bpf_event_output_data_proto =  {
 	.ret_type       = RET_INTEGER,
 	.arg1_type      = ARG_PTR_TO_CTX,
 	.arg2_type      = ARG_CONST_MAP_PTR,
-	.arg3_type      = ARG_ANYTHING,
+	.arg3_type      = ARG_SCALAR,
 	.arg4_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg5_type      = ARG_MEM_SIZE_OR_ZERO,
 };
@@ -676,7 +676,7 @@ const struct bpf_func_proto bpf_copy_from_user_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_UNINIT_MEM,
 	.arg2_type	= ARG_MEM_SIZE_OR_ZERO,
-	.arg3_type	= ARG_ANYTHING,
+	.arg3_type	= ARG_SCALAR,
 };
 
 BPF_CALL_5(bpf_copy_from_user_task, void *, dst, u32, size,
@@ -707,10 +707,10 @@ const struct bpf_func_proto bpf_copy_from_user_task_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_UNINIT_MEM,
 	.arg2_type	= ARG_MEM_SIZE_OR_ZERO,
-	.arg3_type	= ARG_ANYTHING,
+	.arg3_type	= ARG_SCALAR,
 	.arg4_type	= ARG_PTR_TO_BTF_ID,
 	.arg4_btf_id	= &btf_tracing_ids[BTF_TRACING_TYPE_TASK],
-	.arg5_type	= ARG_ANYTHING
+	.arg5_type	= ARG_SCALAR
 };
 
 BPF_CALL_2(bpf_per_cpu_ptr, const void *, ptr, u32, cpu)
@@ -726,7 +726,7 @@ const struct bpf_func_proto bpf_per_cpu_ptr_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_PTR_TO_MEM_OR_BTF_ID | PTR_MAYBE_NULL | MEM_RDONLY,
 	.arg1_type	= ARG_PTR_TO_PERCPU_BTF_ID,
-	.arg2_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_SCALAR,
 };
 
 BPF_CALL_1(bpf_this_cpu_ptr, const void *, percpu_ptr)
@@ -1415,7 +1415,7 @@ static const struct bpf_func_proto bpf_timer_init_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_TIMER,
 	.arg2_type	= ARG_CONST_MAP_PTR,
-	.arg3_type	= ARG_ANYTHING,
+	.arg3_type	= ARG_SCALAR,
 };
 
 static int bpf_async_update_prog_callback(struct bpf_async_cb *cb,
@@ -1558,8 +1558,8 @@ static const struct bpf_func_proto bpf_timer_start_proto = {
 	.gpl_only	= true,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_TIMER,
-	.arg2_type	= ARG_ANYTHING,
-	.arg3_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_SCALAR,
+	.arg3_type	= ARG_SCALAR,
 };
 
 BPF_CALL_1(bpf_timer_cancel, struct bpf_async_kern *, async)
@@ -1889,7 +1889,7 @@ static const struct bpf_func_proto bpf_dynptr_from_mem_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_UNINIT_MEM,
 	.arg2_type	= ARG_MEM_SIZE_OR_ZERO,
-	.arg3_type	= ARG_ANYTHING,
+	.arg3_type	= ARG_SCALAR,
 	.arg4_type	= ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_LOCAL | MEM_UNINIT | MEM_WRITE,
 };
 
@@ -1945,8 +1945,8 @@ static const struct bpf_func_proto bpf_dynptr_read_proto = {
 	.arg1_type	= ARG_PTR_TO_UNINIT_MEM,
 	.arg2_type	= ARG_MEM_SIZE_OR_ZERO,
 	.arg3_type	= ARG_PTR_TO_DYNPTR,
-	.arg4_type	= ARG_ANYTHING,
-	.arg5_type	= ARG_ANYTHING,
+	.arg4_type	= ARG_SCALAR,
+	.arg5_type	= ARG_SCALAR,
 };
 
 int __bpf_dynptr_write(const struct bpf_dynptr_kern *dst, u64 offset, void *src,
@@ -2002,10 +2002,10 @@ static const struct bpf_func_proto bpf_dynptr_write_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_DYNPTR,
-	.arg2_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_SCALAR,
 	.arg3_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg4_type	= ARG_MEM_SIZE_OR_ZERO,
-	.arg5_type	= ARG_ANYTHING,
+	.arg5_type	= ARG_SCALAR,
 };
 
 BPF_CALL_3(bpf_dynptr_data, const struct bpf_dynptr_kern *, ptr, u64, offset, u64, len)
@@ -2045,7 +2045,7 @@ static const struct bpf_func_proto bpf_dynptr_data_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_PTR_TO_DYNPTR_MEM_OR_NULL,
 	.arg1_type	= ARG_PTR_TO_DYNPTR,
-	.arg2_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_SCALAR,
 	.arg3_type	= ARG_CONST_ALLOC_SIZE_OR_ZERO,
 };
 
@@ -2957,7 +2957,7 @@ const struct bpf_func_proto bpf_current_task_under_cgroup_proto = {
 	.gpl_only       = false,
 	.ret_type       = RET_INTEGER,
 	.arg1_type      = ARG_CONST_MAP_PTR,
-	.arg2_type      = ARG_ANYTHING,
+	.arg2_type      = ARG_SCALAR,
 };
 
 /**
diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index 3f1013d80544..63c0aba56a3f 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -553,7 +553,7 @@ const struct bpf_func_proto bpf_ringbuf_reserve_proto = {
 	.ret_type	= RET_PTR_TO_RINGBUF_MEM_OR_NULL,
 	.arg1_type	= ARG_CONST_MAP_PTR,
 	.arg2_type	= ARG_CONST_ALLOC_SIZE_OR_ZERO,
-	.arg3_type	= ARG_ANYTHING,
+	.arg3_type	= ARG_SCALAR,
 };
 
 static void bpf_ringbuf_commit(void *sample, u64 flags, bool discard)
@@ -594,7 +594,7 @@ const struct bpf_func_proto bpf_ringbuf_submit_proto = {
 	.func		= bpf_ringbuf_submit,
 	.ret_type	= RET_VOID,
 	.arg1_type	= ARG_PTR_TO_RINGBUF_MEM | OBJ_RELEASE,
-	.arg2_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_SCALAR,
 };
 
 BPF_CALL_2(bpf_ringbuf_discard, void *, sample, u64, flags)
@@ -607,7 +607,7 @@ const struct bpf_func_proto bpf_ringbuf_discard_proto = {
 	.func		= bpf_ringbuf_discard,
 	.ret_type	= RET_VOID,
 	.arg1_type	= ARG_PTR_TO_RINGBUF_MEM | OBJ_RELEASE,
-	.arg2_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_SCALAR,
 };
 
 BPF_CALL_4(bpf_ringbuf_output, struct bpf_map *, map, void *, data, u64, size,
@@ -635,7 +635,7 @@ const struct bpf_func_proto bpf_ringbuf_output_proto = {
 	.arg1_type	= ARG_CONST_MAP_PTR,
 	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg3_type	= ARG_MEM_SIZE_OR_ZERO,
-	.arg4_type	= ARG_ANYTHING,
+	.arg4_type	= ARG_SCALAR,
 };
 
 BPF_CALL_2(bpf_ringbuf_query, struct bpf_map *, map, u64, flags)
@@ -664,7 +664,7 @@ const struct bpf_func_proto bpf_ringbuf_query_proto = {
 	.func		= bpf_ringbuf_query,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_CONST_MAP_PTR,
-	.arg2_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_SCALAR,
 };
 
 BPF_CALL_4(bpf_ringbuf_reserve_dynptr, struct bpf_map *, map, u32, size, u64, flags,
@@ -702,8 +702,8 @@ const struct bpf_func_proto bpf_ringbuf_reserve_dynptr_proto = {
 	.func		= bpf_ringbuf_reserve_dynptr,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_CONST_MAP_PTR,
-	.arg2_type	= ARG_ANYTHING,
-	.arg3_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_SCALAR,
+	.arg3_type	= ARG_SCALAR,
 	.arg4_type	= ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_RINGBUF | MEM_UNINIT | MEM_WRITE,
 };
 
@@ -723,7 +723,7 @@ const struct bpf_func_proto bpf_ringbuf_submit_dynptr_proto = {
 	.func		= bpf_ringbuf_submit_dynptr,
 	.ret_type	= RET_VOID,
 	.arg1_type	= ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_RINGBUF | OBJ_RELEASE,
-	.arg2_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_SCALAR,
 };
 
 BPF_CALL_2(bpf_ringbuf_discard_dynptr, struct bpf_dynptr_kern *, ptr, u64, flags)
@@ -742,7 +742,7 @@ const struct bpf_func_proto bpf_ringbuf_discard_dynptr_proto = {
 	.func		= bpf_ringbuf_discard_dynptr,
 	.ret_type	= RET_VOID,
 	.arg1_type	= ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_RINGBUF | OBJ_RELEASE,
-	.arg2_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_SCALAR,
 };
 
 static int __bpf_user_ringbuf_peek(struct bpf_ringbuf *rb, void **sample, u32 *size)
@@ -876,5 +876,5 @@ const struct bpf_func_proto bpf_user_ringbuf_drain_proto = {
 	.arg1_type	= ARG_CONST_MAP_PTR,
 	.arg2_type	= ARG_PTR_TO_FUNC,
 	.arg3_type	= ARG_PTR_TO_STACK_OR_NULL,
-	.arg4_type	= ARG_ANYTHING,
+	.arg4_type	= ARG_SCALAR,
 };
diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index a839041e0d00..272678b82500 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -665,7 +665,7 @@ const struct bpf_func_proto bpf_get_stackid_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_CONST_MAP_PTR,
-	.arg3_type	= ARG_ANYTHING,
+	.arg3_type	= ARG_SCALAR,
 };
 
 static __u64 count_kernel_ip(const struct perf_callchain_entry *trace)
@@ -739,7 +739,7 @@ const struct bpf_func_proto bpf_get_stackid_proto_pe = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_CONST_MAP_PTR,
-	.arg3_type	= ARG_ANYTHING,
+	.arg3_type	= ARG_SCALAR,
 };
 
 static u32 callchain_store(const struct perf_callchain_entry *trace, u32 trace_nr,
@@ -863,7 +863,7 @@ const struct bpf_func_proto bpf_get_stack_proto = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_PTR_TO_UNINIT_MEM,
 	.arg3_type	= ARG_MEM_SIZE_OR_ZERO,
-	.arg4_type	= ARG_ANYTHING,
+	.arg4_type	= ARG_SCALAR,
 };
 
 BPF_CALL_4(bpf_get_stack_sleepable, struct pt_regs *, regs, void *, buf, u32, size,
@@ -879,7 +879,7 @@ const struct bpf_func_proto bpf_get_stack_sleepable_proto = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_PTR_TO_UNINIT_MEM,
 	.arg3_type	= ARG_MEM_SIZE_OR_ZERO,
-	.arg4_type	= ARG_ANYTHING,
+	.arg4_type	= ARG_SCALAR,
 };
 
 static long __bpf_get_task_stack(struct task_struct *task, void *buf, u32 size,
@@ -916,7 +916,7 @@ const struct bpf_func_proto bpf_get_task_stack_proto = {
 	.arg1_btf_id	= &btf_tracing_ids[BTF_TRACING_TYPE_TASK],
 	.arg2_type	= ARG_PTR_TO_UNINIT_MEM,
 	.arg3_type	= ARG_MEM_SIZE_OR_ZERO,
-	.arg4_type	= ARG_ANYTHING,
+	.arg4_type	= ARG_SCALAR,
 };
 
 BPF_CALL_4(bpf_get_task_stack_sleepable, struct task_struct *, task, void *, buf,
@@ -933,7 +933,7 @@ const struct bpf_func_proto bpf_get_task_stack_sleepable_proto = {
 	.arg1_btf_id	= &btf_tracing_ids[BTF_TRACING_TYPE_TASK],
 	.arg2_type	= ARG_PTR_TO_UNINIT_MEM,
 	.arg3_type	= ARG_MEM_SIZE_OR_ZERO,
-	.arg4_type	= ARG_ANYTHING,
+	.arg4_type	= ARG_SCALAR,
 };
 
 static int __bpf_get_stack_pe(const struct perf_callchain_entry *trace, u32 trace_nr,
@@ -1015,7 +1015,7 @@ const struct bpf_func_proto bpf_get_stack_proto_pe = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_PTR_TO_UNINIT_MEM,
 	.arg3_type	= ARG_MEM_SIZE_OR_ZERO,
-	.arg4_type	= ARG_ANYTHING,
+	.arg4_type	= ARG_SCALAR,
 };
 
 /* Called from eBPF program */
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 6874ba1424af..6950517f6364 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -6569,7 +6569,7 @@ static const struct bpf_func_proto bpf_sys_bpf_proto = {
 	.func		= bpf_sys_bpf,
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
-	.arg1_type	= ARG_ANYTHING,
+	.arg1_type	= ARG_SCALAR,
 	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg3_type	= ARG_MEM_SIZE,
 };
@@ -6594,7 +6594,7 @@ static const struct bpf_func_proto bpf_sys_close_proto = {
 	.func		= bpf_sys_close,
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
-	.arg1_type	= ARG_ANYTHING,
+	.arg1_type	= ARG_SCALAR,
 };
 
 BPF_CALL_4(bpf_kallsyms_lookup_name, const char *, name, int, name_sz, int, flags, u64 *, res)
@@ -6619,7 +6619,7 @@ static const struct bpf_func_proto bpf_kallsyms_lookup_name_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg2_type	= ARG_MEM_SIZE_OR_ZERO,
-	.arg3_type	= ARG_ANYTHING,
+	.arg3_type	= ARG_SCALAR,
 	.arg4_type	= ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_WRITE | MEM_ALIGNED,
 	.arg4_size	= sizeof(u64),
 };
diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index 13e1aabe6f88..91b166acb3b5 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -824,10 +824,10 @@ const struct bpf_func_proto bpf_find_vma_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_BTF_ID,
 	.arg1_btf_id	= &btf_tracing_ids[BTF_TRACING_TYPE_TASK],
-	.arg2_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_SCALAR,
 	.arg3_type	= ARG_PTR_TO_FUNC,
 	.arg4_type	= ARG_PTR_TO_STACK_OR_NULL,
-	.arg5_type	= ARG_ANYTHING,
+	.arg5_type	= ARG_SCALAR,
 };
 
 static inline void bpf_iter_mmput_async(struct mm_struct *mm)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e8ae6edf2f58..d444e72fdd97 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8797,14 +8797,11 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 	u32 key_size;
 	int err = 0;
 
-	if (arg_type == ARG_DONTCARE)
-		return 0;
-
 	err = check_reg_arg(env, regno, SRC_OP);
 	if (err)
 		return err;
 
-	if (arg_type == ARG_ANYTHING) {
+	if (arg_type == ARG_SCALAR) {
 		if (__is_pointer_value(env->allow_ptr_leaks, reg)) {
 			verbose(env, "%s leaks addr into helper function\n",
 				reg_arg_name(env, argno));
@@ -9305,7 +9302,7 @@ static bool check_raw_mode_ok(const struct bpf_func_proto *fn, struct bpf_call_a
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(fn->arg_type); i++) {
-		if (fn->arg_type[i] == ARG_DONTCARE)
+		if (fn->arg_type[i] == ARG_UNUSED)
 			break;
 		if (!arg_type_is_raw_mem(fn->arg_type[i]))
 			continue;
@@ -9355,7 +9352,7 @@ static bool check_btf_id_ok(const struct bpf_func_proto *fn)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(fn->arg_type); i++) {
-		if (fn->arg_type[i] == ARG_DONTCARE)
+		if (fn->arg_type[i] == ARG_UNUSED)
 			break;
 		if (base_type(fn->arg_type[i]) == ARG_PTR_TO_BTF_ID)
 			return !!fn->arg_btf_id[i];
@@ -9378,7 +9375,7 @@ static bool check_mem_arg_rw_flag_ok(const struct bpf_func_proto *fn)
 	for (i = 0; i < ARRAY_SIZE(fn->arg_type); i++) {
 		enum bpf_arg_type arg_type = fn->arg_type[i];
 
-		if (arg_type == ARG_DONTCARE)
+		if (arg_type == ARG_UNUSED)
 			break;
 		if (base_type(arg_type) != ARG_PTR_TO_MEM)
 			continue;
@@ -9396,7 +9393,7 @@ static bool check_proto_release_reg(const struct bpf_func_proto *fn, struct bpf_
 	for (i = 0; i < ARRAY_SIZE(fn->arg_type); i++) {
 		enum bpf_arg_type arg_type = fn->arg_type[i];
 
-		if (arg_type == ARG_DONTCARE)
+		if (arg_type == ARG_UNUSED)
 			break;
 		if (arg_type_is_release(arg_type)) {
 			if (meta->release_regno)
@@ -9767,7 +9764,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 		struct bpf_reg_state *reg = get_func_arg_reg(caller, regs, i);
 		struct bpf_subprog_arg_info *arg = &sub->args[i];
 
-		if (arg->arg_type == ARG_ANYTHING) {
+		if (arg->arg_type == ARG_SCALAR) {
 			if (reg->type != SCALAR_VALUE) {
 				bpf_log(log, "%s is not a scalar\n", reg_arg_name(env, argno));
 				return -EINVAL;
@@ -9791,7 +9788,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 				return -EINVAL;
 			}
 		} else if (base_type(arg->arg_type) == ARG_PTR_TO_MEM) {
-			ret = check_func_arg_reg_off(env, reg, argno, ARG_DONTCARE);
+			ret = check_func_arg_reg_off(env, reg, argno, ARG_PTR_TO_MEM);
 			if (ret < 0)
 				return ret;
 			if (check_mem_reg(env, reg, argno, arg->mem_size, BPF_READ | BPF_WRITE, NULL,
@@ -10949,6 +10946,8 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 	meta.fn = fn;
 	/* check args */
 	for (i = 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
+		if (fn->arg_type[i] == ARG_UNUSED)
+			break;
 		err = check_func_arg(env, i, &meta, insn_idx);
 		if (err)
 			return err;
@@ -12828,7 +12827,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 	for (i = 0; i < nargs; i++) {
 		struct bpf_reg_state *reg = get_func_arg_reg(caller, regs, i);
 		const struct btf_type *t, *ref_t, *resolve_ret;
-		enum bpf_arg_type arg_type = ARG_DONTCARE;
+		enum bpf_arg_type arg_type = ARG_UNUSED;
 		argno_t argno = argno_from_arg(i + 1);
 		int regno = reg_from_argno(argno);
 		bool btf_id_fixed_off_ok = true;
@@ -17841,7 +17840,7 @@ bool bpf_get_call_summary(struct bpf_verifier_env *env, struct bpf_insn *call,
 		cs->is_void = fn->ret_type == RET_VOID;
 		cs->num_params = 0;
 		for (i = 0; i < ARRAY_SIZE(fn->arg_type); ++i) {
-			if (fn->arg_type[i] == ARG_DONTCARE)
+			if (fn->arg_type[i] == ARG_UNUSED)
 				break;
 			cs->num_params++;
 		}
@@ -19637,7 +19636,7 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 			}
 
 			/* Also ensure the callback only has a single scalar argument. */
-			if (sub->arg_cnt != 1 || sub->args[0].arg_type != ARG_ANYTHING) {
+			if (sub->arg_cnt != 1 || sub->args[0].arg_type != ARG_SCALAR) {
 				verbose(env, "exception cb only supports single integer argument\n");
 				ret = -EINVAL;
 				goto out;
@@ -19650,7 +19649,7 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 			if (arg->arg_type == ARG_PTR_TO_CTX) {
 				reg->type = PTR_TO_CTX;
 				mark_reg_known_zero(env, regs, i);
-			} else if (arg->arg_type == ARG_ANYTHING) {
+			} else if (arg->arg_type == ARG_SCALAR) {
 				reg->type = SCALAR_VALUE;
 				mark_reg_unknown(env, regs, i);
 			} else if (arg->arg_type == ARG_PTR_TO_DYNPTR) {
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 29260951aa87..e414858581d0 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -195,7 +195,7 @@ static const struct bpf_func_proto bpf_override_return_proto = {
 	.gpl_only	= true,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_SCALAR,
 };
 #endif
 
@@ -222,7 +222,7 @@ const struct bpf_func_proto bpf_probe_read_user_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_UNINIT_MEM,
 	.arg2_type	= ARG_MEM_SIZE_OR_ZERO,
-	.arg3_type	= ARG_ANYTHING,
+	.arg3_type	= ARG_SCALAR,
 };
 
 static __always_inline int
@@ -259,7 +259,7 @@ const struct bpf_func_proto bpf_probe_read_user_str_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_UNINIT_MEM,
 	.arg2_type	= ARG_MEM_SIZE_OR_ZERO,
-	.arg3_type	= ARG_ANYTHING,
+	.arg3_type	= ARG_SCALAR,
 };
 
 BPF_CALL_3(bpf_probe_read_kernel, void *, dst, u32, size,
@@ -274,7 +274,7 @@ const struct bpf_func_proto bpf_probe_read_kernel_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_UNINIT_MEM,
 	.arg2_type	= ARG_MEM_SIZE_OR_ZERO,
-	.arg3_type	= ARG_ANYTHING,
+	.arg3_type	= ARG_SCALAR,
 };
 
 static __always_inline int
@@ -309,7 +309,7 @@ const struct bpf_func_proto bpf_probe_read_kernel_str_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_UNINIT_MEM,
 	.arg2_type	= ARG_MEM_SIZE_OR_ZERO,
-	.arg3_type	= ARG_ANYTHING,
+	.arg3_type	= ARG_SCALAR,
 };
 
 #ifdef CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
@@ -329,7 +329,7 @@ static const struct bpf_func_proto bpf_probe_read_compat_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_UNINIT_MEM,
 	.arg2_type	= ARG_MEM_SIZE_OR_ZERO,
-	.arg3_type	= ARG_ANYTHING,
+	.arg3_type	= ARG_SCALAR,
 };
 
 BPF_CALL_3(bpf_probe_read_compat_str, void *, dst, u32, size,
@@ -348,7 +348,7 @@ static const struct bpf_func_proto bpf_probe_read_compat_str_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_UNINIT_MEM,
 	.arg2_type	= ARG_MEM_SIZE_OR_ZERO,
-	.arg3_type	= ARG_ANYTHING,
+	.arg3_type	= ARG_SCALAR,
 };
 #endif /* CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE */
 
@@ -381,7 +381,7 @@ static const struct bpf_func_proto bpf_probe_write_user_proto = {
 	.func		= bpf_probe_write_user,
 	.gpl_only	= true,
 	.ret_type	= RET_INTEGER,
-	.arg1_type	= ARG_ANYTHING,
+	.arg1_type	= ARG_SCALAR,
 	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg3_type	= ARG_MEM_SIZE,
 };
@@ -560,7 +560,7 @@ static const struct bpf_func_proto bpf_seq_printf_btf_proto = {
 	.arg1_btf_id	= &btf_seq_file_ids[0],
 	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg3_type	= ARG_MEM_SIZE_OR_ZERO,
-	.arg4_type	= ARG_ANYTHING,
+	.arg4_type	= ARG_SCALAR,
 };
 
 static __always_inline int
@@ -606,7 +606,7 @@ const struct bpf_func_proto bpf_perf_event_read_proto = {
 	.gpl_only	= true,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_CONST_MAP_PTR,
-	.arg2_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_SCALAR,
 };
 
 BPF_CALL_4(bpf_perf_event_read_value, struct bpf_map *, map, u64, flags,
@@ -631,7 +631,7 @@ static const struct bpf_func_proto bpf_perf_event_read_value_proto = {
 	.gpl_only	= true,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_CONST_MAP_PTR,
-	.arg2_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_SCALAR,
 	.arg3_type	= ARG_PTR_TO_UNINIT_MEM,
 	.arg4_type	= ARG_MEM_SIZE,
 };
@@ -728,7 +728,7 @@ static const struct bpf_func_proto bpf_perf_event_output_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_CONST_MAP_PTR,
-	.arg3_type	= ARG_ANYTHING,
+	.arg3_type	= ARG_SCALAR,
 	.arg4_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg5_type	= ARG_MEM_SIZE_OR_ZERO,
 };
@@ -914,7 +914,7 @@ const struct bpf_func_proto bpf_send_signal_proto = {
 	.func		= bpf_send_signal,
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
-	.arg1_type	= ARG_ANYTHING,
+	.arg1_type	= ARG_SCALAR,
 };
 
 BPF_CALL_1(bpf_send_signal_thread, u32, sig)
@@ -926,7 +926,7 @@ const struct bpf_func_proto bpf_send_signal_thread_proto = {
 	.func		= bpf_send_signal_thread,
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
-	.arg1_type	= ARG_ANYTHING,
+	.arg1_type	= ARG_SCALAR,
 };
 
 BPF_CALL_3(bpf_d_path, const struct path *, path, char *, buf, u32, sz)
@@ -1056,7 +1056,7 @@ const struct bpf_func_proto bpf_snprintf_btf_proto = {
 	.arg2_type	= ARG_MEM_SIZE,
 	.arg3_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg4_type	= ARG_MEM_SIZE,
-	.arg5_type	= ARG_ANYTHING,
+	.arg5_type	= ARG_SCALAR,
 };
 
 BPF_CALL_1(bpf_get_func_ip_tracing, void *, ctx)
@@ -1236,7 +1236,7 @@ static const struct bpf_func_proto bpf_get_func_arg_proto = {
 	.func		= get_func_arg,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_SCALAR,
 	.arg3_type	= ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_WRITE | MEM_ALIGNED,
 	.arg3_size	= sizeof(u64),
 };
@@ -1419,7 +1419,7 @@ static const struct bpf_func_proto bpf_perf_event_output_proto_tp = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_CONST_MAP_PTR,
-	.arg3_type	= ARG_ANYTHING,
+	.arg3_type	= ARG_SCALAR,
 	.arg4_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg5_type	= ARG_MEM_SIZE_OR_ZERO,
 };
@@ -1444,7 +1444,7 @@ static const struct bpf_func_proto bpf_get_stackid_proto_tp = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_CONST_MAP_PTR,
-	.arg3_type	= ARG_ANYTHING,
+	.arg3_type	= ARG_SCALAR,
 };
 
 BPF_CALL_4(bpf_get_stack_tp, void *, tp_buff, void *, buf, u32, size,
@@ -1463,7 +1463,7 @@ static const struct bpf_func_proto bpf_get_stack_proto_tp = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_PTR_TO_UNINIT_MEM,
 	.arg3_type	= ARG_MEM_SIZE_OR_ZERO,
-	.arg4_type	= ARG_ANYTHING,
+	.arg4_type	= ARG_SCALAR,
 };
 
 static const struct bpf_func_proto *
@@ -1567,7 +1567,7 @@ static const struct bpf_func_proto bpf_read_branch_records_proto = {
 	.arg1_type      = ARG_PTR_TO_CTX,
 	.arg2_type      = ARG_PTR_TO_MEM_OR_NULL | MEM_WRITE,
 	.arg3_type      = ARG_MEM_SIZE_OR_ZERO,
-	.arg4_type      = ARG_ANYTHING,
+	.arg4_type      = ARG_SCALAR,
 };
 
 static const struct bpf_func_proto *
@@ -1644,7 +1644,7 @@ static const struct bpf_func_proto bpf_perf_event_output_proto_raw_tp = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_CONST_MAP_PTR,
-	.arg3_type	= ARG_ANYTHING,
+	.arg3_type	= ARG_SCALAR,
 	.arg4_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg5_type	= ARG_MEM_SIZE_OR_ZERO,
 };
@@ -1676,7 +1676,7 @@ static const struct bpf_func_proto bpf_get_stackid_proto_raw_tp = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_CONST_MAP_PTR,
-	.arg3_type	= ARG_ANYTHING,
+	.arg3_type	= ARG_SCALAR,
 };
 
 BPF_CALL_4(bpf_get_stack_raw_tp, struct bpf_raw_tracepoint_args *, args,
@@ -1702,7 +1702,7 @@ static const struct bpf_func_proto bpf_get_stack_proto_raw_tp = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_PTR_TO_UNINIT_MEM,
 	.arg3_type	= ARG_MEM_SIZE_OR_ZERO,
-	.arg4_type	= ARG_ANYTHING,
+	.arg4_type	= ARG_SCALAR,
 };
 
 static const struct bpf_func_proto *
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index 1d295a8769fa..ad0f8f222222 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -333,7 +333,7 @@ const struct bpf_func_proto bpf_sk_storage_get_proto = {
 	.arg1_type	= ARG_CONST_MAP_PTR,
 	.arg2_type	= ARG_PTR_TO_BTF_ID_SOCK_COMMON,
 	.arg3_type	= ARG_PTR_TO_MAP_VALUE_OR_NULL,
-	.arg4_type	= ARG_ANYTHING,
+	.arg4_type	= ARG_SCALAR,
 };
 
 const struct bpf_func_proto bpf_sk_storage_get_cg_sock_proto = {
@@ -343,7 +343,7 @@ const struct bpf_func_proto bpf_sk_storage_get_cg_sock_proto = {
 	.arg1_type	= ARG_CONST_MAP_PTR,
 	.arg2_type	= ARG_PTR_TO_CTX, /* context is 'struct sock' */
 	.arg3_type	= ARG_PTR_TO_MAP_VALUE_OR_NULL,
-	.arg4_type	= ARG_ANYTHING,
+	.arg4_type	= ARG_SCALAR,
 };
 
 const struct bpf_func_proto bpf_sk_storage_delete_proto = {
@@ -408,7 +408,7 @@ const struct bpf_func_proto bpf_sk_storage_get_tracing_proto = {
 	.arg2_type	= ARG_PTR_TO_BTF_ID_OR_NULL,
 	.arg2_btf_id	= &btf_sock_ids[BTF_SOCK_TYPE_SOCK_COMMON],
 	.arg3_type	= ARG_PTR_TO_MAP_VALUE_OR_NULL,
-	.arg4_type	= ARG_ANYTHING,
+	.arg4_type	= ARG_SCALAR,
 	.allowed	= bpf_sk_storage_tracing_allowed,
 };
 
diff --git a/net/core/filter.c b/net/core/filter.c
index 61940e753552..89f8755989c5 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -1746,10 +1746,10 @@ static const struct bpf_func_proto bpf_skb_store_bytes_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_SCALAR,
 	.arg3_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg4_type	= ARG_MEM_SIZE,
-	.arg5_type	= ARG_ANYTHING,
+	.arg5_type	= ARG_SCALAR,
 };
 
 int __bpf_skb_store_bytes(struct sk_buff *skb, u32 offset, const void *from,
@@ -1783,7 +1783,7 @@ static const struct bpf_func_proto bpf_skb_load_bytes_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_SCALAR,
 	.arg3_type	= ARG_PTR_TO_UNINIT_MEM,
 	.arg4_type	= ARG_MEM_SIZE,
 };
@@ -1822,7 +1822,7 @@ static const struct bpf_func_proto bpf_flow_dissector_load_bytes_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_SCALAR,
 	.arg3_type	= ARG_PTR_TO_UNINIT_MEM,
 	.arg4_type	= ARG_MEM_SIZE,
 };
@@ -1866,10 +1866,10 @@ static const struct bpf_func_proto bpf_skb_load_bytes_relative_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_SCALAR,
 	.arg3_type	= ARG_PTR_TO_UNINIT_MEM,
 	.arg4_type	= ARG_MEM_SIZE,
-	.arg5_type	= ARG_ANYTHING,
+	.arg5_type	= ARG_SCALAR,
 };
 
 BPF_CALL_2(bpf_skb_pull_data, struct sk_buff *, skb, u32, len)
@@ -1891,7 +1891,7 @@ static const struct bpf_func_proto bpf_skb_pull_data_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_SCALAR,
 };
 
 BPF_CALL_1(bpf_sk_fullsock, struct sock *, sk)
@@ -1931,7 +1931,7 @@ static const struct bpf_func_proto sk_skb_pull_data_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_SCALAR,
 };
 
 BPF_CALL_5(bpf_l3_csum_replace, struct sk_buff *, skb, u32, offset,
@@ -1972,10 +1972,10 @@ static const struct bpf_func_proto bpf_l3_csum_replace_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_ANYTHING,
-	.arg3_type	= ARG_ANYTHING,
-	.arg4_type	= ARG_ANYTHING,
-	.arg5_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_SCALAR,
+	.arg3_type	= ARG_SCALAR,
+	.arg4_type	= ARG_SCALAR,
+	.arg5_type	= ARG_SCALAR,
 };
 
 BPF_CALL_5(bpf_l4_csum_replace, struct sk_buff *, skb, u32, offset,
@@ -2026,10 +2026,10 @@ static const struct bpf_func_proto bpf_l4_csum_replace_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_ANYTHING,
-	.arg3_type	= ARG_ANYTHING,
-	.arg4_type	= ARG_ANYTHING,
-	.arg5_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_SCALAR,
+	.arg3_type	= ARG_SCALAR,
+	.arg4_type	= ARG_SCALAR,
+	.arg5_type	= ARG_SCALAR,
 };
 
 BPF_CALL_5(bpf_csum_diff, __be32 *, from, u32, from_size,
@@ -2067,7 +2067,7 @@ static const struct bpf_func_proto bpf_csum_diff_proto = {
 	.arg2_type	= ARG_MEM_SIZE_OR_ZERO,
 	.arg3_type	= ARG_PTR_TO_MEM | PTR_MAYBE_NULL | MEM_RDONLY,
 	.arg4_type	= ARG_MEM_SIZE_OR_ZERO,
-	.arg5_type	= ARG_ANYTHING,
+	.arg5_type	= ARG_SCALAR,
 };
 
 BPF_CALL_2(bpf_csum_update, struct sk_buff *, skb, __wsum, csum)
@@ -2087,7 +2087,7 @@ static const struct bpf_func_proto bpf_csum_update_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_SCALAR,
 };
 
 BPF_CALL_2(bpf_csum_level, struct sk_buff *, skb, u64, level)
@@ -2121,7 +2121,7 @@ static const struct bpf_func_proto bpf_csum_level_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_SCALAR,
 };
 
 static inline int __bpf_rx_skb(struct net_device *dev, struct sk_buff *skb)
@@ -2506,8 +2506,8 @@ static const struct bpf_func_proto bpf_clone_redirect_proto = {
 	.gpl_only       = false,
 	.ret_type       = RET_INTEGER,
 	.arg1_type      = ARG_PTR_TO_CTX,
-	.arg2_type      = ARG_ANYTHING,
-	.arg3_type      = ARG_ANYTHING,
+	.arg2_type      = ARG_SCALAR,
+	.arg3_type      = ARG_SCALAR,
 };
 
 static struct net_device *skb_get_peer_dev(struct net_device *dev)
@@ -2575,8 +2575,8 @@ static const struct bpf_func_proto bpf_redirect_proto = {
 	.func           = bpf_redirect,
 	.gpl_only       = false,
 	.ret_type       = RET_INTEGER,
-	.arg1_type      = ARG_ANYTHING,
-	.arg2_type      = ARG_ANYTHING,
+	.arg1_type      = ARG_SCALAR,
+	.arg2_type      = ARG_SCALAR,
 };
 
 BPF_CALL_2(bpf_redirect_peer, u32, ifindex, u64, flags)
@@ -2597,8 +2597,8 @@ static const struct bpf_func_proto bpf_redirect_peer_proto = {
 	.func           = bpf_redirect_peer,
 	.gpl_only       = false,
 	.ret_type       = RET_INTEGER,
-	.arg1_type      = ARG_ANYTHING,
-	.arg2_type      = ARG_ANYTHING,
+	.arg1_type      = ARG_SCALAR,
+	.arg2_type      = ARG_SCALAR,
 };
 
 BPF_CALL_4(bpf_redirect_neigh, u32, ifindex, struct bpf_redir_neigh *, params,
@@ -2625,10 +2625,10 @@ static const struct bpf_func_proto bpf_redirect_neigh_proto = {
 	.func		= bpf_redirect_neigh,
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
-	.arg1_type	= ARG_ANYTHING,
+	.arg1_type	= ARG_SCALAR,
 	.arg2_type      = ARG_PTR_TO_MEM | PTR_MAYBE_NULL | MEM_RDONLY,
 	.arg3_type      = ARG_MEM_SIZE_OR_ZERO,
-	.arg4_type	= ARG_ANYTHING,
+	.arg4_type	= ARG_SCALAR,
 };
 
 BPF_CALL_2(bpf_msg_apply_bytes, struct sk_msg *, msg, u32, bytes)
@@ -2642,7 +2642,7 @@ static const struct bpf_func_proto bpf_msg_apply_bytes_proto = {
 	.gpl_only       = false,
 	.ret_type       = RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type      = ARG_ANYTHING,
+	.arg2_type      = ARG_SCALAR,
 };
 
 BPF_CALL_2(bpf_msg_cork_bytes, struct sk_msg *, msg, u32, bytes)
@@ -2701,7 +2701,7 @@ static const struct bpf_func_proto bpf_msg_cork_bytes_proto = {
 	.gpl_only       = false,
 	.ret_type       = RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type      = ARG_ANYTHING,
+	.arg2_type      = ARG_SCALAR,
 };
 
 BPF_CALL_4(bpf_msg_pull_data, struct sk_msg *, msg, u32, start,
@@ -2836,9 +2836,9 @@ static const struct bpf_func_proto bpf_msg_pull_data_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_ANYTHING,
-	.arg3_type	= ARG_ANYTHING,
-	.arg4_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_SCALAR,
+	.arg3_type	= ARG_SCALAR,
+	.arg4_type	= ARG_SCALAR,
 };
 
 BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
@@ -3001,9 +3001,9 @@ static const struct bpf_func_proto bpf_msg_push_data_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_ANYTHING,
-	.arg3_type	= ARG_ANYTHING,
-	.arg4_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_SCALAR,
+	.arg3_type	= ARG_SCALAR,
+	.arg4_type	= ARG_SCALAR,
 };
 
 static void sk_msg_shift_left(struct sk_msg *msg, int i)
@@ -3185,9 +3185,9 @@ static const struct bpf_func_proto bpf_msg_pop_data_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_ANYTHING,
-	.arg3_type	= ARG_ANYTHING,
-	.arg4_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_SCALAR,
+	.arg3_type	= ARG_SCALAR,
+	.arg4_type	= ARG_SCALAR,
 };
 
 #ifdef CONFIG_CGROUP_NET_CLASSID
@@ -3292,7 +3292,7 @@ static const struct bpf_func_proto bpf_set_hash_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_SCALAR,
 };
 
 BPF_CALL_3(bpf_skb_vlan_push, struct sk_buff *, skb, __be16, vlan_proto,
@@ -3318,8 +3318,8 @@ static const struct bpf_func_proto bpf_skb_vlan_push_proto = {
 	.gpl_only       = false,
 	.ret_type       = RET_INTEGER,
 	.arg1_type      = ARG_PTR_TO_CTX,
-	.arg2_type      = ARG_ANYTHING,
-	.arg3_type      = ARG_ANYTHING,
+	.arg2_type      = ARG_SCALAR,
+	.arg3_type      = ARG_SCALAR,
 };
 
 BPF_CALL_1(bpf_skb_vlan_pop, struct sk_buff *, skb)
@@ -3532,8 +3532,8 @@ static const struct bpf_func_proto bpf_skb_change_proto_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_ANYTHING,
-	.arg3_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_SCALAR,
+	.arg3_type	= ARG_SCALAR,
 };
 
 BPF_CALL_2(bpf_skb_change_type, struct sk_buff *, skb, u32, pkt_type)
@@ -3552,7 +3552,7 @@ static const struct bpf_func_proto bpf_skb_change_type_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_SCALAR,
 };
 
 static u32 bpf_skb_net_base_len(const struct sk_buff *skb)
@@ -3839,9 +3839,9 @@ static const struct bpf_func_proto sk_skb_adjust_room_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_ANYTHING,
-	.arg3_type	= ARG_ANYTHING,
-	.arg4_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_SCALAR,
+	.arg3_type	= ARG_SCALAR,
+	.arg4_type	= ARG_SCALAR,
 };
 
 BPF_CALL_4(bpf_skb_adjust_room, struct sk_buff *, skb, s32, len_diff,
@@ -3944,9 +3944,9 @@ static const struct bpf_func_proto bpf_skb_adjust_room_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_ANYTHING,
-	.arg3_type	= ARG_ANYTHING,
-	.arg4_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_SCALAR,
+	.arg3_type	= ARG_SCALAR,
+	.arg4_type	= ARG_SCALAR,
 };
 
 static u32 __bpf_skb_min_len(const struct sk_buff *skb)
@@ -4040,8 +4040,8 @@ static const struct bpf_func_proto bpf_skb_change_tail_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_ANYTHING,
-	.arg3_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_SCALAR,
+	.arg3_type	= ARG_SCALAR,
 };
 
 BPF_CALL_3(sk_skb_change_tail, struct sk_buff *, skb, u32, new_len,
@@ -4055,8 +4055,8 @@ static const struct bpf_func_proto sk_skb_change_tail_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_ANYTHING,
-	.arg3_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_SCALAR,
+	.arg3_type	= ARG_SCALAR,
 };
 
 static inline int __bpf_skb_change_head(struct sk_buff *skb, u32 head_room,
@@ -4107,8 +4107,8 @@ static const struct bpf_func_proto bpf_skb_change_head_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_ANYTHING,
-	.arg3_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_SCALAR,
+	.arg3_type	= ARG_SCALAR,
 };
 
 BPF_CALL_3(sk_skb_change_head, struct sk_buff *, skb, u32, head_room,
@@ -4122,8 +4122,8 @@ static const struct bpf_func_proto sk_skb_change_head_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_ANYTHING,
-	.arg3_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_SCALAR,
+	.arg3_type	= ARG_SCALAR,
 };
 
 BPF_CALL_1(bpf_xdp_get_buff_len, struct xdp_buff*, xdp)
@@ -4178,7 +4178,7 @@ static const struct bpf_func_proto bpf_xdp_adjust_head_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_SCALAR,
 };
 
 void bpf_xdp_copy_buf(struct xdp_buff *xdp, unsigned long off,
@@ -4282,7 +4282,7 @@ static const struct bpf_func_proto bpf_xdp_load_bytes_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_SCALAR,
 	.arg3_type	= ARG_PTR_TO_UNINIT_MEM,
 	.arg4_type	= ARG_MEM_SIZE,
 };
@@ -4314,7 +4314,7 @@ static const struct bpf_func_proto bpf_xdp_store_bytes_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_SCALAR,
 	.arg3_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg4_type	= ARG_MEM_SIZE,
 };
@@ -4453,7 +4453,7 @@ static const struct bpf_func_proto bpf_xdp_adjust_tail_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_SCALAR,
 };
 
 BPF_CALL_2(bpf_xdp_adjust_meta, struct xdp_buff *, xdp, int, offset)
@@ -4480,7 +4480,7 @@ static const struct bpf_func_proto bpf_xdp_adjust_meta_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_SCALAR,
 };
 
 /**
@@ -4825,8 +4825,8 @@ static const struct bpf_func_proto bpf_xdp_redirect_proto = {
 	.func           = bpf_xdp_redirect,
 	.gpl_only       = false,
 	.ret_type       = RET_INTEGER,
-	.arg1_type      = ARG_ANYTHING,
-	.arg2_type      = ARG_ANYTHING,
+	.arg1_type      = ARG_SCALAR,
+	.arg2_type      = ARG_SCALAR,
 };
 
 BPF_CALL_3(bpf_xdp_redirect_map, struct bpf_map *, map, u64, key,
@@ -4840,8 +4840,8 @@ static const struct bpf_func_proto bpf_xdp_redirect_map_proto = {
 	.gpl_only       = false,
 	.ret_type       = RET_INTEGER,
 	.arg1_type      = ARG_CONST_MAP_PTR,
-	.arg2_type      = ARG_ANYTHING,
-	.arg3_type      = ARG_ANYTHING,
+	.arg2_type      = ARG_SCALAR,
+	.arg3_type      = ARG_SCALAR,
 };
 
 static unsigned long bpf_skb_copy(void *dst_buff, const void *skb,
@@ -4877,7 +4877,7 @@ static const struct bpf_func_proto bpf_skb_event_output_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_CONST_MAP_PTR,
-	.arg3_type	= ARG_ANYTHING,
+	.arg3_type	= ARG_SCALAR,
 	.arg4_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg5_type	= ARG_MEM_SIZE_OR_ZERO,
 };
@@ -4891,7 +4891,7 @@ const struct bpf_func_proto bpf_skb_output_proto = {
 	.arg1_type	= ARG_PTR_TO_BTF_ID,
 	.arg1_btf_id	= &bpf_skb_output_btf_ids[0],
 	.arg2_type	= ARG_CONST_MAP_PTR,
-	.arg3_type	= ARG_ANYTHING,
+	.arg3_type	= ARG_SCALAR,
 	.arg4_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg5_type	= ARG_MEM_SIZE_OR_ZERO,
 };
@@ -4977,7 +4977,7 @@ static const struct bpf_func_proto bpf_skb_get_tunnel_key_proto = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_PTR_TO_UNINIT_MEM,
 	.arg3_type	= ARG_MEM_SIZE,
-	.arg4_type	= ARG_ANYTHING,
+	.arg4_type	= ARG_SCALAR,
 };
 
 BPF_CALL_3(bpf_skb_get_tunnel_opt, struct sk_buff *, skb, u8 *, to, u32, size)
@@ -5094,7 +5094,7 @@ static const struct bpf_func_proto bpf_skb_set_tunnel_key_proto = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg3_type	= ARG_MEM_SIZE,
-	.arg4_type	= ARG_ANYTHING,
+	.arg4_type	= ARG_SCALAR,
 };
 
 BPF_CALL_3(bpf_skb_set_tunnel_opt, struct sk_buff *, skb,
@@ -5175,7 +5175,7 @@ static const struct bpf_func_proto bpf_skb_under_cgroup_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_CONST_MAP_PTR,
-	.arg3_type	= ARG_ANYTHING,
+	.arg3_type	= ARG_SCALAR,
 };
 
 #ifdef CONFIG_SOCK_CGROUP_DATA
@@ -5232,7 +5232,7 @@ static const struct bpf_func_proto bpf_skb_ancestor_cgroup_id_proto = {
 	.gpl_only       = false,
 	.ret_type       = RET_INTEGER,
 	.arg1_type      = ARG_PTR_TO_CTX,
-	.arg2_type      = ARG_ANYTHING,
+	.arg2_type      = ARG_SCALAR,
 };
 
 BPF_CALL_1(bpf_sk_cgroup_id, struct sock *, sk)
@@ -5257,7 +5257,7 @@ static const struct bpf_func_proto bpf_sk_ancestor_cgroup_id_proto = {
 	.gpl_only       = false,
 	.ret_type       = RET_INTEGER,
 	.arg1_type      = ARG_PTR_TO_BTF_ID_SOCK_COMMON,
-	.arg2_type      = ARG_ANYTHING,
+	.arg2_type      = ARG_SCALAR,
 };
 #endif
 
@@ -5291,7 +5291,7 @@ static const struct bpf_func_proto bpf_xdp_event_output_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_CONST_MAP_PTR,
-	.arg3_type	= ARG_ANYTHING,
+	.arg3_type	= ARG_SCALAR,
 	.arg4_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg5_type	= ARG_MEM_SIZE_OR_ZERO,
 };
@@ -5305,7 +5305,7 @@ const struct bpf_func_proto bpf_xdp_output_proto = {
 	.arg1_type	= ARG_PTR_TO_BTF_ID,
 	.arg1_btf_id	= &bpf_xdp_output_btf_ids[0],
 	.arg2_type	= ARG_CONST_MAP_PTR,
-	.arg3_type	= ARG_ANYTHING,
+	.arg3_type	= ARG_SCALAR,
 	.arg4_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg5_type	= ARG_MEM_SIZE_OR_ZERO,
 };
@@ -5853,8 +5853,8 @@ const struct bpf_func_proto bpf_sk_setsockopt_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_BTF_ID_SOCK_COMMON,
-	.arg2_type	= ARG_ANYTHING,
-	.arg3_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_SCALAR,
+	.arg3_type	= ARG_SCALAR,
 	.arg4_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg5_type	= ARG_MEM_SIZE,
 };
@@ -5870,8 +5870,8 @@ const struct bpf_func_proto bpf_sk_getsockopt_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_BTF_ID_SOCK_COMMON,
-	.arg2_type	= ARG_ANYTHING,
-	.arg3_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_SCALAR,
+	.arg3_type	= ARG_SCALAR,
 	.arg4_type	= ARG_PTR_TO_UNINIT_MEM,
 	.arg5_type	= ARG_MEM_SIZE,
 };
@@ -5894,8 +5894,8 @@ const struct bpf_func_proto bpf_sk_setsockopt_nodelay_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_BTF_ID_SOCK_COMMON,
-	.arg2_type	= ARG_ANYTHING,
-	.arg3_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_SCALAR,
+	.arg3_type	= ARG_SCALAR,
 	.arg4_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg5_type	= ARG_MEM_SIZE,
 };
@@ -5911,8 +5911,8 @@ const struct bpf_func_proto bpf_unlocked_sk_setsockopt_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_BTF_ID_SOCK_COMMON,
-	.arg2_type	= ARG_ANYTHING,
-	.arg3_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_SCALAR,
+	.arg3_type	= ARG_SCALAR,
 	.arg4_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg5_type	= ARG_MEM_SIZE,
 };
@@ -5928,8 +5928,8 @@ const struct bpf_func_proto bpf_unlocked_sk_getsockopt_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_BTF_ID_SOCK_COMMON,
-	.arg2_type	= ARG_ANYTHING,
-	.arg3_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_SCALAR,
+	.arg3_type	= ARG_SCALAR,
 	.arg4_type	= ARG_PTR_TO_UNINIT_MEM,
 	.arg5_type	= ARG_MEM_SIZE,
 };
@@ -5945,8 +5945,8 @@ static const struct bpf_func_proto bpf_sock_addr_setsockopt_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_ANYTHING,
-	.arg3_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_SCALAR,
+	.arg3_type	= ARG_SCALAR,
 	.arg4_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg5_type	= ARG_MEM_SIZE,
 };
@@ -5962,8 +5962,8 @@ static const struct bpf_func_proto bpf_sock_addr_getsockopt_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_ANYTHING,
-	.arg3_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_SCALAR,
+	.arg3_type	= ARG_SCALAR,
 	.arg4_type	= ARG_PTR_TO_UNINIT_MEM,
 	.arg5_type	= ARG_MEM_SIZE,
 };
@@ -6007,8 +6007,8 @@ static const struct bpf_func_proto bpf_sock_create_setsockopt_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_ANYTHING,
-	.arg3_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_SCALAR,
+	.arg3_type	= ARG_SCALAR,
 	.arg4_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg5_type	= ARG_MEM_SIZE,
 };
@@ -6033,8 +6033,8 @@ static const struct bpf_func_proto bpf_sock_create_getsockopt_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_ANYTHING,
-	.arg3_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_SCALAR,
+	.arg3_type	= ARG_SCALAR,
 	.arg4_type	= ARG_PTR_TO_UNINIT_MEM,
 	.arg5_type	= ARG_MEM_SIZE,
 };
@@ -6059,8 +6059,8 @@ static const struct bpf_func_proto bpf_sock_ops_setsockopt_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_ANYTHING,
-	.arg3_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_SCALAR,
+	.arg3_type	= ARG_SCALAR,
 	.arg4_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg5_type	= ARG_MEM_SIZE,
 };
@@ -6169,8 +6169,8 @@ static const struct bpf_func_proto bpf_sock_ops_getsockopt_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_ANYTHING,
-	.arg3_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_SCALAR,
+	.arg3_type	= ARG_SCALAR,
 	.arg4_type	= ARG_PTR_TO_UNINIT_MEM,
 	.arg5_type	= ARG_MEM_SIZE,
 };
@@ -6197,7 +6197,7 @@ static const struct bpf_func_proto bpf_sock_ops_cb_flags_set_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_SCALAR,
 };
 
 BPF_CALL_3(bpf_bind, struct bpf_sock_addr_kern *, ctx, struct sockaddr *, addr,
@@ -6290,10 +6290,10 @@ static const struct bpf_func_proto bpf_skb_get_xfrm_state_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_SCALAR,
 	.arg3_type	= ARG_PTR_TO_UNINIT_MEM,
 	.arg4_type	= ARG_MEM_SIZE,
-	.arg5_type	= ARG_ANYTHING,
+	.arg5_type	= ARG_SCALAR,
 };
 #endif
 
@@ -6700,7 +6700,7 @@ static const struct bpf_func_proto bpf_xdp_fib_lookup_proto = {
 	.arg1_type      = ARG_PTR_TO_CTX,
 	.arg2_type      = ARG_PTR_TO_MEM | MEM_WRITE,
 	.arg3_type      = ARG_MEM_SIZE,
-	.arg4_type	= ARG_ANYTHING,
+	.arg4_type	= ARG_SCALAR,
 };
 
 BPF_CALL_4(bpf_skb_fib_lookup, struct sk_buff *, skb,
@@ -6760,7 +6760,7 @@ static const struct bpf_func_proto bpf_skb_fib_lookup_proto = {
 	.arg1_type      = ARG_PTR_TO_CTX,
 	.arg2_type      = ARG_PTR_TO_MEM | MEM_WRITE,
 	.arg3_type      = ARG_MEM_SIZE,
-	.arg4_type	= ARG_ANYTHING,
+	.arg4_type	= ARG_SCALAR,
 };
 
 static struct net_device *__dev_via_ifindex(struct net_device *dev_curr,
@@ -6857,11 +6857,11 @@ static const struct bpf_func_proto bpf_skb_check_mtu_proto = {
 	.gpl_only	= true,
 	.ret_type	= RET_INTEGER,
 	.arg1_type      = ARG_PTR_TO_CTX,
-	.arg2_type      = ARG_ANYTHING,
+	.arg2_type      = ARG_SCALAR,
 	.arg3_type      = ARG_PTR_TO_FIXED_SIZE_MEM | MEM_WRITE | MEM_ALIGNED,
 	.arg3_size	= sizeof(u32),
-	.arg4_type      = ARG_ANYTHING,
-	.arg5_type      = ARG_ANYTHING,
+	.arg4_type      = ARG_SCALAR,
+	.arg5_type      = ARG_SCALAR,
 };
 
 static const struct bpf_func_proto bpf_xdp_check_mtu_proto = {
@@ -6869,11 +6869,11 @@ static const struct bpf_func_proto bpf_xdp_check_mtu_proto = {
 	.gpl_only	= true,
 	.ret_type	= RET_INTEGER,
 	.arg1_type      = ARG_PTR_TO_CTX,
-	.arg2_type      = ARG_ANYTHING,
+	.arg2_type      = ARG_SCALAR,
 	.arg3_type      = ARG_PTR_TO_FIXED_SIZE_MEM | MEM_WRITE | MEM_ALIGNED,
 	.arg3_size	= sizeof(u32),
-	.arg4_type      = ARG_ANYTHING,
-	.arg5_type      = ARG_ANYTHING,
+	.arg4_type      = ARG_SCALAR,
+	.arg5_type      = ARG_SCALAR,
 };
 
 #if IS_ENABLED(CONFIG_IPV6_SEG6_BPF)
@@ -6955,7 +6955,7 @@ static const struct bpf_func_proto bpf_lwt_in_push_encap_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_SCALAR,
 	.arg3_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg4_type	= ARG_MEM_SIZE
 };
@@ -6965,7 +6965,7 @@ static const struct bpf_func_proto bpf_lwt_xmit_push_encap_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_SCALAR,
 	.arg3_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg4_type	= ARG_MEM_SIZE
 };
@@ -7009,7 +7009,7 @@ static const struct bpf_func_proto bpf_lwt_seg6_store_bytes_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_SCALAR,
 	.arg3_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg4_type	= ARG_MEM_SIZE
 };
@@ -7098,7 +7098,7 @@ static const struct bpf_func_proto bpf_lwt_seg6_action_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_SCALAR,
 	.arg3_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg4_type	= ARG_MEM_SIZE
 };
@@ -7159,8 +7159,8 @@ static const struct bpf_func_proto bpf_lwt_seg6_adjust_srh_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_ANYTHING,
-	.arg3_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_SCALAR,
+	.arg3_type	= ARG_SCALAR,
 };
 #endif /* CONFIG_IPV6_SEG6_BPF */
 
@@ -7332,8 +7332,8 @@ static const struct bpf_func_proto bpf_skc_lookup_tcp_proto = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg3_type	= ARG_MEM_SIZE_OR_ZERO,
-	.arg4_type	= ARG_ANYTHING,
-	.arg5_type	= ARG_ANYTHING,
+	.arg4_type	= ARG_SCALAR,
+	.arg5_type	= ARG_SCALAR,
 };
 
 BPF_CALL_5(bpf_sk_lookup_tcp, struct sk_buff *, skb,
@@ -7351,8 +7351,8 @@ static const struct bpf_func_proto bpf_sk_lookup_tcp_proto = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg3_type	= ARG_MEM_SIZE_OR_ZERO,
-	.arg4_type	= ARG_ANYTHING,
-	.arg5_type	= ARG_ANYTHING,
+	.arg4_type	= ARG_SCALAR,
+	.arg5_type	= ARG_SCALAR,
 };
 
 BPF_CALL_5(bpf_sk_lookup_udp, struct sk_buff *, skb,
@@ -7370,8 +7370,8 @@ static const struct bpf_func_proto bpf_sk_lookup_udp_proto = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg3_type	= ARG_MEM_SIZE_OR_ZERO,
-	.arg4_type	= ARG_ANYTHING,
-	.arg5_type	= ARG_ANYTHING,
+	.arg4_type	= ARG_SCALAR,
+	.arg5_type	= ARG_SCALAR,
 };
 
 BPF_CALL_5(bpf_tc_skc_lookup_tcp, struct sk_buff *, skb,
@@ -7394,8 +7394,8 @@ static const struct bpf_func_proto bpf_tc_skc_lookup_tcp_proto = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg3_type	= ARG_MEM_SIZE_OR_ZERO,
-	.arg4_type	= ARG_ANYTHING,
-	.arg5_type	= ARG_ANYTHING,
+	.arg4_type	= ARG_SCALAR,
+	.arg5_type	= ARG_SCALAR,
 };
 
 BPF_CALL_5(bpf_tc_sk_lookup_tcp, struct sk_buff *, skb,
@@ -7418,8 +7418,8 @@ static const struct bpf_func_proto bpf_tc_sk_lookup_tcp_proto = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg3_type	= ARG_MEM_SIZE_OR_ZERO,
-	.arg4_type	= ARG_ANYTHING,
-	.arg5_type	= ARG_ANYTHING,
+	.arg4_type	= ARG_SCALAR,
+	.arg5_type	= ARG_SCALAR,
 };
 
 BPF_CALL_5(bpf_tc_sk_lookup_udp, struct sk_buff *, skb,
@@ -7442,8 +7442,8 @@ static const struct bpf_func_proto bpf_tc_sk_lookup_udp_proto = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg3_type	= ARG_MEM_SIZE_OR_ZERO,
-	.arg4_type	= ARG_ANYTHING,
-	.arg5_type	= ARG_ANYTHING,
+	.arg4_type	= ARG_SCALAR,
+	.arg5_type	= ARG_SCALAR,
 };
 
 BPF_CALL_1(bpf_sk_release, struct sock *, sk)
@@ -7480,8 +7480,8 @@ static const struct bpf_func_proto bpf_xdp_sk_lookup_udp_proto = {
 	.arg1_type      = ARG_PTR_TO_CTX,
 	.arg2_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg3_type      = ARG_MEM_SIZE_OR_ZERO,
-	.arg4_type      = ARG_ANYTHING,
-	.arg5_type      = ARG_ANYTHING,
+	.arg4_type      = ARG_SCALAR,
+	.arg5_type      = ARG_SCALAR,
 };
 
 BPF_CALL_5(bpf_xdp_skc_lookup_tcp, struct xdp_buff *, ctx,
@@ -7504,8 +7504,8 @@ static const struct bpf_func_proto bpf_xdp_skc_lookup_tcp_proto = {
 	.arg1_type      = ARG_PTR_TO_CTX,
 	.arg2_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg3_type      = ARG_MEM_SIZE_OR_ZERO,
-	.arg4_type      = ARG_ANYTHING,
-	.arg5_type      = ARG_ANYTHING,
+	.arg4_type      = ARG_SCALAR,
+	.arg5_type      = ARG_SCALAR,
 };
 
 BPF_CALL_5(bpf_xdp_sk_lookup_tcp, struct xdp_buff *, ctx,
@@ -7528,8 +7528,8 @@ static const struct bpf_func_proto bpf_xdp_sk_lookup_tcp_proto = {
 	.arg1_type      = ARG_PTR_TO_CTX,
 	.arg2_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg3_type      = ARG_MEM_SIZE_OR_ZERO,
-	.arg4_type      = ARG_ANYTHING,
-	.arg5_type      = ARG_ANYTHING,
+	.arg4_type      = ARG_SCALAR,
+	.arg5_type      = ARG_SCALAR,
 };
 
 BPF_CALL_5(bpf_sock_addr_skc_lookup_tcp, struct bpf_sock_addr_kern *, ctx,
@@ -7548,8 +7548,8 @@ static const struct bpf_func_proto bpf_sock_addr_skc_lookup_tcp_proto = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg3_type	= ARG_MEM_SIZE_OR_ZERO,
-	.arg4_type	= ARG_ANYTHING,
-	.arg5_type	= ARG_ANYTHING,
+	.arg4_type	= ARG_SCALAR,
+	.arg5_type	= ARG_SCALAR,
 };
 
 BPF_CALL_5(bpf_sock_addr_sk_lookup_tcp, struct bpf_sock_addr_kern *, ctx,
@@ -7567,8 +7567,8 @@ static const struct bpf_func_proto bpf_sock_addr_sk_lookup_tcp_proto = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg3_type	= ARG_MEM_SIZE_OR_ZERO,
-	.arg4_type	= ARG_ANYTHING,
-	.arg5_type	= ARG_ANYTHING,
+	.arg4_type	= ARG_SCALAR,
+	.arg5_type	= ARG_SCALAR,
 };
 
 BPF_CALL_5(bpf_sock_addr_sk_lookup_udp, struct bpf_sock_addr_kern *, ctx,
@@ -7586,8 +7586,8 @@ static const struct bpf_func_proto bpf_sock_addr_sk_lookup_udp_proto = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg3_type	= ARG_MEM_SIZE_OR_ZERO,
-	.arg4_type	= ARG_ANYTHING,
-	.arg5_type	= ARG_ANYTHING,
+	.arg4_type	= ARG_SCALAR,
+	.arg5_type	= ARG_SCALAR,
 };
 
 bool bpf_tcp_sock_is_valid_access(int off, int size, enum bpf_access_type type,
@@ -8006,7 +8006,7 @@ static const struct bpf_func_proto bpf_sk_assign_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type      = ARG_PTR_TO_CTX,
 	.arg2_type      = ARG_PTR_TO_BTF_ID_SOCK_COMMON,
-	.arg3_type	= ARG_ANYTHING,
+	.arg3_type	= ARG_SCALAR,
 };
 
 static const u8 *bpf_search_tcp_opt(const u8 *op, const u8 *opend,
@@ -8131,7 +8131,7 @@ static const struct bpf_func_proto bpf_sock_ops_load_hdr_opt_proto = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_PTR_TO_MEM | MEM_WRITE,
 	.arg3_type	= ARG_MEM_SIZE,
-	.arg4_type	= ARG_ANYTHING,
+	.arg4_type	= ARG_SCALAR,
 };
 
 BPF_CALL_4(bpf_sock_ops_store_hdr_opt, struct bpf_sock_ops_kern *, bpf_sock,
@@ -8209,7 +8209,7 @@ static const struct bpf_func_proto bpf_sock_ops_store_hdr_opt_proto = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg3_type	= ARG_MEM_SIZE,
-	.arg4_type	= ARG_ANYTHING,
+	.arg4_type	= ARG_SCALAR,
 };
 
 BPF_CALL_3(bpf_sock_ops_reserve_hdr_opt, struct bpf_sock_ops_kern *, bpf_sock,
@@ -8234,8 +8234,8 @@ static const struct bpf_func_proto bpf_sock_ops_reserve_hdr_opt_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_ANYTHING,
-	.arg3_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_SCALAR,
+	.arg3_type	= ARG_SCALAR,
 };
 
 BPF_CALL_3(bpf_skb_set_tstamp, struct sk_buff *, skb,
@@ -8275,8 +8275,8 @@ static const struct bpf_func_proto bpf_skb_set_tstamp_proto = {
 	.gpl_only       = false,
 	.ret_type       = RET_INTEGER,
 	.arg1_type      = ARG_PTR_TO_CTX,
-	.arg2_type      = ARG_ANYTHING,
-	.arg3_type      = ARG_ANYTHING,
+	.arg2_type      = ARG_SCALAR,
+	.arg3_type      = ARG_SCALAR,
 };
 
 #ifdef CONFIG_SYN_COOKIES
@@ -11787,7 +11787,7 @@ static const struct bpf_func_proto sk_select_reuseport_proto = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type      = ARG_CONST_MAP_PTR,
 	.arg3_type      = ARG_PTR_TO_MAP_KEY,
-	.arg4_type	= ARG_ANYTHING,
+	.arg4_type	= ARG_SCALAR,
 };
 
 BPF_CALL_4(sk_reuseport_load_bytes,
@@ -11802,7 +11802,7 @@ static const struct bpf_func_proto sk_reuseport_load_bytes_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_SCALAR,
 	.arg3_type	= ARG_PTR_TO_UNINIT_MEM,
 	.arg4_type	= ARG_MEM_SIZE,
 };
@@ -11820,10 +11820,10 @@ static const struct bpf_func_proto sk_reuseport_load_bytes_relative_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_SCALAR,
 	.arg3_type	= ARG_PTR_TO_UNINIT_MEM,
 	.arg4_type	= ARG_MEM_SIZE,
-	.arg5_type	= ARG_ANYTHING,
+	.arg5_type	= ARG_SCALAR,
 };
 
 static const struct bpf_func_proto *
@@ -12010,7 +12010,7 @@ static const struct bpf_func_proto bpf_sk_lookup_assign_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_PTR_TO_SOCKET_OR_NULL,
-	.arg3_type	= ARG_ANYTHING,
+	.arg3_type	= ARG_SCALAR,
 };
 
 static const struct bpf_func_proto *
diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index ca49bc7f8687..03d95aac8b60 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -641,7 +641,7 @@ const struct bpf_func_proto bpf_sock_map_update_proto = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_CONST_MAP_PTR,
 	.arg3_type	= ARG_PTR_TO_MAP_KEY,
-	.arg4_type	= ARG_ANYTHING,
+	.arg4_type	= ARG_SCALAR,
 };
 
 BPF_CALL_4(bpf_sk_redirect_map, struct sk_buff *, skb,
@@ -668,8 +668,8 @@ const struct bpf_func_proto bpf_sk_redirect_map_proto = {
 	.ret_type       = RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type      = ARG_CONST_MAP_PTR,
-	.arg3_type      = ARG_ANYTHING,
-	.arg4_type      = ARG_ANYTHING,
+	.arg3_type      = ARG_SCALAR,
+	.arg4_type      = ARG_SCALAR,
 };
 
 BPF_CALL_4(bpf_msg_redirect_map, struct sk_msg *, msg,
@@ -699,8 +699,8 @@ const struct bpf_func_proto bpf_msg_redirect_map_proto = {
 	.ret_type       = RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type      = ARG_CONST_MAP_PTR,
-	.arg3_type      = ARG_ANYTHING,
-	.arg4_type      = ARG_ANYTHING,
+	.arg3_type      = ARG_SCALAR,
+	.arg4_type      = ARG_SCALAR,
 };
 
 struct sock_map_seq_info {
@@ -1247,7 +1247,7 @@ const struct bpf_func_proto bpf_sock_hash_update_proto = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_CONST_MAP_PTR,
 	.arg3_type	= ARG_PTR_TO_MAP_KEY,
-	.arg4_type	= ARG_ANYTHING,
+	.arg4_type	= ARG_SCALAR,
 };
 
 BPF_CALL_4(bpf_sk_redirect_hash, struct sk_buff *, skb,
@@ -1275,7 +1275,7 @@ const struct bpf_func_proto bpf_sk_redirect_hash_proto = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type      = ARG_CONST_MAP_PTR,
 	.arg3_type      = ARG_PTR_TO_MAP_KEY,
-	.arg4_type      = ARG_ANYTHING,
+	.arg4_type      = ARG_SCALAR,
 };
 
 BPF_CALL_4(bpf_msg_redirect_hash, struct sk_msg *, msg,
@@ -1306,7 +1306,7 @@ const struct bpf_func_proto bpf_msg_redirect_hash_proto = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type      = ARG_CONST_MAP_PTR,
 	.arg3_type      = ARG_PTR_TO_MAP_KEY,
-	.arg4_type      = ARG_ANYTHING,
+	.arg4_type      = ARG_SCALAR,
 };
 
 struct sock_hash_seq_info {
diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
index 791e15063237..3684c0434da1 100644
--- a/net/ipv4/bpf_tcp_ca.c
+++ b/net/ipv4/bpf_tcp_ca.c
@@ -132,7 +132,7 @@ static const struct bpf_func_proto bpf_tcp_send_ack_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_BTF_ID,
 	.arg1_btf_id	= &tcp_sock_id,
-	.arg2_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_SCALAR,
 };
 
 static u32 prog_ops_moff(const struct bpf_prog *prog)
-- 
2.52.0

