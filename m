Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9718D3655C4
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 19:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786994182; cv=none; b=isqCg4SkIVAk6rtb2sQcqRVdi8afy4fOsYmcQ+r2y3MGo7ykpeYQ4HXNi8v2xjB+DfAh5d9tjqEYA+rpTkPeEnkQuAvAJru58r19v7xK4WgosFldBtbdykPv7bexlnpv5Iclvwqvc2WKa42k7dWndimImQQdn0S3VM5elD6qMig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786994182; c=relaxed/simple;
	bh=tZqXR4UWRT9UZjH+GU8+jx26UQeJs4dmccpXXY4Dv9c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SGdbwYapa+5yx9Z6qfcEVXaW595uh8BdGLCIOmHqPRI0kghdIL6pV3blXxvP0jOv2nd6OVB28BbPqBo7AsgGBYbWxFdG8o73aX0viCJW6smhNQ8GyrKsgldX/tBRbfw13Ma/sskfi/FxSa8YohJ9IeRz60ubHqGwiRRqWFf9Hv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=C0DJPtD6; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="C0DJPtD6"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-384930ca5e2so4241783a91.3
        for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 12:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1786994180; x=1787598980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oiTCxh3PXAHg2e2PXNbMmPdmcyGkYUA/q7OkHsQ+9tc=;
        b=C0DJPtD6en7X0eHr5O3ysMiKPmnvq7NVsy0heUu1SOinNsZDwMi+m4xbJ8SIffsALv
         yDKYhK4rwXSTSI3D3hduhBThtEvSPS9Dec6lZpnXfotMbCSC4pnb/vEBJeI1KBPpVwZr
         IHGijbYET1dkZZUQCXpvP8Qkatl1bI6et6rA8dYRFAH/IKkxKygSdoATYLTAl80sWwVu
         +WQ5mZp296OzshPQuR7OgvPXPxf0TY1ZZPagd/R2GDwj5qaS5IYspQpI+0IAMTnOTaSV
         BID9zOsTuKjq/YH8CGlWvkhsOjAXnT+/m2Kkv5HDdVVSUAl/UY0ou64IzllKDEr0VxS5
         TScg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786994180; x=1787598980;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oiTCxh3PXAHg2e2PXNbMmPdmcyGkYUA/q7OkHsQ+9tc=;
        b=jnWlOmeJMN55x5xpQH4srMgqXeXkeAfxH01faGc5wRbA15Yaz1wuIYKzA9KXkXSJgN
         9XGbxNZqijtfYMehugVfPrTwg1WwLdDbwZEFlr8hTwkf38NQHS5cMsRsJsdHBnrOSPrl
         M6OkCyeu7w258uSNZt3JEmWhvAJkgvYZMz4J88RY0usTzNovai13d0LPGRd8d6s0+7rA
         SDfUmk9IKi87z3/SBTOCsbo5L3P3Xq7OlRzWaDzUYOBGizyhYMLc3EZtf9Sm57EKNkzn
         A2M6xQo7bw1PzInLZNFXVZgTTP3WzpoECy1ZqBGtgOYvLI4QYeZJ7IVtY+rZZXsvrsb8
         aT9Q==
X-Gm-Message-State: AOJu0Yycm6MQxSzHeXYDmaWxy8KjJJIAp+R6XQZbAckFopyh7xGRdWTd
	mm8klaVePfBZW8KblXB7RWaZXANnr6+CHYmn9AgMCD18KHAwarYhvaqrcyYA0y3RtVhrii+dgUw
	xmM6vKes=
