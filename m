Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85913B4E8C
	for <bpf@vger.kernel.org>; Wed, 27 May 2026 07:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779866109; cv=none; b=dU3xUvi7KvbUgj/1vO8IdLKH7MWIKx/Ko54Tgi+D1HPvSW3kqLlNkDLuF5+K1XmxjPl2+sT1hMLea7juuga/0tdwdi7ex8wiKQknE9yWjjanKKABgtQ+XaJRpLCbj3jf7TgUJ8H/Hp9LB3T7bx2nJDYUDFWw+JRx8UDdTTIuyaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779866109; c=relaxed/simple;
	bh=amDGO6NwBQwUrSVSGm3wNBcPXIW/R9e5ucYSLCM+UDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lKvX0FYeDz2mnCya4SCZanPIQuN1WwJZ63yZiwQWtGrO1Rxy02se3zQXjtxgB7OfaHKatA235jdOmsQvJ2qiQDuioxGwXoRt259cK9HpwOqsxbZ8slHGmlq2BRBOoK/e988O8QlG94ZUpQZ3uW+E5B+gKtJyPoCn9lahANZTEdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=fyr4Ww9m; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="fyr4Ww9m"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ba3e3c4f87so118621575ad.3
        for <bpf@vger.kernel.org>; Wed, 27 May 2026 00:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1779866107; x=1780470907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hz6BtmoYYXtqDOrcjjpGC/v2MlsMtEJzxkYQRF+8tMU=;
        b=fyr4Ww9m7E2PNgqrAGrGT4CSBMn5UbMT2qV1wIEMSAG8CMek5LaJShvDo2GweKZ4Pp
         FU1iqROnaOvvrMqS8LT7LUbF+mKAAtuF4r0iebkcPUeAqMbK9i7DKp+C8FxCJNAOug1X
         KWF4vdjQ9t7QlutTu6vpB66vylViIonS4HsHVwHtokDTnuEBHPqjMxss2qw3RS2HfdIK
         rpSOPHKpE1QxRUX43IgnYhWYnHVFxUj0+KXqhxwVibpKVOdNNBTzlapnKdFDqxh7ww/3
         zTEIbFJBtfGpZJxmcX5IWvMhgRWX0DQQ/yXYbjZZDeo6icbvZ8Ynr11Bj9c3k3f6Vm0P
         qTaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779866107; x=1780470907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hz6BtmoYYXtqDOrcjjpGC/v2MlsMtEJzxkYQRF+8tMU=;
        b=mKkoUA8HuJjMbHZBiOv2LAfkzIQsyrQKAVonCpemnhHDPg82VIxrGqPbzwaoH/jIoR
         VCxgLWJgcWi+xGbnYSFXKUq8GeBeNF11mUxI17BIdd2K54Izrk6eZG6U5J8OB8R/Fqrm
         D2PIsaJZqCe3Yg5IAgqFshiZkduaBXB83lEwXBDIdSDkvtOL1P8SDwtCP3HalfZyGUU6
         c16hBRETTx/G8P2HcenfUeBQBcpDXoTaZKzKmc2ofCXpQL2KUuB6dlAui5Tx8YJO2bDE
         1wnufQuUIaYOs6mj399HxLfn00bBdjpSaOaB09r2snsle/n3OsMkRK6N1qa7TJbqm8FT
         FcVg==
X-Gm-Message-State: AOJu0YyaDM5KIAMNlhGA1+IQiwGYnhH89Q67irCGLUU0tc0IfDz0jcOd
	xhq5wdFAimcI0o0uusKsVLIc/ftqWKdK0GmZsvLsdZvE3OF3aQYdBXdgY/NCBL33liNru4p84j3
	U8dGGdpPyqQ==
X-Gm-Gg: Acq92OHH/w5o4k+plVOmIjBVFi7gCSmxNWdDrg/1KEhj6Sm9Hoc68mQDpLhRrQwCiJV
	ZJCBmVFikx8/7MmQw+uJJKto5hpmXkXtZe8ox80GjbhzY4YNlaVldoUAAQhi1oYykM1DVbwJgkT
	bXYw0lcsHMxDnnYxN6f96a75mPhDZn/2H8fRGCNPRMc+ilzpjN8UMLN4wDgoogvPR8m1x9fqoaS
	Z4NvbqiV7tz2AOKQ4E6P6FB18s2yiwoAVBexjftxqRhKbSMD+52WJpQRgZx5ypL4iIA1UDTIajB
	TTC2/NZkKmjMRRJp2IZsOZDewPCoaEB+yq0LN/XBulZ6iHEUNHNgQQqKLi3qisbaITbGubN9gEP
	csTZvOhur2BPt/JygazkXSQsAPOe6Locy5CjtYOP0XMzkWTXv80LRPgmSav0Iz27scGbprfeEs5
	Lr2cw3qJuhE2URCVQAs4Pq6/LqYMY1nEYWrBSwWPYPrlkdYA==
X-Received: by 2002:a17:903:3b87:b0:2ba:3e2f:6883 with SMTP id d9443c01a7336-2beb05d9f8cmr245521575ad.19.1779866106886;
        Wed, 27 May 2026 00:15:06 -0700 (PDT)
Received: from krios.lan ([2001:569:58a0:da00:a5c8:c4ce:f7c1:40c1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb56d68adsm169036365ad.32.2026.05.27.00.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 00:15:06 -0700 (PDT)
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
Subject: [PATCH bpf-next 1/5] selftests/bpf: libarena: Add "arena" BTF type tag to __arena qualifier
Date: Wed, 27 May 2026 03:14:53 -0400
Message-ID: <20260527071457.4598-2-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527071457.4598-1-emil@etsalapatis.com>
References: <20260527071457.4598-1-emil@etsalapatis.com>
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

