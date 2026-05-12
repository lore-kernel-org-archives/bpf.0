Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B98385D74
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 17:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778606349; cv=none; b=cz1hxq/1tYxS8+X1RvJT/LvDo4FUc+OPgQzNZZBJxKDrFsemFIdMt0AzIkugWYRMyDCX0Jmu6shiVo59z3lFGY/HmHc7LRf906XLoHAxnBLGf2hr2ha+h9kOJvGv8BKS4UJu6+bo5tx/QzrN5NIqsWfhC4HdZMKdhSxgxy70XqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778606349; c=relaxed/simple;
	bh=dXVDAYGsucfEXwrdHxgsVdIufOMBOC2UB5kSN+82I0M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ufg34cIvinydZLVJ48VK83J4cmS2EOCBziOsgOFnxMa8zhGGhyMRBdGJnFFArfXtsAyfegVRvZCqq2/uSiEhutWHAavfZ361VRhADBJCYtoRZsayXSZJN5CFvs9KaDy7XZNhPziaSmDKcO2h4NUdVlFbA30QqQwuUDoK0c+2nfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h/5a8oE8; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/5a8oE8"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488ba840146so52310375e9.1
        for <bpf@vger.kernel.org>; Tue, 12 May 2026 10:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778606346; x=1779211146; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wyz5LQ575B6z8WxZCgwOuLT8wcJ2qOnL7lezKWepPVw=;
        b=h/5a8oE8rjkYLTPMXEN2Mr6jZiF6ZEtyroVoIXigV+H5iZt/1ejHocPK0UFxfHvtEC
         VtYMHc6ZoWV0xjiNIKB+8SYNaTTwKfo8zm8uVgqJ6GU7FxVHUcWwZGaG6/Yu3mmveBAf
         K3RXgJ+HPGwtFUTGuyaCNTs28iNtw3IG4PXk8oZWAXKEDlTxE2Z/cFZC5RruFXu57OqB
         5sm/ZS8bJeYn6rx0obmyghokVakAcukZhndqB7kOuuvoqkSygCnnP36UYxlMd4xTsdJk
         VEbwVo4O9AuZCxdSl/aBF6/778m/1Jg1h3jO2M8jqBMSR6pQwivpokaV0uiKOwQKhU4n
         vokQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778606346; x=1779211146;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wyz5LQ575B6z8WxZCgwOuLT8wcJ2qOnL7lezKWepPVw=;
        b=WgnLnqv/eHhRHVVr5NDmAxKIuL4gz9D5ocINX/N4eMnStPtChwAivD3hiMMkTKOHlQ
         NN0z68WYOLjLkk8lvcYmGpsQ4LcAJNhFXNQF09ABXovAlQynQvzMAw8kc4+fyvGeN+HO
         JHQ3cdaqJuVrBLvi5FuUh0c10kO0vviC7G3JwSsztOygwG127JpzH6N4pz3OYattPIZb
         vLR4mXN9xo/2MiD4z3d0pe/dFed36xgygocK3COZFUEqhrElFgvgvYsalN4I+Bl59CY6
         taUigGEY/uzmrOqKga9ImjHeYR0VW2l6x0kgkEYwwhq/rzUIGqc+5oeJf6hytBwLQbYD
         cnAA==
X-Gm-Message-State: AOJu0Yyvh8ISIBWSORhoioI186mSIAYb5KBLQtA127KOXxQE4PYYuWos
	2oQpK4UAQwPWLyOooSKcSyPbZIaJ51srM64iPUwbvMnoEcmZBNbPBHTqa9T5E9gV
X-Gm-Gg: Acq92OGgHOzYaF98K+bzEwFdedkGH1e4jHlbMYVL40iKIW07PzQrWxA5GsOfLWJSlMj
	TXvC85lP3YihzCMHWb+OevRg3GvYXirkKVR0vYUW7jgMYDgVF3VWaXF3Tf5fH5RV2T7fi+vG6Nt
	hyRuErkGs2lfhYYtt0XSJbG7dgvaEgAR1MlxdH2syDBr4T+5TOOWUcE0hs8robv6TIiv0Bdn59H
	Dis2cjH737px6QUICOWTqJSf3iuPjGal7FNU/EI8xfZrmUPoWTZKHOxSxDGeEBFQE4kWuC1WFXy
	l1UkWWhRMzrkA63KB66AeMchtMTFnVKCB6N66dNTmxzVOksfItOtkW/6RA4XlaZdA8cc6ztdnQM
	ufxare/O0AnVH3nUWIX9z6O7Ilz07NPhOmDPbfQpJO06ckfK+DJ99L+79+JeR0SQ979ref2nq+R
	ed4kqviDtaVPFaOzdPDfF/CiqXV/KLnOEcLyLltuirZ+E0L7Zcxo7t1ryixXnWQPYoFnK4XDuA5
	D6nj20W6k3sGjyasOBHvS0adKSgOB+6GykGEjWrkvBMpRBQgeH6aEIJKaZaB75bKbv8wXn8nWUS
	2gQNu1VUNZDNrttUti4HoMvG0wUq1Nqu4rPDOH0yu7U=
