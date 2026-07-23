Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8227E31ED68
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 05:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784783299; cv=none; b=H+wB6ftCNCE20Gcy3ODlzoUPJ14Sx2uP+xUxXWh6o8H8miWbyuUdKqhmPlt80MySs5V3FVf6mBxEcf89VZ3KzTDPvRjlr1TIkkEoPegkLq5wYO14h4Tdf+tKCfz3Dq9UlDevu9WjqNNtAWXRbKTsIBrPdpwcJpnarmzK1TnQkes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784783299; c=relaxed/simple;
	bh=4HyOePhWlFxUlHREXyE0HsyMRn/fRZ9bOmBh3xg1MtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xkbpa8oO3eBWsIJ1sVydopN4TOTmmmbjtVvajGJXoeQ/JWRF5CVWYVlp3wsDFFJaZbstK2Sxorcn7P4V4JGaUslk09hojitguk9PGnErfP3UwU/AeUix3JQEYDPdx6TbeHfV1RlTySCeKBPjuzvxH0dG7LfkrRtkjntmjyTRS74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oUMU5QV7; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oUMU5QV7"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ccf2360620so2195115ad.3
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 22:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784783298; x=1785388098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M4DqLofGujmz08wTCy8PcqDd7a2CQa8bxThve0fY4ug=;
        b=oUMU5QV7gyiGppL3A55RAnqFhXoVhQL99QsshguiABPv5deGIG2Lfm40F1LHUv9EGt
         zBQ370iG8sFPHTeZ60xgeq9x+3Y1P8gIwFK6LyuxRXBIxY7jQUaTWIM22ER8bon4ZL7/
         vwRjBU4yfe0SiH1SlbhDs+RZtc04kTflWtTvnha+t8Q24zf5ZflNpxOLMabGoo+q6V7p
         ctxA3UvHGEiXlDb6Rjtf/wsoHh5UXaKytd8jt3u3CUPfhEuNXuZ35ExXtk+OdIsUSx/o
         e+ozMARznIBwUAoNnAI94IUKu+BC6CXGs1BcBV/OUSSC1fLVW9iv5jFKm8TTZaqbT9Fy
         G6Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784783298; x=1785388098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=M4DqLofGujmz08wTCy8PcqDd7a2CQa8bxThve0fY4ug=;
        b=PmYOEcjyeIvw4CuxC1mH62y8AxWQwL1lAhBNGqF54FOBYKx4NNtkLpqgYBnMc2lyn/
         Xjc393K5b0CmvcYhIuxrOAWoIzn75+gdpBInpwWGbK+YFrE3JPF4RRBlvdFhC8KSluLX
         qO93hAZPZdWt35/uqyzObqCbF8YssHz3pxktDhILgD1eGJBpfYI2qthyM9NYN0CH/crT
         dYw9uL0tCd2CiO5Gqve8otQPzQoICYD4DPr7c0lkOlQJTqC0Zwjd2Nnjn9QOsjBAsFiq
         gh6b9j6VytnvW6nVmB51CB7luan+IVcxBOSK1y4Hi2jQ4M7QDUdHPlP7D2p3dBjHDU6f
         y2mQ==
X-Gm-Message-State: AOJu0YxBq3QE8vyPAK1BGVaIVOYyAg90ajm99EuvK52D+I/4fa8wF6AS
	UDDV4lbph4tprZpZ44U1+1vRHYduT9YPdZYxo6i73EqDtU7gt5LHF+67OGL2rQ==
X-Gm-Gg: AR+sD12K3ok2tEjSj6NbPShOEwPnCONaT6RiDodYJHnQSNubckFY4YQUvUCE/fE50RW
	MTesOXc8XhnkWgL81WcDUcmVdHuUPkQsWkHMSFCpVC/uOuqyj4ruzbmGPHgQHqoIFnBpj55kQEa
	q7k8l2k+5c+iWXMzbcyBrJGidYqcrWnQZvzrsnT/BDnp+41DGtCXI1APX4qXhjwZRJ690ZifSHe
	eyJwTX2m3HSnJL8ivLg44UeUroFGSsIYNFOHpFujwFwX2+gLX8gb7GLF3a/E13s8zosd8cs2JA9
	tYCpz3sRn+Y+n6ADngk5knMn9/orssV1j1dTahKH7GP573e2PPlWzENCNMFqlBxgVVYAEaAiLRz
	qXb7sMZMj3IE93RuxKvIZsZHE8TTIeVeWSo6Fn8p05PNXE/SG2+XuPiATHzmsoMZr6oUg
X-Received: by 2002:a17:903:22d0:b0:2ca:281:27f9 with SMTP id d9443c01a7336-2cfa6c56631mr19532095ad.27.1784783297950;
        Wed, 22 Jul 2026 22:08:17 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:73::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8efdbfd0sm25956975ad.21.2026.07.22.22.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 22:08:17 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 07/18] bpf: Check fixed-size mem args of helpers and kfuncs the same way
Date: Wed, 22 Jul 2026 22:07:55 -0700
Message-ID: <20260723050806.1158442-8-ameryhung@gmail.com>
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

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6520742d51b5..be5d93c0da81 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6941,11 +6941,14 @@ static int check_mem_size_reg(struct bpf_verifier_env *env,
 }
 
 static int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
-			 argno_t argno, u32 mem_size, struct bpf_call_arg_meta *meta)
+			 argno_t argno, u32 mem_size, enum bpf_access_type access_type,
+			 struct bpf_call_arg_meta *meta)
 {
+	/* meta->btf is set only for kfuncs; a NULL meta means a global subprog. */
+	bool helper = meta && !meta->btf;
 	bool may_be_null = type_may_be_null(reg->type);
 	struct bpf_reg_state saved_reg;
-	int err;
+	int size, err = 0;
 
 	if (bpf_register_is_null(reg))
 		return 0;
@@ -6965,10 +6968,12 @@ static int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg
 		mark_ptr_not_null_reg(reg);
 	}
 
-	int size = base_type(reg->type) == PTR_TO_STACK ? -(int)mem_size : mem_size;
+	size = (!helper && base_type(reg->type) == PTR_TO_STACK) ? -(int)mem_size : mem_size;
 
-	err = check_helper_mem_access(env, reg, argno, size, BPF_READ, true, meta);
-	err = err ?: check_helper_mem_access(env, reg, argno, size, BPF_WRITE, true, meta);
+	if (access_type & BPF_READ)
+		err = check_helper_mem_access(env, reg, argno, size, BPF_READ, true, meta);
+	if (!err && (access_type & BPF_WRITE))
+		err = check_helper_mem_access(env, reg, argno, size, BPF_WRITE, true, meta);
 
 	if (may_be_null)
 		*reg = saved_reg;
@@ -8483,9 +8488,8 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
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
@@ -9257,7 +9261,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 			ret = check_func_arg_reg_off(env, reg, argno, ARG_DONTCARE);
 			if (ret < 0)
 				return ret;
-			if (check_mem_reg(env, reg, argno, arg->mem_size, NULL))
+			if (check_mem_reg(env, reg, argno, arg->mem_size, BPF_READ | BPF_WRITE, NULL))
 				return -EINVAL;
 			if (!(arg->arg_type & PTR_MAYBE_NULL) && (reg->type & PTR_MAYBE_NULL)) {
 				bpf_log(log, "%s is expected to be non-NULL\n",
@@ -12403,7 +12407,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
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

