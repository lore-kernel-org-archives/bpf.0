Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793874229;
	b=g13C9XvkSLEdA6pkxfPTYgx3oFyhxaqW6mgXeT13ls743eo0gYx/XNNEXyPTVWZL3mZb
	 SI8KCUjVcixUE/ToqhvziuROaY8t6iT2o20cCICiYZaQ82oKd46+rfdmfLfSk5Q4RmE5A
	 cUD11ZsiWgQJJ78mpEdEB+GZlVqwAosYlmdTx5o8UuAUFUeOA7kLE8zi4keLBALumRaDQ
	 Pv/8kmlyWQr+R13Hw4Fp2XdIGWBiXTVdZGVO67c4yX4mVQCaCNvhHatxWs5/ab8sbkSA+
	 ZxqjaJkjxw1thoLZFzyIEJoW8s4xZNP08cEnne380E78CFdspGy/35RIzv/VMJU8zQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793874229;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=7vPiI7uyQG5/hNrt1SoYsN5v0SSwiCd4tGYudI5VrdI=;
	b=17bU2+ANZy+fQ5MfFBJIU+rkEauZt9u2ctJ/jDBuEDcTk6cYUNTl4du/pNiIidz869IB
	 8vpdwxcK/Lin+Tyjqq65kzGVgzfjlpfYNiFNu0UJuf8m2bnWEV2uuPavvoMvKS3N67xoC
	 K7AZyEmNCQ7yxCyVi35+GoUFhflC7E+5hXAR6gRX/OlhpSc/5THR535nkxCLUcLGdiZ16
	 K0wuyaNje/3mMaV03HQa21Z8tDQa8mLGb9ig/uCYVQOUSv2wcEDBo/mN453HHFb7VbDFZ
	 8MC3/ndIutyzn3iwRWzX7PsPByiBv5N5LEM42SpJlFPkmBznID5pXeYGICR9kQ88ecw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="VxHmbG/j";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6DE606A329
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 10:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VxHmbG/j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FC291F000C1;
	Thu,  5 Nov 2026 10:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793874228;
	bh=7vPiI7uyQG5/hNrt1SoYsN5v0SSwiCd4tGYudI5VrdI=;
	h=From:To:Cc:Subject:Date;
	b=VxHmbG/jrt+mvpz9g0I9AmxMQqudYtqta93/nPqhZozHrDcZ2TPGeb2/OH1uXp3Hz
	 L6M7yHDEqWYAcXsCWwzUXGcqWQSTq74jUthaoWgvzDQ0WiK58Sf5ie67jVIIG6HGC+
	 Cig10k/kPuAofy4kW2626hNI2iW9m2dTOaocyx1ElFts3sHaQ/Vz1ctk5l2WTJiqgk
	 c3zWsbFtGufTLVsIT//mzDY7Kz2OQZj6zXcSIqcsjwzJShjCp24otbpO7HlceZg39c
	 mcvaI+7JRub8f9LqKatCEg2Zb27TzJpC1EDe/xBsvDr7p4wu57n4/TiZjU/IsHLA+W
	 HaH5qgPU2q6YA==
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
Subject: [PATCHv3 bpf-next 0/8] bpf: Add user memory kfuncs
Date: Thu,  5 Nov 2026 11:23:34 +0100
Message-ID: <20261105102343.311331-1-jolsa@kernel.org>
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
BPF programs have no supported interface for creating or removing private
anonymous mappings in the current task. This limits use cases that need normal
or executable memory in a live process, such as replacing a function or
changing environment variables.

Although bpf_probe_write_user() can write to user memory, it disables page
faults during the copy and therefore cannot handle memory that needs to be
faulted in.

This series adds three sleepable kfuncs for those operations:

  - bpf_user_anon_mmap(len, prot) creates a private anonymous mapping in the
    current task and returns its address. The requested protections can include
    execute permission.

  - bpf_copy_to_user(dst, src, len, flags) copies data into the current task’s
    address space, handles page faults, and reports copy errors.

  - bpf_user_munmap(addr, len) removes a mapping.

Together, the kfuncs provide a small interface for allocating, populating,
and removing memory:

  addr = bpf_user_anon_mmap(len, prot);
  ret = bpf_copy_to_user((void *)addr, src, len, flags);
  bpf_user_munmap(addr, len);

This interface lets a BPF program perform the operations in the current task’s
address space without changing bpf_probe_write_user()’s fault behavior or
introducing a separate mapping abstraction.

thanks,
jirka


rfc: https://lore.kernel.org/bpf/20261021195759.119421-1-jolsa@kernel.org/
v1:  https://lore.kernel.org/bpf/20261029212551.56964-1-jolsa@kernel.org/
v2:  https://lore.kernel.org/bpf/20261103075916.100050-1-jolsa@kernel.org/

v3 changes:
- use Alexei's change for checking the const [Aleexi]
- drop ia32 support/hack for vm_mmap [Alexei]
- remove leftover srcptr suffix in kfunc declaration
- drop extra verifier test for non-sleepable kprobe

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

 Documentation/bpf/kfuncs.rst                               |  21 ++++
 kernel/bpf/helpers.c                                       | 107 ++++++++++++++++
 kernel/bpf/syscall.c                                       |  10 +-
 kernel/bpf/verifier.c                                      |  24 +++-
 tools/testing/selftests/bpf/prog_tests/kfunc_call.c        |   2 +
 tools/testing/selftests/bpf/prog_tests/user_mem.c          | 349 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/kfunc_call_fail.c        |  10 ++
 tools/testing/selftests/bpf/progs/kfunc_call_test.c        |  14 +++
 tools/testing/selftests/bpf/progs/user_mem.c               | 101 +++++++++++++++
 tools/testing/selftests/bpf/test_kmods/bpf_testmod.c       |  10 ++
 tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h |   2 +
 tools/testing/selftests/bpf/trace_helpers.c                |  38 +++++-
 tools/testing/selftests/bpf/trace_helpers.h                |   1 +
 13 files changed, 676 insertions(+), 13 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/user_mem.c
 create mode 100644 tools/testing/selftests/bpf/progs/user_mem.c
