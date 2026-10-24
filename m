Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792800251;
	b=dsGP1eriyC4iIvxJkDuaGlrREOiXkoXdwCUfYrtE4NozIBVzatG9WiHcYKiJ5Y5dSdyc
	 OvbWEK+yJVcyKYll2uan5fOSrQVzRDeRRWy0Ejca8DXoBkVq6uT17YzSQnYlyYEpBXL3w
	 zuLWics8JLcKbproQ3/k2uyF1rTSiIzw8tHwQbP+oc8AW2SjXJyVhhDewGtk0T4HVTG6J
	 U74ANB9T6Ou9+XzVjP1yj6D2BEvOFMsRPd5fXwUGCT57ta5oXuy9ZP2Jw67yzX8pXWd6E
	 67TTiF505IrzTis9Z6Fv6Xf+80vloyE76ZXmA+aeieqCeg009MJQnShjIc2qAFenUAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792800251;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=KTVHMFSwEKuWw3MJs5ksmNuTyAAfTU8X+WcuPWpnZfk=;
	b=e++2iJH/S13/S4eRL0rcT1KIMyAwfAuVNfj062/n71MxZdDhg2Na+iHsGs5sDuG0LfTy
	 2GKeGsTdXRZ7Vi1rpai+sfMC6+0T0mgDzABrdZnHTKO1wiJqly6H+cjRZsuSJP0gEHkNl
	 aA++M1BT5hiiZAjTP1zqvX0Iaapjtw3e/7//EeiQJGcANnuYQ6VjC4wPh71dfI77bVVNw
	 rzYKhqhdrhH3g5oUZnTS6M7fso9TNS+Y0VELmKzaW5DgIlv1UQP9TschVvsDbK6KCvmiG
	 fkh1LgqXKroB/gSNF+Q5PDptSHzv50FfVyexhy0ZK6A74t+cx7VvLWlkCN2Gqzh292Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YFxQJezH;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FEF606A31D
	for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 00:04:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89FEF606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YFxQJezH
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3ace9e6e1a5so1357820a91.0
        for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 17:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792800251; x=1793405051; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KTVHMFSwEKuWw3MJs5ksmNuTyAAfTU8X+WcuPWpnZfk=;
        b=YFxQJezHPrVc5hVgJFzpkvPZOlePLqe2RXc7VmzsmyMbUTiJfvy5mi6cFVjwlgF9cl
         wgCfLw/3iyZfzh2pjxoxIZhmTKvKClOGSCJiG6BSNcIq1Cl2Vs/Y4FG2VQM8g1uRlvox
         ILyt46A7zL6vAJCc1A4j0wgK2QV8V+7L9wO7m/oS0Zvgdkqq9Ezi2ILr4vReulvgJqT6
         WvxCOdoKx5yUUcEeQV3I8gPwfgm4NTugfCDHNHG5Ll7GJLpgpkv0D1jHRthSq/Yk8xn7
         GdA+aoDpxALBNpermh3+nML0bxgMj71lyf/YKO6P9kPRl3bq7nnsu74RK+kFzR3+VyM1
         9Okg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792800251; x=1793405051;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KTVHMFSwEKuWw3MJs5ksmNuTyAAfTU8X+WcuPWpnZfk=;
        b=JOBVTFC/MYQWakc2e/6d2me0dp4B6rxnbvkLjFbymRvkR4QhHqtX9q/04KzR0HGI1D
         1a2aVtnzxtK0O/pWqGsXtTfjNNaZPL/aYv4NAcoxQnT0DPmlDnVQFVz6dt1JFhTNWfLZ
         L1UPs4i6Mw7SG+erykZPfwB/CbiQBn7wUoHX12YqyhweJc8w7JquOu0/nzZB5s4/WzdC
         hPrFJhISSiGDpBhFZFF44Ewqrp1B0vn1o+Zn+lebLKhoLSwON4hzkKYU+DX8cUzoWHPQ
         xPbgCyTWQkZOUzwV/Wtm0dB73ikvsaGMAroxxJI5+yKtc4km4uU3iNoyierDstdaqsM3
         U/Og==
X-Gm-Message-State: AFq9FYK328faGXGGnPx0/VHkLcxCC+D/FqhhsVqavVvEnqvD86H6NtwS
	Fi1Y4ttaR1MgJzwYvl2FywUKZz+iE7mMAkDElV8BOa8nm3s33asRwMU08HmZcg==
