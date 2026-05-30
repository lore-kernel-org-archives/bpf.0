Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7C81AA1F4
	for <bpf@vger.kernel.org>; Sat, 30 May 2026 00:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780100588; cv=none; b=UBVxtwDSQu5arvURgc1MsnhXB9U4m7/1AbYcKxDxLdHd0MlaryNlS73AdMBsQTPYT5Q2kcZ6U7Z+Jy2cCwrotLgVXbLwFgrTZqokBaVeUSo+R5sOh60Mt1Zz/i2JXJSiK2sd8ormIcei+Qt4Bz3vyTNLfJWwprlhPHtQS5iL5Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780100588; c=relaxed/simple;
	bh=amDGO6NwBQwUrSVSGm3wNBcPXIW/R9e5ucYSLCM+UDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lAonb3vCdZAjYtZCf5QnD73TWoKVCBXkPPTT2UC+B/zK7Uve39tR9fw21FlnUEEmCVxkvq8GK2czgbw8BDyf3rro1Jzfo+V0wL2eAciFfQpW1/tujzgm9FXrsooHhzzv11fNIbVqDjqAHpsjsFBvqHS7UUukCbXrDHiUa20+NS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=gZDH5v/u; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="gZDH5v/u"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-132d1b2519eso11651470c88.0
        for <bpf@vger.kernel.org>; Fri, 29 May 2026 17:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1780100587; x=1780705387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hz6BtmoYYXtqDOrcjjpGC/v2MlsMtEJzxkYQRF+8tMU=;
        b=gZDH5v/uy0vkounsR55hWU1W2WxedDu1Xrym6oHxF0bezK6XxeuWTzmurr66DtiBYu
         itXPMsyK40yCJnQjqy8aDYT+ao+NMsCkD6DC/VxV0n/IDf7YK0CJXOAYpKfxeISWbaUe
         Oi1qY8dD+DlL01CC34qB0Ne5Zgja8nqKdAMufYOf11JLKZrFivQIbbaEVWKyJcwe5uYo
         L9gPQrR08WER5UyM0kN3vzODYUtvCQ/r8nKrHm4wiRGUe+hB8o8q4jxBoJQdHzkpw+WA
         NCsbxSssJeQpdbZBVm1q7KmMZ1LdzDzHcX3vV2xWBOTO5f0YzXCW+831y8RjFxPlbgmZ
         KQRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780100587; x=1780705387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hz6BtmoYYXtqDOrcjjpGC/v2MlsMtEJzxkYQRF+8tMU=;
        b=I5K0j4Ww/1LC0kbCFVuPH87zGwlYrHJN8UrmOPTdlcLhOYvchNJ2hQ+zC2HF6rJqKX
         xkOK6oqjh5XurTEC5I+W1LuLJUrWNZDwtv+5BE9WBRJwxFehIAFQ+LDALKpKc2Bm1hi9
         waAJbzlSFYV1dK1xN/unYdDARy/v0TuqinCMJxr3HKOLy0864ac1fAMfTovq1/RhODzl
         qcHGC3UrPihG5hvjrSS7sdVLzEdCMOgPfmySTjkT3CMxrefKdRNEJCyspLZGgJpYfVGH
         ZAFSoVzVaNfWeosp4akeRhl/JNM3Um6Nr0SsdDX1YgSn2iqLj4WFuczUHDqAAz8q/WPr
         xZAQ==
X-Gm-Message-State: AOJu0Yy0jUis9QeJz9sKBTvBeEUiBuJhWF4jqEG9ys36kw3uqMEmrLaD
	x8aU53vEBw7X8bvM9JQCXQ56eHKsLWWUCN2j8GIMb1v66qZqK8IC+toskXOXM/tYnG20XE1x2wu
	ZfwwFBqnM+y4l
X-Gm-Gg: Acq92OGmyfteDipJ+jPFFpmCYcAhWtIoOFdLIH+0ogBl3GkyHX5WGwO29XzQeETz60T
	Oje/wGzY3xo6FF3GvaIduybgTtLkPoTojy4lmsrMZ7ze7VSjGXmtT0wByE3ZHCPv5c+y/yohG7E
	3E+2V+jTqyGpnbgba/5aABuMsemdOt0dWyZTinY2ypj0XqjsgSDPeO7bgOQppkr5BDUyFA98AD0
	h1cT5O4QhP2/R498fEVAgTTBOn82CH3MC8tUVuVthmpCOJIg8pwPROIKyI88e1p2IHw5o6TFVuW
	g/M490Sk++9iQ6UjzB3KcJTSi86s311FIoUBmW4eqp0aHHZ++GGrwwoLQvDCxk1HKSNAc6zd00b
	5bjM7kEE+TLq/c4PThFkC4VGcBhzkPZyQs/9LurMONCAyJlyi29u9YBtNMm2pZDxdSEv1gVp7j1
	xDgoH3SpCk0vXccBCZ3gSVxhX/41LP4w==
X-Received: by 2002:a05:7022:4581:b0:135:51d0:6df6 with SMTP id a92af1059eb24-137d4241f27mr865531c88.28.1780100586537;
        Fri, 29 May 2026 17:23:06 -0700 (PDT)
Received: from krios.corp.tfbnw.net ([2620:10d:c090:600::9529])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137b35a5f44sm2070540c88.1.2026.05.29.17.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 17:23:05 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 1/5] selftests/bpf: libarena: Add "arena" BTF type tag to __arena qualifier
Date: Fri, 29 May 2026 20:22:55 -0400
Message-ID: <20260530002259.4505-2-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260530002259.4505-1-emil@etsalapatis.com>
References: <20260530002259.4505-1-emil@etsalapatis.com>
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

