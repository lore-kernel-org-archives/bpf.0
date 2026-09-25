Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1602945DF48
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 23:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790378439; cv=none; b=MH8DwzKQiGt0FYQ3WWhERNtlutmnFL4g38F63olX2DoexiyCcrkQVgo81JI0qFcnv0renPQY9ij8nQaXGStoSKg9j3LVqCPo7g3td3svQgFotNFRkhEMp5HsF18wZ11LTvH2LbC/cHyd6nYPKHhk3albnWkqT5AyZ65pt569PQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790378439; c=relaxed/simple;
	bh=WtL6rxCkfdZ7pTmQgPmxPdrmUbCTBflSvx5Si7/9zqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NijnCeI2sD9Kf58PxPGbe16aYVZpSmM1XtrK27lKIPlEyUxuXyWRbnHdTicE2dgBw+auQfFWqcD9qs+oZQwzq+8Tse4aRhiidartVpKF/xKV8NoIIToPlAmpHbCcVJXgUpFbKlSv+7/HL18X4GrxP4FzpVeJgf7Nmj+32nUL3cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anyfinetworks.com; spf=pass smtp.mailfrom=anyfinetworks.com; dkim=pass (2048-bit key) header.d=anyfinetworks.com header.i=@anyfinetworks.com header.b=hGWTSofy; arc=none smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anyfinetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anyfinetworks.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=anyfinetworks.com header.i=@anyfinetworks.com header.b="hGWTSofy"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f1e428so431260e87.1
        for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 16:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks.com; s=google; t=1790378434; x=1790983234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VR5L8+oQ4rLRFzubuBQiKFNbiQQRFe9UBoKloIMhE4A=;
        b=hGWTSofyMjrw+LaOQDnltigZODwrNbFkhOy46DfWgLaRe2d8QG9YRnplGTlj5HehGC
         wfe3yyE3x3tlCrGp2J/ZaEQnyQA1ZVI2xvJDSQUsZgl/i9vJnabxUknxUpHAL0FNgnJe
         /RFj5MU61cVuGDcG/AYfq0JLD6h4Y+4b4xMUz7HZXFTxQnD03k7x2q+VWV1TVRS0lhrZ
         YjZIzrpyZAwZ5VOR7FAiqKdaikY2Jg1xsM/G9ry2GB3MUH5gVZFLYXwxoFlzx6t+voZj
         fMwBISjtBZFFTjPxrgJK9IlxjW/UPzivZq/SiwHkspaf+LHTe2JDRVQnR7sSj0cM67LK
         XBBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790378434; x=1790983234;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VR5L8+oQ4rLRFzubuBQiKFNbiQQRFe9UBoKloIMhE4A=;
        b=Up1d2j4MM2iHaxPVwLTPUuz8IU5Kj9proIgFpuKmOocL45Nt8hyXQ8HZTgwXdd6B//
         oaTtmhbTnfYLXLawOB+k28coSSLlqpivGlbuI0obJ1hXRjTu4sKge21IKAKF5xt4ErF2
         Ad4hcsR2Qo6dI0MzYQlv16Jwb3smlzUe9a0mipojUb41+jNwSu3tTMFdaPzyrxrHuCo8
         b8C8MMY5uetu9Q+KyY7aX2EvISS/dqlRadXIzls3la7akfU/99RcP4zYKXwtS4gVkLCF
         SeVI3mAGQb9nHTotIjX1BR0pukwtEV5umbmZu75d0Io3qN3Sk6eZsSHw2fsE7paTccci
         sgrw==
X-Forwarded-Encrypted: i=1; AKwUvBwnleXkvMclTWadaEWYTlKSqXBEOAFOyBGnr8Q28pNwrOSqg2rZGw5EuQ+4E8s11/xFXVs=@vger.kernel.org
X-Gm-Message-State: AFuF++mXJvwjrjeUKTrkGNmOlVAH9nTT2QGrDpMHt0xEfXtmFcJ+chdp
	kr1AMnesTPdx3RFWrEZB5M3weA1w/CS3NtnPdA9j2EQeFH8+aVnLhXI1X1KCdXboo6Y=
