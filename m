Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CC6440630
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 23:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790292719; cv=none; b=o5IXoRkx9cINUrh3vU83sPGlSfyL7DyODsAGRdpnMzFJNjY7x6KWZrurkyUmbDyoDL0I9Z6v4LcdaxjK0N8YmLDUjWTN1+mHMRczpKztnUaWAFqxFZxhuk+39ch8rw71C4pScSBlxf+EoEG9YiTBYK4WwIHRzysjTUajFcSJCck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790292719; c=relaxed/simple;
	bh=kupDD2HI9rGcx6UK4S8E1RbeCOvbvB1pI1IeoHqN8HI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fCzVHktmbGFWZ8kNRlA9OvH4MDEjFcDXvjNJl0Ro2bvED1WIpEnOcAhXktMKPOkKrphRaU2FZ2j2zt1Jfrm9r1tw749/ZSkslFlJFAVhkCjXpW8hqyKg5iDYC3DnVpLcDZc7hrbur8eI/x886PsI2DqroZeCoYUR9m/DGWYoi3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AWN/9dqS; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWN/9dqS"
Received: by mail-pz2-f43.google.com with SMTP id 41be03b00d2f7-cc4c08393dfso190113a12.3
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 16:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790292717; x=1790897517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JJSN8s4n1/JJsNwfZbvbjsRDHAm7mWybQMaMqMsZqwQ=;
        b=AWN/9dqSLrdtTjtqTnFjSuHA6Zd8TcAp+3YYZaMjYR73ABGOnDLPLliwoqhHpFp+0K
         aZKNlSS71/XOW6HweNDhMbnF1OxUBz44FL5fGYEV1W65OcuvgM2O3G/i5JpcrR7BR2pv
         ZrSJik86of9Iuck71ZsJ4bX7CGsYzijI8eU+y0OWZefskdkDeWNkkoin0qjT+fQucijn
         S/PSDUaqmgVSa91B+8GbgJ5zHgUh2AN5SPJ3sqN0wJXWxpVr9Yno0qNEW2HnHgdA/TAD
         aOMROqtwoNDaX9CRYlXrrqig27dxD/Ei4ZxNWq7m4hOnBu5C+5Z8DEVy+NYlJy78g7sm
         R1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790292717; x=1790897517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JJSN8s4n1/JJsNwfZbvbjsRDHAm7mWybQMaMqMsZqwQ=;
        b=dJ7hLOd53V96trt0/lI6ZjhgjJjiGlAUeHC99IHADhDLZccYvNjBel1wJEu2tzzgZq
         PWk9raruPJxxe5L0wsNteMrC08FL8PUqAvGPRixQoLqkKQ1FWEsYYd44WUJCWKtt+iv0
         wU6136OWEAoK8J9I8OgwuBOHFWxod/kct4ZH0/o0x2g0njk/7hUnT07mwqN0RnMhBOo1
         uEL/LdYiXzjp1uMnEgesOIOLmaFefbds4/+8jJKGFqUC8a4fzHBEpHj5/NjaKut6ikay
         fNacSFqkogXamaqvoqEDwpjkreA6vX8y9eUDWr5MXEcRGQIQ6NjHPDBHNk1CrR2HRlZb
         eV6A==
X-Gm-Message-State: AFuF++kb+ehh5cFaRry/jtNwo/JZOtVlQkgqLp9ZOaWSRRIQGub+oMiE
	4OoZgexE1QXn8tQenrHESLGlTHkBcAYIAJaimkD+f3sQdKEDl6NYkUODgwlyNA==
