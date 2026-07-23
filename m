Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24BA2749DF
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 05:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784783304; cv=none; b=sBZbhayR4eWXXvFLX0oERhhwo8MrtBOkUvwHx2Nye+Fz/1LqT0BtMqO5hr85TZq3WocmHV/hNc+7d5YLMVeafprAo7Ui0tq0HM3vXdhYVqI6B48zyhdS+ihoGKCS7mEpXogu7mXTSLx5n52GSgz5vBLdC7GWsdCkEArV0C5Uh/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784783304; c=relaxed/simple;
	bh=XzGLGktderj2VOvzAzpVB+CPdgPfoIPN4Urh83bVdgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=totsoAEdpoxCtOwlr5KlaXys/UWCByE9PMUOscZOVCIXW2G1rVCbITEnyWfIYwbAogxmC4OH2E33VBWrT4NG8zs1xfANhJXruk1tNER8M17QlKfnIKR+9am5sgTYd3to0ZAp5JUZ8zwu9d3vyvPMltJbuonE6hFgEeUKOxSIWVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kaU3RK0R; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kaU3RK0R"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38e08baf860so244156a91.2
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 22:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784783301; x=1785388101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RB3eBgz4Z595cFuCIFsvlpE/z2QiN6FjsOl4PImFhw4=;
        b=kaU3RK0RkS8zaqyKwS0g0Vi2XRtqnu2OLhLYQfzCTkqS68GgpASNdf62IZfXwVn3Vo
         3ypamLO9+EPEJT/tAdzyprxa3RYMAGaoqrwlRnC3SAg9E1RDXKkgZ+QN95gVF9+pg26E
         gq044xUjU/eBTfaHOHF2Lj4Gk+v+qPf3Aq3CKOyTjAjl6xuba9e01Mzxl4m7dufT/zr8
         rRHU97Iw/4uIdQL6watV1xN+a1RAATEge/Q3hPzIs2ev0yJxA8OsDA5bKlrbUwsxY5wV
         zeRBd2gr/R5/ZoateZHPNrnZQfOEMLcShRC7BoydbZcge6dYATNNESO5ji4upa4EWB7m
         i2xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784783301; x=1785388101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RB3eBgz4Z595cFuCIFsvlpE/z2QiN6FjsOl4PImFhw4=;
        b=M5Humn/OjBsA2Oh4EpEFU7e/99fNN9rI5D/w1SY5fURG+vveVs3W3/wg6Xxa2BR03W
         na0l5UrmM52DQ8dF2doFNF41ySXhwoIjs0zb8Hlr4omAfj0zc7GzH8FJJTaKYcDYD9sK
         4kfrU5U8/J/B6l0S2ilVjvEjRkB2QJfaMCJhArGD83zDyDk6D5ZL5bclBFFxWbZ7QgKr
         Tz5eIygZMC+A2HKu/AQycWOiwzVeoMBO3jzCvghbPQGixEqaSvzqu2PRTZaAowlYWh+m
         aYWtLUEuW44RmU74cIPqOaZYWb02Th0u76fdTpcnuggnUnZaz6B4C92OC1RQ8Am8sOBQ
         TC0w==
X-Gm-Message-State: AOJu0YzzO+74bPyk5mUvXsQl7a9lHWBsa9IXaWUbr4yqj+fWCGKCOSIW
	iRVmY1mdflwwD/fokvrlfL1Kmv4GsJ3LHzoI2ehioeDtZQNqBfbWR7PiBGj+SA==
X-Gm-Gg: AR+sD13OKkVu2fKnk/xYmxPxuvot26zNY7804SwSCFB9R5JidwzizMZ/Qu+JS+k7+h1
	f9WWN1klrgEQaFfhfyZom+cildFWWJ84KLf6PeEspdtOVA3M5wq3lft52GU4E2LSWzhfF8wB27o
	8NlC5viYRUAd8esLBT6DFCCk+Mtzd+oS6wpZVNOO1nz9D4lyErH8xeCMH0EBCf+fI1MiVaFtWgj
	iVWr0dWUAZZ6NU4Fys2fCWI5TJ3f+mAvcrPEYfXfY4+kMB5rnSnybEN0fwQZssDtVrGag9h6/g2
	ZxoHMRjJrCJwBYuOSBD4WJNARGwKEhRD2aUI9RsOnx2UxHGFIMt6RsFGl/HS5I4StfUCD3iDD4E
	MyPa+wvWKz8MGISN5eIyG9JnxHdVj0KRG2DUrCqR+cNOROqCabcIbNQg94XWwXrTIrQs=
X-Received: by 2002:a17:90b:1d48:b0:387:e0db:3d8e with SMTP id 98e67ed59e1d1-38ec665050cmr1787797a91.41.1784783300587;
        Wed, 22 Jul 2026 22:08:20 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38ecaaf772fsm302760a91.14.2026.07.22.22.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 22:08:19 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 09/18] bpf: Rename ARG_CONST_SIZE{,_OR_ZERO} to ARG_MEM_SIZE{,_OR_ZERO}
Date: Wed, 22 Jul 2026 22:07:57 -0700
Message-ID: <20260723050806.1158442-10-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260723050806.1158442-1-ameryhung@gmail.com>
References: <20260723050806.1158442-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ARG_CONST_SIZE does not require a constant: check_mem_size_reg() accepts
any bounded scalar and verifies the memory access against its maximum
(reg_umax). Rename ARG_CONST_SIZE and ARG_CONST_SIZE_OR_ZERO to
ARG_MEM_SIZE and ARG_MEM_SIZE_OR_ZERO to reflect that. ARG_CONST_ALLOC_
SIZE_OR_ZERO, which does require a constant, is left unchanged.

