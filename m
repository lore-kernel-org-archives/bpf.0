Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8356348C62
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 08:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780042416; cv=none; b=GcPLaPD8C7AA46ptmJXF7Y2nkWU5UPJcokk3dusN45/OdFyp+CnQDcTpbNxmTXnAResj+6CyTpc9wxdG9aSHC5/ERsD+sZ0sa40lQsOfmOrRTTu2lUOiB5DkyUAkRp31QY8GN3u1i0qe2c6D6LFvzE5K0dKN0MKSknA4sSam72c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780042416; c=relaxed/simple;
	bh=kMF94CUgUYHVk9impyTBCXE/rFXGtliI6hQ1g7bEBZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PDpzo0nEBPVIAOcmp7wP1UKsSw9DrbYAEYAdTK5GoX4LAvdInxqHyWbsVUcFKBhXbUHd5IeGRKP4JDwrQCWPIK6iXZyjaLWK0wCqvaXxobi4vFSPsXGdGx6zPNZ1o7X8b+OQEuDEPUOjMLjW1yHtSOQWg9uI1N895K59run0hVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OryXTdP/; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OryXTdP/"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2bcd730e090so108731355ad.2
        for <bpf@vger.kernel.org>; Fri, 29 May 2026 01:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780042415; x=1780647215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CmP8JKl+zVd5853ibk/0JajPLoRoKKYEp6uEqLbvTWM=;
        b=OryXTdP/Y23rLhmA7C/aHX8GwHfXBgzcQ8lhCHsa60qQ6V+PFMNBduv36jI0TrZ89R
         rdLz5PMX0KSkFJq0nl7DgKlhuXLG5J93nWwy7lkKO2ifiZM6/b5DFuEjvzBf9DKDO/2G
         N9zpzWz4taVbachZLL+QLmJ5+2OgSt56y8AewmEWx9bibJWifoj/y2fxOkTNPMtUg8FI
         SckFnCa6/Ce3z9xIlsMeTeI42VtHFkXmjoH30mpZDKhDKlF2sFSB/VskdYPrsf0cevsF
         xHbxYaUaFdofjHdO2hlXE5pIBM/ajFkp+4YvU5unfTeVLFSK9WVGlVYJLbuhgR76vmVd
         G1yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780042415; x=1780647215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CmP8JKl+zVd5853ibk/0JajPLoRoKKYEp6uEqLbvTWM=;
        b=mMQCl/u0tGJwzSavZUqyBOx2JatWZUAFXJYYjNxMoizlGpOx4arzMaoyywLQlPSIru
         ZkkBNO0jZw2aNsJcd0iBzqi81kc1K6FPJV2/gbiR7CVUB3rqoCQr5he7z1RurbkgjhML
         16BrZwL2mbVrTUAfFCd28iF8Xy6acron7OpBhzokiuF+zBchp1YJ0Crl+REA1Bt2Ac8y
         GZUMPmnAecqQh+fd3a1yu/MLbXQSreRQaKXN9f2e+GI3QYW6Xo4O2sGZu4SazA7PvxMv
         UOFlm/wtFJYUk3zWVwhI5r3bGIPWpSQZa5EWlXsXtTEEWlVOk7v0EI7ip/7DqHNfDECY
         0ZfA==
X-Gm-Message-State: AOJu0YwwkW1VO5/EIeN2ceRtKhWJc1zKyCo24ooy0ZJ1/mNWr30i8UAP
	Yq6HIlNe0+7xybiO/EcLYB33+k6olOweZr1Rv3AKgjdCBn6DpZnIPHrM2IpL1UQv
X-Gm-Gg: Acq92OFRvxqUDvL6h9euaI9NijJiDg57fpcvMNfJ1SIaZZNqC2SuJxNJsD3g8ALxoD2
	R7EFqxbebz1yTWJmgb3vygsGWA9UEGR1o8sG6M1y/Zyjemyo6uHhkwz1O8Y6NHdZ0sr0xf9L9Ld
	LjDnVfIk0ziemP3c/jl9QB/fpCpKDqCPdaxsd417lomam1jjNaTPPCxxoJg0OohKNE3XiAlikOP
	hIZUb/rmoy3gb845feVZMnzJgUbCJyHMGnTXH66iL2Y3JQq2IilAuufmlmKAKnEeTpvIEFbDBmj
	jW9KOO/eleyoFNwu8Hh+Vj288yR6QEhMqsw7MGFngsufVads/yBmghoTx2Q3hmNBtXiExTAliDY
	3qqHC0CiYfzBHdrs2SG7YTl4GFnkD0L36EvoTFw/hqY6L4ml9mENtZ2bYas0YRp8NedijgUu4St
	yK66iYDvtrdjAkZ1GdmlhsPwaqRkbQc9dfFltbEZBDMPPjfq23saQ=
