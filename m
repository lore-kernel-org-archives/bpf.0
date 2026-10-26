Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793057930;
	b=GVubTxrhgaHiBRQmUOUbI8NiNQyEgdkOHAHHj2Y/mXK+H+JSccoMRuGxKeEWHwcV2W64
	 VdnSJAP1NUOuXgDKyCCHQBV0KqPQgfKo8OwbAoHqASTibmweo/E77n5hD5W/p8K/th3GU
	 B3jEqXy2qIZZY3n2qG/kEY8RGmCBxt56puksSy9AknswBmIkj4O0iQbhTSku4LwY/d7t2
	 r4hNummyxZ/EmgOCYXIblrU+KHLqtKyibnVMa3laKcDGDD5hJML0OW/IDVD1JWafyKSM3
	 OtbSEHdX257eFWR7PfAuJ1OVpmTemxz/ttBGbr5RsVyY2IncKJYk1Ys/FwJ8Scd3fTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793057930;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=+M7WVyPzj/D91X84nY7O+mN2c5hCSjLBz4vWduDAgpw=;
	b=t3+T+FU6+9eRU1vS47DP12GWPJcT95/qRxPSFPuUIlt8F6ZdMJyXCXMyNza5cjWa8YLz
	 uA9xrceQoBPsIz+ySm4qFJXVBtXy1/MXkRkAtOx1mTaGw7ajf2dv4MO1ims+mHJC+OWTu
	 kUIKB7/8eoWLuQdCFm6gpIJtPkFbddkrno/65aSHwRf5IpzIpPaRVSUs5IgQmC3kQJjVW
	 3A7fD0KrN0Q5y0xlPht2Ei5C7Y8uAqN1V6tNq1G+ds1S41CUttOgueufL0xK6Q21q8Yd8
	 wbqprojy0wEqo/HwTOtrEKANXwOei3MhfxBysiIbyh63NXpugOcxa5KPKG7B8rxN72w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="Z3/WIRn9";
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B13606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 23:38:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0B13606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Z3/WIRn9
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cd6acc50b8dso1263660a12.3
        for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 16:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793057929; x=1793662729; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+M7WVyPzj/D91X84nY7O+mN2c5hCSjLBz4vWduDAgpw=;
        b=Z3/WIRn9ALivyeD8e+r7AivjxFCSD5C0yNQ/4frir36HwGm143PjmMALvMiLUOnHUK
         oA5qIMJGtu3ahwEM1hwV74iv53+QagOGFC0nk+fJBG5EjsWpDF+QceeHtsQcKPmWUBMf
         Yw+rgX1dQ8zJC1OlaE/cyeoQPm67pJeJ680ZS9bhZmRSZXr1M3VLSAzLSzlM6qVl7/gU
         Vv/Y3+76f2mPkNfNK5Y616gn8cVmEDwLdt/I1sodHXWXzSZAfhKyOk30aDMJA6+fMDGX
         xlqAAkL+qktvLTYjqtwWC9lBlE5PE6yXN+AG5RskIybvYkA+vM9grOvZZrEc0I0ntXKg
         aR0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793057929; x=1793662729;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+M7WVyPzj/D91X84nY7O+mN2c5hCSjLBz4vWduDAgpw=;
        b=oFk+X4L9Xlz2we/z9tMIdupd1QiMjthckYw/63khxInvmXmp6RnqWJwkspWok9qQG5
         HqhnVfDGcj65A/JIBKCWP27pj/Xd3KJj+St9by/c2q3i5/iEI59+RczQi+Ai2ZK0Ooup
         Nmaj3IAXLytAQ1fooUEJEl0UpadFjrJXn+MBST4RDHqBGn4AFMBRdQmSc45DoiQa5Quu
         dVGzCXOQU2aJqUSO0H0MuusJ5OaCguu1mBULZifU6eCz9w/GH1GaP3qYSg1McIHWd4FG
         SpvCAZgt9aFVVB1MqSCljlsoi9QOY9WZKsqlA/o+fWjI4znfkEePzVLdfypGNdoS+Z/J
         NlLQ==
