Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792983844;
	b=cIcoGEW8rSc5LAVR8DzqSe+U630J/J8D2EQm7/RgWBdsSVy6vaTAwo5kBsktR3oYKmHa
	 F6dGd+3OHqSaMePoHjuMACE/pIwnfsa1/65CCcOtwqINZLgywligHJUpX31bi1nsf92vO
	 +WAqymJyPsF7pCs3Ji6nkrbe1TMw98qwRdOx+dHgtAzs9AJZ6WRbLUpDjNmQTKPxpA5VU
	 cBvYHXF9oCzZea5MIuFkYNntIlKNmnydut4TublzqgEZorneZmRojK0gNJK0rtq+Yz+xq
	 tvvIIXalXFe7Pnti9oxgXq1uVVxg25qmPAHzl1wlQR4uEYISkjLG0EDiOvxSYzSsM7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792983844;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KEC3hoP0QbwSszOiSHsCpP9C/v6RlZctxalBj09R5iQ=;
	b=WbFB6Hkx4ujhiasob58YnstTY1OkOxUV98Zbnfe1HEZ3ctmvaPf3r/6ekLEK0x95OvOj
	 H/uSFrzfpwS1qYxEaHkFf5LNC+j9VzX/92K0uxJh/dem4+clTh7jdGPQmBVUcWnuvxrkh
	 s4j6NvQrJ1SMPite71eS4C5SHqDADGPWzq8TD+T6N5LZkOZJ7AeRu/8D4SavflHzYdUOT
	 cnRjNN4OY2F7kaoZSQ7XZEbGh/wWNiB2aePSheGlLHE4oGvCpvaVUaeKXghcg4nUyKI2q
	 dN2YrwETRUsKP2qOu60+KjYmmAsncwrLDEeNqUz9v8N6zizdnKjXyTveKQtZ/Z8de0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aLwqas0z;
	arc=none smtp.remote-ip=209.85.215.172
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708B2606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:04:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 708B2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aLwqas0z
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cd3310348d2so1280112a12.1
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 20:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792983844; x=1793588644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KEC3hoP0QbwSszOiSHsCpP9C/v6RlZctxalBj09R5iQ=;
        b=aLwqas0zq1mvfieK5+YXRjDpkqzebZRswhsB84NJUTd0KdF8wqhH9tpjrg1EAKHFqw
         7KOllX+6RV8gFGEtDzQSriEK7QjjnRFg6VuRXbIcZq4B6ym+4Xq7G18SyZuvGZKeFTGW
         /8NH2amdxb73p8kYjauLyxFEBbz6D0M3cBJ2PwZehJJHI0kz4q3Jlo4FNNenJRZAcrJy
         MQvuRqlOCnl9zgWr6HwXtYhfgaMUeXM3+dTP4lXnMVQCECm5d8+RXOZYt2cSx8bFFXd9
         o8eEpdgSzKbHiQFvfko8On/ZkI+F1dO7tTUUBwL2f2UDJH3B5QxvN73Zje1IwOPUZRK/
         9TzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792983844; x=1793588644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KEC3hoP0QbwSszOiSHsCpP9C/v6RlZctxalBj09R5iQ=;
        b=wZfGi50DwvVV7erG7yhjNXAhWZOv/1OSO3ZC2SoqCzZC8WyAL7D/mjTCqbarEzdV/4
         0Wd3rqhjJyYCnW5VfkEXlr8eT8rUECLW9ZihcRxV/63oTNKAQ4fmhiu3Wq1vI9QPIzVs
         hrNngkbn1758In6KyGbb6nLfBMbehm9Bnmlzjx8O4wFSa6KLKsx8be+Y87E4LQg/4qkH
         D88u/ivWZL3M4HhvlcMn84SgH1BYr9i0e94L0PyCctwECChz9UG1V6RlAe/NhTIgQl+J
         K4UAWLnTqHEh2O4aczMCU1UySDWI1VUMo8Z7ftYYC3o+R93U9/4tMf58AvURLsmBjB6S
         gE1w==
