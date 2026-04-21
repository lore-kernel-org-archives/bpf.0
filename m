Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59FA3A0B3E
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 22:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776809422; cv=none; b=giC9cSSuZh5q9B1kE7ZXXc76M98A/7lcktlE9+EfHFZsuv4ufUbF5GSSn5YwrhYXgrOpnEx96sKa9CQkAWHrm0xQZvXUYqraImbaFngxsoAk+iIzVelGpcV9kxA7GDRh7RKNLkZeBkD6PkbBd+jHtMZxAdroxJTkm3vA6UZSNzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776809422; c=relaxed/simple;
	bh=8P7GcnAnWIUAzSkkjW9oX7NjlLj6pYx0OwoExnLCh7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p9tmiqrazexlWyn49rtop2A+/+XbQCy3W7bbnRPI854uTegXdYJEpmKmoGICGiKyfuf4lag62CY2JjudJHG+FpZitkuZYMzoMUsibvI1w0zxj5dGQPMoIVjO/2SSXIpRxlI4WDX9tdPtMRdKJHBkeEb2r+5K+fb6IAvYPBcf7jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pLlV1vzr; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pLlV1vzr"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-35e563b0ee7so2270014a91.1
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 15:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776809421; x=1777414221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t4ZOy56vWlLqlNhtiTENtyLjo+fmzW/yKvl1RKvS848=;
        b=pLlV1vzr3rPHGyIZ2L7Ae5xqfq6SXc9GX0UaVwbv33vityeVQkirC8Pm905MIXhgo6
         y+jjMf8OgQsMNC3SxPa6hmmeHLnnUuNyyvFB+z3z+9wV1cpafSnzpmX7aZ7mBXLDodMD
         9z2ve86WRHMn2oihYQ9LqS9/PPkTGjNDoTc/Haev8NPeKV8WPdhzkU7XS99odeVWG9jz
         y1TMHZ6uxRMj1QX6tKGpMUw5pQoT4Wzu4/GydL4JbV44QcTkvPrAboN8eXPE31lPgR9s
         XcyWlB66VMeT+cTzcjloEaWLy5cLCs+XikLxx03Mp9UslUY7DPDNle+KzoyVXywKH8AG
         LG3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776809421; x=1777414221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t4ZOy56vWlLqlNhtiTENtyLjo+fmzW/yKvl1RKvS848=;
        b=glRXJ1lm64HaT8sVqzleXpyJfmJ2GipxItCVYaaaRmYN2vhyDfdtjPN1O2DVKCW5sC
         ulxMhnwAQrivHt6uZSGCu1M6QdyVpA7USxeNuJ3wQBY5Pc0mRotfL1upy+eP+Ctt56Rh
         /b2rrduBXT2zcdX+WIltqApqox3Unxh2xvYJhbt+Rn0y0bpKw/dgWayMFAxWnoH2iGey
         pxsKkLzNm/BRJ48+VYKL3rWCiQ68q91zK4DOZM27zaQGjJjoScNfhQ/5NLg93QX2AmS8
         tQ2GFtH5xdiVIBMwlzlKqvM+glTT3ep0Z5ttlrGd3S+ZbZNjRrwTawfP/X2Ts3pnLO2P
         qR6w==
X-Gm-Message-State: AOJu0Yyih5PHa0/6+uNH7LPBr6YXnT+RcSQUHnu/sPNfaNuxGKHMm7JY
	E1RMfGKeZoagqNpJVCI5HmWo6QqEDVjOufAjMSxdMw1gtt2xRCaO9pU9M/u83w==
X-Gm-Gg: AeBDietGkNqCfXbMWcSnecFEhl1WL9wnuTzEt3ZozNVS0wEC4i4/ug8VXcMFJ4qd6N3
	Cu1QU34BQ+Cc2faBPE8DRLSM0OqJ8X7onRnk9Kso3NRg/cur71LuLhwnRUYfsWhjKSmZE/KoNGm
	WxYQDoVLaDasRJKWnbOqEsf2alwFdbWxF41E+nx2JrruUsl/O3gjcU9L7STp5+arzG0PUuGoNH/
	SxkfLZYUuh2JtXvrTMvF62mmCp/EL18HZOjBK26J9aVaFM+dRwkMO9bufVMXmbOQrBnJkXfaG3o
	+ppS8Mqga6Orjvbx+1Dy0/inPT37WTkcZ9Brud2Lgv93BuY2nbZUqawrCMKsObD2fUXvgew6NGn
	34AQjXNd0Ghtl9FdCqAngu1doNUf5pGGV4imJK9L4mIMWj0QhbU2LrsVRD++TekY/xwnsCWE9ed
	U8HXJ2oWDFzjgRG2I6ZaAIpZE0
X-Received: by 2002:a17:90b:2884:b0:35b:e4f0:f9b4 with SMTP id 98e67ed59e1d1-361402908eamr15151234a91.10.1776809420957;
        Tue, 21 Apr 2026 15:10:20 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:59::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36141869e88sm14437574a91.1.2026.04.21.15.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 15:10:20 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 2/9] bpf: Assign reg->id when getting referenced kptr from ctx
Date: Tue, 21 Apr 2026 15:10:09 -0700
Message-ID: <20260421221016.2967924-3-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260421221016.2967924-1-ameryhung@gmail.com>
References: <20260421221016.2967924-1-ameryhung@gmail.com>
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

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 41e4ea41c72e..93003a2a96b0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6448,8 +6448,6 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 			} else {
 				mark_reg_known_zero(env, regs,
 						    value_regno);
-				if (type_may_be_null(info.reg_type))
-					regs[value_regno].id = ++env->id_gen;
 				/* A load of ctx field could have different
 				 * actual load size with the one encoded in the
 				 * insn. When the dst is PTR, it is for sure not
@@ -6459,8 +6457,11 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
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

