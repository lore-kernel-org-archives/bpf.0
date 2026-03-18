Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com [209.85.167.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A3D3346B4
	for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 10:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773830132; cv=none; b=CMzmlnvYQ+fRPBeaN4QiBmBkD3HsmfZeGoYPhECcYYHqaZCl+Ytow88o7HgD0Mfy4XZ0J1WwzNpCeBoSV5yLEP+hGvAj0dvDFGELcadBE6GFrHW5ujpK1Z30pSo6xHtdXsmN+Z+HeNU5AtyDJY0upEkNbCYanOEwzWwOaJS6hGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773830132; c=relaxed/simple;
	bh=uk6YmNwGEcjdujBwQOqYsKEaF+rwCEsC28tlQhfd14k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=izOoK2d+4zXx55Jp2POsq8PmhKrRuSQd4D+P0OJbnII8tUunkNauP54ca/WIRC///N5XUThMSuN2krYn1Rq54800ro8T4UCKP4PrRb0djpdo2/xACxT5Qf+bx3+0C6QLurdCZj3zd3Of0UHnmNRoYsld0fwk5dw95RJOWyg5XIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JUf2wVVq; arc=none smtp.client-ip=209.85.167.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUf2wVVq"
Received: by mail-oi1-f194.google.com with SMTP id 5614622812f47-466f1c3c627so4553909b6e.1
        for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 03:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773830130; x=1774434930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F2sTQDk+B22L/xj3yOeTCQzJjqrRO0N1tHqVlnKI9SY=;
        b=JUf2wVVqLRqNOc1gxg0Oo3+cLRN7gGYgmtScL8lmfDS4TRBhR0sGeVMTKIqXH2T0Vv
         suVZ35pm01N4objH8BYcUJjq4iKwlP3gpPJZbQdR3uwN7nEQBQotOI1+j7s1xc/jjjnm
         fGlbP5JqdmJrprzkN/JkFlL6zCS2K4OUpK1Xb30AXwUuV+EERPdc+FrRhSCCvoOAVe4Z
         N1TT6p4JWrGSXwXFHuKGo6aYGdWgzw9qtFFy2Cq+ATz2BBP56yN/X/LQR9VmZNclyJcN
         ooOuKBaFtV1gJ9TQAR8yYkNtDAP0HShXkrAzy/yFSKOnNH7/TH2Ig9GX7ooIZzkfoRuU
         moiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773830130; x=1774434930;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F2sTQDk+B22L/xj3yOeTCQzJjqrRO0N1tHqVlnKI9SY=;
        b=KJdqtrdjsCb5AwHw1BqF5IjkUQhx8aJmxi9TUvLeaP8nBYfMKMDUTIBR3pdV+nwVsN
         FwZ+ptaJe4164vsWPiaidXos9kLad6GJZIUk2XQyu5yM18PCQFDZCBKtS3GiVNYf0YQj
         x/L01kDGUBvmIKz//w8zzTzbtFLgTlBLDua4woNkpDs7I5Dxmx5aO+Lfj+whfMtmwyD0
         uGshLQ2ygEkZiOFVAekdzpoYi8qnah0QjoaSvj7WuxIdBcJ1YYYZvuVM1yQfyes3csMl
         a1wti8Xvb1c0YlgUqxY9h4Tuh6CUK++OAJDwhKnblAjF7GsviIBNvMXqwX/OCaid2QZp
         FLZg==
X-Gm-Message-State: AOJu0YzU4I7g9zIYwYbT13oCPbDJ/uzgQsfkXcrlGHUsFz9cbRhFYwE4
	aDKk4dwIOIbARv9RQoKsTysRXZePezUK4MPKD7EK8HanOU7PRpXL9pmB193M5CB0R6c=
X-Gm-Gg: ATEYQzyx/y9W5zsktvkbEjC2CWIvWlbIDxiJWeT0H+YHlkNT0dHeCbVJFNQiK/krefp
	Y22b06ZtHwD34s8fEC/Q0FordmBvI3xOzJKzRzm0mZfP6JcVp9GnZRXuXQ4vbcF3lfz1Y5PVwIG
	7VRqYbX/MwvQmia2lC7UxHw4PKznzcVO9hxYXVsgStLjfFtr92wKFPnSjBMjmWH/8aXYh5a2RnS
	9iGcfIm6Ed0249zhozsJ1M8zcs5u0htPdSYrgntiW2LqV15/7BqDEuCwkvk/KEOOugZzcvHybQY
	Gqp3x+c/Yu7FKuc7o/3Zvgz751fWHq4xs5ALQ72p6ftel89ix+Sawr5SPsHc+GT1xthenZqXyxh
	06EOQxVq4GmnFdi27efDBzrT5QFTdOi779Yx0WRRHKKPbgIVuXjJ7n4LHrOeIeUid9+iSAqdYP2
	39YOUVk6GFR7wGW+IqpHcjfGTyE7wCo/bb45ABIpd45B6t
X-Received: by 2002:a05:6808:c2a6:b0:466:fd68:c876 with SMTP id 5614622812f47-467ba2fb4ddmr1796002b6e.53.1773830129589;
        Wed, 18 Mar 2026 03:35:29 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:46::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-467ba88e28bsm1471353b6e.4.2026.03.18.03.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 03:35:28 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 0/3] Allow variable offsets for syscall PTR_TO_CTX
