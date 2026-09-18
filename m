Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A518337107
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 13:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789737503; cv=none; b=ddUikaHmlYvR4JpQTVur2ZZ+qTQPigUcABxMjBm4IwNZQN2o3TX082Q7QNllyxnwfxxuoMnjVN6qB6uPrxI4z1QySw/JXZR106vZX9d0RLtuc+KDsODBB2WUQxAzWY8rcc4ZOJ1Rz4Fr3LR3jYMEgN/dw8Wb9N5H4lQbHLJMHyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789737503; c=relaxed/simple;
	bh=8nZtWWT6AcVY+EUtw6nwTwMpmoT9269pOv7eqZMKt/o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rbKVfA4EoaFiulhYcTm4xpEWNlfOORhtGdLqhT4iPKtmSiogUtA06jLd69KAZYw5PyCnua9JSyPnGf1jry7SS2N0OSbuZGvBrI91EvqjDBsyE5GhlXlnsOjKm5vOePNhamT/QznvBguK56c81J+Ihx4LB7/iHKdbJkwq8jwXfgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mlE4u93D; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlE4u93D"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843c2790ccso436617f8f.1
        for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 06:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789737498; x=1790342298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ASNDhQj6stB9jN8HLd03JQLyI4Y3skTrr0meT4GXR2c=;
        b=mlE4u93DJjDSK0ICKjUf8+UwVakqKEReMtBmyM34cM/RDHSc0njesph/URz0SJy82l
         0k8BBWzmPzUHmu/Im2ueHsjgD4YOXmzAKCsiU9GHDYVN8H34bnM1gMkxD8WBryjY37l+
         AScpW60+frbsq27c6j/mNj9YbxYQNqe3porkuVwsoK3hczcf+sNnDHeRNDp2iUggtJ/9
         qI7cKcGvFFIqaSYkrDhI63sroiTcn4q77uiHu7YOD3BfVMawaKjiavURHIdjZVIbRkYK
         wAnnVkh4UmY/V3BJ9dtTTNWw+OOziGRBtdfv5WyFp7UfOZxtA6LQQ0zDBLoIjMLmFhEg
         Ht0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789737498; x=1790342298;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ASNDhQj6stB9jN8HLd03JQLyI4Y3skTrr0meT4GXR2c=;
        b=VnPA1vLKfxXlhGP5w5js65e545MEuCN58y6WxUhV9c1QgKo1VyscBDSgz1Ryiay9B2
         b+ARViK0zmONAXZrcYr4URqKzQ7ZOJFcBWnX/ZxHPrGqr8h134C/DAQARAdCoIAl1tdl
         1h5iaB8xl5QLdkAbnoJ23YKAnHpU0tVUd69V6zgI9i/QmV2059OcjMa9uda7dhmYKRKJ
         3nOTaZfApSGHCNAePXfYCLUGdA53ul4z5vs/jjYhseM2IrXi0i2TklYy5nkQ0p/epm0Q
         ySBQi9gtS3BagKrA3X4+fMQG67yc0VxtTp7400XGCRkCQRkosSCLDADurV4m86CW6sYY
         F/jg==
X-Gm-Message-State: AFuF++m0zVp0zTHBqj2Q3NPk/2F27vdTyyz+OOltfBuLxC5siOFEpKHe
	h58oDQNDoG23vu3Iw47wlZWDRKG03KSXv1eifcGbc0E3A8hPoiOlBzRgnFwFG+SU
X-Gm-Gg: AYBFou2RBy7wpyt2VPeD4YfE6AxXR7eP67EGlVrbJEspzEN9sqDvGoNOYN4GNG08D/f
	NDcTatg5v4LoSX0+vYUmWsd8YG8+wz5LwhGR54/eHlnzcNAE3jene49wSSMqyt1bI90xsEI4sbq
	IbH0QYZEJ6+JCobRENsqUcQBbJc/Btz+TX5kZ+I9SJF4xI5IEwi0O5Z4WMHwU/CDQHAjGPHS0yx
	lKYrGRT7JUSw6FF07jeV0tfiFcBAmL37wPuhACaBjfiymNaKaAmb5P63x5o+js8MdEvJmqkr643
	TpyFPpfXV4I5kszI/+c/+C1TKI1oRIkfuksID9yqmdjGgnA0E9jmB9nW4AQuFSZ9DmD8AtJZZvA
	8gSl8Ax2fkkKsoMyhpjTUo4nXtEF4Ji2K0gATvRhJak02icDW03Cm7txKW4qQ/HuZSGC3oYbRuk
	E5JwM3kuleB4ewHmW7tA8c52rIhLFFn6tYIAKOztuoQJsN2eVP9iVKfwYAzSVCPTFbyNjEK7sDM
	LfbfMYLVG8XGRA=
