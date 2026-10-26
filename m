Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792983664;
	b=tMWZy0T0uQYM0g+LwDlq+6Kn0C3vPA0g8Jsp3LP/iu6pz6IQAXlbDPIWSlikgj0pdjew
	 9FT4SJGniM3H4le18JjObm8Bf1lkujh9S8CaRKQ/sMmcwN11zLsAj4Ewr20zjEEvI9++X
	 FwXRxWsluQrs81nHHgdWMe+isw9d2kXhBX9zvl3AeoUjFaQ2oATW/8R82kXsCrYc2E7nB
	 b20Fnz0qBhAU/7vJQ2AX7FkZJrDjFdDsdj49PYW4Ba6EyhkRkOk28h1szrAWEqyHK0Xa5
	 QZHl1R3EuEq3lEJzG9jKe/p4j8pDN0ThOPuUiRoZT487BPJVi6u8sZTgXQg+xqpxg5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792983664;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rgmF9HegW6smd+h/nAwt+GLlwHXuG96lfDtNG2UnQ2I=;
	b=mnDytnbfDOk6iUb6LQp3U7HEZ1jWM+xtQ7DFdGoefkYg8pmqZmjr4p6GUfYLmDJsoFUV
	 ZbD1eGqJjO/rXBmFAkwamvoi9qX2D5QbV569+0SlEDUiUBZQQ8TYm65Jz/bIkRtgPWH+H
	 rJR3orS52HvthprSqLGsWSLEJntKEFpTaOxYuVaQKsVsJknBPRQtTsRAD7KWWiMi6AEZA
	 zg2ebWIBAXabEtmb72bO8zL8W1jPki6rZ/uC9jkd+OZfN186KJCgIZgWPxhryqpaOm/n7
	 b/O8cwnKi9hc9qa19/z8MJmGf5f/vp1zqvLCbYxnGZD6SCv9riKnBw0FDILOFvkAlyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AyVGi59h;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D27B606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:01:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D27B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AyVGi59h
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cc4dbcf2b85so788376a12.3
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 20:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792983663; x=1793588463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rgmF9HegW6smd+h/nAwt+GLlwHXuG96lfDtNG2UnQ2I=;
        b=AyVGi59hld1CKFhK/+k6CXFTAhtg3IpSypRH+7t/E/mFz/Viw4qIG6g1JU/S5k8BDQ
         CdygKr2+quE01fhDEmh1c3fmLQ3Uow8EGQwoSM2kjFxMjp9zeZPNrkfZyNW7JO0t8jYd
         RWLbTsMuICpHyKcNov1t+TK+vg8789JZpuOAhE5wkhTCMkRDPTrhNHg0aDIgO62u/xkM
         Tuxdp96+rGTxWW3vAiiayTiGb/btVRW4EoLoNtZjfN8DxydubfpF7w4PIs86L1Fc6/+C
         6APOo3NYD234KqjEEk6Jbu9X74f6N9vKnjNYmbLaPp3NkD6oL6g4zvOpZTHJSLwIrHSa
         W5lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792983663; x=1793588463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rgmF9HegW6smd+h/nAwt+GLlwHXuG96lfDtNG2UnQ2I=;
        b=xEFSksN4Kzi9l9sbo2J8LGHd3M5klbbH+aSt+wqkmLSEsTBwgDqaKeYp+JiaAeoSF8
         40myStfSpyEb5P1S7CNurEWA4TNBgC4QmdX2uVMWgF2udhA15xcelA+28txS2iyTnL0h
         b86Ya/6oFfIFX9Akv8GBq5dnkV44gWPbuS5l/NmjYjbYtBA/wkkgv3tqLVCnpwhWWuAo
         TwLDxwiUPPw5MFzYLb0laQAVr6dc9ySWnFKMtnvmT3PjDbCHSzu74cTurAAwtLIkzUCa
         VRzLhUDXNlPfVr9d56NAY7ob4kJLAaBE5IjAPKDebDK/W8F0/S0TXI00coxgumIro0re
         TwEQ==
X-Gm-Message-State: AFq9FYIUyYLLXIfdU6qWeQoiirVKISrKyJgcmrLtlnjB9aehCQudj528
	f6ss/vrtT8L2LyrsuNmdvnX40qNSDAAziHe1GYPwouGRxlIqGMvaPsoUhK9DLg==
