Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A953C2D
	for <bpf@vger.kernel.org>; Sat, 30 May 2026 00:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780100593; cv=none; b=CWNsBmiNMQ+oEt5DApSAnDsGvEnx68IPCz1wzeiGyLy1t2qDiDUEjEiTXNzSJpHfMCXwW/1atVvrBBB2aKIwHod1JSul9NEgwnmqA4z0vMyJhh+k8uX0vaO0/OyIMLSr2h6chZR+dSb4zsU5YigYsNrd8rz1JS330mAZZSnbBmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780100593; c=relaxed/simple;
	bh=xTxUuGOW34iZxNq+Q2spM+WwD6875m9PcyTaGIfTv2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TW/zyNXFpBZdV3ehBue/1cdiPf/vzCYhYWDPVYwlCyZgVte80zejy3c+YqDGZqdO9QSmdNebIxl7CUEbibBMQK8Rn2132q2cvw0AZ3vXj0D5a7wV+kX4drvTD5LfsgT+eyn/RfA641CBkrI2r9lez2yGAMQwPMmufGyvLrcAu5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=DgrRUNYZ; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="DgrRUNYZ"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-137c928ec7bso2317897c88.1
        for <bpf@vger.kernel.org>; Fri, 29 May 2026 17:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1780100591; x=1780705391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WdC753mwRfDP3WBreP0c/F74I9jkwTFmAuqP081M2BY=;
        b=DgrRUNYZzJUEz6tAFf4XGuUnw+0CDe8fyM8XwMNhTB6PRmfunn6wk263FYUojC5nJY
         NqzDRlKcINxCqLEbrZpK9HHREYEbHzHaWR77Rm5ihpmoEXd75gWgutbYqbvclrvqVtK+
         9pPM/pwujFR8/+NNr2dcIE5nf4MAh0wJCpTDLw8Ji8oDsOYwz9DDZDT+d0GzI3z5Y4lU
         DjAdbBsttL56K2ofVd3WayhDY4u3hMZYE9J/gftKisWU8Q2RkeT3yJSueNj83zqmyHeS
         8YNAexEqrcLQvDWOP4uiTJ9okOl17Wteqv8HukCP0J0ZWOhgRVu4vDMslWSaYLcMk+4P
         2YEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780100591; x=1780705391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WdC753mwRfDP3WBreP0c/F74I9jkwTFmAuqP081M2BY=;
        b=E8b6Xr/wxNjfFPoYQxBquzu+b9m0XA467ugYK3iJrxy9BS/aem53WDjES8qi9PdocC
         AEmgzmdgDZno2biZiaY0EyAfNFTZHuogAitP1G7r5uGGlbh3m7tdc8sKkXXR1XAkaPwA
         rFPFr2rPPdawMwjs9jif4UfP6j4rRMDFla9dBt09lWb9SmzSu8f2pjeMO6E5d20j5v6s
         xtg5QCV2Hn7JHD0KDg4vTMyENUs1RIm5Rez+18JmSJKmussBV/H6FMg59cX35UP1Yeh6
         7fRz3r0+wXoeXzXrDwvMHjTG7T/brLm1RgNPrNzvQEw3JbBZHqUlm8CbfDZsskYjeCSi
         OEAA==
X-Gm-Message-State: AOJu0YxLSOnE1B/nS/cMpIb6NzzosBEErIK4IFrk8D20L0pDsEA3vGlM
	5SJiE6h2bYn754TiecSAZ/Wne3DGZFdbbWgRmMxApffaDvSeXP1MtoNap9zoxOb67TjMfZCEG4r
	PTKe2hy1FFGYi
X-Gm-Gg: Acq92OHsJJ/rfzeyKmUD7geV4kB1DJzl+yBvguvuQVgVGv9IRN7HvZmwF6zqTQl6XZ+
	dv/h2z3GKjFdmsaFaR46BUslJjl3jI/cVvFWp2Gh9VI1x7GyzbkXyuq/4AMWjp9UVudLlAqu2Dy
	nMwo7gpKScQ5iL2Yk3Ko9nWKhmsA9nLK4s3+B7DnwUCiuwEq4Oxit0GhZHxVIQ0jxw4S0fvSUQ6
	Wsg+kFk8v0BKIX4c0hrDetNv6MYk81ULIXe7rgicQQC7RUYBSoAX3cynGiDhEfCvvhzeyQgDVUg
	qnEN8fCiMcVJmKuar0z0436+lcz5Sh3OOS4weHfWOP4eIo7W0BZMxJjWOiyAanXnvEVo1jz4PYL
	Fnuaz8GqclObmR2VtIv9HdtcMJzutPbHy4Ut5czvshtUN30aiqiNZfiAhBJllFKIL42rjrgGx4v
	HT1sD2wiPDl1kJVGdJGXUbega6WIiCBD7QKPoX8CGn
