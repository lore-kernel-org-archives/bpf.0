Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A7B37B02A
	for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 22:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787870924; cv=none; b=qgQA7+wdghOf7vwFG7iUohR9Fb7yh3yfMgfQPC1NJmtzBYLqGN3CWDVhi/EGcpsymNso0IhR4u4ZhEimC9z5Yin6CIbuDhwcLJ2Qg3GYbWF+VJGuTg/+rSWENL1nYjn+HE3h0wi5MsWv9f8+/wWH8s8ad0HLxTqRdXWeQAo2aE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787870924; c=relaxed/simple;
	bh=CjrZu0jsOrCHCLlSVibxz5e2SsNtE9ys4tqUk444mr8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rqcCorgR9uis0AugKsNc8E2WTduE8rce/DL6otL7SIsmawuGNix/xlT9CFioTHcl6dR08tZ4PxfAcy/GPT/W5rk+g47CWnRNQ5sdKQ7RHbn8/0FUw8H8M2mRuBj0Sn2QACDYBXc+GJ9czxkcxur8tzVg2Wn8SWByy87VRziCvTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UKOOeog/; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKOOeog/"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-ca80d708489so237675a12.1
        for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 15:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787870923; x=1788475723; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MbudqUO3CFsHR7tDvtHcNVt6/7GtacfGbRMK2uBgFUw=;
        b=UKOOeog/mpIc+LQZ36pGlgQFo68MhMy+6YCz/nQSjCqSmoC4kf7CCw1z8uQveaW0p8
         G8a8EBEuabgnX3nq5sGipibe04yXyFhK8j+4obKUi1eHhywRaMIGUGMYIRZpGuEGKSqm
         ocw2xWKaD8lihEt4lFeDm6nkk5ihrb4+4JyIf/XLIdePX7Bih454/tEzs74cDuEx+LYE
         HJ84GAb6U4SgIYiQond9q38vnJ4qXandVhk+3Pn/gGc6pZdCR3YvbHhb5H3EpTcuuKUL
         HcaJ3rJwxNmGdnAq5s8KPdqO8XKNV5IYKGYFJlAtmMRN7AScGpVbjOkay8f6K03vFNSG
         wXxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787870923; x=1788475723;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MbudqUO3CFsHR7tDvtHcNVt6/7GtacfGbRMK2uBgFUw=;
        b=BnCKnTTFmYiVujBgsFPDMXeDvXxD1kJFBHXL3kd3/BNaMI730rm8bu0cLBcDyT2B8J
         PecIG0ALB1LfPUylFK6bIE33BgigzkztGPdIiZyugNQzsn9tYlPykyAiTPfeKnOXqX/L
         /dUQ6l1toCoTYve3poFMqdrWHbsEApePWR7BshrmdH1efpfk5T88/KVFZBaWg5xW/syZ
         yHXBxKd97wiwKqerdq8gsoIIFI+OqJejVQdTVM29x4CD6dnmlGdymBbo5g5biM7eXuNZ
         Q7gIXe4SJXkc5RUUwT7D3/DCrlld2gcmcwyuF+HHm0ftlcC6GyS9bYkvreEzjbVfTZ03
         WQ2w==
X-Gm-Message-State: AFuF++m33NqO3KGRVWSyTbLKSUpAJCwZSAbBe8fMZnAz5nzj09mV84PR
	8AC+P+JjGDUhJnP+SksLfTJN0ZsVWovjVY7C2i8mZELcmpqoZAs8PvFV6yvSIuM2VZI=
