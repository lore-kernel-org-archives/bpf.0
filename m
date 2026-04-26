Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA5D377EC1
	for <bpf@vger.kernel.org>; Sun, 26 Apr 2026 19:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777230226; cv=none; b=Em7v3rnOO92Sn9fNy38Ua64MXv0EYqsFtiRF6lHLq6SRhE14dvwcYhwEaq5RnhnTSLcdaxbkvUCxLTRkudq7WZnQ6O9Gr9qVm06w//xcPGsV+2H93AG1UZt2DskiMlj067obzF6U8fborBVuQVILTxN70q7tDUyRKdLTG8I6HuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777230226; c=relaxed/simple;
	bh=4ouPdCQ5TthuW5wokGQn0/43icp8SwDR2fQ0QQ3JVi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u0xNQmnh4zHoZhfnYIubPf/wA3o8U7DGMcd8Ev9ud/TONLU2eSDe5XPmLN6cbKTvvPX/UQLv9d4mS/zh+M7Z4wzY41/+YXVRqtqdt6wSM5uPw9hjmBClCTTZQJNx5JCqjpItKjIKiu9DMC+k3a/l5CJIfsivqIJOje3qCsJn7fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=heHZdaZa; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="heHZdaZa"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b7adb38d65so33092095ad.2
        for <bpf@vger.kernel.org>; Sun, 26 Apr 2026 12:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1777230222; x=1777835022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bKte3GLtzAoQC6KpJOJigm/JzgYPGPBtteidmVIscAY=;
        b=heHZdaZa7WEeM+Nmuwgq/NmSXJsjQv9tY+TzRcQaSLC/bvcUpVUV/Hzz70DwoSlEF+
         OhumzvlchcikQsmpc/eBMc0lRB2Iy0YK9W0tpRl+Py8Etbj5CPiZZKJIH0rrxmK5FcP4
         KpOTepfKC44bSzsWPy25xNwfrCOV6CacjbjbLnfoHt6+qdyrx4iGZKbdlOLZxyYwamdE
         Wx9Yv10F7sTk3UfZehF8wEXHXS1jgugmN5SYH4CEhvarID5HNbq9Mq8QZLqyqZKvoqfi
         8RguPTGT7cJr/L2kzjzqZu6vsbcoysKOB/5Rp00x24AaCSnDkpqq+BNadOtircbn+MkT
         IuDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777230222; x=1777835022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bKte3GLtzAoQC6KpJOJigm/JzgYPGPBtteidmVIscAY=;
        b=XDdIBYA6RXfbGZOvMuETpSVewahrF9FKTKqC/HI8TaE/we5QOT60XKaQP/L3V9Bi1k
         wt7RYwPLSfX6Pr4dJ0ltvk0CmbXa3XGwulP+iIBjB/S+THd6ayZyZZhw/i9XmZ1oAIPZ
         O/Oz9eQjgwA/Ra2fzLxKa2qZKx/9ut2k9nauBC0d32Uu/BSdoNkOA8eJupTSjN7GTcFh
         urnSpY7aSUomCsRElPnD5l5t9OznW06XjnbsszZFAmar+XL1JZY0LBVDgqTCwrxO5SAC
         YA03Xa1nW3DMDQEQy/wSw4uhdcXV5sHOaHEWBkAWaIwEYSUNdhO3CdYSwkSq6LCfLNlq
         iyEA==
X-Gm-Message-State: AOJu0Yw7ge7UNGvJKTRu1SfA3YAL25Dc8o0u4KhmnIMr1iLnZIk7X9e+
	8RYKAgD8I7MFEGsZMehjUmOYjVn4zDsSYw9XuyEbUJBN1SS/yvJJTMDqNMTvO93VZjkRuiALWT5
	1Ck0F770=
X-Gm-Gg: AeBDiesViGVZV8JCGPHSB6yC1zCtByRZFdCYK5qnXliAAQmd/czbWBNEax5IXFS8vLC
	ze+XQHr5qvRQ/R9AZxo9vn7tbgeq3CcZZMdq5YzgFZwv16z1/gRot3EpHnSpSi3Sa2FHYJ7eNlv
	dpKgBP0krc8DhcI7ibk90BlPhSNbi0uBM6tYjgJ73nfQZ5CA3xK9WKRlmWY565GvFMRnB2Zxbse
	Tkykzb6CbIFzodwuY7DHQOS3vr+vPLEvrPlQ7oYJNyCFEyChhCz4R6tJUH00DfeyP9ve33pSpUd
	MqqYffSG4+tsylk1JZ/6l75Gmeonnqzu6GtxBQkHczwMw8/xM054RbbviK2nqI19TBI+vwk5tqa
	CBF5YBX60JYYy/bzqFAw5llfbbrTZIiNxqNzth2beiKJklQm9lNoQRCe980s9ODKZ0fyBD4Iv/o
	lSrLRNRQZZ2YBcNovQPNiPnKI=
X-Received: by 2002:a17:903:1b24:b0:2ae:66c9:494f with SMTP id d9443c01a7336-2b5f9e64bfcmr413911885ad.2.1777230222425;
        Sun, 26 Apr 2026 12:03:42 -0700 (PDT)
Received: from krios ([2604:3d08:487d:cd00::2af6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b7a9efd0f2sm107449965ad.31.2026.04.26.12.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 12:03:42 -0700 (PDT)
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
Subject: [PATCH bpf-next v9 1/8] selftests/bpf: Add ifdef guard for WRITE_ONCE macro in bpf_atomic.h
Date: Sun, 26 Apr 2026 15:03:31 -0400
Message-ID: <20260426190338.4615-2-emil@etsalapatis.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260426190338.4615-1-emil@etsalapatis.com>
References: <20260426190338.4615-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The WRITE_ONCE macro is identically defined both in bpf_atomic.h
and in bpf_arena_common.h. However, the bpf_atomic.h definition has no
ifdef guard. If bpf_atomic.h is included after bpf_arena.common.h,
compilation fails because of the duplicate definition.

Guard the definiton in bpf_atomic.h with and ifdef to let programs
include the two headers in any order. Duplicating the definition is
the simplest solution out of all the alternatives:

- Keeping one of the two existing definitions is not possible because
both BPF atomics and arena programs need the macro, and the two features
are independent. Using one should not require the header for the other.

- Factoring out the definition into a new header that only includes it
is more churn than just duplicating it.

- Factoring out the definition into bpf_experimental.h requires all
users of WRITE_ONCE to include the header. However, the arena library
introduced in subsequent commits must be self-contained, while
bpf_experimental.h is in the base selftests/bpf directory.

Both headers are moved to the arena library in a subsequent patch.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
Reviewed-by: Matt Bobrowski <mattbobrowski@google.com>
---
 tools/testing/selftests/bpf/bpf_atomic.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_atomic.h b/tools/testing/selftests/bpf/bpf_atomic.h
index c550e5711967..d89a22d63c1c 100644
--- a/tools/testing/selftests/bpf/bpf_atomic.h
+++ b/tools/testing/selftests/bpf/bpf_atomic.h
@@ -42,7 +42,9 @@ extern bool CONFIG_X86_64 __kconfig __weak;
 
 #define READ_ONCE(x) (*(volatile typeof(x) *)&(x))
 
+#ifndef WRITE_ONCE
 #define WRITE_ONCE(x, val) ((*(volatile typeof(x) *)&(x)) = (val))
+#endif
 
 #define cmpxchg(p, old, new) __sync_val_compare_and_swap((p), old, new)
 
-- 
2.53.0

