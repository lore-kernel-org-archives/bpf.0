Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792634242;
	b=rdfdxDPkrA9K+OCrdbXSBKUyOeU2wNjxdBpuhryQTP/xzgcWhnFtgoDI/Y8xQX++CyVO
	 8OZO3Rhmt1jUb8eAfDNhrV6K6sbj+XEONV7wMJgwZAhUwVF5ph2Ss2V+f4rWyW+nlP72M
	 zgQgOaeJHVmaycak0Flk+lVri/mU43mVhwOTmB7uMyI8ESlc7xYkoON8Xpiun6TSfdkic
	 vDdzhf2WN7jF42JHcW9A2SQsKr4M43mHI4pjefbSARFo8+FXcrxF681C/EBRhKwXqdWoT
	 yV4yFd3b56wzhQIBoBMw1UahJeWz08V+scjnnTzA6KIXyKZ7pKCxXuJNbjxA+86BiSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792634242;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Rrt07MWuBvKNxCUpcIHeF6DdyBR4Zz5NXlnZyJVxMUY=;
	b=WC9uUnv5A7XP26gPu2JcU1WnwSO0m0oWprxoKYlQfEvH5sdFuqAt4yX3b4Nsz6usK2kc
	 RA0tdSblQk8yZ5+VqH2WWF8lufEF8/ZisuEo3MSgyqThilru3YGzIpado0kOQvFEWZa8G
	 a0MX1tYd7Id1hXkZeOyAR1tuxNME3r/vzV/96ZGuB7UrI56xWkZZrBCH71Yl3szwhEU5j
	 pm13SAeQRQppt288C7BBYw0qybcczrL1Kqoge7kgKbSNnHJ97lLZ/dg1CqU2f76o90ySJ
	 m01me/EYeQz30mk5XuafPs4kd47e8dJYdv5BRjQeT7qvfDHsEUKga3NSaF0ZlFQ8hYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LVXHlWxb;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195C6606A31B
	for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 01:57:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 195C6606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LVXHlWxb
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3ac677668a9so1387861a91.2
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 18:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792634241; x=1793239041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rrt07MWuBvKNxCUpcIHeF6DdyBR4Zz5NXlnZyJVxMUY=;
        b=LVXHlWxbt7zTnrfwpRAAKArh0anXhoxyz4LkMwz+U6FjFY5B2RWTV8bC+BeBzModcy
         MK+4H4Ae3Ve+k1MNf0Zf014GvM6J9em3f4qVG+we0Q8zEPfVLgdcaB649f2cQS7nA1XH
         vaosoMUbUzorV4pFiZQNrT1hM//xValQyBYVoQU8m1NDBEK6BIFUexceMPryTDME+2OW
         hpW6xARLpcKaJAY00VViOSCIHdKgEO2VvSCBhgLVvBFgbN1zVf+TeOIHJoBJHkkUbMXZ
         vX7h6qcfbyRFwm9W3KL1J3qhzniEtgZJEwAiSK0p0xosjCrYNJJ2ULGUrUSOtulbnxCy
         3N+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792634241; x=1793239041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Rrt07MWuBvKNxCUpcIHeF6DdyBR4Zz5NXlnZyJVxMUY=;
        b=idMgV88cBVozjjEAM2++AmRk/0NF6DUcqAanc1pIdWjV6WQt6ZKd1K3wkU+OYYditx
         66LHuZnDJHh8yx+mpZEI1rTEdT1yryA2Nqxuvdm2cmk3OH/U4rTcA1/Kd2J3qGE1FqOi
         QcufjBgdIxPFSBEt6bHTs0vH6Gsv0I31LxXcBeF8EcLUf2m6Iy8CP//HnM9VjLO0qM2d
         oUFwERZK+RKZn7BMrUSZ0wgV2XvI2swl1Zt71BabQyDa0WDLqkoEqq4lSpVlOBjRWtFK
         C2ptcAr+31vBttdda/8p61HJXfR3ehh4MQveych+fyi8L27BNLafjpDirDVBOjgGI9Rs
         sz/A==
