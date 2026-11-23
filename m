Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795473153;
	b=NYdmE2tH7JEaoPYqV73Mx88FKgRNHlfm/abBACmObT4BJ5/blo/U3U668w3Y/b4Rq9Az
	 brgGfghU6Ytx15skn/Je97SxPtr4oPtR2R0NzyKQCbX1SXVHr3wPLPWbwEDknE/fv+/hT
	 nE/MJ9yQpc5SCeYpBeo6mVsmXFZ3WrvObCxEsX321FyTq2wPQmDDq0mbVPyXKAU44yQ6j
	 ufX6zaMbFxze12XUK4JxHf5n0xXo691Qz/Yye64/JGKUsQQxrlJM/AfROuGrMTt5+YFmd
	 Mr1tayuYrWODniARlTpdUjF3tt0fRAOUxFDgC2c//ArboJtjM5SI6OOrdRgJ0qQRXiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795473153;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=I2W0m+MltnP+SoW4UuIGkJpaSHmayoHWCMwcjQiojYw=;
	b=4z13VfsLb1zqUYjFgb8ftP6zVh+x4pUijfgNqdgwwNW8xw0dRSBjp2SR3/g6fC6mYxTV
	 wwFNKcMjS81oSOsurms9ATCXv4KJu4qsN2MKlSI6WhCzr+tF3DuGTLMfC+pJWCxKWi7j0
	 ggNhOthvHrRqyzNRKEVP81PV8M6rxinZ4+2mdxBlalA4kXJHVlXYsEIICpFWCeuJrvfgc
	 qG9PS8wGbzStQlhte5yHLcTJe8CgW3dyx3PcYnFIs4jjpiGIYBl5v6wTPqc1QtRgpOAqF
	 3WSEvq8BsdrUBLBde97S+IzviLJfge94OXmqIMuNWMcCAUZCSAZkd8C3mrfKmUa9xBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VimJJ0t2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0CF606A31E
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 22:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VimJJ0t2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BD9F1F000EC;
	Mon, 23 Nov 2026 22:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795473153;
	bh=I2W0m+MltnP+SoW4UuIGkJpaSHmayoHWCMwcjQiojYw=;
	h=From:To:Cc:Subject:Date;
	b=VimJJ0t2oFLm4LNsZhF8Ph9ktpT2/y5y7viynGJR7InD/WiuSeYQtQwiyYUE/8cM6
	 sDmvI258vlx6efDBYwUKXnVE9caD1L+ff0aWvZ66+9m3vNpd162AdyJRPN6HnMn4Lg
	 wZ4kblwu4/JqFf2HfNreaV/dCNA24kS1Y/DujphFb1h0HPwE/RndwLvn9MeOp1Xfl9
	 gR7hO7a5ZjMLv/wcIq7cSmfCvMjyTEkL+/q3Nxg1FCdgER/P7bE1IRxLank/4xgDu3
	 vW7IYFcS1GcuXl338iV3ovNjxfjU9T1tvrK8ceBcD24AcHEXpMPmUkI7wIBvot91qP
	 WQ1P4/OXwEqBA==
From: Alan Maguire <almagui@kernel.org>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	Alan Maguire <almagui@kernel.org>
Subject: [PATCH bpf-next 0/7] libbpf, bpf: Utilize CO-RE for BPF program parameter presence, ordering
Date: Mon, 23 Nov 2026 22:32:20 +0000
Message-ID: <20261123223227.745345-1-almagui@kernel.org>
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
Content-Transfer-Encoding: 8bit

Currently the BPF_PROG() family of macros greatly facilitates
BPF tracing/LSM program writing by allowing specification
of function, tracepoint or LSM hook arguments directly by
name and type.  These are then mapped to a context struct
consisting of a u64 array, with one value for each argument,
with by-value structs > 8 bytes taking two slots.

By instead creating a structure with named members, we can
bring a Compile Once, Run Everywhere experience to parameter
specifications via a new BPF_PROG_CORE() macro.  This will
better handle cases like the following:

Problem: A tracing program only needs to use one parameter
from a multi-parameter kernel function signature, but verification
can fail if the function signature changes due to added or removed
parameters which are irrelevant to the case in hand.

