Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577841FA272
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 02:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775009191; cv=none; b=j1Yfq3RpKee/jjYsKLT+2Zx/o8uYHzwAqnLv+Ak7cGAhfi6bPQ6SdWcT7AUbbl7xLYFgsVbMNwizXUos1ihWBu5L5rNktDQxAoseReD596wvhO2ZFE0vRIUKGBZ87ZdbeUEWVSQB44NpnT1Epn5snfZUFBS9Acn34EYhZrW5Jhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775009191; c=relaxed/simple;
	bh=UqS/6oqGU69ZsgfFTAhaFlERXmAQhHdd1g6RR4XMLws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kQrIFF5/EJroJSoMTUmdICSyJynn0FDdDrDNrQO/Y6WviaQyGcILJlXr5ml2E9tvZQ9T7qO2WcOc+BP0uv19pqJDlH+cCZLZ+fyPr0/ye9rI4RU5QKYNc1+GMBqIw/Tisae4JwgNx061CtaBGw6uhrARR8WBsqZGUrQLxB3T5qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SHUacpj5; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHUacpj5"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-35da1af3e10so3026433a91.3
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 19:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775009190; x=1775613990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UqS/6oqGU69ZsgfFTAhaFlERXmAQhHdd1g6RR4XMLws=;
        b=SHUacpj5YZdSy8gdYy+JB2MCtZO6otvajAqgtMD3lw5ab5Y9sIdjrULhq7LVHe8d/o
         9r1/JYg5y25CiGC9GtNKDY/hcFGLxSJM7LrUz/ctDkzH20dFqluzCz9vC0tqvZSbFS/N
         7F+bAN3tvbAEExheSlCkmj3vP/CUZOSGMq0sRQRnMvw+DCq54nHrnwhMIaVvyq48njw9
         URuAzL1xzWu/aueG7wJwgqrB9Y9OK42LB1ypYvbrx9yRlPOOEkm91UV28wSWlxFFHTuI
         hRAy7WXlTrsTafBXsqxRYveDtB3yPD/9rLFenWY8ij3rNM4FgsoMWqYNd42Rvq0UKCsy
         3bog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775009190; x=1775613990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UqS/6oqGU69ZsgfFTAhaFlERXmAQhHdd1g6RR4XMLws=;
        b=lAbRhnn4pXWraABu5z0wE0hv3sACfsih/TsrYS6BZ1twB3Fpf8LyiMNTJzKjXBLQBR
         XZ/9HVf3l58M5+lvgCEllEoFUwkJ0i300zg13KCk3insjsVNVflN0UtHltYttegN/5eS
         aUeOHZlBn1f+D3vdPTVKh7pGlSea3YhNQi7eOz5K5ZRe8YUV89n27sZQ+sSdXZECzJCD
         IqlAqND10vx/rhhOnXX5u/Z+cJmyimTn2MgpxXxQONB/u6iBsaePuBIzQsqEt+bH3l7T
         TXXWfCP0pFxgf1yt05t/FBDhs+eodCPy9jG2kYRTZX2cQdypMCcGnOqK8pdaqAoOkPWb
         OelQ==
X-Forwarded-Encrypted: i=1; AJvYcCUffEZaYfgivhIpyKXd/d1NVDX0QPuzSNluo+T2/FNHYXQirNqHRZns5HGhpKOuqPez6cw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNg+a0ur8DEky/3Y+HcEDCmEPWovg+KXmywaz5bzFjzD59ews+
	v7xaiwmaHLvbM7fKe2Qeuo0dwF5MSPUWtoHNAzls55rKKAnpjBJjzxSN
X-Gm-Gg: ATEYQzw1Xj/4Gvs2UeD6dZSeZDP0kr+LcN6ckv/VcbyGGXJj8s1g4EPp5K+VTsBxyDA
	4dlAPQ6/HCgB5rf9NJ/y2LADgZcvH71Vo68CsyYy9EM+kNm3qUEGciNKfoObiIdws+PuadY3hyX
	yhLHZk4O/xQHlUTt8NjEpszHLzSuUI2Z4fEShyj7JDhxeCZsBViWT2pvJRruNV9gF6FPkyLxUz0
	fL0ovrO7DB6lrWoYWzor69Bpc7wFWu767Evmot9WicDpSIMeARzieSGBTYrXPKD4sWkIM8LnIh7
	aEOjg0iV+oCWjlbio7MPpPWQ08UyP5eQSZ8Hhx92vHipxGTBa8v54+ojfcwmsfPKkc3P+lgUnTW
	4CAX+dWKw4GWewI5tWdXySWQYkn6eJIVctqBRu+B1x68+OHp0YSKBMH0eAM4+WrOG6KOJTLke5L
	gsuxOz9ZpadtXQFh/x3zyqNUkO24SR6eTBsXW1jBZH1SRQ0Q==
X-Received: by 2002:a17:90b:510a:b0:35d:9927:e023 with SMTP id 98e67ed59e1d1-35dc6eb3964mr1589507a91.8.1775009189691;
        Tue, 31 Mar 2026 19:06:29 -0700 (PDT)
Received: from localhost.localdomain ([47.236.127.140])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe66fb67sm3096224a91.9.2026.03.31.19.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 19:06:29 -0700 (PDT)
From: Qi Tang <tpluszz77@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	bpf@vger.kernel.org,
	Qi Tang <tpluszz77@gmail.com>
Subject: Re: [PATCH] bpf: propagate ref_obj_id for dynptr slices of refcounted dynptrs
Date: Wed,  1 Apr 2026 10:06:18 +0800
Message-ID: <20260401020619.71939-1-tpluszz77@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAMB2axNeSJv_yWDHk-kJLV0RCLrSkxfoNGZ5zyVtDP2dmehv2g@mail.gmail.com>
References: <CAMB2axNeSJv_yWDHk-kJLV0RCLrSkxfoNGZ5zyVtDP2dmehv2g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Thanks for the review and the pointer to Amery's series. Noted on
the selftest — will make sure to include one and run the test suite
before submitting next time.

Qi Tang
