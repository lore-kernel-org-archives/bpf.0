Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94FF2BE05B
	for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 17:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769187934; cv=none; b=PMDUuQD8zpaD/zA6/PLS6WjenN47cJ4MzuhSLe0IqUTlWdI7AAyuvOrdaxQL8dhMWnTKGqvkY8fqnh0YTKIPgUffRbh9P/yBqw2zQevfaIBimkIvXKTvjo2fWqikGu7BUhOVdxSfWjBqzW1314B2OW8+ZF8H86fNPw3omhVURNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769187934; c=relaxed/simple;
	bh=dYBtLZQZSXmjttUMkUr69cwe/3Al9p+VVefAv8iNiCM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JD+ChN5eXzrcyUyqGSXXG48McvLqdJJU5hkw7J2tJyzWf+lHSrYCBUWgwBMlFqJBKRz00Z65gtdczgD6nsPjHH0PJCSwqh861OECet/WKPvPTU/b5mdnZhGBtQs6Mgtg7Ui7kic7G6XWndEDv5b0eu3zoic1/fqRaVycdy1Tuew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=KXvPPUmU; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="KXvPPUmU"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b884d5c787bso365014266b.0
        for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 09:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1769187931; x=1769792731; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hpBi4zuZaxY+L1YIyml9GR1d7OYtXHDSWry/Nv/uf4c=;
        b=KXvPPUmUGa068dBMkukVQYd4yPgewJMj7bEEI+I4qFk6guahu76vGGhE7aDUv54E+j
         qQMKRwSGnp7xjDanEExGiS7eHtfe9VIL6B0AvEFijvbeigOn/DjcGRca+HJInosuFqkg
         hxtlYTiTFeGmfdDelj7CVRCCA2210bCUSfZP8ROQs2IH/xXQovc7Fx4xGQ36R22Y830L
         hxzOqRi+gkkzq+WduE5t1i3SutgBawhHVYpQHro7S0OEtJcKu7GkmWVno+U5NwyBn9cO
         tKpmkil++H9Y2NsaWD0rsZ+OeOChB7MkAIXDUp/QSG3Qg5tdegP0WNO2S2je9E/DL1yw
         PTEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769187931; x=1769792731;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hpBi4zuZaxY+L1YIyml9GR1d7OYtXHDSWry/Nv/uf4c=;
        b=kccifSWXd2RYDzP4ekESph5ZNNHHhqnLfmcLJoOCm1upJ1O/EDd5kzqcA9POkkLx5z
         Kxbe/L9jL29HaAa8r/Pra3TIp8+GQQlZIQqBew4IapolikOWTJiyBEnCzrt6Ll/d4RRt
         JbLhBIz7LTZMczScgoe6aCTxnBcU8NUTwWOsm35UzWvsGtVnc1SgRs69oZV6NGgLNk1p
         FK8AVwfjjPPef6/2gDdwdACCHTTznlkmh5vacZ2vPMszqkkmgYmx3vQYFElIxFfw413C
         ypUmvtAQLwPxbfiGeFruoEmebZN+Qfk4scz/PJYxhPtUiCTgRJjfVpu0g5R9rx4o3JZc
         WRIQ==
X-Gm-Message-State: AOJu0Yz+xNrduK/3Pr5BY3cxjPzKvTs7RgGPn8nX3z4J+CrQhPZCBQvm
	zQ2LheX8g1NEhrlajjrb6rP9t7QS/Pfdd2eZD3vZ3Wu7vrVx1DYx2MokKFbIKeAyXPs=
X-Gm-Gg: AZuq6aILrJ+ylrPf46ONjVfd/G8YsV/Zf4ei2QZ3s0L2RPD4oIjuR2GBEgllk2CdBR4
	VX76HtDZNEQAdEeq+pnsV22VNbsdTOV+DOIJwp9lsOJAoRKFlc3eaU3QYk/6KVeB78hrYlaE4tx
	OCcTPf+JPlr08i5LrSXvPq7hIPuQTV1+EDVmtVANERoHEsDWBFiNdlZkCTzXMISM2leFeZg/tPc
	SHXy56ZtAevjzLveAOBEJD2cHZE1mFuNowmEfHlaBzWnEQKwdu2BoZbJnZiTucZ0PUvQwm4d9u7
	9ca38Q3jEQ0fDEGg5sSEpDskARzyPvoPsFC+ZEEbhxOIkW1gAx0HkXpa2vrNDU/gTs1+GKh1m5U
	fVsBIH4/m63FTUhGLK9mXTODgjgAbEHFuCyeHCRzlQLisa0MDhXobqYg4ICcOsPoxc/psv8pYbv
	n2MgzUWEPmIutCvTigGfgnhUGp5dIXepcLdSy7qzih9Z6FkErkYQs=
