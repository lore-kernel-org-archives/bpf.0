Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794391813;
	b=JdAiIH5/FyQ0qZSD4/xjmzYtq6XalXMf6SlS4f7ndMzjrWg50+nCJELUQblGKgrJItZZ
	 L/DbINwcxc9isskJQ8IqrmMQJE4DEZkUKoBFftDzmkDNANFxh37hn7xXDEQML0A4Ulm6y
	 KuDy/KXiG+0k4iUQ8hnmDkz67TNDX8M/boBYobALSZsxBdVI6Jj2k2xtt74Kfi3CPq8Wr
	 EPbRC6yrLL/hUOZO4ubO8pbwR3GrGCkl2AE+bAUJQiqSFYkkRppHPRx8bC1ZQXglw6wDN
	 7ulZ1wfh6Lxz1H4P/mHtRXN6xjmuz0sFFoKG7VzemDiFSf1g51WHcbHr5Kutwy6F89A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794391813;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=tWrlQ45Hdb1VA203cGYT8oObUZD7HOj6EQl9Pyvmobk=;
	b=Bte4jS/a/gj1W3z1gEmzEiA9m2W96ElTpK3vmXu9NkU/bVmwhc3FQD/I3vrgh0kEFPsx
	 tipPHIcejM/be2/z+D/Oi/wNb3Vjraq1qe77xdQp0Fkj8o05XjL7ICMcvW56v5aX2dUrX
	 e6/Dl7Enc5ULuymQ+W0frPHSJ2gzW+yoyfCFHxqXrkI1nux8V6EmXVQ7FjrM1bAekA6Go
	 7/BBZs0pEZ4+v7NnPESQJhB0XNYU/oiyS/OUxpBSktyw7ELd+uMmWCIIY+2YBXv5SeKE+
	 0GP8ym/kDVLjM/yZW80svZPCs2/Jqp/ndz8N2VY9hI+NWAqEz6ayDFZYPmUlI02Wf8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=g0cdnNIZ;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C21606A321;
	Wed, 11 Nov 2026 10:10:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70C21606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=g0cdnNIZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:From:Reply-To; bh=tWrlQ45Hdb1VA203cGYT8oObUZD7HOj6EQl9Pyvmobk=;
	t=1794391811; x=2109751811; b=g0cdnNIZApZipZSYHhOajzS19VuFinWxCkDPOd15W5BCQX0
	4O127dlpSa/uGcBIHQbM0wjZVkNnZbczh0l3COnujxX8n2ggSIHMcUZtbYaKjyciX41qlQefdSIPo
	8FbnFcSGLK0L5iqoRo3EQ2ncMen5I2bIngp1szOtnuhojYWnzxde9ynqzSIqrTRVm+Jo9sSDodXpA
	cwR7dQjeKPHzrrOVwzFKGiwY79SAg3hXsZ4Np8jDCk41pHKbOFILk5Q1L9lT4ftAHxgmRdQSw/1U6
	QDRMxiZdmschscQB3T07hnhZLkKv/8JjQDlIhGeLwm/hlOU20Asv4IEa9nX5h+uQ==;
Received: from [58.29.145.179] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xR5HB-008kYM-4f; Wed, 11 Nov 2026 11:09:58 +0100
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
Subject: [PATCH bpf-next v3 0/3] selftests/bpf: libarena: Add ordered-walk and lockless-peek support to the rbtree
Date: Wed, 11 Nov 2026 19:09:48 +0900
Message-ID: <20261111100951.230730-1-changwoo@igalia.com>
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

Changes in v3:
- Make the lockless readers static inline. A plain static function in
  a header fails -Wunused-function under -Werror in a file that does
  not call it (bot+bpf-ci, 3/3).

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

v2: https://lore.kernel.org/bpf/20261111073416.203153-1-changwoo@igalia.com/
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