Pure rename, no functional change.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf.h                           |   4 +-
 include/linux/bpf_verifier.h                  |   2 +-
 kernel/bpf/backtrack.c                        |   2 +-
 kernel/bpf/bpf_lsm.c                          |   4 +-
 kernel/bpf/btf.c                              |   2 +-
 kernel/bpf/cgroup.c                           |   8 +-
 kernel/bpf/helpers.c                          |  26 ++--
 kernel/bpf/ringbuf.c                          |   2 +-
 kernel/bpf/stackmap.c                         |  10 +-
 kernel/bpf/syscall.c                          |   4 +-
 kernel/bpf/verifier.c                         |   6 +-
 kernel/trace/bpf_trace.c                      |  62 +++++-----
 net/core/filter.c                             | 116 +++++++++---------
 .../bpf/progs/mem_rdonly_untrusted.c          |   2 +-
 .../selftests/bpf/progs/verifier_bounds.c     |   2 +-
 .../progs/verifier_helper_access_var_len.c    |   6 +-
 .../bpf/progs/verifier_helper_value_access.c  |   2 +-
 17 files changed, 130 insertions(+), 130 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a7b3bb56c70b..4fd360228321 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -889,7 +889,7 @@ enum bpf_arg_type {
 	ARG_PTR_TO_MEM,		/* pointer to valid memory (stack, packet, map value) */
 	ARG_PTR_TO_ARENA,
 
-	ARG_CONST_SIZE,		/* number of bytes accessed from memory */
+	ARG_MEM_SIZE,		/* number of bytes accessed from memory */
 
 	ARG_PTR_TO_CTX,		/* pointer to context */
 	ARG_ANYTHING,		/* any (initialized) argument is ok */
@@ -923,7 +923,7 @@ enum bpf_arg_type {
 	/* Pointer to valid memory of size known at compile time. */
 	ARG_PTR_TO_FIXED_SIZE_MEM	= MEM_FIXED_SIZE | ARG_PTR_TO_MEM,
 	/* Number of bytes accessed from memory, or 0. */
-	ARG_CONST_SIZE_OR_ZERO		= SCALAR_MAYBE_ZERO | ARG_CONST_SIZE,
+	ARG_MEM_SIZE_OR_ZERO		= SCALAR_MAYBE_ZERO | ARG_MEM_SIZE,
 
 	/* This must be the last entry. Its purpose is to ensure the enum is
 	 * wide enough to hold the higher bits reserved for bpf_type_flag.
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 682c2cd3b844..bb0d43814e90 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -15,7 +15,7 @@
  * ensures that umax_value + (int)off + (int)size cannot overflow a u64.
  */
 #define BPF_MAX_VAR_OFF	(1 << 29)
-/* Maximum variable size permitted for ARG_CONST_SIZE[_OR_ZERO].  This ensures
+/* Maximum variable size permitted for ARG_MEM_SIZE[_OR_ZERO].  This ensures
  * that converting umax_value to int cannot overflow.
  */
 #define BPF_MAX_VAR_SIZ	(1 << 29)
diff --git a/kernel/bpf/backtrack.c b/kernel/bpf/backtrack.c
index 2e4ae0ef0860..2f473ad4fd7c 100644
--- a/kernel/bpf/backtrack.c
+++ b/kernel/bpf/backtrack.c
@@ -636,7 +636,7 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
  * r5 += 1
  * ...
  * call bpf_perf_event_output#25
- *   where .arg5_type = ARG_CONST_SIZE_OR_ZERO
+ *   where .arg5_type = ARG_MEM_SIZE_OR_ZERO
  *
  * and this case:
  * r6 = 1
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 3983b4ce73c8..82c5988417a0 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -186,7 +186,7 @@ static const struct bpf_func_proto bpf_ima_inode_hash_proto = {
 	.arg1_type	= ARG_PTR_TO_BTF_ID,
 	.arg1_btf_id	= &bpf_ima_inode_hash_btf_ids[0],
 	.arg2_type	= ARG_PTR_TO_UNINIT_MEM,
-	.arg3_type	= ARG_CONST_SIZE,
+	.arg3_type	= ARG_MEM_SIZE,
 	.allowed	= bpf_ima_inode_hash_allowed,
 };
 
@@ -205,7 +205,7 @@ static const struct bpf_func_proto bpf_ima_file_hash_proto = {
 	.arg1_type	= ARG_PTR_TO_BTF_ID,
 	.arg1_btf_id	= &bpf_ima_file_hash_btf_ids[0],
 	.arg2_type	= ARG_PTR_TO_UNINIT_MEM,
-	.arg3_type	= ARG_CONST_SIZE,
+	.arg3_type	= ARG_MEM_SIZE,
 	.allowed	= bpf_ima_inode_hash_allowed,
 };
 
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index cbb1e49b9bcb..a23a42cbe3b1 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8707,7 +8707,7 @@ const struct bpf_func_proto bpf_btf_find_by_name_kind_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
-	.arg2_type	= ARG_CONST_SIZE,
+	.arg2_type	= ARG_MEM_SIZE,
 	.arg3_type	= ARG_ANYTHING,
 	.arg4_type	= ARG_ANYTHING,
 };
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 4355ccb78a9c..fb9357b64cad 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -2305,7 +2305,7 @@ static const struct bpf_func_proto bpf_sysctl_get_name_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_PTR_TO_MEM | MEM_WRITE,
-	.arg3_type	= ARG_CONST_SIZE,
+	.arg3_type	= ARG_MEM_SIZE,
 	.arg4_type	= ARG_ANYTHING,
 };
 
@@ -2347,7 +2347,7 @@ static const struct bpf_func_proto bpf_sysctl_get_current_value_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_PTR_TO_UNINIT_MEM,
-	.arg3_type	= ARG_CONST_SIZE,
+	.arg3_type	= ARG_MEM_SIZE,
 };
 
 BPF_CALL_3(bpf_sysctl_get_new_value, struct bpf_sysctl_kern *, ctx, char *, buf,
@@ -2367,7 +2367,7 @@ static const struct bpf_func_proto bpf_sysctl_get_new_value_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_PTR_TO_UNINIT_MEM,
-	.arg3_type	= ARG_CONST_SIZE,
+	.arg3_type	= ARG_MEM_SIZE,
 };
 
 BPF_CALL_3(bpf_sysctl_set_new_value, struct bpf_sysctl_kern *, ctx,
@@ -2393,7 +2393,7 @@ static const struct bpf_func_proto bpf_sysctl_set_new_value_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
-	.arg3_type	= ARG_CONST_SIZE,
+	.arg3_type	= ARG_MEM_SIZE,
 };
 
 static const struct bpf_func_proto *
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 93d0d9aa3e15..18be5d6e4f9c 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -278,7 +278,7 @@ const struct bpf_func_proto bpf_get_current_comm_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_UNINIT_MEM,
-	.arg2_type	= ARG_CONST_SIZE,
+	.arg2_type	= ARG_MEM_SIZE,
 };
 
 #if defined(CONFIG_QUEUED_SPINLOCKS) || defined(CONFIG_BPF_ARCH_SPINLOCK)
@@ -539,7 +539,7 @@ const struct bpf_func_proto bpf_strtol_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
-	.arg2_type	= ARG_CONST_SIZE,
+	.arg2_type	= ARG_MEM_SIZE,
 	.arg3_type	= ARG_ANYTHING,
 	.arg4_type	= ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_WRITE | MEM_ALIGNED,
 	.arg4_size	= sizeof(s64),
@@ -567,7 +567,7 @@ const struct bpf_func_proto bpf_strtoul_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
-	.arg2_type	= ARG_CONST_SIZE,
+	.arg2_type	= ARG_MEM_SIZE,
 	.arg3_type	= ARG_ANYTHING,
 	.arg4_type	= ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_WRITE | MEM_ALIGNED,
 	.arg4_size	= sizeof(u64),
@@ -583,7 +583,7 @@ static const struct bpf_func_proto bpf_strncmp_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
-	.arg2_type	= ARG_CONST_SIZE,
+	.arg2_type	= ARG_MEM_SIZE,
 	.arg3_type	= ARG_PTR_TO_CONST_STR,
 };
 
