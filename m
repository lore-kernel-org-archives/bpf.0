Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794698731;
	b=cwEN1JgqFTkSb6opvtR3mm3AEfgO9Kg8i/WkK1WROA14YsD9Xhbd2sHruF5t6qC/csIF
	 iAkKVgvWJC/96ToSZqicSsgCJhk0NMr8wpQS8ylINDekJ+M1PFzP9NJkTV3Xo+HagNh3z
	 3Ogt9xXoS0NnbXi3tBCpi7OVn/TSsp4yK7R23foq1miPYg8x0YTNSNByj94Knx8zdaKHC
	 Sa+fPpK2O5lOIoyQJANJuHW883tkWHcVa8YN8gNGKdf0faatn966/xJLw7FroRIbqUhjB
	 7jhIbUfcz8tTjcui8NqZ+Q3roAZzHADOAvIrvIcr5Iq6W6XqrDakPG1dkbC+d/yQqhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794698731;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=0VCNYcHU0qd2uIDbmUJ+MEDD4eLEb4rGpu9d31FfkFg=;
	b=Mo3li06IjD8wg7PiOsVQ9xMIQExDnFRmxdJ7fW7jXMnZEl1FCXtSY5hDKRLiD+bkZYvD
	 GNPRyxtK6ZQRvsdU7GjR3vpPDTiMQKN7JL3UC3PqN6HTODel5mgpivBJtKOUzPkNISDSY
	 Pb65EIl9OnsGnWiKbF1e+eUuVYFBq/J5oo7AG10l9aOjF6WRCUSUX6Ec9VPSJbNiEtG6D
	 3nEftdMLsNAtnbcoDesxGF5N3oo8uwZCEMjuaJ4j7tLg11JVhjRxWHcQV2pgD+tOlyIMS
	 COfHTGbcfeyPq8oaXDcXG6vlQSIxF4YXicJ+EUrbOOkKWveBuaqj2TeA7fkNXBzSKBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OBixjjB0;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701EA606A323
	for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 23:25:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 701EA606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OBixjjB0
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3ae1b34e0d2so1747252a91.1
        for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 15:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794698731; x=1795303531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0VCNYcHU0qd2uIDbmUJ+MEDD4eLEb4rGpu9d31FfkFg=;
        b=OBixjjB0bz31nhREAoP3sB991FtTS1Gp7Vku1qU8XzZscuPXLIm17SqSSpdVOX7jIu
         G96an6XFTjRwgSdgl5CxOPbVqho6ElHSg2SQlaNXqm8LIdaSHsg31ce8yMfX95YJjapI
         5JYqgVCPkVnfH3+Op2vmVI+Iciw8u7WNwmsOGttqMpf04Eyyw3c5HCGlib0iGmiksZNB
         UKvsbUlYxJ8U6JjkITjV+dXPO+hxJfc2OX3i1yVylc5R2p6pT8Z+mn4Vsjf0ieN2wBOT
         RZVY1RyDqH0bAm60Nxk5zbX9VngvbiR9Mx8NmcUqjDMgmSuMvqaVGGP7hC1er896+O2y
         lMfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794698731; x=1795303531;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0VCNYcHU0qd2uIDbmUJ+MEDD4eLEb4rGpu9d31FfkFg=;
        b=Wadk7iY5gETU/LmAdBgPW2E7fOOzfBDe7mJ5EsidJondxEoNCKOo5bvRMm2Xvt6Cds
         qe03KROEv5LYBthrm1HfW+uExp5t9hcbRFunbawI0H6mkFmOF7BATWl2Z5BUwDzK3bgp
         QPO2Mkn+4qLVxlpPonFYrU5whVM9IBwuEKHB9+E7PF6UqIfFBnfL332MqxluPr3SvCjb
         ffzN03QUOv642Rv5j0YlF6uQ1ZfDRleJwcbH3UvrD6ZuoTIvQwboRfOKvt2dG4F45TbP
         Zy7qO7WDXurHAUXfum2FTpVmFWjvQwH/+paaPRuGmrA06Il9FphLiSItxxhAI7TZdfWa
         /zOw==
X-Gm-Message-State: APuU4Z8njbwrnq19AFvzXMTF882uYWKZJQ9M6XEHMt77gD2DcEu7UT3O
	CWHex580lBhEt8BZDlDg0AOu2h2ktVeEApN+jZ01tAI5r/cvkAhajmfzUip8NA==
