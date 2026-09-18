Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F5D2C11F3
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 09:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789722678; cv=none; b=e+xUAQmUw7eWxI887SiVbfTWTNvSKzZVfS2DxgjQStARGC60muG8y48l/r6lzJVMGSKC1e11+NL6iRCTRLUWTl7l/HZF5teGus3DKn1KJJI0MBqBddN1aPBMuLOhv4xPTbBYOjAB2JRVqODp86RAUA8mHuqap+Qo6GzcXxilZH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789722678; c=relaxed/simple;
	bh=N8gcGlhbhPcsyAylvjuJEfdtlvvs1cgODZctSBueXDg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W5VHCkP2QjcSx/xlPn2r86QuqJn8CCamCNVyiJDwGb5Gf8noHOzInh9HdWD9wGQo7k8JxKurKjzdGk1fDMUoWyybD57k2VvcFNP9yacnxh2htsZ+cjW2+i+8axcZJAz7+j88uPKya0ob6xV7QqZzjJ0rVwm80jn3Q7wGjIuA+tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qm/SB2h4; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qm/SB2h4"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cc9f581c4so2031735e9.0
        for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 02:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789722675; x=1790327475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SHLSHkTPbt9kkxq29Sn3Lw/rKmJD8RTBCnKLHusuNiA=;
        b=qm/SB2h49H169CQH3xuQMEhJUiTo/iUHgkCwzwnUEtEuYQGwXibhFzcummvwESxoLK
         0MmfmXnSgXCkb2uLVqZOu/8+YDDDeEPLgSYVPShPLdA6Xm3Z7vcry6Dl9LwyeAlvrAT0
         Md6GZmKTzhLhIhsBIemtpurqcw/+Cv58dTrtLfurxbMyyjzlff24omx9eBDSx2AugzUn
         zwyvRXSyqAGJo2b5rZtPkGQ7T+RbZZFdtkX1Qr2wGRU61NvIcbWmpzW0FZ+qYjqkgRMR
         IZMlIVGdCwPHQa8yfRUQFyuFcanrLcT2R6ZYpSmW1cDEBgDJFtDLNea2ecExWsCCbwt1
         hDSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789722675; x=1790327475;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SHLSHkTPbt9kkxq29Sn3Lw/rKmJD8RTBCnKLHusuNiA=;
        b=q+q+cE3fceh43A0wLTMMUYzMstQ2YELGZnFRpxkNuZx4xrgmLrtkQuot9iip7CHSKe
         tTgSg7u+cXIOk25iWpseGwG5RCjaX+3oYiOYy4LuKoELtmKe9sgYJEVuMqpxGCImcLWs
         lP3Ow+EO5gusGhnPEmmU79TXqqgcGKdXDfRe6RiXtxO7xrktZhE5kzUx8sQH82gsjInh
         3t2iaRSKIIyc6oLrr8OWDyty0owAekrKATuGIKQiZq4qnbjngxyAQY0qJ7DO1x4dQ79R
         RKZCvC4G0ATlZu75sBjEtv94JLQ7ZwVtADnCrD14uiRCPp7PzXCBE7mYqIQMyvSwgVvM
         n8TA==
X-Gm-Message-State: AFuF++mbd+N6tKjYzFGkg7gTxKvSk56N2/sXsmRou5DdbD048siG4quS
	w1znP6D1Q10LcypZCqDsDr//1RWP92620HW9SWtkYghcCP5N0lWGDdMAIXXijTYB
X-Gm-Gg: AYBFou11SFubKUHl0a0eBdtfIeKT6E9dTDCha4BuTqa6RmLn31qJXCsF1qB6s4pLTS+
	u0Lk4a+nseJzMYC+wvQMSdHuX6ZG+URs4h/NhHOEilMSx24I2irR2Iwm+bKcohXRr3Cu4i+ojJC
	6rjb/i39B1OxplcShcXKAPvDSlnFFV8mMamB2f6HceiqpU8kDrO3csfkLJ5RRiqxjjdp/cZhgpT
	FLURUHPXllDZKsds2f4UkdaMzw4Za9Mn4ftrcSX67KuNIUvg14OL9VugReUstOSbUhBXUf2Ew8L
	55z0RMU2hmyEFSW67h1NHMHzmfYnrBTJa6p7lqCKKMy0QtQDsDWcjlYC8SaDv97/ExjGL+lW4rd
	/GzeIBJsx+S+SXOvjyqqwlpAMxglGSEx1AEtCdmqFLxrs/LaKyX6vidEBbZ/ueW7lfYpzYT3jbH
	iKfbzSeONXSn+62AprvkgryUq2xDXIJgnESy3LIpFS+g861AjX6DIDmjg1KtU8vhDB9dcR7r43O
	DqLNMwkTCj4Fi21PaCblPJoHQ==
X-Received: by 2002:a05:600c:1d06:b0:49e:8222:3451 with SMTP id 5b1f17b1804b1-49fc5001358mr26352405e9.14.1789722674633;
        Fri, 18 Sep 2026 02:11:14 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b4e:8500:290c:210b:1c76:5710])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd1d0978sm138774275e9.2.2026.09.18.02.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 02:11:13 -0700 (PDT)
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
Subject: [PATCH bpf-next v8 0/5] bpf: Add user memory access kfuncs for mm_struct
Date: Fri, 18 Sep 2026 12:10:53 +0300
Message-ID: <20260918091058.297740-1-tasos.papagiannnis@gmail.com>
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
 kernel/bpf/helpers.c                          | 130 ++++++++++++++++--
 kernel/bpf/verifier.c                         |   5 +
 mm/internal.h                                 |   3 +
 mm/memory.c                                   |  43 +-----
 mm/nommu.c                                    |  43 +-----
 mm/util.c                                     |  62 +++++++++
 .../bpf/prog_tests/copy_from_user_bprm.c      |  65 +++++++++
 .../selftests/bpf/progs/copy_from_user_bprm.c |  69 ++++++++++
 tools/testing/selftests/bpf/progs/lsm.c       |   5 +-
 11 files changed, 339 insertions(+), 101 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/copy_from_user_bprm.c
 create mode 100644 tools/testing/selftests/bpf/progs/copy_from_user_bprm.c


base-commit: 961b8946acb482b6d7a39c266d623e5f9c4e873f
-- 
2.55.0