X-Gm-Message-State: AFq9FYKlYtGpckJyW63jg2VUXwZZTVwTfuoz9v81rgiPEuJ89wiJt2Eg
	Lye34BL5sduRsMU/NEoOPP7hUEmhl+nMerHw4iWls47eDez8WP3NUX+5rBAcEQ==
X-Gm-Gg: AYBFou16fsMZOOujjvyR0p3ZvOg1ZK5Ou+sDswBz8gVUfnErn18pY2ePJosEuldVZI5
	5gte9NsXUej6AKRaomINDCJV0wAN6G0Vkl3W7sDiBuCCgl/zpQ3qSL/0oJL828F8tR/gJ2gl/ER
	IU5YxpWqxrJknoFkfNmG1WeAMANhSQgek2t36D7o5nMQbGmQsfdI6NFc3EKsw5snL2NX023WqZc
	FIwl/boUhVNFPkR1cONRiblLKh5qbnvY3pFvYCOfFt2tU6CFVMPPRGI309bX6WFe+DLcbG692j7
	DJiV2fTUueJk9G2MpDgIgRV9w1p7pyI0XaT4aHawnGIhkTwqhbfWQrTDkU+pOrFp7kDnSYR4uGk
	l4ZxNpLXBRX10IJMmAK4QzJVvwoD+GXULyt7xfY9a/pNSfO1uGEn6SkzvW57llfINht50zMd0K9
	yNsKSgyaMVooth1aj5DQxhTDlDkvAUY2/z2qK5a81+ockJYA8oD6O7o/HUYCB1xc4IxKFZbLuhI
	aYzD6WQFfRc+nP7lk1JKstbBT5Dgng+JK1sw8qAIKuhbF5hNxgahilK5wWUNFp/NTbNnYw5T9Gu
	uFOHtPgZqofdrczj/UBLAPrSV1MqJ0mwcbTDaXVQFFsNl1ltLhkDaG1lLqYFDaFMm8hTtQboRVt
	t5zP0ZiaxIpgIQK11TZnXMbxgE/c//Bv36ivZf+oTuFAHTA==
X-Received: by 2002:a17:90b:4a52:b0:3a7:9ec3:ea0e with SMTP id 98e67ed59e1d1-3adeb5a58e3mr3156457a91.22.1792983843844;
        Sun, 25 Oct 2026 20:04:03 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebadfa82sm6359292a91.8.2026.10.25.20.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:04:03 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 44/81] bpf: Mask the count of a 32-bit shift in scalar evolution
Date: Mon, 26 Oct 2026 02:59:05 +0000
Message-ID: <20261026025943.404450-45-alexei.starovoitov@gmail.com>
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

Scalar evolution describes 'w1 >>= w2' as (zext32 (>> r1 r2)). The cpu does
something different: a 32-bit shift uses only the low 5 bits of the count.

  w2    the cpu shifts by    the expression shows
  --    -----------------    --------------------
   1     1                    1
  32     0                   32
  33     1                   33

No rule examines the count of a shift today. Thus no prog is affected. But
the first rule that does will calculate an incorrect number of iterations
or an incorrect range.

Describe what the cpu does: (zext32 (>> r1 (& r2 31))). Shifts by an
immediate and 64-bit shifts do not change.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/scev.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index d0ba709694db..46ccce4ab130 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -731,6 +731,14 @@ static int transfer(struct bpf_verifier_env *env, struct env *e, int idx)
 			else
 				goto mark_dst_unknown;
 
+			/*
+			 * The cpu takes the low 5 bits of the count: 'w1 >>= w2' with 32 in w2
+			 * shifts by 0. It must not look like 'r1 >>= 32'.
+			 */
+			if (class == BPF_ALU && x_or_k == BPF_X &&
+			    (op == BPF_LSH || op == BPF_RSH || op == BPF_ARSH))
+				id = expr2(scev, BPF_AND, id, imm_expr(scev, 31));
+
 			id = expr2(scev, op, reg2expr[dst], id);
 
 			if (class == BPF_ALU)
-- 
2.55.0

