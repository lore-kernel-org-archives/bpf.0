Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A3B2E7165
	for <bpf@vger.kernel.org>; Thu,  2 Jul 2026 02:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782960916; cv=none; b=F5iIpE3yTcbzz7OWQXBxrffYZrtn9ddGrrrC9PuwUaSGDbssbutTgHDiwsxC1PcEqEPmlZFHD2gWlfD/UwLw1sRbLLEuYdPYrEisxi4QHLOQ9qi2NAJo4amF+mb+fOO6X/N0XhwmjTksPHmq7mNyXMceI9TKkNB7tMnM+M4PTcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782960916; c=relaxed/simple;
	bh=pGDpUoR+YVfr0eRZnyVNQJ79pTwqmoMZJvjcbiau6fI=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=DDlCHprf0SbW4mjAIyiIyFNsUa6ut7x4XZzcTaIO7UvvQSnekUStyvh1ASAtLH3oXW9trnlgj2ikFGyMpxMp++Y39NhrivyPjTjv46FqIVoozZZDyWyNHIf5Le01L+SltndghIBOfEa/EsAHxVJQY5D+SjJaFFsBx7XjhYE8RoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=fQpWPuvH; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="fQpWPuvH"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-37f816d01e3so1219312a91.2
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2026 19:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1782960913; x=1783565713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bzv59asYaYM1r1NY8KtOkB7QhvGiD1GkLe9qJuyqT78=;
        b=fQpWPuvHjzNRmEEQ5HlNmHfVEbP9DLJw2+BGRgF3E4LLjGu3bKVBcWPmYvFls4rXJP
         TMNM4jxHhxqG2EUlbSu8m+L+FN0x56z80IPEoWEBTdUWPIsulnWbNI+ZSBGZ+9xtUMtn
         C6NnMvRSTcEq/HJuBZ+SFI6MlzF0LGCrei8z4yEjMSWQ1nETxVzStD4LURfsID165aUP
         OhXqhI8Rl6FJPI/Fij2bUyvldq+8BDCJItEBZKODRQJUyRq9lCFH2n/8OChviM8YHJ72
         v/0cS/vYQ/f4MhWykVWiSU5/K44a6aDRLyZc8FAkGARcQXqi+pcBJfp39TLpFqtCWGyU
         IYVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782960913; x=1783565713;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bzv59asYaYM1r1NY8KtOkB7QhvGiD1GkLe9qJuyqT78=;
        b=MmdJGnnmBywquPHbVC8UIgXAywxo/bp9ixsRJdJuHNYBqgs+kfjT+hWaqRbEp3xMcu
         cumDFwbnfCjm8ns9HKGnYy+pDlaNxrFASAufVb8LQ1V3CedhjWOJnoR5kFNkFL4n+AGk
         T1xqr5beHU3i6flR65+F1bbyaTJh5pZ/7SjUCifkexzffVgiAcGVukgBF1uklQBaURAk
         aibMfzKOp9QBWrCMeMyv7s5YWSOMVXcelnG/J5cBbvvGFMO2KxW/ywIqZDq0FApuS0Jm
         XFcYwA6VnvFvl0vNTCa7X8RPgz6NaZTU63mfpTTVh7tzRhe3nC/SZmZvTFAhfjdwr0Fs
         0+Sg==
X-Forwarded-Encrypted: i=1; AHgh+Rr1ZIU9bNr5bJDRYTGaQEtWNAtACVzrs63WEaxJmmRczuwXR6YDdI9QB/vZrsMOyhT+w9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYGErR3HcK/f7QiR1BpQuQ30yDoQ15bguM5zOIOOUuszOO008i
	EwsgXGuR51MPj9HnKjLeEUkDfbeR+KQ5lnIoYqcCW3Z1+nNeM0EO96N7aQfs4MyV780=
