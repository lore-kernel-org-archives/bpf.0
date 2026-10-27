Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793127867;
	b=SoQ/kTeMlzQ9RNDskhHsE7V88DnUsSJfeBpUZmZPCgMNCxp34Lbnn181rZDg39oZ36gH
	 0sDOuFmUr7osTfbQwmkj9pVs0xjmy07DuEVwl9soWxlNOsK/trVtPKnjkw/cFIbupbgYI
	 YiNuxxrYxAu4amfQ8B0B26Pz3WQrFoBkr+xRsXOi7SjhFsaB3inO9noEngu5/xqSymAVt
	 3U6n+2b25vyEutmoI/V6ap/QAV9fuu0+9AQ002+qJWO9C70RMgLuIg2L7Wr5Q09NxWvHu
	 ywNuEjhXqGFCXmg0ifHSF6WE5SEFF9R8HQ9sXQNsslOlhjKFJe3kuwyPfLhOeovHnZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793127867;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+Mj3SD0A+Q1kZarcgonclec7T+/0jfRAudbp9m45VOI=;
	b=RKlP2T6pq3pcMf3UyV1xWtwqfP0a3ci0Lq6ONRfLmEX9qdNFoKseKLpj/AdQocr2V1If
	 g4BqFzUI9vmsbITKrLChAduf1e3A3F1NjP8CsiZZN0wkKqzre3+3nIAWqj4tE7u57HPbw
	 3Rw0GWEe/UeRIr2bABjZ7Jwyop4XiLTEZljqqbN3PFQ4srVwndu3SRqual9RMnlvTzYzG
	 qwl7f3+SR+5kUHqWzHy4cE7aJ3uaJ+IHN7DvegFhhEK5jYSwrhki+bST+J8qJ9M9TAKci
	 jLwDcoK402Lj26KqG//wUBaRF0z9lz24sE2kr+pGmX71F8cJb/V5OHexa3B3mECSesQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UDasnnFH;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DBE606A31D
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 19:04:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79DBE606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UDasnnFH
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3ae486f8a27so166058a91.0
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 12:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793127867; x=1793732667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+Mj3SD0A+Q1kZarcgonclec7T+/0jfRAudbp9m45VOI=;
        b=UDasnnFHJIhyIJjsTWK1XP78p7KGs8eXlyczUTW8LwrFuOmGWAbQAaVQjDaKSYeLUe
         eXuTXcxkPH2fUyiSaroY3Sd8yeTVSWhYA9iORSlsyQm/CMLs6mR46vsOsndRpZBNT17M
         S60tHf2tTQ913baD629yf6Hy97hsKHjDS4aXdYeZuNpdrDcgNjmWJpHRlgONv70+TN32
         LP97YD/IgpT98tIrHjLFSaXMoi0sNnRBEPDNTQ3RH7CBm0RX9QvGgDBLmaf/uTHmLtTB
         UC+p5dqAmG2Dqz0DSL7tcPCb4JNyiywmDCRrvkhKmLCFT0KnNxNrv8eOvgt2ja79xcQb
         kd3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793127867; x=1793732667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+Mj3SD0A+Q1kZarcgonclec7T+/0jfRAudbp9m45VOI=;
        b=xCTtwIzJciBD3Y9k66zCoHcPkZ0oOTEsJbbaagSkbmko9p8ZOjgvPdIXVpk9HWyhoJ
         vzwxMi6hvjsSm1+IH2izGQStqxBkCy8U441nIyvuPY6pFf8TxXuAWGYpQzmleFnS7aHo
         CBmi2/MZUrTp23v0ZE8CimO9m07O3S5q7AoLvjJfqVw8J0JfTWtzg2eRDbJfOHUjqPh+
         F4XDlkq/IKqPmWStCykDUONfmLQrUWP7HBSEEyLpGwaIYfpU8F2nITGEjhrrvNG8Z4Jy
         LeE4WF5J76pp4zWcoKhlWZIKPhsvh2ua+6Noq+4cFXYMLjBYe9Wihrbtg1cE+6jFdq9j
         kNUg==
X-Gm-Message-State: AFq9FYIZgfnha4HI6Ta1UmhAkyyZ0tDAJ+FyHL7X0MmIhlGxPT+ejrzO
	4aIA4b0AielzRGBpOd3t0vREKdQi3wH1P2lmuaoyjTWo2I3ZjBov+9pzw7obkA==
X-Gm-Gg: AYBFou1A7S/h663j38MS/m5gGJiTyhvphI0vQrr7Fzgm4LijnAvrz49SqHgkdj8P9Ie
	nAMUyDlVTT1WgblYEutgYKcv5mqxjT4GNkm3nNe7LFKXWTtfjeQ0quvv/OmJDG5jTa/VwF7WHm5
	Wdypwagk2bZEP1JhZPbnzdk7UtifYy25Bmp6ImnSyiuRtm+QnFDd5tLxFApO501/BxErVOu8Net
	Gp5bwDDURRebJW6bLpVI5JSLFcOdPuLDYLeHeNpIhSA5v+ZjB43cWzr+0jemoErmBLmxuQcj98g
	3t4yewPi9t+hk3bQXh1CEh9J5H75Ktay5muGqxyJ7s4v9YFGS8Ltq+43wR9x9etMhl1ZX4P2inK
	zyQMnM9GswB2ZEG58MToq8R3D9vx7paPJfUjERyOHTVZcoMIgjKKnUd4QwqDYNBXvBA8Y68wDag
	5B7e82BQfLw4umc0kL042iPMOeQYWJvmJlk02nGshxbVfYPEIDM17fHAk2dqHdxMbzOXm2HJixT
	NQmYHh67l9ewQMWrC0UdDs/brPf6J4Q+Dus1ANSFNnr93TTJyM1DE3EKwoaOf84HnJyzBUW1cxD
	b/M8i9TNfn3XjCDhZtwfigcHmHJClvwIXAIyhPVJKGJD3fgGUHRyWbx8pCCzBU2QY4MxS7aItw8
	A4r0/vkF9A5T88qkE4Na21lu80Q==
X-Received: by 2002:a17:90b:4b10:b0:3ac:aa8d:19e0 with SMTP id 98e67ed59e1d1-3ae57e07c39mr27200a91.9.1793127866762;
        Tue, 27 Oct 2026 12:04:26 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae57cbaeaesm55012a91.17.2026.10.27.12.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 12:04:26 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH v2 bpf 12/19] selftests/bpf: Test a loop that moves a pointer to a buffer
Date: Tue, 27 Oct 2026 19:03:07 +0000
Message-ID: <20261027190314.1440199-13-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027190314.1440199-1-alexei.starovoitov@gmail.com>
References: <20261027190314.1440199-1-alexei.starovoitov@gmail.com>
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
index ddc9667bb078..cf7916e1fc48 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scev.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scev.c
@@ -3517,21 +3517,23 @@ __naked void ptr_mem_other_reservation(void)
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

