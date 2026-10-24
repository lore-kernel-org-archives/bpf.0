Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792800245;
	b=lKJKm3CGdc24i5J1I5RUaNy6ilFHPbSnhlaMyrIlKHL7nd/U3WnKroHhdhYNnpBkv3vZ
	 QvNI8i3wgAwB4ZfwmFPXKaJsnnXxwKvZXYUzzwYWk+9c+f3Yn2G4/P5gXS49tCU/PWAS9
	 9261Yt9Ryx1trK2YzInPW1OTt+oaYDmfl2LKJZh6fXLJj0oTrj3aFe+GWslg9dA40UJ3w
	 6O3zcTtmqSwATMzQl4honOgpMaydxdyCCGT+IB0QKAMF+AR81x/NOvvLA08BprliNtmMe
	 l7v5rHgN25NJG5Uk0M6O6+gUozwjW02aRC16EcatFUNP5dy64XJxfSP62m+JNJSM/vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792800245;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=yWcmeThpcGx6rGZgPANk4Kk6TMJByCg2kVqo+CRdpgk=;
	b=AQ0YJ4fRROT+T9Gxu1iBP2AFyJKjaSHf50gPHFhgOIo97eRbRFz5QPd76VAHMnN6IbOx
	 0h7atusd12YHEEGODpRCu7WpKi1lRpSIZD7csMTDYA/TRuzTbm0vNYluDvXUWa8uLBwNt
	 yYyIdYrJ8upENvGI6qeKu1WF4fAHwrJ9pPX781AEi/y6MMijJoCUtvTIZvqInjy7MTJMF
	 hjATinRug1yLKif+i7HEbZzbMKowJYDwMj+51Ofn59zvzGk4nkLHIXzGqea6lEuDBJc49
	 PcZKB3CoE8Dfe7b3BRPq+SkObuX5RXlQ8qRvsLIXqryDaGgQDxHq+9Xq/whiMJuXBHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OeTd5Ikg;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8346D606A31F
	for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 00:04:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8346D606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OeTd5Ikg
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3ad41b47541so1016844a91.1
        for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 17:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792800245; x=1793405045; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yWcmeThpcGx6rGZgPANk4Kk6TMJByCg2kVqo+CRdpgk=;
        b=OeTd5IkgSJnkdXRe1eYhlrKAuhMgq4GuErGeH4qd5AQEdoOO6PB3oJoEKkHNCkMrTR
         2XnI1ioleJ1io/AxHfFpWVcZ5gr+FDPTAv8Fh8u9ZIGVS9Bd5YthA0l3OgXHFhu2B7bo
         BWg6OXCrV3+N+lF8fdQ0FK4gv4fLvBAlkwU//u78UVf17hhku0xUR+BBffsoqeCLEtby
         hP7GO7X9Hl9BadBnM8BPkn9xUxpwnOaxvt8DghIV1OntMml5gPfkge+5MDHIAKaGiXtL
         Z6K2XESWqxL4Mt2qiZbHkDNMcY2uUqBRVHds8MsBY3aeS7B0OC/BhyJ0DEe0FS5926m4
         TDqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792800245; x=1793405045;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yWcmeThpcGx6rGZgPANk4Kk6TMJByCg2kVqo+CRdpgk=;
        b=BVMCIpMNDAOvbLrg4eVY6m1/t7Vd+twPEOK+M7f1ShcBKBLid/yqH/zE0QNclhSrzA
         ga3xyWOHWg7ss71PCrdYGc+bpPiE/vs6Tw7VMMB+EbxocIlI67pr7CP3JWjYaA/MWCKN
         dGkgd9stOyx2v8HHy2JuH/14EDEWUs4+yrihdvk5CcB2lCJKym9uYr9Q0uzgaWeVuV+m
         /MtfKde+emSENCr8hKoquR/JC3bu3dLN+E3NMr1rhqpz4Gd5PsKXvnLITTCy5BwzKzHT
         6DoUEKwhfpNDwnMNoH4xr1ysKcChT20knbo24EWrYC/EdC4eTEbgDCcqlmBHmy40EWfg
         EhAg==
X-Gm-Message-State: AFq9FYIyulXHgCDr3qGoLxvBpFm4ZLUE1zYn1UEGmVKxlMxXOPIZTLNd
	NF1PRFi2YQqfUKOJ+ikDBtyLzDmI5IfRpIRyrylAQcEZzM/ucAWdC7vcr9mlHzBw
