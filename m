Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794382479;
	b=N/Wp9DufJLMfSncl7DswJHjymujyEhUQ3YCyMQAF4SCAmpDxKVdDoDVQBEaH0zKlUGIr
	 9jwUtAfTVlHNC8P5dKdjo161RRmzS1B2N5vSfFWbdv0GvxwdpKQ4g6DwfwMbrsZ87mpoX
	 pCZpPeWNbXKsRQiavAYhN/stvcwujiP4iinw1U+D9yxpfDHrgk9YwjUQG9l5+qlsAkPwD
	 nRhGRVDOl4Y4dGLbzWM+JNG8XNd+dDCsOKrgl/tUmwx3nPkUU22yMk+nmSG+2OK+ZI2Rs
	 mLJgALIDBQoPcv6+6w78Br8F6uQxY0StrekZrVRmVl742TqW0drA6EujShdL2auIALw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794382479;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=1fq1mWqSsPumugesVbA9rrqce1A+c8HqOBMfP33zvE4=;
	b=JrdsZ8acD30qWXrfMNqdqMg4+YfMPaySSolbA1AKpGiL6tZ98VtjBSCnsAsJSz8FQgso
	 fE4qemoHtxu+l2ESeKepcyxGfD+OnhJXPT15UHVbP/SMMtl9Y6TEFAaP8Bj9Is9cD6otL
	 sY66ehS6gUFdNO1FrmIO7/NirfS6P7SuGCxZ5REq1mhe3Lo/h0t0gUy2neAL7+MEGOP1G
	 cy538Vw+BYRPqDq8C7kYz71Ef1qeL/pojlXycTBNMBhZDn5GOWIjt965VnBSwCaSf7bde
	 rNhfyOQ6O2am6jXUhBrfy9/QNJiFbARRJhbZNnZycRYQqkiMm7wIC3qBNDEhmulBTdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=JIQ5FCzJ;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB908606A324;
	Wed, 11 Nov 2026 07:34:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB908606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=JIQ5FCzJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:From:Reply-To; bh=1fq1mWqSsPumugesVbA9rrqce1A+c8HqOBMfP33zvE4=;
	t=1794382477; x=2109742477; b=JIQ5FCzJGYDElZVqSjHeYCg7Ze2CwLeOvrIGoy63nDZJBAT
	bKW5gExsl4LI1ZIP7UlP5PNcPJRD+zri8elQdKgrleQCi5bwGw42m0F7LtXw3DBnUw/XPtYYxyLYy
	D/+wTJ/d5acb5fUcwILefprUuguSGP23fq7A7AbinZulT5xSpqJiqcYs7If+wyuLCht2QnkPtIZ+X
	wuFdvBeXg9fAyGl/Byza8Li58UjOiOiNd5ZsB+/ZZG0e2q7Ed4jQ8ycstYs1NALJ6JKD0gmk9or2S
	AZtBV9rN3xSRSFBU4wqHLVXBTQbYoPXGUVRYVbwXHED8AN23mcILUMH+9c02vi0w==;
Received: from [58.29.145.179] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xR2qf-008aYU-4g; Wed, 11 Nov 2026 08:34:26 +0100
From: Changwoo Min <changwoo@igalia.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	david.dai@linux.dev,
	Gavin Guo <gavinguo@igalia.com>,
	bpf@vger.kernel.org,
	sched-ext@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	changwoo@igalia.com,
	kernel-dev@igalia.com
Subject: [PATCH bpf-next v2 0/3] selftests/bpf: libarena: Add ordered-walk and lockless-peek support to the rbtree
Date: Wed, 11 Nov 2026 16:34:13 +0900
Message-ID: <20261111073416.203153-1-changwoo@igalia.com>
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

A sched_ext scheduler can build a task queue on libarena's rbtree, keyed
by vtime, in place of a vtime-ordered DSQ. Such a queue needs three things
the tree lacks. This series adds them:

- Serve equal keys in insertion order, as vtime-ordered DSQs do (1/3).
- Add rb_next(), so that a consumer can walk past tasks it cannot run
  in key order (2/3).
- Cache the leftmost node and the node count, so that other CPUs can
  peek at the head and the length without the writer's lock, like
  scx_bpf_dsq_peek() and scx_bpf_dsq_nr_queued(). Add rb_init() and
  rb_fini() for a tree embedded in another object (3/3).

Each patch adds selftests, which run with:

  $> ./test_progs -t 'libarena/test_rbtree*'

Changes in v2:
- Drop the comment on the insert helper and keep the name
  rbnode_least_upper_bound() (Emil, 1/3).
- Move rb_next() before the caching patch and into rbtree.bpf.c with the
  other traversal functions (Alexei, Emil, 2/3).
- Hand the head to its successor at the top of rb_node_remove(), before
  an RB_ALLOC tree frees the node, so that a lockless reader never sees a
  freed head. This drops the wrapper, was_first and the rename to
  rbnode_remove() (Alexei, 3/3).
- Drop the cache line alignment of the lockless fields, which showed no
  measurable benefit (Alexei, 3/3).
- Rename the lockless readers to rb_first_lockless(),
  rb_first_key_lockless() and rb_nr_nodes_lockless(), and document that
  a caller that dereferences the head must keep the node valid itself
  (Emil, 3/3).
- Drop __always_inline from static functions (Emil, 3/3).
- Add Reviewed-by tags from Alexei and Emil.
- Rebase on bpf-next.

v1: https://lore.kernel.org/bpf/20261028060046.549097-1-changwoo@igalia.com/

Changwoo Min (3):
  selftests/bpf: libarena: Order equal rbtree keys FIFO
  selftests/bpf: libarena: Add rb_next()
  selftests/bpf: libarena: Cache the rbtree's leftmost node and count

 .../bpf/libarena/include/libarena/rbtree.h    |  57 +++-
 .../bpf/libarena/selftests/test_rbtree.bpf.c  | 303 ++++++++++++++++++
 .../selftests/bpf/libarena/src/rbtree.bpf.c   | 120 +++++--
 3 files changed, 457 insertions(+), 23 deletions(-)


base-commit: 0fb18ce8a2e9de830433923cf65838933d615359
-- 
2.56.0

