Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C6825F984
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 01:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775956746; cv=none; b=BeEcs4gmlygAPT591cV2IWdokbZCY6sekW/6YSedEFbjyQFp6RpHiUzr8VVF0QsJeAOr7Jt0n1YOQhvPvjqgTQYetH2Wu+MmZVjPPhjdNtp592uDDjGD9UXwIvdDW902K4nxdpgEh7t/iwN9TS1f89fE4PTzm5Cs1V1B7MmsHLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775956746; c=relaxed/simple;
	bh=qf0RBOV2DBi8ccuopXLgz95L3fS68pTpglJpoI0eMpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YzNSj1AX8offPRiXNvOcJhZK7+aVpE3Wp+efvi/uMQQAGXLJiPWa/gkZ+l5nm3zTQYPfxZKmc/eDkkGrWY0xg9MgZiGfX9mFuB4GI3fFM2qljDSnZIiu4OF1Zcis0h5hQZwIWlUdWv2dsB5wZh0Z5Mr7EC25gW7NUVZ0+XLtofs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=SEzyWlJL; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="SEzyWlJL"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c76af79f029so1215719a12.3
        for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 18:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1775956744; x=1776561544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3fHKeGW3Dgjw6ItK8Bh2quX+jKhU+wtMFk7W6jPR2vM=;
        b=SEzyWlJLQBDamUjVxA+t3RASPFup5vkB+gLSd4imRYCrC4cQtlP8wOA9gIVkl9GGuY
         It628gzd6exL2rps/U517Zy2NCSlLfR/1OWUAbl+l3UyExdydiD+BjTs9DcKaggJ1kzm
         MV2TZjIZnrx3BbiYVRaVyPsS+9H6P0BUrpdVLyTtBwQ29cc9P4ZtAUWL6qwqNikihbp7
         ZwfMYg3KcbWkDZlgC6mD5ezvMdGqR5FDdPn4vV9608HIzyHxPw6s9l6WoF2JI3Le0nlo
         9TGlPP0ghcZt/jxLZl1avtWt3PbQgr9lw2aCsZRTFbM0FXaZEyrKUgc4Kc8csnXgXD2Q
         Bv+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775956744; x=1776561544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3fHKeGW3Dgjw6ItK8Bh2quX+jKhU+wtMFk7W6jPR2vM=;
        b=oykuVxXth72XbYbLGo1EX1q1TQjXB+lwQiM8VTPsTorhZTZqm1i5f3gJSD6BzMwGGj
         mtqDzB/bE5asWR4WcyF7rPvidN2xo1Synjmm0DS+pgIYZIje7+0ATKEFXFbYa3+YhUxX
         rOTFn2xMLTWaGt8dTgOnmeKRc+z2ACDluUenpTZiAXrrSLoyLL8gcT67dZ2tdfajsB6w
         Vd854gg52V4dIfzHea7+efkaRQrNbAyA3DGL9JjYOisCezN0x9ib0RBF6oLbAYi37LCP
         8olDibtj84fwzdycqar2CjNhSiPOUrD79cCA68MJJ2CWO7vssQR0ddUKKJa72fMn3zyN
         sV1A==
X-Gm-Message-State: AOJu0YzQTmz30HcGGZ7crF9ZMi6flTpkS68l/DJI5jxarOWSlLNyFsyh
	yB4oNK7ECOMe330+i7nhvRhROWEgnvWfy8wCcMMo8wdVZVAI0q5NsYHgaAcWiaSnrkoOZPYVnbj
	sgZgh4NE=
X-Gm-Gg: AeBDietEpnnuOs35hRkqfXrRnFHEcRgOy5kqODVkBctUy2L0Ui5pce+dTxmEV1frVjC
	/EEJNrI9WxRnQlt1Jyud2An/9FGW7N8YVlwjuXqxR/k3Sm5OEPVCsoXjPsUbH/HbKAgar2smffB
	xCr6vIhcL/WruoCeQ0BUWuY3EsWkAEVRZ1YFi9uHUj9LVKn57oyv0UGfzAt/g8dCTMdplw1Y03N
	Z8+m+KG4r5glDIkoQjrj8PNFmA2v8f4n8j0eCqz5cvd/8M6eAdZEN3jwRmXK0p1qyJ4KdoTLWrR
	LKEbyF1eehPDNNNd3mK4gthVmOyQccFF546sUC0Si+XN2JG1IfoQFzi08o6f2B+R42AyNJ0C6iZ
	T6IzRTN5PErPCWzEUO4IQwPWMm+JyFiY9BT7HZRhuqbqmeWMSUNEKmNbdJfSqVYXDzbqVJodu73
	s8fw==
X-Received: by 2002:a05:6a20:6a20:b0:398:9662:10ff with SMTP id adf61e73a8af0-39fe3c67ae5mr9970701637.4.1775956744540;
        Sat, 11 Apr 2026 18:19:04 -0700 (PDT)
Received: from krios ([2604:3d08:487d:cd00::5517])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c79216ffa72sm6569310a12.6.2026.04.11.18.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 18:19:04 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	song@kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v6 4/9] selftests/bpf: Deduplicate WRITE_ONCE macro between headers
Date: Sat, 11 Apr 2026 21:18:52 -0400
Message-ID: <20260412011857.3387-5-emil@etsalapatis.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260412011857.3387-1-emil@etsalapatis.com>
References: <20260412011857.3387-1-emil@etsalapatis.com>
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

