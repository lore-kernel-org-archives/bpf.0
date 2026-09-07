Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F44D4D2EEC
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 16:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788799972; cv=none; b=JEPDyKptY8RwqWVU7SIC2g1FMZ5nNfoaM9rszgKeSFKw40sSdiG8r0K4JJB6wdooMIbpnOmbiBCKncJUjN8TBvMng8uMHXvJPfzm1McX/O5th8qVxmZ75K7eOxN4E2sYZLI6fmX+FGvO/47zmVgvbKjtlYg5zczEX8GYEiVRULA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788799972; c=relaxed/simple;
	bh=CSQ8kuws1GE3KyX86hyowAfIeJXSMxy86cZQrTHrSvw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I7APpSKJYnFW96zHkhKA0kPJ1EaVfgItNevR/7cBmr4kktEEUOTkW9C4N0dnthmscGxbKoqYrAh4/52qOcAIgmT9Xvn0ibMIVW5ZwEOrvTyNkQfuNN+DKHlTKlX49OeCYsNwDJgpLLcxI61/rOpICVeSs+36NJWdM8Z3A7mB0aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q65+W32e; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q65+W32e"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4858595f997so2250672f8f.1
        for <bpf@vger.kernel.org>; Mon, 07 Sep 2026 09:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788799969; x=1789404769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=u9H98ndHjG+ZTBmwr+gw4XIiGi1/LzmNQdKATV2GZh0=;
        b=q65+W32ex3cK0pCz+XDR4jQRwVrN2KcnHbSlcRsCoL2NY57qgda/sh2skpORAa7CwV
         Ib6Q/euERaiMX07UBO4Xs/mjNdxcDlXurvAJbt5n5upHofnuuvM6RP/q3Ai6Dv3mDsrV
         LKB3Uqm1Ll8bFZJwmFrKlbteVR0iO5SppvO3WG3ETIOkMc4Dof1pR7zFfQ4IT5AjEI8/
         rjxowB8+DhTmOgJ1um2J4rklF0GKM0eDigWEHiSuo0Yp9AjFG40p//PpeyoHga6tz8ND
         BQJCX4nIt2l0w3glb79lopW3w8Y1duQw8Ka9xd0AZ4qluqBMenka5/atfERva9RdlD8H
         fylQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788799969; x=1789404769;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u9H98ndHjG+ZTBmwr+gw4XIiGi1/LzmNQdKATV2GZh0=;
        b=A9Ls02UDdVI/L1PA/q14LJyrUkNowX8nacbi3wU1PSWrPacGzbak4z8hCypYML5X2V
         ykznAYmOKa/ZGQY6H1x0Aoy1PGOeVuDySGOGvKYuuBtFlw2k88NOYBbTsZCihTpTVorg
         TQSQgGvPbWkTF0WUsdE9AyO+oX09gQltbzHc58ZhFtO93OaR5gWkmPCGTJloeAW2EB/e
         XHeX9WraN/5KQ5kxDtZZ0GB8uT9r7wcvro5bNdYIk1YAg3JunL+y0wg/rfo9y5od7pb5
         ziqwTe0Y95aMC/azHGmtq3DPpiYvqDYTIXACZ2KNWkGMCcoFlY/UuXDsE3lRO49UlFtO
         Zzcg==
X-Gm-Message-State: AFuF++nIouuc+GJOTtomrqIpAJeM/GQfb2Oq2xMF2DGaB7LDsI9N6CLK
	wY0LVpTFTOW92BXV9AavOr9vTLuqh15sVQgMDW7srhyaUd+VOmKUaRuslNTZFyblUSQ=
X-Gm-Gg: AYBFou3446wFncUWLCsW4la26w3yRY9VDNb0n0Xnb9zjeKJoiHPqsoTllGnl2fcLa0o
	k6lkJKo9LV5fDgI7uZQcosXLwxPUD4kB4NHI+llInmJvzFXCvyM9b6DZMTRAj++kdoMv++TIRiG
	7wne7iDgFeEJjLLsxvVF7LBzhgrpJcgi96Ua5/IIzX9cc0YDCpG0M9LcUdtxzoN3FwG+1dtlkfh
	mguO8XQXOmDhFRaTCsboYtqVSN0je925OGoOADJ/JiLM7SbXlscdkXpwclNL9Uxg7m4FlmBh6kj
	HVtboGiEkXPdcYVuxkuZRlu4PCHLyu3F4f01lLxCf6iUPi39zZ+IGEm/AVWDxm0d/D5oiy4wi1i
	+jY8sZktcQAqBrIg4xsqBmlgywdjcJRBNXpSZCtAcpFCw1Te+cJSX353rKokXP9ljwol87Jw4pc
	sGIjwb+HUjp+KuFn8m5YQTB6AG+kgpBeZW1yce+4fK51aV/ccSFZtHQhRlNkOH2VE2CPzHyzHgb
	raGHrsNEdiRRQ==
X-Received: by 2002:a05:600c:a0a:b0:49c:e1f1:3dd5 with SMTP id 5b1f17b1804b1-49cf81e6cebmr426580115e9.4.1788799968516;
        Mon, 07 Sep 2026 09:52:48 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b5f:900:ef25:2f4:1792:4e6f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d03543064sm233022415e9.13.2026.09.07.09.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 09:52:48 -0700 (PDT)
From: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
To: bpf@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	david@kernel.org,
	akpm@linux-foundation.org,
	andrii@kernel.org,
	ast@kernel.org,
	brauner@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	kpsingh@kernel.org,
	ljs@kernel.org,
	matt@bobrowski.net,
	memxor@gmail.com,
	song@kernel.org,
	sun.jian.kdev@gmail.com,
	tasos.papagiannnis@gmail.com,
	utilityemal77@gmail.com,
	viro@zeniv.linux.org.uk
