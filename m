Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9FB25D53B
	for <bpf@vger.kernel.org>; Sat,  1 Aug 2026 07:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785570411; cv=none; b=p6kYwji98P+876alJfbGZRF2XHYbvtXQkSHkJ95D8yz7PBC0/Y8W0nIzYmdHl8z6lP2IqsV3+5CPKJHVzkrmNSluO/5zSF1G1FutjcF8aH/G1X4hRWsP9VXzbD2LDUoUEXYByXCoDpbe6GS2bRwxPCpnG3xEyfQxTzv6qtDhNf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785570411; c=relaxed/simple;
	bh=sAOBY3lMsG/VSnNpOOS6RV5gvvsj3lHwZGRJA7ygHEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ag3b/4Ox7CIFZ61lzvI8ssGBtTv2enJJVjg8S0w6LouLVrkWlXQhyrw402TVSwk7KWZlD8MYe6VJfP2bfI2IZep0jzJx53ZqKhsa0wykf2NxZSXoxZU11uPvNFGKf3RY5No4/6X7mudGfHQrKyzNc4D887HnfXl4giRBZc6+e0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OkEzB208; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OkEzB208"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-ca766c1c9ccso996727a12.0
        for <bpf@vger.kernel.org>; Sat, 01 Aug 2026 00:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785570409; x=1786175209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E/Q/t5Oe85IlCuMFlB37C6PXpvLcTIEfO2XLq0Y3ClQ=;
        b=OkEzB208OhSYjjbjSVfrkFw2KSnPLb+5s8ZtWz0svdA//rJpiXzuMnauTBfcDtM+Sz
         DvM3RYEeu6eaNaXumORCFfJf7HyPU0ORd+unw5QNVivc/wLnWv1nLIZ8xyTWFMz0FxxD
         ZUiT3bsbUi+Lm/tsDhLz8Jp3x7HSFQp1t2vKUDjKGMuMT1pa/vw46meJ2P508hxJW5wG
         zqhDEcRgRQgR55S8HsVrCWFxItJ70Rv3V82fP52i+0brbPjtiUHy8abhujEOdiP/HpZy
         t4g3unQWAvCWY5rz6eNvynonILeFat6tXF16uxB3PrfdlFEDqu7X8cetcgYLMRspbmDu
         vB4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785570409; x=1786175209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=E/Q/t5Oe85IlCuMFlB37C6PXpvLcTIEfO2XLq0Y3ClQ=;
        b=aJG4Amat0tiZwpJW22s4xZxzBOAQkbq2JOfDNc7plrSuHEx40Z391TAn92kKsMNL0D
         ocF6kbXGcn68DGFYjrd5RJZU18ShAz/xSLBs2WImhZ+BlxxRrZkfLSNFkz0khbsQnNw7
         GYu4jW0wdHevCj0uL8nkjlJPWoX5Surr02y64m1xqFsnlabe5H9RrGRFD+tj4o5MLdSN
         lsneYa/e8mDAPsOad5PNVbQR0PlTsyk0n36XxqmSQrcboi+B5ahcMCB2qOaF8dnQwHsP
         guxtFG6JvmRdNC9680rZHzsrk5hQUIk4aFFvKbFqvCxkhOY/Wm0gD4dv1Jic06CmoUh+
         oUVg==
X-Gm-Message-State: AOJu0Yx/MT6Pq/XDdJSaoCFmT76aA3rRCvH/Y+2jJD0e67QEMyk5lBFN
	kEC19Q86q6QQiHl3ei135MVMO2rMFIblnyC4U322MSPhfydyYKQLtEsjNzEqcw==
X-Gm-Gg: AR+sD11+ix+0aJqDktkh0fROQ5I/9xyVukQQ1Vw0662GeqhfYXXtdV9g+qYFdUj+5PV
	WmRlPJ+79iuH3NSEpo4w1JVz+H4t4AGqVJoiZ4j1ALJotiyc9424JhM2Eml7xuOEYA/os5CqBcD
	B/RxntZkc/ureauO7+5nhlW90BnEn4rMwFKVKYh05oQgy53kuglN+VaaOlCVqLD9Dp3pXRc3ZGm
	9CcTRZRqfstjU1/ZynQlHsg1lmEv464CBq59Ih/O6+MadmlKyrJHBW3vzu7Tt+nqOyyZyPV0MeG
	Tdu8Bso1RFWaT4b0t4x6gOVikluJDGml3rbLkxCCd4W7sg11LWusI073J9K8uRsOcF+SCn/lYC0
	c4P7Qba2aJfzYPsUweVikASbIh46Q+TF1dFGwhg5bXW07VitjxNlH1NnthJ4yjtSrqnoj6gyqlW
	OPRaARNb8b0/dtgOmzlp4vGc8St/r5RNMA3AVhmD10Y+2AwbYiRiI=
X-Received: by 2002:a05:6a00:4b43:b0:845:e9ff:5d97 with SMTP id d2e1a72fcca58-84ee4812b75mr2093707b3a.12.1785570408997;
        Sat, 01 Aug 2026 00:46:48 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4a::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edbd3a4b6sm1395550b3a.4.2026.08.01.00.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 00:46:48 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 08/18] bpf: Check fixed-size mem args of helpers and kfuncs the same way
