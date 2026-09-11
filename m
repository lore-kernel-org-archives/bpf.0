Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01660468C30
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 08:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.38.64.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789116172; cv=none; b=JZuADeh0V/aCfGTIjvUOgdFtItcdAIwnoccJc0jI8sehG+FJVOct3GJBL8x7hLCQRM7X2f4jfb8BPcX7oAFkewTX/BmzCP28io0j//sn2g8TYBQPiDd0y8NLPlwrbRdW71Q6+Ey6IFkM1niNhufp8PAzUyKlPL3R0BEQZbCX9H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789116172; c=relaxed/simple;
	bh=plrYviPGXru+N8huD+c8maO6B6ZlIooTiIDa/0oOCZI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cBRqk7pFomjo3w5MAMMG1z9rB8D1E2W1EnJRMTA/f8l0y0CloMtgDV6tsKylySbYXkdc0+J5qyO9wmsflD/nwA+8niqS6jP+wzNDciNhsPW2iE3QTcPEevejuechDvhpL4wLGDSzF+YZUf4ybG36yqqxMZOe9cVTk/M9VIQpOz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn; spf=pass smtp.mailfrom=mail.ustc.edu.cn; dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b=afymfwm9; arc=none smtp.client-ip=202.38.64.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="afymfwm9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:MIME-Version:Content-Transfer-Encoding; bh=DsyJtTuZgf
	eW0vk+KupgyoSqSAKfSpQld/ugAX4gCAc=; b=afymfwm9EEjtb24VezcCPBY+cA
	m6kQfLHOIvsjY4mNXIFcfm/ns3nYysJluSae+VOPCx2kWTbBl65kF5pZEYHdHiVi
	zT0fu5nt+wWMNZN+O6lpLgqL/xJmE0I4TS7CC/2t1e3TooTFTekJeLIBc0Y8bTt6
	taj1tDzQG9p5fOUp8=
Received: from localhost (unknown [222.195.81.105])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgBnWSD9vqNqUe8GAQ--.3702S2;
	Fri, 11 Sep 2026 16:42:37 +0800 (CST)
From: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH bpf v3 0/2] bpf: Destroy callee-local dynptrs on subprog return
Date: Fri, 11 Sep 2026 16:42:07 +0800
Message-ID: <20260911084209.3481285-1-xyx2021@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:3pYKCgBnWSD9vqNqUe8GAQ--.3702S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXrWxZFWrZw1fJF4UGF4xCrg_yoWrJr4Upa
	y0ka9Iqr95JF42kF47Ja1jqa4rCan3Zay3G3sxt34Syw4Yyry8AFW2ga4YvF98Kr48Cw4F
	vw1UXa15Aw4UAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9ab7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
	C2z280aVCY1x0267AKxVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x0
	82IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGw
	Av7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48J
	MxkF7I0En4kS14v26r126r1DMxkIecxEwVAFwVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxV
	CFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r10
	6r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxV
	WUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG
	6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_Gr
	UvcSsGvfC2KfnxnUUI43ZEXa7IU5A-P5UUUUU==
X-CM-SenderInfo: h010jiysr6zt1loo32lwfovvfxof0/

A dynptr data slice is valid only while the specific dynptr that produced
it remains valid. prepare_func_exit() currently frees a callee stack without
running the normal dynptr teardown. A slice derived from a callee-local
dynptr can therefore escape into the caller and remain usable after its
source dynptr has disappeared.

Patch 1 destroys every callee-local dynptr before freeing the frame, using
the existing stack-slot teardown so exact descendants are invalidated and
the last release-capable referenced dynptr cannot be lost. Patch 2 covers
immediate and post-release ring buffer uses, an immediate skb use, and the
last-reference error path. Its success control creates a callee-local clone
while returning a slice from a caller-owned dynptr, checking that teardown
preserves the caller slice.

The exact v3 verifier source passes the complete targeted dynptr run:
2/136 PASSED, 0 SKIPPED, 0/0 FAILED. The qdisc test passes 1/1. The
baseline keeps all three stale forms verifier-valid. V2 rejects the
post-release ringbuf form but still permits immediate use of the escaped
ringbuf and qdisc slices. Both retain the caller-owned slice control.

An independent four-shape matrix covers stack-spill, direct-R0,
two-level-R0, and nested-clone transport. All four stale loads are accepted
and execute on the baseline; v3 rejects all four with EACCES (8/8 expected
matrix units). No warning or Oops appears.

The issue is reachable by privileged BPF programs. This series is
submitted as a verifier correctness fix.

Please queue the verifier fix for stable after it reaches the BPF tree.

Tests:
  - W=1 make O=<build> kernel/bpf/verifier.o
  - make O=<build> -j10 bzImage modules
  - strict clang-20 builds of both changed BPF objects
  - test_progs -t dynptr -v --workers=1
  - test_progs -t ns_bpf_qdisc/invalid_dynptr_returned_slice -v
  - baseline/v2/v3 focused verifier differential
  - baseline/v3 four-shape external execution matrix

The full unfiltered BPF selftest suite was not run.

Changes in v3:
  - Replace slice reparenting with normal destruction of every dynptr in the
    departing callee stack, as suggested by Amery.
  - Invalidate escaped clone slices on frame return and test immediate use
    before resource release.
  - Cover loss of the last release-capable dynptr and adjust the existing
    callback test for the earlier return-time diagnostic.
  - Add a control preserving a caller-owned slice while destroying a
    separate callee-local clone.
  - Rebase from 15e2565f1c43 to e4a62833adff.

v2: https://lore.kernel.org/r/20260910044006.2279547-1-xyx2021@mail.ustc.edu.cn

Changes in v2:
  - Reparent slices from any dynptr with a tracked parent, covering skb
    dynptrs constructed from referenced qdisc skbs.
  - Add a qdisc regression test for a returned slice used after skb
    release.
  - Fix the selftest comment style and mark the expected failing access.

v1: https://lore.kernel.org/r/20260909042858.1734125-1-xyx2021@mail.ustc.edu.cn

Xu Yunxiang (2):
  bpf: Destroy callee-local dynptrs on subprog return
  selftests/bpf: Test dynptr teardown on subprog return

 kernel/bpf/verifier.c                         | 28 ++++++
 .../selftests/bpf/prog_tests/bpf_qdisc.c      |  2 +
 ...disc_fail__invalid_dynptr_returned_slice.c | 76 +++++++++++++++
 .../testing/selftests/bpf/progs/dynptr_fail.c | 97 ++++++++++++++++++-
 4 files changed, 202 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_returned_slice.c


base-commit: e4a62833adff6ef0fe7c0b90393204fe3c26b5c5
-- 
2.43.0

