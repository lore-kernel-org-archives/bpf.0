Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64CB30C146
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 00:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780360889; cv=none; b=qsf70qI0d9iXqJMGwfdUUcmdG5PFXrZk++AEDRPKl4w0tPq22N6D8yzG+jKGO23+EfXr/3D3tigFWe0yL9VxCp7eL1hy/7UWGu9iBZ+WC8A8lAvHCGFd7BYy3xt0WM9In9hTlHG7t8DsrYDI6nE4oXeN/os44pQ+ZMktLtNxa1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780360889; c=relaxed/simple;
	bh=amDGO6NwBQwUrSVSGm3wNBcPXIW/R9e5ucYSLCM+UDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tRBaMU3YZk7NUkUnq/c2zRUw1OMam+YkrBVRNwnNUac0xkCiE6Cbu7nD8FeE541hYKeILAu59//LB9rqPgOOPIIh4goNw/WqdKjnMl+5Es1noabPFCK/g5/rRx4dVsvSHdpLRd0+5QeuQ1R4+tEZgANmrFPf6jguig9GybGBAU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=ETO1HDR6; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="ETO1HDR6"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-304545f5206so14842659eec.0
        for <bpf@vger.kernel.org>; Mon, 01 Jun 2026 17:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1780360887; x=1780965687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hz6BtmoYYXtqDOrcjjpGC/v2MlsMtEJzxkYQRF+8tMU=;
        b=ETO1HDR6dh6N/w6jaqySkn22zLOjfosFCGskT3vNP5IAOK4yPMP8aI/LgnS6bRiGG0
         TnTeNbsY1nNU22fPynbGYO/xCNkEQkiiFF37WtEIn5kZ+/cU6/VnTOYasyXRu1opi+KV
         GBR6BzigU79aNuIGSMLt7igMl56EK/Omz84Z48n0AraM7G9vHf6GvjHnaG0clWp0HVVh
         8abdHHuR2a3/SarxdVpx3YVymsmoNtnBB4H7nQj9DO39/mnej3pJ+iVbMSDF6UIEJC2E
         7JXYFHmbCQwyFtleFhG23sGJDYTd9tLW6hxiC8sBfWtZlPS0EuNuL/ZyHm5my+gv+KJE
         THVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780360887; x=1780965687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hz6BtmoYYXtqDOrcjjpGC/v2MlsMtEJzxkYQRF+8tMU=;
        b=YVBXebY4dOg7HLUg207WUP6xHvYgg959B0Y/5MPHmLXZR/8ANdlvJenLVGvw4IKWIF
         EKjIz/5uiV9C0Mun8wCDM+860KKztKBu1LBmFd65VbcSdQ8domnh3pOVAWwg/d/TWK30
         XN4456ZHGLAUrwP4oShL86CK+xiUlGlel2O/utCi7TARP0RfMCQCKFAZKws7Xuevzn8s
         LBiXCf9LOaB2tLpKJdBfHqJyVTNoiq9e6oERx6lCPJtsQ1d7ib+zcuaVNjfQGbK9MMR8
         Aoh0YFmE5AJ1jC45UKa+dLHcBht+/XZbGEjzynrriz3KM+RurSIh7moMvJpKlqvTz94d
         GBDQ==
X-Gm-Message-State: AOJu0Yy8EKlzjzJbftdbb5ZyyunsqV1Ncri2yBSE575AMhIosKh1FSnS
	XTs6uBeGlEe/a/0YeDAZiK4mQh2sQaJtmWixQNcXZEx5TQU/oOrVIRggTu3R5G07DsaNtkVTyKK
	YvcCA/pSaYU7c
X-Gm-Gg: Acq92OEQjqVhyk04LRZ8S5CH5dJv9VR9rreRoZOpJ2vWsgeTN/hWr8BdC8OQBtt6Dh8
	a4JXxd8WQFTYToXs5PjDHn3v5icnC+ibeD/jui+1Ab0z3p5P1Ook+3FvLzdioNt9qZjodMEVqkF
	rgN12y0Aat9oBQ96MsjCaJrRYbrCO4IwULH3dK6dsdbQxmIdTzUh6S3s8kMigliBgR9eJeg9bYc
	eFeTJWUV6eJdxyTiobLaRjMVvVLy7Ot+xGoINqIoorsYDLf1/9+OlZobcvzLaO+Ul8+aPl45aZo
	wC7C2yk7edp514litlmup/fFlPFTUH/uLH97CDm0Knl06q5EmUYdDAOIWgV8nQlbWVdSqJSU6BG
	PeS6EnpQze4s+O80Wx0GCc5tNci6eUn5sFSCzOr0T+WRnDkw7wH1YpMUmSUC6/VBS+kSndQnCdH
	poKZYSy9FX7tFfO8WJEcXTMK0oA+KVWWLyo/My10v8
X-Received: by 2002:a05:7301:4883:b0:304:8364:e95c with SMTP id 5a478bee46e88-304fa4fcce5mr7057686eec.15.1780360886919;
        Mon, 01 Jun 2026 17:41:26 -0700 (PDT)
Received: from krios.corp.tfbnw.net ([2620:10d:c090:600::4f12])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed5d5385sm10172018eec.28.2026.06.01.17.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 17:41:26 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	song@kernel.org,
	mattbobrowski@google.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v3 1/6] selftests/bpf: libarena: Add "arena" BTF type tag to __arena qualifier
Date: Mon,  1 Jun 2026 20:41:15 -0400
Message-ID: <20260602004120.17087-2-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602004120.17087-1-emil@etsalapatis.com>
References: <20260602004120.17087-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The arena qualifier currently designates its associated type
as belonging to address space 1. This property affects code
generation, but is not reflected in the BTF information of
the function.

This lack of information at the BTF level prevents us from
returning arena pointers from global subprograms. Subprogs
cannot return any data structure more complex than a scalar,
so pointers to structs are rejected as a return type. We
have no way of marking the return type as a pointer to an
arena, which is safe provided the two subprogs have the same
arena.

Expand the __arena qualifier to also attach a BTF type tag
to the type. This lets us determine whether a variable belongs
to an arena from its type alone through BTF parsing.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 tools/testing/selftests/bpf/libarena/include/bpf_arena_common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/libarena/include/bpf_arena_common.h b/tools/testing/selftests/bpf/libarena/include/bpf_arena_common.h
index 16f8ce832004..445be3c4edec 100644
--- a/tools/testing/selftests/bpf/libarena/include/bpf_arena_common.h
+++ b/tools/testing/selftests/bpf/libarena/include/bpf_arena_common.h
@@ -33,7 +33,7 @@
 #endif
 
 #if defined(__BPF_FEATURE_ADDR_SPACE_CAST) && !defined(BPF_ARENA_FORCE_ASM)
-#define __arena __attribute__((address_space(1)))
+#define __arena __attribute__((address_space(1))) __attribute__((btf_type_tag("arena")))
 #define __arena_global __attribute__((address_space(1)))
 #define cast_kern(ptr) /* nop for bpf prog. emitted by LLVM */
 #define cast_user(ptr) /* nop for bpf prog. emitted by LLVM */
-- 
2.54.0