X-Gm-Gg: AfdE7ckuIkIeo8rJEwbouTVnkynI640WPW/4gpmmWsoPcaZyq+CVywzjRAzqcG0qRRI
	H6Np5yrztS3qB8WxnjmA21lEr7FBf+0dUQ2GQyGcVbaMLrswJvQC7LoCllzo+hAslQoqNZuzo/G
	ZBm+8jpRaeGKKOUpKrixHxgM2LsLmcvkCU/oaf8c0kThHLwLP8sjpoDkjoeiGs4j/1eicHj+UfQ
	sJynoyQr3oIvjFpQ22nF0tkOsqyhlIMdOTafhZWawj7O7i445CAwV5n7w1j9unNFC0Kwim58Di9
	ZLfhPqRqEa/6UMUddg2UjBaieJelU2qhMC1zoBK4ebB+L4mcq5A2mdjagQzKcNMLaEj95pFOeIV
	a1nKjgCcdsPxpVGdER7NQud1N/jdzY746ZAh0pJhG2sRj7GTnXZ+PT9A0vzZQHwYRvFVrXz5ATt
	NVriD2VhOi0Gw/u7F+Dx1scSZF/7+Gg9LH5y1SIlaiwsdDC3SOmidQX9Hp
X-Received: by 2002:a17:90b:580e:b0:37f:f89a:a1e6 with SMTP id 98e67ed59e1d1-380a9e38790mr4709918a91.0.1782960912995;
        Wed, 01 Jul 2026 19:55:12 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bb80f5csm4358686eec.15.2026.07.01.19.54.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 01 Jul 2026 19:55:12 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	dennis@kernel.org,
	tj@kernel.org,
	cl@gentwo.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	bjorn@kernel.org,
	pulehui@huawei.com,
	puranjay@kernel.org,
	thuth@redhat.com,
	ajones@ventanamicro.com,
	ben.dooks@codethink.co.uk,
	rkrcmar@ventanamicro.com,
	cuiyunhui@bytedance.com,
	samuel.holland@sifive.com,
	zong.li@sifive.com,
	conor.dooley@microchip.com,
	tglx@kernel.org,
	debug@rivosinc.com,
	seanwascoding@gmail.com,
	andybnac@gmail.com,
	menglong8.dong@gmail.com,
	cyrilbur@tenstorrent.com,
	wangruikang@iscas.ac.cn,
	atishp@rivosinc.com,
	apatel@ventanamicro.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	bpf@vger.kernel.org,
	arnd@arndb.de,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com,
	qingfang.deng@siflower.com.cn,
	linux-arch@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v7 0/3] riscv: fix PIO helpers and add optimized percpu ops
Date: Thu,  2 Jul 2026 10:54:40 +0800
Message-Id: <20260702025443.83389-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v7:
- Address the Sashiko comment about inconsistent AND helper naming: rename
  the RISC-V internal percpu helpers from andnot to and, and make all
  this_cpu_and_*() wrappers pass the operand directly.  This is a readability
  cleanup only; the generated operations still implement the same plain AND
  semantics required by this_cpu_and().
- Undefine internal percpu helper macros prior to including <asm-generic/percpu.h>
  as recommended by bpf-ci/Sashiko review. This prevents macro leakage into the
  global namespace and has no impact on generated code or runtime behavior.

Yunhui Cui (3):
  riscv: io: avoid null-pointer arithmetic in PIO helpers
  riscv: introduce percpu.h into include/asm
  riscv: store percpu offset into thread_info

 arch/riscv/include/asm/asm.h         |   6 +-
 arch/riscv/include/asm/io.h          |   8 +
 arch/riscv/include/asm/percpu.h      | 300 +++++++++++++++++++++++++++
 arch/riscv/include/asm/switch_to.h   |   8 +
 arch/riscv/include/asm/thread_info.h |   3 +-
 arch/riscv/kernel/asm-offsets.c      |   1 +
 arch/riscv/kernel/smpboot.c          |   8 +
 arch/riscv/net/bpf_jit_comp64.c      |   9 +-
 8 files changed, 329 insertions(+), 14 deletions(-)
 create mode 100644 arch/riscv/include/asm/percpu.h

-- 
2.39.5