X-Gm-Message-State: AFq9FYKfqEsmIpBPgPwqn2IZw3g2qd53VoA89DWBX6En5xgQH8TIFR53
	c7BXCUD/djYSVCReRdGHzik68EbrrRcEbefu86bjpEUjO6cWICrrBhziC7cw/g==
X-Gm-Gg: AYBFou3rABdsQG3DxsrQN6YnAZrJfQmnXo4WnvdZpcpwus33vAiig6aSCpjhaOEL1r5
	pGxVQ7EA1Hf4+dpNS2/MTLjT1wCbXBpjSVv4J1imKeaFXsMSAplNPFV+gI7nBoUxbBlRUNylmnq
	IUuS/jE1aRA9bodWTbcUMX7STgIa5AMBopjLeRu1ye8xcbkHfAAMaWGvll/TkosRSUBEkl16GQz
	3jQhXJDnf7G3Mxfk6o8Sth3V0d3Fn+LMic79e/uE9VVaCr4HXhvplkDFYYZ3Ri//9ymrsnbcHuX
	kBl5RolH69NyLY0IrRhWZz7riZF7GBwHf8wX52WERTCajseBtQVkmgl3LHGuH9TPHEFig8Wh2CZ
	AMCm9z6jKYpCgkGNIGFN1cuvda04qsdMWOyff8Tc0TJdUQMT9F3aPKRp++NkJANuEQFEaPLW5YO
	aZIVz3Z+eoumtGxm/QZf1nTAfVv9uRFBoLCcpi+4yU8uxZ4vrJozw4ejUOOMNWak7ToUpeAPAF1
	HfYCHV1QkTYj7hsgFT6awZw6UUOjccuRMsJxLub6OKl+05ZQ6ScutJodPFpcwJ7e5fJoaLs0u2T
	8F9qkaCiuDwxJlWOLmvlFF8=
X-Received: by 2002:a17:90b:2645:b0:3ac:c03a:38ad with SMTP id 98e67ed59e1d1-3adea093f10mr7491216a91.5.1793057929107;
        Mon, 26 Oct 2026 16:38:49 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae40455eb5sm1167437a91.12.2026.10.26.16.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 16:38:48 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf v2 10/11] selftests/bpf: 32-bit copy of the counter compared at the latch
Date: Mon, 26 Oct 2026 16:38:30 -0700
Message-ID: <20261026-scev-simpler-clamp-v2-10-f373aec9825f@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261026-scev-simpler-clamp-v2-0-f373aec9825f@gmail.com>
References: <20261026-scev-simpler-clamp-v2-0-f373aec9825f@gmail.com>
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
Content-Transfer-Encoding: 8bit

When building SCEV expressions for the loop:

  w7 = w1;    r7 = (zext32 r1)
  w1 = w7;    r1 = (zext32 (zext32 r1))
  w1 += 2;    r1 = (zext32 (+ (zext32 (zext32 r1)) 2))

Computed SCEV expression for r1:

  (zext32 (linear r1 2))

Substituting this into r7's expression at the latch:

  (zext32 (zext32 (linear r1 2)))

Without (zext32 (zext32 X)) -> (zext32 X) simplification rule
the latch would not be recognized as linear and header_count
won't be computed.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/progs/verifier_scev.c | 27 +++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_scev.c b/tools/testing/selftests/bpf/progs/verifier_scev.c
index 39603c8bf083..37434efd1490 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scev.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scev.c
@@ -3710,4 +3710,31 @@ __naked void dominating_exit_bounds_count(void)
 "	::: __clobber_all);
 }
 
+/*
+ * The counter is copied to a callee-saved register for the call and the copy is compared.
+ */
+SEC("xdp")
+__success
+__log_level(2)
+__flag(BPF_F_TEST_STATE_FREQ)
+__msg(" scev at latch 5:")
+__msg("  r7=(zext32 r1) / (zext32 (linear r1 2))")
+__msg("loop header at 1, header_count is 100 ")
+__msg("loop header at 1, widening r1 to 0..198 step 2")
+__naked void post_cond_jlt32_copy(void)
+{
+	asm volatile ("					\
+	w1 = 0;						\
+1:	w7 = w1;					\
+	call %[bpf_get_prandom_u32];			\
+	w1 = w7;					\
+	w1 += 2;					\
+	if w7 < 198 goto 1b;				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";

-- 
2.56.0
