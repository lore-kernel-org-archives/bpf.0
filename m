Received: from cvsmtppost03.nmdf.navercorp.com (cvsmtppost03.nmdf.navercorp.com [114.111.35.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA341377EA7
	for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 07:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.111.35.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782114441; cv=none; b=FVgggdLQUChm50WAjRBiOqFEzAGBHnHNSO1uecE+rFb55vLJC2PWO34UMJfyuy9Xw/7QWSp7uaDryxTZ3ePL6ypCt+mVWi1hDwOUT3UDgqjNKLRsaO4tXfT/oL96tr//EYznuVnInoU/A+zomjUY+UtOHKWa2rFRJ0n0TU7WozY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782114441; c=relaxed/simple;
	bh=mgG06uHu7Fc1UJwBdL2lLO5NAXZLkPDI3rIiZdaG5T0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aKOsyx0MbA9tkJmcYkApWLhWt2huV0BXD3SJazq+q1E8zDB7XBkIkIEu9tbZ6cRgWKf1WQaAYEAgVmIeWldD6XfmMC95QksaZQdheHGSqCUBhqBBy0dhssy6e+jC4w/hOnhylyK8wMi6KQOtr2/RzS6oIIsECdKQ3i1szowHVZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=navercorp.com; spf=pass smtp.mailfrom=navercorp.com; dkim=pass (2048-bit key) header.d=navercorp.com header.i=@navercorp.com header.b=vATwh7Ya; arc=none smtp.client-ip=114.111.35.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=navercorp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=navercorp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=navercorp.com header.i=@navercorp.com header.b="vATwh7Ya"
Received: from kr0s-real-1 ([10.180.30.112])
  by cvsmtppost03.nmdf.navercorp.com with ESMTP id qevG0HEGQCed1b+sfhW7Aw
  for <bpf@vger.kernel.org>;
  Mon, 22 Jun 2026 07:16:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=navercorp.com;
	s=s20171120; t=1782112613;
	bh=mgG06uHu7Fc1UJwBdL2lLO5NAXZLkPDI3rIiZdaG5T0=;
	h=From:To:Subject:Date:Message-Id:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=vATwh7Yats5TlpwCT4JEGCOnCdOjxbtTOGzt0Ziw4S4f/dVkCmB+Wybrr+s440PD4
	 Lm3IkxsNjtV4PBnTcv77g1MmMWIboY38h4EqwDNr/PkSa+JWWOrWjxdb6FiB+C4gju
	 y9tuL1/0eTyAVsvj9ZkZHhao9e4u+mRaaFgCoLZjIyRw5LFkG2xeVNmy0n6qSulGiR
	 fP2rsn3GvuUf330yI1gYCRo6ZxRd9huVqjByDKKSQTxdvJufQzYBtBRj9fnbZ4jQBH
	 zQlwJj2Ady6iHtGNT2iA6SnsEK4Pdjq9+6lzfR1ouUhDXxsN38QJ6+lxuknPmbDrph
	 bm5FohyXWJrYA==
X-Session-ID: UKh50JfSSKWRPhFHm7TnJA
X-Works-Send-Opt: T9YwjAumKAumKAbZjAgmKqKXKoJYFHmwFBwYjHmm
X-Works-Smtp-Source: Pmb/KAU/FqJZ+HmZKxUm+6E=
Received: from localhost.localdomain ([10.25.121.184])
  by cvnsmtp02.nmdf.navercorp.com with ESMTP id UKh50JfSSKWRPhFHm7TnJA
  for <multiple recipients>
  (version=TLSv1.3 cipher=TLS_CHACHA20_POLY1305_SHA256);
  Mon, 22 Jun 2026 07:16:52 -0000
From: Gyutae Bae <gyutae.opensource@navercorp.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org
Cc: John Fastabend <john.fastabend@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Minsu Jeon <minsu.jeon@navercorp.com>,
	Siwan Kim <siwan.kim@navercorp.com>,
	Jonghyeon Kim <jong-hyeon.kim@navercorp.com>,
	Gyutae Bae <gyutae.bae@navercorp.com>
Subject: [RFC bpf-next 0/3] bpf: compare-and-delete (BPF_F_COMPARE) for hash maps
Date: Mon, 22 Jun 2026 16:16:46 +0900
Message-Id: <20260622071649.31541-1-gyutae.opensource@navercorp.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gyutae Bae <gyutae.bae@navercorp.com>

This series adds an atomic compare-and-delete primitive to BPF hash
maps, motivated by a TOCTOU race in Cilium's conntrack GC [1]: the
batched GC snapshots CT entries, decides which expired, then deletes
them by key in a later syscall; between snapshot and delete the
datapath can refresh the same entry, so a live entry is deleted. A
userspace re-check before delete can't close it (lookup and delete are
separate, individually bucket-locked calls).

BPF_F_COMPARE lets userspace delete a key only if a chosen value region
is unchanged, with the compare and the delete done atomically under the
hash bucket lock:

    attr.flags |= BPF_F_COMPARE;
    attr.compare = <expected>;
    attr.compare_offset = <off>;
    attr.compare_size = <len>;

mismatch -> -EBUSY, absent -> -ENOENT, unsupported map -> -EOPNOTSUPP.
The compare* fields without the flag are rejected (-EINVAL) so a dropped
flag can't silently become an unconditional delete; maps whose value
carries BTF-managed fields (spin_lock/timer/kptr/...) are rejected
(-EOPNOTSUPP) since those bytes are sanitised on lookup.

Atomicity boundary (please scrutinise): the compare is atomic vs every
bucket-lock holder, but NOT vs a BPF program writing the value in place
via the pointer from bpf_map_lookup_elem() (no bucket lock). It
collapses the race window from the whole GC batch to one bucket-locked
critical section; full closure wants the compared region treated as a
synchronization variable (e.g. a monotonic revision). The selftest
models this.

Scope of this RFC: per-element compare-and-delete on BPF_MAP_TYPE_HASH
only. Deferred (will follow once the approach is agreed): batch delete +
its attr fields, a libbpf wrapper, LRU-hash and other map types, a
compare-and-swap *update*.

Open questions:
  - flag name: BPF_F_COMPARE vs something else?
  - mismatch errno: -EBUSY vs -EAGAIN?
  - new ->map_delete_elem_cmp() op vs extending ->map_delete_elem?

[1] https://github.com/cilium/cilium/issues/46298

Gyutae Bae (3):
  bpf: add BPF_F_COMPARE flag and compare fields to map elem UAPI
  bpf: implement compare-and-delete (BPF_F_COMPARE) for
    BPF_MAP_TYPE_HASH
  selftests/bpf: test BPF_F_COMPARE compare-and-delete

 include/linux/bpf.h                           |   2 +
 include/uapi/linux/bpf.h                      |   6 +-
 kernel/bpf/hashtab.c                          |  39 +++++++
 kernel/bpf/syscall.c                          |  54 ++++++++-
 tools/include/uapi/linux/bpf.h                |   6 +-
 .../selftests/bpf/prog_tests/map_cmp_delete.c | 106 ++++++++++++++++++
 6 files changed, 208 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/map_cmp_delete.c


base-commit: a975094bf98ca97be9146f9d3b5681a6f9cf5ce3
-- 
2.39.5 (Apple Git-154)

