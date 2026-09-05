Received: from mail-wr2-f10.google.com (mail-wr2-f10.google.com [74.125.225.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4E32D0C62
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 09:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788599275; cv=none; b=BPP2ViZt90MXWqxJ17MCG3QEKVkphnKPYJFFXa8VTLNqPEJUGmk3MypH68wCImcbfB0AthXaaCxnGMqyEQOTXCZUk9zl6dmp+pD3i+VXS82LIwVfDPQIxB/tgGuTWnvxHzUw27US7BfYiAcSfcMptIOBjl/mv+yqXxI1npxkJT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788599275; c=relaxed/simple;
	bh=QyHFehQrmHWW1WURhgfYVwzqYfAWXKNkwNYX+TV1jyc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L/hylZ94H+TR38SEqFL69JY42SWzWByyWrLRr4IuSS9I1qvfUA6EDmP+Udxt4OpSCv1DEoZP+/ivcrNWEJsgXCTmFhAcH6OBPLXBGki+/QdRstgPL0biLZdfRD4My8W0spQb9vewq1PFJyqNW4qQHpVGquhCrK9ihkU21wTCQHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aTP3VPHN; arc=none smtp.client-ip=74.125.225.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTP3VPHN"
Received: by mail-wr2-f10.google.com with SMTP id ffacd0b85a97d-48433107499so710934f8f.0
        for <bpf@vger.kernel.org>; Sat, 05 Sep 2026 02:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788599272; x=1789204072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kmDe5RUUCAAQpxK6D0VmQGZ+sEMEtUqKEHb19pXsTJ0=;
        b=aTP3VPHNHDmuLVCbYqtGjRjEv53YZbMTipQyWAAgGsQq4V72IKGb23l/zaH21VLFov
         SBxrL3FsAgrIWznDrDovsteicZd+791sjthVD1sbeKcrhA2+gYgxfJksmqOfHpKuNUER
         BhVoe1RITMqOaQ4BKg344xda+K2fDwBm7UrIgXOhCkla/Zp7+oL5d+YpMAUOBaGI9sor
         G2HZINZmfcLTLwUJFO01EYDewKvpzxdGrUunxcnrMsussjoatpb//KJZ7GEJjTyn6GCR
         JYCieovY8ajr8rNLrfIXZNajik9WPWvTINE7TIBKErlMHqCzxGDQvTywLhq2XCCsPSx/
         Sryg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788599272; x=1789204072;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kmDe5RUUCAAQpxK6D0VmQGZ+sEMEtUqKEHb19pXsTJ0=;
        b=XU4SKq7hGtNexH8+XdD/O2qz6DuRYyLRObr+/ZNQPB224vdzSgIK+Go3T7CMiVAfZ/
         +OxXGpdERPiKtSaxTtA9u+Z/ARqwajl6O9rC8Rz0mUr31IV5Efd3SYPQ5bJta4AdvE99
         ZQXgsVCgAt+/uRThan9EZpUsmnXIW3sxEvKg/z2yTp+NvR0zRze/uxz+wJW/CCl5ixnQ
         jIuGvvURSSYaFabt8zH/GzoF+HFP0ptef9lc8Jaf7WnHwOR9n3JzL6A0/TOp06qCByLV
         4mHOzQe9uUDAfy8idZrWFC7O+2KWFayP28dIgsLCCWTg9eY2HDaT1lZnggohksi8Wk9Z
         YdhQ==
X-Gm-Message-State: AFuF++lXnaAXdHYsz71WPepOl/i23aeUU2ReZiIsfP0gN7SnfPniQyoZ
	hqJCdar0YYAWnR2GnHd0SzQajM0yvvj9ySCI0DypwOymmd6SHvbqxCavgmLiX5R8
X-Gm-Gg: AYBFou3DS+ebgzw7h6eNkE5iSj0t/3U+HMm8HfkO+/ggXgBxdR+40kyInJCM6rDNW1r
	mmUqJNtgz9+jcVAtYKGlDkftgj2ThMGgiHhahymqH7wRoyGe8DLjMJCRdLxyNYYmhvCGroDfwRm
	B1auHAoNrKcqtZlAohP22dUF0IsmWaeKR93Vt5OirOHRdh0IS8+4G79p+fLGYXIoMWCN4M963KQ
	doq2XJiDKS6gZbXCTTzJhXG/exp3hwhuth4H1dwuSr5bxEsbRSRAUmqRG842I4suXnO7ZAM57a/
	Kl4ZKQsoPapASZEae/hVUUNjM1kOrXTLGw/+RcngaUAkNhLfm44cYvPA6Oi/2l0zSwqEvU83ky1
	q7Hpc8C2qyC4w4rYxIxKAoFutBOp1Ig0FQrXfHgfV4HTaRgBepxvXOQCnxt2OLOyDOP/RIaX55y
	Gj+/FXD3ig7Rcdqedgex1OOvCjd9tBYcdFZnzM59I9xIX350nitOfDK0xNx93L64jCFX+x8gYbM
	x1yVnTGnqVU9UuEPekJwTGgKoze6f8Y4hZYFxJssMv9e5wNuU0fj0XtdnRz4+vq1TiRloVUD4z4
	pXmiLKI9H9FCcAA65fdSFi0QUAI=
X-Received: by 2002:a05:6000:25f1:b0:485:8f60:f0e0 with SMTP id ffacd0b85a97d-4858f60f133mr3847885f8f.48.1788599271746;
        Sat, 05 Sep 2026 02:07:51 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48591eb3d3bsm2898542f8f.0.2026.09.05.02.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 02:07:51 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Nicholas Carlini <npc@anthropic.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 0/3] Fix acyclic ownership checks
Date: Sat,  5 Sep 2026 11:07:45 +0200
Message-ID: <20260905090750.4064411-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=732; i=memxor@gmail.com; h=from:subject; bh=QyHFehQrmHWW1WURhgfYVwzqYfAWXKNkwNYX+TV1jyc=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWv2rXfT9H63BvkxiXL5quQ1vwlTnmJ+4VR3kcSavTV79 t19/qK7o5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABPR9GH4n7iYg0dwyQNL/Yp4 oZVJD91vccpntq9lrGYtLprofdLqCyPDagWP3sP+v2wXHPrTd1bkzqply17nxW8v9/Ho2f1twvc qLgA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Bound and ensure acyclic ownership graphs for native data structures to
fix a bug reported by Nicholas. See commit logs and tests for details.

Kumar Kartikeya Dwivedi (3):
  bpf: Validate graph ownership with a bounded walk
  bpf: Bound local kptr ownership depth
  selftests/bpf: Check local object ownership depth

 kernel/bpf/btf.c                              | 134 +++++++-----
 .../selftests/bpf/prog_tests/linked_list.c    |   4 +-
 .../bpf/prog_tests/local_kptr_ownership.c     | 202 ++++++++++++++++++
 3 files changed, 290 insertions(+), 50 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/local_kptr_ownership.c


base-commit: 3ccdb07813829ba9487273e75d1cb238cfa774c1
-- 
2.53.0

