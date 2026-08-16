Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3FF3C10B6
	for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 01:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786845478; cv=none; b=OTyERC417Mm8bkuaGwxxkg3OPfS4yvpSoO9jG+CAN3GdLNEVEqHYLgo28CyvbJFVk7XdmJOws05VlvArWCX0HZXkNmgruE7LnExUopTv7o/pUcKwALj5oVOFm30/jMFNWjMW3Twqru99v7TkPXEHKF3lHBRg27H9/IQcJimeW50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786845478; c=relaxed/simple;
	bh=uF0OBRxYo8av4y7VMZhXeM5qnvbPVNs+/C9T9j/zy2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fucGe36GNSI605TyKtKTJtGC2ekmdBkJYK2CfoH6OmDQ8nVZ95JCOmIQT+PctqWS6cudpBakshCTZcFTrjQNuLzsmjd933okUlAe7hhP8LawJnEBSuhtDEtOyH7bPwPWT1addefM5U1Gz/zktGPtASQWtD53PKxGCUgeUUEYg7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ok3hXNbD; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ok3hXNbD"
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-495482c36b8so7666705e9.0
        for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 18:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786845474; x=1787450274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pKfCjHnMX8QhtR6ZpymKT4ZAVjVy6XVN4NL942NscVM=;
        b=Ok3hXNbDLtnP2IAtV4k8dY41cBXnWbeQQ8zbgEXDrSuBFck3PmRTdd7XI666+/Sh/F
         +ZYw89Kae8A1q+oyQ+lK5v+2YuJzOrVg4mnZUzWBp21qXhrQp1WVCOls6aPLxgyFY3mN
         a55PvIYXiY771MpmDMFNPmhfLY+0LifmPYbRJrtGtyLBkL88JHQgYlDgchJ65IdnZyJE
         Qz2dgE2wEVFkCQ98o68lvf3oUUW37MBoEavI2nxjjE3UDgdNGopsrFGCJcZcQtdqWvg8
         l+/etIOsi7CNW9wAskA2I2XeoFYoAoH0IkMW9zGFHZG0Bc2H0AIrcvEhxBNemFkgtQl+
         ObhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786845474; x=1787450274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pKfCjHnMX8QhtR6ZpymKT4ZAVjVy6XVN4NL942NscVM=;
        b=NhwCjXCpq715KHke4HtCBLylbSUx84Askj4JZ0abVSIVNhgmSXpVNGd8yacoIQbZ7g
         0Oz2SmkCGtAokmCGKpA11mkZDyFa1whotQve1JwNvy9hUtpIk/fdFApGGwhGnmJXdM8i
         FN6RKpbGB7EJTIE7y0Qt9jEsI4jxWD2kQllXDcr1YO3/+oGiCC9tzGp4FnbjMi3kE4df
         eSirs9Zzka56FUEcaPvXWXTv2tiQaubWljn8tGmb1y1Y4U4ppL/X4DsG3b2gZyp9+RYE
         tu1qQwktOoXjzFawSos4+Ohu08J18q9VtLiLrspWZaiPE4qmYXxqytwGbumv2H4x72pT
         /njw==
X-Gm-Message-State: AOJu0Yw375/KZ+QCSwHBMR2zuhgSv2Tx5XEmTugEkAcSkBNa+A9KDJig
	C1vSqZgbNxmInuIvX4gMOItQmlfdwBfWX4JKlx89YVlirQv9MSo95wI0Gk95C05f
X-Gm-Gg: AR+sD1183Ln2FYCk0eyW6+rQQ+l+krH0LP4kgUje5cp4NOTpAK58A2EYp1zrES28hWF
	HPlUNPWfH+uOxMj+418j2seQg7+Jnyr3LNPOszC/2hjMy/hUMzn0zjCCQmKS91Dd4fRuYc6yytn
	w47zXukBnUmDfBF62SQTipJk5eF0S2RuVI1oOhQrUbrHLQgiZ9+HeENrlcxS7atppG08y+BawhD
	WkItZb/hP4Bk9uvpxD4P4fZ0eZiF8gk+tsqCcObqqNZtXC3bGlTtNfkqWsCJEKOskROfnxzqcGF
	73UDpLJC/Hc0LzSXJ0r8dore7sDgB5NkOKWblN3gFd5UYMwpDbglmZzBQCtsYjGrhUROZOZnjYy
	WqVWSrwG155QfJcCmaoHjU5aZyuGn+WyRDLnuMIQWqiiQdH1mIQ7H2EHXIJMrEIu/hl3k2VQ6ZS
	/Os7Dxbqnqfx6jnTh0f1Xx0wfoI9VmvjUxBCromLX4nsorCUxJc09YzptfLDS+AILLucfOkQhZF
	Lm68oNyTURw58XdulOrGzh4t8BtRrNxkGgkD+gfMTROh2Nv/zN6+X2zb/18hJ9xB5A9MyKliH4U
	/dQmaLliKVxhLjBHsFZT+AQO30g=
X-Received: by 2002:a05:600d:10e:b0:495:4572:21af with SMTP id 5b1f17b1804b1-499879809b7mr160648615e9.9.1786845474599;
        Sat, 15 Aug 2026 18:57:54 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49987b36370sm144137305e9.4.2026.08.15.18.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 18:57:54 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 05/14] bpf: Use canonical stack argument names in diagnostics
Date: Sun, 16 Aug 2026 03:57:33 +0200
Message-ID: <20260816015746.2632990-6-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816015746.2632990-1-memxor@gmail.com>
References: <20260816015746.2632990-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1408; i=memxor@gmail.com; h=from:subject; bh=uF0OBRxYo8av4y7VMZhXeM5qnvbPVNs+/C9T9j/zy2c=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIatRQlRv5h62xOvvvweHzGFg85dSfLO7JDz1134hs7hjd 7tNvTU6SlkYxLgYZMUUWUr+72MyPlH5O9B2GTfMHFYmkCEMXJwCMBGRBEaGV3MOSjxS1b6VH5l4 Ql/avvvVR8ktB36FT9itqF390/eWCyPDexbJ3Cd/Mjaz12lmMc6qXW5rfL71We+nSq34WWUG1zY xAAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

The main diagnostic identifies the first outgoing stack slot as stack
argument 1 and the sixth function argument. The causal history instead
labels the same value as stack arg6, making it look like a different slot.

Render causal-history targets in the verifier's canonical stack-argument
location form. The first outgoing slot is now shown as *(R11-8), matching
reg_arg_name(), while the main diagnostic retains its fuller slot and
ordinal description.

Link: https://lore.kernel.org/bpf/eb1be5327d136b7e5bd6d68e76fef6de20c40790.camel@gmail.com/
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/diagnostics.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index 37ed22a764e0..2c475174a640 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -2163,7 +2163,7 @@ static const char *diag_mod_target_desc(struct bpf_verifier_env *env,
 	case BPF_DIAG_MOD_TARGET_REG:
 		return bpf_diag_fmt(env, "R%u", target->regno);
 	case BPF_DIAG_MOD_TARGET_STACK_ARG:
-		return bpf_diag_fmt(env, "stack arg%d", diag_stack_argno(target->stack_arg));
+		return bpf_diag_fmt(env, "*(R11-%u)", (target->stack_arg + 1) * BPF_REG_SIZE);
 	case BPF_DIAG_MOD_TARGET_STACK_SLOT:
 		return bpf_diag_fmt(env, "stack slot fp%d", -(target->spi + 1) * BPF_REG_SIZE);
 	default:
-- 
2.53.0