@@ -627,7 +627,7 @@ const struct bpf_func_proto bpf_get_ns_current_pid_tgid_proto = {
 	.arg1_type	= ARG_ANYTHING,
 	.arg2_type	= ARG_ANYTHING,
 	.arg3_type      = ARG_PTR_TO_UNINIT_MEM,
-	.arg4_type      = ARG_CONST_SIZE,
+	.arg4_type      = ARG_MEM_SIZE,
 };
 
 static const struct bpf_func_proto bpf_get_raw_smp_processor_id_proto = {
@@ -653,7 +653,7 @@ const struct bpf_func_proto bpf_event_output_data_proto =  {
 	.arg2_type      = ARG_CONST_MAP_PTR,
 	.arg3_type      = ARG_ANYTHING,
 	.arg4_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
-	.arg5_type      = ARG_CONST_SIZE_OR_ZERO,
+	.arg5_type      = ARG_MEM_SIZE_OR_ZERO,
 };
 
 BPF_CALL_3(bpf_copy_from_user, void *, dst, u32, size,
@@ -675,7 +675,7 @@ const struct bpf_func_proto bpf_copy_from_user_proto = {
 	.might_sleep	= true,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_UNINIT_MEM,
-	.arg2_type	= ARG_CONST_SIZE_OR_ZERO,
+	.arg2_type	= ARG_MEM_SIZE_OR_ZERO,
 	.arg3_type	= ARG_ANYTHING,
 };
 
@@ -706,7 +706,7 @@ const struct bpf_func_proto bpf_copy_from_user_task_proto = {
 	.might_sleep	= true,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_UNINIT_MEM,
-	.arg2_type	= ARG_CONST_SIZE_OR_ZERO,
+	.arg2_type	= ARG_MEM_SIZE_OR_ZERO,
 	.arg3_type	= ARG_ANYTHING,
 	.arg4_type	= ARG_PTR_TO_BTF_ID,
 	.arg4_btf_id	= &btf_tracing_ids[BTF_TRACING_TYPE_TASK],
@@ -1093,10 +1093,10 @@ const struct bpf_func_proto bpf_snprintf_proto = {
 	.gpl_only	= true,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_MEM_OR_NULL | MEM_WRITE,
-	.arg2_type	= ARG_CONST_SIZE_OR_ZERO,
+	.arg2_type	= ARG_MEM_SIZE_OR_ZERO,
 	.arg3_type	= ARG_PTR_TO_CONST_STR,
 	.arg4_type	= ARG_PTR_TO_MEM | PTR_MAYBE_NULL | MEM_RDONLY,
-	.arg5_type	= ARG_CONST_SIZE_OR_ZERO,
+	.arg5_type	= ARG_MEM_SIZE_OR_ZERO,
 };
 
 static void *map_key_from_value(struct bpf_map *map, void *value, u32 *arr_idx)
@@ -1888,7 +1888,7 @@ static const struct bpf_func_proto bpf_dynptr_from_mem_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_UNINIT_MEM,
-	.arg2_type	= ARG_CONST_SIZE_OR_ZERO,
+	.arg2_type	= ARG_MEM_SIZE_OR_ZERO,
 	.arg3_type	= ARG_ANYTHING,
 	.arg4_type	= ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_LOCAL | MEM_UNINIT | MEM_WRITE,
 };
@@ -1943,7 +1943,7 @@ static const struct bpf_func_proto bpf_dynptr_read_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_UNINIT_MEM,
-	.arg2_type	= ARG_CONST_SIZE_OR_ZERO,
+	.arg2_type	= ARG_MEM_SIZE_OR_ZERO,
 	.arg3_type	= ARG_PTR_TO_DYNPTR,
 	.arg4_type	= ARG_ANYTHING,
 	.arg5_type	= ARG_ANYTHING,
@@ -2004,7 +2004,7 @@ static const struct bpf_func_proto bpf_dynptr_write_proto = {
 	.arg1_type	= ARG_PTR_TO_DYNPTR,
 	.arg2_type	= ARG_ANYTHING,
 	.arg3_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
-	.arg4_type	= ARG_CONST_SIZE_OR_ZERO,
+	.arg4_type	= ARG_MEM_SIZE_OR_ZERO,
 	.arg5_type	= ARG_ANYTHING,
 };
 
diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index 35ae64ade36b..c1bf7a197a96 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -634,7 +634,7 @@ const struct bpf_func_proto bpf_ringbuf_output_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_CONST_MAP_PTR,
 	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
-	.arg3_type	= ARG_CONST_SIZE_OR_ZERO,
+	.arg3_type	= ARG_MEM_SIZE_OR_ZERO,
 	.arg4_type	= ARG_ANYTHING,
 };
 
diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 41fe87d7302f..463f94ba1cc4 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -781,7 +781,7 @@ const struct bpf_func_proto bpf_get_stack_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_PTR_TO_UNINIT_MEM,
-	.arg3_type	= ARG_CONST_SIZE_OR_ZERO,
+	.arg3_type	= ARG_MEM_SIZE_OR_ZERO,
 	.arg4_type	= ARG_ANYTHING,
 };
 
@@ -797,7 +797,7 @@ const struct bpf_func_proto bpf_get_stack_sleepable_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_PTR_TO_UNINIT_MEM,
-	.arg3_type	= ARG_CONST_SIZE_OR_ZERO,
+	.arg3_type	= ARG_MEM_SIZE_OR_ZERO,
 	.arg4_type	= ARG_ANYTHING,
 };
 
@@ -831,7 +831,7 @@ const struct bpf_func_proto bpf_get_task_stack_proto = {
 	.arg1_type	= ARG_PTR_TO_BTF_ID,
 	.arg1_btf_id	= &btf_tracing_ids[BTF_TRACING_TYPE_TASK],
 	.arg2_type	= ARG_PTR_TO_UNINIT_MEM,
-	.arg3_type	= ARG_CONST_SIZE_OR_ZERO,
+	.arg3_type	= ARG_MEM_SIZE_OR_ZERO,
 	.arg4_type	= ARG_ANYTHING,
 };
 
@@ -848,7 +848,7 @@ const struct bpf_func_proto bpf_get_task_stack_sleepable_proto = {
 	.arg1_type	= ARG_PTR_TO_BTF_ID,
 	.arg1_btf_id	= &btf_tracing_ids[BTF_TRACING_TYPE_TASK],
 	.arg2_type	= ARG_PTR_TO_UNINIT_MEM,
-	.arg3_type	= ARG_CONST_SIZE_OR_ZERO,
+	.arg3_type	= ARG_MEM_SIZE_OR_ZERO,
 	.arg4_type	= ARG_ANYTHING,
 };
 
@@ -911,7 +911,7 @@ const struct bpf_func_proto bpf_get_stack_proto_pe = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_PTR_TO_UNINIT_MEM,
-	.arg3_type	= ARG_CONST_SIZE_OR_ZERO,
+	.arg3_type	= ARG_MEM_SIZE_OR_ZERO,
 	.arg4_type	= ARG_ANYTHING,
 };
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 0ff9e3aa293d..67704ddd29cb 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -6544,7 +6544,7 @@ static const struct bpf_func_proto bpf_sys_bpf_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_ANYTHING,
 	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
-	.arg3_type	= ARG_CONST_SIZE,
+	.arg3_type	= ARG_MEM_SIZE,
 };
 
 const struct bpf_func_proto * __weak
