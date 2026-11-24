Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795540102;
	b=L5jK/5mF5uepOL9KFMbS26aMjjThGaFmTSOe58rZ9JzYf980tZjxc2EQqzvTjN80lDeJ
	 KLhaRYixd2iVUQdLYSmW77oQgjRKtRqjrUGCefPltyqXwC6cZiKIuYtam087a6k7pPpBt
	 2wAZ8eAI8UNRYWFMCtELJVwSYn0RzmYMyRBy8/tSiCt/qlSIveDnkoZz8qSrhfqvExeCt
	 vUBTtuiWTgyauWRJu9IfQFdje5Wuf/8G737CPlhPIGk3cGZgeVekR9b8SXnyHa9/GlWqj
	 93G5AIlGrC2KZfXpSJkyvtqlbXPOuToETDFoJrk5gg2N5gyrHEROPcdHpFsWzBZZEcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795540102;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=TWXolZYP1Z+2EZDxyUjBWCyGS5K2HLa5zZp9rspSSag=;
	b=TpmhFcmUffPHTuPYCpIEwj/qbI7a7m3FAJnxaZNEJ+sfOGbtjffrG4LhYpFOajPW9v2x
	 okVnHPdeWAG2z8hh3I435OTeYCVGv5/CN4CtdE6JY2MNkfgSyyNQmOFIBhJct72rljOVd
	 UGjnjRFkMfAeeS1QuQ4oE642QHWZ2PbkBePcuRXmsjq4mYVn2eU0oohug6ZD/P3PA2chl
	 popGmvWucBIk2dvWaO/pUBcdNFH6LQhyGKFpifj7oxlEWWpxA45063TtX5VqB1GwKg/ak
	 I4VK74YH5Uy5qX/3xd956o6knIV2mzkElt6FrJqGoj3oRyi1zUTMO9R0i5Klp7LPN0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VkKBzSvw;
	arc=none smtp.remote-ip=209.85.210.46
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81AD606A32A
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 17:08:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A81AD606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VkKBzSvw
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-845788309b4so2299992a34.1
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 09:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795540100; x=1796144900; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TWXolZYP1Z+2EZDxyUjBWCyGS5K2HLa5zZp9rspSSag=;
        b=VkKBzSvweeFrNKCq5GLSLZh18zOZjd5R1uGh94QycuiiCdnGqloBq8AE3sZWA0nbql
         /aA9eizbc61yYCDlI+xnmhJVqQvr6lzThG1y6dbPwrAyVF23yn/dPWD4VstY5bA0jko2
         02avCFmpUOVFO7cYpb6YU/auW/JUY53cCPaCZuURRALJyZmTNdmTcaHFg5F19c2G8b2h
         Jr8MLbvXrjwkUBCulzoqzBiMUV+QIEAf9m8fJs8KE4mdoXUhpm+4k5S/PbqXgg7sNWGK
         uFpQaaq+FsTCIS6ddqe8/RsyQRXbpTKaILBV1FXflxz3vjpHf/UdYWCWTxbtBif/W7uR
         +2SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795540100; x=1796144900;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TWXolZYP1Z+2EZDxyUjBWCyGS5K2HLa5zZp9rspSSag=;
        b=ODzIk/17dW5tPEs1fY1ARoRwvwjqMsucDMwBL40hH+KkrDI/YADK3c5hpy/oIy/PBx
         YwzjTgtxaNoVptZQiijM8BbxzMTGgPFYw8aDfMR/FsRxoxDBf1+J2/d/9nF18xzGhS83
         7FevRv7eti5RMPq2/N4o5rVmgLZJwMKGVLd6AhdR8aqRBYRb8eL9pjq0lPXvSOJhH1Es
         xr+PAxb4BgSrxSAIU/YbL4wMvSppvAfBkmyJRlJ8GA4j6YwEzE7KYzLCcddEDEEjWKKF
         0QljQ/n41vzlWY48KkAOkla2zBFYKv7bc9edyP3O/vAz0a//8zZF568J4oPvwyDxn+uu
         VzIA==
X-Gm-Message-State: APuU4Z+/r8/VDE8fSMYZtLGEBAydYGLpQHWNfCfXN5U7G6uaDJ66x4fN
	+TAA1WnzJa/oUZ2Qj5ZIIuN8lR4CTXV6Tivha3Ki8guPfSfDS8cx9vpx