Date: Sat,  1 Aug 2026 00:46:23 -0700
Message-ID: <20260801074633.1595644-9-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260801074633.1595644-1-ameryhung@gmail.com>
References: <20260801074633.1595644-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed-size memory arguments went through two paths: helpers called
check_helper_mem_access() directly, while kfuncs and global subprogs
used check_mem_reg(). Route the helper MEM_FIXED_SIZE case through
check_mem_reg() too so all three share the same check.

This also fixes a bug in the helper path. When passing a NULL to
PTR_MAYBE_NULL | ARG_PTR_TO_FIXED_SIZE_MEM argument, the program would
be falsely rejected by check_helper_mem_access(). This is not
triggerable since there is no such kind of helper. Also, note that
check_reg_type() still make sure NULL cannot be passed to an argument
not marked with PTR_MAYBE_NULL.

It also tightens the poisoned-stack-slot check. check_mem_reg() encoded
"a STACK_POISON slot may be read" as a negative access size for any
PTR_TO_STACK argument, but that is only sound for global subprogs, where
static stack liveness proved the callee body does not read those slots
(2cb27158adb3 ("bpf: poison dead stack slots")). Since check_mem_reg() is
also used for kfuncs, kfuncs accidentally inherited it and could read a
poisoned (dead, possibly uninitialized) stack slot. Restrict the negative
size to global subprogs (meta == NULL) so kfuncs, like helpers, require
the whole argument initialized.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index cb805bc97604..e1d4820d19ff 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6669,7 +6669,7 @@ static int check_stack_range_initialized(
 	 */
 	bool clobber = type == BPF_WRITE;
 	/*
-	 * Negative access_size signals global subprog/kfunc arg check where
+	 * Negative access_size signals global subprog arg check where
 	 * STACK_POISON slots are acceptable. static stack liveness
 	 * might have determined that subprog doesn't read them,
 	 * but BTF based global subprog validation isn't accurate enough.
@@ -6933,9 +6933,10 @@ static int check_mem_size_reg(struct bpf_verifier_env *env,
 }
 
 static int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
-			 argno_t argno, u32 mem_size, struct bpf_call_arg_meta *meta)
+			 argno_t argno, u32 mem_size, enum bpf_access_type access_type,
+			 struct bpf_call_arg_meta *meta)
 {
-	int err;
+	int size, err = 0;
 
 	if (bpf_register_is_null(reg))
 		return 0;
@@ -6946,10 +6947,16 @@ static int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg
 		return -EACCES;
 	}
 
-	int size = base_type(reg->type) == PTR_TO_STACK ? -(int)mem_size : mem_size;
+	/*
+	 * Only a global subprog (meta == NULL) may read poisoned stack slots:
+	 * its static stack liveness proved the callee body skips them.
+	 */
+	size = (!meta && base_type(reg->type) == PTR_TO_STACK) ? -(int)mem_size : mem_size;
 
-	err = check_helper_mem_access(env, reg, argno, size, BPF_READ, true, meta);
-	err = err ?: check_helper_mem_access(env, reg, argno, size, BPF_WRITE, true, meta);
+	if (access_type & BPF_READ)
+		err = check_helper_mem_access(env, reg, argno, size, BPF_READ, true, meta);
+	if (!err && (access_type & BPF_WRITE))
+		err = check_helper_mem_access(env, reg, argno, size, BPF_WRITE, true, meta);
 
 	return err;
 }
@@ -8455,9 +8462,8 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		 * next is_mem_size argument below.
 		 */
 		if (arg_type & MEM_FIXED_SIZE) {
-			err = check_helper_mem_access(env, reg, argno, fn->arg_size[arg],
-						      arg_type & MEM_WRITE ? BPF_WRITE : BPF_READ,
-						      false, meta);
+			err = check_mem_reg(env, reg, argno_from_reg(regno), fn->arg_size[arg],
+					    arg_type & MEM_WRITE ? BPF_WRITE : BPF_READ, meta);
 			if (err)
 				return err;
 			if (arg_type & MEM_ALIGNED)
@@ -9229,7 +9235,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 			ret = check_func_arg_reg_off(env, reg, argno, ARG_DONTCARE);
 			if (ret < 0)
 				return ret;
-			if (check_mem_reg(env, reg, argno, arg->mem_size, NULL))
+			if (check_mem_reg(env, reg, argno, arg->mem_size, BPF_READ | BPF_WRITE, NULL))
 				return -EINVAL;
 			if (!(arg->arg_type & PTR_MAYBE_NULL) &&
 			    (type_may_be_null(reg->type) || bpf_register_is_null(reg))) {
@@ -12379,7 +12385,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 					ref_tname, PTR_ERR(resolve_ret));
 				return -EINVAL;
 			}
-			ret = check_mem_reg(env, reg, argno, type_size, meta);
+			ret = check_mem_reg(env, reg, argno, type_size, BPF_READ | BPF_WRITE, meta);
 			if (ret < 0)
 				return ret;
 			break;
-- 
2.52.0

