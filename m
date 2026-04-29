Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADCB392824
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 12:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777466130; cv=none; b=NVraSgKQ4NmBMQe1C/HvFT15Oj8r0R0XdG6KoCZVuix85w2ni25625THWwsqbFkymaz9/edY+v23E98OqO6hD4EgzE9P5mgs1r/eMjokiPAHN4Sfi+T+4ixn8UoSH1peZlPr7cdlEP95dRISaXwLeDvOmOtevTnX56we/KEQTgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777466130; c=relaxed/simple;
	bh=13+JLLoZ1Hg0KlvJTzgFeoD3QrJ58AaLVxqe7Odzv4w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p/06ufshxSAxzxFjUTnCZiZIR0LRsaxGXVkcb4ttzzwfUoMMPNvdCnmAhwwLEZyM0eiEeNn6f42YdTLOt0dBwgQbfpPZ+jK6IKzmdDTxnWMo4I8hiC4vhPGuzkpUt7kZBJ9TYfLXFaR5LQbxtD939LhDP7q9M4jOgbR2Pv++WVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQLFwWhI; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQLFwWhI"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c795a47186bso354773a12.0
        for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 05:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777466129; x=1778070929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JgQqfgYWSA68LM6eambu1VWNYKMusGRf22zT6tQJHig=;
        b=mQLFwWhIMTifSFV2/+ImVdTRdw5/BlDkZ86Eoy7R7uKd7oEAHwmGyIcIqPtJcjd5Tr
         eHygO6wcFCEb27LN0vbXlJ16PHINcdU7YNYmUFE8BzOLi9ZwOsxu6XcqqESxrkTxH5Ua
         hfQasBvRkpJKm9r6iWFcX84A35diR/OAihA6UabGg94f0+ITqq6EGvyIpKiic+BdST3x
         XSOju40n7J0PR/x11Isx6wKGOXIVunrx/8Yl3+253kfXFdM2Ik1ygXhpf93FCPGxK5lM
         sxV/QgwCGrRZ3YMKaZ4Ul3imWcNy6eXkZqEyMWx9Br2aSoy8mwYoIF5Qg12+3wTPNq04
         BQfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777466129; x=1778070929;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JgQqfgYWSA68LM6eambu1VWNYKMusGRf22zT6tQJHig=;
        b=EBX3amcq6+wC62kw+exmEGBF73nGO5y4S6lyEOIywAcDPTlpsDa3Al1Km0VDS+dPRE
         pNUJdH6OhCDKpl10rdChYzXV2DtWFJRc8iSW8b/Hd5+2phXJkVL8RkGUe7i0qROpxkm/
         2J29JsbWgDX8u/N32pivKF+Mpp7/F0F5fmZZTHAl2QSJFfTFsM0V9CuZP8KqpZDw1Aeg
         tNpXz8oktg/HH/G3G6OXn5ew/hcG3aaGBfYOIFXlDdAFHDUaw4P+jPmdDGikCyC2JlKN
         sLciA0EoIbNPE1BBx/FkGa/TM1qhPPvj+s7DlrvcHStVIGoeb6wYv+lFcn8/zjRrqLMI
         vs6Q==
X-Forwarded-Encrypted: i=1; AFNElJ9pcaZe7rDFwk6zaoZ5QXy5F4SEBQTY+0/mMo18fdbRcSoRkPm2Ci3hVFrWHi7XmnJV+0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBSRuMU1DCYlTgCgmjK+R8PPt1l6RUuDEEEOq4e74vOw/YCnID
	F35wfKMl+xk2y5NphQL413Z+DE+69IcZiJmCgxTnOQutQdvx4cyXAon+
X-Gm-Gg: AeBDieszHzR+e78Uc3Uo9IAmfTyFlHlHJTECsVYmHv8ZsklKERk4Yt8Iabf4ajlS6aM
	3KRWpPNaLkMtXp29Jw7vAYfq0lYDglNak8bqwQEZm1PsNap73w0iUPpmzyzrfqjD84wY3MYAv5m
	PMf7OuwjVFTsboH8P8bvpICO1DwHmb2Kw7MaWoP2n2n10+hgMKRThfyr+rZvI/s1rxAxIt/wTeF
	YiyaamcIB+/NcoDPU89B/hlczE7lawpj8mcXTwkOsitDvgzmSusb61j257i2DUac2CnzCNXNr+B
	0D2KYKB7riYPT/91fUDhs02eBG8kDkJzWSTaKFhoZmlbm5or1vafrZj2Tj8QID0awRNiBuMgp72
	FuuxHqmwib/j5vJshPGnAu9Xk+B9JZCBmFm5tKHwMnM4eNe7w4AFCWJpI6kLleJeJdC4KJYn07b
	UF0TZ9BMvgA0LlizePbTLMPtE1GZHH1/9BhraE9fc4vD4sPwVKERRaF4syrZaxD8tjUE50KL9nc
	SQU0noWWLRURHi7+sXj2YSE1fhPuoWth0KPAmeCxxM0
X-Received: by 2002:a17:90b:2711:b0:35f:bc9f:e1b6 with SMTP id 98e67ed59e1d1-364a247db58mr2292751a91.1.1777466128927;
        Wed, 29 Apr 2026 05:35:28 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com (32.237.80.34.bc.googleusercontent.com. [34.80.237.32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364a419c9a6sm2261855a91.7.2026.04.29.05.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 05:35:28 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	luke.r.nels@gmail.com,
	xi.wang@gmail.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	alex@ghiti.fr,
	jserv@ccns.ncku.edu.tw,
	eleanor15x@gmail.com,
	marscheng@google.com,
	bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH bpf-next 0/3] riscv, bpf: Fix signed operations and add 32 bit atomics
Date: Wed, 29 Apr 2026 12:35:10 +0000
Message-ID: <20260429123513.3477780-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix miscompiled signed operations and expands 32 bit atomic support in
the RV32 BPF JIT.

The current implementation ignores the instruction offset field used by
the bpf instruction set to specify BPF_SDIV/BPF_SMOD and BPF_MOVSX.
This causes these operations to be treated as unsigned or
zero-extended, leading to test_bpf failures. Fix this by checking the
offset and emitting the correct instructions.

Additionally, we leverage the mandatory A extension to natively support
32 bit bpf atomics (and, or, xor, xchg) by mapping them directly to
amo*.w instructions. BPF_CMPXCHG continues to fall back to the
interpreter.

As a result, test_bpf.ko now runs with 0 failures, and the total number
of successfully JIT'ed test cases increases from 843 to 902.

Kuan-Wei Chiu (3):
  riscv, bpf: Fix support for BPF_SDIV and BPF_SMOD in RV32 JIT
  riscv, bpf: Fix support for BPF_MOVSX in RV32 JIT
  riscv, bpf: Add 32 bit atomic operations to RV32 JIT

 arch/riscv/net/bpf_jit_comp32.c | 98 +++++++++++++++++++++++++++------
 1 file changed, 82 insertions(+), 16 deletions(-)

-- 
2.54.0.545.g6539524ca2-goog

