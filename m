Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5473A36B928
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 22:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784845098; cv=none; b=a/DP9yLKq6Z/ulOShLp+gNSqkbRzIMoQ5RxW0TuEfohePRUhPWQS8XupIQPJ1PtgZgKYpiNwi5v8SxYJb4ovziI7wrRhHDJsdWSEheOIcYNzElBwwfSSPOG8VQgeb4La4+SIKXgen70iNyCro2jTpL7PFSPZv6O347hv2WheHt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784845098; c=relaxed/simple;
	bh=KamYaFf7DMx8/L5rX00o4lze7Fh4WbXthxIdBeMDnlw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QbDnBa4FXcZNPb/vHxyNfwBruX+gbsBQMS3K5YGfFwQ38GHGMkpsBhMxLad04/GRHR/FBPoa6BE6eAucluQmiLjH6mzvsUI0BPmyEqwCGBGbikiv1S6fLjJDlMu8KJ4IPtbr/e/vRv4vR9rxQslIQsHBt+oWN1EE4qoNVC21n64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FBxnDQ5w; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBxnDQ5w"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ceaf8a1265so14809875ad.2
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 15:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784845097; x=1785449897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=556MUYL6Dp/wFsnRk64Tx7w7PHFJkxTZ7Ou1cxFsxdo=;
        b=FBxnDQ5w8SK2EsoPi/fXMOtgGeXHklq88mmtIv3kaL4seZ55Un+LysOdDwVZ32QxGm
         egcSl5ZcZaJctFfCBLtwOC5Pf5rv0zJBXv6lIPJGysUcLq8YFInJ5qSmvbNkN2D6Nxme
         zP14axec0x7mOQDTvgKAiVpyhbTx3oevs63VHy5yzp3Yvj0UCjSSZ72odoF3o+GDH+1o
         DCsQH+mBZU8xnf2g9yYB4ZZop4tHCycBo+BzeagdfV0xJNcMTHfGHgxrfv8ycKyG2WcR
         ayGEbuot3rRJwaqtalgWNafeFSv8YJ3AQWFFI1Zw2Z/dlHe3/AVDyfMGp6JdLjQ69t43
         u9ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784845097; x=1785449897;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=556MUYL6Dp/wFsnRk64Tx7w7PHFJkxTZ7Ou1cxFsxdo=;
        b=SnJwAKStM1UyHOWbAI4LGZUUBuqp1bvGtOWgEfRKWmCB2Xn/r6Tbm2NoC59S9YlQcy
         iZoZwTSJhMMNgRbb0csL/d1FNDvSbyzNx+Nm5xuRboXOqJYrg2w+1rFaiK7pUuZUG8Ql
         TAnIb2sgoopJpqCDdr4KmXjtrfPHP0l8coLFeiKZK7hXSodDWd1IEbAXBk9NKiL83KPO
         1xZmcTB3i4gjrw1aHGUDcRDUTyT8XZuSA44uGIqqnJKvR+GURtoCUvT+3PDNOWO3lFs+
         nYhIosZR0vzt2lajPHt9JbwQByJQFmmJ4owrQyLUH0frdqH8I4tKDt7PDXBMAzB9Jv9F
         Bbjw==
X-Gm-Message-State: AOJu0YxyBeUD9AdpGn8HAdYFY9L7I0Pr1f5rRTgp+6P/BpntJh4ENhJU
	4ZUph/Y+uSSnYI2aZ3hkuKds7VYYLeXGxjpS1gGCTg9ivGljU2O6cIU/lQQBCA==
X-Gm-Gg: AR+sD13be20JBNLK+oc9HLGZUZ0U0W85p9v5kE9oOPNuftKxB0hQsdw/8SMIvGFLkLp
	TzA5J5waw34UnKqZ0LuR3l27VTeDcJuXMaG38p93jxeVVPlmYzXfSb44aAj0OuGG27mkTabnu8L
	2abtNd0bNF3RP56H2Gg89edLUtIOq7iaBIicgmIQIMdO8GoOxVEJ8dk0oShHlYy2fbptxplnlsZ
	Xk01gnG3v7MotmXp31TugnCPR9e3VBLDFGa64D4ksIFjH7yfG/v6zLjVpIfnBT/Zo0JtDiyWUY6
	l9h3O/ko4RyLawnmVt6aexA/9HyPKXy3K0wNVnbMk9efDix7jIapDsVbby/RYSWGKuoOX5pKbxW
	RTz9zizXLpRWrHD/61PF7hDXaadmda+XzOvS869+gQ3g5OJzoUkpKGcJLN8IQJPGK3V+W
X-Received: by 2002:a17:902:f60c:b0:2ce:6d4a:5b8a with SMTP id d9443c01a7336-2cfa71ab5b8mr57996915ad.38.1784845096648;
        Thu, 23 Jul 2026 15:18:16 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:73::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f35027dsm40576865ad.69.2026.07.23.15.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 15:18:16 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf v2 1/2] bpf: Reject passing scalar NULL to nonnull arg of a global subprog
Date: Thu, 23 Jul 2026 15:18:14 -0700
Message-ID: <20260723221815.367797-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A global subprogram argument tagged __arg_nonnull is set up as a
non-nullable PTR_TO_MEM. However the verifier does not check against a
scalar NULL, leading to real NULL pointer dereference. Reject it as
well.

Fixes: 94e1c70a3452 ("bpf: support 'arg:xxx' btf_decl_tag-based hints for global subprog args")
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 99444eae917e..7aa47342dc65 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9189,7 +9189,8 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 				return ret;
 			if (check_mem_reg(env, reg, argno, arg->mem_size))
 				return -EINVAL;
-			if (!(arg->arg_type & PTR_MAYBE_NULL) && (reg->type & PTR_MAYBE_NULL)) {
+			if (!(arg->arg_type & PTR_MAYBE_NULL) &&
+			    (type_may_be_null(reg->type) || bpf_register_is_null(reg))) {
 				bpf_log(log, "%s is expected to be non-NULL\n",
 					reg_arg_name(env, argno));
 				return -EINVAL;
-- 
2.52.0

