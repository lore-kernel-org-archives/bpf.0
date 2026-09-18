Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0544A3659FB
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 05:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789709351; cv=none; b=sKV84VKYVknd6zej8EX5npRDvN4ql4DkFKgUqJFiz01GJcRV3j9Ybir9xooTRwFR9exFdfLLlaOmvEgDH5jQDiFVCjaxLoCKGSJlIN3shzJqFWMvA5TjJ4/SylMxLorZROesN+RsA9cY41rPysz3+IS/a6fBo3YS0PDeLY/ZB6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789709351; c=relaxed/simple;
	bh=QcOkoichEUyt8GpFj5o5ws3oRuu6AdHUZ4SfZP31ffw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CNMv9AbnLEUVCVkDzIT2feaADlLmkZZqMekuMaR/2S5Ym9JqmDS4c8RL0MkjtcctSFV3M06qYdEQpsWHw7BiGq2o6sdCisSFant+NSmcTT5lmwT1feGRnnrLYkQeuKlH6QM/lXm4orAGYfV3MVfjdw9mwy96e1acL+NtS41nYLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jOEh1/0e; arc=none smtp.client-ip=74.125.225.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOEh1/0e"
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-49cfcf2548aso1187305e9.0
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 22:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789709348; x=1790314148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RJMbIXEIWKwkurL1zAGItYnKgVzWb/d1ZxUtzI6d3rw=;
        b=jOEh1/0eRLqAlTNKn2cgrUWCHph7GtpOOvEjJiUV4cR9SKS/9b60qd+HD9asmjbOOw
         qJoBxc6fYqLABULZ9sEKxN9zeTLtMJRFZUnGfwTncoiQ/t92CGPbZ/TR8jnRFCv+rXeo
         JltSOT0ND7uIDSpPoKB1xBS4NhvpNEpVtXvClM8pfqvNj3Qop9VZJBlVOVwQPQrQyCcR
         DD5ZNDQZeDn/BC76P3VXUOZADTZEHPRgNo7EL3OF0dL07r8DVI+r5SHfLAld1yF50Wuh
         sBZnjrqnlkN/w0aSZSX1wC+CxBvt8c9zvHYmj4/Daw/MObPmNQZtXOS2dmKnTB+Exyhb
         jYIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789709348; x=1790314148;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RJMbIXEIWKwkurL1zAGItYnKgVzWb/d1ZxUtzI6d3rw=;
        b=o+Ori5kE3ctOTtIU40fma8FSI4DJQf1LqqA9iPhJmvCMdR2t0XlH0qvm0DLe8ZxhYk
         jDSsYEDl6kKjrXwrj1K3HQ/norli1qsZSNS7Ys4H/+kBo5pK2xbsIJNC1i7rFOWPbTvp
         uaAjEQO+1j2wnzK3zzW6QyKWtdaexfCtkFZdVzeL9lvcPP0zkJpWFHsk03DqpWRbTZJ5
         C8BQlmxR8BI19wmuIiJBukCrMzoL+ooVCVZAy/tnHbWKt9Iyd0nVTaCkzXGzZF9HEQ72
         fnSQQSIvkjS4bZwgomM9J95S1NmkQOOqd7Ea9Y6TFgy4LFUCXxRba+MhS8pRT4W1A4SN
         iw3A==
X-Gm-Message-State: AFuF++n3M4i4lq/56lJ/gzhDt8hlvOezulDPToRAXzMICvbiSZYyU7z1
	oe0jwoqISH/AzymiaQpPUIKquINZE24/9AKAZmFj3WjVq0YteeT0jnfo0n+/h5Sj
X-Gm-Gg: AYBFou3pDB4+ohYaae+5lUhFc12hw2jKrWBmSrG6D6EOFbfEZreZNb+44U/1Nr4GOd1
	NW/k6nEILMVRP3O5LmUbaYKhWAgVygCrw10zFO+RWRQRDAzmAykYRTsaY+y+8G6McL23RiqIM2/
	R+cea0gTZ+3EKJWRgzYjib8XJYL5Qs4ukogypBUkPHfhUnYPJsKizdKmWllrIebQQGJ5TrcaxDb
	86z/sP3sqknLv6+pfamoBbbV9XIKuRuJ6sAc7n3z4Lz7SPUTEWXtAmOtUxLFjtxUXnAowkjcoSq
	Zq1C1MqiPiyvnWTsKDJm1c26XEJynBVi7h6cuqNzgznKu+NDK9B2yXQqeLv6iAAvYF8gpqzVqdS
	fteVG6JHGvfkJ5UG5s1Np1hl+XXqMYzhqQWYfhwugGzsZBhIfoGusBYmBJihzJa+2wLK6ylg9hW
	f8L4wSkx48SQ15IPKrDQA4g3IQndBTv/p+Gdc4CSDfDFChT5YK/gfsO43+hub7khBXrbCQjw7v6
	yB6LsaIMxlvlWEEAF20vegielYjEH2EASgCEvihIhTKJy5kpaW+XcY3T+U6hAd4SKMArKIicdCB
	puv2hbKGbB1B1WgpgllkyAMoKCYnWUyv/BaTRQ==
