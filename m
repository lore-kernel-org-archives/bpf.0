Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793309157;
	b=4rfA+8dPY3h4yfhffzuDwqoJVnKykJSHP0JzEmhQAE2oYrKYggWLIwu9q7RjFrAg7HAg
	 rsmc9dNK6O/Fmz+edYDzvLT2N1R9PzPn9JwvXFK50KEmQ2QcSwaS9UPODalKsiVGOLVqZ
	 VdzYo+SurXD/hcjpTjgsSKdyIrgNsw+szP26OUREx6lJaWAKAl1uVpdLwC5vqajPlK2Kb
	 HIhZuHqdBWVSt36EAB67NWafOV0cW0sPobackMTIW1iV209A05Ox2ChwpD3zN6kiNgNfh
	 m+XJ+qPMdZwLFZ7JxvdyRmxMFHh2jwan0HRy+n4wucLOP/IhP5aFSA7w9tFqdFeoJpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793309157;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=DP062HOdIxmMsfdf5fqGA4zyk89BHd1fOXQS/Uon77o=;
	b=xQ6ehDjdH4n1zgNN2R/nwe5wCD9DiSLEHV3+Ya1Vrv0Fg3GVaQzRBhaxMuqn74LaV4Lq
	 IgeHQCJmVKUFugpRknJoT1axAZd+GPGS8KbCGt7KcV5kYe+C5s/P9IN8YJWB8Yy5B0mDe
	 ahpdpVzwUueLHHxfylmdhYm3LwNsLB+OBydp2fMeHVzp24lwZtTf2ELl4BnD6TF9J4iKt
	 eN3PLRMgDjD0WaKZQxYdrhrr1YKIYtKcwhH+Nya9VG26u37UykwN4NEZsI2o4wutTwGom
	 zdjt/GD+RzYwioi8aDpfUqIsNvY3J8uE38ntnA8Eg4XuMt11Kji7Gj8j3r25lqpzoOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mraMajQh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75490606A326
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 21:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mraMajQh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 593831F01816;
	Thu, 29 Oct 2026 21:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793309157;
	bh=DP062HOdIxmMsfdf5fqGA4zyk89BHd1fOXQS/Uon77o=;
	h=From:To:Cc:Subject:Date;
	b=mraMajQh31xSueAwZmt+bWATDUmUf2XsfHW7HUlpUu9JeVkT70k/Es/1kwdlmPugg
	 mo+lV7jAf3b2gmO0cdiSArsRziXgjUkd487iQ/e1obVwXesfo2MMgOSmLDqYikxesw
	 pAarsg4m6WRwDB6ijnb8juvdZxrMpYzKIQnia6Bs1odnHD5AmYFwiT6iaw1zFdzQmA
	 D8q3Nmp/TJZFrb5IjPWKsf3ywzXt0KZ3yLs44g8qxXEZUcRIFI6wR2sf8imrnn0PaZ
	 GpBeK994E0Y40GAakFJ8A0IIEA9SsM6yMQqz0o1D8RI90olRbauR+fPKoh0Q14h37q
	 xnvg694Sp+WXw==
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
Subject: [PATCH bpf-next 0/8] bpf: Add user memory kfuncs
Date: Thu, 29 Oct 2026 22:25:43 +0100
Message-ID: <20261029212551.56964-1-jolsa@kernel.org>
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

v1 changes:
- follow vm_mmap/vm_munmap design suggested by Alexei
- allow user space write only to current process, because we don't
  have remote task use case and it simplifies security checks
- many changes in tests

thanks,
jirka


---
Jiri Olsa (8):
      bpf: Add __srcptr kfunc argument suffix
      bpf: Add user memory kfuncs
      selftests/bpf: Add get_procmap_info helper
      selftests/bpf: Test __srcptr kfunc arguments
      selftests/bpf: Test user memory mmap kfuncs
      selftests/bpf: Test user memory page exec
      selftests/bpf: Test bpf_copy_to_user kfunc
      selftests/bpf: Test user memory kfunc errors

 Documentation/bpf/kfuncs.rst                               |  41 +++++++
 kernel/bpf/helpers.c                                       | 102 ++++++++++++++++
 kernel/bpf/syscall.c                                       |  10 +-
 kernel/bpf/verifier.c                                      |  20 +++-
 tools/testing/selftests/bpf/prog_tests/kfunc_call.c        |   2 +
 tools/testing/selftests/bpf/prog_tests/user_mem.c          | 338 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/kfunc_call_fail.c        |  10 ++
 tools/testing/selftests/bpf/progs/kfunc_call_test.c        |  14 +++
 tools/testing/selftests/bpf/progs/user_mem.c               | 111 +++++++++++++++++
 tools/testing/selftests/bpf/test_kmods/bpf_testmod.c       |  10 ++
 tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h |   2 +
 tools/testing/selftests/bpf/trace_helpers.c                |  38 +++++-
 tools/testing/selftests/bpf/trace_helpers.h                |   1 +
 13 files changed, 686 insertions(+), 13 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/user_mem.c
 create mode 100644 tools/testing/selftests/bpf/progs/user_mem.c
