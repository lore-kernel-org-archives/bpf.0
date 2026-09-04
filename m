Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8942484232
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 10:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788519513; cv=none; b=lEWJTOdYbm87i84WcwiCkmPrjruJaycEA0bQpA5pApAqhbeo7nX6YvPFolcjhYXNrmukQnU/oetjgtl+NZv6RZ/TYqujQdGqmNnSl5Wm1/NBEFa8jufL6XTSwqHBo3jaCODhzwrwpFMjCX96LrLZK5cW/CNIrl7VJEZeir0CP4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788519513; c=relaxed/simple;
	bh=5yHQlDDHZS6dSVTjZsXMj1S4H7hxEwFqsfVwpTXeteQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aVEsMiOyuDvrOQFWnO2pvDim1aIBCEAvJUZ3nhYyVt5vvJN0lMEs4LhjpVL0ag6Kw+57cRGC6c4URiIwnWod62wq7r+yMgB/tmtO8nKYpO/kkoywj2ar43WOu/Z5U9sB92JjMfE5x7Eol8oum17D1hWjO9s7KWq0XM58ZGQUv4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dGl+VcAm; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGl+VcAm"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cc891373e0so8494995ad.2
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 03:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788519509; x=1789124309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PizEHm/PS46Gb7MqU/Rt95IUcZXQSacvCcrM5GSnGTo=;
        b=dGl+VcAm7kClFdBOevqEH2I+irqA+wM/NvNwoos1I27k9nH4fxG9asrMi4aOErGWnm
         SOIsBoUTgg1yk/0cJGQ2qPsOBINhP3if9Vw7XzswruzjfH7dXO/fb6HeNPsYfxcLlNxx
         7jNnKFHLl+dZ5MTh4aW70AYP2951OuL4FruYw5v/A5eckFaOU6xWY9Xh2Z9xpm+1PYVB
         DUGVg9CjS18Fy9USV9/8jk60YYVDsPf6Zt6TRHwXGNOYjmsrVZC1GQMp15yy277+xAK4
         nGN8r52Qs6Toq/guZQZr03vheowiuN3JS5rZe8oHz9koeiDuA0fwBiL4v/Uvr5Lo2/V3
         +MZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788519509; x=1789124309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PizEHm/PS46Gb7MqU/Rt95IUcZXQSacvCcrM5GSnGTo=;
        b=b1+hah0QY6/umCIZJt49477J0oUTaHb9hwOCL/AjxZKLm6HjRSi6Djl/zRCPbdyjN+
         zvMKAbfAysNmF6dDBkompFiGO3WDkCAOlPUR7/6mLySXxYQt1Rb5BPm51rmSqFUFQ3YQ
         DoYhu+C86wfy+YJtmow6OR1sdIHt3+ZDhTCEi1LDPZ+PR02M88y1YzJftlL+wkUk5MAS
         ChdiT1ZIo6SgkZlXPue0mEIVQf20L/5egJ8kxbBaWk74eOOG4ZFpPr5DD7v3K7fGrExt
         AMTc/xU2MPAPfYhAJKL7CSJzrSNTJ2jcfznj4w8HAVTl06PMGbyKYaIfBuCjMqwuBBLE
         FaYQ==
X-Forwarded-Encrypted: i=1; AKwUvBzWmu1JvApFfhk2WtP8cLCTXpCbWBOXkuOdhCha3g9Q/0SFwSVwyP9XZRFUA3lZYIEFsrw=@vger.kernel.org
X-Gm-Message-State: AFuF++nz3Ljo4uYdoDEpMoU2FZZML79z5RWWnKd1yCLu13u7sQHC/On9
	LiPnYWAS40QmC7m07F6o0MyUzfJfH+1lVHrZPyDy8/cFYnE9gEGiTWH2
X-Gm-Gg: AYBFou1zjuzsz0inQB9WgVo6TNO72SBHlEf7bhvioMUCmtekUGDQhTas2QTvqTX+itP
	53tVg1iK9kHOPnBM4IeSxwr6o8F/H+7dXz+DP/ULlcGnv8w0ieuCm5QpPknX//hhwM+Y5L+zazo
	UrwTFh1Ay4kSOOW87Z03v8FH32Q0TtSz8rvWFoyf0+FIikmzVe9fCWUxad/aF5dy2/KeCjaVVId
	SlYJRM07FTkmh9NRV3kg+ioGopIiHKWwQ4j7Uz4zj7pqNdQfIEfNdXbXO26BJZ7trKxFTfZ3+lK
	D0sIMY34B4pmru2tSjZrnu9N5VqKDC2Jo3VrmpFjKZHe+ESfaVVg3R9ajNdaVUQuOWwOUE6fg3p
	M2pvhoQqLpOuuyX665ODy8S9bK3zYvjIrM121ATdwYQwTi6daeSGFMeAxnpTnxhOZ7+DtpNoz9l
	EaTTUBgSri2mUJT4DYyE2UJN1HuT8mOr06l3x1kScSz+L0B1Yffzj0yuzG6azL3dbM5nSGxW25K
	Lw4vy1RHkxujjXMfkXBmoZKTw==
X-Received: by 2002:a17:90b:1c0a:b0:398:d132:ba76 with SMTP id 98e67ed59e1d1-39b2623abfemr7468790a91.21.1788519509025;
        Fri, 04 Sep 2026 03:58:29 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b123731sm5523091eec.18.2026.09.04.03.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 03:58:28 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 7/7] selftests: bpf: fix repeated words in comments
Date: Fri,  4 Sep 2026 16:27:37 +0530
Message-ID: <20260904105743.39799-8-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260904105743.39799-1-hemanth.selam@gmail.com>
References: <20260904105743.39799-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop words accidentally written twice, reported by checkpatch.pl as a
possible repeated word.  Only touches comments, no code changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 tools/testing/selftests/bpf/libarena/src/asan.bpf.c | 2 +-
 tools/testing/selftests/bpf/progs/iters.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/libarena/src/asan.bpf.c b/tools/testing/selftests/bpf/libarena/src/asan.bpf.c
index 5135d5c72a46..158d95c2520b 100644
--- a/tools/testing/selftests/bpf/libarena/src/asan.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/src/asan.bpf.c
@@ -221,7 +221,7 @@ static __always_inline bool check_asan_args(s8 __arena *addr, size_t size,
 		goto confirmed_valid;
 
 	/*
-	 * Wraparound is possible for values close to the the edge of the
+	 * Wraparound is possible for values close to the edge of the
 	 * 4GiB boundary of the arena (last valid address is 1UL << 32 - 1).
 	 *
 	 *
diff --git a/tools/testing/selftests/bpf/progs/iters.c b/tools/testing/selftests/bpf/progs/iters.c
index 62d7df9e80be..340670e89ba9 100644
--- a/tools/testing/selftests/bpf/progs/iters.c
+++ b/tools/testing/selftests/bpf/progs/iters.c
@@ -1511,7 +1511,7 @@ __naked int checkpoint_states_deletion(void)
 	 * would get equal to one of the explored states and thus loop
 	 * exploration would be finished (at-least for a specific path).
 	 * Verifier evicts explored states with high miss to hit ratio
-	 * to to avoid comparing current state with too many explored
+	 * to avoid comparing current state with too many explored
 	 * states per instruction.
 	 * This test is designed to "stress test" eviction policy defined using formula:
 	 *
-- 
2.48.1

