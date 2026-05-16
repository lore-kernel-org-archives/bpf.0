Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFFD283FCF
	for <bpf@vger.kernel.org>; Sat, 16 May 2026 02:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778898272; cv=none; b=T5fGlQ27Lx/ZWn8kfF/gEk+7e/OPWkZ+FZvD/Z0MVJmgUY21MgX7bu7QD+GHsyzaTdZ4sWa/HY0YTNLRUqKknoHhZYi+IRVW9shqZr54LF8Qfv81oFYUy4ohsZYZKRff2VxG/TiYSC29X6AiArSSCIvDdGaYhcztMCVeT8L7jBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778898272; c=relaxed/simple;
	bh=ps2EZAI5YrDKjx9lnvzkHJ19L3NjEOMyGa12/vfnXrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sqRaYjd63S/n6RjmotA1P+Z6NfAPnIgZgHtkpNR+yjYUNdzdNxzFz+mGD/HicHgMhPvGGedWpy3BXP6JRasU0cD061uBqJm4n6EXxjfo18mu65thhRnNEJ5TwhLUAdOWnE7UvYxwskX68Z+L/MNx16EURdQZM0mavTgxT2S0/UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EBEx0DVI; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBEx0DVI"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso3605125e9.3
        for <bpf@vger.kernel.org>; Fri, 15 May 2026 19:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778898269; x=1779503069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fMsQn6B7jmQ0Yihtlprt30BUdYKDLYuh3p7PW+adwtk=;
        b=EBEx0DVItQypO9c/sxYjrUXz52iJ/AN2rDabvoATEbpzwoS1+jqSbXpWKGqBC1k0lj
         gSOeIRr9JGL372RUIICF07Exz1+gnxARI+hPAs0ZjyWogCZvm2pCj2gDH9c9InlMrNJd
         BK6DBGsEdKXiRxKlO0HtAzFJzVeZu5EMgRHhdn85AAWVOc84IXbtXviSsNZ5Nzs3krdm
         5UEoyTq63JzTSDvDe6elvTQIeyoCGnZsUcgHrjPZUSiABIAN00b/eztBV0/F+FKFOvfG
         09U4c8piIe+kr+BXe/kPhxRYjm6JR5L+FLzC9svGYU+D4OMcX9TmMb4sZ6hzKc/aw3f9
         oQqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778898269; x=1779503069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fMsQn6B7jmQ0Yihtlprt30BUdYKDLYuh3p7PW+adwtk=;
        b=SVqG+1gFPxi30Vd3o8ShR2LZXpU2wVUWe7a3Que9l7OZTbJW/7+HLE3Mo2ZdwjAhOC
         ahjeGk4f1dZfeFV8Kl0hWO4rXo/4CuEJGCQJOKBsjsprMpQnT/lQ4FeomZAeLxTAf7g/
         1wivvRjkgRkMTI/LcncPKsfeHLv8F8Yn2X94Bw9pBNSNnBkd5/3/arx5NpRlUmJxAXDI
         vOqUXa2x6DIlDAgDK43ymu+4ffVfrRPjJ7rEZLjloYgkZEXNaUkXG4QQeLqFX1zZcSg4
         PnlHEM1QHib3emctJClIAODTFTfQmY0yKJ1MvFxCMvgMN6nuisd/ftixf1zDADPOrZtV
         zoeA==
X-Gm-Message-State: AOJu0YxnfWL5uAu0pFFLhq8MUUKGTRK5D+JiOfCgN38ibaqUsCf93hvu
	OrftIk3D2vE3YjlQY5JBBMXhcT2rviDU9kCR99/KhWNEmjtIf67rFRWP2JFeAGMh
X-Gm-Gg: Acq92OHkkYQeTPur7oSkbatIzdxM3P59glzsz/9f94BI4g3uIt9C7FEipx60rcZna1Q
	8lllLKKT9IYO68vtce/4krOupfNYvf4zYkDRv/9iPF9mvB4/uD8B0o7Jn4ovuj3+JYIBkYICX31
	RA6Y9i5JX1p6wTVEF0ArU/BLwddJ6EtsNt7OuO4MAjY4rfXS8YvnBrPyTQ4s0MmVDmb112HZn4B
	eVhT7j/BdQyB845rPhbGw9msiZaziFFiEfoAh5OF8hBNPRV9dz2PswD3c7fY2p/Gz2+qGFl/t3O
	uk95GFeACUwyehQPV+NmUQ/zhTZUKK7z9b/Vo6J4A38ifqymlJMxlarJtSh3SsH7WjSd/EXp09T
	JFJk07MvLCISiDwmTo39bwmlWPIZfCWf3hg4W8lVYEmqezwiqxNZ7K2zLmOR2L4Gk1B/paMij0F
	mtGT7nCkMPD4tbQQK8ndDjWU4HYaQiGbbbrCsHRNmSxhoEOOdHLniRH/M48Didycjn5Qx9IuWTX
	Q3xNt11uIGw+jX4c2D1XLCDrUkp/HkpjO3mYhQnLvR6iFM5Fbx2CJeUOXsh+HEJqQ==
X-Received: by 2002:a05:600c:a4f:b0:48f:e230:2a1f with SMTP id 5b1f17b1804b1-48fe661ede2mr88228645e9.30.1778898269139;
        Fri, 15 May 2026 19:24:29 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe53ab6aasm107020745e9.2.2026.05.15.19.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 19:24:28 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v1 2/2] selftests/bpf: Cover global subprog exception leaks
Date: Sat, 16 May 2026 04:24:25 +0200
Message-ID: <20260516022426.2109698-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260516022426.2109698-1-memxor@gmail.com>
References: <20260516022426.2109698-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1270; i=memxor@gmail.com; h=from:subject; bh=ps2EZAI5YrDKjx9lnvzkHJ19L3NjEOMyGa12/vfnXrA=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIYv98uKVqZnPY27uWDfngp5IHHv58oTtC3g/TGjunvWk6 HLU4kdbO0pZGMS4GGTFFFlK/u9jMj5R+TvQdhk3zBxWJpAhDFycAjCR5FhGhqsL/W+s/fDr/brZ i64+ZHid7H2wr3xhcXtl7y81kaaJ2aoM/xO/LNz2YMZ8fbe43Z/PbZbSOPNddcX9bKarzRnee3p FDTkA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add a verifier failure case where the caller holds a reference across a
global subprog call that may throw. The program must be rejected because
the exceptional path would skip the caller's reference release.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/progs/exceptions_fail.c     | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/exceptions_fail.c b/tools/testing/selftests/bpf/progs/exceptions_fail.c
index 051e2b6f2694..ac44d60e5066 100644
--- a/tools/testing/selftests/bpf/progs/exceptions_fail.c
+++ b/tools/testing/selftests/bpf/progs/exceptions_fail.c
@@ -208,6 +208,28 @@ int reject_with_reference(void *ctx)
 	return 0;
 }
 
+__noinline int global_subprog_may_throw(struct __sk_buff *ctx)
+{
+	if (ctx->len)
+		bpf_throw(0);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("Unreleased reference")
+int reject_global_subprog_throw_with_reference(struct __sk_buff *ctx)
+{
+	struct foo *f;
+
+	f = bpf_obj_new(typeof(*f));
+	if (!f)
+		return 0;
+	if (ctx->protocol)
+		global_subprog_may_throw(ctx);
+	bpf_obj_drop(f);
+	return 0;
+}
+
 __noinline static int subprog_ref(struct __sk_buff *ctx)
 {
 	struct foo *f;
-- 
2.53.0

