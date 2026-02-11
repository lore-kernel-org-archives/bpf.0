Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968E334FF45
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 22:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770849121; cv=none; b=J11otNvn2fJDw/rbXKG2NjuFaDQQ19St5Eaq25no+msLGZkD217jMHIm1l1UgprJSPl2v6+X3/juNO4VllIKLhH3veui/YQQEAFwD+rVxIRusQ3VrHEbZb63cz3u1wTrcR1Eacuym1QXRyLkfUM2tq0/nN3i5oIDImxWx5z7wtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770849121; c=relaxed/simple;
	bh=PWcsGkkBas/kitkyh/QQxkct7fNFJh5foQKYS8edH48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mGXbvYYYFMo1CEcaGgoZ4wLeYY8wtlIvy4pBxzYSXP/aTC3QfYj5gFWarvbaI8uVhVYQ0DIjZq2sR2x3mhHC4cpTtHMz4yeTX7MUq1Ls8V6em4SB47Mt15ujOsBsgCd5PAfcUpjNgYZWleskPu+s60YohmuAvDgwcuVWSOxz6xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ktg4rMeB; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ktg4rMeB"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2baa6ec5638so291133eec.0
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 14:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770849119; x=1771453919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ljU8FyYrq629B/3hbVIvRNnIg24HIn2TxWfUdn1jDAw=;
        b=Ktg4rMeBjoMegqkLBoxnswRVjqp5aDDw1Ah97dwq1kHOw0IxdIVboyNm1/oaji6aFz
         j8lmM6ftidVe6k12YPd3kFF+RiO78pDArYNB1Ht0Qf44XYlkPUgimMl/NDESuenP8Z+u
         LhJTtERTv1zDSQLwfjuQl9M/osZ7ANjkGFMvWX8BAlWhn3DY4wotKeCPWQe3Gqh/AF3D
         2/Jo8tIWzTy0cCeaT8p6nc/N5GVfIoX0UW+24Y1VWYOV/5vSX825ZHr6JsuOKw464+4x
         VbxNVKyu+9m+jR4Y9uhpXTDzBNZycIaXqh+XUlCVAlGYomKIV/NaUTTObGO6Yx2V9ust
         UhPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770849119; x=1771453919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ljU8FyYrq629B/3hbVIvRNnIg24HIn2TxWfUdn1jDAw=;
        b=l+zufjF4u3Xv+ez3t0t16o9k0ftHEZIbSz+a5/91fPeS5lPckeutr/MwWK5tbOJb1t
         rgT0Lh6PSceZibeLXuNoQJV8eFQh7d6mTopcrAR8IkVi9jnEUnPzvwj2zCP26bSNZoOm
         fPRsqG0kNzKicLmnzajMTvuYppvLxoPWzOw2gVNZOeTGmFRNOAPaRuvBKi3p7OOJOuK9
         Vmc4AqrDCPO1ZdyTlHwk263OFEE+lVReKir5bbTdA+8jNU5IPAI6EQHtgGjII6fNDcq8
         K3ITypMZWdY1NiY1MmVjmeZk9YMQY0oKXsBxAOT1ySvXDammLdA8k8TzH1Z/sI+KeaHf
         DHrQ==
X-Gm-Message-State: AOJu0Yy1L4coF+pUEcXKZgs3RVjO0Fb75GN8O53BncYMF6MC453Rl6QF
	v+1SZOrojmCvQn3J5TDTJ7Sm+Z1wyy7ffxL/Np4JiUNxUtNNmAUhPNEW6YEzJrVL
X-Gm-Gg: AZuq6aKPvtFcGEmBpIrJ7TdkGup4FQ1eZN3/Rgw2miys3NHeSjeLtX/C1lI0YnYBIfb
	fK1K9uf/G8JaE1pWjblTW3yEXM5+Ht4LGGJGee19f7HP3fJe/nvop/hosNZTrbcyg3mFO1hePxo
	LDxj4Pr4sVnbo4/ZwBCVEbpp8pNoZn6XoTbGXpwtz292gqetBNd7ooiO7bG8hAECw1tufKtHyFU
	Qd23XWft/j0JRmBibTlcklB10XXuZNRtm/wA6hYw40ram83pdxyEEJKDCZIaVzBNNYjgyiWG87B
	dURnA/EkwjPEPMzohRlGyeElrRrEhrTJPA2wuOXapQEN2tEOriHt+OIFaKrHSVzbijRtaBDpn+S
	FIy4BkxclNSjgMYkSjmZrgjXel9X7WdRWpDhBrvsF1bIK1BM0Uxw6zzjuiv5itZvZ5Es43WZUJO
	xQ1cNBOzX2F2L77zWsGirVyNtKkRm3m+6V3bB4TEHOZrin7eE4kRIpj8fWh0m8Wb+xrBgyHXWtr
	0jyCXE=
