Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8AA2472A2
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 03:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775187520; cv=none; b=QZkqhCM4DLKYG5eLWkMXQXVXq94b7K+SOQm7kadmFskcwyCKNOwQ3USHT03LY+hULFpLhMFfikQAhO9IydC95XCeI0pTmQYeKDgOhdGK6adb5rbv8KnpMi5zVQW+BoVJVFBWu831lCZU9ADSLeAEJhwG+Im+nmhlMAa7xt5ScyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775187520; c=relaxed/simple;
	bh=tXSn6YO379IapqquTyj0/0EIkaCiWSQuCrQ0mx7HuDo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lN9JdqX3qmr4RKghZbISgme3jfJ/n7dtIhzaQIg7HUvLaomE6mFzltesFx6SggzMVic4sGhqpTmksEMy/Leik++9KIZORIRDupw5L3Bs5jwM+7pdIkkEzJiBX48uNOCURF0ad+EsoOjg3FLMvD7XqXQ2Wifi9pvXZgZXCIHR+vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CiX/K8Sd; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CiX/K8Sd"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c70bfef17a4so1108729a12.2
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 20:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775187518; x=1775792318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xxBED/dyO6OlnKVaDUEcT9OabMlvhwXlq+sWLTo9ip4=;
        b=CiX/K8SdMC8xBplNEBbd3g2uxfOaDY2NsjS2BTmkf9YSpe+XlfIOaAdC/oBz82UvE8
         0nt7PLr6+KabAG2HkWm4giJ/VnDmffASowZO/N7kBzoaZrUfQvFnTl0lQemWK8xjVo+P
         Nf6iaczEIgIH8dVaz9S/yx7PNEcjVxlNYYeg/TtBi+YYdgFHtkR0FIlqUlwpF7fP0VF2
         XecXlAXlLNeucs4TNLjG3wPpAbkKimJ3KmYINHT3eqq45lBfel/XnzfAj2/A+uoQipoW
         MbX/2UBooMBJvG8G1/8g6tOWTXzH6AhLLP72E89M1rzkVTHbwatDpFXpYa6m+u9mXn88
         PEOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775187518; x=1775792318;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xxBED/dyO6OlnKVaDUEcT9OabMlvhwXlq+sWLTo9ip4=;
        b=DyJO93tT+G4YAzJZh7hg9wx27IbED39yXTjVk1lKfu1rSRysdivA5ZTDwgHkHagyyZ
         GKTMTMuPGGhQMQyV7C4aCHp5h07FSCa/uoj449zqQiBi5q2N1ohX+1cQ3Q57fRFiCYCW
         DGrbVuQAyYCwr2ZkkHXtpPlbFGkfxPPq+g19qtzc3arwOeb2kgo0tCVXDE2DbLz1kG87
         E+iTx/ywbZIznP+c8JOFDk//nxQMCs4W6Io7eUXBPKTQikCHPw5QnD0yjJTqzYqfOQHy
         doam+1b2lleNHkxv4uGZiqGWr4iy5EZ4RFxgz05EULT6heNs6NrwPvSaRwrN0Ki9SVJq
         pMuA==
X-Forwarded-Encrypted: i=1; AJvYcCXybq3g7XdmwNp4Mc0nFn6w17D8wq8r5f7tru2B9cUv+zWFDVvC4QIVnQ9kozydNa1kSXU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8mmaPuKMbLc7+Lyb1eCmMArY1D2Fvhi5n77Ns9iqHCeg0M6sh
	eDSPwdBfvP5goP/KQ5sp3EYFK3DWNEr1vkFHoyyiZbyqOWVgFXh1fOxJ
X-Gm-Gg: ATEYQzx362GophgAFXRaLh79duhTHVNoKqzsrwG0X7BacSzpIrXSImxFeh/aBRg9C6y
	dYPwEwt/NjZTK0y7z08QLihOyXS6T5wrM56PDwu/qI0eORfmwQh484CNJRhHEkFO/jOLQ9luOjL
	UKuLqKV0j4OSV04uOflZN0QCdqW/wnIO330iodbojYv1nD8MR+uAdqq2T892S4NLWv+CB5stxl1
	kp0+at9OVIQIakpQ81WLd4AFBoLks5SDOH7pZ82I15l5SlJSObWW6yxY8SuPXN8Wnnw07T5r8Yt
	bUwW8iLX/fw6a3Q1IikAavFyFA1JKyTtNGd6FnO9+shoPzSwU6cQuwXIbtazT3FVQscmF4wQTup
	nIN6WIbLHVIwkmWzqYCGealXhFUcxVXurh4rGEzX+MFe8IGLNFZfFSnc+6EUjcZ3+Go4iAhWdjB
	924Dk2h4cenO/D+4FudNZBytZuX3Q4JoWe7uc=
X-Received: by 2002:a05:6a20:430e:b0:398:6645:6f17 with SMTP id adf61e73a8af0-39f2ee10e1emr1409178637.19.1775187518392;
        Thu, 02 Apr 2026 20:38:38 -0700 (PDT)
Received: from localhost.localdomain ([47.236.127.140])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c659a218sm4172659a12.29.2026.04.02.20.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 20:38:38 -0700 (PDT)
From: Qi Tang <tpluszz77@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Song Liu <song@kernel.org>,
	bpf@vger.kernel.org,
	Qi Tang <tpluszz77@gmail.com>
Subject: [PATCH bpf v4 0/2] bpf: reject direct access to nullable PTR_TO_BUF pointers
Date: Fri,  3 Apr 2026 11:38:26 +0800
Message-ID: <20260403033828.18529-1-tpluszz77@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

check_mem_access() allows direct dereference of PTR_TO_BUF |
PTR_MAYBE_NULL without a null check, causing kernel NULL dereference
on map iterator stop callbacks.

Patch 1 adds the missing type_may_be_null() guard.
Patch 2 adds a selftest with a test runner.

Changes in v4:
  - Add test runner in prog_tests/ so the test is actually
    invoked by test_progs (Kumar)

Changes in v3:
  - Drop stack trace from commit log
  - Split kernel fix and selftest into separate patches
  - Use [PATCH bpf] prefix

Changes in v2:
  - Add selftest

Link: https://lore.kernel.org/bpf/20260402092923.38357-1-tpluszz77@gmail.com/ (v3)
Link: https://lore.kernel.org/all/20260401142316.2452-1-tpluszz77@gmail.com/ (v2)
Link: https://lore.kernel.org/all/20260331172720.29938-1-tpluszz77@gmail.com/ (v1)

Qi Tang (2):
  bpf: reject direct access to nullable PTR_TO_BUF pointers
  selftests/bpf: add test for nullable PTR_TO_BUF access

 kernel/bpf/verifier.c                                       |  3 ++-
 tools/testing/selftests/bpf/prog_tests/iter_buf_null_fail.c  |  9 +++++++++
 tools/testing/selftests/bpf/progs/iter_buf_null_fail.c       | 51 ++++++++++++
 3 files changed, 62 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/iter_buf_null_fail.c
 create mode 100644 tools/testing/selftests/bpf/progs/iter_buf_null_fail.c