X-Received: by 2002:a05:600c:8b35:b0:49c:eb17:cf3b with SMTP id 5b1f17b1804b1-49fc56adbc1mr12041255e9.8.1789709348059;
        Thu, 17 Sep 2026 22:29:08 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fc7cebae2sm20373925e9.8.2026.09.17.22.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 22:29:07 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 0/8] Fix generic __uninit kfunc output buffers
Date: Fri, 18 Sep 2026 07:28:54 +0200
Message-ID: <20260918052906.12226-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4375; i=memxor@gmail.com; h=from:subject; bh=QcOkoichEUyt8GpFj5o5ws3oRuu6AdHUZ4SfZP31ffw=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvN6Zdb50hc2Tf53PuWUyeUtm+a4T/LrjEk/JnjUVmvJ VrJSn9MOkpZGMS4GGTFFFlK/u9jMj5R+TvQdhk3zBxWJpAhDFycAjCRHjtGhilfJ5iZvd1qHvRf Y2Xyep5nm7dO2ty0zuJTrKDSp3S7FYoMfzic7gQunnU37XOlu2ixx7qoLy6hJUUiwRPYH1poRIS rcQAA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Generic __uninit kfunc arguments are output buffers. Stack liveness treats
them as writes, but argument checking still requires readable contents and
does not record definite initialization after the call. Check these
arguments as write-only and record their initialization after validating all
inputs, including inputs that alias an output.

Following Eduard's rework, helpers and kfuncs now record generic outputs in
the same argument-checking path after type resolution. Their memory access
checks also use the same argument flags. This includes a separate helper
fix: MEM_WRITE without MEM_UNINIT requires read as well as write permission.
The helper fix and its permission tests remain separate from the original
kfunc fix and its immediate tests.

Changelog:
----------
v3 -> v4
v3: https://lore.kernel.org/bpf/20260916192805.3991983-1-memxor@gmail.com

 * Record helper and kfunc outputs after type resolution. (Eduard, Amery)
 * Derive generic memory access from flags for helpers and kfuncs. (Eduard)
 * Fix MEM_WRITE read checks separately and add permission tests. (Eduard)
 * Remove the output-count validator in the multiple-output extension.
   (Amery)
 * Clarify argument-slot naming and move its accessor into the fix. (BPF CI)
 * Add the unaligned header and order the new test registrations. (BPF CI)
 * Shorten the kfunc fix description while retaining its rationale. (BPF CI)

v2 -> v3
v2: https://lore.kernel.org/bpf/20260916160821.3157543-1-memxor@gmail.com

 * Reuse check_raw_mode_ok() after kfunc prototype generation, including
   struct outputs resolved to generic memory later. (Amery)
 * Remove the now-redundant kfunc output-count check in the multiple-output
   extension and simplify the helper validator.
 * Leave the stack-passed output uninitialized so the reduced-capability
   test detects missing __uninit handling. (Sashiko)

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

Eduard Zingerman (3):
  bpf: Record raw memory arguments during argument checking
  bpf: Check read access for initialized writable memory arguments
  selftests/bpf: Cover helper memory access permissions

Kumar Kartikeya Dwivedi (5):
  selftests/bpf: Allow privileged preparation for capability tests
  bpf: Fix generic __uninit kfunc output buffers
  selftests/bpf: Cover generic __uninit output initialization
  bpf: Support multiple __uninit kfunc output arguments
  selftests/bpf: Cover __uninit kfunc output argument slots

 Documentation/bpf/kfuncs.rst                  |  27 +++-
 include/linux/bpf_verifier.h                  |  11 +-
 kernel/bpf/verifier.c                         | 131 ++++++++++--------
 .../selftests/bpf/prog_tests/verifier.c       |   4 +
 tools/testing/selftests/bpf/progs/bpf_misc.h  |   9 +-
 .../progs/verifier_helper_access_var_len.c    |  41 ++++++
 .../bpf/progs/verifier_kfunc_uninit.c         | 100 +++++++++++++
 .../bpf/progs/verifier_kfunc_uninit_multi.c   | 113 +++++++++++++++
 .../selftests/bpf/progs/verifier_mtu.c        |  75 ++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  45 ++++++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |   7 +
 tools/testing/selftests/bpf/test_loader.c     |  48 +++++--
 tools/testing/selftests/bpf/unpriv_helpers.c  |  16 ++-
 tools/testing/selftests/bpf/unpriv_helpers.h  |   2 +
 14 files changed, 536 insertions(+), 93 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_kfunc_uninit.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_kfunc_uninit_multi.c


base-commit: 961b8946acb482b6d7a39c266d623e5f9c4e873f
-- 
2.53.0

