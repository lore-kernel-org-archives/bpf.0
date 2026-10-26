Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792983646;
	b=QCr4zRHap8QwRYOk8DNbqAorRpUDSALOse8Z1xUdUYAx/JzuTMFaQFD2OqZUL5aB7s0E
	 0u90KQFekgPKv8T9OS1RCKtiJs9qdAg1ioWQFTMPoh318hr6+CgvuaxjFodavI3eRxZw5
	 Z63/ZTqcnDlusoh/Z7hi8F/sZo8XogDn+hxLm4J0mrMo4TW22pU13Rscp5UHPuxKd/NLW
	 JMRJF7jj0vMd5gI6RyJRjWNyHHFlOSz8aGqRUmmi40ibs1AST8FJ6mV+IPp60+r9uoBe8
	 6nCkgbxWN09zsgWN19OX2nCciaQ9R+NcAeglaqmNO7qxBuki6tLHvmGCwhygNN0sO7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792983646;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Fo77cyBEMmSwwKKPmhgPhz86FA/4Ru1Dwfb6GtlkaEM=;
	b=QFsg5HnKnXLfT1IiV55VnVnOb09R0dwv5VnXB7BdzTng/u2nE3A5Se380fdMyxL70yeL
	 MCGwy1VWfJvhNOG9q33xl8RnLRByIlLbj+exUJKzZNDdQoW+zYNz/ZZE0BVQJahHUs7h2
	 o9eYbUEH0+jZHte1LutylkiMgneDAhv5nxIwKV+D/wyZlZgNlhGv/AmoW2QizRMEZWwty
	 /Izg0mPCUsVztM1zysvP142MheWUIea7L9NujLs17L5Z6au0vf0I95W6a4GMamPkw5u24
	 /9yHj0j1qWSNZ5TpVitv83zF1HwEZtApDDHSfsggjE+JF7VCA+4KZn+1gGOtjj5mjaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NPBgs5J8;
	arc=none smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5D0606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:00:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A5D0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NPBgs5J8
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cd62c570b5dso1282378a12.2
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 20:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792983646; x=1793588446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fo77cyBEMmSwwKKPmhgPhz86FA/4Ru1Dwfb6GtlkaEM=;
        b=NPBgs5J8P1qcjlPSlIbBM+XzmgwyeQki6JHu3j+yfBS2n+vF6dy6qnrlltEORqq9gn
         UavRTH1x0fXWe7yU8KWRmAjmXZ3o9ddjr87lOKkz2ULivbNH7dkZiREcR76jjkKltbj0
         tdKQ9Dl7QnE1xER+Yxy1mQsPrPIyGNFqk3SObuIo4WU35ug20kJaXxHZLBrCR8IpT8P/
         rtAHRiLadcAt2gtyGKjeVQ964PYoaxFtbuUwSAQbnrLOwYG1NjkBsKCZDDqsVeXhjnhd
         i2ebtm6n90+2IM9n4gZaGaplvwp61PxwqBfV8p+A4jL5vRGT4knY9m1hGRNScsTmA+9+
         x2ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792983646; x=1793588446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Fo77cyBEMmSwwKKPmhgPhz86FA/4Ru1Dwfb6GtlkaEM=;
        b=LNGqOTT+R43+UafW7eC7SibKKkAA1tVYIz18Cwb647CnVYHgcH+gZYUh9X+N/pxb74
         yifwULefoFOzW1XvBbLBMTstOIg/CBciffoweSsP/I3TmhIiI9IviQXoxevyeXfOaZxv
         N/lUFxEQlOsrL8z5Ucr8NzdM1g02OJSkymjvsuiBiXPpYqzSkm346rDW/Hi1HjkS026i
         6u8fMmI8jMSXUiFfO2QKAIRNT7CvCycqt7UFot3D/bHkgK1ROPv+ioMBnHsHbN7BtDIe
         kAXjaxtd34JwhLu0aVwdvCDwd7JZiE1UDtKFpyWjmRxEfV98Ki4tL1hKyNNR92/4lSaL
         vSZw==
X-Gm-Message-State: AFq9FYJxHX6QYuw/yAZbMpISgr8rryCj1bwd+GqQWu9Pe6Mqj7VZczGE
	l2KzvRJqGaC2XkoCy34lPj9Kncv4v9anpc6rXpnMDEqN6dMeqW5eI9NVLth82g==
