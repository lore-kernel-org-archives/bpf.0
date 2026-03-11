Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398EC348862
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 01:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773191479; cv=none; b=Ee3/T4nhbRGI5DsBm9g23ttsf6NOunZZbmMUWERgzfZV7it05jDp6u3G6lyV0kmOaajQfBdcL1xVgUHnYjtHTBCvxbNpJMsIw8UvhANJ7gY8p9qQ7by3OaC3fb9jQqukNwbrdrMtX1nvP4rEPDs0P0YV2O7f9GdQ6lkgQBIl0gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773191479; c=relaxed/simple;
	bh=xRti5EEReDw0VdWADEJbgOf2M+xzmqlsWtO1DXiwm9Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rpKJ90axubghx22hbx+ZJqFGcx5+Zj02nTbvauCiZBMA6NrYt6fCe+B1wbfXBNgAdqtMKzXSMvgpCAtP7Vn9qOvzwD67W1lEySZsOSzBAB+/Z4o9DMEyVuKgEeuTRUkf9xJFNeLJe9Os0rl8xuLf7+pc6i3VxIJgVEMNCEm1Guw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FFN/QcoI; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFN/QcoI"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8cd751a4e93so266216385a.0
        for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 18:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773191477; x=1773796277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gmbF7efx3b0yltcFa+ORkKamiOCfc4jWkPAR5jL1S6E=;
        b=FFN/QcoIplqNV3x9h1QbxSh8wxxHaMaamLfeZM6Na15k7yiqBXiJ0WBtMskQM1zLh7
         i2W7aKMeIRuTdymTDBwHgihWuy45xzDyNCAQx25rOYIoBOmGfnIThYRSzVsfiIICJzb/
         cftcwhEQ7oclQfNsS7ylhDktzBbpKBImGiXb58y3D0W7aFfUm9ESul9KRt1oXtTGz7gL
         /BnJ3kXHUDdSZ1cD/7W4VaodO3sKP+2RxkszMYUfKvZoOr8ALbQrStPH5ka7VoNBXT5V
         SS3r9PyOLtp9+XoTlbGAiHJPOkeIwONUSIe9OEZwEwOrE+M5G2NLDDzVtyATiRRS+8E2
         vOqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773191477; x=1773796277;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gmbF7efx3b0yltcFa+ORkKamiOCfc4jWkPAR5jL1S6E=;
        b=X58Rr6ye0zEkKW+Sw3AOU9cjT9JDWvTG6Fu29+A4Xgb4rweEYMH7e4sEJromvQh9rt
         qTfrFlbwwFZWhMj8mk27T4DR3vqai92kOnMpCceL6LtaIyyc6N4TXZGx87+48nRl7qXf
         Yeyy2obcbzY3Ovi/itMPrK6TsfKf4G6ep03ujnL61ECztJRySxacAkKG95//ZWZGEbys
         zdIzULoFlBPVcpObM6nEYuIgzARDYxsSd/IJfg2XI1Ej479xJcXaPZRtcl9CfSwJMioH
         5VOu4ZsErYGwE1sUpN1XFCd9WKbrlDSCD2ulBbQAPdB0KRYncEiEaDLbEkR+OsQPf+8l
         V/+g==
X-Gm-Message-State: AOJu0Yyy9jga+7ZOpP7SgT6E0yFC1/6wnttZuPX8jEqSccwHNe8ajzi2
	bbeo8yLvl63IHJ6YCJJq580A2eGAZ3vSm04RSM41htrj0ndPBXTw/NjegQzUZWls
X-Gm-Gg: ATEYQzx3y9wEjXDrw8MpP59AYfnCFh9gGxCMTxesln+5HwXZNXULmc7Cr6zLptk5RBE
	Jklg/IwxkLMSRWt4bro8bJlzf7s8V2+ksXOQfoS9OTZMm1Yxgs06mWlLTF655kCEjCiNJQYNPfv
	tUNDhlKsCgj8w5h6qy/N7fIrWpiNMFQqNabJQNnbIdv695oYED4w7jtxdtA3RJMkB90QN8cV2O2
	cDHCUvS+jYhi6xbyePb9eBzGDT00f5oQ2VHJ/YEzInsdye4uTZ4adxv2pkliC390NJA6Zt5fTKU
	n58qe0xUCOLPFfise59KTAP1hYU8t1Eoj2eu6G3Vy71VsQMbPLQAJB+5BlWLnTYvnOV4cfEBQiV
	MWGpMM2FdwvvSi902ou7UU3Tm05f21VyaQKrHJcAqP6pgcWWiqJ/x1JN9foRGnJybL7Ynhgccvo
	KdoIrgcz9eN1iz5gsVymeWzEbv/aurDtbFjw==
X-Received: by 2002:a05:620a:29d0:b0:8c1:ab1c:f2da with SMTP id af79cd13be357-8cda1a737b1mr121859585a.70.1773191476981;
        Tue, 10 Mar 2026 18:11:16 -0700 (PDT)
Received: from 192-222-50-213.ll.local ([192.222.50.213])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda2148400sm36451685a.39.2026.03.10.18.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 18:11:16 -0700 (PDT)
From: Jenny Guanni Qu <qguanni@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	ast@kernel.org,
	andrii@kernel.org,
	mykyta.yatsenko5@gmail.com,
	yonghong.song@linux.dev,
	jiayuan.chen@linux.dev,
	lkp@intel.com,
	Jenny Guanni Qu <qguanni@gmail.com>
Subject: [PATCH v5 0/2] bpf: Fix abs(INT_MIN) undefined behavior in interpreter sdiv/smod
Date: Wed, 11 Mar 2026 01:11:14 +0000
Message-Id: <20260311011116.2108005-1-qguanni@gmail.com>
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

Patch 1 introduces abs_s32() which handles S32_MIN correctly and
replaces all 8 abs((s32)...) call sites. s32 is the only affected
case -- the s64 handlers do not use abs().

Patch 2 adds selftests covering sdiv32 and smod32 with INT_MIN
dividend to prevent regression.

Changes since v4:
  - Renamed __safe_abs32() to abs_s32() and dropped inline keyword
    per Alexei Starovoitov's feedback

Changes since v3:
  - Fixed stray blank line deletion in the file header
  - Improved comment per Yonghong Song's suggestion
  - Added JIT vs interpreter context to selftest commit message

Changes since v2:
  - Simplified to use -(u32)x per Mykyta Yatsenko's suggestion

Changes since v1:
  - Moved helper above kerneldoc comment block to fix build warnings

Jenny Guanni Qu (2):
  bpf: Fix undefined behavior in interpreter sdiv/smod for INT_MIN
  selftests/bpf: Add tests for sdiv32/smod32 with INT_MIN dividend

 kernel/bpf/core.c                             | 22 ++++---
 .../selftests/bpf/progs/verifier_sdiv.c       | 58 +++++++++++++++++++
 2 files changed, 72 insertions(+), 8 deletions(-)

-- 
2.34.1
