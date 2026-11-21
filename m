Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795288457;
	b=qWxtmHwBOz9HXida7haJ4ScluuZWEoLjf73IPrJknXLwGE82HSSyOVV+fDILkPGVQFzv
	 U+2AiaaRIOV2Eei6dSDs1umrIdyZkeeg9GdHoLwHt24ZZPi1d9OcDfAdweFAgdZutfyCf
	 TdZoCeF8zNxsoA5gYfHGA/AnN7Q2CvbWPzj6f7eCPpb7UHjmxOyn9UzNtU78aehXd7d5O
	 Y5OJFA9SAmpvD72fH4UVqDdvWeoOK3BGLuJvJEpbs1ZmrBY71VhHXtjIpatZZRP+sa78R
	 F33UNT19C8oypZMFhW9tboSwbhoNB9MjSGD1Dg3bQvrsetDLpLjNWnxylC2s1dxaCWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795288457;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=wyxLQ12jXRWCelxFC6NoJ/BikOug3ZGUm9H6faUX4ns=;
	b=Q4gVswHkTREkuwLV3F7tEObVHypOZJbJBsHMGd3bRci1yEvZt04Tp8FEVL2wF5x6vqTq
	 Qf2y2C58hPMxN2O/UaWsgx+LivZ+TlYqN3TJZFcikHXEIAMXDvbHXNuTrREhrlJYxNBCx
	 WNl+x7rpx80GFbnshPw2cX0RlQktFAp8c7t8ZWAba1mrrrK9Ruy+3lTz4D554N00IjBuC
	 Sid7lwowsKKztXDhDc8ngW2+YFH1J5BDFf8FDuAvHbl1fPe7q1e8R2nGflhoISs2i3a7g
	 MPggikq4NkFHgO0G1yWJwMvBpNYGKHdlgJIlnHYK0J8Fp6fiBSo4otjkl6ABwYvkIoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NQbD8u9d;
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63692606A320
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 19:14:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63692606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NQbD8u9d
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2f046b0adc0so9109265ad.1
        for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 11:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795288457; x=1795893257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wyxLQ12jXRWCelxFC6NoJ/BikOug3ZGUm9H6faUX4ns=;
        b=NQbD8u9dzI+oQEVQKOV8+tPcfrIbNtEptLVM/ga/QEyKdeWo7YrhcaROH7OXSijG23
         c5mKeG/xRfwvl9YpMBj4DCdCXbOl214SBRIYn44QEEDqPn56Zk3cCEO6fMmbxVbzQ9DZ
         3hYjUsfPFuhjcqX+gYMkuFrgSMqOsVwBSv8tsJXc/UlrrMb76O1mI73ED73nPZ4UROpO
         jLB6k4E2IqkJM4LyclW4ZaXOj7LQGfnoTqCE6MVdiNqh40GyPSaEAYeoaGckBn8Y7xaA
         9/B5QCSdHPgNqmnHT18NDgyX8MZ+ANs7i2hSbSRYSF6tbrx7WcWd+FrDph3M8Vx9rHk2
         6Ayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795288457; x=1795893257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wyxLQ12jXRWCelxFC6NoJ/BikOug3ZGUm9H6faUX4ns=;
        b=BUtlkc3zvTUevttP12FKhnHiZepvrLvGmpGD2rPj4k2/F7GIF+Iywr5xyPkqqXDaeq
         kiZe84XOXaBN8c1D5MF8CgehxyBMWLByNhDfp1FpQQ1M+f9aPDYDAnvGZFX1ac8E6s1Z
         8M3C34HVbNvf/tJ9MOHrqxyEWqdf9EsyOlwAJj9MefwOfO+mzQCepGq03sr+GFGUfDwo
         6Ut05pzx6+Pj/W/KDzAu3Xzo5RDMQmzCqpLcwYtb/Qa7t22Mgk+oiLhPrgZBiAvgQrcE
         PDyzhBH3bl5W3tLisuOKm6h4XdFZxwU6q56xP7G9Q+4KSPw8VQ1bN2oZY+nTja/P52xm
         rVJg==
