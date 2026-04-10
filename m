Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3B33DCDA3
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 16:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775838664; cv=none; b=liOmM+4N8c9RkWo2cqgyyTVnAoOQlFX++giomritPzdFasp+FIq6+XGej1OOsq+d/QeLaOwTD7Hb/iNTEh0Q4aVDddO4l5xVQ6n0k+kbyaSrmq+R3nf0muiRIdE4MN3f0Hk+6wVw6j63cm3KRQScNSK9+cSVeROxhjs5gcPe9xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775838664; c=relaxed/simple;
	bh=qf0RBOV2DBi8ccuopXLgz95L3fS68pTpglJpoI0eMpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s1RmLEdJMLdR5WvSf4COUGr6Thyl7lh3/dWBHeOgmgRA6ZoztdosTakVDoDHrd4iP0x84nLOznylnRPYXJ7c5qH7DnMImTK+CBJd2WNrVsqAVV5emjJrejXktbUS3inWVxze9CfS0s7G2Ynt2wgV+8gF7IeFw08nNr57WVDgnMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=vZ//EM0R; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="vZ//EM0R"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2c7d8bbad06so3745575eec.1
        for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 09:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1775838663; x=1776443463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3fHKeGW3Dgjw6ItK8Bh2quX+jKhU+wtMFk7W6jPR2vM=;
        b=vZ//EM0RZQI98+YDcsSr3s97el0dIxmKPGHsH6fl4pssZqUofGDZYwFAnvp5WiVaX+
         IfKbh/ISshaWg2BUsOWkzDG8wP7xCPTrWz03t+j19p7S5tgJEeeD/N7Vh33C5pciFuUU
         gPKHma3OKHc9YPSMCDFJJj+bq2W3+7htQQWjynTNCnq17EsAX5hgTBap2FaQjDyM6T0v
         D36e8z/GCkxO7NMCAmhIyCNrk9jUKn9ipcOigVvCmkHr7twB6/fX4fDW2aj8fC/TyTVb
         EqUQDtUAuaEKPjiK/DYZzYbwuyPa1WEL2Bz1T/MGKqR+pmVt/GTasyIxakp5vSDhowQs
         knSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775838663; x=1776443463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3fHKeGW3Dgjw6ItK8Bh2quX+jKhU+wtMFk7W6jPR2vM=;
        b=i5NgOTy6iGxIpknyquBKtox7plS/74lSVrQa6+s5UwgHFStig/1i2gGunuGeTM5oT6
         g5i0PXJRl2MFjdmFtYVlDvDtQrAdotc6yaXEDm0qUai17lMz3Gbv3gZgqbORKQhHvWQE
         fy4YYjldy4aq0Uv5DsnQVaAXtVyVH6mi0js0/v0oENWkL3RgPJTcIJywyHUhsTKz2KDJ
         aOMN9+SqGyW8I5dKZQRkiv4w9cnCyUKtVQw9yx63u8B9AJ9l1Et8snauOj19wt2Id5pf
         huXL4QKrBn+C7NfqvAleH4BOzd+rHr1fjZQ0kEyEHAuWphmkz80Bv+2bDsJGvHow/1ge
         NBMw==
X-Gm-Message-State: AOJu0YwTsPD2gd3sHDb2v8Xed/sULOewVDUmQEXi/v9GTH0YmHY6iGO4
	WSaeIpF4ub1B0zJkSvhgj2pF8IYNBsuIwozaSOIcKLZelKw8bz4oh6f1thXgbCpbBUEDCgA4yU9
	dQkdG/no=
