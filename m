Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792540037;
	b=e1zQipSyB0Y0Bgwpx97/p02Xqge2TQVPIKT4AN1trliV6KlsKsKrfAWKHADmrOm3QVme
	 /oW+U6oUBF9XQF4kj0VPZB+YBeKVpAHDMPVuWC6TSeQzX4uqlwrX5Ol+3ZQem0zbbzCRd
	 L1iZ2o/LLxpAnqjrKY5O2sPECggNvny7isf7OOmZjIewNxfkYvhAR0C5jUENsFdBExoMd
	 ZpDBWFKruSuj5+N73hrVSn1g1PuClwJyEWnLtGUSu41DQGmuVBQnCt8xbq/KN2t3uFwXi
	 /Cwc0JlXbckfRCjykgW8YtjcioC9b5jC8IoguM5dD/wkShpi7yleGwpNmEPKnXBFpKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792540037;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Q14+zkC6fgjsPzRBLAnVtEvSxv8JzAPxSpwoJR5rWqg=;
	b=bBiXN8JIre5gSs86YG0d0/3fn3Vd6DaurRu1qEE51u0PJnLBpLQqoookXlq4KMa21oxk
	 1k9cs/PnSy/aDjt0q1eJRBvLsAXqWM+2Y3xOyuGVPIWwM7Ua6JghtSgzY5I26Ywj4xDzB
	 7TYXWRBl/O9GHYgeIwS5Jw0W/a16gZzNysWYnd4fr67KLMG5wjfbu/2wVECmm7vskbGB0
	 18vsFtVdrEhH4EeAH79LRdyrhKZ3hjbieikGySC35VnU63v97T9ocO1EMMaBftwUL8lnR
	 gnMftxSWgxRBEL8BSDbExUYlSEdxo8xvz2FPb3z0naxP/c/7BcmeaDYFOyTlNtFA//Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qdcrUwVr;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22925606A319
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 23:47:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22925606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qdcrUwVr
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-35c76e9614aso228150eec.0
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 16:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792540036; x=1793144836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q14+zkC6fgjsPzRBLAnVtEvSxv8JzAPxSpwoJR5rWqg=;
        b=qdcrUwVr9Zfb+52bEAI77XaUj4fS9DlCIGpRsnVQJfd38xLX98M1QWgaox/bdKecYF
         6Y8vX7gYtMYPNnu7uGKiI+K0FIF4HGZ3PwjGo7zj6cJGgCJHnvCQPU8y244Z+3ZZmE6y
         FtC4FSzuFkK1XCSpm/z5AxySV7No18JCNrA7pSR90qqVcX4oHXBruZNY+VpK46BsAPfc
         6enFAX/43FP6xMDXrZVIw3Z7AfmML5K6yL88dVUbQZgTLy/aWKeLEvRr6gG3FbESWmfP
         apg06P3qYPA+3Xn34WJZvk+6bimHEzmUbb/PVX0Bs6MzXAXuPvcjPUhvVLykaEpi6ftL
         6+/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792540036; x=1793144836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q14+zkC6fgjsPzRBLAnVtEvSxv8JzAPxSpwoJR5rWqg=;
        b=s/EE1rc+6QLC5/hXsp/D0upU4wccsVLobzSJcfLqf1dx68cdlFRax0gShRenrBVMqo
         PdPLadJbpsCWHGCs8eZnPHTA76G9Rs/qIYBDhp+K5kWAHyy2afC3YzTHvz5Rs8ybSmPr
         Elx370wdawdeJlvaS8ERBv2N/FBBDjTCJcKks/Zfa9n6TUPlLizi1l9DMNJRShhCD1Z9
         9KlTP+e7oX3pFjYhErgkCAVZkvhlbWbSyoAx/08G745JtadB9EcgThf6PJPxJERxCqxX
         USabeJIz6SifEvlT144O7UXmORjSDrhEZoZqZOfeQ+hlBY7a6vVhDq62Pufz/CyeIOgp
         fG7A==
X-Gm-Message-State: AFq9FYKJmDBmkvC/IiAEhBQZ8e8DQKa9bTgd959qMrvfCkP64hbEQGHR
	bvTczCijPQfI+A8RtYqZ6n6+PCsbVPn6HC5GKdVonkM6xfAKXt/wlonAXitkZITX
