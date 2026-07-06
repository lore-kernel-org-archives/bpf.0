Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53C83AEF44
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 17:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783358944; cv=none; b=s9KlezGd1vljoJWld5P4LTzBEFk7UF2aseVXpVLDK8d9ETgLj0mGAyCW4n7ILRbwpbiK6s1pqBHzWxGDvhjgzZMrnkb/mWLi3PBCA6wSMglT+uRBlVBishoVDaQZ+NuA0dONsIgVuP/DZ1H9U34HrSfLtMtacYr3jACdI59GTyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783358944; c=relaxed/simple;
	bh=a6fvkYTDuu+14XJxPnVus2CzWTlAZzpebRF6dfNrIPY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fDzTqQAGOrEJXhcQDlDuEQaku+niW29cuJH3fU1z9jCQsCFz0HNEYnem0tr+lhOEIuji96mbp2qfM/RjuCCiVwLCi1/MJRn2cgMl3tI3RhqNzmkTn+n/ytpzMj1hxkvsp8CPI0+TblDyyKPORht5fOy2jDHXeEZgn8C7Hw9U6h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DxJ9VYxL; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxJ9VYxL"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cc7e86e7aeso18197425ad.2
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2026 10:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783358941; x=1783963741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Sc8UWUFIFca5T75Paxs4hgOTZtiZGU1HZksFlaVnRMg=;
        b=DxJ9VYxLeHYGAdrSxcSwAYV6p+mezUC9PjEa6L9YvzCr3/tk7mMyL0rC76shdGgAoa
         f/VE0bxRVkyhHId8l4n9Im+n8yVFdQ2Ax8Us6F8WKvPEPs6/4rU0vPFBJeLdyK41t0Lz
         /cfr5JXmC0goJhqsG2QYjXOYhjGW5u/iU0LO3ms4Fx3gLPOL+K8BE7B4FBhOHMYRxqcX
         ZQyo8HrixkflLXOoKzslSR3cEK8jI+sUJWa+VsPvFJrheZOBm3yQfDu4ObS5V6j1354N
         GuEAJDql81ht4LyWtdTgUJzOPUrRnsFuTgiTi275xzLII/LAQaBd+cYTL+i+XY9rKQHH
         UsWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783358941; x=1783963741;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Sc8UWUFIFca5T75Paxs4hgOTZtiZGU1HZksFlaVnRMg=;
        b=s19MUlIMi8d5H+xPvxhgrfW1Lu8RwTUo7iXTzX4PxRMvr1di4QRIMJ11D4orODTO1s
         aWqR8WMIjbXiHAL9yVNEaV9e7vdHrZjz3RnACDOfy9YrKEtPMr8SurCDeo4ZuK+JTMnB
         A1n467sul+ArpvoIExD65jyqmkjH4asdTZrUMBdCmhdxyI6PnjHpmQq1zsGVRKhogpHf
         gS9kXmSoN0FVPk/VaBXCCmjCMZ8n0XXTiymBwMh3JDW42iSOT+He0rZksWHHiJVSPJO4
         a3egTuuBzuWCYMoCsMMi+CzODKSYiMN5WrsdnM35yyq3q+NRARwYS84pDDBMgDP6bC05
         i3qg==
X-Forwarded-Encrypted: i=1; AHgh+RrTWJr877axrtuKQBqRkf1/Q5OjZnsOkT/aRDvENM8QqD4Np1uB8wb6QsaGU0bwTirToXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyskLs4uJed/fTxWsx5L3KM+n8LJK3UmB2jE7siVd+pkHvdTUnH
	Yqs8IOUv4VebYqMx/FkvqPiRBv/q9W2eHyJl1QdTQGsbyTlgtT8GXioh
X-Gm-Gg: AfdE7cmNif+VKtg8gfRehTux6m6ZaLRd0OE94Um/4HcHX6HXc958jmfYflue3bAmJR/
	vaaNO7t6nhGzlqQEIO8dKvjSjcWx7dhCC0KC4GGWAbVl2VNJ48weGefN5h/KQtBEH9z6kC50J8A
	jeZQY+HZ9Amx3ky/sSkOi2iqpRWjajrvUF43XT5yqEGxVq63Z+o1nkfqGSKAY8yRYzp3P5F1+JK
	9aEP5hu9jpmZwzR9PdUC1e+QuMkM9uv8s8l8V0pn9Xliqoqmk+ghYCBSK/ojq8WeENkS3LNX1uy
	G/cmC9ZszJsv7hCTPdU2JGDQhasKOu4bbzYRwbNw4rI3To0ZHHxTAWsF8id4cF20qoc7VUimNfv
	7983lD4R5Q7DZ5q7m6l5D7h96CYzQIsL1/fG5AxwmRgJjqzohjlvpulsKMsZp08P7xTHe9BXHgd
	BIoyHzZZqhRu5jSqo+kcMaz6nqfzffKvvZPzEe9uzlXylZxQV8HoV/uxv7uo94UHrjrUwmmFBRb
	Sm4sPWNyqkg
X-Received: by 2002:a17:902:ec85:b0:2c6:a012:6241 with SMTP id d9443c01a7336-2ccbe3f7d69mr17749295ad.6.1783358941128;
        Mon, 06 Jul 2026 10:29:01 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com (32.237.80.34.bc.googleusercontent.com. [34.80.237.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad6f25e54sm54667005ad.2.2026.07.06.10.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 10:29:00 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 0/3] riscv, bpf: Add support for signed operations and 32-bit atomics
Date: Mon,  6 Jul 2026 17:28:43 +0000
Message-ID: <20260706172846.3876436-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.55.0.rc2.803.g1fd1e6609c-goog
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
2.55.0.rc2.803.g1fd1e6609c-goog

