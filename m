Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CDD35B650
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 14:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784728914; cv=none; b=RPoj9HqUl27BRErQnzxu1cPGIJl/qiHSRA9H9vUXzeY6s9jKPHjxK80EXk6sy4oBT0OEH3MA81fsyDkiSQz5j3Gym6UaOHYWeHb6Idqd8PuvqHsnrwMnsKUYZzQXuG1fLOiUPY4bR9hpqJdVCyz/Uu4cVSegrO5zlyCb9Xa51VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784728914; c=relaxed/simple;
	bh=IRZyJ0fopRXhrBse54glb0AttLyv2hlC/a2Ga8rTfYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fmpET1esoCLgwz4h6eBmhSMTlytmKt5pJCFYNxOzVP2axVRFkDznsj2R1QDVnfi+XUjYCkhb86aUEoKWHhPwOie0S+bhZk1eB0MDl3DeNDvxSaeidxGyHIIsurltAe99jfbdjVCUC1jhK1i2fUbOVckibMuwrmTjWpDqqQaG/gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NQRowHfa; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQRowHfa"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-ca913a601fbso8370712a12.3
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 07:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784728912; x=1785333712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lhfzR90Z74WPj2CRcWlLERVPxsI4JJvonp11/p/J06I=;
        b=NQRowHfaXL6iDzqeEeq+ZuOMQODllOoRvvZEJD1OUUnLkgeDH0R0VrxAbyx0oq27nK
         1/bEQgr4qipV7NvC82iH52xn1o2Ry15mg4WQzpQP61EOhZ+i1TQ2ujhGWM618qRrK84f
         k5qxmCxpDxz+V3UN3T0zHsDxtlrv/jvfFwApO+MJG9kZJEv3ldfDyDcqwWEHCK0BhSNw
         8Hpa/z6NIxfCHC2VkZZNAPNUFuT5abdGtrp55S2gVxiKkTf4tWoAcrEBc3FRfVlk5jvf
         G9dWmMDDi+dlhZZ41Ss4fBOtIoRAn7r4sSf9X3IExo8U6wx2HAiXBy3ekFByxU1/GZvq
         dcOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784728912; x=1785333712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lhfzR90Z74WPj2CRcWlLERVPxsI4JJvonp11/p/J06I=;
        b=K+ZkcZGQwWBXfCRxraiBMgx3bTJXe2eXaFHxHxeFn9sqj5ZCnu7xN2KtadUgkkgDzw
         GHhJFrfaNHuqfrtkmdoyysCjTiVbCtQKhO0Xnhxzm/toJYrysEJRYf8G52xWGbjmvTxB
         36ZCba/Ew1SWol3li6itp8Cb5kG/MYGHj/AhuuuMYXrr43Y3rh3DhDxzF3xyKRWhnVf0
         WFgw5Ub2Pf11BfpK+swkaiteDdlMaia7UJFVIdvRVqmJvwZWTFm/xomKcqjQ7EylHKHg
         jtBg5s1vR7QA2MyTsJX4bIF42IcSglzSP23w2gVHzmb6lgCryZ3WteObgZ+IrCocwIqP
         vwrw==
X-Forwarded-Encrypted: i=1; AHgh+Rq0MP6VKXqF3ghFOs/PUgaCyjHHH2sS0etsOyjwwVPHywEPa14ccKzg5GUORTKlvf2oxsc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbxcERlqXMCG9qkDk3h+gLyDQRyWTmQdVS3ZX0kqt1igVh8hRe
	xIpgKuFZWk7bbjAbVEdogbaqTKEScx/JYhF9zAOOq52PWjRFoZ6MhfIr
X-Gm-Gg: AR+sD118xmmPYDRePDhagXR6usiBxTr4Kw0sS2gSWM547pxjaiNN8DsStOkUvjwldlA
	9FYcVKoBMeZQvlMoZjfdwajfJqjf5nK7HA1vB1W8aImfEHuo+w+1cXgz8A/1eX4gQyDSQS3P9TK
	z3YG6+bk3sQvx2Cy5bSh16ctWHo6XG19uUg3zkGvmXWM88Ng9ccvFeAncue2u1sOUQFBpKj9HPJ
	UA2D1yv6wHYClaJQvMdycq/KyWn2No4RlbTfdb1b8xyg35YgaRXTuF8/VKA4l0IXrCiSYG3FA3m
	SP2YoaPBHKeS8ezl58HxlL7YI6wV0UMn/Y/kJFjmfyhW66lM0xVirvSjKrWeoHzO2HYTYPTC0tR
	F4vET9BnImRRC0GnwCo0ddOsHQPPiLttr/LgAk1sj5+Xz3eyj2CeBPfxHBQIbIzbzi2bV9f3EJr
	5y/akSq/wdXfYvS+e5/OSJkP/hvQgrK59iXDvqqi0wBevj9Fc=
X-Received: by 2002:a05:6a21:62c4:b0:3c0:b3f7:e5e5 with SMTP id adf61e73a8af0-3c3ad65cc12mr24097620637.25.1784728910120;
        Wed, 22 Jul 2026 07:01:50 -0700 (PDT)
Received: from computer.goose-salary.ts.net ([2a09:bac5:40b2:277d::3ef:c9])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbb8f1a8a1fsm1242281a12.26.2026.07.22.07.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 07:01:49 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 6/6] riscv, bpf: Remove BPF exceptions from denylist
Date: Wed, 22 Jul 2026 19:30:13 +0530
Message-ID: <20260722140015.1982158-7-varunrmallya@gmail.com>
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

This patch removes BPF exceptions from riscv64 denylist on
BPF selftests since support for exceptions has been added now.
Also, since the file is empty, delete the file.

Signed-off-by: Varun R Mallya <varunrmallya@gmail.com>
---
 tools/testing/selftests/bpf/DENYLIST.riscv64 | 2 --
 1 file changed, 2 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/DENYLIST.riscv64

diff --git a/tools/testing/selftests/bpf/DENYLIST.riscv64 b/tools/testing/selftests/bpf/DENYLIST.riscv64
deleted file mode 100644
index ca1beae7fe8f..000000000000
--- a/tools/testing/selftests/bpf/DENYLIST.riscv64
+++ /dev/null
@@ -1,2 +0,0 @@
-# riscv64 deny list for BPF CI and local vmtest
-exceptions					# JIT does not support exceptions
-- 
2.55.0