X-Gm-Gg: AYBFou3m8fMzRcN8LUP2nRHYl0wKvU8GBBax9XxcZAboR0370jd/V2h4R8E/xuQWSPv
	QZM/mhY18sOM4wRb0kenfpQewjBleZb3Vsg+53DolXPASfAZo7MuDDRTJi6yjdSgIHbd5mGVvDl
	rm/h7IAdaz8Ss4KkrPCVDfBBeH271PBEiTvxPZmwUYvBGjVh71k7X1IqP1rMH/6YB0GcXPjDxl3
	1Dx6iuDVe91F5HjdtqnMKxMuj/rVq7G5+tMA79npRxwAlXSo1Aait2j0lxVtDE5p4s/IIpELuVF
	tQGROx+Mi0d+YRr02cIIDskIzoIAWr4Fivpf9fVtAIGR6CD/iJptpSu5JNCaf8KxIWVdhdCnBdg
	IVslmGfXfsubheSI/OeIRjcvOs248QHCsrF0MOm0IaKECoB2Wad0Z7uLptw4vV1pZhX/Ei7SaDp
	sDpwAPV2ahExR0alFlFZ7JUuJu7enaskBmcT1t+nH6xuQascajudTh+Cxlw9LzjHSPscLJAF8Dq
	mn8MiCG3JWxUdCxi6cbFU+8yOGsFmrUZRpYQN3wXHfcnnbcqRxSAsnZTLbMU1VqpcUifwRG6U8m
	+ZDQ7fTv2WsVTOqOUvd+f9jBBGWCvG+iZTLhXhwWTZMwFqb1v4PTlts5+DwKJt+XTeUBmfUAeaI
	oijpISgQ3gFZk4IlJcx+UkgmuMlHliv8TxoINq6wYWRYPjg==
X-Received: by 2002:a17:90a:d2c7:b0:3aa:f4af:1e0b with SMTP id 98e67ed59e1d1-3ade9a35e82mr4846112a91.8.1792983663208;
        Sun, 25 Oct 2026 20:01:03 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebacbf5fsm6544928a91.6.2026.10.25.20.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:01:02 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 13/81] selftests/bpf: Test a loop that moves a pointer to a buffer
Date: Mon, 26 Oct 2026 02:58:34 +0000
Message-ID: <20261026025943.404450-14-alexei.starovoitov@gmail.com>
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

ptr_buf moves one pointer to a buffer until it gets to a second pointer. It
never reads through the pointer. It loads only if scalar evolution widens
the pointer, and that is no longer the case.

Change it to the loop that real progs have, for example
bpf_iter_bpf_percpu_array_map.c. It counts in a register and reads through
the pointer in each iteration. Without
"bpf: Don't widen a pointer to a buffer in scalar evolution" the verifier
rejects it with "invalid variable buffer offset".

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/progs/verifier_scev.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_scev.c b/tools/testing/selftests/bpf/progs/verifier_scev.c
index c41f33ee6c70..504cf8230625 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scev.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scev.c
@@ -3255,21 +3255,23 @@ __naked void ptr_mem_other_reservation(void)
 	: __clobber_all);
 }
 
+/* An access to a buffer at a variable offset is rejected: the pointer must not be widened. */
 SEC("iter/bpf_map_elem")
 __success
 __log_level(2)
 __flag(BPF_F_TEST_STATE_FREQ)
 __msg("header_count is 4 ")
-__msg("widening r6 to 0..3 step 1")
+__msg("can't widen r6, expr is (+ r6 8)")
 __naked void ptr_buf(void)
 {
 	asm volatile ("					\
 	r6 = *(u64 *)(r1 + %[value]);			\
 	if r6 == 0 goto 2f;				\
-	r7 = r6;					\
-	r7 += 4;					\
-1:	r6 += 1;					\
-	if r6 < r7 goto 1b;				\
+	r7 = 0;						\
+1:	r0 = *(u32 *)(r6 + 0);				\
+	r6 += 8;					\
+	r7 += 1;					\
+	if r7 < 4 goto 1b;				\
 2:	r0 = 0;						\
 	exit;						\
 "	:
-- 
2.55.0

