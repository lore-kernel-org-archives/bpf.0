Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CE03F23B1
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 22:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784845099; cv=none; b=rl2NVIjouZit6kV4Po/6XQGw3kS12gIATag+qsUH9MfbrNSCez9sNpr28xCFb5nZTkjIvvZec0b84TBW0OI5eJ+9QAow+t3wh+6hhKWGKa7T7tsz9EdAQlgBBMxkZoC8lwwMk/pvOtkpOEwX4rLwzYSYNc9NvYvtqJ/ioHQ4L0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784845099; c=relaxed/simple;
	bh=nbLKWRAXFd71UQQ6Ve0cryHcGeNLVedEPtgMKZ5b/V0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NLPHXWPZVVWUNMoK54I/qTdnAC1ktTvJjboiovGpELXkNL4+lPcoBImRlYs5zmQnCVtCJCKoawgLPjaYsr85y9kTJpOgDndMZBNhzIR8oNAXdFAJo7dtv8Qm3xveh9yxuJUNyKhv+tQs06lwcozpKzjjeGk03ebQNZZ7nZK2g0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o5E2TTLB; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o5E2TTLB"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cc891373e0so15049865ad.2
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 15:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784845098; x=1785449898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JMM2aO+mqZalyEuBpdxxd3H6h+YE2NwThz/TWTf8KYE=;
        b=o5E2TTLBZYVskOsalBMhl8ZpXXe4supUJSyYL/+XiXTU9hK7CyGGkZEI6ZmX+GVPBb
         syrzlWrVri5YleUtqeu+kKkn3nTityVcnYu/OntPD0R6EGPcftQI2M26s7MRW9Q9F9Bs
         eYp71kOXHvmiwNIOJHOfLX8xcTSNw+FyMQPwCxtb+4W8DYq7SPaq1Skw5qy1YRYOnqk0
         BmXix6F3IdBUOaqAw9pyagkaVfFc6GHOayn/4EubG4y5KdmKfDt6mxA+xGA594ZrRe/Z
         eohdIjFbBLsLVx1dFhy7vDofT+bWaDz+ppdV9D4+GyHScb0TBH89vgUKq7tDuvTI6Dak
         W8zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784845098; x=1785449898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JMM2aO+mqZalyEuBpdxxd3H6h+YE2NwThz/TWTf8KYE=;
        b=ny62EQJ6s9o0Fje5uMXWkELbckdp6eE1Qfmcg1vKDaZKXqJvIC/LEbAw13pTOOV0NO
         gPCiUierl0yuv2ajkcpPfbieGNn0GW73RyYu7mq6B6MOEhJOdhqNIG1gDv+9WqD0sfN+
         wAvcuw0+rrKGG8JFaKlt/WohwO2UXh6/F2JzKIl3xMXI0vro3ZKlFQ+FPRjv2xOsenxg
         ZfKj5lO4stzfaREB2Hn7U0A5AfN0ItmCI+5r2tRYkOlMAmROiowLCmfwDL0dsDWoa5jM
         Wz3AdNbDSSrMXjG0RRy9JC+4nw+Ww/YF5/7WuHFkNPInS2bn1Oxanxvqec51vKgoBgK6
         I9Qw==
X-Gm-Message-State: AOJu0Yxw/FqkpdyxguMnbnuJWz0cFOBkDx1WNIoMjNmtcwe24tmfdlFQ
	MzDK5Zr4AiL++oJkZac5ZbBvWD5yDwgF5Ua7X4d5PPql+XPkSqIkGIT5zHnFsQ==
X-Gm-Gg: AR+sD11c+zW4q8Vp03+L7m+65w7583C2prmo4jS/aIE8TmCek6+zR2AT8Pop59G7V8V
	Su8jFWjlsTh4QmrRsSmwA04/p3JQPIf9MCqRuzQsU5FUs8Hl86xDxyH9yhEsMMZUtNFQyzK0Sqi
	vOzYId2gJ7KTDf9K2Wj9FVlh/eEwJhxGB7N/el+1Zj2fWVSCFyjwGDyHUx/ciewxQbq0OZ6gS5z
	d0YUsKW4Mi6HlZtjerG981seoDom3UflWErUE6A80rMqg2PtZSJynx+1qqeX+L+EBlXCN7mP1CV
	4f4IxnjZFhpURrxha/zEAYbC88u/jlGpgwlCX1AEhrJOMekd2icC5eVQ2umtmaQP82LMIFPpVPA
	mAE60oRwiNHW2qAiZ+6pP3UhpBukKZ6NIxqyQajybt+/cP3ieYrWghND363Vs0QFmQB73
X-Received: by 2002:a17:903:8c3:b0:2ca:bf68:2a54 with SMTP id d9443c01a7336-2cfa6c66729mr57224845ad.22.1784845097568;
        Thu, 23 Jul 2026 15:18:17 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4a::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8efd88f7sm40710735ad.22.2026.07.23.15.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 15:18:17 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf v2 2/2] selftests/bpf: Test passing scalar NULL to nonnull global subprog
Date: Thu, 23 Jul 2026 15:18:15 -0700
Message-ID: <20260723221815.367797-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260723221815.367797-1-ameryhung@gmail.com>
References: <20260723221815.367797-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure the verifier reject passing a hardcoded NULL to an
__arg_nonnull argument.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../selftests/bpf/progs/verifier_global_subprogs.c     | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
index 75a2e3f48d0f..67dc352addfd 100644
--- a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
+++ b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
@@ -185,6 +185,16 @@ int arg_tag_nonnull_ptr_good(void *ctx)
 	return subprog_nonnull_ptr_good(&x, &y);
 }
 
+SEC("?raw_tp")
+__failure __log_level(2)
+__msg("R1 is expected to be non-NULL")
+int arg_tag_nonnull_ptr_null_bad(void *ctx)
+{
+	int y = 74;
+
+	return subprog_nonnull_ptr_good(NULL, &y);
+}
+
 /* this global subprog can be now called from many types of entry progs, each
  * with different context type
  */
-- 
2.52.0

