Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795579728;
	b=M6p/krsRFknNeP0teWVlZspUYhpp8vAg/hIKdkxjafP1PvM4pwb5jl5162pw8kZI8Ixc
	 HTL063ujoDko1fFLLx8X6SHWdZ6YnWbUnw+XlyL3KF/g0Y4NxXAfDCJrMsyU122CoSjWM
	 QVy1lh8u9Z/kEmMazw7s/Zp527ZT4F2p7q1Rmh8rLdJ3U9mgNSjPywaXRlxuBDM6VaWvD
	 fEqav5C85JhtZUpHnd2cgssTNlZRLWqjYwymOTte1uoPZGY4LG3Ht/JEP05jSK2aboVij
	 Y4w4x9rRhR6H6fuJAk7yO0CC5UQ3FPGD2JaV5L1oeQdKwpRfUFKXewRQwogP+t6vNdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795579728;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6BXaWp6UqvVx2pJzKCWe2MjSfejWfuo5s+POsRVeqFo=;
	b=P1Ar5kqn3m1T6gobNFUreq1SNtHqLR5rCF3/RspQamykBRMPK2iwGn+OjMS/m86S9wsS
	 ery9D8RLnHKxSCfHP8hbSJGfAvA+tCU2dT6N5rqTGa57CPQVDD259NASeDqCqrO+GRMCB
	 2+ZD2bfeo1xPuxG0r9RNzr5itujsbV4ITmrH1J69LxPK4QYSg+yfz5jMU/aNi5R9EJn4M
	 OFscnFt/903VMLhPdunCKU+fZardYksW+cC9nGK4gtKj64xL7omSGbVoPSyf6g3J5OFpf
	 i7p4BCDLcjrJZhomeVGLvicwdfbXO7YBqZmKzZ2mc/XY3XSz8MySKokk7swR2bXRyKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DxqIPhO9;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B7A606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 04:08:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70B7A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DxqIPhO9
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2f048476ab9so37089645ad.0
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 20:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795579728; x=1796184528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6BXaWp6UqvVx2pJzKCWe2MjSfejWfuo5s+POsRVeqFo=;
        b=DxqIPhO95LA74QNEyz5VTo/44yslYIBiUoUYMIyc5U+6rXud5I6p0dtG31kqdD2xle
         OQxuBz52XibYFOlCrEDUdkFLhKY2xBqnaMohPcoJpvuoXL9UU2OlOJ7CJnHZxv0fe6Lj
         Aqgu/vjTapqm2mlZufHfjAKj6UEUAR+UfC0rI+ROWow6aUt/qu8Y+wVf9tb7QZnXdpib
         M5kVgJbHqsiXR9oeY2rdZr0Dy9MxBwFmdMJiYw1ZNN3vPhSxrI6emuWIf6VnN1MKBHpI
         L88iCZ550xYQdWpU0a6NlU3HAzhLMcMBTPI/lkfwmf8jNN+DwlEl0nqUZ3nc1BNXnxSC
         yeqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795579728; x=1796184528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6BXaWp6UqvVx2pJzKCWe2MjSfejWfuo5s+POsRVeqFo=;
        b=CuFBYXZa8nLywCFW5PfOFjE2j2GS2JUFm+z8y0PZQSwF+r7cnggyNIww1kun/FYaEL
         8HYso38jRocQ3UMzV+StDEw7lnSakNoiKsPAYPplYcfK9zupCbEqhkBjElvhjwm3tpMD
         KS9RJUTKJW133XYiQkunHtfKf10CRI6CEjicJMXq53Q4cg9AqwefRxB6/A5TA60SEWFJ
         xbIEs5In2T6So29j+ZqQ9VhGGwL3TJNOc/MP4e9uHXkAe/zy5VwdEaAbd/mtb0lmHqZX
         +GLFB0RnHlD/l0DWZpNwet6GvsvKK48XQzo4kNy96LjEGe2YJ79BTQu1fkyqCmYCAMXJ
         e+lA==
