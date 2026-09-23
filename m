Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4669598BFF
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 22:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790202969; cv=none; b=V7qwNFeBQzfuwoPfQpsH+DP3l/jdwElTONhrvJ9uDNweE2dMefmhMuCGwhXZux+X57i4pR8rNEgEz2HjiMSlS7Av/exFem2r/HE055R9zcfACFZjRgHdzzArVY5g5aRbk+XG8h7AVingMmfJLcvPJoFsY1DTmgtFNan2HhjSLzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790202969; c=relaxed/simple;
	bh=sZ6LaMNPqc/4x/31lhC6GbyKTCqOoHTE7mWQP0absAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LQ2XFZHXIkbW6md8hXh28l5tQcD8HbiqvRR8XNpU3G3PMxqpF1tEWLIwTa70LF56puTuDKXRX8MqHLgdBOJgY5aMliU3Djhb6kuqvr7Zss/mrHYGl5v0Jqr2Dyf/P2WbI+6KoT7IkX2EkgRoVC1Rh4qSpxwztyw/spru3lx615E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CgHd1Xdu; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CgHd1Xdu"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2db18fe433fso7401235ad.2
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 15:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790202964; x=1790807764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EBkUqoQi1Th9OaDoEvRngtDtGouvjsDK/u5onOZKfN0=;
        b=CgHd1XduX6BNxjA0gNDX/r4scZLIbEiC8sPSW7DMeRSc1zBoLw+jJdrUg5o4TYrjYR
         gEnsuh/yr/22hMctKUfz5Qgko7/Xo1/ZMpRPnGleHzuYqEVOy01E6tpgPwuAW14HcYj/
         x/yCxtuOseJ2eT6jdf7YoPcY/O+YamzLKt1gIpdfN3zr4vGWErd0qHPvd9hnx//Jrk9p
         yWeEXN0aDVGKpINz0pqMoE2aFHEDKvpHhwZwzpH1VrBg9zG1IDr9jIuDV4kMkbDH7usN
         UJ8UKnufX6b1II9qM4f3XFYFTDKyc5w/Rb9O9AWYUGB5eyXD07kCxndzlsdFvyd6XH9y
         /gwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790202964; x=1790807764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EBkUqoQi1Th9OaDoEvRngtDtGouvjsDK/u5onOZKfN0=;
        b=V2DbLVuFzlVHmoUAi53fO0gCkM3fZak8cgHzPgf3Ev22zqsG/L0MgWdGBR1aOWA8D1
         kkPkkuPtse3xktt360MWk6hsTHjuW+o69un0LaDTFw6keN2ESZdV41yLJhlnx3niP8eH
         PVJdyQZ9uwWn4XZ6Z8orK40UuhF5N/Wp9vQ8zUy5Zp+cceY16OeC+EFK6cm9ecg+UMe5
         CK83W3SP1OWzllt86f7j5cX6waSb2dzRDfExIrCtAmIvD9AWHkQa3YsBqTJ3+dcZ00+Z
         pNZwOAogiItC+6TWXbIthGxFzF1YTGvLBb3ovbCLn7U53F+NrwD8dZ+V19vWE4DM5zqV
         zcXA==
X-Gm-Message-State: AFuF++nQT62y1QcbHXL5vJCIBnZgVNzc+hc6RvFG2nkwiRDOL4nW79r4
	xV0jUxlaWkG724mTauBHXW5zIET+fD58xVPdfpLzdFMe2LrZli+/UJRBj1kF+A==
X-Gm-Gg: AYBFou3gofoii2e3WVwdD6c7MbS40GOLjqLYu454n62QjOf+j2yXdpHy9Ljgz1OMkem
	hlGytxI+Ucs04FxJjzH9qWfXjG4upyP9ZbKXiAruVHujSZuIXQejjZQIUd79HYZKDw0maRd5zMQ
	ewkODCuj8Jj61OX5fu1hPGrmOg4m3FoAtswK3cGC3lS1oDD5YCd4UEKbQpmOQXgGrK0tIdzw133
	wvD5p1FH+tyLxjdvHyaQF92BIGyumKcjaUsblwK3Prt18HqqkOwb1ghYJI7VuJ2KBoMsziFFX/4
	adlmj74u/o4bjLd76fPrPL40JygN6XArn3gHtZePjcQ4Y2lNkt3vyZrifqQ5Z8yogkeIZLOQl+g
	KRSEXs98IhbyF5ug3ACntWavo6BcRqyeUVa8y09jnJuLTwgikZfr5J0Q1U94SZwbIwH1OdnLGqD
	2/8YN0RILsDvUkf3NTUph97Br3qlPp8AXAyTCJXn8jfq0F5EBABfeM/Ll30iNNK4JoA0EuIyqhz
	cUs9tEswYaKpDZICOu0P9UjpSwILokALR0qyf7R3JFD0/YFVq6UN9Zyi6Kf9Ghx0qsoKHPhrsQ9
	mffihvHUochvI3U/hG5cQOtydsn/VgiSuUC8qtWCZMY=
X-Received: by 2002:a17:902:cf12:b0:2db:2427:97d5 with SMTP id d9443c01a7336-2df7da42a23mr4832535ad.4.1790202963638;
        Wed, 23 Sep 2026 15:36:03 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a5a7b48sm16850315ad.23.2026.09.23.15.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 15:36:03 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 2/8] bpf: Mark loop heads in check_cfg()
Date: Wed, 23 Sep 2026 22:35:48 +0000
Message-ID: <20260923223554.562379-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923223554.562379-1-alexei.starovoitov@gmail.com>
References: <20260923223554.562379-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

check_cfg() finds back-edges while it walks the control flow graph.
Remember their targets as loop heads and which edge of the insn is
the back-edge. The main pass needs it to tell the state that enters
the loop from the state that went around it.
No functional change.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h | 3 +++
 kernel/bpf/cfg.c             | 8 +++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 92f528c45605..5a08f079a489 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -709,6 +709,9 @@ struct bpf_insn_aux_data {
 	u32 non_stack_access:1; /* instruction can access non-stack memory */
 	/* true if some jump or call instruction targets this instruction */
 	u32 jump_target:1;
+	u32 loop_head:1; /* target of a back-edge */
+	u32 backedge_ft:1; /* the edge to the next insn is a back-edge */
+	u32 backedge_br:1; /* the jump is a back-edge */
 	/*
 	 * CFG strongly connected component this instruction belongs to,
 	 * zero if it is a singleton SCC.
diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
index 842c7d1eabcc..748bf544d3ba 100644
--- a/kernel/bpf/cfg.c
+++ b/kernel/bpf/cfg.c
@@ -137,8 +137,14 @@ static int push_insn(int t, int w, int e, struct bpf_verifier_env *env)
 		insn_stack[env->cfg.cur_stack++] = w;
 		return KEEP_EXPLORING;
 	} else if ((insn_state[w] & 0xF0) == DISCOVERED) {
-		if (env->bpf_capable)
+		if (env->bpf_capable) {
+			env->insn_aux_data[w].loop_head = true;
+			if (e == FALLTHROUGH)
+				env->insn_aux_data[t].backedge_ft = true;
+			else
+				env->insn_aux_data[t].backedge_br = true;
 			return DONE_EXPLORING;
+		}
 		verbose_linfo(env, t, "%d: ", t);
 		verbose_linfo(env, w, "%d: ", w);
 		verbose(env, "back-edge from insn %d to %d\n", t, w);
-- 
2.55.0