X-Received: by 2002:a17:902:fc43:b0:2bd:8db9:cc0c with SMTP id d9443c01a7336-2bf2050c287mr25687915ad.6.1780042414939;
        Fri, 29 May 2026 01:13:34 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf239e6f57sm10806715ad.13.2026.05.29.01.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 01:13:34 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	zhuyifei@google.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf 2/2] selftests/bpf: test fork on zero comparison with wrapping ranges
Date: Fri, 29 May 2026 01:13:20 -0700
Message-ID: <20260529-cnum-split-at-zero-v1-2-986c03752226@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529-cnum-split-at-zero-v1-0-986c03752226@gmail.com>
References: <20260529-cnum-split-at-zero-v1-0-986c03752226@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Add tests verifying that the verifier correctly narrows a
sign-boundary-crossing range after comparing with zero.
- fork_on_zero_cmp_k - BPF_K conditional instruction;
- fork_on_zero_cmp_x -
  BPF_X conditional instruction with src being zero.
- fork_on_zero_cmp_x_swapped -
  BPF_X conditional instruction with dst being zero.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../testing/selftests/bpf/progs/verifier_bounds.c  | 68 ++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index bc038ac2df98..f97b0e109326 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -2294,4 +2294,72 @@ __naked void range_within_cnum_cross_both_boundaries(void)
 	: __clobber_all);
 }
 
+SEC("socket")
+__success
+__naked void fork_on_zero_cmp_k(void)
+{
+	asm volatile ("							\
+	call %[bpf_get_prandom_u32];					\
+	r0 &= 0xff;			/* r0 ∈ [0, 255] */		\
+	r1 = 8;								\
+	r1 -= r0;			/* r1 ∈ [-247, 8] */		\
+	if r1 == 0 goto 1f;						\
+	if r1 > 8 goto 1f;		/* r1 ∈ [1, 8] */		\
+	if r1 < 1 goto 2f;		/* must be dead */		\
+	if r1 > 8 goto 2f;		/* must be dead */		\
+	goto 1f;							\
+2:	r0 /= 0;			/* unreachable */		\
+1:	r0 = 0;								\
+	exit;								\
+	"
+	:: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__success
+__naked void fork_on_zero_cmp_x(void)
+{
+	asm volatile ("							\
+	call %[bpf_get_prandom_u32];					\
+	r0 &= 0xff;			/* r0 ∈ [0, 255] */		\
+	r1 = 8;								\
+	r1 -= r0;			/* r1 ∈ [-247, 8] */		\
+	r2 = 0;								\
+	if r1 == r2 goto 1f;						\
+	if r1 > 8 goto 1f;		/* r1 ∈ [1, 8] */		\
+	if r1 < 1 goto 2f;		/* must be dead */		\
+	if r1 > 8 goto 2f;		/* must be dead */		\
+	goto 1f;							\
+2:	r0 /= 0;			/* unreachable */		\
+1:	r0 = 0;								\
+	exit;								\
+	"
+	:: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__success
+__naked void fork_on_zero_cmp_x_swapped(void)
+{
+	asm volatile ("							\
+	call %[bpf_get_prandom_u32];					\
+	r0 &= 0xff;			/* r0 ∈ [0, 255] */		\
+	r1 = 8;								\
+	r1 -= r0;			/* r1 ∈ [-247, 8] */		\
+	r2 = 0;								\
+	if r2 == r1 goto 1f;						\
+	if r1 > 8 goto 1f;		/* r1 ∈ [1, 8] */		\
+	if r1 < 1 goto 2f;		/* must be dead */		\
+	if r1 > 8 goto 2f;		/* must be dead */		\
+	goto 1f;							\
+2:	r0 /= 0;			/* unreachable */		\
+1:	r0 = 0;								\
+	exit;								\
+	"
+	:: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";

-- 
2.53.0