X-Gm-Gg: AeBDievp2EYqTzAd4lKLEiYLE7a5cPmnG9zCiO+B122UyQ6YUPgEK6HjESDy0PX8LDj
	jxxr+F1b9qGisFnJxI0NWbCij2tbH7O7bLfqtfiTypJyV63PCfCR0aSfTOtJ8pW81Df8Z4aijzP
	ZzQRqKILSUodRwBn/1BcwEwCY8SDA5jC+fyjeLltLBiNddT6avxLIvfBRnSRmCDNVBdI8v5mg86
	Q8yxrq9GOBJjRWuC5MJORHMpvRPXEHSsF0O3PWaNTOv8TjehoBC96/KgonPo+NgLdQfBBo/ezDl
	rTOGzu1Meu3cpvrFQcGBgXVAEfPMln/w1rn97jpxMrtWZErPuNReJrW/MVrxdMAHjhIUmLyinu9
	x4V220V2ssC2SV6Q6drTqoHruOeOdaR9eglT0kuBEkOEPIs9OYK0u1okalJoUGMWRDNL0qBarhH
	q4TAHwr2orUWFag9lT7fo=
X-Received: by 2002:a05:7301:3f09:b0:2b0:571a:28a5 with SMTP id 5a478bee46e88-2d58956ace7mr2462147eec.18.1775838662580;
        Fri, 10 Apr 2026 09:31:02 -0700 (PDT)
Received: from krios.corp.tfbnw.net ([2620:10d:c090:600::6eaf])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d55f5c69d5sm5642619eec.3.2026.04.10.09.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 09:31:02 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	song@kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v5 4/9] selftests/bpf: Deduplicate WRITE_ONCE macro between headers
Date: Fri, 10 Apr 2026 12:30:36 -0400
Message-ID: <20260410163041.8063-5-emil@etsalapatis.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410163041.8063-1-emil@etsalapatis.com>
References: <20260410163041.8063-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The WRITE_ONCE macro is identically defined both in bpf_atomic.h
and in bpf_arena_common.h. Deduplicate the definitions by moving
the macro to the commonly used bpf_experimental.h header.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
Acked-by: Song Liu <song@kernel.org>
---
 tools/testing/selftests/bpf/bpf_arena_common.h | 4 ----
 tools/testing/selftests/bpf/bpf_atomic.h       | 4 ----
 tools/testing/selftests/bpf/bpf_experimental.h | 3 +++
 3 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_arena_common.h b/tools/testing/selftests/bpf/bpf_arena_common.h
index 16f8ce832004..a0503ecbc315 100644
--- a/tools/testing/selftests/bpf/bpf_arena_common.h
+++ b/tools/testing/selftests/bpf/bpf_arena_common.h
@@ -2,10 +2,6 @@
 /* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
 #pragma once
 
-#ifndef WRITE_ONCE
-#define WRITE_ONCE(x, val) ((*(volatile typeof(x) *) &(x)) = (val))
-#endif
-
 #ifndef NUMA_NO_NODE
 #define	NUMA_NO_NODE	(-1)
 #endif
diff --git a/tools/testing/selftests/bpf/bpf_atomic.h b/tools/testing/selftests/bpf/bpf_atomic.h
index c550e5711967..d77338ac7e6b 100644
--- a/tools/testing/selftests/bpf/bpf_atomic.h
+++ b/tools/testing/selftests/bpf/bpf_atomic.h
@@ -40,10 +40,6 @@ extern bool CONFIG_X86_64 __kconfig __weak;
 /* No-op for BPF */
 #define cpu_relax() ({})
 
-#define READ_ONCE(x) (*(volatile typeof(x) *)&(x))
-
-#define WRITE_ONCE(x, val) ((*(volatile typeof(x) *)&(x)) = (val))
-
 #define cmpxchg(p, old, new) __sync_val_compare_and_swap((p), old, new)
 
 #define try_cmpxchg(p, pold, new)                                 \
diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 2234bd6bc9d3..56214f7051c6 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -11,6 +11,9 @@
 /* Convenience macro to wrap over bpf_obj_new */
 #define bpf_obj_new(type) ((type *)bpf_obj_new(bpf_core_type_id_local(type)))
 
+#define READ_ONCE(x) (*(volatile typeof(x) *)&(x))
+#define WRITE_ONCE(x, val) ((*(volatile typeof(x) *)&(x)) = (val))
+
 /* Convenience macro to wrap over bpf_percpu_obj_new */
 #define bpf_percpu_obj_new(type) ((type __percpu_kptr *)bpf_percpu_obj_new(bpf_core_type_id_local(type)))
 
-- 
2.53.0

