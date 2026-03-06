Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6111F2641FC
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 19:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772824139; cv=none; b=YNOzDXFmqTmPcdtq6G1lQfEWXv5m2FjGO1/ciWGLK0C3/MFQ6Naj8UfWLYMgwB/1XghOwzaWFHLRL63j0sH730DE7dryW7G7cACH/RifcxS7y+fbbibZt2t3OCjFXYnpzQiYG+98q7ciXJjeFrWkUu5VlZToMAcr4gmauXGkAd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772824139; c=relaxed/simple;
	bh=edvQgNeOv46ZMOh4l6Nts64+x+jMDlczX+qkclgVkwU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V3yRswDPRw7ofOYHqRKcaPvf32V8QgCsFM0uaOVlA5zgB0bRDH6M+q7KhAh+2A9fQj8eUhFYnfvyQTdRbNnn1WWQw0Qh+iQNh0LvZEvifcuBV/dqudDQz6oPyCP2ORiPZwZ0gU7sBxueyFC/0wJZr2mSrgaWDgbqJSN4E3x24GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hPNSjFg+; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPNSjFg+"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-899eabc5292so64868426d6.0
        for <bpf@vger.kernel.org>; Fri, 06 Mar 2026 11:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772824137; x=1773428937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6Cv1u0c8GS3pzmzjgJjS/6YL+uN7UDrixGOE8PPuhuc=;
        b=hPNSjFg+AIi/crcNbZy4WoeEwJfrz9kcUTjdrSSk7Ge3i6YUP2OtR/GgiVix9UlSrI
         NN2yFzl2HkFUVIQpYbY/eEeyGwcI5wX9MrCj/BUGqalUfFFEqK/ZaO5cNmaqvvcun4cU
         NvoDFFHE9FjBimTZ0AYPHVHjg4POtpN/h346Xzh5d9q77xzZKg+rQ6P6mbXGgJ2AU06+
         M3NHhwoOELjW/J4f5eXY3MKkdzuqoBe4G+6IAKZfJAyJGVMV7nY/gPLFPPxmitwixc//
         wNint5BHAkCeG7M0NTGcvVLYviaRQxMKD67o6OWfltDG4l/v36sSQaageBTGOGc99WS1
         qdOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772824137; x=1773428937;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Cv1u0c8GS3pzmzjgJjS/6YL+uN7UDrixGOE8PPuhuc=;
        b=GCtkzovS1hnIekBkOhqt1wlU0uYrGlrwrOG3Nv2fOgaUzC9p0VVesTAfc+SNT1fl+A
         EYBmeRmmRvDR5UH4O/tYFppinbOWVW++0dy+a3/VPv8cqBZuKYlTlM721opJuiJsyVAT
         d4fpykXuCg+rsV9hxeC6ijfjejplqcBkkdbor3i6cm9Uu9cqVY71RIByc3K2/hwVMfxS
         VwiRShhaScRu+SY/hPYa5Y9kqKZMBr8Hd+HGuHCQTH71vvL6IOh94BVAbW58PyLnjGX0
         +26HJwCMUesXbUW4D+5xrfpeS71GUXCWm1IRxLaOCll6tPA6wq2Pm13lWZv4iOSehoqB
         3TeA==
X-Gm-Message-State: AOJu0YxyjJk47kIq066xGR5+LoSRoHit4XqAOqWYkJQhbTXGkJbH+UzW
	fWUsxzi8e5cpLlXEeEToXRNOvPSjCZJNC6wxYJvyw/zTHHLW4Sag1ddu2UpHd68w
X-Gm-Gg: ATEYQzxCTaGkSZZP14hCfeVil/doLT5LXgqLx5Hcr8Uv0LOJVeI7YSq/4Y+26BUD9Ic
	XEDWC0lvjveheIU2HF3XS8lpgEPWk8cHbheEhJT8eO/GU8X/hvbG4NOEy8rWMrg1/lXX1yosbfK
	lbfJ0x343GpEs6lOpEJnO8mzhGdVI1SKrYZmWlGk51ul/PnGsoP6YuUNjcqyIWKSxbCyUso40Y6
	XZUSZ23Nq0YO5THdtpyFIkrM3/ww12001fWfTbtX4dZtG4rNKfdM2BkKymOGaFWRvGtj1uI52iQ
	oHIvZ8qii++jRMXHxg6VyFEeimEQ0MKEjOSL7T4qg5kOpGROr5uVj1y0Z3CIacCqoBrbBmRqKFE
	ihcAF2ACu4c8TcI01U8OQ/tyJnvoZZaHSQWnbBHNAgu+mz4ZMf6dhjRiAGKLdEyvXeQkcH7URWJ
	15JNDCAVI+akP4HP5KOKhdcVuB4jpbZ4jZ//37WojjEwZN
X-Received: by 2002:a05:6214:2685:b0:899:fb3a:9f62 with SMTP id 6a1803df08f44-89a30a5c8bemr49048746d6.17.1772824137006;
        Fri, 06 Mar 2026 11:08:57 -0800 (PST)
Received: from 192-222-50-213.tail19a0b.ts.net ([192.222.50.213])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a317187c0sm20322976d6.50.2026.03.06.11.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 11:08:56 -0800 (PST)
From: Jenny Guanni Qu <qguanni@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	ast@kernel.org,
	andrii@kernel.org,
	lkp@intel.com,
	Jenny Guanni Qu <qguanni@gmail.com>
Subject: [PATCH v2 0/2] bpf: Fix abs(INT_MIN) undefined behavior in interpreter sdiv/smod
Date: Fri,  6 Mar 2026 19:08:53 +0000
Message-Id: <20260306190855.937198-1-qguanni@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BPF interpreter's signed 32-bit division and modulo handlers use
abs() on s32 operands, which is undefined for S32_MIN. This causes
the interpreter to compute wrong results, creating a mismatch with
the verifier's range tracking.

For example, INT_MIN / 2 returns 0x40000000 instead of the correct
0xC0000000. The verifier tracks the correct range, so a crafted BPF
program can exploit the mismatch for out-of-bounds map value access
(confirmed by KASAN).

Patch 1 introduces __safe_abs32() which handles S32_MIN correctly
and replaces all 8 abs((s32)...) call sites.

Patch 2 adds selftests covering sdiv32 and smod32 with INT_MIN
dividend to prevent regression.

Changes since v1:
  - Moved __safe_abs32() helper above the kerneldoc comment block
    for ___bpf_prog_run() to fix build warnings reported by
    kernel test robot (W=1 doc warnings)

Jenny Guanni Qu (2):
  bpf: Fix undefined behavior in interpreter sdiv/smod for INT_MIN
  selftests/bpf: Add tests for sdiv32/smod32 with INT_MIN dividend

 kernel/bpf/core.c                             | 23 ++++---
 .../selftests/bpf/progs/verifier_sdiv.c       | 58 +++++++++++++++++++
 2 files changed, 72 insertions(+), 9 deletions(-)

-- 
2.34.1
