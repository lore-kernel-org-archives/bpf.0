Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749F1257844
	for <bpf@vger.kernel.org>; Sun, 11 Oct 2026 06:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791699714; cv=none; b=RaVFPP2GBHvDdRN7CQHzd3TqPhe8+1CxHXzR5LGafLlwuUuOPRVg+sHU/IZ32MXVcpwihLFd7NhRU5H7J++qKyrf9EgGxPqfdV+vWj0UmIQp4r2JChK6aH+CjVS2TC3vhJePYsLqokDy3EEKTDLbx0LmPZIguQ5TveSVMG5/Rxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791699714; c=relaxed/simple;
	bh=Z5aOdlT5DSR2XQ3TOgMoI6YWrfQ5eZLJBB20qQY0uWU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B/J2ILocgBDX35+HyikthSswQQZJ7Fos3Svb+wzyUKdALuD3Ie5GsijUUrIDP2rd/GMU+tY+Fv+5ewHOgOuI9JP1gvYEa8E8Nh9vTBmoqwDZ4Tzy/tIJirFtUU3YMT9ctXVqKYl2DonthF9Nt6wXUiYh5XlWvFGE39BZe6h0Gu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P7oGAhvN; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7oGAhvN"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-85377c8bc96so320562b3a.3
        for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 23:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791699713; x=1792304513; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MhvSViB4NQQAla+wb928rr47xYSUYI9v8T1VArOW70U=;
        b=P7oGAhvNC6OnnAMbFZVP8Ffy8RTe9X0BdrrEYvHE9SrYinzgwDmOAeH2X5bVYXGegw
         ciDsuvAImpZtzimyqVl5i/DMqnrzo7afqs9ILBcr/FXrqFByHSqs2B7WkTKF4R6zzpOH
         EPG5PIcsNxISkYwis03QiG1MoAAr09QiXVhf0q2DjFNO5VhrU/2R9vTthrAI1EJ4OHCD
         wCKjx7+i52wCAll/AxdFqGEe7ylT0wStUye79EqacZ4oMipxt5ei3nJ/K7LwP7pbz03X
         9yAp6ApJ2LMHbXmfcHtGIucjtPgL0wUJUffrPYQadWxj7rtLJP1CoQeAJgDqRqetS+Dl
         NbZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791699713; x=1792304513;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MhvSViB4NQQAla+wb928rr47xYSUYI9v8T1VArOW70U=;
        b=2EaUTKmReWnxjDqKwxUym9bJ5ihS6CR3Ui5XdN9kEU1u3I7dfKyYVJ1sLSTGMhOLiC
         2U8IYFVI7yuIz1PBNBQPUtBeLceofXv4sPO+ts52OKcFz5o5Ik6TdP+VBEryuEUUoAje
         ACpJpbnnKxO7vnBAIUt9lOmY5dTjmbJ/CXDEWWCZ5kVewKahUuGQ/nGfYBd+JW8veNsq
         DIVo6LpfYt+2uvsctsAmS7U8g+ou77NO1VGmZEQiIXxjOvW8s3FCo4bVHWaKce50hbaX
         6rAeAkbvOmniSs3nDv53NgtxPTXz2jzpzDAAj0W30hMOd4sK0CxohM9kkONJJnk6xuRn
         36Gw==
X-Gm-Message-State: AFq9FYJbsxhROHiGKpDxaemMo1WJeMujDosXhgci23kYpFdt6F/2COcR
	dPoJBE2JSFV16VrKwW1TXi1JMQtoztEfmmIOS3CCrDojPIFi5Pt1uOdkSGRMZQ==
