Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795299257;
	b=awoFRlLHWk2ogo8iC2M0JOltegV47+DJbIJRKsyoOEncUU2ZvMbIAGAZ3AtPsQl63Dqt
	 LHFTrPeuZb/qBnnK4dZk+73K8lZlUvy52/fWctn6tylYytfbrLNseBrc+Ke+pdiIZ26tR
	 muFeQuY3VGcIL8peK2mS6IrNIt/0u7vknimdR6nVRQvv4wB0DX7ZysxaJ+22YQe0zBKkN
	 hhyaeezKi/4lzyKJWClW0GoTEvZYNv1ZK0B0rzP8ijYK/Ec6ojYR5Zh0mmPd88SzNmR87
	 tpao93+sQyoOZTZfdfWDGM3AWMECQJnrA4I1mkGNbLokuxYVucwqWY4iCfnALlp+4EA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795299257;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qJvlT/2x0rK/w7VrpL0SIfSfWDqwBR4sEdWntcW81P4=;
	b=Xja+muQqermNePb7NnsRZ8vXvL1zyRfz2DS17R3y/kV875inESqhlibXdM57uJgrbYeQ
	 8TpKGNektKXrc8CI//gjWK7V4aOv2W7n/P0fo16r8MM22teajt7Hk5m14XGfJBO0Xf3vG
	 9pf4S0ScV0kcWn83sOf0fx25lIqfPIv4G4lkf14I9HMc5mTjCJSKWXyl137m2Cs6ZMwgl
	 leKmTdcWVjHj5QJiP98/w3p+s2MNvFH7qkfDc9e6VUQEiBJwjKK8cMBUYY/S8Fk+ge0/P
	 cHfSXrdZxsq4qJqtopnqxd6cJrxyLk/zyYsvxiOOeymnUXjT9kk2ttjp+1lo20K/sXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cTHcZ0AY;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACACC606A320
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 22:14:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACACC606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cTHcZ0AY
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3b3a914e4c8so1111221a91.0
        for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 14:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795299256; x=1795904056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qJvlT/2x0rK/w7VrpL0SIfSfWDqwBR4sEdWntcW81P4=;
        b=cTHcZ0AYDSV2eaqfPDRMytUk902eblfN1tH0cC/7B39HWVpEWhAwieC6eX8/rVOhdY
         QOfP+CbOkf1nyHXys1cRGAEd+WD9diMN4C3PQ1JfRme32zgMuBE0oC1s1sZfa1iisIYR
         juxVxbWM9yDMjiw00uf5COqy4ANKMxtD3krzsKwoxcEatGyBMgYNnfgLXiEvZ2dH+OIt
         +L6cbV4CzX8+9ALHzMiN2A1g+2yYndDKLGZ0zo6nbjIgIflwmNr08bynkCsxjdjWDzeq
         Oe6mG575CjXc4FCuAyt9Sd2WmvSQ9sFZouFlK0uYTnQfhEHpdJtjeM9Y02aQG+wdTX8K
         49ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795299256; x=1795904056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qJvlT/2x0rK/w7VrpL0SIfSfWDqwBR4sEdWntcW81P4=;
        b=JvhKdcb8p08ZkQvpWXbZxRKRsOd6JudgaVSaWJqcRwDQmyK/R03gBuTQOReba78RQg
         DoOVQVRRFw6D30zmJUnmRHSU+tFiiqZSA4eKi/oIW6s2mdvRJj5NK8Hx8JXOT+RGHdAQ
         wj7kYXs6TgeU3znTRebHIAuZwbmLwH0AtGCbYqcEwy/3gHg4RBfxJojmYsSsNBJjEgTn
         AYta04apScbwh7zOPo4WtfNUbU7Q+4yptlUeipFv+W6DwHxC+FE+muggTsgsum4BN7lj
         xZ2MHxztn22MiATRzGpfEImRcyInOO+Ata94827BkuLBmr9xG92QTnsgIQBZi3sc+blp
         0JZA==
X-Gm-Message-State: APuU4Z8A0FCTwCAAc8yTw7HuLSRhtihGgwLKAUPgzHsIq3A1KEOog+gF
	A9YCWcPM+w0S9pBvL6T1VGFLW0gDQ2hABYYds0JpzCB6nXy9neZE2kifSUJOng==
