Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5779D3FC5CC
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 09:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783501343; cv=none; b=RDDwQFqB0egQ3qfUNqxQKkJmPlGXg55HypaoWz7P9UDHPkutDrQCHm/ZKqFTyCxxAafQKrBp5lHCNLewyp1gdkbEI3IpZc0dY4Nzc80tYVhBl2uNBXfir7rrS0wBzY5e3YoEJVnJFEZjGssZuhN+SUqTC01OEir8ovFIpWHH99o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783501343; c=relaxed/simple;
	bh=bHWXqygn5s9sdyxCIh4Jm+Z9uvZV1D9ZipD3thyoL2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xj2zoTIaUvO3IXbQ/DCGDxVaKk1Qjqb77a/rPqPKzq9oXwKAQ5/hskpiplAOHjv+OkFeZngRBuLXPlei4NRRDGx3d+MZvtdoFfSCPRAceE6UvTT7gPTAp3i/JG5MkQdJEBhbvuTFlbh7oVdX8jSSOQbhZwiuyy8EUdJenUzBupw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c1yLFKnH; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c1yLFKnH"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-381b831d535so566631a91.0
        for <bpf@vger.kernel.org>; Wed, 08 Jul 2026 02:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783501341; x=1784106141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SAADf0PxLEf8SBsG4zFMkckYY7+WHsHRBHPNP6wI940=;
        b=c1yLFKnHANHlZekw9qwzW2Svd9D7ORLvvy7RnOD29sXQ/4zRH+ZF0ZkoocLmwTHxya
         Ve74FudEFWp7nCxyLi/9KQkL8pdeKY1u6iZaMN30B3Zi3gRSvbyG8PV48IWrmJh25uaf
         nlAZOxcVp5POdUp/je0hq7MU3RS+uUlla9fI99TAFin8yqz/9gJLVvggp587fPPYkvyc
         cyAugxwavKB/VV1ZzKLGiMDfi0o8ikcPsGfjf+H3pfH/394odNAGMyKQ5RV8i0VfS5wF
         FAGvLCAUJAbaZjnZaPM/KtEx6s/Vvh4x7bHpPPnNoUVo8e5eN5q2YbNeVXN8pxS5jo8c
         nrPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783501341; x=1784106141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SAADf0PxLEf8SBsG4zFMkckYY7+WHsHRBHPNP6wI940=;
        b=gSDPJikgLAYZTAAA6jZ8vRN+P40b+Yw05MbzFRxITaOYPF3hTyJjLW2BHsATucrdVh
         nQk5YzvhfJJZcQZI50LHyaSdR7UghhXArMtMm1Qx7T2kD3s5JSubfSTAAW/LHWuoKnIu
         5vtWS8Z5rEkpgYilb3SkJJ3FKQba1fxlNc2fNX1K9lAEWtvG8FP0ewmzEYQt6UzSRRV3
         XzTHL8S8FjzMehTQ4sTAz6r4i6cR88c6vUzUQvdd4jKyGHODn/tD7eK3pNziur+YPohB
         wwG3EzASLFzfYVtv0iQWlp1hViWLEZcyU6nqZjGn2AoFvqmL5fQgsnTWd63eA2V8V4Hl
         cZCQ==
X-Gm-Message-State: AOJu0YyMBvJ/x/t/OZkqDTISxX4pvL8+mBkauwBZsgomaJw9JHlfUOiT
	4HvAFp0uUpTDLvbCCk3n6h5oOUwPFHMQufzmIfPLdCZW/aOi85Azt9JC2o6QSBZ6/tKIMg==
X-Gm-Gg: AfdE7cmlZ0DL121uKacpLGEEHaCTEDL/GEhNMZN2cihy9z2AcFY+Q9S9FV06WIYx0lp
	sto4D/O5jF26lMzZ2x2Y/7DJ3/l/uKWWOh+KLsqjxqxzCikCMAjJ0cJeZRCF5LfRPuJpfBbV8Nf
	8qJ3JKSevmxWrasCKrYtVRQCY+aJ/d+obUuIq20VdgncXkkomTn3SM2We2nj9iqtXUTfDr4dGWK
	yS5uQL8iYRuBHEoGyg4fuu0Rou0L1AayHVYs5Dqik4egJxJRpl5Lr8ys0j250VE/Bmq7KJiXk9E
	vOxO+PkXiqxCyS7p9DsSE2YM3AzewIqwLz+q4kKtgBpOM2MBZGcqREO4hzbyi5bjZ3/tbJetSie
	DJdy3kNrrLqHDICqsHoJkGebafy0ZXdq0cz6eq9+gKdgSjIxkBUjgQWc9gNW106x71pIblhWAnk
	N/7sU2YKhmb3MSxorxh3r+AUzTEzsdxggwdALo1cLFRxRdpf1EJGposJSE//tdLNXEMGjhELUWD
	LfgXbUNeMgrVR6oAWWsb2k81aujEwO82g==