Solution: Only specify the needed parameter in BPF_PROG_CORE()

Example:

	/*
	 * Prototype for filename_unlinkat is:
	 * int filename_unlinkat(int dfd, struct filename * name);
	 */
	SEC("fentry/filename_unlinkat")
	int BPF_PROG_CORE(handle, struct filename *, name)
	{
		if (bpf_func_arg_exists(name))
			...


Problem: Ordering of parameters changes for a BPF LSM program

Solution: Again use BPF_PROG_CORE() which is resilient to
ordering changes as these become CO-RE relocations in the
context structure.  Return values should be tagged with
__bpf_func_ret .

Problem: A parameter type changes

Solution: Use ___<new> named variants with old and new
types:

	int BPF_PROG_CORE(handle, struct vm_area_struct *vma,
			  struct mm_area *vma___new)
	{
		if (bpf_func_arg_exists(vma___new))
			...
		else if (bpf_func_arg_exists(vma)

Because the solution is purely in libbpf, the support needs
no kernel changes, aside from the light skeleton case,
where CO-RE relocation is done in-kernel (support for the
latter is added in patch 2).  Patch 5 provides a test
that programs can use to see if support is present.

Support covers fentry, fexit, fmod_ret, fsession, tp_btf,
lsm_cgroup and BPF LSM programs.

In short, we are making use of BPF CO-RE to extend a CO-RE
experience to program parameter ordering, presence and
handling of parameter type changes.

Limitations: tp_btf programs require >= 5.10 kernel since
it is the first kernel that makes tp_btf parameter names
available, while on big-endian (s390x) platforms, signed values
smaller than 8 bytes cannot be read.

This support requires BTF declaration tag support in clang/gcc
to work; because gcc does not support declaration tags on types
we add a marker within the struct itself.

Patch 1 adds libbpf support.
Patch 2 adds kernel-based lskel support.
Patch 3 tests tracing program support.
Patch 4 tests BPF LSM support.
Patch 5 provides a test BPF program writers can use -
bpf_func_args_supported() - to probe for support.
Patch 6 tests that probe.
Patch 7 documents the support.

Alan Maguire (7):
  libbpf: Support CO-RE relocation of tracing program arguments
  bpf: Support CO-RE relocation of tracing program arguments
  selftests/bpf: Test CO-RE relocation of tracing program arguments
  selftests/bpf: Test CO-RE relocation of BPF LSM program arguments
  libbpf: Report function argument relocation support via type existence
  selftests/bpf: Test detection of function argument relocation support
  Documentation/bpf: Describe CO-RE relocation of function arguments

 Documentation/bpf/libbpf/libbpf_overview.rst  | 190 ++++++++
 Documentation/bpf/llvm_reloc.rst              |  95 ++++
 include/linux/bpf.h                           |   2 +
 kernel/bpf/btf.c                              |  38 ++
 kernel/bpf/check_btf.c                        |   1 +
 tools/lib/bpf/bpf_tracing.h                   | 195 ++++++++
 tools/lib/bpf/libbpf.c                        | 142 +++++-
 tools/lib/bpf/relo_core.c                     | 458 +++++++++++++++++-
 tools/lib/bpf/relo_core.h                     |  29 ++
 tools/testing/selftests/bpf/Makefile.skel     |   3 +-
 .../selftests/bpf/prog_tests/func_args_core.c | 325 +++++++++++++
 .../selftests/bpf/progs/func_args_core.c      | 241 +++++++++
 .../selftests/bpf/progs/func_args_core_lsm.c  | 156 ++++++
 .../bpf/progs/func_args_core_lsm_cgroup.c     |  40 ++
 14 files changed, 1905 insertions(+), 10 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/func_args_core.c
 create mode 100644 tools/testing/selftests/bpf/progs/func_args_core.c
 create mode 100644 tools/testing/selftests/bpf/progs/func_args_core_lsm.c
 create mode 100644 tools/testing/selftests/bpf/progs/func_args_core_lsm_cgroup.c

-- 
2.56.0