X-Gm-Gg: AZFdTZcgX830beFA1MKc1zlcmvjsoFYd2wXWzhx5LTpbVRqr1U6wtFF/Ng8O//1uC7p
	5W4qk3k0fAlhOHzqMWxej9I/8OqD6zGIxIF4rm13+7VqwG6sufFXRM4No9H/ou9oR72wTYLM1SF
	KYS2YGC2UDZHbpZjtYxv+CLs/ZELKs2OmLPCBqEorXIAO0uuHMQMWXpUi163aw/wNlTRgDduePL
	IfmjnfkUL/jOpgQfHNRDN7fBa2KB+B6hDOI6SLh1kfMM9vxE09CFV2KrCim02z227clo4Rv4lwl
	+THxuLhxCygowTelsH6rkJ4fzxrRBgSRwOKulZEl7zSz3d6/hymGdPXCbXa6EL3SQOlDMXqsUTB
	iSb9iqrDJpJjLzQ4pJpH0Rruu62ugYFU1SqkexqOwh7Tmsr7v9mzax540Fo0JYI4jgSRWspnOn0
	cM9zxJAFn4zahr9N54/jlPciM5AReiwBFMfkIKHPMC4Ba8He03jWewsBXhp8lMY1aaS0XR9Xl9T
	PRRC17EvyiS6yeOAYG9LcO8MkYoWjFh32Kcr8fN1Rs/BMUe9ZD17evgABlWtHtfFpDTKWRQ4nBY
	Xi+QCXYGfv1bMsI4RsJAglYm0HlofTTBHvF+jNWcfa9dnt8ux9VV3dbW1lMaAXBDxxdN3X2Na8S
	/p5JC2cPhsDX3TtfqoQjdgMQFlRXMNOhPjD7FALgBJQ8tAII8vzf2n00CpzKsdQfivOmWFsiVqw
	==
X-Received: by 2002:a17:90b:5287:b0:3b4:402:b3fa with SMTP id 98e67ed59e1d1-3b41c8fe1edmr6674741a91.18.1795299255846;
        Sat, 21 Nov 2026 14:14:15 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b82e624sm2698741a91.4.2026.11.21.14.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 14:14:15 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 5/7] bpf: Drop a path of a path-sensitive run that is out of frames
Date: Sat, 21 Nov 2026 22:13:42 +0000
Message-ID: <20261121221344.3958866-6-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261121221344.3958866-1-alexei.starovoitov@gmail.com>
References: <20261121221344.3958866-1-alexei.starovoitov@gmail.com>
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

A valid program with recursion can be rejected with "the call stack of
33 frames is too deep". No unsafe program is accepted, because the
path-sensitive run accepts nothing.

A pass can check a recursive function on its own, with no frame for
each call. The run has each call of a static function in frames. It can
run out of frames and get -E2BIG where no pass does. If the last pass
had another error at that call, for example a callx with an unknown
target, the run takes -E2BIG for the failing path. The budget of the
next passes is cut. If the program needs more, it is rejected.

Drop such a path. If each pass is out of frames too, the program is
still rejected. Now its log has only the last basic block, not the full
path.

Fixes: a46de5d64e18 ("bpf: Reproduce an error on one path, with no joins")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h | 5 ++++-
 kernel/bpf/verifier.c        | 2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 942629cc49..05a52913ae 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -586,7 +586,10 @@ struct bpf_verifier_state {
 	struct bpf_reference_state *refs;
 	u32 insn_idx;
 	bool speculative;
-	/* an xreg has no value: unreachable. Only a path-sensitive run drops such a state. */
+	/*
+	 * An xreg has no value: unreachable. Only a path-sensitive run drops such a state.
+	 * The run also sets it when it is out of frames.
+	 */
 	bool infeasible;
 	/* an error only in a leftover, see check_held_in_leftover() */
 	bool holds_too_much;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 907691a67a..fe6209c166 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11240,6 +11240,8 @@ static int setup_func_entry(struct bpf_verifier_env *env, int subprog, int calls
 	if (state->curframe + 1 >= MAX_CALL_FRAMES) {
 		verbose(env, "the call stack of %d frames is too deep\n",
 			state->curframe + 2);
+		/* drop the path: a pass possibly does not have these calls in frames */
+		env->cur_state->infeasible |= env->path_sensitive;
 		return -E2BIG;
 	}
 	/* in the frames of the callers it has no end */
-- 
2.55.0

