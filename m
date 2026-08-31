Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166423DDB1A
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 09:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788168221; cv=none; b=bzqBoFeIFceoSIX5m0OphNCt3QGpoVWiLI9DR3xUYvBmGsECzlp/VzgKslIV0PhOgX3v3RWKxybc3z9vYvnBCrcanw7KYFb75uZychj4j3iRZBBvyhpKW+USTycrXtmt+i77yVJQmxBgJgTH3XfEt8n5hc7/pVmv5TRGEYubP8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788168221; c=relaxed/simple;
	bh=8GMswx1+FMSNRSvbBRN34C7252MpLNJFmXhsZIfBHrc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZIqtSabAIFyp0cM6/yy5L92enDeycN/MB9KXy49IRrLDI03erynaUSBfoiXpnHM+BjmOPvmQmWVH4IZZVjTFCmDVr6M4VBZgaY0kKYemsJaG1xekOffPsxVTdEP1wffizTFL5yrM2iowHKdtDUZVEvOyNhU0sPP3QfSbRyReWXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YP7fl/TA; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YP7fl/TA"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-482f9309813so2130452f8f.1
        for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 02:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788168217; x=1788773017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0nZi5lpGroQ1n6Zg4TqX5QiY23WxJ2fmAQc30SHAO+w=;
        b=YP7fl/TAiaP2zgGCu5o7BqiQJH0sazGkN65ztdKC7cTNvgQXB/rTQc8Mg6Q86CWZE/
         hPHmrB2l3Fb3oNEz4qNivSr4rygQyWFIW8uWL9if3xmEH2KOhZkoFFT6N/O92Bpdat6Z
         zcmPJ6NHFF0DI2OTQv8DXT3TRQe3YBZmX0HDMOocXIzKAfrUVkhgD6ZVbgJq7OImKRUW
         Xyt0CcOXcHvR6IawurupOzqcOxiOBzM3+0pUnDoWbk8FyS7i85z1fR391k5iYtM8P/AI
         HFpHb/pplIQqMf9xg2Cd4hymsblXSgJvoeWKyBDWiOpjkUvWhb/+e0qPuthq8xjDnBkI
         1PpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788168217; x=1788773017;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0nZi5lpGroQ1n6Zg4TqX5QiY23WxJ2fmAQc30SHAO+w=;
        b=TQzwQskb7Mcu+m57jq5kUru5IDupxRpRvQrtUjdXZIk/ulQk/0ZWkQaFGPKP6NhVns
         2lIUqPAFf0D9K4Wr44Zc5xnzbM2CO/4VtFUEuB0q+RNEIlganlvt85a54TVrFQo8A/US
         6h7g1a7802bnCGSe5XzFjODttyBIXoqF/qB4wRoR0+Ljptud+qvi6ZwqdNb17AG4EtQb
         JF0Eob/+K2jbHkQzBTPdCOHIZW1HnOSSgFvxyh5FB4NIIt7u9xKe5EkuEoYKm96z8zOu
         6xEEZ6kY1T9vzjFW6TtIPeupBpji+mzBFvuekxvVwGe9pDq2EB8h92389Xf8wH75EQRo
         E4eA==
X-Gm-Message-State: AFuF++nkAaNBb14BEdykneCTUDAerbPLBN2PN1P2CrRY7b/pFkssz52t
	y5fr2tRoW/r6zGM6bcCT+jZeKRSEeMPCDQXz74YgRrM2b45ONeCB+ywFyPRjn1DZU+M=
X-Gm-Gg: AR+sD11vyzEv4jPiek2iEtxR5WdgMFsrhtKt7WgCqqcrk5kisquMpI1VaiFHKBUX2C4
	S2b/6iNRDVVar5bLRPCE5hkrPSiS4nFV5iVOPKZNYwSAVJDbxu7c+dGMfz/QdN3vEpUdL1apvJh
	zROO5zXdZofYSkIViFr2x2GfCRhsnSNPzVq61z+esVVRzIN6bU7J6SeW9zcHgG5fqA7VY7p6mEv
	XXPwXz3FWvPtHzNVzLR4fXjlS50dtADryqtlw+Ne8LMJttLYer6weaeTOaFtsmePrY6yj9aFy4f
	D39LrYumBwWL+1NhLx/SnZ5WXxHBtFo7cNv3qfeKbKsvNC5op1Asm5zyqWYGJYMQUuV2fumAxJk
	OA9IMiVZYQfUMFpKRr4Y+XCJYPg+8fC4E3nAdKG8nNr8l2Eu1MQZu7jZZ4RKr4Sn/yOhdBJPxUZ
	A9/FnTkSrP0mdyodxXbmjbpKmnA0gJnj6QfDBVgS3tTI9Adjwqg2UzfqvQ5x36rWqc7bfw8MAQJ
	Q==
X-Received: by 2002:a05:600c:6096:b0:49c:cfad:90c1 with SMTP id 5b1f17b1804b1-49ccfad9180mr218842755e9.14.1788168216864;
        Mon, 31 Aug 2026 02:23:36 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b5f:900:ef25:2f4:1792:4e6f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b9500c80asm318248155e9.9.2026.08.31.02.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 02:23:36 -0700 (PDT)
From: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	akpm@linux-foundation.org,
	david@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	kpsingh@kernel.org,
	matt@bobrowski.net,
	song@kernel.org,
	utilityemal77@gmail.com,
	tasos.papagiannnis@gmail.com
