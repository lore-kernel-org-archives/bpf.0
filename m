Received: from mail-oo1-f66.google.com (mail-oo1-f66.google.com [209.85.161.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AC3397682
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 19:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775504647; cv=none; b=M5mnlCj1wPkEeHoIYbffL90Btf4AIeIMgWda8P4WoPO4UVkabbnz5YmhN+d2Kmf8hM0IEK33YXzo5vmZXRbw93+XyDuBvwulk8qsdukg7OZ1rhi1DpPycob0cT5ImOa9ss+IW7geJ0MofPy6XRis0/CjXE9zZ6c+axx0E3adNXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775504647; c=relaxed/simple;
	bh=JWNFnlyWu1XqMiB2DvWBa0jKLy5SRCtqfJdBBfqSAas=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mtE5RFM9tqyTeWgAk3Y3pc2HHxxwKgZrRyUP0xynYE1kWPgDar7qusKRD/Ee2A50FzVev1Z2qs3u6QaRZbURm/nzXG6e0uyZ5gxIhEtPIFhfjdav/ucf6Bxs2YDrEk1GMkVnWzS9HNShvYGVnpA2x3lF5pEH5tX6Yls1VqmK+yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eClbjbOr; arc=none smtp.client-ip=209.85.161.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eClbjbOr"
Received: by mail-oo1-f66.google.com with SMTP id 006d021491bc7-6841e6a5e51so1015614eaf.3
        for <bpf@vger.kernel.org>; Mon, 06 Apr 2026 12:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775504645; x=1776109445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qWPrO4n7z3Vx5b4K7STUdMbAzzPkLY+HsPi1F88RPSg=;
        b=eClbjbOrbnIqPh5vsHY+uQW+4DEAU8unlak/iHj/miL0FpppCnplHZ58MnrFRw5LD2
         nhyLJG2ntP2Twpeei0zeW6um8RSLKVZUUS96yV3iavuYDK5wBEJCGBs1D+tuc3H3/3lg
         Brd9vSqiHhabm4r8KnuajYFCzR/oYE/OemrTAYMXBHK/GnzZ/vBpcO4AF9fbthuKi/qs
         gWmKD5pqkC+0sjGoe2FKahsq/W2QhOQX1SxqYUwqVLrXL/7DuJ5LEE36u4nys8+Ccmhz
         PqtYwM9WWihYS+qebrkFCqyxn2M0HU4SBAn97DdaHw9udVo6/W3XGAM8+8P7p6s1ofVW
         9UTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775504645; x=1776109445;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qWPrO4n7z3Vx5b4K7STUdMbAzzPkLY+HsPi1F88RPSg=;
        b=Plra6c37AQTZiE0vNm0HUyyKFY9lvP2ecQGLX0Sp2CCKjc3pXxyns9/WyD8y5agRFo
         Qa2OqYIqzgMP5u3fQnhBhnZ1WFsJIF0hKwZEQRxzYKthdxNImFNkz/Ayd9ifXt/VDZkV
         8rtPKBtByBapIKLol9RZFxYRiPXX4uT8lefb5D1DP+7IBg4lLPsTijqLKjFfPFEqagHO
         cCFDlOKQv4he43ZwNo2XcbhqsjmLi0/H2xFeQhTYxoC8WGOjRvqlydkWPEtcHjg4OJDc
         Ni3j/DLitCyrpJNxouZ43Q59TBOP53CJTV6KnV7DyzHmpBNtEMTua2iIw83wx5LdkUH4
         EhZQ==
X-Gm-Message-State: AOJu0YwPv5tAbQ9eUoyIg92jFWQNJBHnmbXmsTw1JqkfkORHQsG/u0vC
	pts/oU6wTqqHWHXyGTCTAEFahdujtZXq+czAOW6iGa9FaGBkpxksqILahw0QRwif
X-Gm-Gg: AeBDiev7a6C5FJChWdLBi5tNarmKOYL5E8BdnarTvBPDyOss/UsEM0nY+NWkeNvFmaW
	woRWF50ez8Nelve93SN6or2wkZONxxEOSHjrz6bxdlp7A2TV9/4FhN5AivRXavYKjuLGASt7v1P
	Itr/vvZWKGAeNeyA+imI6rCSbY9T23y3iRsuM8FUo6pxsYltu1uvUhBTSCXxT6dUCKNe6LS3bHI
	R850446hTNSNfLVTW5BRnxa0MvXfh4ak8ujZDVC///bBXWOO/zFz26dahRYwu3aHCa0/qb3M0Zn
	mkJjnmp9Pk+s3M0Wgtvn54C7KrQSzoItVou3ANXDhvBiVES5SISUSiAdHiHdCiFQQ8oRrax4c3K
	zT0wM6sMshzPxjLSZRY7ji4Us1W50M+A90kC5hZrLEka6Jmu2WYU8GLzMg8Fud4BelL6BTvLWlQ
	G9aq2Z5gRAU3SxQ94Ljjvc8goBfuOF0oBc0zImY4Z0MzkU
X-Received: by 2002:a05:6820:81c4:b0:67c:27a7:8c4b with SMTP id 006d021491bc7-682203485c3mr8410718eaf.54.1775504644808;
        Mon, 06 Apr 2026 12:44:04 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:4a::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-680a8d1d2cfsm8808318eaf.13.2026.04.06.12.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 12:44:04 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 0/7] Allow variable offsets for syscall PTR_TO_CTX
Date: Mon,  6 Apr 2026 21:43:54 +0200
Message-ID: <20260406194403.1649608-1-memxor@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2874; h=from:subject; bh=JWNFnlyWu1XqMiB2DvWBa0jKLy5SRCtqfJdBBfqSAas=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIfMKD2tGb6xKRn+o5MfL34O3ak133hDWVrR4jvrmL8xnw1jV r23vKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwES6zzIy7LM4UlKkVTxf4N/mw6Y9Ct U/5HZyPW9jvFQ6X/BOtaDiBkaGt4oFF5neTJxaaSOcu6/43dt/W4Nfqh9qfL3HP7qSQ/g8OwA=
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
v4 -> v5
v4: https://lore.kernel.org/bpf/20260401122818.2240807-1-memxor@gmail.com

 * Use is_var_ctx_off_allowed() consistently.
 * Add acks. (Emil)

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
 kernel/bpf/verifier.c                         | 103 +--
 .../selftests/bpf/prog_tests/verifier.c       |   2 +-
 .../selftests/bpf/progs/verifier_ctx.c        | 591 ++++++++++++++++--
 .../bpf/progs/verifier_global_subprogs.c      |  95 ++-
 .../selftests/bpf/test_kmods/bpf_testmod.c    |   2 +-
 6 files changed, 703 insertions(+), 93 deletions(-)


base-commit: a1aa9ef47c299c5bbc30594d3c2f0589edf908e6
-- 
2.52.0

