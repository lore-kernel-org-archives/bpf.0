Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793167268;
	b=v0DUhjj5M6s4OL8IKZNeORF2OCNG2biAc5vds5Tpaz79EHkdCs6Do/ncI+9x4X2LJSfC
	 UiaW9eQTbRC1VADVq2wd7gi6E+CnwrMrGv/zd1bkM0bow74OxPYhf6Rr44O6MxcE6Janl
	 pqhhVPp5M0+qFfA/b5W4nG4+DotpJiM0SLqyXhHLwbCNVE2bpzHL/3NrX42O0RjWhTZIU
	 GSC+bPRivulcQuivVSiiP25P82CPFJPCBoYo9D5ZQ7iRDG6EWKPJhf2vf1GKZ8NmjhL0b
	 C+Bfb8Fa6NLEvZmnjm6JymdKqOccHwao5HIfUF+nQDUXIjI9FsMfzAqN+gAaN/gHjtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793167268;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=zkmSvQgjRgfEVY/JcC5npmQaLTOybEfeuFjCjVVR/VM=;
	b=sZeQYraiVbZC30Dib5FJZA7n1i8Bqy+VYogLArwzOoDUyNpmSKEb+MPCkZG8LpHjlv+m
	 p2v2MJqHr2eyPG7UzcGwo4yuxc5ekZixccGzuHfldDU7eb7usMz54ZcFjEnGl1AI4KlWI
	 +7/VGT6VfVhzHx+OFbTW+7Iglpoao3ehM/P2crHoJJTpQTGgq0KqldRxLR3ePe4tmPbrZ
	 6Y54fB7Zed+9wpwxYpkNYAIEohmBYhV34fGtVBMphw+4aV7VHt6eQHD4D7gABPu59qs/r
	 JZRUvBhrjZLmCbWHlfBsSxfhK9Dz8dPhv5KLHmb+g8dsCygGV76cPkKzhi93/cYPcGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=LZBD9eVh;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394B2606A31A;
	Wed, 28 Oct 2026 06:01:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 394B2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=LZBD9eVh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:From:Reply-To; bh=zkmSvQgjRgfEVY/JcC5npmQaLTOybEfeuFjCjVVR/VM=; b=
	LZBD9eVh3RmQ+5OxYlgMEjDgxOOtbTfuqZvFCDsVF58NoXpJjpOBc/yC94b7zu2G8wLNQLAcoRIaA
	YAkG/AU+F735JOwyrd+hSPK/9EIcCqGBruwp3I6T0IuR+uodK+iXGfk5iwCjiJ6VK9LHB7nsSv5Km
	g8/zNJ0URhufRyRrLiaj6MI4MT9ZQ/sUJEyc3/cBWkd/w/0J1J8mjjYBxu+CFNEHG0pvT995gH5pM
	IMkiIz5q6dsLvunYQ+fpLlqYRvc+d3QhjSKti8ziy3KwPT9jFqKXVNL77vYcVz0klXj6VYDnqyCVW
	03OQwE6Ukw2flgbiXCEvpnQyZ7ehtWDKDQ==;
Received: from [58.29.145.179] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xLwiT-00CYlo-3x; Wed, 28 Oct 2026 07:00:54 +0100
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
Subject: [PATCH bpf-next 0/3] selftests/bpf: libarena: Add ordered-walk and lockless-peek support to the rbtree
Date: Wed, 28 Oct 2026 15:00:43 +0900
Message-ID: <20261028060046.549097-1-changwoo@igalia.com>
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
- Cache the leftmost node and the node count, so that other CPUs can
  peek at the head and the length without the writer's lock, like
  scx_bpf_dsq_peek() and scx_bpf_dsq_nr_queued(). Add rb_init() and
  rb_fini() for a tree embedded in another object (2/3).
- Add rb_next(), so that a consumer can walk past tasks it cannot run
  in key order (3/3).

Each patch adds selftests, which run with:

  $> ./test_progs -t 'libarena/test_rbtree*'

Changwoo Min (3):
  selftests/bpf: libarena: Order equal rbtree keys FIFO
  selftests/bpf: libarena: Cache the rbtree's leftmost node and count
  selftests/bpf: libarena: Add rb_next()

 .../bpf/libarena/include/libarena/rbtree.h    |  82 ++++-
 .../bpf/libarena/selftests/test_rbtree.bpf.c  | 300 ++++++++++++++++++
 .../selftests/bpf/libarena/src/rbtree.bpf.c   | 138 ++++++--
 3 files changed, 493 insertions(+), 27 deletions(-)


base-commit: 4169c9c90532df9585c0a2ae513337a58f5e59ab
-- 
2.56.0