Subject: [PATCH bpf-next v5 0/7] bpf: Add user memory access kfuncs for mm_struct
Date: Mon,  7 Sep 2026 19:52:13 +0300
Message-ID: <20260907165220.52431-1-tasos.papagiannnis@gmail.com>
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
space is installed on the task_struct. Existing BPF user memory helpers
operate on the current address space or one associated with a task_struct.
Because no task_struct refers to the new address space at this point,
programs cannot access these strings from the bprm_check_security LSM
hook.

This series adds two sleepable BPF kfuncs for copying bytes or
NUL-terminated strings from a trusted struct mm_struct. It also marks
linux_binprm->mm as trusted-or-null, allowing BPF LSM programs to pass it
to the kfuncs after a NULL check and inspect exec arguments before
allowing the exec to continue.

Changing bprm->mm to trusted-or-null would otherwise reject existing BPF
programs that read through it without a NULL check. Preserve that behavior
by allowing fault-protected reads through trusted-or-null BTF pointers.
Pointer arithmetic, writes, atomic RMW operations, BPF_LOAD_ACQ accesses,
and passing the pointer to a kfunc that requires a non-NULL trusted
argument continue to require an explicit NULL check.

On NOMMU systems, exec argument and environment strings remain in
bprm->page[] until they are transferred to the new process stack. They
cannot be accessed through bprm->mm at the bprm_check_security hook.
The new kfuncs remain available on NOMMU for address ranges represented
by a supplied struct mm_struct.

The series also adds selftests covering both kfuncs when reading argument
and environment strings, and verifier tests covering trusted-or-null BTF
pointer reads.

Changes in v5:
- Move the shared wrappers to mm/util.c and handle zero-length requests
  at the entry points.

Changes in v4:
- Add negative verifier tests for atomic RMW and load-acquire accesses
  through trusted-or-null BTF pointers.
- Preserve explicit nullability-marking coverage for tracepoint
  arguments, dentry->d_inode, and sched_ext .dispatch.
- Use the already-nullable mmap_file argument for the negative store
  test, avoiding dependency on the later linux_binprm->mm marking.
- Clarify the bprm->mm lifetime invariant and move its lifetime fix
  before the mm_struct kfunc patch.
- Reword the trusted-or-null read change in imperative mood and remove
  its redundant before-and-after summary.
- Document that the existing task-based user-memory interfaces delegate
  to the new mm-based implementations, reorder the string-copy kfuncs to
  remove an unnecessary declaration, and annotate the remaining
  declaration with __bpf_kfunc.

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

v4:
https://lore.kernel.org/bpf/20260904145340.40212-1-tasos.papagiannnis@gmail.com/

v3:
https://lore.kernel.org/bpf/20260831092305.42062-1-tasos.papagiannnis@gmail.com/

v2:
https://lore.kernel.org/bpf/20260820131801.68759-1-tasos.papagiannnis@gmail.com/

v1:
https://lore.kernel.org/bpf/20260812111140.7762-1-tasos.papagiannnis@gmail.com/

Anastasios Papagiannis (7):
  mm: Add copy_remote_mm_str()
  exec: Clear bprm->mm before dropping its reference
  bpf: Add user memory access kfuncs for mm_struct
  bpf: Allow reads through trusted-or-null BTF pointers
  selftests/bpf: Cover trusted-or-null BTF pointer reads
  bpf: Mark linux_binprm->mm as trusted-or-null
  selftests/bpf: Test mm_struct user memory kfuncs with linux_binprm

 fs/exec.c                                     |   7 +-
 include/linux/bpf_verifier.h                  |   9 +-
 include/linux/mm.h                            |   2 +
 kernel/bpf/helpers.c                          | 142 ++++++++++++++----
 kernel/bpf/verifier.c                         |  17 ++-
 mm/internal.h                                 |   5 +
 mm/memory.c                                   |  41 +----
 mm/nommu.c                                    |  41 +----
 mm/util.c                                     |  62 ++++++++
 .../selftests/bpf/prog_tests/bpf_iter.c       |   6 +-
 .../bpf/prog_tests/copy_from_user_bprm.c      |  72 +++++++++
 .../prog_tests/test_struct_ops_maybe_null.c   |  13 +-
 .../bpf/prog_tests/tp_btf_nullable.c          |  28 ++++
 .../selftests/bpf/progs/copy_from_user_bprm.c | 123 +++++++++++++++
 .../selftests/bpf/progs/raw_tp_null_fail.c    |  78 +++++++++-
 .../bpf/progs/test_tp_btf_nullable.c          |  45 +++++-
 .../bpf/progs/test_tp_btf_nullable_runtime.c  |  35 +++++
 .../selftests/bpf/progs/verifier_lsm.c        |  18 ++-
 .../selftests/bpf/progs/verifier_vfs_accept.c |  14 ++
 .../selftests/bpf/progs/verifier_vfs_reject.c |  14 --
 .../selftests/bpf/test_kmods/bpf_testmod.c    |   1 +
 .../sched_ext/maybe_null_fail_dsp.bpf.c       |   5 +-
 22 files changed, 631 insertions(+), 147 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/copy_from_user_bprm.c
 create mode 100644 tools/testing/selftests/bpf/progs/copy_from_user_bprm.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_tp_btf_nullable_runtime.c


base-commit: 1b7415bf70be95b9a1e7e87d544867881065613f
-- 
2.55.0

