Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AFD443A94
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 19:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786390949; cv=none; b=pspR/niX+31uaeqCpfw3O8ajgtKlMhpI7nbnJjKSF0/vXzCmATDOYmPSTKFo9867ztxM0Cz9aPMI3VR1fF3L9bE6C4Qd+ZGeUW2CuuJPseag0PAE128sRNmPH4nfrEAmxVWtsTb95hKShcDnkAciEuLaIAVt+u2t5EHbwgHFjLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786390949; c=relaxed/simple;
	bh=ivLu/toBesZnDcu5PR3r/U5A/PlpJyTfP1Kq/7WmGYA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=g1EGZMpzTZWhRVaBFO2mPaMf3rMUlY0iZy/eTnBLNnG4kKNoFGxMZ3S9FUuj6qrdrMN20FTmhcV3G2+WrW/kjN/Ml7LeYZHtWC1oby/jG+f8f6j+6cVKD+ML9eqOm9AF8lsZDlKlMUgXqs6OrkGkG//ZfEnE7Gu+gAvrpQHmkHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j3J/LJen; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3J/LJen"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c160420289bso244020166b.0
        for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 12:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786390943; x=1786995743; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2CFecp1st7SCw1iqmiI6hGKB24VM/1GF4mkGVwlRlzc=;
        b=j3J/LJenz6ixCW+X06KaEZ7QmiT60DJVMEMY02gtEGtFEWFypCpUQ9E0mRk55ZVfik
         AKxUZ+1UfTJ6pto3HvAy4el8o6LAW2Yi5Yq1wa4jghWQAHkSZVez6IjuhY8coM25wNrF
         vEpCtct0BE3RmSdUJxgbsv/OltbKJnMDuLHClgz+VYsr0GgKAxwnCUG3FErfh2tg5U8w
         dCvRLpQeVYKpv6Zuxm+gt4hcAT7hnip8RfjrZrjZeff3UZDl4j1sbVfHJBbVKf8f4pTR
         eQJKY+riXbyJ2tB7mbmnrZcZqesurdbYn6VQrL6HW0QSi477tXgSAwgZ4hOee5YtOYow
         RcZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786390943; x=1786995743;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2CFecp1st7SCw1iqmiI6hGKB24VM/1GF4mkGVwlRlzc=;
        b=bwLf+4dIVqd/smAk5D7FHqbfHa1Z87o8OJUxzfCBIxA3r8Q5e087H6ZbwI5eSdLirK
         d1s53mX8gLXJaxI40dKyYQncQjDcVcuiz0gUwNTYL5qSGtAudUePD+YaW753xgtZ2O5r
         qQwoQDI7NYPMJVbFZtyVkwhjSO/ISI9W0ZW/xvQzMMfSPn8+Ct+Gqd9buEhi9J/E56u6
         z7HrhoRwwv879J0K9ML1a9BZxixAgA7L5sNmiZwYjJNQu8m9nnwASDBHbJYjPa8BP1kP
         LhmK6WKnulKXe3kH+zpEVF9o9gAXp5cNaXMrgmL7WbrlpMMV6eLalvgWtb3bOmp89dvL
         VJCg==
X-Forwarded-Encrypted: i=1; AHgh+RpqUVNWF6I7cQ5NsxmYEuAW5REt4ZXs2nahEPEcoM/Vw2Ls9oIoscho8oMYmDfDQZJNm6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxML7kse8GdkZKCGIdJ20295tP1/Wf87NE6Bz8cjU7ZzUgJS9J
	1w2Hfce1WTdS7GCjvq/YHVjWOt3EhTCo31anJKAyatanE+75ovKP5Px8
