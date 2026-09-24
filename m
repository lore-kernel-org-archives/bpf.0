Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555066FC5
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 03:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790219451; cv=none; b=NhhrhYlMf/qz2iP/CrcEiCKum0+4vnFgGkkz7SXh1RJZk+jEQQqUiwnWRJTVy73jQUx7XsCSmdM84dQO5mWL6XuoZ7Bo0gqbo9sSHiZEcksb/t3NzGPWYn/KkrMRYiAbpS/wnHmIG+uZjhd9WqLrTQ2Y2dfP3D9qblzU3R1vCsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790219451; c=relaxed/simple;
	bh=+NZDeb4a09LwEWAjY9MeDGtgXauZ/6FNdbQDl5h1h7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NTWs77s+XZC2pEBu6XkMD9j2I1rOge9BbqjLp7Mu1ELPrAZmVzfwU5sQUghq4PmXKUU6I59QwIR4kN8qp2vVJlk33XzGAsH5lZV7V+vN7xIwMQu8/Bmr1c53ocrnNuh/NOP+qbPI7zHGkcvhBUZ2q0TSFMUQgGx6bh1ItkvrbI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N7ffY0fx; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7ffY0fx"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea4ae2cso1004961a12.0
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 20:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790219450; x=1790824250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UzTsMkdbQ8NlGIH89IJGiojKxLUeYR7zDMCBDgMwb7Q=;
        b=N7ffY0fxaF1f6mtTJD3m2kEeb+Cv7FSEyb5usC3nlNc/M6jeuYNZ0FAZcaUPFWBWUv
         ESbJiaMJD3dtG/3nvYhyPX6uv07cyOE+FccI5XYJeSw+9ntF+sejCgeGMbWfXYhI3tcO
         qdVHdaNVyw9aWrxzjSe6iqEz7MsVQN0vbJ22p34L1aKCIHLNVn51FIVWzOaZLmNPhO3U
         dx2kk2y2bxJ+EvzB77rVGjxaT4gg7B8pkxQ/4CLaCofZnEP6vlxICneyXY/1X1fFj9bR
         k8Fm9U/JiMI/7prwgamV2TD+5xpDfiheFIXYXRx/Pmo1iumLvd71ibNQl4hDwb8knmNO
         1AIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790219450; x=1790824250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UzTsMkdbQ8NlGIH89IJGiojKxLUeYR7zDMCBDgMwb7Q=;
        b=vDtmtGzwe92fg6eHrtHYJaS03u1+Ud+mMkyTlkr138t7Fme/lbImnQlu0uf2ZOW9RV
         p3JyHSzkF8is2dtAOieHnI/Hip8lPtCg+peoIqI88sfj/3p1fQUWocSyHarOXyN7AvKb
         UaIMEqBUF67tpo3nWflK/aCTk8QQ/A7UqItANJmO7dvPwI/1oKZ70ln/7OPeNDfX/K7z
         J5PgrAY1fzJWbvUzvRerTlXf+XiJ15Tw9HECBdh9auraTF6W3FcyPASgyfCGHIQ4PHT4
         FgHQc7Iz96FFQKXfZu82ycZrIZceaYhFF71mRF1OwQVnsF2ElOqHeMR1ngJglziLt+g0
         wPkw==
X-Gm-Message-State: AFuF++ky/0cVSRJP9KYOxlee0QFdoFQyGakHH2ECDulNcUtyVpxqT0i1
	4Gw6NT+ANCw6hGJvl6ojiKdRf/dSEIfEZAAmk3Mg27FucD08uksI+JAePWRw1A==
