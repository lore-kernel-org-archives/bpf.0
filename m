Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C0E3164D8
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 06:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784097656; cv=none; b=Y694AqFTQ13E5v9+6ol/8wtl9iLxAFZk8mg5KlQ9TkecDwz1iDN9eR4g4oEPl7jSeEmD1/pSPyme6EL4dOUEMoM976NSIz8BnKAL6tf2YZoFK2Lc4tf6XwiqIn8Y62koT9RAo6kHmi9eWMR2vG3zoClfRZgRzgPNT+1PG0dgBuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784097656; c=relaxed/simple;
	bh=YuiMVSuttwPqlbXbgt25G9G3ma+p+XJrV/htXlpubwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OclYD/YokBDqxXDwotXADUV0WO3YqpgSVCAMqNGikzWctgecsmD3HqvbQCm2kaa2u3jvrQu7V4+aCGyLJpqv6BEv1VBI0AFaQZLeW3vP5wkByIlyRebMtxFAPlN/GqUW6NjdgEVw/aGf2nO3VGgj3jmE6WbE6PdNPj9A5wH4xWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bn5EPCCI; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bn5EPCCI"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7eb5bdb50fcso863033a34.1
        for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 23:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784097654; x=1784702454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wFHDEK8rc55i7vQiF2jgJENBhqpm5H9Uks6Ex8qpHOU=;
        b=Bn5EPCCIhocs6dVtAO48rOjtyHdFrGEyY+f9KWswrt4elonmPgXiiV+rRBebDwrrBY
         SB2g9gkJ2ET5HPU27ImDnHPU7z92wnladE6Cc9ovCWyFkCqMnoVgjk1uJY4BID8X3+vA
         kZoez/FIG2uucukBwHzGvCggR9U4BMwe+4Kycsy5O0GZ7dBFuQxt+cpF7GaTCps545nr
         ctnz7OMCfxQ+bJdr7f+LNbQIQi5QWOnJOSJmO03i2b+4we9ycJOrKugWfV+XSA9P2A5C
         hkATHbXsPuHSFq7F8qA49m/iL5KoTyvIm8Po3UhnAKr2Yhhv9jFbtTnZyrGhnIGJGx+3
         ZxKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784097654; x=1784702454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wFHDEK8rc55i7vQiF2jgJENBhqpm5H9Uks6Ex8qpHOU=;
        b=ct2V5slWWU3Z0iOf800zoAkSrdrwOIbRV+/YQjqFDBHaG10Xlry0jWAdRUvocXO1py
         N1lckEGapzUqeBQI5EAcoY4oADlRVwXr9syd2fSXWst2Ry6LwAsC8i7ig8o1qwOSPmHZ
         7EmfcGYNugYYoqCmITKkSceL6ER7fUplpegRi1ChJtP7evculzCQXALjhK3wZ/YZ98Wi
         QXpnvK1SpaWtCtNeIyjW7hZDqfkFG8a79k9e+RJvP1MjC1sfxMpwoUGZnmvRQm0n3Hb5
         rknzvvZdOKW+/ImiCYhwkcPSePoFlKvgAd0kM6JTHai+QT+uw6l+kUkcXxWtXJtgH2W6
         GTDA==
X-Gm-Message-State: AOJu0Yxua50mhjf3K6+rXwqo4pDCy+s66munHZVerNxb5ibi+uIlyBP8
	uj43pph91IU55tajNQ44IPZAlj2hDmIa8SfORsq+smZiNLiDrGj7AIuCXH+1FA==
X-Gm-Gg: AfdE7cmrMuVTTTbu+j7I4WToflu10eBG3sOtYaqAbI5a+292VCJSI/yLwBCXcs8zVNS
	Skc9iy02a+wNp6veOf4mpHQaiYYk0B4Omm4qj1yCIyhBbscdR7SOTe27DdmCVnm1Mp9FvxwTlVz
	sDSmCjx2WP/x8+jOl4sTQ/8cXE/6+HNAzR7MWGv1zsetgcvGnTEnYUuM7jJqoWcY+eyvG2G7s8a
	lqNFOZqD/tmmh/1A0gD3DPVe4XaUuaz46scXJPa+Tamta7bh3mLR5sgpbja7uj2OqXbY+/rixbI
	ypnuMUfq1BQSXPXZzltPDNWrAhphertOFacUdTsYvmxkolorLvd3Ld8aGoBkfzLV6R0cJ31Hp3P
	b9PZhgHzShgGnXlYCfX9oc9pZ/fMJS3QP+bue0yFkRRFgrIXVWGwJaC1gsW/HFrV4o1HxRGdCzV
	pRydc=