X-Gm-Gg: AR+sD10iMPJlQtwl5bzHq7uFqpp1hf5lQ5N8yfq62gRhTIS0lJAaWL3Nm9efF+IpkEi
	n+hEeGeRDt/PYMJsnGV4IpiFU+TygpdSHyX2B5xhKLCbalM3G5oxnlB5/h7QBR8M+coh1Afiyo6
	01z1JIeTfeV9sBt/syRBVyjduOj/Tt1Ykd27XG8LpMN1JqtQ/+PMyomVnHw9hYpEDtbIn8vsvu1
	XygwDMdQ/WHQ4j2edVCHXrbESQYvOw//BLr+NbH1n1vOyK5ZQLj4ByT1IIeDPEXrCeW1efuCOWz
	bPBjcVttFRKGUzLXchSbdnXUCLsmJCDXYZYBwO6bul99xX1lFNkA/pdgEbMTSfrZ+excRFItQ2Z
	AulHL7a3LXisZxyk587++zZzwjdfXF1Ig7qz4AR1YvxzKPREeIASGK1K4Y+y0+rQvCZ8PS2LGau
	g0K+mw1kknyjTp12gAdbJZXaByeuw5ipoRm1xK3CKzy7ZTLNg6CPY9PKYsl+Tpsg0QREwK1i9sk
	uNbnHIIN+Njyf/PRAwZwkS9+vt09fYAmGtHq9rV9QEv
X-Received: by 2002:a05:6a20:4388:b0:3b2:8674:9830 with SMTP id adf61e73a8af0-3d0f6d2abaemr12574123637.14.1787870922754;
        Thu, 27 Aug 2026 15:48:42 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::6:e049])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3283d7303a2sm22504228eec.10.2026.08.27.15.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 15:48:42 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	npc@anthropic.com
Subject: [PATCH bpf 1/2] bpf: don't downgrade half-dead scalar zero spills to STACK_ZERO
Date: Thu, 27 Aug 2026 15:48:23 -0700
Message-ID: <20260827-bug-011-cleanfunc-stack-zero-simple-v1-v1-1-c0e996589a52@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

states.c:__clean_func_state() can downgrade scalar zero spill to
STACK_ZERO in the following case:

  *(u64 *)(r10 - 8) = 0;
  ... checkpoint ...
  r1 = *(u32 *)(r10 - 4);
  ... no reads from r10-8 ...

Here 4 bytes at r10-8 are dead and verifier changes scalar spill to a
combination: 0000pppp (p stands for poison). Such a change breaks
precision propagation chains. All places that produce STACK_ZERO
should call bpf_mark_chain_precision() for the zero source.

This patch fixes the bug in a simplest way possible:
avoids converting stack spills of zero to STACK_ZERO.
Two smarter approaches are possible:
- do bpf_mark_chain_precision() from __clean_func_state()
- check slot liveness information in check_stack_write_fixed_off()

I investigated both and the changes required are a bit tricky,
hence go with a simple fix for the time being.

Fixes: be23266b4a08 ("bpf: 4-byte precise clean_verifier_state")
Reported-by: Nicholas Carlini <npc@anthropic.com>
Suggested-by: Nicholas Carlini <npc@anthropic.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/states.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 4e6aafad33bd..66fb11b6c6a7 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -445,22 +445,19 @@ static void __clean_func_state(struct bpf_verifier_env *env,
 				struct bpf_reg_state *spill = &st->stack[i].spilled_ptr;
 
 				if (lo_live && stype == STACK_SPILL) {
-					u8 val = STACK_MISC;
-
 					if (spill->type != SCALAR_VALUE)
 						continue;
-
 					/*
-					 * 8 byte spill of scalar 0 where half slot is dead
-					 * should become STACK_ZERO in lo 4 bytes.
+					 * Can't replace with STACK_ZERO, because
+					 * that requires bpf_mark_chain_precision().
 					 */
 					if (bpf_register_is_null(spill))
-						val = STACK_ZERO;
+						continue;
 					for (j = 0; j < 4; j++) {
 						u8 *t = &st->stack[i].slot_type[j];
 
 						if (*t == STACK_SPILL)
-							*t = val;
+							*t = STACK_MISC;
 					}
 				}
 				bpf_mark_reg_not_init(env, spill);

-- 
2.55.0
