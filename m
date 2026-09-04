Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B413418A54
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 11:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788520671; cv=none; b=MqH5vuOPhjb/YDTDWzeGus8oxgDzYyTno4MpfKjEM25AqGsKk0IdQRd+oKh99HF9eNTinGovr2DEDTxpTTpXA/vf+lFNVCmpPvGRseY2tH+3Zg5lsDYsSBkCwKkEnKW8sAAVBdY//WTNtT/KHfXg5p64U3VvOV0ldEjO00StgTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788520671; c=relaxed/simple;
	bh=E9dAA287EAa796HT4oYolBExrYvudPnFnaT/QfU9o4c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NSFK1NgKz4AGr6rtQwLCornBtv6o9Ir7I7eLx1n9g/h2hpYNI4pWeRVMXGZvA+CaUlwB5fz3A5Gq6BsoKDrOyba9hOQ/ysTitpq8bhW6WVPA55pYG0blwLarNy5rI/MvmR79Zh1MYs8t4njePr/MbnOEXOMXTMO3rt+HtjdQQZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XVDrj7Pa; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVDrj7Pa"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-53031a57d7fso11114991cf.0
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 04:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788520668; x=1789125468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vafBG36yRum0S5znHILZDEuOCiOJO9YS/m791zdYti8=;
        b=XVDrj7Pa34xc1K18ZwRIzoktLg1gJUg8H04sMZk6NQkfXa15MGLszHXP+KYriVR/Nf
         Z9FF5jiEBxN+LZ2+lU8H2abK5aH+ZhpHXJmLaGG6hTucxiFQ4Zmnk3+wuOEf1hMiqN02
         WAr3ioRTbMyFFNF/kLfr2/kp7QoL23wpmmfRHMrhhx+hsJLmixggLs1lG/EnPLK0FbPL
         vVoXsR77sSf1tnX2d8o+yJLtGYmbqcU9eflK2hAbpz//ThhcO2Q999kKI4q43rlqx0yL
         d792zloAOF+8gtYeG728F30ouFyyZAs9bAY3KILS5UWKgJXQMwBioZ7gPZ+gsTnKQKjF
         NKvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788520668; x=1789125468;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vafBG36yRum0S5znHILZDEuOCiOJO9YS/m791zdYti8=;
        b=ouA/4CCN6PAh4YE1JuzZg0l8kvDF8VwV+Uz+rSGIPniFsbbLWAxIDjy6VE+2Kd0Ox9
         /7si/TO3NZ832X9rantch4/RUgyHiihu/BOQZImU4s8DXOZEKmjsVoZmoQ4r7bexHHG9
         VixPfpKvjco/1GhRJYRBsxTsYfxb94B8GWX8UqLpTg6E6KdeKNdgx+Q9u85ZJAvd8axO
         JavTFPnYMLrfHcxwMCWB047uD7vmUdLqljOQp6OPxSb1Se6MtgpIt4NR1Y7gWEwILDIE
         zSGCpVkzRYSMj8/bwDihHaRVmtUiu1mTQffx1SPxDsq2VNiu3spBt05IatEa5nZLnh/L
         7G2Q==
X-Forwarded-Encrypted: i=1; AKwUvBzLMNK+rCldNCoecmI10nnCzDGh0bRMOKj1lZS6ersqOYJH/3rTbM4GEozIRaezM3HQXOw=@vger.kernel.org
X-Gm-Message-State: AFuF++lyDErhayYP+jgjK4CMd4559gAStemmL/K/Xwr/IgfPX3Ym91/A
	NhVR8FtS0AvXr+Cojfy0dpEpvKkFCfaZVpBxyGYtDbZ4LHhm2Ln14UfS
X-Gm-Gg: AYBFou2TgKtBFddoHatjSgUji8eHHFYBjTEd3qwmEe+glhLr03f00GtPXUn9zkkRYKY
	zqR7Qx1eqt9uePq7FvjPJFPkfzswBrHMOVC6LRjK/BesezWchKvC8mCKcy9E8RUKsD/RDG3Z0hB
	SZbjASJ1xJOzXOYm/jLQ7S/LlKiwXJoJ6GKgOOaPJeU2NJQ9Zvjt/6LVvFl9tHDIcyi56OkFI4e
	EDzT+huHguHKmlfyCuU2pBsCsHgNP+YX+8aWVvk4hXfhH7jLzDDlay04IK+2EcNGldN88s8EVGe
	SlVnOZUf2K5Nko8cXO8g5FHr+3d3yN2/x+tEb1ZSKwKOl9pfvVsOSeMy+msTSfC/Mlorn9UZ/Ij
	9IB/M+YfQnTJQCsg/WUhoxg+8HOdhEwIhZS1x3NBhHe8ipptEqVdeasEi5bUuU9SmYAgrLo2+xh
	wQt832LIAV3lYElqHKqj3Swq86uuxMEwffyoamOZVhV2gNBLvr5WVr4Cdr
