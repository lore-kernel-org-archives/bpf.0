Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FFC36D4E7
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 21:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773093553; cv=none; b=ThDKyLiXSI2pkeL1433LutLGAKTxfaZAAmVG6wsrsznvICQ3/LmKN1vfjIVaxH2rzuxuaABC/kzBjuQCg92GfffVIbM0T24QbySetKK/MuSZQEXklz/QPb3fXFnpWcrJOK13yfgcGMF+us88JTOrz/eFjVZT8UDnmfkJNqM+56U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773093553; c=relaxed/simple;
	bh=aivqgWCIZLWoDV8ui/S/7KUwP7kLd8upIbkbAFxy/Ac=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Zmc+HfAWCMpmFs4mygWIU2xIVNoR3YMKOcPzlbnS6bCifGRe25jhTU6Q3xE8GN4xBr6U7TBfCiHpkfgLTkhLUxnzGW3alYWjbfsNhiqGbrY0qFWsZ1NKEG18qG9Lbs6POgsNfgkbgiGJyNoENCXf03Hb8aiCMvqIwADIAgKkTmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HVHT8CSU; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HVHT8CSU"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-899fac9caabso121877766d6.1
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 14:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773093551; x=1773698351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=++bA5XZ6GqCnmZTzgtLXtegF9ONuWJ2ljz9jaMPSmQA=;
        b=HVHT8CSULT5lV6AUvMdz8hFGZyx79gL44LmC6bWWZNoUpjMsH+OQMj8MHO144aGSbS
         MrwiQBo6bS1wDlE09cFGYI1S9LZMVm0uK+dFrsh2cdvVjYtpz8T5pb/UXiSlyOuzL4nJ
         nPtTw7iauF+pAf9psTGaC/ndbEHEjj3L4rEE1UH2k4DdTmh/Jcx4xlBVSYpKGRFBbxpq
         e1mme6BmOP0aC2mSq0Oc14nSsjjWFVFrwHugQ/vLkJRa7VIiFmGsaROnWWHeAgA8HOvw
         NgiXG5UsaHdX/ty5+tlM3f9cghyH2PmUexKm2rDCfn4F+eKR4MbyDsxe1ynu9dZW5D+x
         ILXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773093551; x=1773698351;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++bA5XZ6GqCnmZTzgtLXtegF9ONuWJ2ljz9jaMPSmQA=;
        b=Yn3Vyp469f6NfUfjxswdi3aB2I7EdbGrHV5O7h9KyDT17JJFvs2Vy1IKQoOmMSA/TN
         4NdF5+UbMKG2uFvPAkaF7dQ+yJ1wDQhsTvFXJjROXhpF58nvsV2IW9lrhY6LZVaA+aoH
         pdK1bHeff60iUSlmpLhsjkZkWNNnoBFc6FANdzbZsNbGPthPdKCY2DVdnv9gvsv89lx/
         INj9FRP1nPdPWus33y1ISD8Jsnc3ejoLh6PJyAmGp6SqbJnm772sebwZg0D7KkDApOF9
         5P81POw/JxPEYJYHcLbzhGq7VtF2xpqHsNSKbBLLsRSoJFX3imDvPHe9x8AlbaLoiFQl
         tf5w==
X-Gm-Message-State: AOJu0YxwY1EQ58lPLMTbWxHWFwfCu/FRWV6Rzs3ZaYQK+EnVoXpPNZMi
	d1FbnjouzQa6BoF8vwXNNMWfI1XNiP23q7/Zv2JiFETd//ZaJ5+D3TPDpNN3ckwK
X-Gm-Gg: ATEYQzyWXVfW6PrAndTiLmjXPeSZM5pOcCu8RfKRCCpzRVKbVD8BRX8yyU9LMvAbXhQ
	VxuXg9o/j7ZxqYQXWqwHi9uhktvOwtSQXCFK8O4u59KIIh41pl/2k57RwEDXmRbz5kx9/n2744p
	4JgDKwtDdii3PY0YIkZO0hRrIZwqP+o/u1l56BkRmH6TQ5eQVmvP3H6PhjtRvIcegvxPpyDXnO1
	M04V4uS30OhbDKOvdvaMQaLZ4i5o2Obn1vuaP2bjUZ7DwAXZ6JPqsswNGbiW9ChWz/skC94jtuK
	vZ52XckaAnA6wxj04rSDAaWDYQRo+UpNwb5RtltcB/hvQjTtzNzMe+7ZNkY2rw6gmVNs8Sn1CYi
	H5xffPyLbcsHEo/k+vkFPLkB+jOkcbjIQmT8afu1awNQKzhCtkINt6ovzKYSOPigPyvsFz/PDt5
	ucGY3Q3HYcJBSOKHg+e9Mg2wRx7gjtsCY0Mw==
X-Received: by 2002:a05:6214:21ac:b0:899:ac2b:6ddc with SMTP id 6a1803df08f44-89a30b12491mr197345076d6.62.1773093551111;
        Mon, 09 Mar 2026 14:59:11 -0700 (PDT)
Received: from 192-222-50-213.ll.local ([192.222.50.213])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a57c34a59sm6134856d6.45.2026.03.09.14.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 14:59:10 -0700 (PDT)
From: Jenny Guanni Qu <qguanni@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	ast@kernel.org,
	andrii@kernel.org,
	mykyta.yatsenko5@gmail.com,
	yonghong.song@linux.dev,
	lkp@intel.com,
	Jenny Guanni Qu <qguanni@gmail.com>
Subject: [PATCH v4 0/2] bpf: Fix abs(INT_MIN) undefined behavior in interpreter sdiv/smod
Date: Mon,  9 Mar 2026 21:59:08 +0000
Message-Id: <20260309215910.4131143-1-qguanni@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BPF interpreter's signed 32-bit division and modulo handlers use
abs() on s32 operands, which is undefined for S32_MIN. This causes
the interpreter to compute wrong results, creating a mismatch with
the verifier's range tracking.

For example, INT_MIN / 2 returns 0x40000000 instead of the correct
0xC0000000. The verifier tracks the correct range, so a crafted BPF
program can exploit the mismatch for out-of-bounds map value access
(confirmed by KASAN).

Patch 1 introduces __safe_abs32() which handles S32_MIN correctly
and replaces all 8 abs((s32)...) call sites.

Patch 2 adds selftests covering sdiv32 and smod32 with INT_MIN
dividend to prevent regression.

Changes since v3:
  - Fixed stray blank line deletion in the file header
  - Improved __safe_abs32() comment per Yonghong Song's suggestion
  - Added JIT vs interpreter context to selftest commit message
    per Yonghong Song's feedback

Changes since v2:
  - Simplified __safe_abs32() to use -(u32)x instead of special-casing
    S32_MIN, per Mykyta Yatsenko's suggestion

Changes since v1:
  - Moved __safe_abs32() helper above the kerneldoc comment block
    for ___bpf_prog_run() to fix build warnings reported by
    kernel test robot

Jenny Guanni Qu (2):
  bpf: Fix undefined behavior in interpreter sdiv/smod for INT_MIN
  selftests/bpf: Add tests for sdiv32/smod32 with INT_MIN dividend

 kernel/bpf/core.c                             | 22 ++++---
 .../selftests/bpf/progs/verifier_sdiv.c       | 58 +++++++++++++++++++
 2 files changed, 72 insertions(+), 8 deletions(-)

-- 
2.34.1