X-Received: by 2002:a17:90b:2803:b0:381:abcc:c8e9 with SMTP id 98e67ed59e1d1-3893fd5f5b7mr1562072a91.7.1783501340571;
        Wed, 08 Jul 2026 02:02:20 -0700 (PDT)
Received: from u2404-VMware-Virtual-Platform.tailf6b5e0.ts.net ([24.4.24.156])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174accb0esm19515493eec.30.2026.07.08.02.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 02:02:20 -0700 (PDT)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	shuah@kernel.org,
	mmullins@fb.com,
	shung-hsi.yu@suse.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH bpf v4 1/2] bpf: Reject negative const offsets for buffer pointers
Date: Wed,  8 Jul 2026 02:01:50 -0700
Message-ID: <20260708090151.151729-2-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260708090151.151729-1-sun.jian.kdev@gmail.com>
References: <20260708090151.151729-1-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The verifier rejects variable offsets for PTR_TO_TP_BUFFER and PTR_TO_BUF
accesses, but it currently accepts a constant negative offset produced by
pointer arithmetic.

For example, a raw tracepoint writable program can load ctx[0] as a
PTR_TO_TP_BUFFER, move it by -8, and then access the adjusted pointer.
The access is before the tracepoint writable buffer base and should be
rejected.

Keep rejecting negative instruction offsets explicitly. Once the register
offset is known to be constant, reject const var_off values outside the
same +/-BPF_MAX_VAR_OFF range used by other verifier pointer offset
checks before computing the effective access range.

Fixes: 022ac0750883 ("bpf: use reg->var_off instead of reg->off for pointers")
Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 kernel/bpf/verifier.c | 40 ++++++++++++++++++++++++++++++++++------
 1 file changed, 34 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 21a365d436a5..6fe4fcf93e5f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5326,14 +5326,18 @@ static int check_max_stack_depth(struct bpf_verifier_env *env)
 static int __check_buffer_access(struct bpf_verifier_env *env,
 				 const char *buf_info,
 				 const struct bpf_reg_state *reg,
-				 argno_t argno, int off, int size)
+				 argno_t argno, int off, int size,
+				 u32 *access_end)
 {
+	s64 start, var_off;
+
 	if (off < 0) {
 		verbose(env,
 			"%s invalid %s buffer access: off=%d, size=%d\n",
 			reg_arg_name(env, argno), buf_info, off, size);
 		return -EACCES;
 	}
+
 	if (!tnum_is_const(reg->var_off)) {
 		char tn_buf[48];
 
@@ -5344,6 +5348,29 @@ static int __check_buffer_access(struct bpf_verifier_env *env,
 		return -EACCES;
 	}
 
+	var_off = (s64)reg->var_off.value;
+	if (var_off >= BPF_MAX_VAR_OFF || var_off <= -BPF_MAX_VAR_OFF) {
+		verbose(env, "%s %s buffer offset %lld is not allowed\n",
+			reg_arg_name(env, argno), buf_info, var_off);
+		return -EACCES;
+	}
+
+	start = var_off + off;
+	if (start < 0) {
+		verbose(env,
+			"%s invalid negative %s buffer offset: off=%d, var_off=%lld\n",
+			reg_arg_name(env, argno), buf_info, off, var_off);
+		return -EACCES;
+	}
+
+	if (size < 0) {
+		verbose(env, "%s invalid %s buffer access: off=%lld, size=%d\n",
+			reg_arg_name(env, argno), buf_info, start, size);
+		return -EACCES;
+	}
+
+	*access_end = (u32)start + (u32)size;
+
 	return 0;
 }
 
@@ -5351,14 +5378,14 @@ static int check_tp_buffer_access(struct bpf_verifier_env *env,
 				  const struct bpf_reg_state *reg,
 				  argno_t argno, int off, int size)
 {
+	u32 access_end;
 	int err;
 
-	err = __check_buffer_access(env, "tracepoint", reg, argno, off, size);
+	err = __check_buffer_access(env, "tracepoint", reg, argno, off, size, &access_end);
 	if (err)
 		return err;
 
-	env->prog->aux->max_tp_access = max(reg->var_off.value + off + size,
-					    env->prog->aux->max_tp_access);
+	env->prog->aux->max_tp_access = max(access_end, env->prog->aux->max_tp_access);
 
 	return 0;
 }
@@ -5370,13 +5397,14 @@ static int check_buffer_access(struct bpf_verifier_env *env,
 			       u32 *max_access)
 {
 	const char *buf_info = type_is_rdonly_mem(reg->type) ? "rdonly" : "rdwr";
+	u32 access_end;
 	int err;
 
-	err = __check_buffer_access(env, buf_info, reg, argno, off, size);
+	err = __check_buffer_access(env, buf_info, reg, argno, off, size, &access_end);
 	if (err)
 		return err;
 
-	*max_access = max(reg->var_off.value + off + size, *max_access);
+	*max_access = max(access_end, *max_access);
 
 	return 0;
 }
-- 
2.43.0

