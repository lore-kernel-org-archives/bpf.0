Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E62936C0A5
	for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 14:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771338789; cv=none; b=jnI1ydoKDvKxstgk+MAxvHqJb7aC2mhoSxe32iTG5UW8TjszxWpqWtTzTN62U+oj/uSjvdbd/YGcDvW9PFULpXpH5++ipEIuEL27FXsVImntnzxh8JS0yPBi4Vk5KLbXy3cWbWuXTduh9LlCnNRwPpEuCNCFXHlTQFC9lREtd1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771338789; c=relaxed/simple;
	bh=7wYcnvlwXxMtmytoFvwS0gIZLk/ErVQm+KTlcn7X1Kw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PwJGbKU38CcmWqC6/YcP/0HaX00+81vHwgwdMQ4IBuvdX766Fnd8IvYyqi8/ru/XdMocaRI6NPorH+rn/2UW2LC1hY2MkpJWGVfN5rVELyLj4fSofDISoHnE75YQDGGEZt7CC/ccvALyraVjxr5J2c+fIH+JIOffbIyODfBCa2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=blm4aGhE; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blm4aGhE"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-824ba8f0acaso2823965b3a.1
        for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 06:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771338787; x=1771943587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WmaglD0okUceIHjkPS7+EHjYvS/v7GixIVmf6reFCj8=;
        b=blm4aGhE3QsvvH6GIsyY2akUDAUMd4aDeNTrh45Yp5wV2EizVvNxAr9pHj95279jN2
         QsXppE/lXoav9mcW3/EOpY5tHxJLiidNqtgsp3FQOsb53pmcP3zsYm6Bzfz9GER91PC2
         5PjEs6fGy5mjReOsVc5EdWz8EgOB+HbBWU565rD7Fn4kKPklZr+6BB1Mg3uOKGXGCmyy
         ZmqGVcQvk6fkS+azd/AsNcGlwVHeOxBaCoJ6mieWeCP6KFtb1LftbrBLBsNt3SzjtMDk
         OKkcPO6eLZVqkISz719BEpLOaYtIMlmK7Zi2i1mH2RuSeJJWEvLKxu8dcu2Rmudh0WnN
         UVrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771338787; x=1771943587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WmaglD0okUceIHjkPS7+EHjYvS/v7GixIVmf6reFCj8=;
        b=I2QIka32Dtn3m2xrVSn7SRgfcagDEmNkuZ181T6eaiInmNnkswhaaHrF/7efv0Tt8c
         JLgzsnW46bK0Qbf3XRJNx3xWf1o6gaZ74OGrmJVZqCX4jeN/hmvMEuoKYZTyTTqepQ29
         26RsY6vwUj7r+0ihAIIUh17ITOctXksT7kwUsjRt1VkHR91YfUwLZw9edWFeFQ4teTQ9
         vpF4TLWjcqmInc1bBni5eqLsVvw+ShmxcxW3WHjygFBiufCloUip1f0pxSsX9OtXlkNl
         IQy7+Yoz20uu9s52cce1dXqmbVya+MEM+FMqTtfnU6aG8DyWf0FChTsiponqcltop+Ed
         31xg==
X-Gm-Message-State: AOJu0YwJoCIqi53rOedIpm0voNqwLYU6pgSNNWjDDX3yupbLitS3d+iF
	22u9pNJI0Q55jt1SpjgbVdwoJxtQ2+0tRT+n30bgBXMg5Npg2ufabE6hC+NEKXX2
X-Gm-Gg: AZuq6aJ+DRrI/1y+M0mDr2z34++zXmCIezVVHZx/nizto9PMzZIFJeaEnUn2zD3Olav
	lQGdiMxuFQ43s7FiTKF+b3l7DO9UBr4a8SBYEIXuAUChCkSHntq3rtKUEgkR5xn7ukvRI3s8D9W
	gTafrxV/ZuQPHMtRXUUVdTBgLpsH77ESNVO3JqEbMA3LAUJVU3+mUE7m34PLBO2r2TIScR0biuQ
	6+B46AZM/VP7JG2sDoeBbnekjAiRRU1cqIZU4W7o6/9VBsI+jJcz2LGM0PPEdzr4lP7y8X81tYs
	IQH9gg0y+rRmKLXmkP1+v4IQkzbmZ3mVDLdvL8Pmsp6J9l6ZJ7dukHumSbGTFCxsmoDa/hVSQwT
	MS1Xwa3s7PWGEcZWwh90CLPLBf4dIXLpWu/zW5J+VS8enQhLPr3801oshBl3H73ykTE3MY27JxA
	rEJ5NuPj0y/mRefus4jiVg+/fn2S+Jlw7F7OuPqyjEcz0Xge/pR2WYX6Eo4BM4i5I+MF88v8Qc8
	jwi5ZUWZmEcJiuxy/Me
X-Received: by 2002:a05:6a00:9289:b0:7e8:4398:b36c with SMTP id d2e1a72fcca58-824c963e848mr12234784b3a.63.1771338786467;
        Tue, 17 Feb 2026 06:33:06 -0800 (PST)
Received: from localhost.localdomain ([49.207.200.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6b935c6sm14770821b3a.47.2026.02.17.06.32.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 17 Feb 2026 06:33:06 -0800 (PST)
From: Anand Kumar Shaw <anandkrshawheritage@gmail.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	sdf@fomichev.me,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	haoluo@google.com,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	Anand Kumar Shaw <anandkrshawheritage@gmail.com>
Subject: [PATCH 2/2] bpf: report queue_index to xdp_rxq_info in cpumap and devmap
Date: Tue, 17 Feb 2026 20:02:42 +0530
Message-Id: <a44f6bff92b7f2d0f86c10214c2e861164e52a03.1771338602.git.anandkumarshaw@users.noreply.github.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <cover.1771338602.git.anandkumarshaw@users.noreply.github.com>
References: <cover.1771338602.git.anandkumarshaw@users.noreply.github.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a second-stage XDP program runs on a cpumap or devmap redirected
frame, ctx->rx_queue_index always returns 0 because the reconstructed
xdp_rxq_info never had queue_index set.

Now that xdp_frame carries queue_index, set rxq.queue_index from
xdpf->queue_index in both cpu_map_bpf_prog_run_xdp() and
dev_map_bpf_prog_run(). This allows BPF programs to correctly identify
the original hardware RX queue after a cpumap or devmap redirect.

Resolves a TODO left since the cpumap implementation.

Signed-off-by: Anand Kumar Shaw <anandkrshawheritage@gmail.com>
---
 kernel/bpf/cpumap.c | 2 +-
 kernel/bpf/devmap.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 04171fbc39cb..f5b2ff17e328 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -195,7 +195,7 @@ static int cpu_map_bpf_prog_run_xdp(struct bpf_cpu_map_entry *rcpu,
 
 		rxq.dev = xdpf->dev_rx;
 		rxq.mem.type = xdpf->mem_type;
-		/* TODO: report queue_index to xdp_rxq_info */
+		rxq.queue_index = xdpf->queue_index;
 
 		xdp_convert_frame_to_buff(xdpf, &xdp);
 
diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 2625601de76e..aa2e929792c8 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -346,6 +346,7 @@ static int dev_map_bpf_prog_run(struct bpf_prog *xdp_prog,
 		u32 act;
 		int err;
 
+		rxq.queue_index = xdpf->queue_index;
 		xdp_convert_frame_to_buff(xdpf, &xdp);
 		xdp.txq = &txq;
 		xdp.rxq = &rxq;
-- 
2.39.5 (Apple Git-154)

