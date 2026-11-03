Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793692761;
	b=AIAw1maCwpQUQCDC8MGTu/AB4bpd1YRd1Opv7JMPOBJrGCq6/tE5JJhT9J1niXSTqLlb
	 jgvOs2mik/u3sbeE+uAHQVjWwED16KP/THBy2PZIOrH1FIUzdzENERecHwszCjiLxn/tT
	 cC5OcuVH0mRdh0XOkafAUMT0YD6AFpBUyhZqUbJ+e0BMdtOVCrQLQa7D/6/A3lqMp7Dv2
	 uw7ZyVYqupDhBnLf8eI/vf9l9Dc9unbqxyVAVpVmgHLjNBReTIJcZ6nhTkf81m0787AOl
	 dKx+wCxT9RKegxNLD8KzTS+U848Yhhpnsqdrp1Ixjs3ZkF0vjkfcgpOIPFvxy3Aq5xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793692761;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=HHd7MlRl5WO91ptnS5JcS/T/erAUMFbgJZKZpyddZqA=;
	b=wj84cx2TNxPmBuFrUT9dH5741liPmWBzApRafIcqwcTyqXPTNn3c/a2EL9vucG2bqXA1
	 P7V+yctDjxJIB9PpbHPOywgnYMwIaZ2V/K9usLrhjad2AAAWZhpJIfBnXvBcuhmCaQKRy
	 JXlLlaIrlHSc6YLRSZ6UcleuE+v5RU0Jhlqvbn9vogDT3dG7JmxB0JN8Zau+TkWb+eFM3
	 mBcJVdRxGF2bFZhMS+5glFZ1Ghzel/B35Q5oPO2KYVIla8lfUOHEkrIHT9CAJpvtMP02O
	 5dWD8tFDEOaW4SDpnapVNwzxmPmUmUBJFTGpNARgRdKbjj8vEnTRm4ZioQeLqpyRLgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bIrJ53fI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E158606A32D
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 07:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bIrJ53fI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F4ED1F00A15;
	Tue,  3 Nov 2026 07:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793692761;
	bh=HHd7MlRl5WO91ptnS5JcS/T/erAUMFbgJZKZpyddZqA=;
	h=From:To:Cc:Subject:Date;
	b=bIrJ53fILafaxb8rQHVqV7qorWHK5MHmDxuYeMzUQADfF6nMawp9Fc03hAk/0+3qO
	 fw1g/Yn11camVugHMC0VIBW59vXDWAU+/zey6abhOQEgaKBsLmOzZFcJLtVh4ll1H0
	 68C9YisbM2rdeUj6Cx6h8hhuAouqA84yoQfo0cCMvqQEEmCXcsV97lWPMXs3aASxZ8
	 3tHBqLD+t9fH0384hUYi3ZGZwGIt5dIdG6axPQtm5ZIlkYu4i8+5uRUcTqpeguyt5D
	 wAiFB8AS6BVqCi6KnWZ7yG5cmk9KMcMs/X0VlpA+HeaTsua0aa+6yrQFNxLv4rchQk
	 d+zB5YlikaP+w==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Federico Di Pierro <nierro92@gmail.com>
Subject: [PATCHv2 bpf-next 0/8] bpf: Add user memory kfuncs
Date: Tue,  3 Nov 2026 08:59:07 +0100
Message-ID: <20261103075916.100050-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

hi,
we have few use cases where having the ability to allocate normal or
executable user space memory would help (like to replace function in
live process or change environment variables).

We also need writes to user memory to handle page faults, while the
existing bpf_probe_write_user() helper disables faults during the copy.

This series adds sleepable kfuncs for BPF programs to copy data into the
current task’s address space and to create or remove private anonymous
mappings with optional execute permissions.

rfc: https://lore.kernel.org/bpf/20261021195759.119421-1-jolsa@kernel.org/
v1:  https://lore.kernel.org/bpf/20261029212551.56964-1-jolsa@kernel.org/


v2 changes:
- infer read-only from constness of a pointer instead of srcptr
  argument suffix [Andrii]
- rename bpf_user_mmap to bpf_user_anon_mmap [Andrii]
- use arch_validate_prot to validate prot argument in mmap
- add the x86 compat mmap workaround
- assorted small changes

v1 changes:
- follow vm_mmap/vm_munmap design suggested by Alexei
- allow user space write only to current process, because we don't
  have remote task use case and it simplifies security checks
- many changes in tests

thanks,
jirka

---
Jiri Olsa (8):
      bpf: Honor const on generic kfunc memory arguments
      bpf: Add user memory kfuncs
      selftests/bpf: Add get_procmap_info helper
      selftests/bpf: Test const kfunc memory arguments
      selftests/bpf: Test user memory mmap kfuncs
      selftests/bpf: Test user memory page exec
      selftests/bpf: Test bpf_copy_to_user kfunc
      selftests/bpf: Test user memory kfunc errors

 Documentation/bpf/kfuncs.rst                               |  17 +++++
 kernel/bpf/helpers.c                                       | 132 +++++++++++++++++++++++++++++++++
 kernel/bpf/syscall.c                                       |  10 +--
 kernel/bpf/verifier.c                                      |  38 +++++++++-
 tools/testing/selftests/bpf/prog_tests/kfunc_call.c        |   2 +
 tools/testing/selftests/bpf/prog_tests/user_mem.c          | 350 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/kfunc_call_fail.c        |  10 +++
 tools/testing/selftests/bpf/progs/kfunc_call_test.c        |  14 ++++
 tools/testing/selftests/bpf/progs/user_mem.c               | 111 ++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/test_kmods/bpf_testmod.c       |  10 +++
 tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h |   2 +
 tools/testing/selftests/bpf/trace_helpers.c                |  38 ++++++++--
 tools/testing/selftests/bpf/trace_helpers.h                |   1 +
 13 files changed, 722 insertions(+), 13 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/user_mem.c
 create mode 100644 tools/testing/selftests/bpf/progs/user_mem.c
