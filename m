Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com [74.125.227.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635CF4A5C41
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 13:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788786402; cv=none; b=nNJT+LUB8HEgDD3FgPRLJQbCL8uz3+AxpP6n+wIvGNubs75YP7bcnclrwFCzHkIhCwpMlyqDCcBcyVXB5NeOBLwUS2hAjwVCdAm6ZXsiJ+3OAJjuvp7vjA+yh4LxlPopW6V6DIdlqcTI8deyRU3y3TcQAgTdfe1sFg3dgRTqlr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788786402; c=relaxed/simple;
	bh=KVlall24y0p+qSno+YoVUQqAPfLtfndwd2+UzHAoFPA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aIPM6PiFQSsXsE6bh1XR1p39My6EYraPvFnVMbJPYCvFJ0fIL6GVIKdy21ibUNGH1KNSoLooz1cIhZ4Ryj3E8akx5imvgEFBDyqONP+q1ua1L+SMo1VoueBeK9q8qjSSyRvuxjQXaeh8HbstJgNL4M9QVQ1wepibomWtkSHLvj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H3qWyb9H; arc=none smtp.client-ip=74.125.227.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H3qWyb9H"
Received: by mail-pj2-f11.google.com with SMTP id 98e67ed59e1d1-3989fdf58bcso170359a91.0
        for <bpf@vger.kernel.org>; Mon, 07 Sep 2026 06:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788786394; x=1789391194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=riOSU4dH10zq3tO5Dx537AG40XCcFzKoLCwwWkJ2TP8=;
        b=H3qWyb9HYdUXJ65laXKBATV1baqz1RgE7zo0b3nN9AwTcM5Bt7qRTW9J36gxaYzzNV
         GELDpAAL3tt4ZvdmFhSzX2zvdFGCasxYHrj6SbjdJRL6Dwr1LCiYj4DBXrTH6yOHWkKI
         Awa5OTOnpMG/iCsflOls/EnjN5bVePxtYOIoCOCuSpQ/GvRJb4+yuTuSO67ay+//8VG/
         6Po5xHLKnq/4TvsEDO0m+KLup5Ct02olWGNMcavO1zXLzjnPvVJz7N9SQ/f+pQafDB7R
         //y2yGMAkZpwiEXwLp0jF448C80y3JcjHGbTinlWEHkUjjZUNkTc3GqbKcKPo1z9cBAm
         8XgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788786394; x=1789391194;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=riOSU4dH10zq3tO5Dx537AG40XCcFzKoLCwwWkJ2TP8=;
        b=sOR1hKuZ+bNRR09b8JxmljxBI5EICMAY1qlvA2HgLO6QBNmm+NxHP9pyktGNtfrwTL
         sW1/XjhSL5viWhGpcUIGq4cfakV0GaGahHX/Yx6MjaFIs20MoC7FUiMZSZPnndjwvwuG
         q9DDULNbk9azjw4OpvG9KKdMvldkVlLlHQI+9uD5Tqt2FNgXoQl2Q8o6g4wilpvjkkNu
         /zQp7am33p2k3nmOiUH5LfhuoEni5tYbj0jmwQ3MIZQSjFjpi6MAilAxtbvp946VSa3W
         qDntSD/hHz0AN/PrNcY7R1ABuLqb9YiVR5wGwUxuBVF23FkyRmdxX7ASyXOv9VtjLCx+
         e8Ww==
X-Gm-Message-State: AFuF++lmgrmFWPx8Xjzj1aYZf8HJGp2da072Uu5odoPdUsYbSi4vEuQb
	BJ/m87sBxNi8uOKfeHnBCiSBo7/N0YGM5kSfNweLprPt8haUkrV8wo4=
X-Gm-Gg: AYBFou1AsxWzuFyMxK1q2DaQrDJ+ZnpTA7PPqLUzTljHIgldzjzrFomdzeMlAezSr6K
	ugpnioniGks0fpKiGHPCV8Z9WmHPPCDMB31cqPS61HFPQRvtmHxvAj5ghBEF0asvwY2DfqysEDC
	dORHVdAfU0zJ+9C3tWp+0xTQgvhC0r1vAD0LML1QgauJhMvQNfoMET8O309F3hklUcjwi/wt1PH
	pSigIL4KeQ7OTs/9HNChmCX8gGYMQnQfMvLnTjtkOZCOIn4A2us4+O31axuoTWvx//ZsPTKw+3C
	kLd5M/k10EZgN3F1CWtawf3NFFLg7IIkiduIfGksapeMJ1J2GEWe01EFOnKz3SWg/tt+Un5KhXa
	RmzZOcJ8pj12IrdOVvjHEThUNiKdzLDyMteBimJCjM2fSCcrLaQW76jSCnhlb7hLyOSj/vcO6pQ
	jtJc88X3Q9SpkQtG8O8OCDHIVeKXRTfn1efKiGZJKgEGAgWnaRvPnyJgqYwN6TcMVQ9xIvj/fB4
	PXmphNH+yqHP3zP862ArGM1awQ=
X-Received: by 2002:a17:90b:4b83:b0:398:9bd3:d6d2 with SMTP id 98e67ed59e1d1-39b8bec8c1fmr661379a91.12.1788786394289;
        Mon, 07 Sep 2026 06:06:34 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:6467:d689:c773:5f09:906c:a72b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b07b197a9sm26742398a91.0.2026.09.07.06.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 06:06:33 -0700 (PDT)
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
Subject: [PATCH bpf v3 0/2] bpf, arm64: fix the exception callback's frame pointer
Date: Mon,  7 Sep 2026 22:06:22 +0900
Message-ID: <20260907130624.611942-1-donggeunyoo.kernel@gmail.com>
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
v2: https://lore.kernel.org/bpf/20260907054235.473103-1-donggeunyoo.kernel@gmail.com/

v2 -> v3:
 - patch 2: use the standard multi-line comment style
 - patch 1: no change, added the Acked-by

Nothing compiled changed, so the numbers above are still v2's.

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
 .../testing/selftests/bpf/progs/exceptions.c  | 30 +++++++++++++++++++
 3 files changed, 33 insertions(+)


base-commit: df2908090cda368b01ff43709f51890076c56157
-- 
2.53.0

