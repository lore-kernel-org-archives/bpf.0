Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A403030D401
	for <bpf@vger.kernel.org>; Sat,  1 Aug 2026 07:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785570398; cv=none; b=Y8fQwmeTTOIFD+c52mYGy+3u2KAA2ks3u9YQKmX/nq/htR2yIPR62eoUYDf+5bbqp5MXXPRA21e1DyI8LKgceW+VlKV2Bev3kHjs+kL6FGusM3xWuWyC1SBhif9SdpaYUGPGQWE5KczPoFL1x1LdLhIAAed1Eeab4FYXZ+U57h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785570398; c=relaxed/simple;
	bh=6pmizXpI0vyCMkaFLOmpzM5fnxFiM1kZ5SS73+YHxnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LmGcBzYzxuJQsy6T0X8pLtyQ5ztElylHHC7YbJYh2JeTDhyPFRjnxMAD5/unv0fXvPKjM6z3Krm+NOn7SUZDTU8Cqyc/pt/drfRa9f1LTvdg8mosE45FbccZRO2bgFksX1XAnvBl+OAuIqsbq3Mrj43zWinVJZVw8wyESi16ALQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VYirJGIe; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYirJGIe"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cf50c6f235so20068495ad.0
        for <bpf@vger.kernel.org>; Sat, 01 Aug 2026 00:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785570397; x=1786175197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k7E4lkOl6QboRhs28WGAr/3jUZH3yeel7i2g9cTgELI=;
        b=VYirJGIe/fHrrr0Ub5oc8n9kogBZSqeOusKQpIAZ16PA+8x1v5Y1RSAswGwTU5sRf5
         JHx5rmm/bxGQm8f/fQ/BW9X/v5XmT+lwghPZHoDTOKq/WFjwIpQ1a/llVMKEz3fPS616
         vLMmwPfO036MqgX2SOudu4KELKjnqkhfvXhoxgzAaKuyI4jaB5sxguy6HC3UGhKi71S3
         4j1ArlEth842wfjO3DhJXXBmDx8Qyqu98OIPDRRwNpWq5s1AvwNhxpe3WlqCKxMColos
         T5rO/ls3HNA7r7prSI/qse4bgBFvOZuU03hqYz3CsQZtL6WC/Jy0VfvC9LQWFrMwRXsA
         bIQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785570397; x=1786175197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=k7E4lkOl6QboRhs28WGAr/3jUZH3yeel7i2g9cTgELI=;
        b=e0cZw2pZc3z667AdBmsiCcqAp9cSdBxWRpbCTg72KTweAFiZ9xyN4D38+LMf3DHscW
         F3jbpUvnVlJpCkrx1b3kG6UMSv8FqROQw628kWwaGUSAzwBWTl/WP/O47syVr/BZIsdP
         TQCjwQWC1Sf4X0IbM89V0kWu+HH5TyaEbhbINj3sVRAWtq8yY2a0kmXjxl58mZrZVtfW
         8Dv2f8S13cKcrDboSd6uIhIA9RnIwrM6/DSJtMSC866hdFZk/cM6dZuSkDTQ1lDaL8MI
         BlWAcV18dTQ6kRgfIcECRjhRuWkkBWHCxiZ81CvWTbJ6UTa53nNHU8jdMDHy9oAXn5YL
         A/YA==
X-Gm-Message-State: AOJu0YyQVOdliiWoSJtZ8DfSKUz9WO4Ry/TI0THKpSs2/3y0EyR4DxtE
	7m9UjfV+1QP/srPCLW5CVjwXaRNWQk06abLwaKRWqlXD4Dw1fjxeCmlhioHKTA==
X-Gm-Gg: AR+sD12BKBfo8XeChGuqj/blJ/qENRECPVQM5ZpbgF0XyPtu9N0quemZOA8QmDJVmkS
	qSGyICJu3rAe3GAdyALPy8c/swjlGmXM3GA3Ph7bhEpgEehlnh7U2ZwIRM+oiOOUSj6xkhUJOF4
	IDZt/WNGE/fHpys97Abp3+hR2NmLn/NvGLAGHPf6YYJIT5Wd/tKTN2dIFGWMv8mgtP1AAfxZ1/s
	sc1HovsFm4B2wsRBt4WmE8b6TCXg2lLRrPqTtrekC/4p7RKgVdAH1EkGSddAlQDGDdNwrze44Ni
	LnZf5cye02RpWoQUMv3bwFMSn8OtTL4gq1ctp+PODkviB2+Fhu541dFWH/PIff8x1TuumS1dLPZ
	bPLUzV6juQjrXh3diLdQyMfkr2dcHk824geYGyGt3f3St7hfzuWIABfKbJTxkxGiwI88U7nJTWs
	wxzg4ew0xD/0o0hJRspJR0OSgi37+SHvz72qOupxyhiyav9mPuR/w=
X-Received: by 2002:a17:903:3c26:b0:2c9:97a7:3289 with SMTP id d9443c01a7336-2d0524a43ffmr26288045ad.43.1785570396885;
        Sat, 01 Aug 2026 00:46:36 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:73::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04b11f9a9sm15010135ad.57.2026.08.01.00.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 00:46:36 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 01/18] bpf: Drop process_timer_func wrappers
Date: Sat,  1 Aug 2026 00:46:16 -0700
Message-ID: <20260801074633.1595644-2-ameryhung@gmail.com>
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

Drop process_timer_{helper,kfunc}() since bpf_call_arg_meta is now
shared by helper and kfunc. Call process_timer_func() directly.

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e6f35f4e715b..c1257f7e8d43 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7224,18 +7224,6 @@ static int process_timer_func(struct bpf_verifier_env *env, struct bpf_reg_state
 	return check_map_field_pointer(env, reg, argno, BPF_TIMER, map);
 }
 
-static int process_timer_helper(struct bpf_verifier_env *env, struct bpf_reg_state *reg, argno_t argno,
-				struct bpf_call_arg_meta *meta)
-{
-	return process_timer_func(env, reg, argno, &meta->map);
-}
-
-static int process_timer_kfunc(struct bpf_verifier_env *env, struct bpf_reg_state *reg, argno_t argno,
-			       struct bpf_call_arg_meta *meta)
-{
-	return process_timer_func(env, reg, argno, &meta->map);
-}
-
 static int process_kptr_func(struct bpf_verifier_env *env, int regno,
 			     struct bpf_call_arg_meta *meta)
 {
@@ -8466,7 +8454,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		}
 		break;
 	case ARG_PTR_TO_TIMER:
-		err = process_timer_helper(env, reg, argno, meta);
+		err = process_timer_func(env, reg, argno, &meta->map);
 		if (err)
 			return err;
 		break;
@@ -12515,7 +12503,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 					reg_arg_name(env, argno));
 				return -EINVAL;
 			}
-			ret = process_timer_kfunc(env, reg, argno, meta);
+			ret = process_timer_func(env, reg, argno, &meta->map);
 			if (ret < 0)
 				return ret;
 			break;
-- 
2.52.0