X-Gm-Gg: AYBFou2bOJwau6iyJQbn1ybmGpQo9h17iwRUrgEfb8l/SA8WXd9LSknB4SAAg5Mx3K7
	Ncb1KWRTLkOU9v/AUPXleRyvKdt2muCkVtwqwUD/TTz5RixCRQIZRgx9FESR3sNQGVnCII4ALj+
	SGewqIIvStvuXUXpBBP2xUu7xX6b0lScA6gmKkpGo4z92nN6LleXs3Vfdhl4ZtmJakfyKtZFzyw
	NdwgMp9Edxqx6Bp36QZ5uQMTrIEbDbj/W+G1SswOL8jlHKaQWn4jZsdUd5Skwd3gHdGiBS1JQFj
	tJxRiYCllFAaXW9E/PiRXFwhM4hu3ZZHpFiJeQn8piqQ1UfbtX1lg0QUal3AmoQFmRQpntQ9z84
	3/VLpz5xuSPJzdBSx/GNTgFPDNeBeU/NYuvL6xT/YMeC4xsEHAb01XCEdAwms434hCE+KHpgguE
	950reyw3eC7W1E8JztMubgpMfxnNJgRMWjmUAgcJuFKbfijA779MFHPoSUNTw9YBstPDorwtScv
	7n+s+IplXTC38ETTQVzZDHExy4zZGyWy7W+co3DbV3qOlRHgxRTasJHcCgI7ETb4mAf0LP2sAQZ
	ptmsL0ibLcI0ux9lLJMH4w46VL+sCa7aBi7nVe11F9/iHpikwjRagoZ7SaedNayHM+aAscG5uXN
	tfK04/9QtTZ4QiYQvwE+UzvFh/QrMrEs7ftlXNVv+03Il3w==
X-Received: by 2002:a17:90b:2d86:b0:3ad:ce18:50ad with SMTP id 98e67ed59e1d1-3adead57bfbmr5174598a91.22.1792983645810;
        Sun, 25 Oct 2026 20:00:45 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebadfa96sm6440767a91.7.2026.10.25.20.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:00:45 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 10/81] selftests/bpf: Test that a widened register is not linked
Date: Mon, 26 Oct 2026 02:58:31 +0000
Message-ID: <20261026025943.404450-11-alexei.starovoitov@gmail.com>
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

Scalar evolution widens a register that has delta 4. Then the prog copies
the register. With the stale delta the verifier finds that a read of
uninitialized r9 is dead code, and it loads the prog. See
"bpf: Clear delta of a register that scalar evolution widens".

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/progs/verifier_scev.c       | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_scev.c b/tools/testing/selftests/bpf/progs/verifier_scev.c
index 661ce9ca8f93..c41f33ee6c70 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scev.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scev.c
@@ -1377,6 +1377,40 @@ __naked __noinline __used static int probe_read_stack(void)
 	: __clobber_all);
 }
 
+/*
+ * r3 = r8 + 4 is linked to r8 when it enters the loop. Widening drops the link. If
+ * it leaves the 4 behind then r4 = r3 + 1 is taken for r3 - 3 when r3 is compared:
+ * r4 <= 7 instead of r4 <= 11, and the read of r9 looks like dead code.
+ */
+SEC("socket")
+__failure __msg("R9 !read_ok")
+__naked void widened_reg_is_not_linked(void)
+{
+	asm volatile (
+	"call %[bpf_get_prandom_u32];"
+	"r8 = r0;"
+	"r8 &= 0xff;"
+	"r3 = r8;"
+	"r3 += 4;"
+	"r1 = 0;"
+"1:"
+	"r4 = r3;"
+	"r4 += 1;"
+	"if r3 > 10 goto 3f;"
+	"if r4 <= 7 goto 2f;"
+	"r0 = *(u64 *)(r9 + 0);"
+"2:"
+	"r3 += 1;"
+	"r1 += 1;"
+	"if r1 < 2 goto 1b;"
+"3:"
+	"r0 = r8;"
+	"exit;"
+	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 /* The unknown SCEV of an unbound STACK_MISC slot must not prevent widening. */
 SEC("tracepoint")
 __success
-- 
2.55.0