Date: Wed, 18 Mar 2026 03:35:23 -0700
Message-ID: <20260318103526.2590079-1-memxor@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1745; h=from:subject; bh=uk6YmNwGEcjdujBwQOqYsKEaF+rwCEsC28tlQhfd14k=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBpun/ltDWJl0fTH7B8bSFrlGxtIH3XOSVYlax7S2IL x/1GScWJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCabp/5QAKCRBM4MiGSL8Ryu7KD/ 9YjDeS5OtAmyijVyvi+sbu50Hu6iwUgiTDbb1PWfSeuNwhGaXRidu6/nkwtksoxNe4d7/CpCBdXypY 3Qo69aYC79sPy5CglJnDEHC2/1rC+ZKMseUvoqWZX+rcLUwzM2Hpg5P97L2SH2AuZA4GuIMwjAVuLA GKv4fvRnllVF1yBDvEGRACeHVOuSPvIaMH9AEYgN9H5SRtQSRUKLZ3zVSZm/+ENQ/T8xzbM/L1j1su kwZmoudK51n6XVDE6sEymfGnTfeX0pes5m6WJUWSfjx6KV2mCSf2MK/6lKWjyWD/PYekXrfbk/J3Xz cRJdwVMAcdoZqSPF0uJo3ofHViiPdVp0mCTR/+YDy89Yz4J2xcf3r1uXidVaakroNidNReUK+w1cEb 13oa/NBjdMs44j+GKIHK8nSqB6HxJjWuYyRsBqGBN6mjMaeIb9UI/NfB3B44rPUjCaLjhOlW4okLjS hpLVSFJTg6jVw5GmsrKYsFbpPjeFxCDM1XJew2Vlx8gCLN/BevYYPd5+fWvQfywQvS+gSWbeLM8vO7 3DwTgd0k0LwgUCWF+BL2dAfOQqldadG9uZJ+ZQFMo6xeLfMps5zU7zDJR4wnRYtaER/T7OY9ThNpn/ GfxZMIezQF4hRVnCZp/GbiUrcNqHnzOE/8S01KtgoLj6Ux8rD0hE8VFQ2Upw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
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

Kumar Kartikeya Dwivedi (3):
  bpf: Support variable offsets for syscall PTR_TO_CTX
  selftests/bpf: Add syscall ctx variable offset tests
  selftests/bpf: Test modified syscall ctx for ARG_PTR_TO_CTX

 kernel/bpf/verifier.c                         |  67 ++--
 .../selftests/bpf/prog_tests/verifier.c       |  34 +-
 .../selftests/bpf/progs/verifier_ctx.c        | 356 +++++++++++++++---
 .../bpf/progs/verifier_global_subprogs.c      |  95 ++++-
 .../selftests/bpf/test_kmods/bpf_testmod.c    |   2 +-
 5 files changed, 462 insertions(+), 92 deletions(-)


base-commit: 77378dabb50f593c756d393d8eacb0b91b758863
-- 
2.52.0