X-Gm-Message-State: APuU4Z97ZFJrJuo5XLgOEg7YG4Xp8+2CXJUQ1sV0ZA7gw5Q69h46iQbW
	UAXc+e1iv+nI8NJj3j+JtRbof48Y9DhNe/cIXcw7TXT/sLeR3uqqJMYsXLS7SA==
X-Gm-Gg: AZFdTZdvqjfbOncpU4baHxQWsIa8RBvyCayR3lRhlKGdVgSGh5wLHtfmIhGe8x1W0VN
	RbyDtQ5dSySGVFnRecESUp+m726ecbiPFU7XC9ajsPxb3zg57faSQdpqjy0g1t8vn4Vyf2BNuyg
	i1QrYlsL1myJULIcRNu7ku/OAVr8cEITf5Q4pBQzyC/7+WxiLcQ7YCdulcYuhWsYCSlf5fl5SZ7
	lOFnOU55OCfOZ5SU+gPnDuJd8qw/jgGNmmj6VZtud4szteuqNuAtXdbX0qNuxFgClMmIsQ98pQw
	77JHo5+2POfbqw77mJy/MzAqrae9LWCWbo/B+KBSkHMewY16QjmyjzItHK43xXE0DYUMH2ubZTC
	ui2Iy7resoVMlAz/UrOMk2zp5h9N6tks3l8N/KINKs0sGMv8+TkIqpiqnwcrrneiC8iqCtTsOqF
	EAApIAsr0JTpR8gxZ8xUPNFh+mZHyOw72Q2nk7H+mYOn0XHDXlclGx67W7KiZg4jw3ukF1YrXYy
	PlMaRDygVpmUAuOAMc+3NU7kdByZysrgc1E86GluqLqrgWGpTuHVtJIyBhsM+dzfFXzCkbRDoPs
	s5AbrdPcA3TUXPt9vlpHaZxJIToJ3Pj2UwDFl/jbEx4tfuOCf8vv4RYOgXm16J8Miibr1O1wFKb
	S0Nrohxz+JpsNFXs2q0xbssCKWD03P3MD1LJ2XR8GDtR33vDaWLwUiZKh7V3ZxO9L7x2EqOGeGA
	==
X-Received: by 2002:a17:90b:2e4b:b0:3ab:884b:659e with SMTP id 98e67ed59e1d1-3b41c8e1705mr5663434a91.9.1795288456420;
        Sat, 21 Nov 2026 11:14:16 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41adcfe16sm9633993a91.17.2026.11.21.11.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 11:14:16 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 5/7] bpf: Drop a path of a path-sensitive run that is out of frames
Date: Sat, 21 Nov 2026 19:13:40 +0000
Message-ID: <20261121191343.3670609-6-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261121191343.3670609-1-alexei.starovoitov@gmail.com>
References: <20261121191343.3670609-1-alexei.starovoitov@gmail.com>
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
 kernel/bpf/verifier.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5bd6fa081f..f0334f782a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21970,10 +21970,13 @@ static int do_check(struct bpf_verifier_env *env)
 		err = do_check_block(env, prev_insn_idx);
 		if (env->bug)
 			return -EFAULT;
-		/* a pass had no error at this insn, possibly with a state that has more values */
+		/*
+		 * A pass had no error at this insn, possibly with a state that has more values.
+		 * -E2BIG: a pass possibly does not have these calls in frames.
+		 */
 		if (err && env->path_sensitive && is_error_of_state(env, err) &&
 		    (env->cur_state->infeasible || env->cur_state->equations.infeasible ||
-		     !bpf_failing_path_may_end_at(env, env->insn_idx))) {
+		     err == -E2BIG || !bpf_failing_path_may_end_at(env, env->insn_idx))) {
 			bpf_free_verifier_state(env, env->cur_state, false);
 			memset(env->cur_state, 0, sizeof(*env->cur_state));
 			free_pushed_states(env);
-- 
2.55.0

