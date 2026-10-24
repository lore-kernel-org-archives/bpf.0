Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792800252;
	b=Vixdd0Jb+l/38Aq6vg1mpPFF04dg38eVvuvh05EmxbNLX7edFqStOE62NRabzyQUbvTl
	 2NXrAxieBaFCocxfmr31OBriscMSNUuAU+MaZrDfVtW0DzaSB1ulJ/iq1u/Uahybzcb6s
	 /iCETm8R+tOJnhceibF0kjgZmFCIv4hvcTA49nHqCrm/g7rZFFsY8WTCCEv0svu13jbC9
	 FQPizNes65sjwRswu/wA/9PWJBW9NZxTdjotxGO41wvbrGin36jZyRA1Zp7P6BukbRxhG
	 LTnjxtaF+pqVt5F8XMNOo6/GKH+l2axoLYkYsUrB8l6jJb8Syn/GkCsv7W3dVzL0OSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792800252;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=BN3DXWA+R50v9nawNHUN+/FxFUGm5F6PajH6R7DV3ZA=;
	b=FcaA2g4IXDf5J4weB7Eip8+ayStnXkdF39Ejy3OhHYn8sXy6OSVAsfwWX41IjI+xzoU2
	 465NUoMZiC0nCy7ye6g1baeYgIizWGxVnjAOBfSJmRqDfzd8+X/NmC8Vfo770E1RgNhii
	 BbBoSmnMJ/6QL85hQYtXJjAz4LKMd/7uCo4/6nup/Rw3KHQGCGmoYWlNw/xrrwJKpq8I1
	 Laq4R6V3XxTMLnODgYi6jyHUBAEmYKupUQTSgZcxRLMzeZ/5HSOWCcZTdm/nkdct/DgS2
	 g071Y9q6zfWltG38RWehvgoikCXrUSoH4mn8yO33dIn5rFwJqIEG7W0t8c1OwTGFnCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OpICM0qu;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468D6606A320
	for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 00:04:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 468D6606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OpICM0qu
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e9d1114320so10275305ad.3
        for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 17:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792800251; x=1793405051; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BN3DXWA+R50v9nawNHUN+/FxFUGm5F6PajH6R7DV3ZA=;
        b=OpICM0quiu2SNqzwyRe/f+JvXOQAREeB3X+LzZL0ffU6Pt8b7JLcOUNZv0eisdFZZF
         h3zky0iP3F2PfgIGcrLxGRFVhdttNrA7iAvDHVkBo/EEyYR4DZQmukhT/QGeG9Re3INY
         emHalzGc/IUX6dna9SuP76b0q5ga6vN7dqwslrE3qFIcCcPmc/QZUeQBenW++OhoN+HJ
         5b7dVhOTl+uyZPbcuyoEX35mH2WsV7k+sngmpLXPe9TT0i7wQj6yo+3AFDEHQRE12tIP
         +6PMDbSaTqwr22HucJ6iyDQfHVYSeAUWsmWRD/MWGL4ACy+W2obtKV1w/KGtRDXdFV0i
         oCsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792800251; x=1793405051;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BN3DXWA+R50v9nawNHUN+/FxFUGm5F6PajH6R7DV3ZA=;
        b=xoSxmWVZLyHaeNTGqwNHaIy8aN3pCxqDrotvyO1Ywq+TIxt6v4d+C0K9xEHcCMgx2O
         9kexhwvcWjdx9p+57xfpwMEbmvsmXlixk+jNnsL3gz5Hn2kzgq33T+nnwwYjsAMddnxA
         7EhVcjm3IHOJN3YkODcngj7TYhFEIqTdNA0MqwEJGXlH3GIhzqcKEu4w0soD6ztyqRm/
         rnjGUCKeZ7jXB3J5rlv7SysSnl7bFC2Wpr2ZSuTeL9hxoL5tUhIDlkCHrssa/1oUWDuJ
         Rl6GCkRGWCiG9YcNAX+DA7uvqjTwMQzohe7P8PBlzb/WjVgeBFWlEDqnOJsscD5AYo+z
         qkVg==
X-Gm-Message-State: AFq9FYIhC+r8j3tadpuyNMPoHPYo3+tlsF98hIb9fFrE+sA/5ynQWZXG
	Gmin0xEn8mPfQ5s+FVQZ/oUIUozEMTKM1JCn7ea5s3UkmBDVWSH/2Iebvn1TUnBo
