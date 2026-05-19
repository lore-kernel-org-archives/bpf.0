Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3137344024
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 18:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779214406; cv=none; b=XWdnjVFQUX8BVKW3iC50MVENy40IxB667Cezir5LNXPTq5BDMps7oSZR5XnYGPqchDL6b0I8ysti7ZHkSwkovCu63f9INA+zZ7V/hIXYTYTMqYsjQllzjZdhi7Wzckz56GBvurpDi4DwWP1cjiIBgMg8E08n30j5x0vNTs/4tTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779214406; c=relaxed/simple;
	bh=QKTf9jiczeUt+Nr4S1iZsRKJwxGf9xWDS0EWw8cuyyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OWz0lj5EMsPHGJbDsgJ4av0YG24TWO1zNHdYHuKDr/zAjuA1cAaT/byF7wjZU/4n5C/dwwfBdf8FNenI9Z2TAf3iABiWpB9iqeYZhaBRyW/0wwe65550+NUYKWZzfzd0MpoYNgELi/DUKoPcsfihT/fGnka5fgyXyAd4Fvd7p7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gned0lzU; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gned0lzU"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7c7fc722b50so28908707b3.2
        for <bpf@vger.kernel.org>; Tue, 19 May 2026 11:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779214400; x=1779819200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rlmyr3CMyFCWhDTHZENVmDr9qrkuvPXB7zyLVILmNsQ=;
        b=Gned0lzUYaamRrNaBxlsifW7Dr43eCrM0Kq/ngi2xm3omuL8UEfur3sbp3gV0N1y20
         yLZFXDamW/p+Aukizeq7xFMD++5lQsu5ZldVijCguMJwleKFxMALfQyb8y/aq3aJvbv2
         Vg6N+nOfXMPCYCMtfQD/inPKHaY0DSL9j/Wu9fYSLAkKyyGrOGfCymWqRp3ST6bWSW+s
         WVuPtwQEEDx5VKuPw34PB/k/DZBPlDdNpItQTBds1TIdjg1yYi6Ka2oOBW1l9M91KkJS
         BAQvjhGGjTSRHuDryOJ1sj2QULzUR1zyLPAGUPnjiTuXdCPlxoXjyVWE+LHcBeQi45S0
         wSAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779214400; x=1779819200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rlmyr3CMyFCWhDTHZENVmDr9qrkuvPXB7zyLVILmNsQ=;
        b=r6fwoaFkzfE0LMaveojYky87wZ86K9VpUoas96somfSyTCb4vBLxLKkYuVL8bde5B7
         kks7DgnK8LGWuixYVv4vVieCxP8AgT3qBEdhhnTMQuYjqqgWYzkCe09QdNpP0SvOnv1e
         Xsd56hXYfyUe3kUjoTSXE1JSPWNKNU7/Cx0+b/IG1nTPuTqvvFCujiVKzjF2xGhqmL9H
         iIdqmJ7/UY/y2sffV6J8mGZh8m95e71xPnytdJcy/dfp0EmCOnY2JVFCfMhGvZjF2okR
         FrSxP+uUWEkjBvTvWx4kilsB3rsgDAm28k4NLXmlUHQpf/evMslRE9CjyrJnXeirLL1J
         qv6Q==
X-Gm-Message-State: AOJu0YxhYlnrjSX9mwCetJIgxYkbsCx+ipoNTvxADGkFPRL5uJ8OANxC
	HQtkpz+yz/c+qMNcFvHWU6LtZQJMjJKOw9a2YpJIu/O88Uew3eWxZua7uimf0BLO
X-Gm-Gg: Acq92OHjntE8kOZToaZknfT4M1GTTlr03RdbF2n1DeofREQET1Nn9Vg6qPRQb39J83o
	LUIspDmDxICRl4QL2xZZc5WX6g5eYWEsZzF20Y+b5lsLv8/hn2aGctnYTTfLbweqW1NWhHX14ys
	lo5J5KwI+S145WDHhUXM2tzlC55EEzNUbA+JBWwnbVzpXJtzyTbhnGun0oATj7r1VKY9JwUhwcG
	vUR9mDwW/PHJs74Hr7yfMa5gj/bOXboBWRfJYRVODmMPYXrd/Qdm0x0IMfgmoKYnRPBsCqC7/b4
	eMfHJfNUmjr3v4R7bQDLiLjW2GA/6AGBuRsNJkmUfZpMdXRgTobTVBHyd7/jLWFiMbZi6FGwIn3
	8LTkO/KODQSYW7v8F7wV904EhSeTdNzLTNfvPegqQ8qQj2cr2irQBfQ6LR/bi/31ZBerzE8psS7
	xhF3vw/Jzc3JMzrt54
X-Received: by 2002:a05:690c:c1d5:b0:7bd:6114:4264 with SMTP id 00721157ae682-7c9594b45camr191016457b3.4.1779214400424;
        Tue, 19 May 2026 11:13:20 -0700 (PDT)
Received: from localhost ([2a03:2880:f806:14::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cc991c9bd9sm40744567b3.4.2026.05.19.11.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 11:13:20 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 03/14] bpf: Assign reg->id when getting referenced kptr from ctx
Date: Tue, 19 May 2026 11:13:01 -0700
Message-ID: <20260519181314.2731658-4-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260519181314.2731658-1-ameryhung@gmail.com>
References: <20260519181314.2731658-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Assign reg->id when getting referenced kptr from read program context
to be consistent with R0 of KF_ACQUIRE kfunc. skb dynptr will track the
referenced skb in qdisc programs using a new field reg->parent_id in
a later patch.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 564679f70afd..441950b43a4c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6209,8 +6209,6 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
 			} else {
 				mark_reg_known_zero(env, regs,
 						    value_regno);
-				if (type_may_be_null(info.reg_type))
-					regs[value_regno].id = ++env->id_gen;
 				/* A load of ctx field could have different
 				 * actual load size with the one encoded in the
 				 * insn. When the dst is PTR, it is for sure not
@@ -6220,8 +6218,11 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
 				if (base_type(info.reg_type) == PTR_TO_BTF_ID) {
 					regs[value_regno].btf = info.btf;
 					regs[value_regno].btf_id = info.btf_id;
+					regs[value_regno].id = info.ref_obj_id;
 					regs[value_regno].ref_obj_id = info.ref_obj_id;
 				}
+				if (type_may_be_null(info.reg_type) && !regs[value_regno].id)
+					regs[value_regno].id = ++env->id_gen;
 			}
 			regs[value_regno].type = info.reg_type;
 		}
-- 
2.53.0-Meta