X-Received: by 2002:a05:7022:619f:b0:137:6781:7dd7 with SMTP id a92af1059eb24-137d4271679mr717440c88.20.1780100590921;
        Fri, 29 May 2026 17:23:10 -0700 (PDT)
Received: from krios.corp.tfbnw.net ([2620:10d:c090:600::9529])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137b35a5f44sm2070540c88.1.2026.05.29.17.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 17:23:10 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	song@kernel.org,
	mattbobrowski@google.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v2 3/5] bpf: Allow subprogs to return arena pointers
Date: Fri, 29 May 2026 20:22:57 -0400
Message-ID: <20260530002259.4505-4-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260530002259.4505-1-emil@etsalapatis.com>
References: <20260530002259.4505-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BPF subprogs currently only return void or scalar values. However,
it is also safe to return arena pointers between subprogs in the same
BPF program: Arena pointers are guaranteed to be safe for both programs
at any point. Expand the verifier to permit returning an arena pointer
to the caller.

The main subprog is still not allowed to return an arena pointer because
arena pointers are internal to the BPF program, and the return values
permitted for each main subprog depend on the program type anyway.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 kernel/bpf/btf.c      | 50 +++++++++++++++++++++++++++++++++----------
 kernel/bpf/verifier.c |  6 +++++-
 2 files changed, 44 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index c6a930aca67e..7a8101879f84 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7880,6 +7880,36 @@ static int btf_scan_type_tags(struct bpf_verifier_env *env,
 	return 0;
 }
 
+/* Check whether the type is a valid return type. */
+static int btf_validate_return_type(struct bpf_verifier_env *env, struct btf *btf,
+		const struct btf_type *t, int subprog)
+{
+	u32 tags = 0;
+	int err;
+
+	err = btf_scan_type_tags(env, btf, t->type, &tags);
+	if (err)
+		return err;
+	t = btf_type_by_id(btf, t->type);
+
+	while (btf_type_is_modifier(t))
+		t = btf_type_by_id(btf, t->type);
+
+	/*
+	 * We allow all subprogs except for the main one to return any kind of arena pointer.
+	 * General arena variables are not allowed, since it makes no sense to return by value
+	 * a variable that's on the heap in the first place.
+	 */
+	if (subprog && (tags & ARG_TAG_ARENA) && btf_type_is_ptr(t))
+		return 0;
+
+	/* We always accept void or scalars. */
+	if (btf_type_is_void(t) || btf_type_is_int(t) || btf_is_any_enum(t))
+		return 0;
+
+	return -EOPNOTSUPP;
+}
+
 /* Process BTF of a function to produce high-level expectation of function
  * arguments (like ARG_PTR_TO_CTX, or ARG_PTR_TO_MEM, etc). This information
  * is cached in subprog info for reuse.
@@ -7963,17 +7993,15 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
 			tname, nargs, MAX_BPF_FUNC_REG_ARGS);
 		return -EINVAL;
 	}
-	/* check that function is void or returns int, exception cb also requires this */
-	t = btf_type_by_id(btf, t->type);
-	while (btf_type_is_modifier(t))
-		t = btf_type_by_id(btf, t->type);
-	if (!btf_type_is_void(t) && !btf_type_is_int(t) && !btf_is_any_enum(t)) {
-		if (!is_global)
-			return -EINVAL;
-		bpf_log(log,
-			"Global function %s() return value not void or scalar. "
-			"Only those are supported.\n",
-			tname);
+
+	err = btf_validate_return_type(env, btf, t, subprog);
+	if (err) {
+		if (is_global) {
+			bpf_log(log,
+				"Global function %s() return value not void or scalar. "
+				"Only those are supported.\n",
+				tname);
+		}
 		return -EINVAL;
 	}
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c8d980fdd709..64d7954e93ea 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9375,7 +9375,7 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		clear_caller_saved_regs(env, caller->regs);
 		invalidate_outgoing_stack_args(env, cur_func(env));
 
-		/* All non-void global functions return a 64-bit SCALAR_VALUE. */
+		/* All non-void global functions return a 64-bit SCALAR_VALUE or PTR_TO_ARENA. */
 		if (!subprog_returns_void(env, subprog)) {
 			mark_reg_unknown(env, caller->regs, BPF_REG_0);
 			caller->regs[BPF_REG_0].subreg_def = DEF_NOT_SUBREG;
@@ -16645,6 +16645,10 @@ static int check_global_subprog_return_code(struct bpf_verifier_env *env)
 	if (err)
 		return err;
 
+	/* Pointers to arena are safe to pass between subprograms. */
+	if (is_arena_reg(env, BPF_REG_0))
+		return 0;
+
 	if (is_pointer_value(env, BPF_REG_0)) {
 		verbose(env, "R%d leaks addr as return value\n", BPF_REG_0);
 		return -EACCES;
-- 
2.54.0

