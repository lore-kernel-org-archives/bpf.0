Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7BE361DBC
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 01:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780019384; cv=none; b=lENiq+EvxstVtCEkz1jp6Q2cbFZy886/2Q7yggPYg/sPQ0sXstvUIMHgNn3K3oLCJBbVcS/TDPgBI/5Ovxe+AKjwjqyyNYqUjk7G8U0EtoGA2JJ0ECMmaTVUhW+3H8A1SjD5JAjNOCqNnxXYn/UrUpMqsazeWNl9PlfnUiTVBDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780019384; c=relaxed/simple;
	bh=pe8s9TVFFol6JHyr+MNp/5iPOnewMEboT/fxjDbiS2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t3XyhZLnqkiWiFH8BvKshpqIQwIZTIWMbytDWWxKZkGTUzmwBQ0psS23pxgWNWfxnCP4815ki8OWwj9DcYhmQhT624GBkYZzTG95Y47ArwCpnvidPMBXN5Qd8x6+vJpD8zMSq9GPj2eTowq/nkNHkPoUNNnUlHPRB1a6xVqnrfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j0KGR+If; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0KGR+If"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2b9e9a6802aso58601505ad.3
        for <bpf@vger.kernel.org>; Thu, 28 May 2026 18:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780019383; x=1780624183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2J+IgdoEHYeF4G3sj7Ia8qLZGV8/E+K/UCZOiol4nfM=;
        b=j0KGR+IfA3duNdPkVwpNDfn1dP5WkYaKm9C67IIF/YNreXjDmSVIqX7H05Q58ZCJD1
         G/WLWx0LXCFJqozFLbZfBrELUAwnjDLMHfI8FSzzr4A4WqRoXi4RGHK8tbdvbjoR6MOs
         hFBaESfcsLCNxXrTDtJB51/klhFNPbnU7pjc1GgarEDuUTjE4rWYxrIHOMW5PEJFzPXG
         G+IRxzu5Wzgxl7hw81vxhLAUBli+BUS2w8DS7TnZkZ4CZ07MbKvtCQAFdJN3YA2hshMt
         Z/bdadKotPsgExoSMCGOXXXOYRj/iHcPPqHEol9n0pxtR+2qhXPk/SNyW8JxzIC0F96u
         BRbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780019383; x=1780624183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2J+IgdoEHYeF4G3sj7Ia8qLZGV8/E+K/UCZOiol4nfM=;
        b=PNUym+V4S9wm8yui+ZAunIvgTFpVMlPdUXHDlnTtcMnpNUK+fF1GE/SPNwb/DGkq7w
         wsDLMqv4sDNhBrQzIRVdgWrpzxk+ij5Qx/a7qqfu/dMNzCfUmjD0OOvyMozGcM3h/uDD
         0ztBoOuNeqkTZpyZ/hdKjCq554xvpl8uugAbMHTCo3g0AoOQLZZVthtglvJbSgzYb+J9
         s4IBeP4YZKEwcsGTpNbAXDlFCQL3QHMVYHRn2UQfdF+Cq8AS+WJhp6umMwhh6bIbWhWC
         qr8P9CghbU0dw2vtMNp1/qHLSkMF5+9AsrylSjT5vZYAEiqH+2uc4HvMu8pHp4pqGheH
         b0fg==
X-Gm-Message-State: AOJu0Yz+1MvGA5/b1aE0117iixc/QpKjTGXVE34z8rClZGSd0TqHm5lX
	1isUB691cnYCvpFLKTJcXj1f7BaccJgC9LqivmjycKVcJ6I/XWbSgzE5cTgsUg==
X-Gm-Gg: Acq92OFfjo3fVgONO+/3l3MBe0Djyxa7w3aYOxO0Yy+Dr5n1twYNvGFjzxiahhVooMZ
	exnx2OTGe4WrXydOE6uMVYGs61jGnUDURDKOifwOdRyK5YqEZ+N4HviQzf4J/QexYOmLOIX+Miq
	a4L0OK/Rjnx24IoHFf90kKf7bzbbLPRL9vgq4FsBqRagMPfUDhYLv9b2yrsvqlqbdDGLdIskGZY
	nj6MsekYTSapUA3/gJ7PT3mLuf/u8zabdy9AcMxiLapUk+ZJ+/0v2l6xlYEyPM0vhw8vhfu7GQK
	Y9mm7+isz7PIj+wJp3I0GXTuC/hqYmQQLPV1+WEvixmq299vLU1XoqjBNPOPYifWFu8b03aldIm
	6W5LBh7rj48yoLBtOTN0LMotChlt4rUfPXGgjcggnZqrBg/5Uk+ujDMFqYu5mHW4hN5g7yfbAtt
	dXddRAYy/IWOIpmYiwbDw/2gtS
X-Received: by 2002:a17:903:948:b0:2b4:5e0f:c239 with SMTP id d9443c01a7336-2bf2063dc45mr11713455ad.10.1780019383016;
        Thu, 28 May 2026 18:49:43 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:55::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23a0fea7sm854665ad.29.2026.05.28.18.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 18:49:42 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 03/13] bpf: Assign reg->id when getting referenced kptr from ctx
Date: Thu, 28 May 2026 18:49:26 -0700
Message-ID: <20260529014936.2811085-4-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260529014936.2811085-1-ameryhung@gmail.com>
References: <20260529014936.2811085-1-ameryhung@gmail.com>
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
index d29846c4998a..552840d8d2bd 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6208,8 +6208,6 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
 			} else {
 				mark_reg_known_zero(env, regs,
 						    value_regno);
-				if (type_may_be_null(info.reg_type))
-					regs[value_regno].id = ++env->id_gen;
 				/* A load of ctx field could have different
 				 * actual load size with the one encoded in the
 				 * insn. When the dst is PTR, it is for sure not
@@ -6219,8 +6217,11 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
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

