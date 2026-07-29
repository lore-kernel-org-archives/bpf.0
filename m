Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6380546D2A5
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 16:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785342591; cv=none; b=k3PM7RGNTI/XcV1rpIgkchaKrAmI+hLBZWcZETNNNfUIFFgMnpH2BivQQmd5lS4LoIbE37YrTqxp2yCxlc8NBJKcrdgV9+DbZFYavfOurFqyPj29gWrLW11+1QsJ4nRv2M6wm+kKiZ4qoUbLqsrE20txzlsC3SNWIEBzDjVbh+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785342591; c=relaxed/simple;
	bh=R3lUFwXzA6Utc8Qmizb9zVXH9qJGnpDmVVKh5fC1sUc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=OLGmnghiGX2b26pcCts2/wr/yRUvKMn6MvP9JaeZZgoUflGH6hL57uCxEXXRX/SYM3V0jt4mCBIp0/P0bMBPmcqerkv3PIvyvjb2Ph8HEsYi4z7I6DRiK63FtSUCXwgxgFpsuawuo7wb1JiHKwvRPJYPhC6MwjNtoiufa4ZGF8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZtgYFZ2e; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZtgYFZ2e"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-92e54f8c051so64721885a.3
        for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 09:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785342585; x=1785947385; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YaMgBKE4IT7GHc8dKZ/bu4hutKGY9j/cGc76tkbN8yg=;
        b=ZtgYFZ2eWkhuGGMDXhroyuZQI8hwTLcYaa8NSDzBk/kmSztyCwiu717evu5D7+0BH5
         WT5zfhitoDa8VfsNrqEF0E8zuE9oNVkx2wQGOZ3rob8i51GIrbxBxXUiNAWIUFaFSZp1
         ozjNYHCL8wYdr23vxXnzodUkgHWXs4TDYga8YQdxQVXx5kWWW01KJqmP7koxHODzlmw9
         26uWTsCMg4lhoIEz4INiu/HFFNb82WQDtz0HhJD+/b5OsRQaBLbFiyKJ3n/UUps1Knzl
         B5G9nCJtS8kb0j2jLO1Rg83B9pcT69DSeAomPb031V3oOhzEHwS0ejS+4kEpsxnD4LPB
         PhTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785342585; x=1785947385;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YaMgBKE4IT7GHc8dKZ/bu4hutKGY9j/cGc76tkbN8yg=;
        b=QJwKP0zlkTKskg0KdxxVQ+Paq8iIvXdrwHSXSLLceGdVeoEsL5yv40G715sn6MuqGZ
         ltf3Qwjp4lDY5MuAuz8x0mNNHtBhX7JpLcXEujgkvvhejJ9NXclYy8NfRZX/ix2Zs8Ot
         rC0z8Mx18UQn2oCbT29OPGmEGRRs1kAX8VEV9GU2V9y1sS1jRFnCOWAHx1KGM/Ef2Ri0
         HTjvoQ1tkxiZToKbHOxmDJ3C8umR5sP5pXxF7doekg3yHcf7o34eZ+vZMWvuoK26VLqs
         GzCS5ww4r8x08LfFR7u2X/PuHkBzfK+fwCdduiD67OMuy9iGUzyELS/mBruTCWmTeyRJ
         C08g==
X-Forwarded-Encrypted: i=1; AHgh+RrX+roy9mAnZBnlBp69IQvXGbMGzTo6d43PsHG8NIRCuNKr222l244I976BPBDg0iauYV8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0Zq6RI7lVW2/fmI5DPFTW4EBTV9NI4qeOkYpM9FllcUcvAZsC
	4pOrxXbWJ+LBOoG30PRETQjzvcNWsdSKdgSL7JSINbL0a5+KXYWVwflt