X-Gm-Gg: AYBFou1CWkOGpw91nsmBnFcZcjfNHNgUto5zxLSxF+RUuxDd3v8e0rAYxbiHWEmnF7X
	OF8xqM0dHQF3zUcStHJqO9nGsEVUtoBPaGR0lPjWHpf8cPtX0SdetuifjZIL6EhVOBpFlXO+e8q
	MGVBThsZgJerw+dVYJItWbwkQDmvREfILsiRZnwuJSA3SRskERLOVOzT8a+y/Yqnj95TbuTbR+r
	m2W07XnjqgO72KUEuEbeF6rPjlFJ2VVaNICmB50Bv2B3MmSG4Fx5BJBgMz3qd+Yif0B3Ev+nR1q
	kTTZrEM4G2Y/0vVqCi8CnNsSi4xieBDhyxqY2dJd87qs6k3Gq1judetg+SUxiw+2WWdA8quOdnZ
	OZWzBhPCL62rLweTg4qBbHAbM0JwlO5qqyIrQwWMPnd0rF9d/fUIz8F7TndT198dK45rGNSuSnE
	DeI0+6iMFJN239GZFFd2BgaRuEbnrerrMIhqAT2s0iUMTFQD9lMYbyt6Ty/H3+LLY0JHES7e0a9
	Z9/zp4ovlcOQ9qktDIRgEkWVjaVL2sqKA6Rcu5xLPo=
X-Received: by 2002:a05:6512:208:b0:5b8:b392:b40f with SMTP id 2adb3069b0e04-5b8df09bdfcmr1779080e87.5.1790378433940;
        Fri, 25 Sep 2026 16:20:33 -0700 (PDT)
Received: from nuc.. (78-69-188-101-no600.tbcn.telia.com. [78.69.188.101])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8e6af81cfsm875260e87.40.2026.09.25.16.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 16:20:33 -0700 (PDT)
From: Johan Almbladh <johan.almbladh@anyfinetworks.com>
To: tsbogend@alpha.franken.de,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	paulburton@kernel.org,
	main.kalliope@gmail.com
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	philmd@oss.qualcomm.com,
	Johan Almbladh <johan.almbladh@anyfinetworks.com>
Subject: [PATCH bpf-next 0/2] bpf, mips: Add JIT support for v4 instructions
Date: Sat, 26 Sep 2026 01:19:30 +0200
Message-ID: <20260925231932.1063678-1-johan.almbladh@anyfinetworks.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MIPS eBPF JIT currently lacks support for several BPF instructions
introduced by later revisions of the BPF ISA. This series adds JIT
support for unconditional BSWAP and JMP32_JA. Together with the recent
work of Nicholas Dudar, this completes support for the BPF v4 ISA in
the JIT.

The series was applied with Nicholas Dudar's patch for MEMSX added on
top ("bpf, mips: Add BPF_MEMSX support to the JITs"). The JIT was then
tested on QEMU MIPS targets, with the following results.

MIPS32r1/r2/r6 big and little endian:
test_bpf: Summary: 1062 PASSED, 0 FAILED, [1050/1050 JIT'ed]

MIPS64r1/r2/r6 big and little endian:
test_bpf: Summary: 1061 PASSED, 0 FAILED, [1049/1049 JIT'ed]

All JIT-eligible tests were JITed and all tests pass on all 12 QEMU
MIPS targets. No physical MIPS hardware was used in the tests.

Johan Almbladh (2):
  bpf, mips: Add JIT support for unconditional BSWAP
  bpf, mips: Add JIT support for JMP32_JA

 arch/mips/net/bpf_jit_comp.c   |  2 +-
 arch/mips/net/bpf_jit_comp.h   |  2 +-
 arch/mips/net/bpf_jit_comp32.c | 11 +++++++++++
 arch/mips/net/bpf_jit_comp64.c | 11 +++++++++++
 4 files changed, 24 insertions(+), 2 deletions(-)


base-commit: 6ac134ec930642d5b574b63a72a0e999c2470c64
-- 
2.43.0

