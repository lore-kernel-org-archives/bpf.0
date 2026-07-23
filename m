Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFCF14F70
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 05:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784783291; cv=none; b=MyrEnPhHjePml2168H6fSw0NTk7+Gx3yAWxuhKRgXTutHmAbZ2iDVSleGJ+deP0qvc3qe3xESWXnVcLssk7uwjtk9FKtqjfwaqBM0dbBvE88AgsMPPEzPOHKaJwx5gXmA9e06YwnZO2WmSaiAX8i5ye573zWbGm9oJNEG3emE2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784783291; c=relaxed/simple;
	bh=Vza8QrPNtPQHRcBjh30dJlgG80VV02BZUO4pvHUqlUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hNrQgx5H1S1la/RRsV9JT7zcGB/mUJ+980wLL9uFCswJICXgwPdNodZrxvgY7r/R88gqoHK6xnFa65lUF0mZBqK/4V3SLOvs3i+ekxLN/S+CMP9HV0CfvAAwI2Dm+fgcuYmr4axT8XemnozrwTnNdI3rBFk+C8c90jkKAbnNIZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H2WC+Gwp; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2WC+Gwp"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8487088510aso195646b3a.0
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 22:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784783289; x=1785388089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vv028n+m3gPhclylokuSI7IFB34Ic8AnTu0RjmcnGvk=;
        b=H2WC+Gwp7PBqCTV6erjoT8/VXEGvDnegbkHuhNDooOjvtCPW8NWMJr8XWLCN0UpIwi
         1AUMwVpyawOnP95gqdXmlWUxh8K+uWF/T+AJ1gGUveo5tIDsU11svqEcQpMvLuQxQrnq
         5CCNcppAqmEwRCrXgCz+80GsPVzvEmJuGY5SoKrrghUpQjpJs9cZntpUFrhnijyZUUCu
         MNO+AnSC2zC5cDMMX81NY7RUxzEVayStHyPn3isCdG2xk/kEUmTAbFz89vfx3D+nUSHE
         laDNGziOnFnpwKYP+4JoX6dcEwm2PlmUnI8dW7aGoGsvPbtj+NfLa4/JGZA7XAPUItD7
         Wj9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784783289; x=1785388089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Vv028n+m3gPhclylokuSI7IFB34Ic8AnTu0RjmcnGvk=;
        b=DdBNBt55QYzeGoFbBECCLQODrwlmTvW1BfyZ5mha0ISU9PghUVBH8amhezZVbu1WpA
         AWkvhCYa8Eq3kpRbRhg5956286MjSyAe7pWbYhxnkH5Wfuod9it1R9dEgau51udRfPuY
         9jSxmLJ8PEv0gQToFpWQ5IqP6eX94FDSlqlB6xWZs5/WZrTimR1ufk4dbDXfwOWsYQW7
         6nwpxXj/h8FVtW6bP0gZHOr4BM6t3d82NcUi22J5gENZYqgsGT+ViKMSXud7fw2foQtl
         wFBbioAhfzBaNQ9HUpSOkDuPcW3Uv+G9PiJNnKkBumUxX8XNDmBV2Xkt4WavlLCQpAPq
         XPwg==
X-Gm-Message-State: AOJu0YxOvwggOkvJINdJq+TWPn1aMa+ziaFl6xBIagXffOwqM6JSHOpu
	wkIA2IfyfVilU/ZknI2Rhe3i5BZRFV0tQKFbrCzV+4BjddpnJy26rbmD0/L66A==
X-Gm-Gg: AR+sD13rRT8Z13GG63w8/08hPDQonNiaA0hxqBoBoHpTpXBPZvMZDbL2kVe5kV8g10z
	ufjQxkjV10/lV0OFkfc2d4DTqgeIrVeXMIifH7dsdspdvI2B26z/kxMbJL8loPtkOU3kYlIvHec
	RjqrWaUYJjUcUJW+gzVqlSt3uhCDNVrZRMMGA6dQpha1Yyf5oW9MycfIKhIOzKqoLA7/d0YpjHv
	IfluyozM1A5qvNYLxPpg6bUwmK3IwcmMVxE7l9nyRjvZd1glvucSe7p7NyikB8t5ygPlILtJ9im
	4NlFwohkHDjj0MPvalInDP7lByOkFf7zI/JUTjjLLnC8K48B8wQlPtEhZmxQqRwM8SEj3c0ryPN
	tOQGlLJDuWpJbKAnG6f5tuEtwFseGfkq0g6cz2upDcN87MGWAS5WMww1aTnviY/lbIzQ=
X-Received: by 2002:a05:6a20:b78a:b0:3c3:652c:664e with SMTP id adf61e73a8af0-3c44b28edf4mr1597505637.69.1784783289368;
        Wed, 22 Jul 2026 22:08:09 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:a::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbb8f1af5a0sm2195925a12.28.2026.07.22.22.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 22:08:08 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 01/18] bpf: Drop process_timer_func wrappers
Date: Wed, 22 Jul 2026 22:07:49 -0700
Message-ID: <20260723050806.1158442-2-ameryhung@gmail.com>
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

Drop process_timer_{helper,kfunc}() since bpf_call_arg_meta is now
shared by helper and kfunc. Call process_timer_func() directly.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 52be0a118cce..e8c76abbf76a 100644
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
@@ -12514,7 +12502,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
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