X-Received: by 2002:a05:6000:41f5:b0:487:13f1:47ec with SMTP id ffacd0b85a97d-4871e26e2e1mr7725773f8f.21.1789737497812;
        Fri, 18 Sep 2026 06:18:17 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b4e:8500:290c:210b:1c76:5710])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4871feb5de3sm4424549f8f.1.2026.09.18.06.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 06:18:16 -0700 (PDT)
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
	utilityemal77@gmail.com,
	viro@zeniv.linux.org.uk,
	tasos.papagiannnis@gmail.com
Subject: [PATCH bpf-next v9 0/5] bpf: Add user memory access kfuncs for mm_struct
Date: Fri, 18 Sep 2026 16:17:52 +0300
Message-ID: <20260918131757.42802-1-tasos.papagiannnis@gmail.com>
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

To make the trusted-or-null annotation safe, the exec paths are hardened
to clear bprm->mm before dropping the reference it owns.

On NOMMU systems, exec argument and environment strings remain in
bprm->page[] until they are transferred to the new process stack. They
cannot be accessed through bprm->mm at the bprm_check_security hook.
The new kfuncs remain available on NOMMU for address ranges represented
by a supplied struct mm_struct.

The series adds selftests covering both kfuncs while reading argument and
environment strings from linux_binprm during exec.

Changes in v9:
- Acquire a reference to mm_struct in bpf_copy_from_user_mm() and
  bpf_copy_from_user_mm_str() to protect against concurrent free 
  operations and prevent a potential Use-After-Free in future use-cases.
- Fix indentation in the remaining mm patches.

Changes in v8:
- Removed CONFIG_BPF_SYSCALL #ifdefs from mm/memory.c and mm/nommu.c.
- Reformatted the selftest to use 120-character lines.
- Removed the CONFIG_MMU check from the selftests.
- Removed the extern declarations from the selftests, as they already 
  exist in vmlinux.h.
- Moved the checks to user space in the selftests.

Changes in v7:
- Use execvpe() instead of a hardcoded /bin/true path in the
  copy_from_user_bprm selftest while retaining the controlled environment.
- Remove the unused bpf_misc.h include.
- Rewrap the invalid-flags kfunc call to stay within 80 columns.
- Fix indent in mm patches.

Changes in v6:
- Drop redundant extern keywords and CONFIG_BPF_SYSCALL guards from the
  remote memory copy declarations.
- Drop the explicit bpf_copy_from_user_mm() prototype and share copy 
  logic through inlineable static internal helpers instead of calling 
  between kfunc/helper entry points.
- Validate flags and zero-length requests before acquiring the task's
  mm, preserving existing behavior and ensuring internal helpers are 
  called only with a live mm.
- Drop the verifier relaxation for unchecked reads through trusted-or-null
  pointers and its tests.
- Fix the existing LSM selftest to explicitly NULL-check bprm->mm after
  marking the field trusted-or-null.

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

v8:
https://lore.kernel.org/bpf/20260918091058.297740-1-tasos.papagiannnis@gmail.com/

v7:
https://lore.kernel.org/bpf/20260915080255.48929-1-tasos.papagiannnis@gmail.com/

v6:
https://lore.kernel.org/all/20260908135302.74963-1-tasos.papagiannnis@gmail.com/

v5:
https://lore.kernel.org/bpf/20260907165220.52431-1-tasos.papagiannnis@gmail.com/

v4:
https://lore.kernel.org/bpf/20260904145340.40212-1-tasos.papagiannnis@gmail.com/

v3:
https://lore.kernel.org/bpf/20260831092305.42062-1-tasos.papagiannnis@gmail.com/

v2:
https://lore.kernel.org/bpf/20260820131801.68759-1-tasos.papagiannnis@gmail.com/

v1:
https://lore.kernel.org/bpf/20260812111140.7762-1-tasos.papagiannnis@gmail.com/

Anastasios Papagiannis (5):
  mm: Add copy_remote_mm_str()
  exec: Clear bprm->mm before dropping its reference
  bpf: Add user memory access kfuncs for mm_struct
  bpf: Mark linux_binprm->mm as trusted-or-null
  selftests/bpf: Test mm_struct user memory kfuncs with linux_binprm

 fs/exec.c                                     |   7 +-
 include/linux/mm.h                            |   8 +-
 kernel/bpf/helpers.c                          | 154 ++++++++++++++++--
 kernel/bpf/verifier.c                         |   5 +
 mm/internal.h                                 |   3 +
 mm/memory.c                                   |  43 +----
 mm/nommu.c                                    |  43 +----
 mm/util.c                                     |  60 +++++++
 .../bpf/prog_tests/copy_from_user_bprm.c      |  65 ++++++++
 .../selftests/bpf/progs/copy_from_user_bprm.c |  69 ++++++++
 tools/testing/selftests/bpf/progs/lsm.c       |   5 +-
 11 files changed, 361 insertions(+), 101 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/copy_from_user_bprm.c
 create mode 100644 tools/testing/selftests/bpf/progs/copy_from_user_bprm.c


base-commit: 961b8946acb482b6d7a39c266d623e5f9c4e873f
-- 
2.55.0