X-Gm-Gg: AYBFou0bfM9elZxRVWJsQYQnig/0kwCfUEHDOfN6M3+8ZtPM+5tEivQKzlOt245o9lN
	zZKETBwmH9kPGL9eg4yshlJv6yIbiMwgao/8c6kvBHIRtBsncV1jq0gGKReSFTfhysS5DiJ09v9
	TQYOPcT3LfgWGOjk8xr6T58YvyXvTGBozQAxE1JT5x9euktNwe1eQ99EeDF8pETllmasOgKJ0WO
	mbvaaWGLYlfqr766fVc3vmDcjwJSdSq4dz4gT1U7rQ5BSmJz5pof20ViRg9Roe4eN2pZKwt/lIU
	rfooOczXoYC+BG1dUX+Xb7TOzYT5wP1gz7A6N/wBZaloFfUiwVTLSMgYVsxpFm2AYIpBlMuVED7
	UcCKZ2FTjcWvJFKzC3/tylJxjRrAfFv3uVD1F/2+z405EgJxxREIKioildl1tYF8pC4CCJVBc2n
	WIIUw32dbSKLY/ZlpPo1BLOUDun6tPzbF4saS2HLYyrSN8P0fxuVGFNRdgsSL8pFzYVSi1TX6tq
	ydbRNYONOQvcrQxzs9cn1Y1vpAAlE9KzpWkWYq3MU7zRc22NFsT5OYbZ20WeCXWaW47VikH
X-Received: by 2002:a17:90a:ec8e:b0:3ac:e9d4:5530 with SMTP id 98e67ed59e1d1-3adeae84a18mr627439a91.24.1792800251602;
        Fri, 23 Oct 2026 17:04:11 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adeba31797sm547433a91.1.2026.10.23.17.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 17:04:11 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 09/11] selftests/bpf: case reporting infinite loop w/o current_loop() changes
Date: Fri, 23 Oct 2026 17:03:51 -0700
Message-ID: <20261023-scev-simpler-clamp-v1-9-d43a07eda7af@gmail.com>
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

Add a test equivalent to the following pseudo-code:

  void scrub_slot_callee(u32 *slot)
  {
          slot[1] = 1;        /* turn the caller's spill into STACK_MISC */
          ... checkpoint on first iteration ...
  }

  int caller(void)
  {
          u32 slot[2];

          slot[0] = 1;        /* 32-bit spill */
          for (int i = 0; i < 10; i++) {
                  scrub_slot_callee(slot);
          }
          return slot[0];
  }

Verification proceeds as follows:
- First iteration: the stack slot is a spill at the call site and
  STACK_MISC at the callee's return.
- Backedge: the counter is clamped to 0..9, but the stack slot is now
  STACK_MISC, so the state does not match the header checkpoint.
- Second iteration: the stack difference prevents a match at the call
  site, but the states match exactly at the callee's return.
- The callee frame has no active loop. If current_loop() checks only
  that frame, bpf_is_state_visited() reports an infinite loop.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/progs/verifier_scev.c | 40 +++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_scev.c b/tools/testing/selftests/bpf/progs/verifier_scev.c
index 213a2b6a5027..078803e71197 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scev.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scev.c
@@ -2567,6 +2567,46 @@ __naked void no_widen_any_stack_origin(void)
 "	::: __clobber_all);
 }
 
+__naked __noinline __used static int scrub_slot_callee(void)
+{
+	asm volatile ("					\
+	*(u32 *)(r1 + 4) = 1;				\
+	call %[bpf_get_prandom_u32];			\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * The callee turns the caller's fp-8 into misc, so the states at the call site
+ * differ between the first and the second iteration, while the states inside
+ * the callee are identical. Verification fails with an infinite loop error if
+ * states.c:current_loop() does not search upper frames for active loops.
+ */
+SEC("socket")
+__success
+__log_level(2)
+__flag(BPF_F_TEST_STATE_FREQ)
+__msg("loop header at 3, widening r6 to 0..9 step 1")
+__msg("loop header at 3, clamping r6 to 0..9 step 1")
+__msg("12: safe")
+__naked void clamp_callee_state_pruning(void)
+{
+	asm volatile ("					\
+	w1 = 1;						\
+	*(u32 *)(r10 - 8) = r1;				\
+	r6 = 0;						\
+1:	r1 = r10;					\
+	r1 += -8;					\
+	call scrub_slot_callee;				\
+	r6 += 1;					\
+	if r6 < 10 goto 1b;				\
+	r0 = *(u32 *)(r10 - 8);				\
+	exit;						\
+"	::: __clobber_all);
+}
+
 /*
  * r7 starts as 1 + 6*k and invariant r8 as 1 + 9*k (0 <= k <= 3).
  * The (any r7 r8) union must preserve base 1 and step gcd(6, 9) = 3.

-- 
2.53.0