X-Gm-Gg: AYBFou3L/bMuprmMUJQK7kMVFdrdSjGic8Z6F87S6HJK9bHOVYxOItFgwgB/aNkBiMb
	FE+CzB+WR1APBgQDYhtbqxbmIQ6AARes08dY6NxTdtRz7QpaxxAXb87icppreZ4UR3xus9oGNk5
	gKuOHZ+PFfNL0J8GrjlPak69RHzLCZ+OjvYap9+7if43lSN09hclNSVYfPxj2A9oJyQihp95WsH
	SULADdMFp0uyUJrCOBVLFDW4Ycu1qUBRXRA9unpkOBOvNbzbcYM/9q9ZcOaE0EQ032mCKVljGGs
	614rf8tCs1r5OEUPr4cmSxXiB8s2y0BkqLZDWQKl6OZ4bNJqtiXZjxSOiTJFx4Xbws7IuchSXik
	rNQlnPtM3swh1Fp/u5oAj9YLvrUctW61V8P8mt7UAdJp7kiZ2vBsPDvlViHgnhJ72oJ9GhkvM+m
	4MRExACBzBG7MDALJvwo4hUwEcr7muopwJj+iHEYryRki7tqTCaF2iNS/LwPhMlIn3F9qo4SrvS
	5lcFwofyM4dYS9VHzV5wlYK/uZr1zUn9ER9R1w5lAEqrp7WwIOXFzk=
X-Received: by 2002:a05:7300:cf96:b0:35c:6366:1d52 with SMTP id 5a478bee46e88-3674df52799mr1015261eec.21.1792540036217;
        Tue, 20 Oct 2026 16:47:16 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::7:5753])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3674198f1d8sm2644619eec.24.2026.10.20.16.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 16:47:15 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 2/2] selftests/bpf: pointer operands for 32-bit recurrences/latches
Date: Tue, 20 Oct 2026 16:47:05 -0700
Message-ID: <20261020234705.375067-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261020234705.375067-1-eddyz87@gmail.com>
References: <20261020234705.375067-1-eddyz87@gmail.com>
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

Two test cases checking that loop bounds are not inferred for the
following program shapes:

     32-bit latch          |    32-bit recurrence
  -------------------------+--------------------------
     r6 = ... pointer ...  |    r6 = ... pointer ...
     r7 = ... pointer ...  |    r7 = ... pointer ...
  l: r6 += 1               | l: w6 += 1
     ...                   |    ...
     if w6 < w7 goto l     |    if r6 < r7 goto l

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/progs/verifier_scev.c       | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_scev.c b/tools/testing/selftests/bpf/progs/verifier_scev.c
index 661ce9ca8f93..6f8c3980299c 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scev.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scev.c
@@ -2971,6 +2971,62 @@ __naked void ptr_stack_other_frame(void)
 "	::: __clobber_all);
 }
 
+SEC("xdp")
+__success
+__log_level(2)
+__msg("scev: incompatible latch operands r6 (map_value), r7 (map_value)")
+__msg("loop header at 11, can't compute iterations count at 14")
+__naked void ptr_map_value_jmp32(void)
+{
+	asm volatile ("					\
+	*(u64 *)(r10 - 8) = 0;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map] ll;					\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto 2f;				\
+	r6 = r0;					\
+	r7 = r6;					\
+	r7 += 4;					\
+	r9 = 0;						\
+1:"	LIMIT_ITERATIONS				\
+"	r6 += 1;					\
+	if w6 < w7 goto 1b;				\
+2:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem), __imm_addr(map)
+	: __clobber_all);
+}
+
+SEC("xdp")
+__failure
+__log_level(2)
+__msg("scev: incompatible latch operands r6 (map_value), r7 (map_value)")
+__msg("loop header at 11, can't compute iterations count at 14")
+__naked void ptr_map_value_alu32(void)
+{
+	asm volatile ("					\
+	*(u64 *)(r10 - 8) = 0;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map] ll;					\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto 2f;				\
+	r6 = r0;					\
+	r7 = r6;					\
+	r7 += 4;					\
+	r9 = 0;						\
+1:"	LIMIT_ITERATIONS				\
+"	w6 += 1;					\
+	if r6 < r7 goto 1b;				\
+2:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem), __imm_addr(map)
+	: __clobber_all);
+}
+
 /* Metadata and packet data have different origins. */
 SEC("xdp")
 __success
-- 
2.56.0