@@ -6591,7 +6591,7 @@ static const struct bpf_func_proto bpf_kallsyms_lookup_name_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
-	.arg2_type	= ARG_CONST_SIZE_OR_ZERO,
+	.arg2_type	= ARG_MEM_SIZE_OR_ZERO,
 	.arg3_type	= ARG_ANYTHING,
 	.arg4_type	= ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_WRITE | MEM_ALIGNED,
 	.arg4_size	= sizeof(u64),
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5e09b95458ba..7698ead36778 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7724,7 +7724,7 @@ static int process_iter_next_call(struct bpf_verifier_env *env, int insn_idx,
 
 static bool arg_type_is_mem_size(enum bpf_arg_type type)
 {
-	return base_type(type) == ARG_CONST_SIZE;
+	return base_type(type) == ARG_MEM_SIZE;
 }
 
 static bool arg_type_is_raw_mem(enum bpf_arg_type type)
@@ -7870,7 +7870,7 @@ static const struct bpf_reg_types dynptr_types = {
 static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
 	[ARG_PTR_TO_MAP_KEY]		= &mem_types,
 	[ARG_PTR_TO_MAP_VALUE]		= &mem_types,
-	[ARG_CONST_SIZE]		= &scalar_types,
+	[ARG_MEM_SIZE]			= &scalar_types,
 	[ARG_CONST_ALLOC_SIZE_OR_ZERO]	= &scalar_types,
 	[ARG_CONST_MAP_PTR]		= &const_map_ptr_types,
 	[ARG_PTR_TO_CTX]		= &context_types,
@@ -8494,7 +8494,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 				err = check_ptr_alignment(env, reg, 0, fn->arg_size[arg], true);
 		}
 		break;
-	case ARG_CONST_SIZE:
+	case ARG_MEM_SIZE:
 		err = check_mem_size_reg(env, reg_state(env, regno - 1), reg,
 					 argno_from_reg(regno - 1), argno,
 					 fn->arg_type[arg - 1] & MEM_WRITE ? BPF_WRITE : BPF_READ,
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 76ab51deaa6b..891897f8a1b3 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -221,7 +221,7 @@ const struct bpf_func_proto bpf_probe_read_user_proto = {
 	.gpl_only	= true,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_UNINIT_MEM,
-	.arg2_type	= ARG_CONST_SIZE_OR_ZERO,
+	.arg2_type	= ARG_MEM_SIZE_OR_ZERO,
 	.arg3_type	= ARG_ANYTHING,
 };
 
@@ -258,7 +258,7 @@ const struct bpf_func_proto bpf_probe_read_user_str_proto = {
 	.gpl_only	= true,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_UNINIT_MEM,
-	.arg2_type	= ARG_CONST_SIZE_OR_ZERO,
+	.arg2_type	= ARG_MEM_SIZE_OR_ZERO,
 	.arg3_type	= ARG_ANYTHING,
 };
 
@@ -273,7 +273,7 @@ const struct bpf_func_proto bpf_probe_read_kernel_proto = {
 	.gpl_only	= true,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_UNINIT_MEM,
-	.arg2_type	= ARG_CONST_SIZE_OR_ZERO,
+	.arg2_type	= ARG_MEM_SIZE_OR_ZERO,
 	.arg3_type	= ARG_ANYTHING,
 };
 
@@ -308,7 +308,7 @@ const struct bpf_func_proto bpf_probe_read_kernel_str_proto = {
 	.gpl_only	= true,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_UNINIT_MEM,
-	.arg2_type	= ARG_CONST_SIZE_OR_ZERO,
+	.arg2_type	= ARG_MEM_SIZE_OR_ZERO,
 	.arg3_type	= ARG_ANYTHING,
 };
 
@@ -328,7 +328,7 @@ static const struct bpf_func_proto bpf_probe_read_compat_proto = {
 	.gpl_only	= true,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_UNINIT_MEM,
-	.arg2_type	= ARG_CONST_SIZE_OR_ZERO,
+	.arg2_type	= ARG_MEM_SIZE_OR_ZERO,
 	.arg3_type	= ARG_ANYTHING,
 };
 
@@ -347,7 +347,7 @@ static const struct bpf_func_proto bpf_probe_read_compat_str_proto = {
 	.gpl_only	= true,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_UNINIT_MEM,
-	.arg2_type	= ARG_CONST_SIZE_OR_ZERO,
+	.arg2_type	= ARG_MEM_SIZE_OR_ZERO,
 	.arg3_type	= ARG_ANYTHING,
 };
 #endif /* CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE */
@@ -383,7 +383,7 @@ static const struct bpf_func_proto bpf_probe_write_user_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_ANYTHING,
 	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
-	.arg3_type	= ARG_CONST_SIZE,
+	.arg3_type	= ARG_MEM_SIZE,
 };
 
 #define MAX_TRACE_PRINTK_VARARGS	3
@@ -418,7 +418,7 @@ static const struct bpf_func_proto bpf_trace_printk_proto = {
 	.gpl_only	= true,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
-	.arg2_type	= ARG_CONST_SIZE,
+	.arg2_type	= ARG_MEM_SIZE,
 };
 
 static void __set_printk_clr_event(struct work_struct *work)
@@ -474,9 +474,9 @@ static const struct bpf_func_proto bpf_trace_vprintk_proto = {
 	.gpl_only	= true,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
-	.arg2_type	= ARG_CONST_SIZE,
+	.arg2_type	= ARG_MEM_SIZE,
 	.arg3_type	= ARG_PTR_TO_MEM | PTR_MAYBE_NULL | MEM_RDONLY,
-	.arg4_type	= ARG_CONST_SIZE_OR_ZERO,
+	.arg4_type	= ARG_MEM_SIZE_OR_ZERO,
 };
 
 const struct bpf_func_proto *bpf_get_trace_vprintk_proto(void)
@@ -518,9 +518,9 @@ static const struct bpf_func_proto bpf_seq_printf_proto = {
 	.arg1_type	= ARG_PTR_TO_BTF_ID,
 	.arg1_btf_id	= &btf_seq_file_ids[0],
 	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
-	.arg3_type	= ARG_CONST_SIZE,
+	.arg3_type	= ARG_MEM_SIZE,
 	.arg4_type      = ARG_PTR_TO_MEM | PTR_MAYBE_NULL | MEM_RDONLY,
-	.arg5_type      = ARG_CONST_SIZE_OR_ZERO,
+	.arg5_type      = ARG_MEM_SIZE_OR_ZERO,
 };
 
 BPF_CALL_3(bpf_seq_write, struct seq_file *, m, const void *, data, u32, len)
@@ -535,7 +535,7 @@ static const struct bpf_func_proto bpf_seq_write_proto = {
 	.arg1_type	= ARG_PTR_TO_BTF_ID,
 	.arg1_btf_id	= &btf_seq_file_ids[0],
 	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
-	.arg3_type	= ARG_CONST_SIZE_OR_ZERO,
+	.arg3_type	= ARG_MEM_SIZE_OR_ZERO,
 };
 
 BPF_CALL_4(bpf_seq_printf_btf, struct seq_file *, m, struct btf_ptr *, ptr,
@@ -559,7 +559,7 @@ static const struct bpf_func_proto bpf_seq_printf_btf_proto = {
 	.arg1_type	= ARG_PTR_TO_BTF_ID,
 	.arg1_btf_id	= &btf_seq_file_ids[0],
 	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
-	.arg3_type	= ARG_CONST_SIZE_OR_ZERO,
+	.arg3_type	= ARG_MEM_SIZE_OR_ZERO,
 	.arg4_type	= ARG_ANYTHING,
 };
 
@@ -633,7 +633,7 @@ static const struct bpf_func_proto bpf_perf_event_read_value_proto = {
 	.arg1_type	= ARG_CONST_MAP_PTR,
 	.arg2_type	= ARG_ANYTHING,
 	.arg3_type	= ARG_PTR_TO_UNINIT_MEM,
-	.arg4_type	= ARG_CONST_SIZE,
+	.arg4_type	= ARG_MEM_SIZE,
 };
 
 const struct bpf_func_proto *bpf_get_perf_event_read_value_proto(void)
@@ -730,7 +730,7 @@ static const struct bpf_func_proto bpf_perf_event_output_proto = {
 	.arg2_type	= ARG_CONST_MAP_PTR,
 	.arg3_type	= ARG_ANYTHING,
 	.arg4_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
-	.arg5_type	= ARG_CONST_SIZE_OR_ZERO,
+	.arg5_type	= ARG_MEM_SIZE_OR_ZERO,
 };
 
 static DEFINE_PER_CPU(int, bpf_event_output_nest_level);
@@ -996,7 +996,7 @@ static const struct bpf_func_proto bpf_d_path_proto = {
 	.arg1_type	= ARG_PTR_TO_BTF_ID,
 	.arg1_btf_id	= &bpf_d_path_btf_ids[0],
 	.arg2_type	= ARG_PTR_TO_MEM | MEM_WRITE,
-	.arg3_type	= ARG_CONST_SIZE_OR_ZERO,
+	.arg3_type	= ARG_MEM_SIZE_OR_ZERO,
 	.allowed	= bpf_d_path_allowed,
 };
 
@@ -1053,9 +1053,9 @@ const struct bpf_func_proto bpf_snprintf_btf_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_MEM | MEM_WRITE,
-	.arg2_type	= ARG_CONST_SIZE,
+	.arg2_type	= ARG_MEM_SIZE,
 	.arg3_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
-	.arg4_type	= ARG_CONST_SIZE,
+	.arg4_type	= ARG_MEM_SIZE,
 	.arg5_type	= ARG_ANYTHING,
 };
 
@@ -1218,7 +1218,7 @@ const struct bpf_func_proto bpf_get_branch_snapshot_proto = {
 	.gpl_only	= true,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_UNINIT_MEM,
-	.arg2_type	= ARG_CONST_SIZE_OR_ZERO,
+	.arg2_type	= ARG_MEM_SIZE_OR_ZERO,
 };
 
 BPF_CALL_3(get_func_arg, void *, ctx, u32, n, u64 *, value)
@@ -1421,7 +1421,7 @@ static const struct bpf_func_proto bpf_perf_event_output_proto_tp = {
 	.arg2_type	= ARG_CONST_MAP_PTR,
 	.arg3_type	= ARG_ANYTHING,
 	.arg4_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
-	.arg5_type	= ARG_CONST_SIZE_OR_ZERO,
+	.arg5_type	= ARG_MEM_SIZE_OR_ZERO,
 };
 
 BPF_CALL_3(bpf_get_stackid_tp, void *, tp_buff, struct bpf_map *, map,
@@ -1462,7 +1462,7 @@ static const struct bpf_func_proto bpf_get_stack_proto_tp = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_PTR_TO_UNINIT_MEM,
-	.arg3_type	= ARG_CONST_SIZE_OR_ZERO,
+	.arg3_type	= ARG_MEM_SIZE_OR_ZERO,
 	.arg4_type	= ARG_ANYTHING,
 };
 
@@ -1524,12 +1524,12 @@ BPF_CALL_3(bpf_perf_prog_read_value, struct bpf_perf_event_data_kern *, ctx,
 }
 
 static const struct bpf_func_proto bpf_perf_prog_read_value_proto = {
-         .func           = bpf_perf_prog_read_value,
-         .gpl_only       = true,
-         .ret_type       = RET_INTEGER,
-         .arg1_type      = ARG_PTR_TO_CTX,
-         .arg2_type      = ARG_PTR_TO_UNINIT_MEM,
-         .arg3_type      = ARG_CONST_SIZE,
+	.func           = bpf_perf_prog_read_value,
+	.gpl_only       = true,
+	.ret_type       = RET_INTEGER,
+	.arg1_type      = ARG_PTR_TO_CTX,
+	.arg2_type      = ARG_PTR_TO_UNINIT_MEM,
+	.arg3_type      = ARG_MEM_SIZE,
 };
 
 BPF_CALL_4(bpf_read_branch_records, struct bpf_perf_event_data_kern *, ctx,
@@ -1566,7 +1566,7 @@ static const struct bpf_func_proto bpf_read_branch_records_proto = {
 	.ret_type       = RET_INTEGER,
 	.arg1_type      = ARG_PTR_TO_CTX,
 	.arg2_type      = ARG_PTR_TO_MEM_OR_NULL | MEM_WRITE,
-	.arg3_type      = ARG_CONST_SIZE_OR_ZERO,
+	.arg3_type      = ARG_MEM_SIZE_OR_ZERO,
 	.arg4_type      = ARG_ANYTHING,
 };
 
@@ -1646,7 +1646,7 @@ static const struct bpf_func_proto bpf_perf_event_output_proto_raw_tp = {
 	.arg2_type	= ARG_CONST_MAP_PTR,
 	.arg3_type	= ARG_ANYTHING,
 	.arg4_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
-	.arg5_type	= ARG_CONST_SIZE_OR_ZERO,
+	.arg5_type	= ARG_MEM_SIZE_OR_ZERO,
 };
 
 extern const struct bpf_func_proto bpf_skb_output_proto;
@@ -1701,7 +1701,7 @@ static const struct bpf_func_proto bpf_get_stack_proto_raw_tp = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_PTR_TO_UNINIT_MEM,
-	.arg3_type	= ARG_CONST_SIZE_OR_ZERO,
+	.arg3_type	= ARG_MEM_SIZE_OR_ZERO,
 	.arg4_type	= ARG_ANYTHING,
 };
 
diff --git a/net/core/filter.c b/net/core/filter.c
index 0b7afdd0ae47..eb0b706af4b2 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -1747,7 +1747,7 @@ static const struct bpf_func_proto bpf_skb_store_bytes_proto = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_ANYTHING,
 	.arg3_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
-	.arg4_type	= ARG_CONST_SIZE,
+	.arg4_type	= ARG_MEM_SIZE,
 	.arg5_type	= ARG_ANYTHING,
 };
 
