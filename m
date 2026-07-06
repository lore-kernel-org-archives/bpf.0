Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3418538229A
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 18:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783361856; cv=none; b=qcuesG3BSu1X09Yg2+GvJHUJDZzZv8KtRpc/Dm9bz7mWdboeuBJb3tnIAF7dAAdML23cCYxYZd1PfLnzbqMMyKo6a2GNs79yeGyI/wYjy/gDoiBAspSQMJE793iv9mHX5FT7BAJzgxxY75WozzFM+VeLDLwwxYSzCvLVyH5C9zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783361856; c=relaxed/simple;
	bh=uGRBKCzS2u2DXRohLNfmYBc2EbiXKDSLmpBYPX5fO1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IrZhR+Lhu2mAX1E3ICv07O44bpIe2AlSRxpubETkm+mEJ2zA5wAGsM//+vxm6VbpqL6qeF15xyspEUTiXOob5qUM/B2nQ5/DLNFR5cMzADPe1++DNmGSFAwFZ6u0AwOqN23UBARWa1Z2OVmWMHzZEDQlqQ4S2ALRuskBPaDywCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=eoE+Ou0I; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="eoE+Ou0I"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84780c95e2eso2598201b3a.3
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2026 11:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1783361854; x=1783966654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NbkX5/oO7RDXS8/3JwepjXOBbP5OzlZzz6ME/c1tPSQ=;
        b=eoE+Ou0Iy/0HyiEB0mRd3rQoteeDrczgTfPlWs2yiQrRyEPRqC9jtvC6/ES+5xnpBL
         gIB0IEcUreF9I8URIkZDrxcPMPraYOmMnmnGAMAbDrOc6APoKwCJGuHCbQxqgrODh/Y5
         RRc8yxNe0QAf4+HvjYwSDkG3txDelEkKeXzVIsmDMeGNiwF1noCGhvlXOhlDBDGAVC9+
         5ktT/mX/IDKeKqh3jbF4ctBrQNWwDZRa75D/vvLpgtHKJPYQu2GfTFVm9tBwDQ/xEHUn
         j9tOIxf9+WPDRVB0jQss4ALF9tY3J+8q+1knEq381tRkafwha79igHLIPsNpuLNKbNtW
         C9Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783361854; x=1783966654;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NbkX5/oO7RDXS8/3JwepjXOBbP5OzlZzz6ME/c1tPSQ=;
        b=UqGWRIGdOmArNOFm01xvcgsLacc7c8PuNRu+Y6QBh8b4wkG/Xa1BfJSH2ReU4R4fnF
         hWD2NBH+VUFswBztP90aqnCjyUVbXJMPkIl2Ecttzma6j9BKYmHqQzwBR1lPENhWZRxk
         FYNDcDOdssVET/V0RCg5e3uFSW6OTYRDbH4v41K1yOdFYMkG8efSCQunl6wfANnzsTlL
         1+G//nAvmzCEPlFegin4P+NSp+ASzLRIQmhMp5YiR0R71jR1LBmiPQswspWi80Z0FGOX
         AtpTdyngWB1C90uULpl7YuCsHdX3s/TDoXhC+YzPAnyRBs0vLhPxGmERvKLwn/KVTUaw
         X6zw==
X-Gm-Message-State: AOJu0YzJHJ6FKcln79SYBBAeh5L2y9id917KYt2qHZY1C0EJfqy9Nf/r
	y4SgHsMv7X3tvvIkkYyPEdp7yK3Wle1g6yjoCxSGHknV292agxNU50qh+6xwKbT/5Djf9KqXUAL
	NdqJIOWA=
X-Gm-Gg: AfdE7ck6SVpHlquvjMuowIKTOT03dyrDxKxgP8NXRBJu5JCWqSgNZfYYk01AFWjyeRD
	b8RfcfMw/5UG+5Itidush1lloYQVH3cY6jr2TkMUziq64H3T0WeZYvAXSyBb1WTjMx7QT6Sl5Eu
	WRniMb/9xGlBhKkTjKL6v3VfCcwWvdHN5UBrFT0uTZ+wkzUg2dKyI/7SDKu0MPnnplc1qCYzS2D
	TPGF7Zup/G9X3j5omFMgakaL/IJVemHVpGHrf0VlCwjl6K48Il/aY0ik8/0bLTOXPr/9UgztLWN
	ZRuX3iz6u/WtoTrnBtLdceGEieoNhvFYWAh0Qm0BldMAjVQ0ED2+3o6xaWienKThApVkvd4y0HA
	m0hMS6tViN893Flfj4glQyH4fEYnEEGU/aZZ0+xAmy8KWcsy50BQL/sBgS6gGDGJDPgtIbePbZ4
	ptwm0ElaIJlVE9wdQWytlCIB6JS6+WlGEHtVi1EGcQBTrK/zM=
