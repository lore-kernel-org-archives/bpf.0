Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D903EF64F
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 20:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784838299; cv=none; b=by4Q5p4kWu+BgQMBjGBjv24PYeWZnkRHXHl7+LH7JglsUODwYK+EssGlhWf2Y3YcnsqsKGrs7vgdwI1rxcFX6MHqxYCbvRhSzTM/p6Pn7KcPFeYx/NUmfipa492rhtnpVCzJrNwOfRi5TPWbkBWwwqSWLCwYk/+05IWLwz+pLr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784838299; c=relaxed/simple;
	bh=OzetTbfjQePTy7OVY1wFP4vmFUZsVCuAyG7c7gEUj0M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IpP76+WqDHdv/eNBZM0vO14FgWoWoZpgS5ceUvKRTBKfhAf5U96YlQ6Rh2HFZim2EJJP9RqH4s0cXV8XwCHjr/oEL6WKZYXjEBhbIdZ37XrnSTdWVkuQhC4cViuac1GQe+uevpSkpixNdEgy/oLmxq9BHZwclnWlZ+30rgfZqqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D8tRQXY9; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8tRQXY9"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cca0c5799eso11406985ad.0
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 13:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784838297; x=1785443097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=u/wCNn7r7pOj0j9wdJMmH/uZiuuBESr30e4WVlCi2n4=;
        b=D8tRQXY9AkmuYQrdSbgmQx1BzxkkWa50b6UvuXkhwr24/Crmm5BwWL7cm4l3EPvNnr
         qBDPU4uBQWSPSu700uZLKd6YU+LXNSBYZj7BGV6aJknvEdjbBbHNy0zP9gBbVd2/9GD9
         cDvvo5VoOrf9QcdsiiNd2W9pzHxeNznmc/LdCj7+65rzw+IUZNKgA7/bq1ItxaF/mgCI
         IrzY+oG0WKi7hKZH+TXvMiUY3lmfS4tpdBPDz1h3atSpBJbSVMTXtzbrmO0pvzEUXyU2
         OHf5lssKa1mdeP+EUdiqD+7rxZx188PdHR//AIrJcf6Ig/lqfx4xk28gY3qzCuaXWVuM
         58Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784838297; x=1785443097;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u/wCNn7r7pOj0j9wdJMmH/uZiuuBESr30e4WVlCi2n4=;
        b=cMoIC2KMx6nFQj0lztdR2pSGluO4OMH9zgAchX4zdNbMxpDKxry7j3QWQpLKITdtYK
         3nfi1P8N6BODLVEuAx7dc2mYchL+/nqmB8JSjeKwxuDtSZcVin3cdF3hBdXRgpiZc4Br
         eiTVSTTkj2u+zEZL3a3qITNOke/jtt2wyp82dCj/LpAxher9OQAPTUiFkkO82qFl4C3U
         8NB9kzrmC9pbTo7rsdRXSlC8bUqDDbLZzC0GRI9WEDDRlDa4ofRRmORPzWJgEpyGwmoN
         7+2SCc436TLQ3fqmYS/a4Dw/pNL+hlKm2GClKPnONJ0OZtUAWX09znHN0R7O243qmbxZ
         TDiA==
X-Gm-Message-State: AOJu0YyuuEm9aVHThfLPXL+R7x6FoWu7j/fNA2/MVzpNE3A9Yja1iXt5
	Zoh95sTIbYGx+cKC3AIS6Hr1Pb35ZUFCufO3n0uTiQ3ZYcLjv9u8xXKlRuxZpA==
X-Gm-Gg: AR+sD10w3s9dqzsK3tybIgFdHZlRNJ9DiF5U99RiVUltWbnxErH5Sh5yxh+ytGzsSXc
	wsrOOQEaB2xdvNXCdWSumpDh5PZOfiWiYRvvysyqSVlovhR7KLC5+hBaoSg/eBbTkgssJHSJK/+
	iHnnouqDChgg4LJIsVUJZ2FPc0X+ftSKGU0L1DqUj8ox1MpTm5oProABWTYD9KUp/M5weCBZKdC
	wc+Pa3pprJljn14IkDQyeX2jxLLdbIludMO64kCAZTPL3Ct1icNMpFeodJ/EGRNunAFTQI9B7KF
	prBTdIYsnDe7LXAZXpZ/PhSFwPTFVImS8xWRMkFuhI6PFt55TVkd9m+OZiYb2ZIS37iHCdbKAZH
	sT7ZSNKAFI0JZdtC0uhDs/+3JENn7mC8o9cjoPTdZgpb9QpWrXc5z99r9nRfFWv3GWZvlOeIlsg
	77aQ==
X-Received: by 2002:a17:902:d486:b0:2c9:e846:a57e with SMTP id d9443c01a7336-2cfa67039d2mr53287135ad.0.1784838297450;
        Thu, 23 Jul 2026 13:24:57 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:1::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f34bb48sm39637125ad.65.2026.07.23.13.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 13:24:57 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf v1 1/2] bpf: Reject passing scalar NULL to nonnull arg of a global subprog
Date: Thu, 23 Jul 2026 13:24:55 -0700
Message-ID: <20260723202456.3754267-1-ameryhung@gmail.com>
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
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d952bf07368d..498f01045be7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9331,7 +9331,8 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 				return ret;
 			if (check_mem_reg(env, reg, argno, arg->mem_size, BPF_READ | BPF_WRITE, NULL))
 				return -EINVAL;
-			if (!(arg->arg_type & PTR_MAYBE_NULL) && (reg->type & PTR_MAYBE_NULL)) {
+			if (!(arg->arg_type & PTR_MAYBE_NULL) &&
+			    (type_may_be_null(reg->type) || bpf_register_is_null(reg))) {
 				bpf_log(log, "%s is expected to be non-NULL\n",
 					reg_arg_name(env, argno));
 				return -EINVAL;
-- 
2.52.0