@@ -1784,7 +1784,7 @@ static const struct bpf_func_proto bpf_skb_load_bytes_proto = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_ANYTHING,
 	.arg3_type	= ARG_PTR_TO_UNINIT_MEM,
-	.arg4_type	= ARG_CONST_SIZE,
+	.arg4_type	= ARG_MEM_SIZE,
 };
 
 int __bpf_skb_load_bytes(const struct sk_buff *skb, u32 offset, void *to, u32 len)
@@ -1823,7 +1823,7 @@ static const struct bpf_func_proto bpf_flow_dissector_load_bytes_proto = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_ANYTHING,
 	.arg3_type	= ARG_PTR_TO_UNINIT_MEM,
-	.arg4_type	= ARG_CONST_SIZE,
+	.arg4_type	= ARG_MEM_SIZE,
 };
 
 BPF_CALL_5(bpf_skb_load_bytes_relative, const struct sk_buff *, skb,
@@ -1867,7 +1867,7 @@ static const struct bpf_func_proto bpf_skb_load_bytes_relative_proto = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_ANYTHING,
 	.arg3_type	= ARG_PTR_TO_UNINIT_MEM,
-	.arg4_type	= ARG_CONST_SIZE,
+	.arg4_type	= ARG_MEM_SIZE,
 	.arg5_type	= ARG_ANYTHING,
 };
 
@@ -2063,9 +2063,9 @@ static const struct bpf_func_proto bpf_csum_diff_proto = {
 	.pkt_access	= true,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_MEM | PTR_MAYBE_NULL | MEM_RDONLY,
-	.arg2_type	= ARG_CONST_SIZE_OR_ZERO,
+	.arg2_type	= ARG_MEM_SIZE_OR_ZERO,
 	.arg3_type	= ARG_PTR_TO_MEM | PTR_MAYBE_NULL | MEM_RDONLY,
-	.arg4_type	= ARG_CONST_SIZE_OR_ZERO,
+	.arg4_type	= ARG_MEM_SIZE_OR_ZERO,
 	.arg5_type	= ARG_ANYTHING,
 };
 
@@ -2621,7 +2621,7 @@ static const struct bpf_func_proto bpf_redirect_neigh_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_ANYTHING,
 	.arg2_type      = ARG_PTR_TO_MEM | PTR_MAYBE_NULL | MEM_RDONLY,
-	.arg3_type      = ARG_CONST_SIZE_OR_ZERO,
+	.arg3_type      = ARG_MEM_SIZE_OR_ZERO,
 	.arg4_type	= ARG_ANYTHING,
 };
 
@@ -4194,7 +4194,7 @@ static const struct bpf_func_proto bpf_xdp_load_bytes_proto = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_ANYTHING,
 	.arg3_type	= ARG_PTR_TO_UNINIT_MEM,
-	.arg4_type	= ARG_CONST_SIZE,
+	.arg4_type	= ARG_MEM_SIZE,
 };
 
 int __bpf_xdp_load_bytes(struct xdp_buff *xdp, u32 offset, void *buf, u32 len)
@@ -4226,7 +4226,7 @@ static const struct bpf_func_proto bpf_xdp_store_bytes_proto = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_ANYTHING,
 	.arg3_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
-	.arg4_type	= ARG_CONST_SIZE,
+	.arg4_type	= ARG_MEM_SIZE,
 };
 
 int __bpf_xdp_store_bytes(struct xdp_buff *xdp, u32 offset, void *buf, u32 len)
@@ -4789,7 +4789,7 @@ static const struct bpf_func_proto bpf_skb_event_output_proto = {
 	.arg2_type	= ARG_CONST_MAP_PTR,
 	.arg3_type	= ARG_ANYTHING,
 	.arg4_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
-	.arg5_type	= ARG_CONST_SIZE_OR_ZERO,
+	.arg5_type	= ARG_MEM_SIZE_OR_ZERO,
 };
 
 BTF_ID_LIST_SINGLE(bpf_skb_output_btf_ids, struct, sk_buff)
@@ -4803,7 +4803,7 @@ const struct bpf_func_proto bpf_skb_output_proto = {
 	.arg2_type	= ARG_CONST_MAP_PTR,
 	.arg3_type	= ARG_ANYTHING,
 	.arg4_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
-	.arg5_type	= ARG_CONST_SIZE_OR_ZERO,
+	.arg5_type	= ARG_MEM_SIZE_OR_ZERO,
 };
 
 static unsigned short bpf_tunnel_key_af(u64 flags)
@@ -4886,7 +4886,7 @@ static const struct bpf_func_proto bpf_skb_get_tunnel_key_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_PTR_TO_UNINIT_MEM,
-	.arg3_type	= ARG_CONST_SIZE,
+	.arg3_type	= ARG_MEM_SIZE,
 	.arg4_type	= ARG_ANYTHING,
 };
 
@@ -4921,7 +4921,7 @@ static const struct bpf_func_proto bpf_skb_get_tunnel_opt_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_PTR_TO_UNINIT_MEM,
-	.arg3_type	= ARG_CONST_SIZE,
+	.arg3_type	= ARG_MEM_SIZE,
 };
 
 static struct metadata_dst __percpu *md_dst;
@@ -5003,7 +5003,7 @@ static const struct bpf_func_proto bpf_skb_set_tunnel_key_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
-	.arg3_type	= ARG_CONST_SIZE,
+	.arg3_type	= ARG_MEM_SIZE,
 	.arg4_type	= ARG_ANYTHING,
 };
 