X-Received: by 2002:a05:6a00:21cf:b0:845:e9e8:6458 with SMTP id d2e1a72fcca58-84826c0ddcfmr1616405b3a.20.1783361854391;
        Mon, 06 Jul 2026 11:17:34 -0700 (PDT)
Received: from krios.ht.home (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6d498dcsm4192997b3a.30.2026.07.06.11.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 11:17:33 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	mattbobrowski@google.com,
	song@kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH RESEND bpf-next v3 0/6] selftests/bpf: libarena cleanup and bitmap struct
Date: Mon,  6 Jul 2026 14:17:24 -0400
Message-ID: <20260706181730.21731-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cleanup patches for libarena, along with a new bitmap data type that is
in use by sched-ext. Patch 1 is an NFC that properly renames the buddy
selftests for consistency. Patch 2 fixes the zero variable used in
libarena for can_loop based looping, and afterwrds removes all bpf_for()
instances from the code. Patch 3 fixes an (untriggered) edge case that 
could cause spurious selftest failures. Finally, patches 4 to 6
introduce the bitmap data structure along with selftests.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>

CHANGELOG
=========

v3 was resent as the first submission was missing the first patch.

v2 -> v3: (https://lore.kernel.org/bpf/20260701185235.4516-1-emil@etsalapatis.com)
- Remove unused macros and fix typo in commit message (AI)

v1 -> v2: (https://lore.kernel.org/bpf/20260618085626.19633-1-emil@etsalapatis.com)

- Added acks by Ihor and Eduard
- Fix missing commit message (Ihor)
- Enforce 64 bits per cell with BITS_TO_LONG_LONG (Sashiko)
- Add test for bmp_copy (Ihor)
- Add atomic versions of _set() and _clear() (Ihor) and add a parallel
  selftest for them.


Emil Tsalapatis (6):
  selftests/bpf: libarena: Replace leftover st_ prefix with test_
  selftests/bpf: libarena: Fix can-loop zero variable definition
  selftests/bpf: libarena: Clean up allocation state before buddy tests
  selftests/bpf: Add arena-based bitmap data structure
  selftests/bpf: libarena: Add bitmap selftests
  selftests/bpf: libarena: Add parallel bitmap selftest

 .../bpf/libarena/include/libarena/bitmap.h    |  34 ++
 .../bpf/libarena/include/libarena/common.h    |   2 +-
 ...asan_buddy.bpf.c => test_asan_buddy.bpf.c} |  10 +-
 .../{st_asan_common.h => test_asan_common.h}  |   0
 .../bpf/libarena/selftests/test_bitmap.bpf.c  | 394 ++++++++++++++++++
 .../{st_buddy.bpf.c => test_buddy.bpf.c}      |   8 +-
 .../selftests/test_parallel_bitmap.bpf.c      | 190 +++++++++
 .../selftests/test_parallel_spmc.bpf.c        |   9 +-
 .../selftests/bpf/libarena/src/bitmap.bpf.c   | 245 +++++++++++
 .../selftests/bpf/libarena/src/common.bpf.c   |   9 +-
 .../selftests/bpf/prog_tests/libarena.c       |   8 +-
 .../selftests/bpf/prog_tests/libarena_asan.c  |   8 +-
 12 files changed, 900 insertions(+), 17 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/libarena/include/libarena/bitmap.h
 rename tools/testing/selftests/bpf/libarena/selftests/{st_asan_buddy.bpf.c => test_asan_buddy.bpf.c} (98%)
 rename tools/testing/selftests/bpf/libarena/selftests/{st_asan_common.h => test_asan_common.h} (100%)
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/test_bitmap.bpf.c
 rename tools/testing/selftests/bpf/libarena/selftests/{st_buddy.bpf.c => test_buddy.bpf.c} (97%)
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/test_parallel_bitmap.bpf.c
 create mode 100644 tools/testing/selftests/bpf/libarena/src/bitmap.bpf.c

-- 
2.54.0

