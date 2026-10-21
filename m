Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792612692;
	b=B/SNWgKblK0r0yD9HaDnPAI/kMYu1WPiBbwIOZ6HCuz3ixSeSCsKk8hFBeTxOQpH4yoH
	 oVrTWhgRl7auB4+UePeXUE3AgVRP92f1Q9fNSvvUUrJd7iYJoZAG0cAhVSSiVkq+4yhAL
	 AW17yi2TAdGxmiicjKTiDJDSWRDRo3SEGRlnNfQklftPk1I9vkVd/EbMJTJ2aWL/Gduo/
	 EwbcvTvShT2fxZWG39Bc05shM3xof98f59yA2AlapVfar2crGrE0ma9seqR0CoqBCcIEB
	 cNQjpboKruY755+ke7XEyqmVUk8QApL0l/pZ8Aop9QyuwJHYs0eeucnyYIMMowECNbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792612692;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=VHWY1315vqdREoDmUpz7R9wTUQOFY+NZIx/UnsphZXk=;
	b=eNh60NTV1D8ZuKxzT0II13BLa0ODJP59eUTO+8OdSS/03rIUeHLURXKCU+c5C3zoJPsw
	 hRuu9/XzGNnqcv0p+iUj8LXUtdc1twCM5zKvtGhH5bQxRhLo+1p1lI1921wgWCb3/cgmp
	 A/m49l6L2OTmKKNs+cde5nhTuQD2CP1NXErPiyyogPe0qWGpVNRBhvwGxWAKMQW28A4Yq
	 wmYSKIxyADmavrLH+usyGI+h8P+re6yCixgfDsyM731YyU9C0LhioDOIBBviuNX/mDYPc
	 tDkjw+hfmRtiOR+HWeJESIZiFeO+uCZTkRI7XhfE4fvL6XAdQhN6h+rbEZjwCR+bZZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UMKSzXcq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55FD606A31A;
	Wed, 21 Oct 2026 19:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UMKSzXcq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 651741F000C1;
	Wed, 21 Oct 2026 19:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792612691;
	bh=VHWY1315vqdREoDmUpz7R9wTUQOFY+NZIx/UnsphZXk=;
	h=From:To:Cc:Subject:Date;
	b=UMKSzXcqrpdX3KUaL+oVrhM8PIkOq+TZih80FXRLmP3EzNP4s/u1wd1gP+Tp7FxnI
	 GyDRqyoKhkh7th3vvB29KA9hJ9elb7oVD2yZjvhLlcqz/iYMOAw611BPPWcLAo4ZV4
	 ZQCskznV64SYCjk3gDpMgEbzMbe45U8ZFxITLCvKhXm9EIBUthhA6s/coxztugHFTt
	 qIIUmS/OFnCku9uKkd1RZ+XtBIO3UbBqJ8YCYV6K46bOrLSfXUH5PRLv22bGdjapfk
	 WZNhmStMryK7wQJO9lrMpwaNt6/7iKctbKJmNiZ/ZIp0wTnDJrdD7O6EBeAQ1dIN8I
	 WF1+EV9KmVAfQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Subject: [RFC bpf-next 0/9] bpf: Add support to allocate user page
Date: Wed, 21 Oct 2026 21:57:49 +0200
Message-ID: <20261021195759.119421-1-jolsa@kernel.org>
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

hi,
we have few use cases where having the ability to allocate normal
or executable user space memory would help (like to replace function
in live process or change environment variables)

They also need writes to user memory to handle page faults, while
the existing bpf_probe_write_user() helper disables faults during
the copy.

This patchset adds the following kfuncs for sleepable uprobe programs:

  - long bpf_user_page_alloc(unsigned long nr_pages)
    allocate lazy anonymous pages in the current process

  - int bpf_user_page_exec(unsigned long addr)
    make a page readable and executable, provided it was allocated by
    bpf_user_page_alloc()

  - int bpf_probe_write_user_faultable(void __user *unsafe_dst__ign,
                                     const void *src__srcptr, u32 src__sz)
    copy data to user memory while allowing page faults to resolve the
    destination mapping.


I'm not sure it's the best way how to do this, hence the RFC post.

thanks for comments,
jirka


---
Jiri Olsa (9):
      bpf: Add __srcptr kfunc argument suffix
      bpf: Add uprobe faultable user copy kfunc
      mm: Expose locked mprotect operation
      bpf: Add kfuncs to allocate and seal user pages
      selftests/bpf: Add __srcptr kfunc arguments test
      selftests/bpf: Add user page allocation test
      selftests/bpf: Add uprobe user page exec test
      selftests/bpf: Add faultable user page writes test
      selftests/bpf: Add user page failures test

 Documentation/bpf/kfuncs.rst                               |  23 ++++
 include/linux/mm.h                                         |   3 +
 kernel/bpf/helpers.c                                       | 178 +++++++++++++++++++++++++++
 kernel/bpf/verifier.c                                      |  18 ++-
 mm/mprotect.c                                              |  20 ++-
 tools/testing/selftests/bpf/prog_tests/kfunc_call.c        |   2 +
 tools/testing/selftests/bpf/prog_tests/user_page.c         | 346 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/kfunc_call_fail.c        |  10 ++
 tools/testing/selftests/bpf/progs/kfunc_call_test.c        |  12 ++
 tools/testing/selftests/bpf/progs/user_page.c              |  61 +++++++++
 tools/testing/selftests/bpf/test_kmods/bpf_testmod.c       |   5 +
 tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h |   1 +
 12 files changed, 672 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/user_page.c
 create mode 100644 tools/testing/selftests/bpf/progs/user_page.c
