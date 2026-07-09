Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBAD329C54
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 23:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783638170; cv=none; b=I+i0je7swqSIoUlvV+/eQfgDZs7snufsWeiaOXu7DC9esz0M/+93rqto6fLdZ6r7Eq5qnH0MOQIA/X+6R8/aNu5tAQekqPiShoo3F4UDO2kdYOHZgvN0CLYzzelezj7pk/PbyXAdGqVOsjBEQdcKQVCXEJMeYusXYnZWOfUi5ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783638170; c=relaxed/simple;
	bh=YSJZE3g/rBuD6WlhYeKI2M1yo2ACX+UompJr2cT1Y4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TMHqzHiDFGmPcZCMKK6XcJVKdIXCIg+pACKAQ3WB/Je6N/gP5Q/e/uBdHrE1zrLbK455J4OJiNnKuCbDBPvcMEnoUUmwCe8LY004M3QuZx4Ok3lVVDWLGRxtVWlcjDtfIT4ap1hP5eTe1qecOVRN9hL6Thq3Bw4Ot2umbBW0q9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QPFZx7WN; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPFZx7WN"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-448df16ab34so122491fac.1
        for <bpf@vger.kernel.org>; Thu, 09 Jul 2026 16:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783638168; x=1784242968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JT3s1D6PBFjmR4OU/wnGBNYB+UOz22UZZ3s7B8k65co=;
        b=QPFZx7WNZVX6WOYjo8jannIYP7ohSTVSCuqn0OnOa/u5n4G3wn1RJMZR6Sf9680x2U
         XOahiCCl+e4OseetTEV1FbYjbrBpfEo+tPxdafD9iUJGzN/mKy+3nlRSZWv/F0HrTdVN
         JmMQPJUBijbXQzS2IKpBR/BeTWjuPC9XHBzBzsR4k+IvlQl/kB6kasz6jW3aHmrtrMRt
         duGKlgdD3ISs2+/BrpyGBfxJZJZgEqZ/m4IVFI9lKLS1aDZgufbGewhEKbOXSRlH3Vil
         x/6EWUbOCCY0L6Cve+ITLDBHA4Oly9l5187s3XxJJJT+CmenW+d3sLccMo8IBd6XOD5w
         Tb8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783638168; x=1784242968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JT3s1D6PBFjmR4OU/wnGBNYB+UOz22UZZ3s7B8k65co=;
        b=QZ9hPB+HLitLVrangF5lfS2nbuVnIhJuTsZTlMbNcjdvkPixRWukiY6cDq7E6g1K9j
         Z9MiW3APmEBI86JCd86+A2bfCW0KSieeLoj9eudI0iJRMG4Kp07Hf6JbdvylD8S5JtAm
         Y+Ixmvy5XuYMRgsJV3up5f+qenj1y5Fr8750DOHwHLTZjs0UPg/5v577LoVyxoXmeGG3
         p1+TAyEPXG2vl9kvjs2+P6MmYwV0+8yOvfxaP/pinsWlH5mt07vUk6X2hDnto/h4c3Cl
         YpmVBV/F1Kp8XPl/c7mvvdm/WeLfrTwn3ZN3ymJlIG6yRJKbZo+2aQxwv50vS32jkdzp
         nSiQ==
X-Gm-Message-State: AOJu0YwFzPNgkOXD4d+cjNQCyhDDkRpbjXosqNzTYfpOaZEnNPVZKm6P
	KvCUoTP0md0n+tkv0RwmOKpcfA4YLxRCUaEIBqKdUYXU1idbyV50/OBmFMWNLQ==
X-Gm-Gg: AfdE7cn73clTbXcBqvEu3Ku97mdUliurDSw1WOm5rFBg6WBdquH7sLNe5AzqCEaKNXu
	SQPNZEPXmB4HdQOWjIIT+8xvicdtuI8HPTLpkp1rlwcezgC+8ymvqboAc/vcaah62H641t969PX
	MhI645u3DBZ4DMkHKIDeUjSHMce1OLWkyMaM+pWmuLJ7kLTHYVfrAP6uAuMZHHKTTvEmp+iqViG
	YI/bNsX98sS1DQwFiaYsMqLgGToZjAnVz8q91Ou+30M6Qa8eZrzsTj41YuQ4zBX8Jfb8RqVjeYt
	BuX9+FKOkNIRgJalFv1aeRLCDGV1ogj794c755UfrrhR7sa/QwWcU1ndgLilHQedf6WskKr7bO/
	+iHDCJYJ57tRKZjnCLoTypVEFZmgMWZEeaL2HnoF4e2CNIu+6oMAYUmTySgi+/5W6NjRnVvpA3O
	8gKQ==