@@ -5031,7 +5031,7 @@ static const struct bpf_func_proto bpf_skb_set_tunnel_opt_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
-	.arg3_type	= ARG_CONST_SIZE,
+	.arg3_type	= ARG_MEM_SIZE,
 };
 
 static const struct bpf_func_proto *
@@ -5203,7 +5203,7 @@ static const struct bpf_func_proto bpf_xdp_event_output_proto = {
 	.arg2_type	= ARG_CONST_MAP_PTR,
 	.arg3_type	= ARG_ANYTHING,
 	.arg4_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
-	.arg5_type	= ARG_CONST_SIZE_OR_ZERO,
+	.arg5_type	= ARG_MEM_SIZE_OR_ZERO,
 };
 
 BTF_ID_LIST_SINGLE(bpf_xdp_output_btf_ids, struct, xdp_buff)
@@ -5217,7 +5217,7 @@ const struct bpf_func_proto bpf_xdp_output_proto = {
 	.arg2_type	= ARG_CONST_MAP_PTR,
 	.arg3_type	= ARG_ANYTHING,
 	.arg4_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
-	.arg5_type	= ARG_CONST_SIZE_OR_ZERO,
+	.arg5_type	= ARG_MEM_SIZE_OR_ZERO,
 };
 
 BPF_CALL_1(bpf_get_socket_cookie, struct sk_buff *, skb)