X-Gm-Gg: AYBFou1Cl1yHDD24rqQSs8+B8q3vfGIaIYeuYDlYt6tWEDbO+sDVWhIrcfod2r0NcYX
	+A/2R+CigU1CwXiFyEaAX7ZbKst0raYnjMV5nsi3PwMMMmuN4uQcKra/qZON8Vpdgned7SdOItQ
	iJcB9dpBycE1o7CD9QnPOkqNQYNKCFNO6MsyLd3I1nCrEhIG3pvpHyRYavPbQMQ05Cdtw6r0VVO
	tCnqCVi0jM5VuTHa9B7hbUcAE6s0b48O39HU60kQ09D09nYXl2Oa/4JI6vfZOX66L/UKgSo8mD1
	+YdRoLv0ZiXfcSXGryLuYMHpqYgMg3URKtcEThB9smHP4+eNCSFGu2YWZ78qpeEzSq1LHNVdH1c
	dd+RM6YP9FIyeBYfUEeU87Ervd/iI+H3LLmDV3VKi0awd4wnOomK4l0nvTsyqsuIob8aGY00Pdx
	9W04b9o7lYElKbJVW3r5HR2jR/D1p4+OW2BBUVfA0YguMdBvZhLXQhWrVreDsYRV2DNGwCVvQzS
	9QSIXr+zX/xYjddW4TWGMF1helmzuaHBMI7fSw4iyMhBL8uwTPPz5U6xo8CgnKKb++Pn0Iu
X-Received: by 2002:a17:90b:1b04:b0:3ac:8446:c1b5 with SMTP id 98e67ed59e1d1-3adeae8b8e9mr636372a91.31.1792800244813;
        Fri, 23 Oct 2026 17:04:04 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adeba31797sm547433a91.1.2026.10.23.17.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 17:04:04 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 01/11] bpf: reject pointer operands for 32-bit recurrences/latches
Date: Fri, 23 Oct 2026 17:03:43 -0700
Message-ID: <20261023-scev-simpler-clamp-v1-1-d43a07eda7af@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261023-scev-simpler-clamp-v1-0-d43a07eda7af@gmail.com>
References: <20261023-scev-simpler-clamp-v1-0-d43a07eda7af@gmail.com>
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

Avoid inferring loop bounds for the following program shapes:

     32-bit latch (A)      |    32-bit recurrence (B)
  -------------------------+--------------------------
     r1 = ... pointer ...  |    r1 = ... pointer ...
     r2 = ... pointer ...  |    r2 = ... pointer ...
  l: r1 += 8               | l: w1 += 8
     ...                   |    ...
     if w1 < w2 goto l     |    if r1 < r2 goto l

(A) Scalar bounds for pointers represent only offsets from their
    common origin values. The 32-bit operations also depend on the
    runtime base address: the addresses can wrap at 32 bits without
    the tracked offsets wrapping. Thus, offsets alone do not determine
    the iteration count.

(B) 32-bit operations on pointers either prohibited (wX += 1)
    or convert them to scalars (wX = wX). No need to deal with
    this at SCEV level.

Fixes: 32e962577d2d ("bpf: Support 32-bit linear scalar evolution")
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/scev.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index fea77772ca96..f9e2ca6a5a12 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -2024,7 +2024,8 @@ static void log_incompatible_scev_values(struct bpf_verifier_env *env, const cha
 }
 
 static bool scev_value_compatible(struct bpf_verifier_env *env, struct bpf_func_state *st,
-				  const struct scev_value *a, const struct scev_value *b)
+				  const struct scev_value *a, const struct scev_value *b,
+				  const struct linear_latch *latch)
 {
 	const struct bpf_reg_state *ra, *rb;
 
@@ -2035,7 +2036,7 @@ static bool scev_value_compatible(struct bpf_verifier_env *env, struct bpf_func_
 	}
 	ra = scev_reg_for_read(env, st, a->ptr_reg);
 	rb = scev_reg_for_read(env, st, b->ptr_reg);
-	if (ra && rb && bpf_same_memory_origin(ra, rb))
+	if (ra && rb && bpf_same_memory_origin(ra, rb) && !latch->zext32 && !latch->jmp32)
 		return true;
 
 incompatible:
@@ -2267,7 +2268,7 @@ static bool compute_max_iters(struct bpf_verifier_env *env,
 		}
 		return false;
 	}
-	if (!scev_value_compatible(env, st, &initial_val, &bound_val))
+	if (!scev_value_compatible(env, st, &initial_val, &bound_val, latch))
 		return false;
 
 	initial = initial_val.value;
@@ -2700,6 +2701,9 @@ int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_sta
 		reg = scev_reg_for_linear(cur_func, r);
 		/* If SCEV for r is (linear <reg> <slope>) */
 		if (reg && is_simple_linear(scev, r_scev, &coefs) && is_widenable_reg_type(reg)) {
+			/* 32-bit ALU operations on pointers convert them to scalars */
+			if (coefs.zext32 && reg->type != SCALAR_VALUE)
+				goto cant_widen;
 			/* Spills at varying offsets lose precision */
 			if (test_bit(r, loop->store_base_regs)) {
 				spill_base = true;

-- 
2.53.0
