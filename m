Received: from mail-wm2-f5.google.com (mail-wm2-f5.google.com [74.125.225.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB2F41BA77
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 19:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789586904; cv=none; b=rx4c1kU5POqmEWxAWiyTDLgAlz989c/vsuhYKCttm3a1uPnRjBUaNbGk2hbvCV95yn+KD0BbRHzU96Y9YesBYf3OqPLJoTajJbvIhCZ50kuX54/I2Jd70CZ6mCZy8U0+PoyPxvHwWtUzLAVZ2D+PeuMFf2IusLahIJwESQv2sOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789586904; c=relaxed/simple;
	bh=BOeWiQQo7rn2ww5C+xRZU5cR2MAoGfEc6OFhq9l2tyc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KkfLx2koxlYwQT07bDk6irPYKe4a/mVEH8ek/5xY8h4Jo3gJDVh83MkWyoPdV5ZV0wmqnO8it/cNRAwuKbhL+bhkHGA/rQug8Mvz1JSJHqVql/Y81otHsq7eR6u8oueJ2mv4aTh69SNM0npXpnKuh0BIHA6RRFN7iWYnZimcV+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jnR6BEj0; arc=none smtp.client-ip=74.125.225.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnR6BEj0"
Received: by mail-wm2-f5.google.com with SMTP id 5b1f17b1804b1-49e66652cc3so324235e9.1
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 12:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789586887; x=1790191687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9TX7pgdmLOAKwNe8/P78kFbS4ZlY3JeaLeolYT0CN4M=;
        b=jnR6BEj0kPk61RXpAHU9NA0+AtYxe0yV78V0iI7DYZZPPJwPQejAHM8ZVHSZmC/GAR
         EnB7G5Q8J2Nt6x6woMN4L/i/0kngu5q/9VZ/ZAU0oivt6Tuff988UjJ7BmyRoremBXou
         W+TMkh4Cw+1yJ0xc/O0gxJVW4hoSF/vIAxRz+YrgLmlf5ScPAc9lRZdoaCUkwPOUMxjb
         W12g2fcJ0o/5qYsoq5oH5Lf6gUjYJBvuYmOkWGbzPRgKVlZZDPOH2OTfIFoDPmbA3uOL
         svIzDfCdxSFzQr7BU2u+BZJuJFF+9H6FI5UCcOeoKGXszBkC9Pusne6mxyMgOPl2Nbzu
         n8BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789586887; x=1790191687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9TX7pgdmLOAKwNe8/P78kFbS4ZlY3JeaLeolYT0CN4M=;
        b=nzpKtRnRErT7cB6KRrGWE7nOnb6VSNGsS6rOWxLxNflnxaDY4GwHxyLwzzBCOKbI7R
         4d0f7mCLVbj49b2LZRl31/EjTadV1hBjr0xSOj5hERAb5piWf3L87BXzXF8kqUB8mk/h
         aTMGzNPeoXey1T2gYwh6MiS72NRjwlvVOeM9BRiX9gjlJOgVAE+vItEEPtDCtkWuhNkB
         vGG/T1F6/4iX4r6AAur5bv0aLhRVdKnYDBu1Z+8ChlyPNZTnXsNmofGs9gA8RXcBndum
         cR2d1uQJEbHb+ayvWztAlD2czQnlB4KpvaBf7qUNJCNXPiZpujcVJuAPEBsrW19f+FXe
         ibwA==
X-Gm-Message-State: AFuF++lw+a6ymslwvGBbJrYx2jU77LA+Daxo5g8u0VxOnwonNcU2FK8g
	eYRZeH13O/+XTNCacvGsXOM1Z6R40WQ0Xl58t2y6JQZLTweBqlFYVbLLtDMUUhrZ
X-Gm-Gg: AYBFou37nuBKxN7TaTvUDmP+Ha4AQU7ksTWta2AmEAgydcgb4z2lLgRaYFLXA2kjvBX
	t+WzVl4c0voQaKsgt74dwG1d5khS9gRS/9LJLEb2N6tMb/u0mNjr95081mu21yCjq88GY3rx0Y9
	sWkZqwKqOpg5Olk2SrmxxV3LeM8rky+3FkMlZi9kjqFEhaRrnWICoXbz/46lJOTwJv4Ry4FEZ4M
	1otZi1BydXXnGJpG5pL4LDz9UxmuzL7LLW2M+rzGC5GIZxQpDD+HsCaN5T16uwircFD3hV5qpa9
	lOKU2loF7uOa7Yxc9f3pSxCroUVdoX+x8RXB9fAW9N8lpJkp+luPOIk42eckesehJNJQqcwDnZd
	vfF0NBht50GD9+YvS5LmiSK1v19VT08SgMZ4jsmb2EVvRgVBdIu7WW67v/rdYs+cgBgsr5qnkpT
	2LSet+3X1NPNUiB6eqGOQWLG+IvoWpGIl0bH3uDU2u7mvNaKlhHO1G3/mQFKf+rk1lHfB/+o4mv
	1DlWjMU8V6WujpyVkZRVjvd2zDL78W+k/HANWCiAuP3Bi+PS4OOKoOYBZHlmzNHMmdboDZZtwzj
	+88X7YRwQOsDQg5SEikzHE0B7ajhgY1Pxt45udUA663ox6U7
X-Received: by 2002:a05:600c:4e91:b0:49d:1a02:4797 with SMTP id 5b1f17b1804b1-49eb7346fbamr43849035e9.17.1789586887078;
        Wed, 16 Sep 2026 12:28:07 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd967f1csm1251325e9.3.2026.09.16.12.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 12:28:06 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 0/5] Fix generic __uninit kfunc output buffers
Date: Wed, 16 Sep 2026 21:27:57 +0200
Message-ID: <20260916192805.3991983-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3834; i=memxor@gmail.com; h=from:subject; bh=BOeWiQQo7rn2ww5C+xRZU5cR2MAoGfEc6OFhq9l2tyc=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvV29rGfbdTl6Upv1DdEKi5S2zTW5kXFd31R6uWXeS4p dImt1+3o5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABNZG8XI8PLws5idMZKHr938 XX6z+cdDgW18WQdMv2Xc05xd+fTx+npGhkkPOCcePvBsyYq4xM515Vt7th7Yo9P67l1eleD7T7m zdzEAAA==
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
patches add per-argument output tracking and its focused tests. This
extension is optional; there is no current production consumer for multiple
outputs.

The opt-in __prepare_priv annotation uses libbpf's prepare/load boundary to
resolve module BTF before dropping CAP_SYS_ADMIN and CAP_PERFMON. Program
loading then runs with the capabilities selected by __caps_unpriv. Ordinary
unprivileged tests keep their existing preparation path, and disabled or
undetectable CPU mitigations still cause the relevant tests to be skipped.

Changelog:
----------
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

Kumar Kartikeya Dwivedi (5):
  selftests/bpf: Allow privileged preparation for capability tests
  bpf: Fix generic __uninit kfunc output buffers
  selftests/bpf: Cover generic __uninit output initialization
  bpf: Support multiple __uninit kfunc output arguments
  selftests/bpf: Cover __uninit kfunc output argument slots

 Documentation/bpf/kfuncs.rst                  |  27 +++--
 include/linux/bpf_verifier.h                  |  11 +-
 kernel/bpf/verifier.c                         |  93 ++++++++++----
 .../selftests/bpf/prog_tests/verifier.c       |   4 +
 tools/testing/selftests/bpf/progs/bpf_misc.h  |   9 +-
 .../bpf/progs/verifier_kfunc_uninit.c         | 100 ++++++++++++++++
 .../bpf/progs/verifier_kfunc_uninit_multi.c   | 113 ++++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  44 +++++++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |   7 ++
 tools/testing/selftests/bpf/test_loader.c     |  48 +++++---
 tools/testing/selftests/bpf/unpriv_helpers.c  |  16 ++-
 tools/testing/selftests/bpf/unpriv_helpers.h  |   2 +
 12 files changed, 418 insertions(+), 56 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_kfunc_uninit.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_kfunc_uninit_multi.c


base-commit: 5ef40d69b38a93bc9951dadb1a15c85c597e1a40
-- 
2.53.0

