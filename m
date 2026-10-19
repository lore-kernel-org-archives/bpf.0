Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D311485947
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 06:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792392166; cv=none; b=tpYKHsbVmlqo/CTE56z9XDRQAXwYEwH2D1vCwtWYpizyhA0r2PW9Rmc0kNYmo37CYN1m0hggQ6tulICZazjlq9s1CgPagtIvsVm2ofk37tW9kTN/UNXdAdeTp84NNsrqevj4M3DhUG/W+TkfL1HFCNVLaBak75FBCCc3NTr7W4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792392166; c=relaxed/simple;
	bh=QIHyivvelQsG5goLcwTZfY2CtoiPNubYt+UKx+e9SPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BzavkQrORiJeHvFJ5c2vKIciY6ADBvTc9m69mQl5vcsp2eb0kZ2lWE1crd+v/EtGGAFMeZC6KyMbJz5mxVonMXXvukr8A9t1L36HK5nrdfm3hmHDAlkP6W2VjVSbU3WOuflIZRIhJoHoEgsZukqJCg8i0ttauYCdGyQf3ecOu5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=STyHjCmU; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STyHjCmU"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cd6028ff33fso581041a12.0
        for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 23:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792392165; x=1792996965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vBI495sTrHPugfVjBEVGuxFJ+6JlCnqJ4Bwn59THMd4=;
        b=STyHjCmUI8Sq80l2tcrDAnicEQQ7oAaNMqvcYqa7Q0sA2kQSmbJ9TCkBYr8H3igf9V
         spmeHe1l7oyw9UAtm3f2oCn8hUxArOGBpgUetWu68UVACxeCFOScfkcgWt3ral5QrW9L
         p65Gn6LM4HHi3S07bukO7LavM+a/5Ni7SXTy1XUPG7zMpuY311WFqATXc7fHTguDJuI5
         oetQxFhJVVI07AUTbv1WjuCOW9avx+KtvmaFY4kotQa4qzxC2U20X/WtsYvU/Px6P65N
         TyJQk6n83q8xiGl5f2jFldpxTWwcaQZUA4MO5fM6dA9fULgJI6jkTD7Kr7H4h0K+jq3O
         DjAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792392165; x=1792996965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vBI495sTrHPugfVjBEVGuxFJ+6JlCnqJ4Bwn59THMd4=;
        b=NGd9d6lGMOsv3khOuEF+3XfL6lbiMKlFJo/sK1iQwKwSnbpvPEQbWWN392+/6iFcZP
         H+U4GH3iImwsjNrVloiEwad0j+jHPFOOzN2HsZfUm3AxajMYIjx/3qCTOpkQr8bQoJGC
         bfUwNO0Bfv5apS+PxzyJvedbH4eVNTeiCQ2ZalSzMwcSbsJuizpTKFNVzl14a5/yLmmd
         4kC7TNWotWKrA4W5jDqeuBmLDmEOeZmBELyhqNOWHYPu8tozKrQK33N/BB7R03TK2Wgb
         6t52wxmaGybMiuEFa6sRVNXGwZC37T0So+fhOID0duLKFFdEEui/ri0fORmLyvbeLuur
         M7iA==
X-Gm-Message-State: AFq9FYIkxoa7ue00bBoqY+hh3c0vhdGwPtfcVXUoot1WvfC8Uu1TcXT9
	b7F6IQV9Szqc0F1EtHavK4x00fEsIV1CXqMKsQIAd0Kse6ie8sPc+fJm
X-Gm-Gg: AYBFou1nqPGCq6OcORikn4DoU4l7ScGzSfg6Qs0pJd/1u0nWeEgq4BlPvt/a3UUHHpl
	UnbcZOt9qWWTdG/jkSnZJVHXdOjY3yP1nHjK02VpQTlO+Fz2WGr9tiwAA7dFtCqFpWrwHClEOOw
	u0SKCEW78KUz+kV+zLBRTwYfmXjaZkaeFdAZpdpNjDeWV+KY+5luYSHa3y7AS2ybak98eAyI+V/
	qwc6FRbQdJjABpg0V/CKhZb6Mv0tqti/Y9k15jPz9jqxFNx2uDRYgRICyLB2QQKcGaKpW35+6tw
	g5ID/kGtFU88nirWynwmYpfddB5hRKmXCQFXbL+BTFaMrGtrIWc9ZnWT+RWBxxtFLUv1IxVaFBc
	b0Ob8cAsx+Av9+uZmO4iA2VW+K8rPGbiD+BgGzFaa1py8wUEBPCnFfdES+DoPp53Cdge/GDKLTK
	qa59NFzx8W0eT+PkZQojElleatN9xwFdpVVRGNi4XrUavORtxD7ycXfdwzZm5Qlw6dBUvRbQj2M
	Z4zCfT2yC1HnsLigSMoqV7/dCXnoStOoPGJ0i91G4IPxqLMGglKfH0UIYOlU9dxR9HwNWM=
X-Received: by 2002:a05:6a21:482:b0:3e1:bce3:c3cb with SMTP id adf61e73a8af0-3e225fd83dcmr5763850637.44.1792392164732;
        Sun, 18 Oct 2026 23:42:44 -0700 (PDT)
Received: from localhost.localdomain ([240e:46d:2100:3fed:6938:3f14:63eb:c479])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd654a3a592sm3688960a12.30.2026.10.18.23.42.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 18 Oct 2026 23:42:44 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	akpm@linux-foundation.org,
	david@kernel.org,
	gourry@gourry.net,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	shakeel.butt@linux.dev,
	roman.gushchin@linux.dev,
	yu.c.chen@intel.com,
	zhao1.liu@intel.com,
	tim.c.chen@linux.intel.com,
	lizhe.67@bytedance.com
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH v3 bpf-next 2/5] sched: use static_branch_likely() for the NUMA balancing tick check
Date: Mon, 19 Oct 2026 14:41:54 +0800
Message-ID: <20261019064157.29885-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261019064157.29885-1-laoar.shao@gmail.com>
References: <20261019064157.29885-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

task_tick_fair() checks sched_numa_balancing on every tick. The
static_branch_unlikely() annotation reserves the nop for the disabled case,
so the default configuration (NUMA_BALANCING_DEFAULT_ENABLED=y) pays a
taken jump per tick. Flip the polarity to static_branch_likely() so that
the fast path matches the default.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 973647ad6c2d..71dc47d6114d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -15351,7 +15351,7 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 	if (queued)
 		return;
 
-	if (static_branch_unlikely(&sched_numa_balancing))
+	if (static_branch_likely(&sched_numa_balancing))
 		task_tick_numa(rq, curr);
 
 	task_tick_cache(rq, curr);
-- 
2.52.0

