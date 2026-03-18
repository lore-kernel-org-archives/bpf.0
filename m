Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBF2379EFD
	for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 08:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773824050; cv=none; b=bgo82Bq9ngaSZASKDo/g+iYNxBo/6c0S8VR11YIlSrc4mpFih0XZzrhfu+IcoKIeJcE9pRF2QcFi5G15zbKQx389CY4bXGyw73b9XUkPJFRn+SjY9vhApF8YvxRuNlNOGwxbONArynQAIWx/U0Ej8PfXvZovYopH9tRsPXK0O5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773824050; c=relaxed/simple;
	bh=772FT91vOzTy79kAR1e12rWztA2xnFttMlcdGMjdOJE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L5RRZbIExMzlJES5ohJKnTGK8ETj3C0xFSBBFdfjgo6h0i82EwhvLkFxr3b+Z3jhBvyo0evlfqzjuFjMdlzm2sA5lYpfNAUCa1FW2ZUdAaQ3cCwrZPMtZNcxquNYfsrEFubi4F6h/y4w0sjyXJ2cxdXk1DMKobG7NkUzHlI9D2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FuGkTy4k; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FuGkTy4k"
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-c737d3a51bdso2816093a12.3
        for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 01:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773824048; x=1774428848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WDCiBlD0RMPPvZvuirG6UUNdN1vYcUIKgUuyd+p2/z0=;
        b=FuGkTy4kU5xA5vdKsXwrbujE26QMozJXgLiVjiR9zIyy6sL4uBMEQRSzd8GkNmRjU5
         iCcrSe8D+YsAjNQI8LEkN9VW7t0DnDov13wW4/BhMIdwTcLEFumCIkWj2KSMmmEXjE3r
         FFbRzuh4ON9xGoopZN2a6vMpcY7HNZ4HwAnIG9g0RMu4BK7j5VwZq5srpYOY1z3yOD3e
         VqknxP/wdxtmqSZGzsVdWnwcixpSV8icuyHHpuPRBG169WtEp3KJ7cZ3C7j+ckTlkzab
         XTWiBrkkERJHt2qjGttl4c2dyBeCdqjE8E++4361q2jbc8ZNaXWQ5SMg11t2pE1S1ywE
         24gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773824048; x=1774428848;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WDCiBlD0RMPPvZvuirG6UUNdN1vYcUIKgUuyd+p2/z0=;
        b=JnCF/DH9v0Ftdy/DIWgCkApZkOI+UxjrtrFdoELVtV4ypI49jbUBararuN76ylDRJ8
         e4ULiJC6b6jbdsc7cT2Y/TCLHDUHq7sbGTaboPx5coddQhpqb2xu8OFmivMAY+cAeYZ3
         qU3qPaRBOWeXxmHcqTV3fm7S9A99Aqg1Wml7ePzyJp/o/Chuj1pgJTeY7FQkhHxpUGUM
         B4yp/fK3aDV1aG1SBkr0LcjFCvdlZcdh3gwhxiMga5qWW1D537m5vJqwsz6SQ/2odBdN
         NM5FsSAOjO5DncFzrmVxRulSZn8y49x97j4DGOBlDNcdSoyxW8iBzLn69nxM8PnstF5N
         1DMA==
X-Forwarded-Encrypted: i=1; AJvYcCXzK40JR4b4QDgN2d6LGJdYHgS39vz9FEzAXv/aNmdM7frq4wmywFvkGgymfHaY39f8CGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA+Yu3DiALHk0mlQ2Iok7K5bXE4DXv3AWcfxOskdX5t6KI8zLi
	ha1/F2q0jYNWoVA5PoWipMKxRwg289GwVLqQTWVnOwWaz02h3AvNnDw9
X-Gm-Gg: ATEYQzxWLZ1Fo9XXYnPtyFvGhmF2JQM10lmIhipmyI+GnGmoPngEUUcdMxwdZOD/xpH
	yQZWPYpgHPiS9zZwcTZHpNleTC7A2ynMGYnWwZzTdmWqtkoescwwBzSR9i04isbNHZciH0+W/L1
	6Dd/1pxzhUjZfev+ipnJHv5/x70gHaAr4aa/Fi7P+SLKa7W5RqOAQCYSprRkIXnBMqTzMS0ZzOp
	yeoxZ3Z0bIUhC7wLYZvFImi06HKU32YWuv4st/ns9lEk4hKiMDNODBde09Tc+RAzpyJMq+LMT44
	bD0DWOcoYeQuEfUYQVjwLCBs7P3/ZBg1S6jSJOIFaf8xq0LHxucsnellAPiaSKvhui18uqOYxBH
	nnuLh1t7XqfAP5p7s2I6TTGB3mickTUFIvAksim6tksaYfKV+qgbKDch0WrsuZ7KiCgmPmJuNEa
	Aqh5LXsCZJ3Qbv/42GcxfN0CIATBryjdm/VGi+bWhe
X-Received: by 2002:a17:902:d545:b0:2b0:52f1:e343 with SMTP id d9443c01a7336-2b06e3bc795mr27113205ad.35.1773824047687;
        Wed, 18 Mar 2026 01:54:07 -0700 (PDT)
Received: from SH-PF5NDYD6.Hygon.cn ([112.64.138.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b06e61cacbsm18927455ad.72.2026.03.18.01.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 01:54:07 -0700 (PDT)
From: Ke Zhao <ke.zhao.kernel@gmail.com>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	ke.zhao.kernel@gmail.com,
	yphbchou0911@gmail.com
Subject: [PATCH v3] tools/sched_ext: Update stale scx_ops_error() comment in fcg_cgroup_move()
Date: Wed, 18 Mar 2026 16:53:49 +0800
Message-ID: <20260318085349.78063-1-ke.zhao.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function scx_ops_error() was dropped, but the
comment here is left pointing to the old name.
Update to be consistent with current API.

Signed-off-by: Ke Zhao <ke.zhao.kernel@gmail.com>
---
v3:
 - Fix commit message suggested by Cheng-yang Chou

v2:
 - Corrected the new function name to scx_bpf_error instead of scx_error.

 tools/sched_ext/scx_flatcg.bpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/sched_ext/scx_flatcg.bpf.c b/tools/sched_ext/scx_flatcg.bpf.c
index 0e785cff0f24..c0574ff416c7 100644
--- a/tools/sched_ext/scx_flatcg.bpf.c
+++ b/tools/sched_ext/scx_flatcg.bpf.c
@@ -919,7 +919,7 @@ void BPF_STRUCT_OPS(fcg_cgroup_move, struct task_struct *p,
 	struct fcg_cgrp_ctx *from_cgc, *to_cgc;
 	s64 delta;
 
-	/* find_cgrp_ctx() triggers scx_ops_error() on lookup failures */
+	/* find_cgrp_ctx() triggers scx_bpf_error() on lookup failures */
 	if (!(from_cgc = find_cgrp_ctx(from)) || !(to_cgc = find_cgrp_ctx(to)))
 		return;
 
-- 
2.43.0

