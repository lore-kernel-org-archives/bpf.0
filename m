Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E36E3859C3
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 05:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788759766; cv=none; b=ChO2QTnGoQJqPhg2YgygSwurvZTP84Ro0Q3H4YDCTgdQwqPj5sIxkQcyc7XMlJYnkDEqblPEplAQDVF8eerNqXDzBN7aoNQJi/HguqZKaBBGqcrUn6CN2vXEfpAtJiPi6iiNYTzLTjEq4ZKONNt6g+tFr7mQ23vu2uqfehhf7UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788759766; c=relaxed/simple;
	bh=+96xv4UMzgCobHxPWEb/ZyfxeRIg/8YFBZx2BYzFCY8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pCM+JZUjuilupiba0b/EtUcUQnJbI5V27jQaINNROT0SlJ62f1KddPjCVYvRVvEuUxVRRV6kH4iILuxRlAOZrgXM6TdCTaYku5U08THJyl1PLhg51lO6bIDmS6Aih7qZ/+/EPVbMPYI+njIcKrvtKyWCWKOzjLkoO3oGJVQMZwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n6wpjmeh; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n6wpjmeh"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2d9004f39d3so38917295ad.2
        for <bpf@vger.kernel.org>; Sun, 06 Sep 2026 22:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788759764; x=1789364564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tAu5fxgyZ26sDg3uDkdewTDvba5N+Y2xWOAnHoqr7Vc=;
        b=n6wpjmeholvTO8xRbvSHyEVQBfSofWVOJy5an/ZpzWp2+YNsBrnig7DvnpLFTcNEVV
         N9c2kHThpUA2d32A1Y886voMYRkuc456PYf1F39JdRPkkOwWVd637AB4X/RhjNm1p5Lg
         s1gtKf8ztptS7k6JjjPCnrWwsltY6SNFUK9Ch5VlG3D5jLXwMBvxHT1QN37QoIaWvXNA
         EQ/NLAg8YFghaTB/25sOlg37hq4HwFvDSyfGe2Mx6phSv7oPGEdU/hgvLb3TOKoXCdDO
         AHPQd10yJl4ho6qMzD4v+iV19eWiY6qKUj3n4xEzt6VyGkaUDCHQKMLvs4kVRtMZJf6O
         JlSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788759764; x=1789364564;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tAu5fxgyZ26sDg3uDkdewTDvba5N+Y2xWOAnHoqr7Vc=;
        b=JOGo2EGZJ3j1CIXzQLgxuP/VzDE+LVFAKqcAGCjBfXPPNkGX3wyGMtduwqz4GECsAR
         AsS8wLp9PPEEllkSrDHQnTANh5UFmp5P5qm7SyYTBjzFc9Fhpv63tjnxiKIlAX0PVxSD
         V2Jvh+rL0k+ri9cOawS3NVzK4G5oOOiPhiTubMtI8E7zfduQROIL5CNgNZbTDgqkheXV
         c975CHDB7Bo8GXPFCvVX2eM+bXSPevRFu3FxQKg5YSeZEVnynb+hK5BT9UKypC9umwv7
         T+1GfTX2KXR5DXABspVBUkTzReNPNs+kD5gG0xZLSIs1/3pzW7lnyX7PuzXyTi17DIlk
         sIqA==
X-Gm-Message-State: AFuF++n39q3cDw2sM49f9RUoHwlAwmqabzhejUHGrpOSJShlv4PhANy1
	nYZgEVAOMT1DlLCjjAcetLXuTT5KB8HeAbg5sO3UDTc5AGeCpncbhc0=