X-Gm-Gg: AYBFou2hxt9T4A7sHL7R7fWvdvxfj+B5AMiNQhbZqxPtIVrZckcAlAN4iXeJL5d4E47
	KscFdpjPPsxNxeE7S1LbHAEhm0REDrdKTWXaKjZpwFsoKJD5KcTS4imkbpNQC4w24f2cWKjMENA
	InWfAgK3SoXlnwv+BUSiabI5n3trOD9vxLa+QfGLwx6HZVO6noZaxNHbwj8eWQJ1euHrwr8Cq3V
	I6cy2ZTHcBzveQd3hu/5D7I8aVax+JGpAnoUxe0H18xT4e/3aU9svbLwjQtDL4ooAPyXWKL1JmR
	CN+WpYsXH5eliFyw7BV2Tk1mC9qgl4ISDKnu7Ppo3BCuOjIQfFFYH2zoNY4+w1P04+p7ODQQIgy
	JTRGqMJ9HgABxey5XpzNK95S50K5hZWbLno1S9FAwyoEdRx16ynWpI3yatu78UC5WQBE0gnqQUr
	s2VRNtnKjMM/44XVZ+RUyLG1EfiryRxAu9icC4Gyo3wCVfaOgcSF/PL5q+viNsbsrD8e2i7CnI5
	jwW1uBH7dAKbinH7deM4oYm+b+JVRjkJUJJpl61fGh2ssmhYCq7KXCKt6KI5DOA1OHUca10bmAO
	i7qL5XMcWqOTBM7JtGha5x5+94QWPIBIFNQl/MO5HL+v
X-Received: by 2002:a17:90b:50:b0:39e:5c88:ce10 with SMTP id 98e67ed59e1d1-3a0bb443ff8mr366016a91.0.1790292717234;
        Thu, 24 Sep 2026 16:31:57 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a09773d402sm7468613a91.16.2026.09.24.16.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 16:31:56 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 7/8] bpf: Don't converge a loop on an iterator that was created anew
Date: Thu, 24 Sep 2026 23:31:29 +0000
Message-ID: <20260924233130.1213812-8-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924233130.1213812-1-alexei.starovoitov@gmail.com>
References: <20260924233130.1213812-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

When the verifier reaches bpf_iter_*_next() in a state that is equal to
a state that is still being explored it concludes that the loop
converged, since an active iterator will be drained eventually.
states_equal() matches ids through idmap, so the same is concluded for
an iterator that was destroyed and created again since the old state:

  bpf_iter_num_new(&it, 0, 10);
  loop:
          if (bpf_ktime_get_ns())
                  goto remake;
  next:
          if (!bpf_iter_num_next(&it))
                  goto out;
          goto loop;
  remake:
          bpf_iter_num_destroy(&it);
          bpf_iter_num_new(&it, 0, 10);
          goto next;

Such prog is accepted when the call of bpf_iter_num_next() is the first
prune point after bpf_iter_num_new() and it never returns. Otherwise
it's rejected with "infinite loop detected".

Require the iterator to have the same id in both states.

Fixes: 06accc8779c1 ("bpf: add support for open-coded iterator loops")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/states.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index c1fbb339329f..18bf7b660c2f 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -1335,8 +1335,9 @@ int bpf_is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 			 */
 			if (is_iter_next_insn(env, insn_idx)) {
 				if (states_equal(env, &sl->state, cur, RANGE_WITHIN)) {
-					struct bpf_func_state *cur_frame, *iter_frame;
+					struct bpf_func_state *cur_frame, *iter_frame, *old_frame;
 					struct bpf_reg_state *iter_state, *iter_reg;
+					struct bpf_reg_state *old_iter;
 					int spi;
 
 					cur_frame = cur->frame[cur->curframe];
@@ -1351,7 +1352,16 @@ int bpf_is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 					spi = bpf_get_spi(iter_reg->var_off.value);
 					iter_frame = bpf_func(env, iter_reg);
 					iter_state = &bpf_stack_slot(iter_frame, spi)->spilled_ptr;
-					if (iter_state->iter.state == BPF_ITER_STATE_ACTIVE) {
+					old_frame = sl->state.frame[iter_reg->frameno];
+					old_iter = &bpf_stack_slot(old_frame, spi)->spilled_ptr;
+					/*
+					 * states_equal() matches ids through idmap.
+					 * The loop converged only if it's the same
+					 * iterator. The one that was destroyed and
+					 * created again starts from the beginning.
+					 */
+					if (iter_state->iter.state == BPF_ITER_STATE_ACTIVE &&
+					    iter_state->id == old_iter->id) {
 						loop = true;
 						goto hit;
 					}
-- 
2.55.0

