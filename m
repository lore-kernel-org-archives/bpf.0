Received: from mail-wm2-f8.google.com (mail-wm2-f8.google.com [74.125.225.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B091F1513
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 21:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788472082; cv=none; b=kNQhTpuZkhCzKsRhmGwoPKQDPKUHVd7VbXlasbSdTwh6aTnnEtbXiCSRSKNIX28g7pFvCEWyZ2zBGJ2vwTf03py8vvM5p8hQHXuqjC1c00hQ6CElELUM7dNf9jXeJtP6FMjH/eW0AaBv7U1ZokyQFCxU4qwBQnduCnQKX/G0FIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788472082; c=relaxed/simple;
	bh=4UD8I37K0RXoLIPUXMyW+2MUjrAqPIh15XaXqhMe9DQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vFnwgwV3leodTx0OdEXvCAcH+e6WsjxMLSxwSInzIV9jNWbq8cMbTFgJP2fbaC4Vcme9YxRC3HRxNrKz4evHyib1UwiOOFPd2EPDLXkmRH1yZpEgJabMscvNckWrwfj7uldFhXEngdP1v2xHFsTRVQ7ufk+yCMIQnJIDlOs1+Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LlRZ7pk9; arc=none smtp.client-ip=74.125.225.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LlRZ7pk9"
Received: by mail-wm2-f8.google.com with SMTP id 5b1f17b1804b1-4956bc73c0eso1019585e9.1
        for <bpf@vger.kernel.org>; Thu, 03 Sep 2026 14:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788472079; x=1789076879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q6km4IsM1i08QsKa0z7Za2q2aLaRMb7YgiMbzs38ojg=;
        b=LlRZ7pk9UlWfSPEF2yu5TLPI1cciZzGV9VkdQGhGsyjzLI7+Wt8s8V6/2X5tKARs6/
         Z22k/snWrKXeEi+O7HeNmzxgRW/MOxQ7u1Xzlw/Ug908hDiCe7ZDYNhvJyGRi+vnSBVu
         g7J/X1Q8ASuW80hhdyUlUDkpkJx3GllUg+d1r0CeaU4Mi9KBNhjr9yJKQrS6tvwlH/z+
         s9XH29nHv2uoXqAL3Um0K7f3PEQ06g2nB4u6hGGMm9UvQM7ECjNGmdtkm/Kxn0OZYxN+
         FF2eLVYK3WWQ8ULbBWIpzK3wukUZSnek3VUikjiYtLKPzpy+SIef08XPvyUFrf05pS4+
         Mxzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788472079; x=1789076879;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q6km4IsM1i08QsKa0z7Za2q2aLaRMb7YgiMbzs38ojg=;
        b=McwH26VUofQUbdZ4Hd7m9S5IdHVFPCEtzMYpV7DLI5lzO0YZDu8rNb2ZMXzY9MmTn1
         M5CiUcsXXHBGXasv79UOSU4NT7XNeGVCkaJ5tjiAu+rX+GX3/nBV32/YozZL3iCl0ieG
         Q8Xs2S4Pi0ysICSNSLl84/OynR3CqTHKDPsxRtWWIPT8RsGKfJGhA+/xTQb+NH0QQPRc
         34VXbrwx9oljaDf6XhdOXyZmb5lgog52VmRMOEM/O1J64k12DuapGU8uYIsDfjpmiQHN
         ODb8wkkRuz70ujImMTu4BIgAHydvXlsLC0vVb0bAWthpgojDPtCwlYd5hnuETdSYnRTj
         xtHw==
X-Gm-Message-State: AFuF++nfdFRXDqtkTmBTH4DhCiDtseHKk3TZbExx90tjZBQUKr1SE7Sj
	78aHRdxgBM6oZPna+4nV5KNwOBWw5dAIe/qakAHqLgSs9K09o47B0Qqlc2V8AuNp
X-Gm-Gg: AYBFou33H71mDTi9tv0ATPhaYfTGpaEIuFJawiku9Y/dczXM6e56qv5C48l9VYPAi/n
	bwonJqp5qbrX8xfE/DBleVrQ/CREFOu7U28MaZA1Cfc2YupbW2BSCC4DFayEeDYtyo+XInC5hna
	gbkGt9chthRlzOwisJ8w4CDX9cM84l9p3l0L/SKxUJkYbCHCalpzCCBFUQfoQVvyHLuiVEXSqU5
	lkyeiqC/VmnkaC12OkIogePCqukZbD8lk4huZbVblnGPiMBNj6gWruAniMjwt2BAqVKU5xRiEbo
	kgfwxdV+TlaEgQ8gBohYu/KtHE50lp7N17OQbOhk7kgjQ5TNQwUnpxLrrUWjMwBkcfiego0eQr3
	S/2brQE18zlf6lsQKna2OYhMGfItQ3B/WOkvE304xXsWKG4YkWvP1tcCr3pdULOK1oGpKaPX4PK
	JckDeASLlJlQG5lkefRiheK4f92rv9KJvFTYuBeOnjQiNa2vzqTbIN6qOkSvwDRbjmdFiEBhZ66
	AIHV9I65DPsv8zVzXQUkdxTtVed2VJjwkmScZDysgiU28UffdLun/kLsMT+p+UPoWgNaNXa+Qtk
	z/CSzg7nwQPowYdKaNhAmW6pE7o=
X-Received: by 2002:a05:600c:34c9:b0:49c:f729:d757 with SMTP id 5b1f17b1804b1-49cf824f757mr16918865e9.11.1788472079301;
        Thu, 03 Sep 2026 14:47:59 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf771e9absm15597215e9.9.2026.09.03.14.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 14:47:58 -0700 (PDT)
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
Subject: [PATCH bpf v1 0/8] Misc bug fixes - part 2
Date: Thu,  3 Sep 2026 23:47:46 +0200
Message-ID: <20260903214758.2727663-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1177; i=memxor@gmail.com; h=from:subject; bh=4UD8I37K0RXoLIPUXMyW+2MUjrAqPIh15XaXqhMe9DQ=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvma+aAxZdrC9ed41N9tWLemVPPHwQuN6vmePNzdinj2 6MTpt/U7ChlYRDjYpAVU2Qp+b+PyfhE5e9A22XcMHNYmUCGMHBxCsBEqmYx/LNqXnii+EC+gEIN gxDvjTdOiy7s9fraKyfYVhBt7X+wVICRYcHC9dqJ75/F6kfuXLtqz+/lu110nXo4S1WfqBxzaHy 6jBEA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

A set of miscellaneous fixes for bugs reported by Nicholas, plus some
new findings by GPT-5.6-Sol and Sashiko. See commit logs for details.

Kumar Kartikeya Dwivedi (8):
  bpf: Check ancestor frames for rbtree callbacks
  selftests/bpf: Check rbtree callback restrictions in subprogs
  bpf: Mark bpf_btf_find_by_name_kind() as sleepable
  selftests/bpf: Test btf lookup helper sleepability
  bpf: Mark faultable stack helpers as sleepable
  selftests/bpf: Check faultable stack helper contexts
  bpf: Reject legacy packet loads from callbacks
  selftests/bpf: Reject legacy packet loads from callbacks

 kernel/bpf/btf.c                              |  1 +
 kernel/bpf/stackmap.c                         |  2 +
 kernel/bpf/verifier.c                         | 42 +++++---
 .../selftests/bpf/progs/preempt_lock.c        | 52 ++++++++++
 .../testing/selftests/bpf/progs/rbtree_fail.c | 55 +++++++++++
 .../bpf/progs/verifier_async_cb_context.c     | 34 +++++++
 .../selftests/bpf/progs/verifier_ld_ind.c     | 96 +++++++++++++++++++
 7 files changed, 271 insertions(+), 11 deletions(-)


base-commit: e044668419b9c444282bd09521f7ea07edbc10b1
-- 
2.53.0

