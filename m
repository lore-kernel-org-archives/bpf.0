Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795662233;
	b=P9oNwScOHZx8GNAhh24/Nxab8fyL/TE8TaY5trP0H0G1b5l1oDU1JIm8SiW+Rfdq6ppq
	 4vSiEurzKw8kUYJQIHMQWqUjpqDQFQTJAyY+qZV/QIdfThBIYrjJSWeImlqNhorXtYjLH
	 mmiKuqZO9t6GbP1dSDM8SenPQyddDaPhGP72Bt41glaXShLt3fgo1pXa+JOn7NrShGUXV
	 s4tuoZrSSQ1jK6T37VBi7B9Jp0OolEyuK5u4PL7til/cURiFprNA6cYK7LiPa4L0lEsNu
	 HsMbhcXb9K8XJz0bn2adAgzOQFe3/ZMbUawXy05HIp10NcZUPGMhv4VzmJj908kATKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795662233;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=IJS5dZHgggJckSd6D5qTmvPhR16ImC6Fppgpao1IOCw=;
	b=fePnI8B5Napqe9YO56VhoPUdyEDObQccrn+I/3ZvqIY4tF1gxXj/jAKFOTfyrCxjhas5
	 wUiJ91/AdCW6Pu6g/Qa7zYzdEO0f/nFqrpuASRd1iqAWnrdS/fo4W25qH99d8J0JpqdyM
	 lkm1ZD48jHrWujndWCTTQrwwcn/LXtjwoC0tYHk9Ln3+Drt7CFNfIaqxcSIu7CrWODw3d
	 phK+XUCBe5IF9OkJrEdTgeiOmUEmxfCycvCHb8blQ72Yj1Y3Vf2lfZM0dm+sHxTzdEZJe
	 1FRRLsOEFBYJ0vlSC7ebXA7NpjgYMpfkG3Nq2szUj4W0QAHjNqsSfejB2d+l00FfWKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="u/zyXzXB";
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FDF606A31E
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 03:03:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40FDF606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u/zyXzXB
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3b44bdcea8aso3681649a91.1
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 19:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795662232; x=1796267032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IJS5dZHgggJckSd6D5qTmvPhR16ImC6Fppgpao1IOCw=;
        b=u/zyXzXBGBHS6Qen47g5hjH7/QnGwQ543Lpwo01NQnhCKhHtZLaPVlb3wM+OBlbtDC
         FJg45xmzxNzCblkg0skcGYumwhg3NKOPgc7GbYvMk5wgGNFj+rqxjzpjIX384D05UOWz
         u4Xt0dm7uJEMGm6G7TTs8j/OPJzie/D4apXrvf5hG9wwLZc3vxwRiWAz+J6+TMo6IbO6
         nII5kjc6brdvcxU6kAd7WChTgIax1dqNOvAdHfUBF9mZ0SeJeBjaJlVhn2qWI7p68wPw
         VdFi9tLmk+VbbPf5gMp+QuBhGJo7qFumX4CMq+FO0L2wjeLbii81RLfO5tRhSsBgmPJi
         YiBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795662232; x=1796267032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IJS5dZHgggJckSd6D5qTmvPhR16ImC6Fppgpao1IOCw=;
        b=LnmrVFNeq8czEvQaM8pS7UmuDKjFSVQuwddG2LvrClY62qDzdCo1/sDxgMum1fvP7I
         t/+HfZ8udRNDoWzEoXtxAJFyudngUBhtdueXsP8/NXUgSyDFiOiUuMetK/IexkPULzIh
         PssbWzvBqLmRjEmoC64tn3WY2/QWBW8zqWCDCrv1Q4At3N420N16gQG3PMdc0Kr8a+2y
         kGgzfYYH21hpfRX2ULj8bce5qYtxLtajGoOovHm1bWk6yGtWvSMPJij1AtodcvBMNn1X
         ii74M4jL1JDxQku1S7PcVSiuxA0xGeie9oKqf9uGhthIZib/HrqLK2SegV3LgTiAuK7f
         yGNA==
X-Gm-Message-State: APuU4Z/0h4+up/RDbO0wO+/NnjDSumlalsAv4Mgf/sznPuPPePTmHGPb
	sltnA2setyMXZrfXq4HVTCk81NnupIWoHkiN7Aoqxpa0Qc04/38iHwq6ZsXvrA==