X-Received: by 2002:a17:907:3da5:b0:b87:2471:def3 with SMTP id a640c23a62f3a-b885adf4732mr244050466b.55.1769187931127;
        Fri, 23 Jan 2026 09:05:31 -0800 (PST)
Received: from cloudflare.com (79.191.62.3.ipv4.supernova.orange.pl. [79.191.62.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b885b4184absm134752866b.27.2026.01.23.09.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 09:05:30 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Subject: [PATCH bpf-next v2 0/4] Switch from kfuncs to direct helper calls
 in prologue/epilogue
Date: Fri, 23 Jan 2026 18:05:17 +0100
Message-Id: <20260123-skb-meta-bpf-emit-call-from-prologue-v2-0-0e50db4d4663@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE2qc2kC/42NQQ6CMBBFr2Jm7Zi2GCyuvIdhUdopNLaUtEAwh
 LuLxAO4fHn5/62QKTnKcD+tkGh22cV+B3E+ge5U3xI6szMIJkrGucD8ajDQqLAZLFJwI2rlPdo
 UAw4p+thOhEboSvLCSnlTsF8NiaxbjswTvsOelhHq3XQujzG9j/7MD/9LVf+lZo4MSTZSmvJaM
 CMf2sfJWK8SXXQMUG/b9gFpgPJA5wAAAA==
X-Change-ID: 20260112-skb-meta-bpf-emit-call-from-prologue-d2c9813f887a
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Amery Hung <ameryhung@gmail.com>, 
 netdev@vger.kernel.org, kernel-team@cloudflare.com, 
 Martin KaFai Lau <martin.lau@kernel.org>
X-Mailer: b4 0.15-dev-07fe9

This series enables direct helper calls using BPF_EMIT_CALL from prologue
and epilogue code generated by verifier ops. The goal is to simplify the
calling convention and remove kfunc support from prologue/epilogue, as
suggested by Alexei [1].

Patch 1 adds the infrastructure to mark direct helper calls as finalized
(already resolved) so the verifier skips the imm fixup.

Patch 2 converts bpf_qdisc to use BPF_EMIT_CALL instead of BPF_CALL_KFUNC
for the init prologue and reset/destroy epilogue helpers.

Patch 3 removes the corresponding selftests that exercised kfuncs in
prologue/epilogue.

Patch 4 removes the now-unused kfunc support code from prologue/epilogue
handling in the verifier.

[1] https://lore.kernel.org/bpf/CAADnVQJ=kmVAZsgkG9P2nEBTUG3E4PrDG=Yz8tfeFysH4ZBqVw@mail.gmail.com/

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
Changes in v2:
- Swap patch 3 & 4 to avoid selftests fails on bisect (Eduard)
- Rename is_epilogue flag to finalize_helper_calls (Eduard)
- Untie mark_helper_calls_finalized call from epilogue_idx (Eduard)
- Drop review tags for patch 1 after tweaks in patch_insn_buf (patch 1)
- s/__bpf_base_call/__bpf_call_base/ in doc comment (patch 1)
- Link to v1: https://lore.kernel.org/r/20260119-skb-meta-bpf-emit-call-from-prologue-v1-0-e8b88d6430d8@cloudflare.com

---
Jakub Sitnicki (4):
      bpf, verifier: Support direct helper calls from prologue/epilogue
      bpf: net_sched: Use direct helper calls instead of kfuncs in pro/epilogue
      selftests/bpf: Remove tests for prologue/epilogue with kfuncs
      bpf: Remove kfunc support in prologue and epilogue

 include/linux/bpf_verifier.h                       |  1 +
 kernel/bpf/verifier.c                              | 52 ++++++------
 net/core/filter.c                                  |  3 +-
 net/sched/bpf_qdisc.c                              | 76 ++++++++----------
 .../selftests/bpf/prog_tests/pro_epilogue.c        |  2 -
 .../selftests/bpf/progs/pro_epilogue_with_kfunc.c  | 88 ---------------------
 .../testing/selftests/bpf/test_kmods/bpf_testmod.c | 92 ----------------------
 7 files changed, 63 insertions(+), 251 deletions(-)

