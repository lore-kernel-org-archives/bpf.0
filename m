Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A54A46D56A
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 08:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.38.64.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789116185; cv=none; b=K7r6zwcYxIgoDMQo1flfno1eTNp82BjGVGImS6JQc+ntodY904vwzhCB+TmYGcanwCkrAvXr/hJxvsNi3eiUpZdINjF0rzFCbEIKcl+JbjIx+gsIuNdOVJdSmLl2rORtXX2VlR5UeMK4OrTWbhPQpb1SRmLT0GFtt2TiLgqmJ24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789116185; c=relaxed/simple;
	bh=R3m8m/MW4mibmESK8fuAgDMktB0nbHUFvrncXibtTxg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N3CThk8IMB/eUZR5YEjEUexNjUjKszLkvYnJapm+u+X0ZtQDoe9+fmv4lbPhH6OOBdU90D+LsMGO0NuUm1ZBJrZ73ky+LdOD2iLfx5vo78qhcwwO4/pXc6MApUnaQITT4Eeu8hSRIKbWDStTV42HGTMiFm1PhpkYFCDl792PM7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn; spf=pass smtp.mailfrom=mail.ustc.edu.cn; dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b=M8LSIEtA; arc=none smtp.client-ip=202.38.64.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="M8LSIEtA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:MIME-Version:Content-Transfer-Encoding; bh=OXKQJMj+i+
	ckhndUh89FnmIrahA0xVlxHKOg6bvKcbc=; b=M8LSIEtAFsp4zBcDmFCFfa/XiD
	f6k7f5au/3z/Eet8k2T8rlwqyT3UP6O/KzStBin/TzKf7zXKn0ek/g0lA+dtNHLR
	DKVNPQ72FsTgvfJEOfUfSNT50/imLTJiU6ksrBCDiF1xSZTsRIjp0HKNowBz+TDZ
	7fPLejZszzestuing=
Received: from localhost (unknown [222.195.81.105])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgAnHiUQv6Nqs+8GAQ--.3653S2;
	Fri, 11 Sep 2026 16:42:56 +0800 (CST)
From: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>
Subject: [PATCH bpf v3 0/2] bpf: Track iterator-owned BTF pointer lifetime
Date: Fri, 11 Sep 2026 16:42:52 +0800
Message-ID: <20260911084254.3481508-1-xyx2021@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:3pYKCgAnHiUQv6Nqs+8GAQ--.3653S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAFyrGw13Jr4xAr18Zw45GFg_yoWrXw4xpF
	Z3W3yUtr4kAa12kayfAa18Ca4fWFZ3Ar43Gr15t3y8AF45KryrZryUW3yYvFyqyr92qwn0
	qw4Yvas5GayDAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Sb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
	C2z280aVCY1x0267AKxVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x0
	82IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAw
	Av7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48J
	MxkF7I0En4kS14v26r1q6r43MxkIecxEwVAFwVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxV
	CFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r10
	6r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxV
	WUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG
	6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
	1UYxBIdaVFxhVjvjDU0xZFpf9x07bFEfrUUUUU=
X-CM-SenderInfo: h010jiysr6zt1loo32lwfovvfxof0/

bpf_iter_task_vma_next() returns a pointer to an iterator-owned VMA
snapshot. The next call resets that snapshot and drops the previous
snapshot's vm_file reference before filling it with another VMA. Destroying
the iterator frees the snapshot allocation. The verifier does not associate
the PTR_TO_BTF_ID result with either lifetime transition, so it permits old
direct and vm_file-derived pointers to remain usable.

Other non-RCU struct iterators also release or replace their previous
element when next advances. PTR_TO_MEM iterators already associate their
results with the iterator reference, but struct pointer returns take a
separate PTR_TO_BTF_ID path which omits this relationship.

Patch 1 associates non-RCU PTR_TO_BTF_ID next results with the iterator
reference. Before each next call creates a new result, it invalidates
older BTF pointers carrying that parent. Destroying the iterator uses the
existing reference-release path to invalidate the current result.
Pointer-valued BTF field loads preserve the parent only while the result
remains fully trusted and tied to its source; MEM_RCU, MEM_PERCPU, MEM_USER,
and untrusted fields retain their separate lifetime or access-domain rules.

A borrowed vm_file can also back a FILE dynptr, which does not take its own
file reference. Patch 1 carries the iterator lifetime anchor into that
dynptr and rejects next or destroy until the resource child is discarded.

Patch 2 adds task VMA verifier tests for destroy and for ACTIVE and DRAINED
next outcomes. It covers direct and vm_file-derived pointers, a FILE dynptr
across next and destroy, explicit dynptr discard, the current next result,
and independent MEM_RCU controls.

With the final 109-subtest payload, the baseline passes 102 expected
subtests while seven expected-failure programs load. V2 passes 104 while
five load. The final v3 passes all 109. The current-result, MEM_RCU, and
explicit-discard controls pass on every tested kernel.

The external triplet also behaves as expected on final v3: FRESH is
accepted and executes, STALE is rejected, and destroy-then-reacquire is
accepted and executes. Each probe invocation exits zero.

The issue is reachable by privileged BPF programs. This series is submitted
as a verifier correctness fix.

Please queue the verifier fix for stable after it reaches the BPF tree.

Tests:
  - W=1 make O=<build> kernel/bpf/verifier.o
  - make O=<build> -j12 bzImage modules
  - strict clang-20 build of iters_testmod.bpf.o
  - test_progs -t iters -v --watchdog-timeout 180 --workers=1
  - baseline/v2/v3 verifier differential
  - external live, stale, and destroy-then-reacquire load/test-run
    differential on final v3

The full unfiltered BPF selftest suite was not run.

Changes in v3:
  - Invalidate the previous non-RCU BTF result and its trusted descendants
    before modeling every next outcome, as raised in review of v2.
  - Carry a borrowed vm_file lifetime into FILE dynptr ancestry and reject
    iterator transitions until the dynptr is discarded.
  - Add separate ACTIVE and DRAINED next-call stale-pointer tests, with
    complete iterator cleanup on otherwise valid paths.
  - Add FILE dynptr next/destroy failures and an explicit-discard control.
  - Add current-result and across-next MEM_RCU controls.
  - Rebase from 15e2565f1c43 to e4a62833adff.

v2: https://lore.kernel.org/r/20260910044021.2279628-1-xyx2021@mail.ustc.edu.cn
v1: https://lore.kernel.org/r/20260909042907.1734153-1-xyx2021@mail.ustc.edu.cn

Xu Yunxiang (2):
  bpf: Invalidate iterator-owned BTF pointers on next and destroy
  selftests/bpf: Test iterator BTF pointer lifetimes

 include/linux/bpf_verifier.h                  |   6 +-
 kernel/bpf/verifier.c                         | 110 ++++--
 .../selftests/bpf/progs/iters_testmod.c       | 332 ++++++++++++++++++
 3 files changed, 424 insertions(+), 24 deletions(-)


base-commit: e4a62833adff6ef0fe7c0b90393204fe3c26b5c5
-- 
2.43.0

