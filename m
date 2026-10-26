Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793057928;
	b=hcoWlZJjklsIc1NmP/sPGuOnzTPglmFEzoTh5q4mv2CiDerL23BL8Zl8TaaxU9H1101Z
	 mhND8agsH586C+blbUvtDX5zD1PzrlB+Tgq6rOPXmxhINWDapQ5SsBW+BZmV/BiIjhFnp
	 gZStJmAGbTVSEW4dCGijjwD1Y1avwGEE/+P1w6m5K5Uec3/yHcqJ4XSMX+KaueiLirMkW
	 Kkt/bP4VYaLXNJ4seiX2yBGTSJ9MSNKh5WQ1xFugNCYNv/hxmzul8dT70IJ/G4Ibev1Gv
	 UMxfGhhKrKzZNKBrm5Lf7AiKuxGYJQMrdUTeukijFGQynDQLRT4n8t7aDS9VpqwGI8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793057928;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=HUYs9TkN0DW2uhSOO4PgK5cssD8wCCqyUg4gkncWvi0=;
	b=BltuoR6G1USTED1fBzhGgdLwdEWPMc7K4hfyJrx48TdLxXBWxS/SbUX38UQKfYQrHiWU
	 XS1TM7WF8RclPY9CbzE1ZANnfXG6aFu3t67lNSCaQ0qryaSc1xqqVo4kNiUlskR/thS71
	 aHnnRdp85HPYPcZYWaZ/isq5tw2IOVR4RBEiz/TqLWn78etuLchITledzipeUq6Ixy+5R
	 nVM/3RTOx4oMusv/AJ4OrCy8c2Be6nzvp8OFcxuAOGdGgM4swXwAFCIUs+XTWKXCPyQF1
	 Lr0fYFQsHXgRhKioaLrwSZNiiNj2xQ54CKvaoC28DwZC0kYyzt3qh4v2j1bCKdZgc6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pFpJE7QK;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422B2606A31F
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 23:38:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 422B2606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pFpJE7QK
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3ae25008e2aso655816a91.2
        for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 16:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793057927; x=1793662727; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HUYs9TkN0DW2uhSOO4PgK5cssD8wCCqyUg4gkncWvi0=;
        b=pFpJE7QKBxV2fdAbQPSvW6kphvgNmsFtP4+XkmcpZ749mIA2ED9MnzJvMshiQ5ZZlu
         V7EFoZEc/GgbSVygrMfAZVQgvLtDaVJ7vQMAwV6NoHQAYoAv89HDJpCN3ksI6BY5PBnz
         tjtC8rLGKW/EXJcmFgRcGMegtX81Iu0Ci+XL/LthuVC6WwDLCNAYgE4zKzYVHiyyxyEd
         Eys2e88y0yzLIE6Jy6s8BNKQmZVkfBrYbItYHGmAx3aPZqjteD14Ll/PgDbTVl9fX33h
         ITCwmfwukj3XNx1jNKQSnTitgUr2FH6E8vSjQ5Ho1EJNFOByic5ty6c4H/f/tHvnllo6
         2fuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793057927; x=1793662727;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HUYs9TkN0DW2uhSOO4PgK5cssD8wCCqyUg4gkncWvi0=;
        b=BdreddBQL0G6smo1y91JCcBHQYpv8Gx7VbmrZEXiN6yh4pRgwmttS4ImMDR5pus5xy
         uq++sujFW7SbsjEfGOLtnhkphC9P9HvcVfXy74Uip+bW8/1i0O6RSvvaxQ5MavP8RuX4
         hvQuPnD7dy8PBpKFi1kgD8nY2Oa+UJfnYbfDRsD9F9tOacnwMtXnpAL3+3FJV+oxS6VM
         pBJ7NsO9vZzO6uP4L9UFoL8AZibuj/ZyKtkEnW84xm94gfWMlE2pL0rhqYaXcwxJCrvV
         JXJEuPhxHnWh8ESVglAF/E3H7UIv8rHqdyE+2MNJ6IDuVmoLn89Mr8rykwT4MbAergC/
         RutA==
X-Gm-Message-State: AFq9FYIgbQJyfOfGBoevKVmmKUY9VMF2K8fEvJQ/ZSd+3mqH7OHlyBk6
	bhhvdMQFQFaRiceFzc0NEWqD6nd3CerIfLHUkhm0y7R5X1AuEWUF+j1p4EGn/A==
X-Gm-Gg: AYBFou2ISb1FUacpo5oWSaUEFfapzOUomP+HcykFIayJq6w0cZBpHwQLMAU2UfV81+M
	Nhvx0Ne//cVmYMxUsl5OTKhJQofMCNa58PaKRRl/B9QA+hJA4LsN/MsULuHrgKexYBl2uop5tgc
	rrY5KLJRFccoeuTQh5FugQncLSyEnQF515zYPjF/ApsaLJZxgSFLp4f2u9UCAoAVR+OnDcoL74K
	CzSRXHo7z0GKY8ToU3S6jmv/1s0qcXe/LjSdnn+UoqWlprxkawcmigLjyrMbM4LY4tHtr3Teq+S
	RrptVxie6A9ublzGHRX2DOO3ac0MpvcgXdX72WmEBjSv6e6R8avN+mZDnISrxBokmcCJGD1o7cN
	hR8WruuirR91I/q1+38tyiYAvOpANgw9f79xpL1eHZvh8pNHY5b7iM01v+usiph7ajhlkS2+Z2R
	OCRWYpq5Cps+0w9Adogr+Iho9GMFLzrE7qTPKI9mziLH19qda4P9UrL2j6m5tvbJlTDp8FNH+em
	ybI39m+MDNk9w0Bu8wWabjagpvB/Q+cxeZgahHyOPVbl04r9JwKDsVioh+97ISTcBTS2JP1hc7D
	Ni5tLzM+pnaXTRYUTvZ2T6bt3TijDotW+7Q2l12JTYTz
X-Received: by 2002:a17:90b:4a4f:b0:3ad:6781:da66 with SMTP id 98e67ed59e1d1-3adea9d9ecfmr6645526a91.23.1793057927634;
        Mon, 26 Oct 2026 16:38:47 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae40455eb5sm1167437a91.12.2026.10.26.16.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 16:38:47 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf v2 08/11] selftests/bpf: cases with empty range error under old clamping logic
Date: Mon, 26 Oct 2026 16:38:28 -0700
Message-ID: <20261026-scev-simpler-clamp-v2-8-f373aec9825f@gmail.com>
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
index 805157cfea78..4e58dd475b88 100644
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
2.56.0
