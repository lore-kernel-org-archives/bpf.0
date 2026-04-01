Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com [209.85.210.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9F8405AC7
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 12:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775046503; cv=none; b=PspuDKGsJcQ21OspME8RqEaY+otMx3cd0mMkBzRBSyKeXcEvwEL4lr6PfzIF3TAVQgXrguxc1QdxwbELESn3QOWkgMNsjjcwpCMrzbu2FiVZxqOzoLlShYTTifIVOqvTQ1NjMwpi1IZST+8cMymCBP5aQY3WnX+xQCp19RI5YZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775046503; c=relaxed/simple;
	bh=nU3Z39NrXqbYOt2XKhPpVD4jKeMG3/JjxCQ8Jxy/Ohc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C1cSRNzgN9b2F775nXafYQ2cNZD/PomFIQiOxlHNzEdSd0XlLxZcHZojWzf1N7SbGPs+aRTjDFroBugvJkoIUInB/SgFiMzPzH5oldJCd+gxZmRTdwx321qVeRjC5bVEfL8k/WhOEfh9mYAS8rXCBEFcpq9E/jACzkylbQuEf8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f2Out60I; arc=none smtp.client-ip=209.85.210.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2Out60I"
Received: by mail-ot1-f66.google.com with SMTP id 46e09a7af769-7d7e565c877so3294253a34.3
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 05:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775046500; x=1775651300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2RU8CnW4BuHeiufgwjJtePtUfvMrUJkSI9yaJGHgH9c=;
        b=f2Out60IvxEQjm5btuQLMNWRuikJ4rLzxbM2yFEmPN7QCr9pomNBGkoftxm4hr36lk
         B65ywb7SERSJgRO5tk/eu9G1gaU7f6tRfhTYvckpn6SAWbtPn6ImgVEUb7/5y+RXpELD
         q5s67qWZeje4SDYxIq9mfAzJgNoqfhf0ULS+JfgHoO4wp2J8e3ID1o4WSJw3lWCfr6za
         IwKD6fe4xIRb7XQSO+UQyEa5wD/7uBAMPbk34q+V4QixxOoV+ayJYiEvbsRCecyvtXjl
         tjpOnSXIzCvCUQC20EYgqra+mW1VdIHPpB8UE1eoCJa07kUqbG51K1EEazuv54Lmmgbf
         KMmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775046500; x=1775651300;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2RU8CnW4BuHeiufgwjJtePtUfvMrUJkSI9yaJGHgH9c=;
        b=OF5eMVmjIbwdWwL2b1ZrmEh8kd7aB5d2IEYLnvIUWKLrFslmaL188W3zVHenb6r+Y1
         Zt9l18Mlus4JEqKfbXF/uegsX8EAmOe27y44P904V3keYS19gAHu9+iE+j5vJKWYeuCh
         SuTfLqDTVNCKRgq+coigabvKWolatAphQVIbn+knQ6HuWvhOvqq9hzS+ubiE4L0BjWST
         uuRoqGz2X3evy3kZ4mAhyWM5riV7fQCKtU138AfuK3wAckLdFdrakslVq/VVX+j3k+V2
         MluzEJQDfBeDiNPA1yhEPCDxZ8IMGOfuM8eZ9s5NmT4bKqzCoHBIfHQjb2MacifCYXxi
         3Ttg==
X-Gm-Message-State: AOJu0YwqIos7BWHbQg46LXekNQwFKNXiAkPvpWfR2Cvxit9NYF/b9O/W
	04++i1VsJhhTVnWuwJPpobozrgzmr+dny0SrUH+WeDjvgXycNDMf2KhtEzTK5PinjzU=
X-Gm-Gg: ATEYQzwQbjbwKSdmeUGPj9Sb75YspJPyAu1sfEylCVbrgZ8Ep2v+OXMuUawJV7r9xD7
	22uTyXKHMZeeg8T4EBu1WjRKEDiPVvck7c6QA/uGy99dOOSAuEB7JII4R3el1tSYNkLygQ4BxDP
	e5JzPgrrUWXX41mz7N5mbcwT6qn8XRSfEhmcTfCqoqvKp/FMco6seixSo8fAK0+Ssd3q+XpdJHW
	NURHRFtvE/nDpUU+hqMyGMc+j1FBcOah+pGe4dwGRi8lekT3XtbLMQ6R98JMcGmxc5aUmWEC8oM
	SWf4EHHdSTTvb4VHki1QYcjU1lz50NkAYcAV1cHcyn1Rade8mweED0unV9opazocL1c/rnv/yHp
	zfCro04aHoKWGcMSr7wHszi84ihG/4NXN9qeqwJ4MAOU9vyRXJxdXL6V34kpECtMn3/sVhVKw3B
	AWhVfzVIIvJnshsHSCIykDnfwdqmyuCAM8eiJ6DXrh5zei
X-Received: by 2002:a05:6830:3741:b0:7d9:add1:4399 with SMTP id 46e09a7af769-7db9942755amr1971918a34.27.1775046500303;
        Wed, 01 Apr 2026 05:28:20 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:56::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7da0a814e0esm10375054a34.21.2026.04.01.05.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 05:28:19 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Dan Schatzberg <dschatzberg@meta.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 0/7] Allow variable offsets for syscall PTR_TO_CTX
