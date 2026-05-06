Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1CC480956
	for <bpf@vger.kernel.org>; Wed,  6 May 2026 14:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778077641; cv=none; b=U6Y7vpSru2fPj6jJ0hcM8ORikzL60Y13OmacbOASYUEENEZbQvltNWJyuAg0dNvkey0qEF/W2iF+zY6/vhKF4F5sTwmDeNNi2Ccbq2KlIj44fapLnuafzfDf6Yw49tY0wvAptO0BwyHUteNGwft+sPnmyRkKjCviTlt10SeeyRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778077641; c=relaxed/simple;
	bh=wmdUGf/93UtDgB3jPl4ukhsU5LqgxbxRvydj4y9Jy4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nBDdTW2WcDrtpuWRwOuV0IO4e/waRvtxTRw+XeT4OG1fxB6hiMX5xnekCYN/loWbNNljh6bC3/xyAbS0b/6zBBvG1LN2VH/8jkEYAcPfuAPvCuLIUMaXLh4QVAr+lB4Xx+zuDZZyLLUf+dbi+FVCFOYWdlyjdm6+Ehr+mRK/zAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M0MBuTuV; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0MBuTuV"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8b74b460d77so42833206d6.3
        for <bpf@vger.kernel.org>; Wed, 06 May 2026 07:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778077636; x=1778682436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7M97x8+tCYMnMtmQ9rpSLuRG7Q0JR91etii+VlH9NO4=;
        b=M0MBuTuVhBJLMzU0Ozanwxnt5qjFGcrpPjJnZLkHz5VtyhIvZ8U5V656ZnKkWAuPNT
         V5GD7q3JJ6aRynnvPPWaA07dEBEWO+iQRTtcisjCFj6IqAkcqHEyHe1kMRfzXjg194TY
         Bx3BaSjyUeZkm4GfyatgZp6wg4Sy9f2V+QQRDQIK50h7sbDC/LKukXqmxEav1J/lqkTK
         3dqrn4LkDGgAzS3cWI3i4NQiXR8q1sTIxbD62T58KIBmbM9Zca3imMxVApsDF6T1VuWg
         uKpyO6a6Cnhs49tWVUsN7DSQnc5aFcEyKWHgy/P0MbMT7Jji220qSlYAOWwPTHSWzqcM
         Eqag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778077636; x=1778682436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7M97x8+tCYMnMtmQ9rpSLuRG7Q0JR91etii+VlH9NO4=;
        b=kRG//X/nqzUyEghOpMKwkwB1rtwSR+bbla9xAflBmgb02/39ua67H1l4QCSjeBzmZr
         AGan0aKMs46LjGtlsWUzxShyBMsUr017KWMF3Z/p14wxzhmKsiKdWC00mqCeH14lbx7V
         IMdhJeA3fFeSrzFFtiJuEIygx4wCbqhsMxF0AG18pg7fdTVGAxzhPt07CZ0Xf2Qskymt
         1IbkG8wZlMvJKz1NjCqqPT2YuT/ImTMGhMNrnQDK5GOlZWrt3wrM2f5CZqZh5FOUZKEe
         ZPh4ABsVL5C35PqrnxTnO8uNOfA3o0UIwfHTQGPu07Cgj4ESCsrrdzjzL/NeEgysts8z
         ar0w==
X-Gm-Message-State: AOJu0YwuJiNJOrqkJil/8B7aumTj32vUuza19es0klL4NS9mSdaySwj1
	uFNPPtWejnjVMfPrpaFa88zDcIip3Q89hDy+BFBlIkczYTBEc1orOlW4wjwO3rAGJIE=
X-Gm-Gg: AeBDietuV0v9WlT+aLU0GS7uQIGmP4NmL8sT5vWAy7l7LXYgrBLOjkx8VuskzLIiXX/
	hBvPuw/wX55ZAvBzTlAUU0mM41Ws9oUf0C9H0wYOcef3F1PX+ZC3UBokCviJ8v0m7JtpuwyfYPN
	1OYZvoc40hotZKgCs+fU+O62YkEb9y5DXF88dT8tYs/uCdNoNugU7RLGK+X7nDr4qO/+Effp9h6
	U5r7qe+BykSAQz9Vqxv9++aMTE3wW/nPslaHRXUDJu5Cta8Mhz2IBK+u7UcF1e2NVJop0Pex+j4
	lJ/4aszH+JlZuorg2ulW8A1iHLXI7wjq9rakXyN1FEaCjeox1jmvtHBG++qsM24dGwqT5dEnKC1
	Jr+zGDhK0iGj0cRdjhAXpS8dFg2b+9qxen3KHkwhmqrx6NJzgXGMfqVIycEOCLZaVjRd90pyOAd
	oCnF9tUknkUNk/o4Ruo258BuzVWdM=
X-Received: by 2002:a05:6214:1d2e:b0:8ae:61f1:c562 with SMTP id 6a1803df08f44-8bc41bca521mr55140206d6.6.1778077636160;
        Wed, 06 May 2026 07:27:16 -0700 (PDT)
Received: from localhost ([2a03:2880:f800:28::])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b538b1d953sm204888676d6.3.2026.05.06.07.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 07:27:15 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 03/12] bpf: Assign reg->id when getting referenced kptr from ctx
Date: Wed,  6 May 2026 07:26:59 -0700
Message-ID: <20260506142709.2298255-4-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260506142709.2298255-1-ameryhung@gmail.com>
References: <20260506142709.2298255-1-ameryhung@gmail.com>
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
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0bee6279c38e..0891a3ac4d51 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6057,8 +6057,6 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
 			} else {
 				mark_reg_known_zero(env, regs,
 						    value_regno);
-				if (type_may_be_null(info.reg_type))
-					regs[value_regno].id = ++env->id_gen;
 				/* A load of ctx field could have different
 				 * actual load size with the one encoded in the
 				 * insn. When the dst is PTR, it is for sure not
@@ -6068,8 +6066,11 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
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
2.52.0

