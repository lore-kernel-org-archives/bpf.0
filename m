Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B50837DAAC
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 04:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782879674; cv=none; b=euLrPAdAl+hBTqNjZvjbb5evkZf7/A24l/iNqFlG7F8/ZhiuDDn+G1pCoZEeGT8yfITSWP489eRh0Fq26RVEprO2exem0Uiniykopef+2R4HKeMR5wj036mutx0OgPF/tWNPCkwHBsP8k8wSxTjegdsAjj9g58KTZ8KwcapavZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782879674; c=relaxed/simple;
	bh=ndidOr7I8IHgvxf1AeP1Ck+0PatfZjEXy4LWSt++W30=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=aWV/a+INeC/cnWrypQEULdFHrH/RlRuU4J1DmHKCKJz9qS+CE0qP4qda2sR1mkPMZHHnyV76zO14aRE6Kkx0MAnjvmdM9QY792HRP4tviVwr8L9uyiwCUfgq4HjHyhzr/33XNYOm+jZbn5XVki7X5kPpHQ7hLSDuFC2SuieiImY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=dKtmCoE+; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="dKtmCoE+"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2c82538b6b0so1281095ad.1
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 21:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1782879669; x=1783484469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wIXJacBAyEaKz61QqT13AHUcLwATDSXxJV4uZgWwmww=;
        b=dKtmCoE+cMY+ae/6a2cuOy+r+DPt6J+S4DxJSxhCK/iVk2m5G8zm0VFeoSMS++ijC8
         ZikwGoEKOiyIGXH/IwGqj2V3NbknCEcKa93vP8AMlFJfJIzRpw4PF+yRwt5swNe64yCy
         m8RhGaagOMQX53X3qrgHwEdkmNXf1zbFkYp4UvFI6OerLariet9nHvlCJipDMGvI8O+a
         Qx/5LCScOL9uAio4n0vbpSdNIsot8E59GhGqTIAzcvR2/gQXPZ1FHiPinOZj+rU1Hapx
         YsbNN9SrRkWmJfaKblaBkGbluEZP2ZAqaZSrYdIrNkNt+6xAQbcROLCv/dnKIX1J6FbZ
         dNLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782879669; x=1783484469;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wIXJacBAyEaKz61QqT13AHUcLwATDSXxJV4uZgWwmww=;
        b=j07A+S6H7Yil8XzBP/mNY6cHcqQT4n1JBHEzpBfobcw2B0N2X6ElImPFJ29H2jNXrl
         +6u+7xGON6kTkYI2D7cgMqD0N3+j68gtvSRpJw3K4uxVLkUqNqgWJP3FUg1q50u78Yn/
         S345tff0GWjGoHQrddbYKjs9BhSZEdYsdA09S1wzCas07en2L9mxvt04dcTShJhmWhx+
         Nqic5KF/GFwnhofv29IIeIYqECTthW8oKMjIW3KehFKDuRb6IoNGAa/7VfGFIjVJtlpZ
         I6R5+ipwoCBFv2OPn+86sVZoFQsNR5STK4EHeQyQDA39oACLHzlifEMfr/u6x4bCTMhV
         6HUg==
X-Forwarded-Encrypted: i=1; AHgh+RrycMHX5ov5I+gJmYexfPxix+IMbgyknLV47W2gmsDYNETE4CXe40rP4oEEHOvBcyhhK0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT3pBWHwQUQwXS3gaZozqfSyUqbq973OHlrZkNpejWUHfT54oj
	mTSwXIlcP+iKLwLG2Me7UEoFc8jVyMcPcYEQMlogHtkXaVbDpSBvVcH+V5C8I1W0wgI=
X-Gm-Gg: AfdE7cncUUl7V3bdj6e2g60Y1XYD5zoHY4g1ZGn4luhWwVZusUnTW449CRBumPtn0kx
	0qft+imtuei+JsDTaPlbiWsVeipYgd7sPmTp9qwIixtwBCjwzWKAgcuF3XSZtS7F5UsfgbtcMPN
	Nx5J18zt5/sM6G8yaqOq++r4UtCpGukq3GdROlejseRIE1VrUCf8bps3497i/WD68BrV+hD4gup
	srVfj4sWzXTsG6l6onkdS/s6Y4N+Ksb6sZP7EvglrT7z2NR42svA1M4bvfRB112ctctzvLFAd+7
	yNz4+cV3LX0ZcxwE7/VTaFpD9M1NCCUT2uZMKgWGunL9M4c6PXFBIxTeo+z2iVh28esLBtgm7rM
	+w5ctsQno8i4ON2KwTvLZ9jv1h/oXP6qIWelWjPXReACDPuJlr09loy7pECoVzUZ7vr8bLGEq7p
	0u6tq7EcP6gMGq1qQ0JXzkMYofbLP8OaYCYHQzg3HC971mxA==
X-Received: by 2002:a17:902:d54f:b0:2ca:e3f:6a4a with SMTP id d9443c01a7336-2ca7e73b1bfmr1201915ad.21.1782879669155;
        Tue, 30 Jun 2026 21:21:09 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca37c73a9csm24450865ad.21.2026.06.30.21.20.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 30 Jun 2026 21:21:08 -0700 (PDT)
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
Subject: [PATCH v5 0/3] riscv: improve percpu helpers and PIO mapping
Date: Wed,  1 Jul 2026 12:20:38 +0800
Message-Id: <cover.1782877663.git.cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v5:
- Keep the PIO helper fix local to RISC-V: drop the generic
  HAS_IOPORT_MAP dependency change and the generic ioport_map() change
  from v4.
- Add the missing linux/bits.h include for GENMASK and BITS_PER_BYTE.
- Fix the 8/16-bit LR/SC fallback to mask subword results before writing
  them back.
- Use early-clobber constraints in the 8/16-bit add_return LR/SC fallback.
- Fix this_cpu_and_4/8 to pass the intended operand to RISC-V amoand.
- Initialize the secondary idle task pcpu_offset before starting the CPU.

Yunhui Cui (3):
  riscv: io: avoid null-pointer arithmetic in PIO helpers
  riscv: introduce percpu.h into include/asm
  riscv: store percpu offset into thread_info

 arch/riscv/include/asm/asm.h         |   6 +-
 arch/riscv/include/asm/io.h          |  26 ++-
 arch/riscv/include/asm/percpu.h      | 287 +++++++++++++++++++++++++++
 arch/riscv/include/asm/switch_to.h   |   8 +
 arch/riscv/include/asm/thread_info.h |   3 +-
 arch/riscv/kernel/asm-offsets.c      |   1 +
 arch/riscv/kernel/smpboot.c          |   8 +
 arch/riscv/net/bpf_jit_comp64.c      |   9 +-
 8 files changed, 326 insertions(+), 22 deletions(-)
 create mode 100644 arch/riscv/include/asm/percpu.h

-- 
2.39.5