X-Gm-Gg: AR+sD12TfZ3wxUMxeqbSNTcLxPnhScWQ6hULPw2nLOzh6C4Kf/uiM4Bh0Gl8jGARHbK
	dwnOXmapJaYd54OjV5BdHWmmm1xNGmMCEGBhHtlzrT57/NchUrIlISGtbJupuPGR5kfhwz+vUiE
	duTEa5ugmHorrwyQBVm/HlVLj0USgr72h8btfRj0BzEvTwwsU2idqDL4lXux0jJ9y+3TV4OheCn
	M43bwXKmz/9BrTYwwWSYwOsYx02TM1pnpvFriyoOaBrpNobbUo353LspKMn9skX+truAy/+CaB/
	Ves2I3HcZieAsvsCce0JzVKjfrZq2wneS42bGWzSfLDDbQfyu+gAcKMFd7MDptBBS3YL2CJ+7ak
	I0JGCow+TUicVFfFZxIwig4NuXtLfbn4jmAC5DUqaxjVFSECBCqc1/DG9S34xUVjIlm92ZnKnz/
	j//tpdW46vaBlikfgMvUo3pg043hEmIaNA8qHh62bTXUX1029XNCO5PJDDc5tl2Bzn4T7Fl1NcA
	35n5ysRQIgnY7dTM+Yj+IE=
X-Received: by 2002:a17:90b:524b:b0:37f:bfa2:1887 with SMTP id 98e67ed59e1d1-3933cb3f7d3mr29202519a91.8.1786994179821;
        Mon, 17 Aug 2026 12:16:19 -0700 (PDT)
Received: from krios.ht.home (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3933b62696bsm5485597a91.2.2026.08.17.12.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 12:16:19 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH 0/6] selftests/bpf: Fixes and improvements for libarena
Date: Mon, 17 Aug 2026 15:16:10 -0400
Message-ID: <20260817191616.11071-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset addresses issues and feature gaps in libarena's existing
code, and optimizes some common code paths.

Patch 1 fixes up an inconsistency in the SPDX tags.
Patch 2 incorporates a followup patch for bitmaps that inlines
the nonatomic versions of the set/clear/test operations.
Patch 3 makes it safe to use the arena allocator under IRQ reentrancy.
Ensuring the allocator is correct under NMIs will be addressed in a
subsequent patch because it is a larger change.
Patches 4 to 6 add a calloc() interface for the allocator, along with
a benchmark that is useful for quickly finding obvious regressions
during development.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>

Emil Tsalapatis (6):
  selftests/bpf: libarena: Normalize SPDX headers across files
  selftests/bpf: libarena: Inline nonatomic bitmap operations
  selftests/bpf: libarena: Disable IRQs during allocation
  selftests/bpf: libarena: Add calloc() call
  selftests/bpf: libarena: Add a benchmark for malloc()/calloc()
  selftests/bpf: libarena: Optimize and make public arena_memset

 tools/testing/selftests/bpf/Makefile          |  18 +-
 tools/testing/selftests/bpf/bench.c           |   6 +
 .../selftests/bpf/benchs/bench_libarena.c     | 210 ++++++++++++++++++
 .../bpf/benchs/run_bench_libarena.sh          |  31 +++
 tools/testing/selftests/bpf/libarena/Makefile |  31 ++-
 .../bpf/libarena/benchs/bench_malloc.bpf.c    |  51 +++++
 .../libarena/include/bpf_arena_spin_lock.h    |   2 +-
 .../bpf/libarena/include/bpf_atomic.h         |   2 +-
 .../bpf/libarena/include/bpf_may_goto.h       |   1 +
 .../bpf/libarena/include/libarena/bitmap.h    |  30 ++-
 .../bpf/libarena/include/libarena/common.h    |  71 ++++++
 .../bpf/libarena/selftests/test_bitmap.bpf.c  |   3 +
 .../selftests/bpf/libarena/src/asan.bpf.c     |  21 +-
 .../selftests/bpf/libarena/src/bitmap.bpf.c   |  18 --
 .../selftests/bpf/libarena/src/buddy.bpf.c    |  44 ++--
 .../selftests/bpf/libarena/src/common.bpf.c   |  27 ++-
 16 files changed, 489 insertions(+), 77 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_libarena.c
 create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_libarena.sh
 create mode 100644 tools/testing/selftests/bpf/libarena/benchs/bench_malloc.bpf.c

-- 
2.54.0