@@ -5764,7 +5764,7 @@ const struct bpf_func_proto bpf_sk_setsockopt_proto = {
 	.arg2_type	= ARG_ANYTHING,
 	.arg3_type	= ARG_ANYTHING,
 	.arg4_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
-	.arg5_type	= ARG_CONST_SIZE,
+	.arg5_type	= ARG_MEM_SIZE,
 };
 
 BPF_CALL_5(bpf_sk_getsockopt, struct sock *, sk, int, level,
@@ -5781,7 +5781,7 @@ const struct bpf_func_proto bpf_sk_getsockopt_proto = {
 	.arg2_type	= ARG_ANYTHING,
 	.arg3_type	= ARG_ANYTHING,
 	.arg4_type	= ARG_PTR_TO_UNINIT_MEM,
-	.arg5_type	= ARG_CONST_SIZE,
+	.arg5_type	= ARG_MEM_SIZE,
 };
 
 BPF_CALL_5(bpf_sk_setsockopt_nodelay, struct sock *, sk, int, level,
@@ -5805,7 +5805,7 @@ const struct bpf_func_proto bpf_sk_setsockopt_nodelay_proto = {
 	.arg2_type	= ARG_ANYTHING,
 	.arg3_type	= ARG_ANYTHING,
 	.arg4_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
-	.arg5_type	= ARG_CONST_SIZE,
+	.arg5_type	= ARG_MEM_SIZE,
 };
 
 BPF_CALL_5(bpf_unlocked_sk_setsockopt, struct sock *, sk, int, level,
@@ -5822,7 +5822,7 @@ const struct bpf_func_proto bpf_unlocked_sk_setsockopt_proto = {
 	.arg2_type	= ARG_ANYTHING,
 	.arg3_type	= ARG_ANYTHING,
 	.arg4_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
-	.arg5_type	= ARG_CONST_SIZE,
+	.arg5_type	= ARG_MEM_SIZE,
 };
 
 BPF_CALL_5(bpf_unlocked_sk_getsockopt, struct sock *, sk, int, level,
@@ -5839,7 +5839,7 @@ const struct bpf_func_proto bpf_unlocked_sk_getsockopt_proto = {
 	.arg2_type	= ARG_ANYTHING,
 	.arg3_type	= ARG_ANYTHING,
 	.arg4_type	= ARG_PTR_TO_UNINIT_MEM,
-	.arg5_type	= ARG_CONST_SIZE,
+	.arg5_type	= ARG_MEM_SIZE,
 };
 
 BPF_CALL_5(bpf_sock_addr_setsockopt, struct bpf_sock_addr_kern *, ctx,
@@ -5856,7 +5856,7 @@ static const struct bpf_func_proto bpf_sock_addr_setsockopt_proto = {
 	.arg2_type	= ARG_ANYTHING,
 	.arg3_type	= ARG_ANYTHING,
 	.arg4_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
-	.arg5_type	= ARG_CONST_SIZE,
+	.arg5_type	= ARG_MEM_SIZE,
 };
 
 BPF_CALL_5(bpf_sock_addr_getsockopt, struct bpf_sock_addr_kern *, ctx,
@@ -5873,7 +5873,7 @@ static const struct bpf_func_proto bpf_sock_addr_getsockopt_proto = {
 	.arg2_type	= ARG_ANYTHING,
 	.arg3_type	= ARG_ANYTHING,
 	.arg4_type	= ARG_PTR_TO_UNINIT_MEM,
-	.arg5_type	= ARG_CONST_SIZE,
+	.arg5_type	= ARG_MEM_SIZE,
 };
 
 static int sk_bpf_set_get_bypass_prot_mem(struct sock *sk,
@@ -5918,7 +5918,7 @@ static const struct bpf_func_proto bpf_sock_create_setsockopt_proto = {
 	.arg2_type	= ARG_ANYTHING,
 	.arg3_type	= ARG_ANYTHING,
 	.arg4_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
-	.arg5_type	= ARG_CONST_SIZE,
+	.arg5_type	= ARG_MEM_SIZE,
 };
 
 BPF_CALL_5(bpf_sock_create_getsockopt, struct sock *, sk, int, level,
@@ -5944,7 +5944,7 @@ static const struct bpf_func_proto bpf_sock_create_getsockopt_proto = {
 	.arg2_type	= ARG_ANYTHING,
 	.arg3_type	= ARG_ANYTHING,
 	.arg4_type	= ARG_PTR_TO_UNINIT_MEM,
-	.arg5_type	= ARG_CONST_SIZE,
+	.arg5_type	= ARG_MEM_SIZE,
 };
 
 BPF_CALL_5(bpf_sock_ops_setsockopt, struct bpf_sock_ops_kern *, bpf_sock,
@@ -5970,7 +5970,7 @@ static const struct bpf_func_proto bpf_sock_ops_setsockopt_proto = {
 	.arg2_type	= ARG_ANYTHING,
 	.arg3_type	= ARG_ANYTHING,
 	.arg4_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
-	.arg5_type	= ARG_CONST_SIZE,
+	.arg5_type	= ARG_MEM_SIZE,
 };
 
 static int bpf_sock_ops_get_syn(struct bpf_sock_ops_kern *bpf_sock,
@@ -6080,7 +6080,7 @@ static const struct bpf_func_proto bpf_sock_ops_getsockopt_proto = {
 	.arg2_type	= ARG_ANYTHING,
 	.arg3_type	= ARG_ANYTHING,
 	.arg4_type	= ARG_PTR_TO_UNINIT_MEM,
-	.arg5_type	= ARG_CONST_SIZE,
+	.arg5_type	= ARG_MEM_SIZE,
 };
 
 BPF_CALL_2(bpf_sock_ops_cb_flags_set, struct bpf_sock_ops_kern *, bpf_sock,
@@ -6147,7 +6147,7 @@ static const struct bpf_func_proto bpf_bind_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
-	.arg3_type	= ARG_CONST_SIZE,
+	.arg3_type	= ARG_MEM_SIZE,
 };
 
 #ifdef CONFIG_XFRM
@@ -6200,7 +6200,7 @@ static const struct bpf_func_proto bpf_skb_get_xfrm_state_proto = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_ANYTHING,
 	.arg3_type	= ARG_PTR_TO_UNINIT_MEM,
-	.arg4_type	= ARG_CONST_SIZE,
+	.arg4_type	= ARG_MEM_SIZE,
 	.arg5_type	= ARG_ANYTHING,
 };
 #endif
@@ -6607,7 +6607,7 @@ static const struct bpf_func_proto bpf_xdp_fib_lookup_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type      = ARG_PTR_TO_CTX,
 	.arg2_type      = ARG_PTR_TO_MEM | MEM_WRITE,
-	.arg3_type      = ARG_CONST_SIZE,
+	.arg3_type      = ARG_MEM_SIZE,
 	.arg4_type	= ARG_ANYTHING,
 };
 
@@ -6667,7 +6667,7 @@ static const struct bpf_func_proto bpf_skb_fib_lookup_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type      = ARG_PTR_TO_CTX,
 	.arg2_type      = ARG_PTR_TO_MEM | MEM_WRITE,
-	.arg3_type      = ARG_CONST_SIZE,
+	.arg3_type      = ARG_MEM_SIZE,
 	.arg4_type	= ARG_ANYTHING,
 };
 
@@ -6865,7 +6865,7 @@ static const struct bpf_func_proto bpf_lwt_in_push_encap_proto = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_ANYTHING,
 	.arg3_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
-	.arg4_type	= ARG_CONST_SIZE
+	.arg4_type	= ARG_MEM_SIZE
 };
 
 static const struct bpf_func_proto bpf_lwt_xmit_push_encap_proto = {
@@ -6875,7 +6875,7 @@ static const struct bpf_func_proto bpf_lwt_xmit_push_encap_proto = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_ANYTHING,
 	.arg3_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
-	.arg4_type	= ARG_CONST_SIZE
+	.arg4_type	= ARG_MEM_SIZE
 };
 
 #if IS_ENABLED(CONFIG_IPV6_SEG6_BPF)
@@ -6919,7 +6919,7 @@ static const struct bpf_func_proto bpf_lwt_seg6_store_bytes_proto = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_ANYTHING,
 	.arg3_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
-	.arg4_type	= ARG_CONST_SIZE
+	.arg4_type	= ARG_MEM_SIZE
 };
 
 static void bpf_update_srh_state(struct sk_buff *skb)
@@ -7008,7 +7008,7 @@ static const struct bpf_func_proto bpf_lwt_seg6_action_proto = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_ANYTHING,
 	.arg3_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
-	.arg4_type	= ARG_CONST_SIZE
+	.arg4_type	= ARG_MEM_SIZE
 };
 
 BPF_CALL_3(bpf_lwt_seg6_adjust_srh, struct sk_buff *, skb, u32, offset,
@@ -7249,7 +7249,7 @@ static const struct bpf_func_proto bpf_skc_lookup_tcp_proto = {
 	.ret_type	= RET_PTR_TO_SOCK_COMMON_OR_NULL,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
-	.arg3_type	= ARG_CONST_SIZE_OR_ZERO,
+	.arg3_type	= ARG_MEM_SIZE_OR_ZERO,
 	.arg4_type	= ARG_ANYTHING,
 	.arg5_type	= ARG_ANYTHING,
 };
@@ -7268,7 +7268,7 @@ static const struct bpf_func_proto bpf_sk_lookup_tcp_proto = {
 	.ret_type	= RET_PTR_TO_SOCKET_OR_NULL,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
-	.arg3_type	= ARG_CONST_SIZE_OR_ZERO,
+	.arg3_type	= ARG_MEM_SIZE_OR_ZERO,
 	.arg4_type	= ARG_ANYTHING,
 	.arg5_type	= ARG_ANYTHING,
 };
@@ -7287,7 +7287,7 @@ static const struct bpf_func_proto bpf_sk_lookup_udp_proto = {
 	.ret_type	= RET_PTR_TO_SOCKET_OR_NULL,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
-	.arg3_type	= ARG_CONST_SIZE_OR_ZERO,
+	.arg3_type	= ARG_MEM_SIZE_OR_ZERO,
 	.arg4_type	= ARG_ANYTHING,
 	.arg5_type	= ARG_ANYTHING,
 };
@@ -7311,7 +7311,7 @@ static const struct bpf_func_proto bpf_tc_skc_lookup_tcp_proto = {
 	.ret_type	= RET_PTR_TO_SOCK_COMMON_OR_NULL,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
-	.arg3_type	= ARG_CONST_SIZE_OR_ZERO,
+	.arg3_type	= ARG_MEM_SIZE_OR_ZERO,
 	.arg4_type	= ARG_ANYTHING,
 	.arg5_type	= ARG_ANYTHING,
 };
@@ -7335,7 +7335,7 @@ static const struct bpf_func_proto bpf_tc_sk_lookup_tcp_proto = {
 	.ret_type	= RET_PTR_TO_SOCKET_OR_NULL,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
-	.arg3_type	= ARG_CONST_SIZE_OR_ZERO,
+	.arg3_type	= ARG_MEM_SIZE_OR_ZERO,
 	.arg4_type	= ARG_ANYTHING,
 	.arg5_type	= ARG_ANYTHING,
 };
@@ -7359,7 +7359,7 @@ static const struct bpf_func_proto bpf_tc_sk_lookup_udp_proto = {
 	.ret_type	= RET_PTR_TO_SOCKET_OR_NULL,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
-	.arg3_type	= ARG_CONST_SIZE_OR_ZERO,
+	.arg3_type	= ARG_MEM_SIZE_OR_ZERO,
 	.arg4_type	= ARG_ANYTHING,
 	.arg5_type	= ARG_ANYTHING,
 };
@@ -7397,7 +7397,7 @@ static const struct bpf_func_proto bpf_xdp_sk_lookup_udp_proto = {
 	.ret_type       = RET_PTR_TO_SOCKET_OR_NULL,
 	.arg1_type      = ARG_PTR_TO_CTX,
 	.arg2_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
-	.arg3_type      = ARG_CONST_SIZE_OR_ZERO,
+	.arg3_type      = ARG_MEM_SIZE_OR_ZERO,
 	.arg4_type      = ARG_ANYTHING,
 	.arg5_type      = ARG_ANYTHING,
 };
@@ -7421,7 +7421,7 @@ static const struct bpf_func_proto bpf_xdp_skc_lookup_tcp_proto = {
 	.ret_type       = RET_PTR_TO_SOCK_COMMON_OR_NULL,
 	.arg1_type      = ARG_PTR_TO_CTX,
 	.arg2_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
-	.arg3_type      = ARG_CONST_SIZE_OR_ZERO,
+	.arg3_type      = ARG_MEM_SIZE_OR_ZERO,
 	.arg4_type      = ARG_ANYTHING,
 	.arg5_type      = ARG_ANYTHING,
 };
@@ -7445,7 +7445,7 @@ static const struct bpf_func_proto bpf_xdp_sk_lookup_tcp_proto = {
 	.ret_type       = RET_PTR_TO_SOCKET_OR_NULL,
 	.arg1_type      = ARG_PTR_TO_CTX,
 	.arg2_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
-	.arg3_type      = ARG_CONST_SIZE_OR_ZERO,
+	.arg3_type      = ARG_MEM_SIZE_OR_ZERO,
 	.arg4_type      = ARG_ANYTHING,
 	.arg5_type      = ARG_ANYTHING,
 };
@@ -7465,7 +7465,7 @@ static const struct bpf_func_proto bpf_sock_addr_skc_lookup_tcp_proto = {
 	.ret_type	= RET_PTR_TO_SOCK_COMMON_OR_NULL,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
-	.arg3_type	= ARG_CONST_SIZE_OR_ZERO,
+	.arg3_type	= ARG_MEM_SIZE_OR_ZERO,
 	.arg4_type	= ARG_ANYTHING,
 	.arg5_type	= ARG_ANYTHING,
 };
@@ -7484,7 +7484,7 @@ static const struct bpf_func_proto bpf_sock_addr_sk_lookup_tcp_proto = {
 	.ret_type	= RET_PTR_TO_SOCKET_OR_NULL,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
-	.arg3_type	= ARG_CONST_SIZE_OR_ZERO,
+	.arg3_type	= ARG_MEM_SIZE_OR_ZERO,
 	.arg4_type	= ARG_ANYTHING,
 	.arg5_type	= ARG_ANYTHING,
 };
@@ -7503,7 +7503,7 @@ static const struct bpf_func_proto bpf_sock_addr_sk_lookup_udp_proto = {
 	.ret_type	= RET_PTR_TO_SOCKET_OR_NULL,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
-	.arg3_type	= ARG_CONST_SIZE_OR_ZERO,
+	.arg3_type	= ARG_MEM_SIZE_OR_ZERO,
 	.arg4_type	= ARG_ANYTHING,
 	.arg5_type	= ARG_ANYTHING,
 };
@@ -7823,9 +7823,9 @@ static const struct bpf_func_proto bpf_tcp_check_syncookie_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_BTF_ID_SOCK_COMMON,
 	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
-	.arg3_type	= ARG_CONST_SIZE,
+	.arg3_type	= ARG_MEM_SIZE,
 	.arg4_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
-	.arg5_type	= ARG_CONST_SIZE,
+	.arg5_type	= ARG_MEM_SIZE,
 };
 
 BPF_CALL_5(bpf_tcp_gen_syncookie, struct sock *, sk, void *, iph, u32, iph_len,
@@ -7892,9 +7892,9 @@ static const struct bpf_func_proto bpf_tcp_gen_syncookie_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_BTF_ID_SOCK_COMMON,
 	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
-	.arg3_type	= ARG_CONST_SIZE,
+	.arg3_type	= ARG_MEM_SIZE,
 	.arg4_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
-	.arg5_type	= ARG_CONST_SIZE,
+	.arg5_type	= ARG_MEM_SIZE,
 };
 
 BPF_CALL_3(bpf_sk_assign, struct sk_buff *, skb, struct sock *, sk, u64, flags)
@@ -8048,7 +8048,7 @@ static const struct bpf_func_proto bpf_sock_ops_load_hdr_opt_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_PTR_TO_MEM | MEM_WRITE,
-	.arg3_type	= ARG_CONST_SIZE,
+	.arg3_type	= ARG_MEM_SIZE,
 	.arg4_type	= ARG_ANYTHING,
 };
 
@@ -8126,7 +8126,7 @@ static const struct bpf_func_proto bpf_sock_ops_store_hdr_opt_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
-	.arg3_type	= ARG_CONST_SIZE,
+	.arg3_type	= ARG_MEM_SIZE,
 	.arg4_type	= ARG_ANYTHING,
 };
 
@@ -8221,7 +8221,7 @@ static const struct bpf_func_proto bpf_tcp_raw_gen_syncookie_ipv4_proto = {
 	.arg1_type	= ARG_PTR_TO_FIXED_SIZE_MEM | MEM_RDONLY,
 	.arg1_size	= sizeof(struct iphdr),
 	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
-	.arg3_type	= ARG_CONST_SIZE_OR_ZERO,
+	.arg3_type	= ARG_MEM_SIZE_OR_ZERO,
 };
 
 BPF_CALL_3(bpf_tcp_raw_gen_syncookie_ipv6, struct ipv6hdr *, iph,
@@ -8253,7 +8253,7 @@ static const struct bpf_func_proto bpf_tcp_raw_gen_syncookie_ipv6_proto = {
 	.arg1_type	= ARG_PTR_TO_FIXED_SIZE_MEM | MEM_RDONLY,
 	.arg1_size	= sizeof(struct ipv6hdr),
 	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
-	.arg3_type	= ARG_CONST_SIZE_OR_ZERO,
+	.arg3_type	= ARG_MEM_SIZE_OR_ZERO,
 };
 
 BPF_CALL_2(bpf_tcp_raw_check_syncookie_ipv4, struct iphdr *, iph,
@@ -11726,7 +11726,7 @@ static const struct bpf_func_proto sk_reuseport_load_bytes_proto = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_ANYTHING,
 	.arg3_type	= ARG_PTR_TO_UNINIT_MEM,
-	.arg4_type	= ARG_CONST_SIZE,
+	.arg4_type	= ARG_MEM_SIZE,
 };
 
 BPF_CALL_5(sk_reuseport_load_bytes_relative,
@@ -11744,7 +11744,7 @@ static const struct bpf_func_proto sk_reuseport_load_bytes_relative_proto = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_ANYTHING,
 	.arg3_type	= ARG_PTR_TO_UNINIT_MEM,
-	.arg4_type	= ARG_CONST_SIZE,
+	.arg4_type	= ARG_MEM_SIZE,
 	.arg5_type	= ARG_ANYTHING,
 };
 
diff --git a/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c b/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c
index 5b4453747c23..0952d1ebf0f1 100644
--- a/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c
+++ b/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c
@@ -137,7 +137,7 @@ int helper_param_not_ok(void *ctx)
 
 	p = bpf_rdonly_cast(0, 0);
 	/*
-	 * Any helper with ARG_CONST_SIZE_OR_ZERO constraint will do,
+	 * Any helper with ARG_MEM_SIZE_OR_ZERO constraint will do,
 	 * the most permissive constraint
 	 */
 	bpf_copy_from_user(p, 0, (void *)42);
diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index bc038ac2df98..1a273e416fed 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -1195,7 +1195,7 @@ l0_%=:	r1 = r6;					\
 	r3 += -8;					\
 	r5 = 0;						\
 	/* The 4th argument of bpf_skb_store_bytes is defined as \
-	 * ARG_CONST_SIZE, so 0 is not allowed. The 'r4 != 0' \
+	 * ARG_MEM_SIZE, so 0 is not allowed. The 'r4 != 0' \
 	 * is providing us this exclusion of zero from initial \
 	 * [0, 7] range.				\
 	 */						\
diff --git a/tools/testing/selftests/bpf/progs/verifier_helper_access_var_len.c b/tools/testing/selftests/bpf/progs/verifier_helper_access_var_len.c
index f2c54e4d89eb..343fc08d9747 100644
--- a/tools/testing/selftests/bpf/progs/verifier_helper_access_var_len.c
+++ b/tools/testing/selftests/bpf/progs/verifier_helper_access_var_len.c
@@ -85,7 +85,7 @@ __naked void stack_bitwise_and_zero_included(void)
 	r2 += -64;					\
 	r4 = 0;						\
 	/* Call bpf_ringbuf_output(), it is one of a few helper functions with\
-	 * ARG_CONST_SIZE_OR_ZERO parameter allowed in unpriv mode.\
+	 * ARG_MEM_SIZE_OR_ZERO parameter allowed in unpriv mode.\
 	 * For unpriv this should signal an error, because memory at &fp[-64] is\
 	 * not initialized.				\
 	 */						\
@@ -278,7 +278,7 @@ __naked void stack_jmp_no_min_check(void)
 	r2 += -64;					\
 	r4 = 0;						\
 	/* Call bpf_ringbuf_output(), it is one of a few helper functions with\
-	 * ARG_CONST_SIZE_OR_ZERO parameter allowed in unpriv mode.\
+	 * ARG_MEM_SIZE_OR_ZERO parameter allowed in unpriv mode.\
 	 * For unpriv this should signal an error, because memory at &fp[-64] is\
 	 * not initialized.				\
 	 */						\
@@ -778,7 +778,7 @@ __naked void variable_memory_8_bytes_leak(void)
 	r3 += 1;					\
 	r4 = 0;						\
 	/* Call bpf_ringbuf_output(), it is one of a few helper functions with\
-	 * ARG_CONST_SIZE_OR_ZERO parameter allowed in unpriv mode.\
+	 * ARG_MEM_SIZE_OR_ZERO parameter allowed in unpriv mode.\
 	 * For unpriv this should signal an error, because memory region [1, 64]\
 	 * at &fp[-64] is not fully initialized.	\
 	 */						\
diff --git a/tools/testing/selftests/bpf/progs/verifier_helper_value_access.c b/tools/testing/selftests/bpf/progs/verifier_helper_value_access.c
index 6d2a38597c34..c6603a118fdc 100644
--- a/tools/testing/selftests/bpf/progs/verifier_helper_value_access.c
+++ b/tools/testing/selftests/bpf/progs/verifier_helper_value_access.c
@@ -91,7 +91,7 @@ l0_%=:	exit;						\
 
 /* Call a function taking a pointer and a size which doesn't allow the size to
  * be zero (i.e. bpf_trace_printk() declares the second argument to be
- * ARG_CONST_SIZE, not ARG_CONST_SIZE_OR_ZERO). We attempt to pass zero for the
+ * ARG_MEM_SIZE, not ARG_MEM_SIZE_OR_ZERO). We attempt to pass zero for the
  * size and expect to fail.
  */
 SEC("tracepoint")
-- 
2.52.0