X-Gm-Gg: AYBFou2eHidTC/gdd7WI5f70DhqTnyPnOVEF5RW6EmnuUjpARYD5jNhWytnAJc/vzoC
	srQnSftqAPQirhi0XmSsPcDwyK4VyLi3WDsAiU2mMY33Kuly/ikh1CYgyx4UfAzqhFMSThrPkOY
	JsJyw5lftnVUqTc9StOh1EFjKaEVau2xZjrjWjRggMik+PGt6EH+SQatYrXXkCMfTFSHm80tdXY
	rNBL4oeNpptqwTwBQ55rg83SSal07JnRDkrVrse+klGzAdknHXMearjUqgKpInGsEu6+SNtovnC
	xqGRkjixJTrxdOMO/sAWnillgRkee17lrOSeCXgNXKGIHAmdg2i9VxdyE3Cr9L82tW8iSwL2iA5
	uIhWDUuXFDpZhSLYzv4h6a7hFjSVg/X3C5ZIYOu/x7FnjHWCO5mONHMk8T6Ag7ekMFKnPvbuezL
	JwVBlnA9eCQf8YizBdzvzLtjSlyfpQMybT3i1ku5yhVvEy6oSL2j33X/BcfsQDm536IK2YOIRRG
	sDdApwxTMGsq/Ld
X-Received: by 2002:a17:903:1a8c:b0:2d8:d4d1:313d with SMTP id d9443c01a7336-2db1267bc0emr293026495ad.20.1788759764353;
        Sun, 06 Sep 2026 22:42:44 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:6467:d689:c773:5f09:906c:a72b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db1483dbddsm39107695ad.12.2026.09.06.22.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 22:42:43 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Song Liu <song@kernel.org>,
	Will Deacon <will@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	donggeunyoo.kernel@gmail.com
Subject: [PATCH bpf v2 0/2] bpf, arm64: fix the exception callback's frame pointer
Date: Mon,  7 Sep 2026 14:42:33 +0900
Message-ID: <20260907054235.473103-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The arm64 JIT does not set BPF_REG_FP in the prologue of an exception
callback, so the callback runs with whatever x25 held when bpf_throw()
was called. A callback that materializes the register, for instance to
pass the address of a local variable to a helper, then works on the
frame of the subprogram that threw.

Patch 1 sets ctx->fp_used on that path, the same fix commit b114fcee766d
("bpf, arm64: Fix fp initialization for exception boundary") made for
the exception boundary. Patch 2 adds a selftest that reaches the case.

Tested on aarch64 under QEMU with vmtest.sh, on the base below. Without
patch 1 the new test panics the kernel, because the address handed to
the helper lands on the helper's own saved return address:

  pc : 0x1234
  lr : 0x1234
  Call trace:
   0x1234 (P)
   bpf_test_run+0x188/0x3e0
   bpf_prog_test_run_skb+0x47c/0x998
   __sys_bpf+0xbdc/0xdd8
  Kernel panic - not syncing: Oops: Fatal exception in interrupt

0x1234 is the value the callback reads, so the helper wrote it over its
own return address. With patch 1 applied the whole group passes:

  #117/11  exceptions/exception_throw_subprog_stack_cb:OK
  #117     exceptions:OK
  Summary: 1/118 PASSED, 0 SKIPPED, 0/0 FAILED

Not tested on other architectures.

v1: https://lore.kernel.org/bpf/20260904070210.4163193-1-donggeunyoo.kernel@gmail.com/

v1 -> v2:
 - rebase onto bpf/master; CI could not apply v1
 - spell the three new declarations u64 rather than __u64, to match the
   rest of progs/exceptions.c
 - no change to patch 1

Donggeun Yoo (2):
  bpf, arm64: set up the frame pointer for the exception callback
  selftests/bpf: cover the exception callback using its own BPF stack

 arch/arm64/net/bpf_jit_comp.c                 |  2 ++
 .../selftests/bpf/prog_tests/exceptions.c     |  1 +
 .../testing/selftests/bpf/progs/exceptions.c  | 29 +++++++++++++++++++
 3 files changed, 32 insertions(+)


base-commit: df2908090cda368b01ff43709f51890076c56157
-- 
2.53.0