Date: Wed,  1 Apr 2026 14:28:09 +0200
Message-ID: <20260401122818.2240807-1-memxor@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2717; h=from:subject; bh=nU3Z39NrXqbYOt2XKhPpVD4jKeMG3/JjxCQ8Jxy/Ohc=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIfMs361tZ05dfnd/+v21e1+oK/6/sUus/u+h5V89OTbyiZ+N qfvf3FHKwiDGxSArpshS8n8fk/GJyt+Btsu4YeawMoEMYeDiFICJzPdjZHgpedJopWr3mtTVpja/oh OTJjzplQtMuL5uFwvnpx8fzbQZ/juv/d08/7TKtatB+nPPTWRc78HBafKpjZ/7jkl18i/J5ywA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Enable pointer modification with variable offsets accumulated in the
register for PTR_TO_CTX for syscall programs where it won't be
rewritten, and the context is user-supplied and checked against the max
offset. See patches for details. Fixed offset support landed in [0].

By combining this set with [0], examples like the one below should
succeed verification now.

  SEC("syscall")
  int prog(void *ctx) {
	int *arr = ctx;
	int i;

	bpf_for(i, 0, 100)
		arr[i] *= i;

	return 0;
  }

  [0]: https://lore.kernel.org/bpf/20260227005725.1247305-1-memxor@gmail.com

Changelog:
----------
v3 -> v4
v3: https://lore.kernel.org/bpf/20260318103526.2590079-1-memxor@gmail.com

 * Drop comment around describing choice of fixed or variable offsets. (Eduard)
 * Simplify offset adjustment for different cases. (Eduard)
 * Add PTR_TO_CTX case in __check_mem_access(). (Eduard)
 * Drop aligned access constraint from syscall_prog_is_valid_access().
 * Wrap naked checks for BPF_PROG_TYPE_SYSCALL in a utility function. (Eduard)
 * Split tests into separate clean up and addition patches. (Eduard)
 * Remove CAP_SYS_ADMIN changes. (Eduard)
 * Enable unaligned access to syscall ctx, add tests.
 * Add more tests for various corner cases.
 * Add acks. (Puranjay, Mykyta)

v2 -> v3
v2: https://lore.kernel.org/bpf/20260318075133.1031781-1-memxor@gmail.com

 * Prevent arg_type for KF_ARG_PTR_TO_CTX from applying to other cases
   due to preceding fallthrough. (Gemini/Sashiko)

v1 -> v2
v1: https://lore.kernel.org/bpf/20260317111850.2107846-2-memxor@gmail.com

 * Harden check_func_arg_reg_off check with ARG_PTR_TO_CTX.
 * Add tests for unmodified ctx into tail calls.
 * Squash unmodified ctx change into base commit.
 * Add Reviewed-by's from Emil.

Kumar Kartikeya Dwivedi (7):
  bpf: Support variable offsets for syscall PTR_TO_CTX
  bpf: Enable unaligned accesses for syscall ctx
  selftests/bpf: Convert ctx tests from ASM to C
  selftests/bpf: Add syscall ctx variable offset tests
  selftests/bpf: Test modified syscall ctx for ARG_PTR_TO_CTX
  selftests/bpf: Add tests for unaligned syscall ctx accesses
  selftests/bpf: Add tests for syscall ctx accesses beyond U16_MAX

 kernel/bpf/syscall.c                          |   3 +-
 kernel/bpf/verifier.c                         | 104 +--
 .../selftests/bpf/prog_tests/verifier.c       |   2 +-
 .../selftests/bpf/progs/verifier_ctx.c        | 591 ++++++++++++++++--
 .../bpf/progs/verifier_global_subprogs.c      |  95 ++-
 .../selftests/bpf/test_kmods/bpf_testmod.c    |   2 +-
 6 files changed, 704 insertions(+), 93 deletions(-)


base-commit: 0eeb0094ba0321f0927806857b5f01c1577bc245
-- 
2.52.0