X-Received: by 2002:a05:6830:81f3:b0:7e3:d199:3164 with SMTP id 46e09a7af769-7ec096ee194mr9790862a34.11.1784097653679;
        Tue, 14 Jul 2026 23:40:53 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:73::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcae206e2sm16665762a34.2.2026.07.14.23.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 23:40:53 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 2/7] bpf: Factor out raw_mode-related fields in bpf_call_arg_meta
Date: Tue, 14 Jul 2026 23:40:42 -0700
Message-ID: <20260715064047.1793790-3-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260715064047.1793790-1-ameryhung@gmail.com>
References: <20260715064047.1793790-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To prepare for unifying the helper and kfunc call_arg_meta, group the
scattered MEM_UNINIT ("raw") memory argument fields (raw_mode, regno and
access_size) into a new struct arg_raw_mem_desc. The intention is to
make it clear about when these are set and used instead of fields with
overly generic names.

Identify the raw argument once, up front, in check_raw_mode_ok() (like
check_proto_release_reg() does for release_regno), recording its regno.
check_stack_range_initialized() now recognizes the raw buffer by matching
that regno, so the separate raw_mode flag is no longer needed, and the
per-argument "meta->raw_mode = arg_type & MEM_UNINIT" assignments in
check_func_arg() go away with it.

A raw memory argument can be tagged either ARG_PTR_TO_MEM | MEM_UNINIT or
ARG_PTR_TO_MAP_VALUE | MEM_UNINIT (the output buffer of bpf_map_pop_elem()
and bpf_map_peek_elem()). Either may be passed as a PTR_TO_STACK, which
reaches check_stack_range_initialized() through check_helper_mem_access(),
so both must be treated as raw. Extend arg_type_is_raw_mem() to match the
map value case as well; otherwise check_raw_mode_ok() would not record the
regno for it and an uninitialized stack buffer passed to those helpers
would be wrongly rejected for programs without CAP_PERFMON.

No functional change intended. This patch does not enable raw_mode
memory access for kfunc (i.e., uninit stack will not be allowed to be
passed to kfunc for unprivileged programs). Existing kfuncs with arguments
tagged with __uninit are either priviledged or dynptr kfuncs, which take
another path to make sure the access is checked by check_mem_access().

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf_verifier.h |  9 ++++++
 kernel/bpf/verifier.c        | 58 +++++++++++++++++-------------------
 2 files changed, 36 insertions(+), 31 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 317e99b9acc0..d3592f5b8621 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1464,6 +1464,15 @@ struct ref_obj_desc {
 	u8 cnt;
 };
 