X-Gm-Gg: AR+sD11J5LxLXTLlsknm5pMk1KVGNNuXJnzvuXwtWfduv5yG6g66V19GKroQVGVa1n3
	T1p4PNwf/T4aSbMVcc6z30o1SvhqH+fe4HpZmA5NaDKLJRkOgQThqctLZJeDOOsp7OeVrphZcbC
	bPP4I6aWt7vYko9vcG7oWwC5Qd7fCkSS/BHmX3/wtA6FuiORYbbZRAuSOln9sRYRglvS97RSqdg
	GRmkhpp4HMWZ5YFrulCe7U/tZot20abNXozrNnEXCSYKFtnMdK0vxIUs+SY0pHozXkKZ9S0bVn3
	noaynmL1y76rjD9amzqEULiQ3VhDFIjfnFivO7xZVg2kVAGboBbseujUJ4WWojotg9MGmgRCCi0
	C4YKTXL2mwGE0EISXcpu/8v1SsNnWvQIWKI122I3PpsVIv0mdIqfjpkAixHfl+m9F/FbiLBgH1B
	ZCu4f0JXx2nZNQFEz7JCxxDcv2+sh/jSlI3SUQkaHUv9vF2CLtwPYt2919lQsFV4+xBlBL1VaGp
	9yPwg==
X-Received: by 2002:a05:620a:284a:b0:92e:bd6f:b166 with SMTP id af79cd13be357-9330266c55emr706970885a.63.1785342585335;
        Wed, 29 Jul 2026 09:29:45 -0700 (PDT)
Received: from localhost.localdomain ([187.15.144.227])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-933e7318180sm201745885a.28.2026.07.29.09.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 09:29:44 -0700 (PDT)
From: Nicholas Dudar <main.kalliope@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	tsbogend@alpha.franken.de,
	johan.almbladh@anyfinetworks.com,
	paulburton@kernel.org
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	philmd@oss.qualcomm.com,
	visitorckw@gmail.com,
	bpf@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 0/2] bpf, mips: Add signed div/mod support
Date: Wed, 29 Jul 2026 12:29:29 -0400
Message-Id: <20260729162931.2369353-1-main.kalliope@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The MIPS JITs select division and modulo implementations from the BPF
class and opcode, but do not inspect insn->off. BPF_SDIV and BPF_SMOD
therefore use unsigned instructions, or unsigned C helpers for ALU64
on 32-bit MIPS.

Patch 1 factors division and modulo emission into helpers. Patch 2
uses insn->off to select the signed instructions and helpers.

Tested with test_bpf under QEMU on MIPS32r2, MIPS64r2, MIPS32r6, and
MIPS64r6, with CONFIG_BPF_JIT_ALWAYS_ON=y. Patch 1 produced the base
failure set on each target. With both patches, all 16 SDIV/SMOD cases
passed. Fourteen failed on the base; two already passed. No test
changed from PASS to FAIL.

v2:
- split out the div/mod helpers as Philippe suggested
- use an unsigned quotient intermediate in the signed remainder helper
- rebase onto bpf-next at fdec474c65fd
- test the base, patch 1, and the full series on four MIPS targets

v1: https://lore.kernel.org/bpf/20260716211055.2569433-1-main.kalliope@gmail.com/

Nicholas Dudar (2):
  bpf, mips: Factor out div/mod emission helpers
  bpf, mips: Add support for BPF_SDIV and BPF_SMOD

 arch/mips/include/asm/uasm.h   |  6 +++
 arch/mips/mm/uasm-mips.c       | 10 +++++
 arch/mips/mm/uasm.c            | 20 ++++++---
 arch/mips/net/bpf_jit_comp.c   | 53 +++++++++++++++++-------
 arch/mips/net/bpf_jit_comp.h   |  5 ++-
 arch/mips/net/bpf_jit_comp32.c | 30 +++++++++-----
 arch/mips/net/bpf_jit_comp64.c | 74 +++++++++++++++++++++++-----------
 7 files changed, 143 insertions(+), 55 deletions(-)


base-commit: fdec474c65fd35d5a6e1497ed50a9f98c07192f0
-- 
2.34.1
