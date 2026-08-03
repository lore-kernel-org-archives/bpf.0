Received: from mail-wm2-f7.google.com (mail-wm2-f7.google.com [74.125.225.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6D6395AF7
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 07:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785742057; cv=none; b=hhJLamCGzHy21N7Ehr4j7/Wm40MfsTxhCbE3+Ic8W9sC16gBNPffmZOfi9FbCY0HKF/H3czfxGMx1kOf9R7/0Z9LPNkVD6ITxvBHh9ZDW5xAQ3I2odBPk8FMYRUXhtkDqGVAByfOYe9ROrrDAyjJEI7ApKXve0vBh++6NZVcc7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785742057; c=relaxed/simple;
	bh=eRm0CvS4BfJiNgfFY39Wpe6TWmHRjH0WsglsS/pdmY4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IEoWXdhx2ukJcLeRmB6vz7LnLUas87j0OENpxUwnkcbMkEJNqfbfjoBQ9YNiQSGDv+93sD4PvASRNer3Jr0MhXunvqGLUw0Ps+owN7YOnYy+L9KJzuczVeYW+IkrfAUPfuSfUo2BX9OrksWgcQCUoI+MwWlBD50REijUayDON8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mCxQphfr; arc=none smtp.client-ip=74.125.225.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCxQphfr"
Received: by mail-wm2-f7.google.com with SMTP id 5b1f17b1804b1-49579f38cdbso1457165e9.0
        for <bpf@vger.kernel.org>; Mon, 03 Aug 2026 00:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785742054; x=1786346854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0vzwedFlW2YR8OeXvZzLj7hCG1v8iR3G8VOAaPvg9yI=;
        b=mCxQphfrCjRWGxebw05hW2D4ba07t5vHC9+HIl5saltLMnDG0vgfuKw6uMvW97EE/y
         D7fuNWGbXoGT7GhVZ5xL2UDAF+iXW263UyO0/RTEiIW/+FH+QTMo0TFBVfgW/qWNs7x8
         JApzY1EA+7DMNhnd6+AODHrFEjZtpIdztdrpW2enPJnWblmcrs2MeTqOsmpT/xJwkN9d
         7XIXsLI9L+ie31T81G0WsfWI4gMm67AqUg7DH0wpMllnOjYagHn2iSUWIj+rXAGVHowz
         a23Nl5FGUdEk834UEtaAlZjRbwYjjnj57BCr53tMaGyd6NWIE+DvGuYV4/BBfe86/j1G
         AnPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785742054; x=1786346854;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0vzwedFlW2YR8OeXvZzLj7hCG1v8iR3G8VOAaPvg9yI=;
        b=FjlXm5WHOUN6F0gFmPHA0+nNNnIgmHjvHLhHFG0Yil09d+kkfIH8MnuLxx0mOKsBUB
         Ti9w3U7YXd8+KF5zPIw6D7Uz+lrhyoFfNYIVONeGQgD5jk7RnzFux8KCXO4e+h4VrUrU
         IC94bvg9B+Cm9TjGw508wrRwj0TDBxJXSLjigsuuUrUNK+tCophNkbZd569rijhrJ7Q5
         LKZ/PRHYggYj+ce496Ew1i7mQea2JhkgzJXIrqvzWz/4QJjd3QJsej4Ucr5GQ/xTjhQJ
         mIPEK4pV7Wo+PvT6CUySpOF9b006Cj5yO7v1bo6riOtH5JVizXpr2VErZJq5blOPTDOD
         +Usw==
X-Gm-Message-State: AOJu0YyQSnARoKfK0ydiBu6cXxH1b0YT5QxOsjeGmFPj3oktkBGQU2RA
	mCe2vSWtNgL590q90Ce+rvGl6Jpzsp9FIuoGavciYRwNCit4+VDy9I39BgtNHk3+
X-Gm-Gg: AR+sD11yMc9Q2ZNyMqBF4WUtqeQ7pArcbodRRdqqwB0xQ+E+vOa91MBnBw5z4uzBUO8
	v+xteFMsTXnutYRR5kdDDX9lK63uGhnwoiRpd+rtOqI8iayB04P0YMEdEDz39FUYCOOXQOWkDpJ
	Y37khgOwH0KSJdDroXWU1ykmTJhubw8a38p44C9X2JHjgPA2zTqYE9Srk/0jNq9/uf5S2kBLFqe
	opRo6UQbH35LkYvvkTv9N4TvRbl1mvgI+toSXxSp1qT/kVjs+RL8raZ1dEeyVPKeac45kbPvuGE
	W5b2J3QxmQ7q9pKnIW1+UoanNGInSe4aj8zWgzQkjz5PczTmzbFIwkulUtzZDlpKgHAc6yYDLfZ
	UpWiO5+BS70pqYVdFFDiyM8No+lYn+/aebbH4Eoi4UB9xUCpwIrG+gG6AzMW8vk9RX+PFRtwIck
	FkCCCUj+6jlMjXMUruvHP6NQnHJ8jqfwfAa5KMEj4pLCbWUFpKkW8J6P2RRjB9HL4kucFNSgN3C
	VSUUI8QbLUurf0zdsnNCP2hptNo9QAkgMbFD0f8YdxKEbxobRX3rwozJ9nb1z1NM5vbSgi7+fd8
	4RjWzwSV0ByfoFBG8EZURcqOflk=
X-Received: by 2002:a05:600c:4e89:b0:495:5e3d:15e1 with SMTP id 5b1f17b1804b1-4980c6788f8mr179468335e9.16.1785742054338;
        Mon, 03 Aug 2026 00:27:34 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b59a5bsm199964875e9.3.2026.08.03.00.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 00:27:34 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 0/3] Improve stack depth verification stats output
Date: Mon,  3 Aug 2026 09:27:28 +0200
Message-ID: <20260803072733.191502-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1578; i=memxor@gmail.com; h=from:subject; bh=eRm0CvS4BfJiNgfFY39Wpe6TWmHRjH0WsglsS/pdmY4=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIavA6VqQWcGhCVufXrk54YDqgqWJXF4LxFa28gXoskg+N ju9z9avo5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABOpdGZkuJWh/OvIv3Othn/f NS6I4qhjmySfKnb22Wtme/WDOwxO7mBk+HlFYUmiQL7ZmlXrGIXzZXv9M1d9Et6//NPFqx12Ti2 iDAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Some improvements for more clarity in the stack depth verification
statistics output. See commit logs for details.

Changelog:
----------
v3 -> v4
v3: https://lore.kernel.org/bpf/20260803031457.3115812-1-memxor@gmail.com

 * Read names from subprog_info directly to avoid an out-of-bounds access
   when func_info validation fails. (BPF CI Bot)

v2 -> v3
v2: https://lore.kernel.org/bpf/20260802225209.2511758-1-memxor@gmail.com

 * Reuse subprog_name() to fetch subprogram names. (BPF CI Bot)

v1 -> v2
v1: https://lore.kernel.org/bpf/20260801230400.850271-1-memxor@gmail.com

 * Use multi-line format. (Eduard)
 * Adjust veristat to work with old and new format.
 * Adjust selftest log_level without new option. (Eduard)

Kumar Kartikeya Dwivedi (3):
  bpf: Show more useful info in stack depth stats
  selftests/bpf: Adjust veristat stack depth parsing
  selftests/bpf: Test stack depth stats without BTF subprog names

 kernel/bpf/verifier.c                         | 13 +++++++----
 .../bpf/progs/verifier_basic_stack.c          |  4 ++--
 .../bpf/progs/verifier_bpf_fastcall.c         | 23 ++++++++++++-------
 .../bpf/progs/verifier_private_stack.c        | 15 +++++++++---
 .../selftests/bpf/progs/verifier_var_off.c    |  4 ++--
 tools/testing/selftests/bpf/test_verifier.c   |  2 +-
 tools/testing/selftests/bpf/verifier/calls.c  |  6 ++++-
 tools/testing/selftests/bpf/veristat.c        | 16 +++++++++----
 8 files changed, 58 insertions(+), 25 deletions(-)


base-commit: 8f876c773b79ed66dadc9507f50dbff39c6a9ec7
-- 
2.53.0