X-Gm-Message-State: AFq9FYIcZCwbBrn2MQGBMn5+zroFscroEw7TwCoRfN5FxdN5M9+8TLQO
	iGsyCN0r3AXWEuA01JpXpcDi/6fJR9RveQcLGuCqIlXySpWctzcQ59miGFQxSw==
X-Gm-Gg: AYBFou1KKY+BZakKjt6Fkr4VlPKoeLs8Ui1AQZBAPc1zI2yMGaUCB0hqz9DvFQFe2W9
	r12xkbdbgLwW3PpzQ/tBacJDesixqlK5y8NSmxD6nxzvQV8uW85FGkZlGjnvZXvn7f+ZQDEviNZ
	3fxQP0owpLq/tOqPbaZrIcQoF6X5q69lZ/zcP5LqPxY/DPoKrYMDbK6H4UC00xatHSNIzuo/c+i
	8nUoM0tMtD2ND7W1PXuoA8PFycQop1/VIJfA1Bt4WV3r+6eehfakcGc0GG7xgTd/8MqdJP6qP2p
	FQ5zBaqCpdpT7r6rh0bLkXSsJh1iwPz2Wa3wPMS50yGDbU3E5sODkVHQtYk9ww+d3lACcVjINao
	R2+cRsO952G75vQ305RcvhmhPP8EDs6a/W4xKoHBb+qn3PchXaIu3z8BSlTeUnVvueaRjMXZxu7
	jguW2rqQhqoNt1nAJABPbThKkBo/7zS4XismQ36NKx2L6mHzpV6RPsq4w9rSnk/7r+jXffjwwVU
	DpFafCz/G+m1aokfXyI3PglL1YfVoxVzUtsOY8sUZfN5RuZrrEifNDZCge6Emt/tEAcgtSm7bhU
	2i3RUSXc8lMYGKSUf0zaI/grTyBuhMttSmCJ2u6e6PNM18z/QWNle5P62eDJTp/+3cupodr+qfj
	u9ldgLugAKTSjGohrbAEExsch
X-Received: by 2002:a17:90b:1801:b0:3a4:b74a:795c with SMTP id 98e67ed59e1d1-3ad86c79098mr3189121a91.16.1792634241278;
        Wed, 21 Oct 2026 18:57:21 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada48ed70dsm1701803a91.4.2026.10.21.18.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 18:57:20 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	oleg@redhat.com,
	peterz@infradead.org,
	mhiramat@kernel.org,
	jolsa@kernel.org,
	akpm@linux-foundation.org,
	liam@infradead.org,
	ljs@kernel.org,
	surenb@google.com,
	david@kernel.org,
	vbabka@kernel.org,
	jannh@google.com,
	hughd@google.com,
	kees@kernel.org,
	mingo@redhat.com,
	tglx@kernel.org,
	x86@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 1/9] mm: Bring back mmap_write_trylock()
Date: Thu, 22 Oct 2026 01:57:04 +0000
Message-ID: <20261022015712.1297331-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022015712.1297331-1-alexei.starovoitov@gmail.com>
References: <20261022015712.1297331-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Commit cf95e337cb63 ("mm: delete mmap_write_trylock() and
vma_try_start_write()") removed it when khugepaged stopped using it.
uprobes and dup_mmap() are going to use it.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/mmap_lock.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index b8a13b8d36a4..e5420b0ce61b 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -566,6 +566,18 @@ static inline int __must_check mmap_write_lock_killable(struct mm_struct *mm)
 	return ret;
 }
 
+static inline bool __must_check mmap_write_trylock(struct mm_struct *mm)
+{
+	bool ret;
+
+	__mmap_lock_trace_start_locking(mm, true);
+	ret = down_write_trylock(&mm->mmap_lock) != 0;
+	if (ret)
+		mm_lock_seqcount_begin(mm);
+	__mmap_lock_trace_acquire_returned(mm, true, ret);
+	return ret;
+}
+
 /*
  * Drop all currently-held per-VMA locks.
  * This is called from the mmap_lock implementation directly before releasing
-- 
2.55.0

