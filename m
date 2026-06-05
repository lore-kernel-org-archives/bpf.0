Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E587320CCC
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 20:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780690860; cv=none; b=hxYtRQ2HcG4b8QI8YPuKeQo1K8L/gBRxML+1Y1vWBf/h512j+NrxutgWg1i3rwCF+XgiRegX30Qym+Oz2j8vfIrTwb2zg8maWYQLgR15umvQbV9UKVbUro7WNZUvzdk6nPvYTZZQOzp47muBxEAncAtzVTnWpps9s7kJV2yQsO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780690860; c=relaxed/simple;
	bh=VKa1p6dcOvuI2DFfe1gs5QWC1H4dbHxEPdSpJFQaEaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=haU6yIiut/7vThwA6R50i2+HsaHSX82MSNvijvsEgwobGDE8VFh6p5ieox/eV268NonEXZd4zA0SPnWerXEwHFpib9ZW2OknJk9SBGDFz5FaAFlI6JBLVolVmQ8JUH3ar6u9hJ3ktLcOOapzx3FBVkYHxFGZUSiOOT8wBxdKkO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kNJ7Krlu; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNJ7Krlu"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2c0c2c7d45eso21598275ad.1
        for <bpf@vger.kernel.org>; Fri, 05 Jun 2026 13:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780690858; x=1781295658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H9A8Nis1U71TWs13OCltH/HpVgGML0i1G++ntwFggfE=;
        b=kNJ7KrluUXmFE6QSJgP0lDFWlb8jcgoNsF3CNiqf5QODBehh2vlz6CLQUqwsvjole2
         /U+XID+UaZEF6b+kTvc/mgRvBNryyAjbr58V5e1Y+UzjOalHCghjDuHv+7fgyqmgqCb6
         J2Ef8tPHeEJlkcTMGRCINY2S4xBHropcl+rS9VfB4iJyBiHn8E2+U62wjIR8SBzKJqTh
         5TSi6QgSVQmOorMoHmFxOAlJmlU+nL57e5SpwcSNzVqE9oBalGmo/mJQLfPmryoQSXYE
         LSMp53Nb45Bxe/4uzXoBGOvXuoXASbAHIctmt55kgDPrjZ0RxLbtOBMm2N34k9+Pn82J
         MFrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780690858; x=1781295658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H9A8Nis1U71TWs13OCltH/HpVgGML0i1G++ntwFggfE=;
        b=VJ+Kx8bnKxNv5D8K/5QtNUG0kmm3joJAdg1usSh0sHwdyWsJs2bB/OLlRO1fi3zPXj
         B43DE00UkGKF9DPSuUBK3PTLGUq/RwJp4hnl4xkj8xrHbAa8JEUcuQ5JszkDNsY5XO9v
         gWaQe5u4tNT+wSlX7QWCsi1t29tAuPMsti+Uu8BjpgwYbgAWvSrn2Eibav4VRbNcuvHK
         iiSw6U4nDM+p2rXXkD6kM+ZvyUnO6VOokMsObw0pCpslmr+ABlLsH8QzHKETeZWhVuZg
         /IBCkxSr4nOlDOixbx21/elWy9OWlasiggASBM/mtqZc4wJx+7u5Ekfiay4dzFdf/VZK
         4cjg==
X-Gm-Message-State: AOJu0Yw7pkcF+gLJuJWpqLdOkLTxui9h67DUHb53Lf5w7wENIvueLRH/
	C/DbPnOOBizz4cIatR4jbdbsAwOJlO69rRlZmqLq79Q1FRBdtDLz70xx6M5uGQ==
X-Gm-Gg: Acq92OHMMPtYXlLmX7sc4XLA9gtT4Z7vWBxyvBegHh4waCnhFcIK4f6pJDHCTt6ODx7
	lhZaa94Y+lZOxd6Ho5j44rCyl29r6/0y4dQCXzYafxPMLTl0w4LZ/Alc1yEFiQlx50kqdOMlv6z
	xQzzaxG8HZR7CvDxZw4R72V9WWJ4Gw8QbpOQXEzQ6HuQGyMIkyWIXtUd2qGP+71bkUvZU1SD5R1
	e5Nph6Ye+AWKjXGLHMRS31dHg3yDhx+0zwWNDk5m2xOlrh77m6h0S+jjBIYTjBnzGZSBqztlKXR
	TGOuwSwHYC+25qZq4qN+pKqH8Gki0jJDfTJ5WGXbL62yc8avpWkbUdNwok0jXflYTd99UVfWWkt
	SCrdt2p7NiiIQfDEvdL3ICAo/CT2tpPN2t7RkY/BKeET147n/GVcsUm+4z+CWCWGHB/L0vd/zz+
	tj8xa2MsMHgvYKLVhuLfXS7yw=
X-Received: by 2002:a17:902:f60d:b0:2ba:4e84:966 with SMTP id d9443c01a7336-2c1e85e0896mr52701875ad.36.1780690858479;
        Fri, 05 Jun 2026 13:20:58 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:2::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609e234sm103007865ad.53.2026.06.05.13.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 13:20:58 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	mykyta.yatsenko5@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 1/5] bpf: Fix dead error check on acquire_reference() in check_kfunc_call
Date: Fri,  5 Jun 2026 13:20:52 -0700
Message-ID: <20260605202056.1780352-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260605202056.1780352-1-ameryhung@gmail.com>
References: <20260605202056.1780352-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

acquire_reference() returns a signed int that may be a negative errno
but was converted to unsigned, which makes the subsequent error check
deadcode. Fix it by declaring 'id' as int so the error path is taken
correctly.

Fixes: 308c7a0ae885 ("bpf: Refactor object relationship tracking and fix dynptr UAF bug")
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8ed484cb1a8a..6446db9628ae 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12817,9 +12817,10 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	struct bpf_kfunc_call_arg_meta meta;
 	struct bpf_insn_aux_data *insn_aux;
 	int err, insn_idx = *insn_idx_p;
-	u32 i, nargs, ptr_type_id, id;
 	const struct btf_param *args;
+	u32 i, nargs, ptr_type_id;
 	struct btf *desc_btf;
+	int id;
 
 	/* skip for now, but return error when we find this in fixup_kfunc_call */
 	if (!insn->imm)
-- 
2.53.0-Meta

