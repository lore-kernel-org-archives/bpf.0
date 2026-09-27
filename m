Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EC83CF952
	for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 23:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790550523; cv=none; b=dCyIQ9Uxh7JMXZ0yOLxQDgCyTy0D0HU0X9Z1RgfPAJcDsNER+VTBYWiI5HqaD+hS3NDlsbU5a00CQF8fpNLXCHeCCTiM43xAyVAnoUH9wj4NxiN3jTWSolhUvswKc16HbxiMLf11r9fBHay0InWGetZDFMW6ExDO0oexBPWWNGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790550523; c=relaxed/simple;
	bh=xkSLCh845EsJhrdCyhg70nL7NkB5a8zwpqs11NLsxss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Pb1emGMDWZODyMN6i1lY5TcfDdRxemydddEMxPwS/7IcAmxYlrMRHwex8hQ8iOlvuw7M9Lbn3JSaC9llPDN+cT+kfUC7nkqieR1QSwy4hiIaXrBWwd5WFnQJAGmBy00KDzy07slw6vUJF1xfmuBVgDMZ3QPCruXYK/pqx/abVbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4UphsD2; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4UphsD2"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e8185e037so12811475e9.3
        for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 16:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790550520; x=1791155320; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HKp73jGG5LTsQWZvXwxxCZVQVZBAoFZGjXIJpSRfgkI=;
        b=D4UphsD2ivi88C+drIBgNdYkbpymwEOoohShRjWjN0yQdRRXqh/O+Nb1iT3d5d7IE5
         nSUj8LmBoPjMmMKIygFa1jfVxBL7csun+pbSVIgdch++/6W+8E6wLC78jF/SLxJDB10x
         sd+nfgA8xfQaa7bssu6+eThl1N2UEIVS9BNZLz5HeXJOnEs8huvRW7lSBxsw+O1SzuOn
         U/in9C7BdkuWs0xIcRBH93M/9oj7XvX6nG6luctLdMTbf2/tNZSiVObF803kVx3HMnsa
         WfxFZJ0iKAsxLmHMSL5OmLwzaroe01pgq+H/Bw3zCbApuEFHYHHRBQE4DiLkAsFEJBn3
         JK8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790550520; x=1791155320;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HKp73jGG5LTsQWZvXwxxCZVQVZBAoFZGjXIJpSRfgkI=;
        b=yDNVEUqGBfTYMTEvtBHqggkvF69Gk7isVjme/lWEisCSmTXPAkkD+MljZvaQhqgbmZ
         51aK/P5O3skLASHjTMqhxMpKjDZtqo3ycCsKjMU/xdPmFqna+QXGnb3qiU5gsE/1QGWo
         sYX3y0v7PP0kJOySqEdcyVW5zJD2H1Wd4Wb/CBEyiSGTlbRUre99HqDFqBVnAdpFptYf
         6rkhgDjYYxOpiLq6f6Xd7q3A0komG2WkCtq0CxmXyre4wwR/13z1ADWHvUtwkc37TMMA
         r/xf4FojjxH8C4GotSFGLrIK1cotvKtSJxH/UNDbqHavY8cy83wHydYOJxB5sMC1cp5y
         cBIw==
X-Forwarded-Encrypted: i=1; AKwUvByrK7I3Y2hC2KErAJ7UqEsXubQrk0aPuWzRo3v2hKcujOhiiTVa6Zos/L21Ow5hn1QWMyg=@vger.kernel.org
X-Gm-Message-State: AFuF++n0wkjXnnEpiAZykf1vWEl3a9J6PPCkcx5Af5v/8kUcOA0ef+as
	JLm3BOHuRP+UTPnojT1bzoLl8gcfCSHMMZ/4hcYsTubDECnA5UhoHObf
X-Gm-Gg: AYBFou0fJV2rwAYeSpE9weTRBKL5E8vYnB4tTP4H2mQIWj9Rd5+sDQ6c+lYGbcj+8fq
	owvsghpGBDarNxX0mKI9BzxQMBULOlJlVD5xUN/OJ4o/3XEAc5I/i304e8+bQKGLv4GxdhodMjd
	gBbXSHF4FB+DE1LKeFauDwq1GhX6xZliAl3omO2Q2EVmTmu+aR42+cbioBPYhoQfJCUOiDe8rIn
	cohPn4y0WB7j07T3E0istm8gB28H6QmH30J/2SAFTwvDfYpv6wNoPaB2OPCqCgnAB6D43PxYPPs
	46+o0Y1wKXVT5N99cGVAAw+dgZqdBZ/eF81t2ScfbYBglLONax7MWKDNfHG1NlS+m/wTaF2jhnX
	PwHQWqZ04XwiVGWmagof7jeEevMMkvKghCPTZGKwxnEHTXI7SPweRZ3PoSnULyxxipYMTC2gQIT
	xL4cJrhAqWKshEBiTgmBPYCeWzOP+df0euoeMp9FJCNTOr4N8GQUlzGVOSVygmjU7WtafV0xe2d
	Ju1na0=
X-Received: by 2002:a05:600c:8718:b0:49c:fc6c:be08 with SMTP id 5b1f17b1804b1-49ff06f8316mr132620435e9.31.1790550520067;
        Sun, 27 Sep 2026 16:08:40 -0700 (PDT)
Received: from metepc ([46.197.185.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0018f0e79sm145623205e9.7.2026.09.27.16.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 16:08:39 -0700 (PDT)
From: =?UTF-8?q?=C3=96mer=20Mete=20Kaya?= <omermetekaya0@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net
Cc: john.fastabend@gmail.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?=C3=96mer=20Mete=20Kaya?= <omermetekaya0@gmail.com>
Subject: [PATCH bpf-next] bpf: Fix bpf_loop() depth check to use 32-bit max for nr_loops
Date: Mon, 28 Sep 2026 02:07:26 +0300
Message-ID: <20260927230822.417683-1-omermetekaya0@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

bpf_loop() takes a u32 nr_loops argument. At runtime, nr_loops is
passed as a u32 via the BPF_CALL_4 signature:

    BPF_CALL_4(bpf_loop, u32, nr_loops, ...)

However, the verifier compares callback_depth (u32) against
reg_umax(), which returns the 64-bit upper bound of R1. If the upper
32 bits of R1 are set, reg_umax() can be U64_MAX, causing the depth
check to remain ineffective and triggering excessive
push_callback_call() invocations until the complexity limit is hit.

Use reg_u32_max() instead, matching the 32-bit range actually used by
bpf_loop() and avoiding unnecessary state exploration when R1 has a
large 64-bit range.

Signed-off-by: Ömer Mete Kaya <omermetekaya0@gmail.com>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0eeb498db9d3..8d8923ad5094 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12184,7 +12184,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		err = mark_chain_precision(env, BPF_REG_1);
 		if (err)
 			return err;
-		if (cur_func(env)->callback_depth < reg_umax(&regs[BPF_REG_1])) {
+		if (cur_func(env)->callback_depth < reg_u32_max(&regs[BPF_REG_1])) {
 			err = push_callback_call(env, insn, insn_idx, meta.subprogno,
 						 set_loop_callback_state);
 		} else {
--
2.55.0