X-Gm-Gg: AYBFou0VyDinIiSzT8n3cuA0BvIV/AMjYnXdEbwqYis7q8aKmoUzcb1g9G/Cf8/P/BX
	A1q1EdlQZq94cq29VDnjgzJuDO1p8VARV4yDbHloZAvsUJHsTngeVOcf0XhuKtZkf5dB9/6Xbze
	dqSrHmwGjYNYVdD+PChU58FO37lJ/UifLPb1mmUlHFmdWuytWNtGYgbqXKnA9vsJvbRnk50x425
	iq0jIiu48jmVdX95+kRHjl7xBDAtpRkkF9qlwhZg+W4MYJ5WYRa+EED+jA4PJdBSFHXJBzPKx34
	uAJSffJzvEKG6fXhsvSTUQaxKHYalYiTA8+7hMiqCqQaUzwR3FuInhZrBMNVgHKWv1yOhpCY1B4
	8HK3LNkBSBBiTkNxJm4PdUWWppMNx9Y4ECZInbvY2hD2sZPCc0X4cnu9L13XjQaoovnLH+7fY6+
	80CbrDOMXEedaVM7BdNH4Fy8mII6qH2lyoO4oV+hDDbP9kct+T+6T3xvWZTMKcgN7JKXIC3b5mG
	tHdIBDN2QC3x4fdoTZCQpzQ1FAuIQTViKBfp/LuqrTsnBtIwQKImXE3jAY/adpNOp9ytnzsb9aI
	bel+G9nAB7sv0gXb5m9goQP7O3H+kYtS1cu589Rn+s8=
X-Received: by 2002:a05:6a20:748f:b0:3dd:a196:5397 with SMTP id adf61e73a8af0-3de0e93453emr1088443637.57.1790219449490;
        Wed, 23 Sep 2026 20:10:49 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87d1d5c12besm2078208b3a.29.2026.09.23.20.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 20:10:48 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 01/17] bpf: Fix infinite loop in check_max_stack_depth()
Date: Thu, 24 Sep 2026 03:10:26 +0000
Message-ID: <20260924031042.1690890-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924031042.1690890-1-alexei.starovoitov@gmail.com>
References: <20260924031042.1690890-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

sort_subprogs_topo() rejects recursion via direct calls, but allows cycles
that go through ld_imm64 BPF_PSEUDO_FUNC, since the address could be taken
for an async callback. The main verifier pass limits the number of frames,
but it doesn't follow calls into global functions.
So the following program passes both:

  static int cb(u32 i, void *ctx) { return foo(i); }
  static int foo(int x)           { return bar(x); }
  int bar(int x)                  { bpf_loop(1, cb, NULL, 0); return 0; }

  SEC("socket") int prog(void *ctx) { return cb(0, NULL); }

cb -> foo -> bar -> bpf_loop -> cb is unbounded recursion.
check_max_stack_depth_subprog() walks this cycle too. None of
the functions use stack and the frame counter is reset by every global
function, so neither stack size nor frame limit is hit and bpf_prog_load()
spins forever.

Reject a call into a subprog that is already in the chain of callers.
Async callbacks are skipped earlier and are not affected.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a7c9e2d8965d..74cf24ce3007 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5510,6 +5510,27 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 			}
 		}
 
+		/*
+		 * sort_subprogs_topo() tolerates cycles in the call graph that
+		 * go through the address of a function being taken, since it
+		 * doesn't know what it is taken for. Such cycle is a recursion
+		 * unless it's an async callback, which are skipped above.
+		 * The main verification pass limits the depth of the recursion,
+		 * but it doesn't follow calls of global functions.
+		 */
+		for (tmp = idx; tmp >= 0; tmp = dinfo[tmp].caller) {
+			if (tmp != sidx)
+				continue;
+			verbose(env, "recursive call from %s() to %s()\n",
+				bpf_subprog_name(env, idx), bpf_subprog_name(env, sidx));
+			bpf_diag_program_structure(
+				env, i, "recursive subprogram call",
+				"Rewrite the recursion as an explicit bounded loop, or split the logic so subprogram calls do not form a cycle.",
+				"This call or callback would make the subprogram call graph recursive. "
+				"The verifier requires a finite, acyclic call graph so it can bound stack depth and analysis.");
+			return -EINVAL;
+		}
+
 		/* store caller info for after we return from callee */
 		dinfo[idx].frame = frame;
 		dinfo[idx].ret_insn = i + 1;
-- 
2.55.0