X-Gm-Gg: AZFdTZcJXzDFqR0H8v8o7FiRqVE4Kj9A5rlDkrGadPKTL3mEYjwZPN+KC2PkO+JZJTh
	6YgS0zfLleRDLiztQjTd4BFXlgla/DU2H4YtIbKnsc4HVGy7WMXMpSUAL3SlbiWr3N1LWPb5NWn
	cN+RJkHKWcODYeiWI2V7DbgWO3BCZA8KNs+cAvyu4fP56cmzBdut5Hh2EGmDJFOmZ0+j2S+9xhr
	naZNBLh1LfnHdLXKIMzaH7nJ7caNp0mtD3PgffiKMlIRjvGPVGiJJDBePhZ1I2U5YZYQuKfCYuc
	plfP4zZ5Ek5oEc3S7kT6xagFE7wolFgBiRxJtgq0TSfnzWsKD9fVXdftKaTuZQ1GPqPsIy5YZdM
	RYBHro1nkiWuGG5DEaoxrDiUNS4i56NjX4flmHNYo+h2+qSCrvU2aMcRzL5HulD9Dahpfruw8Np
	TffiQk/vfH8OB5sQmzT4u/H6+qRlKfL4wSt7VWUofOzFDBx3Z79C882Iv7QJPL+5YMTDlWjpicE
	UgQyk/jo6L4wmhQlhKTjQlLO9u8ZVdIokaGJOAhqv8Oz7++iANLN7l7nnwVclOdzTK7F8vHD5WJ
	OB567zjNvfgAHGKVGOmIPQWwny5J/Hmwyiy6Eh0B4/JsMFLWdKnVtrJQSIQlrfh50KMxXdotCZF
	NWMF+FyxiwjzyRTQWOiiT6pKyM4cM1KiL2rdxYi1JlBZQy2Z0pJsk9qcpRbu95vyI5mASMEtyIw
	==
X-Received: by 2002:a17:90b:3d92:b0:3ad:7f4d:2839 with SMTP id 98e67ed59e1d1-3b41c8e0602mr11549075a91.14.1795662232270;
        Wed, 25 Nov 2026 19:03:52 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b703530sm13014653a91.1.2026.11.25.19.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 19:03:51 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 1/4] bpf: Count outgoing stack arguments in the combined stack size
Date: Thu, 26 Nov 2026 03:03:39 +0000
Message-ID: <20261126030342.4013902-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261126030342.4013902-1-alexei.starovoitov@gmail.com>
References: <20261126030342.4013902-1-alexei.starovoitov@gmail.com>
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

The JIT puts the outgoing stack arguments of a function in its frame on
the kernel stack, up to 19 slots. The combined stack size does not have
them, so many frames with many slots overflow the kernel stack:

  BUG: TASK stack guard page was hit at ffffc900005e7f98

Count them. Also for a function with a private stack: arm64 keeps the
arguments on the kernel stack.

A program that is at the limit and passes more than 5 arguments can be
rejected. One selftest expects the new depth.

Fixes: 0f6bd5e7a804 ("bpf: Support stack arguments for bpf functions")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c                                      | 6 +++---
 tools/testing/selftests/bpf/progs/verifier_private_stack.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e7013ed8cadd..f41f0998f9cd 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5712,10 +5712,11 @@ struct bpf_subprog_call_depth_info {
 static int subprog_stack_size(struct bpf_verifier_env *env, int s)
 {
 	struct bpf_subprog_info *sub = &env->subprog_info[s];
+	int args = (sub->stack_arg_cnt - bpf_in_stack_arg_cnt(sub)) * BPF_REG_SIZE;
 
 	if (sub->priv_stack_mode == PRIV_STACK_ADAPTIVE)
-		return 0;
-	return round_up_stack_depth(env, sub->stack_depth);
+		return args;
+	return round_up_stack_depth(env, sub->stack_depth + args);
 }
 
 static void max_call_depth(struct bpf_subprog_call_depth_info *to,
@@ -5912,7 +5913,6 @@ static int check_call_depth(struct bpf_verifier_env *env, struct bpf_call_graph
 					s, depth);
 				goto out;
 			}
-			continue;
 		}
 		depth = dinfo[s].depth + subprog_stack_size(env, s);
 		if (depth > env->max_stack_depth)
diff --git a/tools/testing/selftests/bpf/progs/verifier_private_stack.c b/tools/testing/selftests/bpf/progs/verifier_private_stack.c
index 41bd0ec54edf..ed2a40475125 100644
--- a/tools/testing/selftests/bpf/progs/verifier_private_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_private_stack.c
@@ -100,7 +100,7 @@ __description("No private stack, stack arguments")
 __success
 __load_if_JITed()
 __arch_x86_64
-__log_level(4) __msg("stack depth max 128")
+__log_level(4) __msg("stack depth max 144")
 __naked void no_private_stack_stack_args(void)
 {
 	asm volatile ("			\
-- 
2.55.0

