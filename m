Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEE334B410
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 14:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784728849; cv=none; b=eSEfK9a7XWSlkWON3konXxZdtXr/5L7AcekavPN0wcPso3R+YL6PZZqCQ9/q0k22fActxiOil2zc8DtKYcZZIP76heR0B63KSyNvNj1kElSvWxxZ17cIzrvVhMJr6HVDBEcCqIg8T4hPKX46/gUPcKlEuMrZ7H7JG7wE6qkmPqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784728849; c=relaxed/simple;
	bh=F495hDoANVE0TNTS+OBWz3nMY99148N2vW8xj3+FBPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ola444QvcAibDQse1k2qk3GeeLzYT0JOKPn+ZmIXguFUrLAcjKQLslXtTX9PaPGkB8BgnUTTiom3yfrskxCe+Pgg72PySwqVikpAxER/lgfg+ZLawUbyqrEHa914MzHGG9V6TRsJw5vh8oZ1eHNtIIOUkENwanhjYcIwA44JtdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XUt/uaIn; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XUt/uaIn"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8485b358552so76469b3a.2
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 07:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784728847; x=1785333647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AfYPTs27MYWGdTxiCTfoJlFIBIXHokfTJQCS/9/yrrY=;
        b=XUt/uaInwy1xCGEyrH2smh6K6myqBvCiZ4aoBmeUDtG0sCyUREX3XoDeW9Hfpn0M6z
         2VNGSA/0N+58siWgKv+/pZe9ygPnw5dWHAOBaHO5KIefeM1p0xzALwsDBl0F4C8LwKtK
         vGnPCpqEb8SqwFDaVqLeUIS7rWKfDMUC8pJSDmsOsykPm0qvYtYFBDNffYCJFrBb4iiT
         CPABsHgZ+elSoBAk+eg6n8EtX4SZSZEm5+CB0f6zGg7wYIYdnTV05HmPwa9EB+eXT8wp
         qapH08qaW24lfqqdP+S5hkG5RC8PLnoV39xZdZVG5NY+73tgrkdq4McdZ1xnVHM2h7GT
         U6LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784728847; x=1785333647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AfYPTs27MYWGdTxiCTfoJlFIBIXHokfTJQCS/9/yrrY=;
        b=hTO8aI5whrP1bYf/Jr8ngRtBkeP0ETWzxiOQZKFn5D1Y2y4OhYPY8PU6QkSEdbQqu2
         nsS/J8/D67ixPb1BBbT0Avt4WADXgM5KEfWJ8h+/dlnFfyBW1p+GqxILSot+W/TP10oP
         ogcZ//9DfnRODmYdMJQqIVQfaJZYnm/WTOZS9MQe//PeZcILUAIz9+7ZcnIHa+6zd0iB
         OPvmcDuBYKEHWW/ch7oP+mLgaO1nNhNNXjCwvLvJR98zG2eegWji48I0/7kjEpKeIkvQ
         zobWq22qB658JK1ieh5XE9Hcq2LUkkGieQDXfrPXWNncaUGTAL5LQpsnbGsApVwNFIWY
         dTIA==
X-Forwarded-Encrypted: i=1; AHgh+RqBXJt6BXiVktucs2we2vG1C1HYJ+E7BEXzjBCXMhnpoCcv3stYgPBjALx9UuhV5xjbyb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqJD+lRnHY8hD3oCo35/FksonGTqcG4/TWlBuEEnmm8wuKxjuh
	4r9bPpiTBTEKioMglByjCebdc3ODEelGfjKXtx8vv7s0hIdCD84JxkGy
X-Gm-Gg: AR+sD12yKwtKtF5bmEadeqHHC0/KHrbziymyMR+5lwKQAONhHe114Ul3g4ySA6xfEOy
	ugKi6sf6GEzsNe+17wKncu8Fiv9DUZx3OeCdD2Lqnk713OSG+DCJ0sJG+xhVTV31vRclcfQd2/u
	+qS0ZylkI0hBjHm7iHQkJ8V3npolytGBmeM+hUCvp0ZQg3ECBnsWucbg3jscsOonn9pYraWMNgA
	wIsB+ReCPFVCwd/odnqcjzFIcMl7Ng2yM4Ny2ljEBp+S3eVkPJjaFiCSQThoSE5xkhDB1ZLZc3f
	3Yrr6mnfkEuZd2PGS6ob/V3RueMy8cr1oaAtX/pYyW45kJRZM0UPfZJMJjsGTNwXDgZEt/gJ1mF
	8n967znQIuZ7Hqe3T4MM8D6ZxJYVXwawmT2Ah2uaQLa2QG82npVpQ4ZHO7zmkwTySZ2gFMli+zI
	iIJ4M3dWe9RxwiPFf2A6/4oBIaRnX0hJuVfDIt/9UmB4PJnXs=
X-Received: by 2002:a05:6a00:3a21:b0:847:8d2d:712f with SMTP id d2e1a72fcca58-84c29239a02mr24030412b3a.10.1784728846034;
        Wed, 22 Jul 2026 07:00:46 -0700 (PDT)
Received: from computer.goose-salary.ts.net ([2a09:bac5:40b2:277d::3ef:c9])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbb8f1a8a1fsm1242281a12.26.2026.07.22.07.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 07:00:45 -0700 (PDT)
From: Varun R Mallya <varunrmallya@gmail.com>
To: pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	bjorn@kernel.org,
	pulehui@huawei.com
Cc: alex@ghiti.fr,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	puranjay@kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	varunrmallya@gmail.com
Subject: [PATCH bpf-next v3 1/6] riscv: Use arch_stack_walk() for the kernel callchain
Date: Wed, 22 Jul 2026 19:30:08 +0530
Message-ID: <20260722140015.1982158-2-varunrmallya@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260722140015.1982158-1-varunrmallya@gmail.com>
References: <20260722140015.1982158-1-varunrmallya@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace walk_stackframe() with generic arch_stack_walk() which
already wraps walk_stackframe() and is the generic mechanism used in
archs like arm64 to build the kernel callchain.

Also decouples perf from the internal walk_stackframe unwinder which
is modified in later commits to accept a different function signature,
which warranted this change.

Signed-off-by: Varun R Mallya <varunrmallya@gmail.com>
---
 arch/riscv/kernel/perf_callchain.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/perf_callchain.c b/arch/riscv/kernel/perf_callchain.c
index b465bc9eb870..93a12d53aa26 100644
--- a/arch/riscv/kernel/perf_callchain.c
+++ b/arch/riscv/kernel/perf_callchain.c
@@ -2,6 +2,7 @@
 /* Copyright (C) 2019 Hangzhou C-SKY Microsystems co.,ltd. */
 
 #include <linux/perf_event.h>
+#include <linux/stacktrace.h>
 #include <linux/uaccess.h>
 
 #include <asm/stacktrace.h>
@@ -44,5 +45,5 @@ void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry,
 		return;
 	}
 
-	walk_stackframe(NULL, regs, fill_callchain, entry);
+	arch_stack_walk(fill_callchain, entry, current, regs);
 }
-- 
2.55.0

