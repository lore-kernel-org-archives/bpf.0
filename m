Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318BD2773E4
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 04:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786420913; cv=none; b=MGG0oLecQ4VxXqlyardD10W5OQ+Eo7NYvPxFelg5Q2zo4/7s8NO38veJui7H3dh/N1QklOg6MOygWo2l3dC04TKbJtCmhCGDJwZrlLLncbbrPk5QzlWC8XqoOHIG79OtIC7hZH1uXnm9XbzQ47x0bupYWEYd1SZESIGWRWaqOF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786420913; c=relaxed/simple;
	bh=O3YwKg/rxj6wZhace67T0MMqqd551eX+inMitn7ZWLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bJD+sYneJyAFPlAFF3fCnXmCfuC0LunfTfqvdjtWSPOEwUtLQMhjBADt/4CVcd1ZrBaOPuRt0pRHt0xaUWw1Qnj76Qmwmzn6aqKmBM6FNCIIDFzy8ofGgIF1JGKmKsQ26S871JIXCsQlP9ZgJmIEYy3E5rFAXuJSpprEezONOs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rrvlTdNz; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rrvlTdNz"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cb5b8572b70so3003219a12.2
        for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 21:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786420911; x=1787025711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=f3XmrdIXg3BjIJIlv2ZSsn/hjP6wPweG13cKQY6BbI0=;
        b=rrvlTdNzl4b06RNXukrctlmxCjko0bkCvi38MgU69VvE9+SQgxqibNL7LsC2n6qJiZ
         Ydw4BnGOfN1rjaY/DjZZf79OddG4oWq2ZkGhXQMTix99H9ZOk69BfeTanqC2a9xudHKp
         XfEbweKsPt0126Ktanz/WrfdbE6eN9Agm2XG2EbeEMM1ZszX0M8cjqhvyIDs8YgMd+EO
         SZLfxgwCGAzrY4zZiv55D9yfBmNY+0cVeFrkUK3yTDRKks0j73X4D8PpWdHeox85K+WD
         A6n3jBMINTyYEHUUrh1bTUkYB4JPjpgbHb0TvFYxMzJbnpY01NHTA2GaEoqAqGj1A0Mb
         Hpjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786420911; x=1787025711;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f3XmrdIXg3BjIJIlv2ZSsn/hjP6wPweG13cKQY6BbI0=;
        b=WTalhGkSGIchpy2z2sY206mDcgoxccgHF8C+kd4wSf68NH95ThYEw0mJBNP0ROay4j
         67I1boKn7ggw7akQbyxLnMNtsmlVe9hQaWlIaztFeWBkio50cbR49NC5O6awybvdZpYm
         SQfgnJ4Zsh293syI36s0xllUsHx+/HiDOF388qcYjViXe+BSKDRRBICAS66UIZ+2s2ir
         DUJ4HOaGFnK9VcGXEBXsPGpnOh8tAINONBIpSA82iMy7T+WcGqo98I7pFaxWsnVwAzJU
         58mRBGFvVvcb1Qv5Y6O0PhjOqjaS7znYfBvaMG9oSllgh/9KBLMGWe/AsQiDaroL+fT9
         V/Hw==
X-Gm-Message-State: AOJu0YyTjhK8s9tR6R4LCvP7t0TIEp/CV+GwZeom2KqpIQrsjfrxVI2N
	x18G2OGa/rkdYEfs9WYIsMaRQCjyvg4kQ8gTidwLdXuGgReSUDC/gcn06/bOoA==
X-Gm-Gg: AR+sD10MNRjVGbwZWthtiIUUnhvkviT7HCbZI+YO7n4cLRhGKHWjeGMDJHxQ3AGKawl
	4mLo0PeBvxLdU8VMKBs8dRHsAc9OZBNGicYbRx/dccflWkNtwDna8uwnxlXfL6gbxQ2iVNbkEFz
	VNHCpxJRhWi87TI4kgYVW8YZies06519CDwo/Q3W2hOcslE1gUPCOVkxUfLQ79g9t/H1EfWUvzF
	Hm/+k4P1okl9rABNjppuBeGHXWvYYxOeRFMr9QGReVL8qkd8jmP2ynzQoFLEoEZthaV64NVtXJj
	nDI9iMGRi+4dw1Hqv2am6oPYkG2tO379f4FAe5Ot+YC4cZ2w4Iwua96xyXxWSnysDTHupGjJXXS
	DK4OBta2/6Bk3jZarRukROhWNAEjWj+VzgE6miKeC4ZjkjRGgmXLu4/SwptY9cdHul2mSa69clf
	rotzl/qaSRG4Znf3D5AXp9gmzBs887Wcr5hTic75DWbKjA9b8PaWMCidunp9LE88TyhSoQkgOTv
	/j+SkHFClARhuhs
X-Received: by 2002:a05:6a20:cc8e:b0:3c3:b57b:627d with SMTP id adf61e73a8af0-3cc2b84c686mr952019637.12.1786420911447;
        Mon, 10 Aug 2026 21:01:51 -0700 (PDT)
Received: from patterson.cs.ubc.ca (patterson.cs.ubc.ca. [198.162.52.65])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbed8bb9569sm163683a12.3.2026.08.10.21.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 21:01:51 -0700 (PDT)
From: Ning Ding <dingning04@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	Ning Ding <dingning04@gmail.com>,
	Chuyi Zhou <zhouchuyi@bytedance.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v2 0/2] bpf: Compare iterator types during state pruning
Date: Mon, 10 Aug 2026 20:59:53 -0700
Message-ID: <20260811035955.132989-1-dingning04@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Iterator stack slots can be marked MEM_RCU or PTR_UNTRUSTED. The
STACK_ITER check in stacksafe() does not compare this type, so state
pruning can treat these states as equal and prune an unsafe path.

Compare the type and add a test where RCU protection has a gap.

---
Changes in v2:
- Convert the regression test to inline assembly so its verifier-sensitive
  control-flow layout is stable.
- Add Eduard Zingerman's Acked-by tag to patch 1.

v1: https://lore.kernel.org/bpf/20260807004320.134069-1-dingning04@gmail.com/

Ning Ding (2):
  bpf: Compare iterator types during state pruning
  selftests/bpf: Test RCU iterator state pruning

 kernel/bpf/states.c                           |  3 +-
 .../selftests/bpf/progs/iters_task_failure.c  | 46 +++++++++++++++++++
 2 files changed, 48 insertions(+), 1 deletion(-)

-- 
2.43.0