X-Gm-Gg: AYBFou3rfYaKlZAMldXuK+6tfF6Qsab55hU2aQmh2PT2qEySDkuNxu7PDf+nlJbpQFi
	0mGA3EpTkgMItkAbd296rDGi5S8WDNEkG9NkxMD3ToeeS5HNO3Y+18itQNY8Le5pc0feVAv69ue
	PI1FnPfbEBa7ohlet+YQKA1d0BFMCRBPvCh2MBqce5uf/fGN2xaN8sE7FVgkYChFe4NgeRGb73Q
	DTYVpNJtMGSfDCJL5vx0lVMdpaW/FZV7f9e9ihZs04RnspOB1JGOxu/SG/2TkQ7WoFY8hBjChQf
	k3p9TYI3UfuK/433qPmSA1YVM5GTJ0vZ2m5VsjhF8fGFZEFW0Cem9QUCKk5ivyfLsnKJKDoVNTM
	f5UDQqDg1Kag07zfh3KXbpk8xw4amZh2E8F1tl4Wk1IjLriUYT0qR3cjCLd64KdAvHuKcfZd8iy
	O6udXNkb0jmBR0mZIFcNp5X590POlG0/HsAuKpXAlFSE0ediOmdIYSw+iUH9z+fnt47YK0v/Xy6
	amGRDyM8Go+x6TT9o7fxorBtphFfdyJojX/FXB5ePkfwH28Z7OSqHiaj/kIiuclzDAha0whADdI
	8jyFNPsGXDwcq34g/q1rK5V8BWReN3j8tF6eEGwMp1ThTGW+Xpli8K8jog2I/fEooHIvNjXThry
	QsnAYcoZmDmuEPhZv75Y9GBaUoy+a8VRvOQm81R4u4JL/1OI0Fk6iJQQ8YkUTwLxLrYGwgE2Bew
	==
X-Received: by 2002:a17:90a:f495:b0:3b1:bd6d:fcc2 with SMTP id 98e67ed59e1d1-3b1bd6dfd26mr2280797a91.40.1794698730705;
        Sat, 14 Nov 2026 15:25:30 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1aeb3d2d4sm10281607a91.7.2026.11.14.15.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 15:25:30 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next] bpf: Quiet two smatch warnings in the verifier
Date: Sat, 14 Nov 2026 23:25:26 +0000
Message-ID: <20261114232526.2727027-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
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

The kernel test robot runs smatch on bpf-next and reports:

  kernel/bpf/flow.c:2758 flow_merge() warn: missing unwind goto?
  kernel/bpf/scev.c:5350 bpf_widen_scev_regs() error: we previously assumed 'reg' could be null (see line 5336)

Both are false positives. flow_merge() frees the state and returns. The
label err_free does the same. scev_reg_for_write() returns 0 only when it
has set 'reg'.

Use the label in flow_merge(). Test spill32 instead of its copy in
bpf_widen_scev_regs(). No functional change.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/flow.c | 5 ++---
 kernel/bpf/scev.c | 2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/flow.c b/kernel/bpf/flow.c
index 99abcef86920..5341f95c5072 100644
--- a/kernel/bpf/flow.c
+++ b/kernel/bpf/flow.c
@@ -2755,9 +2755,8 @@ static int flow_merge(struct bpf_verifier_env *env, struct flow_set *set,
 		if (env->log.level & BPF_LOG_LEVEL2)
 			verbose(env, "from %d to %d: within\n", prev, insn_idx);
 		err = flow_cycle_closed(env, &t->st, &s->st) ?:
-		      flow_unite(flow, s->st.flow_entry, t->st.flow_entry);
-		flow_free_state(env, s);
-		return err ?: 1;
+		      flow_unite(flow, s->st.flow_entry, t->st.flow_entry) ?: 1;
+		goto err_free;
 	}
 
 	flow_sweep_trips(env, set, s);
diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index 733394a21942..5648beca3931 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -5333,7 +5333,7 @@ int bpf_widen_scev_regs(struct bpf_verifier_env *env, struct bpf_verifier_state
 				continue;
 			/* the other half of the slot stays as it is */
 			reg = spill32;
-			err = reg ? 0 : scev_reg_for_write(env, cur_func, r, &reg);
+			err = spill32 ? 0 : scev_reg_for_write(env, cur_func, r, &reg);
 			if (err)
 				return err;
 			linear_bounds(scalar_of(reg), iters->max_header_count, &coefs, &bounds);
-- 
2.55.0

