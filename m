Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E049E363094
	for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 06:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773813763; cv=none; b=oZPA63f5xsokGM3EMMZ3VvQxDuVKbkzkQFZhyDiK+Q187ZmlpbrzVUV1HTp/Bc7BcW8GK6F0VhJryMKFPyWqCq18FpJPm4GLgpEDd1Y0MTWvzOWYo+n+SmNOw6ZOLl7oEh8byTuVXt1Vpew6gucaY5pZOqGqzdW1uP4dH95JlJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773813763; c=relaxed/simple;
	bh=oUlk2n2Samf+iUJU+Vashp2Zl+eq2zZZX0pmSpCwDTk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mp6hQsjpFpjgdA5ZHOTEeGG64Ztyk/+rqDjXde5B2IAuJ7QaSFsvYmCloNjEJe/Yn655Eg35s13p3EshIvEvYD5VQupqdhp1lOltO8F+U/xWxLIwyEmlCSLhmGReCLQ2eMfQGOPmnjpFkZ7OSrCiLdEP5UoPOOnFV/heJAAE4VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JICe8JA/; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JICe8JA/"
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-35691a231a7so3828025a91.3
        for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 23:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773813762; x=1774418562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IJkIVtuxuti/XXH+Al9drVlkAla5vyfHEBgWFGTXaE4=;
        b=JICe8JA/lrQRKEW2oL7nUD3QYqSFdXWd6OgDEtAG+e1/L20vFrZFX8M8f6KIhPrFkO
         wjcF0HRwGAE3jEEnSzMwsjaONva7jP/EBXThLrYOoyweGakZ+o6xkHEMJz7D+XJhntiI
         NRyaarf6hX+4bKo8ZwFIwpNIcGADuww++6ynqCmzXV7gUtgBaa7CqIUFJqyJVgPeMnCd
         p2NTUkIMToRgPg+6VNm9jDgqFI3+EKs6IkpXOO0D08AYWgV7Ee3L+cbr+FFUQNX2YEEy
         nwHHUnxs2OGTbmmoF6VKiM/M/2euHpxwg4GFxH4TlRhT01iAMK69lyrqHOpSON4cjd1g
         MhRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773813762; x=1774418562;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IJkIVtuxuti/XXH+Al9drVlkAla5vyfHEBgWFGTXaE4=;
        b=IORmW+CWV/uAriNwsVQxmNt4nwH+VFXdgx0zF2hic9XZ3J/YUqq8aP3ZD6mb6G+cdu
         tskMDSz9xSz6gDDeja0jlTQmK6WnkPUbPgyRsBPteXDC/+6JhxcXNnXxpjAfBHBx7KEb
         hNhDUo4/UOMut0Ne158Ae4UzzA9nbZLN6oDBPao2m5ZfRMUuGkYNXrDw1ZGYgV9XTO4X
         SP3IfbMOE5b8z2gCSlXtYEU2JH9MoTMlCfXBlKC8kd91b3zqNYhdhF2i0QhZ5TDciMXu
         zqINtV7BPVaqiibpunbiLkehezronz1GbDqeO2rx3TayoDImu7lfSV7xdi0VGCs1JKcR
         dUsQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5IQc+c7+nbgEJzZW8usJrNZXumrZKMpyvux7M878kVAHDHtoE44PR370mTbC7T8YIoBw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3bPv+BajYuvf7Eh8vtinBpeTFo5/lkOO3/ot6wlTd4wa9ute1
	511IP2jlHDA2yu2q2o9ZNtq46frIEhk9w5veQdUzrNdXdASCbPXTJYkT
X-Gm-Gg: ATEYQzwbjEekSbDVmsX9uxpBiHZuTAYFOu6KGzpuilGVQSl9/rwfvOaTeqwiL+wcKbv
	/hiJpldTs1hwzrI4F2wTilDAqvs15heRvTArDwGUrr9SoVLgpL0u/sirCa35IR46mvgdIpyn0yI
	IBPp8cNiBAQ00gII8gb25WXvYIeg4dh8HoDW35/Hi008CGmWmZRJhsQEbRmkoUSTS99e0HQ+imy
	6quDAQmPpgdndak1Z9kG4EgW2kzv4mEYwsR/beXEFxWv9bUVTzoq2zr//WRc7Kw+bJ1OeWm2VMi
	cS7CpZ7Oe503t6qESz9Xqm7MxBnAS9Ih8bjLu+Ghu4dF46q/HszFLoZgEr9GENBBXnxqZx7IuWt
	c2aVO8UWsxeppFll5Yu7409zVyNtyg2kze3QXppEPTHH941rb51Yh6UmkQtGVOdmi9RAPdCkYbW
	5cAi1Ni0MDJJU+a0sUlmQIMGeg0CPxa6nTlpT3u721s9eDAGYf0O0=
X-Received: by 2002:a17:90b:5350:b0:33b:bed8:891c with SMTP id 98e67ed59e1d1-35bb9f56531mr1863267a91.23.1773813762214;
        Tue, 17 Mar 2026 23:02:42 -0700 (PDT)
Received: from SH-PF5NDYD6.Hygon.cn ([112.64.138.194])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bbbedd0desm924453a91.4.2026.03.17.23.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 23:02:41 -0700 (PDT)
From: Ke Zhao <ke.zhao.kernel@gmail.com>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	ke.zhao.kernel@gmail.com
Subject: [PATCH] tools/sched_ext: Update stale scx_ops_error comment in fcg_cgroup_move
Date: Wed, 18 Mar 2026 14:02:24 +0800
Message-ID: <20260318060224.47393-1-ke.zhao.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function scx_ops_error() was renamed to scx_error(), but the
comment here is left pointing to the old name.
Update to be consistent with current API.

Signed-off-by: Ke Zhao <ke.zhao.kernel@gmail.com>
---
 tools/sched_ext/scx_flatcg.bpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/sched_ext/scx_flatcg.bpf.c b/tools/sched_ext/scx_flatcg.bpf.c
index 0e785cff0f24..c4019ac6314b 100644
--- a/tools/sched_ext/scx_flatcg.bpf.c
+++ b/tools/sched_ext/scx_flatcg.bpf.c
@@ -919,7 +919,7 @@ void BPF_STRUCT_OPS(fcg_cgroup_move, struct task_struct *p,
 	struct fcg_cgrp_ctx *from_cgc, *to_cgc;
 	s64 delta;
 
-	/* find_cgrp_ctx() triggers scx_ops_error() on lookup failures */
+	/* find_cgrp_ctx() triggers scx_error() on lookup failures */
 	if (!(from_cgc = find_cgrp_ctx(from)) || !(to_cgc = find_cgrp_ctx(to)))
 		return;
 
-- 
2.43.0

