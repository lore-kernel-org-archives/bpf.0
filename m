Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346C015A5
	for <bpf@vger.kernel.org>; Sun, 31 Mar 2024 03:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711856663; cv=none; b=aTXRGOWd12KckqqgZ13IWazaoKGKsWDATfcx/IwvysLlubwKNqPdyPdBsldkHHkXjmeE5RVVT0TklQjYVhMr2NXN2th3B7zTZNvvRiV/JnGt8GYHWgsvdyOmwh++DDg6up4OJNbrWfh+go7gFa54+XyjMtZIW/0Kmo28f8LefOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711856663; c=relaxed/simple;
	bh=1ebO9FDbiUoSz1grHI0f18hUh4NXGNG9dp1+VXCVtT4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j6i+edA5yAxj9kX6R34Nt5PsRCrGbtfRJPBhDpmvi3b4uli2XWViWMGf3JZ5mLtDCagRCVajqmQQVgrnVVarwLQGasqXjexz3I347kXRsKhA1ni9+ZboRewMfOciTe9uWH21h4gOq/HDQ1MHpn19PDrK5tbpeRLreIHQ0oY4d88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g08qx35s; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g08qx35s"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2a207208187so1894938a91.2
        for <bpf@vger.kernel.org>; Sat, 30 Mar 2024 20:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711856661; x=1712461461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4cPX2d6DmO3+kVGwpjOTsEKX7EsPG0lMeTCrav/HTfM=;
        b=g08qx35sR8gvzhIbOutDMRpGkmT2sNgerp/o2fbfP2WYDWtWgZAXclv8kBYpBuzXIQ
         OzAMs6jrrCHy0P2RYZiWS6pp6JVt7u3qOVwvEkEzAFS2Vra/cgNowRV/50outZUje3re
         7RH6wkWxV1Lxorjaig+Sd4Zqw7qbuHAxnYBm0tvZxP2d7NuD4fbJYLoOcVRbzzfsrub7
         VY9RabqYcImwkkqoqPcv09hG4RB7yXA1B7B2pX2rwG+J6WEL4WscDJ4CeajjmljKtbDg
         hhR/jNtlDEflNk+suN+R7lqQp5mUwCf1jbTtUVXObPYNiPLyltPrQQJD+vNThXUjIquY
         KG/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711856661; x=1712461461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4cPX2d6DmO3+kVGwpjOTsEKX7EsPG0lMeTCrav/HTfM=;
        b=L1UAAZtDRn7p5PQnnfzPHAMWw7lX/AS6b1JTjkjmqZEi9hassfG8roO58ZAz+HUyo2
         poEOjCNfLwp56WC52hmiRMKrC5VZbuGeZEyDarJJjPYfY3ptrOyxaLYMelZC3fq1hHvJ
         nlw0k5zXUvnd2+hWi77VXpPN0VTeBH7x8N5vXlUxF1VkDncV5F/sUSTBtEqxKujlrV30
         Se6tvqPCOdP8FYY7eAQ23dMkC9KzdQgeyayMjH32DkaR+KB8yCMLFN0wS5fM3mHSRy04
         ls/w4eavbuZQxheAUi1j1cAi4kQsPHH9DB/F8Q6xWP/IP0Ur/Mzoy4MIeficRULzURtm
         XEDQ==
X-Gm-Message-State: AOJu0YwBbShkPPOVga7U6UMIJNlJKP3UC4FX4FC0qjqq62xpih5kGlHF
	GN6wsYUmU7jfiO/sohFwmr443oe79OHpkHr7kixuclqXEJTEeV26
X-Google-Smtp-Source: AGHT+IEAOlxOjt0rsUAcpIlRyf5P/AWhZoR5JKug3iJ9Ixn7IvD+TTuqZQ0F/oq2M+hstpmi4Hllug==
X-Received: by 2002:a17:902:e882:b0:1df:fda8:e0ef with SMTP id w2-20020a170902e88200b001dffda8e0efmr7180196plg.20.1711856661340;
        Sat, 30 Mar 2024 20:44:21 -0700 (PDT)
Received: from localhost.localdomain ([39.144.105.37])
        by smtp.gmail.com with ESMTPSA id y19-20020a170902e19300b001dcfc68e7desm6030239pla.75.2024.03.30.20.44.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2024 20:44:20 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v5 0/2] bpf: Add a generic bits iterator
Date: Sun, 31 Mar 2024 11:41:52 +0800
Message-Id: <20240331034154.16284-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Three new kfuncs, namely bpf_iter_bits_{new,next,destroy}, have been
added for the new bpf_iter_bits functionality. These kfuncs enable the
iteration of the bits from a given address and a given number of bits.

- bpf_iter_bits_new
  Initialize a new bits iterator for a given memory area. Due to the
  limitation of bpf memalloc, the max number of bits to be iterated
  over is (4096 * 8).
- bpf_iter_bits_next
  Get the next bit in a bpf_iter_bits
- bpf_iter_bits_destroy
  Destroy a bpf_iter_bits

The bits iterator can be used in any context and on any address.

Changes:
- v4->v5:
  - Simplify test cases (Andrii)
- v3->v4:
  - Fix endianness error on s390x (Andrii)
  - zero-initialize kit->bits_copy and zero out nr_bits (Andrii)
- v2->v3:
  - Optimization for u64/u32 mask (Andrii)
- v1->v2:
  - Simplify the CPU number verification code to avoid the failure on s390x
    (Eduard)
- bpf: Add bpf_iter_cpumask
  https://lwn.net/Articles/961104/
- bpf: Add new bpf helper bpf_for_each_cpu
  https://lwn.net/Articles/939939/

Yafang Shao (2):
  bpf: Add bits iterator
  selftests/bpf: Add selftest for bits iter

 kernel/bpf/helpers.c                          | 120 ++++++++++++++++++
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_bits_iter.c  |  57 +++++++++
 3 files changed, 179 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_bits_iter.c

-- 
2.39.1