X-Received: by 2002:a05:6820:151b:b0:6a0:a791:6885 with SMTP id 006d021491bc7-6a36d9739b1mr6712948eaf.23.1783638167726;
        Thu, 09 Jul 2026 16:02:47 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:3::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a36a5ef513sm5623538eaf.6.2026.07.09.16.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 16:02:47 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 2/4] bpf: Factor out raw_mode-related fields in bpf_call_arg_meta
Date: Thu,  9 Jul 2026 16:02:39 -0700
Message-ID: <20260709230242.2003459-3-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260709230242.2003459-1-ameryhung@gmail.com>
References: <20260709230242.2003459-1-ameryhung@gmail.com>
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

Identify the raw argument once, up front, in check_raw_mode_ok() (
like check_proto_release_reg() does for release_regno), recording its
regno. check_stack_range_initialized() now recognizes the raw buffer by
matching that regno, so the separate raw_mode flag is no longer needed.

Also drop the bogus raw_mode assignment in the ARG_PTR_TO_MAP_VALUE case:
arg_type_is_raw_mem() only matches ARG_PTR_TO_MEM | MEM_UNINIT, and a map
value pointer is handled by check_map_access(), never reaching
check_stack_range_initialized(), so tagging it raw mode had no effect.

No functional change intended. This patch does not enable raw_mode
memory access for kfunc (i.e., uninit stack will not be allowed to be
passed to kfunc for unprivileged programs). Existing kfuncs with arguments
tagged with __uninit are either priviledged or dynptr kfuncs, which take
another path to make sure the access is checked by check_mem_access().

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf_verifier.h | 10 ++++++++
 kernel/bpf/verifier.c        | 50 +++++++++++++++---------------------
 2 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 317e99b9acc0..056b99d26cca 100644
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
@@ -1510,6 +1519,7 @@ struct bpf_kfunc_call_arg_meta {
 	struct bpf_map_desc map;
 	struct bpf_dynptr_desc dynptr;
 	struct ref_obj_desc ref_obj;
+	struct arg_raw_mem_desc arg_raw_mem;
 	u64 mem_size;
 };
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7dd961ede88d..e2a3ed67d2eb 100644
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
 
@@ -8403,7 +8401,6 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			verifier_bug(env, "invalid map_ptr to access map->value");
 			return -EFAULT;
 		}
-		meta->raw_mode = arg_type & MEM_UNINIT;
 		err = check_helper_mem_access(env, reg, argno_from_reg(regno), meta->map.ptr->value_size,
 					      arg_type & MEM_WRITE ? BPF_WRITE : BPF_READ,
 					      false, meta);
@@ -8446,7 +8443,6 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		/* The access to this pointer is only checked when we hit the
 		 * next is_mem_size argument below.
 		 */
-		meta->raw_mode = arg_type & MEM_UNINIT;
 		if (arg_type & MEM_FIXED_SIZE) {
 			err = check_helper_mem_access(env, reg, argno_from_reg(regno), fn->arg_size[arg],
 						      arg_type & MEM_WRITE ? BPF_WRITE : BPF_READ,
@@ -8797,26 +8793,19 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
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
@@ -8906,7 +8895,7 @@ static bool check_proto_release_reg(const struct bpf_func_proto *fn, struct bpf_
 
 static int check_func_proto(const struct bpf_func_proto *fn, struct bpf_call_arg_meta *meta)
 {
-	return check_raw_mode_ok(fn) &&
+	return check_raw_mode_ok(fn, meta) &&
 	       check_arg_pair_ok(fn) &&
 	       check_mem_arg_rw_flag_ok(fn) &&
 	       check_proto_release_reg(fn, meta) &&
@@ -10303,8 +10292,9 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
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

