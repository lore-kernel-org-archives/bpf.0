Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55673537EB
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 04:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775190448; cv=none; b=Axwu4Lj08aXdrFW/c8tIspVAR6UXuwNmn+Gucm/XtrwKFSb0LAq30TcWxb6hcJ2Y02+LW4YfzPBdbkjWlX0ozVwzTCyLhvXeenr7oyQH4EVHKva6LGwmpY7I1KVwIqH/nB6ts3cjYJePhpzY3oNrAGyXuyCaNEZqHr0QmhDF80k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775190448; c=relaxed/simple;
	bh=BHTqbEiHnbzQxoQMn59TAPgT96iXhsKokmUSRT6r4Qg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gvw9EE25vRDs5loy2ym9D8B4ffFUN8GsNk8aM/1giElbtm92YRg6mPmmlhZodoTR8nvSJE2O84SCudFlYyLVwca3QQVtCAjxYgRgd0ctxQ9blHxokcWrP6P12aeChkOLpI5R7Vo7nEBzSMBtr1DutY46ABN+CLWQDb7VpExV4mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=EY5DlKgT; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="EY5DlKgT"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-35da01fc0baso1026504a91.2
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 21:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1775190446; x=1775795246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mFbRW0oU+ZYgAtOD3dNumn0ssd6LZXksBKtlQoftxLs=;
        b=EY5DlKgTfEl+L41GIeL2Es8403RMxwwCR9grg6cpTugCb574Bu+p0MVRnzGcSeDk9g
         YZRichTZZTxjLNZtr7wAGoiTdjIosQPKYxEcZaIHhMWreG6szAxwtY/qOMpzKU7tXDbL
         liZyLZ188xLUvOrnGgWrmV1DcUDOATeC1V8Ay4eAvSgGHXJBiZ5PXICPFlQU0nfRJhec
         hSuBQXXmx5JSu0nyFStyt/LX8LgiwZD/g0uYvHsDBymPshYQzNRxF4R/gsNmgs0veM68
         SRXzVHJRS4+ZWiInNlMY2caaOMLl4JhAqGK0eqGKdP0s5TnOuEO72B6X+jZPq9zJOLbw
         lnGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775190446; x=1775795246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mFbRW0oU+ZYgAtOD3dNumn0ssd6LZXksBKtlQoftxLs=;
        b=Ncqn7IFckWfVuho14urKJP0FciDK024GAHY+oT+ZHFd/xUI8RPCLy754WXBlr48tfC
         8lrxcTWJGxyIBZBRubH15W33mh7liIDJOl9GkduV2i4S8K96gB8R+qy0h64qBxen1oIT
         V5ub4yVhwzUWZOYgJYew0miw1vJmcOzRmhETQl4basNLNANUBlV6ow2Z8R1rJKsi6mkB
         4Q+wuRsL7xKolgvGaYVXAAwX6M8tnVosMK7iMyaH/ZlxqPqXkHO28cO6cUCcRB/LehLK
         2zEhnMph2G1hVTs9duonD7cAHKxyOhusu2HXeXYxmAsHNN1XR0ogcbGUvs0FkqvFMNOd
         9xLw==
X-Gm-Message-State: AOJu0YykFHXe8CqNhHJ/H2updhuUnHKxhqZFdDopVMHRURCpXEpLPh/Q
	Ve4hSu4gcOb+JukZwczOQHCSszWiIVm0Do7aUwbUBiO5Ol6n4cuSjpAYa2jkWNX1emgcK2kRTJS
	T6YHMZ61fhA==
X-Gm-Gg: AeBDievQOL8INIGpY1hdCF9BX2KjFwCfyaadltXfcaPoODlB6H5d1oBsoUlf/R7Ph4p
	MryajmWcq5aGMiHXl6cXgU7A6Tnw0mAQE+6I9JMVYS/jOxatybrczP4yzzRGTIJ3ADF8XwKnHjy
	vfxidEOahjYcOXeo2GnMtu9CZIHtrhBOdrNTGU65MKe4+/UTx10r15CcPpkN7z5BxYnTKS04oAN
	9d827FuqTmouJUYUkC/BtxUcxardolK4NCVaQIM6va8/702UGiFS+9ZZ50Hc0SOywf5tSl9G0R2
	CTWEntvxi9Oz/bsWeK3tSyIsm8Pp/5C+MZ4WGqxz49FvjJUAra+HSWa7jYEwmaftlhS3NdsD9M5
	Rt43VgprVq7kev5FP1PJJUpX9hDrFAakqRwdmYooi3tvtkXpGYT1wV4wzifB7QPESqro34rX1DO
	PjdZRW8TBESxnT
X-Received: by 2002:a17:90b:3b86:b0:35b:a8cf:7960 with SMTP id 98e67ed59e1d1-35de678fa63mr1363843a91.3.1775190446133;
        Thu, 02 Apr 2026 21:27:26 -0700 (PDT)
Received: from krios ([2604:3d08:487d:cd00::5517])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe937925sm12970449a91.12.2026.04.02.21.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 21:27:25 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v3 4/9] selftests/bpf: Deduplicate WRITE_ONCE macro between headers
Date: Fri,  3 Apr 2026 00:27:15 -0400
Message-ID: <20260403042720.18862-5-emil@etsalapatis.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260403042720.18862-1-emil@etsalapatis.com>
References: <20260403042720.18862-1-emil@etsalapatis.com>
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