+/*
+ * A memory argument a call fills in. The verifier allows the stack to be uninitialized if
+ * the range is a known constant. Stack slots are marked as STACK_MISC by check_mem_access().
+ */
+struct arg_raw_mem_desc {
+	u8 regno;
+	int size;
+};
+
 struct bpf_kfunc_call_arg_meta {
 	/* In parameters */
 	struct btf *btf;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7dd961ede88d..1a41f99a9133 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -256,11 +256,9 @@ struct bpf_call_arg_meta {
 	struct bpf_map_desc map;
 	struct bpf_dynptr_desc dynptr;
 	struct ref_obj_desc ref_obj;
-	bool raw_mode;
+	struct arg_raw_mem_desc arg_raw_mem;
 	bool pkt_access;
 	u8 release_regno;
-	int regno;
-	int access_size;
 	int mem_size;
 	u64 msize_max_value;
 	int func_id;
@@ -6690,6 +6688,8 @@ static int check_stack_range_initialized(
 	 * but BTF based global subprog validation isn't accurate enough.
 	 */
 	bool allow_poison = access_size < 0 || clobber;
+	/* The call will initialize the memory; uninitialized stack allowed */
+	bool raw_mode = meta && meta->arg_raw_mem.regno == reg_from_argno(argno);
 
 	access_size = abs(access_size);
 
@@ -6725,16 +6725,14 @@ static int check_stack_range_initialized(
 		 * helper return since specific bounds are unknown what may
 		 * cause uninitialized stack leaking.
 		 */
-		if (meta && meta->raw_mode)
-			meta = NULL;
+		raw_mode = false;
 
 		min_off = reg_smin(reg) + off;
 		max_off = reg_smax(reg) + off;
 	}
 
-	if (meta && meta->raw_mode) {
-		meta->access_size = access_size;
-		meta->regno = reg_from_argno(argno);
+	if (raw_mode) {
+		meta->arg_raw_mem.size = access_size;
 		return 0;
 	}
 
@@ -7727,7 +7725,13 @@ static bool arg_type_is_mem_size(enum bpf_arg_type type)
 
 static bool arg_type_is_raw_mem(enum bpf_arg_type type)
 {
-	return base_type(type) == ARG_PTR_TO_MEM &&
+	/*
+	 * A map value output buffer (e.g. bpf_map_pop_elem) is also a raw
+	 * (uninitialized) memory argument, and like ARG_PTR_TO_MEM it may be
+	 * passed as a PTR_TO_STACK that reaches check_stack_range_initialized().
+	 */
+	return (base_type(type) == ARG_PTR_TO_MEM ||
+		base_type(type) == ARG_PTR_TO_MAP_VALUE) &&
 	       type & MEM_UNINIT;
 }
 
@@ -8403,7 +8407,6 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			verifier_bug(env, "invalid map_ptr to access map->value");
 			return -EFAULT;
 		}
-		meta->raw_mode = arg_type & MEM_UNINIT;
 		err = check_helper_mem_access(env, reg, argno_from_reg(regno), meta->map.ptr->value_size,
 					      arg_type & MEM_WRITE ? BPF_WRITE : BPF_READ,
 					      false, meta);
@@ -8446,7 +8449,6 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		/* The access to this pointer is only checked when we hit the
 		 * next is_mem_size argument below.
 		 */
-		meta->raw_mode = arg_type & MEM_UNINIT;
 		if (arg_type & MEM_FIXED_SIZE) {
 			err = check_helper_mem_access(env, reg, argno_from_reg(regno), fn->arg_size[arg],
 						      arg_type & MEM_WRITE ? BPF_WRITE : BPF_READ,
@@ -8797,26 +8799,19 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 	return -EINVAL;
 }
 
-static bool check_raw_mode_ok(const struct bpf_func_proto *fn)
+static bool check_raw_mode_ok(const struct bpf_func_proto *fn, struct bpf_call_arg_meta *meta)
 {
-	int count = 0;
+	int i;
 
-	if (arg_type_is_raw_mem(fn->arg1_type))
-		count++;
-	if (arg_type_is_raw_mem(fn->arg2_type))
-		count++;
-	if (arg_type_is_raw_mem(fn->arg3_type))
-		count++;
-	if (arg_type_is_raw_mem(fn->arg4_type))
-		count++;
-	if (arg_type_is_raw_mem(fn->arg5_type))
-		count++;
+	for (i = 0; i < ARRAY_SIZE(fn->arg_type); i++) {
+		if (!arg_type_is_raw_mem(fn->arg_type[i]))
+			continue;
+		if (meta->arg_raw_mem.regno)
+			return false;
+		meta->arg_raw_mem.regno = i + 1;
+	}
 
-	/* We only support one arg being in raw mode at the moment,
-	 * which is sufficient for the helper functions we have
-	 * right now.
-	 */
-	return count <= 1;
+	return true;
 }
 
 static bool check_args_pair_invalid(const struct bpf_func_proto *fn, int arg)
@@ -8906,7 +8901,7 @@ static bool check_proto_release_reg(const struct bpf_func_proto *fn, struct bpf_
 
 static int check_func_proto(const struct bpf_func_proto *fn, struct bpf_call_arg_meta *meta)
 {
-	return check_raw_mode_ok(fn) &&
+	return check_raw_mode_ok(fn, meta) &&
 	       check_arg_pair_ok(fn) &&
 	       check_mem_arg_rw_flag_ok(fn) &&
 	       check_proto_release_reg(fn, meta) &&
@@ -10303,8 +10298,9 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 	/* Mark slots with STACK_MISC in case of raw mode, stack offset
 	 * is inferred from register state.
 	 */
-	for (i = 0; i < meta.access_size; i++) {
-		err = check_mem_access(env, insn_idx, regs + meta.regno, argno_from_reg(meta.regno), i, BPF_B,
+	for (i = 0; i < meta.arg_raw_mem.size; i++) {
+		err = check_mem_access(env, insn_idx, regs + meta.arg_raw_mem.regno,
+				       argno_from_reg(meta.arg_raw_mem.regno), i, BPF_B,
 				       BPF_WRITE, -1, false, false);
 		if (err)
 			return err;
-- 
2.52.0

