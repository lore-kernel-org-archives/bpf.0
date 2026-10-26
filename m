Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792983850;
	b=cQx4IbxtaV6DPwVXvqPOlvxKQY1MCFBPJ93oyOIcRF0YRxb2mZyBoMoN7mvkRaJp4FMr
	 Xv83WAqzRZlizHMgn2rbK+M5atWXeK+iBspxBv1HbwaOOcQ7foCsDRGodXzZ+G4f8XTl4
	 RSzIE9Br+VEPMKqKRkOaapc+ixm9lX4bp3AzjOhFy8JwQdJlXkOkHX/6qE/6tcULDn5BY
	 Ty4mrQLF2xGegJ1zaM1QVCdnRX5gnOTlb1pY4tOZ2PpziyViCeOoCgU8LX1i7Bz8wGuhQ
	 tS3ti9YlkkNQ+Cyq2s2LEA9/YNnuCcrM93la4+PsunAk3stBW+PZYQA7uAYDSQWFAuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792983850;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ZhLvzyJwEag3EbXKFyWqdwmA95Hw+72FHV6gCiJj3ck=;
	b=Ia1KpDqi5fKeLy2eGpCgUyKfYsIoZsRWtKGRUmNAdW31DCMrclVMi5W+9UPmqIlZwgUg
	 igOPtbxmiyQDhQyu0YUNABXJp4D9Ighf4qwNCgSIrVtynONkzvbCt/F+mbLFFNAZcPIiL
	 8jXTOOin74WCh1ksw5CiBZs6/N7Nku6ZwH8jSDtROiGz7eaCagQMoNSDMQWtaVFxQvd4c
	 MKb+ccMUhgESmlsdEXH5Z3tGBwLaVsB77l1/BBauZdG4ey4BeDpKdZlM2wSpjt7yxRtnE
	 VbInnOdnJpZuqADoY9t181IoubbHcmbioR0XSiVh6QB9tvUJUhzVHgeO5oFdzAAOJ3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SW3iV+dc;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF6A606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:04:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FF6A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SW3iV+dc
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3adac5c10e3so1299078a91.0
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 20:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792983850; x=1793588650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZhLvzyJwEag3EbXKFyWqdwmA95Hw+72FHV6gCiJj3ck=;
        b=SW3iV+dc7a8roeUAYXxDXEDmuW/UAhPG/+YOaeibcmSawlpXz6vSdbB5CuCeqUWbZZ
         FsusmA3W6J5sOy+yw0bogKks+D9X53T5GC9X38jietZtg2653jGW3YGEsYsUJpeLkpC4
         D3f1SpppfhXaa4IyxOxaXRvLMfHs6GPb/uQywVkMs6Wg02GidG05UUaVhQKt+9c21j9k
         GwsPdGSr8EQbo83zvevKNNslrHCaA7qWphUmv7NAF+IXtDobax6ZtmychAoPAXrBUQEd
         JsvnbBNoU2QGhidHgkiE+bzK2GHSjdcujsPyQLfjE59mdezOZDE+ujJPZiou0BAND5nU
         MDgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792983850; x=1793588650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZhLvzyJwEag3EbXKFyWqdwmA95Hw+72FHV6gCiJj3ck=;
        b=2IMW+FHMA3DrJ2I8d4ol6n18ghnB5BuBMEi+k39vjg0cRKWPrK9lG6oUKjZIFpnuig
         h7odk5uLFOINt9YJES3p1c+vIOh5ermfJtrwqEqA6AgKYozDKb620kUcDsB4af0SKdYR
         STwpB8XbbZFHZMqSuVbUXlwt75vogYox6YB3KC/LawZSnm9Vzt9sv/E2coIJJoIFES8o
         wNz3xFwq5W8p6cg8hxqTGcg7Ft853drHJPs+iPW69PWj66dDLRP3ShN89k3GlJL8X1Tf
         p74ivHxQMzWhrZ60H6RCUFiebloen7ttAjT074B59wgjjzTkkPjWKoHz1J6UdzAbmCIB
         ZRMA==
X-Gm-Message-State: AFq9FYI2Zi9KLyaPM5ePh2KqZkSThX4vOrASK1DoPnfbvTs2T4rRhyFa
	aqAIiHTFjHC84PaKqK5AB5pSmjmH1z6C/21SJecLQcSu2nXEJVtgLKA4ag8itg==