X-Received: by 2002:a05:600c:6211:b0:485:ae14:8191 with SMTP id 5b1f17b1804b1-48e8fe4b318mr63820705e9.5.1778606345905;
        Tue, 12 May 2026 10:19:05 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00850765ba98b5d107.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:8507:65ba:98b5:d107])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45491cab9c2sm35971463f8f.31.2026.05.12.10.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 10:19:05 -0700 (PDT)
Date: Tue, 12 May 2026 19:19:03 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH bpf-next 1/2] bpf: Report maximum combined stack depth
Message-ID: <05f82d1180b68e856bb0cc03a5cd86305f5b7669.1778604369.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

We've hit the 512 bytes limit on stack depth a few times in Cilium
recently. As a result, we started reporting in CI our current maximum
stack depth across all configurations for each BPF program.

Unfortunately, that is not trivial to compute in userspace. The
verifier reports the stack depths of individual subprogs at the end of
the logs. However the maximum combined stack depth also depends on the
callgraph of those subprogs (the max combined stack depth is the height
of the callgraph weighted by per-subprog stack depths). We can compute
a callgraph in userspace from the loaded instructions, but it often
doesn't match the verifier's own callgraph because of dead code
elimination. Our current approach relies on dumping the BPF_LOG_LEVEL2
logs, but this feels overkill considering the verifier already has the
information we need.

The patch lets the verifier dump the maximum combined stack depth in
the logs, on the same line as the per-subprog stack depths:

    stack depth 16+256 max 272

The per-subprog stack depths and the new max stack depth are not
directly comparable. The former is sometimes updated during fixups,
while the latter is not. As a result, even with a single subprog, we
may end up with two slightly different values. The aim of the new max
value is to be closest to what is actually enforced by the verifier.

Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 include/linux/bpf_verifier.h | 2 ++
 kernel/bpf/verifier.c        | 6 +++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 976e2b2f40e8..d91843994c82 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -936,6 +936,8 @@ struct bpf_verifier_env {
 	u32 prev_insn_processed, insn_processed;
 	/* number of jmps, calls, exits analyzed so far */
 	u32 prev_jmps_processed, jmps_processed;
+	/* maximum combined stack depth */
+	u32 max_stack_depth;
 	/* total verification time */
 	u64 verification_time;
 	/* maximum number of verifier states kept in 'branching' instructions */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 11054ad89c14..896dbb4515d7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5045,6 +5045,8 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 		}
 	} else {
 		depth += subprog_depth;
+		if (depth > env->max_stack_depth)
+			env->max_stack_depth = depth;
 		if (depth > MAX_BPF_STACK) {
 			total = 0;
 			for (tmp = idx; tmp >= 0; tmp = dinfo[tmp].caller)
@@ -5185,6 +5187,8 @@ static int check_max_stack_depth(struct bpf_verifier_env *env)
 	if (priv_stack_mode == PRIV_STACK_UNKNOWN)
 		priv_stack_mode = bpf_enable_priv_stack(env->prog);
 
+	env->max_stack_depth = env->subprog_info[0].stack_depth;
+
 	/* All async_cb subprogs use normal kernel stack. If a particular
 	 * subprog appears in both main prog and async_cb subtree, that
 	 * subprog will use normal kernel stack to avoid potential nesting.
@@ -18289,7 +18293,7 @@ static void print_verification_stats(struct bpf_verifier_env *env)
 		verbose(env, "stack depth %d", env->subprog_info[0].stack_depth);
 		for (i = 1; i < subprog_cnt; i++)
 			verbose(env, "+%d", env->subprog_info[i].stack_depth);
-		verbose(env, "\n");
+		verbose(env, " max %d\n", env->max_stack_depth);
 		verbose(env, "insns processed %d", env->subprog_info[0].insn_processed);
 		for (i = 1; i < subprog_cnt; i++)
 			if (bpf_subprog_is_global(env, i))
-- 
2.43.0