X-Gm-Message-State: APuU4Z+tuAEHicanO8MlOncIZqBYa9MKQrH0FpEpdUp+8Up/MTJrDY/k
	v0FDwCV6j6f4zWqGnXkD0V/Vjyp3D1uv22pariNzdutXLb2IuKP3BFYsZCOVfwwF
X-Gm-Gg: AZFdTZcEGpMqi81UrZusgToWBtqYAwnL2KYi5c/W08d1f6NghUV9ys7R9YLE85DApqQ
	DuANay+Gv/4xT3nIOBOZhSgnkoew8x5+fXxTkCNDfX2W0bW9vNrEDrK+arqL6jGT9uyrTrxLP1v
	hoYI2Nwbfgcrta2zxRlYOKDQrhhaCcMSwJM2sgT/PcS5B0YoF1ipkKqGtfd4UtKdmNMf7o7t1aU
	sOnSJ50M5xWnA9WH4sDRqdrQc+zB/tsfxEV5uePTeLHQc/V2Cb5oDNqkPqZKNTlkET658IZqSrT
	REOb2xlWTrOeN+SkrSpaETS5LTv5jGYb6lGBLfdo50IWHrKWI/KO6CWloYbM1gK7tTVDUE+vNds
	wwmhnbHl4DsJlhv5/T7CBBHmmYLogBAydzUw5gwc1GKxhproGEwqtKLzBRVQ3YYnNspkZpl3b+7
	m7iYurTD/wmDggolxObrRqtm/3Z65b1k8qlGnGlnj33CD2gg/UkUEDaJ73otr+hBPRFYwmweSJw
	EhTwp+Kzfoy80Zk83Ly4XdEi05KfwIclHf76mfQ59GpXaEFhUylqHggwXuQI73exv9J6+BDdkeS
	O/ypnzFRpF6GKW5kUrCBPbm49X7+of3bjr0SE++cAoDqXxks7CVWpKbsZxNtgh2mlQd51HTK1eT
	dTg/lK+dN0UgbqV6K7B2glDoafUfTAnLnXkGhZr8m/kqNNC0qVgPzPriN7K1LQz8aj7XDoa4d+K
	r4
X-Received: by 2002:a17:903:37cc:b0:2f0:4ebf:84e3 with SMTP id d9443c01a7336-2f04ebf86e9mr137614665ad.60.1795579727533;
        Tue, 24 Nov 2026 20:08:47 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f147a9esm77071595ad.72.2026.11.24.20.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 20:08:47 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	luis.gerhorst@fau.de
Subject: [PATCH bpf 4/5] bpf: Emit nospec after BPF_ATOMIC stores to the stack
Date: Wed, 25 Nov 2026 04:08:19 +0000
Message-ID: <20261125040820.947816-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261125040820.947816-1-alexei.starovoitov@gmail.com>
References: <20261125040820.947816-1-alexei.starovoitov@gmail.com>
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

check_stack_write_fixed_off() sets nospec_result for BPF_ATOMIC insns
too, but bpf_convert_ctx_accesses() emits the nospec only after BPF_MEM
stores.

Emit it after BPF_ATOMIC insns as well.

Fixes: 880442305a39 ("bpf: Introduce load-acquire and store-release instructions")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/fixups.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index a656634fa9e4..03c077572f9a 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -1062,6 +1062,10 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
 			env->prog = new_prog;
 			insn      = new_prog->insnsi + i + delta;
 			continue;
+		} else if (BPF_CLASS(insn->code) == BPF_STX &&
+			   BPF_MODE(insn->code) == BPF_ATOMIC &&
+			   env->insn_aux_data[i + delta].nospec_result) {
+			type = BPF_WRITE;
 		} else if (insn->code == (BPF_JMP | BPF_EXIT) &&
 			   epilogue_cnt &&
 			   i + delta < subprogs[1].start) {
-- 
2.55.0

