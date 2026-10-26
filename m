Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793057923;
	b=wITeKF+fzw3xpccylz6g+V0R7izkXfQXf2mH/duXT6HlGGe8xwT3l1CHniIN8+d6g+oJ
	 jSH/m79dLkLRJTrzMiSEkNlCL5ExCsYJYbGr4NqL0tRbbFJbcHrcd1Nfts+es8wmyhtNx
	 k6As5nVVH7Cen2Qi6OPwFMtJJVdcl9IkxmNqqBrChyiba3afPwpEgHevMsaBpuud8zDzs
	 oTCaYElypfo/x0MjPSuK2RKGftg978J2y4d11vdZs2nnr2UngqfAHT0W2A281cZ64AdEq
	 iKm20Rl97whJUmN4b1miIBgLMQ1D9VP5pfZwHrmFrrAXGkaN/gJ65UbwEgXBxMktR/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793057923;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=a+j+vMxKPoTaNTB/9YAI4AyjTsvkuFvkX7Ptqxq2wI0=;
	b=NTfRUKao09iTEGC5x0w7go+6sGhXRBbI1v3BQeJWtyxqyVUdOs6A/Mjs/kAdY8/Zf8X6
	 U1C0Or2umXG1uZvfFQLWZ3OFmSemuFF65Ry5hzykDJYZ5Mu+m6Wc7ZrA7hssRisKnU48n
	 uoWoHjsBkxVECLk/zZPgmkya0ZHqNek1hOhMxIwDnjr26qytPvL4fTDIM441Lcs9JaxVb
	 QyXZdMX09G6fl/p8pY18sjjjub8/T4Ga2bTfhniUoC5GcIEkX7TiT61lkTs04eH/lVLXs
	 2MNkPsxf7/JV2Gn+XBFiB1/D70yZb6F5V0KsT8i9TJsgHcOP/NgjIngla0w6hJt/cyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JQPeG7+Q;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B08606A31D
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 23:38:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4B08606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JQPeG7+Q
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3ac9f49b984so257863a91.1
        for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 16:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793057922; x=1793662722; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=a+j+vMxKPoTaNTB/9YAI4AyjTsvkuFvkX7Ptqxq2wI0=;
        b=JQPeG7+QI2vBpuOgO/0yL563HQ0fKtRLFKxTROUlxe23zcGGzFXILxzc8KFalR3zhq
         alcpFtHFR6st/Gz+A4DQmnYRxYd3T4F34DdkKKB4PiimdJKcGTny9Bgh7u3hXYS3fE4S
         1AVMvcAsb1MuvmYgWs0Luc7yFZDVjQ3Fp7AGqjcMq2p/i1McAUn5R3RBFCEV69Q3N4Ac
         1Op1KeTEBBugi1/mm+mjMdrAd8zr9fZCybWYiWihZ4VnxF0Vh22OnXh0yXiYsshSB5II
         atlK/8lBVbQTqJkVLEL5jA/K9fitE/Yeh2df280dj9fuph4WFNBr0r6vzVu/ZKnRw55/
         AzeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793057922; x=1793662722;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a+j+vMxKPoTaNTB/9YAI4AyjTsvkuFvkX7Ptqxq2wI0=;
        b=WAzOPlME9P570yXQF5v9kK+g1zM3tyX9IUQgmfNyPf0W+icNO5ZozZ5ytSvJFEZRta
         iLFX+BwCRzuGOkttQmutduZF7gV2NM+reXonVKBxW1BWigA3KlETko+dfKpEsVl566QG
         di3BI5UEJJTm3BBzwhj3MemQqN/dZGl+MdPAxljP/e4UQOEa57hOfVPoiPbZxFDHxdIj
         j7TYhRjpCLFNAzj/DaDhtnYLa8s/lntyYQqT4EGzmGJI32mG2yNyDsuJBylWE0mEZqpl
         i75+tRreWg539ngFjMSIK3MBv5nocHXD2rVw4o4VynOD1WzKikIC1KRCALPB1EnTHov+
         FDXQ==
X-Gm-Message-State: AFq9FYIhUA77lQH1MXnvlyC/xuJsXPF4RT636dK0xw1jGQbYr/0YrT1J
	Cm5a3yMNH97VzMKvrQX/BxTChMyUUnMftbtIkj3V0DVW520nux6rTE6b3eh/7w==
X-Gm-Gg: AYBFou1wloriFQfE/YMRXkLzEqX05gyCOua6epx8QkCPINEetHA+enjjAU+n1WjWPJ0
	+D0rua9QPgodC3tCpvJuKmE0SkTRYB8wBLuhFXoqODTMoxNuy0tHIpP7k/+K7zoCdhWwNcXOmOB
	jw/0C5KPMqijI9s2BO/rUn89xezZ8i4tc6XiFzzcVnX9j1Pi7iYO2m2Br6NkHfTzKdauOIZYkN1
	BRX2TYNluazKwU9Wn8UbAQwKqNtPNdjhxmeFFxqHBC3lpOsTmTPPm/4ULTLJrEEjHgXGxBVHmSW
	+yNn355W4oY7cZIhwIqf+XweQXftEwVL04XM65VZs7iThgTBjSXKTO1e4/oY4Uhgic7PpG5HaXN
	TCgInkUaUJ/sSXxPPoye0QvqX/Q7WO7dmG3NHA6JUJ+QpcnkjzHtwx27+AKFZjLTnKFqkUXmY3W
	8jHUbVC+sNVFTdQRjJ9Mw9umSpwQvu3YgOt2HFXiieNrjZOJ9wSS1H+llnN7vt690zZZc96pyUq
	8nY694hc+1HlWlhh19dUEc1kDYUZ9pyh9ckQvxXZUTbaYNyBCLmZjIE2Ss0jQgw4kZjsyjAVDLA
	DJHvVfHatZLlmhD8cLKz+/Q=
X-Received: by 2002:a17:90b:2705:b0:3a4:b509:88bd with SMTP id 98e67ed59e1d1-3ae40268cd0mr480319a91.2.1793057921916;
        Mon, 26 Oct 2026 16:38:41 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae40455eb5sm1167437a91.12.2026.10.26.16.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 16:38:41 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf v2 01/11] bpf: reject pointer operands for 32-bit recurrences/latches
Date: Mon, 26 Oct 2026 16:38:21 -0700
Message-ID: <20261026-scev-simpler-clamp-v2-1-f373aec9825f@gmail.com>
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
2.56.0
