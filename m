Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3D53E022C
	for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 23:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787873485; cv=none; b=P7vuXhrl+vNm8JEkWhgV+T0wHBmu/Zue6+h8dnYbSlT0ZzTwLQb6QR4UkTGI8AtKQWQbMaR079yGhDNGnUvsTVHv6npFJjImrs3pnLhwGNlokoqqDZ924tAZXH7urbYONVh80QFn96qVh9PEf0Vc9YzqPDxxy4DxJzQMvqz3ZAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787873485; c=relaxed/simple;
	bh=/Etwo9DLyA1piEjryJIX/y39Y2LuaF2Cl5MFeAEYG5E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K76WZ9bpa8ZXc8bPK8Asm8IJXYoyXUiJH7zRzeMvT4J6VzgedVNxuzF6Lkg6SiVlTIvKE+/oHAwrvA4zfpCQvfewRbgjY6VfIjoWT5mqy+jfvLMuFWs2BDcQkXUvfOjfjVys2qUX0seQoqBTImQKOe7krmLlC5U7XTZwX54w8+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=INdbKFdq; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="INdbKFdq"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38dc69c74b8so292476a91.0
        for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 16:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1787873482; x=1788478282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dyiy2y/avbYOe0BnQSrLgYOVHtwCGX72+qfVpLstJvk=;
        b=INdbKFdqr+oOKdIS6fNi1KjYeQqVP7cMehmHLqCakBHQCuVKkVloj2KQZX+2BIBR4j
         7kx7j83xIdi5cJsqnzr0XtbKYuBqmf408X3Y2EtY2kDHueyXTQtEKwB3USshpEn5cQ6j
         ZKzYw1PXgAO+eq+bNA4DiecxtFzsaUpDox3y9M2kDqOta08fYRDnNYrHFTK+Qq33zqfk
         nL1JjiXnDvLpc4ObbkYQ+ze1EVBS8YI4DK0Yce5R7v7HIgvbm9HHjqja43njYFTk5Ao6
         3UPFGS5I9z3BQjaZ8QOLOd+GeRtxV2+Ffi0kyySfLCN1+ojKAIh/CkIsCJeAWhFofz5a
         UytA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787873482; x=1788478282;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dyiy2y/avbYOe0BnQSrLgYOVHtwCGX72+qfVpLstJvk=;
        b=b//qlLDjz7wPKP03X2O9++TXB/4ppNsqE6OrEpAcFE7/Pu0AxzkxmrpYGORozsqLBF
         vdy+/JT7E0OhI9HFOmaUBdr3RYebF7hDNFmMTVOsk7677fWPy2RlphTywVh2qygS2fgq
         FFTAMTzFrAuih/Kl8kQGojqRdjuk+MsyPQQqMHdK8poz0P/oTtSCuC9p6CL4DVohWOnp
         ip6v/wA1winZolkPG4opPGG8eXvBPabSfw6fWjoSRKD6pgnvjTFxs2F2IyYfhUJ1yVTQ
         5Y/BqvbT+h46EVIhYeuIAh5bZqMKEeFM7nVh4UYf3gmwqCDCs72L9e88SSpba/FUjTYi
         2/CQ==
X-Forwarded-Encrypted: i=1; AHgh+RrN7c0L2Weq4nHYRiOX2LUmDxO/4zTYCE6Gso+amxwwMaTXBEQSqv3Fja2euXfWD0Q9Oy8=@vger.kernel.org
X-Gm-Message-State: AFuF++nVCSYTFM1Lnfl/MLlCKAsudx9NFo8Z0mC2FEj6k9tbX935FrnX
	AcbrozBRuUkHItoVVK8zhjbUCO+oy5ZXOo+g8rDCJP/A09lx+//udhCf4MHOPTIOscQ=