X-Gm-Gg: AZFdTZc3X9FChGptEsWQZx8/J11wHdCmx/5oE5oZTo3jrUOXMJO32UA2cM6qJvtzuCY
	fwl+jf76P+YSuFQ9L2IFe9rer280oDQPw9riInRXm6yFX7YF1K88V0YCZ6EkoC4uNQt8LhKzOo8
	4QdVod7OSDBC1jXkTaeepnft2QQkQkID2YwbHQ2YptiYs7d1s9MKMARuvtQUMoh8qK6Kz/GNMzs
	wfImenPVALo0VrT9Sr+t3X+JBJjI9cYC079l1o99OoTjA2e2DL7Xxx4MvV7K5h/0f4YUZUlmne8
	XQbPsfHf236IphkCksk27azSMh9uGqwPsvwGaPtwWf5WukXUSNOS60L8ZcUtKsYB9WktSraIuNN
	YoUy5CRfb57xTXrcO13A5/DNtlteOx4QCcBcmBECCSKhgUu2BCMkQsfKb05ybC1PNnDVP3XXMtf
	7GQG4PO31sklyX9FgZMkeTRFadGzFkxBAWPbLIozrSJeXVQxbSkQU4N81fondziFHMUSVGfpnN7
	eyCFAYBYAfI+EOu3JsjTepxqkpnId4aH7SiGnIZmo+bA/AmawGCVNl4iuessOt+LkTh0mxSyHTU
	xyfvoKIhW6MWoGQcJOHe
X-Received: by 2002:a05:6830:2696:b0:862:c062:392c with SMTP id 46e09a7af769-86315963a1bmr17825248a34.14.1795540100303;
        Tue, 24 Nov 2026 09:08:20 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:42::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8631690f53dsm10307376a34.19.2026.11.24.09.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 09:08:20 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Subject: [PATCH bpf-next 0/2] selftests/bpf: Fix flaky
 verifier_arena_large/big_alloc3
Date: Tue, 24 Nov 2026 09:08:07 -0800
Message-Id: <20261124-arena_big_alloc3-v1-0-141c26210bff@meta.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHfEBWsC/x3MUQqFIBAF0K0M9zuhsejDrUSE5lgDYaERQbT3B
 +8s4LyoUlQqHL0ocmvVI8MRN4Rl83kVoxGOYFs7MNve+CLZz0HX2e/7sXQmxpRs7JhD36IhnEW
 SPv9yRDiTyfJcmL7vB7v+vWlsAAAA
X-Change-ID: 20261124-arena_big_alloc3-ddff2d311b40
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com, 
 ihor.solodrai@linux.dev
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795540098; l=1183;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=CTGVWVVbyctWyu+b1J+chTtrmZnm7r9SHriGNRu2m9g=;
 b=8wcX57lmVonYofuD1TOXVjP7FoErQMeAWBKCaHrUv6iTp/4v10w1sA8DRQiqEuD1Qj9HqAOmy
 UcK0FLnk8RKDusUvcS1izpaRZgbySQjCUJgmCv/PzSsauODxqewx2m9
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

big_alloc3 allocates 1025 arena pages in a nonsleepable program. That
allocation does not reclaim, so it can fail when memory is low. BPF CI
sees this as a FAIL on aarch64. When the allocation fails, the test
cannot do its check, so the correct result is SKIP, not OK or FAIL.

Patch 1 lets test_loader report SKIP at run time: __skip() with a
__retval() right after it, like __success __retval(0).
Patch 2 uses it in big_alloc3 and runs verifier_arena_large serially.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
Mykyta Yatsenko (2):
      selftests/bpf: Let __skip() report SKIP for a return value
      selftests/bpf: Fix flaky verifier_arena_large/big_alloc3

 tools/testing/selftests/bpf/prog_tests/verifier.c  |  3 +-
 tools/testing/selftests/bpf/progs/bpf_misc.h       |  6 ++++
 .../selftests/bpf/progs/verifier_arena_large.c     |  9 +++++-
 tools/testing/selftests/bpf/test_loader.c          | 35 ++++++++++++++++++++--
 4 files changed, 49 insertions(+), 4 deletions(-)
---
base-commit: 966e9d6e515bdd60f401b16eabc10eadca5f7885
change-id: 20261124-arena_big_alloc3-ddff2d311b40

Best regards,
--  
Mykyta Yatsenko <yatsenko@meta.com>

