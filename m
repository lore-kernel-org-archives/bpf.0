Received: from mail-wr2-f9.google.com (mail-wr2-f9.google.com [74.125.225.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCEF3AFD05
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 16:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789574910; cv=none; b=Bmusaf6uBuZn5cgjj7IPdmYoeGsDRGLwSHc/9ROYJm1ewcUMzRZtvV0xS4tUE64H8Nt2dDmkjUKfnYcGVrbUbLKJ0Jh4WsWvfe26XrwRnoOSiDCQxaHHepK8fpgGOAGMrDMJmVKEKqC5VpInrxf/nP+oTeivtWPWr5xFdlz9zaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789574910; c=relaxed/simple;
	bh=Oe334dM9+NIbB/6CvpoPJ+8KAdbebD4y8LvS/Qpr+sg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hiAHZdFzyt4uVSmilQizqb5K4/+w0goOQiJg64mKQmsPBUm4BZAnWszT18rNZi9CnCjkvx1IC9/dXJfF8aOy5jHPROEbtY/gTyeUM2sz6rwMaaPeobXuW+ZXuVWIbj228Mp5dFJGUePumEbUabSdRvG7Wndlb75Np47ojTmSMOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z+vLO/wD; arc=none smtp.client-ip=74.125.225.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+vLO/wD"
Received: by mail-wr2-f9.google.com with SMTP id ffacd0b85a97d-48437576531so1988596f8f.1
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 09:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789574903; x=1790179703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z0KWFkfFawCZRk4dD217N4GTaQAesOAOHnydKLH9M1E=;
        b=Z+vLO/wDlA5m16xuMfkgWS+KLID/q4vZKWSnra0hLtO4DtW5LYXkSgfN1hC7YGdHB/
         ZqtDGoHehhX5Ygr5ffm0Lztg+D/OwoaAb+kWkDqy1S6QAfQHwiBGXCRsmGj2iChYhH0k
         cm4ol9xAY3vy6iAP69+wRru7pHcc8YN19S89F+OXkl4yBbd0Q9DB07GfeLrs0CQmzpfH
         6nPzGQpXWdSz8ZYzNMnEPEujdxHFcwHufFbo3eRcHACWhvH3CpNBb7dAkDOE7L+wCgP4
         5qOyBTy522e/PqBlYPU6I+SMAxcnuzUCxjqgxtmCU4XZ5KbHMS2gMONQLCFbi/4CeaeK
         s6nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789574903; x=1790179703;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z0KWFkfFawCZRk4dD217N4GTaQAesOAOHnydKLH9M1E=;
        b=Ep/oVhdUjYC8rcX10q23E/vwRgXOfnb6YGp/rwmx/3qMo3RocgH39SSNMGrw8ehEfY
         9xglusZ0RoY4F2McVO9jvU0B7I8+3/0yYwhIyNwEizz0C8Mxt80m0uC0l7jQZbcWckgb
         Y16R7XeS/SfRst1PLm8G6Pv7xEJX1QhudvMZgmHQftk3P6Mt0g5sGrnMAFFEtvubmlRk
         iOum7JURbrk/eWD7OL1vF4ML7FvEyYepkyqd8MRpsCghLoseKOAG/xbxCTA3HLbUE1o1
         +puIByuJfaNk9adQq8SS8R72qKfYaZz00aToaFWtMtzvoUv4fBQR/7vVXkYw2iMwX5Tv
         CQNA==
X-Gm-Message-State: AFuF++nMF6h+KwxOyVwKjqyuYYSWWrdb3G5bRNJ2pxRT2sBpwkFgjApZ
	QGNuEfiBJfLf6SD164fgVM2+Y2i4GQZleAXeZPFqG5L6ahLIC84mtZHOOVjd4WvV
X-Gm-Gg: AYBFou2Puh+62eL3x9oL8kEJJO3T6BBbZaJUGiW+Usa/WABvi7DyvzE02Ql3GHkJ/Fb
	7ulaAlZsgMEWlCkUPlpU22jK6CR2sgnvcFU0Hehk9no/a1ymChDT+TQFQ6N6eB/781EYVJApgfP
	rsj/dYx1tDoFR22IeNkc1OCKRhUoK5FKhZ5aP2h3wJ5ve5N3ciz95v9sTa7QUv6htSpPhH0ZEnt
	6mip9o5BvWQCI4zYfnMkdst/2BtoSk64MY/NF1/5Q5O+QIE7zI8RGJrlvoUr9EZwbMpk9OaI0aU
	9V0QlClzfYIv0JOSg1LSKtAgitWJtROeUaVKmwcRSfOKL1wvcLe/GvwwvAfDih+KTJ5DV8g6AzN
	QEyrg8VGRxsilH4tp7iZxqzKZwFACADfXBElUFCVo1XzFt8T+qKeHvR1PnQvaFJm6/4xHPLRZhz
	EU9AbAUMJ8whdGZ+nFAVyIXsaNJfjmOQZOrrftQqDddCWxFWzr78jCsF9j7Ml7Uc3UmA3lW9Ik4
	kp5/rATM6r+uTjyv7nx1xhlHXDtRiK6c5SdD5x2QIwDrN6bqnPNSykDj3PHosr12EZtBQioSXBr
	7AfKY2E+k2/5M8CGuCZ4OpWoArgwohjDU3sW5w==
X-Received: by 2002:a05:6000:4287:b0:487:1004:95aa with SMTP id ffacd0b85a97d-487100495ddmr3278172f8f.14.1789574902680;
        Wed, 16 Sep 2026 09:08:22 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf1f80bsm7684855f8f.7.2026.09.16.09.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 09:08:22 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>,
	Amery Hung <ameryhung@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 0/5] Fix generic __uninit kfunc output buffers
Date: Wed, 16 Sep 2026 18:08:13 +0200
Message-ID: <20260916160821.3157543-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3262; i=memxor@gmail.com; h=from:subject; bh=Oe334dM9+NIbB/6CvpoPJ+8KAdbebD4y8LvS/Qpr+sg=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvVvuffvyzyq9TfKadueF+GxSL/gukv7fwXT55HvTr9/ OFJV36VjlIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAEzk8gVGhiVFS10Cpuy5s7Y3 ainj/W+Ngqc03nOci21s39QZoZv/0Znhf/rvmqWcN2yT5U5fldIvL5f+v2SCFnuuvj5bdExARLY OPwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Generic __uninit kfunc arguments are output buffers. Stack liveness treats
them as writes, but argument checking still requires readable contents and
does not record definite initialization after the call. Check these
arguments as write-only and record their initialization after validating all
inputs, including inputs that alias an output.

Keep the single-output fix and its immediate regression tests separate from
the extension for multiple outputs. The first three patches provide the
capability-test prerequisite, the backportable kernel fix, and its tests.
The kernel fix itself has no dependency on the test fixture. The final two
patches add per-argument output tracking and its focused tests.

The opt-in __prepare_priv annotation uses libbpf's prepare/load boundary to
resolve module BTF before dropping CAP_SYS_ADMIN and CAP_PERFMON. Program
loading then runs with the capabilities selected by __caps_unpriv. Ordinary
unprivileged tests keep their existing preparation path, and disabled or
undetectable CPU mitigations still cause the relevant tests to be skipped.

Changelog:
----------
v1 -> v2
v1: https://lore.kernel.org/bpf/20260915141004.1196460-1-memxor@gmail.com

 * Separate the single-output fix and tests from multiple-output support
   and its tests; reduce coverage to focused cases. (Eduard)
 * Skip inactive output slots before looking up argument register state.
   (Sashiko, Amery)
 * Separate sysctl restrictions from mitigation-related test skips.
   (BPF CI)
 * Use an int-width initialization store in the alias test for big-endian
   targets. (BPF CI)
 * Centralize conversion from argument numbers to slots. (Eduard)
 * Share clear access-mode selection between fixed-size and sized arguments.
   (Amery)
 * Clarify the opt-in prepare/load capability boundary and retain the
   reduced-capability alias rejection test. (Eduard)

Kumar Kartikeya Dwivedi (5):
  selftests/bpf: Allow privileged preparation for capability tests
  bpf: Fix generic __uninit kfunc output buffers
  selftests/bpf: Cover generic __uninit output initialization
  bpf: Support multiple __uninit kfunc output arguments
  selftests/bpf: Cover __uninit kfunc output argument slots

 Documentation/bpf/kfuncs.rst                  |  27 ++--
 include/linux/bpf_verifier.h                  |  11 +-
 kernel/bpf/verifier.c                         |  93 ++++++++++----
 .../selftests/bpf/prog_tests/verifier.c       |   4 +
 tools/testing/selftests/bpf/progs/bpf_misc.h  |   9 +-
 .../bpf/progs/verifier_kfunc_uninit.c         | 100 +++++++++++++++
 .../bpf/progs/verifier_kfunc_uninit_multi.c   | 116 ++++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  44 +++++++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |   7 ++
 tools/testing/selftests/bpf/test_loader.c     |  48 +++++---
 tools/testing/selftests/bpf/unpriv_helpers.c  |  16 ++-
 tools/testing/selftests/bpf/unpriv_helpers.h  |   2 +
 12 files changed, 421 insertions(+), 56 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_kfunc_uninit.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_kfunc_uninit_multi.c


base-commit: 5ef40d69b38a93bc9951dadb1a15c85c597e1a40
-- 
2.53.0