X-Received: by 2002:a05:7300:7493:b0:2b7:5a7f:f74c with SMTP id 5a478bee46e88-2baab72308dmr233474eec.9.1770849119508;
        Wed, 11 Feb 2026 14:31:59 -0800 (PST)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::2:8141])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba9dcd0609sm2639306eec.16.2026.02.11.14.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 14:31:59 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next 1/3] bpf: split check_reg_sane_offset() in two parts
Date: Wed, 11 Feb 2026 14:31:38 -0800
Message-ID: <20260211-ptrs-off-migration-v1-1-996c2a37b063@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260211-ptrs-off-migration-v1-0-996c2a37b063@gmail.com>
References: <20260211-ptrs-off-migration-v1-0-996c2a37b063@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

check_reg_sane_offset() is used when verifying operations like:

  dst_reg += src_reg
  ^          ^
  |          '-------- scalar
  '------------------- pointer

To verify range for both dst_reg and src_reg. Split it in two parts:
- one to check a pointer offset
- another to check scalar offset

This would be useful for further refactoring.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index edf5342b982f676567579ed6349ccd5391eee7c8..3bf72eacbec2407fc79e22f62098755415bdf61c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14426,9 +14426,9 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	return 0;
 }
 
-static bool check_reg_sane_offset(struct bpf_verifier_env *env,
-				  const struct bpf_reg_state *reg,
-				  enum bpf_reg_type type)
+static bool check_reg_sane_offset_scalar(struct bpf_verifier_env *env,
+					 const struct bpf_reg_state *reg,
+					 enum bpf_reg_type type)
 {
 	bool known = tnum_is_const(reg->var_off);
 	s64 val = reg->var_off.value;
@@ -14440,12 +14440,6 @@ static bool check_reg_sane_offset(struct bpf_verifier_env *env,
 		return false;
 	}
 
-	if (reg->off >= BPF_MAX_VAR_OFF || reg->off <= -BPF_MAX_VAR_OFF) {
-		verbose(env, "%s pointer offset %d is not allowed\n",
-			reg_type_str(env, type), reg->off);
-		return false;
-	}
-
 	if (smin == S64_MIN) {
 		verbose(env, "math between %s pointer and register with unbounded min value is not allowed\n",
 			reg_type_str(env, type));
@@ -14461,6 +14455,27 @@ static bool check_reg_sane_offset(struct bpf_verifier_env *env,
 	return true;
 }
 
+static bool check_reg_sane_offset_ptr(struct bpf_verifier_env *env,
+				      const struct bpf_reg_state *reg,
+				      enum bpf_reg_type type)
+{
+	s64 smin = reg->smin_value;
+
+	if (reg->off >= BPF_MAX_VAR_OFF || reg->off <= -BPF_MAX_VAR_OFF) {
+		verbose(env, "%s pointer offset %d is not allowed\n",
+			reg_type_str(env, type), reg->off);
+		return false;
+	}
+
+	if (smin >= BPF_MAX_VAR_OFF || smin <= -BPF_MAX_VAR_OFF) {
+		verbose(env, "%s pointer offset %lld is not allowed\n",
+			reg_type_str(env, type), smin);
+		return false;
+	}
+
+	return true;
+}
+
 enum {
 	REASON_BOUNDS	= -1,
 	REASON_TYPE	= -2,
@@ -14874,8 +14889,8 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 	dst_reg->type = ptr_reg->type;
 	dst_reg->id = ptr_reg->id;
 
-	if (!check_reg_sane_offset(env, off_reg, ptr_reg->type) ||
-	    !check_reg_sane_offset(env, ptr_reg, ptr_reg->type))
+	if (!check_reg_sane_offset_scalar(env, off_reg, ptr_reg->type) ||
+	    !check_reg_sane_offset_ptr(env, ptr_reg, ptr_reg->type))
 		return -EINVAL;
 
 	/* pointer types do not carry 32-bit bounds at the moment. */
@@ -15004,7 +15019,7 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 		return -EACCES;
 	}
 
-	if (!check_reg_sane_offset(env, dst_reg, ptr_reg->type))
+	if (!check_reg_sane_offset_ptr(env, dst_reg, ptr_reg->type))
 		return -EINVAL;
 	reg_bounds_sync(dst_reg);
 	bounds_ret = sanitize_check_bounds(env, insn, dst_reg);

-- 
2.53.0