X-Gm-Gg: AYBFou3vcZtdJX3ibCwOhCGQQsRcMGhlBCsEWYk3M+jO0lsDWkx0UyC32vFrNgCuBN6
	6u0P0OHsiz3ZsOcau9XtivrOgE0Qlo8QvQTGFmr9x44Tv0smj2pDIb8mmg+eMj3aO/SGMabJlxm
	lUPEMyY9SlLTXC7I8t9LuvZcr/MEMa2PtxN+y/OND1fQ8OR8TmcUWgOT9RMcYTZFIB76POtfdLN
	qzYchy2Iws4n1qgMdKPoBhVwNwwLWpoA5jxV0Sqe5GTN0V9ZBIdGmWlSR0fF13tYasLB84i7iOW
	X7c+ExuRewxJQj7nDXOXUZn3jQpjFTrO6zUS0avHXG6HNHOEqVd5IncWf6zxYHzojtPXxjUQDyg
	Va8cKmEU54X/R8RHEcPQ8/wkotG1zVRpyZNPndK15uMobk7uXdfTqzRqFRhBQB3U82E0qJnIk6i
	nTLgcU9GFyzDFU0t0wPtX/uCIzXYWpR99hiCu2LMPiYDOHoat37epZtYJBb9vz5cHCPmebUJP/c
	NGFUeV4UNbgWwtMKeX0Yg5HFU2Y2MnW1HvozIkhmZWWbKpyblSNk5LqRqOVImkYTXe2U13WSkCr
	AnM+buY5IQS1GZ+6S8BLqrHrf4+O/SBcSQcrgvRN1lVFYJAA0ANsu/hgSRpoNZe8Ex9AeHdTphd
	NlvbUIRDHbmqhXq3nCpkR5Jeh
X-Received: by 2002:a17:90b:57e5:b0:39e:4c80:f67b with SMTP id 98e67ed59e1d1-3adeaae625fmr4738184a91.26.1792983849628;
        Sun, 25 Oct 2026 20:04:09 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adf8f3f22csm4045455a91.3.2026.10.25.20.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:04:09 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 45/81] selftests/bpf: Expect the masked count of 32-bit shifts
Date: Mon, 26 Oct 2026 02:59:06 +0000
Message-ID: <20261026025943.404450-46-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

alu_ops_exprs examines the expressions that scalar evolution makes for
'w1 <<= w7', 'w1 >>= w7' and 'w1 s>>= w7'. These expressions now contain
the mask.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/progs/verifier_scev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_scev.c b/tools/testing/selftests/bpf/progs/verifier_scev.c
index 5a7c32ce1c6c..a68a2368aa71 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scev.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scev.c
@@ -362,15 +362,15 @@ __msg("w1 ^= w7 {{.*}}; r1 r6 -> (zext32 (^ r6 r7))")
 __msg("r1 <<= 2 {{.*}}; r1 r6 -> (<< r6 2)")
 __msg("r1 <<= r7 {{.*}}; r1 r6 -> (<< r6 r7)")
 __msg("w1 <<= 2 {{.*}}; r1 r6 -> (zext32 (<< r6 2))")
-__msg("w1 <<= w7 {{.*}}; r1 r6 -> (zext32 (<< r6 r7))")
+__msg("w1 <<= w7 {{.*}}; r1 r6 -> (zext32 (<< r6 (& r7 31)))")
 __msg("r1 >>= 2 {{.*}}; r1 r6 -> (>> r6 2)")
 __msg("r1 >>= r7 {{.*}}; r1 r6 -> (>> r6 r7)")
 __msg("w1 >>= 2 {{.*}}; r1 r6 -> (zext32 (>> r6 2))")
-__msg("w1 >>= w7 {{.*}}; r1 r6 -> (zext32 (>> r6 r7))")
+__msg("w1 >>= w7 {{.*}}; r1 r6 -> (zext32 (>> r6 (& r7 31)))")
 __msg("r1 s>>= 2 {{.*}}; r1 r6 -> (s>> r6 2)")
 __msg("r1 s>>= r7 {{.*}}; r1 r6 -> (s>> r6 r7)")
 __msg("w1 s>>= 2 {{.*}}; r1 r6 -> (zext32 (s>> r6 2))")
-__msg("w1 s>>= w7 {{.*}}; r1 r6 -> (zext32 (s>> r6 r7))")
+__msg("w1 s>>= w7 {{.*}}; r1 r6 -> (zext32 (s>> r6 (& r7 31)))")
 __msg("r1 = -r1 {{.*}}; r1 r6 -> (- r6)")
 __msg("w1 = -w1 {{.*}}; r1 r6 -> (zext32 (- r6))")
 __msg("r1 = 42 {{.*}}; r1 r6 -> 42")
-- 
2.55.0