X-Received: by 2002:a05:622a:144b:b0:530:430e:8f10 with SMTP id d75a77b69052e-53054a34eb9mr50348541cf.47.1788520663162;
        Fri, 04 Sep 2026 04:17:43 -0700 (PDT)
Received: from Turin ([187.15.144.163])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5305402a8fcsm18350171cf.1.2026.09.04.04.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 04:17:42 -0700 (PDT)
From: Nicholas Dudar <main.kalliope@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	johan.almbladh@anyfinetworks.com,
	paulburton@kernel.org,
	tsbogend@alpha.franken.de
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	bpf@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 0/2] bpf, mips: Add BPF_MOVSX support to the JITs
Date: Fri,  4 Sep 2026 07:17:29 -0400
Message-ID: <20260904111731.673341-1-main.kalliope@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MIPS32 and MIPS64 JITs lower register BPF_MOVSX as an ordinary
MOV because their move paths ignore insn->off. The instruction is
therefore silently miscompiled instead of falling back to the
interpreter.

Patch 1 factors ALU32 and ALU64 register moves into backend-local
helpers. Patch 2 decodes the MOVSX width from insn->off in those
helpers, keeping MIPS32 register-pair handling and the existing ALU32
upper-half paths inside the move operation.

This is missing architecture support rather than a regression. Core
MOVSX support arrived after both backends, and the analogous RV32 change
(c6a08afdfe3a, "riscv, bpf: Add support for BPF_MOVSX in RV32 JIT")
went through bpf-next without a Fixes tag.

This series can be applied before or after the in-flight SDIV/SMOD
series. Both are semantic prerequisites for MEMSX. The ordering
discussion is here:

Link: https://lore.kernel.org/bpf/CAJZwKkis=3NGw9At0WfiZaRYEoMPbQfqJKN0e+vtRDvp4VY5Ng@mail.gmail.com/

Targeted MOVSX and MOV control testing under QEMU Malta covered MIPS32
R1, R2, and R6 and MIPS64 R2 in both endian configurations, plus MIPS64
R6 little endian. All 180 runs required the JIT and covered the baseline,
helper-only, and final series boundaries.

I also ran the complete unfiltered lib/test_bpf.c suite directly on the
final v2 candidate with CONFIG_BPF_JIT_ALWAYS_ON=y on little-endian
MIPS32 R2 and R6 and MIPS64 R2 and R6. The MIPS32 profiles returned
1036 passes and 26 failures; the MIPS64 profiles returned 1035 passes
and 26 failures. All five MOVSX cases passed on every profile. The 26
remaining failures were 14 SDIV/SMOD, 8 BSWAP, 3 MEMSX, and 1
JMP32_JA case.

Existing lib/test_bpf.c cases exercise all five valid MOVSX forms on
MIPS, while verifier_movsx.c covers the generic verifier contract.
No physical MIPS hardware was tested.

Changes requested by Johan Almbladh in review of RFC v1:

- Group the 8- and 16-bit cases and compute the shift from insn->off.
- Move clobber bookkeeping to common emitter tails.
- Avoid early returns and use emit_sext() for MIPS64 MOVSX32.

Other changes in v2:

- Document why width decoding belongs in the move helpers, the supported
  ISA floor, and why other MOV offsets cannot reach these paths.
- Run the complete test_bpf suite directly on v2 on four little-endian
  ISA profiles.

v1: https://lore.kernel.org/bpf/20260819010523.1057789-1-main.kalliope@gmail.com/

Nicholas Dudar (2):
  bpf, mips: Factor register moves into helpers
  bpf, mips: Add support for BPF_MOVSX in the JITs

 arch/mips/net/bpf_jit_comp32.c | 60 +++++++++++++++++++++++++++++++---
 arch/mips/net/bpf_jit_comp64.c | 56 +++++++++++++++++++++++++++++--
 2 files changed, 109 insertions(+), 7 deletions(-)


base-commit: 6655c409707ec8ce9ce0850ffe4fe02331fd4d9c