X-Gm-Gg: AR+sD13svJ/8nYOeqZKEEHIAl227HLpwN/wI93qg5wpNAmaQI6cZjsFLniz6E/dvs2G
	3lYaCJFOvHs+MRKyNg6/3Zexca6hrEsK6JqUW7p05iyI5JXQ6z4iN6WwiPOCA++wJ3hs2zH5UMM
	WyivrkCV2ZPVQVJ8WXMvUF1m+kmlNtfB7L4fx5yCjraNE92aFkfi6kEBlI5dJM5EZnqkrsuRwMG
	ZLErSG3RdTZayzUOuqjKyqdNqPuewLlHHNhmgDF+qnqlgu9rW5dhVuFc3XxYZtlORgy+y17Z63m
	xlTPjm+Ypn7K1sW16L7j1O0jp6owPhhDfLphdBun2c02vLUlFOjUwqzSDC6koff/Y7mUWC0/sNW
	Lj33AttoVAmD6BL8D40PtpDHu6I0RmTPSTPDfgKYwg7CLI2lZEe56UFGJvA2KjANIm4PRBIw0pw
	O/SDKCWB1tB2kmBPcZwkg4zC/cWeaDJBqM0jtDt+DW+w==
X-Received: by 2002:a17:90b:1c0a:b0:396:54ba:8932 with SMTP id 98e67ed59e1d1-396d104e722mr3685624a91.16.1787873481701;
        Thu, 27 Aug 2026 16:31:21 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4a::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b1ab4e12sm4501710a91.16.2026.08.27.16.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 16:31:21 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: linux-kernel@vger.kernel.org,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Joe Damato <joe@dama.to>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	bpf@vger.kernel.org
Subject: [PATCH] mm: memcontrol: raise MEMCG_MAX for charges that fail without reclaiming
Date: Thu, 27 Aug 2026 16:31:18 -0700
Message-ID: <20260827233119.411152-1-joe@dama.to>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Charges that exceed memory.max and return through the nomem label can
raise no event and simply return -ENOMEM.

A non-blocking charge can hit the limit, get rejected, but is not
visible in memory.events.

This was noticed in a production setting where bpf_mem_alloc() attempted
to refill its per-cpu freelists, which triggered a non-blocking charge
while at the limit.

Move the event so that it is raised as soon as the charge is known not
to fit.

Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
Signed-off-by: Joe Damato <joe@dama.to>
---
 mm/memcontrol.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 1271d390b617..3904fe9a7b2e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2683,6 +2683,11 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 		goto retry;
 	}
 
+	if (!raised_max_event) {
+		__memcg_memory_event(mem_over_limit, MEMCG_MAX, allow_spinning);
+		raised_max_event = true;
+	}
+
 	/*
 	 * Prevent unbounded recursion when reclaim operations need to
 	 * allocate memory. This might exceed the limits temporarily,
@@ -2711,9 +2716,6 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	    mm_flags_test(MMF_OOM_SKIP, current->signal->oom_mm))
 		goto nomem;
 
-	__memcg_memory_event(mem_over_limit, MEMCG_MAX, allow_spinning);
-	raised_max_event = true;
-
 	psi_memstall_enter(&pflags);
 	nr_reclaimed = try_to_free_mem_cgroup_pages(mem_over_limit, nr_pages,
 						    gfp_mask, reclaim_options, NULL);
@@ -2773,13 +2775,6 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	if (!(gfp_mask & (__GFP_NOFAIL | __GFP_HIGH)))
 		return -ENOMEM;
 force:
-	/*
-	 * If the allocation has to be enforced, don't forget to raise
-	 * a MEMCG_MAX event.
-	 */
-	if (!raised_max_event)
-		__memcg_memory_event(mem_over_limit, MEMCG_MAX, allow_spinning);
-
 	/*
 	 * The allocation either can't fail or will lead to more memory
 	 * being freed very soon.  Allow memory usage go over the limit

base-commit: 3d83758432b5e6ed9507500a57efb0f3af41ee7d
-- 
2.53.0-Meta

