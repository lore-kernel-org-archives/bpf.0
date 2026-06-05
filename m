Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD8D3542F8
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 20:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780690859; cv=none; b=eGG4ZLHKbL8LNGM91xRSHlatD/P52W8eKLNw8V1fzmwSPWqtPbgYXLG/Pv2BO5gwG53HIyI3SEj5fzwvjqSH3s3UjwG2Knx+Btwp8agxTm3dNoyLbFCU9hAVwAmDulibK7kfzscvv0UGCHGAJoUtmCy7STPskeR7aWCCZ3+oIMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780690859; c=relaxed/simple;
	bh=IF3bLlVAYEJNXlOm/4+Rlrx92Z6NYnEGpeWPNJ04zhY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j5kHb6pcx0LIFuDQBAunUF4NdQG3H+nPawZci+y2VGniWRwlMEQPRXqCA/7VkMZYbzO0KE5wXUfS8y0uadeZr1NuHICGB1k6HBUSg4R87l2wsSwWefgEUthrW5aWIyg0JOjs5Jr1EGkXrfi4Baed71BJ3hs3zlkvq1ccIcMg0n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nn1OleIf; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nn1OleIf"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2bf2247e38eso24406915ad.3
        for <bpf@vger.kernel.org>; Fri, 05 Jun 2026 13:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780690858; x=1781295658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R1Y2tNa2HZ1zwUJNN0kQs2FqAhqUWf2d0UQ2wElOB1c=;
        b=Nn1OleIf+dmbxSryGxG44NyiFO0nwxtB5zr386IYXNzByQHhB0LQzbtGZCglmE+odd
         N+A3/qGtPs8BxglaimoGX+43hW0aJDDMSb2dlUamkbQA1WBiYB9Sw8EufQO6CP0ac269
         FY+ZVMcrt4ZpT91x0DuRhd6elpWKoF/a2IaOzfobTx+zn0LIF2V3M9iBhMPaQC81vaM6
         GQ44xQcb713zbelJQmeBAbZ5Q7mKzv/SGV0UgnujkxKhz60dCixvFSG01wOQGWAOgj66
         aGVcZo0nBIeqA+ZxR7W9TEWhnurc8q8h/Pu/w0/eYfOCYgBf7KAhAbpbK8HNkU2DGXHo
         KDzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780690858; x=1781295658;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R1Y2tNa2HZ1zwUJNN0kQs2FqAhqUWf2d0UQ2wElOB1c=;
        b=D0wK4XbBT/fizaZuDhf+15bhQVWHSv1GPDUcQn7tk5af+RHbHo7UOiANvhfeFgrm/5
         rn7b/AGZi5yLff71864I9cNnMV2BIOYhW9CT1ur6ZfV6+HMmXRXCq4he/C6F12k6YlML
         51+fj3S+NTcOIuSb7o5zw3Td1MRtQs+OsOWnKj2CcVJrArzjFAFhmwGvYj2FTY8cX2VQ
         Glx+DZFMPKgdCkb0TDL/VkAmMg+hFiY7xRGdJH2ReZn8nPTILLsUhSTNZGnQXTRWYYFZ
         ixdX4qgkmVG9aObsVmfjrhhEELra1q4HwdbB1Szo6ItKp7D/3AyZgdqJ5LkKT5GgpNV0
         Qdbw==
X-Gm-Message-State: AOJu0YwVdnc7J6mfyR2dBT8S5UkyXNYfQ5+L+6GLMTOHxt5zLY8JORmp
	j3iL99F73NaLmwuhV5udPD4jPwJehlvjBBTg8D6D7QNeg7nMhVbYzFgAGXdkmw==
X-Gm-Gg: Acq92OFKF/VbaZDZ+TTmEo9u8FSXmtkmJlwvGU+qH4IxeGzRZjvWcOXwZ/DfRBkDy6n
	pxxjMve/g7FGJKYVGa57GLP/DUBLNjGEofAfkEzwyiyGzhhSRbQyrHwpVvQSMq+GvVuLl9FGeIo
	qqPFNq296ibriD57qgEt9OH77NM2gxl8020uVCebUTM+LQfFmgAmZhhwUgjYE2+OLEOauA3EHf5
	IMVcrkKrKOyHfaVc0XWWQwHCXLlUYT/Td6EjduOin+s1/mhYQ9GpsuwZ4lcxg29yJfwfVk9+arl
	vYj51P7Zvu/NS0gqXeJPIfjSYZkBXNTOgUIa1VY1oQZ+1ydhVjD2S0sjI/fvdqyRkET4E+c/lOz
	10WlbepH59S3ueQwAvM7I2v9EZuKd0bCd5LhDiGM27JXfFELoh1VwgVfc8mLnTNqu5J92vbsjjy
	1+6g88gm8HoPZ2Nuv3Xn63JBM=
X-Received: by 2002:a17:903:15c7:b0:2bf:dd0:c8b1 with SMTP id d9443c01a7336-2c1e78acf24mr58595315ad.0.1780690857586;
        Fri, 05 Jun 2026 13:20:57 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c1664a67b0sm101155435ad.80.2026.06.05.13.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 13:20:57 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	mykyta.yatsenko5@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 0/5] Object relationship tracking refactor followup
Date: Fri,  5 Jun 2026 13:20:51 -0700
Message-ID: <20260605202056.1780352-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

The main patchset refactoring object relationship tracking in the
verifier has landed and this is a followup that addresses the remaining
feedback in v6 [0].

[0] https://lore.kernel.org/bpf/20260529014936.2811085-1-ameryhung@gmail.com/

v2 -> v3
  - Fix cleanup in patch 2 (AI bots)

v1 -> v2
  - Add patch 2 fixing silent failure when acquiring reference for
    struct_ops argument
  - Add patch 4 removing WARN_ON_ONCE in check_ids()
  - Add fix tags

Amery Hung (5):
  bpf: Fix dead error check on acquire_reference() in check_kfunc_call
  bpf: Check acquire_reference() error for "__ref" struct_ops arguments
  bpf: Compare parent_id in refsafe() for REF_TYPE_PTR
  bpf: Remove WARN_ON_ONCE in check_ids()
  selftests/bpf: Use bpf_dynptr_slice() to read file dynptr in leak test

 kernel/bpf/states.c                                 | 11 +++++++++--
 kernel/bpf/verifier.c                               | 13 +++++++++----
 .../testing/selftests/bpf/progs/file_reader_fail.c  |  8 ++++----
 3 files changed, 22 insertions(+), 10 deletions(-)

-- 
2.53.0-Meta

