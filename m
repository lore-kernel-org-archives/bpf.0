Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7113545FFD0
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 16:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267345; cv=none; b=JbEM7GvMWyKHBmt3C7mgz3dNzWTFniwC/MbuzcZoOUFISo4CR1md1eh78o6d9DR9D1gzTj39ASx3XvIs6yWJxG5JC2l6NOya039dv4IuoSFZg2XcVdRZflA0r4natrt2tSm8oqzKp+E+r2jyUtmeRHRG37PoaCk1wMxZejwIEqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267345; c=relaxed/simple;
	bh=IwLqOSUWli4cbC9zBJ5E09g24pfVYbTLxznRReprs5o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PAvbTGyrhGdyvrTPgrRXAxf1aR+6z58B0iSyugSv/hej3pTKAcaiKm8nGBBhTRZBlrR3OAHF03oSrXUwX3uY7A62ibV3akbnX+ZsIBJQxNjDrcH5G1mYDbMyRKLNht+JQfkntSLM54LQ238QVSU6pzl9vjH+JN4ObRW+aDMrAZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KvwNubDj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KvwNubDj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C8821F00899;
	Thu, 24 Sep 2026 16:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790267344;
	bh=pEuevvvSPzYhuIPGgpqHW+ZTpUlE8pECrXhTx6tcXVo=;
	h=From:To:Cc:Subject:Date;
	b=KvwNubDj/GJlW+tmiCWzGOsNqZnSREbwz/gxwSwzhgfTUOey3MTbEtxg6CdN/Zaoz
	 kJoyj03nFbKHCslEBBx2Dw8hO+3QaIfe0JF5hNdYwFFHDZ4BpdTR4VpvYPyvpQPiYP
	 VXIZoyiSIew5cpS5d/eE4eh5tV7uGdCYl5NbOC32Ys6P1Rjn0LYJCVJYowkdw2pNcu
	 R2NSz6BVl7cf0qhK0XlnHS/7I884Y5QbYnrv44nHVFfr2M62DttkiVwU33rGkJ9xNU
	 bCwIT8jEGUgufnJ5Mau1S0XFj2VgLxBFYMNRS80RultUfR3iz+IbOQP71moN/h2IVM
	 YYdOKluRSHjFQ==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	"Alexei Starovoitov" <ast@kernel.org>,
	"Daniel Borkmann" <daniel@iogearbox.net>,
	"Andrii Nakryiko" <andrii@kernel.org>,
	"Martin KaFai Lau" <martin.lau@linux.dev>,
	"Eduard Zingerman" <eddyz87@gmail.com>,
	"Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
	"Song Liu" <song@kernel.org>,
	"Yonghong Song" <yonghong.song@linux.dev>
Subject: [PATCH bpf-next 0/2] bpf: Support bpf_rcu_head in hash and LRU hash maps
Date: Thu, 24 Sep 2026 09:28:55 -0700
Message-ID: <20260924162858.2435106-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_call_rcu() currently only takes a bpf_rcu_head in an array, because an
array element is never freed while the map is alive. Hash elements are
recycled, and an RCU callback cannot be cancelled, so a delete racing a
queued callback would hand the element back to the allocator underneath it.

This keeps the element alive until the callback has run. The map claims the
head before releasing an element; if a callback is queued or running, the
element is unlinked but not returned to the allocator, and the callback
returns it through a new map_release_elem(). Patch 1 also covers the two
places a hash recycles an element without freeing it: the per-CPU spare a
preallocated htab uses on update, and LRU eviction.

Patch 2 adds tests for the delete, replace, recycle and eviction paths.
Each was checked against a kernel with the corresponding hunk reverted.

Puranjay Mohan (2):
  bpf: Support bpf_rcu_head in hash and LRU hash maps
  selftests/bpf: Add bpf_call_rcu tests for hash and LRU hash maps

 include/linux/bpf.h                           |   5 +
 kernel/bpf/hashtab.c                          | 104 ++++++-
 kernel/bpf/helpers.c                          | 117 +++++++-
 kernel/bpf/syscall.c                          |  14 +-
 .../selftests/bpf/prog_tests/call_rcu.c       | 254 +++++++++++++++-
 tools/testing/selftests/bpf/progs/call_rcu.c  | 274 ++++++++++++++++++
 6 files changed, 740 insertions(+), 28 deletions(-)


base-commit: 4f3a5eae895b9995e93425a75235d8f1f3268caa
-- 
2.53.0-Meta