Subject: [PATCH bpf-next v3 0/7] bpf: Add user memory access kfuncs for mm_struct
Date: Mon, 31 Aug 2026 12:22:58 +0300
Message-ID: <20260831092305.42062-1-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On MMU systems, during exec, argument and environment strings are copied
into the new address space held by struct linux_binprm before that address
space is installed on the task_struct. Existing eBPF user memory helpers
only support reading from the old address space (i.e. current process),
and for this reason programs cannot access these strings from the
bprm_check_security LSM hook.

This series adds two sleepable BPF kfuncs for copying bytes or
NUL-terminated strings from a trusted struct mm_struct. It also marks
linux_binprm->mm as trusted-or-null, allowing BPF LSM programs to pass it
to the kfuncs after a NULL check and inspect exec arguments before
allowing the exec to continue.

Changing bprm->mm to trusted-or-null would otherwise reject existing BPF
programs that read through it without a NULL check. Preserve that behavior
by allowing fault-protected reads through trusted-or-null BTF pointers.
Pointer arithmetic, writes, and passing the pointer to a kfunc that
requires a non-NULL trusted argument continue to require an explicit
NULL check.

On NOMMU systems, exec argument and environment strings remain in
bprm->page[] until they are transferred to the new process stack. They
cannot be accessed through bprm->mm at the bprm_check_security hook.
The new kfuncs remain available on NOMMU for address ranges represented
by a supplied struct mm_struct.

The series also adds selftests covering both kfuncs when reading argument
and environment strings, and verifier tests covering trusted-or-null BTF
pointer reads.

Changes in v3:
- Replace the linux_binprm-specific kfuncs with generic struct mm_struct
  kfuncs, as suggested by Andrii Nakryiko.
- Move the kfuncs next to the existing user memory helpers and make the
  task-based variants delegate to the new mm-based implementations, as
  suggested by Andrii Nakryiko.
- Clear bprm->mm before dropping its reference on exec error paths.
- Mark linux_binprm->mm as trusted-or-null.
- Allow fault-protected reads through trusted-or-null BTF pointers to
  preserve compatibility with existing BPF programs, as suggested by
  Andrii Nakryiko.
- Add verifier and runtime selftests for trusted-or-null BTF pointer
  reads.
- Rename __copy_remote_vm_str() to __copy_remote_mm_str(), as suggested
  by Andrii Nakryiko.
- Clarify that reading exec strings through bprm->mm is limited to MMU
  systems, while the generic mm-based kfuncs remain available on NOMMU.

Changes in v2:
- Register the kfuncs on NOMMU systems and return -EOPNOTSUPP when called,
  as suggested by Justin Suess.
- Add selftest coverage for reading environment strings, as suggested by
  Justin Suess.
- Clarify that copy_remote_mm_str() leaves the destination untouched when
  called with a zero-length buffer.
- Use sizeof() instead of hardcoded argument lengths in the selftests.
- Use ~0ULL for invalid-flags checks in the selftests.

v2:
https://lore.kernel.org/bpf/20260820131801.68759-1-tasos.papagiannnis@gmail.com/

v1:
https://lore.kernel.org/bpf/20260812111140.7762-1-tasos.papagiannnis@gmail.com/

Anastasios Papagiannis (7):
  mm: Add copy_remote_mm_str()
  bpf: Add user memory access kfuncs for mm_struct
  exec: Clear bprm->mm before dropping its reference
  bpf: Allow reads through trusted-or-null BTF pointers
  selftests/bpf: Cover trusted-or-null BTF pointer reads
  bpf: Mark linux_binprm->mm as trusted-or-null
  selftests/bpf: Test mm_struct user memory kfuncs with linux_binprm

 fs/exec.c                                     |   7 +-
 include/linux/bpf_verifier.h                  |   9 +-
 include/linux/mm.h                            |   2 +
 kernel/bpf/helpers.c                          | 115 ++++++++++++++--
 kernel/bpf/verifier.c                         |  17 ++-
 mm/memory.c                                   |  33 ++++-
 mm/nommu.c                                    |  33 ++++-
 .../selftests/bpf/prog_tests/bpf_iter.c       |   6 +-
 .../bpf/prog_tests/copy_from_user_bprm.c      |  72 ++++++++++
 .../prog_tests/test_struct_ops_maybe_null.c   |  12 +-
 .../bpf/prog_tests/tp_btf_nullable.c          |  28 ++++
 .../selftests/bpf/progs/copy_from_user_bprm.c | 123 ++++++++++++++++++
 .../selftests/bpf/progs/raw_tp_null_fail.c    |  63 ++++++++-
 .../bpf/progs/test_tp_btf_nullable.c          |  17 ++-
 .../bpf/progs/test_tp_btf_nullable_runtime.c  |  35 +++++
 .../selftests/bpf/progs/verifier_lsm.c        |  19 ++-
 .../selftests/bpf/progs/verifier_vfs_accept.c |  13 ++
 .../selftests/bpf/progs/verifier_vfs_reject.c |  14 --
 .../selftests/bpf/test_kmods/bpf_testmod.c    |   1 +
 .../testing/selftests/sched_ext/maybe_null.c  |   6 +-
 20 files changed, 566 insertions(+), 59 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/copy_from_user_bprm.c
 create mode 100644 tools/testing/selftests/bpf/progs/copy_from_user_bprm.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_tp_btf_nullable_runtime.c


base-commit: d761934c9483ecde93fe99d8705282f716dfee50
-- 
2.55.0