X-Gm-Gg: AYBFou3FyHXzrUJoSEaLtro65NkdHiqQYeOYfunQ0oQNT8v39hE93GQQN+HPdsIGdfd
	pb0aaIq3TcK06itEiVYlZZvsqPVit2GvBbUE0/6g8UYRbHzRXBfIgW0lqpekNpODib8bTAqzedC
	oKZpsVC5RHnm/zjJgLLm0YcEGg5B9oH8I+pshkCQn/zrXPVQUCvB5MvCNFmatHdoiFJF1wfdhG1
	z20+AIpnESnWxDTYNTDRFOp10gQ/cgJpKSFQH8iGQYI8/I62CkMnBVwGfsccaE2q2rsjikF770b
	lTRpP9R7v2hbVzhuojxiO/h0EnMW0CTY0xNcTTIh87CRWMwmp0HzJMkZDyCvS6Zc+RdkA87u3ix
	oYClgii+zgyqj+3+0jNQ71d49oiFcQ6okbkwLUU8knVRIGELZY++kaNMl7x3cIqM7KYmE9dkL7q
	YgPySYqLSKnKkAKzDY5SQ6jMEXnBmLl8xUFPha+hQG3um84GhJGuehNXKcl1DWR8eR2N9p2ha7a
	BLorbWDO0M50PpiTpgooCKkOYpZk4vC0CxrVVn+qOGa//qS3EFaZu5ZUDiYa1dSdFcyaO6L
X-Received: by 2002:a17:90b:1f8f:b0:3a0:cca0:4a8c with SMTP id 98e67ed59e1d1-3adeb550f44mr389561a91.7.1792800250897;
        Fri, 23 Oct 2026 17:04:10 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adeba31797sm547433a91.1.2026.10.23.17.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 17:04:10 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 08/11] selftests/bpf: cases with empty range error under old clamping logic
Date: Fri, 23 Oct 2026 17:03:50 -0700
Message-ID: <20261023-scev-simpler-clamp-v1-8-d43a07eda7af@gmail.com>
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

A 64-bit and 32-bit examples leading to an empty register range error
when scev.c:bpf_clamp_scev_regs() intersected current register state
with computed iteration range:

        r1 = 0;           verification
        r3 = 0;               path
  loop:   r3 += 1;              | <---------.
          if r3 != 5 goto +0;   | r3 ∈ {5}  |
          r1 += 1;              |           |
          if r1 != 5 goto loop; '-----------'
        r0 = 0;
        exit;

- At header r3 ∈ {0,1,2,3,4}.
- After `if r3 != 5 goto ...` continued with r3 ∈ {5}.
- On a second iteration bpf_clamp_scev_regs() computed:

    r3 := {0,1,2,3,4} ∩ {5} = ∅

  And reported an error:

    verifier bug: scev clamp produced empty range for r3

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/progs/verifier_scev.c | 55 +++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_scev.c b/tools/testing/selftests/bpf/progs/verifier_scev.c
index 8eeb4d73da98..213a2b6a5027 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scev.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scev.c
@@ -1604,6 +1604,61 @@ __naked void post_cond_jne_neg_step(void)
 "	::: __clobber_all);
 }
 
+/*
+ * r1 and r3 are widened independently, so the r3 == 5 path reaches the back
+ * edge with r3 past the last value it takes at the header.
+ */
+SEC("socket")
+__success
+__log_level(2)
+__flag(BPF_F_TEST_STATE_FREQ)
+__msg("loop header at 2, header_count is 5 ")
+__msg("loop header at 2, widening r1 to 0..4 step 1")
+__msg("loop header at 2, widening r3 to 0..4 step 1")
+__msg("3: (55) if r3 != 0x5 goto pc+1 {{.*}}; R3=5")
+__msg("loop header at 2, clamping r3 to 0..4 step 1")
+__msg("from 6 to 2: safe")
+__naked void clamp_dependent_overshoot(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	r3 = 0;						\
+1:	r3 += 1;					\
+	if r3 != 5 goto 2f;				\
+	r2 = 0;						\
+2:	r1 += 1;					\
+	if r1 != 5 goto 1b;				\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+/* Same with a 32-bit dependent register, SCEV (zext32 (linear r3 1)) */
+SEC("socket")
+__success
+__log_level(2)
+__flag(BPF_F_TEST_STATE_FREQ)
+__msg("loop header at 2, header_count is 5 ")
+__msg("loop header at 2, widening r1 to 0..4 step 1")
+__msg("loop header at 2, widening r3 to 0..4 step 1")
+__msg("3: (56) if w3 != 0x5 goto pc+1 {{.*}}; R3=5")
+__msg("loop header at 2, clamping r3 to 0..4 step 1")
+__msg("from 6 to 2: safe")
+__naked void clamp_dependent_overshoot32(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	w3 = 0;						\
+1:	w3 += 1;					\
+	if w3 != 5 goto 2f;				\
+	r2 = 0;						\
+2:	r1 += 1;					\
+	if r1 != 5 goto 1b;				\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
 SEC("xdp")
 __success
 __log_level(2)

-- 
2.53.0
