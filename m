Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0709765192
	for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 00:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783988786; cv=none; b=MnDoYO3qIaR3FbEd9pTRDqo3EqpGhCMOoEB4xd752ySQbObv8VO3XumKZOgrD25R+A2ZZmGmHDZ04CD/UYTDOHWxtxr77lrSZ21LQK5iHh6lmigt++Duq8LASyw7XHBd/vC3rGc1nFm+4A0wE64IqYB66jGwE5vVh9Y6Hz41sm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783988786; c=relaxed/simple;
	bh=bOzNWk8bNtDn/8LSHTmj7FrMfRMlqCITIhamJeT6gLs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GLzv1bOjuldhGyBbmF8ajV+8lx5ZiR934mOeU8So9F8xee7v0MEVFrtcaGhzZpj7CgBPs2rzv1Boh5j50ZG3olgxWX5Msgf4Hq8viG8xrCA+1bmufjhyERAS//eusP9dI5kYe8YQ6cP6WdUXuPy07exX55XrIANPOIubeN9O+GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kaLiQajW; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kaLiQajW"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cedda2ce6fso8762375ad.1
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 17:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783988784; x=1784593584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6LIPldVf2eYY4ZzOEEdAQlLQd7zeaBceJuQKY42PJtA=;
        b=kaLiQajWwPlrbw9Yg8V2OnEFhARqft4M6yqzc8rGW1IFGlubwL0n3MAIaCqAZvT2DE
         s/Wy8ERIg5UPT1cw0aHkoeH33q0bTxjOLgp2+3YlVYelYYwVzuhv4TjmQ27qNQvqZBMr
         8scYUs8vvDPEFjhWw/7XipIRdfrR9xihigVRAClpqjcSIGJqRSpceXumydJttM/oHWFi
         eW2nua1lGZuqQ+P9hqHogmdUgv3C2nOAnD2C0Yq3u1RVkzEZXBs60HKA+aiYt6/EzhiE
         9ZeTJXK6xYH7akysmTqx1gF99te8AtCd54zgz1mTqnEysUfTpI0T311mPRiYrdHJqp19
         Yc3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783988784; x=1784593584;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6LIPldVf2eYY4ZzOEEdAQlLQd7zeaBceJuQKY42PJtA=;
        b=hjGZKEXdAqckqO0Ga0zeuG97aaa6C1xD4JE2mVCQIa1Zc7RhLhQEqHHxLuxEHHuuxp
         gNYD4tgV4saifPls3z51mrB2vbU6N0edpC0RuPOMSwZeOV40u0fD/39G0Ke8QzUgNqFn
         Ica400MlonEUBJ5UCLkl3AX6rhyyHEKze838NH9UgytMu4nyZTPFWzVMofjTVrm6pEb7
         o4J0Qnad0ZbFpSY7bPfwXySAPkG0izVTMW5QeEYeZw5uZFU9Jis400DZC8hQg8ykkkPo
         sW8r6sqdXGkWTYJWR8mMcDL+hSLfTakaNHa2pHQr0w9dkoFtWi669/TDI4qTWKabVHq9
         23cg==
X-Forwarded-Encrypted: i=1; AHgh+Rq30mtuCTtCvGukNBqTxM4udiR2uDyx2/c9CHhMk/DWPVYzB11O6hw44ySrPUCKx9Dw7sw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4T3Ym01nXVZ0CGzV+BvNvbA9orOkuDPuQm2x6j04Fp2eYWKVS
	ZHKhVRQ59Z56RqN9Bt7HbEemh6zAILokkBRUFfPFCrBB4rXAyFpI7WcK
X-Gm-Gg: AfdE7ckhgnPaa3Ee9MtLkoL44qn+G4jbAZZWch1wO8AF0fjkVRrpWRb7iGWFWXQ6vq8
	91XVicpo4LsBTDkTF+csiq4oRksEf/2NUhd/GBhsvdBCzwRdP4hj/LsiTmbK/xO1H0I7L1sy7Zb
	iMdrSpmgeSj8OlKmlqr9PB1yaSwuMHSW9sSL1mkC0rKWmahj6hlx5hQG91JBdUzW/34PmcG0zT9
	VToJC6jZUiZWiX7StFrIAL90uRRe8daI9rxMrcDqsyznqVime5lk1RoXX5CG9qpvkI+jS6bjQYO
	9vzHA3CQQ/mleWybaHeh0phfi1oRoD2qe53DA29lQj1F0cSiy2OLWgLKaN7RypPMMOQGvWNAlGI
	lMP/GlnBhT+0G6YCAzJX/vhLdWK084tLxcXIaNB6Upy70reqXrqTyZpCRAww376bN58ZUnmj5+9
	4RliziT9z4OI73FryAvCPObcHtGDwNYdyHqKkAylf35/rwPd5VORkdsEC38aTfA8YO0gLAtYF2y
	H6v+FqIv34dRms=
X-Received: by 2002:a17:903:2c03:b0:2ca:c01e:8837 with SMTP id d9443c01a7336-2cef143b095mr1026595ad.24.1783988784157;
        Mon, 13 Jul 2026 17:26:24 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com (131.197.81.34.bc.googleusercontent.com. [34.81.197.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d1edb0sm105796545ad.53.2026.07.13.17.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 17:26:23 -0700 (PDT)
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
	aou@eecs.berkeley.edu,
	pulehui@huawei.com
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	alex@ghiti.fr,
	jserv@ccns.ncku.edu.tw,
	eleanor15x@gmail.com,
	marscheng@google.com,
	bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH bpf-next v4 0/3] riscv, bpf: Add support for signed operations and 32-bit atomics
Date: Tue, 14 Jul 2026 00:24:48 +0000
Message-ID: <20260714002451.4091139-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for missing signed operations and 32-bit atomics in the
RV32 BPF JIT compiler.

The current implementation lacks support for BPF_SDIV, BPF_SMOD, and
BPF_MOVSX, ignoring the instruction offset field and treating them as
unsigned or zero-extended. Introduce support for these operations by
checking the offset field and emitting the corresponding instructions.

Additionally, we leverage the mandatory A extension to natively support
32-bit BPF atomics (and, or, xor, xchg) by mapping them directly to
amo*.w instructions. BPF_CMPXCHG continues to fall back to the
interpreter.

As a result, test_bpf.ko now runs with 0 failures, and the total number
of successfully JIT'ed test cases increases from 843 to 902.
---
Changes in v4:
- Add a 'dst' param to emit_bpf_atomic().

Changes in v3:
- Pass insn directly to emit_alu_r32().
- Remove the Fixes: tag and update title.
- Consolidate size, mode, and off into insn for emit_store_r64().

Changes in v2:
- Add missing Fixes tags.
- Fix memory ordering by emitting aq=1, rl=1

Kuan-Wei Chiu (3):
  riscv, bpf: Add support for BPF_SDIV and BPF_SMOD in RV32 JIT
  riscv, bpf: Add support for BPF_MOVSX in RV32 JIT
  riscv, bpf: Add 32 bit atomic operations to RV32 JIT

 arch/riscv/net/bpf_jit_comp32.c | 111 +++++++++++++++++++++++++++-----
 1 file changed, 95 insertions(+), 16 deletions(-)

-- 
2.55.0.795.g602f6c329a-goog