X-Gm-Gg: AR+sD130owG9pVGoUsGNAukUets5qOevW2uxCv54QL8UYz+atcNDKa/rEZklWd9nD0p
	A3yzwX47XjUhzDEDcU2H1RpFOlu37CO25fLG/Yrn3yQeApZg6m24Gdgffsw82i2YRMryCY5zO1V
	pHzSUsyq/3wz5X+j1KmZBZ3xmRnoFQ2/OiT7RoJcMnNpVUVP5H9uRjxv748YS+qJd02WnWhOhn1
	tiEPnDbEn/bzReqBS2GW1H7enzShpYnfQPs8s2pKi80CEY6vxB5PWafoLDGqUf9V7NfUuRpg8CY
	IZD14oh1R0xGDLuMWGPRdyoFNotpEjj4KfQqAXvbFSRJ8lh0bIKptp7Z1g0GIJpyLYc+oP08Y3a
	my2TF2iRJxdlVbtLRzmqkrMCGQdiloLnQU59MA+aF09rHbGgZxlp47NXAuecVTJM7cBtpoMHikr
	M1IjHZ6N3S+M8u9nD4zyIv4t2subohhKt8n57rapH4aOkWDgzz56ReNshmHZaxad/nCxCjPU9lK
	qM=
X-Received: by 2002:a17:907:c719:b0:c20:af9d:4544 with SMTP id a640c23a62f3a-c20af9d5499mr565645966b.6.1786390942924;
        Mon, 10 Aug 2026 12:42:22 -0700 (PDT)
Received: from TurinLinux.. ([187.15.140.84])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2080a6f414sm430309066b.17.2026.08.10.12.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 12:42:22 -0700 (PDT)
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
	bpf@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 0/3] bpf, mips: Add signed div/mod support
Date: Mon, 10 Aug 2026 15:42:12 -0400
Message-Id: <20260810194215.3754591-1-main.kalliope@gmail.com>
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
class and opcode, but did not interpret the opcode-specific insn->off
value that selects signed DIV/MOD semantics. Negative operands therefore
produced unsigned results.

Factor div/mod emission into helpers, add the missing signed uasm
operations, and interpret the raw offset only in div/mod-specific paths.
On 32-bit MIPS, use signed 64-bit helpers for ALU64 operations.

The base, each intermediate patch boundary, and the full series were built
and run under QEMU with CONFIG_BPF_JIT_ALWAYS_ON=y on MIPS32r2, MIPS32r6,
MIPS64r2, and MIPS64r6. Fourteen of sixteen signed DIV/MOD cases failed on
the base and after the two preparatory patches; all sixteen passed and
remained JITed with the full series. A big-endian MIPS32 base/full
comparison produced the same result. Because patch 2 extends the shared
uasm interface, that intermediate revision was also built with a microMIPS
configuration.

v3:
- split the generic uasm additions into a separate provider patch
- propagate raw insn->off and decode it only in div/mod-specific paths
- keep the signed remainder quotient in s64
- add the requested short comments to the div/mod emitters
- refresh onto bpf-next at d114bb989367
- add intermediate-boundary, big-endian, and microMIPS validation

v2: https://lore.kernel.org/bpf/20260729162931.2369353-1-main.kalliope@gmail.com/
v1: https://lore.kernel.org/bpf/20260716211055.2569433-1-main.kalliope@gmail.com/

Nicholas Dudar (3):
  bpf, mips: Factor out div/mod emission helpers
  MIPS: uasm: Add signed div/mod emitters
  bpf, mips: Add support for BPF_SDIV and BPF_SMOD

 arch/mips/include/asm/uasm.h   |  6 +++
 arch/mips/mm/uasm-mips.c       | 10 +++++
 arch/mips/mm/uasm.c            | 20 +++++++---
 arch/mips/net/bpf_jit_comp.c   | 55 +++++++++++++++++++-------
 arch/mips/net/bpf_jit_comp.h   |  4 +-
 arch/mips/net/bpf_jit_comp32.c | 29 +++++++++-----
 arch/mips/net/bpf_jit_comp64.c | 71 +++++++++++++++++++++++-----------
 7 files changed, 140 insertions(+), 55 deletions(-)


base-commit: d114bb98936770c501c958bf2bc5fb6b7c0bad7b
