Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3D817C220
	for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 21:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770932083; cv=none; b=XjQoXo098N58R3UGHOYiyLb+E3HspzNN2a8ILDMmig6rgpCaggU2u4wMBt8d81hc6wzCEsJ4LcYypDufEdCFrRfshB+pp8SATscSNcOgob31XRfVxPY/0VQqHuN1Lfj/6Qohbs2OwNmrQan62cdm078LZScy0I2OE39lVg6inW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770932083; c=relaxed/simple;
	bh=H+di9mAItzwMGUupnhdSEx6k0FVcB8XtyIfJhXWu8zI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KNxc6GMoTJumeB2ausTzNOVut6o4IKdHVJwTpInrm06B48YmWconyeVI9kk2h79+XIZqOdThbNnInFptlgZ6HbaLe7c6nUxm3C6vgCW6EM+mvb8VWyTedX3ti/myDDf0n6/NoaWyO7sBEJiR6RKw6TRsCdoXip5qQvKilv9/CFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PVpSPljW; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVpSPljW"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a871daa98fso2062065ad.1
        for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 13:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770932081; x=1771536881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UxSxiQ9RA2zxeDQ1ceNlG37Wb40P/nJYnmXcS0sv1YI=;
        b=PVpSPljWXfTfWdc0SjVBK9nmkWwzSmXaS9MJi4Gbw/Zeb/tAtVYUvA4j7IMLnmCR3I
         fMNKoaszHzJXsi0fWFfdN8VT2G/5wiGLn4MXnLcb67aHp5AiJ1MzQkH3qhrY3K0eWfu+
         e0aRkeg4VIUzwrHe2wcYI52XeiNAa9EbnI8nq8aP+8Xdm8JqZdA9PL+OWuCmLS/9G8tl
         ydYlLd4xtNtxyoZreaYw97v8HTQnLBRkovIxf+WrOLvxrMzbipzM45CK9pO6uvKzJH57
         aS7c/fK8+2ei2S1aMoeD0jC0L75w5ciJ63azZcXHLvTpAGEggSfD/LBbdLe66CSxx3Lh
         ELJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770932081; x=1771536881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UxSxiQ9RA2zxeDQ1ceNlG37Wb40P/nJYnmXcS0sv1YI=;
        b=H8v7K1a0r00pbYbg7uN05V8cEFF043k9Z/d4umkNJqxeiSlE7uki4W44kqU75MGL1a
         HkZaw5o+JU61GtyEE5FxscKdGLgOqTBSqK9vVBkROkxelr1dg13ZQAzdmPUUMO5Fu/sR
         HVDXqTMKlI7lmp8zwYMXG3mn5z/BWShJXi9/hdbN5P4ODLSP7tJkB+9r792BvrsqUpvT
         ct8SRTVKj6U7JuQHnXo0X10DmFbDqfMR3CzaJac0xoDP2eL/QZNCuZJROemB8jvQKPnc
         /UjRRynC5QK5l8k/zP//M5VmJV82SP8Z10VTCfX1qyGXRATGFh8AAkxLtFP1gfJ0+MLo
         m+jg==
X-Gm-Message-State: AOJu0Yx7vZgHjLVqyTIZ2FQn/ok3EjYTxZFgJhVHyr/5JQOaS8Hm9F0F
	uLappq0xs3KdxypJXgwb6reTvIdEIRi1xEZxwbV14qo9y+NkKweNiVUWkp3Lg2MR
X-Gm-Gg: AZuq6aJExIyQyHkOUM2vP34AGrfOdUO5NnS5Sv5YacqmPpxf1Egsd/rOR7uGfuL5Dug
	3249kZKPW7SR/g1cyMUPNQRuiGCPSQ61fK8b2CZHD0dKpyazfL9IVGG0JJUoOqP3T38kmRA+02b
	TsyWtOxasMwd1NLeVGfz1nzfEufamDoIk7YWrbH9QCfMa2k8dXX7eE4r7aqlyJwDHO4AYbZMfNq
	4bjvWW9aqMeazbwXPDv5HotLA/NMu9LMMhavVU0UlSbOy4AR5gwxUqLckIcZaAm2LAukZEFrYmT
	WVCz0K5mLs5LFqUrqxiBngbFjeatpB5HjSltvy1Se99AaUEB7dgc2EHeUqMKyJbCwSU6ZCCRWNP
	ErtJKOVFGof7ptlbbkR77ggEnUMhunkA1qxC5UsykI2lBLJeXqJRAAGHGQNLqnDQMmFoNS8W7YR
	xAtvwOoCP02DwlaFQgEj0IzWkn9rP81S09+FhN6lW2mYxZ0+NP
X-Received: by 2002:a17:902:e5c3:b0:2a8:ac0f:9aec with SMTP id d9443c01a7336-2ab4d01d805mr3819675ad.49.1770932080995;
        Thu, 12 Feb 2026 13:34:40 -0800 (PST)
Received: from honey-badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ab29979b13sm58728405ad.61.2026.02.12.13.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 13:34:40 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	kuba@kernel.org,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 1/4] bpf: split check_reg_sane_offset() in two parts
Date: Thu, 12 Feb 2026 13:34:21 -0800
Message-ID: <20260212-ptrs-off-migration-v2-1-00820e4d3438@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260212-ptrs-off-migration-v2-0-00820e4d3438@gmail.com>
References: <20260212-ptrs-off-migration-v2-0-00820e4d3438@gmail.com>
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
2.51.1