X-Gm-Gg: AYBFou2H9UNdEAnMtWFF9VXxFJsA0H4w/I6gFoZYGTRyi3NUwVxAsaiuZiUihTj/x/a
	bDjrdT4hGCkVkrssmSNVDHi/XrD59gqvM7eAkKt3dH6z8Eeh07oPdNAzzt/laTXCh8XC6sEUidI
	/zBKC+RvBlm1MRfUl0W/6U9iq6tEaasiZS0T4sZ6nCcQao/vIJyjdbcpaDv8pyR90FShlybJN9W
	8nh2w/h6nn5BUPgDpfwri42vrq0Y9L5wBOJoafOZf3xwJBZvFhdPtU8fTxM97ZYwgptw0a8+kK7
	DQjVkg/c4JRqRZ60GCvzDneCfHYHE5gN0NqVBPscHitTpIAOAca0CvRPiRwbdgCzQEgIHIqdKvi
	S9d/f8vqLNh3Vo6w/ZG5Pwr4o604ouI/7OuIevW1Svf/dezao5Dd+4z1SkqEC6M34F+nDYPoqh8
	QP0qihk1sigO+27mt1CmiCAfdb9EJ9Owsibxrn3plPTxBCzxafFN+MbE+Y9MBy8JWTWKThPnhRV
	YapIn5GIV/i/5s=
X-Received: by 2002:a05:6a00:4b41:b0:848:77b3:579a with SMTP id d2e1a72fcca58-897c653b577mr5643735b3a.17.1791699712702;
        Sat, 10 Oct 2026 23:21:52 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-896c31071absm2854341b3a.15.2026.10.10.23.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 23:21:52 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 0/9] bpf: follow-up for scalar evolution series
Date: Sat, 10 Oct 2026 23:21:34 -0700
Message-ID: <20261010-scev-minimal-v3-followups-v1-0-6000e95ef993@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20261010-scev-minimal-v3-followups-c1e3f247f224
Content-Transfer-Encoding: 8bit

Assorted follow-ups for the series [1]:
- Use BTF type information for static subprograms when inferring live
  arguments at call sites.
- Handle ARG_SCALAR and ARG_PTR_TO_DYNPTR in
  bpf_global_subprog_stack_access_bytes().
- Fixes for other nits reported by bots for the series.

Fix for build errors on 32-bit platforms was shared previously: [2].

[1] https://lore.kernel.org/bpf/4b4912cf5f30a3c6866a09511c9b5d3a427cb471.camel@gmail.com/T/
    bpf: use scalar evolution to widen bounded loops
[2] https://lore.kernel.org/bpf/20261010205828.3366892-1-eddyz87@gmail.com/T/
    bpf: use div64_u64{,_rem}() in scev.c

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
Eduard Zingerman (9):
      bpf: static subprogram arguments liveness should use BTF type info
      bpf: more precise stack liveness effects for global func params
      bpf: avoid duplicate declaration for BPF_SCEV_REGS_NUM
      bpf: reg_bounds_sync() comment fixup
      selftests/bpf: static subprogram argument side liveness tests
      selftests/bpf: stack effects of scalar/dynptr global subprog params
      selftests/bpf: harden __msg pattern for global_callee_btf_arg
      selftests/bpf: harden __msg patterns for step_movsx_bounds_on_line
      selftests/bpf: BPF_F_ANY_ALIGNMENT for byte_array_size_spanning()

 include/linux/bpf_verifier.h                       |  3 --
 kernel/bpf/btf.c                                   |  8 +--
 kernel/bpf/liveness.c                              | 15 +++---
 kernel/bpf/verifier.c                              | 34 ++++++++----
 .../testing/selftests/bpf/prog_tests/exceptions.c  |  2 +-
 .../bpf/progs/btf__compute_live_registers.c        | 21 ++++++++
 .../selftests/bpf/progs/compute_live_registers.c   | 32 ++++++++---
 .../selftests/bpf/progs/verifier_bounds_step.c     |  4 +-
 .../bpf/progs/verifier_btf_array_access.c          |  1 +
 .../selftests/bpf/progs/verifier_live_stack.c      | 62 +++++++++++++++++++++-
 10 files changed, 150 insertions(+), 32 deletions(-)
---
base-commit: 15b578b1715d9a318c804350d98af87c203672bc
change-id: 20261010-scev-minimal-v3-followups-c1e3f247f224
